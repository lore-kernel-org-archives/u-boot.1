Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED3AC5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 04:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56EC5807B1;
	Fri,  6 Jun 2025 06:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="CavVIioN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97D2581E25; Fri,  6 Jun 2025 06:42:28 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CCE8800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 06:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manikandan.M@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGga/A2mg7aZhF/2/lqH6odQBhhEg+vWiU9o0p+e1qlKhhZgHpvY+4G1LyAGFpOMut2WdEIne2JfRbleSVBlW1juI3TTQkkTetrC0rXfDr9wWaUaWhmq7nWVQDXfAz6LqvMuh8VlzGxUZlmAytX/9hMdSHlRxB0G2Cb9hSbWb9vdZjURHQkcJeb3ZICVd723rPtbevqiL03nuUGTRiTl4RLQ+5Fgg11EX5kKXpzlgIKTVaMAfer76U4CD8Yk5uERTRfJwEgusXDT6VmDL7Bg8R2tcbNBjwwDXM+DzskUJz1qrvV+86QSGrsjGuduWPBFL7UDL9llLVSd/9mcaE5siA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIhbXcVd5in9iMppr2n7siFWau/PHY7JjK531ta24Ic=;
 b=tCfabPSBtjoi28axFL07Lx1/jpKrtT0VGVKtFJF6C2nphKfKWDrpTW/xFaYYlcOP/b0emTKSgO2ojUTHa0h/C0rUQK/EIVClJ+ZiIQo63QQ7SEi7V744ahRitJceany/Cc2Lal9nvLqM6kgPApt2MWp/1Po/KlC+JWiAm0QKuYNEdP31rjbGdaoLU8BkRpf3fRl11VnB8ScrJx1NySjt4N97Nlotxcl4MgGLAHdl1vOBE/rVWytmvD8X4OJxNDTWEBckH1sGStVPdta6Q7fhpVEfHVH04jwb0QTeoP4LbZWQXrk4PcOyqNlGC2JPFtaoa5nQkn+TQFv4YELIzr0Tag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIhbXcVd5in9iMppr2n7siFWau/PHY7JjK531ta24Ic=;
 b=CavVIioNS53LRSohvmT4rMUSZSwDKFRLuOHytnkAucSmAbm/ursH2HC3lgx68cjJfn288eiOYoDW6MNBPduhF3+NZwy9Z5SnK1fhZh/0aqE3TAWFv7CdZbwWMH8eeN5uplKk2TzCOhMr7qYQlSXLCviNKO3igTJ4vZYJu13do/YRThhwnFSCkRp3fd5H2Z0IqH87lf0NagFxU0asHMmY86arZO+SUdqnwow4cfLPYSreEFpZ/4psEQzeNdVtWsz6MuQF57dUFAkPxKdUB8s1feNL7qOsifHXJU2wNvR0D+ftb5zNSBgn00SIy4NXJk4Y+OhU4dqRJeHripP+D3VOfA==
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f3a) by CY8PR11MB7135.namprd11.prod.outlook.com
 (2603:10b6:930:61::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 6 Jun
 2025 04:42:22 +0000
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::a7eb:da5d:125c:3345]) by DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::a7eb:da5d:125c:3345%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 04:42:22 +0000
From: <Manikandan.M@microchip.com>
To: <eugen.hristev@linaro.org>, <lukma@denx.de>, <seanga2@gmail.com>,
 <sjg@chromium.org>, <Oliver.Gaskell@analog.com>, <malysagreg@gmail.com>,
 <nathan.morrison@timesys.com>, <mkorpershoek@kernel.org>,
 <robert.marko@sartura.hr>, <jerome.forissier@linaro.org>,
 <sebastian.reichel@collabora.com>, <duje.mihanovic@skole.hr>,
 <sumit.garg@kernel.org>, <patrice.chotard@foss.st.com>,
 <Nicolas.Ferre@microchip.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 4/9] clk: at91: clk-main: drop parent_name check when
 registering main_rc oscillator
Thread-Topic: [PATCH v6 4/9] clk: at91: clk-main: drop parent_name check when
 registering main_rc oscillator
Thread-Index: AQHb1EVlXv2zBj5FhUyvhv5GWbBMjLP0H4+AgAFyq4A=
Date: Fri, 6 Jun 2025 04:42:21 +0000
Message-ID: <b01bea7a-8c91-46a8-b09a-084b8330d7db@microchip.com>
References: <20250603050556.80851-1-manikandan.m@microchip.com>
 <20250603050556.80851-5-manikandan.m@microchip.com>
 <8d7091fb-b07b-4b4c-ba73-fefe574b8fd9@linaro.org>
