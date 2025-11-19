Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C036DCF34DA
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CED0483FC5;
	Wed, 19 Nov 2025 16:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="f5MKSUiN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFF7383DBF; Wed, 19 Nov 2025 13:35:19 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D30A83952
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 13:35:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4116289e6=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1763555717; x=1795091717;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RshcKYi3cY63Q8KtjNFSaTYrQ5ySuDW1ipqxBgOG4XA=;
 b=f5MKSUiN2c8UiobiqfCgWmwLGA5nphNweydoQGkP589OpKO9JQI07IWy
 C7C+A3NRsrRW9ZrM2WDWKDqxHXrLJHm09uJhI1yCxdwqw5N7EnTRuq7xd
 +EikzXaEqSc3omFXv0k18fRONpEMTB28GQPio0EJtidtt/zZeVSy0bOLd
 j1ixk9hKhIm5TIZ6iBMqF9EsfdTcC75ARibyeroBt96UKWVhw08CzqHOD
 Qm5L4nbhH9f88VZy8bj8c/TYPfrGXJG1c1wlu+lZOl3ObuCr6IO2hfs9Q
 v4UW5J7uULANGPbhjq1BfgNVMhTKLmavmAnUdIp4bpXeDNO7pMYE64KO8 g==;
X-CSE-ConnectionGUID: s8V0RJAGRayRdCV3CvjQew==
X-CSE-MsgGUID: wu3A89ZkSnaUi0zHh4CszA==
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="49379171"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 05:35:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 19 Nov 2025 05:35:13 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 19 Nov 2025 05:35:11 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>, Leo
 <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, Yao Zi
 <ziyao@disroot.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 <jamie.gibbons@microchip.com>
Subject: [PATCH 0/2] Add MPFS CPU Implementation
Date: Wed, 19 Nov 2025 12:38:41 +0000
Message-ID: <20251119123843.4171699-1-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 19 Nov 2025 16:39:33 +0100
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

The following series creates a custom CPU implementation for Microchip's
PolarFire SoC as it needs a custom implementation of top_of_ram().
Since there are multiple boards that use the PolarFire SoC, some kconfigs that
are determined at a CPU level are moved from the board kconfigs.

Thanks
Jamie.

Conor Dooley (2):
  riscv: create a custom CPU implementation for PolarFire SoC
  riscv: mpfs: move SoC level options to the CPU Kconfig

 arch/riscv/Kconfig                     |  1 +
 arch/riscv/cpu/mpfs/Kconfig            | 33 ++++++++++++++++++++++
 arch/riscv/cpu/mpfs/Makefile           |  6 ++++
 arch/riscv/cpu/mpfs/cpu.c              | 22 +++++++++++++++
 arch/riscv/cpu/mpfs/dram.c             | 38 ++++++++++++++++++++++++++
 arch/riscv/include/asm/arch-mpfs/clk.h |  8 ++++++
 board/microchip/mpfs_generic/Kconfig   | 24 ++--------------
 7 files changed, 110 insertions(+), 22 deletions(-)
 create mode 100644 arch/riscv/cpu/mpfs/Kconfig
 create mode 100644 arch/riscv/cpu/mpfs/Makefile
 create mode 100644 arch/riscv/cpu/mpfs/cpu.c
 create mode 100644 arch/riscv/cpu/mpfs/dram.c
 create mode 100644 arch/riscv/include/asm/arch-mpfs/clk.h

-- 
2.43.0

