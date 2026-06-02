Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CC0CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 00:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBF72848EE;
	Wed,  3 Jun 2026 02:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="vGJ4e9UD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA73883EF9; Tue,  2 Jun 2026 23:30:25 +0200 (CEST)
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8C3A84855
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 23:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1780435822; x=1780695022;
 bh=11STN0qY6VeB07DEiy2Oid1Uwdnev1AA2J3QraHl85k=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=vGJ4e9UDLywg8Ee8x1cnUddy9kN4BBCLxD4/gzdlcY0e9EdmSPheNdu4NZ9S82JcO
 9ihuOKabl90WOGKT92cXuJakHS92pmASKb3o9d1TveOgExpQBsrQrQnrL+B+roZan1
 N6p8lMe9QZ4kWsqc+u5Q96sBLUjgMbIYUb0govEdkQ+41LA+4SWBO0ZHPOXxH8NcFL
 dUy5kSWsllmXg+udscMz4mM0YDiL0Y6jP2HXthnmGe2JzkbBZR0sf2+aHfl/hbN/Be
 J7mv3MEIfC8fGISFcO9q6SG4ZPg7NanQ9IoWxIPvD7AH/NlDmGfcC17CpL5gVAQFv+
 gdNWqu3KV01iA==
X-Pm-Submission-Id: 4gVPBP3hPgz1DDLM
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v4 1/3] image-fit.c: introduce CONTROL_DTB_AS_FIT config knob
Date: Tue,  2 Jun 2026 23:30:11 +0200
Message-ID: <20260602213013.558064-2-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602213013.558064-1-rv@rasmusvillemoes.dk>
References: <20260602213013.558064-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jun 2026 02:23:44 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Having scripts embedded one way or the other in the U-Boot binary
means they are automatically verified/trusted by whatever mechanism
verifies U-Boot.

Writing those scripts in the built-in environment leads to
backslatitis and missing or wrong quoting and is generally not very
readable or maintainable.

Maintaining scripts in external files allows one
to have both syntax highlighting and to some extent apply shellcheck
on it (though U-Boot's shell is of course not quite POSIX sh, so some
'#shellcheck disable' directives are needed). Getting those into the
U-Boot binary is then a matter of having a suitable .dtsi file such as

/ {
	images {
		default = "boot";
		boot {
			description = "Bootscript";
			data = /incbin/("boot.sh");
			type = "script";
			compression = "none";
		};
		factory-reset {
			description = "Script for performing factory reset";
			data = /incbin/("factory-reset.sh");
			type = "script";
			compression = "none";
		};
	};
};

and making that part of CONFIG_DEVICE_TREE_INCLUDES, so that U-Boot's
control DTB effectively doubles as a FIT image containing a few
"script" entries. At run-time, one's default bootcommand can then
simply be

  source ${fdtcontroladdr}:boot

Except of course that the control DTB is in fact not quite a FIT
image. The lack of timestamp and description properties could
potentially be worked around (by just adding those via that same
.dtsi), but the no-@ check is not possible to get around. But since
the control dtb is by definition trusted, we can make an exception for
that particular address, if the new CONTROL_DTB_AS_FIT config option
is enabled.

One can of course build an ordinary FIT image with those
scripts. However, that requires extra steps in the boot command for
loading that script from storage, requires one to use "configurations"
for pointing at a single script to run, and signing the FIT image
using the same key used for verifying the kernel. Moreover, in certain
situations, such as bootstrapping/production, there is no place to
load that FIT image from, and it is much simpler to just have the
necessary scripts be part of the U-Boot image itself.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 boot/Kconfig     | 13 +++++++++++++
 boot/image-fit.c | 24 ++++++++++++++++++------
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index ae6f09a6ede..19a170957c6 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -103,6 +103,19 @@ config FIT_FULL_CHECK
 	  of bugs or omissions in the code. This includes a bad structure,
 	  multiple root nodes and the like.
 
+config CONTROL_DTB_AS_FIT
+	bool "Allow U-Boot's control DTB to act as FIT image"
+	help
+	  Enable this to exempt U-Boot's control DTB from the sanity
+	  checks done to ensure FIT images are valid. This can for
+	  example be used to embed whole scripts in the control DTB,
+	  that can then be invoked using 'source ${fdtcontroladdr}'.
+	  In a secure boot setup, this is safe, as the control DTB is
+	  necessarily covered by any mechanism verifying U-Boot and
+	  can therefore be trusted. This only affects the case where
+	  the image being checked is gd->fdt_blob. See
+	  doc/develop/devicetree/control.rst for details.
+
 config FIT_SIGNATURE
 	bool "Enable signature verification of FIT uImages"
 	depends on DM
diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..87427d07d7c 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1664,6 +1664,16 @@ static int fdt_check_no_at(const void *fit, int parent)
 	return 0;
 }
 
+static int fit_check_images_node(const void *fit)
+{
+	if (fdt_path_offset(fit, FIT_IMAGES_PATH) < 0) {
+		log_debug("Wrong FIT format: no images parent node\n");
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 int fit_check_format(const void *fit, ulong size)
 {
 	int ret;
@@ -1676,6 +1686,13 @@ int fit_check_format(const void *fit, ulong size)
 		return -ENOEXEC;
 	}
 
+	/*
+	 * For the control DTB to act as a FIT image, we only require
+	 * an /images node.
+	 */
+	if (CONFIG_IS_ENABLED(CONTROL_DTB_AS_FIT) && fit == gd_fdt_blob())
+		return fit_check_images_node(fit);
+
 	if (CONFIG_IS_ENABLED(FIT_FULL_CHECK)) {
 		/*
 		 * If we are not given the size, make do with calculating it.
@@ -1724,12 +1741,7 @@ int fit_check_format(const void *fit, ulong size)
 	}
 
 	/* mandatory subimages parent '/images' node */
-	if (fdt_path_offset(fit, FIT_IMAGES_PATH) < 0) {
-		log_debug("Wrong FIT format: no images parent node\n");
-		return -ENOENT;
-	}
-
-	return 0;
+	return fit_check_images_node(fit);
 }
 
 int fit_conf_find_compat(const void *fit, const void *fdt)
-- 
2.54.0

