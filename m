Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53193E77180
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 14:46:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8106A80104;
	Mon, 16 Dec 2024 15:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="tKVvg6jj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762EB80141; Mon, 16 Dec 2024 15:46:40 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 077BA8003E
 for <u-boot+nodisclaimer@lists.denx.de>; Mon, 16 Dec 2024 15:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHXx9NOSV72b2JU1qdYiWwtQD2pXOZcopR63yNAQnaScgrlzJXuRo39qQeFZr2lZuCQma0HovkPfpw1M3A1fzO2jk1aXhp9hoNhmAQOTtmI+TOznzWf2hi1BrMjZGFZthtOKCs7seMgIzslfbBu938YgxDrQJlWZP17K7OvNK4OtLy2bzj67ZIRETfjpbfAu8pzCuA8XyF4vDKKaTA4GXkOwwEZtbyPiPvkgaHsZyO9x8aUnHCUTzWzhSZQYKtLtAnCbbXCnl5Wb9czt4CSr9dVIcV0GFQguzV7Q123e4TDSo3PvzlP0Zu6urKmyFLx+E+Sz/wmOLrzIvELrBKjbiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl5oVOJw7rcsRFQdRhrLku/LvGrieoyVFpfgz1iRLFE=;
 b=i4fQnHrlFOPoNiauuS4F3O0SRVhhAjiYURUV9Ir46M+Mb8WqkBUUZ7MSQTeHRl4+Wwrx4XvmsHapN54/W8KLPJRV0X0R8DJUCxzKIMp4+gfCau8HUS4im/+VNVZAQPOq4p66i5T6OJxJ7vy01llVY+MW5N9TmHxFaoyGrD7AmavG9mF29lQYyHlgrG8eDpwpcRK6ZvmI3zvHKR9tO06qZkz066s3qFizjyB4t725DwVBnBFtGhI/MGRP9kKxTgf0VORTQZoCf9LHMj9P5PxJAIDeydxc70v0tDE5MaN2yQiddvaIw7ShAq3uwlQTlsUulqgZEBhDcvFuqlbOrG2tKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl5oVOJw7rcsRFQdRhrLku/LvGrieoyVFpfgz1iRLFE=;
 b=tKVvg6jjkoxcc33g0V3AZHsA25+TzlqjqfkA574z7KU5XfctMWvb2zMtoQbiyM6L4LBK/J0AccbQNtWB1dGd+qQko4J8Pd4E4tROiYPQKrDrZWUwdlUbkXHItH0+d87Moih4WxirFxFkT+tf4vcE5BeSL7q3OfCjXjWSGcs84s3u4EFWppPyURBj07Me9z/rK0MJEfQ+qfIMax+7DEQwHPywsl9Lkt9vvrhRXd6y+vxCIxKQzUq453CiYq2/k0epz5qAtb4/HB68wCe1xw1prB0Frfj1NEHJoekQH4cRHPAd7ORBS1lsymF8ix5WRr6uNJGZicX178k0T7R4YrjXsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PASP264MB5537.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:43e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 14:46:35 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:46:34 +0000
Message-ID: <44cf0a6f-4461-4992-a06f-6ff835d30657@softathome.com>
Date: Mon, 16 Dec 2024 15:46:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] test: lib: add test for sha256_hmac
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
 <20241212133710.172404-7-philippe.reynes@softathome.com>
 <CAEfUkUL-JDovdtwmvywd8vfjK-vqPWnJwpeQGo+sZXWJNPFmjQ@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkUL-JDovdtwmvywd8vfjK-vqPWnJwpeQGo+sZXWJNPFmjQ@mail.gmail.com>
