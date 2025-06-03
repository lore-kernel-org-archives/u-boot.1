Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8AAC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 09:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA8A981F0D;
	Tue,  3 Jun 2025 11:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1748941827;
	bh=UcSH0OU2J3P/Dukhvwmv/zMg7fgAIYh0T31zeuG8Ia4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tPbR6QSHX+yWso4wOHZptMXtJ054GBiHD69EZELvrf2F68/XaDIeBM1uLGjrDScEE
	 bvfxbd6w0EYMBSn8sPULV3TIUMoUPAuY8NNHx+VykuvxqPWAAAvXikABSI3YTUQrxS
	 MlXw1I5lfLex2g5PizDymVE8D2W/XqA5aNdxfSP/pCIpUCTPiu8gwMO9aKDY9j8t/Y
	 Fj1ByorEWQLFQWa350aR/+Q8G/wcxuMt1Y0H52QB/EVGWYvvVH5wjQaeg11gbBpU3y
	 iVWugF+JTO0JqRzTkOtKrkeK0ZuZ4j92xvXz6IXhChGLQEZSeAQS+XG4zY1sYlHHkL
	 2o8b68Gp8XkKw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3102E82102; Tue,  3 Jun 2025 11:10:26 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4849981E72
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 11:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="YbmbUXNw"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 19E5210397298; 
 Tue,  3 Jun 2025 11:10:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1748941823; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=UcSH0OU2J3P/Dukhvwmv/zMg7fgAIYh0T31zeuG8Ia4=;
 b=YbmbUXNwCMQPnv8Iok+VrBJkW6Qm+C9YW5s4+7RefwvRtP/5/mOFoj8NZFEqOLVnRBUXVB
 lJ9MwYFf5Tv7lTf3gjxb5VJNLg0o9L6KAkstQA0syU/GXYVnFWWUbu2XKXS2B7oREjhXAd
 8uxbKuZTnZOm+nQqGR4kRpO/ChWVuTk4KgPLEfeuAo7F1vN3l8fk4m5N50RMd8K7cAqp4P
 r4C7SvlFzHZShgraoDZsQYruy9uLP77n7bmEGkVn33RF3TOKX6VsX50LvPizCeNtHX2+ea
 VrN00KUSYaC7svXDAX7Egit+rmlfxYXv2sygtNbgH3/4jSAuttubM4uSQhTpRg==
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
Subject: [PATCH v3 1/2] Makefile: Add size check for u-boot-with-spl.bin
Date: Tue,  3 Jun 2025 11:10:04 +0200
Message-Id: <20250603091005.162413-1-pro@denx.de>
X-Mailer: git-send-email 2.39.5
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
    Changes in v2: none
    
    Changes in v3:
    	Reuse existing SPL_SIZE_LIMIT instead of implementing a new option

 Makefile           | 1 +
 common/spl/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f88684947ee..9f3b09a60a3 100644
--- a/Makefile
+++ b/Makefile
@@ -1535,6 +1535,7 @@ OBJCOPYFLAGS_u-boot-with-spl.bin = -I binary -O binary \
 				   --pad-to=$(CONFIG_SPL_PAD_TO)
 u-boot-with-spl.bin: $(SPL_IMAGE) $(SPL_PAYLOAD) FORCE
 	$(call if_changed,pad_cat)
+	$(SPL_SIZE_CHECK)
 
 ifeq ($(CONFIG_ARCH_LPC32XX)$(CONFIG_SPL),yy)
 MKIMAGEFLAGS_lpc32xx-spl.img = -T lpc32xximage -a $(CONFIG_SPL_TEXT_BASE)
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 77cf04d38ed..ff61ee91a10 100644
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

