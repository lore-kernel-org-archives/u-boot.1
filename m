Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58127D6C29A
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 20:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF98988F27;
	Tue, 19 Nov 2024 21:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=vodafonemail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=vodafonemail.de header.i=@vodafonemail.de header.b="R3VGs6ul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B60888F27; Tue, 19 Nov 2024 21:45:53 +0100 (CET)
Received: from mr5.vodafonemail.de (mr5.vodafonemail.de [145.253.228.165])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96390885F4
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 21:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=vodafonemail.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vodafonemail.de;
 s=vfde-mb-mr2-23sep; t=1732049150;
 bh=yoDim3z2PINTlHrdkkujPuMmEwBGcv8JqPx7EHDLzAE=;
 h=Date:From:To:Subject:Message-ID:Content-Type:From;
 b=R3VGs6ulaoWLaft4/qJqSHw8Dw6YTGEtz6hB1aWD0Q1jCuCVhNAY1472XxmtxrD/k
 SuhvSqLkSlbUhuHUFyWWI/1eIhju1EXnHLdy6WGhmHjQz/RSJY/u5MFu4x/eI46BV9
 EYBCKucw8LtyD8spHuXiNGDHFuU5N06qMU3JuJiw=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr5.vodafonemail.de (Postfix) with ESMTPS id 4XtGjV21Vpz1y65;
 Tue, 19 Nov 2024 20:45:50 +0000 (UTC)
Received: from tachyon.qrv-systems.net
 (ip-095-222-025-162.um34.pools.vodafone-ip.de [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4XtGjM0gS1z9rwL;
 Tue, 19 Nov 2024 20:45:40 +0000 (UTC)
Received: by tachyon.qrv-systems.net (Postfix, from userid 516)
 id 93EAF2E01AB; Tue, 19 Nov 2024 21:45:39 +0100 (CET)
Date: Tue, 19 Nov 2024 21:45:39 +0100
From: Yuri Zaporozhets <yuriz@vodafonemail.de>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: BUG: SiFive Unmatched: BAR0 on video card is never initialized
Message-ID: <Zzz483tW7ODsig6u@vodafonemail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 3842
X-purgate-ID: 155817::1732049146-18FF8466-E129AD60/0/0
X-Mailman-Approved-At: Tue, 19 Nov 2024 21:54:26 +0100
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

Hi Heinrich; hi all owners of SiFive Unmatched + PCIe video card,

Default U-Boot configuration for Unmatched always fails to initialize
BAR0 of my video card (NVidia GT710), because the PCI driver selects the MEMORY
region at 0x70000000 for bus_start/phys_start ("region 2", according to
decode_regions() output), which has the size of 0x1000000. Naturally, the
video card's BAR0 doesn't fit into this small region, because its size
is also 0x1000000:

  pci_auto_config_devices: start
  PCI Autoconfig: Bus Memory region: [70000000-70ffffff],
                  Physical Memory [70000000-70ffffff]
  PCI Autoconfig: Bus Prefetchable Mem region: [2000000000-3fffffffff],
                  Physical Memory [2000000000-3fffffffff]
  PCI Autoconfig: Bus I/O region: [60080000-6008ffff],
                  Physical Memory [60080000-6008ffff]
  .......
  pci_auto_config_devices: device pci_7:0.0
  PCI Autoconfig: BAR 0, Mem, size=0x1000000, bus_lower=0x70400000, bus_start=0x70000000, phys_start=0x70000000
  addr = 0x71000000
  No room in resource, avail start=70400000 / size=1000000, need=1000000
  PCI: Failed autoconfig bar 10

The situation changes drastically if CONFIG_PCI_REGION_MULTI_ENTRY is set to "yes".
After this, PCI starts to use "region 1" for MEMORY, which has the size of
0xFF70000, and is, obviously, suitable for GPU's BAR0:

pci_uclass_pre_probe, bus=-1/pcie@e00000000, parent=soc
decode_regions: len=28, cells_per_record=7
decode_regions: region 0, pci_addr=60080000, addr=60080000, size=10000, space_code=1
 - type=1, pos=0
decode_regions: region 1, pci_addr=60090000, addr=60090000, size=ff70000, space_code=2
 - type=0, pos=1
decode_regions: region 2, pci_addr=70000000, addr=70000000, size=1000000, space_code=2
 - type=0, pos=2
decode_regions: region 3, pci_addr=2000000000, addr=2000000000, size=2000000000, space_code=3
 - type=8, pos=3
....
PCIE-0: Link up (Gen1-x8, Bus0)
pci_uclass_post_probe: probing bus 0
pci_bind_bus_devices: bus 0/pcie@e00000000: found device 0, function 0: find ret=-19
pci_find_and_bind_driver: Searching for driver: vendor=f15e, device=0
pci_find_and_bind_driver: No match found: bound generic driver instead
pci_auto_config_devices: start
PCI Autoconfig: Bus Memory region: [60090000-6fffffff],
                Physical Memory [60090000-6fffffff]
PCI Autoconfig: Bus Prefetchable Mem region: [2000000000-3fffffffff],
                Physical Memory [2000000000-3fffffffff]
PCI Autoconfig: Bus I/O region: [60080000-6008ffff],
                Physical Memory [60080000-6008ffff]

This picture is in full accord with Linux kernel, which also uses
0x69000000 ("region 1") for bus_start and phys_start.

With this setting, all BARs on all devices are initialized correctly,
and, moreover, I can access memory-mapped VGA ports of the card (see [1] for
details), which is essential for initializing the card in text mode with
bios_emulator:

PCI Autoconfig: BAR 0, Mem, size=0x1000000, bus_lower=0x60500000, bus_start=0x60090000, phys_start=0x60090000
address=0x61000000 bus_lower=0x62000000

PCI Autoconfig: BAR 1, Prf64, size=0x8000000, bus_lower=0x2000000000, bus_start=0x2000000000, phys_start=0x2000000000
address=0x2000000000 bus_lower=0x2008000000

PCI Autoconfig: BAR 2, Prf64, size=0x2000000, bus_lower=0x2008000000, bus_start=0x2000000000, phys_start=0x2000000000
address=0x2008000000 bus_lower=0x200a000000

PCI Autoconfig: BAR 3, I/O, size=0x80, bus_lower=0x60080000, bus_start=0x60080000, phys_start=0x60080000
address=0x60080000 bus_lower=0x60080080

PCI Autoconfig: ROM, size=0x80000, bus_lower=0x62000000, bus_start=0x60090000, phys_start=0x60090000
address=0x62000000 bus_lower=0x62080000

Notes:

[1]: https://envytools.readthedocs.io/en/latest/hw/mmio.html#gf100-mmio-map

-- 
Regards,
Yuri
