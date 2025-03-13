Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBBEC282EC
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 15:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E7D081760;
	Thu, 13 Mar 2025 16:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NV4qx/3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E022810F4; Thu, 13 Mar 2025 04:48:52 +0100 (CET)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D38680756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 04:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Flv7CkHAAwCwjdr63kNBBqZD+kJgJ3cO3HsJ+jMRPFxDhEqs1L0G8QMx2rJ2K6cSR1b8FiSZmg7ZC5+mfIXpJz9zDyVqYZHZ7zO93/UzfxjVJhYhUocdzKS3Rg4jl/rhdGgVM3oMBhJAchazP4AkQ8NWGHcstQXZoSvgrTUcJGTlOlqdSocMPNnV/7TFMG9IG+Zms9pbgfh9mTv2DgH5F2bOlIIzElggBtUZsQNyLr60wTsnXt7sKlfNBS5C/owkFN8WdxwAOkL2ODAjz7DDQJFcD+1PTDIFxmqww5FqoMtNlRYV+DsOXr3roJSlR3lx7gxuaAYfZjGsN/ywD21lng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHOb9k19LcbTfJa+K7C3dTDsHtkqarcW+mrAtIOCEfQ=;
 b=tqTaz6Aiz2ezDb80J//DcwNG4KoSEkfyqRxSvw34l5mB6H7S9HIEWxFCeRl+vZ+1XVzlLS9gkeffngbT8c+UQlGc4REVXgczqGXF5DGlmbcOgln2066v98XORXw7VHPDByZri3aPVxdcWpRiaFFIuM40qgecPjnbWHFKdU1O9NU9UmwggX35yELOiy44AWN2iZQ9s5hoa86TyEsJ4g1w0QwL45QvKwxgFuj3ykUxtUC7gidDASbjDwMN171FjncVHnPzJynI5zchtSiAYm1iHo8cxf/0zG1MqC+tkkyTDmH6de/khhpVJqyhlAWa3sLRgxcVvqUVaDQjFXTDmEEp5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHOb9k19LcbTfJa+K7C3dTDsHtkqarcW+mrAtIOCEfQ=;
 b=NV4qx/3VaJwk7BF5ZpNkHGbJ9YWDgGCZqy706OCVU572jzrTDVUaVHfvseIgiQ6xITah9hIFK4UXIo5SBq07HLmXVzm96+MakX3UcYoAmGauiNO8sa3h0lqBigAVuTrS4XyWy8WhzzP6gfE/mPBxLrc5PLZuPum3pm9dzeJxRzlyZNbDjKdg3FhwgIPUe5Z9XZUKLC+3R7x7ORDXHtn8Urrs/puOMaH0Qcw6R/PGRdTyPvKSluD85VgDZOhd9A/d2tjT+m6aYeR6//hHKuoaedJevSwJmHAutvgblrcLjbhg/L6ghJvSwhjoG0od12TQVpn9DZYAJP/vjO9X60G+AQ==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by BY5PR03MB4933.namprd03.prod.outlook.com (2603:10b6:a03:1ef::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 03:48:47 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 03:48:47 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, "Meng,
 Tingting" <tingting.meng@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 "Rao, Mahesh" <mahesh.rao@altera.com>
Subject: RE: [PATCH v1 2/2] arm: socfpga: spl: Notify SDM on FSBL execution
Thread-Topic: [PATCH v1 2/2] arm: socfpga: spl: Notify SDM on FSBL execution
Thread-Index: AQHbklBPsdQvx9qI2EGe5NC9pAOBpbNwcP0A
Date: Thu, 13 Mar 2025 03:48:47 +0000
Message-ID: <SN6PR03MB3583085726C9A3F58368377EA7D32@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250311063852.9059-1-alif.zakuan.yuslaimi@altera.com>
 <20250311063852.9059-3-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250311063852.9059-3-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|BY5PR03MB4933:EE_
