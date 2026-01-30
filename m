Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18070E6BF0D
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 13:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965F98431C;
	Fri, 30 Jan 2026 14:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="skGiIsoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC34484326; Fri, 30 Jan 2026 14:35:48 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BBE3842FE
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 14:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYjBqs478EsYPGAffusz7z1+aGq3QSNXH33JbnuoDuSfyPWjBtPFw5LXH0tdREv0GchD3BxN0QcIq489855WNAH6q7boezHNRuBvdihNDSdEcIyh7VeSq8RpZn5cZcLDpbHCawd//kKuZGz2lEizazVnEwCX4rRJiR/o7ZtZQxUrS3sf8R/5lk87nxTlBsqaAZDvbHf3CRHlBP3CF0thipOC1ozHM82Cqw/36LL3xG7ZIUMllESnmsj6OVjrHCSJj0Ihg7j0Qbg/a7dGlXBCEuodT9/tk4qTbzZ0yq7VKtr147yBFB6g6Zia1FyUfrgeFmO3BnMAVxU1VyfjCDzUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03mwh937US4E72J3wc9nrDXzoosnlNkhXBUXFLvaETo=;
 b=i2CzCgQmpXvId0eAQ7G7zNLS6Y3RFsrDPgz9kiXoC0WA7fRmwN5a+7lvFUic1W345xZT8yK9QrdBKb3SusMMO5zbe576JOZNKSyijtXgFmf0NPfX/9xVjr10D/JQf1Y8CcD4oi/P2mrwlrNlx4Bo7afwPGbIO3FIoxMvrNoS1c74WDmEpD7ihZwhw1q3QgbKTqVDwdzqeaOSAB5D9U0Q484zqXuK7/YcTf2q26YhYd3aeEIvVrRtLjsAUAqaJortu1Y0B8zs4oGwW0COUw4jbL8jGIFPyqZj0YlyjJJD+XZgYWFGkd8U2WTBWa9YqxUFlPoCn2BQ8nSxQ6SFz7eegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03mwh937US4E72J3wc9nrDXzoosnlNkhXBUXFLvaETo=;
 b=skGiIsoH19qeW0ukC8SBkzDJvJnq8Cd6r0trc0p389I8QtH87ncfcAYqbA5ayOP1siR2vYsWpED7mWb8r1yHkTWJ6Ks/HSRrtgnmeNJD9OCZcovre2CEYf+HY2w+onNPIVTuyAiwcw2YCVS5Qn6ortUjAmtVTJLzicgSzO3zGF4XITaJwIopqGiQ+Rng7cghBKcXYSJ3qrEd2WvLWj85vRBDLJAlwfRnKUGdOGHgoeD0iao5RRViQqjcp8PhF6Hj30I7WEcOT8fAdUrbcCjHaLvshaBxQFu1KeOxbbQcxzYsBx48XGGnz9znc+U2AWQO5jDYMzQQLMyhKVMUvculVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PARP264MB5882.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 13:35:44 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 13:35:44 +0000
Message-ID: <3fd48665-472a-4c51-a8b0-1a4d3ced5a27@softathome.com>
Date: Fri, 30 Jan 2026 14:33:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: lib: ecdsa: Verifying signature on target
To: =?UTF-8?B?TWFya28gTcOka2Vsw6Q=?= <marko.makela@iki.fi>,
 Jonny Green <jonny.green@keytechinc.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>
References: <IA0PR17MB66130E9A26543D795DB5C98C959EA@IA0PR17MB6613.namprd17.prod.outlook.com>
 <aXxyovMIrH15aVnP@kehys.lan>
