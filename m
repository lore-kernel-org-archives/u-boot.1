Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0ABC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:39:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F9EF87809;
	Tue, 19 Dec 2023 12:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DeAuXbj9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FC33871B1; Tue, 19 Dec 2023 11:30:37 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A99E086D2E
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJAUPAD102564;
 Tue, 19 Dec 2023 04:30:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702981825;
 bh=StURTRid3iY3vWXT4yTSHji1amPzJC0AyNyuZ/PCkKk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=DeAuXbj9Rt2ykomL/OsOblj4LFbClbRaUF/CJLNKBZM1b3fHpVlzyWMbXw9Pcp7sR
 dUOu7GYXqgO3s8HcrhgCtDUycDh9CwD57pe3tLRQAICLk4XM/7UXwSylvP6+IT+eXh
 DGy5aoixLjw9M0eugaYsjgB6GvtJdrZRYkQAdFEw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJAUOYu018303
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 04:30:24 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 04:30:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 04:30:24 -0600
Received: from [10.24.69.31] (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJAUJ4k065455;
 Tue, 19 Dec 2023 04:30:20 -0600
Message-ID: <842de993-9095-4950-9827-9334444603c6@ti.com>
Date: Tue, 19 Dec 2023 16:00:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] Introduce ICSSG Ethernet driver
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20231219101225.3443978-1-danishanwar@ti.com>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20231219101225.3443978-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 19 Dec 2023 12:33:18 +0100
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

Hi All,

Please ignore this thread. Some mails seems to have been duplicated.
I will post another thread soon. Pls ignore this.
Sorry for the inconvenience.

