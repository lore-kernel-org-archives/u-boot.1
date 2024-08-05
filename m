Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58206C52D71
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 10:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88E77888AB;
	Mon,  5 Aug 2024 12:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=marvell.com header.i=@marvell.com header.b="daeIAEMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5B3F888AB; Mon,  5 Aug 2024 12:08:34 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD278889C
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 12:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rminnikanti@marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4755LE6o030530;
 Mon, 5 Aug 2024 03:08:19 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40trgp8sq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Aug 2024 03:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTPdPcuT2Eb9yuzRGYCmtSfm14DenmlLdMUAI02aaomnNE0UXN+jEXExq8ub+gReq6MczHCMeEQNZhqBosJLX6im3ZVX53q6ePOpu4WhR/58xh4Y7pNZP8fu8cYE75PmXVaLtJG0eVB/YiXgosj9zyGLTD8n1bX5ucuCJOgjv7sgACvEJDG6JZ7P1Np14kPhOLnQkol76X2mCrl4bYdGgNZOxUUG9HotWcQhHejLpWAOdx69NsrMEnb704FTh8xTGYlljI0N1JaIag82+iFs744GqIJYnZAkQybCSdy/PVSbhiPr84ixbaeLJE2pgXMlO6YCP0AnwUkiGb5cbEqAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8ck9ZvOwlgY750ej40T3yAVc4EvaoBO9dapRgaVagE=;
 b=ANIO/vthbbsZpa91Gjy9hTVs8UMVItNUKzOQ81INdSr6IWFy5ccdpz53vL8W51rhnzufY23XaJ4noUpKSRwR6Q/rxvlgxSyvTOe2S8lK8/9An6zPHWWN8XGj3TvRTaUj0ZkveEFDOnAI+q58aUjhF/b9XLfVZiYGAzKGPb8lN7cOs5TAmIbJtoolBG2ULbksKc2YEmV+wAo5bv6EyYpQf5Fl0PCbTjpNSjfNGgClZrOk6Kvb98W36BRUaDyLAJ3rrz72Ghf4P+slgfrIxSZvlFPP9C9PpE4pln6LL57WNzT4GaNeFQrrjK9u2+SUldSIKriceAvUwIMHpKGqWMm9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8ck9ZvOwlgY750ej40T3yAVc4EvaoBO9dapRgaVagE=;
 b=daeIAEMIixAOPEyyL7AhKZEJ6E/Y//bQiL32YRNCtTodVNbATfyL0sKy8ZQ7GhwMHOXfz15SFI71mMjHWha6CBkrjUF2MfRWaoQOMtlPMehkQqGX4Ppg4Xl5p6cJpFSt7+HrcMQ3RQgP0+tQAFiZ5S+7tWJTgTS7U5baQ59+8jo=
Received: from CO6PR18MB4451.namprd18.prod.outlook.com (2603:10b6:303:138::12)
 by BY3PR18MB4804.namprd18.prod.outlook.com (2603:10b6:a03:3cf::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 10:08:16 +0000
Received: from CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::4c2b:70d5:95ac:1d6c]) by CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::4c2b:70d5:95ac:1d6c%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 10:08:15 +0000
Message-ID: <59375643-8204-c2ae-c04f-0b17840ff8a4@marvell.com>
Date: Mon, 5 Aug 2024 03:08:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [EXTERNAL] Re: [PATCH 0/4] fs: ubifs: Fix crash and add safeguards
Content-Language: en-US
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@denx.de>, u-boot@lists.denx.de, Stefan Roese
 <sr@denx.de>, Hans de Goede <hdegoede@redhat.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Kyungmin Park <kmpark@infradead.org>,
 Alexey Romanov <avromanov@salutedevices.com>
References: <20240703101258.1670825-1-ada@thorsis.com>
 <8f3a7059-6330-f332-8e9f-729b853e001e@denx.de>
 <20240704-goes-grape-25a9f1d14c24@thorsis.com>
 <20240801-wham-entertain-15505d61f84b@thorsis.com>
 <e0c3e3e2-1c7f-e244-5b1d-0498b5771deb@denx.de>
 <363c73bb-54cf-3800-bb31-9af83fbaf33d@marvell.com>
 <44ca37d8-5d8c-80f7-1151-6a77732433f7@denx.de>
 <20240805-outlook-dollhouse-e2d93213b174@thorsis.com>
 <CAOf5uw=LbRAvDvG5_50OF0bUiL1TVfALwMBonza9s2x99tHoBQ@mail.gmail.com>
