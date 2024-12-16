Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE97E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 15:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0D008005B;
	Mon, 16 Dec 2024 16:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="hanNkz7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30DC6800D2; Mon, 16 Dec 2024 16:27:27 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E841D8003E
 for <u-boot+nodisclaimer@lists.denx.de>; Mon, 16 Dec 2024 16:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4LzIWu+AFVte9feEvxSmJbPTGtaNkUrBebdcEINi06A+g7jI3wABw8+RGfIF4ed6MoMnlDOw5OKKvU54zgq3pXBZ6A3Z9gtxb+/3VNox31V6n1QEDg/tnScA+hhAg9dysyu6+yB7nY1VQZW4fDpKFMlNfJkkVRIYd3nf4sXu91UoHOcJvefctz2CyPXDNy22wrc4XoYp4lJCn4/+vFHJvfHP/6ujyl2osFaIRA/wYb/wFE/22tY5VGRPRnDqu6i6jbB40nRWb+n405hByNDdX9Jd8t/JTntO9Ykt8TqLE8QWyNr8sNqHKr8d3hf3c+1bWZSFOQiiGN0p1EBDqgi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlNLDWqOvf7wnIgXq1o7rs+XadXrHw9HTxFnt1uv0Ao=;
 b=PUhVALLVaJhCyZQ5w5tVZwYLiO7jdoAF8chY826zBN2bvf5hs0gPMmxQ8JDkQQa0hMzE2rViXjs/q86LCQbh5RGMzC/OAbOEicb63vTMrocMNR6JkU3A3GmpoDs2tuR4p+cE9wXYRv1eK6zsufeGl5Lt3fsjGB+DDHb+KSiUohuzMlysluH1OiFbUZSjJS1BSCfPPIHb+AudR17Al8+Rz1trq+d58jw9v7f301SIafpZkebahY5qKYST4Ld6A9hrmIPc+y0l5+kp+aIdzNrs8LhyLlHPWTHSYC7/e0xLh6Dl//S7lAAZ0VSDHxn4NhSC0w2MPS/G/a0s3jrKEXf7Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlNLDWqOvf7wnIgXq1o7rs+XadXrHw9HTxFnt1uv0Ao=;
 b=hanNkz7QuyUMo6qsWloKd5dsyrm4fUMvsmFlbv5o7WcLwLIx8jurg0xP0hzLW1Y3DLMjkmRYvy+HB9IaPREVTF8Rbvy9peVL8bdShaqrjaSvxrs8CXQX1ijRSINACiOZPCV/9DF7wZgz2+kjGhaI6u1j7O6CgAi0lnyitM8Q21KDDpWHwotnIYdv1MZc6hoAoDZ/6/gs6Yfhk6YEBdUl0eRp6zxeQc+huUDUxpqfQ6rJqm+7baH2tJkWJ3xguysH4OGRcqlGNhwihUORirZUQb1Npj20hkuibZPvS8pQqFEM90ASHsgY1CBMVh+5uAFw/PD1Z9ichAgHawLLWMFB6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PASP264MB5122.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:43b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 15:27:17 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 15:27:16 +0000
Message-ID: <f87475ea-c174-4811-8c85-056e98971df3@softathome.com>
Date: Mon, 16 Dec 2024 16:27:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] lib: mbedtls: sha256: add support of key derivation
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
 <20241212133710.172404-8-philippe.reynes@softathome.com>
 <CAEfUkULeJipeyYGC1kvRQOubESupRt7ezG0a-Q3DZTmDR6rE-A@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkULeJipeyYGC1kvRQOubESupRt7ezG0a-Q3DZTmDR6rE-A@mail.gmail.com>
