Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12EDC4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 08:38:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C492887695;
	Mon, 22 Jan 2024 09:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="LkTAxTKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBC3B876F4; Mon, 22 Jan 2024 09:38:54 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D11586F80
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 09:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUf4x7YAvjceZ6yHPql0Rb9tCH3HLSGTbpYgr74hJDoUUimwJ62cmNh9xzsnw1d4giq3DxUP7gvk4uVnfTjRaDXNHLxbUaEiQJOKhcwZWXkzSM2NoV82QpoL2cI2Z6UEED4xlPT5R1TWa35QivgVkYQAvLlQuKi2N7eu2XqYBYjfp2xN0Zj1j/ClvsdbWeQYpCF0I7Aktw9w0QU1FQdouhluaxh5XerIwTtAvonHTk8UE+EOnEOTsS32FqtqJMMecsGpG9LB4/uAavajjQYvjUOktrxBh7+uplbb0R9Td2OpIJRXqJ44t+JkLMPw80TqgHp9tls4E2i9vQ7vHo/FFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKxUGJVEmpKIwHQyhA2CPMcOfkGCn8ZZ+AiJ4538fGo=;
 b=j3YlbLLyLPkgTMCgHsKM0Kox6Md6r1uBpZagtfespsjZPIOuDCv2qWDuqaVtpfa8MgLExEOiLNaYxLMPbtTcrMQldpiYKNQ8igP1rE6u8IKtmhzOPdk7FrNpo+sT8Dw9JfMrPRoFeOjteAdD7BJBT+3MH6BXZ7HtYAch/yGNzeoKvJRfs7fSFSXIyKaghnbETE/mGGZPTsyJVL47vMILLGoEhwbg9YF0d0WSWbloccKI1imbSahZPKvs2+so9XbWWrCL095dVtH73f8LFSijvCMO1ifGnLz43cUkuIBiHpdxT+YyR8XLEHJ2sXzL/Stj2QviStn6R2I0J0K4jTzTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKxUGJVEmpKIwHQyhA2CPMcOfkGCn8ZZ+AiJ4538fGo=;
 b=LkTAxTKiKVwKPngE1JaJDfg67tK2NXCaK935R2aToSilxVFMSgcxoYzg7dBNNkYGL1Frmy1b9PfR/kYXLpSjz9eFiQYPQdr18l3LaNaB3Ek+lQBMTPvftrbIIahVLTzUUdjaCdciEvabyZ7J2v/PtGnQCy0a7UZmyRpf3pIkx/WxWn0iKCBYfc3X2xxHooc9krt8e8DatAPfUelygtSWcDHEGPNLRKVRNaAx3q7vZ97PKABempQIG9fmn7Y10+zwuFFTVSmJJJsAXzglInn8JDwOf6wcZo6ZUYp5LQKvy9GOOC82Qf7SoSzT5YeWCn2xwdlrqxDGNTiQ3cRMVEQjDQ==
Received: from DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::9)
 by GV2PR10MB6115.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 08:38:50 +0000
Received: from DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f1f5:cb7c:e668:56b5]) by DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f1f5:cb7c:e668:56b5%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 08:38:50 +0000
From: "Leto, Enrico" <enrico.leto@siemens.com>
To: 'Tom Rini' <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Sverdlin, Alexander"
 <alexander.sverdlin@siemens.com>
Subject: RE: [PATCH v4 0/6] board: siemens: clean up subfolders
Thread-Topic: [PATCH v4 0/6] board: siemens: clean up subfolders
Thread-Index: AQHaPkk63KGwCm7ovUuuA1eL0UlH7bDfxcmAgAXaG5A=
Date: Mon, 22 Jan 2024 08:38:50 +0000
Message-ID: <DB8PR10MB373762A5BD3DF0ECB524BE68FF752@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
References: <20240103133154.152886-1-enrico.leto@siemens.com>
 <20240118151533.GA2523070@bill-the-cat>
