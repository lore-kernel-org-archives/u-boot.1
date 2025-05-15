Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE1FC3ABC3
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 03:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FD5782AF6;
	Thu, 15 May 2025 05:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="B8i9kw+b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5327882B00; Thu, 15 May 2025 05:21:16 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2520382A9E
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 05:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kv2JdF3mRyiFxesAM/CtItOEJJxgQY8VJ7JNgsTqrhJgDtM5Tu77pxk94xvLU3XzVukl3ZEGN8ffTffuT1ZNrRdt92pktry1ItdPJqmbcL3xyjmUl0ldzwYfWzBk3KyhlwS/TvUQvVnSCrKMGFeZLb5Mr7btonNod4M8pxdgUyy7GHXS0SQzb0lBJgGj0y5e2IWoHYOVYz6OT5NFt20QKnMzRaIFJYtXvvvHMK+KUQB74xhHKLrhxVHPudOP7+YWuhfry6WsIhFTLiPd+EIx149L4KsqAi9a/E9xi4BYP7ehfevbfb3SbLNklwoYiSJfxtKxs0U9UGnN92AZu7j2yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peRATVcydjMy0Ls6RQn3jpjVeLgUVJkuFpssAGBt+fg=;
 b=E1m8Lo4RfrOGDg8wQJN4cORK9ySV375zFg/4IRMKJaKYV+e5tvuy4ww8l/31FzJVRgeByljE7tvMvamRui8Udp6+1RecrYlXqiBLAGhdhL7tCNFrtTLWK1J9P220ULu73M5TM7Ey5OJbYoEi9habfnSdobqUTM7yr0DRq9MYuwEfDfFLIG2i4qGcDHeBN9qwHG4OzL7a0UQb7sxkWumDbUlGggD/CyHKbW8IL8M4GFDuOL1w1S2NXS4xIRPV9HHFn/dKJQQyudYrgXJvyWXtN77PFvnqChNQ/YmuePx/LCP4I/xr9vwCZMHnHTlgassqqLcCQ385Mavr3xHBR3wSDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peRATVcydjMy0Ls6RQn3jpjVeLgUVJkuFpssAGBt+fg=;
 b=B8i9kw+byNeLzuCgrDBZuUePUuscDJOMBnRip3nPjN0YXzDEnLfvyins+ZqFHS2kl06/CWPwrLaw8cqI7Wa0hJbDxSZEQ7m27f8Q7TCSXXjKmCymrpRkVtIVVwQUdr3co9Z9S2NJvLERjPSzZLqE/2pKENNAJJQnetouNjnDx6x47nMN392D/tTfZ+0JjWt2r2OA+m7ARiw+kw3bJxTm2t8Oh36zfZqYbrzPgpvE+fnC0T4v4n+0xNJeQdA885ulLGzM9yE9b+7kFt8w4SuXKHmZATdN1S0qQmPaKSs6gZLe55VA/GzNPrX42QNburZox9chcvhS5tHveL2Zi4l12g==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH7PR03MB7509.namprd03.prod.outlook.com (2603:10b6:510:2f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Thu, 15 May
 2025 03:21:10 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 03:21:07 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 3/5] drivers: ddr: altera: arria10: Fix incorrect address
 for mpu1
Thread-Topic: [PATCH 3/5] drivers: ddr: altera: arria10: Fix incorrect address
 for mpu1
Thread-Index: AQHbvpEJYNi3Od1vQUO3pr7s0a6kr7PTE49Q
Date: Thu, 15 May 2025 03:21:06 +0000
Message-ID: <LV8PR03MB8137E8E5EB4CB73EAFD3E4CCA790A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250506141246.6672-1-nareshkumar.ravulapalli@altera.com>
 <20250506141246.6672-4-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250506141246.6672-4-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|PH7PR03MB7509:EE_
