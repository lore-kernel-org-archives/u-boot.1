Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AE4C44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 11:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CBE28397D;
	Thu, 22 Jan 2026 12:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mobileye.com header.i=@mobileye.com header.b="SmYq5MZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C5E1839DF; Thu, 22 Jan 2026 12:33:42 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 937EA80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 12:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mobileye.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Vladimir.Kondratiev@mobileye.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unjpISLKsH5VTwRRfAXGyTFdEE2MuTcNzOxeVj5rburDayz6GSYtFBfG41EV5+1cDKDNTaqKy7i0K1lznwwavqhXo9dY+sb7EjjAudE9kwght5DhOMEfqXtDygGNVu0ebQvmnqhrok+EPLsjD8pK8EQd6K2eJvxZimBU0e7DODOrJpin03zn47xSIXRetrlxrh9BonTYEJ5HW3TmF47Yx2XFvuEBLteZPd52mMjV+GAY4bwPTAeSACdFnWjAe0oVgT8ntfhPPkcfFYw/7mz87HyP0u1YFIpYZmKNP2Yovc+4LlPRZjRIm4HoZ/Uywr8PrUlfwuRWHNOjexruPpEVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeVPxHqHw2z4ckFsOhl7Ic/6G5GWrD5B1AVIGbpolmc=;
 b=rzUtxOxlO/VSwzz5tLS+KyUTOZupEVZ5vzMsskgmqoKrl/KBfLmU54QRU1rVHcnbpjnRR4by/K0INKwAfN7xXmYTT0pifUjK7iHwt+flObtOROCLBPcH86woot7bZF+ZZiXLHaTAQHGfGHznjAAkTdIDz+Lo94XgQTflndvNMgnQtTxwZ+TbegTgcv1b//MkQAvoR9Glaa4iuNekhpJNtRuUuoG61bcpvxnr3JC7T62QadzrfMaV6J8koFsMUvvYsnvGs3HUIxo8fp8Unp3IxBDNmzqP3EpifwrR+wTLGrbd1GKAjMq7Dz3U6wSjF4+eG6HrrDsrwz6HCuPCnrxxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeVPxHqHw2z4ckFsOhl7Ic/6G5GWrD5B1AVIGbpolmc=;
 b=SmYq5MZufIDt/vFYG02nxYFGYlMc13zU22Nn35zFqvKKgIl9KwAkJAdceBnkJV84E9vj17Z1HtRTmpuwOQKf+I1zEtWRD9PTl/woNrLqfbOzppu5IKw+N/R1U3ikjT97paYD/nLOx36f44IRbP6bCdXxbhsmGp4iSbDsGqTnBt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
Received: from AS2PR09MB6296.eurprd09.prod.outlook.com (2603:10a6:20b:578::5)
 by DB5PR09MB8746.eurprd09.prod.outlook.com (2603:10a6:10:654::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Thu, 22 Jan
 2026 11:33:36 +0000
Received: from AS2PR09MB6296.eurprd09.prod.outlook.com
 ([fe80::ef0b:e667:faa1:bae0]) by AS2PR09MB6296.eurprd09.prod.outlook.com
 ([fe80::ef0b:e667:faa1:bae0%5]) with mapi id 15.20.9520.003; Thu, 22 Jan 2026
 11:33:36 +0000
Message-ID: <f684b72c-bf53-4b21-a45d-cd6b4e2c1218@mobileye.com>
Date: Thu, 22 Jan 2026 13:33:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] opensbi options from FIT image?
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: afd@ti.com, ycliang@andestech.com, alpernebiyasak@gmail.com,
 anup@brainfault.org, linux@yadro.com, mr.nuke.me@gmail.com,
 n.shubin@yadro.com, sjg@chromium.org, u-boot@lists.denx.de
References: <f65aa26d-6c98-4b08-a94a-1e56f6871d1e@mobileye.com>
 <0e10d672c1cc068a1d68b5dc237b594a0a07d227.camel@maquefel.me>
