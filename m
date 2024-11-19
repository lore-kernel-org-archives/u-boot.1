Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B52D60D00
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 00:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB74689426;
	Tue, 19 Nov 2024 01:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uviG7qJ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6878C89491; Tue, 19 Nov 2024 01:36:33 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABA3689417
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 01:36:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ0aSTJ053133;
 Mon, 18 Nov 2024 18:36:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731976588;
 bh=p1u9+K/mmToBWKrQYtcDeEdyvStDz3RMs8/v7oTBZiI=;
 h=From:To:CC:Subject:Date;
 b=uviG7qJ7dT8M1ERZyqNeUEVLkop6QeAggTRSdl12zyY1P+kz1UQ9AeKAmHpZZiy16
 QmyhoVPXD4xXWuOgNt+RbUIe7//87vpqHXkpVVN3cmFV1S7YUamfQawMFR0yfhbxuK
 +eJc2uKwdu2Ws/yt5f/X2a6KbyiTScFY+C8qrAq8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ0aSdn021896
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Nov 2024 18:36:28 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 18:36:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 18:36:28 -0600
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ0aPMT114132;
 Mon, 18 Nov 2024 18:36:26 -0600
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v3 0/5] Add OPP_LOW support for J7200
Date: Tue, 19 Nov 2024 06:02:54 +0530
Message-ID: <20241119003617.1871183-1-a-limaye@ti.com>
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

Test logs:
https://gist.github.com/aniket-l/328ad93ed60c2419ed7be9f85e6b6075
- With series applied on master and CONFIG_K3_OPP_LOW enabled in
  j7200_evm_r5_defconfig
- Logs shown with and without efuse register programmed for OPP_0
  (Errors out if OPP_0 not found, programs OPP_LOW spec if found)
- Voltage update verified using 'i2c md 0x4c 0xe' in u-boot
- Frequency update verified using 'k3conf clock dump' in linux

---
v4:
* Manorit
- Update function name to k3_avs_check_opp and update description
- Move Kconfig definition to arch/arm/mach-k3/r5/Kconfig

- Update commit messages
- Fixup patch styling problems
- In previous versions, fdt_fixup_a72ss_clock_frequency() assumed a
  fixed order of assigned-clock-rates in the DT to update clk freqs.
  This may not always be a valid assumption. So, add a new function
  get_clock_index_by_dev_id() to search the indices for A72 CPU and MSMC
  clk IDs and then use that index to update the clock rates in place.
- Link to v3: https://lore.kernel.org/u-boot/20241116071615.839623-1-a-limaye@ti.com/

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