From: Ravi Minnikanti <rminnikanti@marvell.com>
In-Reply-To: <CAOf5uw=LbRAvDvG5_50OF0bUiL1TVfALwMBonza9s2x99tHoBQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::17) To CO6PR18MB4451.namprd18.prod.outlook.com
 (2603:10b6:303:138::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR18MB4451:EE_|BY3PR18MB4804:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fda470-55e1-47f3-a290-08dcb53685a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VE1RUFdvMWZ1N2FPajNMajF6anlzZWtCZ0dhQitpM01pL3VzT1ZUYXJjWFpr?=
 =?utf-8?B?TzhTOURjQ29ZV2lBOXdiNGRVWksybXlTMjNRdVI4eGxMQXhHYnV2V005NWhv?=
 =?utf-8?B?QnJmTFR4T0dGc09PWE1kdTg4b2c0b1dEMitUYkcyVWhoSVpLYkkweCtkb29S?=
 =?utf-8?B?QjdtN2d5V3dmR3UxUklVamg3YTYwZW81R0FtOEhvUDNpT2toakxuTG4yS2Ev?=
 =?utf-8?B?T3NnQTZHNm5JU0QzNlVhaWxYT3czNkVRSm1NOEFrOWp0VEEvNWcrazJyYVBq?=
 =?utf-8?B?dVZpQzNGTkNmNC81V3lDUkw5ZzVEa0pUU1BrRlJRUnVZdkM4K1VPQ3hVdUpu?=
 =?utf-8?B?RS9QNmtFellYMDV3M3YvK3p5cG5qMW9rS2xtMmJpTnFSVXRsaWZ3NTlsYU1a?=
 =?utf-8?B?eDRUTEUxU0hSZUk3b3FMblEzVThJS1FmUHlRcktSYmZNYUxJalNUNlFnUkZ2?=
 =?utf-8?B?RkU3SDBsanRWQ3huUU15YlZIL3JOVnFSN0ZtVmdlV1NOK2tudnUrMGgyV1FT?=
 =?utf-8?B?SWZJaDBlczRPTEwyOWtYc2pMSHdUVkhpaHV4UFFUclRxczVtSkNIeUtBbVlk?=
 =?utf-8?B?ZE43SnZXeENLNUlIVnJyMFArcFpyVlkzMDVQMmF5clRUaTRmSEd1VEYyT2JZ?=
 =?utf-8?B?aW9SQXYzNkkremdCazJrR1QzYm1mazZzaXIwL2VSeVBnZXBvSW1wY2swV2lQ?=
 =?utf-8?B?Y0I5cnBMUzBHVzA0dUNFdXlocWtQREtHYXhjenp0TjVycEJBQmdUcjJML0gv?=
 =?utf-8?B?N08rWHIrVUNKcWRlbEpUQWMxNFZmN2xHN0dCblFmc3hFVk9BdGY4Y2ljclVo?=
 =?utf-8?B?Y2pJMlNwRE9aN1V1QU1ua3p5NnN5R0NvNmpkbDY3Y0JuKzU0Z2o1eElQaE01?=
 =?utf-8?B?eklEOURBTHQ0R25CaDM5S3djT0NsdnZWamVJUzZ1SUwwL1dOMTZQdERTZ2I5?=
 =?utf-8?B?a3Bza3phdnFzc01wclQ0d2c0eFlPZStWdi92Rm1zekhrT1plQlZESVkyMHNI?=
 =?utf-8?B?Mi9sTEdZM3NWNjBzRmJJNi82U2FrQmlrRkttY2JoSTJCQ2traFFaS08xbXMz?=
 =?utf-8?B?aXVubEw3ekRldjdRZ1hmamp6ZFIvcENIaVJOeDJQY0prRURIM0ZkSklrL1dP?=
 =?utf-8?B?M0hRTHNwMHdvKzYwT1MrY0lvQUJ4OGovRDlDWUM0djRyVjNEUlNuVnFnd0p1?=
 =?utf-8?B?ZWpmTFVtbUZlVWNlZ1RGZ0ZsaU9jRFp2WVJTWjVkQ2FjMnBpbXhVd3NJSkw3?=
 =?utf-8?B?ZjNaZ3dSZ01JcVQ2UGJVRjlmbS9ZSEtuM3hPM09sU0xTd1BvYmlSQ0oyb25N?=
 =?utf-8?B?aU56MCtRMVlWYjcvbWhkdmRGbGpEaTdJMVJyVmxCS3pKalZSR29pd3A4VU5h?=
 =?utf-8?B?RHFGNjEzdDZ0WUpBOEJvOUVHdkNDQjNFQkVWb214K1krWm9MQUZ4Y0NSZHpr?=
 =?utf-8?B?cDIrUmQyV3BUQ2tQWGYyYnpYYVNaMTFML1h2MlQvZHdKMzdRQ3NKbjVLdFE4?=
 =?utf-8?B?aUllSUdzaHNyRFVIcGk1N3NGaHNPYzNQMUlEV2I2QUYzNVZHRVNOcDlqdU9q?=
 =?utf-8?B?dlVuek1STXpzd1JNMXora2tMQWUvWlFmczlXQ1ZGbTZRME0xblpFaDlkZzRl?=
 =?utf-8?B?d2FlZ1krSUVvZ2ZVTHcxUzB5VjBYMnJoNUt0L0liTnk4aXpSc1VIbndHL2ZR?=
 =?utf-8?B?Y0h6TlZDUWJBdCtsRWFtWVcvaHdRcC9GZktGTlRCdXMyeGJ6YnZPWjlQemV3?=
 =?utf-8?Q?VKyxiAgX+T3nw8dHoE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4451.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU9xRzlDQTdJUUNQNGRrV0I0YlBQN2tCYWcvblFDRmRsV2htSGJtbzdIejRv?=
 =?utf-8?B?SmRBUVc0YzlFRS9XdWVjVXJpUmtIMXMyTzJCSGVWN1FwTFRnV3FKT1VNNzRp?=
 =?utf-8?B?WDBSTGk0aUdsMVU2YUV5L1lYZFgxcEVJWW1YM0xDYzVwYmpTMlpST0pFbHg1?=
 =?utf-8?B?eGlpSUc3emJDMisrUmFYbkZXZHdOVm01dkVYb1g4cFBocVN6UUtBWE1KaGZU?=
 =?utf-8?B?bFAvUzRvRUFLMVRiSVo1QWtXT2w5SXYzMkE4U3R3K0gyWkxuQjZCQnZ2YU5r?=
 =?utf-8?B?VTdrZU9UbnE5QlJvU2Z1Znh1aWFrNm5LQnFrWjRkMTBUc3E4cDhEV0llaVlF?=
 =?utf-8?B?OUNlRWMrNlpsR1dTTjAzYW5BTmdHd1RMZU5pOE8ycThrNTFYU2MxYjdRUktY?=
 =?utf-8?B?NXZKdHZPQjU4OW53cDR0OUJVc1M5RmZmOGU5ZS90MXkrNVFWc1licWk1SnBr?=
 =?utf-8?B?V0U4ekFuWVRKdVRNTXZrWklXbWU2NktFRmF1VUlaYTNkRDFsSDQ4c1ZqN3l4?=
 =?utf-8?B?cjNaQTRaQmgzbkU4STVzcjVVdm5oaTNPek02ckdOVHRrVmN6Z2MxcE9wSWd1?=
 =?utf-8?B?b05BZDVWOUJmTTVxeXkvNXVmTzZmM0pyQW5vL0EyRDU2dCtReWJJcFRlTDVp?=
 =?utf-8?B?QklvcUtVUHp1dURHWFZtTDVoc1YxNE81YUJaUm5lZExBWW13eVRSV3B3aC8v?=
 =?utf-8?B?eWtlOUJyVDl1OTlBZ2dUdDg1VkE0UXdsUDhqQk9DV2xqcWRGUGM4a2NxQjM2?=
 =?utf-8?B?RUlUWlF3MHRTbXBhMU5qTTdjQ0FDa3VMVDhnZ0RVclRZZWxGODhYSjlaTVQv?=
 =?utf-8?B?VjRhazZ1OVFrWUY1SUNIeVl5T3RoL09iSGxUUnhhN0VFTlUwTk5MS2ZUVTMx?=
 =?utf-8?B?azBMbHhDWFNFRGhMd05jb2pYVlFITXdUMVc3WjF0Nld4WnhoVkdlOEdrZm1p?=
 =?utf-8?B?a1hxMmcwSzJVS1FpZldtSUp1UFpyZXRtbmxLbDZzWE4zZVd3WDdSRCs1cTg1?=
 =?utf-8?B?MzhnUElPMGFPbUU4bmtmWG4rRHh1T2dGQkpubEJpN2VTNFlWYjFJNEg1WHNq?=
 =?utf-8?B?Ty94V2g4VXRzdmNiU1FDSUpXbzNRckpHVGJKcURpd1JWOVgzMUZjU3FIbDMr?=
 =?utf-8?B?OGVDY2RHSU5iLzZ1NGExdVpTYzhtbnNqU0ZGMnBiUlQ0dnhJV3JyUENkbGRM?=
 =?utf-8?B?enpqb1ZoejhlOWtjakVPYlJRUkZUUUNKbmVPZVhPdE5yWmdMYkRBY1BJd1dq?=
 =?utf-8?B?Zjk2Z3lzTFlLZjBkOUhBQ0prMm1ubzRYVWpiZUJlRkxVam52SjVkRlFUdnRm?=
 =?utf-8?B?WGh0UElxbEhoaStvbVNFWThuQVU4WURxRkQyWXBaeWdzVHVIdndHeXg4WFh4?=
 =?utf-8?B?UVhDOTNJU2J5QU4wS0FDUVRvWndPcnFLTDIwbnRsclo1Ulppa2hkdlJkTWlQ?=
 =?utf-8?B?WG52TU1vS2FTT2hKbTZ1SkEvWlhtRFQrdWZIQkVFUWJZd0Q5N3liRGx1anVQ?=
 =?utf-8?B?dm9ZczRuRzU0V0FDNElkUkhteTV5TGM1ZFlDakFKeEhKTHFnVnhqNUpiQWxI?=
 =?utf-8?B?UTkxaVo5YllUNmlPZ2RkWjBnWjN1a1dqc2NsOTNqRVdSYi9LbU5mbE42QTBj?=
 =?utf-8?B?MFovbHdsTEpPMUc4R3pIWHFtZkRlU0JZOTJIOHplWVhiY043NlVWeDFDZ1dF?=
 =?utf-8?B?Vk00ZElWcjg4OXJKQlExZ0MvQkFEYkxSb3lOU29UdGVuOTZaOExxWW01a3Np?=
 =?utf-8?B?UDJIbGpYd3Z0L0x2Nllzd05hQUFXMER5UmhPUHhXMUtxNERkMFFYeWJaejV0?=
 =?utf-8?B?K1hxNzBqaDM4blVQTGp0dHdvaHlKYXdxL0tUODhURyt1YXJyQlN3T0xLSzFT?=
 =?utf-8?B?REs3dmc2blZ5bTRZRjVqV216SkF2d043cEhKaTJYdlBqMUI4K0p0N1Qvc1BC?=
 =?utf-8?B?OWZXTHFpM0p6ekZJQUdTODNWMHBsMUp5eVd5VVpWdjRZeU8zcXE3UlhWeUJi?=
 =?utf-8?B?c1UvdnN2enZrTTBpRlFoMHNsUnA4RUZYb21nTkxRZEJZMHNVbHNNbkFqN3pJ?=
 =?utf-8?B?cFFySnB6Q2VDZVNudk1wYnc5VkRzcTZpK2RqUlBraXc5UzRpUHRHRllHcElw?=
 =?utf-8?B?bHY3Wk1ORS9VYnRvT3I0Z3lSRVN6dmxDYmRxZFIwb2VxZ0tOQXVSK0U4ZVVX?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fda470-55e1-47f3-a290-08dcb53685a5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4451.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 10:08:15.6257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dEdZ+ag6R6hDF5NOIoJxPNX40uhnvEsSO4tnA3Nh6epmrpvdo4yXhuGjKNSAV33SqUA6mSRO+oQ8+VXN1BVXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4804
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: j9-6B0WH8v2fFa2LqKbPLQnQ3k-iTyrQ
X-Proofpoint-ORIG-GUID: j9-6B0WH8v2fFa2LqKbPLQnQ3k-iTyrQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
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

On 8/5/24 01:58, Michael Nazzareno Trimarchi wrote:
> Hi all On Mon, Aug 5, 2024 at 10:=E2=80=8A49 AM Alexander Dahl <ada@=E2=
=80=8Athorsis.=E2=80=8Acom>=20
> wrote: > > Hello, > > Am Mon, Aug 05, 2024 at 07:=E2=80=8A28:=E2=80=8A19A=
M +0200 schrieb Heiko=20
> Schocher: > > Hello Ravi, > > > > On 01.=E2=80=8A08.=E2=80=8A24 21:=E2=80=
=8A39, Ravi
>=20
>=20
> Hi all
>=20
> On Mon, Aug 5, 2024 at 10:49=E2=80=AFAM Alexander Dahl <ada@thorsis.com> =
wrote:
>>
>> Hello,
>>
>> Am Mon, Aug 05, 2024 at 07:28:19AM +0200 schrieb Heiko Schocher:
>> > Hello Ravi,
>> >
>> > On 01.08.24 21:39, Ravi Minnikanti wrote:
>> > > Hi Heiko, Alexander,
>> > >
>> > > On 7/31/24 23:54, Heiko Schocher wrote:
>> > > > Hello Alexander, On 01.=E2=80=8A08.=E2=80=8A24 08:=E2=80=8A50, Ale=
xander Dahl wrote: > Hei, > > Am Thu,
>> > > > Jul 04, 2024 at 10:=E2=80=8A18:=E2=80=8A55AM +0200 schrieb Alexand=
er Dahl: >> Hello Heiko, >> >>
>> > > > Am Thu, Jul 04, 2024 at 06:=E2=80=8A28:=E2=80=8A31AM +0200 schrieb=
 Heiko Schocher:
>> > > >
>> > > >
>> > > > Hello Alexander,
>> > > >
>> > > > On 01.08.24 08:50, Alexander Dahl wrote:
>> > > > > Hei,
>> > > > >
>> > > > > Am Thu, Jul 04, 2024 at 10:18:55AM +0200 schrieb Alexander Dahl:
>> > > > > > Hello Heiko,
>> > > > > >
>> > > > > > Am Thu, Jul 04, 2024 at 06:28:31AM +0200 schrieb Heiko Schoche=
r:
>> > > > > > > Hello Alexander,
>> > > > > > >
>> > > > > > > On 03.07.24 12:12, Alexander Dahl wrote:
>> > > > > > > > Hei hei,
>> > > > > > > >
>> > > > > > > > filesystem handling is different in U-Boot and beyond that=
 UBI/UBIFS is
>> > > > > > > > different from other filesystems in U-Boot.  There's UBI a=
nd UBIFS code
>> > > > > > > > ported from Linux (quite old already now, maybe someone wa=
nts to update
>> > > > > > > > that?), and there's "glue code" or "wrapper code" to inter=
face with
>> > > > > > > > U-Boot scripts, commands, and filesystem handling.  The fi=
xes and
>> > > > > > > > improvements in this patch series are for this U-Boot spec=
ific glue
>> > > > > > > > code.
>> > > > > > >
>> > > > > > > Yes, the linux base is very old ... patches are welcome!
>> > > > > >
>> > > > > > The last sync was back in 2015 from linux v4.2, there were 800+
>> > > > > > changes to ubi/ubifs in Linux since then. :-/
>> > > > > >
>> > > > > > > And for me it is not that easy, as I do not have a hardware =
with
>> > > > > > > current mainline U-Boot running on it... I want to update a =
hardware
>> > > > > > > I have to current mainline, but I had no time yet for it...
>> > > > > >
>> > > > > > Besides the custom hardware here, I used Microchip SAM9X60-Cur=
iosity
>> > > > > > lately, which is coming with a raw NAND flash and can boot fro=
m it.
>> > > > > >
>> > > > > > >
>> > > > > > > > I'm no filesystem expert, but after days of debugging I'm =
quite sure the
>> > > > > > > > bug is in U-Boot since UBIFS support was added in 2009, an=
d it was
>> > > > > > > > repeated in 2015 when generic filesystem support for UBIFS=
 was added.
>> > > > > > > > So please review carefully!
>> > > > > > >
>> > > > > > > Which bug?
>> > > > > >
>> > > > > > The memory leak and double free fixed with patch 1 of the seri=
es.
>> > > > > >
>> > > > > > >
>> > > > > > > > The crashes were not easily reproducible, only with boards=
 using the old
>> > > > > > > > distroboot _and_ a boot script inspired by (but not equal =
to) the one
>> > > > > > > > proposed by RAUC [1], which basically boils down to:
>> > > > > > > >
>> > > > > > > >      ubifsmount ubi0:boot (from distroboot)
>> > > > > > > >      test -e (from distroboot)
>> > > > > > > >      ubifsmount ubi0:rootfs1 (this time from the boot scri=
pt,
>> > > > > > > >                               triggering a ubifs_umount)
>> > > > > > >
>> > > > > > > So, you have a special sequence you execute to trigger the b=
ug, good!
>> > > > > > >
>> > > > > > > In special 2 ubifsmount in a row... may not often needed for=
 booting!
>> > > > > > > (I ask me, why that is needed? Boottime is not good than...)
>> > > > > >
>> > > > > > Using distroboot with a script here.  The script is in a separ=
ate UBI
>> > > > > > volume ubi0:boot, kernel is loaded from ubi0:rootfs1 or ubi0:r=
ootfs2
>> > > > > > however.  So there is 'ubifsmount ubi0:boot' from distroboot a=
nd in the
>> > > > > > script found, loaded, and run there is 'ubifsmount ubi0:rootfs=
1' (or
>> > > > > > rootfs2) later.  ubifsmount calls ubifsumount internally if so=
me
>> > > > > > volume is mounted already.
>> > > > > >
>> > > > > > >
>> > > > > > > BTW: Is this really a good bootcmd in [1] as on *every* boot=
 your
