Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1BCE77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 21:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF712801CE;
	Tue, 17 Dec 2024 22:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="AFYj9vDI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFA1F801FB; Tue, 17 Dec 2024 22:37:33 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A00E80107
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 22:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+1rDPVFGKwojZ23aG5MB5G/bb5Dj+9CdKahY7xGcaz6cTcAARei9yWncVoYLI1Irjb4rH4i5RJMcirLd+lRyvSoBCsKygeVZ4koeyRN2GaL9YZf8XuR+i9HS5EiQTNuNkS50yEq5PGhJaqJLGF9bqsn+nD5IEDdcCeDUqhtpc3dgwMkFA3vESO3xutEEB2lIb/BCRASAPeLo7nXtyWjhF1ZQ/aenvQscPz3hFBfqT826/mpG5h3Wms5Gf6C5VEXkhFIzSaey0B/xw5l2x3LKtlLreg2unJw4fTHZbE9Sl8T5UXgnj3NELKWX5ag9e0N+o0c2nkzlYMitOFehCvAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KacShv6K2Kxp+XWBpR3LTn086+9q4f1PJXAUCdCUIL0=;
 b=Jrzn6Wiw7o98oSM/LQQPJb13s6iT29a0rRNw6l7O7ENCz1veu2ZjOEGpu1qCOZyZoqgYXzNweOkl+C+AKkRCCI0VyVoK1r/sXCm3JwhLzdixXZgaC0QPmaakGiVideAscY/0YVjwd7AhqLmIq9iQL3B/ryPK6dtg2ezcqdTzqO3SSQXA+kmKjaBwWt8toLNFMIBT3ftN3vVMCHrYynTkhQ2rYwES+GVARPmr3dDBRjmsT6IvlWB+FHnvdycyWdV0Z1pJupWDYdVLGT9i08Recp82KOawDzbmPiht+F/3o8XRBlpj0xa5vsP9rAwUb1zlVVt3vyO3Eelu4841ingSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KacShv6K2Kxp+XWBpR3LTn086+9q4f1PJXAUCdCUIL0=;
 b=AFYj9vDIlVEar+5vHiFZ2jbgRwQYXLZBCNiLYtJecqeklIa04etH+2jYm6al71IgpY7qmQzUpIiA8HmS7Op5rcl6irM6spXKxOfEdNbIsYNkubWBK7TBm+4GE8eN4/bwIZiwnCTpGb2bPW8DklLu7eT2joanGgwQ2CMtXwJobsLQEaLS7Lv5+Hd1ulJCCUIdYM+laDReB7ZO1wfl3m0RfwJ0volv4ayf3b35x+2efdXn09GsT9+ycjNRd1LBLdrCt48T8tNW6QbTl0tWY1IA5docurRCT4NC5RZ6Zh89cBB+fFUtcx/Tr0SLVvrAjKrb0XMDmJDi+1HZtag92yixNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PR1P264MB3445.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 21:37:30 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 21:37:30 +0000
Message-ID: <338a426c-fd2b-42cf-9a61-7f4c030cf976@softathome.com>
Date: Tue, 17 Dec 2024 22:37:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] lib: sha256: add feature sha256_hmac
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241217083212.70330-1-philippe.reynes@softathome.com>
 <20241217083212.70330-6-philippe.reynes@softathome.com>
 <CAEfUkU+LkwSMNwsiQfwUx8HEijCDOJUNqSU_fQ7YcinhkWdwyA@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkU+LkwSMNwsiQfwUx8HEijCDOJUNqSU_fQ7YcinhkWdwyA@mail.gmail.com>
