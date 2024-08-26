Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A288DC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 08:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10D2E887F3;
	Mon, 26 Aug 2024 10:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tXKhw1GF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1148188795; Mon, 26 Aug 2024 10:48:36 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33884884CA
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 10:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVOClZv2gGEKAzvMtX6spZ46M+ekPVWET2caGYCgXWOCiG2DMqaA/Rn1SynOSlvoEyD8vFv1ps/8ii7XUowcDlehvSX1mBczV5b2AMU7oBAUaJhby6tfcEb0a7VQVHoqE/h39K3iHlJdMTqU6APMwf5jX+xt5OiyM9ErVtWZGqayd5zRp8lSjVMber4pcU/MO4NnOtWSrb/VdHH3Bw5tPI1edRmCPISLr8I4TpggiQ8OCVJxkisMzkjySkljB/yJbJnRtEpHCAd+JMTpNhCFi7rjm76mwh8bMdW4MG2KdU3pMw7tIo8Uxhl+6ZeBVJVpvW3no5BLtfRH99scldT4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaOUgebf53tp8KKXmDaKKvWGWF4GKdEmXZ2zWfkA07w=;
 b=dHO+tj6XXv0QigPNWxyciZaf39q3LqC21c7lscO/hIz0MAxf3Y3lYFzzCHUm4KI5Mtun0RfBNWlcBGMhDD0C7kLNIsDx6BI6BunJT0R4XPYTncEM4sGyM5B6IglyMH+ncIbVjELWtveENcQ5AWLYykHCZ+qfsmuBktpkO3LBHo2Ax1AuqdwP7qhzjCWoLba+EN7uflW4rdGdpXl6w8OYGzJhBE7WPfQO7AJkObfagjTtbj3gm7ndGgVJS5qExdQ72un2bIVfyA90ffe4PEl6cqV+JweJt0RX57JDJXV+9z3OIBe5gHGSHnAVAh7ktItIQRlm/2772epn6C7K27SM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaOUgebf53tp8KKXmDaKKvWGWF4GKdEmXZ2zWfkA07w=;
 b=tXKhw1GFcZ4JQ0mlQOrROCLYpNrgI/YQaIxhQlNnkDl4Ik4KuyRZxT06Ac4l9J/yqoWm3/wOyn7ZhybslOxAQ8KnysHm7rFOiplL/DxLcAfU9dnNWase1i0AkYiVW509uGKkrZRViO86I3T/6/HwzK9bGCqQxHvm/ufailV7N5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 08:48:30 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:48:30 +0000
Message-ID: <ae9343ac-a862-4a7b-ab8f-dbc4ae5433e4@amd.com>
Date: Mon, 26 Aug 2024 10:48:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
To: Simon Glass <sjg@chromium.org>
Cc: "Kummari, Prasad" <Prasad.Kummari@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git (AMD-Xilinx)"
 <git@amd.com>, "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "git@xilinx.com" <git@xilinx.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "d-gole@ti.com" <d-gole@ti.com>,
 Love Kumar <love.kumar@amd.com>
