Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922C1CCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 22:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7A5483B0E;
	Thu,  6 Nov 2025 23:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="aspteKzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1958183C51; Thu,  6 Nov 2025 18:01:45 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 018CA83BDD
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 18:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so10146225e9.1
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 09:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1762448499; x=1763053299;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+ewmpIiOxmkDa6VyEV7TtFSD5FesY2Aoh6a2lv+Y1Y8=;
 b=aspteKzPJXrRrKttrp0jqowasJc0d7wsDQA7mzdf8Ry8zSExd0njF6Vc8tYe7M5cY9
 UXc+NwiecjaqzxaBlDvtHTQEXX4PrZxjVA04C3xAHcasvuEnw6NpEiWylSuFYrZKuHyW
 yWYcCk7GkNiAJIhgbtslcSSeqjm4lOIb2sv9VG5r2jsfWXgTrfcKWEanqBsezmXHAg8+
 KrGkuDR0V8HiEzT0xII+oW1crpQttaTzsCy2X3IRF/cXMIPT5acSSBtA46tHJ8cpHmy8
 2BBaZ75HR78fyY+wUYxd8VOlZ8K2ala1evgbUIkz7J7hg2mTLGDXQg1oUYgpjb5lLyvx
 vlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762448499; x=1763053299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ewmpIiOxmkDa6VyEV7TtFSD5FesY2Aoh6a2lv+Y1Y8=;
 b=gZ0/eiEZzoGtI6VylTyP8PseEyxqGGrzx6eX2E09+5Kxfp6cY3D/8Tovb5+fRIvy5g
 Pl3/IIivI+nT0w6kawFvOpb3BodsdcA6M2SrGFYCokt5qIJtjh54jIMD83urrNgg/itX
 auBzjkV3Uh+dPVTdqFjMy4lBB+GWbc+SWUBytkz5r0sgpWGeT/lHfjcNiCXJffTiCQnO
 Ebuwl5rvEbRwKs78iF8wisheUSAxQWnb2Gnk4k9YPdZDEC9lIdu6sB2nzfXQWRqYMLkk
 ua20B6OkKfteE0/1IlBLKWXygR6SlZBYp7tjE/i/nhgoTuFqew8/x4+flnnQjVsiinYN
 eUVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/B4uOQTGlKNUb8g9mTlirtNXsl9dBEKkCwqz1gE3af3YVW+cavWTfCW70ejjZRLpge5gTU30=@lists.denx.de
X-Gm-Message-State: AOJu0YyzF0rqqXe4K0FjFgRQdIJWuqqsHkYkPe1Qu9QEz9WIhS65TGmN
 Ngr7Vy6Sj1HhImPdPHHm+i6icUg0hKs9+emcgQAuA5iUjy3WHdzePdUCO6CT/z5P5XA=
X-Gm-Gg: ASbGncvTerEG2JNf1QJG2lp824kwh+z64Rk8YZT76vK5xTuR+3upQHGjBYrQc+MX/5q
 2SPiME8bL0MZnoJLEKZE+3k+NC48uE8fa6d4tt4B2Va+Ap9bE/t6de/+xjkea0yqUZj6muUT5wR
 hWj82tXPvr/1YAR0EySduylYYNT8GpxRZnSQaUV2OnECsULb858HYzJGhSRLREdaRtaXeSuL9pW
 ba+8Fs0WIhRGTLP5y2FSyGvZkK1nuOIHESseOkmQbLaSxzyanfoPIZJmWV6rg3MpGqRZotLV1Ki
 EJVnwFcXd908XBWLEjArt3x7kOwjAwnlssia2H6R/R/z8A4Kc4uiZBMuDBHgGNY0m35Nnlhrjia
 /t4hk9/EIRKxEH2AbgWfKYWtLNn8C8VLkeWeow5FxOIkQmhnAltFE7SJILtox7yfbNa0r5hbB+F
 DpNUM1
X-Google-Smtp-Source: AGHT+IFsBL0J9jUnpscoJh+K3LGrEpS9AQzhtNfA1B0xxfX2wnpc90zdPiouOU741ecEYGa+TxHs/g==
X-Received: by 2002:a05:600c:6289:b0:477:3543:3a3b with SMTP id
 5b1f17b1804b1-4776bcb20a4mr225345e9.6.1762448498949; 
 Thu, 06 Nov 2025 09:01:38 -0800 (PST)
