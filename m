Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA17C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 07:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73F6C831FE;
	Tue,  8 Apr 2025 09:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="bjo4Rrzk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4377383211; Tue,  8 Apr 2025 09:06:46 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2726E8312E
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 09:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AN9Uzwvq93yZX4ueDNZFKVIsO2zK59kCwRvCP0n1Qg6tikcWveSQeRwpL2UsfDUj6oiNT7v9aELr+ifoLpCGM5S5BooQ3671O2KI+O3UZmse1eW//znPiW2PobOO8BIoRaxd9pM6Ag/617GnWWo26s9aFdqL8RBVriBlJqNmWyiJZKfUI6ystwudEbnlF/AJcyGyO7rlRfRPeg5lWJ5iS0Ap2Rov/5OzZMYfoGHw1WyaoL5Mp7PwrW79wtCYaxwRk+DVy7k+I1BNFaGyPDXgfEx3Z6difeWgFmRgcH7SCeczVgYNbjkyNMdHEdx2GyuLZLZBT1MDbpnsv3G8ry2hEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEp1bLa8OOpGjjVYdwe4VwZ1PoVMFqBusbY3FE0wQTI=;
 b=rCxFQJBxGNMsZLmvBb2Qt86ldmfXJseF6dxrDzCWZ1bBZSlmW6ijWyUHv5DvafxPQh04s2Pq2wXyb6z68q927J6eWU8UCJP8AsH8lw7+CFh2hwqbU4QB1r8E/hxnqJ/SRJnPbp4Pdpj3mY6d/pnmISNtAzahb68UT8Exw1MwrsygmvJK0yyE1iG1lXri5mbC+QiOcg/ic4zPst9nIGF595LVCzjCrgANxS08GGAkQC9Nc4MetujxD75MMtmQIHJuOi0K4qNSOVo0i/XZA/vskQCCQkDEeubmqAVKgIVU4zE7pNjXU0v3QEfq081ajG9fmXjoMfQ7q1U33Ipfo4++vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEp1bLa8OOpGjjVYdwe4VwZ1PoVMFqBusbY3FE0wQTI=;
 b=bjo4RrzkCLRyMWI0wZrmpLIXoPWOSkECX8te+r1WMcVmFHPbVlEs1jwm9WP7WKOPJH8zcNSDqj1jIvEhS83mkspdjqS+brXkPSMntLyI1tLn1sPajxVEvhI5+DUE7gpMOneIx1MmuDIa55RsoSYda54AVcFVE6aM2kmgiQQxpNgAzl8uYhU70jrPGkWgA80QwcrpBpagZsatLyQJP/uNXoK0fIQbGJOqOANUZKJy3E/b3u94EKrSlB7MW09BDyGhkmkPhRVIUZzCKPUycUcE0Wyc1VTO0n8jNNPrHQeeAKT3XlO7C/lScJW4L9pVfmKh5QRADRJTuyRDtp6gGxXB8w==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH2PR03MB5205.namprd03.prod.outlook.com (2603:10b6:610:9b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 07:06:41 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 07:06:41 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, "Maniyam,
 Dinesh" <dinesh.maniyam@altera.com>
Subject: RE: [PATCH v1] configs: agilex5: Enable Marvell PHY driver
Thread-Topic: [PATCH v1] configs: agilex5: Enable Marvell PHY driver
Thread-Index: AQHbl7GOB290GmWDBUWwy0DKpBtx6bOZeiIA
Date: Tue, 8 Apr 2025 07:06:41 +0000
Message-ID: <LV8PR03MB8137DF744B37E42136A6613AA7B52@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250318025746.964-1-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250318025746.964-1-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|CH2PR03MB5205:EE_
x-ms-office365-filtering-correlation-id: db96e077-7d66-4257-16f1-08dd766bea1a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2kvGPJVhRTErpUaA7bMzOrCLjZqaKyZbxeY65HQEI0rnNavp5znjK1X43Jmv?=
 =?us-ascii?Q?cNDX3UmVLQ/aDOGqM8tcJ4TzZ2XBvX73bcDdAyWQ2DZ2WLZ4IzBdr8Thbvv5?=
 =?us-ascii?Q?yFpyU/S1LkWZA7MuVuCq+zrqbhJj2zHKKkG2snJgQyuQP9YNfBeZ7/lGoi0D?=
 =?us-ascii?Q?kjrGrdS6sqWIyf/8lucmKpwFI6dZTUxIPWPND+dgE5P7pB3S4BMRGygaUryV?=
 =?us-ascii?Q?WbGGpvsOcqGm0WGThO2h26Qc9GPxyY1YitDiJC3xXXyVE4ixeLaMQFE3QI7j?=
 =?us-ascii?Q?uPufhbsQkWo5/d6/DJXbn/d8hLdC6EeSEGQuQ2WWvjcj3AERPGpqg0o3j4Bn?=
 =?us-ascii?Q?bvonEQjzggOY7PkyKHZs1mzv5NYEn7UvMbKEDKRU2L5ha2ARyvxcdpFekztq?=
 =?us-ascii?Q?iT2/k3SarLTwZ8FP2fdB4juoVRiAReAwRBBQdjpIC9y1bC4xpdjPeoZhCO70?=
 =?us-ascii?Q?nYWYkN9dBOIjDzX8Si9qL5AvF2A6gUf36S0FsQmXram8XCoiTUEoL5/o8nFk?=
 =?us-ascii?Q?jSA4SSrB+vQULVgYScX3Xs5gA4t0NMmGB1ss8BcsF/+oKWfQFdrT94Gfvpdd?=
 =?us-ascii?Q?xQpGYJOQrD3wO+YMvbkynNzDap0J1EgzRmitpiZpRgKwo3UvSaDSUdTUiDVl?=
 =?us-ascii?Q?w5hVvx8aZRg8aXX66+g8v/i1AK+4JFhz1TwxQMbDUfDfclEAxz8Xg408SIDu?=
 =?us-ascii?Q?1Iw7L3RAZ2eadUdfUY1z6R+gLJWl+xE+XLzcmkcCHFbvh5Z1RbuSzAiMVVvq?=
 =?us-ascii?Q?gosL7jmwS7p+0BH+NUJ44HSgwna7D9wD6jCr5y+OFhVG+UAIjZJHSa7X53es?=
 =?us-ascii?Q?yoMlvVToh8RDsatnisTphixRQ0jd7FGd197EII0FGQxtWCkPh1am5j9mYjgA?=
 =?us-ascii?Q?SMFzn603VPjfGaCIgHJHxWAdcLOtuNo2OJ3jCu3C1Y1vBnjRjVL28CMibQxr?=
 =?us-ascii?Q?dmozbcPxZ2nRy/syByCDmTj6PbMcW0m5iAzGm0VWr/9QAeXSZ5jtf+8ASLEm?=
 =?us-ascii?Q?kjMVqU6w/W5TNIrZh+SKBP2L+/l0wHeFUpqdqS75Bq7ZwFX860GWf0lqhQx7?=
 =?us-ascii?Q?/GO1OMXojvZNyv0b+P+GW+b89p4U8q7q4ilHtYLhtGLlpmoDFGU9tXDSoVmn?=
 =?us-ascii?Q?Jw4bXKnwj936tMKjKeaWzlk7Vi3jVrqz5FITZ1g9Q6/san472/eVhwnfYU17?=
 =?us-ascii?Q?1J2fJpaPQc51jQw0qMEWIvq9yDNOgAnGYZlxcS2DXJBCPXHHePaYulqUUFer?=
 =?us-ascii?Q?U9BlZ7qnD8U5/HCdL1yGvE6ANe3awygugkwE0jmXDm+O3LjZVgODW1mEvJeG?=
 =?us-ascii?Q?K7WCzYPgs3qXH2C3AfZYg9tIYtQ9kBpl/DEfiU4Va4QspLpM7v0pWyveB7/y?=
 =?us-ascii?Q?VqkeDi8pSnreV6WHALBye3fOTesck6ExTjfZo0g1kQfOJA7HtEhK2/udyVkH?=
 =?us-ascii?Q?0J/QxPbOvb0BrpS6QQXDxAtSkWXsvD/9ymKbklOG1bJZ5TLclaTPTw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ulOtm2oIoCDIkc5qpqKmrZPwi5aMo50s6RmfTgEGgNpNXGHzYWynkPq1gErm?=
 =?us-ascii?Q?5n5dtagZfsXv8tEAMsVHlo5IRZfZnSpt51XUz71l6MFAjXa0gszuEud+wZqo?=
 =?us-ascii?Q?KR7MA6QdJkDDaA4CLV0TN8f6eBc3+Qeuzgg5lGNzyy5DS2WcECqZrBZ2/kYR?=
 =?us-ascii?Q?TA/0iHr0PfHFNoNcKCINIB3DKuA2cwRw7anZS5wuMBvnlwdzn5xUvkbvuXbz?=
 =?us-ascii?Q?WhrK9FbctHHf375Dc7QlSBO4I+57bJS6JquEj9i1vzNekaUhGptyrUOxhtbb?=
 =?us-ascii?Q?Y2mCuec/ijIHxmf9zAiNfzUXLxLJkX5p8jWvX0Z8IsjHKges9v83lXy0YKud?=
 =?us-ascii?Q?XlZ8XpviJTtyziZjEaIhz2xUr1uJHbpuHWsoFDIKYG8M1Kmul7IkW44Al8P/?=
 =?us-ascii?Q?Lj1ulz2NYmQDBFlAd9bcoMTA4CwSVwvOlZlxkwKMqAMxyNyMVBuLTAJkRE/p?=
 =?us-ascii?Q?ZROrn07r4THizUIVjYJHMzOUnDjOIRmfC96SsWsTT/2Ccb3tyTbMo01bgCeg?=
 =?us-ascii?Q?aM94si+CKMmKhN0yBE1enYwSPTbCEHogM7LM22eNFyY6Prd654Ne02jnr+/5?=
 =?us-ascii?Q?5i39wzOE9SEJhwiaq9DEckEkZf4nH5ri/DEQT1Iy/verp9BfiVvevwOWMfp+?=
 =?us-ascii?Q?dM7VJdbapH9a0fNPKmOJeHXLmfF0UEY99oa+raSfJG8V63VlbmUuBAbWRDvw?=
 =?us-ascii?Q?yNw1Qpeikz42+pBuL8dCg4bAzD9oYQ5+xqwac4bpWpBdTrOv2fK6G9RNWuA/?=
 =?us-ascii?Q?LHYA/U6Nz9YVQFN6Lq/gB261Z/zDgECL+/fLBwAsUj1lFPY5VqxEyJXPRyjV?=
 =?us-ascii?Q?OoxIghqpisGczpDAi9BGopqF0RWmah1I7VuBFGCthvMeJIhw2bWu69LrmX3W?=
 =?us-ascii?Q?dGWMJECXhe2fHK5jxTblIORqBOrD6uvpYNt8VPnWJqYS24v/NFKMgdWmD5uJ?=
 =?us-ascii?Q?z2fbA8diHK7erbP7iU9T45y4/U1WXoTeGYbFgzQQb9VaMrH3pOxOmkP4znxf?=
 =?us-ascii?Q?2EX2r9PLiWQwyqnraSioTKRkfIzPWCsNK9yP94/hQXKVWp6Pw6KD/vWe2ZOh?=
 =?us-ascii?Q?pdc1aLywlngbbsa3dQUktXLp8rhvFkIv4rra8CWZ3bYIDuxC+umOiyFuSgQ9?=
 =?us-ascii?Q?ecURFn/vspqukSVPFWIW4n5IIhUm/ZcqUvFtlOCIAjbVZwMXS9fxkbCbOGas?=
 =?us-ascii?Q?iF9fQQbke7Ufs8PDLVVH99Whaespu/tSXvW2hex89jwxeO5wDFQEXUgozQf/?=
 =?us-ascii?Q?sv71WB0lHbD985gbwZlsoInepvYPHlgsxwIoSwwtklxAkOJpixvQjzhDVgIE?=
 =?us-ascii?Q?MpyX0J5l9Qlu4ZikX3utbLtt8kFC777I+91oAAHAKVptOnS8VbIzRtgRz131?=
 =?us-ascii?Q?QGmpv2tg8X8trEl0QGMIBCcuEjDfpDMPma7JnGmBTWghDb/ULnJ7znUIXpQ3?=
 =?us-ascii?Q?gZJj77E1PuDHeZaTyZNRZRjAFJARtZ1hEn13kPFCEc0AuWuOKMNuGD5bHiuw?=
 =?us-ascii?Q?F4Zi4T0YPac4tuIB5wVMAwH0bJRkSUfTd8l4w4h/6vo1dLUH+zNL9ZnVErPH?=
 =?us-ascii?Q?LQTJlI2szGlnMs0n3VnlfLJXnYNmDR41uuhAqGAC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db96e077-7d66-4257-16f1-08dd766bea1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 07:06:41.7371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxpOZ4hpGQWX7it/4afA1b6t93Tzo9QrRI5ckh+Z3Euth4ZgWlZEEgI0SaydNgPS+cdNhxPEit321oHn9hHF3QD66+MwVxjFf8sf7ENFqX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5205
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
> Sent: Tuesday, March 18, 2025 10:58 AM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Maniyam,
> Dinesh <dinesh.maniyam@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>
> Subject: [PATCH v1] configs: agilex5: Enable Marvell PHY driver
>=20
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Enable Marvell Ethernet PHYs support for Agilex5 defconfig
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  configs/socfpga_agilex5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/socfpga_agilex5_defconfig
> b/configs/socfpga_agilex5_defconfig
> index 0fa81b0c738..2e59d2bafc7 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -99,3 +99,4 @@ CONFIG_HANDOFF=3Dy
>  CONFIG_SPL_RECOVER_DATA_SECTION=3Dy
>  CONFIG_DWC_ETH_XGMAC=3Dy
>  CONFIG_BLOBLIST_FIXED=3Dy
> +CONFIG_PHY_MARVELL=3Dy
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

