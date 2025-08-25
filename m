Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9201CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 18:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0254482DA1;
	Mon, 25 Aug 2025 20:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RayDX+Vh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28B38830A0; Mon, 25 Aug 2025 20:18:07 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17F7A82C84
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 20:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGhBo+FCNM2Hx02d0SuaCsYNLZjjOl+JUnweq2wv2nRZHr/tmxjtXq/BpSnbSQ03bL2lHDCbOCnmeyBpO4eSyefCWpEm3EtT21702hj/d0QTMKG0IFlZ5dW4UllJoAubukRyNqDpYShlJGGpUdW/T816rCyiyBDx3MtwKbcFNnGiBZ2lEuKcmk6KdOk22Yt54itRLMei5h1a3Tv7/1ag5Ihr2hvisaMhc9Hz4dRcP0/HxKubQc3lWSioMFwNWFWiTTrpzEUJznMymE4khkGubtKY/Sv+MjEyHcCdGiQnT0m/7PSGEOJEAWH2QBzHYIkSJM6XZvugNDcaJITkwmoUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9UKsCB4WcYtQoN/WCPAI+D+pXU8XbaS41nAJXvqM2I=;
 b=c1OQJS0tgamBmZHrFROMJiVRSYZhLXJU77MX5ZoAl4HQxFwWYZ7k6RlU91rxTP9HhQtXVhLvjtWjcrPybrR/SCGZJrgzcWFkWG7lfLDBI4kodzaLJM2yj3gsOOd1GKGz5SApQhm6e7mxVj9IUJ50gT5iFMAisVsO5kJgQB4pjWdTk/kxhHw+zAOL0HBGKxTS+j2WOKcv0SM92kiiEVn10uGEoOJwONodbEdUwuBY3dR7eBGMpgExtRbUhMfCTESYshA7rC7P2hgH26Ty+63U2ajibWwZM+/sLg3YUZzoTPZkZ0+OAODvmBnLO9gBFqQ+cRPdAamP4JbASCrjZ5qRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9UKsCB4WcYtQoN/WCPAI+D+pXU8XbaS41nAJXvqM2I=;
 b=RayDX+VhvKHR+982Bi+XraI7O5ouv4ZbAdi+r7QnBnwvdnb76P+aesmRcbqMyhfwzCOGg52vzLtItmtnpuMV83yN1HGLEcdfc0E7MC6fbcf0pewAK1iHeHRvA3RJUPDIF6Ewf7k/hUYwr34cEjMomhs+cxD7ZemJN4WPlJz6qKyoA4nHyJrXSWbbXj/L1ouAX07ULP/6S3YT27YbitFhrXWR7aRxaNBpZKKPb5ATiSJM8Fk1LV5+dpP7YIzL8q8QKZxflCErCMyOOqViaxKP5bKmB0sUfKvA1Xb6P3dSSjwaMau41fcPCGwZtmkXvKBQwQre+lkQEUScOVqjkSzIaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by LV4PR03MB8307.namprd03.prod.outlook.com (2603:10b6:408:2e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 18:18:00 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 18:18:00 +0000
Message-ID: <e1e44ddb-4569-4d8f-a1e1-67e14c359ccf@altera.com>
Date: Mon, 25 Aug 2025 23:47:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drivers: fpga: Check bitstream address doesn't
 exceed 512MB
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Michal Simek <michal.simek@amd.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>
References: <20250820073201.8649-1-nareshkumar.ravulapalli@altera.com>
 <20250820073201.8649-4-nareshkumar.ravulapalli@altera.com>
 <LV8PR03MB81370A93399D0C1E3D814F13A73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <LV8PR03MB81370A93399D0C1E3D814F13A73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::8) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|LV4PR03MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: a3bc100c-2b6b-4ae3-7908-08dde403b944
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGxCbldmVHU5S0NWSVNJNmJTK0M5M2YyUTY3NGIraEVDT3h6dkNxSFc5SDg4?=
 =?utf-8?B?RXlKSUlJR0J0UytwdzBCeWphVHA5SnlUKzdSVy9kOGhxbVJqdDQ5T0RHc0k0?=
 =?utf-8?B?Z1BvOHZlK2MvZWhxenU2MXl1aHBFcDdvTlZkZjJuT2pidmlkZDhOL25CS204?=
 =?utf-8?B?cW15REUxZmpYYmkxY0Fzc3hiN3RTYUExSGRjdDg3WXdibmllcU1mc3p0S25u?=
 =?utf-8?B?ZnF5a2lzdUV6K0xaek5ablk4VzdJRDRyMXorYTliaDUySGR0WDBoUmcxZXBr?=
 =?utf-8?B?bW83aEtKK2FUSEdFUGZJSWE4QU1rVzgrK2xBWmNNbGdtbVVqQWNFUTlobDBZ?=
 =?utf-8?B?dDV4T0lReUVCNm5RUEN5NWg4M0JjT2tlcmlLT014ck45TDE5RktEZ0dTaWU1?=
 =?utf-8?B?cGluRHBKU0duSzRqL3IvZlZtUjJTSERET2syVEluQnp1eDdKZ0E1NnIyK0Yv?=
 =?utf-8?B?T1FNV092NDcxNjdDZDhYNTRpYVdSWXdPZEloRlJjVmt6NFZrUnhXZUJZelQv?=
 =?utf-8?B?ejRuY2VpMCtydDYrK3BUZWJ1OTg3WmNzaWFpN2ZObHRLRlZQWEVva1Q3ZG1J?=
 =?utf-8?B?Q1ZkdEFmNXgvQ3RmMXpqTDd4YURUUjZyKzgxRmhNR2s0cndmUWs1WVJTeUJI?=
 =?utf-8?B?V3FWUUlkT3FXY1dFYzFrZUJVVXZIZmxUODNCZDNzS0dqZVJqNG1rbWZRSkVy?=
 =?utf-8?B?OCt5b0FpNGlTa0lXRHZlakFqbUduRjZqTndwNmNvcjN5R1prcUgrdGFkQUJn?=
 =?utf-8?B?NnFzL2RTbVlTOHBSWnkvU3NtRGhZR1U3eGFPdXFEYzlqZU0zejZiQTdwbitQ?=
 =?utf-8?B?TEc1N21uNFdUS25Gd2FKajRLQ3pYV1NnUCt3aXl5aENqQ3VjV2N3cHhVYmhm?=
 =?utf-8?B?WVQ2Wktzem5laEtJRm1KZ09oTzh5YXJCUitBWFZwSXAwZDZNVC82Zlo5WE84?=
 =?utf-8?B?UlRTOWhIL0NTK29BQitEZHNLTnYyWHhDQkErcnoxR0t2czdwMGJzSnZDWkZh?=
 =?utf-8?B?S3ZKWnJqcjdVQ0hXWXRTKzJpcGdKdUE4bENLTVMrUzRaUEpVYUwxYXE3RzUr?=
 =?utf-8?B?RnIwWUZIazJzeDEyUjh2cHkyTXNlQ0I4MWdiUkJvcWxaZzdONmRtQk1UYU5C?=
 =?utf-8?B?cHJnN3poU1ZkNWEzQjBFRFdJd2xMUHJuOVBFTTB2dExPSnpqQjBsL1J6Wk5o?=
 =?utf-8?B?dkplWW9sbno3aWlMUVpMbFNRdW5hSmhmditCZ3ZWYzNVcWpwV3cvN2NrZHNJ?=
 =?utf-8?B?ZEt0cDd5eVl1NFFKdVBmQnVzQW5jelZWN2s3a1FaUGQrNm8wdUxIcDEyNUYy?=
 =?utf-8?B?bUlaT0hDb3lqRXNyenNYQjl3Wm9wQVhmczhFTXArdXVKT0tIK010VzFnK01l?=
 =?utf-8?B?RkxjQWVKZlVncmdzZFNiUEVjb0tJVGpQdHQ0M1JEREpwNHhkVEtCWUdqR0E1?=
 =?utf-8?B?U0V1SE1kcU1pVk02STVTQllUQUlWUGxRRFZDcVVqc0ZxWlJrNXBHbmFkN2w5?=
 =?utf-8?B?T29uUXRRK1pMdmZFTVN3Kzk2RjJqdUordURGQWVXbmhyeG4zakZUWks2eEd4?=
 =?utf-8?B?OEo0MEpqR2RWSDBJZVFCRmlPNWVaZmFmcjFBRWwveEd4MWg4N1pJQnZMVlRI?=
 =?utf-8?B?SEpiUVhiZ2NnZ1dSYisyUlBiMGtpejhoUzdXSENOSFB2d2syZVZ6VitnS0NP?=
 =?utf-8?B?SVJYc3J3OWh6Y2tVT09xT3ZObjJ6OTI5REJneWRSVlF2MFp6M0lpTXZBNDIz?=
 =?utf-8?B?NEk4K0VzQTlMUEw4VXVBRmNnYlNhTHE2ZTFYMklMOHlwRndSSmVndUxGeXQ1?=
 =?utf-8?B?dVdxTHZaSDlGU0phK21nOXVYUTIwc2xGU0MvOWpQbXhoQ2lzZEhBYkRic2hF?=
 =?utf-8?B?YUs2UktsWi9mSVJGdVNKOERYelc1VDZ6ZWZicjlhRXdUUS90ZDMrRDBSZytk?=
 =?utf-8?Q?lXB2SsQY6Rk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHFtaHdNWmxKYkU4Z0drWEdRNEtzQXNrQzM2bCtJeitTSnJmcEpyN3hrekFJ?=
 =?utf-8?B?V3Q5R3lVK0FjZUxIMzh4MG5yN0FKRlFjMzhZTzRvWWxSV2dxKzh4Q2FpZkJ3?=
 =?utf-8?B?OWxobUhNNFFJb2Q4cDd3Vm04MklsTS9OSXYzS0RqQ05Ndm5HQjhJZTBBaXo0?=
 =?utf-8?B?c05LWTY3Vzlva0JraExYT29oeVNzcUs5ZFE0RjhCUHNTU1J2eHF3cTBuQ1da?=
 =?utf-8?B?OGFJR2ZwbGJ5eE45RVI2SXg1UHZ5SWo2YUUwcGRIQ2RwcDUrOUtISHlaNlhj?=
 =?utf-8?B?dU5kOXVBb1o2aWtaTnNBcHA5SHYwcE44WlJ0d0NmdkdyRUpQem80MWJ1c0Z5?=
 =?utf-8?B?bUVPQkNMSXYzSVJLWlVFblBZWWJPbSs3YzJPZE5mMS9zb0U5aDRqa2NTVXli?=
 =?utf-8?B?VWQvQUlOeHhQWG5wcXJDWXAxellUcEprMWFPK0NRMzlTaTNVSHliRFZrVmk5?=
 =?utf-8?B?cHBTWnF0UWdhZm5UcDJQcTRhdGR6TndGVFk5VklZcWk4UWJrSklYeFZtdUhl?=
 =?utf-8?B?ZzVHeWJZd1dmaXlLcW5GckovS29wNnBTTWg0KzRDSlhBSGJiMk5SSVNVVWE4?=
 =?utf-8?B?L3JSRWNkaWpTS0xYSU9ySHFmNk5vUE80U0UzeENJZkN2MWR0SXJha0xKRzBu?=
 =?utf-8?B?U3I0T21zNXNoUGFIQ2JYVjFyQ0krZkxXVFZXZldSUDVkMStGc3lXb25LQ3lk?=
 =?utf-8?B?R3l0djQ4NHFEcjc4UHVBTDYzODlYQ2oxbWhlOTJSelpvd1NQaGQrNFNDZy9p?=
 =?utf-8?B?Z3R5YUxqUXc2c095WjN3T0RselRhUTdQQU1wZTVoU0dlT1dSdjdGTkEwcWNO?=
 =?utf-8?B?clFLSFJTelVOZHRYM3F3aG01TVVFRGFaWGlDYVJrYS9GMG84cCsvdUxlNFBE?=
 =?utf-8?B?SGxnYUZkSjZoaWhFajlsc2ZoMHRNcW4zVlVvSERIaWc4ZDdIM2hjVE8rUExh?=
 =?utf-8?B?K1pYaGF1SmhINm5DeThBbUx2Nk1kaWV0NExOajNvZUE4SmtuOTdyQ2NST1BZ?=
 =?utf-8?B?ZUJTcEdaQ2tLSzRJclFWWG5GWmFBbzVMQWYxMnhOaE9xZ1E3TFVIY05va1Jj?=
 =?utf-8?B?dHRPMTcwWDJMVnNDZVM2ZXhEN2ZvalNtVXR5ejJBdmVJdVhhNk0zRXNEM0tB?=
 =?utf-8?B?QTdNelZrdm16UWtKTkpvbzVtR3Vwb2EyOE15eXR6MEg1UmRCMGdpOWZIelhW?=
 =?utf-8?B?emhPZ2FWQTV2N1ZNSmZkNUxvRk1udUxWMFBEQ0dIM1hVNUV2UHBUUm1FN2R2?=
 =?utf-8?B?L2hFdGxWYVdRdTVGRlhIVDZIMGF6MUk3RnBTTnNSQnMrNlFHbnA2TW9TdXBT?=
 =?utf-8?B?emlkcldsd2Q4TXpua0JlRXZIRzNXNHl6VitNaGRZV3RaWDVoaHlEMndxbngw?=
 =?utf-8?B?Z1JlaGpKdEZZS0lxL3hMOTh6d0JYQmR6M3lsZ0RadlFKQUIxMTluMFZYZkI3?=
 =?utf-8?B?YkUvNmNVVnJZM0ZwT0E3cWEwQmRFaWlpQ0thSjVDZkhMMHRMMEVZVGZ3VDRM?=
 =?utf-8?B?RGVJYjgzV3BFY1RISUwreERZVnJ2RVNuRlFVVkh4aUxNMFNOd09ORWttbUlH?=
 =?utf-8?B?TVh2RjE4d3VTZnE2M2hkQVFLbXJBYTMvVjZmSCtwNHJpQk1UV2szUFVMUnlY?=
 =?utf-8?B?TmlhYUpIUHgvZHFMeWJSK3JGMnVnbUt0ZTI2UXRKMitVSEJvQU9VQ3NvU1Rv?=
 =?utf-8?B?ZFZTSnBYSW1wSlZHTkRHY1VMdXorR1NMWEQ4NFEwcGhveHk1elhEZm1hK29L?=
 =?utf-8?B?aXIybTNKeXl6MzdjTlNSblJpV1ZKdXRoeUVYU09NV0Z6My9vODNqekxRb1di?=
 =?utf-8?B?ei9STWVReTRXK3F2dWt5WWlkOGJDVGl5ZWVxN0IvNk1tcisraEZmYXZmcU91?=
 =?utf-8?B?UExwNFluemw4NVFtaVBnbnlLdTM5MEJsT1dXYlVPM0laSmx1OFl6TjJlUUsr?=
 =?utf-8?B?UEd1UjFPd3VhL1RaMGNzNEpRKzNtOXdySVVqRzk0ZUZOUWJ5aDZRWllraVYr?=
 =?utf-8?B?MUR1NUpIM0gzNU5wWkU2Sjc0cmlUVUljbHp5bDRySjcvRld4cUM2a2o4RTB0?=
 =?utf-8?B?WTVWZnFNUy85RCtBVkc5akJaSFJXeW9hV1EyZm5sVWhOdGxuZWlJRWZUcWdP?=
 =?utf-8?B?Nkx3M0ZaWDdqaDRqdGVzKzVSVjZGNG5YT01lSWxTMVM1bExTVUw0Q3hGMnV2?=
 =?utf-8?Q?TAhDcl6RHPmG9fGeq1AHX3g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bc100c-2b6b-4ae3-7908-08dde403b944
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:18:00.7045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Vg7jAt6pSfDN8NnVrFSF//tkZsN5eTQQ3FpdE+WNfEtTioDLQ+6yjvHMsBiaqykdNQg4uUVpfEbgzt5M4Qw7bILcgOQjYIFyXqd9GZFmLjAT5KNq68Jcx/rDqvJot1u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8307
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

