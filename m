Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95635C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 322AA87C2B;
	Fri, 29 Dec 2023 18:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NIQwKHKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF46A87B92; Fri, 29 Dec 2023 18:47:22 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 431D587BBB
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1WB006036;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=uq/8cnWM2voxb4gO8Dnd8YJ87O+GfvybLpvoHgA1YPs=;
 h=From:To:CC:Subject:Date;
 b=NIQwKHKwmOHU/aHp425dZt9xrBN9Nzx6HIGv2MmPRHLbIWpewoHphLsQ5QR94FWz9
 ta4+Kw3lrimFK5SX8GAlTUmffzXRHXuDFLD83F2NVWLI4lDIHULahJ7Np0laoxbz7j
 arL1EebzeUoi5R8MpRbEVTnQ+FQBrUaTU4usrfSg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1Yp063418
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:00 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl0uU122665;
 Fri, 29 Dec 2023 11:47:00 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 00/26] sync am65x device tree with Linux v6.7-rc1
Date: Fri, 29 Dec 2023 11:46:57 -0600
Message-ID: <20231229174656.634065-28-bb@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3261; i=bb@ti.com;
 h=from:subject; bh=E6kgDLfKFXD89MAKhow25uqwUkIIPfraR3mnKR1fnR0=;
 b=owNCWmg5MUFZJlNZq4PqzgAAZf////5Lb2fw6p/22577dtr2e/T34d7O38b/6bvrz95u13+wA
 Rsyh2oAAABpoAAaeUGgNNAGgAaaANAAGjQaAA0aGgNB6jJp6j1NG00Q9Rpsj1Q6NAAyDRoABkDQ
 NM1A0ANNPUekBoPUA0NqMh6hoGyjQAPSAGh6gB6h6R6mjTQaHCaAxGmmmEyAGmgaYmTCA0GgZBo
 ANDJkYCZGJiNGgZNGmQANABoyDRk0AgRuFtQsckExoh3E15QVh0sNUAn5LtFJtJ4InvZ2PGAGhd
 t1gWDOhqXvkBZ2xa5bD3FKw4TwoZONQQDLlahbRO6NapwJxcWT1N0SJ0PZLsInwgGxQKUhAbP4A
 DRk00RMcaZDLVn57mCQN2P5oamD7jnUMTnhjJu0hGb4EKNimCSMxbPjSmlBRiVkwK71SKtTZ6M6
 kUx00M41Qe7sj/KihOpRoBmbvl3sOROjqzUEHZOw/iaJtT3IYsvxeVYQjPw7Jvx0wqO2GViC1ZZ
 tV4MfVp2ZyQdMFaLV6F3MTlsTi8wpmaMWKrrL7MTSB4nGL9HI/xiFTURSVRVcUkBradQZ87yk4d
 kyHF6s9C1d+5KQHGBIQbM6e9C3DHIBtrWwR9cUhBv6H9mCaorRrPPjZQW9AlYxuIAIDXIMidxOi
 ATl/4u5IpwoSFXB9WcA
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Hello Again Everyone!

This series gets the am65x booting again along with syncing the device
tree files with v6.7-rc1 Linux.

The bulk of these patches unify the WKUP SPL board file with the arm64
files to make future syncs from Linux much easier. In the end the DTBs
should look a lot like what the DTBs look like for the am64x which
is fairly similar to the am65x.

For those interested in what UART boot looks like:
   https://paste.sr.ht/~bryanb/7df8a645dc548912cd806abd5ecab967ef3287bc

Changes from v1: [0]
- fixed multi-line comment format
- moved wkup_uart0 and mcu_uart0 U-Boot overrides to the r5 board file
  as they are not needed for a53/main domain U-Boot builds
- corrected a bad wkup_i2c0_pins_default fixup in PATCH 6/26
- spelling fix (s/Libux/Linux/) in commit body for PATCH 6/26
- added trailers from Tom

Thanks for reviewing and happy holidays
~Bryan

[0] https://lore.kernel.org/u-boot/20231221174412.210807-1-bb@ti.com/

Bryan Brattlof (26):
  configs: am65x_evm_r5: enable driver for fixed regulators
  configs: am65x_evm_a53: disable CONSOLE_MUX
  arm: dts: k3-am654-r5: Merge board file and U-Boot overlay
  arm: dts: k3-am654: pull in dtb update from Linux
  arm: dts: k3-am654: copy bootph properties to a53 dts
  arm: dts: k3-am654: include a53 board dtb for r5 build
  arm: dts: k3-am654: remove duplicate vtt_supply
  arm: dts: k3-am654: remove duplicate wkup_uart0
  arm: dts: k3-am654: remove duplicate timer
  arm: dts: k3-am654: remove duplicate mcu_ringacc
  arm: dts: k3-am654: remove duplicate mcu_udmap
  arm: dts: k3-am654: add needed regs to udmap nodes
  arm: dts: k3-am654: remove duplicate mcu_uart0 node
  arm: dts: k3-am654: remove duplicate main_uart0
  arm: dts: k3-am654: remove duplicate sdhci0 pinmux node
  arm: dts: k3-am654: remove duplicate sdhci1 pinmux node
  arm: dts: k3-am654: remove duplicate wkup_i2c0
  arm: dts: k3-am654: remove duplicate ospi0 node
  arm: dts: k3-am654: remove usb0
  arm: dts: k3-am654: remove duplicate mdio
  arm: dts: k3-am654: remove duplicate vtt pinmux
  arm: dts: k3-am654: remove duplicate root properties
  arm: dts: k3-am654: remove un-needed aliases
  arm: dts: k3-am654: move dummy_clock to root node
  arm: dts: k3-am654: remove duplicate mcu secure proxy node
  arm: dts: k3-am654: convert bootph-pre-ram to bootph-all

 arch/arm/dts/k3-am65-main.dtsi                | 342 +++++++++++++++---
 arch/arm/dts/k3-am65-mcu.dtsi                 | 156 +++++++-
 arch/arm/dts/k3-am65-wakeup.dtsi              |  10 +-
 arch/arm/dts/k3-am65.dtsi                     |  19 +-
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi  | 195 +++++++++-
 arch/arm/dts/k3-am654-base-board.dts          | 301 +++++++++------
 .../dts/k3-am654-r5-base-board-u-boot.dtsi    | 208 -----------
 arch/arm/dts/k3-am654-r5-base-board.dts       | 303 ++++------------
 arch/arm/dts/k3-am654.dtsi                    |   7 +
 configs/am65x_evm_a53_defconfig               |   1 -
 configs/am65x_evm_r5_defconfig                |   2 +
 11 files changed, 886 insertions(+), 658 deletions(-)
 delete mode 100644 arch/arm/dts/k3-am654-r5-base-board-u-boot.dtsi


base-commit: 0a0ceea2269b983e736b80104f03cc800d1a5e2a
-- 
2.43.0

