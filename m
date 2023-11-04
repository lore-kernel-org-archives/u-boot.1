Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6820C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 12:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D9C687007;
	Sat,  4 Nov 2023 13:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PLxaJkFP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FA2287126; Sat,  4 Nov 2023 07:23:14 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0CF787114
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 07:23:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=iuncuim@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c6ef6c1ec2so33703741fa.2
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 23:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699078991; x=1699683791; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ti6a2HRiekjPyKR5d1tRbkB1lFn/8+EM4KKrySEwuXQ=;
 b=PLxaJkFPeMx5HRcl8Xn/yr7Sk/YU3LtqoULTHiq19mWXyxBj/zT8DJUPZkWe3Tc6ZI
 7za1SGQx6wJI1Nakfjxbnlq1TsSsanDNTJN4zOu6VfwzVEwihT1P6N+2hf6oMiNhmjl1
 VRc/pYYLHcFoSAdWTxmXCJ/QqpBClwp2OUlhI7MIlDAXtj0zHZ/rBtFUbTTN1CE4FRY7
 3TDRCwi0e8GZXeFyVPIq4N6u+MiY7pAe4OLTb2V/ueQMj/lUKGDcbh0XlE7HLQZTHUFF
 bc1UAkNQBHmxYo4Ch9fRu+exGH+Nd4rgPFVkUg14LGB+MZ7Vxd+lZQ3Ya7lKnr5bxCzd
 kYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699078991; x=1699683791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ti6a2HRiekjPyKR5d1tRbkB1lFn/8+EM4KKrySEwuXQ=;
 b=gLi7uLVRwSQRsYOcUwrm9X1ukAOpac9XBC6PmWJYAsbit8SssQZpFJ7uvaxFLlmEbU
 0R5gnJ4DxARTQI4O9x473InPL2xHNBNUcccIPxXWp73pSlosdPiSfV/eLGto+nm+XzTE
 1nvdmXAyEWGR8taMPksLcEjnFEdl9pnJTl+IrletL4r7HwQjjE3DyEZttLS5IUhHQ87g
 mbIzRObZOZJ2cFtcglGEed/KrM7uYjbbf4p19aDRX1tlL3QdH/NSNz3QeTgMxFZ1tIss
 YpiPggxTrrZ6z0aoqCWUy40KHcvD8qU7fIxmjvcQ1tNcvmL901v4h44vdNnz67P50b1S
 KDeQ==
X-Gm-Message-State: AOJu0Yxdf3bXu/2arB4Hd+c3YNVkGlQU94i+7vZbNybMpADa9ebd4gLZ
 yRS+GzipMbaOsm8XQJqudOQ=
X-Google-Smtp-Source: AGHT+IG0JkrUOKMUvMSTxUB2BYr+x7nz0jZWIj/mEcbZ9+F7VNaOueqc69vPOtLOzhcLh+uaOgU+xA==
X-Received: by 2002:a2e:b0e5:0:b0:2c5:2813:5538 with SMTP id
 h5-20020a2eb0e5000000b002c528135538mr18361648ljl.21.1699078990891; 
 Fri, 03 Nov 2023 23:23:10 -0700 (PDT)
Received: from SerialExperiment.lan ([46.251.193.172])
 by smtp.gmail.com with ESMTPSA id
 b18-20020a05651c033200b002bcdbfe36a1sm426123ljp.84.2023.11.03.23.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 23:23:10 -0700 (PDT)
From: Mikhail Kalashnikov <iuncuim@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v3 0/1] sunxi: H616: add LPDDR4 support
Date: Sat,  4 Nov 2023 09:22:47 +0300
Message-ID: <20231104062248.32938-1-iuncuim@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 04 Nov 2023 13:20:38 +0100
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

From: iuncuim <iuncuim@gmail.com>

At the moment, the driver only supports DDR3 and LPDDR3 memory.
Add support for a new type DRAM.
These changes have been successfully tested by me with orangepi
zero3 4GB (DRAM: Rayson RS1G32LO4D2BDS-53BT).
This patch should be applied after this:
https://lore.kernel.org/all/20231014170236.16211-1-andre.przywara@arm.com/

Changes from v2:
 * added default value for TPR6 parameter
 * added panic for unsupported DRAM types in switch/case conditions
 * added new line at the end of the timings file, changed the description
 * added a few small missing parts obtained from boot0
https://lore.kernel.org/u-boot/20231016053441.3197087-2-iuncuim@gmail.com/

Changes from v1:
 * replaced the phy_init array with one compatible with opizero3
 * added DRAM TPR6 parameter
 * adaptation to new mctl_phy_configure_odt()
 * added timings for the board orangepi zero3 4GB 
https://lore.kernel.org/u-boot/20230729111331.173768-2-iuncuim@gmail.com/

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

iuncuim (1):
  sunxi: H616: add LPDDR4 DRAM support

 .../include/asm/arch-sunxi/dram_sun50i_h616.h |   2 +
 arch/arm/mach-sunxi/Kconfig                   |  17 ++
 arch/arm/mach-sunxi/dram_sun50i_h616.c        | 197 ++++++++++++++----
 arch/arm/mach-sunxi/dram_timings/Makefile     |   1 +
 .../dram_timings/h616_lpddr4_2133.c           |  95 +++++++++
 5 files changed, 277 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c

-- 
2.42.0

