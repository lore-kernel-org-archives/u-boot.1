Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34289C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 17:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A9280BAE;
	Wed,  4 Jun 2025 19:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WnZCYIfG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EED98006D; Wed,  4 Jun 2025 19:03:15 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CCBC80584
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 19:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a375e72473so34269f8f.0
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 10:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749056593; x=1749661393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nVfoGVeQ6qCGbS7DSKuaCP6Umf2tK3Lq50KWIm8F4ho=;
 b=WnZCYIfGwFo+l98BReCXEsHqULWBfBJ9qvMP5BAhziiCal9WMYxM7aM8E0VCtR94FD
 voTVxUdM2gP+fF149v2mXKR7uwUXrz+IU9uN/kr6AjnWnc4Fwpv2gSflBo5HL0t2a0pd
 FkXrvLzhu2d5655salNPfs+gckBJcLsC596snYi/Erz/DtyRGpTihj0ZPKZSRxXSyGYP
 M8eoXH03yn1LghIoIH6y7un7xM6TA38wk2dTqKcXfEqDGPCPQRatI420oNn2RsC519oI
 Ab6Ffw7ccNNBAUY7WEnO+3tT1hl6andQE8iF4Pzr9hIkxKkHrIQpNV7h8PBCAsX2Cez+
 yNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749056593; x=1749661393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVfoGVeQ6qCGbS7DSKuaCP6Umf2tK3Lq50KWIm8F4ho=;
 b=egWRqNehCH3xVqjmpbl0aKEXmTfHlD2b0RkFLXwL49z1j1PEfsetcp3WJFF6hrBrF+
 JpnYUUEoSLqJuQrjot835ngPFu1rsaK9r8HcVHxW4j/z3c2kyNnM4p9imXd7TikBQvDY
 tR1zUwb4rKJVWg4uRlwOtdNsf1KFOH+W6Nq0AV7JeXVT4jD8fHdVKygYcVrAby9U+uNm
 Wx23agkl6EQPXRpSlBogBk2gcxaymctCK1RVGLeycov1jB2X14IbyI/2PK5ARP0WfIyp
 zctHg78E8Vg1AYUcs7g3N9XT6oRz99Sg1ahLpzYcNxXz3whkSSJ9+fbaFDQMEG2SqXz/
 eEqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTLDH4/znU3Fhn2SzNVXtgVQqoAYoicDL3Ih5DWasBLFr8z5vbo96Af903CrzVtPwawv9Hc88=@lists.denx.de
X-Gm-Message-State: AOJu0YwiX8bt8K9LZwipJyg0jsG964tfNcvXHZiRaWwPJn5Pw5M95ljM
 /4kDZrwq1A/hY157W6MCuXgw9KDlyqrgQRQbIVrA9vTXXf8mHU4iyAAK
X-Gm-Gg: ASbGncuR4Eg+F66SF9Nhmnl4X7+Ja+NJ8YfgXY4oacDSgqqofVeEPPS4k8XLAM9X2XB
 dQ599gFasKTw4/9I6xqVqyv7BxNfSjnTVoI9UuSJIBwF57TFbczUkk62aZhl2LP/+kzcatWKaoz
 dhWbh8U1HLRfS9npKSMb3ovpUk0IublKo/3vJHP+bwovJYR4NNk7ymSZHy/le78mzYtuuVKnmFJ
 HDqIhpO601bRkoIeDfh0MVwfpoJbdIfVXAkiM+Lr50/LwaEOPUf3d98eztYlVBT23LiRwZXYfOz
 2rKXPULibr6QDYlmlFCvQEjOv+GQFNXOIwUAs4byDn7VEAGGeE/zXqD7mZVBXsoTrwYY9k7RrLD
 Q5jliV2gfYuTDRabv9fEsZDmDlvL6JvM=
X-Google-Smtp-Source: AGHT+IEXczcJEmFMKYFo4ZdNRlN9done/eXpG2XBl0mZufVNIKDoi7IRvAgh4J8IHFbP6IsdccS5Hw==
X-Received: by 2002:a05:6000:250d:b0:3a4:dfc2:2a3e with SMTP id
 ffacd0b85a97d-3a51dc316a7mr3359748f8f.39.1749056592337; 
 Wed, 04 Jun 2025 10:03:12 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00a13fasm22608825f8f.98.2025.06.04.10.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 10:03:11 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 2/2] mtd: spinand: winbond: add Winbond W25N04KV flash
 support
Date: Wed,  4 Jun 2025 19:02:39 +0200
Message-ID: <20250604170246.5354-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250604170246.5354-1-ansuelsmth@gmail.com>
References: <20250604170246.5354-1-ansuelsmth@gmail.com>
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

Add Winbond W25N04KV flash support that use a different value to detect
ECC bitflip.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/nand/spi/winbond.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index dd4ed257a83..16abf89dbbf 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #endif
+#include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 
@@ -18,6 +19,8 @@
 
 #define WINBOND_CFG_BUF_READ		BIT(3)
 
+#define W25N04KV_STATUS_ECC_5_8_BITFLIPS FIELD_PREP_CONST(STATUS_ECC_MASK, 0x3)
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
@@ -121,6 +124,7 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 		return -EBADMSG;
 
 	case STATUS_ECC_HAS_BITFLIPS:
+	case W25N04KV_STATUS_ECC_5_8_BITFLIPS:
 		/*
 		 * Let's try to retrieve the real maximum number of bitflips
 		 * in order to avoid forcing the wear-leveling layer to move
@@ -172,6 +176,15 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N04KV",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
 };
 
 static int winbond_spinand_init(struct spinand_device *spinand)
-- 
2.48.1

