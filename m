Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8784C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00E4E871CE;
	Mon, 18 Dec 2023 20:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="R9wNPOIX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDAC08743A; Mon, 18 Dec 2023 20:11:29 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A6AB8715C
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d3ce28ac3cso9379345ad.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926685; x=1703531485;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8wNX3EsfPja+o4Thpz/bM1hPb4SjnXUMSWQ2OlPwqyw=;
 b=R9wNPOIXMxA5lgbTqXlDoxGOTQjp61XEWTHbxpK32/u8TwpGk0qDy3GuOT/gCz2k0x
 mRx0yz+njq4evCtNeBfwvlhlVpJT4R6vwPjxmaEcLOZfudKIyVp600pLQ3oHfpipTJFo
 UZO05qW3zg4W1gvR0pD5ZDR4YzATklvnWIs58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926685; x=1703531485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8wNX3EsfPja+o4Thpz/bM1hPb4SjnXUMSWQ2OlPwqyw=;
 b=OZBbQYsoHX8tOKp3DB0Z8/eQW5sdu1EGNvi17lG8OvLDujd+COy8qiiSHvn/e9gJc/
 Ddta6pqOmiQyajpa5G8JbaNZ2K/bEwO5irBIjru9zv9649cEIGARkSFVCuZsF3q0Tgb8
 i/XA1GrjCSahhfYnD7zCMjojWJD2vgCW42vV2NVgHiY58hl5AZkcyyytmQ9RAqSBX44x
 lnAfiHKsMdObK1vgj8rjDlb8L6uwS64QMS0fc9vDXEAvsxWSYQ/IlZxB/sxUIY/hqYsh
 cIYNq4LfBWd17prMQi2bdxx9kyrTMdhZZs6mkWcmK/v65nBdN046/ekX3gER7eWA/07w
 QwSA==
X-Gm-Message-State: AOJu0YzXvTuREp4FRiHqUOafi27aL/2JWZo8MmbbkRqiiHqQiRxQ4aXq
 KgUcFszG5v4jF+wpjevfXKbHvA==
X-Google-Smtp-Source: AGHT+IF28uM9R1iQB0XoeaXbc6BtOwcAR7FUdxA5AdKEcr1R5hjRUQXcMWXPKf9nnB//xA7opNr1gQ==
X-Received: by 2002:a17:90a:16d7:b0:28a:ea6f:9649 with SMTP id
 y23-20020a17090a16d700b0028aea6f9649mr3262353pje.94.1702926685582; 
 Mon, 18 Dec 2023 11:11:25 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:11:25 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 00/17] video: dw_hdmi: Support Vendor PHY
Date: Tue, 19 Dec 2023 00:40:57 +0530
Message-Id: <20231218191114.129329-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
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

From: Jagan Teki <jagan@edgeble.ai>

Unlike RK3399, Sunxi/Meson DW HDMI the new Rockchip SoC Rk3328 would
support external vendor PHY with DW HDMI chip.

Support this vendor PHY by adding new platform PHY ops via DW HDMI
driver and call the respective generic phy from platform driver code.

This series tested in RK3328 with 1080p (1920x1080) resolution.

Patch 0001/0005: Support Vendor PHY
Patch 0006/0008: VOP extension for win, dsp offsets
Patch 0009/0010: RK3328 VOP, HDMI clocks
Patch 0011:      Rockchip Inno HDMI PHY
Patch 0012:      RK3328 HDMI driver
Patch 0013:      RK3328 VOP driver
Patch 0014/0017: Enable HDMI Out for RK3328

Changes for v2:
- Use proper cfg function for meson
- Add VOP cleanup code.
- Add DCLK get rate

Linux VOP/HDMI out issues seems resolved with explicit VOP cleanup.

V1:
https://patchwork.ozlabs.org/project/uboot/cover/20231211085939.5478-1-jagan@amarulasolutions.com/

Any inputs?
Jagan.

Jagan Teki (17):
  video: rockchip: hdmi: Detect hpd after controller init
  video: dw_hdmi: Add Vendor PHY handling
  video: dw_hdmi: Extend the HPD detection
  video: dw_hdmi: Add read_hpd hook
  video: dw_hdmi: Add setup_hpd hook
  video: rockchip: vop: Simplify rkvop_enable
  video: rockchip: vop: Add win offset support
  video: rockchip: vop: Add dsp offset support
  clk: rockchip: rk3328: Add VOP clk support
  clk: rk3328: Add get hdmiphy clock
  phy: rockchip: Add Rockchip INNO HDMI PHY driver
  video: rockchip: Add rk3328 hdmi support
  video: rockchip: Add rk3328 vop support
  ARM: dts: rk3328: Enable VOP for bootph-all
  rockchip: Enable preconsole for rk3328
  configs: evb-rk3328: Enable vidconsole for rk3328
  configs: Enable HDMI Out for ROC-RK3328-CC

 arch/arm/dts/rk3328-u-boot.dtsi               |   4 +
 .../include/asm/arch-rockchip/cru_rk3328.h    |  34 +
 arch/arm/mach-rockchip/Kconfig                |   1 +
 common/Kconfig                                |   2 +-
 configs/roc-cc-rk3328_defconfig               |   5 +
 drivers/clk/rockchip/clk_rk3328.c             | 105 ++-
 drivers/phy/rockchip/Kconfig                  |   7 +
 drivers/phy/rockchip/Makefile                 |   1 +
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 885 ++++++++++++++++++
 drivers/video/dw_hdmi.c                       |  48 +-
 drivers/video/meson/meson_dw_hdmi.c           |  11 +-
 drivers/video/rockchip/Makefile               |   2 +
 drivers/video/rockchip/rk3328_hdmi.c          | 131 +++
 drivers/video/rockchip/rk3328_vop.c           |  83 ++
 drivers/video/rockchip/rk3399_hdmi.c          |   8 +-
 drivers/video/rockchip/rk_hdmi.c              |  12 +-
 drivers/video/rockchip/rk_hdmi.h              |   3 +
 drivers/video/rockchip/rk_vop.c               |  44 +-
 drivers/video/rockchip/rk_vop.h               |   4 +
 drivers/video/sunxi/sunxi_dw_hdmi.c           |  19 +-
 include/configs/evb_rk3328.h                  |   5 +
 include/configs/rk3328_common.h               |   1 +
 include/dw_hdmi.h                             |  17 +-
 23 files changed, 1393 insertions(+), 39 deletions(-)
 create mode 100644 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
 create mode 100644 drivers/video/rockchip/rk3328_hdmi.c
 create mode 100644 drivers/video/rockchip/rk3328_vop.c

-- 
2.25.1

