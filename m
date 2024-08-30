Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F7FCA1009
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 15:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69F8188C60;
	Fri, 30 Aug 2024 17:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DRNnOVxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0694588C60; Fri, 30 Aug 2024 17:57:41 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE0F9887F3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 17:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5df9433ac0cso1176601eaf.3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725033457; x=1725638257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ukLIZ9wBp3dobfHrcQQqVVFPCV9I0BtzSNFEmcK/Df4=;
 b=DRNnOVxj+Td7Yk08zlp40er2KqRU3k7aa35IyoMIlZQ8p4JuFtMl88dnRH+BOXXJA6
 A67cL+E1Fc5WQIn9UzYg8Zd3qmIV/aTPZzjWexSN6kUL1ZfSUTBVpGCBpf0deD3ZE7+I
 HvG25LQFxegFCrKAaE6x6ybnJIVLmMZZwe2VaQozDnej5M463Zl5t3oxteEg5dhe2ZhO
 oMAoPcCRBP753xaFN/etmdZsXO1pfq/U93Aa0BwrBHXBsRK2aKYJM7UKwCdn5p8wyyZ5
 iOo6DH1D2EbQTZfD2uJCNeoW83L7ZGqYRJXP4kSwUHX3TnKAuv6yGll/4K5yZM/Ie2eg
 EbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725033457; x=1725638257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ukLIZ9wBp3dobfHrcQQqVVFPCV9I0BtzSNFEmcK/Df4=;
 b=I9yUQPpLI0mxcCns89/LitaTL6DrP61jYZhlv8o4E+hqZy8sSbV6B+5w3YDi7zxDMY
 y4SUfq2uZbzt4lxzIv5t7+kGg4OeNdmGclOdSqedKYIQGDUxsnnpk9M4diTqRR5jKl2t
 tKJkIETYQytkaywi8E6J82J0XO+JeX+WHwAmjH7C2pDlfEohJUgoY9jTvI3y+m+3GY7k
 Eb7ae1JZEZQb1/UFkzb7+WV7vVOcjGhNS7TMogsg5tjNliUu0bGohLEKQPpPfn7xhuyu
 6osTAWVjq9cmLy6ndsdiIWjg8DM6EwApMU1ZQ78Kw3c0m8CZqLDGFq0L8AfBmOW9+2Ev
 qIiA==
X-Gm-Message-State: AOJu0YxtXP9Xnd91Ye0brsF5vOz8XKs0+Tv9E2e82PZplJ+rhbWXyGw2
 JCbSkvaL1ZkjbmcNsEqv0qZSf6uTJvQ6BT7wma6aQYpLmrVNmOYKxyEQ0A==
X-Google-Smtp-Source: AGHT+IEvkwrLkkpSMrWMXaGmJ4h+GhwEvBuhI4f3pTmxQjraeW5kOcLEQC9DFsjGgVyXrRaRFUBB/A==
X-Received: by 2002:a05:6870:9e9a:b0:268:be91:23a4 with SMTP id
 586e51a60fabf-27790189bf7mr7585032fac.30.1725033457220; 
 Fri, 30 Aug 2024 08:57:37 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70f671a8630sm490092a34.51.2024.08.30.08.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 08:57:36 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 0/9] Add Anbernic RG35XX-2024
Date: Fri, 30 Aug 2024 10:55:05 -0500
Message-Id: <20240830155514.481410-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the Anbernic RG35XX-2024.

This device is a handheld gaming console (series) based around the
Anbernic H700 SoC. It comes with 1GB of RAM and multiple face buttons
for input.

Add support for the simplest model for now, and then iterate later to
add board detection logic, support the entire device lineup, and
move to using the mainline device tree.

Changes since V2:
 - Moved back to using the U-Boot specific device tree, for now.
 - Changed the cherry picked device tree commits to update both
   the U-Boot device tree and the mainline device tree, so either
   could be used.
 - Made the DRAM PHY pinconf compile time selectable instead of
   runtime selectable to decrease SPL memory usage.

Changes since V1:
 - Removed DDR3 and LPDDR3 patches from Jernej Skrabec, as they could
   not be tested by me and were not required to bring up this device.
 - Changed the default TPR6 parameter based on a suggestion from
   Mikhail Kalashnikov.
 - Cherry picked 2 commits from linux-next and converted devicetree to
   upstream.

Chris Morgan (5):
  sunxi: H616: DRAM: Add alternative pin mapping
  sunxi: Correct TPR6 parameter for H616 DRAM driver
  arm64: dts: allwinner: h616: Add r_i2c pinctrl nodes
  arm64: dts: allwinner: h616: Change RG35XX PMIC to r_i2c
  sunxi: Add support for Anbernic RG35XX-2024

Jernej Skrabec (4):
  sunxi: H616: dram: LPDDR4: adjust settings
  sunxi: H616: DRAM: Adjust configuration procedure
  sunxi: H616: DRAM: Adjust size scan procedure
  sunxi: H616: dram: Update mbus priorities

 arch/arm/dts/sun50i-h616.dtsi                 |   2 +
 .../dts/sun50i-h700-anbernic-rg35xx-2024.dts  |   6 +-
 arch/arm/mach-sunxi/Kconfig                   |  19 ++-
 arch/arm/mach-sunxi/dram_sun50i_h616.c        | 137 ++++++++++++------
 .../dram_timings/h616_lpddr4_2133.c           |   2 +-
 board/sunxi/MAINTAINERS                       |   5 +
 configs/anbernic_rg35xx_h700_defconfig        |  28 ++++
 .../src/arm64/allwinner/sun50i-h616.dtsi      |   2 +
 .../sun50i-h700-anbernic-rg35xx-2024.dts      |   6 +-
 9 files changed, 154 insertions(+), 53 deletions(-)
 create mode 100644 configs/anbernic_rg35xx_h700_defconfig

-- 
2.34.1

