Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40792C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6FD4877B0;
	Wed, 17 Jan 2024 08:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QhrySOJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1FE0879A0; Wed, 17 Jan 2024 08:52:19 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 730B586F67
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso89801115ad.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705477936; x=1706082736;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y6kcOmDCmnO9DP1d4EkDYtTXcTv9/97oJnF+wpodB2E=;
 b=QhrySOJuifUudUJhlCyCtDfy4OXjp5nZx0THw9td9+WaNZ1r6ppSrEEtosh5fOX3V3
 B+bXn51t90DaSIw9q4tBiHmK7v2SfyJ2XTemyPbGERpH9v9JJM8sLg8844DP+SvXPt98
 IBJOBD+r7YLH9teCg6qIq49LWBej0Y5Qj+wqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477936; x=1706082736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y6kcOmDCmnO9DP1d4EkDYtTXcTv9/97oJnF+wpodB2E=;
 b=WPnryPGjZpiKr9yiFv4OMx8d64hhm+CYXFzxIbXV8TuUyofB4Dn3L2mtET+05BBPx7
 In/n+AoQ/huuU3b/JynA+tVBoTn8OBYAmwiIc7tqMFHuhzoLT6MFm24o/gA6nuoGbjx4
 SYf8PsD35EfSen/yAFP0hVGVBJckjZ+lyw/imakn3HhIV2MdBC7JJjMIzw6BMLv7y7e3
 xjKPOMAypF415YCAyMjvBXZ4V5VSGDXqWwyDm0OEtFCyHLD+CzNxDefPsIDmE0D4GEaY
 Av5edZ/Q83sAjQPHD7+HfGj6SXIyJpuK0D0eD4eB6ypts9WAnWQwfy/+jz8S5DitoXwo
 8Z7w==
X-Gm-Message-State: AOJu0Yzj/FkiUcFfzDLWxdTL5dx+McHEUQQbOLXJ8ivTJwFNpZeqRgRJ
 7La/m6OyAACRfYEy9ftbpq3huSPReuKhiQ==
X-Google-Smtp-Source: AGHT+IHm2spBAmRV7hx6IehOTi4HfWb9nZrsE4ZF7eUyvCAaEOEI5qlGLo45P2vVVmSgPVwLzrgVPw==
X-Received: by 2002:a17:902:eb86:b0:1d4:be6f:5eab with SMTP id
 q6-20020a170902eb8600b001d4be6f5eabmr11594017plg.6.1705477935750; 
 Tue, 16 Jan 2024 23:52:15 -0800 (PST)
Received: from localhost.localdomain ([183.82.41.50])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902784a00b001d5081be740sm10718624pln.62.2024.01.16.23.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:52:15 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v3 00/17] video: dw_hdmi: Support Vendor PHY
Date: Wed, 17 Jan 2024 13:21:37 +0530
Message-Id: <20240117075154.58747-1-jagan@amarulasolutions.com>
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

Changes for v3:
- updated phy_ops logic
- tested in BPI-M64
- updated handoff logic for rk3328

Changes for v2:
- Use proper cfg function for meson
- Add VOP cleanup code.
- Add DCLK get rate

Linux VOP/HDMI out issues seems resolved with explicit WIN0 disable.

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
 drivers/video/dw_hdmi.c                       |  29 +-
 drivers/video/meson/meson_dw_hdmi.c           |   6 +-
 drivers/video/rockchip/Makefile               |   2 +
 drivers/video/rockchip/rk3328_hdmi.c          | 126 +++
 drivers/video/rockchip/rk3328_vop.c           |  83 ++
 drivers/video/rockchip/rk_hdmi.c              |  11 +-
 drivers/video/rockchip/rk_hdmi.h              |   3 +
 drivers/video/rockchip/rk_vop.c               |  44 +-
 drivers/video/rockchip/rk_vop.h               |   4 +
 drivers/video/sunxi/sunxi_dw_hdmi.c           |  14 +-
 include/configs/evb_rk3328.h                  |   5 +
 include/configs/rk3328_common.h               |   1 +
 include/dw_hdmi.h                             |  11 +-
 22 files changed, 1345 insertions(+), 38 deletions(-)
 create mode 100644 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
 create mode 100644 drivers/video/rockchip/rk3328_hdmi.c
 create mode 100644 drivers/video/rockchip/rk3328_vop.c

-- 
2.25.1