x-ms-office365-filtering-correlation-id: af26472b-edf4-4540-8c67-08dd61e1f5cc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xN9LJdVdK1Mg2v7zSAPb279P1AZgCD8t4Uh6Q7TBXIyh5/sLNlGapG+RMXxv?=
 =?us-ascii?Q?Oe0LRyTNUFbdrUCdoD/wWTcDUf750LamF5UXzHaenmRtl3h4YGTQH6+xX/jK?=
 =?us-ascii?Q?2kYrRUaYWBQrpXvkqITE9ReyRI3oqNn9jzHPTiGL4ooO6F/JuxWO8hzF9u/d?=
 =?us-ascii?Q?hi1T+yPt0zja5Qo5Nmqr64uEdctL1+KkVJDuCiaIZ5UjyYDS47mOXJUOGwm4?=
 =?us-ascii?Q?F6SRjv5HA7rkcG2iL30NNSc1qsWQxeEeHzuRG8x+fJmAjyI4vY7u9uY9Iu9v?=
 =?us-ascii?Q?/WD7qGbwLmS1b+R4LJT+D91v/L0p4r+69L6vc9PJ73ymjcHWgxlLN4qfOKP+?=
 =?us-ascii?Q?EimFRaQx+xuMeERw4BcYuUVTfr1pofaClBzsnjBy8P1Ogbz6YuVYrTclcTlP?=
 =?us-ascii?Q?TRY3AcMQYJfAkP19IcDJkAh4eQoi9mdSWAyUjg5ZHMUkv9fRIDtwXZbWMKUk?=
 =?us-ascii?Q?hBbuuTO+F+Jb89/KxPMNOqvuHR676+1T5YKfIvD5MSmyvCbejcPPgDxZAtM2?=
 =?us-ascii?Q?gq5JYlfGsyIYzM+H+/8UKJUhXtKAY19j9hwvzhJJ2tcRb1t3UmQFYm6TtvwP?=
 =?us-ascii?Q?ED1q+OPibqVrpjumd6YINaKY93YMe5av5GAhyeB2ZYXF+JPDh5T0gH0o0g6B?=
 =?us-ascii?Q?duiAFe2ck09FY9YEDAwNoYlRdtrynnGssyRhUmWXGmKFAyanHHrwOmkaGUYZ?=
 =?us-ascii?Q?zrzt09wB7r800qyl9iEp8rcgNMGXRNNsb6hLow8bfdkiRkTHxE2K6dGwIEca?=
 =?us-ascii?Q?4vxugMSZt6ubysqkr6u3Sgz6at+NInHNnyiz/mVjka/UlEw5lGQ0enoca0E1?=
 =?us-ascii?Q?Nesm7OliNbfwxkWOUejSkB9GyGxcKE1tAy/rAkaQ6aHnE8DRRrEtcf8gzSej?=
 =?us-ascii?Q?s8qisUv/x4r2tEq3TyeVtoJP5BNACPoJC8T98AbmSMJ7/DaslViRuEmym1UU?=
 =?us-ascii?Q?VHBY2a2tLLYgkr439IOwPMCxgb+Rd83M3uiJuxlFh83G9fVUnV/94v7aZdDw?=
 =?us-ascii?Q?6yKo/Y5EEaZff8jjT/k6EHwoLPaG3s6pcp1m/gs1wihP88crtoWCbu/V8y72?=
 =?us-ascii?Q?V8BpH8MQYt7CWC5OGMabUYtZ3xMNNBUsazyz2QWEzHK61C+I2pKgMyrAZ30m?=
 =?us-ascii?Q?8tN+uYIv8pTP+ckTRKvt9kBxekwNbeRmcrTlOSvQJoiJ8HM0823QrgB/y69h?=
 =?us-ascii?Q?osuwMWdnESrnuBPhjpdr0xixVp9LqhVhUwef1Mxp2g7hY6c/sgsvDTJGeXBJ?=
 =?us-ascii?Q?pcMwjroKaKYHHVjMwPwCsuHTGuMndwGW2NET1nqHaM0c8esh/zGwWAtDADUR?=
 =?us-ascii?Q?XMiqUMEM9FMt3SslB21nvYTQaK4P4zfg/gch3wSHdp+6pnJlQVzKW1TSo8Y1?=
 =?us-ascii?Q?qGzKYu4dCXnW/mwKSh62jxBpR9I3qVWhu6FoU0UQvR/4cn6+u6z3unctFND3?=
 =?us-ascii?Q?pbeIZRQnRgLF8C8HLdidqJD6JSivOAfo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Y2H6bRZZc22llClSvN4Q+vmw7xI/V3SaPldjH64EnQRGQlARKorKLc5rb2L?=
 =?us-ascii?Q?YzhQc4dDFhtCRFOuPpdnTuLn+SJCQPJX7ozOaB9RK1oI/6zj2VEbcgUbna/D?=
 =?us-ascii?Q?R4g3ZtXvQeba1HaHetneJCdWpTIT7RfT76RoTtnpcpj0RwkCH/jW1rxywHE/?=
 =?us-ascii?Q?BBj3OQ8HOJ2iEGdPrU9OkHxcYz5LJUIVFqx2HlFOIaTArMUBbCgIv7nZzBzh?=
 =?us-ascii?Q?ZPUHAFn3gVKftVkJx1UH/8SPkn+AuC9gMNvxhaDXuNJx1JPs85C9nkpf11K6?=
 =?us-ascii?Q?QFkfEXRIbROwKDMVUEmIc8m3Gvkw74SV8/MB3NW3Z5FroKzPyc5R4+5qiol8?=
 =?us-ascii?Q?bRiso7FB8Zw99ML1gg4WMtksM8R1Oo4JEji1yThUCnNgNYXJ5g/DnuusxCue?=
 =?us-ascii?Q?426zKk9Eo0grPvtgPIAsHW23FroN1H61mKmgsIr55VYxuh7BGwGcUGsFKHpA?=
 =?us-ascii?Q?67fzo+lzswvBZDwETN52a1FXIHy9+PnTCXjt1Pm7L5RPgr9sE/dAhTcK0Hhw?=
 =?us-ascii?Q?dE1pdrlTMKVAYBWW3rg92JyxnNgnC5K0UBUNIv6Fg7InUc3+stzdvT9ecWqk?=
 =?us-ascii?Q?2woCIbhlUV5bDP/rDIM7LxShXvfXhtvn/2v8IQuxyVvgji+7/iks0bS1IekJ?=
 =?us-ascii?Q?UbU62RP8CTjkVdKWTE+y3PtNv6YqVSjdjYF30zb61BCkpW6IfCCCXwFsHRq6?=
 =?us-ascii?Q?NL3Rb2ypaUO8r+cwRXnOtXDPcxu/qvJ54BXEXKJTbQZT4j5XmRmluVU8NyZe?=
 =?us-ascii?Q?4c5RvZtZxEQ+qu66ijIjy9pjmZ9hUE7SGRfq2pKZk4sOTWvyLtVFK9nqpx3r?=
 =?us-ascii?Q?bGIasLqT+URuunV42JiMPDtL0+RUquwr9yMclFwKwlRhx7rNJSdMoalVdVn0?=
 =?us-ascii?Q?eQXnh2iArUllBg2BAh6mLZKgjP8ZUSe37MDZQvc7xHEYegd6uPdUVCuPHDHj?=
 =?us-ascii?Q?AMRNgr7gBU9YF4ZqQfI8Dy0vqshGEvsWCnQiOTI+Y+CCLNAQhcJTXLsXToPt?=
 =?us-ascii?Q?+6krXKeijRo2QRgY3WDYS4R+JvVM/CdhR2QoIYuLt0EW2vKedRA2Y9zHVbZQ?=
 =?us-ascii?Q?2RUj7Zm2V7oScHOMvEO2zUiTLdrK4XDjEzibV8qDbBjqC89C3cP/9MKrnqDJ?=
 =?us-ascii?Q?BV4PUwfDGJOUEm6Zufl0Yrfdyu2fJOhZJCVxsXC4BCNt3CmW1PoYNxBxzhZJ?=
 =?us-ascii?Q?UnPUv0Gdxvpm9COIlj13VLymaf+jf1xzgsP3/Lz0/1jkb3E7/Hjv1/LCQzd9?=
 =?us-ascii?Q?FBuVY6VqJphi0QT3Dhin37ZISlnFf2Yjk8O4AmqdFp7xuRt/hiBxEDsH32uk?=
 =?us-ascii?Q?Usg2zE+/kNhH7zvvuu4qTx/OOPaxsARi6h120PUdvNe2oJS8gcxVEf6vQIPH?=
 =?us-ascii?Q?BfrsXaHw1JllNKcTrqLY3vSM0D7OkDVypSrMkEuqh25BwySd0uJmODbH7XsU?=
 =?us-ascii?Q?hWO9e8CgT2gEeYlBPctnKo07THUHu6BlVKHx0V/DbqH/z654eirslVl7l+ES?=
 =?us-ascii?Q?aV2Mzelps05LizHdxBbO+wvhLScwlemuCHCkcW5wDUxmnIzefAYLo0LJgx3J?=
 =?us-ascii?Q?9d8omX0laGLzjDVyoOOTGzG5kBQnJlc85IXSuQLU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af26472b-edf4-4540-8c67-08dd61e1f5cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 03:48:47.5267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UuJuwVXeCoTLpuByl4LlszI0S1B08Z/kkY7M5Lg/CMLshR9Lvoj3fnV5eZ0m2+K3TM1vUNuFlnBNmOp/Orve4BL+zzN/7ndnwYe5K3LItKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4933
