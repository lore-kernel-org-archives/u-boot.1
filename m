Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10731C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 16:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419AF833C7;
	Tue, 22 Jul 2025 18:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DJHh0XeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47C15833F8; Tue, 22 Jul 2025 18:42:25 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 915598339C
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 18:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45600581226so59243515e9.1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753202542; x=1753807342; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2kX3mQUfK98qzfNsIorRnBV9IunYiwtd02f6Wxtz8GY=;
 b=DJHh0XeEafjtQ4QsLsb97KXg2FzEshjAG/SEI390FaqG3voMXQBL2ofvSyUlNHZ4F7
 vAjNeb2cGLF5YglOWVirWfe29lo/Msl0BNvo88uqP5O0XsJWvxAIh5BpuBnpxe9r7RIE
 kHyAUlM4OiVQ2YoVFboIVLR2BnsNqlQ+idne/C1RMvEq0yg1+VBvPP6X1DyyyPQhY+tt
 X1bMks0liNEazh/7mtXnwxuxk/o+8PWXZTCuSA4AOdVkqvKyBBGDyKPwFpp66bSXee5D
 YQ0FsmMbsC7AqdZ8+6Gx736m+OAax8fntwanekKcbY4kYEpGOMrdKqzwG4FCqyWvcNjI
 f96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753202542; x=1753807342;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2kX3mQUfK98qzfNsIorRnBV9IunYiwtd02f6Wxtz8GY=;
 b=LKEGlk+nrgqaIt7KIXsjm1gzN9EQujmI+8Eho70Rf1L6NFpoFpcz8MnWec/Bc5tzYk
 YvIaD8qiMIKHNOMBRX/DwYgLuZAPBTOJQlruFzao8Gl5gw2ScEU+WBlDm1/GVzQaqmHj
 9h/jMCq1gnncN7VSmWcaTbzP2I0gr2RPvvtuB5jvUXayNB0tCkfDETz+6uMbPLC9XOxF
 rb6zOcgW9OJQHwYSmiW87Dreah8u5megwPmQBX0NH+YAe21LwY+XbbTZxgEb3pEFUK9M
 dlbZFHZd/dJt/LwS8PL0dEv91Ybmx3tjJTvOIiPvy1fMW/4D9qQ6Zcn5U+eJMGUqN3Gv
 zeXw==
X-Gm-Message-State: AOJu0YxBeLv4NlsRzI4+FTnfomYGFpkwNCZjuwUWDn6z4dhe8Ew3UD6Q
 Yl/zrShc8+UAeYmF82jXazEHCSu3EOMZTN7nq7dJXGNCM009Gl0iOUlygi1jBQtnhJzlEmZeGc3
 Yyijl
X-Gm-Gg: ASbGncuHJBbZtEHy0djGRd9LE9nON0HT7YH/51yt30Om3zFHM6DgrJDvNxD7lmD6Q9U
 4+fO9G4CR9ykk6W5A7mRCsiwqD7/OCja+GGjTb3arVIrcxQ9swR0J+fgLgplNsBgypfaXegFee4
 HcbbZjMWlmeRGIHNl+dwDtHEmeTEFkp+vSa1Rw8ymPzmKCfI7E5XtvQN+UrUZdYMTLA0cnBNRuQ
 Mum1QIH1JQJdZPLOJJajjMlrkYF35vM7YJKZmW4YWTr+XjnQNTuCw3lmsI53kO1byoa8x7Jl/RW
 lLsZfVkAblW4KvT/4mHvvB2apYir7hGE1m4EImcbqaWbJoQa6CBmldijmB0QBqq56y9FLSEhfh5
 04R94vFXF5DYs1upeo/wTrShjjQP9YDM8jP28pjWoyyeMdlKv2wBkgZR6Mo3GfQ==
X-Google-Smtp-Source: AGHT+IGy/Ue5BI5pniRRRW+j/Yk+mi00p1AB6dLafiVHZfv0pEXDOlA7F8kkCCeIVOStddMzRvchdw==
X-Received: by 2002:a05:600c:820f:b0:43c:ec0a:ddfd with SMTP id
 5b1f17b1804b1-4562ed57638mr221639615e9.6.1753202541812; 
 Tue, 22 Jul 2025 09:42:21 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:eb9:1701:2943:d0d1:b3a5:d7fb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4563b7404f3sm138811035e9.23.2025.07.22.09.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 09:42:21 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 22 Jul 2025 17:42:20 +0100
Subject: [PATCH] sata: sata_mv: Remove always true test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-sata_mv-v1-1-ad4f3589a67b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGu/f2gC/x2NwQrCQAwFf6Xk7MIaWor+iogk9dXm0FWSUoTSf
 3frcZiB2SjghqBrs5FjtbB3qXA+NTRMUl5I9qxMnLnLPXMKWeQxr6nN6HMLvSgr1VolkNSlDNP
 RzxIL/BAfx2jf/+J23/cfdH3v0XIAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Smatch reported an issue with a test that was always true in that an