X-ClientProxiedBy: PR1P264CA0192.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34d::17) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PR1P264MB3445:EE_
X-MS-Office365-Filtering-Correlation-Id: a384cda7-0e0d-4e90-2b33-08dd1ee3022e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTc3L2EyUitqY1lUbkN1Y3JDaWc4WXZ0OThLMXcrOEhTREZWaEdheTQycXA0?=
 =?utf-8?B?cThJSFJqVURNYnZFM1VUK2k5WW1Md0x3dGxjeXRWR3RIVytsemx2eVJtVy8x?=
 =?utf-8?B?UnBMY1hRNnJmcWFuNjZia2ROam5YdkU1WUtnYXRhaHVTSWhtT1BDdUVBcCtR?=
 =?utf-8?B?cUdsSUVGSTNGVXBsbmpCZ0hKazlvYWEzaGNSbmlRZytHMC9oR3p0OTBsdTQ2?=
 =?utf-8?B?WElGZDlRSVVGK1Ntd2lXcGs3QXlmV3IwNG5EY21zSklRZ2VpSnJCSGp3U2xr?=
 =?utf-8?B?K29QME9uZk9vbXN6c1JkWnJJcEs2M0JzTVlVQ29vZkZIZnVaWElWb2dzOWtI?=
 =?utf-8?B?L1hneEZ1RTBMSFVkVGkvT0JDOHE2YjhSNkdVOVdnb0VyeWJBYlZzWVlvQkll?=
 =?utf-8?B?cWUrVDNqSmVyenRDZW1OTDdxQ3I0ZFdxNERXaEQwWnpGSmVmZjU1M0VIR3VU?=
 =?utf-8?B?NWx2RGFBTkhUaVlKWlNPaWF4QjdLamFRZmxKYm53bHY5bmYvY1o2b1NYVzRs?=
 =?utf-8?B?WndsaVNuYkJUK2NoMzVhQnU4VlhnVTFsalV6TzJtYmNLaStXK1J6TDluZ0d0?=
 =?utf-8?B?UnN1VmJBaG5sSjN5akJFS3pFaGt3Q3FzQVFsRDFualRJNXpzUWg0bXdEaW5S?=
 =?utf-8?B?Vkd3TlNWSzBMTVp6ZzB5UFZqSm8vU2ZiV0JpempobU0zbXBHeGRpbmVnZStq?=
 =?utf-8?B?UzN6UEZyTzd5MjR4UVcycHYxZzBjaEFPSHRvN0k1cG1yL3ZIdGRHUnV4QTBn?=
 =?utf-8?B?UWt2dUljeFhmZDdjNjZadGJMaWttNTJhRUpQVzl4cU84NnlOb0pzS2tGczEv?=
 =?utf-8?B?U0xEd3NXdVBvQ1lmRmlMb3B6UGw0ZjlXck5hRE1tU2xDQ1BvT1FkT1RDSWpq?=
 =?utf-8?B?UHhRM0VCOEk3cWpEV0dTeHQzMVdFQ2dHZU8xUlk5akcyVURDcWV2OXlHM0N2?=
 =?utf-8?B?YWV6OU1RdE10Nk1KMVcxYm0zU1VERkFUMk9DYU42Y29WMUl0UjR5Z3pDUExY?=
 =?utf-8?B?RWtkQVhwaVVNaVJUVHBOZk5EdE9xUm55ME52d3FDNTZucGVwbGZSWnVjNmxU?=
 =?utf-8?B?MkRoTitydEplZEdicW5BMXNWZU9aU2FPR0VZOERoaEw0RkRDaGZzVEFhTTFN?=
 =?utf-8?B?d1ZTWnZwMzBrOENzOHkzb0VPdm5Dc0lUTHhWUm9RK2JVL2JyMjRuYnFMc0oz?=
 =?utf-8?B?VGdxNEUraEg4aEkxR0dvblNoUnJTbENGUnlWdWhFUm80NFJvak9SdmNFTEpK?=
 =?utf-8?B?Uks3U1VkcjVvUjlLRExsMVVhaTdnUi9XVlRyTU8wU0pLcUQrbjdMZm11WkhV?=
 =?utf-8?B?Q0kzSGJmeWpVa3lCMkxNWm1qZzlDVWpuTE50MUliZDVBdGltc3V4bXh6NWN4?=
 =?utf-8?B?eTAyQ1p0UjYxcTVHV0MwMWNTV1Mvb0RPVFVpZFlVdCszcEg0N1hNSG5mTUQv?=
 =?utf-8?B?K3pCR21qeFFmZzlJRS84NDAvK01lajd3cFU3cW1oRmxvNGNMZXJlUHRKbHpl?=
 =?utf-8?B?RmtCWUthS1VpbEorVGZhV1ZtMDZsWUJEK1ZqZW5QMUl1ODRxU21aSXg1YTlD?=
 =?utf-8?B?U0E0MUJYa1lORWk5c1orTkRjckpQeS9jbE1SQmxRZDhJUUsvZENIbzJ2L1NY?=
 =?utf-8?B?R3kybnVXZFdOQ2JqTnZ1a3ZYYVdHbXE4YXNjb2ZhdW11Z0ZNK084eVdVOE43?=
 =?utf-8?B?OS8rWjNyaThnWW9TdytDU29KRklSd3pURVJSMkxvWFF0aWVkbHdXRGJTclR4?=
 =?utf-8?B?WFlaRFRleFo1YjBxcUZ4U25YeVJJaXJYaFRvbXdvb0w3eUY5RFJvbWFrQUp1?=
 =?utf-8?B?eC9DY3JZWm9LbkY1bU45OGRzdStrdG52dlNnWEVITWZKelZ6OHc3TzlZbzh0?=
 =?utf-8?Q?nFv8ZFBm2Bpk/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnNDaTVOQldCekJLRTF4SDY4c1hobW53TFRDOUV0ZjV5eTFlMDVNcEQ4Rlpo?=
 =?utf-8?B?RnlYdk94OHpGSVJnSXZncG14NFp6VEUzMlZVZmd3NFBCYVY5MFRhUmxrWlZW?=
 =?utf-8?B?OUhSTzV4S1hVM2kwK2ttNlY0Zm8vMG96U2NrOWxzd0tna2MzRWdUTnBMRmVZ?=
 =?utf-8?B?eXBjTjZKT0E5VVVLc2Jyc0pOUHhIK3lsVFdvUVJNeC9pN3dYd2dNdVNsNDBm?=
 =?utf-8?B?WllDODhqdGNmdFlkaWVWbDBnbW1ZZWdsRlhjZGxHbXZhamdGdEtKSXBFT1p5?=
 =?utf-8?B?WjI5eGd2SS82RXROaG5HWmJvZFAxS2duS01CY0FJVllaeWlCUElqdk8zWmpv?=
 =?utf-8?B?WlJzcUU2R0dMckt3WklqWDhzNnI4eXg3RVZUT2djTHBodnlSdFluT0pZeEJz?=
 =?utf-8?B?emxOczRUWURjbVhkZkRUbmNFazhHcXJOTXVKYjJ1aG90bENLZ2RIUzdwejFS?=
 =?utf-8?B?cXF2UXBWamFXaUlBWTcrRGJTd2FEU0ZvVkI2VXhBbm9KVStyTk9ReDBvK0hN?=
 =?utf-8?B?UThMa2xGajFLaGR0N1R4a0p2K09HMlhUZWZ3ZjFEcFZSaHBkQnlXVXJjb2xz?=
 =?utf-8?B?bktaVEFiNDBNZVByVkpVSXg5VzBpRzFoTmJOZVJFMVQveTVCYWFSRVRZaDBi?=
 =?utf-8?B?d1E3M2dFVGI2WmY3blRnd2ZiaDdSdHRSQi83V3VIRjdEN2xrc0g0bWVxQjBl?=
 =?utf-8?B?cE9pRWlveFdqbElSeXI2YzczYU9Db2V0czZIMERKQWJXTk9xNkgxeCsva3dF?=
 =?utf-8?B?dUhMUkJXR1dMSWRqeGplb2JDMVJpMlIybVJReUU3Ym5INUc4Z1BMbm9nRWY2?=
 =?utf-8?B?YkVRMzh1NUI3VmlYQUJzMDI3MlVhVVY5T2x2M2FtdGc3aFVEdlBKSVVmZVFS?=
 =?utf-8?B?b2gwUjh6c2o3VDVhODJFaWdhYTZreE9uMHZvMVRIamRsVVpOQWxpdXJ1dGUv?=
 =?utf-8?B?MkE0bFRUcXVCZ0FmY2FmeGJxbDFHeCtVZlQ0cnk2UlV0RnNQUk5OVS9tMWY0?=
 =?utf-8?B?aGhZN0R0K0NjdEVIQmVCTlVFZVNlZTlaWmVuRnNZUkQyNWdNdDJPN3ZGM3ox?=
 =?utf-8?B?c21UcERCZE4vM0tHTUlHWE1YSjJYMzBiRWdMT3l1TitVYUp5a1Z2UmEvOTg4?=
 =?utf-8?B?Q1ZyL1QxTXU3MUV5U2FaZDkydjRZRy9ZQXpaVXlCMnNzRmdMRHd1Mm5LUTlS?=
 =?utf-8?B?RTZaTForTzhDaU5Xb2k2UWZMSmpCR3dna1RNdXNDcm8vUkZTV1grRE8xc3Rz?=
 =?utf-8?B?Si9oRUxkc1c4aGVqVi9PKzFabHg0bzRRRHdxdjI3TEE5SUN6NHRwbWZOaVFL?=
 =?utf-8?B?UGEvRWxwbDYwcHNoQnp3U3JaTzlHakRsZlFrQWlCTUdaT3dvUjZKcmtoNXh1?=
 =?utf-8?B?TldxSXJraEJRMnpSVXJFb1BmSDhMSnY0SkpuVnNGempIaVBHQmxDbmxuVlc4?=
 =?utf-8?B?Wld6VE90MWkxK1BzWE9TNExKNVRnNGdyVjVuTHlWVkZxelRWc3lJT2RkbFVy?=
 =?utf-8?B?MGc0Q2Z6TnNUQkRmM2JLNmx1cUdLb3dzRUV1TGh5NS9tQ0c0NXlRMzZGUk1y?=
 =?utf-8?B?YXRpVTBxM2w4SDd6QW90Q1IzS0EzbkFuN3RnUXF4S0lEVFdSUitqajYvUXQ5?=
 =?utf-8?B?RFFiL1FoSCsrMmVLR3BUM3ozaWVUV1ZhQmFVTFppWk9DMEFHdlFFanpoM0lI?=
 =?utf-8?B?ZnlKbFpuZXlZajZETUZOQ1ExK3NUd3E1YmN6OUhlMnF0WlNEeFM0LzRKem8r?=
 =?utf-8?B?aHBoTDZoeEtMOWhjdjNnaW9QQldPa1NpenhTZEJHaTgwY0NNaWh2VHBBNlpk?=
 =?utf-8?B?dXFJUW5lQnlXM3NOZGZYcXpRV1RxTHRoTUpDT3pMMnAyZi9uRHR6Y2J4cGxT?=
 =?utf-8?B?UmpoaUJQclE1RHNPT2pNTlR0QjVxNm82d1NTU1F5bzl3ZlhyMlZTQXBtUnpn?=
 =?utf-8?B?VFUvVnFvcW81bmE5S3VzNWdKR3pDWUNqTDR6elBwOWxtV2pPNUNsQkdnMGpV?=
 =?utf-8?B?djdpSks1alc2L2ZkV0Q5RVhaK1l2eXYrOEdCbkJ2aDRjRTlqRWpydk1ERG5a?=
 =?utf-8?B?R01qcC9sZ3VNRkJaUXhkTE50OUNJUGs5Wnc0U3NocDFOcEFIc0JudDhUVTRo?=
 =?utf-8?B?bkpwQ2RpeThPUzhseWU1bUNockJuVUYvRmlOcm5GcDBReElOam11MitMeldB?=
 =?utf-8?B?L1ZrYVYyakFSWFFka0VFa1FrYTZRT01ieGdWNElSRFpFQmswYnFxZjlXaXlx?=
 =?utf-8?Q?X66eyKHVDwgktIpOWBaEcsjQbLhmIXCYs+zHaDUNJw=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a384cda7-0e0d-4e90-2b33-08dd1ee3022e
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:37:30.2003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnwV8Z1OFNDFMx/rGllBpKVUVOmRD2c7ik12jv3sExHF+zyRKMn3TjsQujic1Qvb4lFvM3ZljLc4J6kVCd70FqPytwiHS5xl9kVLe6r49HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3445
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