Received: from box-zli ([78.199.60.143]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4776bccd41bsm79845e9.2.2025.11.06.09.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 09:01:38 -0800 (PST)
From: Zixun LI <admin@hifiphile.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [RFC PATCH] mtd: nand: raw: Add ONFI NAND unique id read support.
Date: Thu,  6 Nov 2025 18:01:23 +0100
Message-ID: <20251106170124.3992080-1-admin@hifiphile.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Nov 2025 23:47:10 +0100
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

This patch adds support for reading the unique ID from ONFI-compliant NAND
flash devices.

The unique ID is a 32 bytes long identifier that is useful for device
identification and tracking.

Tested on SAM9G25-EK with Macronix MX60LF8G18AC flash.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/mtd/nand/raw/nand_base.c | 69 ++++++++++++++++++++++++++++++++
 include/linux/mtd/rawnand.h      |  8 ++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 48e3685d995..30aa578e074 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -991,6 +991,75 @@ static int nand_onfi_set_timings(struct mtd_info *mtd, struct nand_chip *chip)
 				       tmode_param);
 }
 
+/**
+ * nand_onfi_read_unique_id - read the ONFI unique ID sequence
+ * @chip: NAND chip descriptor
+ * @buf: destination buffer
+ * @len: size of the destination buffer
+ *
+ * Issues the ONFI UNIQUE_ID command sequence, validates the unique ID and
+ * copies it into @buf.
+ *
+ * Return: 0 on success or negative error code otherwise.
+ */
+int nand_onfi_read_unique_id(struct nand_chip *chip, void *buf,
+			     unsigned int len)
+{
+	struct mtd_info *mtd;
+	unsigned int copy;
+	unsigned int byte;
+	unsigned int copy_len;
+	u8 raw_id[ONFI_UNIQUE_ID_LEN * 2];
+	u8 *out = buf;
+	int ret = -EIO;
+
+	if (!chip)
+		return -EINVAL;
+
+	if (len && !buf)
+		return -EINVAL;
+
+	if (len > ONFI_UNIQUE_ID_LEN)
+		return -EINVAL;
+
+	if (!chip->onfi_version)
+		return -EOPNOTSUPP;
+
+	mtd = nand_to_mtd(chip);
+	nand_get_device(mtd, FL_READING);
+	chip->select_chip(mtd, 0);
+
+	chip->cmdfunc(mtd, NAND_CMD_UNIQUE_ID, 0, -1);
+
+	for (copy = 0; copy < ONFI_UNIQUE_ID_COPIES; copy++) {
+		for (byte = 0; byte < ONFI_UNIQUE_ID_LEN * 2; byte++)
+			raw_id[byte] = chip->read_byte(mtd);
+
+		for (byte = 0; byte < ONFI_UNIQUE_ID_LEN; byte++) {
+			u8 lo = raw_id[byte];
+			u8 hi = raw_id[byte + ONFI_UNIQUE_ID_LEN];
+
+			if ((lo ^ hi) != 0xff)
+				break;
+		}
+
+		if (byte == ONFI_UNIQUE_ID_LEN) {
+			copy_len = min_t(unsigned int, len, ONFI_UNIQUE_ID_LEN);
+
+			if (len)
+				memcpy(out, raw_id, copy_len);
+
+			ret = 0;
+			goto out;
+		}
+	}
+
+out:
+	nand_release_device(mtd);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nand_onfi_read_unique_id);
+
 /**
  * nand_setup_data_interface - Setup the best data interface and timings
  * @chip: The NAND chip
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 3e80b134063..87083c34aed 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -88,6 +88,7 @@ void nand_wait_ready(struct mtd_info *mtd);
 #define NAND_CMD_READID		0x90
 #define NAND_CMD_ERASE2		0xd0
 #define NAND_CMD_PARAM		0xec
+#define NAND_CMD_UNIQUE_ID	0xed
 #define NAND_CMD_GET_FEATURES	0xee
 #define NAND_CMD_SET_FEATURES	0xef
 #define NAND_CMD_RESET		0xff
@@ -409,6 +410,10 @@ struct onfi_ext_param_page {
 	 */
 } __packed;
 
+/* ONFI unique ID */
+#define ONFI_UNIQUE_ID_LEN 16
+#define ONFI_UNIQUE_ID_COPIES 16
+
 struct jedec_ecc_info {
 	u8 ecc_bits;
 	u8 codeword_size;
@@ -1385,4 +1390,7 @@ int nand_write_data_op(struct nand_chip *chip, const void *buf,
 /* Default extended ID decoding function */
 void nand_decode_ext_id(struct nand_chip *chip);
 
+int nand_onfi_read_unique_id(struct nand_chip *chip, void *buf,
+			     unsigned int len);
+
 #endif /* __LINUX_MTD_RAWNAND_H */
-- 
2.51.0

