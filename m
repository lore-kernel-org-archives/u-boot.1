Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C265CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 07:26:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E7C482C84;
	Mon, 20 Oct 2025 09:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NX22Kbma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 166C182E34; Mon, 20 Oct 2025 09:25:59 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0C35807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 09:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b4fb8d3a2dbso2787524a12.3
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 00:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760945155; x=1761549955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L2ERHSjVnGzwvcNhEd78rv5nCafPv8BCpkqQS2Hzx8g=;
 b=NX22KbmatUs5Pvac8oSkaLngP7+mQqKGchVcMCenvjn6iljoeMYsEng13sHoL0FIoo
 zgEv5OUhNOEEW0FD7ISYWhg04zGgGV6BxH5+NnpNjXVVDXEmnll0pUQT/GmfqsdFAPN/
 H96Re6qSu0cgYVWbwjE6SxwUMzk7K1rtjGjV/OSYz0yBa37jjt14aIJFufhavMU0A0Uf
 4j5NB2TDKZpNJfdkX5zTufGYXoC+tixsOrE6ifnoTpcUnk1CaR/1OVoZPMIZ40VKZdts
 To9LNRDQjm3t+LrmZh9TU2mvR/8+y/uETd0MoJRUbIEyX9VqBt4rJln/JysZeHL8qJhD
 fUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760945155; x=1761549955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L2ERHSjVnGzwvcNhEd78rv5nCafPv8BCpkqQS2Hzx8g=;
 b=wTKZOU04u6ANEukfnyFBLUe6Wd6+EdDlPabAQ+kVr4m1ghRrXMOmuUzEeIOTDCB1pE
 7Zd6ewutxTl+GMsBzJqpdheS8oYvwSDLOzkxdTIBmZqVcNQIs0QVINurwWq/9d4gj2hb
 HoxgPnyEeKgU63uhtC+Or9lwgPhiY5dcWBDM2nBD/ifDlhaw93KYDt320glcNwpnb9BK
 E6YP3MPa8VVO+ikB1Lkf3vV7xVot11hMlZjqedRTvJealbqnLJKmSWfrnQIdvlJmCH/Y
 QiEv2uVY3w6c+hoHQ8nlM1Lj186dsC4QJ/A19gi7yzlfZXfo3MLyIdCzUsP4PD1+n14E
 u+0g==
X-Gm-Message-State: AOJu0Yz8K22vLWXeyyybL8LJVWDsdMZkMbqwJSCogSiNBD9V70sGvtB0
 4g/Wxnk34KlUv9jUQEgdkcafsavvP9vPJhL3njRYkwCuqS3Y+iol9XpP5eCuWA==
X-Gm-Gg: ASbGnctSYVGr7TFuqrHqjlK6+SzwastV6zheWDWJ0xm7frLLHC0dwq6LwvxnUdttgVo
 Cj8vC4h2If9I7wH37JQrhShQ8RXdVtdsTN8I2myfdhDfnp5KFnKh88f5b9JHIqHlJJpWtj10XJ2
 ZnB3GkAKqzimuIfz3xEzXUpjoqSxTZ07SMODeRpL1LLuqG7qTn5JP6Tq72KwTAYfPz8U/3ArH4l
 1ptJe60QemmDYYDMKgSNEcuIrj+JW9lSxAj0aIxcF3Z7wklqmr8WryGW6EiZxsL6/bT/NMIzB7S
 6h0drWhXnQ/mSNaYSOkAOn9eosOJQnnRO4IEoNuB+MygatDi/yeFUoyZLVe8LGrmypPmUjGEI9t
 oPDXA5nfYpPof6a2mYSlufECbwJ5MhBv6ERRFexSgw8Zwex6p1EBa+XgEuOA6t8Br+Zd6w7LDOA
 L/vvGiS4DOEjCUOAAagqFT8qaOBlw66AGFnOgfVtJIn03zpAOkMg23rTtIb7uY7fr3hJY7
X-Google-Smtp-Source: AGHT+IGWAI1WdqKwqQIcO8DeI8Q1jh9VmzcHG1rWlQgI2WbkL3A155fk3BZXCPSFCmP9zDw/+J8sTA==
X-Received: by 2002:a17:902:db0b:b0:290:b53b:7459 with SMTP id
 d9443c01a7336-290cb65dc2amr143604615ad.56.1760945155201; 
 Mon, 20 Oct 2025 00:25:55 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292471fdcc1sm72150325ad.82.2025.10.20.00.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 00:25:54 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, venkatesh.abbarapu@amd.com,
 Shinsuke.Okada@infineon.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
Subject: [PATCH] mtd: spi-nor: Set address mode in SEMPER flash when SFDP is
 skipped
Date: Mon, 20 Oct 2025 16:25:28 +0900
Message-Id: <20251020072528.10279-1-Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

nor->addr_mode_nbytes is set during SFDP parse. Infineon SEMPER flash
family relies on that parameter to read and write registers. To support
use cases of skipping SFDP, set address mode in device specific setup()
function.

Tested-by: Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 6f352c5c0e2..e382a518a34 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3794,6 +3794,16 @@ static int s25_s28_setup(struct spi_nor *nor, const struct flash_info *info,
 #ifdef CONFIG_SPI_FLASH_BAR
 	return -ENOTSUPP; /* Bank Address Register is not supported */
 #endif
+
+	/* Setup address mode here, in case SFDP is skipped. */
+	if (!nor->addr_mode_nbytes) {
+		ret = set_4byte(nor, nor->info, 1);
+		if (ret)
+			return ret;
+
+		nor->addr_mode_nbytes = 4;
+	}
+
 	/*
 	 * S25FS256T has multiple sector architecture options, with selection of
 	 * count and location of 128KB and 64KB sectors. This driver supports
-- 
2.34.1