In-Reply-To: <8d7091fb-b07b-4b4c-ba73-fefe574b8fd9@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF9623118BD:EE_|CY8PR11MB7135:EE_
x-ms-office365-filtering-correlation-id: 88a5a613-133e-4b05-d462-08dda4b486dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?bE5aZDZzOWxUUGdDcksyVlUzc1BkT1NQUk52bDVSb242c3RLZ0N3L3RoWkNP?=
 =?utf-8?B?TDdhcHhEVmd5RVdqeWZJY2syWlN1bGJFT1BkTkZtOXBDYlhIcExPak5sK3Va?=
 =?utf-8?B?QXUzMWtGclc0bzdMWmo5Y3p3WlJoRU1RZjRlTjVCcXFWRFRLRTZ3VU1Jd3ZD?=
 =?utf-8?B?dnRmcHQ1djZwdjE2Z3A0MkpSTlZjNC9Jc25FT1g4aG9NSFhhYnBwN3B0VHZS?=
 =?utf-8?B?bWVDMVBSMXNrcllyNjQxQTQ4WWg3bXRXNDcxWmlXS2hYMm1pT0dtOE4wYjhR?=
 =?utf-8?B?M3J5RHlCT0hnU0tBZDdSOWhkdGpxWEkrT3MyY1EzQUh3bWdSSFMzUUJ5KzFu?=
 =?utf-8?B?TE81V1EvWkg4ajJ6ejBYaHpJUGFOZENJYzYwbjlrdWtUOVZ4ZEpyQnlyUno4?=
 =?utf-8?B?OEVqQjE2RzVNdTF6c1R1VTZMcUxVa0ZVYk8vQU9vNWFvVUphdlF1eFN1Qy9m?=
 =?utf-8?B?WDZoNHNrSXpiUmUydFpheVYvbDNDN2hQRFJ4ejNNOFk4RHNSMkdBeUJ6dURW?=
 =?utf-8?B?RmI1K3A2QmtRSDhST1dTOUxOL3BhVkNGdGc2TjBSZ3FidmJmRmRKR2s3NkVq?=
 =?utf-8?B?emgwaXM0NUFFWlA2Ty9oVGljZVhkSGxtVXg4T1R4L09iZjlJblV2TTRDaWZl?=
 =?utf-8?B?bXZjenF1ZHE2Y3E0UFN4MUY2Ujl1MnoyYUVmUHpPeHlHNWRmTVRIREExYk4y?=
 =?utf-8?B?dFRBcENQTkttN1B3WVhJWEhGVHVETFZFditpQU5Cbmx5WVFISHRGM21GY084?=
 =?utf-8?B?akhDc3REcG95U28xcXArNml6YUw2UUNqYk5qUDcyMm9EMjFwUWhOWklJMng2?=
 =?utf-8?B?bzZ3VUlBNmpiQkhxZGt3Rm1PMkxwMjVpTUErV3Q1bXcvandORzZHS0RPL1NR?=
 =?utf-8?B?clg3aFhPbklZZmo4MXc0dW51SndHbldtWlVsMUJBenBmWjdzeE9JWUJtYTUz?=
 =?utf-8?B?UVlITElDbnNIMVQ3SkhFUG9tWEdVeFR5Ym1UdXplTmltT0hTenpvZWlWK2g0?=
 =?utf-8?B?RXhhVmNJQUszVVEwUDZUS29IaXRqd0ZBSTJxNnd4NzlERHlyTlBxNXM1RUZM?=
 =?utf-8?B?dmVSOG54QnBYUno3eEI4L25CLzdEdTJpR2VtL2JNRGF4eXRaSGdqQVJubmZY?=
 =?utf-8?B?cm4wb2JCN1lvRFNrNUszODFDUEY5VlAwZUdDL0dYMStsbVdCNE90TzEvL05N?=
 =?utf-8?B?SGhsd1FTendMUWxNVGFuY3pIY2lRbjNSSGY5UlFZdGFnWk9aeUtJem90eTMx?=
 =?utf-8?B?MG5YdUkrZmhCaHRUNVlSbXBpUjVJUytPem1NeUw3d1hma2NFa0FsU05HQndN?=
 =?utf-8?B?UWFaaEJFTUlKODZIVUV0NXdXSEs1dTArYnYvc0JtR1Ewd00wSzByWDdVOE9I?=
 =?utf-8?B?OVF3MEYxM0tvRzJSNitDa3BXNTZHZ3ZsV2c3SW1ES0FSNGtCN2NyMUdxRGZD?=
 =?utf-8?B?UlcxVWt1RVA5ZFFKemhoOXU1TkZzMEpyY0NLUEtreEY5RTNvTkQ0V1RJL3FY?=
 =?utf-8?B?TEtMNnRJMS9jNDFzaXhpS3lkSkZSMGFUTTR1bG03bGhhRGdmTHZEL2hmZEhI?=
 =?utf-8?B?anR0M3NkV3BjZHlMUHI0ajNCVUN0UzNYQVI3QjB0UzIzVkJjWVlMWE9sQUc1?=
 =?utf-8?B?VjY3SVlUR2EySWlJZDN5U09na1BvZnpYd1VyOXBQZ21XVmQ0QjZraXRUbTA2?=
 =?utf-8?B?a2JFV1FzZ3N6NEtYN2IxeFh3MENmVVl2cml5M2RlL1pMVmJEMVJqUGZGL1lU?=
 =?utf-8?B?RmNVaFQwblVWeERQeTBMNlNsbmJoNmM0bUY1ejZBTFJYMVpLNWRhZEpralF5?=
 =?utf-8?B?MnBYWWd5TGN3Q2Nkc296M1J6dWEyaUtWWjdoZ0puSHpobnNicFNJeTFDTys3?=
 =?utf-8?B?MjdYdjErOGYwSWxlM2d0T25uRTJVbkFhSXZHcU5GeXZyY1NJVkwraG1rMnFl?=
 =?utf-8?B?RVprYy92b3lzdUF3WUNGMi9hbzJZbWRHTmo4R0N3UTRta2JnTFpQN2I2Uita?=
 =?utf-8?Q?JE3Rw1tozrjHfhq7EnDse4/27mTVt0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF9623118BD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHJxMkdRZnAybUtFUXJiMU9kblB3cWhvUHEwcEF4aHlyS1pWQzc5REFxMGVi?=
 =?utf-8?B?MTY5WVNDOFJqUFY4S3BqcWgybmxUNGtLY3FIT0pDS28ybjFLcE50czRiQWpr?=
 =?utf-8?B?VmtEazE4RXpHcldBdXpBZnB1S0JiK0ZwbVlyblFZd1VNYmcxWnhXWlpqVi9V?=
 =?utf-8?B?bkZ1dXVUYjJkd1N5R2lJNFZCOWx2REE0TlJlSWdWWUJuUzhrMHJ0V1dGVHRD?=
 =?utf-8?B?c2Nia21TNXU3QXdMZ2hGdlZqazRSU0VWNkJoZldBRmZGUVUrUHZHTGJvT3Nm?=
 =?utf-8?B?NkpWQzljTHJ0TDJOTElxcGFua1A4akFhYWlNN2lEb01zR0dxdjlHOGlONWlE?=
 =?utf-8?B?VHByQy9ueG0yOEZNQlNST1RjSTV3b1YySi9CVnpFWVUxckVubExUcWkvaXhT?=
 =?utf-8?B?NW9QbkFyZWIvc3ZZSUNpOXM3aXF2LzVWR21GNVRmMlMrQ1NEamc5NXVkbGx2?=
 =?utf-8?B?SzdmbVdMQll2d2loNy8raWYyV2JrWHV5NUoyR1I2bXZ3OXE1bVRPQStIRjN1?=
 =?utf-8?B?d3I0U1FBYzM5aXFWVlBwNW9SeFIwc3RNUytsQ1dpK0hsOUI3blphSTJCd0xx?=
 =?utf-8?B?cFdjcHZhUjU0dFE2Vmo2ZHRFNUlLNkdwbkdQTERtTHZrUmNUTEkyYzJwdTha?=
 =?utf-8?B?dXhoN2x2YlcwYWZiRU1yY3RrN0V2QTJuSzFzWkRuM05TOHNFOFhvOG1PZHhh?=
 =?utf-8?B?NlIvL21SOE1yN2k4N0trcVRONmM0dGRNSGM5NzY3OVU4cGRQWjlxUGVDVHFr?=
 =?utf-8?B?dW92Q1g4UTdXVmUwdGtYcVhkOVJNbVBJdDFuQy9uZnVQcU03T09vZDVSRWhW?=
 =?utf-8?B?T1VjamFKR3ZLVzFNM2pEbXlUUk1hMFZybUUrejU1M2VZek5mcEUzblAyWXVY?=
 =?utf-8?B?WDVkbldSVjdtOW9SbENrNDJFdUtHallnOFJLdnVDckNreUFMTlFIMGNiWWgr?=
 =?utf-8?B?RUVHS0Q4Z2VTek9ROEw3UWlMZnJoNElSNndqZTRlTWFQSzVQVjIrR2hXUDg5?=
 =?utf-8?B?SEIvRE5kVzZLU2tZMlNXYXRCdEx2dkc0bDdHbzFTNE9rQ2xuRGt4WDhvMXZs?=
 =?utf-8?B?cXp6UmNGQlBqYTQwZldlSXZHS1dySldQcHk2QmxwOG9aeEp1SFZaaDlWYk1k?=
 =?utf-8?B?RnJKSTBJaEtBaEVpWlZsN2l5dVQwenBnSWRJdjgwMGN6aHFEaDUxWFlnRlEy?=
 =?utf-8?B?UnlOTmV1c0thVUtIeEtBdy9WTHVCTW11OEE2MjBtVkE4SHdZcHhqaG5nNUp5?=
 =?utf-8?B?ZTYyZ0ZDY0Eza3h6VFR4NzVDbW5wK3V6djBYM05EZld5dEwzQmV0Q0ZtRE5l?=
 =?utf-8?B?QUdBZVpOK1RJbjBOUlVXTEhmNno1bGNoeWpVcTQ0MFJ5bGw4Sm5Pd1pLaXVJ?=
 =?utf-8?B?cUpuTFRJRmpqbGtmUTI2R2ZDcjgwaXBMR281OGdHazNJc2FlV3J3MWZ4Ty92?=
 =?utf-8?B?UFJqR1VwTHJLWjk1WnFsbkx2dDBkK3l5Y1k2amh3OTdaME5TdXdEb2xOMVM4?=
 =?utf-8?B?VEl1ZGZ3RzBSZlhMOEhmSGNZVmdCKzUrSHJISUUvaEh1U0hTV3RxQSt4NnZo?=
 =?utf-8?B?ZFlOUi8vQ2hxZzEwd3N1a0JiYTdRVkRFMTNHQzlUSjM4eHd0NlV5MVlZeEIz?=
 =?utf-8?B?d3U1Si83M0ZGSVN5Y1R6Wm9vd1ZqNWJWTkdBWEF2Mi9lQ1Q3VFV0T2ZLWGFk?=
 =?utf-8?B?Ty8wN3JIRGRoRVJuTE5kak1iQ0tmZElNTzdubkVGcldqbnVOK2hQL1lZVVds?=
 =?utf-8?B?ckxpRVpSN3ROMzRTVVMreFQ3YTJtT2c4NEROS0R1L3VyMTBZZUxqY1J5OEZM?=
 =?utf-8?B?UDNHYTFpdThnTTFGaWgyNTFYaGdtVUkwS3BEbjZDMVRzV0R1WjRvYUhMMTho?=
 =?utf-8?B?b2taWlRBRUdmQUdaYmFqelB3bGtxZFRuclFxb1IwVWU1Nk1XelZkN1hBN0Fp?=
 =?utf-8?B?S1AwMDVGVHdhbnd0ekxUdWswSWszUFI1bnhaME9MMVY2aGdWVVp5S2pyVEYv?=
 =?utf-8?B?akptS0w3YWQvcW00SElCTGVvdTlUb0d3TUllTEk2WllVMVg4bUdMdDAvY0RL?=
 =?utf-8?B?QkxBK0RONFlkcjh4c3lWSktLdWhoL3ZYQXdQRGh6c0lnZHUwVVJQTlpxSThp?=
 =?utf-8?Q?vXDFjRwOZN+PyhhaKIXIDmE2e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60FF60673A0DED42A9FAB6C80EBD901C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF9623118BD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a5a613-133e-4b05-d462-08dda4b486dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 04:42:22.0090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2iXQy3zkjsT2G1uBcJR4RvpKNygblm7ULwrFiytlmRPnJpjugXxOXb2yyhA52eggnvdD4UAQm2dkD6LyAvlK/XXhBlo4RFvrVR2ih7Ny3kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7135
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

