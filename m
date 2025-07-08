Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BC2C83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 10:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61FFE83285;
	Tue,  8 Jul 2025 12:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1751971236;
	bh=3JeotcYVis4sPUaCGfG4DQvJByEeRHx2zlTG/ztKKyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a9x+/P8P27h3WfANp5/AsFaJ1wS5lbxrj+RGk9+4WUrHA3FV4GBIrMVVYx7XbA68J
	 XA6M4GKUr3Dj2HqhJhdb8SFpztKHja8pY3tkrge+cfMgPhESkfeW2FDoxj8Vc/1dX/
	 RIZtZEEQm4oJIf6jmtuO3hPyz9LSQTv2o1ujcYY4oLLDwahR9T0x9dhpM0YLpTnl27
	 RrjErVQOAEwUep9jR9Htzp8vhJJ1ZuV5ZvxATb4nSqWlWruPETxbWv+rNAnjSEtiK8
	 nl3U4sqUOkgj/EOlQ3+bD0Ux9PtpUvzvs2kuTU8JRzlpEGsxAbEsUzRVOmV3vSGTAR
	 /GfWkgVLe3ayg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFE1883015; Tue,  8 Jul 2025 12:40:35 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 085EA83297
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 12:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ZvlqXxqf"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C629E103972A9; 
 Tue,  8 Jul 2025 12:40:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1751971233; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=3JeotcYVis4sPUaCGfG4DQvJByEeRHx2zlTG/ztKKyY=;
 b=ZvlqXxqfMw3JiTRyuSPnWDTLI+XH6dI25B8x+VFFLSZS9pO5qwmo42Inz1ROTjD/VgTt3L
 PjXLc8jp3to1kW6lDgBR8lFDee3o4c9wlUpltywJWJ3TNxYEP7F1FqGQp1aKD4ZuErG0QV
 7BvG1PrzZE4bCt47y44ci1FzwRrqPPsXYI3ei9up6UShz+Py/z/2PzEzjEQ369EiwuIU1x
 4pFa/8dV0bkT6l9fIZsfRbdFf7CtKNBsNq9KVxZaLCDNiNU569zTXtXRKfvuQeWF2Ra9d+
 jUv/Qp/ZRuqfCIuJOwfU7L9ZLNfu+hn+B1HeZKDM4HPivQhIrg1XuCBUHJVicw==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 1/3] Makefile: Add size check for u-boot-with-spl.bin
Date: Tue,  8 Jul 2025 12:39:57 +0200
Message-Id: <20250708103959.26129-2-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250708103959.26129-1-pro@denx.de>
References: <20250708103959.26129-1-pro@denx.de>
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

Like other images, u-boot-with-spl.bin may be subject to size
restrictions. Extend CONFIG_SPL_SIZE_LIMIT to handle this case.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---

Notes:
    Changes in v4: none
    
    Changes in v3:
    	Reuse existing SPL_SIZE_LIMIT instead of implementing a new option
    
    Changes in v2: none

 Makefile           | 1 +
 common/spl/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index fa9ce756083..791c00713ec 100644
--- a/Makefile
+++ b/Makefile
@@ -1545,6 +1545,7 @@ OBJCOPYFLAGS_u-boot-with-spl.bin = -I binary -O binary \
 				   --pad-to=$(CONFIG_SPL_PAD_TO)
 u-boot-with-spl.bin: $(SPL_IMAGE) $(SPL_PAYLOAD) FORCE
 	$(call if_changed,pad_cat)
+	$(SPL_SIZE_CHECK)
 
 ifeq ($(CONFIG_ARCH_LPC32XX)$(CONFIG_SPL),yy)
 MKIMAGEFLAGS_lpc32xx-spl.img = -T lpc32xximage -a $(CONFIG_SPL_TEXT_BASE)
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 9a17ccb2d3d..dcb25b593f1 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -43,7 +43,7 @@ config SPL_SIZE_LIMIT
 	default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
 	default 0x0
 	help
-	  Specifies the maximum length of the U-Boot SPL image.
+	  Specifies the maximum length of U-Boot SPL images.
 	  If this value is zero, it is ignored.
 
 config SPL_SIZE_LIMIT_SUBTRACT_GD
-- 
2.39.5

