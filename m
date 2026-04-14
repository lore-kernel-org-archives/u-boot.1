Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32FCF531F1
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 07:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C92E84129;
	Tue, 14 Apr 2026 09:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tQXWUIt9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B523F84132; Tue, 14 Apr 2026 09:17:27 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 971DB838BB
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 09:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YM9GxhOTFABl+YY8O+PbNcg6dQwZ7NEac4DmCkhRzUuzjV8cRinY4sSWQxYoRiO0U2g9LJf7huSPLvKT3lIP6HgjCnQc4sADl1UrkGgpHSr2Mpk/0M65RSzqXk9Tj46QCbXvBwfLYnFKuWBhG89oz87WFLQt7l594M2OcMtbDzXmWewvJ8ryHh6kKvU5lG54dTMcFGi/puVrQFPDt1T/FP+yD8eL8Lu5sM4hFScqEmsEH7xS1XVwZmS5Lqv1Qyj7RnuKAwzHvvkMSCg0tcJIHom0vyk84US2I72Y2kWd5aRjQdwRn4F0It06eou1aCotcsUsRb4eWTNP6lxJ26O0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bu5c3NLgBVYea4H2Xzw316JYkffdII7ctZeCeRyCLr0=;
 b=s91qLkjeCeYak0s7Y6Cbxf+6+W8UuPurvtgZyC58pRfVX54weyqyVJBBp0XpCmHkf1XT6kxvBFNXHOdv7BVkwfe04MoPoOSYoRIYzsGURqPEYrYDbeLSD/d7Aj0cJpZg431Ub3dSKHys/wzES8Z8xseonFRzLyqmY1zr3VLOIK6+S8KrcAUakibeLFXuzBhE9kCvAS4RKYOnD7P6bTD0b7ueqd5If/RQNLXwiSaMUWDwR22+xV0N/3wvCHWkBFyHOISVy77m1seIrmpv9xUZvnInK2VL+5YlmsZY47yOSeeEcplT1LIJN3mt3H9l6v/MIT+GG6PhrVhOQ7kRaXR56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bu5c3NLgBVYea4H2Xzw316JYkffdII7ctZeCeRyCLr0=;
 b=tQXWUIt9ye6NWns4s/pVhjcMuvq4cxT/j39wNegRxz7hG2Wps3PP+3+F6xvRwJSzXAQuupGTaFHN4nwUnTNmu3kBPpQROLFMtuv0mBBTGgBaExRn1GtdQ3XtnUrwUo7G9UM8g7/Q4tw9NNrimG1RQkWy8EvR/7WhRHwgJJH2fe0xmf/Bzv8Hs/7rhefucuHSZZ7oFYENuxkJO0yTSFyEgKsjRnuIjlmMUIuNaCgOWi8wCOxe/7IeFsYzz1jbXzB6g01xzhT+BN67zKZlR/Y9wOiuwRAbpegzDOcL+02xgHewdLpIpi4hppFCjE0JDmu579OPC8rcTxgC+OfDCCAnjA==
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SJ0PR03MB6676.namprd03.prod.outlook.com (2603:10b6:a03:389::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 07:17:22 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 07:17:22 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "NG, BOON KHAI" <boon.khai.ng@altera.com>, U-boot Openlist
 <u-boot@lists.denx.de>
CC: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>, "Rao, Mahesh"
 <mahesh.rao@altera.com>, Marek Vasut <marex@denx.de>, Naresh Kumar
 Ravulapalli <nareshkumar.ravulapalli@altera.com>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, "MANIYAM,
 DINESH" <dinesh.maniyam@altera.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, "LOK, CHEN HUEI"
 <chen.huei.lok@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] arch: arm: socfpga: Fix data cache flush issue
