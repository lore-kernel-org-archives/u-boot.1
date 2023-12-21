Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8A6C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B54A878C9;
	Thu, 21 Dec 2023 18:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZY22dbUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B4A878F9; Thu, 21 Dec 2023 18:44:25 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90EC187885
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiE6G118504;
 Thu, 21 Dec 2023 11:44:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180654;
 bh=tQmp3ujfJrAM6TlHpHz0OJxfqM81jpyXCmqDnF87xVg=;
 h=From:To:CC:Subject:Date;
 b=ZY22dbUO7EhYNeJWzXkIRH81SbfAySqPJEWWsElpy2ZUG57Swy5u1X4bbe0g8Uszz
 ri1jvKnzVkYAE+SC5p705pbBOUWLlsQBAvNyhjVB+v5Jkew+zQ3W4oWzhqTSSndjHo
 M7y+RBig+LiQnWFTZVvfwhP8Rgywep+tZzTunjVE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiEg9113453
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:14 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:13 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiDLd069227;
 Thu, 21 Dec 2023 11:44:13 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 00/26] sync am65x device tree with Linux v6.7-rc1
Date: Thu, 21 Dec 2023 11:43:46 -0600
Message-ID: <20231221174412.210807-1-bb@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837; i=bb@ti.com;
 h=from:subject; bh=vpM1eKrWh97I3M8aYPyuWpeeeJzgO1AMUcgBfxVZ9rI=;
 b=owNCWmg5MUFZJlNZAqcMVQAAaf///r/dnrG+f7W3/Zdnc0XehGx/d//tKHZX3+/f3b/jrl+wA
 RswHahoNNAGmgNGQAANNBoGg00eoaBpoaaABoDQHqaABo0ZPU02poaBpobIno0meqIDQBpkAMhk
 BkaAMgBiDQZMID1GE9TTQYmmjJkMTaj9SZBkAaaGhpkAYTRodNH6iPUYgHqMEGg0A0MBNA0ABiA
 ZA0ZNMBGIaYhiaaGgAAAyaAZNGmAB7BCLoVHZABsjlyY2lbg3JaeCAzgDKSqyg4UwIKFHfRhru2
 MCZranFDc23BoO+IoGQPBPYu9t6MEskDgZi6ldDQdxljgWq9A5/dka4EhSaJRfe/bKbV2bDK/0U
 EseqhjxBcArKhDIlQUWSIF2WdiMKI+vNefHfQOdVCi9AYaqrUqzdNxidDsv3NEDK3oG3bshqldN
 wxGqt4n5LWElCtfDFJer1UihZlt08uT8bO8uiw6APMYeyFK5Stfc+YgTqBeOO5GuxOb8gkcIrUM
 stCZbmRHhLUbII+BgfLp8EbsRQyVxR88I9RejhjHkDGlgqPjSSzKfUu2JspIH4zyJWopzVhXNB4
 p2mH/c09bVITcxLo5AJ7nrDrMWGcEfz6vOKgipJ2ndNjlamAXLTDwHKtIeQq1TAA7wtzSpQb4AM
 BNT/F3JFOFCQAqcMVQ=
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

Hello Everyone!

This series gets the am65x booting again along with syncing the device
tree files with v6.7-rc1 Linux.

The bulk of these patches unify the WKUP SPL board file with the arm64
files to make future syncs from Linux much easier. In the end the DTBs
should look a lot like what the DTBs look like for the am64x which
is fairly similar to the am65x.

For those interested in what UART boot looks like:
   https://paste.sr.ht/~bryanb/7df8a645dc548912cd806abd5ecab967ef3287bc

Thanks for reviewing and happy holidays
~Bryan

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
  arm: dts: k3-am65: remove duplicate mcu secure proxy node
  arm: dts: k3-am654: convert bootph-pre-ram to bootph-all

 arch/arm/dts/k3-am65-main.dtsi                | 342 +++++++++++++++---
 arch/arm/dts/k3-am65-mcu.dtsi                 | 156 +++++++-
 arch/arm/dts/k3-am65-wakeup.dtsi              |  10 +-
 arch/arm/dts/k3-am65.dtsi                     |  19 +-
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi  | 201 +++++++++-
 arch/arm/dts/k3-am654-base-board.dts          | 301 +++++++++------
 .../dts/k3-am654-r5-base-board-u-boot.dtsi    | 208 -----------
 arch/arm/dts/k3-am654-r5-base-board.dts       | 298 +++------------
 arch/arm/dts/k3-am654.dtsi                    |   7 +
 configs/am65x_evm_a53_defconfig               |   1 -
 configs/am65x_evm_r5_defconfig                |   2 +
 11 files changed, 887 insertions(+), 658 deletions(-)
 delete mode 100644 arch/arm/dts/k3-am654-r5-base-board-u-boot.dtsi


base-commit: 2c9ee3f22603083ef0c4b808cf92645e5417156a
-- 
2.43.0

