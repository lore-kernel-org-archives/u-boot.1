Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2426FC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 10:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 655538871E;
	Tue, 21 May 2024 12:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bBtd5DiK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F108812B; Tue, 21 May 2024 12:57:11 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56C4B88748
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 12:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44LAv0oF058129;
 Tue, 21 May 2024 05:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716289020;
 bh=uV3qOWgzW42YibrnRs74SCoaECUVLISftLC/RV3OfDY=;
 h=From:To:CC:Subject:Date;
 b=bBtd5DiKPs6hW9GUII74efbhzMcDrOJoxgfLtHhZTAn2NZGdU2TaBJ4RgaZ3A2unl
 5KfuYfFyOozHoYbhbO1FRQ6I9PIQ4WYcl6Zt1TMv3XSBeVcg7T0rKWoR7Ba0YGHN6z
 usch/LNePmh40mGC4vuOCx7bVWcMHKXWnSNCCIW4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44LAv0x5041761
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 21 May 2024 05:57:00 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 05:57:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 05:56:59 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44LAurAf047424;
 Tue, 21 May 2024 05:56:54 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <trini@konsulko.com>
CC: <joe.hershberger@ni.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <devarsht@ti.com>, <sjg@chromium.org>, <emanuele.ghidoli@toradex.com>,
 <matthias.schiffer@ew.tq-group.com>, <a-bhatia1@ti.com>,
 <vitor.soares@toradex.com>, <danishanwar@ti.com>,
 <andriy.shevchenko@linux.intel.com>, <bmeng.cn@gmail.com>,
 <mkorpershoek@baylibre.com>, <s-vadapalli@ti.com>,
 <u-boot@lists.denx.de>, <joao.goncalves@toradex.com>,
 <hnagalla@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 0/4] Adding support to load secure firmware for HS devices
Date: Tue, 21 May 2024 16:26:44 +0530
Message-ID: <20240521105648.3780072-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Some use case needs rproc firmware to be loaded at u-boot stage,
using following commands at u-boot shell, firmware could be loaded

=> setenv dorprocboot 1
=> run boot_rprocs

For Secure devices, secure version of rproc firmware should be loaded,
which is appended by sec keyword[0].
but currently non-secure firmware is loaded even for secure devices.
So adding support for loading secure firmware on Secured devices.

[0]: https://gist.github.com/uditkumarti/cd8bf6a448079b59145d17a0e8bf13b7

Bootlogs:
GP : https://gist.github.com/uditkumarti/23a00c313e1c28b62537aab733a585df#file-gp_device line 65 onwards
HS : https://gist.github.com/uditkumarti/23a00c313e1c28b62537aab733a585df#file-hs-device line 60 onwards


Manorit Chawdhry (3):
  include: mach-k3: move k3 security functions to security.h
  drivers: remoteproc: ti_k3 : enable secure booting with firmware
    images
  mach-k3: common.c: add a flag for booting authenticated rproc binaries

Udit Kumar (1):
  include: env: ti: Add support for secure firmwares

 arch/arm/mach-k3/common.c                |  4 +++-
 arch/arm/mach-k3/common.h                |  4 ++--
 arch/arm/mach-k3/include/mach/security.h | 11 +++++++++++
 drivers/remoteproc/ti_k3_dsp_rproc.c     |  4 ++++
 drivers/remoteproc/ti_k3_r5f_rproc.c     |  4 ++++
 include/env/ti/k3_rproc.env              |  6 +++++-
 include/env/ti/ti_common.env             |  1 +
 7 files changed, 30 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-k3/include/mach/security.h

-- 
2.34.1

