Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205E0C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 16:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 874CE83890;
	Tue,  5 Aug 2025 18:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xVcUC3l5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E432838D2; Tue,  5 Aug 2025 18:10:31 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 659668388B
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 18:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4589968e001so36845775e9.0
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754410228; x=1755015028; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sM7of9fLqaaBIzUQe7dxizPxrN7YWtY+qJqZHsjBjbM=;
 b=xVcUC3l5dwmRBJ3k7Cl9nVjDqx5TOQBUFA3lNH6VWr2b2+RpOtFwIw37BEQHboMLUH
 pv/rMojTDaNvGDMm+uU8fFq3edEPlLd7oTJr9qhAJrrHPx4PFnh6VXyS7/ES8NBuwI0r
 HoM64psSEXmKJFF8cIXmqf2I4AHJDzqVF1Al/Xp7EnHxjLGnCUzrEeDAc5zgHhsJGKFd
 3YjZ81Jukt9LSkLvRxNv9KF+ROHTXLszqWeM72OkG9yiaumxtQZIT6YGc9X0dbnCISWk
 LFxM5P8V/8ftgeahfDndI7ZRQWakksRSLRCYcpJMPqEAdqKGIFPHmKC0wPWSstgIQsn5
 euww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754410228; x=1755015028;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sM7of9fLqaaBIzUQe7dxizPxrN7YWtY+qJqZHsjBjbM=;
 b=MrJKYNWHoAXi8O+X7JoKn36ttYGRSq7r/zYoOLLgwhQHfPX5AWuajSVrC5lofNkbTW
 6UEcCHkFad1rEk/5ZcSmwzliFike0N9CM1tLJhY83WhFAF6HU0r9GKc14yzBKxTcOA14
 QYAakwhwdrS4fNWY72M//Jsjcav3xCDE8ByCxM1Sbd+B/nV3PHHkbotauBiMdafrYOU/
 YMZ9K1tYCF/tkSGaVwsm+kLcbI16DL+3ciCV+w1hJQc49J/Es6SGHo4+7XqihZB0heyM
 qKSlFBDYJl7Yp/8DKaqnLEQa3EgRTrgBt/bY8ZTgZCoaNN2ikggesTVjaghykst0QYMU
 g9tw==
X-Gm-Message-State: AOJu0Yxq1Vw0rrp3+3hgEq8RjA77cFfT2hLzUDijU5fP0tAt7+VGbyqa
 ZIAmCgvwmtHRpnYV8vn9jlKD+ziIKnWfIPDajtRVw1fOs499oLh9YI3loZFzFpBL8i5nd56uJ1/
 Kmj2E
X-Gm-Gg: ASbGncuYckafCBSIJ75rK+IaocIQHMb7yb5BZWeRNfO5q31nTouYjuxpIrcXAGGK2Xw
 Huy4gcIQziHUfB9Ry6ZRIE0UJ8ECKGoDAI7nWIcO9ECcXgVNjXP91Uypb9a/oQ/ydqDniA4s3R3
 YNVaFGUnvLAgQ99wswnHOIZEb2xzBSZIpWqYTR0Rr4vPKegL3tKVnhJA1I3zWx2XVVD7vbHNrik
 KOl4qnJG5jzwgVXeNe8Op2W79T0pYDe7cN9vSenpCYDt8ZiS342JQuvgpxvrnMtoUCTELLYQLz/
 2KPfD7k5UquhxSimtaOSUidB4R8ALgd9zbICTr/a2r4rINsNEX46hlbVfygb9SJUzuZR/7d3j0q
 sCQTCpiDutM4Vee6703ghHFt4cxxq0msLwDUyYB4gNEjyTeW0Ao4=
X-Google-Smtp-Source: AGHT+IE5RA7mw/lc+IbhkoMc2XocY/hv85a0H9oXOdWOu8dC3ZbdUGsYcK/tUDZQrEFBVGnYAvHIrg==
X-Received: by 2002:a05:6000:2289:b0:3b7:8d80:e382 with SMTP id
 ffacd0b85a97d-3b8d94698f1mr9853982f8f.4.1754410227757; 
 Tue, 05 Aug 2025 09:10:27 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c469582sm19439472f8f.52.2025.08.05.09.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 09:10:27 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 05 Aug 2025 17:10:26 +0100
