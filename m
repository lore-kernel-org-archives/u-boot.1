Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8A3C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 11:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45390889A1;
	Fri, 14 Jun 2024 13:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="ydLrmiGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06412889B3; Fri, 14 Jun 2024 13:15:27 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63C83883AB
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=8880cef7d=Conor.Dooley@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1718363725; x=1749899725;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=iF7wgGjRHBFfZVH/TieCRlvx/MSsql4aQbQtAS1B5tA=;
 b=ydLrmiGHso3WyjfXONUpI4oanpHELRJTffz2yxBvZgxIuR+d4hHa5iYP
 zlMzpRIecI/oCld3aLnU63czv8hPZhkJrduLovUlo6KrS6wwCBhayedyT
 O9UUzgkSrIjzZSARhpHv5inwEYoSfEvhZhCdedPpFakmLWUgUpm/6wM7t
 8BH+FNrTXqIZNTSsJm7BiY4cBikKutUDtovvlmJReL58lmyNWCyxF77Iq
 Y9zg1b3pd6pPYdPjpDhjOad2SMoimSZJcDaPLNu+xR1EG2nk6160dsJrG
 ZAqibFtVvXlBrmmSQldGhQ03UEhS2J7qNX9+VSIUU6qQes+FV3vO8nhr7 g==;
X-CSE-ConnectionGUID: AZaD9F6uQjCU0St7mPsn4g==
X-CSE-MsgGUID: uMCYjyFsQ22+MnXLHehEXw==
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
 d="asc'?scan'208";a="27548374"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Jun 2024 04:15:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Jun 2024 04:14:56 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 14 Jun 2024 04:14:55 -0700
Date: Fri, 14 Jun 2024 12:14:37 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: <u-boot@lists.denx.de>
CC: <xypron.glpk@gmx.de>, Minda Chen <minda.chen@starfivetech.com>
Subject: v2024.07-rc4 issues on VisionFive v2
Message-ID: <20240614-condense-hastiness-8163da268f60@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PigCmc3XYAzlJNZ9"
Content-Disposition: inline
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

--PigCmc3XYAzlJNZ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

After going from Vendor SPL/OpenSBI/U-Boot to OpenSBI v1.4++ plus
v2024.07-rc4 SPL/U-Boot I ran into a boot loop problem relating to
PCI:
	U-Boot 2024.07-rc4 (Jun 13 2024 - 15:09:34 +0100)
=09
	CPU:   sifive,u74-mc
	Model: StarFive VisionFive 2 v1.2A
	DRAM:  4 GiB
	Core:  136 devices, 26 uclasses, devicetree: board
	WDT:   Not starting watchdog@13070000
	MMC:   mmc@16010000: 0, mmc@16020000: 1
	Loading Environment from SPIFlash... SF: Detected gd25lq128 with page size=
 256 Bytes, erase size 4 KiB, total 16 MiB
	OK
	StarFive EEPROM format v2
=09
	--------EEPROM INFO--------
	Vendor : StarFive Technology Co., Ltd.
	Product full SN: VF7110A1-2249-D004E000-00000540
	data version: 0x2
	PCB revision: 0xa1
	BOM revision: A
	Ethernet MAC0 address: 6c:cf:39:00:17:95
	Ethernet MAC1 address: 6c:cf:39:00:17:96
	--------EEPROM INFO--------
=09
	starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
	starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
	In:    serial@10000000
	Out:   serial@10000000
	Err:   serial@10000000
	Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
	starting USB...
	Bus xhci_pci: Register 5000420 NbrPorts 5
	Starting the controller
	USB XHCI 1.00
	scanning bus xhci_pci for devices...=20
	U-Boot SPL 2024.07-rc4 (Jun 13 2024 - 15:09:34 +0100)
	DDR version: dc2e84f0.
	Trying to boot from SPI

This only appeared after I refreshed the environment by running.
`env default -a -f; env save`. Before that things worked "fine", I
suppose because nothing actually touched PCI. I've just disabled
PCI for now and things are working once more. I've not attempted
to bisect/debug this, cos that's not the fastest process while
running U-Boot out of flash.

In case it is relevant, the board I have is one of the "super early
bird" ones.

Cheers,
Conor.

--PigCmc3XYAzlJNZ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmwmHQAKCRB4tDGHoIJi
0qymAQC9SdjDkARig5XdrhJECdMUjurF0YKax1m2k8t3XLH/NgD+OEbDww0tZstx
DLGEr7iFiBD71IZqAOWoS2NkHO++XAo=
=cs33
-----END PGP SIGNATURE-----

--PigCmc3XYAzlJNZ9--
