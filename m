Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59284C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 11:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEE5283015;
	Tue, 27 May 2025 13:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1748345915;
	bh=sLGAUd4gL52dqEoK0U26/F0vvU9DOBq8S+q9daCBCvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vWNXDTwP6fGOM8ftEJr7AlbiIs5EEIOosm1yrMgR/b4hF4gvvYYmQ3VufTHVvbMPg
	 R+LgU5QHzFKW3iaaQXDpOecP24NwhzgG0dn/o7lgVmD3PwPNYP2AFwUR6azdpj/qvX
	 u+wMS+yojEZrjkT9Vtvlh3KlRiq0lw4ycYnj5ip/4Lz4CHvOHczwO2tOXsUbQ89+2V
	 hDVDmN2yaKBXprcT44bEWpwQEz5X5O4vd+9z8FF4OveoQH9fefGVQj2TCKapAkHpMS
	 XmIG21uGUe284OhfmchKHjvUsqZjbD2Ym/5osMrXH4vrNzYaYP/RmefAlWiAZ3PPnX
	 VrTAOTxmTH5NQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA49C82B7C; Tue, 27 May 2025 13:38:34 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 748AB83022
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 13:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="bcy4YR61"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 446B41039728C; 
 Tue, 27 May 2025 13:38:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1748345911; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=sLGAUd4gL52dqEoK0U26/F0vvU9DOBq8S+q9daCBCvI=;
 b=bcy4YR61jz6NTdaxcvlYepHxujxYke2y1Vbxlp0ac72zimLsnY39JZ9HObfbXKLlpoU2TY
 urM1WjriLG4+dQcqSfSmKPc9/BAVfTSzKJnkgciM+fWkHFxFZCtncNnch0xwBQog1mYkBI
 eQe5uPcBBHxrySZVLjf3EnMGtheqf2JnqNGPmvS/hKz16Y8nmY1q/jVAOsPRbnYnLdJWSk
 KHavqxbf+M3vPbV5HjJLxluXn6NIx9S4Sz5e5QiGpXLsR/+K3FiPzrnMOllewGWmdxUJGw
 9+eICxyY2k92XWFAbYZ4vkS0t+/KaoZPBWW+qNAynu9hDKVSDXHdXwKd0D8JbA==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] spl: Add size check for u-boot-with-spl.bin
Date: Tue, 27 May 2025 13:37:50 +0200
Message-Id: <20250527113751.95741-2-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250527113751.95741-1-pro@denx.de>
References: <20250527113751.95741-1-pro@denx.de>
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

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---
 Makefile           | 7 +++++++
 common/spl/Kconfig | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/Makefile b/Makefile
index f3278e3b013..dea9f4f133f 100644
--- a/Makefile
+++ b/Makefile
@@ -951,6 +951,12 @@ else
 SPL_SIZE_CHECK =
 endif
 
+ifneq ($(CONFIG_UBOOT_WITH_SPL_SIZE_LIMIT),0x0)
+UBOOT_WITH_SPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_UBOOT_WITH_SPL_SIZE_LIMIT))
+else
+UBOOT_WITH_SPL_SIZE_CHECK =
+endif
+
 ifneq ($(CONFIG_TPL_SIZE_LIMIT),0x0)
 TPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_TPL_SIZE_LIMIT))
 else
@@ -1535,6 +1541,7 @@ OBJCOPYFLAGS_u-boot-with-spl.bin = -I binary -O binary \
 				   --pad-to=$(CONFIG_SPL_PAD_TO)
 u-boot-with-spl.bin: $(SPL_IMAGE) $(SPL_PAYLOAD) FORCE
 	$(call if_changed,pad_cat)
+	$(UBOOT_WITH_SPL_SIZE_CHECK)
 
 ifeq ($(CONFIG_ARCH_LPC32XX)$(CONFIG_SPL),yy)
 MKIMAGEFLAGS_lpc32xx-spl.img = -T lpc32xximage -a $(CONFIG_SPL_TEXT_BASE)
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 77cf04d38ed..ace2002023a 100644
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