On 19/12/23 3:41 pm, MD Danish Anwar wrote:
> Introduce ICSSG PRUETH support in uboot. The ICSSG driver is used in TI
> AM654 SR2.0.
> 
> The ICSSG PRU Sub-system runs on EMAC firmware. This series Introduces
> support for ICSSG driver in uboot. This series also adds the driver's
> dependencies.
> 
> The ICSSG2 node is added in device tree overlay so that it remains in
> sync with linux kernel.
> 
> The series introduces device tree and config changes and AM65x
> to enable ICSSG driver. The series also enables SPL_LOAD_FIT_APPLY_OVERLAY
> for AM65x in order to load overlay over spl.
> 
> This series has been tested on AM65x SR2.0, and the ICSSG interface is
> able to ping / dhcp and boot kernel using tftp in uboot.
> 
> To use ICSSG2 ethernet, the ICSSG firmware needs to be loaded to PRU RPROC
> cores and RPROC cores need to be booted with the firmware. This step is
> done inside driver in kernel as kernel supports APIs like
> rproc_set_firmware() and rproc_fw_boot(). But as u-boot doesn't have these
> APIs, the same needs to be done via u-boot cmds.
> 
> To make sure icssg-eth works we need to do below steps.
> 
> 1. Initialize rproc cores i.e. rproc_init()
> 2. Load $firmware_file from partition '1:2' (root) on device (mmc in this
>    example)
> 3. Load the firmware file to rproc cores passing. i.e. rproc_load()
>    taking rproc_id, loadaddr and file size as arguments.
> 4. Start rproc cores. i.e. rproc_start() taking rproc_id as arguments
> 
> The above steps are done by running the below commands at u-boot prompt.
> 
> => setenv start_icssg2 'rproc start 14; rproc start 15; rproc start 16; rproc start 17; rproc start 18; rproc start 19'
> => setenv stop_icssg2 'rproc stop 14; rproc stop 15; rproc stop 16; rproc stop 17; rproc stop 18; rproc stop 19'
> => setenv firmware_dir '/lib/firmware/ti-pruss'
> => setenv get_firmware_mmc 'load mmc ${bootpart} ${loadaddr} ${firmware_dir}/${firmware_file}'
> 
> => setenv init_icssg2 'setenv ethact icssg2-eth; setenv autoload no; rproc init; setenv loadaddr 0x80000000; \
>     setenv firmware_file am65x-sr2-pru0-prueth-fw.elf; run get_firmware_mmc;  rproc load 14 0x80000000 ${filesize}; \
>     setenv loadaddr 0x89000000; setenv firmware_file am65x-sr2-rtu0-prueth-fw.elf; run get_firmware_mmc; rproc load 15 0x89000000 ${filesize}; \
>     setenv loadaddr 0x90000000; setenv firmware_file am65x-sr2-txpru0-prueth-fw.elf; run get_firmware_mmc; rproc load 16 0x90000000 ${filesize}; \
>     setenv loadaddr 0x80000000; setenv firmware_file am65x-sr2-pru1-prueth-fw.elf; run get_firmware_mmc; rproc load 17 0x80000000 ${filesize}; \
>     setenv loadaddr 0x89000000; setenv firmware_file am65x-sr2-rtu1-prueth-fw.elf; run get_firmware_mmc; rproc load 18 0x89000000 ${filesize}; \
>     setenv loadaddr 0x90000000; setenv firmware_file am65x-sr2-txpru1-prueth-fw.elf; run get_firmware_mmc; rproc load 19 0x90000000 ${filesize}; \
>     run start_icssg2;'
> 
> => run init_icssg2
> => dhcp
> k3-navss-ringacc ringacc@3c000000: Ring Accelerator probed rings:818, gp-rings[304,100] sci-dev-id:187
> k3-navss-ringacc ringacc@3c000000: dma-ring-reset-quirk: disabled
> prueth icssg2-eth: K3 ICSSG: rflow_id_base: 8, chn_name = rx0
> link up on port 0, speed 1000, full duplex
> BOOTP broadcast 1
> BOOTP broadcast 2
> BOOTP broadcast 3
> DHCP client bound to address 192.168.4.58 (1020 ms)
> 
> Thanks and Regards,
> MD Danish Anwar
> 
> MD Danish Anwar (16):
>   net: ti: icssg: Add Firmware Interface for ICSSG Ethernet driver.
>   net: ti: icssg: Add Firmware config and classification APIs.
>   net: ti: icssg: Add icssg queues APIs and macros
>   net: ti: icssg: Add ICSSG ethernet driver
>   net: ti: icssg: Add support sending FDB command to update rx_flow_id
>   net: ti: icssg: Enforce pinctrl state on the MDIO child node
>   arm: dts: k3-am65: Add additional regs for DMA components
>   arm: dts: k3-am65: Add cfg reg region to ringacc node
>   arm: dts: k3-am65-main: Add ICSSG IEP nodes
>   arm: dts: k3-am654-base-board: Add ICSSG2 Ethernet support
>   arm: dts: k3-am65x-binman: Add ICSSG2 overlay and configuration
>   configs: am65x_evm_a53: Enable ICSSG Driver
>   configs: am65x_evm_a53_defconfig: add SPL_LOAD_FIT_APPLY_OVERLAY
>   tools/fdtgrep: Include __symbols__ table
>   board: ti: am65x: Add check for k3-am654-icssg2 in
>     board_fit_config_match()
>   Revert "dm: core: Report bootph-pre-ram/sram node as pre-reloc after
>     relocation"
> 
>  arch/arm/dts/Makefile             |   3 +-
>  arch/arm/dts/k3-am65-main.dtsi    |  49 ++-
>  arch/arm/dts/k3-am65-mcu.dtsi     |  13 +-
>  arch/arm/dts/k3-am654-icssg2.dtso | 145 +++++++
>  arch/arm/dts/k3-am65x-binman.dtsi |  85 ++++
>  board/ti/am65x/evm.c              |  11 +-
>  configs/am65x_evm_a53_defconfig   |   4 +
>  drivers/core/ofnode.c             |   2 +-
>  drivers/net/ti/Kconfig            |   9 +
>  drivers/net/ti/Makefile           |   1 +
>  drivers/net/ti/icss_mii_rt.h      | 192 +++++++++
>  drivers/net/ti/icssg_classifier.c | 376 +++++++++++++++++
>  drivers/net/ti/icssg_config.c     | 469 +++++++++++++++++++++
>  drivers/net/ti/icssg_config.h     | 195 +++++++++
>  drivers/net/ti/icssg_prueth.c     | 654 ++++++++++++++++++++++++++++++
>  drivers/net/ti/icssg_prueth.h     |  89 ++++
>  drivers/net/ti/icssg_queues.c     |  51 +++
>  drivers/net/ti/icssg_switch_map.h | 209 ++++++++++
>  include/dm/ofnode.h               |   8 +-
>  tools/fdtgrep.c                   |   8 +
>  20 files changed, 2555 insertions(+), 18 deletions(-)
>  create mode 100644 arch/arm/dts/k3-am654-icssg2.dtso
>  create mode 100644 drivers/net/ti/icss_mii_rt.h
>  create mode 100644 drivers/net/ti/icssg_classifier.c
>  create mode 100644 drivers/net/ti/icssg_config.c
>  create mode 100644 drivers/net/ti/icssg_config.h
>  create mode 100644 drivers/net/ti/icssg_prueth.c
>  create mode 100644 drivers/net/ti/icssg_prueth.h
>  create mode 100644 drivers/net/ti/icssg_queues.c
>  create mode 100644 drivers/net/ti/icssg_switch_map.h
> 
> base:commit: a6f86132e30a407c7f96461df53c62fbe52e2b54

-- 
Thanks and Regards,
Danish
