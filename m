Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAAAD6C29A
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 21:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B1588DC6;
	Tue, 19 Nov 2024 22:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ch5rirZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3377188F27; Tue, 19 Nov 2024 22:03:50 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA4E288C53
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 22:03:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732050227; x=1732655027; i=xypron.glpk@gmx.de;
 bh=4jRgaDDgovyi1egqF8xbeaeGr26fO/sjLtBxZR9uei4=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ch5rirZRiImd3u5Z952aaBUESAriezAEYe8qVA9yJxf/F56fFHDdp8WH7oE9K184
 XETlNRQUQ0Wy1NvijtVxoIfPyAes1pX69ooXKNECAOxRW9ytpBQJeogd7hv/SytyP
 P7cqPW1gf9S9GpXFMAX8Otrjq8hxIz/xh/cE7XR3IQXfycjj/l/fE0xe509zANBsE
 RGvQDiWrl54frV4UbTVlCBSUtkIXrXb9x/V6nx6Od/vaqeM1yomJXh43Ahl0azdmq
 Zsea0CtR4TMwkwSDGHLeZtp68HxW6onpV78sOBxITLnExmRPZnAORBxvU7+DiPILb
 XkbqOyjQNmarej9SPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1tf6ty0965-00n3x1; Tue, 19
 Nov 2024 22:03:47 +0100
Date: Tue, 19 Nov 2024 22:03:45 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Yuri Zaporozhets <yuriz@vodafonemail.de>
CC: u-boot@lists.denx.de
Subject: Re: BUG: SiFive Unmatched: BAR0 on video card is never initialized
User-Agent: Thunderbird for Android
In-Reply-To: <Zzz483tW7ODsig6u@vodafonemail.de>
References: <Zzz483tW7ODsig6u@vodafonemail.de>
Message-ID: <6A65FCCE-4A7C-4558-9753-66E0563C62E5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Slo6BtjtV+Mh5Dv93YyprNeeyW9pefn3Go+TsDJnk8qDbB5ZjR/
 wG+Rd3pUoG6UBSDDe5+cIomZgurRom1H8MUge3+bCqHD9zSjiEWhdNIOBA1A+u4I5l2mxaA
 HKFO40WNJUo6qZgw/7/iZ8Q3nURpPLE3AzlELxeM3hGDbFKl8SKlbTwhohqX/fOE7JFuTWJ
 F4jhHaNqPezBKsE0YQTEg==
UI-OutboundReport: notjunk:1;M01:P0:WAhOWqZhh5s=;lf+fr4F60I8cwzjXX8KIS/6HNbF
 YWSl9gIlGuzGQb4Lmtal+g6kLO9hUJwOINhbZrF5znHJq+67G1NJSvN+W9tv/pxFKDKbVMUx1
 SQtarjZ6tkBGRH1Oq4T0Byhlh4yurnJTh56lpgja+eBNKYugISUdqsej2J3r4+GtsKKAmdEPI
 c2XlXr178B2qH7fCoLVWmFEFK9sIWvA0y3H0fAjGY4QamCfpz5F+TX36bm1FARYwIzJI7FNtO
 tGoOayTdGnNK+djtpGe5fQMkVKmsFgXDljo85s/KUBY/HiyuafMlV/KXX0uOhAan0eSOtYEVn
 mWFBX8pYYSlXGSixFvwhhGMSkUB1oI0wVRzobkIkxp68xPiwmsFNZUMvqYK5CZ3gQfsJkM8a5
 t7Hv+ZGCg8QmN1dTc6N24+cAJJOpJkdrO/C2BkLsMaTRIOmqi1gcpqbnaMjeRMAg1Je0QdH4L
 jTkkeE3wMc/pmn0ZCBvNPkWCzKAOQm5uFtALkOyYAMRRi0RNbwpom0WDjOAJPp+3DwyWth2qZ
 5yjqXkM/VR1VC/NYfONLaVkrIn+2uAd7B9Ut4qFZPBM/eb2kOFlj8Uol9UAOhxDwzRJj7gXWz
 3HCVQnpr1KntAFQDyf59o/9NXatPp6okMTui9j86AX0J6j9rdifvYX/oGzBxIUR30MWZUQlS9
 4azpPjo9mmvHa4FCTjT4ojwbAXLVi5ye3314vMRv06NXLXEzoMZ72R+V8IsKVCmuRd79VHCjD
 i30eBPRcrmiZbNitKSky5CxVa2PN2J8S5r0KL1OogA3a55XHXD+2GRZ9fW483xCrIYgbMDVUL
 YjUnHR8/V8eZxWpVZ012u6Oo5ghBT0Pcu0VC1kBdouTjvSlnMuaLjxehcejEJxQqtCaCmWGUB
 Toq4tfZvzjwMvHyJyROwdAnJcqCBAIQZRelFJoAd0Dg1n12WmdQg0j4+f
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