unsigned variable will always be >= to zero. This led to a closer look
at the code which showed that some static functions returned values that
were always discarded so make those functions return void. Also make
the passing of block counts in those functions always use lbaint_t.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/ata/sata_mv.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index ac78760a33e..82dc5304dde 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -363,7 +363,7 @@ static int mv_start_edma_engine(struct udevice *dev, int port)
 	return 0;
 }
 
-static int mv_reset_channel(struct udevice *dev, int port)
+static void mv_reset_channel(struct udevice *dev, int port)
 {
 	struct mv_priv *priv = dev_get_plat(dev);
 
@@ -374,8 +374,6 @@ static int mv_reset_channel(struct udevice *dev, int port)
 	udelay(25);		/* allow reset propagation */
 	out_le32(priv->regbase + EDMA_CMD, 0);
 	mdelay(10);
-
-	return 0;
 }
 
 static void mv_reset_port(struct udevice *dev, int port)
@@ -578,9 +576,9 @@ static void process_responses(struct udevice *dev, int port)
 	}
 }
 
-static int mv_ata_exec_ata_cmd(struct udevice *dev, int port,
-			       struct sata_fis_h2d *cfis,
-			       u8 *buffer, u32 len, u32 iswrite)
+static void mv_ata_exec_ata_cmd(struct udevice *dev, int port,
+				struct sata_fis_h2d *cfis,
+				u8 *buffer, labint_t len, u32 iswrite)
 {
 	struct mv_priv *priv = dev_get_plat(dev);
 	struct crqb *req;
@@ -589,7 +587,7 @@ static int mv_ata_exec_ata_cmd(struct udevice *dev, int port,
 
 	if (len >= 64 * 1024) {
 		printf("We only support <64K transfers for now\n");
-		return -1;
+		return;
 	}
 
 	/* Initialize request */
@@ -653,7 +651,7 @@ static int mv_ata_exec_ata_cmd(struct udevice *dev, int port,
 	/* Wait for completion */
 	if (wait_dma_completion(dev, port, slot, 10000)) {
 		printf("ATA operation timed out\n");
-		return -1;
+		return;
 	}
 
 	process_responses(dev, port);
@@ -664,16 +662,13 @@ static int mv_ata_exec_ata_cmd(struct udevice *dev, int port,
 		invalidate_dcache_range(start,
 					start + ALIGN(len, ARCH_DMA_MINALIGN));
 	}
-
-	return len;
 }
 
-static u32 mv_sata_rw_cmd_ext(struct udevice *dev, int port, lbaint_t start,
-			      u32 blkcnt,
-			      u8 *buffer, int is_write)
+static void mv_sata_rw_cmd_ext(struct udevice *dev, int port, lbaint_t start,
+			       labint_t blkcnt,
+			       u8 *buffer, int is_write)
 {
 	struct sata_fis_h2d cfis;
-	u32 res;
 	u64 block;
 
 	block = (u64)start;
@@ -693,18 +688,15 @@ static u32 mv_sata_rw_cmd_ext(struct udevice *dev, int port, lbaint_t start,
 	cfis.sector_count_exp = (blkcnt >> 8) & 0xff;
 	cfis.sector_count = blkcnt & 0xff;
 
-	res = mv_ata_exec_ata_cmd(dev, port, &cfis, buffer,
-				  ATA_SECT_SIZE * blkcnt, is_write);
-
-	return res >= 0 ? blkcnt : res;
+	mv_ata_exec_ata_cmd(dev, port, &cfis, buffer,
+			    ATA_SECT_SIZE * blkcnt, is_write);
 }
 
-static u32 mv_sata_rw_cmd(struct udevice *dev, int port, lbaint_t start,
-			  u32 blkcnt, u8 *buffer, int is_write)
+static void mv_sata_rw_cmd(struct udevice *dev, int port, lbaint_t start,
+			   lbaint_t blkcnt, u8 *buffer, int is_write)
 {
 	struct sata_fis_h2d cfis;
 	lbaint_t block;
-	u32 res;
 
 	block = start;
 
@@ -720,19 +712,16 @@ static u32 mv_sata_rw_cmd(struct udevice *dev, int port, lbaint_t start,
 	cfis.lba_low = block & 0xff;
 	cfis.sector_count = (u8)(blkcnt & 0xff);
 
-	res = mv_ata_exec_ata_cmd(dev, port, &cfis, buffer,
-				  ATA_SECT_SIZE * blkcnt, is_write);
-
-	return res >= 0 ? blkcnt : res;
+	mv_ata_exec_ata_cmd(dev, port, &cfis, buffer,
+			    ATA_SECT_SIZE * blkcnt, is_write);
 }
 
 static u32 ata_low_level_rw(struct udevice *dev, int port, lbaint_t blknr,
 			    lbaint_t blkcnt, void *buffer, int is_write)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(dev);
-	lbaint_t start, blks;
+	lbaint_t start, blks, max_blks;
 	u8 *addr;
-	int max_blks;
 
 	debug("%s: " LBAFU " " LBAFU "\n", __func__, blknr, blkcnt);
 

---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250722-sata_mv-40e704eb9b2b

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