Content-Language: en-US
From: Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <aXxyovMIrH15aVnP@kehys.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0026.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::13) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PARP264MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2e7a23-38c5-4c59-ca91-08de6004782c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTlXOUc3UmJhZGxiQ1Ztd2wzNmVta0NxU2syV2hHSEFsYXFZU055aTRFQTRI?=
 =?utf-8?B?dHNob1J4VG1MdG1BR2l6aUU4eGZ1c2IzS3llQk5qS0g3K0x3T0s1V0RlZ1Fw?=
 =?utf-8?B?YW1oS3RkWmVacmc5Y1NmRk1uUkYvbmdVcGwyZ3Vta2UvUGxhTWpRbFRGUmZa?=
 =?utf-8?B?cnU3Tm5CL1cxMDNDcGJLeVhNY0MwVUpTZDRDbEt5MUVCdUFGdXQ0Q2RuZlRV?=
 =?utf-8?B?TzA1cTd6bG9xV3U3dHNSdmgxZGY2K1NDSjJiRzFlaEZDOHB4M2pXYnREVjZ6?=
 =?utf-8?B?MWVabkVERTdiVHoyRjlUV0NENENmUnhMNFBkSnlaQjFTWWNaV0I1K0NiOWVy?=
 =?utf-8?B?V01DV1R0bCs5RG5sTEY4RTV4UUJ3MXdmVEVsM1lXUktHVUVuQnVtaXl5YmIw?=
 =?utf-8?B?aStneWZTWkRxN296eE5hZ1JiTDJHNjhGd1dmL2pFKzgvKzUyT2xMRGY0SHV0?=
 =?utf-8?B?N0xlSkhIWEdJZHhvcExyUVlxVEc1bTd6U1ZDZ3djdXIzVmpYSS9ndkFraDlT?=
 =?utf-8?B?NCt3Z3pGekhLeVhJOUdIeVR2RTBmM2YzVTc0MlgyMThtdlIrRTJjRkJaUmFV?=
 =?utf-8?B?ekFocDM4czRHSU4rTnhudklvWk9obHV4SkJLZG1hRkd2VEV4Q2NSQ2p5VE5l?=
 =?utf-8?B?OEtjUTNFQ3MrcXY0MG9LcVUyNXd5Ui9mMWpiSnhEMjE2MTBwaDJuRmhqaEI2?=
 =?utf-8?B?RWZheCtOV1dYb0FkUUQ1U2ZOSHBrNm9xdjljTDVMTDUzVzh2bFl0aHZkTjF2?=
 =?utf-8?B?dWk1d1ZZVURGU2hmUzZKMnd1aXdNZE1DZHliY2gvLzJIZlpzVkU3cEFnYXhr?=
 =?utf-8?B?eXBEejBIWXVwbXpkVTFuL3ZmcGdVa0NNMml4OE5ldDArdXFxZnNvbHJwbm9S?=
 =?utf-8?B?YkZ6eVJNVnVXRzluVXowM0hBdkRYUTQ4V3V0c3BDaGVxU0dXRURocXFQcFVK?=
 =?utf-8?B?VjRNOHFDRVRya2ZpMEsvVDlNOGtzbnhsdmRCcUR1UzFiUmNzQnVyandEVFFk?=
 =?utf-8?B?WlkyMVJLVnBRTElZdnNUYWpMWUQ4ZTJRUXZENldBbytkMEpaSk5Td3NhWDRN?=
 =?utf-8?B?VWVBZVpONTZnbGxDRWI1UHRlejlwMHlQVWlOUVVZK0V4RGxlL3FSQ2tpQmMr?=
 =?utf-8?B?OUl0RlFjUGtTVlAzVXhGcTFqeWFNQTQ5QUE0eFVFTS96KzlxSm1Cc21xNy9z?=
 =?utf-8?B?M0RrMWFBTkRzcWR6aUpqSEZ5VmxUVC96NXZBbHJhenRlc2wxMU1BWDlETksw?=
 =?utf-8?B?UHRxMmZLKzRuM1RJQ1doQXVqOXYxbnAzLzJCWnZuTEZsUFdTdGZMbjN6MHQ2?=
 =?utf-8?B?SlJHam9BbjVpWlV4dUlNTnlVN2FmcXFOYWpGcnVtK3NwclIrYzkxWS96bE1N?=
 =?utf-8?B?NndodGhUaHRVeEluMXZmREgrVE9xZ0VuNXVldUJ1ejI0QmdzeEE1ZWVzODNO?=
 =?utf-8?B?dHJyNlE3QnVLM1U3WGdxVWxyR2xQY05OVWt1TjFTZW0vcnZ4Z3NoV3RvWWxZ?=
 =?utf-8?B?dk9XQTMvaGhZOUN6SmZobDdiMFBId0xKNytad29BaW81UjNCY0dxdUlFQTA5?=
 =?utf-8?B?S0NrTHlQNjZvd1JiQ3pFOExjLzR5SEJoZk1YWkswVnNtQ2xyYVJCZ09JelE2?=
 =?utf-8?B?NVFsZlZGbkRkTjRqeDJXaTgyL0RBTytUNWR2ZFlia3FjVStvQmNCMm9uZFUy?=
 =?utf-8?B?ektvbkJCMUNPN25UZlB3OFdJTHhLL3FDTURGVTJYeVJnRG1kU2ZjS2I2eC94?=
 =?utf-8?B?NWlYVG1CcHFCWldzS3QyVnBQT2V0cXIxSnRLSzcrMStwRHdXZGxaOVRMb2g0?=
 =?utf-8?B?eXM0TXlGVSswYjg4cHg4L1g2ME9zRXpBSldrVlJESnVLOFlZQ3NpMXhFNkg0?=
 =?utf-8?B?c3NrUTRQeE5XQzd2M3E2eEYvdXNIQmtaSTY1UkJJUVA4L0l1NmhVOUVESTVO?=
 =?utf-8?B?dUsvQU5lNklIMnZoRUozVmd1MWREa2VFY0hIWXVQYWl4d2piZlhTNVJ3UkN1?=
 =?utf-8?B?SXFJSEJWTTNtbnBlQkI5eExpTWNLZFM1aHhseDk2OWlEc2JoTlNKb2laekdU?=
 =?utf-8?B?K0VMM0ZZalJ6Tkc2NTlNWUR2eVZBNWJtdkRCRkZKakFKVndQU2ZERjFZRHdq?=
 =?utf-8?Q?Ts8w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K21BUklUeStBOTF1ZlhLRHRZVXZISnpRZzRVRFhGazNVb3cwNU1BdmsyL3JQ?=
 =?utf-8?B?VW14TWIzb3lpbUV2eFVzVW1wbDk0dEl1bCsyQzdBU2Y2UmpGdW1WcHdZY1VE?=
 =?utf-8?B?K1QxNCtxMUg2b25HQVIrcjZXREdDVW12TW5UVzM4OVpxN2t3TFdZL1V5K0JR?=
 =?utf-8?B?RHRTWVR6K2VQZnYyVUcwakRCRU9rU01ZaEQ5MEtxWWV5RmRzSDk1S0QyL25F?=
 =?utf-8?B?SUVzd29sYTR6bGpTdGlLdTdSWlUwNGp5MzRtSUdSOVRBTVM4Nk5UQU5ic0Vu?=
 =?utf-8?B?VFhGdnhKQ1UyVG54bzh5UXUvTWJoaUxqdTd4MXh2ZklFdkZKa25Rcm9wTnNV?=
 =?utf-8?B?VCt0MS9WUEx3aWVaNHY2bEZ4bDZhQSt2UzFwTmJoQ0dxODg5Z1NzL1B5KzNQ?=
 =?utf-8?B?K3ZPaUc2aDJ2QUMweTdXUndkSlAwRlRGanNnbHlIRmhHY09XR1RXcjYxY2RN?=
 =?utf-8?B?aVRSTzBROXJET1AxMEhFRDIwZEZqOTZPbVBEWnJEV25wd0FteW1zUDFaMS82?=
 =?utf-8?B?NzZOeUpFTnRHQ1VSNks1eEkzcmQwSkdRcncydk01ZzR1d2s1c3Exd1VjMWNx?=
 =?utf-8?B?MWpIZFJ1cDV0dWNYM091clJHWWNOVUJ1RUZmcUdUWlJVWlBINEFCSmt2RzlX?=
 =?utf-8?B?T09kN0ZNZXVYV3BXTDZiZUxwNVd2SXZMMm1CR1pCQnhqOWRHaDFNc08zdG9S?=
 =?utf-8?B?YnhsS1Fxc0JzbFdpaFFEbE1LcUZqZWlzTUc1WkluUFRraUsyaUFWNmNxVUF5?=
 =?utf-8?B?S3pOd202WUV4SzNPMDhuOGIxRnVleTRaQ0w4TWZ5dWhSTTRuU1VXS3BXYVB4?=
 =?utf-8?B?c0pjQ2tpWmZJQ3g4TXdkRzc0d3RrRzNsMFNwVDNKT2RqQXo0WC9PYzh2M3J5?=
 =?utf-8?B?MHd0ckJDbGxVSjRPWGVYbUpCczJIdEtyQ3dTTERCeGNXbGlhS0FFMlIyKzYv?=
 =?utf-8?B?a1lsbjZPZWdLR2tVOEZhUll5VU5qWkkvUXIrdFZvS1RnQjkwUWNCbytTN3d2?=
 =?utf-8?B?eC90ZmRiVEtIRVJabjdBZ1RzMmNibGt3TkhjWkROUzVNNlZRSnc2eURlUE4r?=
 =?utf-8?B?ZG15aTBLOUo1Uno1RndEZmhGQnNLT3hibHU3aDJsdllKQTZRVkRjZHlKeHFo?=
 =?utf-8?B?MzBYRnZpRG9naTRKYUVsMWh3ZUtZM3czb2laK2NjL3lHenhkSHdoRDhNNDJi?=
 =?utf-8?B?YStBQUlnMzgxVmdpSXkxSjNHdUtGSDhxZHpGWUUzNUd1TDJudzRHS1U4dTlJ?=
 =?utf-8?B?SXZ3VUhMOXd2YzdvUFE2YW5PMlB1cFYrVHVpdVJ2TERzdmNlQ1h6Z2ljY1FH?=
 =?utf-8?B?OXVibTBHMWpUTS9oOHFoVzlOT0wzRW9aN0VlSlZtVkw4bmtyTDVDMnJrZkJr?=
 =?utf-8?B?VnMvUDZjelhtSnlKK3NCcUk1YkVkeEV0L3JsQ2ZwVEVSb1kyYnM2RE9yZ05q?=
 =?utf-8?B?NVhDS3VOSFJJY2F5bEtZRHBsL2JudVJOYkdkSysxeHJ5UXhtdWtxUkRkVk9N?=
 =?utf-8?B?RWE0ZnFsVCtpdmVnUm5YNWZESVFZRE1UQndhbklxMDA0YnliRjNMc29mVUV6?=
 =?utf-8?B?Q1d6WjBPZ1pjdGsvbWVVVGRqZytvd1Q3MFV0cUQvVEFQazNBK0RIR2NiWENC?=
 =?utf-8?B?ZGhFOWZ0dThBYkxQTzFQdXBYMldZNzYwWm5IelBCbzFLT1JZL3RZVVRtMnky?=
 =?utf-8?B?OXVUV0RTa3dMNmNkRHp0OE5PaU1ucFRhcDM5ZTdDWDJxUS9VMzIxUnpCcnAx?=
 =?utf-8?B?T2o4QkJkZXdvOWVaQktCOWV0TnFCN01Qa1ZmMnNuWDUyS1VZSFRpZXhzSlhB?=
 =?utf-8?B?akFEbUQrVE1HUm02OU9NOVpGVkp4Y04zMXJXU0tYOEJkOTk3cEp4dUtpMXg3?=
 =?utf-8?B?K2tGRGtZOGxNZHNqcG1GZXBMTnM5bmk0SWlNQ2lTU0RIRVlMZEUyWjl0bFpH?=
 =?utf-8?B?eEg1VkhqK3NOd0lPMGIySUs5dmVqb0QyUm8yZFA3VjVRSHRTTldGek9kTG53?=
 =?utf-8?B?QjR6R0JEbFNjeURrMk9RcmNtbDQzU244Y2E2aCtSMHl4QXJtbzJTcFlCOGNW?=
 =?utf-8?B?dGgwYVZtdjhocWxmWTl3b2Z1L2pBbnJsTHhGaWRjZVBhQVR4b2RXdnFIYUhC?=
 =?utf-8?B?eHRFdUF4amFpbWxQaDVoanQ3SkYzRGIwUnE0Z0tQNjJtWjNPWWZxSHRXRnVR?=
 =?utf-8?B?dlA1S3BiN1FYczZ3Umo3b1QxdXdkNWFhcm12TFdKa2VSNzZlMDkyU0MwbEx0?=
 =?utf-8?B?bi9TTmRsaWJqUjQvZ1o2WlMrZGxabVI5bER4VCtDYWZ0YnVhOWZCYWNvdGJR?=
 =?utf-8?B?eEUwVldBOHlRNkFZb0hxdW53T3NObUdCeitXcmtrNzU4TnZrUXFwaS9mMXJZ?=
 =?utf-8?Q?slHXfMdeknvhIaj/rGfUdze0BDJzFuP0epAr8TkzeEurB?=
