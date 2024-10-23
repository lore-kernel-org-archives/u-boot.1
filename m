Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5641CF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D896A892CF;
	Wed, 23 Oct 2024 15:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FzCYMXY2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 711378925A; Wed, 23 Oct 2024 15:02:25 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8342A8925A
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=a-limaye@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49ND2EHX030252;
 Wed, 23 Oct 2024 08:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729688534;
 bh=OMEx0F9d5Gu/AwFVKFSijIa68illH6W6lVHju+Wiuws=;
 h=From:To:CC:Subject:Date;
 b=FzCYMXY25SQHzqmP6Jpuft6dd0XQaF6TvMrAjsB6AIHxHwtmz4ejUj/OQ1HFJM2iP
 3g1ciCzE1jMYc85W3eOd6UXzXhCCn5OvczT0PH30tOnlwVVk9f5Xwddpi9pj1lrApg
 nqzLETQz7zc9P0491Ajy+tM62RvBPx0CocxVuHLs=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49ND2EhY027945
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Oct 2024 08:02:14 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 08:02:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 08:02:13 -0500
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49ND2BPx037622;
 Wed, 23 Oct 2024 08:02:12 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v2 0/5] Add OPP_LOW support for J7200
Date: Wed, 23 Oct 2024 18:27:08 +0530
Message-ID: <20241023130033.1826413-1-a-limaye@ti.com>
X-Mailer: git-send-email 2.47.0
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
OPP_LOW AVS voltage read from efuse is valid and update frequency (A72
and MSMC) and voltage (VDD_CPU) as per the OPP_LOW spec.

[0]: https://www.ti.com/lit/gpn/dra821u  (J7200 Datasheet)

Test logs: https://gist.github.com/aniket-l/ec76679ebcb399cf10426bd7a4a154c3
With series applied on master plus below:
- CONFIG_K3_OPP_LOW enabled in config
- Additional helpful prints added in code
- Logs shown with and without efuse register programmed for OPP_0
  (Errors out if OPP_0 not found, programs OPP_LOW spec if found)

---
v2:
* Neha
- Fix indentation
- Updates to commit msgs

- Re-format patches 3/5 and 4/5 with logical changes in each patch

- Link to v1: https://lore.kernel.org/u-boot/20241017062911.2241167-1-a-limaye@ti.com/

Reid Tonking (5):
  arm: dts: k3-j7200-r5-common: Add msmc clk to a72 node
  misc: k3_avs: Add OPP_LOW voltage and frequency to vd_data
  misc: k3_avs: Check validity of efuse voltage data
  arm: mach-k3: j721e-init.c: J7200: Add support for CONFIG_K3_OPP_LOW
  configs: j7200_evm_r5_defconfig: Define K3_OPP_LOW

 .../arm/dts/k3-j7200-r5-common-proc-board.dts | 10 ++---
 arch/arm/mach-k3/Kconfig                      |  6 +++
 arch/arm/mach-k3/j721e/j721e_init.c           | 45 ++++++++++++++++++-
 configs/j7200_evm_r5_defconfig                |  1 +
 drivers/misc/k3_avs.c                         | 34 ++++++++++++++
 include/k3-avs.h                              |  2 +
 6 files changed, 92 insertions(+), 6 deletions(-)

-- 
2.34.1

