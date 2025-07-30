Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC6DC87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 12:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5D5282D32;
	Wed, 30 Jul 2025 14:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1753879146;
	bh=ztPJjRn179c1cthhe4TAwWalp5od7uVpXxRhtX+Eb4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=StJTEEK56r+fYJo69BZSwObRUnRrWoknxpe3oDyPFF6IJQXXm2XBgWTku4C/EZfx5
	 oYXeUWc5ZhgMr6GQ2LQ+qjkVqIJw15/T8RC3SnueimsEMTVkjWQQfxHZiOoKgsk3I6
	 tmu3AZBPkpCTgd3L7k41pcXtSQMF5t7FjS0ZFokavMJDcJRa0FBcYnkrkm8WO+b3F7
	 8+2pii0KSmdCgQKc5UWvKpyg/ekUH5IqG5d7el49gjA+A+5FklKhHIyMfhuZpNmood
	 2ePqB2qNxV7EeNfXAiCDnv3SXiGZJJdSNH2vC0CLZf52oJ0v6y2gzNdPyK+R1GJSKw
	 q/kPOuhPY/SDA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 567108004F; Wed, 30 Jul 2025 14:39:05 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 258CF80FA1
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 14:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="MtDtoNUZ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7E9B21038C12A; 
 Wed, 30 Jul 2025 14:39:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1753879142; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ztPJjRn179c1cthhe4TAwWalp5od7uVpXxRhtX+Eb4w=;
 b=MtDtoNUZ6vgKMo66Vm+nGznMx/01wBU7sb1dsuDg9wsMwzBXzR5r96d07Oy0wwYV9by4TI
 EJuuvhoZajufkApLOSizQyA6UP0OggozAJgRyktP8n7Xb9I3HZodMto2cVp5/jDYqZ5dqO
 V6i4bhQSa7G5u2Jedfg1uUTUjLgZbao/eIGUtIOgmitQdT5N3U2A3Ac6zYBFVJa772/rXa
 aKOn2nyMDU/OIwT3MwRWdSynTnIe2F31bhI0srYKGHA11gMcXXNx4mXoqZ6w7W3QyBu0wE
 t0KCIiFxcbtPd4hshP3b6ziPGxokxLt19Do5T7k7c35j5qD7TwjirAbU9p1BKQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
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
Subject: [PATCH v5 2/4] Makefile: Add size check for u-boot-with-spl.bin
Date: Wed, 30 Jul 2025 14:38:31 +0200
Message-Id: <20250730123833.249923-3-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730123833.249923-1-pro@denx.de>
References: <20250730123833.249923-1-pro@denx.de>
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
---

Notes:
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
index aefa44c327f..e10d75384bf 100644
--- a/Makefile
+++ b/Makefile
@@ -1716,6 +1716,7 @@ OBJCOPYFLAGS_u-boot-with-spl.bin = -I binary -O binary \
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

