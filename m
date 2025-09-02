Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F25CA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 12:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C599883A8F;
	Tue,  2 Sep 2025 14:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="F+hy6cS7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F90483A6A; Tue,  2 Sep 2025 12:07:36 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E85883A7A
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 12:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=333b0acd5=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1756807655; x=1788343655;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VYnWK+IJaAgKqqY5aeRO4Qpv2ubqmr3L4tw5JZv2koc=;
 b=F+hy6cS7+odfs32c51blm4//0C0ZTdsFKSdsv0KADaGfNi2q0gH/tHvE
 OkoVDEnkRvwREJohQM1iIAAGEQoH7/cQ3j7F0Hi00hsW4ovbIhWm9HBwW
 /iD9cB38vinE+2ubwY1C+KLLC1bBcMCsWu7AMdE/5Wg2PXciK7QhII64J
 cFEPUSzg9NN79FhjJ5SPS/1jz8TiVRI6U/wUL8ANUG8wfiCcr2FpxDQN9
 XPJ1L+hqPJQ5hO9iewVD6YwJJxt1EM7IK6pEM4hQ+yET7UA4yXtM4M3iL
 d5aeB7y87mzVRDVFwt7QlAYCE3ccr5hHaRJnevyecRC0R1aLdrBebkDJv A==;
X-CSE-ConnectionGUID: nZaRhOgDT8+FU/xp9gk6EQ==
X-CSE-MsgGUID: t97IOTPXSGiRmj9LggdXQA==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="277316045"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Sep 2025 03:07:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 2 Sep 2025 03:07:08 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 2 Sep 2025 03:07:07 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Cyril Jean
 <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 0/6] Make MPFS Generic
Date: Tue, 2 Sep 2025 11:10:57 +0100
Message-ID: <20250902101105.3218793-1-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 02 Sep 2025 14:59:00 +0200
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

The following patch series makes all Icicle Kit files generic. This supports
the addition of upcoming support for other MPFS boards.
The series also includes the addition of the MPFS Video Kit and updated
documentation.
Also included is the addition of functionality to the MPFS system controller
to read the device tree overlays on the board. This functionality is used on
the MPFS boards to support auto update.

Thanks,
Jamie.

Jamie Gibbons (6):
  board: microchip: icicle: rename all icicle files to generic
  configs/microchip_mpfs_generic_defconfig: add board
  doc: microchip: introduce common sections
  doc: microchip: add mpfs_video.rst
  misc: mpfs_syscontroller: add functions to read device tree overlays
  board: microchip: mpfs_generic: include processing of dtbos

 arch/riscv/Kconfig                            |   6 +-
 .../{mpfs_icicle => mpfs_generic}/Kconfig     |   6 +-
 board/microchip/mpfs_generic/MAINTAINERS      |   7 +
 .../{mpfs_icicle => mpfs_generic}/Makefile    |   2 +-
 .../mpfs_generic.c}                           |   2 +
 board/microchip/mpfs_icicle/MAINTAINERS       |   7 -
 ...onfig => microchip_mpfs_generic_defconfig} |   5 +-
 doc/board/microchip/index.rst                 |   1 +
 doc/board/microchip/mpfs_build_boot.rst       |  29 +
 doc/board/microchip/mpfs_common.rst           | 666 ++++++++++++++++
 doc/board/microchip/mpfs_design_hss.rst       |  37 +
 doc/board/microchip/mpfs_icicle.rst           | 743 +-----------------
 doc/board/microchip/mpfs_video.rst            | 105 +++
 drivers/misc/mpfs_syscontroller.c             | 200 +++++
 ...mpfs_icicle.h => microchip_mpfs_generic.h} |   0
 15 files changed, 1068 insertions(+), 748 deletions(-)
 rename board/microchip/{mpfs_icicle => mpfs_generic}/Kconfig (92%)
 create mode 100644 board/microchip/mpfs_generic/MAINTAINERS
 rename board/microchip/{mpfs_icicle => mpfs_generic}/Makefile (85%)
 rename board/microchip/{mpfs_icicle/mpfs_icicle.c => mpfs_generic/mpfs_generic.c} (98%)
 delete mode 100644 board/microchip/mpfs_icicle/MAINTAINERS
 rename configs/{microchip_mpfs_icicle_defconfig => microchip_mpfs_generic_defconfig} (84%)
 create mode 100644 doc/board/microchip/mpfs_build_boot.rst
 create mode 100644 doc/board/microchip/mpfs_common.rst
 create mode 100644 doc/board/microchip/mpfs_design_hss.rst
 create mode 100644 doc/board/microchip/mpfs_video.rst
 rename include/configs/{microchip_mpfs_icicle.h => microchip_mpfs_generic.h} (100%)

-- 
2.43.0