X-ClientProxiedBy: PR1P264CA0138.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ce::17) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PASP264MB5537:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d2ef95-d992-467c-c338-08dd1de0700f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUZKVmJ3WkVwemNSU2dhajlDVGl3WnpQcUtKZzd4NHljT3FoNXE2MjR3T2ta?=
 =?utf-8?B?RkJLWE0vcXkzK21uc1FmWmtCR3JkMHVQMFF5VDluQ1NkSTJrV3duNVF2UFZX?=
 =?utf-8?B?bjVjZ3dUS2lObk9seFJyVUZvVUxFZGFvalgrcm1MZVBHQ2l3QWFJU2NDMXQ4?=
 =?utf-8?B?U3ErazJhU3BCQ1NnWnlmWjNwYlFoVml3MkxWQ1NOQUIrelY3RjV5VkNUcGxK?=
 =?utf-8?B?dDBaT3YwMjI0QnNONWx5bjU5RUZwSHZiN2hsUmZvNHl3d0xvaXk0d2xDa1RC?=
 =?utf-8?B?cUFIOS8vZXhLbTNSQ0s5eE0zK0hzUjhkNjZVQTBIM3VaQi9GZE9KeU95Z0pK?=
 =?utf-8?B?UU11em5BNzFNWTk5S1lzTkNqbmZTSFZ0NFRTTFV6Z05KOHZXVEhUY053NEJy?=
 =?utf-8?B?YTBHR3NRTWtVaU5kTVlveG0rS2phZTRrbEd2QXE1NGFyUnVlMWxqdm1HMzBk?=
 =?utf-8?B?QXNtd3VsOWRFTWVVR3gyajRuYzVlN2pEcmx2SjA2YkRvZ2RvWllVTXJVUlFt?=
 =?utf-8?B?NEhMdWdkQ25BS0VJWmQ1aGhJTnFPZWt3bHhlOTNsWWt5VDV4Mkx2TDM5M0tQ?=
 =?utf-8?B?REZwTmlmOVhVbEhNZW5FTHV0UThGTkRWUjE3M2ZXcVJDUHpxbENBUkpLV0R2?=
 =?utf-8?B?anJXRlpQR29pSEplYnozNzBmaEJjNnYyMk1GRm4xeGNZcTJZNnpCZU5PeVBo?=
 =?utf-8?B?QjRTTm5pbjBLYXZhZDh0dVgvMEVRNW90YitZZHFEek1UaFRzOVFsWjhxZGFs?=
 =?utf-8?B?THdpenYxTGtNNHd2TGgwdGw5Z3pVczFEclMyc21wNE9NN0JMRkpsNlJRSCtP?=
 =?utf-8?B?UEg3bnBOR3kvZXY3R1oyYkdtWlpzZUF5bzY1cGc5VnJiRndmb3VrZ0pYb1V3?=
 =?utf-8?B?NmlCQlpDbG1tTFdHdUhWbDB3RmN5Wm5WN2o5RW40akhOYnN1WENDOFREQVdL?=
 =?utf-8?B?bzM0b2s3Q1FVbytIdzZ3NzZYQmp0ZFI1dysyUGoyejlEOEJyaEUrc3hPbk9U?=
 =?utf-8?B?d2FiZUcyNXV1cStORFNqK3FwZks5ZElZTUlpVnAvT05JZ3FIZzVueE5FR0NJ?=
 =?utf-8?B?WE9DWjA0UGNFTy9rcTVvRVRoMk9RRUpLcGpFTXg5NEVReXFjQm9hQkxrR2hK?=
 =?utf-8?B?dFQ2NTcrMEtvRXlWWE0vcDI3MmdRVTJYOFdySWVwOGFOa1dmMWVoUmg3a3Zl?=
 =?utf-8?B?RURudGtUS1JLTzZ5d2F5SEZISm1pR1VRUysvRWV3L1I3OUNWVTJVZnBnTnZP?=
 =?utf-8?B?MU5aT2FTaW5vU3JKNVd4cmR1WWttNkVuT0VoQSs1NGxnOXE3NkRiMkd1NlVr?=
 =?utf-8?B?OHlPQzBodWVOSXp6WVZVWDBuKzdTenljSGZCMytKK0NEcFdyRDRYYURBd1dz?=
 =?utf-8?B?SUJ0SEo4dWY5dURkTHNyS2FRTHdRK2RnNHdVNEVZNmlTYjVvZEdoNzgyYTNu?=
 =?utf-8?B?OFc2Wmt6UUhua2NTUURsMzBwWVFrL004OGxVVHdzK0t0Vy9ON3A3dlpMQjVW?=
 =?utf-8?B?Zk1BNWZLZ1RITm9taG9tOWM0T29Db1dPaHZXVW5xaUxTY3I1WTlvUHArT005?=
 =?utf-8?B?T2ErZzByZVZtMjhrcGxadTVyVGRpNHFBc09XdzVIb1NOdjhxa01Cay8rYXYx?=
 =?utf-8?B?L3N0dncxK1VkREoxOG0wWitEUmg2MUhJNG10c1VCRm80cjNXZ1hISnNXL2kv?=
 =?utf-8?B?WnFGRys1YTVnWjdUMFlYY3U5UFpleC9Hd0tNRnFxQTFhdG85N3lUdjJ6Mzh2?=
 =?utf-8?B?cmVnZnNtbUVHaFJGVHFGdVErOGVRbmhrY1lXTStwRnF1cWZwM3NJT0pTYkR2?=
 =?utf-8?B?SWUrWFRvNUVGMDNyTnBtRmtxc2JGWVZyQkpjYnVMVjZBaDFwdTY0VWk0NEw1?=
 =?utf-8?Q?XdGUNSHgewNLx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm0ySnhzMWFUUm9qYXU5U1FNUm5mZ1Y0V0hBQjRzaThMdEFjK0dPSHBMamcx?=
 =?utf-8?B?b2RxTHFNd1drRVNIMDRuQUlCL0tFTzZvbTkySVU1ZTVGQ2VkbmxvNlBIdFUy?=
 =?utf-8?B?TkdFNXBLL0huVW1OMG1qZXNlQzNNMWJYVWpjNlcxR1ZoQS9zd0tCZGgxN1Vv?=
 =?utf-8?B?eGdzWEp3RUNHM05qSXR0NE5QUEg0c3RBbTBqMFJrTmROaGhZTG5Mc2dSYSsz?=
 =?utf-8?B?akZUS2NiWkhRUGNQVlpnblFFZG9BTmROU1hFcWRvTWFPWDVycFEwODdTNEg3?=
 =?utf-8?B?SzkvWkdQcnd6SnNqNXhrK3JESDgySXRjUllvbFlrcWpQSXlvWUtybXgvaC9X?=
 =?utf-8?B?TnMzaWFzMWM3K1lFVzd3bEwyMXNQeThzcmoyQlcyUTBZR2tPSERvSE0xSGdk?=
 =?utf-8?B?c0xaUzVGWmY0Z3dhNEp0ZTMwM25XdWhxU0o4NmNmanVFRnYzMTRiL0VDYnNr?=
 =?utf-8?B?QWlmeVZSQWJHc2tncndid0ZIeDNxMGt3RjMrMjg3TVJjMGdSVDJsT3d0Zmw1?=
 =?utf-8?B?L0Z1b0N3djhVU3ZWRlZtdWdMYnltWG9XNnFGYmVhTjdFU3Fia2R5VFc2SXE1?=
 =?utf-8?B?Z2YzZXpDcVJYeXdhQlRGTFNFR0VPWVpOdzU2Ti80dlhVVVk1MDRYNndGaExK?=
 =?utf-8?B?Y08zcjVWakxWcHgyZmpEMDFNRWUyQ0xxSWRuQUtIRlM0bnJ0Qnh3Rkp4ZHdZ?=
 =?utf-8?B?RmMySU9LWDgwVExHREI5cCtkVTNrWE5Eb0Z5djE3WDdNUUMvQVZMWHNTVlZ4?=
 =?utf-8?B?WmU5aDV5T29CQ3FLa2RtbTl4bHUvWno4NXVxemNvbVdCSTRDKzZZczYvdUpD?=
 =?utf-8?B?NnpxQkpubGpGeFo4aXpzVDBOYnZtemI5QjdwTmxBZ3YyUHhWNC9yYkdWV01Q?=
 =?utf-8?B?OFNuK3pZSmVuOEc0RWhXcHhjSy9wRTdKd1BOUGZmVG9zTGdFUS92eUN0UTNz?=
 =?utf-8?B?dlB2T0RENlFFeFFHdGYwaUpDb3pTc2Q3bW05NjUvV2hoSTE5STF5bmJXWWRk?=
 =?utf-8?B?cTIxUXd1Sk1pZG55RnNWc1NiNVM4SFgxeERTeDRNbmV3cjJTS25RczRIakF4?=
 =?utf-8?B?SlZPQ1FwT3hvZEFSVlZyYmJrTkFDKytPYUZpdTJUTE95Z1dBSkZJTThpeVI1?=
 =?utf-8?B?U1NaWUpQU1ZIN3ZaOEpxYmE2SEE0Uk9BWVByUWRaODRzMzVJdThuYmdZRUFt?=
 =?utf-8?B?NGI2VEViZytaMjVIUmdsVnNUWnNSeWMydDFvKzNmajAxK0xMbDAxMElrbkI4?=
 =?utf-8?B?RWtsL2F6RkFjOTJTdndmT1dxLzJ5WWhOVTlQUWhEZ2hJM0p4MXNlRnZOcGVr?=
 =?utf-8?B?N2dwVTVFRG9uMGdhczFwKzA5TjVxTTFiR2pNYm82K2hDZ2t3Mi8zMXBJQWZI?=
 =?utf-8?B?Vmg3R21yVUE2K3NIbmxIeGJ6RlJjVGJSYnh2aW1mT2NZd0NkejMwMStRdTJS?=
 =?utf-8?B?UDE1U1A1QkN1ZkxhK0NQaERvZUFScjlydkd0cmg3cWRjQXFuS0txUjUzNkxi?=
 =?utf-8?B?WGRPTzRWSnk3K3NZdUVpVkZ3YzNKYjNFaktNNWpHdDVSSTJaMDUySExid2xD?=
 =?utf-8?B?bU84R0IzMktvZFV5OFNMT2IybFBFUGc3eXVRVmlpVEdtMDN2a1hoSUtCbTVM?=
 =?utf-8?B?TWxvK3RLMWtMbmJnVWFheElyOXdQWVExdytJNjNNemxXdVcvQ0VkcXZMem56?=
 =?utf-8?B?eTBsc2EyQXdxUjVML0VQN0tXc2treEV1WlYxY2NQVmdMQkVDb2hIbW9vUHNI?=
 =?utf-8?B?L2c1YXVJbHNGSFhFOFVjZ2dmejNRSW55cjZ2bkZZenV1V29YaTVEcElPK1Ex?=
 =?utf-8?B?YktqMkMxMTBBOVZPT0VLYVRxeTloTW1LbHQzQUUrTzB3d003SjJqUm1lZDBM?=
 =?utf-8?B?U1MrZEFLdTlVTnV0bnlnRGZ2RjllUTBESHN3eTJQcHk2dkI4ZVJPMm80K3d0?=
 =?utf-8?B?dy8xS1hudlFnQm01dHFJSTlsSW9Ib1c2d0xVM0VRUzhrS0lFVFhQNWFlNjBJ?=
 =?utf-8?B?UWptT00wQXpVN2dDMkp3a2NyY2VDQ2ozV05ERlpSYVpycUdXbDY0eXU3OCs5?=
 =?utf-8?B?bEdjM05ici85TEJ1Q0h6elNpbXNTR1FMWGhKejB5ekRhZ1FzaHliZFF6NTJz?=
 =?utf-8?B?ZXFRQnQyNVNMOFZwUW5qWTk5dkcyY3RaeDdrZlZQbEU0UzlhZEhKY0VyL3Rr?=
 =?utf-8?B?QUtONTFpTEZtVXpPTVNTVnBkUi9MRzN0QjRxZGVqQkVEWEhQZ2JpT3RBS2xm?=
 =?utf-8?Q?M/cNyLUCyJ/RuQbK3sDVzbi6mvOfz9W3W2aP5E1u38=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d2ef95-d992-467c-c338-08dd1de0700f
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:46:34.9015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mW8xsoOG4I/MvJIf9JA/lyjvPOIOWLmTPgtUVkSQr8LcHbMZcQIHUSFXKzBxBtnqPsDH8Yz3Iivbr+IQvJpD0GpuT3FoD9Pb+bBbl5kFqw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5537
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Raymond,