Subject: [PATCH] net: phy: cortina: Ensure memory allocated is freed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-net_cortina-v1-1-5a3faca0ad2a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPEskmgC/x2N0QqDMAwAf0XyvELtVGS/ImOkbaZ5WJSkjIH47
 9Y9HsdxOxgpk8Gj2UHpy8arVGhvDaQFZSbHuTIEH3o/+t4JlVdatbCgG6jNd5/jEHIHtYho5KK
 ipOVqPmiF9BKb0pt//830PI4Tf3ionXYAAAA=
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

In cs4340_upload_firmware a buffer is allocated with malloc but this is
never freed. The pointer to this buffer, addr, is not even kept
unchanged. But in some cases addr is not a buffer allocated by malloc.
Introduce the use of another pointer to keep track of the buffer and to
know if it needs to be freed.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/phy/cortina.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/cortina.c b/drivers/net/phy/cortina.c
index be480ecef6c..dec024844b5 100644
--- a/drivers/net/phy/cortina.c
+++ b/drivers/net/phy/cortina.c
@@ -135,6 +135,7 @@ void cs4340_upload_firmware(struct phy_device *phydev)
 	int i, line_cnt = 0, column_cnt = 0;
 	struct cortina_reg_config fw_temp;
 	char *addr = NULL;
+	char *to_be_freed = NULL;
 	ulong cortina_fw_addr = (ulong)cs4340_get_fw_addr();
 
 #ifdef CONFIG_TFABOOT
@@ -147,6 +148,7 @@ void cs4340_upload_firmware(struct phy_device *phydev)
 		size_t fw_length = CONFIG_CORTINA_FW_LENGTH;
 
 		addr = malloc(CONFIG_CORTINA_FW_LENGTH);
+		to_be_freed = addr;
 		ret = nand_read(get_nand_dev_by_index(0),
 					   (loff_t)cortina_fw_addr,	&fw_length, (u_char *)addr);
 		if (ret == -EUCLEAN) {
@@ -158,6 +160,7 @@ void cs4340_upload_firmware(struct phy_device *phydev)
 		struct spi_flash *ucode_flash;
 
 		addr = malloc(CONFIG_CORTINA_FW_LENGTH);
+		to_be_freed = addr;
 		ucode_flash = spi_flash_probe(CONFIG_SF_DEFAULT_BUS, CONFIG_SF_DEFAULT_CS,
 									 CONFIG_SF_DEFAULT_SPEED, CONFIG_SF_DEFAULT_MODE);
 		if (!ucode_flash) {
@@ -179,6 +182,7 @@ void cs4340_upload_firmware(struct phy_device *phydev)
 			puts("Failed to find MMC device for Cortina ucode\n");
 		} else {
 			addr = malloc(CONFIG_CORTINA_FW_LENGTH);
+			to_be_freed = addr;
 			printf("MMC read: dev # %u, block # %u, count %u ...\n",
 				  dev, blk, cnt);
 			mmc_init(mmc);
@@ -199,6 +203,7 @@ void cs4340_upload_firmware(struct phy_device *phydev)
 	size_t fw_length = CONFIG_CORTINA_FW_LENGTH;
 
 	addr = malloc(CONFIG_CORTINA_FW_LENGTH);
+	to_be_freed = addr;
 	ret = nand_read(get_nand_dev_by_index(0),
 			(loff_t)cortina_fw_addr,
 			&fw_length, (u_char *)addr);
@@ -211,6 +216,7 @@ void cs4340_upload_firmware(struct phy_device *phydev)
 	struct spi_flash *ucode_flash;
 
 	addr = malloc(CONFIG_CORTINA_FW_LENGTH);
+	to_be_freed = addr;
 	ucode_flash = spi_flash_probe(CONFIG_SF_DEFAULT_BUS, CONFIG_SF_DEFAULT_CS,
 				CONFIG_SF_DEFAULT_SPEED, CONFIG_SF_DEFAULT_MODE);
 	if (!ucode_flash) {
@@ -232,6 +238,7 @@ void cs4340_upload_firmware(struct phy_device *phydev)
 		puts("Failed to find MMC device for Cortina ucode\n");
 	} else {
 		addr = malloc(CONFIG_CORTINA_FW_LENGTH);
+		to_be_freed = addr;
 		printf("MMC read: dev # %u, block # %u, count %u ...\n",
 		       dev, blk, cnt);
 		mmc_init(mmc);
@@ -280,6 +287,8 @@ void cs4340_upload_firmware(struct phy_device *phydev)
 				     0xffff;
 		phy_write(phydev, 0x00, fw_temp.reg_addr, fw_temp.reg_value);
 	}
+	if (to_be_freed)
+		free(to_be_freed);
 }
 #endif
 

---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250805-net_cortina-6e1d30db62d4

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

