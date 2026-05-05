Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58F2CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9503848EA;
	Tue,  5 May 2026 14:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="M6+V0lt+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAA1684903; Tue,  5 May 2026 14:39:34 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BD08848D8
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycmqt2UZ72VgigW+L9dH4sRhweKvNYum7JhrHag83fQL7shAs8dUBLLG9hGSjDwUEd4OvoWh7P9axzh6/vHkgparxW65hzohS8Afzkd+nFahnxW6xcoDXnOaxagxydjNjLnvN+9oPyScXvLHOgh2qCqH9AH2KP2PKZkttIsmtRaA2yUe0SIG8nEI8TEk5ku6gJrZPppdj6wiztnhLgRat19WuZ3FzckPs9TK8LGiMveDDPT7KmbbtZWigDkeQ8hqU/ICERwyMOHkFIzKVfCxIEDm93i5/NBGptBgCcmBElS31GsHo/FecDnXCBiC7IjiYm6jGo3Jm2MHJGmXghcPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wfrR9H+wHjUtHVNWzL7beDcsG6DYne4PjaSnD0GjPE=;
 b=kMZYALJNgwhhj+NzX+WcBHdc5ej6DnxyWfSBP8GfsNi8nvsktHkcgyzER2VzZD7RPrP02Dd+ygthLNWhcHNOaTMlq8DMk+6oTj/iOsrw/YmPfidLLqMzTobFHHpW82np3Gb59yfxG1xtvxjwHE8n1B9rKoyB51cgSzYjAxTiMBDcDxiD77lhLbrbqlRasSu0zt3VabTIh8Ae3PXlIXEjFWUp+DMEaMkldnpYJB8xTdr5hL74xzEcfgmI3ufKVAMp8NHAh8ta6zcJY2P1fDsUdyR8NVY8jAmWpOl/pJAKnkpF1AZT7HQAccb4GyFbz5uAGusm2r+IMizoJWru7bHlzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wfrR9H+wHjUtHVNWzL7beDcsG6DYne4PjaSnD0GjPE=;
 b=M6+V0lt+eyM/qZBfHH5oh691UYafQkOQ28V/h0mmFKDH4A69TUt5ylCbiWuZCohVhgdqVe6RWwhHgVf6m2IUha9f/c64/UyvLFFIob0NW4B+lhKZpbVAj2zkTueNWqPN51dQvMQ+bC5OhzquLOQ522/wUPY0KAFjGdIHwhmYmNPSsfa+q+pWuSwd0T5ECLMKQ8hfHvINFp4C6Xt8ZVlQXtN4wDPN9EKmxz41O4lcI/jW4xaJObsgpQZCx2opZzVf/BdKrdFd0xw9xQLxu9n/06j4NETTMzuUnv0IEL8FoCVvNnWFcDfPI3ORDunkU8GtQSSmMUZnUyWOhrAgLrO4Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by GV1PR10MB8345.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 12:39:30 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 12:39:30 +0000