X-ClientProxiedBy: PA7P264CA0398.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39b::21) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PASP264MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: 94496ca1-4a67-4ebd-5178-08dd1de61fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzJ5RE5RaFdQWElnNTJBdFp0N1BRaEEwK2dzTWE2Sk9pSWZVbmtGSzNnbURs?=
 =?utf-8?B?VGhYSkZOS3Z4QjJxLzlaN1YzM2FMUmpGOUJYZUk3NG5NVUw1a25mNlYxNzFi?=
 =?utf-8?B?WEhvVWswYTAwZ1lOM29heGRZWWQvVDNoQ1pZME1LY0dBYU14V0ZJMEVsZHht?=
 =?utf-8?B?MmJjUjJ0dHJYaE02UDFuMnZyK2lUTlMrK1M1K2xUNDNyTzd0ak00MjFtb1RR?=
 =?utf-8?B?SFJROFQ3eGw4S3ZBRTFCVGZwL0VkTTlMWnBrM3ZrejNQRDhVTXViZ2ZSSnoz?=
 =?utf-8?B?blBYRlBFNjlYSUJGTlVUUmdpVHJzSGpjRFMwYWxLYmhxa1dHWGgxMGxrT1pm?=
 =?utf-8?B?VGMza2hKNmhxK3BzczdyeTVmWGlqR2FDV3dqcGdRTzJlbTRkOW1EYTZsM29w?=
 =?utf-8?B?SVBSNUdIcThySWx6Sk40R1hsSGZHNTRHNVR6VklXZUYrb283bGxiSnhSZGZ5?=
 =?utf-8?B?b00vUEZZRFBra21lcXNBdHVkS3d5UldzNldwZkZRc1lQQnFrVTdNRE1ROXc0?=
 =?utf-8?B?NFN5K2RjOUZrRkRJVUFiV1RXelYvaUZVcnVhZVhKSEtJZ1ZHU3haSE56WFBw?=
 =?utf-8?B?MVZkNldxOTd5ZUlPakVWQ3NuTHg3N2RrY0hwbXNVem82RTVhOVlBTmtKUlFy?=
 =?utf-8?B?R203QlpRdDdGY2VUeXlTajFmbzNyRlJlMGo4RlpDT0R3enEvcWZ5ekdGNzZn?=
 =?utf-8?B?dWlzNTVBMnU3L2lZWmhUOFFQQkd6Mm9OOE1XcGdPTjZHUHdaSStLQkFOTlh3?=
 =?utf-8?B?VXR1UkE2K3NHdytmUVJYcDd5MlFqS2ZhNXZSVDRCZk5pSU1QTUR6dXhWVGhL?=
 =?utf-8?B?a1ZyU0kwUXpqbHgvdmF0Um50cXBSUjZwN3FXb2l0UU9iQmNuTUt4cStzNFAx?=
 =?utf-8?B?WW9GRFI0VnFLWkROVWJnejVvMS9RQ0plaVQ3VUZLOWhwM3FDM1k4RXFsSjlP?=
 =?utf-8?B?VXlZeXo5dGMzY3lEVlNGQ29sbFc2bkgwZUJ3Smk3MEVrdElFdXRkaXZ3YU9T?=
 =?utf-8?B?T1l1NWhIRmZQWmUzR3FGZk01b2Z4bkdzUUZMZlJkYUJlYUpYaGd5d1RvYTlw?=
 =?utf-8?B?ZXRYaHkrMHhCQlUwb1dDYWhvdzlIckphaDJUOENXbUVLZ1NpQzNCSTNPYWRv?=
 =?utf-8?B?RVpxYU5DMXh0ZS85VUo2UmZySnNDOFc3NmpzVEJVTTZTaStHQlNrNVg0cGEw?=
 =?utf-8?B?TmdvUUxQNGdpb1B3REZyelVSYkwrNEx3cktBa2p6bjJHSjhMYThqc2FzQ1JX?=
 =?utf-8?B?Q3NDQ1B6SnNjTkRwMlpVNGtvMUhmR2dNNTlFWTRVREFld2R5MEY5WmhSRUow?=
 =?utf-8?B?RlIvL01rSjAyK05DVXZiZDA0SEwxK3VpUVJzOWRCcmpYYWpPNVhuR1BUZDNj?=
 =?utf-8?B?YkdzTW8ybW1PUmRRWlI5VXI4czNkeWtYMmdoTjJxbnNCeFVEYmx6THNsZVBY?=
 =?utf-8?B?eXliSUFseXNya0YvQ2dvU3NLM2F1OU5xR2VGeHUvYjRRNEpmaTUvamJLaHJJ?=
 =?utf-8?B?cFFlMXFrby9QY2ZsaW1TN3c2SzJZUmhPNVR5bVpMcHFLMWhSeSsvbmtsYnor?=
 =?utf-8?B?azBYTnpjR1JVbTVZTURqWTFWMVA5bGRIZXpsOFZsNnhYOGQ1cjFGanNKTW5K?=
 =?utf-8?B?cGRianZVdFJhbEdVSWl6ZFplRkF0b2t3THlmR25RY0RHN0ZUTjlPQ3MyTTNI?=
 =?utf-8?B?S2IrTlg5dkplYVhSeGt5MitRT3NFYnB5eTBwdFpmN3hoRExmN2dndzhnVW84?=
 =?utf-8?B?UHo3QWkzVDk4VVAzNEd4UWtpZ3gzLzkyZmF1UzlVdmtYWW9qd2lKOVdQRXQ0?=
 =?utf-8?B?aDIxaGorWWVmZFZrbWdwdWtHdjg5ZFZWNW9ib3lxcVJMRDU1WU9Eb3F1UUM0?=
 =?utf-8?Q?E+rPjzpPgjqY1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlVPTy8zOHMzZyswSFhwUzFQVWFycnJkaE5ab2NzQlY4UmY5RFN1a0xEcFBw?=
 =?utf-8?B?eU9BODNnZGxhOFF3S3o0QVhqNXRCcU51K3VTemJ5ck4xTzFuVWxvbUxTUGpO?=
 =?utf-8?B?VDNpVnBjQnJYS29PMTRoZFUvNy9OU2g5QVV4cEZXZTdRR1BuazIxeUNxQitr?=
 =?utf-8?B?SWIzSlhBYTB0US9WNE5ObkkwbzFJek5mZVdkTmU1VUxSYkdFVjZLVTd1L3FS?=
 =?utf-8?B?bFdoTkZ0ZEJRZENER0hlMmFvRkxTNDhxcmExbzU0YzhLZXo4OEt3b3I4TVZp?=
 =?utf-8?B?dktJT28wL1drbExIM1MvNml6RlFza1VRc3ZCRkdUdkY1YXhrcjJFTWlaak1u?=
 =?utf-8?B?dGNVTU1GLy9jZEIvejZtb1dDdFhRZngzQUFXOHJ5VXcwOW9PVmhuY0VoTjU1?=
 =?utf-8?B?MHNrTVFOblpYNFliZnJMazBQQ3RoTG9STFZsbEQyNkNHSWNnZFlDNmlUeUZm?=
 =?utf-8?B?YmErVk1ML1JrY0NEV2h0YWkvNFQrak81N2tkYmZZL25NeVM4V1FIQmpwU2Nr?=
 =?utf-8?B?QUpLSXJlTjJobU5Ub3hUZ3pJUlZxbGJVNDJ3MTRZMmE3OUxqRHBqSzRjdGZo?=
 =?utf-8?B?NHNmUm12VGF3V29PQXFwVHRxVjFGaE95QWhRQXl4emI0eTBRVW9EYjV6RS8v?=
 =?utf-8?B?elhwL3ZQVktyNy9QOWdqMDZxMzduRmVRT09oQmJkVFRRQmkyZzI1TTNRUmJy?=
 =?utf-8?B?WEVCVFNNNnhlbkZUcVBqQ0lJOUp4OWRNVXBCdDBPRHZ4Rm1jeTNCQVE3VVVJ?=
 =?utf-8?B?TVd6TUg5WkxydmZia2lWMWRjNUFqZWJSYmF1c29oWWRBbnJDYXJBMzRpVWJC?=
 =?utf-8?B?cHhGSHhtdDROVWZiQnJ0SkhzcHRxOVNlSEVVeXhVUE1qZzdBNmFYYUlBTjNt?=
 =?utf-8?B?aUR1TDNEc01qV1NrTnVBeUtGNERLc3dQcXZaMkpib0V4cldOU0pkeEdwUHBw?=
 =?utf-8?B?c2hYMjdSdWo2aGt2SnRieVhQVC9vRnQ0N0dsZjMxQUp3dWRFbTh2L1NpbTBC?=
 =?utf-8?B?Yi9RSkpWdE9LcTN0cVVwcFNrSEpnajZYbGpnRlo0V25XYkEzYXNxOHJnVVp6?=
 =?utf-8?B?UW9kbXVPTmRuYWFuSTNjQVQ3UzVFSFo1eVRoNUhTSmVtcDdXbHlxM3pzeUd1?=
 =?utf-8?B?aHFDZEd3ZFd1WjJZaGFIUEUyV0VqR0VSTHFrWTZiRnI1U2l5TzluSmVZSzY2?=
 =?utf-8?B?MjluVGJoMlZzc0lKME9tcUlEVVZ6Y3NYMTRmOVRDTXZXcU44UlBrZFVDQno1?=
 =?utf-8?B?eDl6TWZYWWszdU5CNEFWSm5JWG1jeXZuc3kzZGtxSU1GNWVGWklSYWxCUXJU?=
 =?utf-8?B?YlNyR2hONkNFWkNpWThSRWRteWx3RkhrRVpoY0poUHdFSTN4Q05ZbkdldG5O?=
 =?utf-8?B?ckF3RGRlbW1zOExkOFZiTWw2RDhKMnBYZHoybEJ6cnNKekFqTkIzazcvTEtB?=
 =?utf-8?B?eDlpK0lxVi9YQUFtUXNCWkhKT2tQS0N5SldmcEFoNTZvbWlnaHpVZEtJeEJT?=
 =?utf-8?B?TTJERlRlK09xLzFHWTNBczcyRVZQZ08zVm9zYUNTMUdSNzZmaThpNndCK1Ns?=
 =?utf-8?B?dU9CNEFoay9JTHk2TXc2NVVickFraDhhMVUzaHBaYVUycGl0THpnZkZqUVdr?=
 =?utf-8?B?TXZLYzZqWExHRTVZZkkzbWFxZWY5NCtkUmNMRkhWRnQ1azRwY3VoNEp5cVFV?=
 =?utf-8?B?UlhSNWFIeWZFTTNsdDU1VzhlYlkzdzluQjhaT05yMFNWSzd0R0FVaWVzdTlu?=
 =?utf-8?B?bllHa3Fpa2VDM08venBJQldkV1lnTFhQdWZyRFlsZXl6QjFveHJyR3VRUVJl?=
 =?utf-8?B?aTRDRks1a1FBS3F1NXNIcVZzVEpUZ3VlekkwbjBmL1JOdGUrWk5JUmJmeWlU?=
 =?utf-8?B?Q2VOc1BQc1hkR2RBbE5qcDVyWTZiQ0VQWWkzRGlRVmRrUTl3MDhzam1xT1E2?=
 =?utf-8?B?UUJ4VENTYVZMT0pFbEVFOUNCQ0NseW1semo3ZzdMUCs5SE5jaWJkQjFYRkNU?=
 =?utf-8?B?cWJpRjduY2JIQlpsZ0NqMXBUMnhOaXovVlh3eFFLS2hWWk92bUZvWXQ3Y1hz?=
 =?utf-8?B?S2djVkZuTEQrOWRBWnY0N3pKMFdJdWVqekRCVDNoV3BTVFU2Z0szZXVmdW0v?=
 =?utf-8?B?c1VaK0tpRk80dmJWd2libE1vajJhbFpaQXF6QytjZzZrVCsvdnpsQjZJcTFT?=
 =?utf-8?B?dkRuREI4bG1WVnRBYmhPZTZobW02c0llSVZxL1R2NUFXUU44MkV5TG53SFZ0?=
 =?utf-8?Q?/qRZWkxdh44oVgGNpIpm7lDzu4NPwfAGdTFIZjFWEo=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94496ca1-4a67-4ebd-5178-08dd1de61fa1
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 15:27:16.8752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQtIS28L5MwgLU2609Gt9ke4F5/fUn2K5auyLDmaIYRYV/hJoLn13jI3dZbj7Tw6spLhDRy9+TLydBEUkYr+2vtQynqVD6uOPINE/BGU3yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5122
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