Le 13/12/2024 à 17:56, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> On Thu, 12 Dec 2024 at 08:37, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     Adds a test for the function sha256_hmac
>
>     Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>     ---
>      test/lib/Makefile           |   1 +
>      test/lib/test_sha256_hmac.c | 296
>     ++++++++++++++++++++++++++++++++++++
>      2 files changed, 297 insertions(+)
>      create mode 100644 test/lib/test_sha256_hmac.c
>
>     diff --git a/test/lib/Makefile b/test/lib/Makefile
>     index f516d001747..4c0abcba81a 100644
>     --- a/test/lib/Makefile
>     +++ b/test/lib/Makefile
>     @@ -24,6 +24,7 @@ obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
>      obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
>      obj-$(CONFIG_UT_LIB_RSA) += rsa.o
>      obj-$(CONFIG_AES) += test_aes.o
>     +obj-$(CONFIG_SHA256) += test_sha256_hmac.o
>      obj-$(CONFIG_GETOPT) += getopt.o
>      obj-$(CONFIG_CRC8) += test_crc8.o
>      obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
>     diff --git a/test/lib/test_sha256_hmac.c b/test/lib/test_sha256_hmac.c
>     new file mode 100644
>     index 00000000000..78b87ec98a8
>     --- /dev/null
>     +++ b/test/lib/test_sha256_hmac.c
>     @@ -0,0 +1,296 @@
>     +// SPDX-License-Identifier: GPL-2.0+
>     +/*
>     + * Copyright (c) 2024 Philippe Reynes
>     <philippe.reynes@softathome.com>
>     + *
>     + * Unit tests for sha256_hmac functions
>     + */
>     +
>     +#include <command.h>
>     +#include <test/lib.h>
>     +#include <test/test.h>
>     +#include <test/ut.h>
>     +#include <u-boot/sha256.h>
>     +
>     +struct test_sha256_hmac_s {
>     +       unsigned char *key;
>     +       int keylen;
>     +       unsigned char *input;
>     +       int ilen;
>     +       unsigned char *expected;
>     +       int elen;
>     +};
>     +
>     +/*
>     + * data comes from:
>     + * https://datatracker.ietf.org/doc/html/rfc4231
>     <https://datatracker.ietf.org/doc/html/rfc4231>
>     + */
>     +static unsigned char key_test1[] = {
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b,
>     +       0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b };
>     +
>     +static unsigned char input_test1[] = {
>     +       0x48, 0x69, 0x20, 0x54, 0x68, 0x65, 0x72, 0x65 };
>     +
>     +static unsigned char expected_test1[] = {
>     +       0xb0, 0x34, 0x4c, 0x61, 0xd8, 0xdb, 0x38, 0x53,
>     +       0x5c, 0xa8, 0xaf, 0xce, 0xaf, 0x0b, 0xf1, 0x2b,
>     +       0x88, 0x1d, 0xc2, 0x00, 0xc9, 0x83, 0x3d, 0xa7,
>     +       0x26, 0xe9, 0x37, 0x6c, 0x2e, 0x32, 0xcf, 0xf7 };
>     +
>     +static unsigned char key_test2[] = { 0x4a, 0x65, 0x66, 0x65 };
>     +
>     +static unsigned char input_test2[] = {
>     +       0x77, 0x68, 0x61, 0x74, 0x20, 0x64, 0x6f, 0x20,
>     +       0x79, 0x61, 0x20, 0x77, 0x61, 0x6e, 0x74, 0x20,
>     +       0x66, 0x6f, 0x72, 0x20, 0x6e, 0x6f, 0x74, 0x68,
>     +       0x69, 0x6e, 0x67, 0x3f };
>     +
>     +static unsigned char expected_test2[] = {
>     +       0x5b, 0xdc, 0xc1, 0x46, 0xbf, 0x60, 0x75, 0x4e,
>     +       0x6a, 0x04, 0x24, 0x26, 0x08, 0x95, 0x75, 0xc7,
>     +       0x5a, 0x00, 0x3f, 0x08, 0x9d, 0x27, 0x39, 0x83,
>     +       0x9d, 0xec, 0x58, 0xb9, 0x64, 0xec, 0x38, 0x43 };
>     +
>     +static unsigned char key_test3[] = {
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa };
>     +
>     +static unsigned char input_test3[] = {
>     +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
>     +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
>     +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
>     +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
>     +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
>     +       0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd, 0xdd,
>     +       0xdd, 0xdd };
>     +
>     +static unsigned char expected_test3[] = {
>     +       0x77, 0x3e, 0xa9, 0x1e, 0x36, 0x80, 0x0e, 0x46,
>     +       0x85, 0x4d, 0xb8, 0xeb, 0xd0, 0x91, 0x81, 0xa7,
>     +       0x29, 0x59, 0x09, 0x8b, 0x3e, 0xf8, 0xc1, 0x22,
>     +       0xd9, 0x63, 0x55, 0x14, 0xce, 0xd5, 0x65, 0xfe };
>     +
>     +static unsigned char key_test4[] = {
>     +       0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
>     +       0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
>     +       0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
>     +       0x19,
>     +};
>     +
>     +static unsigned char input_test4[] = {
>     +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
>     +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
>     +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
>     +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
>     +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
>     +       0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd, 0xcd,
>     +       0xcd, 0xcd,
>     +};
>     +
>     +static unsigned char expected_test4[] = {
>     +       0x82, 0x55, 0x8a, 0x38, 0x9a, 0x44, 0x3c, 0x0e,
>     +       0xa4, 0xcc, 0x81, 0x98, 0x99, 0xf2, 0x08, 0x3a,
>     +       0x85, 0xf0, 0xfa, 0xa3, 0xe5, 0x78, 0xf8, 0x07,
>     +       0x7a, 0x2e, 0x3f, 0xf4, 0x67, 0x29, 0x66, 0x5b,
>     +};
>     +
>     +static unsigned char key_test5[] = {
>     +       0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c,
>     +       0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c,
>     +       0x0c, 0x0c, 0x0c, 0x0c,
>     +};
>     +
>     +static unsigned char input_test5[] = {
>     +       0x54, 0x65, 0x73, 0x74, 0x20, 0x57, 0x69, 0x74,
>     +       0x68, 0x20, 0x54, 0x72, 0x75, 0x6e, 0x63, 0x61,
>     +       0x74, 0x69, 0x6f, 0x6e,
>     +};
>     +
>     +static unsigned char expected_test5[] = {
>     +       0xa3, 0xb6, 0x16, 0x74, 0x73, 0x10, 0x0e, 0xe0,
>     +       0x6e, 0x0c, 0x79, 0x6c, 0x29, 0x55, 0x55, 0x2b,
>     +};
>     +
>     +static unsigned char key_test6[] = {
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa };
>     +
>     +static unsigned char input_test6[] = {
>     +       0x54, 0x65, 0x73, 0x74, 0x20, 0x55, 0x73, 0x69,
>     +       0x6e, 0x67, 0x20, 0x4c, 0x61, 0x72, 0x67, 0x65,
>     +       0x72, 0x20, 0x54, 0x68, 0x61, 0x6e, 0x20, 0x42,
>     +       0x6c, 0x6f, 0x63, 0x6b, 0x2d, 0x53, 0x69, 0x7a,
>     +       0x65, 0x20, 0x4b, 0x65, 0x79, 0x20, 0x2d, 0x20,
>     +       0x48, 0x61, 0x73, 0x68, 0x20, 0x4b, 0x65, 0x79,
>     +       0x20, 0x46, 0x69, 0x72, 0x73, 0x74 };
>     +
>     +static unsigned char expected_test6[] = {
>     +       0x60, 0xe4, 0x31, 0x59, 0x1e, 0xe0, 0xb6, 0x7f,
>     +       0x0d, 0x8a, 0x26, 0xaa, 0xcb, 0xf5, 0xb7, 0x7f,
>     +       0x8e, 0x0b, 0xc6, 0x21, 0x37, 0x28, 0xc5, 0x14,
>     +       0x05, 0x46, 0x04, 0x0f, 0x0e, 0xe3, 0x7f, 0x54 };
>     +
>     +static unsigned char key_test7[] = {
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
>     +       0xaa, 0xaa, 0xaa,
>     +};
>     +
>     +static unsigned char input_test7[] = {
>     +       0x54, 0x68, 0x69, 0x73, 0x20, 0x69, 0x73, 0x20,
>     +       0x61, 0x20, 0x74, 0x65, 0x73, 0x74, 0x20, 0x75,
>     +       0x73, 0x69, 0x6e, 0x67, 0x20, 0x61, 0x20, 0x6c,
>     +       0x61, 0x72, 0x67, 0x65, 0x72, 0x20, 0x74, 0x68,
>     +       0x61, 0x6e, 0x20, 0x62, 0x6c, 0x6f, 0x63, 0x6b,
>     +       0x2d, 0x73, 0x69, 0x7a, 0x65, 0x20, 0x6b, 0x65,
>     +       0x79, 0x20, 0x61, 0x6e, 0x64, 0x20, 0x61, 0x20,
>     +       0x6c, 0x61, 0x72, 0x67, 0x65, 0x72, 0x20, 0x74,
>     +       0x68, 0x61, 0x6e, 0x20, 0x62, 0x6c, 0x6f, 0x63,
>     +       0x6b, 0x2d, 0x73, 0x69, 0x7a, 0x65, 0x20, 0x64,
>     +       0x61, 0x74, 0x61, 0x2e, 0x20, 0x54, 0x68, 0x65,
>     +       0x20, 0x6b, 0x65, 0x79, 0x20, 0x6e, 0x65, 0x65,
>     +       0x64, 0x73, 0x20, 0x74, 0x6f, 0x20, 0x62, 0x65,
>     +       0x20, 0x68, 0x61, 0x73, 0x68, 0x65, 0x64, 0x20,
>     +       0x62, 0x65, 0x66, 0x6f, 0x72, 0x65, 0x20, 0x62,
>     +       0x65, 0x69, 0x6e, 0x67, 0x20, 0x75, 0x73, 0x65,
>     +       0x64, 0x20, 0x62, 0x79, 0x20, 0x74, 0x68, 0x65,
>     +       0x20, 0x48, 0x4d, 0x41, 0x43, 0x20, 0x61, 0x6c,
>     +       0x67, 0x6f, 0x72, 0x69, 0x74, 0x68, 0x6d, 0x2e,
>     +};
>     +
>     +static unsigned char expected_test7[] = {
>     +       0x9b, 0x09, 0xff, 0xa7, 0x1b, 0x94, 0x2f, 0xcb,
>     +       0x27, 0x63, 0x5f, 0xbc, 0xd5, 0xb0, 0xe9, 0x44,
>     +       0xbf, 0xdc, 0x63, 0x64, 0x4f, 0x07, 0x13, 0x93,
>     +       0x8a, 0x7f, 0x51, 0x53, 0x5c, 0x3a, 0x35, 0xe2,
>     +};
>     +
>     +static struct test_sha256_hmac_s test_sha256_hmac[] = {
>     +       {
>     +               .key = key_test1,
>     +               .keylen = sizeof(key_test1),
>     +               .input = input_test1,
>     +               .ilen = sizeof(input_test1),
>     +               .expected = expected_test1,
>     +               .elen = sizeof(expected_test1),
>     +       },
>     +       {
>     +               .key = key_test2,
>     +               .keylen = sizeof(key_test2),
>     +               .input = input_test2,
>     +               .ilen = sizeof(input_test2),
>     +               .expected = expected_test2,
>     +               .elen = sizeof(expected_test2),
>     +       },
>     +       {
>     +               .key = key_test3,
>     +               .keylen = sizeof(key_test3),
>     +               .input = input_test3,
>     +               .ilen = sizeof(input_test3),
>     +               .expected = expected_test3,
>     +               .elen = sizeof(expected_test3),
>     +       },
>     +       {
>     +               .key = key_test4,
>     +               .keylen = sizeof(key_test4),
>     +               .input = input_test4,
>     +               .ilen = sizeof(input_test4),
>     +               .expected = expected_test4,
>     +               .elen = sizeof(expected_test4),
>     +       },
>     +       {
>     +               .key = key_test5,
>     +               .keylen = sizeof(key_test5),
>     +               .input = input_test5,
>     +               .ilen = sizeof(input_test5),
>     +               .expected = expected_test5,
>     +               .elen = sizeof(expected_test5),
>     +       },
>     +       {
>     +               .key = key_test6,
>     +               .keylen = sizeof(key_test6),
>     +               .input = input_test6,
>     +               .ilen = sizeof(input_test6),
>     +               .expected = expected_test6,
>     +               .elen = sizeof(expected_test6),
>     +       },
>     +       {
>     +               .key = key_test7,
>     +               .keylen = sizeof(key_test7),
>     +               .input = input_test7,
>     +               .ilen = sizeof(input_test7),
>     +               .expected = expected_test7,
>     +               .elen = sizeof(expected_test7),
>     +       },
>     +};
>     +
>     +static int _lib_test_sha256_hmac_run(struct unit_test_state *uts,
>     +                                    unsigned char *key, int keylen,
>     +                                    unsigned char *input, int ilen,
>     +                                    unsigned char *expected, int
>     elen)
>
>
> const unsigned char *


