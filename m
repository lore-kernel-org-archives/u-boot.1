Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52117CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84C6A802C1;
	Tue, 19 Aug 2025 06:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NGwy36Lv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0FD280422; Tue, 19 Aug 2025 06:12:00 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF31D8006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0OMg5nmD8marPAzYpmHTyhR4qX/lgN0bjIl1Tj7EBa300sNwwtVekaHp3jSKPe7RcdvCYMKb7ofoMgp58AxhJg5azXD7Vgod8DeXVY1zgjV0yRQmnFeKycJpJ3NdPPtegIQ42rz/8x8jrBReDMRZofoiD7a4EVia7mfaXRYSbBpXpvcPybcunc8cU5qfX3/EmI196E22/9miuFwOraRwMWHNDw0ztifNqehrAQDAsPPWJn4oksziuv4Dvy40U0eqgfnkkuFCv5IctmxbbH5D0TwC0LEBanaPzu3CCX89LyiJqypoW0ExUK1+HJxx7bdhmTASCjjhYrGwKLHbWj/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewcKEkfR5fV3pZmmXFERRQep5xIxqTLZSofjlTGr6Pg=;
 b=VPfgnd/DGF4TFHsjoKjvxDY/bRmKtWuuoA3wokXVwwuBOL488gbU5BVRHbDYdCrnQ/DGM+ttsdCRiCLVOGoND+3F9a7vkWfyHYrBWqVi5/lf2XtwvKFp+f/INbxZczXK/OH6SFbGpkuP0a/mdR/HlVXV/8CaqkCoH0yJtaNLgE+YUQaAIlZNiVEVXnJucXai5ZjFHqW4eaa0rb/C+RF/7GB1i7rwRvCT3e10Jqwwp4m1KyTKZlnNufFIK18eYLhWkmxBgMS4qHjy4mcKzhnIvkCtxP0MOMPqkmXdfLzUCAqHyE7UyCB73nwodYO2RUwIPHR+OHcaAAOH0zADJvC8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewcKEkfR5fV3pZmmXFERRQep5xIxqTLZSofjlTGr6Pg=;
 b=NGwy36Lv7d5elLEc8nHDM5Rh7VrKLMCBz0YoSAIfjkEhHvZhnLv90GnTsBgZvcwfVUD5WWw6VCGksfuORG4NP66Aj7h/a+0QdOsLCPkKEMeEsTC6XHu0xgxpUvYgEu5P3G5jspgCT3LxdDIVw4GZ4Uwp+klBSIyyklCEcoT+XlhKvVXMypY2OmE/MrDjlj3xhuvAQN3SCbhFO920qbjwiDWgh3aBf91Iun72xSmzLYUNDYgwI4tLRmX09H7dgFsgDTWGdVgEi108lpTbCYC2IuvnhJbKxNr7RYLnvqAsuxUdlpTshFuiLyk6g6bfrFNxLn7hZvVNSzSr04qwi+edSA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH7PR03MB7243.namprd03.prod.outlook.com (2603:10b6:510:24a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 04:11:55 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:11:55 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] drivers: ddr: altera: Correct DDR calibration status check
Thread-Topic: [PATCH] drivers: ddr: altera: Correct DDR calibration status
 check
