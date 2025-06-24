Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23477C71157
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 05:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DEE082B20;
	Tue, 24 Jun 2025 07:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="k3ebe5Tx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5EC682BCD; Tue, 24 Jun 2025 07:48:34 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD0881F66
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 07:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3B4zrNiyd1DL1KKmSGpN5pmJdfNc+5XJ8s9A0dU/6bkcb++DZIfto0kofyBJYhKfU8BswUNkECXQNshlBQ+8jepD/+2hald/p8rihD3JkdNpVtvtWaSWejMDMzYJBVYXKPKi4vw+llcppjWuQBRNCShJAxZp9V34Q1RFkzNta0bANWebpRBzmDI+hJVmztQYBhWHNP2vl2ChdkXy/O3tvjbDv9HJ3qzKUD7ZcTOKYqV5u5hTgmy9WCN2pCWKZcUo3HsltE64RVm/LvJA+GR+edHWNe2nZF5Nd65ONzl1drSVXWoC0GnqZScXvPQGPcfMfQO5OKI/2iEtsKq45DgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDeHQ3JiSeKJLUZky2eFlItWaLBC3/Qa4iFERGSJ558=;
 b=kfx379WCpsiXDJyeEep8BlUBZeuRQY8OrdAuRZ9krSJ+fdb1+Hrs9wTGyIhoIjopbyIYrHAlvKE6sILjE16J73K0Hs00uCMLtvmNAqvhnCiWcZCOKZ/lQFyxLCZsCbcIf4oqNMbhojvI/whM/oAOhW056tK7hMXdyE9XGKBVOOpEZ5OhHBkzwx3QvdjNkYMsG/26dNpzm46QYSZAzTnHi7nbhkiXG/IW3O6qmfSYWYiqZ9luEPRpqogs07a0kMC9xmVp+FLKrAn0fPxTrvDqCc9Il/+XjENEGssNdmbrYTu10+dvNl+U7oT8mAp15bD4tk3GSYMwZhhffPJuxNDnTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDeHQ3JiSeKJLUZky2eFlItWaLBC3/Qa4iFERGSJ558=;
 b=k3ebe5TxvQm16Zo2/apFzWeE1duUBYVcZ7QUV1ptZ4gnbVjIfO9AkEVZG3ghVEEfXATvzHgNJDHjDdP7qBmm5m49/f4mnpUmQcEit4JGN6VjNjOlXj0qu/kLlJadCPmRb7QGzqU4hBDAQxz/TzuZFCGq3CTHhZ/VWNfjqnxToGnD8KmnydYNqNR3vE/eVdwZ4MhmbRYYYv9YB4zFSdPBGodMeIzz+U1lQxu6znrtoRh8o+cUK4jBACghQkzDnoe2zJIW6nLiUB+UNQ2pKFAolym7SjdQ52ZL4wG9Ipyhn4R6g2/pjDhwUxpoD3nbZMgJGs/WlkEPURHKC9nVg8cenQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB9950.eurprd08.prod.outlook.com (2603:10a6:150:b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 05:48:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 05:48:27 +0000
Message-ID: <7cc78b07-8299-4638-ab07-fbcf2a3b5bb0@iopsys.eu>
Date: Tue, 24 Jun 2025 08:48:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] drivers/net/airoha_eth: fixes
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250606201728.462664-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610072924.1066329-1-mikhail.kshevetskiy@iopsys.eu>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20250610072924.1066329-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0405.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB9950:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ed347f-b712-4233-925e-08ddb2e2bdad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eklVd1FJVTdqbjlLRDdBM1BYVnR5LzRnalQ5b283MzE4OXE2VGE2b1Fvb3c3?=
 =?utf-8?B?bnJmb3hpc3ovaEFqc0pqa2Y2RUhlZHhUVFVFNkc1WWxWZlA3MU5kSzM2di9Y?=
 =?utf-8?B?QlZ0RW0zVUMvdGNFQUQ4L0ZPWXVhUkNiejA5S1lVSVI0OWJNdnFndFZRcDRR?=
 =?utf-8?B?cTRnYVh6NDMxa2crTUdjYlNTY01WdHp0SXR6ajhQVDl4ZzRjN2ptWDR4RzZr?=
 =?utf-8?B?MExRa2RQb0kyVEFJYmtsRjJOd2tyRWlTMEtjaTh4WDdCTVBGNkFxcG9GNmJJ?=
 =?utf-8?B?MzdsbFIyTERzS3o4T1E1VThxdjc3RWc0bjByRWkvTnpiOFJVRXFxUEVkSENI?=
 =?utf-8?B?bGFIcVo4dmdJRlBnU1VNaGs1UWlWZW5ML1MyMW01bFNWUmxPa3dYOVlrWmFM?=
 =?utf-8?B?MGcyTTZNdzBRcmNkY25uMlFXNVVlT21nTWw1VWRyaVVBOGtoemR5TFF3Uy9U?=
 =?utf-8?B?KzA1WEtYcEgrM1JtWDlUdklrWW00Skl5TExBQkdkRXZva2lnd3BGbjJZSTlZ?=
 =?utf-8?B?VEw3VFltV2M3M20rOHhDNGt2K3FGMC84U216alNpM2ZnbjhSYTdrSHo0L0VD?=
 =?utf-8?B?b0FLdUFzWjlWNUNvWDZWVjRUMVljVDBKTkJJR2hiV0p6T1NnMEk3M2hOWWE5?=
 =?utf-8?B?bER0d0VXbHRoajZjc3V2SzYzL09SVWY2a0ZGS2lGY2VkZlhaaS9JNHZzd3g3?=
 =?utf-8?B?Nlh6N29pY3NFRzhSNWladHBFRFRVOG5RKzJBTk5tSU1BczNjMUE5VUNSWHpU?=
 =?utf-8?B?NEE5QStrYWFRVHNhV0lFRENnL2l1V3pacHNPVGo4anY1bDk1eVJRMlNWWTQ2?=
 =?utf-8?B?b3hXcldJTjZqK0hCcjZIR2s1MTZvUEMwS3lreFMrRUQ5Wm44a0R0WFpaUDFu?=
 =?utf-8?B?N0xvMlh6aHgwN1RjK05SS3lLTlY3RXhZVzl6M2VaTitzUmJad0hCOXZXcWw3?=
 =?utf-8?B?a1BDRk43WGdpdjB5RUF0RnhMTWswNHpOUTdGMWxWVUdXRXdIOVVBKzNRUWZI?=
 =?utf-8?B?b2lNRmhqYTl2a25rVWNNdWhYRlFLM0duWHlEQlp3dTNOMG84YXM1R3ZVcld2?=
 =?utf-8?B?aFZXZ0M4TXR1WnAwOFUzajJhbEdTc0U0ejNIVHJJbkVvcjdpQ1l3eitub3NQ?=
 =?utf-8?B?TWVqZG9NNVFRMHlUaDBWS1RIZjJkcTVwSlJ3N0duR0ZvWUVlaTlIb1VtZEor?=
 =?utf-8?B?cXFTUld3UWpSVStUVElTWkxjQ0FqdUhteTFVT1M5TmF0YnZkMTBjOUtzRkpo?=
 =?utf-8?B?V3FEaGNYN3A2NGxkUDJQV0dwSlBBRTNVVUZ1U29ndzhMWE82MzAvVWQ0OG15?=
 =?utf-8?B?d2xDNFJBcllLb3pEVHdEbkxqdEQrdTY3cUg2VjFoQzZ6OWRWOVFHd25JZ0xX?=
 =?utf-8?B?Y2VFSGZSeWY3cWV3TDZvRVQzK3BNWlBJMW1IbmxEU2lMTHluekNKQVRyaUk2?=
 =?utf-8?B?TUYwOGZaby96anZncW5ubmdTTVR0cVJpTmZSRkF6N0V6d0pGL282S2d6WHJD?=
 =?utf-8?B?VTRXNUpDVURsVkZXdE9IVkdiMXBtNm1TK2EwbmN5OWxiNC9aK0lod25pZFh5?=
 =?utf-8?B?TlJKVDQ1VThzSDhDenlmbVg5MWY3MkZiMXhaYlpSL1lLTEczNG5NK3hhM3BT?=
 =?utf-8?B?aTVzQTFaUmx3ZlNTYWpjS3NkNFo0UVQyUThWRndnbyt5YXF4ZFRneWFzVHZm?=
 =?utf-8?B?K2FDaXNhRXVTakFjanVEZUdlNkV4L0tKbEZPMWlCdUd0MGJ1ZHhlMlFxaytG?=
 =?utf-8?B?Q0ptR0dNbkdnRzNURHVIaXdIemVmaFFHdUNvaDFyTW9XcSsrMFdTM2FZcWJu?=
 =?utf-8?B?bk5lMWk0T080TWh3ZTBlbUwyV0tlSTdpRkdxb20zN2VwcEE0OEJyRUhNcmw0?=
 =?utf-8?B?REkyR3hhNkZITkM2L2cvaWNOcnZFbFduOEhic0VLZzRIT1RoblpJUktFdjJy?=
 =?utf-8?Q?DwjIeiZgIec=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WS8rQW13UkViVndyeHNValFIN21RU3libkEwN1BkNHJGOUlsWHV6WGVhcFhq?=
 =?utf-8?B?SXk2QXJmNUgrZVowR3pqd2xXQktBNWVsN1ZwVi9yL01IL0FDajVNai9aUCs3?=
 =?utf-8?B?aGVMdnZTQ0NaNHI4UzVWaXBRczZCSThsUVd1RGR3djN4Z1g4T2RrTjNHdnJO?=
 =?utf-8?B?NWxpRmU3SFphTVIzWWY4SzFISy9RQ0tYbGUxMGxFSThwSnVKRmJlSGtrOWhH?=
 =?utf-8?B?T01EMisyQVRLNDFFdVlwM1NlcGtjMVhDNG9DWlZTQUU4UVZOSmVRK3I2ODB0?=
 =?utf-8?B?NHoyODgrRHIvejhsNXJmdTVmVUl1YXVoMUJ1dk8wWUt0V3k2QmxLMmJwakJT?=
 =?utf-8?B?R3VkQytucEFDQlFPQzA3TmJNWVp2TG05ZmNRK3hwS2dVbE1Ja1RKaENvT3lK?=
 =?utf-8?B?MFN2NXdGQUcveVhjck1aREN5dktrMUx6WTA0cXZyajNNSDdUam1GbkRVUDdE?=
 =?utf-8?B?RnNwVnRtSkY5Y2grMVp1Ly9YbUY4Q2R1VHFHSGlYeVYreEc3RDRySEhNZVRD?=
 =?utf-8?B?eHdaK2NsUndFQWQ4WDJCUUtJQkRSZ1ZkdWVxR2lSaGtaMm5uazJnN0pnWm1H?=
 =?utf-8?B?eE5iYkliSzFraFVaRDhmQWlPV2ZZbEp6TS9hMVlxL05CMVUrMDdnYzZqTXI0?=
 =?utf-8?B?WEp2djd4OUZLQU5MV29PM3dVUjZBSldoZ05zWFJDbkhyc2NSZFRMeVJ5T0tN?=
 =?utf-8?B?UzFJdXFuQzRBTEVoRXRKRkVXcTNlV0FPWmpMeEJmbTlJc0ZhQUpCZTcrSEUw?=
 =?utf-8?B?bDBJMlBkQTVWNGhqc1h0SVA1MzdTR0dRZnRzVGJqUFVLWDBIWno0OUVwOWRF?=
 =?utf-8?B?aFdVOXpJSEx1Q0RSRjV4MnZRL0hyZm1yUWd3L1VoMzJ3bzRGaEQ2dm9kOUI4?=
 =?utf-8?B?dElSUWs3V3JTUUllbUZjVjQzK2lBc2dHZHVoc3l5d0xEY1NTNUlRTVNrZHh6?=
 =?utf-8?B?dXM4UUU1YmFTc0U0NnZ4cFJtTm14TWhjMW4xY0lMTFNXbDJuUUs0NFl2V3Rw?=
 =?utf-8?B?OTVwUGt0amJqMzdmY0UrN1JwTFVKM2VaM0xDa3RDUGpVa1ZoYVZ5dkNNRGJy?=
 =?utf-8?B?TlYzcVp5NGlUYnVVbjJMdjZEOTdMWkh5MmEzVEYzbXJYc0ROeEFhVUZjcFFn?=
 =?utf-8?B?d3FoMEN0N2llaXZJM0RJd3p0MmZ3ZUtnL29kOUhndGMydFZPbzNiMkNNSVB2?=
 =?utf-8?B?bUpZZ08rZlN1aldnbTVRVUQxTlFuWjdjbU9hNFhzR0tPdndBd3FPV1dtZ1Fz?=
 =?utf-8?B?NGlOeVliQklWZUd5aFFONy8yZ3hWUFg2R0wzaWIrd08vRTJkcUluemhkclNB?=
 =?utf-8?B?em83bHNxWHNhNGNiTnptdTVGRmtDcUoyMDJCY1RxRHUzbmpZNC8rb1VxdjZY?=
 =?utf-8?B?YUJQS245djQ0T0g0d3hwZHRGQlpPWHZOdXFuKzlRYkIxamQyODhlblVGb1ZM?=
 =?utf-8?B?U1Q2TTVxUStFYVdRV283YXdWWTZLbHozbHVwWTZBeU0wTTF1eXJxeHpmSTQy?=
 =?utf-8?B?bUN6a2c1UExab2hmbTdlcGFkcmJ6cGRZVVlIU29DNXNkRlFzQ2kzeVVLRi8x?=
 =?utf-8?B?L043dTdBRldacG5VTSsvclIwVTN6RVhlSm5YUWwrVGNIMnAvLzVtRTlvMlFK?=
 =?utf-8?B?eVJ2cnZ6QnZmZEVpMEpmdnNJbks5RjZZQ0NPcDZUMUd4VTFqQk1kQ2grVWdv?=
 =?utf-8?B?Ly9vYUNjcXdNamxsaHlkVmpLMzNRRXF0SVhkekRTREFrdGpNamZVSWU5TEwy?=
 =?utf-8?B?Sk5QME9rbFk5alVLcy85ZFFkWE5GSHlneVhhZTJOV0l0V2k2azRsSE90cWU0?=
 =?utf-8?B?NUxEazVhTjhSYTRYZUlLa3ZFcVFzNmZVQW5TOVRIVGsyNm1aSlNyNityUmE3?=
 =?utf-8?B?aThYY3BjK01HY2hNQ1ZoTTZJUnJQUlUwOXoxNkk5Q2VQeTNMT0IyWldDUzYy?=
 =?utf-8?B?djNCb3Q0azBOdmFsc0FFWFJ6bEtESG9uRm5JU084TXZsSG4vK1NnL3lVcGhB?=
 =?utf-8?B?dmJZTGhIRnljck1FS0JzSU9tN3UwS1liM2lONFNGTHVJNnllYlJLZ1QyQkpG?=
 =?utf-8?B?VWFvUXJVUGorakJUYWtjZUNuMiswaXpDdjBVR2tOY3RKUVM5Vm9tOUgyQW5F?=
 =?utf-8?B?allLNnBHOERZbVR1Zktyb3c5SWliNjA1cXl4Nld0WmFaSWJyVDZGd29PeFRs?=
 =?utf-8?Q?dG3or3mPyVL3W/Dp/C8E26w=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ed347f-b712-4233-925e-08ddb2e2bdad
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 05:48:27.5911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5+eR1tRMbgxWKs7hZggOPyLsii81dKT9iGWNMsE2B1p2vNNwirpGycOp+glv/GjIN5h7J+/VfPPO3Z4xqKZyxNDm/6LGV4zSTegmumjcC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9950
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

Christian,
Is there any news?

On 10.06.2025 10:29, Mikhail Kshevetskiy wrote:
> several fixes for airoha ethernet driver
>
> Changes v2:
>  * update patches description
>  * improve formatting a bit
>
> Changes v3:
>  * national letters were replaced with the corresponding english letters
>  * code was tested on 32-bit and 64-bit airoha boards both
>
> Mikhail Kshevetskiy (3):
>   drivers/net/airoha_eth: add missing terminator for compatible devices
>     list
>   drivers/net/airoha_eth: fix packet transmission errors
>   drivers/net/airoha_eth: fix stalling in package receiving
>
>  drivers/net/airoha_eth.c | 69 +++++++++++++++++++++++++++++++---------
>  1 file changed, 54 insertions(+), 15 deletions(-)
>