Le 13/12/2024 à 17:58, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> On Thu, 12 Dec 2024 at 08:37, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     Adds the support of key derivation using the scheme hkdf.
>     This scheme is defined in rfc5869.
>
>     Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>     ---
>      include/u-boot/sha256.h | 20 ++++++++++++++++++++
>      lib/mbedtls/sha256.c    | 22 ++++++++++++++++++++++
>      2 files changed, 42 insertions(+)
>
>     diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
>     index 2f12275b703..f21173305a6 100644
>     --- a/include/u-boot/sha256.h
>     +++ b/include/u-boot/sha256.h
>     @@ -1,6 +1,8 @@
>      #ifndef _SHA256_H
>      #define _SHA256_H
>
>     +#include <linux/compiler_attributes.h>
>     +#include <linux/errno.h>
>      #include <linux/kconfig.h>
>      #include <linux/types.h>
>
>     @@ -49,4 +51,22 @@ void sha256_hmac(const unsigned char *key, int
>     keylen,
>                      const unsigned char *input, unsigned int ilen,
>                      unsigned char *output);
>
>     +#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
>     +int sha256_hkdf(const unsigned char *salt, int saltlen,
>     +               const unsigned char *ikm, int ikmlen,
>     +               const unsigned char *info, int infolen,
>     +               unsigned char *output, int outputlen);
>     +#else
>     +static inline int sha256_hkdf(const unsigned char __always_unused
>     *salt,
>     +                             int __always_unused saltlen,
>     +                             const unsigned char __always_unused
>     *ikm,
>     +                             int __always_unused ikmlen,
>     +                             const unsigned char __always_unused
>     *info,
>     +                             int __always_unused infolen,
>     +                             unsigned char __always_unused *output,
>     +                             int __always_unused outputlen) {
>     +       return -EOPNOTSUPP;
>     +}
>     +#endif
>     +
>      #endif /* _SHA256_H */
>     diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
>     index 2128e598834..b8bc43b612e 100644
>     --- a/lib/mbedtls/sha256.c
>     +++ b/lib/mbedtls/sha256.c
>     @@ -10,6 +10,11 @@
>      #endif /* USE_HOSTCC */
>      #include <u-boot/sha256.h>
>
>     +#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
>     +#include <mbedtls/md.h>
>     +#include <mbedtls/hkdf.h>
>     +#endif
>     +
>      const u8 sha256_der_prefix[SHA256_DER_LEN] = {
>             0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
>             0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
>     @@ -33,3 +38,20 @@ void sha256_finish(sha256_context *ctx, uint8_t
>     digest[SHA256_SUM_LEN])
>             mbedtls_sha256_finish(ctx, digest);
>             mbedtls_sha256_free(ctx);
>      }
>     +
>     +#if CONFIG_IS_ENABLED(HKDF_MBEDTLS)
>     +int sha256_hkdf(const unsigned char *salt, int saltlen,
>     +               const unsigned char *ikm, int ikmlen,
>     +               const unsigned char *info, int infolen,
>     +               unsigned char *output, int outputlen)
>     +{
>     +       const mbedtls_md_info_t *md;
>     +
>     +       md = mbedtls_md_info_from_type(MBEDTLS_MD_SHA256);
>
>
> Please check if the return is not NULL.


I have added check in v5


>
>     +
>     +       return mbedtls_hkdf(md, salt, saltlen,
>     +                           ikm, ikmlen,
>     +                           info, infolen,
>     +                           output, outputlen);
>     +}
>     +#endif
>     -- 
>     2.25.1
>
>
> Regards,
> Raymond


Regards,
Philippe
