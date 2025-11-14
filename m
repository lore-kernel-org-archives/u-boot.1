Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA91CE7AAD
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 10:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD6483F4F;
	Fri, 14 Nov 2025 11:54:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="avFDfoA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5562083FA3; Fri, 14 Nov 2025 11:54:10 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6644483EF5
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 11:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/JzpPsuWTbif2iTPmsSZPaGfSv1nXzFYOuJiyIxoajWhV/4l3RwUVx4Z1Be2hridMQbN745kftqdXpQOUdnKsLOVw4FiAHwN+b+k3h7pauRT+jZcDNnw0GtTJXuu7ig52dxAdSjgpaicR2YFv0ptp60+ZY2LezMFUvLgX0ZyQ2yJJPX1G5aJk41BovT3xzxJe6G+hQajJaxVbfgf7tnmakmUg1tOzbBWK519uhF462x1f3F9hHK6+hRy4xUrdQiUH682v17bKdgnALOVzkZ2EALT68x72SM+OeEjz1qFOqBS0qrd1hH1K+DTGyco2Dq4yPFM0gVjl55SNw+fCVJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtovFqzwPE2GCWVtV7t14rJ0IUORqLtdk1N/LPaMju0=;
 b=spb36hwRMTBvwGH7xO+bpi/hpG5oG7S5+lex7IzfIqQx9ZT/1oq7Y7T33ZUkcjWAuHc9gFJIV9Wo7evBc6WpUi69f/uwpClRjXUkWz0qMJB8FoUQpS/3Mam1DZre87wTScHTRXd3+398HD4Iofb0RSerVZBJ8Q0ApwgbL5eGQ1YIB6v5DQj6jYHKbyTHXQOcvpaoXcUgncPuzx0vBjDLHY0CaOqIapbxyRA6nz5UHVAJNvITLUumrSoW3bPo6eDZ+GxTQBHm4+wLle73rqKcYPyD4nUS9ZwpGfcm/7/gWiQBtKycq9N/Lb7GjsY1cXG7bLMrVfk3asPrTFOtrXTuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtovFqzwPE2GCWVtV7t14rJ0IUORqLtdk1N/LPaMju0=;
 b=avFDfoA9c/YrMjZOwVhkYYxKFJ3kuvDLsw1zMDTfbsFG95YtaJVo/yIYWPL2nJ4wj4WGPKqIJSVrfkqHLup8listFmRKIm0KFfI7IpSgelzi1nbgmKBUATYbobxSDrU++HTsWsnU5ytHMY2QnF5k4j8e9iL0AkeUDXBrbnXKuoGZqvNOKuBYFGWOcxy5vePlnKlRmL9vkz3s0ohxUyqme5odNsjUAgDDY9mXtH0hBuaeeoHrQ0TvWORmaLN+38wgU2DHhaV8C6R+hCXQ31rhg6QVny1xMUR7IpG8zwrXjZn2isRESzj04CTRSIeA+DvVBZh3RepESlYaq88cVG3jqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3935.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:160::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 10:54:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 10:54:05 +0000
Message-ID: <0c48f4de-0da8-4d95-8070-f4382ef344f8@siemens.com>
Date: Fri, 14 Nov 2025 11:54:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/26] arm: socfpga: agilex5: Add new driver model for
 system manager in Agilex5
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-2-alif.zakuan.yuslaimi@intel.com>
 <DM8PR11MB559296B2DEB7CB7AA6253B7BD2C52@DM8PR11MB5592.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <DM8PR11MB559296B2DEB7CB7AA6253B7BD2C52@DM8PR11MB5592.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3935:EE_