SGkgRXVnZW4sDQoNCk9uIDA1LzA2LzI1IDEyOjA1IHBtLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDYvMy8yNSAwODow
NSwgTWFuaWthbmRhbiBNdXJhbGlkaGFyYW4gd3JvdGU6DQo+PiBUaGUgY2xrX3JlZ2lzdGVyIGZ1
bmN0aW9uIGxvZ3MgYW4gZXJyb3IgaWYgcGFyZW50X25hbWUgaXMgbWlzc2luZyBmcm9tIHRoZQ0K
Pj4gRGV2aWNlIFRyZWUuT24gdGhlIFNBTTlYNywgdGhlIG1haW5fcmMgbm9kZSBpcyBvbWl0dGVk
IHRvIHN0YXkgYWxpZ25lZCB3aXRoDQo+PiB0aGUgTGludXggRGV2aWNlIFRyZWUuUmVtb3ZlIHRo
ZSBwYXJlbnRfbmFtZSBjaGVjayBpbiBhdDkxX2Nsa19tYWluX3JjKCkNCj4+IHRvIGFsbG93IGl0
IHRvIHBhc3MgTlVMTCB3aGVuIHRoZSBwYXJlbnQgaXMgbm90IHNwZWNpZmllZC4NCj4gDQo+IEhl
bGxvIE1hbmlrYW5kYW4sDQo+IA0KPiBDYW4geW91IGV4cGxhaW4gYSBiaXQ/IHBhcmVudF9uYW1l
IGlzIGEgZmllbGQgaW5zaWRlIGEgc3RydWN0LCBub3QgaW4NCj4gRFQsIHNvIHdoZXJlIGlzIHRo
aXMgcGFyZW50X25hbWUgdGFrZW4gZnJvbSA/DQo+IElmIHRoZSBtYWluX3JjIGlzIG5vdyBnb25l
LCB3aGljaCBjbG9jayBmYWlscyB3aXRob3V0IHRoaXMgcGF0Y2ggPw0KPiANCg0KdWNsYXNzX2dl
dF9kZXZpY2VfYnlfbmFtZSgpIGZhaWxzIGlmIHRoZSBtYWluX3JjIG5vZGUgaXMgb21pdHRlZCBm
cm9tIA0KdGhlIERldmljZSBUcmVlLCByZXN1bHRpbmcgaW4gYW4gZXJyb3IgbWVzc2FnZSBiZWlu
ZyBwcmludGVkIHRvIHRoZSANCmNvbnNvbGUgZnJvbSBjbGtfcmVnaXN0ZXIoKS4gVGhpcyBwYXRj
aCBzdXBwcmVzc2VzIHRoYXQgbWVzc2FnZS4NCg0KPiBFdWdlbg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IE1hbmlrYW5kYW4gTXVyYWxpZGhhcmFuIDxtYW5pa2FuZGFuLm1AbWljcm9jaGlwLmNvbT4N
Cj4+IC0tLQ0KPj4gICBkcml2ZXJzL2Nsay9hdDkxL2Nsay1tYWluLmMgfCAyICstDQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL2Nsay1tYWluLmMgYi9kcml2ZXJzL2Nsay9hdDkxL2Ns
ay1tYWluLmMNCj4+IGluZGV4IDA5ZGFhZTk3Njc2Li5hNTE4NmY4ODVmMCAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvY2xrL2F0OTEvY2xrLW1haW4uYw0KPj4gKysrIGIvZHJpdmVycy9jbGsvYXQ5
MS9jbGstbWFpbi5jDQo+PiBAQCAtMTEwLDcgKzExMCw3IEBAIHN0cnVjdCBjbGsgKmF0OTFfY2xr
X21haW5fcmModm9pZCBfX2lvbWVtICpyZWcsIGNvbnN0IGNoYXIgKm5hbWUsDQo+PiAgICAgICAg
c3RydWN0IGNsayAqY2xrOw0KPj4gICAgICAgIGludCByZXQ7DQo+Pg0KPj4gLSAgICAgaWYgKCFy
ZWcgfHwgIW5hbWUgfHwgIXBhcmVudF9uYW1lKQ0KPj4gKyAgICAgaWYgKCFyZWcgfHwgIW5hbWUp
DQo+PiAgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4+DQo+PiAgICAg
ICAgbWFpbl9yYyA9IGt6YWxsb2Moc2l6ZW9mKCptYWluX3JjKSwgR0ZQX0tFUk5FTCk7DQo+IA0K
DQotLSANClRoYW5rcyBhbmQgUmVnYXJkcywNCk1hbmlrYW5kYW4gTS4NCg0K
