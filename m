Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AF9C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 09:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C5B28832A;
	Tue, 16 Apr 2024 11:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rXmkOUBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5730B88319; Tue, 16 Apr 2024 11:20:48 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C324A8831C
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 11:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43G9KMh4079212;
 Tue, 16 Apr 2024 04:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713259222;
 bh=xifGd48IUa3Q029uJD7Ua8hQoIC2Z8qXKHtgLCfOLh0=;
 h=From:To:CC:Subject:Date;
 b=rXmkOUBZU/ZSqK9zpTqsH968J4ih7fP6B1R4TP6NphKBym1gHDqxvalq1RqcsjR4x
 +t8XraH8uP97qDSuK//tqNqwKSH22p7ggqYOiSarRIftLmW0iNf260Uz4QZZIQ19iF
 u/gAutIoVkD5j/FuS3J1P5YbIk6CqsSMgcxmfxbE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43G9KMHh128761
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 16 Apr 2024 04:20:22 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 04:20:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 04:20:21 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43G9KLxf024848;
 Tue, 16 Apr 2024 04:20:21 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43G9KLLD010770;
 Tue, 16 Apr 2024 04:20:21 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Bryan Brattlof <bb@ti.com>, Sean Anderson <seanga2@gmail.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Nishanth Menon <nm@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass
 <sjg@chromium.org>, MD Danish Anwar <danishanwar@ti.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Tim Harvey <tharvey@gateworks.com>, Tony Dinh
 <mibodhi@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>, Sumit Garg <sumit.garg@linaro.org>, Michal Simek
 <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kever
 Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>, Roger
 Quadros <rogerq@kernel.org>
Subject: [PATCH v4 0/6] Enable ICSSG Ethernet Driver for AM65x
Date: Tue, 16 Apr 2024 14:50:12 +0530
Message-ID: <20240416092018.3593039-1-danishanwar@ti.com>
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

The series introduces device tree and config changes and AM65x
to enable ICSSG driver. The series also enables SPL_LOAD_FIT_APPLY_OVERLAY
for AM65x in order to load overlay over spl.

The ICSSG2 node is added in device tree overlay so that it remains in
sync with linux kernel.

This series has been tested on AM65x SR2.0, and the ICSSG interface is
able to ping / dhcp and boot kernel using tftp in uboot.

The users need to set env variables fw_storage_interface, fw_dev_part,
fw_ubi_mtdpart, fw_ubi_volume to indicate which storage medium and
partition they want to use to load firmware files from. By default the env
fw_storage_interface=mmc and fw_dev_part=1:2 but users can modify these
envs as per their requirements.

This is the v4 of the series [1]. The series doesn't depend on any patch
and can be applied cleanly on u-boot/master

Changes from v3 to v4:
*) Separated the device tree and board specific changes into this series
   from the main series [1].
*) Added check for TARGET_AM654_A53_EVM config in board file as suggested
   by Dan Carpenter <dan.carpenter@linaro.org>
*) Rebased on latest u-boot/master.

[1] https://lore.kernel.org/all/20240124064930.1787929-1-danishanwar@ti.com/

MD Danish Anwar (6):
  arm: dts: k3-am654-base-board: Add ICSSG2 Ethernet support
  arm: dts: k3-am65x-binman: Add ICSSG2 overlay and configuration
  configs: am65x_evm_a53: Enable ICSSG Driver
  configs: am65x_evm_a53: add SPL_LOAD_FIT_APPLY_OVERLAY
  board: ti: am65x: Add check for k3-am654-icssg2 in
    board_fit_config_match()
  board: ti: am65x: Set fw_storage_interface and fw_dev_part ENVs

 arch/arm/dts/Makefile             |   4 +-
 arch/arm/dts/k3-am654-icssg2.dtso | 145 ++++++++++++++++++++++++++++++
 arch/arm/dts/k3-am65x-binman.dtsi |  65 +++++++++++++-
 board/ti/am65x/am65x.env          |   4 +
 board/ti/am65x/evm.c              |   9 +-
 configs/am65x_evm_a53_defconfig   |   2 +
 6 files changed, 221 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/dts/k3-am654-icssg2.dtso


base-commit: 6e316e3f397b5e01e98c5dd56cdbaab961daeedf
-- 
2.34.1

