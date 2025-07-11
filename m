Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AECDC8303C
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 07:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9142805D7;
	Fri, 11 Jul 2025 09:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="wDcSwEId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED1B482CFA; Fri, 11 Jul 2025 06:46:40 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4B5B8277D
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 06:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYmx1Byiloha9MVTLpdtc7UtX2twWo0Qhi5Y557gGSkIdpcDjme9o9RNwi1oO4KF91tcFQCiDAY377CQunuUGsf1dAoXLC5O8U5WXKbFvya/fKPxs9/eJDo17szZon9xWmM0LbeJmv8YAzccKexn6Grge27VSSx3/XVAjc5GSMGKNKXlZ7em/1XJsTG8efygg/PTn0mjNuiF8k107X2jAbAZMSkVuQDbbygYT1ah+r5z5TDK73+CdZao+L01RcNJRHnCEljawOhrD+9GBZCKHZGXmnMwlhZamoOAToRimDCT47J0Rsx5QutvOOzimceL52aZWO3byHPMZExObjG0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3GMiTP2WtLsxiAl3VPOcWVQWBphcmlxhIOkeXwSKCg=;
 b=KPPM0hAVPpLE8GHzmfbPabQyUcxESqvus4JKtITaz8hU1W+oHeOewPPCjIx6dmZCazjciq8BDL59oKpqKSC2YRUKQIxjAbMUOnUYMGsjFKAAxIwePwh+mKa/OZ++DJiEkes4xd/U70VrcMSys7EJ/VgDeFSAHF8WBwntk+796/zqa9UZNOpNc/+BG+Y85xKVQHGusA5Jstoxb+NyM1sMEE7U7OLAuwb9XWNAWBZdqZ1nNSfCiC+niYzEtdw4HvdWxiDGHXiHRjinCaYljSTkbDaxGu8Www8Xz38JWaEiw2EZCv/iQhjIu55a7EGUXu7kR0l7KRwgapbIzYVC0xPd5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3GMiTP2WtLsxiAl3VPOcWVQWBphcmlxhIOkeXwSKCg=;
 b=wDcSwEIdYQpskO4ZBlk//idaaUoVF2Iv2jz/YQkrz2GyU3mL+MWAYeyDV+POjvcE1THyQx1u8jtOmKS+P4jtO3EJnCK27eWCPxy1iUpey/6WvynFvdMEhBD1BefD72lYee1XODhFK3LGoZmoGfKV0ihDaZo5B6IWba9dsLkCi3MlG9X6Mk/Jzk9b8Ql6NXr96jgmhWU8nsKRcYJRKMGzuJt/nsEggIjElEVBT/ev3kbso2WKDo+iRIlkS5UhdTyRb0tYlFY2oHwFSqBxllNY6HRkxPeNqPZnAUrGgEEvxrzIHZ8A7F/pt70AM3N5IFQtMjpwTWPiPyqSX41sTHHZBA==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CH8PR03MB8323.namprd03.prod.outlook.com (2603:10b6:610:2c5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 04:46:35 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 04:46:34 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>, Tom
 Rini <trini@konsulko.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon" <jit.loon.lim@altera.com>, 
 Dinesh Maniyam <dinesh.maniyam@intel.com>
Subject: RE: [PATCH] configs: Relocate malloc and bss address
Thread-Topic: [PATCH] configs: Relocate malloc and bss address
Thread-Index: AQHb8VD0i2GfFOoHf0OxT/JuKWwuu7QsTFqAgAAKEIA=
Date: Fri, 11 Jul 2025 04:46:34 +0000
Message-ID: <PH7PR03MB694222A5FAB2F4BA7E06F049F74BA@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20250710041253.74712-1-dinesh.maniyam@altera.com>
 <20250711035425.GB1654@nxa18884-linux>