Le 17/12/2024 à 15:54, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> On Tue, 17 Dec 2024 at 03:32, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     Adds the support of the hmac based on sha256.
>     This implementation is based on rfc2104.
>
>     Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>     ---
>      include/u-boot/sha256.h |  4 ++++
>      lib/mbedtls/sha256.c    | 15 +++++++++++++
>      lib/sha256.c            | 50
>     +++++++++++++++++++++++++++++++++++++++++
>      3 files changed, 69 insertions(+)
>
>     diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
>     index 44a9b528b48..99cf78e204c 100644
>     --- a/include/u-boot/sha256.h
>     +++ b/include/u-boot/sha256.h
>     @@ -45,4 +45,8 @@ void sha256_finish(sha256_context * ctx, uint8_t
>     digest[SHA256_SUM_LEN]);
>      void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>                     unsigned char *output, unsigned int chunk_sz);
>
>     +int sha256_hmac(const unsigned char *key, int keylen,
>     +               const unsigned char *input, unsigned int ilen,
>     +               unsigned char *output);
>     +
>      #endif /* _SHA256_H */
>     diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
>     index 2128e598834..7d456a82017 100644
>     --- a/lib/mbedtls/sha256.c
>     +++ b/lib/mbedtls/sha256.c
>     @@ -10,6 +10,8 @@
>      #endif /* USE_HOSTCC */
>      #include <u-boot/sha256.h>
>
>     +#include <mbedtls/md.h>
>     +
>      const u8 sha256_der_prefix[SHA256_DER_LEN] = {
>             0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
>             0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
>     @@ -33,3 +35,16 @@ void sha256_finish(sha256_context *ctx, uint8_t
>     digest[SHA256_SUM_LEN])
>             mbedtls_sha256_finish(ctx, digest);
>             mbedtls_sha256_free(ctx);
>      }
>     +
>     +int sha256_hmac(const unsigned char *key, int keylen,
>     +               const unsigned char *input, unsigned int ilen,
>     +               unsigned char *output)
>     +{
>     +       const mbedtls_md_info_t *md;
>     +
>     +       md = mbedtls_md_info_from_type(MBEDTLS_MD_SHA256);
>     +       if (!md)
>     +               return MBEDTLS_ERR_MD_FEATURE_UNAVAILABLE;
>     +
>     +       return mbedtls_md_hmac(md, key, keylen, input, ilen, output);
>     +}
>     diff --git a/lib/sha256.c b/lib/sha256.c
>     index 827bd9a872b..a18aec3928b 100644
>     --- a/lib/sha256.c
>     +++ b/lib/sha256.c
>     @@ -264,3 +264,53 @@ void sha256_finish(sha256_context * ctx,
>     uint8_t digest[32])
>             PUT_UINT32_BE(ctx->state[6], digest, 24);
>             PUT_UINT32_BE(ctx->state[7], digest, 28);
>      }
>     +
>     +int sha256_hmac(const unsigned char *key, int keylen,
>     +               const unsigned char *input, unsigned int ilen,
>     +               unsigned char *output)
>     +{
>     +       int i;
>     +       sha256_context ctx;
>     +       unsigned char keybuf[64];
>     +       unsigned char k_ipad[64];
>     +       unsigned char k_opad[64];
>     +       unsigned char tmpbuf[32];
>     +       int keybuf_len;
>     +
>     +       if (keylen > 64) {
>     +               sha256_starts(&ctx);
>     +               sha256_update(&ctx, key, keylen);
>     +               sha256_finish(&ctx, keybuf);
>     +
>     +               keybuf_len = 32;
>     +       } else {
>     +               memcpy(keybuf, key, keylen);
>     +               keybuf_len = keylen;
>
>
> All looks fine but keys shorter than 64 bytes are copied as is, 
> without explicit zero-padding, this might be an issue.


You're right, I have fixed that in v6.


>
>     +       }
>     +
>     +       memset(k_ipad, 0x36, 64);
>     +       memset(k_opad, 0x5C, 64);
>     +
>     +       for (i = 0; i < keybuf_len; i++) {
>     +               k_ipad[i] ^= keybuf[i];
>     +               k_opad[i] ^= keybuf[i];
>     +       }
>     +
>     +       sha256_starts(&ctx);
>     +       sha256_update(&ctx, k_ipad, sizeof(k_ipad));
>     +       sha256_update(&ctx, input, ilen);
>     +       sha256_finish(&ctx, tmpbuf);
>     +
>     +       sha256_starts(&ctx);
>     +       sha256_update(&ctx, k_opad, sizeof(k_opad));
>     +       sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
>     +       sha256_finish(&ctx, output);
>     +
>     +       memset(k_ipad, 0, sizeof(k_ipad));
>     +       memset(k_opad, 0, sizeof(k_opad));
>     +       memset(tmpbuf, 0, sizeof(tmpbuf));
>     +       memset(keybuf, 0, sizeof(keybuf));
>     +       memset(&ctx, 0, sizeof(sha256_context));
>     +
>     +       return 0;
>     +}
>     -- 
>     2.25.1
>
>
> Regards,
> Raymond


Regards,

Philippe

