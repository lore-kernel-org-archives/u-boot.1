Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CEBC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 07:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 774368780E;
	Tue, 12 Mar 2024 08:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BOKrZWi7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70F0C86D73; Tue, 12 Mar 2024 08:03:59 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 610E487D82
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dd59b95677so28182595ad.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 00:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710227033; x=1710831833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ExuDj/aRlhc/2s4ri76mBAGm8oXX3+3/aTUbINuRDXI=;
 b=BOKrZWi7WYut6Llb1zSHcKdrZpkBzrhvk19UxGwjRPh9b2XG5wO76ckNK8IgeyMr3G
 f+axV740ArSiXplWrLoJafXfIFUFh27AkljPLl6K7p9jqUC6HvYUweDfo6Wp2Tr5P5U0
 YezqXr/BK/C0QkUbEe48rhQa1feE+gfxOw31egqOClkgCK8tsHQrGiwUEpbz+Y+5ROml
 GDxcyHpKFyOCTWQhubcFgrVbOjkNsazdYHehFN0l3xpMNh353xyCQ7XRyTuYK4uln6v+
 r2AGteT6SKFgOsk+VrrQxfX6xusjb5pbmYJLBH196htFfNlY/E9dzE92d8++RMiOMr3o
 temw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710227033; x=1710831833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ExuDj/aRlhc/2s4ri76mBAGm8oXX3+3/aTUbINuRDXI=;
 b=uLEQhjFRbujx3s3gGHH5mx+TjBvmVp+tVyeC7C8c8KPeEyf7SSHDrjB8QWSC+wYUZk
 DmkSIDxUuLdn3KfNz/Y6F7p0vxIl+Zql+n1t0GZ/ryMK4FMQtLIxYK+omIIYUPuRnSE+
 dM8u2LUgs6TLJgUAR9BhM8vbOWRX5ds8cz6mnGFkvh8jJy9FgL+Vk92XA20XQ+5r388G
 9gvAUttevbt/QpMF42gs8BoPQxGr7pukakrWKvIfLmsLHFkFCCSe7I+h+gtoNjsYmqko
 tEm1Kbw6LZ6v9MFelRh5bRDV+qZhV/kmofzpVlQduAT0dnw1uQKAzY/cUC+HdMUAZZDR
 BCMA==
X-Gm-Message-State: AOJu0YxiHgvEQT67asl1usV6F+nMM11zbArbdeJaYX5ZsPXLw3bBMnik
 SDDzXNvnXn9GTXILHSRPPadZtzmRmy6+IeJBqv+F5nGMh4JVp0kdDNO1aOLr4OcLNdiViccD7gw
 c
X-Google-Smtp-Source: AGHT+IFlttsudu8F9bDlSk5HRqYK2wlSP583HanPvYYU+232qgCOEk3mY1czHFNow9svLterJCXexQ==
X-Received: by 2002:a17:902:ef8f:b0:1dc:7856:2213 with SMTP id
 iz15-20020a170902ef8f00b001dc78562213mr6027572plb.37.1710227033410; 
 Tue, 12 Mar 2024 00:03:53 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 e13-20020a170902784d00b001dd0d0d26a4sm6045401pln.147.2024.03.12.00.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 00:03:53 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 00/11] imx8mp: Enable PCIe/NVMe support
Date: Tue, 12 Mar 2024 12:33:27 +0530
Message-Id: <20240312070338.86127-1-sumit.garg@linaro.org>
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

pcie_imx doesn't seem to share any useful code for iMX8MP SoC and it is
rather tied to quite old port of pcie_designware driver from Linux which
suffices only iMX6 specific needs.

But currently we have the common DWC specific bits which alligns pretty
well with DW PCIe controller on iMX8MP SoC. So lets reuse those common
bits instead as a new driver for iMX8 SoCs. It should be fairly easy to
add support for other iMX8 variants to this driver.

iMX8MP SoC also comes up with standalone PCIe PHY support, so hence we
can reuse the generic PHY infrastructure to power on PCIe PHY.

Testing with this patch-set included:

Verdin iMX8MP # pci enum
PCIE-0: Link up (Gen1-x1, Bus0)
Verdin iMX8MP # 
Verdin iMX8MP # nvme scan
Verdin iMX8MP # 
Verdin iMX8MP # nvme info
Device 0: Vendor: 0x126f Rev: T0828A0  Prod: AA000000000000000720
            Type: Hard Disk
            Capacity: 122104.3 MB = 119.2 GB (250069680 x 512)
Verdin iMX8MP # 
Verdin iMX8MP # load nvme 0 $loadaddr <file-name>

Changes in v3:
- Rebased on top of U-Boot next.
- Incorporated misc. updates to commit messages.
- New patch#2 to refactor reset driver function names.
- Patch#3: Refactored further for better code reuse.
- New patch#4 to fix refcount issue with power domain bus.
- Patch#5: Refactored further for better code reuse.
- Patch#7 & #8: Added dependency on REGMAP and SYSCON. Also, added
  support for vpcie-supply regulator.
- Patch#7 & #8: Added error paths and .remove callback.
- New patch#10 to enable PCIe/NVMe for imx8mp_venice*.

Changes in v2:
- Renamed PCIe IMX driver pcie_dw_imx8.c -> pcie_dw_imx.c.
- Added myself as maintainer for PCIe DWC IMX driver support.
- Incorporated various code and commit message improvement suggestions
  from Marek, thanks.
- Patch#3: Gate PCIe and USB clocks behind corresponding power domain
  IDs.
- Patch#4: Expose HSIO PLL clocks as a regular clock driver instead
  similar to what Linux kernel does.
- Patch#7: Picked up tags.

Sumit Garg (10):
  clk: imx8mp: Add support for PCIe clocks
  reset: imx: Refactor driver to simplify function names
  reset: imx: Add support for i.MX8MP reset controller
  imx8mp: power-domain: Don't power off pd_bus
  imx8mp: power-domain: Add PCIe support
  imx8mp: power-domain: Expose high performance PLL clock
  phy: phy-imx8m-pcie: Add support for i.MX8M{M/P} PCIe PHY
  pci: Add DW PCIe controller support for iMX8MP SoC
  verdin-imx8mp_defconfig: Enable PCIe/NVMe support
  MAINTAINERS: Add entry for PCIe DWC IMX driver

Tim Harvey (1):
  imx8mp_venice_defconfig: Enable PCIe/NVMe support

 MAINTAINERS                           |   6 +
 configs/imx8mp_venice_defconfig       |   8 +
 configs/verdin-imx8mp_defconfig       |   6 +
 drivers/clk/imx/clk-imx8mp.c          |   6 +
 drivers/pci/Kconfig                   |  11 +
 drivers/pci/Makefile                  |   1 +
 drivers/pci/pcie_dw_imx.c             | 338 ++++++++++++++++++++++++++
 drivers/phy/Kconfig                   |  11 +
 drivers/phy/Makefile                  |   1 +
 drivers/phy/phy-imx8m-pcie.c          | 283 +++++++++++++++++++++
 drivers/power/domain/imx8mp-hsiomix.c | 191 ++++++++++++---
 drivers/reset/reset-imx7.c            | 125 +++++++++-
 12 files changed, 937 insertions(+), 50 deletions(-)
 create mode 100644 drivers/pci/pcie_dw_imx.c
 create mode 100644 drivers/phy/phy-imx8m-pcie.c

-- 
2.34.1

