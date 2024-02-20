Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF0CC5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7755387D74;
	Tue, 20 Feb 2024 14:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yxu7oLQC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E7F187DC9; Tue, 20 Feb 2024 14:37:58 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F74B87D72
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e47c503fb5so459979b3a.2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708436272; x=1709041072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lbxz2Ne3QBME7tXo49K2i97OhddPjJT5OAxF6oGfEvo=;
 b=yxu7oLQCHt504lDI5Z8TM6ZrecZ9EZO8pP4YoxW/Rc7a/SAwsfjrCdJh85r7b3/pD+
 T3nKb3WCGfBYnPykKT76BwgagV5u15zI/DQHH0qRdYZG6col/0DXxJqnFjYBLH6nxWpC
 Zvp0cJtyQAv1DoauHOv9gGPPNvb9DnLjXh5H109RsKCvHueDTImKgsEhoLURz+/xrm81
 Oz1PZK69N0qz5/njEbPLa0CvMIaayoW1L0e5r0FDu5Extch8aE2g1zx2QjLXOWPpEUAT
 RhQ6L+Y9l6yAX/M/7AFxIMUXWLY3uVbJmh7p4mYBOrxHJHtmb4Uoo0DrrYR1KD3AsU9q
 v3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708436272; x=1709041072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lbxz2Ne3QBME7tXo49K2i97OhddPjJT5OAxF6oGfEvo=;
 b=mVTahj1n958qLA4bAbEybO/m3Cio6hggca/nj3x7BGJ/OkbNDKcWjKcje7EdNCrnjG
 Ubz4w6GvZzl0JTc8XjnMAOrKZ/0dF5bmp5gfdB1u1IxXEHyoo6vix8jhgxsGoq3RMVjM
 sJIPLcrXogaTjKf8pauoOPC5un3M3yTIkWnGrC8lmaBPzS/HxbcQbfI06GXlMcBKUxeq
 ZEJ0c9Btjtbu52yuS1lHJ6WsCeWvFoAOHPLoUvcsOTYP+EXSNUih9Q7ktuzQDYMhzMj2
 oWg6LO5cQ+aD5lx/ZJ0PgQr9JT2is1COkWbLf8Yn8Mu4PaW9C/rkARalSkU36t09dA//
 hvow==
X-Gm-Message-State: AOJu0YzrHKA4Z+VHSKsDtco2x9Z9mQdpmuZSkrGssTyJ2H2IrxQp5x0e
 H0GvP+VhT6DsMmN1hRyMsrSCwGUYa/q3phtouMJ7WdmLGmEbpT7lNivD1Rhddc8g9n6iPHJI0AR
 M
X-Google-Smtp-Source: AGHT+IEiZkF3IesErIxoTXNTv0qHcAHzU2w5bia2Qi/v77kqzmTZYoimS2h9/eiZsC7BZAuRv74IAw==
X-Received: by 2002:a05:6a00:1897:b0:6e4:864a:9f68 with SMTP id
 x23-20020a056a00189700b006e4864a9f68mr372423pfh.5.1708434672141; 
 Tue, 20 Feb 2024 05:11:12 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.148]) by smtp.gmail.com with ESMTPSA id
 y12-20020aa79e0c000000b006e3e72a4f87sm5195902pfq.0.2024.02.20.05.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 05:11:11 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org,
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 0/7] imx8mp: Enable PCIe/NVMe support
Date: Tue, 20 Feb 2024 18:40:49 +0530
Message-Id: <20240220131056.2962331-1-sumit.garg@linaro.org>
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

Patch #1: Adds PCIe clocks support.
Patch #2: Adds i.MX8MP reset controller support.
Patch #3: Extend i.MX8MP power domain driver with PCIe support
Patch #4: Expose high performance PLL clock required for PCIe PHY
          on verdin board.
Patch #5: Adds standalone PCIe PHY support for i.MX8MP SoC.
Patch #6: Adds DW PCIe controller support for iMX8MP SoC.
Patch #7: Enable PCIe/NVMe support for verdin board.

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

Sumit Garg (7):
  clk: imx8mp: Add support for PCIe clocks
  reset: imx: Add support for i.MX8MP reset controller
  imx8mp: power-domain: Add PCIe support
  imx8mp: power-domain: Expose high performance PLL clock
  phy: phy-imx8m-pcie: Add support for i.MX8M{M/P} PCIe PHY
  pci: Add DW PCIe controller support for iMX8MP SoC
  verdin-imx8mp_defconfig: Enable PCIe/NVMe support

 configs/verdin-imx8mp_defconfig       |   9 +
 drivers/clk/imx/clk-imx8mp.c          |   6 +
 drivers/pci/Kconfig                   |   8 +
 drivers/pci/Makefile                  |   1 +
 drivers/pci/pcie_dw_imx8.c            | 348 ++++++++++++++++++++++++++
 drivers/phy/Kconfig                   |   9 +
 drivers/phy/Makefile                  |   1 +
 drivers/phy/phy-imx8m-pcie.c          | 246 ++++++++++++++++++
 drivers/power/domain/imx8mp-hsiomix.c | 121 ++++++++-
 drivers/reset/reset-imx7.c            | 114 +++++++++
 10 files changed, 859 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pci/pcie_dw_imx8.c
 create mode 100644 drivers/phy/phy-imx8m-pcie.c

-- 
2.34.1

