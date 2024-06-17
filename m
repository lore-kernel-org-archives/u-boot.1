Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EDBC27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 03:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A42C88239;
	Mon, 17 Jun 2024 05:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8A5988245; Mon, 17 Jun 2024 05:54:56 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9044A881A9
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 05:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc72mpHyyPW7nk9fvWZuj0/RtKrK7V6M4C1yIEd5ZP3BQ2OaKnAT1uwhbmQpUrf+xkf2YFu23DvwhoRjzV3/Vd9d1Otfn3y+J7S7D8RgtZzfF8RqzyZGEQ8tWxUew8XUsK0zIrjm1Sg1bfEZn8Wbn6uVdTjebV5smnOBYs+dofcFNqvhVLVsjPAF50F+XbkdI0XBPS90Ejrki9iXxLNN0RRj47ijrRl3OkcoPapaRh0uTORjV/YeosTC4b1L98Dgj//ThtMvFRGinmVq9sWBZiHdenugKKv4gmqm3tRXPjXqT5081N1iWVqZ56dbXuahTdvoJeQ5QxEshXqeuOi4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SUEnBuDkSLkBE4ViQsMxbkQoRZL+Iy4OsynKoBYjXs=;
 b=LQr4gdNGm9rOs/PwWr2ElRxPUFOdsx5qIeZjyj38kJQY6GW3TRJjbT5/M3H2REvbpT4NlvL79b821gyAGqI77WpGHXlFogLy+T2FaqtQ2V9tacTLqBwI9fa33bD+YnXOFxFBnWminQ3MMd/3jr0R5NbaFYmXdZAKXGHeQV8TW/fZttOOAstUR1uCoj6rUAc/ZVwJ+TZnlxq21O6LVYUoQbe9cbCA5aL2d94x+IrjqKz+NuJ3jqE6ZwGfeeC9fPPSZr86MIg9WDdXsDuPSxuhllXCSqod8s0GtgXUU3+T8nn60rTFTlR68UI01Krefk5i3S30C4wy4FpKpR18BeDvaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0685.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.42; Mon, 17 Jun
 2024 03:54:47 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7656.033; Mon, 17 Jun 2024 03:54:47 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor.dooley@microchip.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, Hal Feng
 <hal.feng@starfivetech.com>
