Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D1AC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 09:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C49D287650;
	Mon, 11 Dec 2023 10:00:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Z9sErS4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE2688766D; Mon, 11 Dec 2023 10:00:43 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E814875FE
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5c629a9fe79so2195362a12.3
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 01:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702285238; x=1702890038;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BY2CdbPPJsTHC24zbkM3RkJ/Y5IF7bCirtD5UxLv+VI=;
 b=Z9sErS4bNVjrrcAyI6jS6gXNhzX9iNGf8WR4N4oVQRWU6fcOaQJ2BbOpej501Pku4k
 C902gtNdfxNmzLx0eiF/bVmoCtHkwizhn1GeAv8AJdup1vXq0FMKOOOxOOD4HEYF45YZ
 qHXFzGESoOrfnqjyUqUzmdWF/LYTxA6wMi6AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702285238; x=1702890038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BY2CdbPPJsTHC24zbkM3RkJ/Y5IF7bCirtD5UxLv+VI=;
 b=jsqKfSOq/WwmGxS5sFjigxnEYhPyCTXPb43br+9ARzR1v1xf2W7hiQCoDek3jl+Ab9
 oNLdtT/t4UcMeIVOAH3nq1z5HzQV+Mn9MethsPZVSMTP0L0xxUgWG+sYp1VqLADKmQ6i
 +9k8ivwaWE9k1WBxRdmYVqoAPSeZeSD+2NmhUKfpnBMGn+SNkX9IHWUQJb6SLs6oHXC3
 KfqBx85N5ZCR6osNLoVo8ymTfxT4TO3qk7/X1EIM4z+3+W20cPi+NYU24apvPMPBe6pA
 SN/th79Ir+b96yq6L5QTCtaIbmqG1jHe1ssTCtWx6bjQW0CwRiHVU3ojlhXYuDHNG+M2
 rHHg==
X-Gm-Message-State: AOJu0YxrF5ZpF09iraWO+DKhDwIbo4VgOP/ELJd5BfZZOZjP6Xy1oDX0
 4WvfY4CM+v9p8EFt2jpPyRrQYwChPOxZDKTn8GKJbQ==
X-Google-Smtp-Source: AGHT+IF2Tbti2TCmmo08X7uJQDum0HWHJmWlI9tW2dG5Kbif/6sirevCL9pCPIk2RMjKrWrNNoFEFg==
X-Received: by 2002:a05:6a21:3298:b0:18f:97c:926b with SMTP id
 yt24-20020a056a21329800b0018f097c926bmr1833027pzb.80.1702285238367; 
 Mon, 11 Dec 2023 01:00:38 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001cfb93fa4fasm6080779pld.150.2023.12.11.01.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:00:37 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 00/17] video: dw_hdmi: Support Vendor PHY
Date: Mon, 11 Dec 2023 14:29:22 +0530
Message-Id: <20231211085939.5478-1-jagan@amarulasolutions.com>
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

Unlike RK3399, Sunxi/Meson DW HDMI the new Rockchip SoC Rk3328 would
support external vendor PHY with DW HDMI chip.

Support this vendor PHY by adding new platform PHY ops via DW HDMI
driver and call the respective generic phy from platform driver code.

This series tested in RK3328 with 1080p (1920x1080) resolution.

Patch 0001/0005: Support Vendor PHY
Patch 0006/0008: VOP extension for win, dsp offsets
Patch 0009/0010: RK3328 VOP, HDMI clocks
Patch 0011:	 Rockchip Inno HDMI PHY
Patch 0012:	 RK3328 HDMI driver
Patch 0013:	 RK3328 VOP driver
Patch 0014/0017: Enable HDMI Out for RK3328

Importent:
One pontential issues is that Linux HDMI out on RK3328 has effected by
this patchset as I wouldn't find any relation or clue.

[    0.752016] Loading compiled-in X.509 certificates
[    0.787796] inno_hdmi_phy_rk3328_clk_recalc_rate: parent 24000000
[    0.788391] inno-hdmi-phy ff430000.phy: inno_hdmi_phy_rk3328_clk_recalc_rate rate 148500000 vco 148500000
[    0.798353] rockchip-drm display-subsystem: bound ff370000.vop (ops vop_component_ops)
[    0.799403] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, using dummy regulator
[    0.800288] rk_iommu ff373f00.iommu: Enable stall request timed out, status: 0x00004b
[    0.801131] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, using dummy regulator
[    0.802056] rk_iommu ff373f00.iommu: Disable paging request timed out, status: 0x00004b
[    0.803233] dwhdmi-rockchip ff3c0000.hdmi: Detected HDMI TX controller v2.11a with HDCP (inno_dw_hdmi_phy2)
[    0.805355] dwhdmi-rockchip ff3c0000.hdmi: registered DesignWare HDMI I2C bus driver
[    0.808769] rockchip-drm display-subsystem: bound ff3c0000.hdmi (ops dw_hdmi_rockchip_ops)
[    0.810869] [drm] Initialized rockchip 1.0.0 20140818 for display-subsystem on minor 0

The only way I can use Linux HDMI by disabling IOMMU or support
disable-iommu link for RK3328 via DT [1].

[1] https://www.spinics.net/lists/devicetree/msg605124.html

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
 drivers/clk/rockchip/clk_rk3328.c             | 100 +-
 drivers/phy/rockchip/Kconfig                  |   7 +
 drivers/phy/rockchip/Makefile                 |   1 +
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 885 ++++++++++++++++++
 drivers/video/dw_hdmi.c                       |  48 +-
 drivers/video/meson/meson_dw_hdmi.c           |  11 +-
 drivers/video/rockchip/Makefile               |   2 +
 drivers/video/rockchip/rk3328_hdmi.c          | 131 +++
 drivers/video/rockchip/rk3328_vop.c           |  66 ++
 drivers/video/rockchip/rk3399_hdmi.c          |   8 +-
 drivers/video/rockchip/rk_hdmi.c              |  12 +-
 drivers/video/rockchip/rk_hdmi.h              |   3 +
 drivers/video/rockchip/rk_vop.c               |  44 +-
 drivers/video/rockchip/rk_vop.h               |   4 +
 drivers/video/sunxi/sunxi_dw_hdmi.c           |  19 +-
 include/configs/evb_rk3328.h                  |   5 +
 include/configs/rk3328_common.h               |   1 +
 include/dw_hdmi.h                             |  17 +-
 23 files changed, 1371 insertions(+), 39 deletions(-)
 create mode 100644 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
 create mode 100644 drivers/video/rockchip/rk3328_hdmi.c
 create mode 100644 drivers/video/rockchip/rk3328_vop.c

-- 
2.25.1

