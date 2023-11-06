Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63F8C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 02:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E3E18701D;
	Mon,  6 Nov 2023 03:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ABaf22qe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17CEE86EEB; Mon,  6 Nov 2023 03:27:06 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC45A86FB7
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7781b176131so201169885a.1
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237573; x=1699842373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fM6S65KgM+ZZGYfz6/dW8QFaaInzwvZ5V8GjaJVJhr8=;
 b=ABaf22qeoCUIqvca9Y8jJGnTmmXkhb5yTsRRK/0+JV05QESQoVdC9nXUHsiuM+onLo
 IsIvz6kgQVyC2hstVlUxGRtNEXQGLX3Esl0BrtMxQlZyzttSe0K5bK6n3YahRWrewoVf
 fv7u/TZPPSpkSAu2AJJQl9fIhzftvG3OtA6PV7gHvp9RYzd4QLvJdBAd1g63Ku26xpG5
 Ym2CMSjYguGGYfuqT9/p54XxHI69K5on3Rclc+mNNC/bB2l8Mmhj6pfzAx3V/ht/iq5W
 EaLYQ1+v5UP/7/0JlMR06alDnjyP+zxl6RDGUJ0xaQlGdowuTnGM142MLRT4u5LlhMtQ
 Ibew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237573; x=1699842373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fM6S65KgM+ZZGYfz6/dW8QFaaInzwvZ5V8GjaJVJhr8=;
 b=Uxtshbcfy7otw4GvCLPk9U6DEdkA2eQYLo7itPeb7zOrw4joxo0M47Nl7i9GDq6b1K
 Xx+MB3oS6WUH9LrOtKklmIXHdn7rhXq6KlAD8amgaySSXvjkop2dyPHDJKbN5L9s4UN6
 tnzWE0QvjHLTMIyHsQLZ3T1c+G0dy3gNSuQsAe70WSiP7UjCWI6KWDXpOS2vA6vv6piu
 dOMUwMWSBloQZiBXISe86vkgfCf1/0VmjF8Qu2/wqMiSNIgc10BPyZBW8Oj5NRyPbmY4
 1d4oaTDkHxywJYxH5pAnLmscAWiriFfX3uVLL07NGmEtChZ1wrucOWYvHt1/MT3Qjv80
 idRg==
X-Gm-Message-State: AOJu0Yy6/OzmOuH23KRjGozuTPWVF87aaq3VBGPjSBHrnyM1AmPuTKb2
 HlTbPc6ptY+sVYwcnxRWV+M=
X-Google-Smtp-Source: AGHT+IGgnG5vvc/QHIA0kiADg3W8tH4598qwJIwIAZmEAlmqfKkpIfDTHIhu3eUw+d1ln3e7TC4UYg==
X-Received: by 2002:a05:620a:2450:b0:773:c6a1:a4e0 with SMTP id
 h16-20020a05620a245000b00773c6a1a4e0mr32000208qkn.2.1699237573369; 
 Sun, 05 Nov 2023 18:26:13 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 x8-20020ae9f808000000b007756e75b91bsm2890086qkh.78.2023.11.05.18.26.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:13 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v6 06/25] spl: Remove dev from spl_load_info
Date: Sun,  5 Nov 2023 21:25:44 -0500
Message-Id: <20231106022603.3405551-7-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

