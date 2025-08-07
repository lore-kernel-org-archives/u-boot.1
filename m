Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91AAC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 07:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7097783C34;
	Thu,  7 Aug 2025 09:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754553447;
	bh=X9tNRDssmzsXmabc05mhaMzOiTBuQSGju3y/dd0CjFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jCBWfeL8llN/8Sr3WYapZBW6ZRMGj3pLpRGbOxz+Hll97VKorVn89tPPeUIlmJCM+
	 IgvAD0VgegGfHxbPW9c3RjKuQS/hVKqIxrfooIvPGkN0qbf2Na9er9TSTpfiu+1Oce
	 m6yg7ktqoDR3TYFGUlAF3NizYzXIGc/VIpQ39Fmq/moQWD59eOWGVnI31AyWLmppdO
	 mPW7/r5CQcbkRsv4YuZxi03z1BEQZdBvfhu0AfEt+y08CtZBvDVrLPwEqjj4bBm2zB
	 w5bF0GHf2TLdlgdz/lsWIVBBRnkCM2Yqtvk0r16qMry/eOCciTw0XgNpwKzhpS4+iO
	 6ii22qjWaVmkg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39EBF83C34; Thu,  7 Aug 2025 09:57:26 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B861183C16
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="PoFk7Hz1"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9E6BB1038C12A; 
 Thu,  7 Aug 2025 09:57:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754553443; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=X9tNRDssmzsXmabc05mhaMzOiTBuQSGju3y/dd0CjFk=;
 b=PoFk7Hz1SCpQC/I5seBi8R998e3XBTf/4GG+9vPlDK6Z6I9elC0Cuz7FBrjdnEK2IxnQ26
 4/DKA4/DwhlOl7G+wsDlb+oafE/YMnyFJeuYmLWZx/U4Y6A7dGZEzKsOXfTONCZiStnUPv
 ZNVi3Gup0+VRF6uSBojlTH4DC9MoQXNd4ca5RdDkWkL77dtKXXjZXamZsrJEKK+j6eC88W
 ZtxHU+neBmqr2iVLYVRFOq6Ag62ZQnE9mmlWsTlzF7AMS2jubh+GUQuUfHPVwoB5OdYnyP
 uh70RqB4h4jaXJ7dQpMbe92kRx76eTOHSIuGMFc3/RPDmshFTZDm94pBakgJRw==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>, Tom Rini <trini@konsulko.com>,
 Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 2/4] Makefile: Add size check for u-boot-with-spl.bin
Date: Thu,  7 Aug 2025 09:56:51 +0200
Message-Id: <20250807075653.356088-3-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807075653.356088-1-pro@denx.de>
References: <20250807075653.356088-1-pro@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Introduce another SIZE_CHECK macro for u-boot-with-spl.bin.

Note that we cannot reuse BOARD_SIZE_LIMIT here, as this also applies to
intermediate u-boot*bin images, which, before being compressed, may be
larger than the final combined image.

Also SPL_SIZE_LIMIT has to be a separate option, as some boards might
just want to restrict SPL size while still allowing u-boot-with-spl.bin
to be bigger.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

Notes:
    Changes in v6: none
    
    Changes in v5:
    	- Fix for broken boards reported in v4
    	- See https://patchwork.ozlabs.org/project/uboot/patch/20250708103959.26129-2-pro@denx.de/
    
    Changes in v4: none
    
    Changes in v3:
    	Reuse existing SPL_SIZE_LIMIT instead of implementing a new option
    
    Changes in v2: none

 Makefile           | 1 +
 common/spl/Kconfig | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 69c37082610..70d963a5724 100644
--- a/Makefile
+++ b/Makefile
@@ -1715,6 +1715,7 @@ OBJCOPYFLAGS_u-boot-with-spl.bin = -I binary -O binary \
 				   --pad-to=$(CONFIG_SPL_PAD_TO)
 u-boot-with-spl.bin: $(SPL_IMAGE) $(SPL_PAYLOAD) FORCE
 	$(call if_changed,pad_cat)
+	@$(call size_check,$@,$(CONFIG_UBOOT_WITH_SPL_SIZE_LIMIT))
 
 ifeq ($(CONFIG_ARCH_LPC32XX)$(CONFIG_SPL),yy)
 MKIMAGEFLAGS_lpc32xx-spl.img = -T lpc32xximage -a $(CONFIG_SPL_TEXT_BASE)
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index ab05536bd02..b5c0c60ff6b 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -36,6 +36,13 @@ config SPL_FRAMEWORK_BOARD_INIT_F
 	  - initialize the serial (preloader_console_init)
 	  Unless you want to provide your own board_init_f, you should say Y.
 
+config UBOOT_WITH_SPL_SIZE_LIMIT
+	hex "Maximum size of u-boot-with-spl.bin"
+	default 0x0
+	help
+	  Specifies the maximum length of the u-boot-with-spl.bin image.
+	  If this value is zero, it is ignored.
+
 config SPL_SIZE_LIMIT
 	hex "Maximum size of SPL image"
 	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
-- 
2.39.5

