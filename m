Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5DFC02192
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 01:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D8158081E;
	Thu,  6 Feb 2025 02:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uCBEgp6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4BD7806FB; Thu,  6 Feb 2025 02:54:13 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1807480104
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 02:54:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5161s7A63463772
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Feb 2025 19:54:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738806847;
 bh=6nWQkzMr+aHQ3xbd/RzN+CKM3S70Xf8CGukVpE0jxoQ=;
 h=From:To:CC:Subject:Date;
 b=uCBEgp6eT2V0WIXMcOVMRfNHMPwUU2usnBsrA/ZAwXA3dSQgeT9iFsCSh6l99OfAm
 rq4l9vVSvgqsl6kJ0pMr+ThCewuGjWVyy0/lQPCIV8Obcq6PqgfLptl/GZHQz4tieO
 1e9jaIUxekQAzMoL/jG/O2PEvY/UZTjI5F9e/OVY=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5161s7ZK010843
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Feb 2025 19:54:07 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Feb 2025 19:54:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Feb 2025 19:54:06 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5161s67u036392;
 Wed, 5 Feb 2025 19:54:06 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Judith
 Mendez <jm@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v4 0/6] Introduce K3 remoteproc driver for M4 subsystem
Date: Wed, 5 Feb 2025 19:54:00 -0600
Message-ID: <20250206015406.2702944-1-jm@ti.com>
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

This series also adds support for R5F cores on am64x SoCs in patch 2,
sets up environment to load FW in remote cores in patch 3,4,5 and enables
config options for remoteproc support in patch 6.

This patch series was tested on am64x EVM using commands:

=> setenv dorprocboot 1
=> run boot_rprocs

Changes since v3:
- Add patches 4 and 5 for remoteproc env support on am62x & am62px
- Fix implicitly include warning
- Add remoteproc support configs for am62x
- Cleanup remoteproc configs for am62p and am64x.

Hari Nagalla (6):
  remoteproc: k3-m4: Introduce K3 remote proc driver for M4 subsystem
  remoteproc: k3-r5: Add support for R5F cores on AM64x SoCs
  board: ti: am64x: Add remoteproc specific env support
  board: ti: am62x: Add remoteproc specific env support
  board: ti: am62px: Add remoteproc specific env support
  configs: am6*_evm_a53_defconfig: Enable remoteproc support

 board/ti/am62px/am62px.env           |   6 +
 board/ti/am62x/am62x.env             |   6 +
 board/ti/am64x/am64x.env             |   6 +
 configs/am62px_evm_a53_defconfig     |   1 -
 configs/am62x_evm_a53_defconfig      |   2 +
 configs/am64x_evm_a53_defconfig      |   4 +-
 drivers/remoteproc/Kconfig           |  10 +
 drivers/remoteproc/Makefile          |   1 +
 drivers/remoteproc/ti_k3_m4_rproc.c  | 371 +++++++++++++++++++++++++++
 drivers/remoteproc/ti_k3_r5f_rproc.c |   2 +
 10 files changed, 407 insertions(+), 2 deletions(-)
 create mode 100644 drivers/remoteproc/ti_k3_m4_rproc.c


base-commit: 021baf7b08cceb58bb850859dba1614424e16a83
-- 
2.48.0