Subject: Re: v2024.07-rc4 issues on VisionFive v2
Thread-Topic: v2024.07-rc4 issues on VisionFive v2
Thread-Index: AQHavkwq/WKtJewga0S7EGop9BrWAbHLV5cQ
Date: Mon, 17 Jun 2024 03:54:47 +0000
Message-ID: <SHXPR01MB086333CE721C890725DE854BE6CD2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240614-condense-hastiness-8163da268f60@wendy>
In-Reply-To: <20240614-condense-hastiness-8163da268f60@wendy>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0685:EE_
x-ms-office365-filtering-correlation-id: f44147cc-79de-4151-5a6c-08dc8e813b23
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230037|1800799021|366013|41320700010|38070700015; 
x-microsoft-antispam-message-info: z5BbzuQvhpuLEGpk3HJc8C7Z/I5ofbh2elILJar+iSZrfm3/rHX5yt33mgFPEm7fWk7B7bnHMcwhovnFIHTlOcEYbhTttn7IakOoSuSXR3JgcuHG//9iwG8zyyMUluT+gS/uZ+fKsLEDcW1gkgMy5vXmzztUl3ITg6r/CMJEmoyQNizEGgwt3QlJgSxa369RaJdE3HIlqOQvZTx7Krm/mhL15cq8yjM4RDcT8bPXq8SmDmcy4HB5pbWPL1EJYZm+kg8NNzrMRknJpFsS6lFO/DOF998lzPvcgGVGffP2TCw271ZQbji8m6iHFffqXT1zXJHYTvyYnBWaFJZUnQGzBlMTNW88C7h2qdm+Qt3KpuxptPRMYoe6Q5DCn+RKCF3Au9T34MQimF8AKMQz31K+lwO60EyJWIRXZik09Dtx9SB1vlBEoHAaJF1i5gmTuKtVcqEwE1w1Y6XHrnsdzoCLWvEB9rNggAR4Q2143g9irDD77aRwfCeZAnF9T3+nGz0G0e4Ut2Yk+aohMo6PVa6ABvPtp1zz8UeoupNNfwPHTemi+yBJ/Dm7vi7raxl5oI4p1oBp73VErapMjwrwfRS+djIlgNh4FKMMD71guu1fRuW8Og8wA6qV/2rHPcpnY2fH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230037)(1800799021)(366013)(41320700010)(38070700015);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zMju2zPILZU5uaiQALbv/hrg0JsgjqCtvKNZm19MoD0p6Yop0V0iMpZXdW7n?=
 =?us-ascii?Q?08iX2Sw4UBJXWZp2pSO0BBazrhHiex4dE2//Kflv71gfEElxiazLJSY8A7dC?=
 =?us-ascii?Q?279RFrmEQzh14MXEfLCL3KdwtHXpgXBywGKFSB8UcdBs4tgkY53QaPldtMud?=
 =?us-ascii?Q?4haR/BH23PwzfQFBTjpqoTCUWomVTtQ/deej25XU77BoIhvzX414SXItig8H?=
 =?us-ascii?Q?XqGCOX7j2z5zzWelZALVm47Ae1DaRg5aZWYIKjYx7YlcnSLizTYgUrnfN7h3?=
 =?us-ascii?Q?IUuanHXijvW3mvdlFkp3whAXbAkEaySzgbgN2cHXeH5gENpViGiObILFxU/g?=
 =?us-ascii?Q?K/lyeBouvWv9gkS9wTuFXJaNUb8HRpmApdRYbfm6td0J+VLOPhoQnnS6a43e?=
 =?us-ascii?Q?46bfMtdLaQNJqkhBZI1wA/PLb18eGBrIPQW44XnSM8UbeAu2lgqGkHae99ZJ?=
 =?us-ascii?Q?tYeVLpE/m2OUSAYnXlZaHK6KdEmLzNvAeRCMBSoXWtVG5DHgrYWNXQDAxUqI?=
 =?us-ascii?Q?/vYPZ1a7IY/a697LXLAKXcTOUmX3nDtTG6Q26KGTMPYLPQWQ/MSYGO4R4Lwy?=
 =?us-ascii?Q?X9akM/R4Cw/7f8nGOsHGNb9phiOx+0/1sK1HelAOoiFYhIe+oXxuROu6STD3?=
 =?us-ascii?Q?LopEF9X72Io/eDl77sYFgu+ppBbQjs5QWC7y3MemZj5rNqstJ9COPbla0EJ9?=
 =?us-ascii?Q?Mnu6lmkmNkvK/CCAtpGP+nzolZ9QsqSIuCagROLHzRZsaohGb9wVdQU5K4wz?=
 =?us-ascii?Q?jMLsxlB6BF/v6d6KLIKTviwGov/m2qokj3jk0+xBpvOPO676iT9QsBc7VCZi?=
 =?us-ascii?Q?70gthrQxdqCAdvcvfoh8NYiBdv+icYvvJHtZh4VeuvwrxWaJmBxc2zGdFqnD?=
 =?us-ascii?Q?dEOFtkaHy8tzTy+1AttXsxVT1un9twcT2Zcl+QeYJdPmwPZrHh2vQrJk+62Q?=
 =?us-ascii?Q?mJ8lhZGLR9GgZN1wCFvF939Wm1H5PBD+dCDMZFphOTUkEuOE7w7L3781fo9v?=
 =?us-ascii?Q?D3/MsGS/K0C4QyO7XMNNhiqk1wxH3YDmrfaxMBL/wD4/HBq3cZEuXqr2O9Pw?=
 =?us-ascii?Q?Q3eTFKooVnH96Kp+yVvxzBmTFD/IWmJSj8Iu8SHOx+ddZoboYMcC1G6LQtaE?=
 =?us-ascii?Q?EmTaWPCrUJm9S8hTR2Kt1d1Nkdx9lDhGSD8JfyIxQYb9L7Q1FuxuVe8RfHNL?=
 =?us-ascii?Q?IfCdFPUO59AjPMMtP4ITxTnTIO/zJfRbA7hfZJCGeYn/rJy2DzgUOyYSt/Cq?=
 =?us-ascii?Q?d47fmKCep74EoVNZNxIP9BljiWh50gMTerGPRzFFewoaZUA+Ba1SpE6tnAYp?=
 =?us-ascii?Q?POW3tCd/xAyWGJtzcA2001TJMQCUqiukW5wjJUDxZxqqbYRFz6Vm2/S+nP8v?=
 =?us-ascii?Q?pVcl+Ea1L9sc4L3iIJku30tDU0LgnBIk3HeuVWkHrOjOSqpEy4VeA3SB7oPA?=
 =?us-ascii?Q?Ia9njvKaPZpj+JEhILyIRyOt5oYxgrL84Nr8pM0cUhesx6JLn1Ejs4D3eDdd?=
 =?us-ascii?Q?4IJG6reuATAUjFVO5+uNgY+M3xOMVJLjqNks5ilqq9nsYmnK+ac9j+5Qg+0j?=
 =?us-ascii?Q?k/bTlW6MbrhVmPv4Ofw5HKMdYM/y1o698Rzvvs1P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: f44147cc-79de-4151-5a6c-08dc8e813b23
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 03:54:47.3513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rx0fsdGy7sexP/EKZSYNygeHB6u4FpET/18gPsLHEViS7VNxVnvimFykzwH8jy4bJoOKAEV8onKgTCbfV7YfgEEvTOCATvPCexxcjiivC98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0685
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



