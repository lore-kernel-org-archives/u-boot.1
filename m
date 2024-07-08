Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B71FC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 14:23:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D54698876E;
	Mon,  8 Jul 2024 16:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720448579;
	bh=RepSeukUJFzuBgZGy9umBiP4FrQUoB8mvr+vRZdLwaA=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RD7mwO2/Rsf2H8zGhYMhkpopsHJCuu+JXW1HyC2woKAub4boB5DyAoNBS4NwLOqtL
	 V2l+Rlhq6Z/SeTl4wR7R4m+YZEqIKhSF81CShn2IzEbDSEgRe0UOIuXmTXcl579Y6v
	 TdPgv+A1WKCEIu+saiA91kV0hTLALwG9y0svSz5ZtcK96WiKVK2J0Jq4Be8wPdmxqR
	 GMlBiE3kVz1jND4UGjGwaHzCIsijGmA0pfXfHri23ERRSuco+SvmDhoAEnUc/tMEi1
	 WsDDtYX8UPgzrZXj70ihbpO210VRC6Jf9ZcTrHowdpfnpgxXSNjQCBl40/gaRgK2r8
	 frCuXRifU7a8w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C665288771; Mon,  8 Jul 2024 16:22:57 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C4F988756
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 16:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4WHmYS6s5Zz9sdS;
 Mon,  8 Jul 2024 16:22:52 +0200 (CEST)
Message-ID: <63f91338-51d5-494d-bca8-c9e2b075ec67@denx.de>
Date: Mon, 8 Jul 2024 16:22:52 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-marvell/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

please pull the following Marvell MVEBU related patches into master:

----------------------------------------------------------------
- Add mvebu_espressobin_ultra-88f3720_defconfig (Benjamin)
- Update DTS for Thecus N2350 board (Tony)
- Add "old" Marvell DDR3 training for Armada 38x and Turris Omnia
   (Marek)
- Misc turris_omnia changes (Marek)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=372&view=results

Thanks,
Stefan

