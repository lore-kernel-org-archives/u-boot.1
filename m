Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6260CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 00:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A4A84908;
	Wed,  3 Jun 2026 02:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="h5az1Pxs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE6383EF9; Tue,  2 Jun 2026 23:30:30 +0200 (CEST)
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch
 [109.224.244.108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C209584837
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 23:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1780435825; x=1780695025;
 bh=gRcRacvET9u4v56wSl1NYOyNsq6dQo3uzXXZV8ypDBo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=h5az1Pxs7WAEtgM+CgtWvzJkF3vI0ol1En3YBwJxSdTpFZxCi5Sf3oeieB6IrLpAP
 MCKy4kTq9zqGi5lxlL+8sBCLrh5sewPM3db0JE9J4EkHfdJSz26IGG4KWw3NkPiCdB
 o1Z+TmLRIUUzsGFicRjBXEZuZYS2HtyOr0dGux4AwLfMISvtsN0gk/NqSxyuCLYUga
 cgFqhPylMnF1cBaFIGGTTdw5p5zQ7QePXRh1zDaLykyGprYJTi40iUAkFrh1ksrGA3
 KdYiZT9qqsrbgs+TSqWr1YA3EeJMq9PU4/NTxgbWVcIcH8Q0hFLW8LDps1nsVdWNl+
 k8+hd2uX/5CoA==
X-Pm-Submission-Id: 4gVPBR42Jkz2Sccb
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v4 2/3] doc: develop: add section on embedding scripts inside
 control DTB
Date: Tue,  2 Jun 2026 23:30:12 +0200
Message-ID: <20260602213013.558064-3-rv@rasmusvillemoes.dk>
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

Add a section that explains how one can embed scripts in the control
DTB and run them from the U-Boot shell, the advantages of doing that
compared to using a separately built FIT image, and the configuration
knob that must be turned on to allow this to work.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 doc/develop/devicetree/control.rst | 58 ++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 634114af59a..7d6117d5c4b 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -232,6 +232,64 @@ outside the U-Boot repository. You can use `DEVICE_TREE_INCLUDES` Kconfig
 option to specify a list of .dtsi files that will also be included when
 building .dtb files.
 
+Scripts embedded in control DTB
+-------------------------------
+
+The `DEVICE_TREE_INCLUDES` option can also be used to make the control
+DTB serve double duty as a FIT image. By including a `scripts.dtsi`
+file containing something like::
+
+  / {
+	images {
+		default = "boot";
+		boot {
+			description = "Bootscript";
+			data = /incbin/("boot.sh");
+			type = "script";
+			compression = "none";
+		};
+		factory-reset {
+			description = "Script for performing factory reset";
+			data = /incbin/("factory-reset.sh");
+			type = "script";
+			compression = "none";
+		};
+	};
+  };
+
+one can call those scripts using the `source` command in the U-Boot shell::
+
+  source ${fdtcontroladdr}:boot
+
+or just ``source ${fdtcontroladdr}`` for invoking the default.
+
+Since one does not need to separately build a "real" FIT image
+containing those scripts, this simplifies both the build process and
+the boot logic, as the latter does not need to first load the FIT
+image from storage.
+
+Another advantage is that when the bootloader and boot script must be
+updated together, it is easier to achieve a guaranteed atomic update
+when the boot script is embedded inside the U-Boot binary, instead of
+stored separately.
+
+For the above to work, one must enable the `CONTROL_DTB_AS_FIT` config
+option, which will (when the address passed to the `source` command is
+the address of U-Boot's control DTB) elide certain sanity checks that
+are normally done: With the above `.dtsi` snippet, the control DTB
+does not quite become a "real" FIT image - it lacks `timestamp` and
+`description` properties, but more importantly, FIT images cannot
+contain nodes with `@` in their names (unit addresses) anywhere, and
+the control DTB obviously does have such nodes.
+
+This is not a security problem, as the control DTB is necessarily
+trusted. In any secure boot setup where the bootloader is verified,
+that mechanism must also include verification of the control DTB. So
+in fact, since the scripts embedded this way are then also
+automatically verified, it simplifies implementation of secure
+boot. When using a separate FIT image, one must build it with
+appropriate signatures, just as when building a FIT image containing a
+kernel/dtb/initramfs.
 
 Devicetree bindings schema checks
 ---------------------------------
-- 
2.54.0