In-Reply-To: <20240118151533.GA2523070@bill-the-cat>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=1c4ac687-ad53-46b5-8678-a304f1142a1d;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-01-22T08:37:28Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR10MB3737:EE_|GV2PR10MB6115:EE_
x-ms-office365-filtering-correlation-id: ac197064-ef3f-4933-5e04-08dc1b258efe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fwL0lk6Tt3Koruc8N3faXm5QVQwt78Iugk8fJOGAcaebQV6p0x/bfthLp/B3I+2oe+mp59Nny5x0LHkCqdhf2EkohHo5gA67mYR24pLT61l2NZkHN/7hafR+yiJ6GuxS0btfyeAqK/QXvRiXcjEdUD/3XTdV8+QWqLBr5BlnSNEMgNr+81dIrMZqk35XhM3gTjEqkoeMHJjGBweDwk+eSRX5ShjxP402EThH6xAD5IWOcc85y/9zs/uDEfb7O1EMJrguGxJllSeW2FGgs3ZNtCuccGtpz+0cDzn+J89MSmIhpL61Q1lLQortrXZEnE8eJie7oCrm5poDj7njrUTbOpcEV7NO931GP720J8SDYj1FGcBpfQB7Z9T3RJGq4+tTinoqPxEa8nvdj3cHJDk0M0S3KE0YE2zhAqqyxUKEOGYkBJ49TZUmY+5jroRc+lpHroAqdlSf1CBjqlQWhRbABp/MukkTPmNvXd+mWUB9NWJmgs2uT+/JFuXaYw/P5okKuEPB/rLEdJhfHeMCNaK/8XQzZv1/dZmaX1mGtNpbycJ7F9nthI1gG8BK63N5jKwugNZOgjy3JyQL8yTErClOKQsUucp8eqghGLmh+4oFlb5wsrXFkH9DCQTC73Rbw6MUh68gROdcFPSRjPEzbWYRSn1cQtSbCPid9LtQLT9r2YY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(53546011)(478600001)(71200400001)(7696005)(9686003)(6916009)(6506007)(64756008)(66446008)(66476007)(66556008)(54906003)(76116006)(8936002)(8676002)(316002)(66946007)(55236004)(26005)(107886003)(83380400001)(2906002)(4326008)(52536014)(5660300002)(41300700001)(33656002)(38070700009)(82960400001)(38100700002)(122000001)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gEyXN13A4opWXe69diHIpwaO2yzN1ogO3ByquRGvSWYmEGbb0rdhWAlazLwT?=
 =?us-ascii?Q?wH1b8kad80m+Y6/SvUMFel4ixudA22BSbcdQXGyELMAKM3rx0ZEKtoQ6ucY9?=
 =?us-ascii?Q?q/cN2NZqZEmII9XSuiIQ66tUXfxSiJBCD7VN9zv8T93op1L7TXQHfKxC16ZI?=
 =?us-ascii?Q?TtGpyR0r2X9ERLNcq5M+qhvbYXcV/064N1O1rb/wWJ2LDh3zskG2W79h5ugd?=
 =?us-ascii?Q?hA3c0Wuojqr1aEAC+GqpkVXDGmcRfbCN/vzdlBfooMGkqdTQ9JtC4r3E7vjy?=
 =?us-ascii?Q?EQkbUfTbNjcW8XsjrJ1RAF9DW/iG4YidSzTw/Rw61ZPe8U9fkZmizIuUTmh0?=
 =?us-ascii?Q?6PMWGHXaI/SRTbISrIxzbVV/biJj2poIp9pf4RLXXru0CO2wV4figv8qeK08?=
 =?us-ascii?Q?BrSSUmvf85dyIiKx7pSaEjp4cAK7GwhUlGWqxn1MK7zHrTSOeZCSWy4IWfGI?=
 =?us-ascii?Q?myP0qNfpFNYOvidSIPng/XuYdLgpARDBpXhFcNRzqaZdwnKWaJQQas4t+PX7?=
 =?us-ascii?Q?rcqIGD4bBW1mo83F0Dld+ZcOGU7d3W2cF9lrblYJ3r+3AGxYuVlvXLwmoRgh?=
 =?us-ascii?Q?sZcWwoRoufUC1dPH4BHYTu0N3mvruPE9roVBJ4lsNB5NEcY3+sqMVjFFW0bt?=
 =?us-ascii?Q?mSTXkLYzvI8E1BOW/ZFf/UmqiogaQz3azsBY5a4rawKKjdU3c9ZtmQqQcP1i?=
 =?us-ascii?Q?OiPCjn2jFs2Jq34kvqcShv+Hq9MwHRBvBSffcVq3b9ue7O1A4vbmVAz0di6D?=
 =?us-ascii?Q?+8VT3aujnY1OLXZviVT6ZV7AumnZmT4MRDcCIR1U2/4kyNuR5uVI0QCKPvAb?=
 =?us-ascii?Q?AhZL3u7ZITzOR7en4rbsmH4jNVKGJOgAF3jiNIu5eO5/Xg9qXZ6JZT10Yh8a?=
 =?us-ascii?Q?mPubOwPtJLBbYmLCGmboRAsDN6oyHfFbCPJn7c1mxYKBGYXFpz8uzOC0TncF?=
 =?us-ascii?Q?CBn+gUFCUkmIElQ/Ex0KC51AmergOf0wTEOrq0pmR6PF59/78zec366rTOpU?=
 =?us-ascii?Q?D7AbEgMcIuFvtAZKyg/ezaaz0PzUNNaWZrVhA0zNh2BEJ/B5WeKKrJgV2s1V?=
 =?us-ascii?Q?CXDZUX+GrtaDsztnohrIxgpEQ/MmGgkLdiktkf9gXWQXkM6TL/PmowUbzaX5?=
 =?us-ascii?Q?ixcv2P2VQ+xU+xvrnMLLUt0KVqpXbUShmpo1PtOAA6/4EF952N0az2ivkt8X?=
 =?us-ascii?Q?stkMoB2sGIHovSW+9uxwG433LVfa1TkpZsFC8q8BCOTqLdh6vkX9CPXjMD1A?=
 =?us-ascii?Q?HGQtf1m+vGJRhvvW8MLkZMi2rBwCpCrI1FBkywNywauVrn0gfocc9Usnb35Y?=
 =?us-ascii?Q?h8WVbCD2M3vgefKw840szkf/lH3B/iCbwVIFj8bXzsFTEL0tf5+1SezF1iqp?=
 =?us-ascii?Q?O/qoYlE3VE8jGOj0phuLGnshRYMziXdrjd9SLT4s5KmgglX5OcZGX8vFPu7B?=
 =?us-ascii?Q?TrO/+VlV2xzFXjUhwURAuvOJhrN8qhHZBxVMKTQQI9usVuhp2uDYP+1dDjFZ?=
 =?us-ascii?Q?YClatRxORY+9vL6XiNg+wZxk2afeP5aBxdJ2Etk/baJ6oNb03Pf/quuHT5C0?=
 =?us-ascii?Q?cmmwMa5upMFPGnlYFuQ8m89MzIQb4POpSoXhByiK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ac197064-ef3f-4933-5e04-08dc1b258efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 08:38:50.5901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BwQoK0HIj3FqWfORIEc4pjPhneKc63eP4FNwxp0BOmwJxSSZEajDEFNbwbJzM3wXoGCjTV3qEsTk68wfKvrtPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6115
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

> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Thursday, January 18, 2024 4:16 PM
> To: Leto, Enrico (SI BP R&D ZG FW CCP) <enrico.leto@siemens.com>
> Cc: u-boot@lists.denx.de; Sverdlin, Alexander (SI BP R&D ZG FW CCP)
> <alexander.sverdlin@siemens.com>
> Subject: Re: [PATCH v4 0/6] board: siemens: clean up subfolders
>=20
> On Wed, Jan 03, 2024 at 02:31:48PM +0100, Enrico Leto wrote:
>=20
> > This serie depends on the serie:
> >     [PATCH 0/6] siemens,am335x: clean up the draco board family
>=20
> Is this not applied already? If not, where is it? Can you please repost i=
t?
>=20

Yes, it's applied. I'll remove these lines.

> >
> >     The common folder was initialially created for the common parts of
> >     the products based on draco-am355x board family. We have the
> >     product lines 'pxm2', 'rut' and the base line unfortunately named
> >     'draco'! Adding the new capricorn-imx8 board family, the files
> >     were enhanced without cleanup.
> >
> >     Simplify first EEPROM probe and access that implements both i2c
> >     with & without driver model. Use abstraction functions for this.
> >
> >     Move all am355x specifics to a new file 'board_am335x'.
> >
> >     Clean-up includes, config checks, maintainer.
> >
> > Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
>=20
> The problem is that I see:
>=20
>=20
> > ---
> >rm:  +   draco-etamin
> +(draco-etamin) board/siemens/draco/../common/board.c: In function
> 'board_init':
> +(draco-etamin) board/siemens/draco/../common/board.c:88:9: error:
> implicit declaration of function 'board_nand_cs_init' [-Werror=3Dimplicit=
-
> function-declaration]
> +(draco-etamin)    88 |         board_nand_cs_init();
> +(draco-etamin)       |         ^~~~~~~~~~~~~~~~~~
> +(draco-etamin) cc1: all warnings being treated as errors
> +(draco-etamin) make[2]: *** [scripts/Makefile.build:257:
> +board/siemens/draco/../common/board.o] Error 1
> +(draco-etamin) make[1]: *** [Makefile:1859: board/siemens/draco] Error
> +2
> +(draco-etamin) make: *** [Makefile:177: sub-make] Error 2

