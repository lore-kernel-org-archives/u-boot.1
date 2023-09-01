Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2A7CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 06:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F58B86725;
	Fri,  1 Sep 2023 08:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d+lvQeZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51C3086205; Fri,  1 Sep 2023 08:15:27 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DF1886205
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 08:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3816FJPr074575;
 Fri, 1 Sep 2023 01:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693548919;
 bh=NefKRWoG99DWm+4teMXT5C9FTnCi753Kex/X5wgrCR8=;
 h=From:To:CC:Subject:Date;
 b=d+lvQeZBBX+2AKXxsm+LcpuYetdzz1yXSPqrjNonkRWwOYYGw4ZiyTfCVmPf7y03C
 s6+wn2w9nlZm93rvg9un9aHL5mOSDUI+Ff/Tv4bevNwvhxfc4OXC3yaQWz2RfVPwj6
 sD4tjbNA3oYGzYK3C3otg1TNNDOjjs3HRFl65JO4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3816FJNL061041
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Sep 2023 01:15:19 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Sep 2023 01:15:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Sep 2023 01:15:19 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3816FF0L047686;
 Fri, 1 Sep 2023 01:15:16 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>
CC: <peng.fan@nxp.com>, <ye.li@nxp.com>, <robimarko@gmail.com>,
 <u-boot@lists.denx.de>, <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 0/2] thermal: Add VTM driver support for J72xx SOCs
Date: Fri, 1 Sep 2023 11:44:58 +0530
Message-ID: <20230901061500.2342452-1-u-kumar1@ti.com>
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

This series adds VTM (Voltage and Thermal Manager) driver support
for J72xx SOCs.

Basically this driver is ported from kernel v6.5 to u-boot.
Main purpose of this driver to program thermal shutdown value
and provide SOC temperature.

To use this driver, update in device tree and defconfig are  needed.

Device tree sync is under review with series
https://lore.kernel.org/all/20230822185725.6718-1-reidt@ti.com/
Once above DT sync series will be merged, another patch will be posted
to update defconfig.
For now marking DT and defconfig update as donotmerge.

Boot logs:
https://gist.github.com/uditkumarti/fca15b10abe4c756b7889a8dc45bad57
line 67, u-boot temperature and line 778 temperature reported by OS

Udit Kumar (2):
  thermal: k3-j72xx-bandgap: Add support for vtm
  DONOTMERGE: j7200: device tree and defconfig

 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi |   9 +
 configs/j7200_evm_a72_defconfig       |   3 +
 drivers/thermal/Kconfig               |   6 +
 drivers/thermal/Makefile              |   1 +
 drivers/thermal/k3_j72xx_bandgap.c    | 539 ++++++++++++++++++++++++++
 5 files changed, 558 insertions(+)
 create mode 100644 drivers/thermal/k3_j72xx_bandgap.c

-- 
2.34.1