Am 19=2E November 2024 21:45:39 MEZ schrieb Yuri Zaporozhets <yuriz@vodafon=
email=2Ede>:
>Hi Heinrich; hi all owners of SiFive Unmatched + PCIe video card,
>
>Default U-Boot configuration for Unmatched always fails to initialize
>BAR0 of my video card (NVidia GT710), because the PCI driver selects the =
MEMORY
>region at 0x70000000 for bus_start/phys_start ("region 2", according to
>decode_regions() output), which has the size of 0x1000000=2E Naturally, t=
he
>video card's BAR0 doesn't fit into this small region, because its size
>is also 0x1000000:
>
>  pci_auto_config_devices: start
>  PCI Autoconfig: Bus Memory region: [70000000-70ffffff],
>                  Physical Memory [70000000-70ffffff]
>  PCI Autoconfig: Bus Prefetchable Mem region: [2000000000-3fffffffff],
>                  Physical Memory [2000000000-3fffffffff]
>  PCI Autoconfig: Bus I/O region: [60080000-6008ffff],
>                  Physical Memory [60080000-6008ffff]
>  =2E=2E=2E=2E=2E=2E=2E
>  pci_auto_config_devices: device pci_7:0=2E0
>  PCI Autoconfig: BAR 0, Mem, size=3D0x1000000, bus_lower=3D0x70400000, b=
us_start=3D0x70000000, phys_start=3D0x70000000
>  addr =3D 0x71000000
>  No room in resource, avail start=3D70400000 / size=3D1000000, need=3D10=
00000
>  PCI: Failed autoconfig bar 10
>
>The situation changes drastically if CONFIG_PCI_REGION_MULTI_ENTRY is set=
 to "yes"=2E
>After this, PCI starts to use "region 1" for MEMORY, which has the size o=
f
>0xFF70000, and is, obviously, suitable for GPU's BAR0:
>
>pci_uclass_pre_probe, bus=3D-1/pcie@e00000000, parent=3Dsoc
>decode_regions: len=3D28, cells_per_record=3D7
>decode_regions: region 0, pci_addr=3D60080000, addr=3D60080000, size=3D10=
000, space_code=3D1
> - type=3D1, pos=3D0
>decode_regions: region 1, pci_addr=3D60090000, addr=3D60090000, size=3Dff=
70000, space_code=3D2
> - type=3D0, pos=3D1
>decode_regions: region 2, pci_addr=3D70000000, addr=3D70000000, size=3D10=
00000, space_code=3D2
> - type=3D0, pos=3D2
>decode_regions: region 3, pci_addr=3D2000000000, addr=3D2000000000, size=
=3D2000000000, space_code=3D3
> - type=3D8, pos=3D3
>=2E=2E=2E=2E
>PCIE-0: Link up (Gen1-x8, Bus0)
>pci_uclass_post_probe: probing bus 0
>pci_bind_bus_devices: bus 0/pcie@e00000000: found device 0, function 0: f=
ind ret=3D-19
>pci_find_and_bind_driver: Searching for driver: vendor=3Df15e, device=3D0
>pci_find_and_bind_driver: No match found: bound generic driver instead
>pci_auto_config_devices: start
>PCI Autoconfig: Bus Memory region: [60090000-6fffffff],
>                Physical Memory [60090000-6fffffff]
>PCI Autoconfig: Bus Prefetchable Mem region: [2000000000-3fffffffff],
>                Physical Memory [2000000000-3fffffffff]
>PCI Autoconfig: Bus I/O region: [60080000-6008ffff],
>                Physical Memory [60080000-6008ffff]
>
>This picture is in full accord with Linux kernel, which also uses
>0x69000000 ("region 1") for bus_start and phys_start=2E
>
>With this setting, all BARs on all devices are initialized correctly,
>and, moreover, I can access memory-mapped VGA ports of the card (see [1] =
for
>details), which is essential for initializing the card in text mode with
>bios_emulator:
>
>PCI Autoconfig: BAR 0, Mem, size=3D0x1000000, bus_lower=3D0x60500000, bus=
_start=3D0x60090000, phys_start=3D0x60090000
>address=3D0x61000000 bus_lower=3D0x62000000
>
>PCI Autoconfig: BAR 1, Prf64, size=3D0x8000000, bus_lower=3D0x2000000000,=
 bus_start=3D0x2000000000, phys_start=3D0x2000000000
>address=3D0x2000000000 bus_lower=3D0x2008000000
>
>PCI Autoconfig: BAR 2, Prf64, size=3D0x2000000, bus_lower=3D0x2008000000,=
 bus_start=3D0x2000000000, phys_start=3D0x2000000000
>address=3D0x2008000000 bus_lower=3D0x200a000000
>
>PCI Autoconfig: BAR 3, I/O, size=3D0x80, bus_lower=3D0x60080000, bus_star=
t=3D0x60080000, phys_start=3D0x60080000
>address=3D0x60080000 bus_lower=3D0x60080080
>
>PCI Autoconfig: ROM, size=3D0x80000, bus_lower=3D0x62000000, bus_start=3D=
0x60090000, phys_start=3D0x60090000
>address=3D0x62000000 bus_lower=3D0x62080000
>
>Notes:
>
>[1]: https://envytools=2Ereadthedocs=2Eio/en/latest/hw/mmio=2Ehtml#gf100-=
mmio-map
>

Hello Yuri,

Thank you for sharing your investigation results=2E Could you, please, sen=
d a patch?

Were you able to show output on HDMI?

Best regards

Heinrich