In-Reply-To: <20250711035425.GB1654@nxa18884-linux>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|CH8PR03MB8323:EE_
x-ms-office365-filtering-correlation-id: 60837970-3d41-4799-9701-08ddc035e9f1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?I/m1kx3Sx/DrEdaG/jAAF6t4srAEJ9eYCI3FLXwt6fjJZMtbZYar/3F8GdeL?=
 =?us-ascii?Q?4I7Nw4dOH/HUzT3PFX8SWUtqcREhDgKG7Y1c7ohyoTxCRV00F9vEKJy1UBJu?=
 =?us-ascii?Q?bGCnRE6EU9AIOz6APGWSWKM6tYeYO9m/obFRe0kTyeRjTtS2UwuM9y2Vp+X+?=
 =?us-ascii?Q?mIvqgp839wIHiOO4UXiiC6hGUWOmUfKkZW7uMT3ILoP5NW4+OgOVUqP40bHw?=
 =?us-ascii?Q?VaIa0s0zUiFL60DqQAivHNKj252Cr45TTDcfQU42l/LmdhL10l5PH5v4aINj?=
 =?us-ascii?Q?jJ6A86DzpoSaU9BkbkZXgVeMS8PChdwaskoAXi8zw4LTeLOyc3C879d7H+ht?=
 =?us-ascii?Q?Vu4GJkbdXUsOp+3AJ7e6TInI95inxolDzZNiQQtOXJwGP3HlO18C6tNIdb3g?=
 =?us-ascii?Q?DEchp5O1BtiH7iOPZx64r5EU38M5duB82alzcRQ4LrKMpYiDK+RGpfYMIxxt?=
 =?us-ascii?Q?mKFTtm1MN6LeRXJT/UA84GR+xiu8u3ZoWZ26V/5hVUrZxOjqUuVAq59GVvHD?=
 =?us-ascii?Q?QRA84Z1VnvsSDMVs13jQLsj1FbVMULfW0UX6HAyXG4pXLxPp1Q80GuqCLRdB?=
 =?us-ascii?Q?F5o+fR1EARVSuWhCLXc/GeTH175jvHNACxInqfzk/zvHG5j8URFR8AT83lTK?=
 =?us-ascii?Q?yQ226Vf5ID+7aFltbQHkKrPRCR30fSQcMdB9IbC00RVbuKWwNKTVOzVvFTag?=
 =?us-ascii?Q?TIaHVTNp+FU33o8H0FTwFD0XT+Z6DgREm+fAzRIJbEfQwe76foS6plmTp/w2?=
 =?us-ascii?Q?InDz5stqaUtr6jU2+dCXqwYI38hpMUWYBNhcYXT+Uj2l36laxR9uGen8A+dT?=
 =?us-ascii?Q?0bgEFIrJG7v+Ih6JAhAC2owX5bpivt29LyRdL181ymZACD+YKB2NUT7A56G+?=
 =?us-ascii?Q?SdTr7N4LsWz/3fsfb5jeDyTO6oIISHjI7GTIrnYHJQu+34OqahmdhICM2uE0?=
 =?us-ascii?Q?zCNTNu47KucpoEOOU8EKCqjYyNOo8YlTVsVHRgLurgTBrgFm2ydwib4RCQR0?=
 =?us-ascii?Q?r4EuTdDP4OMsG+dv7LVPldMHskgLONBdvCD8l3eEua/2/CK1oIK54cy0jcm5?=
 =?us-ascii?Q?TS4MpJAkmNBtDtXz7xVm+J88nsW98PdItj95JDoJ9BYSb/on3gGDIFKA4i+9?=
 =?us-ascii?Q?28ByAsN/J4SjQh+j4BzWtdcLptxxsQ1PKztVf2rhLF934HEPgW6UDGCY4ki3?=
 =?us-ascii?Q?n9DtPwTkbJ8wPwTnlYBJhy1olPUBzAZf/WA9PvYhYipcEHcUnLxSvqOzDaMz?=
 =?us-ascii?Q?HKdg3W3o5vZuj5q9LQ+dD5+xi69IM07700t4gX7AkyzzmbUlp4zjdpB6KJhx?=
 =?us-ascii?Q?/f6tE2Uy12jp2m6RYmyBqeBolKSAgCz3QPKXLZmxZ+dY/pOu9RarGGp2dvLf?=
 =?us-ascii?Q?xr57EFJMy3kifq4PnmmL7JWYF/DNzmLPefKgkXMDZUhHTtC/FuOkWOvqJp5p?=
 =?us-ascii?Q?/xjXdkcLsZLNxcPfv6JyjqMwjdPD8xJ2G1KGgk2HKg9xwDlPNHSvtw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RSdZl8Jnkv+GbUMJOvjG9jgranasIzan/a+c4/HUe55dcTm1r8yG4D5rFN02?=
 =?us-ascii?Q?RJYXeXPvON14GuPMZ+NmLtdEJJvdW2EjXW0iyUBJMifdpGK/2bBGjdEXiyGZ?=
 =?us-ascii?Q?b+fhHtEATr0KOS6uBrKzXMse/v4SZqBSVH3C3kJWg7eRkDd/yNWR/Bf1Zcj6?=
 =?us-ascii?Q?raxvRaLv1E4+jFHrAP2+V2aTEPX3+b/5eSYjDWp2qdNKn8fcUty61X+bYJ8i?=
 =?us-ascii?Q?UXGSIdvP98T1Rjg+NOcDQ9sLThhfx+Z8i9nOVICdwSkd/xoTq3E/UyxVhUTR?=
 =?us-ascii?Q?+Ttm3Iiv3eYND5NNrJYBnLeUMF2LF/+a2ZP92nAHm1h7ThNTwumu+PLXUF3D?=
 =?us-ascii?Q?MdVfiAnL6Kt10+SPOEPTEmJq8m1EIO9chLvP7hgnVJvyrtNjg/DYfwH6xWip?=
 =?us-ascii?Q?GP3YPdE1ETjRae9psxKviVxJAI38AUnqO9YQTlQiHwu8t2lRxVrudRGrZhHM?=
 =?us-ascii?Q?qmzuFFprFfQj1d9eQW48Kv38OpLUOwIdwCcgeb1zGQsCpXBu04I4qpgnG5in?=
 =?us-ascii?Q?dPQV0fNKoJtAUEOOxYYgo4qbl1PZliyyA5+f/QtlElgjGy3BQD9BwcR1vjfX?=
 =?us-ascii?Q?C9QzH0wZMpkorehlyhuu2XHTM8YguwLR3PDQkFjVVjpbsZSKLCJR6WjBoKOg?=
 =?us-ascii?Q?CKqWlhCYuTPhXF5SJR6Zo22k0mOIcB5JNWI0/eH6SPi4g5mXQkSJQHoyg7rz?=
 =?us-ascii?Q?PrA1kWIPc1gWnpPcaeK2SiT8ZnVwjDIL+JTCNyeq13OyZ4w5yR4TPc7a367o?=
 =?us-ascii?Q?9OtUMucVUtI6Oys5Pb2t9mssRSgV9AvgA+KvZvKiXQIVtsISr9jIxPYiVJY5?=
 =?us-ascii?Q?DSwKL1mSVVLtRw5MuJv++mgyMm8Kk8SI5j7cNWW3Z1xr7fVYH61uvBuMYFAd?=
 =?us-ascii?Q?DcZzqqehAn82lpS4myHUD88u2biI6dnyQHe16RNxBfSuni32dgw8R/UsCcCv?=
 =?us-ascii?Q?PoopAkeHi01ZLEso4qpyuFHJ+wY6Z/+lSj5Bug5fOXE5taR+KKsofEzKfH9T?=
 =?us-ascii?Q?bKjMPnaeW75vGuxlGB7GIro1DrKUjGLQZb4opABsug9K44liPsFLgUtAVpoq?=
 =?us-ascii?Q?3emwBk5mAq0VvY/0wr74C8oxRp9kEDqfaCIWKhqvr4lRMtPxi9QWS3J3gGX9?=
 =?us-ascii?Q?bYn7FUtH8kuNbf+zbeflFOzESo3sxQ2EjXQyX3CiY9panl5qBeGgHsrJ70qf?=
 =?us-ascii?Q?StjF5Y4RAvTcjJyHFzxnhXAImTLqw3yY/v+Fsqy0sBqWqa9WmRtnbgxwsY1T?=
 =?us-ascii?Q?p8KInHtodvcEqSP7Zlco9S1vE+KgwHhDTeDkP/6vXdqMp98sv3aMTxG8dBNr?=
 =?us-ascii?Q?wBZ8bBg2tjrmMhm5SQF/hdB6RY014rmk9gz9lszKvkjsYHc2sPUMcSno1nP3?=
 =?us-ascii?Q?wvdEpxYpLQyK5v6OM+TQtw9m8LQ0r09+Df+TDpXCogkSQzQIjQGGWfcz7tiG?=
 =?us-ascii?Q?upsIexs1jZwvZgCWdggpXjXjq8QJ+B8PTatxhDPvxX+CmqbfNLYoCffGPt2j?=
 =?us-ascii?Q?kQVNNMJaI4Iho3j0NPLjVZjosYz86ex144gs2D5XqqCdtnmZTFZGhBYEueXW?=
 =?us-ascii?Q?+UzfZviFiaAzEKJ44u7H4+rE+LkneFPdGqTHX/Z7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60837970-3d41-4799-9701-08ddc035e9f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 04:46:34.7024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQF2U+JRFSlvSoZjB+f66deZEX6rhlsIic4WEkZX6xcUxzyQbjF7MhERP5K5FTW8BlBLNGtcY19kH1XZzWnPLAN5uuJF7VKxe9kCVJS4BxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR03MB8323
