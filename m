Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FE3C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 09:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B440F871AA;
	Wed, 13 Dec 2023 10:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u785P7A/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36F57877D9; Wed, 13 Dec 2023 10:30:23 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5638B87015
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 10:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33338c47134so6104380f8f.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 01:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702459820; x=1703064620; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E+Wk6lJKkwdpW5iXxOSKeoq70miEq59nRglwqSNX58k=;
 b=u785P7A/aNv1LqA5NC9NmhhkCuYwDJkYMvtLxt3FbfRfiY1zkpw5rtbjerE+URW0zU
 V4CSCBjcwQxpiUtYzQNXoKXFpZMatP10Cqrp/AiEq1SvTlNla9QsqvpUYpMCo7Ql3VGC
 yAb9XSBosa8MkonCO4ecBZ6gCIB1XvpfPCYZ4q0nM1W57RuvsSYlQaCTLvelGpNWniF2
 lK1vaHHTpzrxFfHJL2tmewgFUp29o5tfvuQrXqKACX47CUcBNCkTRkJqLAUXd0CbZkWZ
 /lxWhkt2/ecOuWpO77rJ9fZsiTWNyKSUuno6BlgWiH3T0balE9EskE/IuU/8CRzMG0/g
 zdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702459820; x=1703064620;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E+Wk6lJKkwdpW5iXxOSKeoq70miEq59nRglwqSNX58k=;
 b=QeA672XSc4gFVsFuS0Q2Yakwj3mKdIIp7nbPQMPXNkHqpNZS2yDYeamBtsjeII/Xg9
 vert6Wq5LUwyTlGwi/70clCA0rIZwfqMmskM801U0jLg8UPkEjtYfggeJzvPBQeMHqJw
 YlZvz9ceMy7bsSCRJTvVjQ7mFd7YOLEqTtEphf/CJOnzPjpMKYs09EvKlm3ByT5ahzLf
 bwZKj/0cPaw1pbzy5pD7i/zDK29YThyd9tub3pmbawULjG9eA6HQjh6G4+47osj50tbW
 VsNwAdhyAScQYRfCG7MXjUeF19SRgZLgfQoiFWoJyaw4PjstaNfbpJ8ESxygOynNeFXm
 K1Tg==
X-Gm-Message-State: AOJu0YwgFO17mhLIu2ButeYPFucClKk42Fx35WGqWTGb7y0tJpzVAzpR
 8W/i3AKsdzwyeRIkEZE5x9TsaA==
X-Google-Smtp-Source: AGHT+IFkb4/Z4nAOMUH4O4hr0RwBxW5C+xiTWTHZruGFvbqsPwOAa8SZq1IN/1LDA0jEgBtKqfZ52w==
X-Received: by 2002:a05:6000:1007:b0:333:2fd2:6f7b with SMTP id
 a7-20020a056000100700b003332fd26f7bmr3543985wrx.133.1702459819758; 
 Wed, 13 Dec 2023 01:30:19 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:596e:6d4f:fc0a:ec65])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a5d504c000000b003333521a1cesm678817wrt.57.2023.12.13.01.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 01:30:19 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] ARM: meson: introduce GXL MDIO mux driver and
 switch to Linux v6.4 DT