x-ms-office365-filtering-correlation-id: 8cbeb97c-893a-4363-8b5a-08dd935f8858
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?d6640PqaBRnDwR4AD2VsA1lYN0KeRsBraV4hqAIZhlVoCmehacfDE/u9k/6E?=
 =?us-ascii?Q?O1sOpHkFeOspW1ZSOMr1K6FV3ImvZFrUS05n0hz1OyB1Mlx+AdQuLb8xdwwH?=
 =?us-ascii?Q?139VOeLxoY+9HlVwIJ1f9oofN8t7+zYwx85ZlvB/bW1mTmaUxU5ohSNQTonZ?=
 =?us-ascii?Q?PvxVGNyavE1+ADWnv9qoPBW0uuE1TzqdqB63Jv/DiFJqrTARgQ8z7yj+k/ps?=
 =?us-ascii?Q?qjT4lugHQTSuWZ24E8gkYJyJI58g4VvCU7TkfgliwVsxAgl4Oy770cIUU1L8?=
 =?us-ascii?Q?Fi7wGS/ARRARXbEDB2JS6+0At5cBs/+9+6e7P4gctoQoxoIbC6rQt1DeVrYz?=
 =?us-ascii?Q?qFNH/hWKTR4CBiUdiKf0nrBY+q8Lr00WOycGX64roxYuLTHtejFE0987ZGI/?=
 =?us-ascii?Q?6kvA1KpgX/LNbeCydzHSDyfa6y1JAKPVvw5xQ2EXAhiaa699EI+vKqr0Q/XM?=
 =?us-ascii?Q?GtXuXlk3+VNU5Eo8FAcMDlKuBLeaBIjrnw+YRUFWPZhBvU5z83jO+ixemSMH?=
 =?us-ascii?Q?mfvp5goR/IcRv2JSh43CaYHdOT0OiJdaqLTqR48Xnb4m3Wo/pdjqvmAMVCkJ?=
 =?us-ascii?Q?ZJTzrQLKmSdn8TRFUwULcJWt4BxzHsvqbeLiBRIttiMhV0XWrigj7jQZwAl3?=
 =?us-ascii?Q?NgJZyMOwvJlQ77VTM258eJPM6r6IKw5ZMmK+LPyPs+jRgWBYVLLzP/pZAsqi?=
 =?us-ascii?Q?fL0yTQiyxek6E+qXklaj++VWYW86MAIs6RBQQznqhEXJaOVcjLJqAElUciKB?=
 =?us-ascii?Q?DrJLD7Zyjz0yVSE3XHJWdEAyiC1MjzAy8yOGEY6MoEJmg2u5X1gfVeb2qKLX?=
 =?us-ascii?Q?p/3nWman3PrtsOHUVqbwOubd6CcvqcoFy6c9KwV9rEf6l/cY+b8oe3anl20O?=
 =?us-ascii?Q?ZiOysapLUxheWwgN32n+O/45yU6Wap8eUSiSmCiBysdl+lTR86S0jQhmLJEs?=
 =?us-ascii?Q?gSn5KP8SeIeKx5lw+r8nOSYVsA+rFVYfus1R4BmhXTEECu1RCaenemeYUSNH?=
 =?us-ascii?Q?D45/ZQndqy3F806wr0P766tXWXEIYDSaQACY2FgCRND0d/CO8WPVzrEcdcQl?=
 =?us-ascii?Q?wVZkoslZgOR6MbmT9GVoYrmR/PtfCxBhKqGdbIlVVZ34f7nKVOUZ9y9g4Txq?=
 =?us-ascii?Q?bKWKf+S+RgM75pwfdyhwoMMyURBWwj/b9POD8iYFVQx0gYaPwl/dM+KM6UWw?=
 =?us-ascii?Q?lSQGZhBNQLy3lFJuFFdtFCT4k1JUHaolXtbVXBhiYjOLX1yc8LwX1+Nj9Gg+?=
 =?us-ascii?Q?CkCzpVi1N1+Z/CtQS881h63krSHRZc59SjZgegin3wdYtZdWKinPtbFNI/lL?=
 =?us-ascii?Q?dKYpVLWEqqOeWjB/CIVdcrvCrl091bbaL9ao28Af2PBX4MHnULT0g057V3Id?=
 =?us-ascii?Q?DWe2QlbC8/b6eoR5J2GJfTovtanO76+edEWBzAQIU8ui1tQHcmBpvTrNIC39?=
 =?us-ascii?Q?P2sXDH6latFmiz0L82Rkh9SwwSHyJjlHzLoQtBizQJC1LPypiUO6BV7npsuA?=
 =?us-ascii?Q?JryLLgBlEntbOCI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cR10RE4f3hb/9bkZfIXlyUBUNCDZ6V6TshIay4hSTDZbndpWKR3JgEgtNKvj?=
 =?us-ascii?Q?YjeruvpVAbBDnPb03b2/qWwlQnDJ6rx9TCIcZp/Td8/6a6QCVI6VDAc4tu7b?=
 =?us-ascii?Q?xCMiKKJ+wQLK0rEK5vA5yctO80FjKSGyOponFcswi3rfWcUTSd2s1/fxQUvu?=
 =?us-ascii?Q?JLq2q9pHFFZxu4dHjpjPe2/s7OpjAuwP9g1aaL0jxfDhdP2J2xbFAGQRczH8?=
 =?us-ascii?Q?yKidBq/hgVE0eMP+1G61zbRURcSE7KeM4Qe74ff0AKgcOywHn8BLhr0WS+2N?=
 =?us-ascii?Q?tgd6TlY7zu7GHoxz577QKnA8qJhdPSZS/AKbTb9CwozhFlaWzmB4pHex7JWC?=
 =?us-ascii?Q?AdU4bb0leXkwfngOAVay//k1MHd7jkjk5N3yM1qmezVuyt4zAc9fLgJMIAmW?=
 =?us-ascii?Q?YVzMk5TE0Pad/TVoe6XQukQtubjWkhw52AGCkGSMuS+DxQb3NcIr3+aUfJn4?=
 =?us-ascii?Q?k3reydMCfZaDL1P0kJOaAgCm3hSD7ugGy6dWGTlWa5rUYyPcDP7YWFTR66s2?=
 =?us-ascii?Q?0lQYfx2Dbu7z81akSZRKyhjC9CzuIFhdMjnfoQAqGj0gNkXZTBHEJSgLobkm?=
 =?us-ascii?Q?pc53y+VHZ6HeW1VlopQBnpYyHP8wLlBJmVHllDd1vYdBhBxpT3TM5fhRsxcu?=
 =?us-ascii?Q?rXDhirtoOx/55pNqLiQojDKHP7szP17hJE8u0s8kX2WnBfmKuntMj1yreq/e?=
 =?us-ascii?Q?WOtc5oQu1zlVEi8cBxR7REJOCFZF+adQEJ/aC5CYSGQ/2GvQTPzN1j7BTW06?=
 =?us-ascii?Q?gMwT7MQVHP1aw6Xi5rfqFDoMJXLKh34vkEpZVRAXp1xyhVNfcOi+WcaG4n67?=
 =?us-ascii?Q?+P3VZ/xdLnXXMh+LXZd6zZjm1aMF1wL23wMcwO/Wu25k+uQblDhhlc/R+J5U?=
 =?us-ascii?Q?gF6w9Xw+sj1VJ3i5JBeil4hbvDbmZrwgONj9EU9/LiGRmtscBu88gOhk8hnu?=
 =?us-ascii?Q?DAzgDqISJaskc8mQK9Qltkewuf31vTT/4hRY8KSvOmvbLvU1zeaqNmqel2wb?=
 =?us-ascii?Q?X+DG/TQE/qf4TjZFwQtvXu8jgKNjzPr4l7Yej1DRWHt6zRKzesx+MPgqwdQG?=
 =?us-ascii?Q?t1N1n8Bt1aH2xOI2uF0nb564XHDs99HwfUS5ih5gYF+WkAVGvr/JkluwRP0a?=
 =?us-ascii?Q?I9T6Ltzm/eM7ACWzaYxC4Sl9d/6VvfqQgiF0tfgRk7aTr+7Gd3lbyXHgvip8?=
 =?us-ascii?Q?4xpgi53oGr6f/cjeraEOeAfyVSY410n3AbK+15tm8OVABhYPalmv/691n3kx?=
 =?us-ascii?Q?jZz88f4OY3+sYiKtU3yHQNDgXyX/FWNSbyfWvX5tUXTvjZL2HRNtZq9ekK5a?=
 =?us-ascii?Q?INpx5ATUNFHrPndCTF7MZ63bRHDmrrH1m3246h6yd7hxqpTcNeHyO1pDb/yt?=
 =?us-ascii?Q?Bj8YSUXYsPCcS+m2K7/Q+brHNbxMRwRlNR+o/gpYPhBVmyO0OlSubxnEWQrZ?=
 =?us-ascii?Q?hPulYVhPP+RiNqxvQf7OCj9f/X1OqlBJBUFmvUEB/nCa2obpchAajE6qwcyw?=
 =?us-ascii?Q?zW5+HAesh8uTXOhdJskxhLHowjhSDZryLOzQzUolAYpIKPrd7mU8n6XgH6xw?=
 =?us-ascii?Q?P+Bt3Mg77Mtfh5ohC9rBXmo0dAwqmYsqxaOtwEu2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbeb97c-893a-4363-8b5a-08dd935f8858
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 03:21:07.0173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UDaQ3l6ldNs2PmA7puoyc2FXvWySyLoelvaD0YERcSUj6KP4MM56hiLiuvwrMxed3UD6G4OHnmrSQg2ec8t1m9n0MqaJg0WfKHQVS05FPn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7509
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
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Tuesday, May 6, 2025 10:13 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Tom Rini <trini@konsulko.com>; Ravulapalli, Naresh Kumar
> <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH 3/5] drivers: ddr: altera: arria10: Fix incorrect address=
 for
> mpu1
>=20
> SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS is added in
> SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET() macro already.
> Remove extra SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS in mpu1
> address computation.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/ddr/altera/sdram_arria10.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/ddr/altera/sdram_arria10.c
> b/drivers/ddr/altera/sdram_arria10.c
> index 4a82af0b711..d8ad94f31cd 100644
> --- a/drivers/ddr/altera/sdram_arria10.c
> +++ b/drivers/ddr/altera/sdram_arria10.c
> @@ -477,7 +477,6 @@ const struct firewall_entry firewall_table[] =3D {
>  	},
>  	{
>  		"mpu1",
> -		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS +
>=20
> 	SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET(mpuregio
> n1addr),
>=20
> 	SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET(enable),
>  		ALT_NOC_FW_DDR_SCR_EN_MPUREG1EN_SET_MSK
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

