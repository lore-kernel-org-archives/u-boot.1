Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A98CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:05:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D087838AB;
	Fri, 26 Sep 2025 18:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AZgaqp/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBDE98144A; Fri, 26 Sep 2025 07:53:19 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A98608206E
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 07:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6SLRfzSqks1T37AlVMm1QIN0zQ5wlNnEkTSfRit2gy4H36Nq7Y+JYHZgzFwevMU94x0aYtEuQpbpc3CPbYlFDGwnJog7nNv1HOATbVeem6iTg10Y5M5ib4HSJgBdIL2bOdINizDVnJFVBOwr1i7u+53u/EIpkk+iIN4Hg7pc65Inor8FKa+bOlc6bmLKHJLHwHkgb/vb7HJU3jRE/rHvvuqLFald5zHvuEHllCXrf8cMriuoMLSUFBSEKBDhY5GAOG8xRCjdc5woHvkiRcj5SzExfqzLOo13vyM9zeaDL9cKqco0fd8VwSwpTPMzJY5rJgdUozxs4WbOeumuCtBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oszCR00dG+ofHEETWpk3NM4lLjkaXPEeZQM/bNWx2/4=;
 b=c3F1lTo6V/IpsRBlClZy1hi6PtfCAjz2+fSTk2hWwev93wsrIlZVBOAqVZGQRd2IwgMVvurpYG3hea1deK3qZqBTEYRyz99o3nly20WwXyHj7y17aKgyM1JAR9yt78nHbhkdOKjs1474uun91zUK4ZyvuGddZlatltj3cMZiCewugJiwiNYMl4xHoU3ZDMOSD++C3OJrLn5s36b2OgqDZzEs2kJ6DinqQqMit4RXxSd15y+zqDfW1ryAvD0YWLeyIbLrEQeR5ID1UZLbE6h8RVwGKGUMRDpAJq56YAYwgoH+RLYmsRvh2uG1kYyG3p/MwMPQ4mPbcTCJTSnfKS9UrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oszCR00dG+ofHEETWpk3NM4lLjkaXPEeZQM/bNWx2/4=;
 b=AZgaqp/ybGugzC9gUPEb09YrVOI0Kv/HUuaCT78x7t8Z42r1QKqgsbXt50E9ItuIto8Vw2icq2sqrq95m/jxxH3DPcDfKATUduEPGdPm05/ypqmVsKW/+yXILNWgQ9Km4izidakUMIl7EHF7qipANbbo8CU8YgNxd07gnThpDQj/4uvbYosVMQJx3B1yKcwMg2UIHM3AWL70OwPsaLNdPU2pOC7/GHnqj8lfge3ShUQhB/B0AMlyCYdN2qdJt9EIizSi99OGUhrP51wnsrR+2WNYi1bgw1VNu/gxIcXn36Qyyw+DFgAXWEkLNHz4eyh7UfTibjCzIGxwyxbjdUomrQ==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SN7PR03MB7034.namprd03.prod.outlook.com (2603:10b6:806:32e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 05:53:14 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 05:53:14 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>
Subject: RE: [PATCH 4/4] net: Tighten more driver dependencies
Thread-Topic: [PATCH 4/4] net: Tighten more driver dependencies
Thread-Index: AQHcLl0urDy3lihiW0qQsFz4WTZlH7Sk9jOQ
Date: Fri, 26 Sep 2025 05:53:14 +0000
Message-ID: <SA3PR03MB71879F064700EEC64233B7CBB41EA@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20250925204414.3561033-1-trini@konsulko.com>
 <20250925204414.3561033-4-trini@konsulko.com>
In-Reply-To: <20250925204414.3561033-4-trini@konsulko.com>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|SN7PR03MB7034:EE_
x-ms-office365-filtering-correlation-id: 42368764-ec94-4435-a17e-08ddfcc0fbd9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QpSfqINur9pj4FVsIfem2RGO8+pt5wwchJzmfBXQNNvONQz8QHWJ7HbMjpNg?=
 =?us-ascii?Q?ic4fFxYBfv10DHqGfukjGHmXRT02ZW7yLwpXu07nCIhxrK7WpWFpvJJZVptm?=
 =?us-ascii?Q?nj70tiaLVYWYfco/l7r9QnZg64WXm/vDE1XR0tVmXld6VLiJbZ2BHCSF0ea5?=
 =?us-ascii?Q?2U727ALqnQZRN2U1I9rYF217LEUB/atvf6gQ0O4GRD7S19sM0al1CaeSP9RI?=
 =?us-ascii?Q?TmeZPBXMvzV2kYogRVl4QWrswLSBB9tFEw14gQWpmNk/p4POmUZYsd7wlkoG?=
 =?us-ascii?Q?XaAiOyTenSkiKhpCWopU/zv/ijvtbJc4Lq5Q6PCJC+/xpgN1JvKaL+DDQzYa?=
 =?us-ascii?Q?xsn6sp+B9aSQUg215i5BKWlHBO42B+3DyVRGSy2G82uu5sPATy4NzJx5tJwl?=
 =?us-ascii?Q?bGJaIiEURTBNm2Kd0ndpK8mTAVX86GqxpRgy0LmBIP+auRWohHAcky/9O0i7?=
 =?us-ascii?Q?ReVuyvJ3MxJt5sKfUlL0b0uoMyMiySV58OF89UdUNvWlsLcwHjjU88oSJHjT?=
 =?us-ascii?Q?xVeUBm+N+yMR+YH7b9YFAYtUeM48x/fTXg7fkfugHNyvCy1/iy+W179viW9n?=
 =?us-ascii?Q?O1JJahlbl4BnwjiqLtUwnChaPKPnAyGlDuPFszUWHRRfIRTVJ9Env9wy73OV?=
 =?us-ascii?Q?R3DkAQU8phhys9yptgAU2E70HB2ePDLo3cLqfTbMjSu5rePiXKUyfSVthCW7?=
 =?us-ascii?Q?k1x9/0O7LBZ17psJ40qrPzMPvsrKhY9SsLUQdfO96c5AGD31M6EklQv9XrvW?=
 =?us-ascii?Q?tckhy5MWDp2huCYIzmeQAK27nA89aZ/2Ig+dDZiSpTH/GZonA0ad3ibFDAGC?=
 =?us-ascii?Q?xC7BV6RyWTi7Ub2u/QmKX1kFIB38/O1cSan+0nccDFCXfXEOJSbnjo57ndZi?=
 =?us-ascii?Q?3N5oBve76+Z4g+CM78aVB68H+Og0D4rz5QD8NCZ5/7h8fdmM85JJZI+1Y1W9?=
 =?us-ascii?Q?p09IbKUtXsn25knzHne/oV5ngOH9flPi67Cfsmt+UtGDxyTd/7I3gUp0ys69?=
 =?us-ascii?Q?qo+vR0595AtM7t0olIimr1faSCLwdlwz+GHJYvUnhmascoDs5NK7eslts2VX?=
 =?us-ascii?Q?vz9Dvsbdm/rA0qZYeztNrHovHmLAeNRjM8q1BcmEJAVq+uTktFeRWwndqC5o?=
 =?us-ascii?Q?FpA8fJvrh69gdCNfMAvFkgBXYBRKSUiKAwEp0UQUa642CapxPW3lCrjGI7H+?=
 =?us-ascii?Q?tVZTIlHvLcIJs7lhjj9epsbW7c6BBDkjoqBjvG82Lph51Tw7jC5Xe1J+D6uG?=
 =?us-ascii?Q?Qe6VHXSRVgPiwRCzKnkkBVxRSSaD+yo+Ez3Uf2vwC1QR10vhwdKFgzWIeqL0?=
 =?us-ascii?Q?tPuy9PW5n1uz3yve6hF62aRO0pB8GnXhx3dOUFfPczPg6aR8Lp5zjfx715r8?=
 =?us-ascii?Q?GVgU5gBdan+IjydUrMOl/O1fKtE+IWgyxQjlnsr2SaiDX9Osh2K6p++pkGHS?=
 =?us-ascii?Q?jAn71gijDcO9b+Ts9oId1UB83aSrXCpSZePsADVvjCQEkOHSz6towA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jSBGalvTS9inXXTcOCbycwx7rotezT2kd4h13nuCCL9KGMLDPgyrNYMc8P2Z?=
 =?us-ascii?Q?SgV0rzk0QLNjGlc93FQWpd2VjWNmxSHY9aA1oBT0qwoHRZcxq9Ctekg1bWgR?=
 =?us-ascii?Q?NXRwYkaEJ9dqnSNHmpZLjNpQzWdh4bO/ae8bxq5RQtIoa6bpDBoWd2dZSyP2?=
 =?us-ascii?Q?F+xAWhRcW58ePXyn21DKyNIhk+gEnivb6GFiZXWr2tKU43RHgzYv9lP8b6vF?=
 =?us-ascii?Q?1paLPqQdc0NVSWT8B+izI6GiyMFTXXq7PFnIm7JuDXYAasyYKVImUETlpoSa?=
 =?us-ascii?Q?DBoEGE7SZfCVsugqFGsE/8mrf/woga7DYXycZvNBqgzTAEnFELMtavn4lED/?=
 =?us-ascii?Q?n369cjoXQZ5s+kOwC36R8tFLF7bDVSEYa5+TO1Hl9WgY9esAZBBInHNh1yET?=
 =?us-ascii?Q?sTzpA27RvDW8z8T6SaFA6NK7sXX2GQWaA3xc5sdXcsmDYOvr38N63HitLq3U?=
 =?us-ascii?Q?yohbWSesYFXp5ps59AL+MYf0I1c55ThpzoM4i5G0XEWH3+KXhS/IRESCE1bE?=
 =?us-ascii?Q?SeOnC0jO1+VWhLPNCOh9mEFlgAJ96I2nK5jA78+SYeX+Arhqzyzge0fUlYZL?=
 =?us-ascii?Q?BxZWkSby4kTMl+e3fJkIIx/Sp0haGaaBDSJg6D9mqOeiQ0X9EwxpYizsxkDT?=
 =?us-ascii?Q?J40b+MgZ5kqLba2JnqTuiWC8v2cM+ByPpTVDp9YcpalxA3cQktQ+nLaLpHLE?=
 =?us-ascii?Q?OPX01rmKIbkKB5Y9xH96nIjrORjTLnlk/Cjxu/a+uzclprtYWam8CwDh7SE4?=
 =?us-ascii?Q?RdvTpVkHsDjv8z6UHv5tmK+BfN3TM7aF629focnCZqb2eEkEyBfdejUah9Wb?=
 =?us-ascii?Q?sUgMV3x8A1mYoP+o09g16dkdZoMQG081hONDtNzQzarXcLdmcCuTM1JRCQdq?=
 =?us-ascii?Q?7/oYIbHKilHGJGMkxJ/1vMj5LASbTSoqq+jOY+y0uhcb01KH4P2qBkxUbOD9?=
 =?us-ascii?Q?aRcd4MaK8rzj8v/iDL2YqDJWq37wE0iDHITuoXYSnlgwVr7AxEXJMhw/ec0q?=
 =?us-ascii?Q?7I1B1Yz9BnsjyFR2bUDBdd1i1lFHyJpfWhZHE7L0w5J1zzO7mgr3V6aqcde1?=
 =?us-ascii?Q?BcXmU4qp2rRGvdn7Xtnm1uj4Y/PA1ySuSUOfg0JPkDVo9QNC3bfcvL+Q9nJs?=
 =?us-ascii?Q?yVJAYPEv0xmQZD9cg/7kwGzz3yeADO+kZ45ej/WpFjUSOMOI0yg1bUtsMWU4?=
 =?us-ascii?Q?nEEPg60qjFXjTDNUoitBw6OoUkW5K6Zel+BCR53eiiRw5Ct5f0K1SQu1C3ZA?=
 =?us-ascii?Q?ggFDP+LSUCp/ARYE5FVoy/mtJWzzSHQHIQBDqnW+lxR/5rifHTCTPoDWTX5z?=
 =?us-ascii?Q?/VYUNU/Swkc2RHxXbL/yC860BawpfWNG2Ey2V6qlm9HPSy2aUNihJFn2iyPg?=
 =?us-ascii?Q?u2yIbVjvZCDgL/mo3Cw8717nr/5QRf5IURbcauy655mqskKMhjzG3RpWgNPX?=
 =?us-ascii?Q?Zr86SG4YvULUq7HNoGQ2uZqBgllyCFKaUpgHIId0+0/G9pXOixO6MlSkbPxH?=
 =?us-ascii?Q?hPF5Oy9afDxVOqZ+HUH8l9u2Z3QQrDbcnClenuQtCwku5rpCCezFsA9zwRkN?=
 =?us-ascii?Q?XHtaFmwlZGYv7UurGeHlT7a/44GKK93TaF8fUai77eZw4z271/884t3cr7MG?=
 =?us-ascii?Q?eMM6vbKVwqyTBdLVeqJ/HI4oHkT8fv/ieZUdKEW/nROQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42368764-ec94-4435-a17e-08ddfcc0fbd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 05:53:14.5136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hpVrzmx1JKbjOnjSqh8d1LlOYvfngrr20wAC3sYj177whu9W5VjamirQD0BJXYL9YwjqbrUX7zOjvklZZWsjFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7034
X-Mailman-Approved-At: Fri, 26 Sep 2025 18:05:54 +0200
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

>  config DWC_ETH_XGMAC
> -        bool "Synopsys DWC Ethernet XGMAC device support"
> +        bool
>  	select PHYLIB
>          help
>            This driver supports the Synopsys Designware Ethernet XGMAC (1=
0G @@

That case we shall remove the DWC_ETH_XGMAC config from our
socfpga defconfig?

> -190,7 +190,8 @@ config DWC_ETH_XGMAC_SOCFPGA
>  	bool "Synopsys DWC Ethernet XGMAC device support for SOCFPGA"
>  	select REGMAP
>  	select SYSCON
> -	depends on ARCH_SOCFPGA && DWC_ETH_XGMAC
> +	select DWC_ETH_XGMAC
> +	depends on ARCH_SOCFPGA
>  	default y if TARGET_SOCFPGA_AGILEX5
>  	help
>  	  The Synopsys Designware Ethernet XGMAC IP block with specific diff --

And preserve this config DWC_ETH_XGMAC_SOCFPGA?