X-Mailman-Approved-At: Thu, 13 Mar 2025 16:39:20 +0100
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



> -----Original Message-----
> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Sent: Tuesday, March 11, 2025 2:39 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Meng,
> Tingting <tingting.meng@altera.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Rao, Mahesh <mahesh.rao@altera.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Subject: [PATCH v1 2/2] arm: socfpga: spl: Notify SDM on FSBL execution
>=20
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Send out "HPS_STAGE_NOTIFY" mailbox command to the Secure Device
> Manager (SDM) in SPL to inform SDM on FSBL execution.
>=20
> This is necessary for the SDM to recognize that the FSBL stage has begun =
its
> execution and should be made as early as possible in the FSBL process.
>=20
> Therefore, the mailbox will initialize and send out the notification righ=
t after
> the completion of timer initialization.
>=20
> Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  arch/arm/mach-socfpga/spl_agilex.c  | 6 ++++--  arch/arm/mach-
> socfpga/spl_agilex5.c | 6 ++++--
>  arch/arm/mach-socfpga/spl_n5x.c     | 6 ++++--
>  arch/arm/mach-socfpga/spl_s10.c     | 6 ++++--
>  4 files changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/mach-socfpga/spl_agilex.c b/arch/arm/mach-
> socfpga/spl_agilex.c
> index 52617a39cca..91c27a5543d 100644
> --- a/arch/arm/mach-socfpga/spl_agilex.c
> +++ b/arch/arm/mach-socfpga/spl_agilex.c
> @@ -50,6 +50,10 @@ void board_init_f(ulong dummy)
>=20
>  	timer_init();
>=20
> +	mbox_init();
> +
> +	mbox_hps_stage_notify(HPS_EXECUTION_STATE_FSBL);
> +
>  	sysmgr_pinmux_init();
>=20
>  	ret =3D uclass_get_device(UCLASS_CLK, 0, &dev); @@ -77,8 +81,6 @@
> void board_init_f(ulong dummy)
>  	}
>  #endif
>=20
> -	mbox_init();
> -
>  #ifdef CONFIG_CADENCE_QSPI
>  	mbox_qspi_open();
>  #endif
> diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-
> socfpga/spl_agilex5.c
> index 3451611082d..a9aad5350d2 100644
> --- a/arch/arm/mach-socfpga/spl_agilex5.c
> +++ b/arch/arm/mach-socfpga/spl_agilex5.c
> @@ -62,6 +62,10 @@ void board_init_f(ulong dummy)
>=20
>  	timer_init();
>=20
> +	mbox_init();
> +
> +	mbox_hps_stage_notify(HPS_EXECUTION_STATE_FSBL);
> +
>  	ret =3D uclass_get_device(UCLASS_CLK, 0, &dev);
>  	if (ret) {
>  		debug("Clock init failed: %d\n", ret); @@ -100,8 +104,6 @@
> void board_init_f(ulong dummy)
>  		}
>  	}
>=20
> -	mbox_init();
> -
>  	if (IS_ENABLED(CONFIG_CADENCE_QSPI))
>  		mbox_qspi_open();
>=20
> diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-
> socfpga/spl_n5x.c index 5ff137e5c6f..81283ef7162 100644
> --- a/arch/arm/mach-socfpga/spl_n5x.c
> +++ b/arch/arm/mach-socfpga/spl_n5x.c
> @@ -49,6 +49,10 @@ void board_init_f(ulong dummy)
>=20
>  	timer_init();
>=20
> +	mbox_init();
> +
> +	mbox_hps_stage_notify(HPS_EXECUTION_STATE_FSBL);
> +
>  	sysmgr_pinmux_init();
>=20
>  	preloader_console_init();
> @@ -84,8 +88,6 @@ void board_init_f(ulong dummy)
>  	}
>  #endif
>=20
> -	mbox_init();
> -
>  #ifdef CONFIG_CADENCE_QSPI
>  	mbox_qspi_open();
>  #endif
> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-
> socfpga/spl_s10.c index 53852cb7443..fa83ff96adc 100644
> --- a/arch/arm/mach-socfpga/spl_s10.c
> +++ b/arch/arm/mach-socfpga/spl_s10.c
> @@ -52,6 +52,10 @@ void board_init_f(ulong dummy)
>  	socfpga_per_reset(SOCFPGA_RESET(OSC1TIMER0), 0);
>  	timer_init();
>=20
> +	mbox_init();
> +
> +	mbox_hps_stage_notify(HPS_EXECUTION_STATE_FSBL);
> +
>  	sysmgr_pinmux_init();
>=20
>  	/* configuring the HPS clocks */
> @@ -84,8 +88,6 @@ void board_init_f(ulong dummy)
>  		}
>  #endif
>=20
> -	mbox_init();
> -
>  #ifdef CONFIG_CADENCE_QSPI
>  	mbox_qspi_open();
>  #endif
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
