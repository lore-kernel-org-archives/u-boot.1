Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0974CC35FF1
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 03:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 650DB81D0B;
	Mon, 17 Mar 2025 04:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742181358;
	bh=q41AHThmHlNYqet5vG1wq+1CSIYxPKKFzH7dNRsOtKc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WCvrV83sNtUrlybL5mdvq9XNJ5jSsyk3bNvdLIK5qjceSLWzUGjgxONr2fRlHaS8A
	 m8lJOhaM9zWntsgE0FeyOT3ipVonlj1YZFhxLTfstugCFu7wbH5QYow+lSaq5ZMlTD
	 5jTrNRf0iIWBk2wFyTzIbTTMWwS0w9po3QPIjWWhupbi6vWUpepcwmo9dbxPOD5g6h
	 OBFfnPgfK1kkdZD/Vw7okclq/i0LFLMKDADGzg9Swp2m4hQI/v75RxLuraeCs7tV8C
	 QVBk/pfSDqtE/jp84FuwlDKfPXgp8jfhagx1KG6+cvY0XP6hcYPAn9XGOqsW/gAfP7
	 cTdqwizAKwzEA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 023FF81D0B; Mon, 17 Mar 2025 04:15:58 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E20E810EB
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 04:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="SaaBF9FG"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 487FD103D1FFE; Mon, 17 Mar 2025 04:15:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742181355; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=q41AHThmHlNYqet5vG1wq+1CSIYxPKKFzH7dNRsOtKc=;
 b=SaaBF9FGw0dzVwh3v7Hi8t+W/8+i7FwnN1YZbCXhe6gNJJLSuM2lhtfL4cO+eTub/VT4bw
 jzbbv0U7UBtCcnp4/WchjeJR46rnHsusA55WizsLgBIM/DNEjHnLAqwP3Gdk+T9gb0MSHl
 qLboD22QZZFntOPH9gozLhDOEheo6KBzAau5cBghwhL3056fc6HGVje0TUppb5Nfy9p5nI
 6/po8zgATYCbkZVxXpJVnsDGEzpccshy8Yv5OUoetca/Pf4xwA1EaMxy7oPvJhqypbrq/S
 jsswBGv4XuDwsMVYIa4FUpGbiE5rWBJ5028l53pevTl2MBy66ZlWmhjX44rpuQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PULL] u-boot-usb/next
Date: Mon, 17 Mar 2025 04:15:23 +0100
Message-ID: <20250317031542.223248-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The following changes since commit 0e1fc465fea62ebae91f2f56cb823e8b37ee1077:

  Merge tag 'dm-pull-15mar25' of git://git.denx.de/u-boot-dm into next (2025-03-15 08:19:31 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git next

for you to fetch changes up to b0e75b4fb0bdecdcec59ff6f72d02513ad466272:

  configs: starfive: Add visionfive2 cadence USB configuration (2025-03-17 01:55:19 +0100)

----------------------------------------------------------------
Minda Chen (7):
      usb: cdns3: Set USB PHY mode in cdns3_drd_update_mode()
      phy: starfive: Add Starfive JH7110 USB 2.0 PHY driver
      phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY driver
      usb: cdns: starfive: Get dr mode from wrapper device dts node
      usb: cdns: starfive: Add cdns USB driver
      spl: starfive: visionfive2: Disable USB overcurrent pin by default.
      configs: starfive: Add visionfive2 cadence USB configuration

 arch/riscv/include/asm/arch-jh7110/gpio.h    |   5 +
 board/starfive/visionfive2/spl.c             |   3 +
 configs/starfive_visionfive2_defconfig       |  10 ++
 drivers/phy/Kconfig                          |   1 +
 drivers/phy/Makefile                         |   1 +
 drivers/phy/starfive/Kconfig                 |  21 +++
 drivers/phy/starfive/Makefile                |   7 +
 drivers/phy/starfive/phy-jh7110-pcie.c       | 239 +++++++++++++++++++++++++++
 drivers/phy/starfive/phy-jh7110-usb-syscon.h |   9 +
 drivers/phy/starfive/phy-jh7110-usb2.c       | 162 ++++++++++++++++++
 drivers/usb/cdns3/Kconfig                    |   7 +
 drivers/usb/cdns3/Makefile                   |   1 +
 drivers/usb/cdns3/cdns3-starfive.c           | 182 ++++++++++++++++++++
 drivers/usb/cdns3/core.c                     |   3 +
 drivers/usb/cdns3/drd.c                      |  14 ++
 15 files changed, 665 insertions(+)
 create mode 100644 drivers/phy/starfive/Kconfig
 create mode 100644 drivers/phy/starfive/Makefile
 create mode 100644 drivers/phy/starfive/phy-jh7110-pcie.c
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb-syscon.h
 create mode 100644 drivers/phy/starfive/phy-jh7110-usb2.c
 create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
