Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F230BCA0EFA
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 08:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4949E82FC7;
	Tue, 26 Aug 2025 10:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="d2rwFv2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2901828A2; Tue, 26 Aug 2025 10:27:11 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8102B830B4
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 10:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAbrNJKg/INYfQTlWDHIB792hIZyyonaZQW2NJG+av/3Jn6Snde2YjL8ZDWBbKGgLF4vhu/3KcCa/UUqRb/6CGq9OpaHzPuxBQJmz6EUHmf/98zsky8W0VQWno6qcUPmjTUtNyoK5oDBsQpuVAHs+SVrpYiPin9E4YbGdy2BXSB0YL/KbRvgppVlIrSNqX6hfUk5nnXxiOaOrA5oQgRbctMH5NPlDfrGNimq038yvfpBBL2GHCbdAsrwcoHabGrKdaWZXAtq+PBnEr4P0DVUZ7inqXMn3iCkO5nT9xPgY216U4+EOaWfxc7LTeROT6irNdkRu/tWu8uY4fC8h5itmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM8yJp5Zj4Wd0DNG20ZFLnBRO8EzlVmbsm/tEyLiIts=;
 b=gYS7OKZplWL/+lB4od/CZsI7NlkjO0Leg1Bb2sZAQqVBXfR9/EKKLMlutUWIlwzYLSysaYsqSmNIV67foQnMFIPkAU3WBeVHZyX7RVEfRVdakOYRShbI1ESk8I0qcI8n6On2gOZFV57v6toLeucFlVjBTBSN0pLJ841+Xrt+KPbHg6jCuxG0yxZ4u6yXofzzNI6/38ieQxfqJpT0mBp8QlzBfyMqgLsekK2Ln9GZKpPVsxpgk441VbIGL63BcSBvrng+p55gp+s6hGmeLtXgitHSVhWA8y1WQ3f4IKwrQc7vczIhxPKPLgHfKlrx64kw/DXU2FTitI435y4AWwub7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM8yJp5Zj4Wd0DNG20ZFLnBRO8EzlVmbsm/tEyLiIts=;
 b=d2rwFv2HFcDVhLijFHZ6QqW6MEI8lPVfh5OenTbJOtpv7Zq2JTwFPfyzunKH/kGfz4XeQUkLZwuCVj1guaGZzgRbTsno3Joz2HLiStMknF5LWwvwet2+bCDspOkcvw93YM2sGviSrsz+DTxGHzbpZbpuU+3t7WSNn76yw15pcApr6rczZgPjknhbTRcuMkyN73O5PHcXcCCgra62HbGQs1v8Cz6hiFVp+BT4L4JkMrwnseXewDSgjselBj0AcFWplzc365mb3DwSXVyP4V2k3W6CkRi3bUV40q6J3rI5WgPejLNFl4sgTPySBKvNNVyDJ2ePEohD0W/Y7WHiSFkxXw==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA3PR03MB7370.namprd03.prod.outlook.com (2603:10b6:806:37e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Tue, 26 Aug
 2025 08:27:05 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 08:27:05 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Michal Simek <michal.simek@amd.com>, "Ng,
 Boon Khai" <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v2 3/3] drivers: fpga: Check bitstream address doesn't
 exceed 512MB
Thread-Topic: [PATCH v2 3/3] drivers: fpga: Check bitstream address doesn't
 exceed 512MB
Thread-Index: AQHcEaSTwiJDwYP8OkCqo7/tKLpHMLR0oxCw
Date: Tue, 26 Aug 2025 08:27:04 +0000
Message-ID: <LV8PR03MB8137180E80095EAB1CED68A8A739A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250820073201.8649-1-nareshkumar.ravulapalli@altera.com>
 <20250820073201.8649-4-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250820073201.8649-4-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SA3PR03MB7370:EE_
x-ms-office365-filtering-correlation-id: a66090fc-d8cc-4c7f-fed3-08dde47a56cd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?a7438ry1UOZM4eXzRG8DvaOIfiFaeBUOel6zHdh9OKMoEQU+9HbzZshvJ6KJ?=
 =?us-ascii?Q?fmA4noezIzrG1rLTAMhNydjz1YKafmKFwwFhyyaEeneTcXHSGn/wT95hXjvE?=
 =?us-ascii?Q?zTGPTqD3cr88dms9FE7jC3WgV4FslkyRWxV5b99rzZKX+djBMhRUKQ0sCkPQ?=
 =?us-ascii?Q?K55xfnZmoHuddHJ3P3eMxsGcrbLBBYI+B23yDB75KcMgMIsK1q4P1ZZtnNUv?=
 =?us-ascii?Q?h3W0fMNYtF0M463JjLrD5vJiODIokxpjprKe7Ufr4+00b0R3IiTQZVSnacCO?=
 =?us-ascii?Q?X2Aw1NwKKgf9YA9lD87XVblej6AJFR4YonvgD/4mPJDc55sh8/OW69Uf8XOj?=
 =?us-ascii?Q?/ayC/cj2X7l7fQWBYDfqhtrRppv4JdpDrdKbpYoKHvd0OgigQ8b8LTJIlqZl?=
 =?us-ascii?Q?yI/g8XgrmtPbyrckDRoyclKzVlwV1IH4dHkM2MPUlMbBcTlqzqLGGcnkRhe7?=
 =?us-ascii?Q?JA3Z9F9oXJP7KkDb5ILzvOO39PGEwhmaLZaUd2FAaohXnk6KpLZpkK1M3gBB?=
 =?us-ascii?Q?xNQZDgu+UQAch5qkwGyS1sd/NLdjM88PuQG5f6w5LuRxJXoHSwEnQWjViqJN?=
 =?us-ascii?Q?ugxDE5FUn9X5Nn5zUhTOQ0090yLx8Viie/jSD2l8NXpKqH0gT4RX57cLQIR4?=
 =?us-ascii?Q?TeODHfn4UeiF4MwMHJ93bEYkNcv6/qyUEPeWt+yGLkgHcdFV5+xJ3Edm3H0T?=
 =?us-ascii?Q?WnSYUkqwC9uK4DJpclkJsLa602eF1Kl9558zWtJIE/Yl+iGW3BO0QmTlxLse?=
 =?us-ascii?Q?FImNzHnOTJjWBYNaicY6HBQ/QeCirxs5oR+c7w3wWMErYAYxw5yQsWSupfox?=
 =?us-ascii?Q?ebf7Z/xOWOpVEo7P0AVnRjNo4tYK5PDUOoR/OLYQPCsQevOsRlfelp0ROe3Y?=
 =?us-ascii?Q?OuiEVWFaxGL2w0GZw4ApH5cRgxWS+yt4aL000FeyOFDREJkJ29Gpm0vJaeri?=
 =?us-ascii?Q?fnRz8mZ3KGN51Lv/IEVbap2eDO4IOEFxFbewzfo4tNI9kI99pnawtPTAEli3?=
 =?us-ascii?Q?VFKe0UlQOr9BelSQhJ9TdRDbrriKzKucLADQS6yKOLksrErqr4j916sDPiyp?=
 =?us-ascii?Q?uAo/S8TEkkvpzukidtsJQlhBAndakngS6xcVLNzNo29p3+KPejALz6vBa3WD?=
 =?us-ascii?Q?98SeWch0HYeqah4w9j/jZlwT7/fgSVfTcRRJEozKN8R6zoBNyRp/QPBZbVJP?=
 =?us-ascii?Q?agIBA+EoTJNehlNNOsTHyN7g9gqvd0oBDp2C7ggCW/Ow1u1tWT0p+0JQ60r5?=
 =?us-ascii?Q?jCyq8CdMLveIFkkEnAHllbLdGFBDksIkfYCMfP9gWNYu8DuzfpoyIhH8QqvY?=
 =?us-ascii?Q?4UY/W9n6CFnSgAcOSfOiTfaE9+i+febvhGeup6m0PRUIkCPH5/ZK2dXiMYvj?=
 =?us-ascii?Q?q0P0R3dy9g9H10KJxQ2PAfEIKdS2EoCEV4zlnV1Iej647n498r52+7ff7I8w?=
 =?us-ascii?Q?w69p5+xAk9YMsQrH0u5FrzVlJBwD6Juzn4/Ml/yIfGXqYKCtcR2DSw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2wfQEA55MKrBroC+ZzDoxXk5b2d0i3J/2Cpln4SVxDPWkA6graHJy0BoVhoE?=
 =?us-ascii?Q?QR9tn3cDLneeLVOe8v5YWhiXYE4hmenOzVCT2Oa97B0mUuVoqL927iMopYL/?=
 =?us-ascii?Q?ZVBD0HCNxTk3Y/fZIAraSJ8BMSIKNx+7RJQl80WYhKZrPi82BpDq3GxBtN1f?=
 =?us-ascii?Q?USNpC3vO4rfh9oPO1OGaardkTACLnZRhn5FCtO2F2OpqmyCTQhXWSIJtp9iY?=
 =?us-ascii?Q?0S/OMtB9CT1XNe9zJBza80NFVnQgBiPCJT63A4MzkPPxu6f2leYh5qgbMuAJ?=
 =?us-ascii?Q?yQZiUfN0DvTK7P7er9qZOi3np4E7qpn7KfTzXe8qqo9Xde2fZ6sYQDh54PH2?=
 =?us-ascii?Q?KaN0WEZ7d/PD5OPU4ZwFXURAHkRu+ncmBPAxu+aFldzTQpY6hc7du6sQpVuB?=
 =?us-ascii?Q?lfh/i4ANbFnz/J+lGGJeza/qRnUSSXZU4/7UCRbg6C2dcRZ1qoOc4HpKrRYN?=
 =?us-ascii?Q?N0gJ93fqY+TpwO1fOlVvAjeoZVzCou28A0S1DxI1NoK8N1zJGeFFEE/8i4fn?=
 =?us-ascii?Q?yeHMEpAZtEzxUhB03GYF3i9qBp7LdhbSaM8q6bvUkz6+jYNhlo0c0dMz9gDl?=
 =?us-ascii?Q?qqjXBj2OVKtbz5YvSQ8K5Q2vPskyYBbawD00S9Bc5Za9lyCvMp9sgVJ0JcVl?=
 =?us-ascii?Q?7Bd+OJUNxexOk4JCuLpJ2EYllrfvoGOUVt3vuovqur401rdr3FnI9AAcctb+?=
 =?us-ascii?Q?c2H0K9fv0WVPOcv+4RDTuGoxp0oExAP2QQ86YOBZbonnR6V1Yc7+Ic/GEukH?=
 =?us-ascii?Q?9Hb5e0XCvQMWtrXro7nMFQuHMPSeyOzfjxYjm39LmMv/v1F0XGaJWUB4i0FF?=
 =?us-ascii?Q?hcVjnKlbq6tFEBfL5URJr7NYWk1rMmrLu6UjqHLigbqEAy1/gQ5WOt5/baMT?=
 =?us-ascii?Q?TFdNxsWy/RdeK4Plw7uJTuQupVdFxeJwCTAxH4Bt2dncqCaJY3j9LWo281B2?=
 =?us-ascii?Q?KgYZ4xZyjRylMHIOXtZm74Pv0j7EIBjKnjG7ODW7bQEvlzQKY5zOVqZ4vEiK?=
 =?us-ascii?Q?eegUkbluPdUbGmL7mzC4UzLezD4PGE2a6nunJkqS1gW2+RjdADwBogRJq8l5?=
 =?us-ascii?Q?yRhCHqklEnGAtlq7IiU6n8OODiPIaujFA6vKe6lqjMLG2R1g3ity8CxjQwbl?=
 =?us-ascii?Q?I3yPqac4mnO7xM4Hfep4X8zjMmaEYf8acaqo8Xh9lbrJ0UZps1A9mxERcNzq?=
 =?us-ascii?Q?ttUee2yjudWxLpoWHwvfuRIOS4F/NsqIooSJTYQ0XJ0YFyIuyts+aHTh5c01?=
 =?us-ascii?Q?ZYMjudPRjB8H4/BOQV0pKXpdf9mDJK87lXAL7ztjatHjTkE679rYT8JqiznS?=
 =?us-ascii?Q?j9VU1Ti2aR13VRw2o8HhJHohhBCmhCBrveu6YkzMiT8iKBTgpYUQo/G4TTuF?=
 =?us-ascii?Q?YlsKMEuJZDKL2PJe0DWGT7+dDcs1ZtgNyThwbfWgdVej3Mf4HWQysoZMUl2G?=
 =?us-ascii?Q?0ma7jvM4aR0R+PDEo77Y4XL67A2Etd3NpJA0b2c78kiVLXkUf4BS1zyMw9co?=
 =?us-ascii?Q?9yrDPYlszoPj0zfhLs1nMWq/ykMyWjMh8k3vOQDl48NoluAXT7AsskEiB8yk?=
 =?us-ascii?Q?uQPv2adjhQWSOQWV9nPIyVbY3t44K751IFzSTBPW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66090fc-d8cc-4c7f-fed3-08dde47a56cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 08:27:04.9900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k2qIGGoec4I4xckwtwd6PsZau9+VpXSgoAoDG8YwXfY7x9gqst8nA0J70t+5IkUumkclTCNtlKXTed44uNIKXzxfxphWemewd/2w59jQEQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7370
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
> Sent: Wednesday, August 20, 2025 3:32 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marek.vasut@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Michal Simek
> <michal.simek@amd.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> Ng, Boon Khai <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Tom Rini <trini@konsulko.com>;
> Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH v2 3/3] drivers: fpga: Check bitstream address doesn't
> exceed 512MB
>=20
> Secure Device Manager(SDM) has only 512MB window address space to HPS
> over PSI BE link. The default access range is 0x0 to 0x1FFFFFFF.
> To allow SDM accessing the address space more than 512MB, SMMU has to
> be setup for address translation.
>=20
> A conditional check is added to not allow the fpga reconfiguration for an=
y
> bitstream data where address exceeds 512MB, unless PSI BE link address
> translation is setup in SMMU.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  arch/arm/mach-socfpga/include/mach/smmu_s10.h |  6 ++++++
>  drivers/fpga/intel_sdm_mb.c                   | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/arch/arm/mach-socfpga/include/mach/smmu_s10.h
> b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
> index 209caa86e38..d611664e227 100644
> --- a/arch/arm/mach-socfpga/include/mach/smmu_s10.h
> +++ b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
> @@ -30,6 +30,12 @@
>=20
>  #define SMMU_SID_SDM2HPS_PSI_BE		0
>=20
> +#define SDM2HPS_PSI_BE_ADDR_BASE	0
> +/* PSI BE 512MB address window */
> +#define SDM2HPS_PSI_BE_WINDOW_SZ	0x20000000
> +#define SDM2HPS_PSI_BE_ADDR_END		\
> +	(SDM2HPS_PSI_BE_ADDR_BASE + SDM2HPS_PSI_BE_WINDOW_SZ -
> 1)
> +
>  void socfpga_init_smmu(void);
>  int is_smmu_bypass(void);
>  int is_smmu_stream_id_enabled(u32 stream_id); diff --git
> a/drivers/fpga/intel_sdm_mb.c b/drivers/fpga/intel_sdm_mb.c index
> 5f4aae47d6d..1bbb717015b 100644
> --- a/drivers/fpga/intel_sdm_mb.c
> +++ b/drivers/fpga/intel_sdm_mb.c
> @@ -10,6 +10,7 @@
>  #include <watchdog.h>
>  #include <asm/arch/mailbox_s10.h>
>  #include <asm/arch/smc_api.h>
> +#include <asm/arch/smmu_s10.h>
>  #include <asm/cache.h>
>  #include <cpu_func.h>
>  #include <linux/delay.h>
> @@ -1031,6 +1032,18 @@ int intel_sdm_mb_load(Altera_desc *desc, const
> void *rbf_data, size_t rbf_size)
>=20
>  	flush_dcache_range((unsigned long)rbf_data, (unsigned
> long)(rbf_data + rbf_size));
>=20
> +	/*
> +	 * Don't start the FPGA reconfiguration if bitstream location exceed
> the
> +	 * PSI BE 512MB address window and SMMU is not setup for PSI BE
> address
> +	 * translation.
> +	 */
> +	if (((u64)rbf_data + rbf_size) >=3D SDM2HPS_PSI_BE_ADDR_END &&
> +	    !is_smmu_stream_id_enabled(SMMU_SID_SDM2HPS_PSI_BE)) {
> +		printf("Failed: Bitstream location must not exceed 0x%08x\n",
> +		       SDM2HPS_PSI_BE_ADDR_END);
> +		return -EINVAL;
> +	}
> +
>  	debug("Sending MBOX_RECONFIG...\n");
>  	ret =3D mbox_send_cmd(MBOX_ID_UBOOT, MBOX_RECONFIG,
> MBOX_CMD_DIRECT, 0,
>  			    NULL, 0, &resp_len, resp_buf);
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