X-Mailman-Approved-At: Fri, 11 Jul 2025 09:26:27 +0200
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

Hi

> -----Original Message-----
> From: Peng Fan <peng.fan@oss.nxp.com>
> Sent: Friday, 11 July 2025 11:54 am
> To: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon
> <simon.k.r.goldschmidt@gmail.com>; Simon Glass <sjg@chromium.org>; Tom
> Rini <trini@konsulko.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Lim, Jit Loon <jit.loon.lim@altera.com=
>;
> Dinesh Maniyam <dinesh.maniyam@intel.com>
> Subject: Re: [PATCH] configs: Relocate malloc and bss address
>=20
> [CAUTION: This email is from outside your organization. Unless you trust =
the
> sender, do not click on links or open attachments as it may be a fraudule=
nt
> email attempting to steal your information and/or compromise your
> computer.]
>=20
> On Thu, Jul 10, 2025 at 12:12:53PM +0800, dinesh.maniyam@altera.com
> wrote:
> >From: Dinesh Maniyam <dinesh.maniyam@intel.com>
> >
>=20
> Nit, update subject with socfpga_agilex5: config:
>=20

Noted. I will update it.

> >With Inline ECC enabled, the bottom 1/8 of DDR is reserved for ECC
> >parity bits and must not be used for general data address allocation.
> >Previously, the SPL bss and malloc addresses were allocated inside this
> >ECC parity region if the DDR size is 1GB.
> >
> >This caused ECC hardware to detect stale or invalid parity bits,
> >leading to data correction attempts and DMA polling hangs or failures.
> >
> >Fix this by relocating the malloc and bss to the usable 7/8 region of
> >DDR and is fully ECC-safe.
> >
> >This change ensures reliable ddr address operation and prevents
> >unintended memory corruption.
> >
> >Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> >---
> > configs/socfpga_agilex5_defconfig | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/configs/socfpga_agilex5_defconfig
> >b/configs/socfpga_agilex5_defconfig
> >index 4ac0a5d9b99..01c5ac88015 100644
> >--- a/configs/socfpga_agilex5_defconfig
> >+++ b/configs/socfpga_agilex5_defconfig
> >@@ -12,7 +12,7 @@
> CONFIG_DEFAULT_DEVICE_TREE=3D"socfpga_agilex5_socdk"
> > CONFIG_DM_RESET=3Dy
> > CONFIG_SPL_STACK=3D0x7d000
> > CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> >-CONFIG_SPL_BSS_START_ADDR=3D0xbff00000
> >+CONFIG_SPL_BSS_START_ADDR=3D0x9ff00000
>=20
> Commit says bottom is reserved, but here bss start is moved to low addres=
s.
> ECC area is at top area?
>=20
> Regards,
> Peng

The idea here is to move the bss_start_addr to DDR base address + 512MB.=20
The ECC-reserved area remains at the lower end of DDR, and since
Agilex 5 requires a minimum DDR size of 1GB, this memory layout is safe.

This approach maintains consistency with the existing memory layout logic d=
efined for previous SoCs in:
include/configs/socfpga_soc64_common.h

Regards
Dinesh

