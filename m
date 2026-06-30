Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAABC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 19:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59DE884A52;
	Tue, 30 Jun 2026 21:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s1MZv9Y1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE6184ACD; Tue, 30 Jun 2026 21:37:47 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59B2084A49
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 21:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e93cd4e64bso3674384a34.2
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782848263; x=1783453063; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lURNXgV7ANRbhQx8tCuNQBnEjdCUc5680jjZkjxtLW4=;
 b=s1MZv9Y1AjeI7+7Ykqt/xYv+7sSJEOWd7GL7SkuRbZwcwnKaZwJsfaQ3F8TPPeuhAW
 AJo62EwXqe9ibQFZ5OngA49SE9K6W/G7M55+pP/aimzvHTlWJ3UX9WqZuGmAKMgqTpTj
 Vi6ReivwohsrLUbIqbj6t3RZS4Lyw5TDIK5vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782848263; x=1783453063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lURNXgV7ANRbhQx8tCuNQBnEjdCUc5680jjZkjxtLW4=;
 b=oejELFRZTZ6CzuWI9fTebEjTs2hOnmKZikUhSOlRsldkIb01Do3IcjeD7vt3A9jDsJ
 VcYf6r91JyHXGWlBB/HJfLhaIwvsS1B1FoQQJdRKFnh80dOBevVH5b32S5h1Yjf99Lf1
 6DftEH93ef/1nCb4GAnLBCmeiKj9WwgvRHz6F/CZ2caxXhoufCZ3DwX35yGllINzKyHH
 0r0LOB/x2ebqSoit0rZP9+PloCusC962tngIiwD8B1LEsiJulILcZcMem6VrC5oWd1YD
 g3saTqYr2K/qkfD1VcSEEv/7YckJrB6F7FYddV1G7guoep+DMQjNlx5LIZFj9pOXZWJl
 taGQ==
X-Gm-Message-State: AOJu0YxTLJsJpIBg/9jojhGkMmMic9pYH/fYb/SmShKeYb87K3XNUVGR
 H/2Dk6Fb/YlQ19irkR+G9ou0l664q2mz/AW7hI4wok977l1nI8PukWCFzOM6XJjXg7Y=
X-Gm-Gg: AfdE7cnL82SxJtiy2V7CJ7l+eYn56UwB6G+FEzJrbggtv5xFNIJji2xJX52VEtWKIBn
 7adtedH4ld2irTqtTwrV7xBnOSGq6A1BtrzvJV5FZ6QZOQhA3Uy6xiZNkLn8LuM62Yqio5gijWX
 zqZoq+A8/LFHOeR8ksgdGVmvtoTkPzw3/C0qZ2LDm7nyzbjGvjx9eBc0+FvNmPkqYjf6izIihVU
 2KXSyNL8eW+Qd3hzGG4B9O0uBWW/cCY+0cvTtIo0QqHzMk/k0SZXWMDamkEJzTbFU7g7QWjzv2R
 tlJt+G30hdI23MySdZVCKLCTzTroWlY/Gyc1Y7JJq5X83A3LWYuVav21x6fANP/wVCXRWOEYFTo
 Xi9m7kNl7S5OEr0ImUmyr+7jT+TbtWAPrIIe5xMr20UnE2XDLsmr7UAr5/v/vckmNwUhsxHLRbK
 Kq0bYutWRfUPWzTGG6JKY8x3uBPcIcS1U+TXJKZxlhNVjHxxdhmtE+Ah1LfOKoqn01TL3k+mDR5
 2JtekJfppe3FcottMze2ka4F8iTy16+D4eA9GIwTFJTNw0WAzo=
X-Received: by 2002:a05:6808:c2f8:b0:495:dd23:162f with SMTP id
 5614622812f47-495eafa1eb6mr4380898b6e.35.1782848262990; 
 Tue, 30 Jun 2026 12:37:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4935596b734sm9539271b6e.17.2026.06.30.12.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 12:37:42 -0700 (PDT)
Date: Tue, 30 Jun 2026 13:37:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Julien Stephan <jstephan@baylibre.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v7 0/8] Improve FIT signature handling
Message-ID: <20260630193737.GA2326735@bill-the-cat>
References: <20260618130943.549083-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M3wPtbdjxbt87ySj"
Content-Disposition: inline
In-Reply-To: <20260618130943.549083-1-ludwig.nussel@siemens.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--M3wPtbdjxbt87ySj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 02:47:35PM +0200, Ludwig Nussel wrote:

