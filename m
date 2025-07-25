Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0813BC83F26
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 11:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A0DB83937;
	Fri, 25 Jul 2025 13:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dqFx/QSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20EBB83939; Fri, 25 Jul 2025 13:03:01 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBF4083931
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 13:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+9RMAUoZn2huipusO3DWfgfZdGseD/IarSwy1d/1c/MdBLl2+IE+p2pUvAQzt9g0OEOTD8rLdD2tBR9XG3hIPuxW04p3xPWos8kQ1C5vGR4O8tF+uB1ttU2Eeh7QCIP6c1f5wgfel0qnIUR76MBD/KVIZTixu5vlQDJNpIkleyEsWByDXlxMT0iZmXnUPcGVXBH+s784jLUC8Iy6kJ5iL3WTnofRvtRLioJrOdV+OnamJs5JGTe0kBybbB/qqgg01XLwXLCDA4KXeIa5bAZHuHVVU53gl8z9QLPqJ44A5JY66Hl8b1v5iP7Hemu6lQRJxI/fHa4p67K8qXXMYQHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqXQlTQycbe5mtikT8HEe9uEMzh69CzFYnLKQzb4ekI=;
 b=j7/uymec+ZFasF3u3jzUu+5C2zGUkRa0+nsI82Dmjxo/HfmIAhCsb0oOumdF492Shz7XqdG9UbrHh2VcYx8ZSt3l8r6vapADZ6sM+uuqTHCcXNIFqF80GlYvRkRBybmtii7yOIpnzHgOtdt4sm8MfcmxQ5SjQKKnmPzBCXuIbQMNRmdXazgUSAvJqqsqPFzVDcHT1w1Elr8sKmNhMm7CqTwL79Y/Z1fg7bQjtmrPGb4X5jmfiSvVcxLRbFbjKA+asknnU7LBKgbSL64Fi62qJ+opPVDHV/WXBens8x+J2NQc3jRGDazLGT47g5nQ6aW3IXXGQMw2f10Ppc6mNZcmIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqXQlTQycbe5mtikT8HEe9uEMzh69CzFYnLKQzb4ekI=;
 b=dqFx/QSGbK0ydopDTfKJOQwTuDTQLFAiYeqm4qTwnFvtB1xMNP6SdEYt5X1myoq+H+etDTnSU+5DHjZ3G+Sd3UAkO/zszs67AK6RgbaAE5IOPEplpRuiVodozzleJ2wgLBo/0MHwUT+bu5Vs3WCOIzyROfUM90WBrPsuSWCSdtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 11:02:57 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 11:02:56 +0000
