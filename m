Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6987DC54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 14:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7BC08809A;
	Thu, 21 Mar 2024 15:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iih5OLyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C10A187D5E; Thu, 21 Mar 2024 15:55:26 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 987948809A
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 15:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1def3340682so7979945ad.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711032920; x=1711637720; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vosje43hANX/4C2DUVAUF4aYlbt6DCdnXJbG0dxverc=;
 b=iih5OLytJ339rUNAHPDQoZKgDK1urt/R+JSfOXPc+4Q1+E6HXvYynXJW0VR9CrM9HC
 bqfSpT+onICGtYZvb247D6Am/MyEqwo5q4yp+N2DQgGrTlAoy1BjobJmes2bt7KII4Hq
 olZLAg9ExV+z2zo0Nx3Kg1FYOAI8J7zK9Ry7IXDmuZOQofArxq88MeZmfrXjC0p9kL5B
 DdrpZbimvzoWkExb49UIUGOPNk2D46mac5QLU+m1o43tdrISomyos3O+ZuE9Rty9lZOL
 o8+E746eClkg+QYWki+JoDxue5/sSD0n0WWwi941rYOHQT2u0qG6Elov5FDl7A5bEFoj
 mpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711032920; x=1711637720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vosje43hANX/4C2DUVAUF4aYlbt6DCdnXJbG0dxverc=;
 b=Yp11BRv0xK5HzcaYMLZiYZc8SXAbw+ZW8jbjjzcAYJ15+h4nn3IfXk8nLge/EZ5zLO
 cUrUf792B4pqPzp5Kop5b7Jiw3H1oHzfL4J5Q3paAz3wdQQtiftjFt7mi+sBnJq8AgqW
 sggyLUDzQAq4owkByFaZW/UnSSFrdxTrJBK99djumxNjmDEjh2hfdcIIdcDhixQdCrJ0
 DmedxX3+LA4h8hp0suI6T2Gx7LbMj0UeSHqDGR60BerpRtiPRPpepCJL8DvrXPQMSA2c
 utu01NwUvvrRyY9gcrgTJXPaWBNnhDcCdUhPpBtiUzG2o4v4XIlJTKawVVf6/t9jRPhI
 PpHg==
X-Gm-Message-State: AOJu0YyMT5BYNxuiUIbVCjI5PcRkYSCQwTnwNEbr5RgCAqGzVsi6Hxnq
 kT6b7Ic6oerwMGpNgSupgXTScwvchA0+fhST8r+9qby+TAoYzFlsZSlojrES83NjOzb3A348Wxv
 I
X-Google-Smtp-Source: AGHT+IHAFrVz5/F8L6rZuH5KUY+zOLoyOuZAexongkOx/OIZPRRCgIKjqjAxmvl/EK7qwtVP+89Hbw==
X-Received: by 2002:a17:902:db02:b0:1dd:a03c:8fe9 with SMTP id
 m2-20020a170902db0200b001dda03c8fe9mr9288517plx.0.1711032920137; 
 Thu, 21 Mar 2024 07:55:20 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.159]) by smtp.gmail.com with ESMTPSA id
 j9-20020a170902da8900b001dddb014624sm11751668plx.54.2024.03.21.07.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 07:55:19 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, pbrobinson@gmail.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 00/11] imx8mp: Enable PCIe/NVMe support
Date: Thu, 21 Mar 2024 20:24:56 +0530
Message-Id: <20240321145507.619448-1-sumit.garg@linaro.org>
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

Changes in v4:
- Incorporated misc comments from Marek and added his review tag.
- Dropped patch #4 (imx8mp: power-domain: Don't power off pd_bus)
  since power domain off path is never excercised for DT based devices.
- Added patch#8 as suggested by Peter to describe older pcie_imx.c
  driver as legacy one.

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
  imx8mp: power-domain: Add PCIe support
  imx8mp: power-domain: Expose high performance PLL clock
  phy: phy-imx8m-pcie: Add support for i.MX8M{M/P} PCIe PHY
  pci: Add DW PCIe controller support for iMX8MP SoC
  pcie_imx: Update header to describe it as a legacy driver
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
 drivers/pci/pcie_imx.c                |   8 +
 drivers/phy/Kconfig                   |  11 +
 drivers/phy/Makefile                  |   1 +
 drivers/phy/phy-imx8m-pcie.c          | 283 +++++++++++++++++++++
 drivers/power/domain/imx8mp-hsiomix.c | 190 ++++++++++++---
 drivers/reset/reset-imx7.c            | 143 +++++++++--
 13 files changed, 955 insertions(+), 57 deletions(-)
 create mode 100644 drivers/pci/pcie_dw_imx.c
 create mode 100644 drivers/phy/phy-imx8m-pcie.c

-- 
2.34.1

