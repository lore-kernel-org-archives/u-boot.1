Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4ED8CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30EDF8405A;
	Mon,  8 Jun 2026 10:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XRLFcWIv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DA9884154; Mon,  8 Jun 2026 10:35:09 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F950807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6gpXvN29QHTZWdqiMLZzt2tFf6BwfvH+SJ2TC28TAx58vZwE6T9drs7yoSlxENVlfyfpkzkkgSIohMS0jKb2CldDkkFHOGrdw+M62u/7ztI01s+8u1Y9xRQkcaKdaO7Q+NAXVm/ezI7FuJxay0/cwRx+JHGf2ZP9HZcG2rMqOqvRJE+zeY/L0VIJt4fyGQO384kmW/dq0grhoRyYL+sF1hK6MXJvCeXyZNHkIwooNA9Bzvmk/LGS8653xtefgDy0zHltX7IOWzmGzPB2I54b+AOJFyDgmTtekbbrSAARCQIlEFKgbUweq3tgwP3fmwAC1rKv9hDjESW1Pm2RxY3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4Ync2TvzKfSZnK4HcMtvYrRrQpMqWXlbkAuJ7BAXKw=;
 b=Xdjq4yJlcB98vRV9draygRb6zj/7S5yF061YPRTCZxhyayzf4w/BUSvzLSHvGRo/mmngr1vM4ocyOrPdXScqJYIXPMMlXV6rTi/ud+v9U7awIQ/rsuDkOEIgg1nIcVcYCFTy6SNGI4VIXw7d6uQUIPJYcg2le6vrMpgmLgJ960gRuUPvcXLX5JWwsVmBu4wknxCe+RXsqbSsktbLzGZYMUKOHXFyl/iWfpkfOGJKUlPkW9IIhj2UxrrFlTrnKKjaray/nUp+6ZRoFSCPbvk4gaRs4lhIIHL0WNrxItUxGgAJglkSxo/L4DPkRUOiPSNB7j8Newm6Q+0zjn4JoPHATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4Ync2TvzKfSZnK4HcMtvYrRrQpMqWXlbkAuJ7BAXKw=;
 b=XRLFcWIvdb9pkCgw72HsHlJNvhawrVYac7uBLeKcLZkDLE0FZBUlhrdFoPZ02DlQaB5shcmFmTLIt8Rod1G+HMRV2zDg+NQtVhAWNXDfWGy5oYach3Y+sJr8XaRiQFnFijkH5+YR341AdkY+QCUrR3Sg3rtVtc1boM++pXoDh5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 08:35:02 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:35:02 +0000
Message-ID: <dbfe4a51-22f1-46f6-bea7-7b2e4e4e0414@amd.com>
Date: Mon, 8 Jun 2026 10:34:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drivers: fpga: Use FPGA_INTEL_SDM_MAILBOX conditional
 instead of Agilex/Stratix10
To: "LOK, CHEN HUEI" <chen.huei.lok@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Alexander Dahl <ada@thorsis.com>, Tom Rini <trini@konsulko.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>,
 "MANIYAM, DINESH" <dinesh.maniyam@altera.com>,
 "NG, BOON KHAI" <boon.khai.ng@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "Rosdi, Danish Ahmad" <danish.ahmad.rosdi@altera.com>