X-MS-Exchange-AntiSpam-MessageData-1: m+iFHz/vWp1cSnwQz3vP4rRbia4pNC2sqEk=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2e7a23-38c5-4c59-ca91-08de6004782c
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 13:35:44.6481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6Gbox2+3VlDALlkEMzdNl9potwoKjvPqGhE+Q6tZh1ZiJhPK+UoMyRiJHh30VB0zXKVX09Pmw5/o8xQhqoQvfkCtmRmAU+j+GTwdCsjXrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5882
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

Hi Marko,


Le 30/01/2026 à 09:58, Marko Mäkelä a écrit :
>
> This Mail comes from Outside of SoftAtHome: Do not answer, click links 
> or open attachments unless you recognize the sender and know the 
> content is safe.
>
> Thu, Jan 29, 2026 at 10:18:03PM +0000, Jonny Green wrote:
>> Hello,
>>
>> I am implementing FIT booting with an ECDSA signature. I am building
>> from a TI fork of U-Boot that is based off of v2025.01 from the
>> mainline repo.
>
> Nice. I have been meaning to do the same;
> https://lists.denx.de/pipermail/u-boot/2025-November/602918.html 
>
> contains some notes.
>
>> However, attempts to boot on the target with the signed u-boot.img and
>> generated .itb are failing. Debug printouts show that the call to
>> ecdsa_verify in ecdsa-verify.c is failing after calling
>> uclass_first_device_err: "ECDSA: Could not find ECDSA implementation:
>> -19".
>
> I only found some implementations for some specific firmware or
> hardware. In mbedtls there is an implementation, which I have been
> intending to write an interface for. A first challenge was to actually
> include the mbedtls in the build. The attached patch would introduce
> CONFIG_ECDSA_MBEDTLS.
>
> A challenge with the Kconfig system is that you can create an "overlay"
> of a default configuration that adds things, but you cannot remove
> things that are part of the default configuration. Here's an example of
> adding things (without modifying any existing files in u-boot):
>
> cat > configs/a53_defconfig << "EOF"
> #include <configs/phycore_am62x_a53_defconfig>
> CONFIG_FIT_SIGNATURE=y
> CONFIG_ECDSA=y
> CONFIG_ECDSA_VERIFY=y
> EOF
>
> The above actually is how I was originally experimenting with ECDSA.
> Currently, I am using a Raspberry Pi 4. I figured out that there is a
> lower-level configuration interface:
>
> make rpi_4_defconfig &&
> scripts/config -e FIT_SIGNATURE -e ECDSA -e SHA256 -e ECDSA_VERIFY \
> -d BOOTSTD \
> -e MBEDTLS_LIB -e MBEDTLS_LIB_CRYPTO -e ECDSA_MBEDTLS \
> -e SHA256_MBEDTLS -e SHA256_SMALLER -e MBEDTLS_LIB_X509 -d HKDF_MBEDTLS \
> -d LEGACY_HASHING_AND_CRYPTO &&
> make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-
>
> If the LEGACY_HASHING_AND_CRYPTO were not disabled, it would override
> any MBEDTLS parameters.
>