X-MS-Office365-Filtering-Correlation-Id: 533c6b8a-8570-43ca-0126-08de236c20cc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkc3cEhic2U4a2x6MEYvTEJXSXAzeGVXZ1JMTzN6L0MrTEJSUThFdXhzVzNX?=
 =?utf-8?B?c3Zka0UwN1NQdmRsM1d0QWVRRDhDS1lvTXc4bndUTTRpaGJOaE9XdTZWMUxM?=
 =?utf-8?B?WmFOOHNxWmliVXh4azNOVVhoUkZDbllHKzN6N2ZLaFo2UU9MU3hPSmtzdGFU?=
 =?utf-8?B?ekJWTGlsUDZCYzBIQ3RzYVhUZDloUVpqZUxqUTVmWU43THJZeHlrQUdiVXRR?=
 =?utf-8?B?Z3B0bUpBOGtsY244NnZxZkZoOE9aWlVMMURadFZvYzBFWnQ1ZmN0WHdJWkRt?=
 =?utf-8?B?UHQzdnZpcEJtNGtXdCtUWkM0MXVSeDMydXo0SEVCdHRqMTVZY0tVSnNkbDVm?=
 =?utf-8?B?cHprRDNRTWkvUmJpUmNYcUMxV3FDRzlGRnVDYWtxc0wzTExwSlcwRmMwYWFX?=
 =?utf-8?B?U254K1p4ajNZYXBhSjM4U0ExcGp5YUN3MitVN2JJWEw5WUNSZlFBZG52anFV?=
 =?utf-8?B?WlVTcDZNMXZjaVNidnMxbVV6UEVsaUlLMzczb08xMzd2djdpQldmaEFuYlN5?=
 =?utf-8?B?WDlHZGdvM3FiVE9TMDFiQWJocCs2NmxPbE9CZDNHUG5HSVdZVzRZaGs0SkZp?=
 =?utf-8?B?VElzQlQyZlU3RDE4YUVpejBEcisyZ1kzOWJaeHBDdVFsSnBlMno4RGNBUVZW?=
 =?utf-8?B?aGhwVENrZlozV1hxcklFUUZpSEZkYUw2cWFJR1BGR3gvQy9tTzRyMWc1UEkr?=
 =?utf-8?B?TkhocmlHVWlXNEtMcXhhOUQvNnNaQ2JscVY5b0ppWVFmVm5vcGNQNEI5ZXZ4?=
 =?utf-8?B?SFlyVS9LdWxwUmxCa0hnWm9QRkROazdNMy81VlhJZWJ4ZXR4ZTBuQk41UXRJ?=
 =?utf-8?B?RzUxN3oyZUZ3M3AvbWtySko2dHU4ZjBZQjBmS09LbTQvb0wyWFF1Q01VUHgz?=
 =?utf-8?B?UlVyWElVMmZ2U2I5c0kwYnFUOTFRTDQvRzhaelpTTHRuRis5V2l1RXJQcEdI?=
 =?utf-8?B?UTA4K09JelcxMzljbzZCZ2ErYys3VEJac2hUNGhCYzdxTHM4NU9uQU1ZTFBz?=
 =?utf-8?B?ZFRRbkI2M2FSVzhSbDVSZkN6eVA2Q3FjaG9XSlg0cmwzSGwzMXRDdjFhcDF3?=
 =?utf-8?B?M0J6QS8wcndDR0RPVWt4Wk9UbGZ0elgyMVNsS3BEUjJDWmNlc3FEYmhVWVdy?=
 =?utf-8?B?Rk1BZWVQbzlRWHQzNzk2dm92ZVhOajJXMWlrWi9nNVFsNmFjbkFSeGNiN0lK?=
 =?utf-8?B?RExndDJoblZ0NDV1R2FLeEUzVkhLejNqcVZ2d0R6aHNDL2MrazRmRnllSmwy?=
 =?utf-8?B?ZGZMRzhEZkkxNEpmSjBycDErL0M2cUZpTERveUhIVzFqRW9xZ0dMbzI0OWw3?=
 =?utf-8?B?U3I4cG9hTjhiUkRtM1RTSEFob2VUYzdEOE5aMFh0KzhEb2ZOQ3F2bnpJd3pY?=
 =?utf-8?B?V3hlUndRODBydCtnaUc0UHk1dk5JZVdRbTYybkgzdWJJbFpGNmZ6TEpSVmxW?=
 =?utf-8?B?M2FEaXlycWlrU1FOTjBFV1FXd1pUbFY5c3RkTmJZYkpOa0Rzc3lOaG0rN0VQ?=
 =?utf-8?B?RjF5NmNaM2pXL0xWem9xeTdBQVdRVXVpMkdRUWt4T003bGNSQUhVNFhLbHBE?=
 =?utf-8?B?KzV3U3U0VjBlU3F2UTY5U2Q1TFkyZWFVYURxNlBJRFB6SjFySXU5RTR3T0NL?=
 =?utf-8?B?eUpuSWxvNkVRV3R3S0xJZFk3c2JZeE0xc2MvSTlPNkJUbkR2NTN4V2pwZ3Y5?=
 =?utf-8?B?YjlXSmNJQ3ZFSWxNRGFqWGN3dTZ1cmRpcGYzQ2dGNEZrdGtMWVBIOTdhdXdD?=
 =?utf-8?B?T3krcG1TdGxkem5IM1pGU0FCSjdzbGYwMmx0N2hWNDhYeEdpcXlsQnhmL21y?=
 =?utf-8?B?OVZpWWsrbngrRk1zUGI4SzJmWFVSZlJmS0xXTDNmQ1JSMnp0c0NpRGxDNmM3?=
 =?utf-8?B?Z2FoVU02Q2FTaVRIajRTT2xTZ3NiNTVKKzhDQUNMaVdRdHVORUtPai9jRmkr?=
 =?utf-8?Q?LrILs6P10LQdB6MetCwYjLWlRWtcEji/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1BnbWE3ekFBbURFM2FhNHpNZGxvQlMrcnpiU2I5K2t1V3dTd2tXUVhZdkls?=
 =?utf-8?B?eHdpbTJJbytXN3N3S2hMejZieml1VzRxM1gydjZwUG1hSGdEakdJWHFkTGx4?=
 =?utf-8?B?K0lvY0xSbGhzeGdnaWFFZGFYNGV5U0NmVjZteVpxekdyMm00OFVSenhIcmtZ?=
 =?utf-8?B?UVRudmZMM3BrekUzS3I0djBnSVMxbUp6cGRqQ0FSWDkzbThoSk9TVDhRRG00?=
 =?utf-8?B?WjRFWEFBd1ErZFEvdFBseXMzYzFsdWNZUzI3MmVmRDkxVHp5WVBTZEtNYTlz?=
 =?utf-8?B?NmRRZGE0R2NIQ08xVDJJWlRwUEZITE1lc0FrdHBoajV1dVZNMm5LdUZvc0p2?=
 =?utf-8?B?d0tCUGtIY0VzazZCTHM0TUhPM2RoblB1cy9zMVhUdXUrY0tjWkZZeko3WUt6?=
 =?utf-8?B?RU9sWGlkbHpZcS9xSE1GRXRiNlNLZ1p1VDZFSE0xbXR4OXhyQWRHaDdzS1JU?=
 =?utf-8?B?MnhhMVJzdzJ4aUN0M1NOTEg3MjVCVEMxMm1uVEdXU3AycmRrdXVFUDd0ZEJv?=
 =?utf-8?B?UzJQeHp2R0NUN0hLMzF2TDllRk10cGJGTTV3UExKMnRxYVNhcXRzYjRLY0hh?=
 =?utf-8?B?eTdkcWVYdzIvcG0yajNIbXNUSFAzK0VHdWxVU1UxS2xQeFhkRmFnVnNyU0pu?=
 =?utf-8?B?RzJTdUt4RU02Q0NUU09vNzRmWlc3MlZMd3JnWEVyZlNjcDlzREptSGpSTU0w?=
 =?utf-8?B?cTdxSDN2ME1ieFBIdnhieUxIOWRFVy8zcnNmODJ2SmdMUWEyZXpnZEVnWWRH?=
 =?utf-8?B?dEx3QlVWbmx0MThZRWNpejlJcUc5QWI1c0FaUnhNMWxGOFdMZzQ4TVQvSUlt?=
 =?utf-8?B?clBuQnR6WUFwWTN1UzlYK2pzZ25xeWlJRjJtWG13YlhGeE5xekF4V2FleTdT?=
 =?utf-8?B?L1dRMVVpWVVPMFBHVEduU3RUZm93d3c3aTJBa0VZQjIweDkyYkJVQW9EL2NQ?=
 =?utf-8?B?akkvU2JEL3NaU2VsNHZnYndxak01d256YUJXNHBkYjZXYVFwY2ZzR2JaM2hO?=
 =?utf-8?B?cmZiUEt1VUJSWkpkSFZsWTM2cU1zMW5hQ1FpTXFrd2UwV2Fha3lKVStLaStt?=
 =?utf-8?B?MWJWZ3dYdXpLcndBcUFFZ0kxVmFqRlRKRUFmb1Ntck9zbkp4Z1lJTGpNazF3?=
 =?utf-8?B?TjlnalNuVVovYm9xYisrL1FpSSswQVdQZTI1a09NM2NkQ1FoVGhWUWQvQXpJ?=
 =?utf-8?B?aWx2bEFQby84YkhTVnArSmpQM3Z3ZE52ZVQ1SGdHakgwOTUwcUpBWHgrSTJY?=
 =?utf-8?B?Z0xKRnVGbFd5VHZ1VkhwdXllcnZsYUZnYm9ZR2REU2RFRU95KzcyaXZDQlVv?=
 =?utf-8?B?K2pSVWYrbTFEL3MrMHRTMVR3V3U0UmErN3pWMmFtQ0VqZzZVckhRQzVGMjBH?=
 =?utf-8?B?QkJSeUhlQS9BS28weE1PMFNKaFpqdUo0NjlycWh2ZnJsTUtsc2RERTJGNDBp?=
 =?utf-8?B?elhqdkU4TklXeWZjRTU1S0hiaFJ6R3lnd3BIdHpPNURxZldVQTFmRHlzZjZi?=
 =?utf-8?B?S1FqdXQ1dFllWkYwUjVqaDQ2bUNkQ2svckx4WGhXb1lrMk8wbE10N0NOOXVi?=
 =?utf-8?B?aXhvN0VVTFFXKzM0YmViZk5HT2RUWjRnUkZ5ZElSbUdhN0hwY1E4Ym1QdWFq?=
 =?utf-8?B?QThSUlNiTHo1NVJST05tRlRrWmJFSVJnUHRIWCtzaFR5YjY1Y2g2aVIxTTFF?=
 =?utf-8?B?Q1NKdnBGSTZEQkJSSWhFcXNMSkVGV01LeTFqVmxjMUZuWXcvN3dVckhwZUsw?=
 =?utf-8?B?QzNsTEV6OVBZTHF6Y2lQZ0k3VnM0SG9XclA1NGNtRnVuVVVHTnIxbkdTUGtX?=
 =?utf-8?B?bk50a3V1WjgrMjNETndGWU9JMjc5SjQ5dzVtMTdyVDRWT2Q0YTlVTEVZSlk1?=
 =?utf-8?B?U0ptUE5PVGhjZkdOaklaM2o1cWppK3hFK3oxdmRMUCtnUXk1dnM2ODhLbzFK?=
 =?utf-8?B?T0xvcTNLVS9wakVuUVVVOHFCVE5nMmVMbWJtWk1jazBSMVRzZVNpYXk5V2la?=
 =?utf-8?B?Nkc1UHIyYmhOcGxqbWRuRDFzQUNoK2dJb3FSdU5GVUs0dmNxRzBHYXV5N1c1?=
 =?utf-8?B?WHExVkowazRPQWZEQXE4YVRxVmRpdThrVElsTXNBaXVqUWpDS1Njdi9RTUVD?=
 =?utf-8?Q?kIvBEcbRD7nW89g9gJO1SvxCi?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533c6b8a-8570-43ca-0126-08de236c20cc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 10:54:05.2279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KB8+svoQkNE06SDUxsouQP/sG72mwAmM/zEBss9AT5cNXLl58vi8lpOzvzqM4+oq3p2870VgELNnMxderNdYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3935
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

