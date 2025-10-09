Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C1ECCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 15:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9460B844AE;
	Thu,  9 Oct 2025 17:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="nvv0FdJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0486784582; Thu,  9 Oct 2025 17:47:16 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2102784461
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 17:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8Ca/tXKS8Tehu8Hw5pE9vtH10rlsp832D9a+OPi0JU+HJZsWb0I9DZEaIf4nHyXTZexsCZD7LAntUd1OhMcGGsLa9o5WRzil0uFWOHYwheq47UMhrRYddAm6yIZ5mwmMm36EWOxBci7yJXtkCm/SLFAc73sasb6Q0WPkGLBpoXXUqppaCdUsUOEpwdVWBHmzIqyfCMbhFVjP4DRvg4RMxNY40eHt9VQxUbN5Y+z7Tb2gF4enviVhRX4l3vxsTJ1lo/Us8dXUIA7efVe5zn5M3MwAsiFKHoVGRHjjUDUc982gFq1qSTctd4zjYH+mTam1QhC+qafZTN/u6M7299nAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvxukizkk1dSsBoVU55/nrcj5fIdcBoHPx6E5H5leXA=;
 b=Y1ls+B81Gbo/OmvxU43fvFYgJtg5RKnUgKcBQCQwtbyC4GhLiL0fa5DbIbX+y1MS1sTtFJc9r9tgp4/o1Xn0On+7HP/oDnzFkIJUnPxCAfil75ul48VljkVl1KBMqn8djFpmuZeu8zfNogagqImk2DnD1jj2drC8GQjhLSIdXfT0m2XB44tmbbU5jG3cvGo5viYbBGphlo6eFTgzuSV64BaE7ePpAaB68QgJpyROMLOXEqR3Og212lR9wADgMNMue4odtejwd8kgBoLoVFbhu9FLpfKucTK0siyMui7fAjriM5b2OsCls2JDKkQaI4JhuJ39Gk9YuotTLum46yZfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvxukizkk1dSsBoVU55/nrcj5fIdcBoHPx6E5H5leXA=;
 b=nvv0FdJjmK+sD/QeXhE8xc79vAp4GcrsKZi1XJAV9F3zBBjIcYTsnuLzvzlPu6EBdVpcftJog1ea3NMzPC2x23pjoxbh5xdabr0oP4waTzD1atcOxHpod8if1xlaQFCA+72RUc7570Ah7GEzL0Ufzr8dVLtTcPB5tL3kwkpWJ4XGSAG8oyQG1tGUww5JL7w/mWc1Jka1rhQpA3aC2Gxga2Q9QMEuLMc065O2BwbILsa+DPk+UFZYUn1JtW6L5/amZTidWj4o98MxGIWr9WZSVYZOVorB6F4cJB8GJlQoI5RQ+a/nHEtdZJpxRt25A/NDF9LvuHyYj5y7o9gnG2nuvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by MR1PPFF05B95851.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::6a6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 15:47:11 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557%5]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 15:47:11 +0000
Message-ID: <0e49fa3c-3711-4567-8b7c-b2b99b3699e9@softathome.com>
Date: Thu, 9 Oct 2025 17:45:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bootp: Prevent buffer overflow to avoid leaking the
 RAM content
To: Fabio Estevam <festevam@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, u-boot@lists.denx.de,
 Paul HENRYS <paul.henrys_ext@softathome.com>
References: <20251009091719.187715-1-philippe.reynes@softathome.com>
 <CAOMZO5CGTiGUzhefRfhb0FbiurtV3vf3DASsUkgPBxpNCVa9tA@mail.gmail.com>