>> > > > > > >        Environment is saved? This is not good for lifetime o=
f your
>> > > > > > >        storage device ... why not using bootcounter?
>> > > > > >
>> > > > > > Well, I was not aware of bootcounter, but I had a look and the=
 actual
>> > > > > > counter must be stored somewhere.  Possible are:
>> > > > > >
>> > > > > > - pmic =E2=86=92 has no storage possibility on my board
>> > > > > > - rtc =E2=86=92 soc internal only, volatile in the end (if bat=
tery is empty)
>> > > > > > - i2c eeprom =E2=86=92 missing
>> > > > > > - spi flash =E2=86=92 missing
>> > > > > > - filesystem =E2=86=92 ends up on the flash
>> > > > > > - nvmem =E2=86=92 no other nvmems present
>> > > > > > - syscon or some cpu register or sram =E2=86=92 volatile
>> > > > > >
>> > > > > > So none of these are possible in my case, I only have a raw NA=
ND as
>> > > > > > storage and thus I have to use U-Boot env, which is stored in =
UBI here
>> > > > > > btw to not stress the flash too much.
>> > > > > >
>> > > > > > I could investigate if it would be possible to let RAUC use the
>> > > > > > U-Boot bootcounter infrastructure, but currently RAUC depends =
on
>> > > > > > U-Boot environment variables for tracking boot attempts.
>> > > > > >
>> > > > > > btw: documentation of bootcount is sparse, I only found the ve=
ry short
>> > > > > > 'doc/README.bootcount' and it's not even migrated to recent U-=
Boot
>> > > > > > sphinx based docs. ;-)
>> > > > > >
>> > > > > > But from what I understood the concept is the same, U-Boot cou=
nts
>> > > > > > something and Linux userspace has to reset it.  The counter mu=
st be
>> > > > > > stored somewhere, for example in U-Boot env if no other storag=
e is
>> > > > > > possible.
>> > > > > >
>> > > > > > >
>> > > > > > > > Crashes can be triggered more easily, if patch order is ch=
anged and
>> > > > > > > > patch 2 (resetting pointers to NULL after free) comes firs=
t, or if patch
>> > > > > > > > 2 is applied on its own only.
>> > > > > > >
>> > > > > > > Hmm...
>> > > > > > >
>> > > > > > > > The fix is in the first patch, and on my boards I see no c=
rashes
>> > > > > > > > anymore.  I also tested all kinds of combinations of calli=
ng `ubi part`,
>> > > > > > > > `ubi detach`, `ubifsmount`, `ubifsumount`, `ubifsls`, `ubi=
fsload`, `ls`,
>> > > > > > > > `load`, `size`, and `test -e` and got no crashes anymore a=
fter the fix.
>> > > > > > >
>> > > > > > > That sounds good! Hmm.. test -e has nothing to do with ubi/u=
bifs I think.
>> > > > > >
>> > > > > > Oh it has, 'test -e' calls file_exists() which calls fs_exists=
() which
>> > > > > > ends up calling ubifs_exists() which is one of the functions c=
ausing
>> > > > > > an immediate memory leak, see patch 1.
>> > > > > >
>> > > > > > > On what hardware do you test? Is it in mainline?
>> > > > > >
>> > > > > > Tested on custom hardware, but I'm confident it should be repr=
oducible
>> > > > > > on any board using ubifs, especially after applying patch 2 re=
setting
>> > > > > > pointers of freed memory to NULL.  This should trigger the bug=
 with