Thread-Index: AQHcCEjOe+ngntUN10GrgIF6M4gYcLRpbilg
Date: Tue, 19 Aug 2025 04:11:55 +0000
Message-ID: <LV8PR03MB813772685AFC47DC359515B8A730A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250808094242.26221-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250808094242.26221-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|PH7PR03MB7243:EE_
x-ms-office365-filtering-correlation-id: b6bb615b-e411-4809-8d81-08ddded688d8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KuRFa3cCwbM1ejVLlCJRfIc9olrOkbILJdF6ojRlu8TUDQaH1tMqIQGXsc2E?=
 =?us-ascii?Q?+niL4GYALOB1Dwih+9MnSVAdUSF4tmBatPyli4d666YhCwCnmquXmOiWl9iv?=
 =?us-ascii?Q?XPTAKmajI+U2nE9br4dPL1iLIa19ezuRZEEed2ZQoBruPf2SfJWa9U2lfb6N?=
 =?us-ascii?Q?4sm3jcCBiVlMPCEZlGoLrfKUgiRBVJuUZ1V3uJZUEKwQzl0O/cexAFlHoDLx?=
 =?us-ascii?Q?KKOEFyd9leWNdFRLqEiEG/K47BPxGTOapf82FVOJn9RHN9xPsm1nU8Sgu2/i?=
 =?us-ascii?Q?/xGFURx8GhuTvxCcRCLebHxuF1M+wzY6xBRw5qkISzOiyegouIsasfaDZ/Vw?=
 =?us-ascii?Q?fpvjHFNvzOoYml8n6Jo5YVo3jbm/YcKe0Rs4uMgtAe2J+bKlydczYw6s5P/2?=
 =?us-ascii?Q?APJnQMO1DaouBhXGO5gJ90JEmBjbLsO82hcBU1ExVaAiSW30wUdKQUQs2Xtr?=
 =?us-ascii?Q?2pLinYewmrdllfarkhHeQdWiPKrRCATPUNXgIBzBzfVld+GPtgZQLr8QAsoT?=
 =?us-ascii?Q?zbICbqMo+TlQAYqx2JzEFDeYUbOBmeAgSHSojV6PcS8arUVcqkGeMc6A/M5n?=
 =?us-ascii?Q?yqY0CyK+Q0Xpsa53+ZqszyNNtzZXE1oJd+G9aZp6xdmBGfWlyQBbvw9Yv6AD?=
 =?us-ascii?Q?xg6y+1PnPgbyC/Yepd7Q5aHTS0UbBXVINbuax5oJOdabRDTocW2caKH1iQhD?=
 =?us-ascii?Q?Wh3EU7lX7V6gvIVRXZAichEBGCs5GyxDZ+W0d1heD8fMXfMbNFaf3camUs1y?=
 =?us-ascii?Q?yi6lY1Q/ZyodiX+GNtr5HIbkJGg8OK2dAwEELEaXAzBX7Jms8qayPKrDLCLe?=
 =?us-ascii?Q?GhIYi5pHSkeL4CQrqbitXT3Vn71aTM1wbJ2QlX+yKdnBumFBmgKlEkBcth8X?=
 =?us-ascii?Q?bApeTDmUBe4GNNum7ZrDjLE3PdmJYSzld9mbrxHyMmEvFnrVQVIf0CMeNRYr?=
 =?us-ascii?Q?oePZrBNrT8kk2DyVLSMP064M1KkRv4jG3juGCGMBELOBj+E48SZI7l+ChOvD?=
 =?us-ascii?Q?eQsmYeefN8f8JDOkPEZblsyJAE4hq87B2H8mlhqc11fUMMMvmSnz8y4z1Yd+?=
 =?us-ascii?Q?RFYlcrzSeS+9OaEZs6qF7KSjLgfnYicfZzx0KB/cyk6pQZQYUJ7Li6kJBOAz?=
 =?us-ascii?Q?8wkaAVu+3occ1pwSlgr4Z6TlWXWo7zMZoiw8SxvG4P6OsF16+cEUOmmM46Zd?=
 =?us-ascii?Q?R/sNi1UFoIUvabB243xUrKQ4/8o1nuuYRKaffJ/ptbGnN060pdFA9fAx+oTt?=
 =?us-ascii?Q?RhYtuac9So0sqPoVnKHoy4ujUrsSKi3ya+IcdD2yY6CVHUcrWmOUyUPneJIJ?=
 =?us-ascii?Q?wx8BHLh7knzbmogEMTSOVZ8O/5rdSuBa9ZqqAVZCWSYcy5ytrnlcqSwLYGpp?=
 =?us-ascii?Q?8fZZujmIaKolQzAHl8JqxKAJTyoAmtPWdC5KcgevDWQhRtSgQAqkAijxXueB?=
 =?us-ascii?Q?COdm17HgAi8c33mwOgOmX4IoI5K06onnD/zPuios5VIS0ZmOEj5PYKUZh7wO?=
 =?us-ascii?Q?qWiWNltOixZ+L7s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jksPxLViuH0PnZ1s/x1c6W270ADwwb+7HJNoXmQy40uyK8oEXoTj+lkXpQyu?=
 =?us-ascii?Q?7cTIgIfz1MhxbH0KkESp+jj4zu1v600ITM85qU2m1++FIB07hMp1kJnyvsz1?=
 =?us-ascii?Q?C2wbyBSVkWRsp9ZsF9+MpRvRwE5MZ29lWFBfQ0QzkZ/92po+Irn5XQOk/9Ij?=
 =?us-ascii?Q?wxvZ1UYJ0s7LYPCIkHo3LEVwS3CUrtAgg0WXDXcLwGAU/ZSgwZIMIWlMuh5v?=
 =?us-ascii?Q?V394LbkVs8fqEfdlJW2L3W3mjiyjjg00UFa7BGMI0w8GKIkB0XqrXv/m60DV?=
 =?us-ascii?Q?USoOTFb4FvPvnCLUWWLNM/totgVec+yPFuF2UMcMj1F9qCZIq0CXjadSd1my?=
 =?us-ascii?Q?vzdRtrD4QCa6Yvj98NUKBSrxSfJY56bF6wsKiZF6CZkYTZxPZh1r4OWlPI1/?=
 =?us-ascii?Q?oOkiv99tvAMK0+vTS4zYFplCBE06CbUzwcL3Uc/BlEXh+yyG2buIGc3LV6ul?=
 =?us-ascii?Q?3KSHLnRt9mqvqTK9km5S9wLeGJLI46qb0SE07G48zitbUezGrgEaNxD4Fl9a?=
 =?us-ascii?Q?aImrpoBSbfpTKXtZM9rfT/VrwiCsovofQDt/7pfHMDaMkxK2F28rYblhMP+k?=
 =?us-ascii?Q?Y76yk6qFYuwPhJEJtoS+5OCi7SksBEERGVIdkgXJeQ+tXEEJF0V90ADtEbVv?=
 =?us-ascii?Q?vGGwb8Iu+RfqerqfOqF3VgvZHt0B7NPFh7FYqwPmbn5X1F9Lu4onCoSTh6d7?=
 =?us-ascii?Q?EOarnVLmyyI/66l3iT1MLuPm+ovbfcsYmBDDv2F1qh6lM0gnii78mBkwayi/?=
 =?us-ascii?Q?Rw3jE5gINB/R4zzDC//YUoOSIaVuGocpcKHdx1puZ1zhDztwen4shRKY3VdW?=
 =?us-ascii?Q?Zp45qqtpRUceIwPQByZ55tf5NMFEWcxCKy0aXnPafia0xNhUvoKlvbPR4LC6?=
 =?us-ascii?Q?J+6rKU5zdEQg9G46+zlyFNplVXp3lmLHe4cQLXFt4gp7fB+kxJMX8pmCSu/w?=
 =?us-ascii?Q?cquj0uQHxkdDQMeLLp5ycVnXxNFHvSwSkWhvyyPC32V0qd7Ci7C70njgC+iw?=
 =?us-ascii?Q?jjbdRhSVLmQpWiYtc6Ep0s5CeTO5aFIDnJwJfKnGMRxHjAl1nwHjhGtHLC8d?=
 =?us-ascii?Q?YfarLROWUFnnyB8wS6PeDNZFke0EbBI6a7Sg4n5GrZJfytRgtvW2Bv4rS3zf?=
 =?us-ascii?Q?8W0EEZ7b2Ov1X3g4MRFt3mmAMbk++rtT3JMZZDXZMTLmbzkUsHadoxi2AyIy?=
 =?us-ascii?Q?2B8rFpUG0Z5MoLAHBqETfJoILaYavOYnGVgZx6gjP2hl5LEMTSYxkbqkUu6s?=
 =?us-ascii?Q?M3Hv2zGyUjsWPh3r3Y6axBd+YbcvkeQPa/kb9rHKqJm5Rrs23TlkQ1kMnqwe?=
 =?us-ascii?Q?CHPMLw2omII0ohgdpiSD+ODNtMr3AViLXihaq+Wy+PC1cli5JMtumpGCt94/?=
 =?us-ascii?Q?KaZ0SNygjSNbTTmaOzpqpFXBmweMjoqQzdFLka3P+eIvM9/zaIFO6JWhp9hq?=
 =?us-ascii?Q?Lr4B3SGopNrUfJGhIqwPg9Lyms6+gO4Ukcwzwz0HpQMjabslsD8hWMsVsTLd?=
 =?us-ascii?Q?i5kWMJ1ptnaPF8mw4HHzvvIZ81t0KqSj7BQYRZAZt5HUKBpiOPF0abNWxmK6?=
 =?us-ascii?Q?RAataMakIyDLAgHK2IagIQc21tyrAtXerRzXYY8f?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bb615b-e411-4809-8d81-08ddded688d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 04:11:55.6237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IzB4W26Jpgalcaei0u1rUvqJYV9FUTbQEd5WEOHbXFSJ4vCLYYQkgrPiJq/rsI21/P63KTF+/hNHSPT3poVEGmgYK/fEeAC5Z6Yug3SgdMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7243
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
> Sent: Friday, August 8, 2025 5:43 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] drivers: ddr: altera: Correct DDR calibration status che=
ck
>=20
> Bit 3 of the seq2core register is no longer set to indicate calibration
> completion. Instead, added polling of the seq2core register until it read=
s
> 0b00000111, signaling that the Nios processor has started the calibration
> process.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/ddr/altera/sdram_soc64.c | 6 +++---
> drivers/ddr/altera/sdram_soc64.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/ddr/altera/sdram_soc64.c
> b/drivers/ddr/altera/sdram_soc64.c
> index 27fbe80ed41..4ce129f5e2b 100644
> --- a/drivers/ddr/altera/sdram_soc64.c
> +++ b/drivers/ddr/altera/sdram_soc64.c
> @@ -82,11 +82,11 @@ int emif_reset(struct altera_sdram_plat *plat)
>  	debug("DDR: Triggerring emif reset\n");
>  	hmc_ecc_writel(plat, DDR_HMC_CORE2SEQ_INT_REQ,
> RSTHANDSHAKECTRL);
>=20
> -	/* if seq2core[3] =3D 0, we are good */
> +	/* if seq2core[2:0] =3D 0b0000_0111, we are good */
>  	ret =3D wait_for_bit_le32((const void *)(plat->hmc +
>  				 RSTHANDSHAKESTAT),
> -				 DDR_HMC_SEQ2CORE_INT_RESP_MASK,
> -				 false, 1000, false);
> +
> DDR_HMC_SEQ2CORE_INT_REQ_ACK_MASK,
> +				 true, 1000, false);
>  	if (ret) {
>  		printf("DDR: failed to get ack from EMIF\n");
>  		return ret;
> diff --git a/drivers/ddr/altera/sdram_soc64.h
> b/drivers/ddr/altera/sdram_soc64.h
> index 183b1a33080..2ed31b99b29 100644
> --- a/drivers/ddr/altera/sdram_soc64.h
> +++ b/drivers/ddr/altera/sdram_soc64.h
> @@ -64,7 +64,7 @@ struct altera_sdram_plat {
>  #define DDR_HMC_INTMODE_INTMODE_SET_MSK		BIT(0)
>  #define DDR_HMC_RSTHANDSHAKE_MASK		0x0000000f
>  #define DDR_HMC_CORE2SEQ_INT_REQ		0xF
> -#define DDR_HMC_SEQ2CORE_INT_RESP_MASK		BIT(3)
> +#define DDR_HMC_SEQ2CORE_INT_REQ_ACK_MASK	GENMASK(2,
> 0)
>  #define DDR_HMC_HPSINTFCSEL_ENABLE_MASK		0x001f1f1f
>=20
>  #define	DDR_HMC_ERRINTEN_INTMASK
> 	\
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

