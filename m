Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2F6C3ABA9
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 06:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8048E8070C;
	Fri,  2 May 2025 08:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AlzNPhtQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCFA5812BC; Fri,  2 May 2025 08:04:26 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c102::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9721C803CC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 08:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEsVLfn20CJLIG2hCg0K75ueViWDJ64C+YXAVFsHjQjcVbJpHXQkhde0so08nyGa9fuQsvlx0heMIzMSXlQItHY+vP1i+PsCS/ZKSmBqqb3zDpSRlJTY3JBROqW1tPxt6WZBNkNstNHmvKz7WXzq8hBJNWfsGcBvTSypvF9PRau0gDg/jWQYCLMlGsviQyioXtepffV6XipGe77j2XlwCBdxzKUUK2Rs+v9iNRhwfegCvMzaFSRxhmcutJIUjhD/gRIiL02nT4PyzVABl5hhkR10sRSlEx2RnfjHU9WXJvM52Q1yBvg5YBSVpN8puoQZXaN4pDZZQv5Mi3tTFtt2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZK9+QnU+Pjb0bTbJFX1WJp+Pm5P6+4oISe9CJQMMiQ=;
 b=vasnbwG2vmtGpQx518sLiusXt9V2A7A5HG1UQpm4FzjlePFChHnfGMxFDf/Y90j/Xh1FHfdpcFddOhtjAxHWYZo/INtLbvglabE36MGD9wmdr3sbLcwvUrP2Tsq9wyvoBXazVRYUgkUqCWFJHDjdlOA9kovZJP02fFrE4EAfKuPd2Y8TjExSBqOU5xCMJZcUigE7KFbsRWhfFz4co0sgzXyyptVqSrSmGNA6dLktTLOSGB31hEVR/GmCxYOzLYk1SLyfmZmF/uli3Hxg2U8PDcZPiayu9lUHaEk3rmFKkK4FOxex1E1z4xUhPJRlwmYIHU4eBDQhOyxXqGjF4gsGkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZK9+QnU+Pjb0bTbJFX1WJp+Pm5P6+4oISe9CJQMMiQ=;
 b=AlzNPhtQHCidgDvpqNjwGRgAPuNCXifdCazt40c58mQXtMiYLQqXhtpdjDhxVIhXPcG0PyUlnAWCeKY/8AcMgmYHVtuSquURXXmCVkMvI7HCL9KNcx/AceLlkkNPmcL6BlM69BEsjpQbrHSqRft3SHNE6xXBrN6oglq/d2BwFlR9/s+kxFL7H2TMqaAT0NaJ1nJnKDSaBkbsV4oKzZvCN0WdzUrw3LyDr9rSi7+j/g9Rhjb+1QMbYuyW55Sk5ek7ZEJ3tXl2eYap1BIuO9NQB7RQ/m4H0gUtLVO4Wt8TGdafAiEsP2/vzuJLToQao098NfzwNRrbNM6ZFJcDy+iVoA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BY1PR03MB7288.namprd03.prod.outlook.com (2603:10b6:a03:52a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Fri, 2 May
 2025 06:04:20 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 06:04:20 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Meng, Tingting" <tingting.meng@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, 
 "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Rosdi, Danish Ahmad"
 <danish.ahmad.rosdi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>
Subject: RE: [PATCH v1 1/1] arm: socfpga: agilex5: Sub-device check enabled
 for runtime workaround
Thread-Topic: [PATCH v1 1/1] arm: socfpga: agilex5: Sub-device check enabled
 for runtime workaround
Thread-Index: AQHbuOzCDNORc8tw6UaMK6OXrX8go7O+3jPg
Date: Fri, 2 May 2025 06:04:19 +0000
Message-ID: <LV8PR03MB8137EB74194D697B44A8C68CA78D2@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250429095442.5811-1-tingting.meng@altera.com>
In-Reply-To: <20250429095442.5811-1-tingting.meng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|BY1PR03MB7288:EE_
x-ms-office365-filtering-correlation-id: 84cb8d63-e46d-45ff-76e8-08dd893f2dca
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5o90vsWsztz+1AtshpkgHhppCrNZF7pjmSyw7LkJMB3qUMF76/PnEcToq7MM?=
 =?us-ascii?Q?1UvGnaW6ud7VpjGNgHbkBmft0EZeK2twTeIPA8JbP77Pk0JQTMjvEr+WPSLR?=
 =?us-ascii?Q?pkxF0/fOvzjqpAKWchDkW33QNAqSztvmwSWer8K2CsznEBdhPPeuYz6pCxaZ?=
 =?us-ascii?Q?bCilGYXgxfhGigy711S7l2UPKBCwexCL72iWODwgkrQNVkfUd+I6ojNBhSEc?=
 =?us-ascii?Q?P+aehEeSap5u3RuvT5H15aGjEoPftSgTPencXIM4sfyls0lOR4T7G809ztRx?=
 =?us-ascii?Q?Vf9n+pkl2BPikHOHhN7mRIMTQ9vWFcpN7ZFKuv2SU24R/i3aj/GX9M/Gd8BO?=
 =?us-ascii?Q?yqKl3TKFXDDNQFqpWKb/SLpRFmwvDuKSuH0XU7fKixm0S1NBiwBFmEKSoh72?=
 =?us-ascii?Q?2g+VuHGZpTcdqTSCgoBsB+D/NPEVtax5yjYxZd0zCwsiE+5vZyIk1atAP7Wy?=
 =?us-ascii?Q?GxLyta/Bk3OPHMT118T01p7ir2l8stbyT3jh/bzr0XdOZDzYbfDIdDswg3y5?=
 =?us-ascii?Q?TKYMPNO2nubVGQ5Fi8AJPXQ+jCCNRgxFy1jl3Nf1P/KuMh/XmueqpWAldlbl?=
 =?us-ascii?Q?iwl9eX8H0VWqom2YokKfw7lY6g6C7QatzES8rmoJ9WJEFx+PHjd0TeOIhd57?=
 =?us-ascii?Q?iAPbvmtXA6Mbaqds0tP+9p90l08GSLqqIWb42EtLXvjxebNclt4VBW0ypLal?=
 =?us-ascii?Q?vOZxLoh+bWnqUW5eGFhkGyChg4ETuVoUuMCzF5ca7T8yhOwMRNs49O07Q7yi?=
 =?us-ascii?Q?CSQ/fSA2mzYr4H4DS1ERXzArrk2g9g/huFj14NGLu8iqKvYHb1jPd2TAAw72?=
 =?us-ascii?Q?sMs9h7g8CQHgDwLroYdcvc+ej2nsHNbuySdmGCkgXubEngf37raq8KF/3h4Y?=
 =?us-ascii?Q?wEJF2Nq2U5h74AEhwK77zxv2dGttMpoRnS88B/OdrqAjFXqpiwjDGuLCJJ4H?=
 =?us-ascii?Q?bbIQ7xLjlFxv0CHcYXcxPvJecU4dcS7DJ3xDDhAUnf0kKUIsJ0MO8uLLYaxy?=
 =?us-ascii?Q?rV+8Nyqtn+i3cxGioHOvJSzdvwIvQIxiRVfsfc1e43ruugZ1pXhzY/VgGJG9?=
 =?us-ascii?Q?BtXJYBhbz/tLk7kOIov5bdWG5QCDptEAhJex9qr5FSmNFgSgTdOpsuhABEMh?=
 =?us-ascii?Q?AgaRYHqGvYVHaMc7tC42qyKLthrLTbVI28T10sMc5e8F88k/7mZCddFTdoY2?=
 =?us-ascii?Q?M1NgBD4tCEdsEOHZHHAXHP84EaYNPJUzKCIp2cwceaOMubHz5QEzs3l+j/05?=
 =?us-ascii?Q?vg0s33RxrV+onG0qmjUVI2A1D9oOqSlA65gOeNoW1IgF02s1lvNQrgJJ8mYA?=
 =?us-ascii?Q?vguGzXAp00sNMjApM31EWZeAnUtoP9/ecmqhtNqTQb475PFavvk1+4r20982?=
 =?us-ascii?Q?54uxGunguk8z3nujrWqBUaFWI6jePgbTSKh8FhFplPlumKhZfRjEVv8cBv16?=
 =?us-ascii?Q?PE3k9mGj0vDkXEuASQ8O557YOF+RX+XpN1JmrO55GcaY1yykZWLHSCt9jfe5?=
 =?us-ascii?Q?CdPV6E1Oj411EP4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?44fPpFTAaCsRDLZ0WPpvi865hwH4DC6X1uQgWVe8fYt0CNmHEqYD272OtbZK?=
 =?us-ascii?Q?P/1P3KXnfALYebVne7ZhJ0rLf74ribxLVU0+O/cV7N9yO6m9lbZEZLn1QYLk?=
 =?us-ascii?Q?Y36wSMcgiyHrr/vwk1fV4qL0CL8XKUA37BiQqBsS38zeKMheAEe+k/JOY5Qm?=
 =?us-ascii?Q?amNdUajFGmmNOurwJM+onMtzxnIa9QqREaEstDCnY6XfOjUNDQW6ij7fnYHs?=
 =?us-ascii?Q?jS6kRGDR1stn0IJgjUdvtQheFj3YaTjxjHpGh1zxFbcmvClUu1XZdH0AbNbv?=
 =?us-ascii?Q?JU8WwyjwhqwxQo9EUu9xHga5Bbc4z9zigh/xAPztVNjOpx31qtBPemFpsq7z?=
 =?us-ascii?Q?OKY+vIZj+PqVOa12xesDzHoY5CwvXn8qsxylpMxVYIOoypK0+NNofxMbomHX?=
 =?us-ascii?Q?LU004NwmPywDjEz87FuvDQdpiuSNR/a8OJskE8Q6XrNUJpAhTpk5ZVJy0Ij6?=
 =?us-ascii?Q?yGclW47YA6CnKCZmWBzIoltSaFl6fPKvuC3ak2VBngM0eYAmaf/ezntXFvDL?=
 =?us-ascii?Q?2mA0DNpIr9ypqOaxpgUTtumO+B2jtK/RLnK+fkeLR8BEpH8F//unDtq2dERc?=
 =?us-ascii?Q?5S1b1QwESIVKP92NTxq+f7iZGWQiOhKsJ/JBJC7LQmCSgZfBalAxagguJWtU?=
 =?us-ascii?Q?DbRiGCTDDEbbXate691BFVHMu7EZsIMSuDSHZXF4MbxC1Zn/tmgTCQPU1Urf?=
 =?us-ascii?Q?0HOOEynG4Y4gRfO7iSDEelQxODj1BNLIqq1Mr3e4y0o4R+MUE477Ge1aN069?=
 =?us-ascii?Q?7MwJ2DdhuO+GwHt2IY21HSGWYchIKQPOA/WLyP2nUnfQwcP6BgRJAJ2CHbRB?=
 =?us-ascii?Q?orvQ2RjJRJve/ahAgbWI0r1Q1uG0CvaX7OqP/oZAH1QUcAtMEOK4TSftZfy0?=
 =?us-ascii?Q?mmXW/PkxxFjBwP4q04ZujmjPgBGbflPtIfp6eZ5eK3PE23ZIjvS3MvcMT9KK?=
 =?us-ascii?Q?ywqWAKZit8ltiLKss7aqTBqIaN5d9Mgud21PE5/oGTXLdgtcFZSUl+rKLUCC?=
 =?us-ascii?Q?Mt2W7b2q6B8BkSSkv4VyvmOL+Ajj0jG9k/kX7npxG7AYGfvG3xheTvmKbCzu?=
 =?us-ascii?Q?cgPD3iFOojpi1lsdnGnQFwA2cH55DgwebeFXO5KJq4KXwG4Hp2Epq9svFic0?=
 =?us-ascii?Q?ewxgefTkUu1/nQhZHRV0StNSzbiv+FvOaQdrXTpxZpht0rok4eDPr1wKdia+?=
 =?us-ascii?Q?5PZlWTFbV7hVe3cRqsW1/KLEpCfT+d5vLni0bcKFvLEbIAYqINljF5x1MBQy?=
 =?us-ascii?Q?jamFYHPgei2aWLsEtRIkOSNJMuq5Pses+SWZx/s3wbmKfjOtppO72FUdfNQC?=
 =?us-ascii?Q?O3idnGlxCH6XbzpwrcJHeqT1HOcf9dsEfrUfXNelRgTlIm+ZiMYTBsIlJzT0?=
 =?us-ascii?Q?TkbdGUmIIUhcYyC5xq8F369D+kSBvEEY8WJSMRLd5u9PsN2bsCWisVXpffPo?=
 =?us-ascii?Q?adeVw84KUxDAftAKfLMzoRzpsb9eCRZ0zrAzG7pivzI7w87kCERmVxCuWLoC?=
 =?us-ascii?Q?8/jZgJGgl4+j0EvTgu/Tya77A0mmyVZzBfn0bwPfqjmHzXNFHBU96q+zpR4K?=
 =?us-ascii?Q?SJyb60XKfLsigi2PdpUx6NeSacjSDL1a2cVLhUZX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cb8d63-e46d-45ff-76e8-08dd893f2dca
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 06:04:20.0068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q850nNo4eSvA2JvFeggKqsJ8Y/e1H2mXv4x7vY4kILsWHkuAJrpZIinSRMZSyTZVOLmi9aXLbWKh4nhXNhelmG5LI0+CgAKSvRXGBYfQh+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7288
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
> From: Meng, Tingting <tingting.meng@altera.com>
> Sent: Tuesday, April 29, 2025 5:55 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Rosdi, Danish
> Ahmad <danish.ahmad.rosdi@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>
> Subject: [PATCH v1 1/1] arm: socfpga: agilex5: Sub-device check enabled f=
or
> runtime workaround
>=20
> From: Tingting Meng <tingting.meng@altera.com>
>=20
> Sub-device information is retrieved from the JTAG ID in Boot Scratch Cold=
 4
> Register. This interface is introduced to allow device-specific errata
> workarounds to be applied in the future, based on the detected sub-device
> type.
>=20
> Signed-off-by: Tingting Meng <tingting.meng@altera.com>
> ---
>  arch/arm/mach-socfpga/misc_soc64.c | 32
> ++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-
> socfpga/misc_soc64.c
> index 4f080f4f0b3..5222b384434 100644
> --- a/arch/arm/mach-socfpga/misc_soc64.c
> +++ b/arch/arm/mach-socfpga/misc_soc64.c
> @@ -22,6 +22,22 @@
>=20
>  DECLARE_GLOBAL_DATA_PTR;
>=20
> +/* Agilex5 Sub Device Jtag ID List */
> +#define A3690_JTAG_ID	0x036090DD
> +#define A3694_JTAG_ID	0x436090DD
> +#define A36C0_JTAG_ID	0x0360C0DD
> +#define A36C4_JTAG_ID	0x4360C0DD
> +#define A36D0_JTAG_ID	0x0360D0DD
> +#define A36D4_JTAG_ID	0x4360D0DD
> +#define A36F0_JTAG_ID	0x0360F0DD
> +#define A36F4_JTAG_ID	0x4360F0DD
> +#define A3610_JTAG_ID	0x036010DD
> +#define A3614_JTAG_ID	0x436010DD
> +#define A3630_JTAG_ID	0x036030DD
> +#define A3634_JTAG_ID	0x436030DD
> +
> +#define JTAG_ID_MASK	0xCFF0FFFF
> +
>  /*
>   * FPGA programming support for SoC FPGA Stratix 10
>   */
> @@ -42,6 +58,22 @@ static Altera_desc altera_fpga[] =3D {
>  	},
>  };
>=20
> +u32 socfpga_get_jtag_id(void)
> +{
> +	u32 jtag_id;
> +
> +	jtag_id =3D readl(socfpga_get_sysmgr_addr() +
> +SYSMGR_SOC64_BOOT_SCRATCH_COLD4);
> +
> +	if (!jtag_id) {
> +		debug("Failed to read JTAG ID. Default JTAG ID to
> A36F4_JTAG_ID.\n");
> +		jtag_id =3D A36F4_JTAG_ID;
> +	}
> +
> +	debug("%s: jtag_id: 0x%x\n", __func__, jtag_id);
> +
> +	return jtag_id;
> +}
> +
>  /*
>   * The Agilex5 platform has enabled the bloblist feature, and the blobli=
st
>   * address and size are initialized based on the defconfig settings.
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Best regards,
Tien Fong
