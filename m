Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17532C7115D
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 05:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D728882DF2;
	Mon, 23 Jun 2025 07:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w9sWF2vg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4875E82DA1; Mon, 23 Jun 2025 07:52:28 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41AF782D17
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 07:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPj45+0fqYFRvRlAUGEFuvbsHYtRR/EE85Vjf3vg3G26LJHEEOsJ3Yd4Digq/NwSkkMBv5b+E3gAwVwnuIuumRrwq++shVeBSkhoP0i8WKNnsQ3hhcB3N56IIs4Eg0iwL1AQZ+u2qHfizyF385xHFjdc03sL/JZA/1lf3ynyIPb0z0OoZbYsaNttEVVGS0A8m7Bx7QsSZd1KlvwaCSjU2zdq9acB0JvBYA4YE27qODcNbvgCWL9ygLAtHisy4HPDlXiaJ5V4zRs4mAwP9/G9dnIpcwlod9mGvb489wkzbPoD6dGYi+DGbAXyv9xu/dMXX+Mr3WGrivwKMl/33PNlgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhW7OBM/B00tlp0V4hSPEaqyc3wcnt7RIbSxAZ8onPQ=;
 b=huUrYMxr+v8GUu9UA7aPlJqS26tINjpdn5Lub2yiePZnsRy/CdlVePCuYBZGc0INa+fv6gG6t74o8qsSth2LpTrW/P2zTka7s62jWHb8iYIe/JXjYThNaoCIT0BwtwTaV4jcPo/OPYD9y3lizW8tXhatcUgpM7Ik46V9dJp/sfcHnnfr5/IkyqEnqzJMFd6TrSBGCY9HGoenBwdt3Nk9IOiv79QhFZtUSFpulLj1iRVT67onvTaf2VnlT26HBS2clCOMbDJdL+KefC3mQbdbKvJAE7rilQJo07RQ9Io8gtFHJktUGb1zDnw+AzxQ+cBJuOoCKmfXCMbcv4VHP3a9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhW7OBM/B00tlp0V4hSPEaqyc3wcnt7RIbSxAZ8onPQ=;
 b=w9sWF2vgkZPZuSDTkOiW00ADwSI98TfdZVyz9ZPnjh9hcwv6upX86s1tVh9sa/KXgTTu5fewV/LwQTihzwwfRMwq5Lfdt+FA7Q0b/l6nsglEOdDPrS/0snGfFwoUOegzdHjiy0Z6x8MGg5htXasRy+ElthSyZpO6FBaN33NyFEEGdpmVuOmRXeoa4lJnFHfJe0CuC5OT2nki0ohE6wMik2dMh1zWUs2o5D11EcJ2cLdDJd8+/9nDKwZlLMxvGBFcaPx6w4vjo0rVnrPJL+nv5tIYZoZMjZ2p3XiOKw3hLwRh0JYBq40ffvib6xb2pK/fifhAna/Do+/jGR+8O2QSoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10671.eurprd04.prod.outlook.com (2603:10a6:10:582::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 05:52:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 05:52:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 23 Jun 2025 15:02:31 +0800
Subject: [PATCH v2 3/5] imx8mn: evk: Add support for capsule update
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-sr-v2-3-e97fc53f0f8d@nxp.com>
References: <20250623-sr-v2-0-e97fc53f0f8d@nxp.com>
In-Reply-To: <20250623-sr-v2-0-e97fc53f0f8d@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10671:EE_
X-MS-Office365-Filtering-Correlation-Id: 095d3779-f810-43d2-678e-08ddb21a20e1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vkc5QWhHdTJSYnJjQ2FINENCaGMxejByMEkzcWtvRjluYUJ1aHU4N0M4d0ZU?=
 =?utf-8?B?SEppbkJCSE5YSDA3WURwY1FzSEV3YVhUaGltcklyYkdJcnd4ZmNzcFFhQ1A1?=
 =?utf-8?B?WUdwZlBSdFZCaGozYU1iZ0pjaDlIb09lT3VOeExML2w4TnBlaGFuMllheEFY?=
 =?utf-8?B?aEhMQ2lhNDQyckhoMmFGYmhUbktueSs2MUpOdEJpRUtYblJiaVQwWmZ6UWZK?=
 =?utf-8?B?c0xGM3ZnL25LREQzY0NkaVdzQ3d6UCtUaU5IQjRLS2lzZTdKV1EwMGNoYzZQ?=
 =?utf-8?B?dk9VVUxkQUxiZzVEU2RjUHBxNVdXaFV2Rnd3eXh3TGhRZmpWd1ZlRHNOcFl3?=
 =?utf-8?B?bGlwRkpTdklpS1JhK1BJR2p5WG4rTlFBRlI5TklIOWFBSlZQMU5sQ25RUmk2?=
 =?utf-8?B?ZTY4ZndtTFB5QVVMTEwxWFJmcmNtOS9iSks1M0JQQlF5STQ4Z1c5RmtFM1pq?=
 =?utf-8?B?Z09QdE01QWowNTRaWm1JeTd3TEVRd3loQ3Rzcm9ZamJqMjlCQW1VN085RThP?=
 =?utf-8?B?NUNuejg1K0NmT25UelFQazMxa0NQV2tORzg4UE5kVFFnczJod1p1dWVNUVBi?=
 =?utf-8?B?TmlabS9XaXE4QnBiZ1pndVVGblZXNEg4VythU3FRcFYwM1BVUUNLWEUyek5R?=
 =?utf-8?B?U0h2ckk1TW5RRjFwNnNLMEpmRW16akZZT1dqUTFtWnVSeEZhczlubEFpV3JP?=
 =?utf-8?B?SUJySmRpcWVMZHc2MWVKVjVJendGREZBNnhZcnpMaUtMODRmdDYzQnNYQzUy?=
 =?utf-8?B?bmRMVVowMitHNHBiWW5SeFJoUXJoZWNrVU91NS81UVI3K1VveTBvSjZ0RGlH?=
 =?utf-8?B?dENjYlhVMERUci9pM1I0blVvTXpTWnZRZnZveTBqanlVaC8yc3QvSDJrU0xx?=
 =?utf-8?B?NXdtbDkyNkxHOGovM1VXdlZCSURISzJRZGhYRStkTStpYTg2R1ZzVFdwbnJJ?=
 =?utf-8?B?cFlJZFBZNEsvU3VQQlkyMms3ODlSWU9qQkp5REFoVGNkK3BXdVc0UHI3Y1RR?=
 =?utf-8?B?NDhzcm9PRC80aTFDTStyZDE1MFhqYzVNL25udS8rNWlVYXBoSmNqT0xaQnNN?=
 =?utf-8?B?czVYLzdhNnBTSzkySEQxclMrUjhyUkFlbFRtM0RMOVQyYm1vSnI3U1Y1VU15?=
 =?utf-8?B?YXFVZG0yWTFhTXlVdEtmMDBkcjFHMlhZblV6OTBGQlUvWWk5NnVMYUVGTGdM?=
 =?utf-8?B?dzlsKzZGQ1NYakYwVjRwR0dhYlVKbHk0QWxXazFTaVZ5K1VrZTdrU3JLM3Ry?=
 =?utf-8?B?N2VWSUVQai8wbWZsUFpiVktRMTl2dllaZzlBYXYwazdNa1p4N2NmcFFoaFVm?=
 =?utf-8?B?MDFXT055cnpDQU9mMW5WYmZjYkdRUHhoNDQzQmJRUzVRZ055VGJoUXkyNndr?=
 =?utf-8?B?QmhnZkNtRmZoeCtTajFCZHVuRTFuaEY2cjZGNUlKbkk3TnRWVUtNVWxPQjRM?=
 =?utf-8?B?WVdXeTFWdkJSbzNONXkzOFp5TGhsQ0JNZFV4WUExTTJSUzUvS0ZJdUNSRTJL?=
 =?utf-8?B?WmZST25aZ3NicG1wWGU2cmtEbGNqMnB3TUEyaFhzNUhoTjVtdCtUQkppckdY?=
 =?utf-8?B?eG5qcEdkQStoQWpicGFvVnNvVkhVSHFWcHFqMHFONkl3MG5HeGJvOFh6S0k4?=
 =?utf-8?B?MXd3cmF6K2Z5S0FXYTUvK2s1a0dXbStUS0xjWFJ5RmE2YVNiSzAzaGZzTEph?=
 =?utf-8?B?YkdFNzZXbXNDUXVjdHJhQzJOcXViWlU4V1lBNzRlWm1sQ2JWY0dPaGhxZnFI?=
 =?utf-8?B?UjJZVUQrOUNLalgxVHRhTGg2Vzdmdi94LzBISnBGMEpOTEdQRlA5THNtUHdZ?=
 =?utf-8?B?VDlUSmlCYUl3djVUemdsRGZQcmZSZXo0MGlxWStMdVJ3VG9PZXhqV1dPV0s4?=
 =?utf-8?B?aTJIbm5SczN4UjZHR2d1aU96M1R2bzkwaFpxWDRvbkF3WjJXTUVSR1pSL3Fu?=
 =?utf-8?B?ME40RWpnV3JqOUFkbkxCdDBuRWxHRU9SS0E0NWxjU0xjVCtoQ1oxTEwxTmw5?=
 =?utf-8?B?a0ZmZVBQVzBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ZMaHhXV3NOZ1JZbE1yMUlNRHNhSTdIN2xOeC9iSG9ZSEc4SitCTTV4dVdE?=
 =?utf-8?B?b2F5QXZsMXZldFZGc2UycjJ1MDRnNzhMR1hrSVczazVueEIzVlFROEEvbnBV?=
 =?utf-8?B?UTlLYjNZczk0dGJ5czFJTXNId2RrQW9XU3I2RUxHd3Z5THgvTmY1VUpVM2ky?=
 =?utf-8?B?WVNla3F1NTBMR2FQQnFBMFRTWGQySFdBTll5RTJZaE9keUhCS0pwdytWK0tt?=
 =?utf-8?B?cWlxNklMTjY0ZWVidmpTTzNOK3hrcmF3QlozMzg3ZFFNbWR3NlFxeDRxK1Vz?=
 =?utf-8?B?ZGVBemlNRlljcmdoKzFQbDBrWTRHKzdPUnZtWC9PYldrd2JpN3B6dkdQTFVB?=
 =?utf-8?B?NEY3blVFUmthRUZpcmUxSTVWaXBjbUdFVDQ1U0dRV2tOcjVZUlkvaGw1U0Vx?=
 =?utf-8?B?dzlPczY3WlViTkFKQnRRL09BMno2ODRvaUNnRHVMYmRQK0xhWVdjVnRTQlI5?=
 =?utf-8?B?MzN4bmhIdTlJYm13YjdsTDVWSmJldk1aTkVPUU0xK2FOTEVhSjhiL2hvdU5Y?=
 =?utf-8?B?Yk5QcDFwRjJuUEZrMlluQ1dGbmNCdno5RUpoMEtBTnhGYmtEdXFjUmtkTFR3?=
 =?utf-8?B?cXhtM0FnVDZDOG1aV3grZFg5ZHZnVk94NEsvbVVZR3ZYNkdZenNkTDNFaDVE?=
 =?utf-8?B?ZVRMdGtxdGpYRUlEYkhiQ1V1SHh3bnFJRnNpVDlTMmY0Nmcwbk5VbTRUcXcx?=
 =?utf-8?B?TWRxajFESUhkc1U4b0lXQXFKbUVaUnRReGpKbm43R3I4eE5teFlYY2EyUHB3?=
 =?utf-8?B?UDdsUkJWWmJ0TVFaZUpsTlEwRENhTEJoaTRVYXJYY05vOVVoZTNXRVlpOTJs?=
 =?utf-8?B?Q1pPcHpmeE5Ycm5rb3lwd1p5ZytYUDdQTkxHYVptbU5Ib0d5MFRSSDFId3Bh?=
 =?utf-8?B?aktVMWNiaTBKR3czY216ZE51QWpCOCtxNFBoUEN5WE0wVkRoeTh3SXdSeldC?=
 =?utf-8?B?THZxRkZnakhDdjJNZlJlUmJUeEQzSkI0eGxBMWoxQ0d1UTBIb20vUXpRenB1?=
 =?utf-8?B?NjFaeFlaNzRHdUx0Z1JvcjRIc0JTUGY5WTJjbmtsc2lOUng4NEludGRkaGFs?=
 =?utf-8?B?UHd0bEV0OTBvVUhFVXkwU1RMVCtsMnNQRlNqSFJYR2I1MnM5VVQ0TS9xczdF?=
 =?utf-8?B?b29KTS9PNWt4cXlWMitMRkMzUXFINnVrVm1DUjJ4TjE4NHdVMzdlRFhDYUR3?=
 =?utf-8?B?c0M2eHlNMlVsU0M1MUtrM1ExUU11cHNNQkxmZCtkNy9nbVM1VDkvY0xkZi9K?=
 =?utf-8?B?RW9CM2lXN0pIUFhMbVNWckxhS2YxNldneUIrQkVyRHlJTjB0QXV6RnpJSExR?=
 =?utf-8?B?THgwYnFGWUlpblRmQTFRQmFqc1FCRWV1ZkR4QVlNYWRXY1Z4OFAwRG5iNk81?=
 =?utf-8?B?czc0NStmVFBma2Q0K2xvL0tBcGI4bmtTcUk2S0tnMGRoNmx6WnhDcnVHY1hy?=
 =?utf-8?B?ZWpjSWNYU21haTlJd09UdWxUNlZmWkU0SCtGUDBISC9qbXdiNWR1ZVV1VE1h?=
 =?utf-8?B?bkdXVlRBa2JwVFVGUWJRczJWSlo2SzZxSFo4dDU0MC9MeHZMN2pQeVVyTlFM?=
 =?utf-8?B?dm9ZUTFvR2d5VEpweElpbnQ2dDFCb2ZOTTRRdlBRSFBzYWlBOGdFU2NRS1Fx?=
 =?utf-8?B?aG4xSEYvdG1rV0FhVktabjJMYm9BOXJ2T2o4dE92QWdrM2NIR1BMV3o1eFBa?=
 =?utf-8?B?K3hyVnU2L3o1YlZCM2JwTk5qOVc3OEo3d2Z1eWpWY2lIRmg5MzBsaHNXME55?=
 =?utf-8?B?KzU1aFFsTTl6RkhIZFpZRWZkSlczeXNlYnpKT3ZCSTdXQlhHaGx2SGhZMmNY?=
 =?utf-8?B?aUgyVmxSSDI4d3A2VzRsT0Rsak5rSDBxQ3N0VGY5b3g1VzdVcStpZ051RXdi?=
 =?utf-8?B?M3FBMzFMRXFzWjFTR3dnV01VbXBTM0NUN2o1UFExMGRHK1M1Q0VLK0FpT1N0?=
 =?utf-8?B?ZkQxS2YzZlpaOXJTdDlwOHUxSGVGa2txL1M0ek9ST1JyZnhwVHZNZjNUZWQv?=
 =?utf-8?B?VnY4d010YVFjT216aWR2TnBncFV5cmNUQnN1RkZGaXRFc1RNOWp0eklWcld4?=
 =?utf-8?B?TVAzbzJOL1p1Rk11UGp6YTB3QjVMN1NwaFNhWWZTRFhhZzcxTERaZFNxVmZD?=
 =?utf-8?Q?68lm/GsTAOZUZPCgx77o8gvo3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095d3779-f810-43d2-678e-08ddb21a20e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 05:52:24.8064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JT6koRWxXgQ+K4H08vzaIdGqnF9U0F4GzjxJAJIWJzM++BAja1grruz+Q209zhKGYA9EPBhhwL7kwYOQ25Ekyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10671
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

From: Peng Fan <peng.fan@nxp.com>

Capsule update is EFI based firmware update which is widely
used in various OS distributions. This feature is required
by ARM System-Ready compliance test. So
 - Define image array and GUID
 - Select configs for EFI Capsule update

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mn_evk/imx8mn_evk.c | 22 ++++++++++++++++++++++
 configs/imx8mn_evk_defconfig            | 23 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.c b/board/freescale/imx8mn_evk/imx8mn_evk.c
index c62d7a47e21b77918af85e966ac2bf8f58a75df4..9d3f29f225317ed6cf3991ed8286696b99f00a6c 100644
--- a/board/freescale/imx8mn_evk/imx8mn_evk.c
+++ b/board/freescale/imx8mn_evk/imx8mn_evk.c
@@ -5,9 +5,31 @@
 
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
+#include <config.h>
+#include <efi_loader.h>
 #include <env.h>
 #include <init.h>
 
+#if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
+#define IMX_BOOT_IMAGE_GUID \
+	EFI_GUID(0xcbabf44d, 0x12cc, 0x45dd, 0xb0, 0xc5, \
+		 0x29, 0xc5, 0xb7, 0x42, 0x2d, 0x34)
+
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = IMX_BOOT_IMAGE_GUID,
+		.fw_name = u"IMX8MN-EVK-RAW",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 2=flash-bin raw 0 0x2000 mmcpart 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
+
 int board_mmc_get_env_dev(int devno)
 {
 	return devno;
diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
index d45c83951effb4f38d2b0fa19146cc2a44ca77cc..199bee49d1ee4e33d15cf684bc8961387f076b7a 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -23,6 +23,12 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x42000000
 CONFIG_SPL=y
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
+CONFIG_EFI_SET_TIME=y
+CONFIG_EFI_MM_COMM_TEE=y
+CONFIG_EFI_VAR_BUF_SIZE=139264
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
@@ -55,13 +61,22 @@ CONFIG_CMD_CPU=y
 # CONFIG_CMD_EXPORTENV is not set
 # CONFIG_CMD_IMPORTENV is not set
 CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_OPTEE=y
+CONFIG_CMD_OPTEE_RPMB=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
@@ -73,8 +88,10 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_CLK_IMX8MN=y
 CONFIG_CLK_IMX8MN=y
+CONFIG_DFU_MMC=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
+CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
@@ -99,11 +116,17 @@ CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_SPL_RSA=y
+CONFIG_SHA384=y

-- 
2.35.3

