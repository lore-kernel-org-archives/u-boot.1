Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DFBD38FE4
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 16:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF6A80433;
	Wed, 14 Jan 2026 17:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mIfYiI6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1265A8063E; Wed, 14 Jan 2026 17:27:46 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F348380325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 17:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CX7coGU2ssuDcMSb7C4Y68Hx1iOhGwwFaZkXoBtL7MGqwmiLXW1UKciKtYEGPpgUIbe9p9fviGPEQ4jalEJPo03ZxAltulcD3DDMTZSCG1jWpAIAiZyN5MN0T45MmCNbuCTbxhALgMmQ2QeoriRRzEY6LGOsS45EhUQcC3MJpFcUL9prBva4s8hgu5usPGYi3E+kd2RrVIvHgvGzv7tnh1fMcteumZyxis93QxS2BIzTuPE0XirNxW4k4WLNG1Er3dn5IGIywXK1xC8E7MOox+FYg3MXs6UyOFpkEh3GWTgD4s7gLzhZY+XDBr2mg6ypDDC1fBX2QUcYpySOg4y3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0WJATtWFiPFiWfDlzqbmMPejWr2RwkEGiQcuXiK1Rk=;
 b=CAUBCHpvDA/DDhoIt7XhN28wpllkKmrAAcUypuyCo6+JMSHajwc/zNY1bU6YBBY7nchjfeGneWQW60i+6mWhdkYYgC9tZngR3Of7/589TAJqSFWDAwEcLoJNkse19O+lS4bNaKH20HAn6eItYp+vnsk5LpKxoKkNsDzRY8HS5O4f2+Ip78SLf3TjoTv1xMDavJAFD40tsCZemltFGAUky9hrtW1jJxLoN2AOZgVkH+ak2gZabxTeQfX0Ans5uBKEaNbfxabJnWSUdQtt67Rw1YOM5LjPGyMoB4rlRXQcfdt4V64/HVyolDtpDfKR48qgMPT5g1fAh80gr9j3eqHPrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0WJATtWFiPFiWfDlzqbmMPejWr2RwkEGiQcuXiK1Rk=;
 b=mIfYiI6dYZFm/EtiK78/62CyEdxwQ+yYIgxofaFPag3dJlEIhCBVmKmRClazNvsALFeXga91nR+8xMll4IxZhn0ZAGcE+5ApvpYQNJaI/X0QwclsHDvXEBvvO0IJibHNZfWmXGDp+tsr3E1AFTnGlYL+L1qMR+Mw6SyRUdgPiEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV1PR04MB10455.eurprd04.prod.outlook.com (2603:10a6:150:1c8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:27:39 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 16:27:39 +0000
Message-ID: <fcb352fc-5fe1-4443-8c3a-153c182d6774@cherry.de>
Date: Wed, 14 Jan 2026 17:27:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3576: Allow pmu sram access for
 non-secure masters
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de
References: <20260108133234.4001390-1-jonas@kwiboo.se>
 <20260108133234.4001390-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260108133234.4001390-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV1PR04MB10455:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f7fa96-9eb0-4dcc-5415-08de5389d590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MG0vMWRIYlZxamUzYVBHdWVZU1M2ZVVIVGc2NnltZ0NDT1VHc3JmZ1pRd3NQ?=
 =?utf-8?B?Um9zWTJVODBsaThxc0xZUDVXYmIrOHdPYzA0QVlxVG8zb21yK3Vqa3VScVlC?=
 =?utf-8?B?Y1lFeUQ1QUJvOXdYOElWQjdhN1Y5ZWNZbEZaVFpEc2EwMXVPNktOZ1drMTdR?=
 =?utf-8?B?NmQ4L2txcng1MnBmeXd2YTNZdHJhdVRHMU5laENWbERkM3k3bkd6VUhrdlNm?=
 =?utf-8?B?QjU3U0dBeEsrV3FDU0V1SWxHRzdpd0RQUjBhWnlsOXdXb1BhaTFmSm54LzJi?=
 =?utf-8?B?NGIzVnFwMlZiaWtzbC9Uam9uVXFnVXJmMzdENC9Qd0lOMXFwT2x6d2MycFhl?=
 =?utf-8?B?T25ONnU1TXV4Z0UrNHdEeHpzQkNuanpqUGpRc1U1VTE4TEFRTHMzaVNOSE1m?=
 =?utf-8?B?bEYyT2hVdEoyb2M5aXVkclRSUzBZQ1ZRdzV6dCs4VVFEb3FCU3hDUGxOVmZD?=
 =?utf-8?B?WE5KSU5vaElES3hWS0pYNnNmYTJwMGYrY2pIRlB2elUzVDF1TGVPaFFBSW91?=
 =?utf-8?B?ZEFwYmV6YVN1Y29xUWszcXFSUXNvZE9Dd3VuSTIva1RNWGZLQjc1TFFqdEl6?=
 =?utf-8?B?YmI0SnpTeVZiYkJOZ2tsaVlhWnhETFljTEVaOENXR29rN09YKzRFVGhYK2gx?=
 =?utf-8?B?RjNRaS9DQ2trN00rYUo4Z3pLbElHR1ZnUTRpQjFiYWFYVE11YVdTT1Z6bDNl?=
 =?utf-8?B?NTJLRnYzbGNubURxdWpOZVZjazl5WTJFWWtzbDFxbmtHM05pbittMUpNbmR6?=
 =?utf-8?B?SFk3Ui82SDZPK08yT3BtVlJLZGkrUDdYMUVJQ1BFYk9qSFdwazV1dTJ3S2Mr?=
 =?utf-8?B?cVBxN3U1ZytIdVJTcnpQVkdRMDNOTXNtVGh5cWJicWhkTTBVTTB6ZjRNWkZ1?=
 =?utf-8?B?TnI1QkVXV3V5bExHQnJJcVFYc1NTNUgwQ0VNbmtZRDB4dEJBV0ZRenpCREJS?=
 =?utf-8?B?TUpWV3BNUTlBeXBMUDJvTWsyRFp3SUgzbklaSHdFV1J2L2xLaW94R3dCYjVG?=
 =?utf-8?B?a3puWHdVZWswMTNaMFpPcWhtSklKYjRzblROM1NUWE1MOFEwaTF1RldyVVpj?=
 =?utf-8?B?akF3SkFZelJOUW5WbGhmL28wTTJ0K2d4WHdxVXI2MGNnVGRXdlZ6ZXdYWk5H?=
 =?utf-8?B?cmVLNlljYnFFL0czdkxOOU9JaHBYRkNPa0svYjFnRGZjQnJqVlNINWljelQx?=
 =?utf-8?B?K1d2V2RoSHluUW5aL3FkbTVMbnUwelQrbUNnTGduc3dZbzBQUklEUWw3OENJ?=
 =?utf-8?B?R21qTlRUMUJ3SnJZdjJVdklIbllHUHE1TjMrMTZnTno4OXo2alRuNjlxUlZS?=
 =?utf-8?B?QjBvRkpYbUtWNHlUL3R6TVRiSzV0ZndaUFZzb3dUYUE1NTBFVjdiT2ZPanVH?=
 =?utf-8?B?WFFxaXhTdzRxSDUzZVJCRW5GNnZCMlI2UFFMbFhUYWRYR3BjMC9zSFV6a2tj?=
 =?utf-8?B?cCtxemZsdmNhdGFyNUZOZFQrc29NWGVaaEM4eDFPTWgzazRZVUMxMzdvOWFY?=
 =?utf-8?B?Sk1QUWg5YzNUc3VVZGRhK0l3TE1jdEVtbWVtR3NsNzVmbmtzZld5WFROUmZG?=
 =?utf-8?B?cUJKdmJXREZRdDc4Yy8vQjMxdVdodjlGb01JWGNKeVIyb1FSLzF5YStQNHJ3?=
 =?utf-8?B?b0tSc2xPSVRjZGNZditkWFNmS1ZSM0dneEdPZm1VMHlRK0RKU3doMWtrazY5?=
 =?utf-8?B?dEg1a2JhLzdyOEh4S2drWG5DaUF5WEdvUGdtYXFvVXhobFQyT3lBdDZrLzF6?=
 =?utf-8?B?b1FFQWgxeTU4eldSZ3Z3L0U4MkVMZ0V6Wno1V3hTWjBURTRFa0xaQStzUVZj?=
 =?utf-8?B?UUpRbit2cEF0Zmwvcyt2UHQ0UnhhUUg0bk42WnBFVFN6WnpQMlltaGNXVHFU?=
 =?utf-8?B?c3FSUDBKbVJtaUJraGh4N2E2b091b2R5Q0ZqWTJHTVQrbzl4OWZPdU9tNUVi?=
 =?utf-8?B?Z3Vqby9jZCsyNE9GdHB4a1FlSnN2N29udWNZY0xWV3NxdjFuc0RJOXIwa2tp?=
 =?utf-8?B?c2J2NUtKcjBKK3ppMEsyamVjR1Vad2lieFViald5Qk1FVWlkaGU5elB0N09t?=
 =?utf-8?B?M1R2SUtvZi9adk0vU2RWM1kralBYNGpOb2xQVXFIZEJXRWI0aDdNQmdwSm4w?=
 =?utf-8?Q?F76s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFdlMUVPSEN3Mm9lVDVpQmpnSXhOZzFsVUZmTVZZU0I3cncrVTJNTEFtUXNJ?=
 =?utf-8?B?bTlxU0VSd1A4Q0RVUDNGZWRNbTBVdHRYMVhoQ3BhR2NVdHQ2Z2FCSDBVeUYy?=
 =?utf-8?B?Wml3STUwZ09JMUpNR0lXUnQ1NW5jb2xTdjdwNzByRjJITzR1NnNlcEtHTXIv?=
 =?utf-8?B?a1hJS3dBamxhQnJHaTBRclIzdllyVkhvbVNiV0ZLaEI5MFZhcmtLdWcxdDBN?=
 =?utf-8?B?NVlmRGRnWHNzdXRsUGkvWE1DTUs2d1d1MU8zcUZCRlUrWUIvT0ZZd1FNZWhx?=
 =?utf-8?B?ZnNTaUdlMkNscStnd09RYlpnN3BTSVlyVFIrVTNYQ20zMjA0cW5GbUlkT0U3?=
 =?utf-8?B?MnUvSkFnQjNrL1FLYWNlRnNlYjJwc2hTUmpnbk5uZHp5bHB6dUlzNFZrZ1RG?=
 =?utf-8?B?R0xnSEtEZlBFUCtIWC9FdTZYSGFVZGpwUTJMTnB5ak1wb0ZjZENaa1FnTVFJ?=
 =?utf-8?B?ME9QbE5JckdIZVFmZ0hjQ3ZsbW9PRmpReW92MTdYTTV3RldFdzVTMC9wOWVD?=
 =?utf-8?B?Mk43QUtKL3E1QTBmK1ZhVHdJdjBqYkRZWDVmVW1qbWpqMXFuZG1lengxOEVL?=
 =?utf-8?B?YVdHajluZCtxU3dXNTJySlkxUlljRzlDZ2dXUGR4SHZLQXdKejhVVU5XN1hI?=
 =?utf-8?B?N3dCKzhXVXBzaitBR1VwaFJSMExzeDZaWng3NDZ5cTVXakFUUCsxNG9MTnFF?=
 =?utf-8?B?WHFLd1htVmVROEJWZmF3OVFLQ09zZmhIcVI1eEswSjRUVEhPMzlhK0NpZ1BF?=
 =?utf-8?B?eURyU0dpSDQvOTFZNldCSXpsTnh4QXIwajlSTVZ3MDdyS2NXb2F1UFRUTHhH?=
 =?utf-8?B?WWlZWU5Ob3JLdlI3bWpvVFh0UUVBdXBoOHQvUjRwcVAxeDRBZ051ZENNc1Y0?=
 =?utf-8?B?UVlPdGxITGlyUEJOOVgzVG44aHN6VnVMSGlFbUpkZ2pMUmQ2V0xqbXAxem9V?=
 =?utf-8?B?L1dTTkh1N0RDdnU3YkJKMXB5bGE2dWpoRnB0ekp1Tnk4cnJUR2lJN0x1SlQ2?=
 =?utf-8?B?QWxzNFdNSTdVTjZRZzE5MytTV2hvbWN1MDYzN1B6ZHM2NHZMRnRmTWpaWUJW?=
 =?utf-8?B?SGUyTnNPMktMRnJzZDdmM3FBdlQvVmlxdXZIeDJZQTRUOHY4QWpFNzgwaWJs?=
 =?utf-8?B?Z1BxelV4QjhYOWIzMUFZdGdTaUsrcVcwdG5HbkhLS21LTFErWWNqSXFkclI1?=
 =?utf-8?B?OTBhclNNQmlMUTNpQWlldkdHUGM5cFoycWdCd1JJbTRBc3hvVHlZUUFsWmFD?=
 =?utf-8?B?K05HdUJHVmRnTHJYWXpLQlhISzViL3JVU25LRVFiSFdpakNmWVhoVlMxd3JL?=
 =?utf-8?B?YlpoNXptQWhBZUVrVDlIS2xyWExuUEFaaHJmZGZXY1FmMHdHckpOb241dVlz?=
 =?utf-8?B?RFdEakhhQm52bU5VeEdtc0NTRFV6bkpSNWxtWk4ySEhMeHJrTGIzNlJVWGk3?=
 =?utf-8?B?NUV4VmJkSEZwNnhCejVNRDc1K3daZWxrTU5XOWs1YUhvSUtjSUZZZjRQVXNq?=
 =?utf-8?B?Wm53VHBXYzgvNHNpRTlPVzU1V0lKSkFBVHo1Tmxwa2xRemdGNmFKS0J4MkpK?=
 =?utf-8?B?WENBQmVTR2toL0hzaTRiZHhDdW04SjRKZ25XNUd3N0ppWWpCMHZXWDFtUUVN?=
 =?utf-8?B?ekF6T3AvRzdzV3hsbldhVERDRDhpajZBUDl4dnRqWUlVcUJnRVpkSzR3Vmc4?=
 =?utf-8?B?cFlnUjhLVXJnSjQ3ZmVsbkFsa0dYWmVYSVhRVDlNa3RSc293NUJWUmZYZCsr?=
 =?utf-8?B?cW8yall0VmNiek0rYy9qOFVTK1plSGt1c2x4Vjg1YW9WbjNSRkhDTGcvVlVW?=
 =?utf-8?B?M3haelhaeTlWMG1HVjhFYVhJcVZrZmozeGF3NEV0NU9tRmtDOU9hbEl4YXhm?=
 =?utf-8?B?bnoyUTYvVzFSdUJ1NEx6d1g1T3ZlQkg5eHVoNGIrWHRUTEUzZzJuRTJFampB?=
 =?utf-8?B?V3BDcmt5OUJoUkY1ZEtvQlVTbUhpU0tGdHhUM3VIQTRCSnlhQ2NKZU02SU5S?=
 =?utf-8?B?K0orN3BFRkx3UFdsdHN5MW5lb3RTREtvaGF5Wk1jaEgwSTZyOXBTLzF4aC9u?=
 =?utf-8?B?eEVocThHdjdhQUNjcHU5RUgzdnNDZFN2WktwYXo1M0VheVRMRk1Bc0F5clJX?=
 =?utf-8?B?NjYvN2NUeGx1Ky9MMndnYmlSNStBMlZEaDZJMVFwdFpQK3pmUGhVYlZlRXpJ?=
 =?utf-8?B?cEhVd1FXWStJZFdWQTdlR29YNVJtWit4Z1d2THlFK0J2M2lBb0hiOUI2bWp0?=
 =?utf-8?B?VDdxQ2FuUzR5VktETEx1dkkzVU5VVXMxeHh3Sk04d3BLYktUaFNaci9QZ2JD?=
 =?utf-8?B?ejVKWldhRmtscW4yWUZIRjB1UEl1RVF5c0g1bmpNWGlKWjJNOXVwZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f7fa96-9eb0-4dcc-5415-08de5389d590
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:27:39.2806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRmSWQDoe/pLhKYWfWJes4kX8FwJRmHkhazkAMSks3JtsNuwGm5C71lYmAnTjHBQP2JD5Fnm7xavgJsAeBpu94VplHzei2VUJMtCt16/gLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10455
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

Hi Jonas,

On 1/8/26 2:32 PM, Jonas Karlman wrote:
> The firewall block access to pmu sram for non-secure masters by default
> after reset (0xffffbfff).
> 
> Change the pmu lookup configuration to match the default lookup config
> for ddr and system sram (0xffff3fff) to allow loading TF-A using DMA.
> 

What is this "default" lookup config and where does it come from? You 
say it's 0xffffbfff after reset and it's set to something different 
after a TF-A has configured the firewall... Is it after a cold boot? 
That somehow is different than a warm reset maybe?

> Mainline TF-A will re-configure the firewall to use an even less
> restrictive lookup (0xbffe3ff0), so this change is not expected to have

[1][2]

> any real security implication.
> 

[1] 
https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/rockchip/rk3576/drivers/secure/firewall.c#L522C36-L522C46
[2] 
https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/rockchip/rk3576/drivers/secure/firewall.c#L611-L613

For the proof :)

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/mach-rockchip/rk3576/rk3576.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
> index a1e8a7572fa4..c17ba418ced5 100644
> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
> @@ -26,6 +26,9 @@
>   #define SYS_SGRF_SOC_CON15	0x005C
>   #define SYS_SGRF_SOC_CON20	0x0070
>   
> +#define FW_PMU1SGRF_BASE	0x26003000
> +#define PMU1SGRF_SLV_LOOKUP0	0x80
> +

How about using the same names as in TF-A?

PMU1SGRF_FW_BASE instead of FW_PMU1SGRF_BASE and
FW_PMU_SGRF_SLV_LOOKUP(x) instead of PMU1SGRF_SLV_LOOKUP0?

I cannot test this as I don't have an RK3576 board but it looks ok to me.

Cheers,
Quentin