Content-Language: en-US
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
In-Reply-To: <0e10d672c1cc068a1d68b5dc237b594a0a07d227.camel@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To AS2PR09MB6296.eurprd09.prod.outlook.com
 (2603:10a6:20b:578::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR09MB6296:EE_|DB5PR09MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac6fc08-eef2-48fc-62e4-08de59aa14e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGt2Z0YvenN1a2RKcE5TRktTK2UxWnVnYTVnUkNTR2MrY1V0bXhrVEJzb2xS?=
 =?utf-8?B?U2hZRjJaUmc0bjAzT1hiUGVhTC8wc0F4cFBweHJhTU9oY2pyWEZkaFFUSVM5?=
 =?utf-8?B?dzQwZDZJMkJwL0UvdkN4TFFRVitqaEo1ZVAwaGp5SFlna2NMS0RNUDFDaGRv?=
 =?utf-8?B?bVRwWlJwSDNZZFV5a045SDdCOTVPRlZJVHJZR3UzMmlqMXR5b1l0Uk1GTzli?=
 =?utf-8?B?NlNOSHpTVmZoVVZoREJUamtmZnM2cEZhbW1NdjJEWXNNcTFZVlpvR3pHSXpD?=
 =?utf-8?B?bEFRRG5BejRjQlI1UmZQY1kwR3crcCtPdlQzc3UvSVVrTGJ4cVpZK2NjOEVE?=
 =?utf-8?B?dG5LaGVWUEFLeitmNkE0anc3WGt3NmlEUUhiSWl0QnYxR2lncVozYUQ2VXAv?=
 =?utf-8?B?WER0S3dSYVl1OXFDQVNiSWNHN3FJRlJSQnhnUGRpNTVHYkdtaE9URm8yZyti?=
 =?utf-8?B?Z0crS0tyOWhMSDh5a2NNUEdVcklsWFFSWXlVMGlwV29qLzEyNm52MGJYZHVa?=
 =?utf-8?B?R0Q4OWJIaGNzRjRhSDhkNmp6N1p2TkI0bkV3SGhBellvcE5MS2h4MERuNW9H?=
 =?utf-8?B?Vnk2dWt0cnF1YjVqaEd4UTh3SW9CWDlhZVhaVkJwVDVZc012YUVMUFBQMDJK?=
 =?utf-8?B?bTNHNHFKalo1UUc0WUU3UFBJcTgzMTFRbGNwMExNdUNqcWdGdXdPUGtIc1hk?=
 =?utf-8?B?KytvSk52cGpVVmhqKzhpVkYxRUVxM1JwYWNGVDhGNmRwcnl1b0VkRXkwemI5?=
 =?utf-8?B?b1lOQ0g4ZVNzcXR6YkhEN3FmSXlldlAvT3NuVEVIVkFkdTFKN2s5QVpXMDRO?=
 =?utf-8?B?Qy9iK2Nia3FxV3dCQXplcjdBT3dQSk1VYUJVYlZadEYvaTVCY0U5Skltc3c1?=
 =?utf-8?B?ekcyRW1PcVlIQ09LNXNxd21ndHZpaEl2ZlA1RWQ0LzRUazBwb1dqUzVoTVZV?=
 =?utf-8?B?dHRzdDFMdkVXRlNNNlBWWnVoQlhzazF1dVI4TjJGbHZyK3pmKzBGand1NU43?=
 =?utf-8?B?c09QNkoyWlBRaU56OHlmRG1CYmRtTlVxTGRqeGdBQVdLQkpqZVFJZ2kxblIx?=
 =?utf-8?B?TmoxRGx6Zk5xaW53eWJsTlVQT1dvUHI2dE1sZ2M5SEg0WUQ3ZWZRWTVqQmtO?=
 =?utf-8?B?UHZtZnhVVFltTVNyTTZ3VE0veHkrN2xYRklGWTZuTWlLV1FrQlRnRHFTakha?=
 =?utf-8?B?OVYxWXYrK3RPaUpGKytzTHhHd1RJOTMvUGo3MGVlL3d3VEFjSk8rM3pIaE4z?=
 =?utf-8?B?UUVpSXVYbVdhVXVsTW1DUnJXeisycHRvaENQZHBKS1VJbWUxVURYdTJlbVAr?=
 =?utf-8?B?cVduMVdRSUJ0WU4vcnhOY1U5L2pVcXBFK1pBaEsxR0M5ZFZkMndFak9SbFht?=
 =?utf-8?B?c2VhWFd5YWFrbUoza0UzaFZNeGJEanBOeTZVOVgyaUtSS3BiUGhUNDlXMEVR?=
 =?utf-8?B?amVRTDlSWmQ4REk2SHU0bElWT0dwancvWlZtU3c2K1BJQTdUbDRTVEpqUElL?=
 =?utf-8?B?WGd4ZFdtUXVpVHBsdlVaT3l6RzBieFE2N3dQQU1CSVlOaE1TckRhTHRjTkV0?=
 =?utf-8?B?bml4VDNEdDRhKzFMOG5GeXFKeGV4ZGJXaGJYSTdkeGNzcjFqKytzR1JObG5l?=
 =?utf-8?B?U3N6RXc5dktWWmU4MmdNYVBYRVIybnZGdXpieWxpbDlwVTFlQnVybW85SlAv?=
 =?utf-8?B?M3JDeXFNY2o3Q0tqUlZDdGpYL2hIQlFob0RLWWJKZzdsK2JwUEFJdFZoTlBH?=
 =?utf-8?B?R0pIR3k1SnA2NWxHZXdtazN0cGtXK0VYSzBieDZOeUpJRUJkRHlOWXBQQkRz?=
 =?utf-8?B?RytVSVZnRGtjVUFaY1podE4zZFJjdlN0MDF6Y2s2MDQ1WWdtQ1hmM1c2SklF?=
 =?utf-8?B?OXhSdWVQWDA5ZVhqREVIYzlVY0VBd3owZmduSGVTRDFGSWk1dHBqRWhRMk9J?=
 =?utf-8?B?elFHc3pPMjV6QmlEeUpBU0JnbVNrTkdDdjU2V3JjMFpPRXB6bWlUUm1TbHZZ?=
 =?utf-8?B?aXNUdllUS3gzVzBFKy9mNStWTDlNeU1ocTR6allyTWJmOVdnMCtUYytDMS9G?=
 =?utf-8?Q?lVWba9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR09MB6296.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alVYVzkyR0NTLzV5RTZLYi9YUHluSGYrODg2eUFwWi9FeUFQb0NtS0JqTEoz?=
 =?utf-8?B?dW1CbGxLb1FicGVEYi9vNTBnU2pYMklsNm8yRnZMUm11ZXlxZU5sRDMyc2M4?=
 =?utf-8?B?emMyOTZLbVBYWEE5N0NJaDRoVUVKRnB6SGhzZkgyOXJHWEpiTGlGMFhpVUlp?=
 =?utf-8?B?UEhBOGs2WHRHR3ZlK1R1V05FRXlYUWpFd0t6L0FFQTgrRlNCeUtJc2lkVVls?=
 =?utf-8?B?Z01jSEI2WjlIcUNFR0JZUHZHaFF4RXBvUG1QMU5veVVUNmFUYjV1ZkJ3RkFi?=
 =?utf-8?B?RTdVSVJ0ZlNrTVlKbHdKRkRGQ2JjdGVJNUd1c0h5cXlLdC9NV1NLWmNRV0Jz?=
 =?utf-8?B?WHdQL3l4UithODdhcnVCdzlpbk1ZNnFyTjI2eUVQaDZxcTdCSnZJQll3dHF2?=
 =?utf-8?B?UjFSRWJMcEpVanFpMzZJRkl6MERGMWJjT2dhbHpGQlhxcGNBNkN4YlNoRDM0?=
 =?utf-8?B?eUZHQ1ZsYWlvK295R3U5ZGJRcGcrVDZtK00vLzJJUGk0ZUwrSmdKRkxEdVQy?=
 =?utf-8?B?MDBYbThva3VhbURRcktlWFZoemh1bHRiWngyOEw3SCtwMlVySjkwWklISWhT?=
 =?utf-8?B?S2YxaDZJSzJPWjgzSzMrUVJTNTF0ZlJHSmU1dVZGR2xDT0pxN20va1pyeTJw?=
 =?utf-8?B?T1VncFpITWMrbGxJUFpKZHlkUXowTFBCblgxa2VMYnVCdUNPTjF2SVM0YUpT?=
 =?utf-8?B?U3Z0Y2ZFZWJTNE4vV0NxelMrdm1CVVdvTnBPNG5ySVN0bTZ2K3d3OGdSTGps?=
 =?utf-8?B?bmQ0aXJsbFRIVzVMUkFBeXVHL1pyQm0zVkM5anBSL0cyV1FLRHVzNTc0R2hT?=
 =?utf-8?B?YnRWK1dQVVJVZlkyUTErdTZWcnhCS2RLakQ3WEsrTGpWSXdRbzhRQ1hFeEdL?=
 =?utf-8?B?ZFM2TXVCWWtPeWZHR2wrWkFvMHJ4ZmFDM3YrVmZsRVVQT2VQOFh4a0NBcVYw?=
 =?utf-8?B?bzFXUjI2L2tuamVOOXcrNTV3a1UwcjZqYTdmT0NYOUtzSC9zTi9PL2dvRmxk?=
 =?utf-8?B?clpXdVhCdGZiRGxPZ2w4VGdPSmZGdmU5V1ZtNWM4bHVJcUhuenRoMFpES1Ji?=
 =?utf-8?B?YUZwRm9XQTNlWmhZUjJQaVBKaENRWjZNeUZJbWxWb21OajZtRlMyNE9ZVFY4?=
 =?utf-8?B?Z21EUE5aOHpmdzFoYTlpVmxqZHAyQk5JQnNXcFRPLzFiSzl0STRDVGdMbThE?=
 =?utf-8?B?bzdaSnozTFBTU1UveFVUbGo2eFRuNDArYTNGMW8rOXdZdG9PYXBiWHhmeDM4?=
 =?utf-8?B?cG5Wam9iKy9PMzZuc0tNKzBMTks4SU9WeVFkd0Z1T3h0bzVJeldyLy9TZTNi?=
 =?utf-8?B?UzZWVVlmbU9tYi9ib2tRMkhNd3I3MCtSQXYxTVRUQmZheU1RWXhIcDNnakYx?=
 =?utf-8?B?ZUYxTEtxZzFVQ3U0WVJnKzlEQUwvVk5qYlI2a0djMG9YWUZCN2pJRVdndnpl?=
 =?utf-8?B?cGppUlVLKzNxZkhSeFNEQjg1TVFHZ09MaEJEMnBRNFhyZm1YWWlGWnZXckYv?=
 =?utf-8?B?YkJpbFFpclRhc2FWM0k5Ykx5ZjA3YTB3a1pvTU50TnF2UWtyUUtFU1VnMS9L?=
 =?utf-8?B?MTArMEdTSzRkYklSTnhteWFiMWRYeEg4SFhoN2VvQk81eWk1V3hNSDVPd0oz?=
 =?utf-8?B?N2RSUVEzS1NVZGdiMjdBTmRKbUdhRTROQkFySys5S1RvV2Q0T2dqbUJzcmo4?=
 =?utf-8?B?NmNPdThMTXFVblVBaUpkeXBjSzl0STVFd0t4RFg1dW9TTW9kZ3VKVEdJOGtP?=
 =?utf-8?B?Qjc0a1B4RmErdXNJTlJSN2x3T3U0WHFSOCs0RFBZMHFDcWJTakhiVHhnRk5h?=
 =?utf-8?B?YnBDZmZEUUd2ZGRTL2NPdmd3QU56S0pCYjFvWHFuUzBQdytjL0Iwd2F2VXVx?=
 =?utf-8?B?U0IrYi90UGJQN0NVS3UrMFdBNnFmd3pvZGdGNHNlcnhaM1loOG1YdUZCdzJi?=
 =?utf-8?B?TFhQUDBORmMrY2VINVRXdHBDNHpyUEVrT3A3bXpCTEc5cFFIS2pHYTR6YVZy?=
 =?utf-8?B?MGwyaXdyNkNBOG5DL3hFTDZyZlgxeUdPYTZzbEF3TUpjNUJPZkVBd2lvMkxm?=
 =?utf-8?B?dzNHaG5PUWxtNHFMNmpYRC9BbFNqNTlvRUxJaklpY2F0OU1qSE55b0RFVEx3?=
 =?utf-8?B?RXJRUVNyQWZXM1lCYW1Ua2lYRVFieVMxYUN3QVJwRDUzUGMvWmlRMUg4NWRB?=
 =?utf-8?B?a05jbHBXamo2L0FEM0dNa1puUWo4emIwVE9vaHUwU0tobE5Gb09IbVFZZGpL?=
 =?utf-8?B?dmVaUUl6Smp6aVdSZit0Z3JXc3FHeDhuS2VNK3hQV0tpQTU3N3g2b01JOVYr?=
 =?utf-8?B?MlVPY0kzRjY1Sm5RaHZDQW1NOWVGYWZKZEVQTEhSNGdNTEVFQW0rdz09?=
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac6fc08-eef2-48fc-62e4-08de59aa14e6
X-MS-Exchange-CrossTenant-AuthSource: AS2PR09MB6296.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 11:33:36.4867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoMk/40bJdOYHk98TyA0lyaSmsDbOFq48YiRJ/v4xfaYI0rbMIyMFEH+wCUcUrq/KBiVDpbfjrunoMGC/8ttdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR09MB8746
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

On 1/22/26 11:43, Nikita Shubin wrote:
> EXTERNAL EMAIL: Do not click any links or open any attachments unless you trust the sender and know the content is safe.
> 
> Hello Vladimir!
> 
> Thank you for sharing this!
> 
> On Wed, 2026-01-21 at 17:21 +0200, Vladimir Kondratiev wrote:
>> Hi all,
>>
>> After commit aa0eda17cf98 ("spl: opensbi: convert scratch options to
>> config") it is possible
>> to specify options for the opensbi, as in struct fw_dynamic_info
>> "options", in config file.
>> It is better than hard coded value but still, it is fixed at the
>> compile time.
>>
>> Can we have this options set at image load time? This would help to
>> enable, for example,
>> opensbi debug prints at the runtime. I see an option to do so in FIT
>> image, by adding
>> property like "opensbi_options" to the opensbi image node or to the
>> configuration node.
>>
>> While bootloader usually flashed on some raw partition and it is not
>> that easy to
>> recompile and re-flash it for every run, OS FIT image can be stored
>> on the partition
>> formatted with some filesystem so changing FIT image is easy. Also,
>> if it is only
>> matter of changing .its file and re-run "mkimage", whole process of
>> changing opensbi
>> options became easy.
> 
> Generally, I like the idea. However, there are some issues we need to
> consider... See below.
> 
>>
>> I see even more value in this for u-boot proper, if we teach it to
>> run in M-mode, so
>> for developer boot sequence can be
>>
>> PBL -> u-boot SPL -> u-boot -> opensbi -> linux
> 
> Not this, but:
> 
> PBL (M-Mode) -> u-boot SPL (M-Mode) -> OpenSBI (M-Mode) -> u-boot
> Proper (S-Mode) -> linux (S-Mode)
> 
> OpenSBI is earlier in chain than U-boot Proper, so additional options
> can be passed only via U-Boot SPL.
> 
I know this is what we have now; but I really mean

PBL (M-Mode) -> u-boot SPL (M-Mode) -> u-boot proper (M-Mode) -> 
opensbi (M-Mode) -> linux (S-Mode)

For this, need to support u-boot proper in M-mode. This way it is more
valuable for development. Point is, opebSBI need DTB used by Linux,
it makes modification for this DTB. With S-mode u-boot, one can load only
linux kernel and initrd, opensbi and FDT loaded before.

I want to be able to load all components, that's why I want M-mode u-boot.
Anyway, this is a different discussion

>>
>> where u-boot will enable network and load FIT image from TFTP; then
>> changing opensbi flags
>> will be matter of seconds
>>
>> Examples, proposed modification marked with "==>":
>>
>> for opensbi image node:
>>
>> opensbi {
>>
>>        	description = "OpenSBI fw_dynamic Firmware";
>>
>>        	data        = /incbin/("fw_dynamic.bin");
>>
>> 	type        = "firmware";
>>
>>        	arch        = "riscv";
>>
>>        	os          = "opensbi";
>> ==>	opensbi_options = 
>> <2>; // SBI_SCRATCH_DEBUG_PRINTS
> 
> "opensbi-options" looks more like Device Tree to me. Also if we refer
> type as "firmware" may be naming it "firmware-options" is more
> convenient.

firmware-options looks fine, good idea.

> 
>>         compression = "none";
>>
>> 	load        = <0x8 0x00100000>;
>>
>>        	entry       = <0x8 0x00100000>;
>>
>> };
>>
>>
>> for configuration node:
>>
>> config-1 {
>>
>> 	description = "config-description";
>>
>> 	kernel = "linux";
>>
>> 	firmware     = "opensbi";
>>
>> ==>	opensbi_options = <2>; // SBI_SCRATCH_DEBUG_PRINTS
> 
> Same here "firmware-options".
> 
> If you are using it in three places what is supposed priority ?
> 
> Recently similar issue was solved by Alexander Sverdlin for linux
> bootargs btw:
> 
> https://patchew.org/linux/11af73e05bad75e4ef49067515e3214f6d944b3d.camel@gmail.com/
> 
> So order can be SPL_OPENSBI_SCRATCH_OPTIONS -> opensbi node -> config
> node.
> 

Agree. Then, I will prepare patch doing this

>> 	ramdisk     = "initrd";
>>
>> 	fdt = "fdt-1";
>>
>> 	loadables = "linux", "initrd";
>>
>> };
>>
>>
>> Comments?
>>
>> Thanks, Vladimir

