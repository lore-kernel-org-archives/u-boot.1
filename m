Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCAAE784BE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 21:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7617083C23;
	Sun, 28 Dec 2025 22:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="VdclGosV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6312883A8C; Sun, 28 Dec 2025 20:43:38 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C9F83A3D
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 20:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B1F6710CA7A; Sun, 28 Dec 2025 20:43:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1766951014; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Rm1LbjQhbB6B/5/CqGnOecZcERw1MwYyVLKs8iq9MnA=;
 b=VdclGosVqCMQFrBNw6H4xXpFYkSLZkhXK+5QTvPNwOWPrzkbXpTR+yElmAzbMxMWlB5tZe
 BDWexLUR1uouc5MXiVN0Cr3uW6Zc8m+qGIGeyHv1BBvhBRwfH2mFblpDewONPxUffrmZPt
 RKTh0OevPQspYWYK+rPYuE+5nUbBldk/y9rmlySifdb0Vk0+++p69wT5DuzK3TpR5BtdRL
 G2lpfutvLJgQ5XMKNTLRAljTMpmQJmad3HXlbD5QTM0/bkXSVUys5nPg3yyvfpK0x2D6nQ
 En1ZGigLCPg3D4UFe88inThBJizp52oF421/jR/DWqt8+zDvBd73KsCxKgYhEg==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] Makefile: Make flash.bin target available on i.MX9
Date: Sun, 28 Dec 2025 20:43:21 +0100
Message-ID: <20251228194329.354828-1-marex@nabladev.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Sun, 28 Dec 2025 22:40:09 +0100
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

The current implementation of flash.bin generation with
CONFIG_SPL_LOAD_IMX_CONTAINER=y requires build of u-boot.cnt
which is i.MX8 specific. Reinstate the i.MX8 check to avoid
this dependency for i.MX9 .

Fill in flash.bin target for i.MX9 into imx specific Makefile.

Fixes: c3587197c0c9 ("Makefile: Make flash.bin target available for all platforms")
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 Makefile                   | 9 ++++++---
 arch/arm/mach-imx/Makefile | 3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 2402f9313d8..cc6b7f49557 100644
--- a/Makefile
+++ b/Makefile
@@ -1769,14 +1769,18 @@ tpl/u-boot-with-tpl.bin: tpl/u-boot-tpl.bin u-boot.bin FORCE
 SPL: spl/u-boot-spl.bin FORCE
 	$(Q)$(MAKE) $(build)=arch/arm/mach-imx $@
 
-#ifeq ($(CONFIG_ARCH_IMX8M)$(CONFIG_ARCH_IMX8), y)
-ifeq ($(CONFIG_SPL_LOAD_IMX_CONTAINER), y)
+ifeq ($(CONFIG_SPL_LOAD_IMX_CONTAINER),y)
+ifeq ($(CONFIG_ARCH_IMX8M)$(CONFIG_ARCH_IMX8),y)
 u-boot.cnt: u-boot.bin FORCE
 	$(Q)$(MAKE) $(build)=arch/arm/mach-imx $@
 
 flash.bin: spl/u-boot-spl.bin u-boot.cnt FORCE
 	$(Q)$(MAKE) $(build)=arch/arm/mach-imx $@
 else
+flash.bin: spl/u-boot-spl.bin FORCE
+	$(Q)$(MAKE) $(build)=arch/arm/mach-imx $@
+endif
+else
 ifeq ($(CONFIG_BINMAN),y)
 flash.bin: spl/u-boot-spl.bin $(INPUTS-y) FORCE
 	$(call if_changed,binman)
@@ -1785,7 +1789,6 @@ flash.bin: spl/u-boot-spl.bin u-boot.itb FORCE
 	$(Q)$(MAKE) $(build)=arch/arm/mach-imx $@
 endif
 endif
-#endif
 
 u-boot.uim: u-boot.bin FORCE
 	$(Q)$(MAKE) $(build)=arch/arm/mach-imx $@
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index fa2cdaba144..a19c4f1a74c 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -226,6 +226,9 @@ ifeq ($(CONFIG_ARCH_IMX9)$(CONFIG_ARCH_IMX8ULP), y)
 ifneq ($(and $(CONFIG_IMX95),$(CONFIG_BINMAN)),)
 SPL: spl/u-boot-spl.bin FORCE
 	$(call if_changed,mkimage)
+
+flash.bin: spl/u-boot-spl.bin FORCE
+	$(call if_changed,mkimage)
 else
 quiet_cmd_cpp_cfg_imx9_check = CHECK    $@
 cmd_cpp_cfg_imx9_check = $(CPP) $(cpp_flags) -D__ASSEMBLY__ -x c -o $@ $< && $(srctree)/tools/imx9_image.sh $@
-- 
2.51.0