Message-ID: <cbda2cea-d25a-4d85-b459-3870f6a45800@cherry.de>
Date: Fri, 25 Jul 2025 13:02:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: cdce9xx: Fix use of dev_read_u32_default
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250723-cdce9xx_clk-v2-1-3ba5a5bdf6b3@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250723-cdce9xx_clk-v2-1-3ba5a5bdf6b3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8fb5d2-d184-4128-f651-08ddcb6acf93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzJObTZmTm5aTG93NzVLNkxQZlFmVzZESWZVc2lYbGRKNno3aVFEdWx6RjFQ?=
 =?utf-8?B?ZW1uQ3Vad0dkdWtkempzOEFlemVJeVZ2aG5vOE13NWZZK0YyZGcvYmc3QXEy?=
 =?utf-8?B?enpPVU4zamtKOEJ6YzFwZ1BwWGhqeWVkU080MUluMUhsVkZES0RxcW1iWEp4?=
 =?utf-8?B?eGhPR3Vzd09Oc2tNNUtXWHN0blJ4ZEJlS3NLbHZMaTZyYmlDR2lEZGVvREhT?=
 =?utf-8?B?OGhRdkJpUzQ2UFRONitRSVdlMjl6c1VzTndVVm5lbEVuVVdLUDZzOW12elRV?=
 =?utf-8?B?V0ZBMjgrUEZQWkgxV1J3bkpQWmVOWm5ZWXc0OUdsR1BzYWxBc2dMd1kvYWFu?=
 =?utf-8?B?bEVTRFlGbzY1ODVSWUNDSEdyMlUrd0RSRmFLSDBCSFZKcWZQWlhYYnRsazhR?=
 =?utf-8?B?eElBcUFWR1lXNDhVVlN2THZCQ2J0eHdQYXp3VUNrRThnTW9ZZjZ5cEVrd2Fh?=
 =?utf-8?B?OGF2TFVGWHJ1S0I5UEFpQXRMN3JUb0lXQVZQZVNJWGt6VW1zQWpMQy9Ra1Jm?=
 =?utf-8?B?ekFUMTdhb2w1VGlvOWFRcEk3a21oZTBDQ3NlRW9vN2lKS1FjL0Fmd1FQTnRF?=
 =?utf-8?B?Z1haaTF6TkMydVIxZFdWYnlHUkVxaG82bEVkTURGbmdBdGoybjVtRkRRTDdS?=
 =?utf-8?B?QXRReVVzZkdzMzg2VmxGMmlYbFhuM3VtZHE3aGlmbVhhUDhNNVBqMVZwWWV1?=
 =?utf-8?B?aFhDUlFiRVBFRUZ1K3hCVS80OVU2dnZ5a2RXZ1NRK1ptSitKcS9JOUl5ZUsy?=
 =?utf-8?B?TDNoZDdZejErTUJHaFViWmRhY3dhTzh2bUhZaCtBWWU3OTByS1ZGWVBCamhm?=
 =?utf-8?B?enZJVGFlWW1ZK0RNS0R0eHhiSENUR01oQWRvdkNGMStiY1BDYXlISW9ZMEl3?=
 =?utf-8?B?WDF2NFBPRjdpNFA4eDltL29wT09kZVFaVVNiaTJpTnZhd2gybHR4VURXa3lZ?=
 =?utf-8?B?UkNPakNVUWhSMmhmSnFuUm4xVjJ6dFNLZW42VGRONmtWR3ZVa1ZWblp6K2V2?=
 =?utf-8?B?T1FqOEJUSGh4RmV2Nlg5K3h1ekpGM3kvOGZjeFlCdzlhSXhlQlhSZFJzSTJG?=
 =?utf-8?B?SFpsdndmazl0alpzSTBVYWl1TmJGc3FzZ1UvS2lnZGFCdENNczgvd1FSSXZ0?=
 =?utf-8?B?SGdzTWVlc1IzTXdVZkxTZ2QxTWJia2FSV3kzRHRxM1hLS2lLTXZiem1tVXZE?=
 =?utf-8?B?aEpOdmYvTlZac0hVanVOU3JuYTRXUlo1V0wxU2paL0NTM1E0dmpVVWNicklu?=
 =?utf-8?B?Q2VrbkRXSU5kMXZSUmIwZHlBdk5wY2FiSkRkc3BHUjNnaG9nc2NnSVJRZ1dM?=
 =?utf-8?B?emErb2pjcWNuVWwyNFNJbTN0eWc2TU43dkRRRVg4OGYraWNodTlVWjhlbllo?=
 =?utf-8?B?aHVuTld3UWZpd2MvcWdrZEY3TGNPVzVyL3drSzE2YXFkZVRpdzh5UmQzcEo1?=
 =?utf-8?B?UTdTdTN3L0VRSENDTTFNU1pMeW90NEFnTkwxc3pUTFpFZGlMZ1NRNE5CQXFy?=
 =?utf-8?B?dDhQRldSVlU1dW1kanc2eTFjVHFNb0J2V29MckNwZnA1U2hacGhGS3lta2Nx?=
 =?utf-8?B?eE4vYmV5cFBVYXlOTEZTa09wUmV1eThKSGZKRlc2V3NrcUlsL1A2dkRvZnVY?=
 =?utf-8?B?RlNsTkVDcE5NZ2Fia0k1VVNJdVJUb2Z3aE9qT013RG5mcmswRnNicXdUTU10?=
 =?utf-8?B?Tm9oaTFqek94NWhSTWNnTW45TjhvZjN0RDdCVElSRGNudDFVMEV1Nm5TUkpx?=
 =?utf-8?B?dUlEcXJ1MWpzd1NQRkNLNnRYVFQva0FlUlBEQ0pwbXI0WlNvMkkzRDBEMlVw?=
 =?utf-8?B?SXMzYXh5dnZ3TncyZmMzb0N0aHcrNlJOeklzUkdNa1dSOTV6blA1bWJzdHJO?=
 =?utf-8?B?L2lYZ2pTVzIrd0dCcDJpYXEvcDZyOGpEZktvcGpjVGxrOFVtZEZpaDAxcjBi?=
 =?utf-8?Q?Wu9jRRDb5dk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THNkZmhkR21CZ3k2WUVaSFRZU1hMYXJOcytTQzFpTm1PWTlCaXI2c2JWR2ZY?=
 =?utf-8?B?ZVVCdDFCL2RSaEp3R1R2WGFRTGhQSkhGb0RhQVYzSFVOZnRMQlFZVVpLTHpH?=
 =?utf-8?B?YUZTVHpUQlhIMktyNmdMSk5YOGovUk03N2VZNjhpcnNtVlBqSFFYMTEzWjhs?=
 =?utf-8?B?TXZKZkJPeEVTdHZGVjlYaEFqUlFTeHhGTlJ4NU5XSkxMbjdkd3JjZG5kWDFx?=
 =?utf-8?B?b3p1VTdMSkd4VFRac0JnTVhjYVNxWGtVeDl4MytJNUx6UEQxemJsZ0VPTkkx?=
 =?utf-8?B?Qm9adFBsZ1BDaHBUeFpJeFBTSU52TFR5d3pWbGRpSElxUUo2aXNLOXRvczhl?=
 =?utf-8?B?MDJxNUtVUHM0NTk0WGVHWW5CRGxUZ1I4UVFiS0hscHhobHlidlpCa1Y5YmF2?=
 =?utf-8?B?ZGxlV1g1U3ZUbnlNZGVndjBOV09vRTlQUFJCODVza0UyU0xZWlBPZzJBUytk?=
 =?utf-8?B?S2dsajcrNGtWSzlnQ3ZlN2pDNC9DT2h4a2ZTdDlicUxNVVZzT2NUSXVRa0Jv?=
 =?utf-8?B?dG80eWRpbzk0L2d2enlaZ3RUVUhqVWRzUzRNbW55WFJmZHpMWEl0c29QbitW?=
 =?utf-8?B?VHJzajk5M3NxYVRsTVA2a2pqbFdXQnU5U1pTZUwwRkJESU1tRGRkYnVLWkRU?=
 =?utf-8?B?Tlg2QVRsU09ua0tzMFUrSUpodHA5TzJOVUNxRmJGZjY1VGdQSWVXK0dSK1JO?=
 =?utf-8?B?OWpqNllmc1l1ZFB3b0I2MTJUUFVuaG43dzB0RldNMi9EYVNpR1pxeDNKTE5l?=
 =?utf-8?B?dkZ1K09ibFdUWVNHVmlkdGtJMTNRWU1aaVp0MlJFUFdxcERoOTJ6SkZuS2xV?=
 =?utf-8?B?eGUrZ1BzcGpVQitHanorNFU4Wnd5SWF0NUhYSjR0ZWtJV0EyTmJvNnRDRUV4?=
 =?utf-8?B?cnZleXJYRU8wQmpYdURVd21zTkhvblhkQjlERTJzbGxzMXFLT0RTeDljVWFU?=
 =?utf-8?B?Unk4MUFob1NpZzE5Zldua1ptVy8zc2hkNEJiQTJlUlg3eHloRjcva21aOVlF?=
 =?utf-8?B?ZUhmRjM0V2RPZlNhOGlJdHBkN1RtQnc1ZElhQ1B0T21nbnRHaVFaMFhVdTBW?=
 =?utf-8?B?WGhLUk40bnJnckxKNVUrWUJUcy9wU3MwbXpTSng2aWhCMVhSNDhzajZiYW9C?=
 =?utf-8?B?YldWU3VmcENnMVdnWTFBdVF3eWR5WTc5cEVVMWg5b1V6YnAwc3ZkTm5pbXdv?=
 =?utf-8?B?SGtmeGt3SHVzVUNyY2kvZTQ4a0Q0aFdMV0JPamhnUTFCV1Rib1NiRXRFYkFr?=
 =?utf-8?B?RTZLdk1aMHZZVGNDcXRxOVQ0N1NuOWYzRHJlRVJPT2lUM1EwUmFmSHlZS2RM?=
 =?utf-8?B?b1hHUzJsWERRTjQ1clhMYWxLS0gzK1dsR1UzVWJhNXl4S3FuQ1NGWFJ2ZzZv?=
 =?utf-8?B?THUrT04xbzh6azJ3dXQxODdQV0ZPNVhqdWlSSWduVUFra3lIWnA3c3Bjb044?=
 =?utf-8?B?UWtEdmlwWDgvcFpnaU9acFkyMnBuOVdqcEFiWkl2UkxIZEhjeWkyZWMxR0p6?=
 =?utf-8?B?bjRYQVpmUzRaRUhvaEV5U0VWWXRDVFZxcHRXbmt1ZWxWSjhRa0FCTHh6Rzkr?=
 =?utf-8?B?SURWVTZHV1NkQzAwNGlUckpuazhLcFZaUDRVUkhDYy9UT2t5ZEJuYWJyRmVP?=
 =?utf-8?B?S0JXM2Y2NklNREpUWW8xa0d4SytEKzN3c2FxUUZEV0l5TUFyZ3RQMk43N282?=
 =?utf-8?B?OVVTRFdyYUs3ZkdlYzBXMFZGbmIyTDM2eVppTGxJQ0s0bi85bEZsaEZ6cm5a?=
 =?utf-8?B?aFpMMk0rMWV4YUwwR1YxU0c2UWRTWEl3ZGowOE9yWHRWbFpPcncwZVBBcjNW?=
 =?utf-8?B?eG80RGNjcXJJZTcxNWFsV1BkNlcxSFZvM3ROU2NNbkhUSExXYmM0VnJBMzBp?=
 =?utf-8?B?eFR4dWhTd1QrMjJVZ2xpUzEvaGpQMXUrZmF3WnFOSzJSWDZwUFhnKy9tSGM5?=
 =?utf-8?B?aUJMYlpaZzgzdU9HMVZzOXBsTVBCaU4xTjdidFozUytLRGxGektPRytYNEdu?=
 =?utf-8?B?QU85MG41NjRjblhOaDQyS05JWWJGdS9ZWW9KL21PaUt5aThNY21DOTA5aFVt?=
 =?utf-8?B?SC9LWjUxZ2d0Ykd3VnJ6Z3g1T2FVaTRYVnFNcEg0YTVIRnRyc05VNlcxRHZo?=
 =?utf-8?B?UFVIVVRRWVdwUnR4cSt0ZmtSZ0NINmljd01ZUSszUGNCam1MWlJvRXYyaDRz?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8fb5d2-d184-4128-f651-08ddcb6acf93
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 11:02:56.8474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dn04CoooYMnJx1NmxYgO6BYAUvMEHFaoyinUxqsZT+d3U3jylolJkGeOOZA7agqntk4/T4Z/5A9Kk2v79+9GpfXWrKFZVc5UpAAkTbHDUoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612
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

Hi Andrew,

On 7/25/25 12:41 PM, Andrew Goodbody wrote:
> The function dev_read_u32_default does not return an error and the
> variable 'val' is unsigned so testing for >= 0 will always be true. It
> looks like the code was attempting to return -1 if xtal-load-pf was not
> present but that cannot work. Instead use dev_read_u32 which returns an
> error code separately from writing the value into the passed pointer.
> 
> This issue was found by Smatch.
> 

Fixes: 260777fc2333 ("clk: cdce9xx: add support for cdce9xx clock 
synthesizer")

I believe? This should also add the original commit author in Cc which 
may have more info on what was actually intended (but that was 6 years 
ago already, so maybe they don't remember :) )

> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