Date: Wed, 13 Dec 2023 10:30:11 +0100
Message-Id: <20231213-u-boot-gxl-mdio-mux-v2-0-c56bb02a75ea@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKN5eWUC/32NQQqDMBBFryKz7hQTKdKueo/iYhJjHFCnJBpSx
 Ls39QDdfHgf/vs7RBfYRXhUOwSXOLIsBfSlAjvS4h1yXxh0rRullcYNjciKPk849yw4bxmNrXX
 ryJRsoCzfwQ2cT+urKzxyXCV8zpOkfu1/X1JY4516opu1LQ3mOfFCQa4SPHTHcXwB0zNEDbcAA
 AA=
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2503;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=FIuWtHSeZsGEmhH82xAOBSjsdqhkSKLtyLoSiQr92kc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBleXmlu0cqacvEZ1vIX7tnSt448UTz0LVhewYoP
 UwkQxxzJR+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXl5pQAKCRB33NvayMhJ
 0YwMD/46iHk/fveStGNwghlFasPybTTNAXHLW1ro1b+49IdvrXxKddFn60/ymq08xhZ6+DHh4Y+
 hr6f8VqWkQlZQsFXd5V1JcGdUcIZY8ZNHdBPOXxMe5EKwWgocL9ce4oMLULYKp1UJAfGzIOKA4e
 oTW8cOxRZlTscTBwCQYgrwFG6l+HASC7ru3WEvt2q5qC/2U8od3Wy9bzjLFbwuaHL1b6MXhg0os
 Q1HdzNv9Y6CSzBWRObOsyP64LzaRgTp9p3k5Op9hiNISX1lRDDNpbM9BXEB3nXBuNVDC6GNfjea
 EyBSah+Kfeyy1jI0H4gr5duzRv8oMDz2a9zAg3YomT+4Ig+ZsIfdwQfbPLVdrfEl7KVqWJPt38s
 6PPVyAf5+Fhv/DO8/M2/YbT5lr6/zt2EaxlGt3P9Fbdn3uZWaWNWXi1iKSTnqgxGhPIFlTOpxlG
 aJboqttz6nqbtSoAEZQQNODjKNk25EBYXNoM5wc3jDyaNqc8y/YbZ7MlkORreYHL0X9rPS7HenN
 mXr7VSk/SV6sTMktNk/WNJz1+cvC4Jkb7cRzNPJU7lS2Zuw6BP/sWxErDNx9gWnXpPg4r9jL+db
 sr0ckh753mTckD1D4hqRzQcYmgjwOmC7X93e6yvyNvPTNz2vF82CF+9ZcDLR8n/TgRRrDkHLFY3
 lxVjI00FD7uq6Ug==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Linux v6.4 uses a new MDIO mux driver for GXL boards, let's port the driver
to U-Boot and sync the GXBB/GXL/GXM DT to make use of this driver.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Fixed copyright line in mdio mux driver
- Link to v1: https://lore.kernel.org/r/20231212-u-boot-gxl-mdio-mux-v1-0-9adaa5cc7afb@linaro.org

---
Neil Armstrong (2):
      net: Add Amlogic GXL MDIO Mux driver
      ARM: dts: sync Amlogic GX DT to Linux v6.4

 arch/arm/dts/meson-gx-libretech-pc.dtsi            |   4 +-
 arch/arm/dts/meson-gx.dtsi                         |  21 ++--
 arch/arm/dts/meson-gxbb-nanopi-k2.dts              |  13 +-
 arch/arm/dts/meson-gxbb-odroidc2.dts               |  26 ++--
 arch/arm/dts/meson-gxbb.dtsi                       |  18 ++-
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |   2 +-
 .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  12 +-
 arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  16 +--
 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |   3 +-
 arch/arm/dts/meson-gxl-s905x-p212.dts              |  68 ++++++++++
 arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  21 ++--
 arch/arm/dts/meson-gxl.dtsi                        |  43 ++++---
 arch/arm/dts/meson-gxm-khadas-vim2.dts             |  15 +--
 arch/arm/dts/meson-gxm-wetek-core2.dts             |   2 -
 configs/beelink-gt1-ultimate_defconfig             |   2 +-
 configs/jethub_j80_defconfig                       |   2 +-
 configs/khadas-vim2_defconfig                      |   2 +-
 configs/khadas-vim_defconfig                       |   2 +-
 configs/libretech-ac_defconfig                     |   2 +-
 configs/libretech-cc_defconfig                     |   2 +-
 configs/libretech-cc_v2_defconfig                  |   2 +-
 configs/libretech-s905d-pc_defconfig               |   2 +-
 configs/libretech-s912-pc_defconfig                |   2 +-
 configs/p212_defconfig                             |   2 +-
 configs/wetek-core2_defconfig                      |   2 +-
 drivers/net/Kconfig                                |   7 ++
 drivers/net/Makefile                               |   1 +
 drivers/net/mdio_mux_meson_gxl.c                   | 138 +++++++++++++++++++++
 28 files changed, 342 insertions(+), 90 deletions(-)
---
base-commit: 65eed687729c28431d38c6c9174da4d878fb107f
change-id: 20231212-u-boot-gxl-mdio-mux-bc027eab0273

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

