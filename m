Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91968D37E40
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 15:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E96B830CA;
	Wed, 14 Jan 2026 16:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fh+cNcIw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C19283923; Wed, 14 Jan 2026 16:16:32 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B5F18063E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONoRzQpNJzs+5h+p7whQq6dkSye1XF7NxaEiAdYzNYCvxT0Az9ySiB3gFAVotcVzsxFGoopD+sgr6bJgsdXuRBNWB4e2eLEx2o7oJ/8j4/6r9D1Be5wIqZO8ZoEElVlo0Z1Co6teO4ixkNoihbGGbQPyq+VWs+N+zZPIbGB3YAcnlxd2RnjYZkWmYzp1i4ghrgYM0igl/EIcgi0m9qAbmiGoBlIqMTBHW4DkAnZ8qZ+kxCWM6Np5vTWzq4YEG4wWbjSztVBhyo0mawrX38qBDab4n751W2UJkuXi+s3af0TYcACXbxx7H1mVwjU2xaPuiJTvgedSqgIp35ohk+VvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30fAoiI6+cYnNbWnA2Ok6e495PfztVQHxl5uDLsIpJg=;
 b=mEivo4++WWQmp3qVXrnMyYFj1fEZUTEhjxlAtNq+0w6vmpNYfS2EQTDrzvuaV84GNrjv7KhyfIjXg8FGohBmw6oSHXWPsV127jYEN2AsazhGViMxDZgfKIMK1i0Y5WnkEcNfibNSQx4UVChCPkb6ZDU6FTV3w2evHa0PezU57Q8mSsRakKlRBySn9j6RniBgvhKZSgqJUKaAM62zZN3MiU3k3gEkSU/zAcMe5AJSKDkHad25T15lJmiD7pPSrHPQGtkQb2sinUb3lBYC6lelwyaI6yt2R9m9y67HIyqGPecGKUdBjQRBNz3o9H3XsPBTEkGz6IgvslqLLyOMM/NuKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30fAoiI6+cYnNbWnA2Ok6e495PfztVQHxl5uDLsIpJg=;
 b=fh+cNcIwYlZRCaz8tHyaiBw0reqJvcmGMUaEG0QdX+HGLA0ATOHdUvtfjgVeBDe5tdVZPmxv2O0Doc2iroTW7V1Iyqielh4SmbQ+RqmtrkHm2Qjbxs/WBLmcSLDNyjwyoJXHdooBeFsQ/K3TZOW0bwB0oI+bWZK/q7TqU3vmNhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14)
 by DU4PR04MB10338.eurprd04.prod.outlook.com (2603:10a6:10:565::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Wed, 14 Jan
 2026 15:16:28 +0000
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b]) by DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b%5]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 15:16:28 +0000
Message-ID: <c97ff6cf-048b-4d9d-93df-68a370f36289@cherry.de>
Date: Wed, 14 Jan 2026 16:16:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] phy: rockchip: naneng-combphy: Enable U3 port for
 USB3OTG on RK3568
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260106233646.3184154-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260106233646.3184154-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0286.eurprd07.prod.outlook.com
 (2603:10a6:800:130::14) To DU4PR04MB12026.eurprd04.prod.outlook.com
 (2603:10a6:10:643::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB12026:EE_|DU4PR04MB10338:EE_
X-MS-Office365-Filtering-Correlation-Id: 64128096-a136-4eed-be55-08de537fe411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3J0SDAwb3VOTDFRUUd4Mmh5aUdPOFZxaDdqNUJ0K01CTU1Na0VmVDNaQUQw?=
 =?utf-8?B?emlCbTNEWnN1TnFoUktDSjNXRGtZSjBJeVlwQmlMR0Z0ZHRZNFdvSDZtVWFr?=
 =?utf-8?B?THNlanhFOTZKUEZ1SzBHSHdvclIzenpYN2VYTEY5NFpGNks2YVpUS1JJSHJW?=
 =?utf-8?B?NVRMUkRtdE56UW5KZGxIc1pmWUF4M3JJUXBuTHR4NTFNd2NWRDZhQW5MSWl2?=
 =?utf-8?B?WHcxTTl2OFFjUE00ZHdZeFBiUjBBSGVKYmhnL3k1Q2ZBTmsvZnBtNDJVMHNJ?=
 =?utf-8?B?dlMwWDJRR2FGZEFGL21kVCtkcUhkYkRCUys2SURlRXg0YjVFMURqays1anRQ?=
 =?utf-8?B?L1plWVkxa3ZXcFBqcFkwWWpjY1ZZYld6RWk1OEU3Rjh2OC9oUzRNN0RDY1F0?=
 =?utf-8?B?RDJKQ01XVVNnSWkzY2hZaElrcWYyYndzd3haRDhRSnRPaCtvdmM2VGQ4cjEx?=
 =?utf-8?B?YWt2cjcxY2xQQlhRczYxUXJOWXZIMmhzWnlPMk1OUUQwcUx6Ti9LU2ltenhX?=
 =?utf-8?B?czFVeHZjQTBBVlVVSnR0b29XS3pBbWJ1YXVHY2NSNDEvKzF3b1ZsTzJtcjZE?=
 =?utf-8?B?VmdTTGtCR2xYdjRsbUVPZG5EeFhFOFNWUGFQSHlRZGZ3dFdWQlAveW55NmtI?=
 =?utf-8?B?NlVZK2NVZHVEZXBDSWx5K0pPZE5rdVBwMTFwYmJoODczcUtIRlRSR3g3cWd0?=
 =?utf-8?B?enVMYmtMd1Q3SUVEU2dtMmVCSmZsekY3WDA2R2JGdGlXaGVPSlljUWp5UEd4?=
 =?utf-8?B?ZGZGY0UrRmk3SW56RFpBa20yejJTVGZxQWdkZzBJOU5LYVdiRDQ2SkZkZ1dO?=
 =?utf-8?B?OHRWMEZYSi91dXp4amYyZ2lSL2xRVE1NTUY5TU85cXdITmpsREhaaDlPdCsr?=
 =?utf-8?B?aUQxTWhYK2oyRVRnOTNCVjB4OHdzU1QybVNXQkFqc2N6SjdVZTFwdWNFMWcw?=
 =?utf-8?B?enhHU1hhd0F2WVljZ1NIUnUrS3pGTG1NdVErek90ZEN1SGlmazkyRlgzb1A1?=
 =?utf-8?B?UHNyQ3hxUHdKbGdiU3c5NkZMcno3U1pDcUlXWUEyQlJLeThJVG13dTlnZXZK?=
 =?utf-8?B?cFNneExxdzV2NHRhclhpUWZ2T1Jwc3FZMVlXNHcza250MVY1bC9ubW5VbThL?=
 =?utf-8?B?Ny9hYW5EMWtzMjhrWmlwd2liN0E3bHliVzdGellRTERIdGFiMDVXK1g3S1hr?=
 =?utf-8?B?NXQrQS9xQWFld0VxMmZuYmczRlY4UDIwUVVtV1ljdzREcnh1eE1mRzhMSjl3?=
 =?utf-8?B?RTc4MWhvMnVscGNZeXpPNE1pVDRKVFNBN3k0M2hlQWpuQkhmM0RyQnpOUUda?=
 =?utf-8?B?WkdQeThlbnU1MkNXUlVtaUM1ZWRKZS9nRXNWcENub09TWW1JMmtXeC9GTjVz?=
 =?utf-8?B?TXBlb0x4bkQwUlY0dXJmeHExS3djbkIyNGl6RmJtSWFxUGl3NnYwQnNFTld0?=
 =?utf-8?B?U0ZiZHFBWUhTQnY0SzR1TjdndUl4R2trTmVLS1VtNE1KSS82aC92dTVYVkYy?=
 =?utf-8?B?WnlvZHB3VHhiWE5nWG5MWXhNNXhIekhJV3NZdGdGT3VkclBKZmU2b21vQ0Fi?=
 =?utf-8?B?RG52QUJiRVJUb1ZJMldmTkFaZEJMTnpCSzE4ZFBlTkEvRUlXbWZtSyt6aGxa?=
 =?utf-8?B?TDdRYVdOamw1WGVNMFlURHRwMUJ1Um02d3paWHNCcWQvN0lJRElVT1pPRnRq?=
 =?utf-8?B?SnpQWGRuQ3BtcFBCcXR5bkhZMklsQ3JvUGFod3AwUFNwUlo1OUoyYzh2VWFw?=
 =?utf-8?B?ektLRUd2eVFmTHliQ25aUUlEVTBLMzhPTGM4bUpUQ1h6MmpKOXRVL3dTZC83?=
 =?utf-8?B?UFFpSWg5Snl1WWNGdzlkWTgzY0RvTEJkSTVXenpiOENmeEw5OHczQ1NLWU5w?=
 =?utf-8?B?UXNpRCtCaWhaMXVtU3pReDlTSis0NkVtTTA0SXN1UXVkdWRXUFRWWHpRNjVh?=
 =?utf-8?B?dGhtblQ1Sm5kL3NRdHpOVGFkS1ovWDR5TWJyeXNhRS9mbGF3M0loMDh5TlV0?=
 =?utf-8?B?THVTdDhpdGpxdUh0UmJ0Y1N6RFJQRjFSL2ZiOG5rQUJlUzJQblBjTVBmQXZn?=
 =?utf-8?B?Y1lZRXZ1V29pMnhTMUhCRXFmZUlWZ3c3aGxYamx2a2RpU3paUFdmMWx3cVIv?=
 =?utf-8?Q?ev5E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB12026.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGNnaG52Rk9JOTZERk04SUpzcnZkTXVLZUEvSmFGajF0S240UHhuL2RSWEJk?=
 =?utf-8?B?NmsvWTVNTzZVa092UHo0Qmx4U3N3ZjNPWUMyd2sxcUhBQWh1WWZlenBEaDVD?=
 =?utf-8?B?MjBHWUhnS01ZbXRzYkQyWHdoUFFFNnZFV2NMZUtXejZ3VDY4bjJ2djJMMmdx?=
 =?utf-8?B?SXZYZzFIcU9WK3h3WHNNV0Vtb3RteDZZVkdOQ0IyeGRaT1UyWjk5ZmNCYUhU?=
 =?utf-8?B?Z2pRS01OTVRyd0E2ZHVqeTFmTzhQM0NlRlk5bkR6M2JFZXpVZzNwb0dWUTMx?=
 =?utf-8?B?S3lOY3NQSWg4ZFJsbFpwVXRaK3RtNTBid0VPczU1TXl1dDlOczZXa3BKYTdm?=
 =?utf-8?B?RE9JSnkwekdYUTlnaXpqUjJNSVBKVGU4QjExSHMyQ2hsaUFyWGxpblA3Sm1x?=
 =?utf-8?B?cEJaelFyQlVLODVjRlJldVFQUjE4THZ4SStmWVJ3QU43eE5pOEY2d3FpV04w?=
 =?utf-8?B?QkRENkw0TllzSkZKMTU4UC80ckdwUDlmRGVjOUF1eWg1eVBML0M5UGRxM01M?=
 =?utf-8?B?bU0vUWtMVjNLaWFKdklpNERBZjdhRGFQYzdheHRCaFpuUzhUU0ZmOWNrelNN?=
 =?utf-8?B?bmtFRE85R1pveHRSajRVNk5mdHY3VzdBcXQ3RjJBbmxRY3AwVk5ybkJMVW5N?=
 =?utf-8?B?K2E5aGtLOHRrMHBaaFpHeFlNT1pnQ1ZVWmdtbGh2NEdMYysxajFnRTI5dXUx?=
 =?utf-8?B?REhDRXFaU0VtOHIrL2NPZGFaY0tWc0gvemIvZkJkQll1REJBdlBJbnhwZHh0?=
 =?utf-8?B?cFBLYjlYRHJZMFdwRzlGNjd4cEgyZVg0ZHZWZHVwM0FxMytENGphNFlNNGRQ?=
 =?utf-8?B?cVFkOXhOMGhwWUxYVy9aNlJPZnJ1RFdWZVJNZ3czOWVHdkpOTFpJeW0rSHNi?=
 =?utf-8?B?b2ZGVGNmWFhQYVVLOXBubTRqRG00SVo4a1RBVmdsdkhOU0RlbEZjMEo2SHp0?=
 =?utf-8?B?eXppOGo0VDlMck5XWjQwdXFYRTM0YjBNbEJWRnJuajRqbTRzcENzcElxcjkz?=
 =?utf-8?B?WmhmTkpmUGsvKzdoMjdTcmYvSEZXZk5RV09HWndwTlpvQ3VrakFTRkNMdHdi?=
 =?utf-8?B?bWFPQW15R3VuQ3NtZVBvTEd2c3hGdkJNUVZWSEdPbmxPdFU3UXVjUkhHUXQ2?=
 =?utf-8?B?QkxGeU02eTB2MkF5aW5OTFdUZ0t3ZDhvRm9paCtGVmR2M3ByaXU2MHJNbkF4?=
 =?utf-8?B?VVkrV3FQWmRlcE9HQVVWaGg4T1N2M0F0aTVQd0dZeDZGWFlIOS9tZUM3aUVI?=
 =?utf-8?B?ZU5XQTlLeitobWRUUlpkenlnb1VsRFJNVzVaeDZxTkUxcTFnVTc5a1V2ZzM1?=
 =?utf-8?B?MFRuZ0k3SDh2R0JnaU9CTFVSWVhsakdydmQvYjRqeXZIRmxQNkJhM2RjQytM?=
 =?utf-8?B?Y0NKU3F0MXQxcEFhM0U1Zyt4OTVqYlJ3NWY5Y0RFQ3lGeElRakFLTVNxd3FG?=
 =?utf-8?B?QWFkTU9LbElZMDE2WHEyWXpYZU5tKzlaK3ZNZXlsT2liOFpUM1BxaklIa2t3?=
 =?utf-8?B?TTc5YzYvVG1tUlhpWEM2YWNJaHpWMjY1QklKQ1Y3UFF3eEc2bU5pSHN1cUtr?=
 =?utf-8?B?aGQrTGhvVFhIR1p4enRqUk9rRzljdm5pemYyeGRoY1MvQ2g3TE4xWDQwOFNv?=
 =?utf-8?B?TjhDNWNHeEJXdmhFVWtvRC9Wd1ovNUxCNFlVL0hQRHAvTnRMTXhGdk1IVjd5?=
 =?utf-8?B?SXRMMCtOdU1OM3lFS0FYUzkwK2hzQ09TYjV1Z211Sm9BVXlPZHZYL3BWWVFy?=
 =?utf-8?B?Y0tKUUk3dzE5K0Y0TXNQNkpDK2hXWStsOUxzekJVVU9YRUtjb3Bpck8xcUZD?=
 =?utf-8?B?c0pLWEtsMUlXMmQydUJuc0RGTVZGZDAyNlZiWXFzSU56bVdNRUxHajA4VnQy?=
 =?utf-8?B?eXNBQmZCc3k3RjgxNytubzhFZ1Q1ZFVQNGJsSzlkMlUzWlV5ZGhvWWxMUTBC?=
 =?utf-8?B?bkFvOE9JWjdxRlR2UG1sVGtpYmMwMXRyb3FCVWR0YTVIRDVTRWNpbS9oSTZ2?=
 =?utf-8?B?cXZGSFZpSHRzb2VVS09Yb0xuUDVxbTdreHFRdTJGS1NWMlBnQVluRXMzRG44?=
 =?utf-8?B?cmFQdUl3VGRmU2VDanUxeFNkTlJWS2ZxcDNQR0ZmZENJa1dxczZUd2dHcWpD?=
 =?utf-8?B?R0NtVGxGNTV4NEwzaGFBZm1CNUxHWnlpcnBPSTNRNFhwK01LQzFIRXJBbUJH?=
 =?utf-8?B?ZGZyZFBpRnNNVDVSWjE0WUtzYXpPZ1FOcS9RaU43dElQdWRTa0puaENWNTIz?=
 =?utf-8?B?eW55U3EwWnNIbm1HQk4zTkgzZ1RuVUpmUmtCQ3EvblVYWHMybWFLdkgzRmtn?=
 =?utf-8?B?T084Mlk2RHBlOTlORS9JcjhvQ2RrZEhWNHBqWnF5ZVBlWnZVbkVldz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 64128096-a136-4eed-be55-08de537fe411
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB12026.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:16:28.6849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTHja4XHLq0VjBCGMA2O/iN0+eSN7TftpAlBe5i47tcJJaJlnqGe9+Pk1+yh/yrKT2LKX6hgFEGzh5PSpAhhJmniVDXZ1HRDwrgSO23K7i8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10338
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

On 1/7/26 12:36 AM, Jonas Karlman wrote:
> The USB OTG U3 port may have been disabled early, add support to the
> COMBPHY driver to re-enable the U3 port.
> 
> This matches changes made in the Linux commit 7bb14b61b7d0 ("phy:
> rockchip: naneng-combphy: Enable U3 OTG port for RK3568").
> 

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