Thread-Topic: [PATCH v1] arch: arm: socfpga: Fix data cache flush issue
Thread-Index: AQHcpjSFklm/vwpUnESX61UojuZGkrXecOHy
Date: Tue, 14 Apr 2026 07:17:22 +0000
Message-ID: <CY1PR03MB8121641FFBFF4F3F08FCE22AA7252@CY1PR03MB8121.namprd03.prod.outlook.com>
References: <20260225085530.18706-1-boon.khai.ng@altera.com>
In-Reply-To: <20260225085530.18706-1-boon.khai.ng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR03MB8121:EE_|SJ0PR03MB6676:EE_
x-ms-office365-filtering-correlation-id: 251ba8f7-723f-4d9c-c9ab-08de99f5df26
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|55112099003|38070700021;
x-microsoft-antispam-message-info: PLYe+z2hffz8GXQAS9XGNCNIYhNL/71SOX6KYP604XtrRmfXiCn6ftmOU1rSO7Tncjo8ojOQIT6w+YccilzLegzColKdAwPjz53U0u/mRFg5XGA1kDzwqOEzDsKIpLnVc6wwEOTodY9vcLvRM4zbyUAyO7dGG/ciH58zRNSzuTCpwM9AncyUyBBid0E3kUPaVqtHy3FJ0fTauwiyF/VhZUZsbOzxA6x1R33+/sLVjUoqPbmcyVbv+Im+ZDwR7k+LVzX6rrbWBYYshOldZ9GxbixuHgkKjs+luF78c5hD025/c5jHwdWP72/ZKK7YJewcyUiRh/AWjoi1eezURxd75cOv+923cn+LLnUUcJ1nG8BO9YVFYZk2ZHFjXR/Vl2Z6fbO0F4aN8IT+rZh5FiWFeWlKTGgS+z8lUoLwJWC5Rp3quwSWsKBOO9rmhKXOOC6zBJwi5wGUXMb93r80ldwu+Qyo39f0hzpW5xfm2R7r2lLOCGYJmuoTzB2DB2z6WskQpva9BABrnGSvxV0joCq3QhZm1LGhU94ihgaczT9olFlGVddvy6JdT/wyP59gB4BXJ3MqiCOol7HddC6V/Ck0AoM2LzxpTsy95A3KxicsNccCXMRjce3qqaRQk7XrTd+dBiqnzIs1nR/WX2UDXNf4yil4Kesx9srbBSjBAWpfp0NNhkyZobkTwBgGbYOSvr+Mn58RZ8Svxpdowcq7lVihypUa7E+YtaGPl+uMAKbh6YueNubClHsEWtp/E85AQOWMi1asotZBhGNWucUlQpAsSy5Tyr+f7wrWMc9d4RFHz70=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(55112099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rf2GqJFHSz/SwfKG4wO8Kmh1LIYRD1dPGaBUe1GjDhhPHSGyU1B32nsRfp?=
 =?iso-8859-1?Q?GJ8mTnuww/KHgFU+UiR8q/Mm+6yzksE1/X7Rs1ehDZWrpkxrfnDxLZ4ZXl?=
 =?iso-8859-1?Q?VLhwcCrw4ba6c/OULnWrTP8mJR869zVe1TPxXV+WHkMUxguMpeJnbf/Ab/?=
 =?iso-8859-1?Q?29Akhu0sS3NEOc5qfJumM33o2dn4YndY4XOcTHBR7l9ZfVZygF3XrRb+RH?=
 =?iso-8859-1?Q?qzVZUOD2x0SMpsQpc4mf1jXCMy4c2dAYxSvoVMQf5+3q4bf5/Mpl66xmUu?=
 =?iso-8859-1?Q?4O84Ql7KNaEm3b4UTm+BE31SBSe0oV9ARrYY8+axsr6akWBYHt2ta7MxAL?=
 =?iso-8859-1?Q?Dj9qljM9CezKB7+VNENnVkr3H9krDPqFTwqPR1geEBBglasRORq8090Xx2?=
 =?iso-8859-1?Q?NCOHHpOfLQGTLKDTiPSXzIRl83rMSO5731n3zIuBzE4bqKP0laLVgytPza?=
 =?iso-8859-1?Q?Qn5TIotpvS5ptdeDzqS8fBXMO1CL6J3ZlxQn7zwKMQYghzVrZjubVJIT/O?=
 =?iso-8859-1?Q?vt/lhRvSNiH67CKFJlr0h/Kt6FG/nPyBf7Jgksy9BFR0w/bWqaAUAnFauA?=
 =?iso-8859-1?Q?kc/AP86HZi4Lora7GlVzs8ysfBBO6kQLtJzfw46i9CyOkVeqkrDdEG22Mg?=
 =?iso-8859-1?Q?kfpi7DiRbd6GhPh9a7i2WVvO1q3DIVlqf7IK4ZuuKJPg7lndHF64FVDY/K?=
 =?iso-8859-1?Q?+5IfHpqqGPSi/WTq4465a1GP7n/98yGZ7nn+whU/fu7HxTY9evlhELOG2M?=
 =?iso-8859-1?Q?Xg91CytVnhFBuxRqF8fsom4KUrbzeIxo/RQf+Xfj5+MNXLI6VY9wP17kxf?=
 =?iso-8859-1?Q?f/VhBSmQ17rLiNOUz6JNu+JPt7K5HN+uXSwO5hSyBWvFwQf44zmxyz91Ef?=
 =?iso-8859-1?Q?tVcN/Plptub/1/BEyVItJBPJbxfZbPYjsjmY4Oc5hsAiBKaXZ9bJpb5C3M?=
 =?iso-8859-1?Q?G1ePYi8ZCGXmgT0dTj8nOh8eOvrYpK1vS/hdc3L92F3iz+YXHPw8+b5iMm?=
 =?iso-8859-1?Q?yf541LIzYJx6+3KtPZzo3ULkkTVdU8CCD+K9NdfD2+xhUMBG8lcWcbp9vK?=
 =?iso-8859-1?Q?InpscpzKNp11LOy3/YYST9ldM7YstCxcxddVuCkJy2lBdvqfD5pnHcBz/S?=
 =?iso-8859-1?Q?TNOi3HxfbeEcSvlTY8/hI0I2E6lPK4S+Pk6CF5IJvLE/SAxirbgRHVneAP?=
 =?iso-8859-1?Q?BTfaBL+cyjOa1XyEvHbPnoIQ+aujDxUKpEHL12Hdk0OIIf5SN5cAtuBf8U?=
 =?iso-8859-1?Q?Ww0qQvZn+BFFAJ5LIaVJi6cyfyddOKmuabzUB53H5DEAJqUMDEcm5X2y8X?=
 =?iso-8859-1?Q?NZ4m4XlvAcoBJiql49+writB1MwDJZ+/RljIwNBISQPiRY/aSJ8DE5GMS/?=
 =?iso-8859-1?Q?T5vkkLNzrS+U8cCHrreAHDpmBVaDcbQEY8r7HOHovuAPuWo/PSlRhD+Qm8?=
 =?iso-8859-1?Q?oJIWC9n/+18XgOhE1gBKUrTBS3acxMPDZSqnFfBzYd/zT5sfwOwoi9RgDn?=
 =?iso-8859-1?Q?5IMyK5makXQ4zEIx78raBuQ57Fv+QygjN1xFrvkxC3kWQvs8w0eQOY62h+?=
 =?iso-8859-1?Q?ZNB0Y9GB9JsIKEmuDQbKGAQF5LLAXb/Mr2nrDHTE34A/jBlT4Eru7XSck0?=
 =?iso-8859-1?Q?IzmCrfMiUTCyZyUgZJA5CFX7hAdxf6stdybZ2yCORYrBru3JSzmpRPayiu?=
 =?iso-8859-1?Q?QoqMdVIBSRZwOjjRFpnsDDu10/AwfiPJgseyZ5q35+UF35t7ynIzgriig1?=
 =?iso-8859-1?Q?mnZOeowfQW+KOYOrVprxvBfVY6xC+L506GIihlbN4KRgMxMZFDcYOVhOHo?=
 =?iso-8859-1?Q?uXkPQ22mIw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251ba8f7-723f-4d9c-c9ab-08de99f5df26
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 07:17:22.2960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHOBDNnA4qg3OC9gDpHAZoi4rsCRLUY6cVeY5/TjwKcQMxn++WWF6Q/OpEtrYg0DcaDG+7Nvw3v9VpIphtj3SwwRMXMLjxarR+whq68KFwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6676
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

> From:=A0Ng, Boon Khai <boon.khai.ng@altera.com>=0A=
> Sent:=A0Wednesday, February 25, 2026 4:55 PM=0A=
> To:=A0U-boot Openlist <u-boot@lists.denx.de>=0A=
> Cc:=A0Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>; Ng, Boon Kha=
i=0A=
> <boon.khai.ng@altera.com>; Rao, Mahesh <mahesh.rao@altera.com>; Marek Vas=
ut=0A=
> <marex@denx.de>; Naresh Kumar Ravulapalli=0A=
> <nareshkumar.ravulapalli@altera.com>; Simon Goldschmidt=0A=
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong=0A=
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Maniyam, Dine=
sh=0A=
> <dinesh.maniyam@altera.com>; Yuslaimi, Alif Zakuan=0A=
> <alif.zakuan.yuslaimi@altera.com>; Lok, Chen Huei <chen.huei.lok@altera.c=
om>;=0A=
> Hea, Kok Kiang <kok.kiang.hea@altera.com>=0A=
> Subject:=A0[PATCH v1] arch: arm: socfpga: Fix data cache flush issue=0A=
> From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>=0A=
> During flushing of data cache operation, the stop address=0A=
> was modified incorrectly. This led to Linux certificate=0A=
> authentication failure during VAB flow. So, addressing=0A=
> this cache issue with this patch.=0A=
> Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.c=
om>=0A=
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>=0A=
> ---=0A=
> =A0arch/arm/mach-socfpga/smc_api.c | 4 ++--=0A=
> =A01 file changed, 2 insertions(+), 2 deletions(-)=0A=
> diff --git a/arch/arm/mach-socfpga/smc_api.c b/arch/arm/mach-socfpga/smc_=
api.c=0A=
> index a531030f5be..87834e59206 100644=0A=
> --- a/arch/arm/mach-socfpga/smc_api.c=0A=
> +++ b/arch/arm/mach-socfpga/smc_api.c=0A=
> @@ -44,11 +44,11 @@ int smc_send_mailbox(u32 cmd, u32 len, u32 *arg, u8=
=0A=
> urgent, u32 *resp_buf_len,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 args[4] =3D (u64)resp_buf;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (arg && len > 0)=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 flush_dcache_range((uintptr_t=
)arg, (uintptr_t)arg + len);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 flush_dcache_range((uintptr_t=
)arg, (uintptr_t)(arg + len));=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 if (resp_buf && resp_buf_len && *resp_buf_len > =
0) {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 args[5] =3D *resp_buf_le=
n;=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 flush_dcache_range((uintptr_t=
)resp_buf, (uintptr_t)resp_buf +=0A=
> *resp_buf_len);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 flush_dcache_range((uintptr_t=
)resp_buf, (uintptr_t)(resp_buf +=0A=
> *resp_buf_len));=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 args[5] =3D 0;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> --=0A=
> 2.43.7=0A=
=0A=
Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>=0A=
=0A=
Best regards,=0A=
Tien Fong=
