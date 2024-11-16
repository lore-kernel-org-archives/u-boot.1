Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4154AD68BE3
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 07:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1BE1896C4;
	Sat, 16 Nov 2024 08:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Pmb6d7J9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9546D89667; Sat, 16 Nov 2024 08:16:50 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06CBF891B1
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 08:16:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AG7GjUH098243;
 Sat, 16 Nov 2024 01:16:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731741405;
 bh=fz1GcT/4Ag3k7SB02C5W9CnvVmy8a51Dsg4c2bqrI0M=;
 h=From:To:CC:Subject:Date;
 b=Pmb6d7J9dXw0j6MnpnBSF2YDtqKW1H61Al9b7M0wzvDHNsfxkf7gCjLQZJBF/kG1h
 bbVSodPenU5H1ap3i34RKpOS6fovkbDjX7vrKCGYroekYKh/lSOtRYPFro29paGWoa
 vDXiaR7PJb9nQ4T1huH3R0QdADEtCrd2z7Y/x4+g=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AG7Gjhb060580
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 16 Nov 2024 01:16:45 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 16
 Nov 2024 01:16:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 16 Nov 2024 01:16:45 -0600
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AG7Gg61129041;
 Sat, 16 Nov 2024 01:16:43 -0600
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v3 0/5] Add OPP_LOW support for J7200
Date: Sat, 16 Nov 2024 12:45:14 +0530
Message-ID: <20241116071615.839623-1-a-limaye@ti.com>
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

Test logs: https://gist.github.com/aniket-l/b931d47f06baf6d4a780fa08072e5159
- With series applied on master and CONFIG_K3_OPP_LOW enabled in
  j7200_evm_r5_defconfig
- Logs shown with and without efuse register programmed for OPP_0
  (Errors out if OPP_0 not found, programs OPP_LOW spec if found)
- Voltage update verified using 'i2c md 0x4c 0xe' in u-boot
- Frequency update verified using 'k3conf clock dump' in linux

---
v3:
* Manorit
- Use more descriptive name for fdt_fixup_a72ss_clock_frequency()
  and make function static.
- Move error prints (with error codes) before else conditions. Helps
  with code readability to map error print with the function.
- Remove k3_avs_set_opp() from board_init_f altogether. Reasoning being
  that the value being set through k3_avs_set_opp() will anyway be
  (correctly) overridden by the k3_avs_notify_freq() call later in the
  boot process, when a72 freq is actually set from clk_k3.

- Add msmc clock at the end to preserve current ordering of core and gtc
  clocks
- Add Kconfig dependency on K3_AVS0 and Update commit msg to make it
  more clear

- Link to v2: https://lore.kernel.org/u-boot/20241023130033.1826413-1-a-limaye@ti.com/

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
  arm: mach-k3: j721e-init.c: Add support for CONFIG_K3_OPP_LOW
  configs: j7200_evm_r5_defconfig: Define K3_OPP_LOW

 .../arm/dts/k3-j7200-r5-common-proc-board.dts | 10 ++---
 arch/arm/mach-k3/Kconfig                      |  7 ++++
 arch/arm/mach-k3/j721e/j721e_init.c           | 41 ++++++++++++++++++-
 configs/j7200_evm_r5_defconfig                |  1 +
 drivers/misc/k3_avs.c                         | 34 +++++++++++++++
 include/k3-avs.h                              |  2 +
 6 files changed, 89 insertions(+), 6 deletions(-)

-- 
2.47.0

