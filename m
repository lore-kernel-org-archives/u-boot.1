Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84D6C87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 12:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFF9183A95;
	Fri,  1 Aug 2025 14:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="u5ZXj5um";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28826839F1; Fri,  1 Aug 2025 14:32:53 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD7583A89
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 14:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=301ae58c2=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1754051567; x=1785587567;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=t9qZO1NgUpL0MtynuZm3EE8wCQZNoIx/JefXnysYruc=;
 b=u5ZXj5umq6Kt8DEDusXRH3HytQTKGMjcexmBCdF2uKS5Aj9yScoTB9Fd
 BSc2Mit2v/t8onF3OTwOpYlLb8sH1x/9zW3LYIQWtihysyJ/Z9SbN6oEi
 WCtMt0lzxtjcAJqr/tMkhy8m0AaujfFQH5iJO40oSPSYyKEFC7EwvMI0e
 Be9CxV170k+gyGfkH3T8wnWsyqmPVrnTc9ZDI3sQldDKvlxEt6BaNnoWK
 hpKjG5kq3Qk5bxAHHEFGoifwK1BaKw+CyMZmncvXkp5Rg04bEIky1kn2O
 rkTKliNQrjP6earnwb+7kt/ZljNLAjgijafWn9zeZzmZpdGSY2mzFJIwl w==;
X-CSE-ConnectionGUID: MeqoYqJ8TL+1crWCDCcF1g==
X-CSE-MsgGUID: wPlzXeOeQDWuihlBCwKiBg==
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; d="scan'208";a="44692469"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Aug 2025 05:32:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 1 Aug 2025 05:32:20 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 1 Aug 2025 05:32:18 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Cyril Jean
 <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 0/6] MPFS Icicle Kit Cleanup
Date: Fri, 1 Aug 2025 13:36:20 +0100
Message-ID: <20250801123626.1972658-1-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 01 Aug 2025 14:41:57 +0200
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

Hi all,

The following patch series completes a series of cleanups for Microchip's MPFS
Icicle Kit. This includes making use of the CONFIG_OF_BOARD_SETUP functionality
to move the ethernet mac address setting to the ft_board_setup() function which
allows replacing fdt set in boot scripts for Microchip's MPFS Icicle kit.

Additionally, the Icicle Kit board file is further cleaned up with the
addition of two new drivers - mailbox and system controller - to move all
functions which interact with the system controller and which can be reused in
other areas out of the board file.

Regards,
Jamie Gibbons

Jamie Gibbons (6):
  configs: microchip_mpfs_icicle: enable CONFIG_OF_BOARD_SETUP
  board: microchip: mpfs_icicle: make use of ft_board_setup()
  mailbox: add PolarFire SoC mailbox driver
  misc: add PolarFire SoC system controller
  board: microchip: mpfs_icicle: enable new driver configs
  board: microchip: mpfs_icicle: update to use system controller

 board/microchip/mpfs_icicle/Kconfig       |   4 +
 board/microchip/mpfs_icicle/mpfs_icicle.c | 121 +++++++--------
 configs/microchip_mpfs_icicle_defconfig   |   4 +
 drivers/mailbox/Kconfig                   |   7 +
 drivers/mailbox/Makefile                  |   1 +
 drivers/mailbox/mpfs-mbox.c               | 177 ++++++++++++++++++++++
 drivers/misc/Kconfig                      |   9 ++
 drivers/misc/Makefile                     |   1 +
 drivers/misc/mpfs_syscontroller.c         | 157 +++++++++++++++++++
 include/mpfs-mailbox.h                    |  67 ++++++++
 10 files changed, 484 insertions(+), 64 deletions(-)
 create mode 100644 drivers/mailbox/mpfs-mbox.c
 create mode 100644 drivers/misc/mpfs_syscontroller.c
 create mode 100644 include/mpfs-mailbox.h

-- 
2.43.0

