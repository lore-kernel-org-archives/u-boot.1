Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2FFC369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 06:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F9C81F45;
	Mon, 21 Apr 2025 08:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hO/wFxB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1057181F6B; Mon, 21 Apr 2025 08:32:18 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C785381F44
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 08:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7Akm66ATYIIovxLb9Kcg/vxQgXdQkNFynCmeJInXYu08Ci1xniPn0otw7WAqEeFnirSZEopKTFdfJDfHk5fMpz+YNcLnTk/Za5fu73m6Sd3WRrWR38PPR2KXgmtgPh9ZJQtKc4XvWV4bUGfQzynh4sZNItUYuU95BPBoiWweHrNgDNu3MQsk5siVv2ZU1xnTJdVYaBLLDzXykQV39zYK/+oaTaRuGcxrvuXK8VRRGjpVh+Q9MY93xJQzpOKPeIeM3NscbV23PcaSqLmfO8qnH35w40CWgn55C3TKytDuV15L4rbtqL6/qkxKh3zS9d8IPWuaztmUJJAGa0FVAWECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHI/1xjPArEkyjXHq0mrX+0HLqDW7r7MEBRi1Pz1cmM=;
 b=zCEndpemk1pX5gPourzkZPR1DN6R0EO/QYJq9TKJDlKddGsh4Ax1QK1LyONgaiWbU2XcOK+3bZVdKktliAu+PofAGgIYJt9cknz+vOeRMSwrLw8dtyjpF7hRIAaiJwlQqary0IdKmjd62pYAtAV706hYqlFuvNK244EQ5xJYj0qaMcYxfxerHi1z1u8C4l5Ho2yOV9mmPduWg0p4dJPYNtAAXW5NlzDjVzDkvKXJgxnMGL0oNXQxsf2Sb5RHLBo+ZSTTDgnVV3PQiiMVZ/7KczREQCIRfChghL5ftF3n7kwwEfIDdb5KzH34hlyzapKg9uUs3OVIZ171ZXWrc7g2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHI/1xjPArEkyjXHq0mrX+0HLqDW7r7MEBRi1Pz1cmM=;
 b=hO/wFxB26jVjAvQWVA/7edVDvBl9gLqFGnVEgJHTMu/U5kpd3S3FDjMpiZ9DjKx2NFEPvbJ+897iZg53Ca0QZzRc5XbrWi7Cm6x5sHtzx/Opd/E0otn2LoV+zgmaHOF7AqvT/CVTNZkOEZrPKBzDyO2Lk9/ciL2ynoB+X+xdSBk2V1rwILkpgBSHnM8ue727Z+0q9xt2duXqBWvje5c1t+8NRQhcn0WkTCpzKvRcINUROpjPHNORzK79MGohR4OJaYpjW+Olxfuub51vkpBqeAmetunC/nxIzmY6PbhOlQSCQgbodnJ/3fO9sSDJOnBCRiuZKrXEcoBoiOlb977NsQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA0PR03MB5500.namprd03.prod.outlook.com (2603:10b6:806:b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 06:32:12 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 06:32:12 +0000
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
Subject: RE: [PATCH v1 1/5] arm: socfpga: agilex5: Add MMU mapping region
Thread-Topic: [PATCH v1 1/5] arm: socfpga: agilex5: Add MMU mapping region
Thread-Index: AQHbsnv13tg2hI0F00OJ4bQ+0r6OBLOtqSdw
Date: Mon, 21 Apr 2025 06:32:12 +0000
Message-ID: <LV8PR03MB81376E5ED82217C31D926AEBA7B82@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250421051126.13799-1-tingting.meng@altera.com>
In-Reply-To: <20250421051126.13799-1-tingting.meng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SA0PR03MB5500:EE_
x-ms-office365-filtering-correlation-id: 7bb230e5-3150-423a-76fd-08dd809e4017
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?wE7Xv5KNYBNzPhYno0g0DHymHlJB+tbofYC/XnMt/Vapne/mKRmg01CHOtWu?=
 =?us-ascii?Q?HAaQNsFf2umfCvPZqr0cBE9uvcOgCpDc1U6a9bmChjx2zZwp1k7DFUsgr95V?=
 =?us-ascii?Q?pM6Sk+CI3Y6Ui5PouVPhpovqJC93mjBOZFYo4YqknplFykJ1Mvl2N2S7FTVv?=
 =?us-ascii?Q?3D5WPVt1Cdhg66X38mVDDg6PWXcu7rSbb0luvGYXOPGWXKYvO1NtdQEoUlio?=
 =?us-ascii?Q?Y2dEp3wvWm4u2dqd3BssaWbAP9szGRtLU7r5wCNSTPYfpGVQW+wJlPttAUu4?=
 =?us-ascii?Q?dCgnV8hS/nbtg9zNL36JrTB0f2zM/TOLhZl/ftuNnS0h1C4N2fNyko9O+T3h?=
 =?us-ascii?Q?w/mXb1VXFiFR4ILFjdNR2i1sbn8//c8qIzRRxSUOSnlmuAzGw3ZPNDdXh7VA?=
 =?us-ascii?Q?1NSKXjpJnfFaj3MybFVruzII1sdGiWHNXJ7dadQY5K1eEcaRk7S15zM52cmf?=
 =?us-ascii?Q?EdN+CNq9umlakjNajprBIuL7OvgdGN8e/rTbzUqHeO+9iJiwBduVu+l8TaZk?=
 =?us-ascii?Q?IzhEgscq8rwuEkHofkRh9uv7HnTl6UPY6dSt0gBz7dXCK1o+k/UeEKZQBwgb?=
 =?us-ascii?Q?QZQ4/GBgT3o7Dzhi8ynpPDMjkFM0GOzSNfQ3pUFy7oJpcq8GmRzzS2On80i3?=
 =?us-ascii?Q?uVsY94P28wxeRnGTGHymGxx+DQHEYt8ku8pHtibcQ0SATFsAMHXdQk3O1M1f?=
 =?us-ascii?Q?jRPipglUvsVQQk1gFc3fI/qZYi1X/RJ3r3WoNBuh8HPALtjKDl6F7ct8oCVC?=
 =?us-ascii?Q?HNaLqTnp4a7BfPNmES046La+358R8wZYd9nMrLeJamDkBFOmRv+jnS8e7VlQ?=
 =?us-ascii?Q?w91RrLz0pbVSVcJEw5mKItF/58quuLElG5apNcM9GQsNGIuVxKcmbSkIJ0a4?=
 =?us-ascii?Q?1lzOhZa1kGY7GrxZOY9b7S42kHJQtx4ESuCJN1n9lFCA+V28+3yw+jRaw0QZ?=
 =?us-ascii?Q?ZAeIGq13oWpevhMKVZzjWvhHxB5pza/DLIjRNEHUL8VsajX++TW0AroBpfOo?=
 =?us-ascii?Q?oTxjHkDZAXGioNGF21OEWg5LgV/AFzKoofIq3c4lDgZ9PP9Or6AY8sDDs9HH?=
 =?us-ascii?Q?Ot+i9Ak70GvrEB2rPIf3EKYDVo4GR66syMsdALmeVFMdaeCTwhNCemVOXKQo?=
 =?us-ascii?Q?e+QrCcOPZw1OeCKfIl93cuCK6mcgXcgPALMGrP1+rjM7JsaLqz/8kyGbU2iE?=
 =?us-ascii?Q?rl8h7SCkGSAMo4hCi1lABHF5Kb+qEiDab07oKaJzZ6nolSiet6r4X6fdY3y4?=
 =?us-ascii?Q?GZswa7UTXgQ6hwpSOZQqo03Sqt7QKtvTCUweueheJgIJDUxH4YXJ2R7MZpxM?=
 =?us-ascii?Q?78TP3ezbaC4DjRVri1PLbVK51l5Nbib3J8FuEMXtca6CYU2d8fNddrppryi1?=
 =?us-ascii?Q?cEv+Y4pC8VjlFbJPGXAJbBq6ljgvU0dd4cT1g1aLx6aCfzDhELg0qZEHddpr?=
 =?us-ascii?Q?+hfdhmhHRJaq1tBKMYjVU2C0hCjUuVD7XIO5b8RQDAKte5VhgZO95w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6whi2/fpgQeok1Hrkl3v42VsR9hcgU7WzgetAp4vY1zuH4P/KNoCE8wEvkdl?=
 =?us-ascii?Q?cnuOoPgn3A52BpHZjAsl+W5upW6kqTQteFWfN/HfuCaBo5A/ntSWSxldCEWY?=
 =?us-ascii?Q?62OcZWongNxaEuoeKzVc5ktmvQPNlMoirmVSKKynee2oFCYwH4if4jNoXUIc?=
 =?us-ascii?Q?IgoQAGeo3vuNvv2pfPDm0W6jO0Z33dUoPlZWdlf0k7Y8kv8QmaoPcihm8tWt?=
 =?us-ascii?Q?95WhAXGkrTbCF2F2TZPMQPPlbTLbfUuqU8kyZCCdD6p49pb3r3RV3P1I3eNW?=
 =?us-ascii?Q?EXcMimc+OR3LtvWvlsrg1dKfLJsRhZP5aocKAv50fyTd8yQ+RA/bGARO8Z7m?=
 =?us-ascii?Q?SNemskr8VtHmr/JXywan2VLqr8T8MTZFZAbunVoPAqDDsly7inAz9/FGRbk0?=
 =?us-ascii?Q?x8a5f6KzW4sio6ra9nShszann4/fkeYsesAbUxcDr85ymVqROxdMOspxLTFQ?=
 =?us-ascii?Q?3tqkTgVBW2nbaUq5BDJBvie6UsaMncTZGDeR0kfew68g80aj7afePFjbr2st?=
 =?us-ascii?Q?zYTy/u9+sf8gTseaAyX9zlFQntuHmlynZw5msoIAnR7J+w6rNbPKmkoVkHqX?=
 =?us-ascii?Q?fhcGMzi/gP5QiwIhT5kD8C+PweZE1RhWxIC3ywt1Nsfm+iIgSOncH4hAMfb2?=
 =?us-ascii?Q?XmH189+nRVqF/fpZnuI+894nR93uW88ybohWyX6kapCbDZVuq56I9jhjX76C?=
 =?us-ascii?Q?lbEaEhSNOuadeq12TkqDfbPmdzfNjW/665sVKS3PwJnMqUsy8Ht7FLUtwr4y?=
 =?us-ascii?Q?ensmlwTzqdjBLuN/mTm3Bc286O3+Cu13/kdd5Eqr8pdkwCHYBC3dDV+46npR?=
 =?us-ascii?Q?MC10SibTCpHLpNFQeIwzm+Ay3ldskqqNiii+/WBRIyPtSIa8QrMYUTkMY/nB?=
 =?us-ascii?Q?UvMXadkaMY4GuLk/kJDKymoNAIm5Pw6MNEXj5p819lS/6tzdwp6W/+OiPsXc?=
 =?us-ascii?Q?AnN0veZqNDigcrbeZnStbU4QoIBh6euoTCesHhF6q27OVeOdsbRadkzbc+he?=
 =?us-ascii?Q?jufAacXbhcGp7Z1CZNKlSONrbSuhKRbTx85G5KmkSNwvaio5DtKE03le0Wl4?=
 =?us-ascii?Q?wbPnQAa47Cqx4xWahHQXPx+0dZdC2h9kthWG0+V+dbMI2PBCDzBlGcYz698y?=
 =?us-ascii?Q?auZFw6DZhiMGXS8Owvr3AgZjbOr+25+3L/DWD4awx879ohuYwT9pJ74/pml7?=
 =?us-ascii?Q?DygP9o1c3Nyhc+P4TndBGZd8pp5WMfJgl76TVn367Ohhk7yBlbj1GqoycWRF?=
 =?us-ascii?Q?w3hrJquErghsNgPGeHSs2F6RhOnt7MOyiKzgcpPfj8AE3ujH/kf8w1QaXqvN?=
 =?us-ascii?Q?HBDl4M1mjFwDucKw7ymcQHeEq9l30YcdcYikoqzBqVWShfin/bst5mirkCkX?=
 =?us-ascii?Q?r0mdbqyTup7HNxJZPls/pySfOY4+C4Yej1+7goJzyx/rw6Ih0x6GCfs+dKDv?=
 =?us-ascii?Q?1LG0Mr5WBQxAm3ZHVnC8y8PWtgj6qOLCnP+DbzN9euoTscO5N5ac2/9edATd?=
 =?us-ascii?Q?nVV8dX8+eKhbYEJiEyV8CloFQrbmcasQhDRVVoxlgF6QaQjPr3FHJIWGmred?=
 =?us-ascii?Q?+p9zxVVGxPMlMioWV5dWEi3YpDZuDhZeNCZPEu6h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb230e5-3150-423a-76fd-08dd809e4017
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 06:32:12.4500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brz1KyCe31/zrgnftUrfzmHaBUBvsafsjztWso3iCKBewRo1PZPnSRW+7O4Q+6+KMymAttYjnQkiBtMPEXBiXEokmA3lEThAB+21Ty5ZHDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5500
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
> Sent: Monday, April 21, 2025 1:11 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Rosdi, Danish
> Ahmad <danish.ahmad.rosdi@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>
> Subject: [PATCH v1 1/5] arm: socfpga: agilex5: Add MMU mapping region
>=20
> From: Tingting Meng <tingting.meng@altera.com>
>=20
> MMU mapping regions were added for the second and third DDR memory
> banks.
>=20
> Signed-off-by: Tingting Meng <tingting.meng@altera.com>
> ---
>  arch/arm/mach-socfpga/mmu-arm64_s10.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm/mach-socfpga/mmu-arm64_s10.c b/arch/arm/mach-
> socfpga/mmu-arm64_s10.c
> index b8e40d9a788..1dc44ab4797 100644
> --- a/arch/arm/mach-socfpga/mmu-arm64_s10.c
> +++ b/arch/arm/mach-socfpga/mmu-arm64_s10.c
> @@ -57,6 +57,20 @@ static struct mm_region socfpga_agilex5_mem_map[]
> =3D {
>  		.size	=3D 0x80000000UL,
>  		.attrs	=3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>  				PTE_BLOCK_INNER_SHARE,
> +	}, {
> +		/* MEM 30GB */
> +		.virt	=3D 0x880000000UL,
> +		.phys	=3D 0x880000000UL,
> +		.size	=3D 0x780000000UL,
> +		.attrs	=3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +				PTE_BLOCK_INNER_SHARE,
> +	}, {
> +		/* MEM 480GB */
> +		.virt	=3D 0x8800000000UL,
> +		.phys	=3D 0x8800000000UL,
> +		.size	=3D 0x7800000000UL,
> +		.attrs	=3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +				PTE_BLOCK_INNER_SHARE,
>  	}, {
>  		/* List terminator */
>  	},
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