The following changes since commit fd46ea0e701920eb205c2bce9d527bf0dec10b59:

   Merge branch '2024-07-05-assorted-updates' (2024-07-05 16:36:43 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-marvell.git

for you to fetch changes up to 711443eafe0d8064744f6ee69cef08b032346c74:

   mvebu: armada-8k: respect CONFIG_DISTRO_DEFAULTS (2024-07-08 08:20:58 
+0200)

----------------------------------------------------------------
Benjamin Schneider (1):
       configs: add mvebu_espressobin_ultra-88f3720_defconfig

Marek Behún (16):
       arm: mvebu: turris_omnia: Disable ext4 write support in defconfig
       ddr: marvell: a38x: debug: return from ddr3_tip_print_log() early 
if we won't print anything
       ddr: marvell: a38x: debug: Remove unused variables
       ddr: marvell: a38x: debug: Define DDR_VIEWER_TOOL variables only 
if needed, and make them static
       ddr: marvell: a38x: debug: Allow compiling with immutable debug 
settings to reduce binary size
       arm: mvebu: turris_omnia: Enable immutable debug settings in DDR3 
training by default
       arm: mvebu: turris_omnia: Fix ethernet PHY reset gpio FDT fixup
       arm: mvebu: turris_omnia: Implement EEPROM layout for the 
'eeprom' command
       arm: mvebu: turris_omnia: Enable the 'eeprom' command
       arm: mvebu: turris_omnia: Extend EEPROM info structure
       arm: mvebu: turris_omnia: Read DDR speed from EEPROM
       ddr: marvell: a38x: Import old DDR training code from 2017 
version of U-Boot
       ddr: marvell: a38x: old: Fix some compiler warning of the old code
       ddr: marvell: a38x: old: Backport immutable debug settings
       arm: mvebu: a38x: Add optional support for using old DDR3 
training code
       arm: mvebu: turris_omnia: Support old DDR3 training

Robert Marko (1):
       mvebu: armada-8k: respect CONFIG_DISTRO_DEFAULTS

Tony Dinh (2):
       arm: mvebu: env_sf_get_env_addr() missing check for 
CONFIG_ENV_IS_IN_SPI_FLASH
       arm: dts: mvebu: Update DTS for Thecus N2350 board

  arch/arm/dts/armada-385-thecus-n2350.dts           |   10 +-
  arch/arm/mach-mvebu/Kconfig                        |   15 +
  arch/arm/mach-mvebu/cpu.c                          |    2 +-
  arch/arm/mach-mvebu/include/mach/cpu.h             |    1 +
  arch/arm/mach-mvebu/spl.c                          |   37 +-
  board/CZ.NIC/turris_omnia/Makefile                 |    2 +
  board/CZ.NIC/turris_omnia/eeprom.c                 |  190 ++
  board/CZ.NIC/turris_omnia/old_ddr3_training.c      |   63 +
  board/CZ.NIC/turris_omnia/turris_omnia.c           |  199 +-
  board/Marvell/mvebu_armada-37xx/MAINTAINERS        |    5 +
  configs/mvebu_espressobin_ultra-88f3720_defconfig  |  106 +
  configs/turris_omnia_defconfig                     |    6 +-
  drivers/ddr/marvell/a38x/Makefile                  |    2 +
  drivers/ddr/marvell/a38x/ddr3_debug.c              |   30 +-
  drivers/ddr/marvell/a38x/ddr3_init.c               |    3 +-
  drivers/ddr/marvell/a38x/ddr3_init.h               |   43 +-
  drivers/ddr/marvell/a38x/old/Makefile              |   29 +
  drivers/ddr/marvell/a38x/old/ddr3_a38x.c           |  737 ++++++
  drivers/ddr/marvell/a38x/old/ddr3_a38x.h           |   93 +
  drivers/ddr/marvell/a38x/old/ddr3_a38x_mc_static.h |  226 ++
  drivers/ddr/marvell/a38x/old/ddr3_a38x_topology.h  |   22 +
  drivers/ddr/marvell/a38x/old/ddr3_a38x_training.c  |   39 +
  drivers/ddr/marvell/a38x/old/ddr3_debug.c          | 1546 ++++++++++++
  .../ddr/marvell/a38x/old/ddr3_hws_hw_training.c    |  147 ++
  .../ddr/marvell/a38x/old/ddr3_hws_hw_training.h    |   49 +
  .../marvell/a38x/old/ddr3_hws_hw_training_def.h    |  464 ++++
  .../ddr/marvell/a38x/old/ddr3_hws_sil_training.h   |   17 +
  drivers/ddr/marvell/a38x/old/ddr3_init.c           |  769 ++++++
  drivers/ddr/marvell/a38x/old/ddr3_init.h           |  405 +++
  drivers/ddr/marvell/a38x/old/ddr3_logging_def.h    |  101 +
  drivers/ddr/marvell/a38x/old/ddr3_patterns_64bit.h |  924 +++++++
  drivers/ddr/marvell/a38x/old/ddr3_topology_def.h   |   76 +
  drivers/ddr/marvell/a38x/old/ddr3_training.c       | 2650 
++++++++++++++++++++
  drivers/ddr/marvell/a38x/old/ddr3_training_bist.c  |  288 +++
  .../a38x/old/ddr3_training_centralization.c        |  711 ++++++
  drivers/ddr/marvell/a38x/old/ddr3_training_db.c    |  651 +++++
  .../ddr/marvell/a38x/old/ddr3_training_hw_algo.c   |  685 +++++
  .../ddr/marvell/a38x/old/ddr3_training_hw_algo.h   |   14 +
  drivers/ddr/marvell/a38x/old/ddr3_training_ip.h    |  178 ++
  .../ddr/marvell/a38x/old/ddr3_training_ip_bist.h   |   54 +
  .../a38x/old/ddr3_training_ip_centralization.h     |   15 +
  drivers/ddr/marvell/a38x/old/ddr3_training_ip_db.h |   34 +
  .../ddr/marvell/a38x/old/ddr3_training_ip_def.h    |  173 ++
  .../ddr/marvell/a38x/old/ddr3_training_ip_engine.c | 1354 ++++++++++
  .../ddr/marvell/a38x/old/ddr3_training_ip_engine.h |   85 +
  .../ddr/marvell/a38x/old/ddr3_training_ip_flow.h   |  349 +++
  .../ddr/marvell/a38x/old/ddr3_training_ip_pbs.h    |   41 +
  .../ddr/marvell/a38x/old/ddr3_training_ip_prv_if.h |  107 +
  .../ddr/marvell/a38x/old/ddr3_training_ip_static.h |   31 +
  .../ddr/marvell/a38x/old/ddr3_training_leveling.c  | 1836 ++++++++++++++
  .../ddr/marvell/a38x/old/ddr3_training_leveling.h  |   17 +
  drivers/ddr/marvell/a38x/old/ddr3_training_pbs.c   |  994 ++++++++
  .../ddr/marvell/a38x/old/ddr3_training_static.c    |  537 ++++
  drivers/ddr/marvell/a38x/old/ddr_topology_def.h    |  121 +
  drivers/ddr/marvell/a38x/old/ddr_training_ip_db.h  |   16 +
  drivers/ddr/marvell/a38x/old/glue_symbol_renames.h |  247 ++
  drivers/ddr/marvell/a38x/old/silicon_if.h          |   17 +
  drivers/ddr/marvell/a38x/old/xor.h                 |   92 +
  include/configs/mvebu_armada-8k.h                  |    5 +-
  59 files changed, 17596 insertions(+), 64 deletions(-)
  create mode 100644 board/CZ.NIC/turris_omnia/eeprom.c
  create mode 100644 board/CZ.NIC/turris_omnia/old_ddr3_training.c
  create mode 100644 configs/mvebu_espressobin_ultra-88f3720_defconfig
  create mode 100644 drivers/ddr/marvell/a38x/old/Makefile
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x.c
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x_mc_static.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x_topology.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_a38x_training.c
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_debug.c
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_hw_training.c
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_hw_training.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_hw_training_def.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_hws_sil_training.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_init.c
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_init.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_logging_def.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_patterns_64bit.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_topology_def.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training.c
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_bist.c
  create mode 100644 
drivers/ddr/marvell/a38x/old/ddr3_training_centralization.c
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_db.c
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_hw_algo.c
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_hw_algo.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_bist.h
  create mode 100644 
drivers/ddr/marvell/a38x/old/ddr3_training_ip_centralization.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_db.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_def.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.c
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_engine.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_flow.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_pbs.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_prv_if.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_ip_static.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_leveling.c
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_leveling.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_pbs.c
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr3_training_static.c
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr_topology_def.h
  create mode 100644 drivers/ddr/marvell/a38x/old/ddr_training_ip_db.h
  create mode 100644 drivers/ddr/marvell/a38x/old/glue_symbol_renames.h
  create mode 100644 drivers/ddr/marvell/a38x/old/silicon_if.h
  create mode 100644 drivers/ddr/marvell/a38x/old/xor.h
