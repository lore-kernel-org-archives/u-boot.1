Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D176C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 21:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAFEE82B95;
	Sat,  7 Jun 2025 23:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d/cb3+OK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D5A1811AC; Sat,  7 Jun 2025 23:12:12 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14B9A8059D
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 23:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso2910909f8f.1
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749330729; x=1749935529; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nVfoGVeQ6qCGbS7DSKuaCP6Umf2tK3Lq50KWIm8F4ho=;
 b=d/cb3+OKN9PcrIB25jFgznZgym1R9RLHtPHFX0saNpw6YYFvGBD6Rr5YqeK/BmW72w
 Ob2i7GBLz8T5oF9VE1oHHwqlSUFxFOUnrKdgiaiZ6B6CrqbopsQmc62z9QfAiEsinICn
 RG1NIAP0+sA4m3lH9Z27MZfIaglm/jIGLQvLgFgaei19pa+hDnVo4i9PJUl78ikDXUSh
 i7yEa+cUL7kHQxwxqXHywjOHuVE6bHtO9Z4BQ4VfQ/7X9yJOW6a39z6TGbZyrQ0+pm9Q
 BotmFwq2+xFTUQpUUsgLvs0EEB7AHrYxrJ+zxreWHx5GKtvfFFKJMF51qcpwZyO7zCBX
 WKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749330729; x=1749935529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVfoGVeQ6qCGbS7DSKuaCP6Umf2tK3Lq50KWIm8F4ho=;
 b=RrD4ScqnaEfwP2BR454Kfj2J84c3piZs7lhkknTcQVbpJZfShLYFGRLWwVbMdVfuWu
 FBSubVSB9PBaVI7rVSjAhPDnmR63Ws3UR0dbLGo924ZsAJ+u0LMhlUJPbS31ojuH+7cl
 Z6udmGjKejXVhJe1j2rI8tjQck4R+Ynzs9EmRUMrEyh0VZ/8RRhTGQqK0n5iPaEM8ejH
 P6EkfCynRYKwqxdkIaG/9tvoIBcYMuEd8jGP8giGAHN9ei4jNNiIi5mWcKd2x8K7VPFz
 6EWsw1YyNIB8EBq3V6pqdX3t2iTl8s+KDFlLsz3mkVQk3AgHzG+76oVWbhqOhIXl6t7u
 Topg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDh3zpAZP3envkkttVO+CMvgf+DPY3HaJEdnErc5clPDScriAVKEPghgdWF/OkDee7bOi/wbw=@lists.denx.de
X-Gm-Message-State: AOJu0YwmL/jWsMdQrJswN8Yx+pLj6QoFgmi1m6OkMYoGpraRks0f1pJV
 uG1LDbKxmrXKxgJxNB71MTkZuXaxLEFSepqtZ03oEkPwP41epDDDybrn
X-Gm-Gg: ASbGncuyFf0zPOIo8Ix0ZwU54JlpDMl0bzuuOLQkJgSPIdQZlbayEldLaf2B8qIaPfM
 qP5UKFRAoI/1CbH/0wKLr3gv630DuI92MSokGKyfLUg4nnyfyGd3yHtwy/pqXje1WibQQ+J72Im
 fzwSP38AhdTaphCmEfci1uKhwPrYwTPdbjl3YBo7JYET2M0IE7TqLDzQw86ch2LBVPyqxyzIJ+9
 mg2zBaIUpLrSuAo43Obf4QKecR9K+vqvmxY9HbHDonIh6GxtiVu3hIiPr6QVan2ssL8qKRFrEXN
 3qzwvOomW+NCIGVuw5cBq4WnrNrVx/AWGSeaYuMJS/0/fTKutl4hacMfoPITvP30ZO+YvIQjyAm
 v5bfmQtDjJ4WISEfb5XDJgpXSBn8sGr0=
X-Google-Smtp-Source: AGHT+IEov3l01n70T1Kij7U12oPm67ij3VgXVJkRwNXXjwdDOaxoJ25b2Vf6YmNmuI+TPgNJobaK4g==
X-Received: by 2002:a05:6000:4285:b0:3a5:2599:4178 with SMTP id
 ffacd0b85a97d-3a53188da4amr5881530f8f.19.1749330729432; 
 Sat, 07 Jun 2025 14:12:09 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4526e155ce7sm64368245e9.10.2025.06.07.14.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 14:12:09 -0700 (PDT)
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
Subject: [PATCH v4 5/5] mtd: spinand: winbond: add Winbond W25N04KV flash
 support
Date: Sat,  7 Jun 2025 23:11:21 +0200
Message-ID: <20250607211133.2005-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250607211133.2005-1-ansuelsmth@gmail.com>
References: <20250607211133.2005-1-ansuelsmth@gmail.com>
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