On 19.02.25 07:37, Chee, Tien Fong wrote:
> 
> 
> -----Original Message-----
> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@intel.com> 
> Sent: Tuesday, February 18, 2025 4:35 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>; Tien Fong Chee <tien.fong.chee@altera.com>; Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>; Tingting Meng <tingting.meng@altera.com>; Boon Khai Ng <boon.khai.ng@altera.com>; Kok Kiang Hea <kok.kiang.hea@altera.com>; Chee, Tien Fong <tien.fong.chee@intel.com>
> Subject: [PATCH v2 01/26] arm: socfpga: agilex5: Add new driver model for system manager in Agilex5
> 
> From: Tien Fong Chee <tien.fong.chee@intel.com>
> 
> Initial creation of new system manager driver.
> 
> Add supports for the SOCFPGA System Manager Register block which aggregates different peripheral function into one area.
> On 64 bit ARM parts, the system manager only can be accessed during
> EL3 mode, this driver model provide user the high level access to system register and abstract user from low level access.
> 
> The base address of system manager can be retrieved using DT framework through the System Manager driver.
> 
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> 
> ---
> 
> v1->v2
> - Implement system manager driver to move towards DT probing
> ---
>  arch/arm/mach-socfpga/Makefile                |   3 +-
>  arch/arm/mach-socfpga/altera-sysmgr.c         | 113 ++++++++++++++++
>  .../mach-socfpga/include/mach/altera-sysmgr.h |  16 +++
>  arch/arm/mach-socfpga/include/mach/misc.h     |   2 +
>  .../include/mach/system_manager_soc64.h       | 128 ++++++++++++------
>  arch/arm/mach-socfpga/misc.c                  |  18 ++-
>  board/intel/agilex5-socdk/Makefile            |   7 +
>  board/intel/agilex5-socdk/socfpga.c           |  12 ++
>  configs/socfpga_agilex5_defconfig             |   1 +
>  9 files changed, 250 insertions(+), 50 deletions(-)  create mode 100644 arch/arm/mach-socfpga/altera-sysmgr.c
>  create mode 100644 arch/arm/mach-socfpga/include/mach/altera-sysmgr.h
>  create mode 100644 board/intel/agilex5-socdk/Makefile
>  create mode 100644 board/intel/agilex5-socdk/socfpga.c
> 
> [...]
> 
> Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>
> 
> Best regards,
> Tien Fong

This very likely broke all targets except for the agilex5. It definitely 
broke the cyclone5.

diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 9d464307665..e0ed1b8e954 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -248,6 +248,12 @@ void socfpga_get_managers_addr(void)
 	if (ret)
 		hang();
 
+#ifndef CONFIG_TARGET_SOCFPGA_AGILEX
+	ret = socfpga_get_base_addr("altr,sys-mgr", &socfpga_sysmgr_base);
+	if (ret)
+		hang();
+#endif
+
 #ifdef CONFIG_TARGET_SOCFPGA_AGILEX
 	ret = socfpga_get_base_addr("intel,agilex-clkmgr",
 				    &socfpga_clkmgr_base);

Arent't you testing for older designs anymore?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