I'll check why I have not seen this problem by me and fix it.

>    aarch64:  +   deneb
> +(deneb) WARNING 'ahab-container.img' not found, resulting binary is
> +not-functional
> +(deneb) aarch64-linux-ld.bfd:
> board/siemens/capricorn/../common/factoryset.o: in function
> `factoryset_read_eeprom':
> +(deneb)
> board/siemens/capricorn/../common/factoryset.c:149:(.text.factoryset_read
> _eeprom+0x2c): undefined reference to `siemens_ee_read_data'
> +(deneb) aarch64-linux-ld.bfd:
> board/siemens/capricorn/../common/factoryset.c:177:(.text.factoryset_read
> _eeprom+0xb4): undefined reference to `siemens_ee_read_data'
> +(deneb) aarch64-linux-ld.bfd:
> board/siemens/capricorn/../common/factoryset.c:172:(.text.factoryset_read
> _eeprom+0x264): undefined reference to `siemens_ee_read_data'
> +(deneb) make[1]: *** [Makefile:1766: u-boot] Error 139
> +(deneb) make[1]: *** Deleting file 'u-boot'
> +(deneb) make: *** [Makefile:177: sub-make] Error 2
>    aarch64:  +   giedi
> +(giedi) WARNING 'ahab-container.img' not found, resulting binary is
> +not-functional
> +(giedi) aarch64-linux-ld.bfd:
> board/siemens/capricorn/../common/factoryset.o: in function
> `factoryset_read_eeprom':
> +(giedi)
> board/siemens/capricorn/../common/factoryset.c:149:(.text.factoryset_read
> _eeprom+0x2c): undefined reference to `siemens_ee_read_data'
> +(giedi) aarch64-linux-ld.bfd:
> board/siemens/capricorn/../common/factoryset.c:177:(.text.factoryset_read
> _eeprom+0xb4): undefined reference to `siemens_ee_read_data'
> +(giedi) aarch64-linux-ld.bfd:
> board/siemens/capricorn/../common/factoryset.c:172:(.text.factoryset_read
> _eeprom+0x264): undefined reference to `siemens_ee_read_data'
> +(giedi) make[1]: *** [Makefile:1766: u-boot] Error 139
> +(giedi) make[1]: *** Deleting file 'u-boot'
> +(giedi) make: *** [Makefile:177: sub-make] Error 2

'giedi' & 'deneb' are based on imx8x board. This is another family that are=
 not affected from this patch serie.
This patch serie is not the cause of these warnings and will not resolve th=
em.

Additional info.
We also have everywhere this warning since u-boot version 2020 or 2021. Thi=
s doesn't affect the u-boot/SPL outputs. The complete boot container incl.
'ahab-container.img' is built separately with the mkimage tool of NXP.
On first appearing of this warning we asked NXP. They didn't improve any so=
lution. Maybe there is now a setting to remove this warning.
A patch serie is planned for our imx8x boards.

>=20
> When building.
>=20
> --
> Tom

Enrico
