Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294C6D2F7EF
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 06:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BF2288C05;
	Thu, 17 Oct 2024 08:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aU0DIaEh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A21E88D5B; Thu, 17 Oct 2024 08:37:25 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D59888B8F
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 08:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49H6bIlu025543;
 Thu, 17 Oct 2024 01:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729147038;
 bh=tn/yOZdESwgNqvIO8ldow/TnHfN4aFZKWplKyfobYe4=;
 h=From:To:CC:Subject:Date;
 b=aU0DIaEhneQISpVRqfkxCnq0rn7VArav3LINlwzM8bN8LKCaY2CpXqBcfHr97GYrw
 lXUjTdOlfngrB+QqYvqPa03liW6OUeOhLtWyqxdfMyZg8LmLZnkrgCJjwX/ngcDCYF
 B4wuV7Kp5kDxWY70xJ2+Ez8m9J1wbPnYHaip+Mc4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49H6bIB1028552
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Oct 2024 01:37:18 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Oct 2024 01:37:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Oct 2024 01:37:18 -0500
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49H6bFOT090460;
 Thu, 17 Oct 2024 01:37:16 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH 0/6] Add OPP_LOW support for J7200
Date: Thu, 17 Oct 2024 11:59:07 +0530
Message-ID: <20241017062911.2241167-1-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
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

This series adds OPP_LOW spec data in k3_avs driver and enables a config
option to select the OPP_LOW performance point.

AVS test logs (CONFIG_K3_OPP_LOW enabled and dummy efuse value):
https://gist.github.com/aniket-l/3bdb454d2416e1900dce795ce6090507

J7200 SOC supports OPP_LOW and OPP_NOM as two Operating Performance
Points as per (7.5 Operating Performance Points) section in the
Datasheet [0].
- A72SS/MSMC at 2 GHz/1GHz operation must use OPP_NOM.
- A72SS/MSMC at 1 GHz/500 MHz operation can use OPP_NOM or OPP_LOW
  voltage (though OPP_LOW voltage is recommended to reduce power
  consumption).

The actual OPP voltage for the device is read from the efuse and
updated in k3_avs_probe().

The default j7200 devicetree and k3_avs driver set OPP_NOM spec
frequency and voltage.

In the board init file, if K3_OPP_LOW config is enabled, Check if
OPP_LOW AVS voltage read from efuse is valid and update frequency and
voltage as per the OPP_LOW spec.

[0]: https://www.ti.com/lit/gpn/dra821u  (J7200 Datasheet)


Reid Tonking (6):
  arm: dts: k3-j7200-r5-common: Add msmc clk to a72 node
  misc: k3_avs: Add OPP_LOW voltage and frequency to vd_data
  misc: k3_avs: Add k3_check_opp function
  arm: mach-k3: j721e-init.c: J7200: Add support for CONFIG_K3_OPP_LOW
  configs: j7200_evm_r5_defconfig: Define K3_OPP_LOW
  DONOTMERGE: For testing only

 .../arm/dts/k3-j7200-r5-common-proc-board.dts | 10 ++--
 arch/arm/mach-k3/Kconfig                      |  6 +++
 arch/arm/mach-k3/j721e/j721e_init.c           | 54 ++++++++++++++++++-
 configs/j7200_evm_r5_defconfig                |  1 +
 drivers/misc/k3_avs.c                         | 36 +++++++++++++
 include/k3-avs.h                              |  2 +
 6 files changed, 103 insertions(+), 6 deletions(-)

-- 
2.34.1