References: <20260428053030.19532-1-chen.huei.lok@altera.com>
 <IA3PR03MB80212DA982EA73C977D48CFBC31C2@IA3PR03MB8021.namprd03.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <IA3PR03MB80212DA982EA73C977D48CFBC31C2@IA3PR03MB8021.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:254::12) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: ca1f95ee-d75e-4660-e6d7-08dec538d5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UIAWy1j76Gl2srKM522WYyeuSfHTrXWid/uCOZ0meO9gaJNlq/2cnP0/bqRSbdjS7fubxUsp1a9FyUKGbFDunwShTLkdH6y7fqdDulaNj9f306uKDObwCE0NXrIABUwa96r/Ox77/HkvxQWxn9DvACCBXWfteWPH9yoLerI9j5ANJoFAR6D8s1xEJlVUwOUZ/mR4PmCp4uXXMpmGsCt2kPO1NKDIW3lrFLqfMU1cr50a8e2J+EsCkpPmhbCV01kQ7TI+2HhBPar2L95Q12N8xYaPxlOL2pjMosyNK6z2rwODEocb1LNm5QEbciYd29+kThgMXMt1CA8v+G9laV/efOdQWJlggYbR4xVqcJN4J+MjYL7N90xUjMDDY2+Dfv4luCOP4MDNzcq0w71F3PR8koAvaIUcaBdBemo6IFyg5PjJCDbIALEtxqS0y7gsQOuZcR1w8nuhCdNAxDUlOttPrXPgWqLh4wmx1ZpqhQxGGp4Z67XTEfhSACVye9CGUAlrcxMfcKSaB8zRQynlsumuMC5DLjKaF8oFb37AvIjqRJdPITHflbhmlaNrmy+3oYkBVRyOS53IHJVzYJGeLcikMuYC4lndVauhN/zMbmwsgHXXpw82ViBnHvVnPGlvU+O6gz1s+J4kUIF2dGAgFRBaxo3Ywy3xUdggn9m5qYcKRtFWQle+xkx0JYPf0Dav/dtK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3QyU0NDNVM4bkdQZVEzTkVnNmZNWk1NZ29BY0JSTlFPTk1tQXdNTHlYRFBI?=
 =?utf-8?B?T0dsWVJaNEJMejNPVlJ6M0FMVGlFSGY4ODM4WS8zd24yZjdJTU8xZXVxWStm?=
 =?utf-8?B?UittSGZNZ0l6aXN6WDFFYS9BYWtJYkx3UE91NlNYSUNqS2EwcklsZ1BkMHhP?=
 =?utf-8?B?Z1lWUXY0UGJ5eUZsUEhyOGdUVzFVZFRpdWV3SzcyRS9KMjA1OVJkdTIxL09R?=
 =?utf-8?B?TytWckZoelVJYTZUZ0tyekFwcmNwanhKbHk0b3RxRmR2ZldEZHVVRnVybUpR?=
 =?utf-8?B?L3Vscks2aDZvNEhrUnplT3VId29nc2N5anFXNnFaazJyWVNlbEpCNDdvQ05H?=
 =?utf-8?B?UTlRSnF3NkRpNnpKeUpYb0tYMDVKZjU0UGJBN0V3YjFYQTJnTWNDeUdLdG1T?=
 =?utf-8?B?VkcyTDNxV3FScmFJT29nZ3RxalVkVFIwcFVFc0U0U1R4L0kwWDUwQlowK3NX?=
 =?utf-8?B?N2NDSUVSeVpjZXRoRVkyYm1IMXl0TTBIMExMVHZGRUp5TkI5enFuTmZPUmpP?=
 =?utf-8?B?SEU0MDFQT3dtcEtZWjBTVGsxMzI0Q0FGUVBMMlcyNVdMMHdHTnlFRFV0Um5m?=
 =?utf-8?B?cS80NEtjQnpsY0dBZmxaWUZ3aUloU3FPY3FKalRBUDJxcVN0ajhCcG9IREs3?=
 =?utf-8?B?NHYzQlRaK2llNml0N3VSY0Q2VG84WVNkQ0JrTGVmNUpMQVlibVREV0Zab293?=
 =?utf-8?B?MFhkcEJPdWZNUWI1Y1l2anN3WVBRWW9uQ29JZytTcS9WWUI0N0hhQ3owZ1A0?=
 =?utf-8?B?QzZ1a0dMdElTM2hYeGNOUzVjdEpwY0lGTm1DT2NrazcxRkRCeFZES0FSek1u?=
 =?utf-8?B?a3pYYjRZeEp3T013a0xVZjZ2SnNVKzFKdEdWWlVtZXlYU3oxaTRmY2U2QmR3?=
 =?utf-8?B?ZHJ6eWQvektPS0NudjI3QzQ1K2xOSVhJeTRtdXVMVFBxZ3JBTUZjRGUyWmpM?=
 =?utf-8?B?SzlCYnFuTVpSVXg2SEZ1Y0NlSDJaSlhXZjRIU1dYVklUSkQxMXZueU00cU9B?=
 =?utf-8?B?WWtVVzNLditMRmt6dGRDbzlVK1VPa1J1NkZHYVNFci9mVjNsZU80YzJqcmZi?=
 =?utf-8?B?ZFVSaFFOS29lRWIvS3pXR29BYktZb1FOUFNWQ3lLeGJkdWhWL3RJK01BN2Ro?=
 =?utf-8?B?QlhmSyt5UkQxdEFsdkNWZGs1elNrUlkvbXI2VlppNGYycWJRRGNQZ2hqUTRN?=
 =?utf-8?B?dFI5V3RjNTFvNTlUSzF6U09yalhXWmgyY3JIbWlVUmR6MHJsM0wrSmdraXhs?=
 =?utf-8?B?b1RUd1cwV1V5VElQVEl3eHZqc29IL2NoaUdTc0F4VUxxTkNSeUdUbUk3c2Fo?=
 =?utf-8?B?R3NyV3YzV1F0dnJaMzZsNmc3RVY0M3laWDRiTlpqc1JSVDNiekI2bkljV244?=
 =?utf-8?B?V0VWWDRDajJCY1JNbDMyTXp1SVlvS3h2U1B3cGZKOFp4QzgxSjdINERmbitG?=
 =?utf-8?B?eFJzcnF6TGpEdldOQlE4bmMrd2ViUnJKaFg3SnBoMnhtN1U4R2tKOFdrUXpa?=
 =?utf-8?B?cE0yN3Q1aXYrdFNMWHg4bzNLN3VDcVIyRTFkcEdEQktCdE1vaTFiaWZVQWdK?=
 =?utf-8?B?VUxiQ2ZyeTIxRlJiek9jSkRBOXJUVmErVWxQejduY25YQnJFbmprUlZ0d0Ir?=
 =?utf-8?B?NE9HY3RtL3EvVVBzSWRnZkNTS0RpY0VyMWcyb2lSbDFSS1JlbVE4UytNbVdW?=
 =?utf-8?B?MkJ5WTZydlQ0WEp2QStQU0JkU2tTQUdlV1VSdWpjMmN4UjRwTUhsNHNDMG13?=
 =?utf-8?B?Z0E3WlZWdWxxQzYwdER6Y1JVdlEwbEJJd0dvS2JkY2EydUVFWkpaTkovUUZr?=
 =?utf-8?B?SzlGQVFKdWhWeW9EY3NhNFR2M1VFa3RJWlNPK3lTWmJwQXUzL0NDWUVFNjl1?=
 =?utf-8?B?OTJyMDJ6NVdmSW9RWXJTKzNEQVBOUzBmZjAxVTdFKzlkNytERU56aUQ4MVZ4?=
 =?utf-8?B?dkJCK29QRWhvSTJHZDIrMkFSNUxydE5MZktiMzNIeUd1OHBWdVo3MXVtQnJh?=
 =?utf-8?B?Ukt2WFJvejR1NmVmSkRlWEdnT3k4V0ZqWjNmUFlFamJwMjU5Y2VRVmNUOUxx?=
 =?utf-8?B?ZFZ4aUNtWFY0QXRKRXk3dWtiQ2haMENjSEhZNGhYOEZPWmhYMVdVZityZ1dv?=
 =?utf-8?B?Ri84VjR6VTRNdWlNeFp6YXpKeitJdks0T0swQkRkSUZ2VDNkWUZrTlhHSnZ3?=
 =?utf-8?B?cXZUQkFwWTB3cWJhRlNkRURDeDIwRlhNL2lyS3hrWDBIUS9CYmk3czNBUmo2?=
 =?utf-8?B?YW9rcmd2WUhCMHJ6NHZRS3daN3VrWGxEVHRiRzIrWkpneEF0V0dDeDdUZEsx?=
 =?utf-8?B?TlJ5bkRLd2RkQzIvMUs2dVgveDZ5WXRhbUZGYm84TjNmVExER1cxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1f95ee-d75e-4660-e6d7-08dec538d5af
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:35:02.8379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1FVKAvu/bP8/x+ocgJQA/a+yUqJa9cqiJMl9If3cfO+oni8ohNVrQq7UPE4BHqY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067
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



On 6/8/26 03:19, LOK, CHEN HUEI wrote:
> Hi Michal,
> 
> Following up on this v4 -- this addresses Tien Fong's review from v3
> by switching to CONFIG_FPGA_INTEL_SDM_MAILBOX as the conditional
> instead of the per-SoC arch checks.
> 
>> Replace the conditional compilation checks for
>> CONFIG_ARCH_SOCFPGA_AGILEX and CONFIG_ARCH_SOCFPGA_STRATIX10 with
>> CONFIG_FPGA_INTEL_SDM_MAILBOX.
>>
>> Signed-off-by: drosdi <danish.ahmad.rosdi@altera.com>

Obviously this is wrong name. Please fix it too.

Thanks,
Michal
