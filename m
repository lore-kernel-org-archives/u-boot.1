Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B63FA3741
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 13:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE98A84239;
	Fri,  2 Jan 2026 14:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V/6dtPoz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E4108423C; Fri,  2 Jan 2026 14:25:15 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50A7284227
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 14:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ray.xy.liu@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-29f30233d8aso140003145ad.0
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 05:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767360312; x=1767965112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yaK4oioUnn2lPC5/T+O4lumCb4F5/sf2n0NfzFsUor8=;
 b=V/6dtPozzNu07KJe3yqmKL0BeytfwMlsnvaHZGkat4zfM0Nrukpz1DGrpJA75wxX4N
 0Wp0DCUjNYxt0jp6LEXOYO5hC0nW0CNKTPTj1xYQ2QVXM5h52D3GFDqzPfTn3mGQX5Ne
 zImqev7ERwNZoqA6NWtTuP2sgz5skcvHgGMtN45mAd9dketz9jmq5b6O6RWXUOa23Lwc
 DaO82K2SGeaFj3TKDcDHe2c/W8PX7ag660xOo4N7kPrhAWmujCIO/ZYHADvDVflgdDtn
 5RF6cbid0RQ8bE+cRhkUcTGV0h5TcfJmKSbKDsouA3GQ2Di3wuP9O2ESeRdp3MhHPjPq
 kgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767360312; x=1767965112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaK4oioUnn2lPC5/T+O4lumCb4F5/sf2n0NfzFsUor8=;
 b=eymxXqGfMPAeA+cmCuh9ixHtl9X/KD7vIh1hS217aS1MYgbV3Sbf8gTFFhhpHMflLq
 OF39qxprNx5qTGcbMW3gsd/UCJIGdu0r9xhr2hIJVyiSMGI8eCuD/dp+amLlSpM5DZAu
 FShrizD8U7Fh7nDwik9zqvhNVoxJhdsDM4M204eW3CJf1nzImFJ1yH9ev9HryzvvV3QX
 5zReG0ZO0sZCF1Oev2Lt+uLV3UBRYahtmcjgQaJ7+qGYyqXBCtBuL8ubjleKQTE17aU4
 s3m+eLPejIw/ps4V/5z/ZMPI9V7zmfP8UxMUE8Zsi1ZzwP77XtbJxMIvKu+tJLpmBsTE
 LNGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOt905Y2pJqoxDze+pfhcQ1ItNRqIdEvm1mvEScT70dWgF3VehUDuyk+B/iLLAkIiMbaPLuIE=@lists.denx.de
X-Gm-Message-State: AOJu0YwwqJmrXYl5W5okKPiewxyC7B1U63icwIVZMTIqQfot4QaeKpl1
 WYZZY6mf0BRBZn72vr2HucYh3QoO9XDJdlxo+fA/V7Npj2ZWazru3uSt
X-Gm-Gg: AY/fxX5nQd1k5D6/nSsYMGhO3V+Y8SHO+Jzj5ROU3UY5yBB2iydWHaYx4PgJJuHQz6k
 dNEZIRP8h0crnx3KCRDBY8IqANBZ7TQS0QuZxGV66U7M29NLUlnHRdkcni/AZegFZ1CdS3rBqEP
 ZGknWWA/EW5luXAXnzHobKrPLC2v7HdnXX3ZHsF0XYe/+f3gkCL1ycYhu7XO6FrDT6HhMH7Hv24
 /u4R7n6Hbf39PbdtT34T3Y2JhmpZWD/2kDfldkPozuL/hfkKzvheHutOWMSqwBZREQWmfwxlBzb
 nckKCON4cP7XkqyJKA/FmYpj/S44k5s+aN/q/NVd2kuF9R1/NCFkcaZfWXwJzwRG++FLC3ncfFM
 3ZMgbdSSpiPopGm/eOEuP7EfCaWuoZ+Luiur8VzZBxtebhhGomf8UJn1WC2mB9s3oT4VvnaA2cD
 WI2GIf8VcBZmjZ4pbodz7dAyLlRopFAEa4yet5tFZZuxYOVYyywhp5Je0zTMZB
X-Google-Smtp-Source: AGHT+IF0sWbUjUQNP5BfSY/yZjV9EZ3g1jBIyx339iXVy8/VpbtaWf9irTMDEeiVcF+vG/FA5E6pWw==
X-Received: by 2002:a17:902:d4cd:b0:2a0:8ca7:69de with SMTP id
 d9443c01a7336-2a2f2830566mr404885255ad.41.1767360311547; 
 Fri, 02 Jan 2026 05:25:11 -0800 (PST)
Received: from DESKTOP-ITE2KEP.localdomain (1-34-52-164.hinet-ip.hinet.net.
 [1.34.52.164]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c66829sm381939285ad.10.2026.01.02.05.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 05:25:11 -0800 (PST)
From: Ray Liu <ray.xy.liu@gmail.com>
To: ansuelsmth@gmail.com
Cc: trini@konsulko.com, u-boot@lists.denx.de, Ray Liu <ray.xy.liu@gmail.com>
Subject: [PATCH] arm: dts: an7581: set r_smpl for MMC in U-Boot
Date: Fri,  2 Jan 2026 21:25:00 +0800
Message-Id: <20260102132500.5794-1-ray.xy.liu@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Jan 2026 14:28:54 +0100
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

When booting from SPI, the ROM code does not initialize the MMC
controller on AN7581. As a result, the first MMC initialization
is performed by U-Boot.

In this case, the r_smpl bit is left uninitialized, which may
cause incorrect sampling timing during early MMC access.

Set the r_smpl bit explicitly in the U-Boot device tree to ensure
reliable MMC initialization.

This change is limited to the U-Boot-specific device tree.
The Linux MMC driver already performs runtime delay detection
and does not require a fixed r_smpl setting.

Signed-off-by: Ray Liu <ray.xy.liu@gmail.com>
---
 arch/arm/dts/an7581-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
index a9297ca6503..7fc71d471c4 100644
--- a/arch/arm/dts/an7581-u-boot.dtsi
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -84,6 +84,7 @@
 			reg = <0x0 0x1fa0e000 0x0 0x1000>,
 				<0x0 0x1fa0c000 0x0 0x60>;
 			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			r_smpl = <1>;
 			clocks = <&scuclk EN7581_CLK_EMMC>, <&clk25m>;
 			clock-names = "source", "hclk";
 			bus-width = <4>;
-- 
2.34.1

