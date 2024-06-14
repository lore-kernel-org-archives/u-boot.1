Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB064C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17565889FD;
	Fri, 14 Jun 2024 16:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OmxIPek8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92C2C88A00; Fri, 14 Jun 2024 16:25:57 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57A8E889FB
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E0BC461F33;
 Fri, 14 Jun 2024 14:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F35C2BD10;
 Fri, 14 Jun 2024 14:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718375153;
 bh=gDjerEWQYg4RiYFqOp+FSn1FHNrEvIwzl4yie5Foj0s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OmxIPek8wQEMqV9nknk6ZluVgQ3rVCMtamW/7PBlhVREwR+Z78Xkyt+kNMCEWn/vW
 RTtpkG+UgsVokdHNRXadmNGsbP7syBdFlofPsVcvpTFio6X7uRxqsdHoS10/v+dSvg
 3fUit6cpNOV+47prJU5zRqojk3lmDjmFfNijoxKhhdCyecvl6OXzeeVM79pBRMRjWC
 cFU2nNKpSP84tOqTr3VOhpKYhaaLkoMnGxWjAiTkZhEOEQtUXCPuZgzAAGY4AmeMXT
 0o5QKaYRjKAWC3HtvCfKTDhSa8y2Gk8EdDV2vlbgE4FAYBicPfof4Ja4J1A02K0NRq
 /nh5KYEvtHq5A==
Date: Fri, 14 Jun 2024 15:25:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de,
 Minda Chen <minda.chen@starfivetech.com>
Subject: Re: v2024.07-rc4 PCI issues on VisionFive v2
Message-ID: <20240614-eating-squeeze-76fa72f6a3c4@spud>
References: <20240614-condense-hastiness-8163da268f60@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NYJZa30G06WbCaZg"
Content-Disposition: inline
In-Reply-To: <20240614-condense-hastiness-8163da268f60@wendy>
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


--NYJZa30G06WbCaZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 12:14:37PM +0100, Conor Dooley wrote:
> Hey,

I forgot a word in $subject, should have said PCI issues. I added it.

>=20
> After going from Vendor SPL/OpenSBI/U-Boot to OpenSBI v1.4++ plus
> v2024.07-rc4 SPL/U-Boot I ran into a boot loop problem relating to
> PCI:
> 	U-Boot 2024.07-rc4 (Jun 13 2024 - 15:09:34 +0100)
> =09
> 	CPU:   sifive,u74-mc
> 	Model: StarFive VisionFive 2 v1.2A
> 	DRAM:  4 GiB
> 	Core:  136 devices, 26 uclasses, devicetree: board
> 	WDT:   Not starting watchdog@13070000
> 	MMC:   mmc@16010000: 0, mmc@16020000: 1
> 	Loading Environment from SPIFlash... SF: Detected gd25lq128 with page si=
ze 256 Bytes, erase size 4 KiB, total 16 MiB
> 	OK
> 	StarFive EEPROM format v2
> =09
> 	--------EEPROM INFO--------
> 	Vendor : StarFive Technology Co., Ltd.
> 	Product full SN: VF7110A1-2249-D004E000-00000540
> 	data version: 0x2
> 	PCB revision: 0xa1
> 	BOM revision: A
> 	Ethernet MAC0 address: 6c:cf:39:00:17:95
> 	Ethernet MAC1 address: 6c:cf:39:00:17:96
> 	--------EEPROM INFO--------
> =09
> 	starfive_7110_pcie pcie@2b000000: Starfive PCIe bus probed.
> 	starfive_7110_pcie pcie@2c000000: Starfive PCIe bus probed.
> 	In:    serial@10000000
> 	Out:   serial@10000000
> 	Err:   serial@10000000
> 	Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
> 	starting USB...
> 	Bus xhci_pci: Register 5000420 NbrPorts 5
> 	Starting the controller
> 	USB XHCI 1.00
> 	scanning bus xhci_pci for devices...=20
> 	U-Boot SPL 2024.07-rc4 (Jun 13 2024 - 15:09:34 +0100)
> 	DDR version: dc2e84f0.
> 	Trying to boot from SPI
>=20
> This only appeared after I refreshed the environment by running.
> `env default -a -f; env save`. Before that things worked "fine", I
> suppose because nothing actually touched PCI. I've just disabled
> PCI for now and things are working once more. I've not attempted
> to bisect/debug this, cos that's not the fastest process while
> running U-Boot out of flash.
>=20
> In case it is relevant, the board I have is one of the "super early
> bird" ones.

It's also worth mentioning that I have a WDS1000T3B0C NVMe driver
connected to the slot on the board - but it doesn't contain my next
stage etc.

Thanks,
Conor.


--NYJZa30G06WbCaZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmxS7QAKCRB4tDGHoIJi
0gmMAQCeoMR+0hArpazb5hK9OpB91aFVobc+QGG9mEDbXBsdlgEA41AZdUdJXpK0
QC2i+a1U5NZbRQsDwx+71sJ4sYXl0AY=
=prdV
-----END PGP SIGNATURE-----

--NYJZa30G06WbCaZg--
