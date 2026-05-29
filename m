Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAEECD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 20:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1713846E2;
	Fri, 29 May 2026 22:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WrWtjmxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD8C846A3; Fri, 29 May 2026 21:46:31 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9AF0805D7
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 21:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6870ad8072eso9645637a12.0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google; t=1780083989; x=1780688789; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhOphmAoE6yGJ0WqshHyvpyYQHZoSSMW8fgNwwstsik=;
 b=WrWtjmxVjC/pbJu2nPKgEKqXsLBvOzrFqgPqw2fMwFBjvoE4M2OU2iTZgu4tLQe310
 ZywXUE5FhBLHaZ6aP44ERHqlHf8odYTIUkqbknVWVSFCY1TJTeEOhXDasI9CT/stkccD
 BfpFgWX0hcXrYT2B0dhaFuqWpyTTcL9T6sc8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780083989; x=1780688789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QhOphmAoE6yGJ0WqshHyvpyYQHZoSSMW8fgNwwstsik=;
 b=tUcBo0w6TxnW+wgD7rpInsiUctTwCbr+21B7jXmgEIkERfraNi9DRo+dzXxL9uSP3a
 GXvGsU26C1oBAi74kIE2usvxB1c2RVuw9TT0AUsDlTOVKTM+QtYnT/AJdl6aAypK9q3c
 YXbeFR2ZsFdRfXbKjORSVrUHHlG+u8fNsl0uNNE0XDtiYCf1NX7CFmkF3aoLws3ofvMl
 a0mNg4ezGRrhpNI3Tl4EdbqLFzGxKNHUAGntv27ShuMay45fLG1s0g2hSjgz6hOlXZ5k
 VYERT2G0MoVW8Z9RO9a/s1eekNviQKdccSqPuNj9DElleUAtXTYRIjxO3bk74jafYVE1
 yX7Q==
X-Gm-Message-State: AOJu0Yy7huGiLIs2bjMxOpOMn2MATfC14AZUuoUUXGchGZnc5dBKxNW+
 u5A2shTWnLuTbA8A7M8sHDAeXBiTdI5bVNgVCakeQlN6cLb+Pb1Pdfb+KibpEEisappoyGsscOw
 3C1xzWPw=
X-Gm-Gg: Acq92OGKwiLitXUVQAX8B2knESHMiqKdO0nokCh1NP6SUHGKUaE0Qrj/AOk9HU5Zn5K
 hml+cfPeNA93eJyOiEt/T+pIziImbl1ti5BXZfuYzUvo7ATYi7BVTvZ4MpNLgEmfvrsYY3GtdUw
 uDO6a3a6iuHkbzxxZISR130bu/qm4jiyNoJoSqFdR30OpcaibjlBh5P//Xcwg778hD/ILMt/0MX
 YkEZshN8s7wtvXYACqdHgWCRY/C9JlwrdsAbNlH4s7/N4vCrzKCjDKVeL3aLDoArOXm+q9TfWCe
 72PbGpPDETpDCDaLRdeav5wg9yasrSuApQmj/cSYob7t4/BfVZgTNDLGHXOYybKPpDVd9ZVD50J
 Q2JqxWnAhFAVeylPb9V8cRCfdE7cjtx5A07+YXjPP5CqW+TMF7EKnd3TxKvVhNmAs0Z1EqccTVi
 Whgpow3+N2WbPsrxWb1R0wXJ9vOwHeyVgXRblKGUPA+OAu7hPxwwBwLywTCONe9CC0
X-Received: by 2002:a05:6402:5209:b0:670:d548:62a1 with SMTP id
 4fb4d7f45d1cf-68c929706bdmr449279a12.3.1780083988804; 
 Fri, 29 May 2026 12:46:28 -0700 (PDT)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68c1620d5bcsm859869a12.2.2026.05.29.12.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:46:26 -0700 (PDT)
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 1/3] image-fit.c: introduce CONTROL_DTB_AS_FIT config knob
Date: Fri, 29 May 2026 21:46:19 +0200
Message-ID: <20260529194621.1470583-2-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529194621.1470583-1-rv@rasmusvillemoes.dk>
References: <20260529194621.1470583-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 May 2026 22:17:03 +0200
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

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 boot/Kconfig     | 13 +++++++++++++
 boot/image-fit.c | 21 +++++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

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
index b0fcaf6e17f..18498d0b51a 100644
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
@@ -1676,6 +1686,10 @@ int fit_check_format(const void *fit, ulong size)
 		return -ENOEXEC;
 	}
 
+	/* For the control DTB to act as a FIT image, we only require an /images node. */
+	if (CONFIG_IS_ENABLED(CONTROL_DTB_AS_FIT) && fit == gd_fdt_blob())
+		return fit_check_images_node(fit);
+
 	if (CONFIG_IS_ENABLED(FIT_FULL_CHECK)) {
 		/*
 		 * If we are not given the size, make do with calculating it.
@@ -1724,12 +1738,7 @@ int fit_check_format(const void *fit, ulong size)
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