> This patch series tries to improve dealing with FIT
> (configuration-)signatures a bit:
>   - make signatures work with QEMU. QEMU brings it's own device tree at
>     a memory address. U-Boot expects public keys in it's own DT though.
>     So merge both.
>   - (optionally) enforce signatures so we can't accidentally boot
>     unsigned fit images. Quite an easy oversight, esp when qemu
>     previously didn't even use the built in DT.
>   - make iminfo verify configuration signatures, not just image hashes

I missed that CI hadn't completed before sending my previous message.
This doesn't pass CI still, as it breaks the
test_cmd_smbios_sysinfo_verbose test:
https://source.denx.de/u-boot/u-boot/-/jobs/1491333
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
_______________________ test_cmd_smbios_sysinfo_verbose ___________________=
_____
test/py/tests/test_smbios.py:52: in test_cmd_smbios_sysinfo_verbose
    assert 'Manufacturer: linux' in output
E   AssertionError: assert 'Manufacturer: linux' in 'SMBIOS 3.7.0 present.\=
r\r\n13 structures occupying 524 bytes\r\r\nTable at 0x13e474020\r\r\n\r\r\=
nHandle 0x0000, DMI ...000: 20 0b 0b 00 00 00 00 00 00 00 00\r\r\n\r\r\nHan=
dle 0x000c, DMI type 127, 4 bytes at 0x13e474226\r\r\nEnd Of Table'
----------------------------- Captured stdout call ------------------------=
-----
=3D> smbios
SMBIOS 3.7.0 present.
13 structures occupying 524 bytes
Table at 0x13e474020
Handle 0x0000, DMI type 0, 26 bytes at 0x13e474020
BIOS Information
	Vendor: U-Boot
	BIOS Version: 2026.07-rc5-00592-g791c9c97114d
	BIOS Release Date: 07/01/2026
	BIOS ROM Size: 0x00
	BIOS Characteristics: 0x0000000000010880
	BIOS Characteristics Extension Byte 1: 0x00
	BIOS Characteristics Extension Byte 2: 0x0c
	System BIOS Major Release: 0x1a
	System BIOS Minor Release: 0x07
	Embedded Controller Firmware Major Release: 0xff
	Embedded Controller Firmware Minor Release: 0xff
	Extended BIOS ROM Size: 0x0000
Handle 0x0001, DMI type 1, 27 bytes at 0x13e47406d
System Information
	Manufacturer: emulation
	Product Name: qemu-arm
	Version:=20
	Serial Number:=20
	UUID: 00000000-0000-0000-0000-000000000000
	Wake-up Type: Unknown
	SKU Number:=20
	Family: armv8
Handle 0x0002, DMI type 2, 15 bytes at 0x13e4740a2
Baseboard Information
	Manufacturer: emulation
	Product Name: qemu-arm
	Version:=20
	Serial Number:=20
	Asset Tag:=20
	Feature Flags: 0x01
	Chassis Location:=20
	Chassis Handle: 0x0003
	Board Type: Motherboard
	Number of Contained Object Handles: 0x00
Handle 0x0003, DMI type 3, 22 bytes at 0x13e4740c5
Chassis Information
	Manufacturer: emulation
	Type: 0x03
	Version:=20
	Serial Number:=20
	Asset Tag:=20
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM-defined: 0x00000000
	Height: 0x00
	Number of Power Cords: 0x00
	Contained Element Count: 0x00
	Contained Element Record Length: 0x00
	SKU Number:=20
Handle 0x0004, DMI type 7, 27 bytes at 0x13e4740e6
Cache Information:
	Socket Designation:=20
	Cache Configuration: 0x0180
	Maximum Cache Size: 0x0028
	Installed Size: 0x0028
	Supported SRAM Type: 0x0002
	Current SRAM Type: 0x0002
	Cache Speed: 0x00
	Error Correction Type: Unknown
	System Cache Type: Other
	Associativity: 4-way Set-Associative
	Maximum Cache Size 2: 0x00000000
	Installed Cache Size 2: 0x00000000
Handle 0x0005, DMI type 7, 27 bytes at 0x13e474103
Cache Information:
	Socket Designation:=20
	Cache Configuration: 0x0181
	Maximum Cache Size: 0x0400
	Installed Size: 0x0400
	Supported SRAM Type: 0x0002
	Current SRAM Type: 0x0002
	Cache Speed: 0x00
	Error Correction Type: Unknown
	System Cache Type: Unified
	Associativity: 16-way Set-Associative
	Maximum Cache Size 2: 0x00000000
	Installed Cache Size 2: 0x00000000
