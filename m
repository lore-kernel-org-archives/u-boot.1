Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF8DC02181
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 01:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDF5A803B5;
	Thu, 23 Jan 2025 02:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NNlyEAU+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC66580762; Thu, 23 Jan 2025 02:08:03 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9781E80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 02:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50N17x0U1109005
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2025 19:07:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737594479;
 bh=qBcHeD4Bu56RaRaqzf0SfKXPwZmM79mL5qrUueCFeWU=;
 h=From:To:CC:Subject:Date;
 b=NNlyEAU+uo1buwe2E4NNiJw4YKrMti/5GojYCeooHQLtHaxxnMVJBoaTq+LtlgkVq
 +YUE00sXxBK7D38+kB49b4w9hIpWK8/X8o/BHJlA0dYSYkbaKcnXiZbSsqwAD0CBbh
 nOeuzCNkKWB825d+PK+n5yZulLM+W///7/Tkp2yY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50N17xmd064220
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Jan 2025 19:07:59 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Jan 2025 19:07:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Jan 2025 19:07:59 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50N17xaP066772;
 Wed, 22 Jan 2025 19:07:59 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 0/4] Introduce K3 remoteproc driver for M4 subsystem
Date: Wed, 22 Jan 2025 19:07:55 -0600
Message-ID: <20250123010759.810799-1-jm@ti.com>
X-Mailer: git-send-email 2.48.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Some K3 devices like am62x and am64x have a M4 processor in the MCU
voltage domain. This patch series introduces remoteproc M4 driver which
will be used to load firmware into and start the M4 remote core.

This series also adds support for R5F cores on am64x SoCs in patch 2/4,
sets up environment to load FW in remote cores in patch 3/4, and enables
config options for R5F and M4 remoteproc support in patch 4/4.

This patch series was tested on am64x EVM using commands:

=> setenv dorprocboot 1
=> run boot_rprocs

Hari Nagalla (4):
  remoteproc: k3-m4: Introduce K3 remote proc driver for M4 subsystem
  remoteproc: k3-r5: Add support for R5F cores on AM64x SoCs
  env: ti: am64x: set rproc_fw_binaries
  configs: am64x_evm_a53_defconfig: Enable R5F and M4 remote proc
    support

 board/ti/am64x/am64x.env             |   6 +
 configs/am64x_evm_a53_defconfig      |   2 +
 drivers/remoteproc/Kconfig           |  10 +
 drivers/remoteproc/Makefile          |   1 +
 drivers/remoteproc/ti_k3_m4_rproc.c  | 411 +++++++++++++++++++++++++++
 drivers/remoteproc/ti_k3_r5f_rproc.c |   2 +
 6 files changed, 432 insertions(+)
 create mode 100644 drivers/remoteproc/ti_k3_m4_rproc.c

-- 
2.48.0