>> > > > > > the simple sequence already described:
>> > > > > >
>> > > > > >     > ubifsmount ubi0:anyvolume
>> > > > > >     > ls ubi ubi0:anyvolume / # (or load, or test -e, or size)
>> > > > > >     > ubifsumount
>> > > > > >
>> > > > > > ubifsumount will call ubifs_umount() which calls
>> > > > > > ubi_close_volume(c->ubi), that pointer is either invalid leadi=
ng to a
>> > > > > > double free inside of ubi_close_volume() and it will crash onl=
y in
>> > > > > > certain conditions or the pointer is NULL after applying patch=
 2 of
>> > > > > > the series, then ubi_close_volume() crashes right away with a =
NULL
>> > > > > > pointer exception.
>> > > > > >
>> > > > > > Note: without patch 2 it very much depends on the sequence of
>> > > > > > commands, but after the first ubi_close_volume() triggered by
>> > > > > > ls/load/size/exists the pointer in ubifs_sb is invalid, but ac=
cessed later
>> > > > > > by the second ubi_close_volume() triggered by ubifs_umount(). =
 If you
>> > > > > > do something in between those using the freed memory by someth=
ing else
>> > > > > > again, the second ubi_close_volume() access might get corrupte=
d data
>> > > > > > or access things outside of RAM.  Patch 2 redirects this on a =
clean
>> > > > > > NULL pointer exception you can easily trigger.
>> > > > > >
>> > > > > > In my case I got a pointer variable actually containing a stri=
ng
>> > > > > > "ng.." aka 0x2e2e676e which looked suspiciously similar to a v=
alid
>> > > > > > pointer on the platform somewhere in RAM between 0x20000000 and
>> > > > > > 0x28000000 so it took me two days to realize it's not a pointe=
r. ;-)
>> > > > > >
>> > > > > > >
>> > > > > > > > The three additional patches (2 to 4) are more or less saf=
eguards and
>> > > > > > > > improvements for the future, and come from me trying and m=
y debugging
>> > > > > > > > code done on the way, more or less optional, but I think n=
ice to have.
>> > > > > > >
>> > > > > > > I will look at them .. but give me some time, as I am in hol=
idays the
>> > > > > > > next 2 weeks ... Hmm.. and it would be good to get some Test=
ed-by
>> > > > > > > from people with hardware...
>> > > > > >
>> > > > > > Take your time, no need to work in holidays.  Would appreciate=
 a