I have done this change in v5


>     +{
>     +       unsigned char output[32];
>
>
> Please use SHA256_SUM_LEN to avoid magic numbers.
>
>     +
>     +       sha256_hmac(key, keylen, input, ilen, output);
>     +       ut_asserteq_mem(expected, output, elen);
>     +
>     +       return 0;
>     +}
>     +
>     +static int lib_test_sha256_hmac_run(struct unit_test_state *uts,
>     +                                   struct test_sha256_hmac_s *test)
>     +{
>     +       unsigned char *key = test->key;
>     +       int keylen = test->keylen;
>     +       unsigned char *input = test->input;
>     +       int ilen = test->ilen;
>     +       unsigned char *expected = test->expected;
>     +       int elen = test->elen;
>     +
>     +       return _lib_test_sha256_hmac_run(uts, key, keylen, input,
>     ilen, expected, elen);
>
>
> Why we don't just:
> return _lib_test_sha256_hmac_run(uts, test->key, test->keylen,
>                                  test->input, test->ilen,
>                                  test->expected, test->elen);
>

I have done this change in v5.


>     +}
>     +
>     +static int lib_test_sha256_hmac(struct unit_test_state *uts)
>     +{
>     +       int i, ret = 0;
>     +
>     +       for (i = 0; i < ARRAY_SIZE(test_sha256_hmac); i++) {
>     +               ret = lib_test_sha256_hmac_run(uts,
>     &test_sha256_hmac[i]);
>     +               if (ret)
>     +                       break;
>     +       }
>     +
>     +       return ret;
>
>
> This seems to be better:
>        for (i = 0; i < ARRAY_SIZE(test_sha256_hmac); i++) {
>                ret = lib_test_sha256_hmac_run(uts, &test_sha256_hmac[i]);
>                if (ret)
>                        return ret;
>        }
>        return 0;
>

Usually, I try to have only one return per function.
But I have done this change in v5



>     +}
>     +
>     +LIB_TEST(lib_test_sha256_hmac, 0);
>     -- 
>     2.25.1
>
>
> Regards,
> Raymond


Regards,
Philippe