Handle 0x0006, DMI type 4, 50 bytes at 0x13e474120
Processor Information:
	Socket Designation:=20
	Processor Type: Central Processor
	Processor Family: [00fe]
	Processor Manufacturer: ARM Limited
	Processor ID word 0: 0x00000000
	Processor ID word 1: 0x00000000
	Processor Version:=20
	Voltage: 0x00
	External Clock: 0x0000
	Max Speed: 0x0000
	Current Speed: 0x0000
	Status: 0x01
	Processor Upgrade: None
	L1 Cache Handle: 0x0004
	L2 Cache Handle: 0x0005
	L3 Cache Handle: 0xffff
	Serial Number:=20
	Asset Tag:=20
	Part Number:=20
	Core Count: 0x01
	Core Enabled: 0x01
	Thread Count: 0x00
	Processor Characteristics: 0x0204
	Processor Family 2: ARMv8
	Core Count 2: 0x0000
	Core Enabled 2: 0x0000
	Thread Count 2: 0x0000
	Thread Enabled: 0x0000
Handle 0x0007, DMI type 9, 24 bytes at 0x13e47415f
System Slots:
	Socket Designation:=20
	Slot Type: PCI Express
	Slot Data Bus Width: 8x or x8
	Current Usage: In use
	Slot Length: Long Length
	Slot ID: 0x0800
	Slot Characteristics 1: 0x0004
	Slot Characteristics 2: 0x0001
	Segment Group Number (Base): 0x0000
	Bus Number (Base): 0x0040
	Device/Function Number (Base): 0x0000
	Data Bus Width (Base): 0x0000
	Peer (S/B/D/F/Width) grouping count: 0x0000
	Peer (S/B/D/F/Width) groups:
	Slot Information: 0x0000
	Slot Physical Width: 0x0000
	Slot Pitch: 0x0000
	Slot Height: 0x0000
Handle 0x0008, DMI type 16, 23 bytes at 0x13e474179
Physical Memory Array:
	Location: System board or motherboard
	Use: System memory
	Memory Error Correction: Unknown
	Maximum Capacity: 0x80000000
	Memory Error Information Handle: 0xfffe
	Number of Memory Devices: 0x0001
	Extended Maximum Capacity: 0x0000000000400000
Handle 0x0009, DMI type 17, 100 bytes at 0x13e474192
Memory Device:
	Physical Memory Array Handle: 0x0008
	Memory Error Information Handle: 0xfffe
	Total Width: 0x0000
	Data Width: 0x0000
	Size: 0x1000
	Form Factor: Unknown
	Device Set: 0x00ff
	Device Locator:=20
	Bank Locator:=20
	Memory Type: Unknown
	Type Detail: 0x0004
	Speed: 0x0000
	Manufacturer:=20
	Serial Number:=20
	Asset Tag:=20
	Part Number:=20
	Attributes: 0x0000
	Extended Size: 0x00000000
	Configured Memory Speed: 0x0000
	Minimum voltage: 0x0000
	Maximum voltage: 0x0000
	Configured voltage: 0x0000
	Memory Technology: Unknown
	Memory Operating Mode Capability: 0x0004
	Firmware Version:=20
	Module Manufacturer ID: 0x0000
	Module Product ID: 0x0000
	Memory Subsystem Controller Manufacturer ID: 0x0000
	Memory Subsystem Controller Product ID: 0x0000
	Non-volatile Size: 0xffffffffffffffff
	Volatile Size: 0xffffffffffffffff
	Cache Size: 0xffffffffffffffff
	Logical Size: 0xffffffffffffffff
	Extended Speed: 0x0000
	Extended Configured Memory Speed: 0x0000
	PMIC0 Manufacturer ID: 0x0000
	PMIC0 Revision Number: 0x0000
	RCD Manufacturer ID: 0x0000
	RCD Revision Number: 0x0000
Handle 0x000a, DMI type 19, 31 bytes at 0x13e4741f8
Memory Array Mapped Address:
	Starting Address: 0xffffffff
	Ending Address: 0xffffffff
	Memory Array Handle: 0x0008
	Partition Width: 0x0001
	Extended Starting Address: 0x0000000040000000
	Extended Ending Address: 0x000000013fffffff
Handle 0x000b, DMI type 32, 11 bytes at 0x13e474219
Header and Data:
	00000000: 20 0b 0b 00 00 00 00 00 00 00 00
Handle 0x000c, DMI type 127, 4 bytes at 0x13e474226
End Of Table
=3D>=20

--=20
Tom

--M3wPtbdjxbt87ySj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakQa/AAKCRAr4qD1Cr/k
Cg1EAP9IknTHYlgVESdGQVKQ2ylzq4JUuyWx/N0L0gcDXTnkkQEA/kXeoPYoiD07
QNowlSXdMb4fX7H9W8ca6O6cf6tSqAo=
=3Yoa
-----END PGP SIGNATURE-----

--M3wPtbdjxbt87ySj--