>> > > > > > Tested-by by anyone else though, maybe some of the raw NAND fo=
lks?
>> > > > >
>> > > > > Well, apparently nobody had a look in the month of July, I add t=
he raw
>> > > > > NAND maintainers in Cc, maybe I should have done in the first pl=
ace.
>> > > > >
>> > > > > Would be happy if someone could have a look at the fix, maybe re=
ad the
>> > > > > patches first before the discussion? ;-)
>> > > >
>> > > > I asked Ravi and Alexey (added to cc) if they have time to look it=
 they
>> > > > can reproduce the issue and test your patches...
>> > > >
>> > > > bye,
>> > > > Heiko
>> > >
>> > > I tried to reproduce with CONFIG_SYS_MALLOC_LEN reduced to 1MB and
>> > > calling ubifsls in a loop, logic below:
>> > >
>=20
>=20
>> > > ubi part ubi0:rootfs
>> > > ubifsmount ubi0:rootfs
>> > > setenv i 1
>> > > while test $i -le 200; do
>> > >      ubifsls a/b/test.bin
>> > >      setexpr i $i + 1
>> > >      sleep 1
>> > >      echo "Loop count: $i"
>> > > done
>> >
>> > Thanks for testing! But it is not exactly the same sequence Alexander
>> > described ... but you also trigger a bug.
>>
It is not same sequence but it is similar (multiple access to ubifs file ex=
ists and ubifsls)
Test involves ubifsls which is also part of the patchset fix.
Double free issue is visible on reading the code, but doesn't show up any c=
rash on multiple
mount -> file access -> unmount sequence.