dev and priv server the same purpose, and are never set at the same time.
Remove dev and convert all users to priv. While we're at it, reorder bl_len
to be last for better alignment.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- New

 common/spl/spl_mmc.c       | 6 +++---
 common/spl/spl_spi.c       | 6 +++---
 drivers/usb/gadget/f_sdp.c | 6 +++---
 include/spl.h              | 4 +---
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 6d9137c32e0..3d7551a7dae 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -65,7 +65,7 @@ static int mmc_load_legacy(struct spl_image_info *spl_image,
 static ulong h_spl_load_read(struct spl_load_info *load, ulong sector,
 			     ulong count, void *buf)
 {
-	struct mmc *mmc = load->dev;
+	struct mmc *mmc = load->priv;
 
 	return blk_dread(mmc_get_blk_desc(mmc), sector, count, buf);
 }
@@ -105,7 +105,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		debug("Found FIT\n");
-		load.dev = mmc;
+		load.priv = mmc;
 		load.filename = NULL;
 		load.bl_len = mmc->read_bl_len;
 		load.read = h_spl_load_read;
@@ -114,7 +114,7 @@ int mmc_load_image_raw_sector(struct spl_image_info *spl_image,
 		   valid_container_hdr((void *)header)) {
 		struct spl_load_info load;
 
-		load.dev = mmc;
+		load.priv = mmc;
 		load.filename = NULL;
 		load.bl_len = mmc->read_bl_len;
 		load.read = h_spl_load_read;
diff --git a/common/spl/spl_spi.c b/common/spl/spl_spi.c
index d83d70f2f33..af7a28e7c25 100644
--- a/common/spl/spl_spi.c
+++ b/common/spl/spl_spi.c
@@ -59,7 +59,7 @@ static int spi_load_image_os(struct spl_image_info *spl_image,
 static ulong spl_spi_fit_read(struct spl_load_info *load, ulong sector,
 			      ulong count, void *buf)
 {
-	struct spi_flash *flash = load->dev;
+	struct spi_flash *flash = load->priv;
 	ulong ret;
 
 	ret = spi_flash_read(flash, sector, count, buf);
@@ -151,7 +151,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 			struct spl_load_info load;
 
 			debug("Found FIT\n");
-			load.dev = flash;
+			load.priv = flash;
 			load.filename = NULL;
 			load.bl_len = 1;
 			load.read = spl_spi_fit_read;
@@ -162,7 +162,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 			   valid_container_hdr((void *)header)) {
 			struct spl_load_info load;
 
-			load.dev = flash;
+			load.priv = flash;
 			load.filename = NULL;
 			load.bl_len = 1;
 			load.read = spl_spi_fit_read;
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index ee9384fb37e..1b16b7eb452 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -744,7 +744,7 @@ static ulong sdp_load_read(struct spl_load_info *load, ulong sector,
 {
 	debug("%s: sector %lx, count %lx, buf %lx\n",
 	      __func__, sector, count, (ulong)buf);
-	memcpy(buf, (void *)(load->dev + sector), count);
+	memcpy(buf, (void *)(load->priv + sector), count);
 	return count;
 }
 
@@ -844,7 +844,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 				struct spl_load_info load;
 
 				debug("Found FIT\n");
-				load.dev = header;
+				load.priv = header;
 				load.bl_len = 1;
 				load.read = sdp_load_read;
 				spl_load_simple_fit(spl_image, &load, 0,
@@ -857,7 +857,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 			    valid_container_hdr((void *)header)) {
 				struct spl_load_info load;
 
-				load.dev = header;
+				load.priv = header;
 				load.bl_len = 1;
 				load.read = sdp_load_read;
 				spl_load_imx_container(spl_image, &load, 0);
diff --git a/include/spl.h b/include/spl.h
index 8ff20adc28e..951e136b9ea 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -285,16 +285,13 @@ static inline void *spl_image_fdt_addr(struct spl_image_info *info)
 /**
  * Information required to load data from a device
  *
- * @dev: Pointer to the device, e.g. struct mmc *
  * @priv: Private data for the device
  * @bl_len: Block length for reading in bytes
  * @filename: Name of the fit image file.
  * @read: Function to call to read from the device
  */
 struct spl_load_info {
-	void *dev;
 	void *priv;
-	int bl_len;
 	const char *filename;
 	/**
 	 * read() - Read from device
@@ -307,6 +304,7 @@ struct spl_load_info {
 	 */
 	ulong (*read)(struct spl_load_info *load, ulong sector, ulong count,
 		      void *buf);
+	int bl_len;
 };
 
 /*
-- 
2.37.1