References: <20240806120659.686073-1-prasad.kummari@amd.com>
 <CAFLszTgAiRBih1JOtqvBEi8QbVc4-yV7Mq3kam=_FRgw58mtjg@mail.gmail.com>
 <SJ0PR12MB66851EC7FDDD9A61A63E4DE982B82@SJ0PR12MB6685.namprd12.prod.outlook.com>
 <CAFLszTg9VemEeiHkOzh+jnQ84y34V3A+EPU2_YaOJgZwhn=7GQ@mail.gmail.com>
 <9aaf2326-2339-4d9a-b5b8-c5115e844599@amd.com>
 <CAFLszTgHsgJ6hP3FjLicHoiMAh--OCFLJtSUCVWiCukDBczoCw@mail.gmail.com>
 <59d3c644-350a-4325-8e64-c14f6649a60f@amd.com>
 <CAFLszTj5HW1NGaKgV51tCv-i-vSUR3btYcFbc3-WFsG8CJtFCg@mail.gmail.com>
 <cab33499-07f3-4833-836c-005f3ec67fbb@amd.com>
 <CAFLszTipK435Oii=UuAUaFd4zXPvML8U88s9iCk13hOWL5N2jg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTipK435Oii=UuAUaFd4zXPvML8U88s9iCk13hOWL5N2jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0207.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::28) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff814ac-c76f-42a6-b6ba-08dcc5abdba3
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHdzMWVMZEdoV0hMN0lzbkZTenhWUjhrWCsyMzdJRjZ0bW81L3FQZVc3OUFU?=
 =?utf-8?B?UGZWYTlGRFdtZGI2OUo2ZHloRnovajExQ2FCNVZDSmptM0lDWTJWMFpRZVE2?=
 =?utf-8?B?eDhZTnFrTHhod1ZMUy9lSzkxNFAxN3dVZlUzRzdVSE1HZlRPM0RiR2JpQXF0?=
 =?utf-8?B?U3paV0lacTk5NTZZc0p6M3hrWDhhdlFVUzEvVkpNaVFyZHRKTGpRdmErRlJr?=
 =?utf-8?B?UEhDZnVYNk9VZlhlWlp6VnYyc2pTY2VVeGh5djlqamNJS3dPSG5Ld1ArckVp?=
 =?utf-8?B?ZFlsd3k2cU0vNXhaZ2xwWU5PRjlyaVBqMHU4UlNsUmVwYjllWUtaN2Z1eHdn?=
 =?utf-8?B?a0JqVitoaGJjWlF5clhVRCtpSXc5Z0JhdXVSOXFqQ1VjSnZXU1hEU3UwWWtJ?=
 =?utf-8?B?ZVlhSHA1ZUVnQW10ZEtnV3FLNS9oR3JmODYwQzhkMitIMGt3NTZxMlk2VUJl?=
 =?utf-8?B?UXByUG4vVTZoN3dWMmRMZlVVYy9FMDRMdWNMM21KZGZFOG9iWFpqY2pwQ2tS?=
 =?utf-8?B?YTc0Z1lhRzZPQ2NlRloxSytnb1BVaFhQaFRpeFlHWDI0RU9MMlBNL1d1anUz?=
 =?utf-8?B?bllqbFpNTmpwWkhFZkJVRVI4dWYwRk9JdkVVRWx4ckljdEdiWTMzMGV1dUsr?=
 =?utf-8?B?Wmp1aURYeTFuL3pmcWNpWXR3ckpwUnBjeEt1bHovUE10cDRsQW51allNUVRZ?=
 =?utf-8?B?OFdCOUJPM0NLNlhHUlBzSzJNS20yYmx0UDBuS2NteU9tZGJ4VU55MmptSW1z?=
 =?utf-8?B?c3k4ZTh4Qnl4Y3U2WHNRNkpaRVBhME9yVStBNUpmbGxoNWIyS0dxRTh1Y2hm?=
 =?utf-8?B?dDFmVHpydHVjcHp3M3hYTVBFWXJRWFpTYnZLUk9CYS9ERnJDVm1lUDBWbERm?=
 =?utf-8?B?cU9xL3U2NE4vcjJQU2xCR3Y1dXlYNTNkWFJTUG1NYXJHQ25SUXlBdjhFbGM4?=
 =?utf-8?B?UVhkNTEyQkpLcDBDT3hYWmZlMERYd3hiUHVHdkxVa3Y5cGgyNFIzZXNqbDVW?=
 =?utf-8?B?RDFOVWdTUitoY1J3MDlZWlFnam9DNkFDbGFBaG12RFBqSSsvR0pyUjF3WkUy?=
 =?utf-8?B?OVFMT1AvZ0JEUGtvUDQxVlpURmwva2VabUl5aTR5VWUzalJUWWpWc2F5aFFu?=
 =?utf-8?B?U1lIV0c5ZWJ2aStMbE9GNVdaRW1kNUdLQXpCNGk5OTRtd01GMGJCTUp1VHVn?=
 =?utf-8?B?clRZSTdvYno4VmpiRWt1bFNzeno2b2thdnBUcFcxU1hJREdFOGpnOFZkNmJu?=
 =?utf-8?B?U0FHelh6TDcyZFRlTFJyb0t4bEMraDdIaXFCOEFHd1psUzJTV3ZrUlRzRnpz?=
 =?utf-8?B?cDJMbnJPY0VKdEFnMFJlc3RRZ2tFN1R1ZS9qL3JQN2lDYTJWbStrMFM3djZV?=
 =?utf-8?B?Z2xuazUrRGsyVWFQa010bmoyak81RWVJZUlDOVNDSmkwTzA2dTJoekFuTlZU?=
 =?utf-8?B?OSsrSHFqNVJQK242Rmd0ZzRCeVFlV2Z5azE0cHhybkoyYWk1RjQ5bkQrM0Vk?=
 =?utf-8?B?amZHazRzMnord2JQNm0rSXVXOXlPUkgwdCtaME8ycGV1M0tSZzlDU2Y3RFhQ?=
 =?utf-8?B?NnZISlJZaU96M3hlbGsxWno1bHJDbW82NEx2VlY5WXdFcnkvYWw1MDdTTmRJ?=
 =?utf-8?B?QUczbFYyUVZpdncwZmZHZVB2R1VSblpsUUpWTlJHY0VhOUJrcGREcVNEV0hW?=
 =?utf-8?B?SDNPMURMWEh0QjFDU255YnhQU08wd3B3YVpDampPbEVOSmJXVm1VTXVUUndW?=
 =?utf-8?Q?EXfXl3Rm7DQu/93VxQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUFtUkVvb0JTRkMwNXJUZUtiUlFoMURqK044K0JJaGdzU3A3SjNKWnl2TDY1?=
 =?utf-8?B?R3Q2Q3ZYamJLVUpYSTNmaTBvSklnc09lb0ZzR0U1QlhmaHg0Y3l6d2JKQWpI?=
 =?utf-8?B?Mk43MXI0T0o2ZHBqWlRRbnRtSjJHdmp5LzNsNUs0U1VaNmZBTEJqcHR6Qm91?=
 =?utf-8?B?N3FIM2FtWXhjZWxTQUtnblBpOXQvZEE4VVhvNTN1Tmdrd0RKcURMdlBnZWZY?=
 =?utf-8?B?TU1KUWwxZ1Z4UWhiaHpvWG8rWGhJK3ZvRWlGVytsSHIxVTZ5VnhZRnJ0SUdF?=
 =?utf-8?B?OWRxM0Zzcjl2Unp1UkpXdmZEZE93R3VjVC93Vm43T1oydmRLZG9QdTdHdUNO?=
 =?utf-8?B?Mm4yejYrRmtsRDFsQ0lVSW1XeEUxaXR6NU5zSU44dUlsVjhCRFN4N0RjMm9V?=
 =?utf-8?B?SWUzUU95OUVxei9DVkZvM09ucThudlBLTFhwZktvdUFIOHMvMXAxVHdITlUz?=
 =?utf-8?B?QjZ0bFYvM2ZxdnVXeGRKV2J3S2w2dmdEaFBSOXJvTTVHbFdhTVU0WUtXV1pI?=
 =?utf-8?B?cTNLUTh4UEdCcWtqVUx4NWxvSnNyeGI4d1B0cjc0azhOZEw4bXBTUlpKM1F4?=
 =?utf-8?B?ckxXYnRBdUVMNzFxYzhDZkE2RkNQVUR5N014UWVrYUlYdURtZ1RaSGxUak9M?=
 =?utf-8?B?anNWOFZhSjVKTTd0QVNtMUlKK0FERVlsaXZuWGQxaFVVNlI2aUtiWTdrMHVq?=
 =?utf-8?B?b1JnblZBanNLRThKTWZnbDArSmwxTVltQURzWEpqODNaR3dvZzZCSDV2bU4v?=
 =?utf-8?B?aWdJUVFFY1JSbXFaTXNPRm9pT3ZQUnhCejJIc2l2SEhEdjZBa2drUVhQYlMw?=
 =?utf-8?B?bElJTlk0WEduUExHTFJWanJ4NWpJcVg0ZmwvRHgvcG8xR1RpdTZVQzUrT3Rq?=
 =?utf-8?B?SC9LTnM3L0M5Q3h2QTh6U0p4dGlPVE5Dc3RqV2UycE51WElIaFIvNHlObkZh?=
 =?utf-8?B?UkhhdjM1dFN3VGE5V09SUHFpTmprUUVlVFhiU3pYRi83TUgzeDl6ek9USnN1?=
 =?utf-8?B?Y01qQ1phVnM2WGQ2djdtZkFLUStvdjRUbFdVWlNxN2pPRzEzaVdsclhFMmF3?=
 =?utf-8?B?Smc3ZlJFVWdycFMxR1l2UHY5YWVQbjkvYlFoc2F1NWM4WU13dWIzU0duQjQx?=
 =?utf-8?B?YlRjOEFkUDZsdlhwTE5KNTJXeWJhWlZoZzBOUW9RZXM0TmNXRCtvdVltSG56?=
 =?utf-8?B?WFB1TGh1ZkhzdC9uV29vZ0hYSWMvMDA1Uk14RUhTYnA5Y1VZUGNUVmJTcGtl?=
 =?utf-8?B?dWpMVFMwUk1KUlhhTlNTOERrdzJvem9pTHpXd2ZpMllaZTN4MUVFajNIZzY2?=
 =?utf-8?B?NURUOW94QjJGbkJrM2YwSk5aaFNvWVFsNmUwRml6N01JY0tyYzZiRlVCVjI4?=
 =?utf-8?B?dFUxb1RaTWNkUWE5Q2ZhOFFlSHAxbUREN1p5U0p5eFh5VEtERlZhelNWOXF2?=
 =?utf-8?B?UHhVMXByRW5Rdmt3VEEzbUcxVnd6QU1TdEZQanZJYXZpTnltZ3RFSU14UlRE?=
 =?utf-8?B?OURyYjRiekNISndGUGhYdzI2TjVONkRtMmNxeGpEckFnQVgyMTRuTksrcWMz?=
 =?utf-8?B?SUZvR1p6RW9xcXh1SlpnY05RWHRuNnNsbTFwK05Yck5zaXBPZXpIWmpFVmc0?=
 =?utf-8?B?ek1vUVc4UmNxYS9xYnZ0b2drcG83MlI5VmJYdHkxejRPK3I0UFpLQUJxWEZj?=
 =?utf-8?B?VFpBZTRaUEdDTGxMRkpKZ1RKVzdPYWF4a092a0F3WHlJMllDQWxWN2d0dFNm?=
 =?utf-8?B?OTZIV3hUdjhyZmlUT3dJYVp3djdhaFQ1UVVvWkx4dTR1Q1BISjIrMFRIQWtn?=
 =?utf-8?B?Vk9BekY4SXNpVXBUaityVVBkY1JIOGt4UVpzakVuMzlKeDVOblBwRFJVRWo2?=
 =?utf-8?B?ZFlUd0wwVGJxMDhHejVZR0hJZzUrZ0hFS0RsUmppMGRsZktGYmNEdWx1clU1?=
 =?utf-8?B?K3kyRlpQY0F2YVBReGJNTjJCUlhtSEhKcWdGUVQzWFB1Y1pBNHF0Ui91RSti?=
 =?utf-8?B?WFcxOVV6QnN4eXFtb1JUMW1BYnRZY2xoT0V1aVlhQmprZ1F0Y3c2Z01FOWYz?=
 =?utf-8?B?YkRESjBTV2krc00yUWZHOVNKL2NKRENSOHQ1UExpbkdJWlc5aEFzb0x1dlhu?=
 =?utf-8?Q?AkLHEi8PYpB2TleBPpKQHD7Tk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff814ac-c76f-42a6-b6ba-08dcc5abdba3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:48:29.9674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVhfxYrXbJxzZm6KjBUjTSbRjLZveM7atZax5UVRhrpkIhutctac4BTf2+ICIXA0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767
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