Thanks,
Ravi

>=20
> diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
> index 048730db7f..33df4ff51f 100644
> --- a/fs/ubifs/ubifs.c
> +++ b/fs/ubifs/ubifs.c
> @@ -557,6 +557,7 @@ static unsigned long ubifs_findfile(struct
> super_block *sb, char *filename)
>=20
>                          /* We have some sort of symlink recursion, bail =
out */
>                          if (symlink_count++ > 8) {
> +                               ubifs_iput(inode);
>                                  printf("Symlink recursion, aborting\n");
>                                  return 0;
>                          }
> @@ -568,6 +569,7 @@ static unsigned long ubifs_findfile(struct
> super_block *sb, char *filename)
>                                   * the leading slash */
>                                  next =3D name =3D link_name + 1;
>                                  root_inum =3D 1;
> +                               ubifs_iput(inode);
>                                  continue;
>                          }
>                          /* Relative to cur dir */
> @@ -575,6 +577,7 @@ static unsigned long ubifs_findfile(struct
> super_block *sb, char *filename)
>                                          link_name, next =3D=3D NULL ? ""=
 : next);
>                          memcpy(symlinkpath, buf, sizeof(buf));
>                          next =3D name =3D symlinkpath;
> +                       ubifs_iput(inode);
>                          continue;
>                  }
>=20
> @@ -583,8 +586,10 @@ static unsigned long ubifs_findfile(struct
> super_block *sb, char *filename)
>                   */
>=20
>                  /* Found the node!  */
> -               if (!next || *next =3D=3D '\0')
> +               if (!next || *next =3D=3D '\0') {
> +                       ubifs_iput(inode);
>                          return inum;
> +               }
>=20
>                  root_inum =3D inum;
>                  name =3D next;
>=20
>=20
> Should we not free inode_iget?
>=20
> Michael
>=20
>> +1 =E2=80=A6 thanks for testing. :-)
>>
>> > > It crashes with or without patch. With patch it takes 4,5 loops more=
 to crash.