I am working on this topic, but I haven't published any patches because 
it is not finished yet.
I have added the support of ecdsa using mbedtls. I need to add a 
"software driver" that can be called
by ecdsa_verify when no hardware supports ecdsa.

>> Other debugging steps I've taken:
>> * Ensured public key is present in the booted image via inspection 
>> with fdt
>> * Ensured relevant config values are set: ECDSA, ECDSA_VERIFY, 
>> FIT_SIGNATURE
>> * Attempted to get trace information from the boot attempt, but it
>> appears my board does not support the required clock
>
> One problem that I noticed is that the ECDSA signature verification in
> fit_check_sign needs access to the private key. Were you able to fix it
> so that only a public key is needed, like it is the case with the RSA
> signature verification?
>

I haven't looked this part yet, so I will also have to manage it.

> Also, I understood that u-boot prefers to store a parsed RSA or ECDSA
> key in the FIT in its own pre-parsed way, while the MBEDTLS library
> would apparently input the raw key. This problem would have to be solved
> in some way. Maybe, by just embedding the key in binary form in a FDT
> node and letting MBEDTLS parse it? This would of course require some
> changes to fit_check_sign and other tools as well.
>
> Storing the key in the canonical format would seem to make it easier to
> add further algorithms. I'm actually not that interested in ECDSA; my
> ultimate goal would be to integrate an algorithm that is expected to be
> safe against attacks based on quantum computers.

In summary, supporting ecdsa on platform without hardware support of ecdsa
is in state "work in progress" on my side.
If you can wait, I will publish my work asap (not this week), otherwise, 
if you want I may
provide my work "as is" but if it not finished.

>
> With best regards,
>
>        Marko Mäkelä

Regards,
Philippe