Hi Simon,

On 8/9/24 17:58, Simon Glass wrote:
> Hi Michal,
> 
> On Fri, 9 Aug 2024 at 08:47, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 8/9/24 16:44, Simon Glass wrote:
>>> Hi Michal,
>>>
>>> On Thu, 8 Aug 2024 at 23:39, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>> On 8/8/24 16:28, Simon Glass wrote:
>>>>> Hi Michal,
>>>>>
>>>>> On Wed, 7 Aug 2024 at 23:31, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 8/7/24 16:36, Simon Glass wrote:
>>>>>>> Hi Prasad,
>>>>>>>
>>>>>>> On Tue, 6 Aug 2024 at 23:05, Kummari, Prasad <Prasad.Kummari@amd.com> wrote:
>>>>>>>>
>>>>>>>> Hi Glass,
>>>>>>>>
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Simon Glass <sjg@chromium.org>
>>>>>>>>> Sent: Wednesday, August 7, 2024 3:21 AM
>>>>>>>>> To: Kummari, Prasad <Prasad.Kummari@amd.com>
>>>>>>>>> Cc: u-boot@lists.denx.de; git (AMD-Xilinx) <git@amd.com>; Simek, Michal
>>>>>>>>> <michal.simek@amd.com>; Abbarapu, Venkatesh
>>>>>>>>> <venkatesh.abbarapu@amd.com>; git@xilinx.com;
>>>>>>>>> jagan@amarulasolutions.com; n-francis@ti.com; d-gole@ti.com
>>>>>>>>> Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
>>>>>>>>>
>>>>>>>>> Caution: This message originated from an External Source. Use proper
>>>>>>>>> caution when opening attachments, clicking links, or responding.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hi Prasad,
>>>>>>>>>
>>>>>>>>> On Tue, 6 Aug 2024 at 06:08, Prasad Kummari <prasad.kummari@amd.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Added LMB API to prevent SF command from overwriting reserved memory
>>>>>>>>>> areas. The current SPI code does not use LMB APIs for loading data
>>>>>>>>>> into memory addresses. To resolve this, LMB APIs were added to check
>>>>>>>>>> the load address of an SF command and ensure it does not overwrite
>>>>>>>>>> reserved memory addresses. Similar checks are used in TFTP, serial
>>>>>>>>>> load, and boot code to prevent overwriting reserved memory.
>>>>>>>>>
>>>>>>>>> The SPI flash may be used to load other things, not just an OS. What is your
>>>>>>>>> use case or problem here?
>>>>>>>>
>>>>>>>> [Prasad]:  We have observed that SF command can overwrite the reserved area without throwing any errors or warnings.
>>>>>>>>      This issue was noticed when the TF-A area is reserved in the Device Tree at address 0xf000000. The sf command is
>>>>>>>>      corrupting the reserved area,  and U-Boot relocation address too.
>>>>>>>>
>>>>>>>> EX: TF-A reserved at ddr address 0xf000000
>>>>>>>>
>>>>>>>>           Versal NET> sf read 0x0f000000 0x0 0x100     ----> Overwriting reserved area.
>>>>>>>>           device 0 offset 0x0, size 0x100
>>>>>>>>           SF: 256 bytes @ 0x0 Read: OK
>>>>>>>>
>>>>>>>>          U-boot relocation address relocaddr   = 0x000000007fec2000
>>>>>>>>
>>>>>>>>           Versal NET> sf write 0x0000000077ec2000 0x0 0x100   --> Overwriting reserved area.
>>>>>>>>           device 0 offset 0x0, size 0x100
>>>>>>>>           SF: 256 bytes @ 0x0 Written: OK
>>>>>>>
>>>>>>> Yes. There are many things which can overwrite memory, e.g. the mw
>>>>>>> command. It is a boot loader so this is normal.
>>>>>>>
>>>>>>> What image are you loading here?
>>>>>>
>>>>>> In spi boot it can be Kernel/rootfs but at the end of day it doesn't really matter.
>>>>>
>>>>> OK, in that case yes it should use lmb. That was the question I was
>>>>> trying to understand.
>>>>>
>>>>>>
>>>>>> We have protection for srec, fs load, tftp and wget already.
>>>>>>
>>>>>> c6855195e4b4 ("loads: Block writes into LMB reserved areas of U-Boot")
>>>>>> aa3c609e2be5 ("fs: prevent overwriting reserved memory")
>>>>>> a156c47e39ad ("tftp: prevent overwriting reserved memory")
>>>>>> 04592adbdb99 ("net: wget: prevent overwriting reserved memory")
>>>>>>
>>>>>> And this is just +1 patch to protect sf command that it doesn't touch reserved
>>>>>> location.
>>>>>> The same code should be used for other commands(nand, usb, etc) which loading
>>>>>> block of data to memory because all of them shouldn't rewrite reserved memory.
>>>>>>
>>>>>> In connection to mw/mtest/etc command protection can be also done but not sure
>>>>>> if this is useful because you normally not using them for booting.
>>>>>
>>>>> Exactly.
>>>>>
>>>>> I am hoping that we can pull SPI flash into bootstd...has anyone
>>>>> looked at that? Are you using scripts or is there a special bootmeth?
>>>>
>>>> We didn't find this issue in connection to boot. As I wrote in another reply we
>>>> found it via spi testcases where TF-A was placed lower in DDR and test overwrite
>>>> it without any other evidence. Part of the reason is that protection units are
>>>> not enabled to protect secure FW.
>>>
>>> Do you mean the sandbox test test/dm/sf.c ? Or something else? If the
>>> former, then we could mark dm_test_spi_flash() with CONFIG_SANDBOX
>>
>> pytest one and I think it was this one.
>> https://github.com/Xilinx/u-boot-xlnx/blob/master/test/py/tests/test_spi.py
>>
>> Love is working on sending this test upstream as he did with others.
> 
> OK. But why is TF-A low in RAM? We really need to have a think about
> this TF-A thing. This is the second problem I've seen in a week (the
> first was rockchip resetting the timer). Is there a spec for what TF-A
> is supposed to do / not do?

It is user choice where they put trusted firmware.
All depends on their application. Normally TF-A is in OCM but some users can 
have a need to use OCM for user application because for example it is much 
faster than DDR.

Not sure if there is any official spec but documentation is here.
https://trustedfirmware-a.readthedocs.io/en/latest/

But this issue is not related to TF-A. It is just the way how we found it based 
on our partitioning.
Because DDR can be partitioned for Secure OS, different cpus (RPUs in our case) 
or for processing units(MB/Risc-V/other masters) running out of programmable 
logic. In general when you are reserved location for whatever reason all loading 
commands shouldn't use them.

Thanks,
Michal