>> > >
>> > > Log:
>> > > UBIFS error (ubi0:0 pid 0): ubifs_iget: failed to read inode 85, err=
or -12
>> > > "Synchronous Abort" handler, esr 0x96000004
>> >
>> > -12 =3D -ENOMEM
>> >
>> > So it seems, we have a memleak...
>>
>> If with my patch it takes more loops to crash, this suggests we have
>> more than one memory leak, and of them got fixed with my patch(es).
>>
>> > Yes, ubi/ubifs linux base is very old, but I tend to think that proble=
m is
>> > in U-Boot adaption layer...
>>
>> I would also suspect the adaption layer.
>>
>> However, although my patch fixes one memory leak, that was not the
>> main reason doing this.  The reason of the crash in my case was the
>> double free, and accessing invalid memory afterwards.  So from my
>> perspective the patches are okay on their own, and looking after more
>> memory leaks should not be part of this series.
>>
>> Greets
>> Alex
>>
>> P.S.: not sure what's causing this, but I only got the mails from you
>> all through the mailing list.  You can keep me in Cc, so I won't
>> overlook your answers easily.
>>
>> >
>> > bye,
>> > Heiko
>> > >
>> > >
>> > > Thanks,
>> > > Ravi
>> > > > >
>> > > > > Greets
>> > > > > Alex
>> > > > >
>> > > > > >
>> > > > > > Greets
>> > > > > > Alex
>> > > > > >
>> > > > > > >
>> > > > > > > bye,
>> > > > > > > Heiko
>> > > > > > > >
>> > > > > > > > Greets
>> > > > > > > > Alex
>> > > > > > > >
>> > > > > > > > [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A_=
_github.com_rauc_rauc_blob_master_contrib_uboot.sh&d=3DDwIDaQ&c=3DnKjWec2b6=
R0mOyPaz7xtfQ&r=3D3apjoJolwzwH82pd_c1HzSLzzrwfu9x1lSm802edgOg&m=3Dlpy642Uhq=
tTXHV0dd0xnOtQxkQSO5RC6FwcUbzt-FsNwd3QSXZsulfqC6dP9qV7G&s=3Dwbnw_T9_r6taMKI=
FqJ2-wtj9Zv02OD7mbIy-ZZFRjRE&e=3D  <https://urldefense.proofpoint.com/v2/ur=
l?u=3Dhttps-3A__github.com_rauc_rauc_blob_master_contrib_uboot.sh&d=3DDwIDa=
Q&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D3apjoJolwzwH82pd_c1HzSLzzrwfu9x1lSm802edgO=
g&m=3Dlpy642UhqtTXHV0dd0xnOtQxkQSO5RC6FwcUbzt-FsNwd3QSXZsulfqC6dP9qV7G&s=3D=
wbnw_T9_r6taMKIFqJ2-wtj9Zv02OD7mbIy-ZZFRjRE&e=3D>  <https://urldefense.proo=
fpoint.com/v2/url?u=3Dhttps-3A__github.com_rauc_rauc_blob_master_contrib_ub=
oot.sh&d=3DDwIDaQ&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D3apjoJolwzwH82pd_c1HzSLzzr=
wfu9x1lSm802edgOg&m=3Dlpy642UhqtTXHV0dd0xnOtQxkQSO5RC6FwcUbzt-FsNwd3QSXZsul=
fqC6dP9qV7G&s=3Dwbnw_T9_r6taMKIFqJ2-wtj9Zv02OD7mbIy-ZZFRjRE&e=3D> >  <https=
://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_rauc_rauc_blob=
_master_contrib_uboot.sh&d=3DDwIDaQ&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D3apjoJol=
wzwH82pd_c1HzSLzzrwfu9x1lSm802edgOg&m=3Dlpy642UhqtTXHV0dd0xnOtQxkQSO5RC6Fwc=
Ubzt-FsNwd3QSXZsulfqC6dP9qV7G&s=3Dwbnw_T9_r6taMKIFqJ2-wtj9Zv02OD7mbIy-ZZFRj=
RE&e=3D>
>>>> > > > > > >
>> > > > > > > > Alexander Dahl (4):
>> > > > > > > >      fs: ubifs: Fix memleak and double free in u-boot wrap=
per functions
>> > > > > > > >      fs: ubifs: Set pointers to NULL after free
>> > > > > > > >      fs: ubifs: Make k(z)alloc/kfree symmetric
>> > > > > > > >      fs: ubifs: Add volume mounted check
>> > > > > > > >
>> > > > > > > >     fs/ubifs/super.c |  8 ++++++--
>> > > > > > > >     fs/ubifs/ubifs.c | 31 +++++++++++++++++++------------
>> > > > > > > >     2 files changed, 25 insertions(+), 14 deletions(-)
>> > > > > > > >
>> > > > > > > >
>> > > > > > > > base-commit: 65fbdab27224ee3943a89496b21862db83c34da2
>> > > > > > > >
>> > > > > > >
>> > > > > > > --
>> > > > > > > DENX Software Engineering GmbH,      Managing Director: Erik=
a Unter
>> > > > > > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell=
, Germany
>> > > > > > > Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: h=
s@denx.de
>> > > >
>> > > > --
>> > > > DENX Software Engineering GmbH,      Managing Director: Erika Unter
>> > > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germ=
any
>> > > > Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx=
.de
>> > > >
>> >
>> > --
>> > DENX Software Engineering GmbH,      Managing Director: Erika Unter
>> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>> > Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
>=20
>=20
>=20
> --=20
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>=20
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__www.amarulasolution=
s.com&d=3DDwIFaQ&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D3apjoJolwzwH82pd_c1HzSLzzrw=
fu9x1lSm802edgOg&m=3DU1Rv-XKqb0aXhWgOxWsZGY-rDRlRGztjPzwhC8OmxVOMsZS6Vgna6D=
mYv_FXd5_9&s=3D25Kc666V9Nv8qBX85mtwQCjOd9WayHgtVr2EU2RbtL4&e=3D  <https://u=
rldefense.proofpoint.com/v2/url?u=3Dhttp-3A__www.amarulasolutions.com&d=3DD=
wIFaQ&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D3apjoJolwzwH82pd_c1HzSLzzrwfu9x1lSm802=
edgOg&m=3DU1Rv-XKqb0aXhWgOxWsZGY-rDRlRGztjPzwhC8OmxVOMsZS6Vgna6DmYv_FXd5_9&=
s=3D25Kc666V9Nv8qBX85mtwQCjOd9WayHgtVr2EU2RbtL4&e=3D>
>=20