Content-Language: en-US
From: Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <CAOMZO5CGTiGUzhefRfhb0FbiurtV3vf3DASsUkgPBxpNCVa9tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0286.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::34) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|MR1PPFF05B95851:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0874a1-d7a3-4d6c-0a7b-08de074b1c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHMvUW1xQ3JRL295ZWFMd3k4NndibnZmUlFaT2piSVRqNGsyOUpoRDNNWjNy?=
 =?utf-8?B?bkI0U25zWUlhUmJaTXdLemhlQlhVbEExd1ZIZGFDVVdQNjdPYjB5eWtKYlBL?=
 =?utf-8?B?NW5YODMvY2lWNXVoSzhHdS93bi8xRElYd2FCOXhiRjlvNCtRcGU2TUU4WGFv?=
 =?utf-8?B?eTRGTElRa3kybUk5dy80Kzd2RjdUZXVkWTM5dS9pQU16WEFNcXMyTFNpS25I?=
 =?utf-8?B?UlkzMWFWUjVMOXk0cG9EWVVBSG1RYXBGbXFDQnkrUTU3b2ZhcG5YNWFGMXFG?=
 =?utf-8?B?cDNxUXJqMWVjR1pJMW42dGEyU1RtcVBrczJuM21jZGJLTHM3YWNTaEhWSTNR?=
 =?utf-8?B?WjJMdzlsVHJCbDJ1YXNuc1dkUmFPaERSbzVrdVFENzMxL3hoQm1aVThuM29G?=
 =?utf-8?B?am1hZjRzZlpXalovZVFaZ2FmcXdmTU1QM3RNQWxTeHJ1YjcwNjg2c25ZVHZu?=
 =?utf-8?B?aHVQQjM5dmlDVzVJSmgxMFd4WW9MZGhqRkdSZytNbnVISGU3Rkc1WG5XakN4?=
 =?utf-8?B?NkxkWWxSdHUxUUpPTUVpNHg3S1VWU05mU2xydTFoZnJCQUJVcEMyS2I5VWFX?=
 =?utf-8?B?TWVQM2txYUhjY3Q2YU1NaGZJcGlBNVRrS29wM3pJWHlxY1BnQ252VXhUVitR?=
 =?utf-8?B?RzNhK1N4NmhPblRhSGcrRDNNVnNGQmJmK3hGUkRvTjBLN3hDOGd5dFc4Y3RH?=
 =?utf-8?B?S1RnRUVSSUxQNGpGTEc2WVg0T2JtZWM4VXBuRis5Mm9FWmFOUlBLcENsYVVO?=
 =?utf-8?B?OVBXMFNIK3g0c0dYbHg3aVMyZVo0VUY3UE0yK1dHQ1BGSWhHWUhFZG5BUTZD?=
 =?utf-8?B?MXFsVk9INDUyRGdyRHZQZXNBL3ZPQ0ozVzVNaCswTUdqOVhDYWx3YUpzUENI?=
 =?utf-8?B?MnJIWG55emZrQ0FYczU2U1QvenJ2d1pSaFQ0UGJ5TjU1c0VtdUpLSlFaRkJR?=
 =?utf-8?B?UkxQM0xuN290eFo0Y1d6VmpyWlV0Wm96cGF2UDh4RkRnZmNQUmU5VFZML2dO?=
 =?utf-8?B?WjRveHN4bXFSdzh1ZVhaeTdGYXB3N2gycWw3eEpGeHNZMFJkSkFLa1JZcEdt?=
 =?utf-8?B?VG9ZUXhaTVhMc2RJcHBUNWFDUFlKazZSZlFnZ2hQUmlVMnhzbDBBQmxKaDI5?=
 =?utf-8?B?bzByOU1DSlc4K3JWa2lWMzh0cU5WZHp4VnN4Slg5Y0JXRVlkajRsTW8waGNI?=
 =?utf-8?B?d3g4bUhmSytKOXdxL3RVbWFET1M1RjFLRVRBb1JVNEZDUFFORG52R0pnMGo5?=
 =?utf-8?B?NS9DdVMzUHlPUisycjUraXlWZXRYOGxsOUVUWEp0TlpERlZMUWdTNWVjZnNX?=
 =?utf-8?B?dnVYdUs1WTlWbjFlV25jTm5VeitrY2NHdVpHMkthdExtT1pscnRlcnZZZmZk?=
 =?utf-8?B?ZGI3cEZCbUVxTHNUK2pVMldqc1FiQ1FuMUpGTlFqcnhtMk5MSHBxcjh4bm1M?=
 =?utf-8?B?UlNKWFdkVkpTTU5TVkhJdkpITGZyeVJOOUlKNU9oRzhleWVlTHlwNGwwaXBW?=
 =?utf-8?B?aEZ1TG81OUlCSEtBU2F1dHl5bysrZTVxNklpSEoySUZnYmV6QmhDL0svcGUr?=
 =?utf-8?B?MXptZzNaK3ZsWmNFODNNVDNOU2dIVnRuNFc0OVJULzFSVzhybzBmYkNzMTBV?=
 =?utf-8?B?QnJLcjNkZDBZaWhMTTRCQjdBNDJMeG9HcWs3aWhSbnJMNk54N1psUUtrTjU1?=
 =?utf-8?B?QmNBNy9PdWpGZFplcjV5NWN3U09FVDRSQk5DWWkrNHZZazZyTnE1WWloeEw0?=
 =?utf-8?B?elFnaXZmZk16Z3JlL0lOaFREZ0M5cjQzNDFCaDdLdGw0d1pJMFZDdUNSUUd5?=
 =?utf-8?B?NGN5S296UzdqbUVxUHY3aXZPRXpESkdzZEtKSlpwM1hiOUVHV0l6dCtmRzFS?=
 =?utf-8?B?dVBqZ21FMDM0UFlpdWZyOVVjRnRQZ0dKV0cvQ2g2MnhKb3BINVVKZVFEVjNa?=
 =?utf-8?Q?2VCgjMNrYL/wkUXvihwUhcmtTk3DF3sS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnlWSEt2bUJMbE1sNkpDU2xvZG15VUx1RlAvOG9qR3JGdU5xSE1lRFhweDJD?=
 =?utf-8?B?ZWQxQjBjelNNVGdvandNTXpwVGIrQnpJODJuSjVmL25vQXZQMjdIWUNPd2Fy?=
 =?utf-8?B?aURaQ1ZXVTBPV0U1UFR5MldnN2tKMUI2L0pBZUZXVmdwbStObUN5Y0U2dmxB?=
 =?utf-8?B?emNoOWdOZDk4bjNMY2dGVEw3ekRrVXNSZzFiMmZCaVNWVURZOFBRTzNOempr?=
 =?utf-8?B?RFNjSGJNeVp0Sko5UkdZRjdKVk5DOUJmbVFxSWxUaGRGWVJuZUFhUVVvdGM4?=
 =?utf-8?B?NXRjWTBRMml4aTR2UUwvR3pMWHd4a0MzMkhUMmhUQzhOUmxmM3c2cVlBZzda?=
 =?utf-8?B?TEUrVDVFQ29MK2Z6T0FjKzQ0dVdXTTFnUVhsQVM2L1BhVlZ5Z29yMXJCRk51?=
 =?utf-8?B?aisxVlFaditQRnBCeHJ2TXp4SHIrRlovVkdqWEJKK3BaNE92ODZRZnFkM1NZ?=
 =?utf-8?B?MHc3Q0JBZ0wvMjJsOHg2TC95VE96REpFWUtId25JTkxleEU0OUlsdXZBT1Qv?=
 =?utf-8?B?c0NPMVhJT1lVbVlJYlZvWEtvWU45ZlNMOUkvdkVmM0JwYUhCRTlzR2tDNTUw?=
 =?utf-8?B?a3o1WXRaaFBTV0txZ2FVZEdxSWFLaE5mSVlnOWVIaTNTNzdWOGFBb0xTdjlD?=
 =?utf-8?B?UkVCZ2sxVFhSU3dyZmVUcG9kVmNDTXVLQnZWZVNIeUgxODJiYW1QUU9aci85?=
 =?utf-8?B?RlFlcU1WbkF2ZVZqSmtGaUk1SkJ0VWkzS3BwM1FyYkk4bVVtS3BSZWhVblpM?=
 =?utf-8?B?YlNXSldmMTUvRGcvMmxqbWtwUitrS2htcDVUd2RTdlNtbjk3Rk4wRXhKSWVj?=
 =?utf-8?B?VEZkT1ZNYU5Tb2xZN3pOaUo5TnkrdjRvbEQ4NWY4bmlTb1R2N0VLN3N6QUN5?=
 =?utf-8?B?Nk9FWHBxemRiSkVDcjJXZlVXZUhoZ2tpdkt6b3RpMllodStLVlhrSDZrcHFY?=
 =?utf-8?B?K2dLQmMzVExWT3NyT2xyZWZHNC9XSEZNRWdTSUlvMzRaanlhaXo5YUNRZTNP?=
 =?utf-8?B?MTBCL1BVVURKc2w1U2FhTmJIWkZPbXpEZFJVVEFKVk1jMlVTbnIxZDRvWFhT?=
 =?utf-8?B?VnpzZnJqcnVPWG43d1B3RUNvS29nYzhhNnNtaGNnSGp0WTVUVHZZNWpMenRR?=
 =?utf-8?B?WG4wZkJGNm5JcmFPMkNqQzBjenBFRkFlT20wNGhXK1VGU0RKY0ZNaW9JcEVi?=
 =?utf-8?B?Y292UW5lK3pFZDl2MWxqUFlxWVZXWDIvUjVnNzhJUXRNcndQaEdVREsrNy84?=
 =?utf-8?B?V1JITy9oM1hxdnBEVE55YnkxQ3BvczJsdTlDc0JxV0FSUzhxTUV4TFBIckVW?=
 =?utf-8?B?L0h6ejRsZElZejJqZjRRbm14YWlrNTI4YVNTQlowTmE0MmpaUmpoWndFbmZF?=
 =?utf-8?B?L0srZS9zTEdMVVdiYjZrSHJsNkUwaFJnRmhLajhVQzhYL0E2VnNtRzJLK2NJ?=
 =?utf-8?B?QVlyUjc2YWVsenBIa3hNdUxTT0ZUSVVyYUJSNWJNTGtVK2lLckUwbUlyTUxn?=
 =?utf-8?B?ZHE2ZjM1YzdoY25tWjNHWGJkazNxTXAxNTgzdFNSakZxYTJ3MEFLUEQ4cStq?=
 =?utf-8?B?Mzhma0pKU0tCdURDV3VsdHNXaExyRDhLSGQ0NUZmRHhUQ0FwVUh4OFNwSXdE?=
 =?utf-8?B?Y2ZSUTJMZWxhcWluVDd1M2xrbUpCelZWZXVWUW43RDdnOVVhdHpvb1Y1cWVE?=
 =?utf-8?B?QVFqZTJyNFNOZzc1WElIb3dOVnE0SEEzSkx3cHR2SUxJTFJzSmNHYTFIVjlw?=
 =?utf-8?B?TDJ3KzJLaHNReFd6OWZIYW1TcVM5ajNHcUt6RTRCc05YNFVDV3I0RVZkNU82?=
 =?utf-8?B?Q3BkalF2b0xDcWVLd2E4WEMwb0RlcGJhbDM3Y1U0dUhZUHhXQThyQ0tBZjFE?=
 =?utf-8?B?b2xxZUdOeTNaRDFRVVFRM3JjL09ZVFhlSU8zWTVyMmx5blkySENNeGM0bnFi?=
 =?utf-8?B?SGRvRzlMeC9qM1RXK3hPTFArUVFRc0tINmhpM1orNHFEZU1EbG12Q0NvWC9w?=
 =?utf-8?B?c3NyYldXSmNDRGt4RmNOSkxIWXZvYzRQRVFLWktYVE0yUFRKVnVLRSt6L01C?=
 =?utf-8?B?cTVwS2Ywb0hYU0FsU3lBczdsY0x6VXlvcjhhVUVoL0lVUjM3WXhnYUxMTGJ6?=
 =?utf-8?B?Z0lrS004a3VaKzk5Vk55MFdGenpBSUNmS0JLWlBybC8vcjQyMlZ6b29xVWp6?=
 =?utf-8?B?Z0JRZUErRnluVW4yeW9MQVE1R0lKdjNzZlowaDlsRzVoQk1PQUE0S1h5L3cz?=
 =?utf-8?B?MjYrZmRxazR1UzRwZW1TRDZMMU9RPT0=?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0874a1-d7a3-4d6c-0a7b-08de074b1c34
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 15:47:11.6146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfV3Y87Axmvm532zKemA+R2aPpMYlwvFXlmsPEp9SzgTVfKoarw4AvzjJPPphwSoXlyE9dm+1slh6RR8o2lX+/QkMhibuuwQyMti81hH7Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPFF05B95851
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

Hi Fabio,


Le 09/10/2025 à 14:16, Fabio Estevam a écrit :
> This Mail comes from Outside of SoftAtHome: Do not answer, click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Philippe,
>
> On Thu, Oct 9, 2025 at 6:27 AM Philippe Reynes
> <philippe.reynes@softathome.com> wrote:
>> From: Paul HENRYS <paul.henrys_ext@softathome.com>
>>
>> CVE-2024-42040 describes a possible buffer overflow when calling
>> bootp_process_vendor() in bootp_handler() since the total length
>> of the packet is passed to bootp_process_vendor() without being
>> reduced to len-(offsetof(struct bootp_hdr,bp_vend)+4).
>>
>> The packet length is also checked against its minimum size to avoid
>> reading data from struct bootp_hdr outside of the packet length.
>>
>> From: Paul HENRYS <paul.henrys_ext@softathome.com>
> You don't need to duplicate the From line here.

ok, I have removed it in the v2


>
>> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> You missed your Signed-off-by tag.

ok, I have added it in the v2


Thanks for the feedback,

Regards,
Philippe