>=20
> Hey,
>=20
> After going from Vendor SPL/OpenSBI/U-Boot to OpenSBI v1.4++ plus
> v2024.07-rc4 SPL/U-Boot I ran into a boot loop problem relating to
> PCI:
> 	U-Boot 2024.07-rc4 (Jun 13 2024 - 15:09:34 +0100)
>=20
> 	CPU:   sifive,u74-mc
> 	Model: StarFive VisionFive 2 v1.2A
> 	DRAM:  4 GiB
> 	Core:  136 devices, 26 uclasses, devicetree: board
> 	WDT:   Not starting watchdog@13070000
> 	MMC:   mmc@16010000: 0, mmc@16020000: 1
> 	Loading Environment from SPIFlash... SF: Detected gd25lq128 with page
> size 256 Bytes, erase size 4 KiB, total 16 MiB
> 	OK
> 	StarFive EEPROM format v2
>=20
> 	--------EEPROM INFO--------
> 	Vendor : StarFive Technology Co., Ltd.
> 	Product full SN: VF7110A1-2249-D004E000-00000540
> 	data version: 0x2
> 	PCB revision: 0xa1
> 	BOM revision: A
> 	Ethernet MAC0 address: 6c:cf:39:00:17:95
> 	Ethernet MAC1 address: 6c:cf:39:00:17:96
> 	--------EEPROM INFO--------
>=20
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
> 	scanning bus xhci_pci for devices...
> 	U-Boot SPL 2024.07-rc4 (Jun 13 2024 - 15:09:34 +0100)
> 	DDR version: dc2e84f0.
> 	Trying to boot from SPI
>=20
> This only appeared after I refreshed the environment by running.
> `env default -a -f; env save`. Before that things worked "fine", I suppos=
e because
> nothing actually touched PCI. I've just disabled PCI for now and things a=
re
> working once more. I've not attempted to bisect/debug this, cos that's no=
t the
> fastest process while running U-Boot out of flash.
>=20
> In case it is relevant, the board I have is one of the "super early bird"=
 ones.
>=20
> Cheers,
> Conor.

CC  Hal
