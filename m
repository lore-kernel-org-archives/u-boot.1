Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EE1C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 15:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C732788CD8;
	Mon, 19 Aug 2024 17:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oz49E3j6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF17C88CD8; Mon, 19 Aug 2024 17:02:04 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 984018641A
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-27022a3536dso1814566fac.2
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724079721; x=1724684521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WygNCvaEIYbgzexQH3wuWXQ/H3ojwPHvkSmw8wPmawM=;
 b=Oz49E3j6CTkFH+sQiQrC6dsfN6C0e0ep/5T2IQ01HZmbvfSdu0/T1L9hqdplNoEFNH
 HxZcKLjSuWefmvdDkydejf/SewU5DpAEbJLIj65zInyw4+qLmZ6b+/GDx1Ei+GShJDz0
 78S/LtTDzXDpsvITA3XLcgeawqLUw/TlPbZYWx7yJMFI3P0ONHp2hggk5qzlCkEDJu7D
 ejR0HS7g6lCFcC1KLKnLHn+B6VfQev+gYkw+LvQiv2HmyCPlFlpwqs26P9DjckIoQcUc
 PPNnYjafsGLANnhBEmyukPtVOPzQ3zQEJ1+4qNfDpDe1XvEXIkAl1edal0Jcf8uvWLrB
 WV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724079721; x=1724684521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WygNCvaEIYbgzexQH3wuWXQ/H3ojwPHvkSmw8wPmawM=;
 b=ByclaqNvN6OtVeulZc3wdUtlWU63YbQYlBZzioAS1J8GMKTw0Nm0zOnUhoHi16m7x0
 GE0NSDGNzdkXMKErr1JAfpyc0NZg3rIllDKpqFRknDPmEYz5Gcqj8w1TfKJb8T0359uP
 bWYz3QZYg1EzfltXzNslUEKa2eISS49n0B7SjQThb03S8eJg6F2OnUCcYi9XIMCUfSpB
 GBK5KP1aw8lp5pwbs8zWaTNYOS+ygDszUrih0F50IhXLnRgxQ6k+HLwXcQk9ChPX++Xh
 3ZKRr3VHCpwasJhX4MwOQZSvllgzedHDvFgvAEXCQpWo1yMxV8nGj5jyGVfAgWovawZZ
 8eWQ==
X-Gm-Message-State: AOJu0YxcPbPY+gy2U3CXqtQ6n69NJlKY0hcUP9wU/35zVgSmy0q62IC9
 YvHzjeZugLHe3HzYwOvi0p+bBRkEqJr9xcHqU2jmSUERwQxlEmx7Epe6Og==
X-Google-Smtp-Source: AGHT+IGKhFEXIwspnD9goXSs9fC3XFF+sokheNUcq2VLzNxwKpUHRJjQdnwDtX8jGkVr9drzEq1Dyg==
X-Received: by 2002:a05:6870:e8c6:b0:270:1850:f898 with SMTP id
 586e51a60fabf-2701c37ed06mr12379633fac.12.1724079720974; 
 Mon, 19 Aug 2024 08:02:00 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-27004432d18sm2945189fac.7.2024.08.19.08.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 08:02:00 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 0/9] Add Anbernic RG35XX-2024
Date: Mon, 19 Aug 2024 09:59:29 -0500
Message-Id: <20240819145938.503221-1-macroalpha82@gmail.com>
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

Changes since V1:
 - Removed DDR3 and LPDDR3 patches from Jernej Skrabec, as they could
   not be tested by me and were not required to bring up this device.
 - Changed the default TPR6 parameter based on a suggestion from
   Mikhail Kalashnikov.
 - Cherry picked 2 commits from linux-next and converted devicetree to
   upstream.

Chris Morgan (4):
  arm64: dts: allwinner: h616: Add r_i2c pinctrl nodes
  sunxi: Correct TPR6 parameter for H616 DRAM driver
  arm64: dts: allwinner: h616: Change RG35XX Series from r_rsb to r_i2c
  sunxi: Add support for Anbernic RG35XX-2024

Jernej Skrabec (5):
  sunxi: H616: dram: LPDDR4: adjust settings
  sunxi: H616: DRAM: Add alternative pin mapping
  sunxi: H616: DRAM: Adjust configuration procedure
  sunxi: H616: DRAM: Adjust size scan procedure
  sunxi: H616: dram: Update mbus priorities

 arch/arm/mach-sunxi/Kconfig                   |   2 +-
 arch/arm/mach-sunxi/dram_sun50i_h616.c        | 174 ++++++++++++------
 .../dram_timings/h616_lpddr4_2133.c           |   2 +-
 board/sunxi/MAINTAINERS                       |   5 +
 configs/anbernic_rg35xx_h700_defconfig        |  52 ++++++
 .../src/arm64/allwinner/sun50i-h616.dtsi      |   2 +
 .../sun50i-h700-anbernic-rg35xx-2024.dts      |   6 +-
 7 files changed, 179 insertions(+), 64 deletions(-)
 create mode 100644 configs/anbernic_rg35xx_h700_defconfig

-- 
2.34.1

