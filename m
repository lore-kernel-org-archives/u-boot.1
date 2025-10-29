Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895F1CCD1BF
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 07:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E50C18006D;
	Wed, 29 Oct 2025 08:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D5F1800B6; Wed, 29 Oct 2025 08:38:38 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A17948003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 08:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 59T7cEJ2037843
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Wed, 29 Oct 2025 15:38:14 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Oct
 2025 15:38:14 +0800
Date: Wed, 29 Oct 2025 15:38:10 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <ycliang@andestech.com>, <rick@andestech.com>,
 <e@freeshell.de>, <jimmy.ho@sifive.com>
Subject: [PULL] u-boot-riscv/master
Message-ID: <aQHEYtIGJ9sab_Ai@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 59T7cEJ2037843
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

Hi Tom,

The following changes since commit 23987e10905146def3ab61e55ec912c6e742efdc:

  Prepare v2026.01-rc1 (2025-10-27 16:10:23 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to e1c05c00696a12c02674c1cd977d7c64900c5c58:

  board: starfive: Add initial Milk-V Mars CM and Mars CM Lite user documentation (2025-10-28 19:30:56 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/28051
----------------------------------------------------------------
- riscv: dts: starfive: cherry-pick jh7110 updates from v6.18-rc1-dts
- riscv: Add upstream boards Milk-V Mars CM and Mars CM Lite
- timer: sifive_clint: Add GHRTv2 compaible string
----------------------------------------------------------------
E Shattow (14):
      riscv: dts: starfive: jh7110-common: drop no-sdio property from mmc1
      riscv: dts: starfive: jh7110: add DMC memory controller
      riscv: dts: starfive: jh7110: bootph-pre-ram hinting needed by boot loader
      riscv: dts: starfive: jh7110-common: drop no-mmc property from mmc1
      riscv: dts: starfive: jh7110-common: drop mmc post-power-on-delay-ms
      riscv: dts: starfive: add common board dtsi for Milk-V Mars CM variants
      dt-bindings: riscv: starfive: add milkv,marscm-emmc
      riscv: dts: starfive: add Milk-V Mars CM system-on-module
      dt-bindings: riscv: starfive: add milkv,marscm-lite
      riscv: dts: starfive: add Milk-V Mars CM Lite system-on-module
      riscv: dts: starfive: prune redundant jh7110 overrides
      board: starfive: visionfive2: Add Milk-V Mars CM and Mars CM Lite selection by product_id
      configs: starfive: Add Milk-V Mars CM and Mars CM Lite to visionfive2
      board: starfive: Add initial Milk-V Mars CM and Mars CM Lite user documentation

Jimmy Ho (1):
      timer: sifive_clint: Add GHRTv2 compaible string

 arch/riscv/dts/starfive-visionfive2-u-boot.dtsi    |  68 ---------
 board/starfive/visionfive2/spl.c                   |   8 ++
 board/starfive/visionfive2/starfive_visionfive2.c  |   6 +
 configs/starfive_visionfive2_defconfig             |   2 +-
 doc/board/starfive/index.rst                       |   2 +
 doc/board/starfive/milkv_marscm_emmc.rst           |  24 ++++
 doc/board/starfive/milkv_marscm_lite.rst           |  24 ++++
 drivers/timer/riscv_aclint_timer.c                 |   1 +
 dts/upstream/Bindings/riscv/starfive.yaml          |   2 +
 dts/upstream/src/riscv/starfive/jh7110-common.dtsi |   4 -
 .../riscv/starfive/jh7110-milkv-marscm-emmc.dts    |  12 ++
 .../riscv/starfive/jh7110-milkv-marscm-lite.dts    |  25 ++++
 .../src/riscv/starfive/jh7110-milkv-marscm.dtsi    | 159 +++++++++++++++++++++
 dts/upstream/src/riscv/starfive/jh7110.dtsi        |  24 ++++
 14 files changed, 288 insertions(+), 73 deletions(-)
 create mode 100644 doc/board/starfive/milkv_marscm_emmc.rst
 create mode 100644 doc/board/starfive/milkv_marscm_lite.rst
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-emmc.dts
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm-lite.dts
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm.dtsi

 Best regards,
 Leo
