Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FADED60D00
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 00:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E49C4894F2;
	Tue, 19 Nov 2024 01:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=vodafonemail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=vodafonemail.de header.i=@vodafonemail.de header.b="fX6cGyqB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5113894A2; Mon, 18 Nov 2024 21:50:56 +0100 (CET)
Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D2D688E63
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 21:50:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=vodafonemail.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vodafonemail.de;
 s=vfde-mb-mr2-23sep; t=1731963053;
 bh=PhRPIuaCpI+wzcbL3L5LUzc+3nTBt36bdpljmn6yChw=;
 h=Date:From:To:Subject:Message-ID:Content-Type:From;
 b=fX6cGyqBpxA48JtE+nwU2c5hUp1KcEKg3QHiycfybwOXlPhB8qBscBhqLUrX231N+
 V0eoex0cnhLPVw511T4W9Lsjf+9NEcvp4Pz9TsqYj+4d44CkT2A4ulXvk3nFoFqvw5
 OLT4r0khBIO0mVaeknVrlWZ2vWU33LBMPwJ2AR3s=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr6.vodafonemail.de (Postfix) with ESMTPS id 4Xsfsn5zB3z1xyB
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 20:50:53 +0000 (UTC)
Received: from tachyon.qrv-systems.net
 (ip-095-222-025-162.um34.pools.vodafone-ip.de [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4Xsfsj404lz8snW
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 20:50:46 +0000 (UTC)
Received: by tachyon.qrv-systems.net (Postfix, from userid 516)
 id EC8ED2E01AA; Mon, 18 Nov 2024 21:50:45 +0100 (CET)
Date: Mon, 18 Nov 2024 21:50:45 +0100
From: Yuri Zaporozhets <yuriz@vodafonemail.de>
To: u-boot@lists.denx.de
Subject: BUG: U-Boot crashes on SiFive Unmatched when CONFIG_DM_DEBUG=y
Message-ID: <Zzuopa6ZqUnQQOjf@vodafonemail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 28328
X-purgate-ID: 155817::1731963049-61FFA465-E63EE30D/0/0
X-Mailman-Approved-At: Tue, 19 Nov 2024 01:22:58 +0100
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

Hi all,

I enabled CONFIG_DM_DEBUG on my SiFive Unmatched, and U-Boot boot results in
failed assertion ("ofnode_valid(node)"). I'm attaching the full log below.

The same behavior is also for the 2024.10 stable version.

==================

U-Boot SPL 2025.01-rc2-00111-g0135f0e2e8ce (Nov 18 2024 - 21:18:08 +0100)
ofnode_read_prop: assigned-clock-rates: <not found>
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
ofnode_read_u32_index: clock-frequency: x (800000004)
ofnode_read_prop: assigned-clock-rates: <not found>
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: reset (ret=0)
   - result for clock-controller@10000000: reset (ret=0)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: reset (ret=0)
   - result for clock-controller@10000000: reset (ret=0)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: reset (ret=0)
   - result for clock-controller@10000000: reset (ret=0)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: reset (ret=0)
   - result for clock-controller@10000000: reset (ret=0)
ofnode_read_u32_array: sifive,ddr-params: 0
   - 0 'i2c@10030000'
   - found
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_u32_index: reg-shift: x (2)
ofnode_read_u32_index: clock-frequency: (not found)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
ofnode_read_u32_index: reg-io-width: x (1)
ofnode_read_u32_index: clock-frequency: (not found)
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_u32_index: ngpios: (not found)
Trying to boot from MMC1
0
   - 0 'mmc@0'
   - found
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_u32_index: sifive,fifo-depth: (not found)
ofnode_read_u32_index: sifive,max-bits-per-word: (not found)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
ofnode_read_u32_index: spi-max-frequency: (not found)
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_u32_index: reg: x (0)
ofnode_read_u32_index: reg: x (1)
ofnode_read_u32_index: reg: x (2)
ofnode_read_u32_index: reg: x (3)
ofnode_read_u32_index: reg: x (4)
bind node reserved-memory
Device 'reserved-memory' has no compatible string
bind node fit-images
Device 'fit-images' has no compatible string
bind node aliases
Device 'aliases' has no compatible string
bind node chosen
Device 'chosen' has no compatible string
bind node cpus
Device 'cpus' has no compatible string
bind node soc
   - attempt to match compatible string 'simple-bus'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
   - found match at driver 'simple_bus' for 'simple-bus'
ofnode_read_u32_array: ranges: bind node interrupt-controller@c000000
   - attempt to match compatible string 'sifive,fu540-c000-plic'
   - attempt to match compatible string 'sifive,plic-1.0.0'
No match for node 'interrupt-controller@c000000'
bind node clock-controller@10000000
   - attempt to match compatible string 'sifive,fu740-c000-prci'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
Skipping device pre-relocation
bind node serial@10010000
   - attempt to match compatible string 'sifive,fu740-c000-uart'
   - attempt to match compatible string 'sifive,uart0'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
Skipping device pre-relocation
bind node serial@10011000
   - attempt to match compatible string 'sifive,fu740-c000-uart'
   - attempt to match compatible string 'sifive,uart0'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: false
ofnode_read_bool: bootph-pre-sram: false
ofnode_read_bool: u-boot,dm-pre-reloc: false
ofnode_read_bool: u-boot,dm-pre-proper: false
ofnode_read_bool: u-boot,dm-spl: false
ofnode_read_bool: u-boot,dm-tpl: false
ofnode_read_bool: u-boot,dm-vpl: false
Skipping device pre-relocation
bind node i2c@10030000
   - attempt to match compatible string 'sifive,fu740-c000-i2c'
   - attempt to match compatible string 'sifive,i2c0'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
Skipping device pre-relocation
bind node spi@10040000
   - attempt to match compatible string 'sifive,fu740-c000-spi'
   - attempt to match compatible string 'sifive,spi0'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
Skipping device pre-relocation
bind node spi@10050000
   - attempt to match compatible string 'sifive,fu740-c000-spi'
   - attempt to match compatible string 'sifive,spi0'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
Skipping device pre-relocation
bind node ethernet@10090000
   - attempt to match compatible string 'sifive,fu540-c000-gem'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: false
ofnode_read_bool: bootph-pre-sram: false
ofnode_read_bool: u-boot,dm-pre-reloc: false
ofnode_read_bool: u-boot,dm-pre-proper: false
ofnode_read_bool: u-boot,dm-spl: false
ofnode_read_bool: u-boot,dm-tpl: false
ofnode_read_bool: u-boot,dm-vpl: false
Skipping device pre-relocation
bind node pwm@10020000
   - attempt to match compatible string 'sifive,fu740-c000-pwm'
   - attempt to match compatible string 'sifive,pwm0'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: false
ofnode_read_bool: bootph-pre-sram: false
ofnode_read_bool: u-boot,dm-pre-reloc: false
ofnode_read_bool: u-boot,dm-pre-proper: false
ofnode_read_bool: u-boot,dm-spl: false
ofnode_read_bool: u-boot,dm-tpl: false
ofnode_read_bool: u-boot,dm-vpl: false
Skipping device pre-relocation
bind node pwm@10021000
   - attempt to match compatible string 'sifive,fu740-c000-pwm'
   - attempt to match compatible string 'sifive,pwm0'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: false
ofnode_read_bool: bootph-pre-sram: false
ofnode_read_bool: u-boot,dm-pre-reloc: false
ofnode_read_bool: u-boot,dm-pre-proper: false
ofnode_read_bool: u-boot,dm-spl: false
ofnode_read_bool: u-boot,dm-tpl: false
ofnode_read_bool: u-boot,dm-vpl: false
Skipping device pre-relocation
bind node cache-controller@2010000
   - attempt to match compatible string 'sifive,fu740-c000-ccache'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: false
ofnode_read_bool: bootph-pre-sram: false
ofnode_read_bool: u-boot,dm-pre-reloc: false
ofnode_read_bool: u-boot,dm-pre-proper: false
ofnode_read_bool: u-boot,dm-spl: false
ofnode_read_bool: u-boot,dm-tpl: false
ofnode_read_bool: u-boot,dm-vpl: false
Skipping device pre-relocation
bind node gpio@10060000
   - attempt to match compatible string 'sifive,fu740-c000-gpio'
   - attempt to match compatible string 'sifive,gpio0'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
Skipping device pre-relocation
bind node pcie@e00000000
   - attempt to match compatible string 'sifive,fu740-pcie'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: false
ofnode_read_bool: bootph-pre-sram: false
ofnode_read_bool: u-boot,dm-pre-reloc: false
ofnode_read_bool: u-boot,dm-pre-proper: false
ofnode_read_bool: u-boot,dm-spl: false
ofnode_read_bool: u-boot,dm-tpl: false
ofnode_read_bool: u-boot,dm-vpl: false
Skipping device pre-relocation
bind node clint@2000000
   - attempt to match compatible string 'riscv,clint0'
No match for node 'clint@2000000'
bind node dmc@100b0000
   - attempt to match compatible string 'sifive,fu740-c000-ddr'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
Skipping device pre-relocation
bind node memory@80000000
Device 'memory@80000000' has no compatible string
bind node hfclk
   - attempt to match compatible string 'fixed-clock'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
   - found match at driver 'fixed_clock' for 'fixed-clock'
bind node rtcclk
   - attempt to match compatible string 'fixed-clock'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
   - found match at driver 'fixed_clock' for 'fixed-clock'
bind node gpio-poweroff
   - attempt to match compatible string 'gpio-poweroff'
No match for node 'gpio-poweroff'
bind node binman
Device 'binman' has no compatible string
bind node config
Device 'config' has no compatible string
bind node mmode_resv1@80000000
Device 'mmode_resv1@80000000' has no compatible string
bind node mmode_resv0@80040000
Device 'mmode_resv0@80040000' has no compatible string
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: false
ofnode_read_bool: bootph-pre-sram: false
ofnode_read_bool: u-boot,dm-pre-reloc: false
ofnode_read_bool: u-boot,dm-pre-proper: false
ofnode_read_bool: u-boot,dm-spl: false
ofnode_read_bool: u-boot,dm-tpl: false
ofnode_read_bool: u-boot,dm-vpl: false
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
ofnode_read_u32_array: ranges: bind node cpu@1
   - attempt to match compatible string 'sifive,bullet0'
   - attempt to match compatible string 'riscv'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
   - found match at driver 'riscv_cpu' for 'riscv'
ofnode_read_u32_index: timebase-frequency: (not found)
ofnode_read_u32_index: timebase-frequency: 0xf4240 (1000000)
bind node cpu@2
   - attempt to match compatible string 'sifive,bullet0'
   - attempt to match compatible string 'riscv'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
   - found match at driver 'riscv_cpu' for 'riscv'
ofnode_read_u32_index: timebase-frequency: (not found)
ofnode_read_u32_index: timebase-frequency: 0xf4240 (1000000)
bind node cpu@3
   - attempt to match compatible string 'sifive,bullet0'
   - attempt to match compatible string 'riscv'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
   - found match at driver 'riscv_cpu' for 'riscv'
ofnode_read_u32_index: timebase-frequency: (not found)
ofnode_read_u32_index: timebase-frequency: 0xf4240 (1000000)
bind node cpu@4
   - attempt to match compatible string 'sifive,bullet0'
   - attempt to match compatible string 'riscv'
ofnode_read_bool: bootph-all: false
ofnode_read_bool: bootph-some-ram: false
ofnode_read_bool: bootph-pre-ram: true
   - found match at driver 'riscv_cpu' for 'riscv'
ofnode_read_u32_index: timebase-frequency: (not found)
ofnode_read_u32_index: timebase-frequency: 0xf4240 (1000000)
ofnode_read_prop: riscv,isa: rv64imafdc
ofnode_read_prop: riscv,isa: rv64imafdc
bind node serial@10010000
   - attempt to match compatible string 'sifive,fu740-c000-uart'
   - attempt to match compatible string 'sifive,uart0'
   - found match at driver 'serial_sifive' for 'sifive,uart0'
   - seq=0
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: (none) (ret=-19)
   - result for clock-controller@10000000: (none) (ret=-19)
ofnode_read_u32_index: clock-frequency: (not found)


U-Boot 2025.01-rc2-00111-g0135f0e2e8ce (Nov 18 2024 - 21:18:08 +0100)

Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: (none) (ret=-19)
   - result for clock-controller@10000000: (none) (ret=-19)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: (none) (ret=-19)
   - result for clock-controller@10000000: (none) (ret=-19)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: (none) (ret=-19)
   - result for clock-controller@10000000: (none) (ret=-19)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: (none) (ret=-19)
   - result for clock-controller@10000000: (none) (ret=-19)
ofnode_read_prop: compatible: sifive,bullet0
CPU:   sifive,bullet0
Model: SiFive HiFive Unmatched A00
DRAM:  16 GiB
ofnode_read_prop: assigned-clock-rates: <not found>
bind node reserved-memory
Device 'reserved-memory' has no compatible string
bind node fit-images
Device 'fit-images' has no compatible string
bind node aliases
Device 'aliases' has no compatible string
bind node chosen
Device 'chosen' has no compatible string
bind node cpus
Device 'cpus' has no compatible string
bind node soc
   - attempt to match compatible string 'simple-bus'
   - found match at driver 'simple_bus' for 'simple-bus'
ofnode_read_u32_array: ranges: bind node interrupt-controller@c000000
   - attempt to match compatible string 'sifive,fu540-c000-plic'
   - attempt to match compatible string 'sifive,plic-1.0.0'
No match for node 'interrupt-controller@c000000'
bind node clock-controller@10000000
   - attempt to match compatible string 'sifive,fu740-c000-prci'
   - found match at driver 'sifive-prci' for 'sifive,fu740-c000-prci'
bind node serial@10010000
   - attempt to match compatible string 'sifive,fu740-c000-uart'
   - attempt to match compatible string 'sifive,uart0'
   - found match at driver 'serial_sifive' for 'sifive,uart0'
   - seq=0
bind node serial@10011000
   - attempt to match compatible string 'sifive,fu740-c000-uart'
   - attempt to match compatible string 'sifive,uart0'
   - found match at driver 'serial_sifive' for 'sifive,uart0'
   - seq=1
bind node i2c@10030000
   - attempt to match compatible string 'sifive,fu740-c000-i2c'
   - attempt to match compatible string 'sifive,i2c0'
   - found match at driver 'i2c_ocores' for 'sifive,i2c0'
bind node temperature-sensor@4c
   - attempt to match compatible string 'ti,tmp451'
No match for node 'temperature-sensor@4c'
bind node eeprom@54
   - attempt to match compatible string 'microchip,24c02'
   - attempt to match compatible string 'atmel,24c02'
No match for node 'eeprom@54'
bind node pmic@58
   - attempt to match compatible string 'dlg,da9063'
No match for node 'pmic@58'
bind node spi@10040000
   - attempt to match compatible string 'sifive,fu740-c000-spi'
   - attempt to match compatible string 'sifive,spi0'
   - found match at driver 'sifive_spi' for 'sifive,spi0'
bind node flash@0
   - attempt to match compatible string 'jedec,spi-nor'
   - found match at driver 'jedec_spi_nor' for 'jedec,spi-nor'
ofnode_read_u32_index: reg: 0x0 (0)
ofnode_read_u32_index: spi-max-frequency: 0x2faf080 (50000000)
ofnode_read_bool: spi-cpol: false
ofnode_read_bool: spi-cpha: false
ofnode_read_bool: spi-cs-high: false
ofnode_read_bool: spi-3wire: false
ofnode_read_bool: spi-half-duplex: false
ofnode_read_u32_index: spi-tx-bus-width: 0x4 (4)
ofnode_read_u32_index: spi-rx-bus-width: 0x4 (4)
bind node spi@10050000
   - attempt to match compatible string 'sifive,fu740-c000-spi'
   - attempt to match compatible string 'sifive,spi0'
   - found match at driver 'sifive_spi' for 'sifive,spi0'
   - seq=0
bind node mmc@0
   - attempt to match compatible string 'mmc-spi-slot'
   - found match at driver 'mmc_spi' for 'mmc-spi-slot'
ofnode_read_u32_index: reg: 0x0 (0)
ofnode_read_u32_index: spi-max-frequency: 0x1312d00 (20000000)
ofnode_read_bool: spi-cpol: false
ofnode_read_bool: spi-cpha: false
ofnode_read_bool: spi-cs-high: false
ofnode_read_bool: spi-3wire: false
ofnode_read_bool: spi-half-duplex: false
ofnode_read_u32_index: spi-tx-bus-width: (not found)
ofnode_read_u32_index: spi-rx-bus-width: (not found)
bind node ethernet@10090000
   - attempt to match compatible string 'sifive,fu540-c000-gem'
   - found match at driver 'eth_macb' for 'sifive,fu540-c000-gem'
   - seq=0
bind node pwm@10020000
   - attempt to match compatible string 'sifive,fu740-c000-pwm'
   - attempt to match compatible string 'sifive,pwm0'
   - found match at driver 'pwm_sifive' for 'sifive,pwm0'
bind node pwm@10021000
   - attempt to match compatible string 'sifive,fu740-c000-pwm'
   - attempt to match compatible string 'sifive,pwm0'
   - found match at driver 'pwm_sifive' for 'sifive,pwm0'
bind node cache-controller@2010000
   - attempt to match compatible string 'sifive,fu740-c000-ccache'
   - found match at driver 'sifive_ccache' for 'sifive,fu740-c000-ccache'
bind node gpio@10060000
   - attempt to match compatible string 'sifive,fu740-c000-gpio'
   - attempt to match compatible string 'sifive,gpio0'
   - found match at driver 'gpio_sifive' for 'sifive,gpio0'
bind node pcie@e00000000
   - attempt to match compatible string 'sifive,fu740-pcie'
   - found match at driver 'pcie_sifive' for 'sifive,fu740-pcie'
bind node clint@2000000
   - attempt to match compatible string 'riscv,clint0'
No match for node 'clint@2000000'
bind node dmc@100b0000
   - attempt to match compatible string 'sifive,fu740-c000-ddr'
   - found match at driver 'sifive_ddr' for 'sifive,fu740-c000-ddr'
bind node memory@80000000
Device 'memory@80000000' has no compatible string
bind node hfclk
   - attempt to match compatible string 'fixed-clock'
   - found match at driver 'fixed_clock' for 'fixed-clock'
bind node rtcclk
   - attempt to match compatible string 'fixed-clock'
   - found match at driver 'fixed_clock' for 'fixed-clock'
bind node gpio-poweroff
   - attempt to match compatible string 'gpio-poweroff'
No match for node 'gpio-poweroff'
bind node binman
Device 'binman' has no compatible string
bind node config
Device 'config' has no compatible string
bind node mmode_resv1@80000000
Device 'mmode_resv1@80000000' has no compatible string
bind node mmode_resv0@80040000
Device 'mmode_resv0@80040000' has no compatible string
ofnode_read_u32_array: ranges: bind node cpu@1
   - attempt to match compatible string 'sifive,bullet0'
   - attempt to match compatible string 'riscv'
   - found match at driver 'riscv_cpu' for 'riscv'
ofnode_read_u32_index: timebase-frequency: (not found)
ofnode_read_u32_index: timebase-frequency: 0xf4240 (1000000)
bind node cpu@2
   - attempt to match compatible string 'sifive,bullet0'
   - attempt to match compatible string 'riscv'
   - found match at driver 'riscv_cpu' for 'riscv'
ofnode_read_u32_index: timebase-frequency: (not found)
ofnode_read_u32_index: timebase-frequency: 0xf4240 (1000000)
bind node cpu@3
   - attempt to match compatible string 'sifive,bullet0'
   - attempt to match compatible string 'riscv'
   - found match at driver 'riscv_cpu' for 'riscv'
ofnode_read_u32_index: timebase-frequency: (not found)
ofnode_read_u32_index: timebase-frequency: 0xf4240 (1000000)
bind node cpu@4
   - attempt to match compatible string 'sifive,bullet0'
   - attempt to match compatible string 'riscv'
   - found match at driver 'riscv_cpu' for 'riscv'
ofnode_read_u32_index: timebase-frequency: (not found)
ofnode_read_u32_index: timebase-frequency: 0xf4240 (1000000)
ofnode_read_prop: assigned-clock-rates: ofnode_read_u32_array: assigned-clock-rates: Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_prop: assigned-clock-rates: <not found>
Looking for hfclk
Looking for hfclk
   - result for hfclk: hfclk (ret=0)
   - result for hfclk: hfclk (ret=0)
ofnode_read_u32_index: clock-frequency: 0x18cba80 (26000000)
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_prop: assigned-clock-rates: <not found>
Looking for rtcclk
Looking for rtcclk
   - result for rtcclk: rtcclk (ret=0)
   - result for rtcclk: rtcclk (ret=0)
ofnode_read_u32_index: clock-frequency: 0xf4240 (1000000)
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_prop: tick-timer: <not found>
ofnode_read_prop: assigned-clock-rates: <not found>
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
ofnode_read_prop: assigned-clock-rates: <not found>
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
ofnode_read_prop: assigned-clock-rates: <not found>
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
ofnode_read_prop: assigned-clock-rates: <not found>
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_prop: assigned-clock-rates: <not found>
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
Core:  36 devices, 21 uclasses, devicetree: separate
MMC:   0
   - 0 'mmc@0'
   - found
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_u32_index: sifive,fifo-depth: (not found)
ofnode_read_u32_index: sifive,max-bits-per-word: (not found)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
ofnode_read_u32_index: spi-max-frequency: (not found)
ofnode_read_prop: assigned-clock-rates: <not found>
1
   - 0 'mmc@0'
   - not found
spi@10050000:mmc@0: 0
ofnode_read_u32_index: load-environment: (not found)
Loading Environment from SPIFlash... 1
   - 1 'spi@10040000'
   - found
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_u32_index: sifive,fifo-depth: (not found)
ofnode_read_u32_index: sifive,max-bits-per-word: (not found)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
ofnode_read_u32_index: spi-max-frequency: (not found)
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_bool: m25p,fast-read: true
SF: Detected is25wp256 with page size 256 Bytes, erase size 4 KiB, total 32 MiB
0
   - 0 'ethernet@10090000'
   - found
OK
EEPROM: 0
   - 0 'i2c@10030000'
   - found
ofnode_read_u32_index: u-boot,i2c-transaction-bytes: (not found)
ofnode_read_u32_index: u-boot,i2c-transaction-bytes: (not found)
ofnode_read_u32_index: u-boot,i2c-transaction-bytes: (not found)
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_u32_index: reg-shift: 0x2 (2)
ofnode_read_u32_index: clock-frequency: (not found)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
ofnode_read_u32_index: reg-io-width: 0x1 (1)
ofnode_read_u32_index: clock-frequency: (not found)
SiFive PCB EEPROM format v1
Product ID: 0002 (HiFive Unmatched)
PCB revision: 3
BOM revision: B
BOM variant: 0
Serial number: SF105SZ211900108
Ethernet MAC address: 70:b3:d5:92:f4:fc
CRC: c26d0cff
Looking for gpio@10060000
Looking for gpio@10060000
   - result for gpio@10060000: gpio@10060000 (ret=0)
   - result for gpio@10060000: gpio@10060000 (ret=0)
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_u32_index: ngpios: (not found)
Looking for gpio@10060000
Looking for gpio@10060000
   - result for gpio@10060000: gpio@10060000 (ret=0)
   - result for gpio@10060000: gpio@10060000 (ret=0)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: reset (ret=0)
   - result for clock-controller@10000000: reset (ret=0)
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_bool: u-boot,skip-auto-config-until-reloc: false
ofnode_read_prop: assigned-clock-rates: <not found>
PCIE-0: Link up (Gen1-x8, Bus0)
PCI: Failed autoconfig bar 10
In:    serial@10010000
Out:   serial@10010000
Err:   serial@10010000
Model: SiFive HiFive Unmatched A00
Net:   ofnode_read_prop: assigned-clock-rates: ofnode_read_u32_array: assigned-clock-rates: Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
ofnode_read_prop: phy-mode: gmii
ofnode_read_u32_index: reg: 0x0 (0)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
   - result for clock-controller@10000000: clock-controller@10000000 (ret=0)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: reset (ret=0)
   - result for clock-controller@10000000: reset (ret=0)
Looking for clock-controller@10000000
Looking for clock-controller@10000000
   - result for clock-controller@10000000: reset (ret=0)
   - result for clock-controller@10000000: reset (ret=0)
eth0: ethernet@10090000
drivers/core/ofnode.c:575: ofnode_find_subnode: Assertion `ofnode_valid(node)' failed.
resetting ...

==================

-- 
Regards,
Yuri
