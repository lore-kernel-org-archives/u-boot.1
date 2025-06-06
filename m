Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0BCC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 07:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A13A82B0F;
	Fri,  6 Jun 2025 09:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P2mRsDyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 506F282977; Fri,  6 Jun 2025 09:22:14 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67DEB81FEE
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 09:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-442eb5d143eso16553685e9.0
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749194532; x=1749799332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nVfoGVeQ6qCGbS7DSKuaCP6Umf2tK3Lq50KWIm8F4ho=;
 b=P2mRsDydT2jKu7eKxmQEWBiASMBFKip7lEWep4hEtX8niwZZeP9T6G8HFdlUSi0Bzr
 r2dX4ppzF9/BXCHiveCHDZTdKw0bVtqC0eSCk6s+FKt9W4tI7OpTWTxuJ2gqnDmKbizA
 TlAYNaPeMzlYKDoOI8Fdtv67mCjMn7Jl0JX6CqK0+czkcdlDbx6SJC0t1W1c0wBcaa+1
 TMwk1dV7T1UJECdeCTYcCSo88JJpoqYqrxV4U62A+yqJUMvTEPlcTAxGdurWB1+F5AdM
 SEWf80Mg1SMCr+UeQVfB48JKs7sgRSlfpn/phuXB+UyXvjoPrbfNzfwHJyROVbURM7SM
 wnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749194532; x=1749799332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVfoGVeQ6qCGbS7DSKuaCP6Umf2tK3Lq50KWIm8F4ho=;
 b=UF9kUsbqsQRnHW1jDvCRh2gHvZsVSpmzz67hhdjn6FCjY7Aaku2bXPxjeYHNCaVkml
 zVXLZ5SKfy1RlJqNihEKUHrz8HtAmNE+eYnM1biBDTWhJ14Idit1oEtPpPUQmEiae4m5
 hxLgJdkpetbYUCKqShH5LriMpDf1Ym+TevJRVGGCGvCH/Vi5nC1IjcWwvyVlpA6f6WHw
 gQ6L4cnb3uI79CYT+oBV+wsdpH7NWivTe53scc/+bNJwEI4qd/JeH/FvstvpSUbsiMwG
 pN6loX+WbdfqOJoW9XSrRmw79R2WptgbOQHSMr8gm+p4rLo2dtEBBbAJms/3E5TTf/eD
 bDlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu35Cxpfc/fT4kPz3zcIrT8wnZXgvrcmYfedosn0cANyq5JJTl8n6AgIXC9KIxYUCCOWQcw5w=@lists.denx.de
X-Gm-Message-State: AOJu0Yyd3mRC/mOKyrnYs7Yr9K2WklCOoygPkn4r0nM8F7S9mQ9KU3Cf
 QfLwOTkoN4jrt0uAmoi/VzU7t1/oWaG5syPbX2G/5PgE5lEaA4OHYPvl
X-Gm-Gg: ASbGncsagRW+AnlxsxJW3UZvXNqCHW+k+F6wOi1hvJK1IW0YobpAmEVEHWg4bv/Ixbi
 SXOrVAeRoDTpW6RAaKfTYW/JjhDbMTVr/P8m2TNtu9yAphsIIOaGhhJ1lhhrqVjd6nyEgdZrX/Y
 7pkEZIEK+W5BLENmO6Uv0oq6TTx5cD+Bw0XCPnKztKjlnYnPqF0OTvXhQA+Gx6C69JUik8Th4+Y
 touduX6481xGxWhT5O/L5os1ZFP8l3uXM8vr28WC4XSn1mxTCI2krABWUjVZwhsYj0cphmsMNc8
 DwdPxj+DqXikgCMFiZkDY89Tn/duH9kLjTyZN7sVI3OPVM9779NDMzrLBlViQfNrih9WByZYzHQ
 mr9H3+2ApuZ1NJuAblpSpA5OfWehCO1U=
X-Google-Smtp-Source: AGHT+IFn0bUMsb7ZqGeISv7VrN2eqkNI3hd+Y7qLIOfPmhXVjWZzAkerDCpnXqhmQw4ThpZlKdzw/w==
X-Received: by 2002:a5d:4b47:0:b0:3a5:34db:4cfd with SMTP id
 ffacd0b85a97d-3a534db4d97mr569580f8f.7.1749194531804; 
 Fri, 06 Jun 2025 00:22:11 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4521375b5e1sm14666295e9.37.2025.06.06.00.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 00:22:11 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 5/5] mtd: spinand: winbond: add Winbond W25N04KV flash
 support
Date: Fri,  6 Jun 2025 09:21:34 +0200
Message-ID: <20250606072140.18824-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606072140.18824-1-ansuelsmth@gmail.com>
References: <20250606072140.18824-1-ansuelsmth@gmail.com>
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

