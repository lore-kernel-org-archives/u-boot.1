Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A881DC25B4F
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 17:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEAE2886F1;
	Mon,  6 May 2024 19:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=marvell.com header.i=@marvell.com header.b="VbRMCK4m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27448886F0; Mon,  6 May 2024 19:33:10 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 057B6886EC
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 19:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rminnikanti@marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4469uumh004602;
 Mon, 6 May 2024 10:33:03 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xwmhgdk1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 May 2024 10:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ncx74vG7nEfAy2w191kBkJtr604eDffNKbWHcm7OsCrhKi595rWlrrfRpZDyAzHsSkVi6W4bWE5MuVVdKfoHoT4ZeczAeG/ZkeHGRpkdIggkVYAMG7tzOHs2S7xqpVQJcEUGJM000JTToY5lVw0IjEyRtSwyzR7OvuvLoYlWZwzN2ni1bkM3LoDJpH4djJoBuu6K8imroqcSqILOQp8XtQvVQbG0TA/MYjJzpfEK7Fv6s0KA9m752BNehRVWjNNXL0xoIXdgELqx464+SowKEKWueBIgxZ3fUbnDRPrcJWk+AvkOsSoyeDqn32xwarkofwB2hQpMnJ+R894qZt+aYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmnwXH3EjbuUtRlDQCG/JPyvnCMTNcfStCiLAvqd9iU=;
 b=mk/s023yxCey8ilyIavEvlDh+6Py4osI0bDBJFO3l8o6h5LqzBv4YUQhMg1tX+WqyROSXpyzJOhB3dAyNboBoGSnfHTNZ9uU1IR4tgCcLF0401rz5E7OJ2aNW6mfx/QHPUI/6p5r1KLIb35paXEwiuO52Em3xDo6Z2HNbe65H3U+aRT/OgYQ49xUX6ZiEu+ZVF7H4w67PkuWsSxu+BMXiyk5TOD4laCsr9Zq3Tj5femXhTrR0lbD4UuYLijKs6DeZwSUtw4ikRBqxbnnFtEtXt4qL5FbbF3IiJmd020WQ8KJhNYjCp1Iyop6kRrqT69c2iveb2hXqQ7EVC3YyVHrCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmnwXH3EjbuUtRlDQCG/JPyvnCMTNcfStCiLAvqd9iU=;
 b=VbRMCK4mFn+LDLE4ZmRaTd1bZK2k7QpqPgw34kHvPhJ4agHEE3q64Vh+jhJ0rp72duzTqFz40fc2TAPpl7V1+aqdbvl8u0Mow8RGwp7vcozDjfWpV6fRreSIWSPLysXP2imoL9nvLztqPuI69hI6BGGHG8h3s4wrElv3wuVulmU=
Received: from CO6PR18MB4451.namprd18.prod.outlook.com (2603:10b6:303:138::12)
 by CO3PR18MB4974.namprd18.prod.outlook.com (2603:10b6:303:176::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 17:33:00 +0000
Received: from CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::c0ef:b62a:5356:65cc]) by CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::c0ef:b62a:5356:65cc%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 17:33:00 +0000
Message-ID: <06d001bc-0bd0-53e3-4408-21f6d6dac141@marvell.com>
Date: Mon, 6 May 2024 10:32:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mtd: nand: pxa3xx: Incorrect bitflip return on page read
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Chris Packham <judge.packham@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, hs@denx.de, trini@konsulko.com, sr@denx.de
References: <ea0422cd-a8e6-3c36-f551-a0142893301b@marvell.com>
 <CAFOYHZCAKtYiy=3X=u2+oqv3Wx8=W-vtV=+akbo+e479hPoX7A@mail.gmail.com>
 <CAOf5uwm+Am-J6-yiCy0=N=FrcVpYGubtUfW9JT6YN3dp4-zutQ@mail.gmail.com>
 <7f949d87-585b-8dd8-bd8b-d29766da4ad6@marvell.com>
 <CAOf5uw=hsE9ffb0Czzp0B7Q0ZZTp=vHyoRW2oD-ENu_S+qF5CA@mail.gmail.com>
