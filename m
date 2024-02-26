Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B330C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:05:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C60C87D74;
	Mon, 26 Feb 2024 09:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qxvvIzDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8456B87E93; Mon, 26 Feb 2024 09:05:21 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7013B87E95
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e08dd0fa0bso2361291b3a.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 00:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708934711; x=1709539511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ooCHpnNh9uZ8qKAbHOrwEt/rKg4sWi4OjU2q69+ql/0=;
 b=qxvvIzDjQSeCxHvw6YpHGTP7u6SfzJ7iNIT1TqnSSHvnaOZLlVS0Ct7ejCns7aOnWq
 c4JY5x7LFKuPxPbZaxgLI86eTvdndUpdYk6RAgBzmooxq0ocmsdBp0jnKneSqMQxUTbK
 hR+N/wVvHUG2rmFx/RgaVbvL48cABGNwf6W1aVY63CVDfZJMiXT84zaeYdnxcyY41RzL
 ztVZeSZA2dehLBqG1aFrXeq5Zkdc0PEu6KcVs6OydCsoTeoR20DiOZByIejAGSWyIHpb
 ub8l9KRtW/49CR7+GlfZhYCZXpdhJSOEaTmppWC1Qa8XbRCKSae+s1qI+GgmTDbfxLPN
 H+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708934711; x=1709539511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ooCHpnNh9uZ8qKAbHOrwEt/rKg4sWi4OjU2q69+ql/0=;
 b=pAS7f4KWwL4ra89NMIi4G6P1RPRkWhjl4/PYsZhBgfjzrH+po168bYKTnuZB57lmaE
 Ssz6OIV/in1v2e6jAmuE24Gh35uh6FgqCY/ETjpcYStJ6KaQMUitI0I4VbDDRQaUCpAX
 ms4A7L9RgaVS8EMOoNH1KTLcInFDBO//EwOpWPmbnTAQFWrpTL1ZtDsZi499/2VFS5F7
 ZEnZ38sYZeSfjIoo7frFrB9sJ/LZgeKO38uZ5BNFE2ely5tCXf85y30ycbMV/2Al8x2G
 aFrhzBMVdEFYniGLVxrbPIGoIzvIIRmf08h42va912XJGg2qF69Y/hI71cQfKuAhxknR
 W7IA==
X-Gm-Message-State: AOJu0Yw78xSxwa1lkrXl8B4gn21eUfiE29JARwqI9NA7DuJ83g0JOIql
 zgENYxPoc/GxQzZsfGc+YbVn5PqPY8vPI0Fw8wyGvIQkmNxF5DG9X5Qi4aruxEkLmb4hJ5FOkPd
 G
X-Google-Smtp-Source: AGHT+IGi7qHbMvW3I6Iw5RUVLo7xmft+iw2KLLn6Y+xnN9FmpFRZdPN2L1c9KAXdFtT9UL/FhtAmaQ==
X-Received: by 2002:a05:6a20:c888:b0:19e:cbe9:63b with SMTP id
 hb8-20020a056a20c88800b0019ecbe9063bmr7296283pzb.3.1708934711347; 
 Mon, 26 Feb 2024 00:05:11 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.32]) by smtp.gmail.com with ESMTPSA id
 k2-20020aa788c2000000b006e13a88d52esm3392842pff.61.2024.02.26.00.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:05:11 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, francesco@dolcini.it, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org,
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 0/8] imx8mp: Enable PCIe/NVMe support
Date: Mon, 26 Feb 2024 13:34:25 +0530
Message-Id: <20240226080433.3307154-1-sumit.garg@linaro.org>
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

Sumit Garg (8):
  clk: imx8mp: Add support for PCIe clocks
  reset: imx: Add support for i.MX8MP reset controller
  imx8mp: power-domain: Add PCIe support
  imx8mp: power-domain: Expose high performance PLL clock
  phy: phy-imx8m-pcie: Add support for i.MX8M{M/P} PCIe PHY
  pci: Add DW PCIe controller support for iMX8MP SoC
  verdin-imx8mp_defconfig: Enable PCIe/NVMe support
  MAINTAINERS: Add entry for PCIe DWC IMX driver

 MAINTAINERS                           |   6 +
 configs/verdin-imx8mp_defconfig       |   6 +
 drivers/clk/imx/clk-imx8mp.c          |   6 +
 drivers/pci/Kconfig                   |   8 +
 drivers/pci/Makefile                  |   1 +
 drivers/pci/pcie_dw_imx.c             | 314 ++++++++++++++++++++++++++
 drivers/phy/Kconfig                   |   9 +
 drivers/phy/Makefile                  |   1 +
 drivers/phy/phy-imx8m-pcie.c          | 269 ++++++++++++++++++++++
 drivers/power/domain/imx8mp-hsiomix.c | 179 +++++++++++++--
 drivers/reset/reset-imx7.c            | 114 ++++++++++
 11 files changed, 890 insertions(+), 23 deletions(-)
 create mode 100644 drivers/pci/pcie_dw_imx.c
 create mode 100644 drivers/phy/phy-imx8m-pcie.c

-- 
2.34.1