Message-ID: <95621f94-8398-4f60-912a-1c23fe79bca9@siemens.com>
Date: Tue, 5 May 2026 14:37:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v2,0/4] Improve FIT signature handling
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
 <CAFLszThcmzcAewzvjN_4kY4FR6rGknHmWUF4GNha__4h2uCqAA@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAFLszThcmzcAewzvjN_4kY4FR6rGknHmWUF4GNha__4h2uCqAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0303.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::8) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|GV1PR10MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: cec748d3-3229-4c85-b893-08deaaa35a3a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|3122999024|18002099003|56012099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: PFX+wfjhslB15MRxpQoPxrpXyp3tWvPQfTbwvYdDvyMgH98uKCz7iUTAxRQoISNgLXQWDmkuPnVN+ID4mJ6OQZGO7J5eogZN7zImoEa0KNRiahy9+ejeSfAuWe/0vV/e0Y6qyCTaGnw/KQwl4XYML3p0Lm66cBzvZ6ZrQxt+JDbvx3JTev5oHMLSa6w9Mnp5aCRnGtKAwxLfOBbRnnIHjpaurR9+7DJ3OjoEUkhkUHpU9kMSVyG5tKWegNqdJrLHTsdvNAHwJ5yYWpONfox+scf/t3fBNoKW9fPBDXvlKpFZV8fMOEEaYGuGLy0qRt9p3vipztszTedkTrqtKDN5LQs2BEvG3ituuu3QVFqxAxqSVsmakL8wqWMMUsXS9O1d4L6rbxTt9yWjdiYse/u++0QHBQUwl72k25ZBc6+TT4lV76fU0vNwGJQQq/o34DAaoqx7Op3AAyI4vxtbtGTX44To3sDcGmHqwFxcJIW1z0LkN0iCDyDRhFMytdkLe9Ls9re6GYbmC4h+BykiDXRqxwwkLds0WtF4DntX084mC9pFmGmaijp+uZuwmA0fBgKBgXzm70CVgOu0beIpnEo/+FMQS7oYee1VZlinii4XM1Zrf9zRkgTeQiYl4oTeJdEVFA7axG4VjIEk2ZO/AF2Ucg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(3122999024)(18002099003)(56012099003)(55112099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXRRNFRlZzhKOTZZZnppZStVdCtodVJWZCtGNzI1WUdoVjJrbXE4RmRncFcv?=
 =?utf-8?B?dlhLZWRaSzFEcFBJRjBvd2NINFJQbno2VUJ3VnZLSGt6OHRhSmZVeXZsL3l5?=
 =?utf-8?B?UUdJV2ZLdzZHVXRyZW1ZK1I0SmlVVWdCRHRhKzF5RERhQ2dxT1VuZ1M0K1hw?=
 =?utf-8?B?RTJ5Qm51QW8xa0plMTFlZS9EVXdSUVIrVDVKMW5sWWdiVWQzdEZ3QnRQTldX?=
 =?utf-8?B?eC9GaUwzQyt3K0RBVitKTnhVVUF0ajUvRkp4ZFZ3OFNLYUFWb0dhejZvaFdV?=
 =?utf-8?B?MUNCdjEwZ2xIbTM3QS90dENkVThHSi9UM0xQUy94SGo1UStiNEpDaXBVMUZz?=
 =?utf-8?B?Y0hIcHl1YUw0Ry9laE92ajZIenpVWUV5TDBvdjZXNmEzSmdRUEhQQTlYc1FI?=
 =?utf-8?B?b3ZaZEFrNXdIVG9xakR4L2hzY0dtUW14SG5ub0daaklrR0M5eWhML0x2THg3?=
 =?utf-8?B?dXZmSlpDSGhFdkRjUEs2ZUgvdG5jbTRhMmJzM3ZBWGp2WFRVN0JHU3lFOGZV?=
 =?utf-8?B?V2RKUjJ3aEVuY0syVWRiQWZmVjR0U2p1dkhjbnhxWUR4SjJHdURaYUdwaVkw?=
 =?utf-8?B?cHNvWEJ2SVlDdWY0aURUVDRtb1hwUy84dlVFZEhLaVE5dENuOUlmRnd0YWlY?=
 =?utf-8?B?ei9pY0xoY2ZQZ0ZFc0k3bi9QWjY1R1Qya2NZbnUxMVF4RXNlSHQ4eWFjUU91?=
 =?utf-8?B?MUpSVFlLaU5ONjZVS1RMNXFpa0hWK0Rkb2ZGdnV5a3R3S3RvckVOTGhSSzJq?=
 =?utf-8?B?K1p4MVBCWkV3WTFzbHppb3NqQkxhQjh2KzlDcCtTNkJBMTJNUjJjNDIydEtL?=
 =?utf-8?B?UUlPNElWRXVpcTVwbDJLNjhlODFlWE1XWU5kUkF4WWQ5ZkZyd01CUmFMbTli?=
 =?utf-8?B?NjZ0VXlsc0FyNkpSZ2FObWpWREYvMk9mSW81bWVleGMxUHd1RFRMazg2ZDYx?=
 =?utf-8?B?NWlzWmJIbi8reFhjUitBLzZnaTFjV1E5YjF2WHFFZitTOVNhRy9JS2lmeG1Z?=
 =?utf-8?B?N29GN1BFRUFnMjdsOVphSElWQlQzRU1Zazh0MVNHL2ROS0ExVTYvbzBGWlBh?=
 =?utf-8?B?WFBHUTNuUFA0RnREOXMvTXNOTWlaN0N4TUhHQUpMZENsV0QyQ0JaM1ZyMVpS?=
 =?utf-8?B?TUJrc1JPZzlMVTdGcm85c3hBUklNYzFjYTlGeG8ydDFjVE53RTA0SFpmWnBC?=
 =?utf-8?B?L09DWEhtYkhSeklOWWtKanEzY0dNdDl3T0pPbWZmS2JORERNaUl6Q2hVRVF2?=
 =?utf-8?B?WndGM3lpUGN2SXRjMkY3M3lEZEcxekNIdmx6WU02MWhpNkk0WVVpMHByRkZw?=
 =?utf-8?B?T3BZaTJpa1BKdUIwNnRHSW5Vem5QeVJlbXNBeTg1UEdpeDV3YTkrbHFKRW4w?=
 =?utf-8?B?YWRxckFBYi9KeWZ2OWhoTDBQaGJYMm5QTEwzTDB2WDJYWmVLLzNWbnYweHky?=
 =?utf-8?B?ZzVpc290WHo2ZTF4aDI1ck01RGVKM2ZPekJqN1ZqZlU0Z3RPdFE5R2FWSXJS?=
 =?utf-8?B?YlhLOGlqaWNUcSttSUxOR3dpRDJMbldEeVlGcUM1OGxzaEdOTjJicmJnbnFB?=
 =?utf-8?B?M3d4RlRGa3hVYnRDclJKWFRIVytxZFJCTDd6U24vcVNNT1c4WndxVDREQjkv?=
 =?utf-8?B?MHk1UlpmRkpWREtaRnFtY0VLVDE5bW9sc1pKSkk0ZGN2TzE2L2hkcUZXSjRx?=
 =?utf-8?B?UWJNeUVEVi9HV1RTdENvU0VndnlmUURKWlFzR1RrMHRlS0EyV3d0S2YrWmw2?=
 =?utf-8?B?NmVURTlxS2pjRjBHbkpaZ1NVdk5aTjVKMHA2WnR1Nzd6UEQ3Y3Z6ZlVKbGZv?=
 =?utf-8?B?eVJEeHMvZUpZTWhrcmNLbnprQWhRcGU4VXV6aUt1cndEMTFOeHhlN1YvdTlN?=
 =?utf-8?B?QVFOZERJcUJiQ3YrZU1TaFdocGJGSjI3TVBKY0J5cEF3Y3pqZHpxUEdiMDhq?=
 =?utf-8?B?NytTVXBaQVU4Q3kwUVdaeHpyYlRsUGZKRkc1S3ZXaWg1WktuMEVLcm5Wd0ND?=
 =?utf-8?B?aGZHWUE1WFdWNExZNzVhZVgvSXc4Qm96bm5YNS90KzZONHllaFZSS3JBNThp?=
 =?utf-8?B?Z0U4SVJyQUk3MGM4OEpId3dvSXVtQ0NvTlZHQnRlbHBhVnAvcU9jTjhpZFdF?=
 =?utf-8?B?MUNSY0xzWThHNmY2bzcxNnhzK29zZHdxYW9Hek4xdHpzMTVzYVIydUtER0Yy?=
 =?utf-8?B?OEhDVnk0ZVd5SDl6Y3FrMFhLMEN5eU5NSzdrem14UGpvWU5sUDI2Ly9qdDFO?=
 =?utf-8?B?OWFuSjZmT1ZrQlo5cmUvVTdnV0hLSkhsZDRKc3hmR0kwK3NGUldFOXpScHFU?=
 =?utf-8?B?MHRseHJYbWNBTkNCcmFlNk5oK20ydldUQ2grMFFuSmNQZ0xoKzBGUS9rODZ1?=
 =?utf-8?Q?2FF1rC+app6gLXO8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec748d3-3229-4c85-b893-08deaaa35a3a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 12:39:30.5668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuKcKEzTeCzbZMFYKUcAGdVTO5FdwEBI/o3ek5Fyr71Zk9HjCRcNZAjtYyJ2+m/l2tjoFowSR0mtOwcyn2lKz8O7GW69KzV2k+WAVKAW+Nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8345
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

On 5/4/26 14:27, Simon Glass wrote:
> Hi Ludwig,
> 
> On 2026-04-30T12:25:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> 
>> (optionally) enforce signatures so we can't accidentally boot
>> unsigned fit images.
> 
> Thanks for tackling this - fail-open signature verification has bitten
> people before, so making it opt-out is a good direction! A few
> series-level points:
> 
> test/py/tests/test_vboot.py exercises FIT signing end-to-end; please
> extend it to cover FIT_SIGNATURE_REQUIRED in both the success and
> fail-closed paths (no keys in the control DT, unsigned config).
> fit_all_configurations_verify() added in patch 4 should also get a
> test, ideally driven through iminfo so the command path is covered
> too. I wonder if we should enable the option for just one of sandbox /
> sandbox_flattree?


Thanks for the review!
I haven't touched tests at all so far, might take me a while to get into.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
