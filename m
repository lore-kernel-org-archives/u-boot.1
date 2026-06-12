Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B497ACD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 20:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 202AB8488A;
	Fri, 12 Jun 2026 22:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pPMHZpUm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A88684878; Fri, 12 Jun 2026 22:19:16 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD13A8063E
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 22:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-5176ca6bab1so16096821cf.0
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 13:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781295552; x=1781900352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1sb14WIHvJrBNJV6Wxe9l+TW/PjiDweIMgcHm2dJQG4=;
 b=pPMHZpUmrC/+yWtXiblNp/jPy96y+l2tK7xsIEJuUh9Kg+ScMraukIALPDLngq+OEC
 lJIqpi46m5VuPNXX3GD4er3JVQY1bFWbsUqeOqsZS3/uqtY+uOpLjJpGsXZwNAuIGMJ3
 t982dT45osMp4B+AfWngd3n6udSBdJnif/hnFpxrrUP51xmRAWoZcuSpWGq5s+9ByKKT
 2gamVkXcPikWcncvi35rwSTGvzRLgM1eNUy+eMX05f4492WThCXgIkwx+kLjq23DrG2o
 t1k3XySLVnLvpjS4akch/xfmduvbx+ZR6S2lQ4c5Oin+osL3abA7QtgQ7+0I2coZaRIR
 +2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781295552; x=1781900352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1sb14WIHvJrBNJV6Wxe9l+TW/PjiDweIMgcHm2dJQG4=;
 b=of+rBnCrJxT9qJiXHuRfDgFrHqDUSX9RZUybAj2EblYxoyeMKly1KBAGJ2KhquXXWC
 bR7Wwmu3uAS2wpu/Vnu+ennoO6eYGYsg4v0DFruxpDBVL6POprfB8HjfLinyvRA3Xc1D
 IivvSkTwPakDsBkDuooPvWI3KZRBN2Zit2B1P59xq96auR5BS1dokhvqqpu3d8abz9ww
 piG5IZr46oXttemSEFC7Ejz84m+KxeACFSxOKYHHQmbiIeSjXnKEx+2lvr97JT2IyNWO
 sojfPk6G0ffYR7orsiQ4MC5ZL0ICzrOTjt9Slvc+6ZaEN2tlRYlb6TC951hB4qmr3HKV
 X4ng==
X-Gm-Message-State: AOJu0YwC+EljeO+XaH/AFpvEaleSeuzsDXyRaD0f4ZQ1x9+xhG3rHou7
 Sop6Kxllbs4zAK9QG0JA0C3EefN3OjpwT9LlSc/GxFEc8NBrLgHI6vNH9D2KBv23
X-Gm-Gg: Acq92OHjf96F0olEJUuDrhaCcHzZYkYXkOdEGN5dNBcljRZqt6W7AUDaNdEOdV2lXbb
 MiNjVRnZRN0uaXSEI591szY/OMj6Cza451f3NrIFU/LQhQa4m+TKx8wUaVZj7KdpRxOl3JgZ3Oq
 bnlD2yjF9YV4ksfiaUt8K4aXRG8TKjym4BYbqR+JNFSzzS8hSFzQz1CDOLLKKM/x3hQULCreEjr
 1NB7OQMIAqFomppiypBvE8ywBJ1mkV+bPbyWSCC7LEzg8IwPpEyGChBXPy64PfLLdZkQpeudT/V
 snJwQN95JNz4wwBufQQBitj9oT0z5iy++iEAIQBgpmem+traJabu2S2gf3HNQqHNzmUg33b7fIM
 0+BW44gg0UQYctOYbL7qEtWIqctuM8b+L9XVTkS85bAjN0aIAhT5BdjwyJw/82b1RxpqfS+TH2e
 BLTQXJI/nt4OKdUDt3Y4bLv3hEIf84QrAkwoejOOCgdijgRzTwasxg/bRUeMQsU87xxmzDANX9y
 E4r7Jt/
X-Received: by 2002:a05:622a:1451:b0:50d:7ca3:379a with SMTP id
 d75a77b69052e-517fed38156mr53088041cf.3.1781295552340; 
 Fri, 12 Jun 2026 13:19:12 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb7a3c4asm31304551cf.14.2026.06.12.13.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 13:19:11 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 0/8] Add SD card and eMMC support for SpacemiT K1
Date: Fri, 12 Jun 2026 16:18:53 -0400
Message-Id: <20260612201901.73657-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

This series adds MMC support for the SpacemiT K1: an SDHCI platform
driver, the SD card device-tree overlay, defconfig options, and SPL
boot-device selection from the SoC strap/config registers. The SDHCI
driver is usable in both SPL and U-Boot proper.
    
It also carries two generic cmd/meminfo fixes needed on K1, whose DRAM
is larger than 4 GB and split across two banks with an address hole:
widen the printed addresses to phys_addr_t, and account LMB regions per
bank.
    
A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
write images to eMMC.
    
This series sits on top of three series still under review, and must be
applied after them, in this order:
    
1. K1 clock/reset/dts migration v2 [1]  (8 patches)
2. K1 SPL bring-up v4 [2]              (14 patches)
3. K1 pinctrl/GPIO and SPI NOR v2 [3]   (9 patches)
Then this series                        (8 patches)
    
[1] https://lore.kernel.org/u-boot/20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com/
[2] https://lore.kernel.org/u-boot/20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com/
[3] https://lore.kernel.org/u-boot/20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com/
    
Guodong Xu (8):
  spacemit: k1: select boot device via config registers
  mmc: k1: add sdhci platform driver
  dts: k1: add SD card support in u-boot overlay
  configs: k1: enable SD and eMMC support
  doc: spacemit: flash on K1 SoC based boards
  cmd: meminfo: widen memory map addresses to phys_addr_t
  cmd: meminfo: fix the lmb info for large DRAM
  cmd: tlv_eeprom: fix accessing invalid parameter

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  87 +-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  82 +-
 board/spacemit/k1/MAINTAINERS             |   3 +-
 board/spacemit/k1/spl.c                   |  77 +-
 cmd/meminfo.c                             |  53 +-
 cmd/tlv_eeprom.c                          |   2 +-
 configs/spacemit_k1_defconfig             |  17 +
 doc/board/spacemit/index.rst              |   1 +
 doc/board/spacemit/k1-flash.rst           | 157 ++++
 drivers/mmc/Kconfig                       |   7 +
 drivers/mmc/Makefile                      |   1 +
 drivers/mmc/spacemit_sdhci.c              | 934 ++++++++++++++++++++++
 12 files changed, 1401 insertions(+), 20 deletions(-)
 create mode 100644 doc/board/spacemit/k1-flash.rst
 create mode 100644 drivers/mmc/spacemit_sdhci.c

-- 
2.25.1