Content-Language: en-US
From: Ravi Minnikanti <rminnikanti@marvell.com>
In-Reply-To: <CAOf5uw=hsE9ffb0Czzp0B7Q0ZZTp=vHyoRW2oD-ENu_S+qF5CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::32) To CO6PR18MB4451.namprd18.prod.outlook.com
 (2603:10b6:303:138::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR18MB4451:EE_|CO3PR18MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 632f5ef4-98b6-477d-5877-08dc6df29384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1ZGU2tzcUtBQlhaZHJjUmtHSm5rYzFRWHJWWTlwR1Z2MSt4VVVxc21WMWh4?=
 =?utf-8?B?WjcxRjJPSHJ6SG96aUtReHBkSHB3WWJxYzFzRmZZemFEOGpEdWpFUk9YUHh6?=
 =?utf-8?B?SnBqNG5yYzNKTnZZNE1aVjJOdm5nNUFjZzlrOWhNU3MvaWUyVE1wUERNbjZW?=
 =?utf-8?B?ajBwMkQ0THRGUHhVZ3hBL0t4K0dEa1o1MUNlTTBjM09nejlkLzdhd0EyWm1r?=
 =?utf-8?B?YmQxMkRRWGFQMlFPNk51RTN1VFZWK3BWWEZNVEdWZWl2Mm1sakJtdURpdVBV?=
 =?utf-8?B?ZGJtN253dEVlaStxTkF2N1doZnBlTUE2TDRvc0I3U3JZeEluUG1Ob0t0THJX?=
 =?utf-8?B?cWZWMFhlRktsQlJmZHE2V2hvZmVPQWJWTzhucWx3WkNGcFIvZXRmT2NDUmdR?=
 =?utf-8?B?OGk3eW5WYmRYc3B3a01taXZhN1JXMllaNlU4dnkrVHJoWUdIM0I1K3ZEckJv?=
 =?utf-8?B?aSsyVjVaTHQxS1h1ZHRIRFQzTjk0U2RCc1pBeThIRWd6dXpWTUNtWFlOWUZR?=
 =?utf-8?B?aG9Lam9IQlM1T0o1ckgxU3NEc3kyMFRyRm8rTDc4aE1RdnJwS0Vsd1BoQ05E?=
 =?utf-8?B?bEVEblF0OVNKK0Y4Z256MnZZcE5mYXJOOXBCNXphL2o4SVRBVGR0TTdsaGln?=
 =?utf-8?B?V3N0RzREMG9aQ24yMVh3eFE4VnlqTlg2VFBsM21vVnNMWjdoY3FDZjlLd2xG?=
 =?utf-8?B?bW5LcjU0OXVEZU9OTjNIVXd5aFZlYVpvYnFnMkRSWXRwRC94bkc3MFRidzht?=
 =?utf-8?B?ZERLQWh1eHN6VmVjS05pREJuYjBGdVBWVzhMUm84dDZqY1N0cDFBbHhPS2x3?=
 =?utf-8?B?TW9VZ2JJcjZHRmsyQXVHK21sRHZSeXhmRFlwSllrdVlhdHEvdzA0SUNKd0Nq?=
 =?utf-8?B?Z0tKVXZWb1M1MHIvMlVzSk9iWlBXL25QQkh4M1d5MXFEcGMrOFovY2lQRGlC?=
 =?utf-8?B?N3FpRis0WWlISk9xWE11cGtWWjdjeVNxeDJ3c1RWdHFKSmV3bDdxelBoUmNm?=
 =?utf-8?B?L3k0VTJRTDhXbVgxQ0plWUd5d2ZZeDliNEh3NEhpUVlUTVRiblVkSDlWUnFi?=
 =?utf-8?B?dS9ROUVwb0lZZ080RHJPa0szM0kvVWhOekF1cjlWTXVtWFNSRFNHM2hYYTBi?=
 =?utf-8?B?R05IQzBUQ1BXU2ZkOEFDS3kvbzU1bVpTWUlOaDBiQ1FBZG5yWHJiaHVQOUNM?=
 =?utf-8?B?THRWcXlyeGVDQkozd210QlRzMEM5ekFyeGhTYU5lM2NuV3l0YWU3UG8reis2?=
 =?utf-8?B?S21rN1ZhMWVTWStWSlArNG1Nc0hkQ1huZjg2T0JMbGpzUHpOZU96Y1BPTzAw?=
 =?utf-8?B?RXFxV3dSYndLbVNZZmpGV3djNExXYURlNEpQUUlraHlFWkdUbjAzK3lYakVn?=
 =?utf-8?B?a2t2a05NZDQycHR3UHpRNU1Yd0hpZWhOLzNCcUtIcTdvM3FkODRBcVA1SkFT?=
 =?utf-8?B?UkNoMVJFT1U0SkdjT1g1UjlsbHFUbk1YY3cxcDlwRTZ5SHpabWlHRTRDdGNk?=
 =?utf-8?B?UkdXVnNCRFd0dmJya1o0RUxTNE1reG1LMkxuUlNhczRYU2VCWGlCMThIVGpm?=
 =?utf-8?B?QTdrMDVzaWE4RFJYTkVnV29LLytoQ2ZGNlFxSzV4N0Yxc3pHNEtyVlVaWnZE?=
 =?utf-8?B?OEw0ZjZFYTI5Vmw4V04rOEYydmhiY3dhUUV1Z2lUbEE4V2E3b1hDV0x0MEpw?=
 =?utf-8?B?c3hVampwVm1qaEZBNEExY1hQSVowdVVNcUExUmNSYjVURWxtWnloM1JnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4451.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlJ6WGl4cVZVb1NrVGN4Z0tPQ1V2bmpxQU1FcURHVmhVVFJaWXdKTHY3QTNF?=
 =?utf-8?B?SFQxOVdyKzlvV0dyQ0NuRzFVdlpURzF3NUwxQjR2YkE3eVN6d1JSYzg0WUw4?=
 =?utf-8?B?QWlvc3RNM1NJUDV6dmxwUlNDNXVndno1UndHSmQ5S0thd0NJN2x6dXhKY2k4?=
 =?utf-8?B?dWtpWkZhek96TElGU05IREpHRm80SGNXc0xId0FFREszOHhueEdPekxWSWhs?=
 =?utf-8?B?UytNOHlRZFM0NkhrM1ZHM1hDdnhxQ2EzWVp4eUwwdTVFVDRCNm10R2dPVlky?=
 =?utf-8?B?ejBFTUxQbFFjSldXU3dOaDVQa3p3M3A0ZE04QWZFNlp0bno5RkhpcWdLV0lE?=
 =?utf-8?B?WGlsY2hacWdZMU1haDRQZ0NGMnV3Nmo0dXRYeFFvTFVCLzlBN1gzbzlmaG9W?=
 =?utf-8?B?alJQVGpiNHpYYk84R0RJampBN29sZFMvRjVQRFZ4a3BUeEViU0Z2d2ExYkVU?=
 =?utf-8?B?WjdIeGs2VkJrNzV6TjdCcnFXS2JnRmlDVlNsUDhmZmM1T29GelkvbUh5eitj?=
 =?utf-8?B?ZHZvZUxtbmM3MFl2cGZxLzBWR29GSjNLSEJRTkxJTGM5dkpVWFdSQWJxRzFU?=
 =?utf-8?B?Z2tqSW5EYk83MFFRc3l1TVpONjNuUlc2d1FEblhBN2ZWdnc4OVhNRDZLVk5E?=
 =?utf-8?B?VzZkVHdnNWk2THJvWmlQS2tIcGdGNk9mZHB4ZW8yZy9vdHdBUDU2NmpLSmNv?=
 =?utf-8?B?SlNzYjJGY09leURoWk9hWUlHeUFXZXpkQnlSR2VZcGNVSU96N2FYUWlaLzZM?=
 =?utf-8?B?QlJucGh0dmhoOGJGWTl4a3ZUcDI3L3VaQy9HWk5Dc0lJYkFucDV1YTUzUnIy?=
 =?utf-8?B?cGRBVXZnN3RQY1pJVTBPWnRFUTZ6bk9Mb3JqWDc5MkY2MmtrNHFJeUVlbzlF?=
 =?utf-8?B?a1hRVklzRFdKemovMHVvWW56MWxUTjhndjFDdXB2bFhIYXRjWXFhUEZrQnZ1?=
 =?utf-8?B?S2FPcmNtWWpqM0gzNkI4cUFZTmh6dEhIOGkwTDhqRlV6RERZKzZVS0hhVHpj?=
 =?utf-8?B?WkdIWmpEYmp6emRlRXdkbHdXaThpWVUzeVhvaHpydWpya1FjUTVPZ0dYVE5n?=
 =?utf-8?B?R1pPTmpjV2dqTjZkWjRDK3MvOFFha0lKcmc2czZNaHRGWUlScE9OVkh4aytl?=
 =?utf-8?B?dElGL0RtTTBmTVZrRlphdDBwOUI5Y3BnSlgwRGFCUU5YYzd3TTNUUGRKRHp0?=
 =?utf-8?B?bmw2UUpVYkduUVIrZVdwUEttS0MvQVN1R0NjSmEzV0lldUZFemtaUDY3bGl6?=
 =?utf-8?B?OTlFcDJQOCtpcTBCNCtENHE0VSt2MkJoYmRpd1pNYThhR3RxcWl1RS95c2or?=
 =?utf-8?B?K1Q3cStvb2VmQkdOVngrM1RVbUNibXozM2NKNGd5amQ2U1R5dVpQT0dwNDR0?=
 =?utf-8?B?aHFUOW0rbVF5VXowU1JpaTRKa056REtVMWYzaU9TQ0YyRzd1SS9XN0kzeEwz?=
 =?utf-8?B?dW9lVlBiSWYrVjlqWlBNUmpHNlpodFpiUWs4eFNFYTd3UlFrdU1meTRFRkVj?=
 =?utf-8?B?MXBqc0V3d1F1amhvekRpR08weUVMTk10Vmp3dExRenB6Zklud0F3VDBvQWlI?=
 =?utf-8?B?SHhWM0RVaTlYcUtXbnkwb2htek5IUm9hZzFmYmhiM2xtSlI5K3I2eUwxRTFE?=
 =?utf-8?B?eDdTWk1YNk1sUGpGNkZnMmJnL2lkQmtuSEo3T3JoL1dOcGFVa0x4UENDeGdt?=
 =?utf-8?B?dXp4dUNVZVZocDNucFJqVXBFb2VtZHlLYjYwd1hqLzlCT01iK1hSVFVFeFFJ?=
 =?utf-8?B?QXV4TThYazdybFRNbkNSWUtkVTRaRkJ3amhiOGQ3Nk0vS0NBTndJOFFRYUR2?=
 =?utf-8?B?TWtXQndrdmRCNUYranpiemE0dlR4ejFiL2lRRUdNSm1QUnVyNmIrazN5RlZT?=
 =?utf-8?B?djFDZ0JRaVM3R1BaczAzTWY2MDNPTVc4bDNla1YyYXBnTXJ1Snc2bk1Wazhy?=
 =?utf-8?B?dFc2MnFoVlR5c0h4OC9XTWVUck53UWh6SGlNa1JUNjRtQUNPdWZsM0N5V3or?=
 =?utf-8?B?WUlCdVhYSTBCV1lVUXE2UGUzcHlQeGwvMmZtbEgvaUZTMnRQbVdwMkhrQ3lr?=
 =?utf-8?B?Z1J3MXFuY25tR0t2Q1puOU5HZ0dXaHpiRFFYY0swQ1U0OEJQMGM2WWxPVHRl?=
 =?utf-8?B?RDh1dzdkaTNyMS9UWVRpZ2ZDMDF4aWxOS2x4N1RrREc5NGd5NDJKZzdqQ0p3?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632f5ef4-98b6-477d-5877-08dc6df29384
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4451.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 17:33:00.5770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbL7c/qRkMztHiNBTOf6m2rgFwNRSwRipPWrEg+QQjQDXzGYa1h057SlGwTxTDjONw425tuu3Q5QXjdK4aZ/bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR18MB4974
X-Proofpoint-ORIG-GUID: L8KCsnN1pkXw7GCW1V0nfGmOIF8KbyDy
X-Proofpoint-GUID: L8KCsnN1pkXw7GCW1V0nfGmOIF8KbyDy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_12,2024-05-06_02,2023-05-22_02
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

On 5/6/24 00:35, Michael Nazzareno Trimarchi wrote:
> Hi Ravi
> 
> On Tue, Apr 30, 2024 at 6:25 AM Ravi Minnikanti <rminnikanti@marvell.com> wrote:
>>
>> On 4/29/24 09:59, Michael Nazzareno Trimarchi wrote:
>>
>>> ----------------------------------------------------------------------
>>> On Mon, Apr 29, 2024 at 6:22 PM Chris Packham <judge.packham@gmail.com> wrote:
>>>>
>>>> On Sun, Apr 28, 2024 at 4:15 AM Ravi Minnikanti <rminnikanti@marvell.com> wrote:
>>>>>
>>>>> Once a page is read with higher bitflips all subsequent reads
>>>>> are returning the same bitflip value even though they have none.
>>>>> max_bitflip variable is not being reset to 0 across page reads.
>>>>>
>>>>> This is causing problems like incorrectly
>>>>> marking erase blocks bad by UBI and causing read failures.
>>>>>
>>>>> Verified the change with both MTD reads and UBI.
>>>>> This change is inline with other NFC drivers.
>>>>>
>>>>> Sample error log where a block is marked bad incorrectly:
>>>>>
>>>>> ubi0: fixable bit-flip detected at PEB 125
>>>>> ubi0: run torture test for PEB 125
>>>>> ubi0: fixable bit-flip detected at PEB 125
>>>>> ubi0 error: torture_peb: read problems on freshly erased PEB 125,
>>>>> must be bad
>>>>> ubi0 error: erase_worker: failed to erase PEB 125, error -5
>>>>> ubi0: mark PEB 125 as bad
>>>>>
>>>>> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
>>>>
>>>> Looks good to me
>>>>
>>>> Reviewed-by: Chris Packham <judge.packham@gmail.com>
>>>>
>>>>> ---
>>>>>  drivers/mtd/nand/raw/pxa3xx_nand.c | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3xx_nand.c
>>>>> index 1d9a6d107b..d2a4faad56 100644
>>>>> --- a/drivers/mtd/nand/raw/pxa3xx_nand.c
>>>>> +++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
>>>>> @@ -800,6 +800,11 @@ static void prepare_start_command(struct pxa3xx_nand_info *info, int command)
>>>>>         info->ecc_err_cnt       = 0;
>>>>>         info->ndcb3             = 0;
>>>>>         info->need_wait         = 0;
>>>>> +       /*
>>>>> +        * Reset max_bitflips to zero. Once command is complete,
>>>>> +        * max_bitflips for this READ is returned in ecc.read_page()
>>>>> +        */
>>>>> +       info->max_bitflips      = 0;
>>>>>
>>>
>>> Why this should not be put to 0 in read_page instead on prepare_start_command?
>>>
>>> Michael
>>>
>>
>> ecc.read_page is invoked after the read command execution.
>> First chip->cmdfunc is executed with NAND_CMD_READ0 and then ecc.read_page is invoked
>> to read the page from buffer. So, by the time read_page is invoked, info->max_bitflips
>> must already have the bit flip value.
>>
> 
> All the other implementation has a slight different way to handle.
> From what you said the reset should
> be done on for NAND_CMD_READ0 command and should be sufficient.
> Technically should be moved
> in switch and not unconditionally.
> 
> Michael
> 

max_bitflip is not being reset to 0 across page reads.
Once a page is read with higher bitflips all subsequent reads
are returning the same bitflip value even though they have none.

This is causing problems like incorrectly
marking erase blocks bad by UBI and read failures.

Tested it with both MTD reads and UBI attach.
This change is inline with other NFC drivers.

Sample error log where a block is marked bad incorrectly:

ubi0: fixable bit-flip detected at PEB 125
ubi0: run torture test for PEB 125
ubi0: fixable bit-flip detected at PEB 125
ubi0 error: torture_peb: read problems on freshly erased PEB 125,
must be bad
ubi0 error: erase_worker: failed to erase PEB 125, error -5
ubi0: mark PEB 125 as bad

Signed-off-by: rminnikanti <rminnikanti@marvell.com>
---
 drivers/mtd/nand/raw/pxa3xx_nand.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3xx_nand.c
index 1d9a6d107b..97f250483f 100644
--- a/drivers/mtd/nand/raw/pxa3xx_nand.c
+++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
@@ -803,6 +803,11 @@ static void prepare_start_command(struct pxa3xx_nand_info *info, int command)
 
 	switch (command) {
 	case NAND_CMD_READ0:
+		/*
+		 * Reset max_bitflips to zero. Once command is complete,
+		 * max_bitflips for this READ is returned in ecc.read_page()
+		 */
+		info->max_bitflips = 0;
 	case NAND_CMD_READOOB:
 	case NAND_CMD_PAGEPROG:
 		if (!info->force_raw)
-- 
2.17.1

Thanks Michael. Fixed it.

>> Thanks, Ravi.
>>
>>>>>         switch (command) {
>>>>>         case NAND_CMD_READ0:
>>>>> --
>>>>> 2.17.1
>>>
>>
> 
> 