Hi Tien Fong

On 25-Aug-25 3:12 PM, Chee, Tien Fong wrote:
> Hi Naresh,
> 
>> -----Original Message-----
>> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
>> Sent: Wednesday, August 20, 2025 3:32 PM
>> To: u-boot@lists.denx.de
>> Cc: Marek Vasut <marek.vasut@mailbox.org>; Simon Goldschmidt
>> <simon.k.r.goldschmidt@gmail.com>; Michal Simek
>> <michal.simek@amd.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
>> Ng, Boon Khai <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
>> <alif.zakuan.yuslaimi@altera.com>; Tom Rini <trini@konsulko.com>;
>> Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
>> Subject: [PATCH v2 3/3] drivers: fpga: Check bitstream address doesn't
>> exceed 512MB
>>
>> Secure Device Manager(SDM) has only 512MB window address space to HPS
>> over PSI BE link. The default access range is 0x0 to 0x1FFFFFFF.
>> To allow SDM accessing the address space more than 512MB, SMMU has to
>> be setup for address translation.
>>
>> A conditional check is added to not allow the fpga reconfiguration for any
>> bitstream data where address exceeds 512MB, unless PSI BE link address
>> translation is setup in SMMU.
>>
>> Signed-off-by: Naresh Kumar Ravulapalli
>> <nareshkumar.ravulapalli@altera.com>
>> ---
>>   arch/arm/mach-socfpga/include/mach/smmu_s10.h |  6 ++++++
>>   drivers/fpga/intel_sdm_mb.c                   | 13 +++++++++++++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/arch/arm/mach-socfpga/include/mach/smmu_s10.h
>> b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
>> index 209caa86e38..d611664e227 100644
>> --- a/arch/arm/mach-socfpga/include/mach/smmu_s10.h
>> +++ b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
>> @@ -30,6 +30,12 @@
>>
>>   #define SMMU_SID_SDM2HPS_PSI_BE		0
>>
>> +#define SDM2HPS_PSI_BE_ADDR_BASE	0
>> +/* PSI BE 512MB address window */
>> +#define SDM2HPS_PSI_BE_WINDOW_SZ	0x20000000
>> +#define SDM2HPS_PSI_BE_ADDR_END		\
>> +	(SDM2HPS_PSI_BE_ADDR_BASE + SDM2HPS_PSI_BE_WINDOW_SZ -
>> 1)
>> +
>>   void socfpga_init_smmu(void);
>>   int is_smmu_bypass(void);
>>   int is_smmu_stream_id_enabled(u32 stream_id); diff --git
>> a/drivers/fpga/intel_sdm_mb.c b/drivers/fpga/intel_sdm_mb.c index
>> 5f4aae47d6d..1bbb717015b 100644
>> --- a/drivers/fpga/intel_sdm_mb.c
>> +++ b/drivers/fpga/intel_sdm_mb.c
>> @@ -10,6 +10,7 @@
>>   #include <watchdog.h>
>>   #include <asm/arch/mailbox_s10.h>
>>   #include <asm/arch/smc_api.h>
>> +#include <asm/arch/smmu_s10.h>
>>   #include <asm/cache.h>
>>   #include <cpu_func.h>
>>   #include <linux/delay.h>
>> @@ -1031,6 +1032,18 @@ int intel_sdm_mb_load(Altera_desc *desc, const
>> void *rbf_data, size_t rbf_size)
>>
>>   	flush_dcache_range((unsigned long)rbf_data, (unsigned
>> long)(rbf_data + rbf_size));
>>
>> +	/*
>> +	 * Don't start the FPGA reconfiguration if bitstream location exceed
>> the
>> +	 * PSI BE 512MB address window and SMMU is not setup for PSI BE
>> address
>> +	 * translation.
>> +	 */
>> +	if (((u64)rbf_data + rbf_size) >= SDM2HPS_PSI_BE_ADDR_END &&
>> +	    !is_smmu_stream_id_enabled(SMMU_SID_SDM2HPS_PSI_BE)) {
>> +		printf("Failed: Bitstream location must not exceed 0x%08x\n",
>> +		       SDM2HPS_PSI_BE_ADDR_END);
>> +		return -EINVAL;
>> +	}
> 
> This function is common for all SoC64 devices, but above limitation is not applicable to Agilex5

intel_sdm_mb_load() is defined twice within a #ifdef condition. 512 MB 
limitation is only addressed in the second function definition. Could 
you please confirm if this is not the intended implementation?

> 
>> +
>>   	debug("Sending MBOX_RECONFIG...\n");
>>   	ret = mbox_send_cmd(MBOX_ID_UBOOT, MBOX_RECONFIG,
>> MBOX_CMD_DIRECT, 0,
>>   			    NULL, 0, &resp_len, resp_buf);
>> --
>> 2.35.3
> 

Kind Regards
Naresh

