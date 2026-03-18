Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F131077610
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 20:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A73A583642;
	Wed, 18 Mar 2026 21:09:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IK7NZ504";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA567836D3; Wed, 18 Mar 2026 21:09:18 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D6C836D3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 21:09:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=flaviu.nistor@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso2354675e9.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773864556; x=1774469356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ENgLRmSPUNZBn9FcGONvJNg+bxmVVRkZNvZdr75a5jE=;
 b=IK7NZ504JA89OQqwBhqbHfG/wlVqA9BplEW6g5BouLg65tQxNsKMr6fOiuOPuwz95K
 FjgQpEzE2xlxIBWt+VzxehgkdDc0WjaZhtz+1Ffit/l4I5uVlRfNOju6+PIzA6IP2Epx
 HhdKt3nYd0G3yc2RquHqsWIhzHGgazg5FY7dMILgadcO1hqUu9Y+Q14jfT3H+YUQUHbI
 rXa/hoowmfUra1YPIoAgmdjwjBT8iggAbVfJgZnjCPi7xh0BXVFVbyxlmooAGZusLIaa
 1wbFhtLbXyc+C8v31YL9/cojmLML7Sq40unSF2ibtLmg1vfLSX+iEyj1Qk3wyspDL37A
 2ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773864556; x=1774469356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ENgLRmSPUNZBn9FcGONvJNg+bxmVVRkZNvZdr75a5jE=;
 b=DufWM117740u7p1DIZA90YDgBJTfrZOYrb6QXV8KZtWLsmhvvrHjF3BxndX0sWbkW9
 Ac5UVYusgKcCgUivctW5HB1PVgiIF+1VFPB0CR0295DiAYjwLu2Ny9rP/7a6W4cOO3vD
 8/tfbny0coCZixQ3D8yUZM4bHT2sU8Hlf2sdiPETe7cvzC3lznC1ujFOXYGOtBgsFNZu
 HJ8djKZsCg9/gxr8FVmBYNZlcN5DrL7grHMZGahjqALSjU/R+ZlI0yaz8/kJuFxoqVb6
 PcJbtemwg7SRzt9J+5M3fMe1R9MWk+B5vRmNyXPKKau3Wiq+4TMmeydo3cAExeo30ENM
 ch9A==
X-Gm-Message-State: AOJu0Yz9F9dw2mRqbur67d3r49ov2kzNW/jHCZjXHgmq20R0xwhCjqoC
 TvgIsCzqueQT3dhoGbIvM3ZZEFo6ZpjtHvB5YAMWg4SCGFDlDxb5b725eKqj1ZC2
X-Gm-Gg: ATEYQzwdmzmiAnuL+7XO9r2+nH3K25/i3QXfaXNU1Btt0JxAXAi5X7IGILRfzziShZr
 RtRuPfy+Ckkl09Df9FE/uYfT/w8zNfOYd4okkjVQNwgpv/xaFAYsAcyljsTRr1AMRdWO14oh7py
 qvjlgvLWk4ycHn+o+ZlW1pAOHTFrH+KTiPo+enAq7ayQ4qP6h3oUD4CC0FgKO/HoGaUMd1oVoAu
 14yQBNInuMWMXnVveIANPgP4xw2Isx6G5ZUXgFxoVoynhYsDZ6zSnX6BpR5LUbAesjKunmOiQQF
 Is6mKR5/QapnCeb+KX+Xvk0NI6A6SSZbkN2lSKJsubhu4zC2itTE44gQTkgUtd0gdzPvNnQnirL
 tBq3g/flthx8FkyBPDDBMfsYB5PNxfmKpiZpL9S7PdK4TYmksQDuBtlMoGT1LqWxYF7hVTDSUmo
 gMVZ1Wrxy3x7LmIq59CUXRncgkonD0Rcaz7B/jMueTnosgJ5MnamluQgT0F+SH0dbaSICACvS7
X-Received: by 2002:a05:600c:4685:b0:485:40c6:f507 with SMTP id
 5b1f17b1804b1-486f456feb6mr80738805e9.30.1773864555942; 
 Wed, 18 Mar 2026 13:09:15 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.232.50])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4e48ad5sm126294495e9.1.2026.03.18.13.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 13:09:15 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: u-boot@lists.denx.de
Cc: Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Christoph Reiter <christoph.reiter@evk.biz>,
 Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Flaviu Nistor <flaviu.nistor@gmail.com>
Subject: [PATCH] mtd: spi-nor: Add is25wx128 and is25lx128 chips
Date: Wed, 18 Mar 2026 22:09:12 +0200
Message-ID: <20260318200912.4550-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Add is25wx128 and is25lx128 ISSI chips to
spi-nor id table.
Both chips have a size of 16MB but is25wx128
is the 1.8V version and is25lx128 is the 3v
version.

Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index e7fea375706..4c31e07930d 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -250,8 +250,12 @@ const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("is25wp01g",  0x9d701b, 0, 64 * 1024, 2048,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("is25wx128",  0x9d5b18, 0, 64 * 1024, 256,
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ) },
 	{ INFO("is25wx256",  0x9d5b19, 0, 128 * 1024, 256,
 			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("is25lx128",  0x9d5a18, 0, 64 * 1024, 256,
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ) },
 	{ INFO("is25lx512",  0x9d5a1a, 0, 64 * 1024, 1024,
 			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB) },
 	{ INFO("is25lp01gg",  0x9d6021, 0, 64 * 1024, 2048,
-- 
2.34.1

