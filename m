Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5B0CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 05:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD0F683287;
	Thu, 11 Sep 2025 07:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kLtVpONt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58A9E8329B; Thu, 11 Sep 2025 07:41:59 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5995B83236
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 07:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Px2LEuVdoWzb2BQIaB3msKCrwlmJzRDmbeFSHp0SOll8bvlf34FO8BU3gH/UhG+tTpu3NblGYSeQtdm8y8b00P8iHcNBe1TxAKh1xSpeufnA7M5Q+nTFagYX5fNQLmTKJJ25QwA8PHiOwIuUH6MBIL1q3PTMGF4rEzaICgZCvFs142BDTOw3NAbkyYZ9vjspANoL/wMwc7X38MRa9y8O0PPhOCh/vrbgQekfSu1vHUbCYRjGpHx9el+8AloDQBsSrAPuyI3sbDFTSyfnSxDHDEEC6Mhh4PiYoq/zyZKXR/kIrcce2+PAMcArW01uZZ5sPPZCawCvsqfSrIrS1e1rfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODjC12SYWyl5QJ5zUOqs7w6IYrkr9p7VmMdA6kmzSVs=;
 b=o8AqPcoL7Kb1EP0fuMN7clTTBd8opIZG94Xb4RLJ4CahhHSmiMuDmZtLImxNBP958U5asd1bJrN8vbvV2ayRoTzfjnEqvBMHAD/LcwLAQaN0wVE1qXWVhxfC5xaUQzM9ajUSN6mgCXPySenrFE2Ts4WgV1dv3gyCn1ehSXupJDAB6V7SMbaD+DmePwMMkVEsdnHaSgbLhjlLjl3BiTT265hpoiloQODbpJus6smDzsoGBbmankKvJfjGqJkwBSua4i4W3TYogdw+vCrs1YG1WZhVyI64Clw0KZH6RrykLqCqaILVBuLWd/GO1+2eac0OmY7J1qyyo2qlgBNBwtgx+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODjC12SYWyl5QJ5zUOqs7w6IYrkr9p7VmMdA6kmzSVs=;
 b=kLtVpONtzbQfE9JIVwjHbvXksYEIkaGdXexfK0ITI+jcGpOrN18GDwH7SrEalPnboMWyTt6VRoAGrh9u7tG4g/BBH9HHxfV8q7kmyfy64sgAX9J6mVAQc1vOqZRtJd9H3FEAY1BIBuSyWv+mU9hVJrHM6GhGn0iZXZ/n68Dm+qrLcx8/P3CA+Tis0P7iAaT1boP1vTdLtlmd5dUYFpoZop+tNlWvt0ienXkCFy0RCJL4kydNCs7t7QADhYM6xtCyPaBzRVw31ZLOoKh5JWTN9DS8gI5z4OeSbhSS47MHVLTF+CG7SkRYbrFAh4N1gLyMs5kfsnB8E1kT48ewlfOg8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by CH0PR03MB5986.namprd03.prod.outlook.com (2603:10b6:610:e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.17; Thu, 11 Sep
 2025 05:41:54 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 05:41:54 +0000
Message-ID: <1d7e28de-7580-404f-814c-9bb171230c00@altera.com>
Date: Thu, 11 Sep 2025 11:11:46 +0530
User-Agent: Mozilla Thunderbird
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
Subject: Re: [PATCH v2] mtd: spi: Add ISSI QSPI to lightweight SPI flash stack
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250828063638.30278-1-nareshkumar.ravulapalli@altera.com>
 <1e597315-bc7b-49dc-968f-4e5ef1d5f43b@mailbox.org>
Content-Language: en-US
In-Reply-To: <1e597315-bc7b-49dc-968f-4e5ef1d5f43b@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::25) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|CH0PR03MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: b278e646-4acd-4593-c1ca-08ddf0f5e9d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nk5HWnNrU3BjZTBIMjhOMzgxT3IwdDB0TVRHRlhrOWNvbFczVHBHLzRqcm9T?=
 =?utf-8?B?dkVzUXdJNmRSWk5qb2ZoYnNkRitZSHRUR2V4cUxQR2hPbUJUZVlPMk9iaTZU?=
 =?utf-8?B?bTVEeUZyVFBCQ0d4VkxUTEpQRkFqQ2FEeDRyY0pDbUFzSGxmLy9ucWlxQU5x?=
 =?utf-8?B?ZEhuNFc3cWFqR05ZTFVjS1pGeE1LOFVJOGN2WEMwb0c2Zlh5ZU50TmZhQnUx?=
 =?utf-8?B?LzlkbDdhVC8zOWQ1bkpGYlpNZFdqU3UvbWZvMnhhOUhiaUwyTVlsTVdjRlBp?=
 =?utf-8?B?YnZzcUsyU3JIaHdiR0ZidmQ0elZkcDFWUmtKZXV3dE1nWUg0NEFIeSt3eFhO?=
 =?utf-8?B?Z01ZUzJodXBJUitKdUNoMGQzakFSUVJDQitXNTlMa1U1cjlhZzJRUk84bTdD?=
 =?utf-8?B?NFQ5Yy8zRUtGRWpMbGthem9aUHdxWWUybXFuV3d5Vk5kZ0xvdDZacWVHcXND?=
 =?utf-8?B?MGZ6engwOXY1VDZFNHcvSXU5STFJQzM5Y28xOWIvRndJNFJzTXZUNDRuSW9O?=
 =?utf-8?B?ZlM2V0JMZmJTUkJBaWRWYVN2VlQ4UkFoeVBveHhrSUpNbkc5RGlOK0hhcUxw?=
 =?utf-8?B?MEtmQ0l0L2pUV3QzYWhVL09BL0luTUxYZk01UE1vLzZVTFRHY2xrd1QveHJY?=
 =?utf-8?B?aTZtNytmT0pLeUlHUnRmeXA2YmNjYUFnN0dlcmdRY3Y2UlAxRXFXaHU3NEg0?=
 =?utf-8?B?OXNvcnN0UVNYcFI2WWs1ekRLaXdZVkFrLzJOcU9XV0RIRENCUVhIWDFNUVlG?=
 =?utf-8?B?SEhlNVBJYk4xaUFuVGRFQzQ0S2tXWTM3RjY0b1ducjBjZEErQXlSMW9EeDk3?=
 =?utf-8?B?dlphcHhnQ0pLN2ZZRjhDQzZTNEp1RmxVZlFwMzdwOFd3L21yMVZuOEJKTTVa?=
 =?utf-8?B?UnhzVTFNZkZzenh2NDlRTjBkcXpPYVRBWXFaR09TbDBBQ1RaZjY2TEdVdHZw?=
 =?utf-8?B?Vzl4bnFxcFRldUpoM1VjTzZhMnZsSkd2S25aZXdURjNMTGR6cVRLU2Jyc3hw?=
 =?utf-8?B?NVZ3eFM0SlBZUTcyaTJRQ2tuSFN0M1pDRE1tWjRSeWZ5a0hpeWg0OFFwZGJq?=
 =?utf-8?B?b2Mxa2NPS3Zmc2hjYUNNc2x6Ny9OQmpKVFRIUGsyVEFBMmtGSjYyQno4RHZF?=
 =?utf-8?B?c3ZWcDJlN1hEWUNEVHViNWJQMkZQS2FwZUE1UlY0MmNOTGJUUFQxSCtZVkZ0?=
 =?utf-8?B?Nnk3dldlTHFuWll4a2JCc3cvNWpSRXZpTUhiWUtoMWVINWNDNUE1ZjllTzQ2?=
 =?utf-8?B?bG9wRzdzTUZBUDZjMTV4VWl4dFNKaHM2UktuZWlIcXhBTWJ4V1lhM3IwMUJu?=
 =?utf-8?B?YWtEQ0prWWxsRjBONG9KVDRWVmliQXdEVHY2VVhzSWJnVGdvRmUvS0FpVGpV?=
 =?utf-8?B?bGR1TW9zRmtVUW5YelVFTFV3WEU2Q1h1ZnVJMlZiTEhNRzVoRFJEMVpVcFpo?=
 =?utf-8?B?dSs2dnhzVWxkbURsQ3JoVFdGQmVnMVhEUEFGUmtBd01Lc0l5a3N1dE9yZ0E1?=
 =?utf-8?B?WmJCK2cvV2xHV3hRRzZBL0FrZ3ZMbmNlOS9XMEZuU2NkSGt1eUhEZFJYMHlu?=
 =?utf-8?B?OHJKTjJ3TXRNb0ZBQWVibm1xWmN2WVlHOHc3VDVEcFBiWFR5emltQTM5RGlh?=
 =?utf-8?B?elpaQXRwK2hFWmx0VWFOcmFjSTBaRDhhdlAxb0dWbTFiUjBoSU03STRsa1N3?=
 =?utf-8?B?R2crR1QrdWtSK2J1SlF6b3hrbVZwZndBOVBPQ2lHM3NCak9TZHFxTVBHKzdH?=
 =?utf-8?B?WDQ3SHRncDVEeXdPVmJzYmV1VnZOMndmbzJ0NGVlVE5WanB5NnV3RURGR1Rz?=
 =?utf-8?B?MGh0Y3VSdVQxMHNwMUFvRzlwWGRBbDhGMXUzMno1MWxQcXJZQUJNRXhhMTli?=
 =?utf-8?B?cTF6U05lK3F2TTQveGZXajVJY0kzYXNXR2N6WmNmQ3FyTDBNaEV4bG1PZ1da?=
 =?utf-8?Q?pybXjlFnQ4k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UllzWDNhRWYyUm4zcFFUSEIxdEVoREdJeFQ3M3kwbXc0WWlQeTJ2R0ljQWxY?=
 =?utf-8?B?bnFGQmpiK3lnVHlqYlZMS0VURUxQYTlWVHNZUm1EdSsyQVFvWDFrT1MwNCt3?=
 =?utf-8?B?SFFRcVR3RnF5L0d4K2xCV1hTWmIyYXZHRXIxSndpanM4VmppbUhzYTlSOVN3?=
 =?utf-8?B?TGFzV05qSzB4dnhzR05KejNtbEZZcGFtVjQ3RlRKSGp3VWVrQ1ZuWGNPeFgr?=
 =?utf-8?B?OCtMaHI0RWx6K0dIdktBQVM1YmtySktGOW5DTWJ5RkhVcWluUHB1aCtHaWlj?=
 =?utf-8?B?VUJlU0dYNFJYL3BkTFFBaFBCV0NWeElpN1BHSzN2bzJlRWladlZya1FUVjQ4?=
 =?utf-8?B?QkZhUWw5UXN3dGgwSjFsYU5SSGZOUldYNFhCTk4rdXlOWG14ZjFwRXRMMHl3?=
 =?utf-8?B?VWdmMWxDbE5CQkVZVmt5RHJyWlNkYUdBOWhwSnQvWHNvcE1VOThpb0hHRXpG?=
 =?utf-8?B?TmUzUnI1TmlRVHhvNHRBTVNlZkgwOVJGU1RjdkVubXdkdFdtWTQ2UWZtcTJN?=
 =?utf-8?B?RHZYK0x6eTJreldhdDB5YkdwRXVTL0JJSmZONUI0Yi9MRXJEMVcvUE02QWhN?=
 =?utf-8?B?QVI0Wm1TTkdZbzRLWU5hcnB3eHBsSjFCR1crNkwrbGJVazZ2MFdXZkttT1VW?=
 =?utf-8?B?ZXp4NEJQRDlNTzhoSkNZU0srODlZOTczcHY5M0FzZVRsWGZUeXVaOHByRUdF?=
 =?utf-8?B?TWR3VnI4SU1Oc3Fwam82UkJCLzV4WDVldFBIdldoRFNHMitSbUdYSFFmbCtu?=
 =?utf-8?B?dGdQR0RvaWROZ3R4M2VKNC8wZFovTGw5K2FzVW9hbzBkQ3dtR3BtMGtvcG9F?=
 =?utf-8?B?YjY3RnFOQ1ZQREQ5Y2lEWVJ1OUVKbFZSZU0vbDcwVjFFcUlSTkVCSjZ1eE1J?=
 =?utf-8?B?YjBvOXRrV1BlTjM5dkRBOUlFdUFXSkdsbk5YcXNuK0o4Smk1d0VvR2syZ0RJ?=
 =?utf-8?B?bzV4SmdPd2NsenBrKzZ3R3hEdkZEeEZBdnQyYWhkcm1xclZTanpZb1JLS0Zh?=
 =?utf-8?B?clVUMDlXOEhrVGV3Z2JBTGYvSDh6Ylpqd1BqZnBNWDNKVUlLRjJUejJRdzkv?=
 =?utf-8?B?SkZ5VGdNWGoyaUUrN0hTUlY2a3NsMXI5ZDBsRUQ3SEZacWczME1SQldMY3dB?=
 =?utf-8?B?TmQzV0JwVW1lSUtxS0FsZi9SdVFhbWNOODYyNnU4ZDYwbnJsVFZYS0JUZXBZ?=
 =?utf-8?B?c2kwZm5na0NxTVFSTkxxOXc1VXkybVlzd2JCVUJ6eEY0MWUvN1dJKzRxRCty?=
 =?utf-8?B?MXZMK3pnRE15OXhSVjFvSys0bVQvaDNRNnM1eGw2ajNBTXJvN255eHVTdkN1?=
 =?utf-8?B?MlkySXJDOE9DZFVoQVV1TE9CanJyOHFKcE9ZYXNoTUJtdGRNQ1M1RVdDQVNa?=
 =?utf-8?B?TDBSZ3IvcVI2c1B3NlFIdndTSWRpL3hJRm5WOEZCUzFPWktiZ0ZzNGlyYWNw?=
 =?utf-8?B?Q0JDOXRCYVloVWw0YWxhTHJtMTF5OEVvVlhMdTZJa2xGbmdTT0h2VkQ1MG51?=
 =?utf-8?B?Vjl4YUJLZmlCSVhmK1g5RGZDVzhieWhLTmlqSmN0dk1lYU9LRnhOVDFLNVNO?=
 =?utf-8?B?amdjVEhRaGFEL3VzV3ZJOWc5M1EycVFJUURJQmNJZEZ4Zk9lMFFPR3Y4U3VH?=
 =?utf-8?B?Z2lDYmJiTjFVd3ZRUEZla2tTblU5Z21WYTR4TlI0b3hkcndFVXdmZWZNNWtV?=
 =?utf-8?B?b0ozKzk4MTJCOUZQcGNGYU1ETGY4NjlSMS9FZVorbmFOZnpFQkZWNVZsa0JF?=
 =?utf-8?B?QjJlWWRpTG1xdk1jSk40TDZBN0dDM2o0L1lKcytqbDBpcTYrYmJLMkFRQ2Uy?=
 =?utf-8?B?TUZpcGcxbGFjVU1hemlzUkNjQWhOZDRWQ0R0UkVOUTg5KzdJOVV4eFBFYk1l?=
 =?utf-8?B?YnJZOEswUzZORFJmQXc2bGZZdVh1ZlJxTEVLMnFpL3lROXcyd1NWdnhUQUdp?=
 =?utf-8?B?bFdINGI0TXBtK2V4c2xxRk5paGZNTzQ3QXRCWU1Kc0ZkMEduZ0lOM05abGM4?=
 =?utf-8?B?TFA5dG85SzNjM2lsZ0tFTnFxeS8zNWpHMUxnZ0lpSWJmRktVeHJ5Qms3U0I3?=
 =?utf-8?B?SFo0RWFsaDZRZzM3OHFWUmFJYTE3WmR2OG5rVU5XZ3FWR1hpUG9FS3htOG9R?=
 =?utf-8?B?WDllZncxNC9EcU91b3ZWbUY2ZDJVWEZZZDg2QUxWL1IvQWxBUExoK1pZdEJl?=
 =?utf-8?Q?gPNJb2gDZILf4YsZ1DrltZ4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b278e646-4acd-4593-c1ca-08ddf0f5e9d1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 05:41:54.0740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPGqiaePA4i/SPj8KhpCBhf/0a6XFlkOozZMviaBh/2t3c3184MHt33O6pJd4tFX8jJDdcsNTvEStRG43qduU9Sz79N831BahljX0ARSe21nsreHd0WKx1KcZ48BGh2Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB5986
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

Hi Marek

On 28-Aug-25 8:50 PM, Marek Vasut wrote:
> 
> On 8/28/25 8:36 AM, Naresh Kumar Ravulapalli wrote:
>> Add support for reading data or images from ISSI QSPI flash.
> Which part does this implement/fix/.. ? Details please.

We are just adding ISSI QSPI to be supported by SPI NOR tiny; just like 
Macronix and Winbond ones are supported in this file.

> 
> Is there a matching kernel patch ?

No, I didn't find any matching one.

Kind Regards
Naresh

