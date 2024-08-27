Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CAFC5472E
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 09:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F66A884DB;
	Tue, 27 Aug 2024 11:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="s5VGBJQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B17CB887F3; Tue, 27 Aug 2024 11:50:20 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F3180245
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 11:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLQOQN5+aNMaNl7kZvZ4JQVVs9c8Fwr+Ss0tosT98VqTGTrK8EEIA6uAn16b/YljG3umnEjHwp5uBElYPHUJLApE13PlUR1VbjDvFU0jpTMPGkLJdXolJnHVNrgOn0gwR3bDOEOHtLmWrDvPH50qqI3kJ2B6dK8hsLyDxd0/wU1Q9o9jheWmLmkqfLmIP05cHf+nKLqCD7YXAPzvTbKDL01Tsw2XooF5wNoYE3U1hTncLT5a32lMtuXkZR2b88Xt1qKcX6+zEmQbBkwCskQW9u1EPFbQNhyHDM7atnzEYEf134legQx91isFHgORZGtCvQ8UhH4oMleTgDdvRAEorw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApquqgR7Hd0tvfbHD5PQAA46LywYxJ5zCb7nuU1t048=;
 b=tUefCEdd3q1+VwSnRrmYHKNS9/umqsEAWNaY2ytsLYdek4Ye2N84/KxtpTWREm8fMOwkXuYGoqCAZpDCh29vPvK2BH0mkmQg6IQtFs4QQ71ZDmELc/vGKI5IrEeB4hCfbZ95nD8eMscao+3XAEyUCSWhOCXqHhimhr298+cJQh0qP9M/ZDPZv1iCaYSaUALjBtXSW/tSssaObm770uMrTIRNLJ8qXyNHwECabxZNiEs4TJHTmPPQ7BQ00trOE8x4DQuAnb8Ba7fkWXzBQVfiiDg8EghiBCg+9Mdtxtia5o/eTX7qoI9jfZX/rY/Jy7rvzLsse5LNz1jX/bvb2Xm6Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApquqgR7Hd0tvfbHD5PQAA46LywYxJ5zCb7nuU1t048=;
 b=s5VGBJQXNow9bwQ30RXk/9SI3A6g/A6aGLB7/90dARzEFwj/DI3B8EB+Ohu0YtJymoPBw9g9Ml16FNrwPyjD46H6cBc4LcC2Ltprs6KRmCf1H2hIIzRfuR6/zuVZkC9+LJ2iVs4eSeqi+nbiIjgkwtBrYDoXb4i7Sf74gfVMndcUTXEKxK0VzxUFrFuK93a2t/UPlrcYwy5EJSTZL0JJQWPIdeS65ygHdUCgTesS5J2YZ7OFtcgmNSY9k6HOXLKCELsSYO4u7Oyq8EoG73BkA3xO5ZSejve2LfrcLAitvpV39isSB0Z9Mc6LZHkremv/O7zbX4rpsfO9LIWO8WFqOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5804.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 27 Aug
 2024 09:35:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 09:35:33 +0000
Message-ID: <f61a8c74-9838-481e-aa1e-09fcc07f044e@siemens.com>
Date: Tue, 27 Aug 2024 11:35:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: OF_UPSTREAM vs. additional dtbs
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
 <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
 <4576b818-9732-45ff-a4ab-b98fc0ecf4c9@siemens.com>
 <CAFA6WYNXgJkCX9-aoL5FGchAHGdV+ikTt4+pTJP-jZ_UJG8E6Q@mail.gmail.com>
 <87a9fe3e-5d9a-41e8-a8b2-4368cb727a65@siemens.com>
 <CAFA6WYMGyMAB=m-hkxs87PyHszcbQUk6+0_G0n+0-Yk8NeRXQQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFA6WYMGyMAB=m-hkxs87PyHszcbQUk6+0_G0n+0-Yk8NeRXQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:610:e7::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: deda3707-6fed-4b53-c292-08dcc67b9920
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bG1icDFkUU9TMnNodWhNQU04M2dmcGNBQ2tadTIwYXVFM1VGWnBoOEhqR3FJ?=
 =?utf-8?B?QWJWcS9kdWpGNktvTCtVazQ4NFpBYWVUWjlIUUwwczQ4NEtGZU1pa0dxUyt1?=
 =?utf-8?B?cXNKVC9yc3pNMjBjMXBURXZidjJxQTd4cmRVVXdqR2xrd2w3T29Xa0xERzBB?=
 =?utf-8?B?bWx0by9tSXRibTNTeWErb3JqYkJSa1EvUWZ4YjZSY1JuQjc1dlBYaUg5QStS?=
 =?utf-8?B?OFlVSitaTFlTRnhyYUFOUGt6c3ZjY3BNQXUzSkNvQVZhdThxZlVNN0Mrd1Vs?=
 =?utf-8?B?eldBenpXS0ZJdjVIRVdaWkxSZGlYZ1hUY2pvUnpyTGNZRFFLcDA3Kzc5VTVX?=
 =?utf-8?B?NUhaUGVuMXNzTDFBMXB3YTcxc0d3UVRTcTNjRThtK2gwK0IvMXQ2Y09wZzdn?=
 =?utf-8?B?UFE2b3VNSWNYUlhEcTA0Z011WUxtMnoxOG4zVGxaVUhUUDI1K0VoUnVRdC9U?=
 =?utf-8?B?QnZIVFhCdVpBaGFHZVFNSzJGOHQ0YnpmOXo2S1ZqZExEemJHNVorM3pPYjZa?=
 =?utf-8?B?RDhIdnJYd2hKOEhLYTZxTjc4bWNsNUUyMGtHcXAvOUozQ0x0eHVHYkRSV1I2?=
 =?utf-8?B?eit4QzZ4K0FoaW5QWlpDV0crMzBIWHRNL3VObVpYY3lXcURTb0VPa3c5ajJi?=
 =?utf-8?B?T0VmRjZOZHoyaVdhUVMrSmRKRkxyb1RZRTNXODNjUWpDT0I4UjN3Zlp0dEhm?=
 =?utf-8?B?RmtQWkp3RlpQbW44TnI3cVZZdU16NzZuaU42ZXpFRlBWbWlWR1d5VmhmNjFk?=
 =?utf-8?B?a1kvRlR0UXU0UCs1emRDa0M0Ti9yVnFXZzYwRWxxbFJZSDJvVkdHbEtLVnB2?=
 =?utf-8?B?QVp1MlFQWkMxYWhHMDBhdkVSU0c3WTY1bU5UL29QYTZINjY3TlVlQmpEYlo4?=
 =?utf-8?B?T21ReTlrekt0TUlyOVpybnByUkhIYUhKeFVJdm9VM3FjOHM3MUNjRzVxK0pv?=
 =?utf-8?B?VTNSSjFGSkd5RzVmOC9Od1JCcDRSODdCSHNjZm5EOU1EZHBHaWdFSmdQQjFo?=
 =?utf-8?B?bVg2b0NZMTRWa241VjE5T2F1WHdhOHk2U1picW9wdlNHRjlhYzhxVGZNRS82?=
 =?utf-8?B?cCtJQUxudUFXalR3cGN4NTVtZEs0OUJDbWdET1lqcHpOa21BT2JTRHpQeHo5?=
 =?utf-8?B?N0NzOC9JMWxZTlhUc2Y4ZlJ5SStKUitEOUtXSERiWkc3b1FKS25KcTdJWmYz?=
 =?utf-8?B?QXZ4NVRqckt5eE9IUzlObFYrOEcwSTlRK1A0NGtzUS9IWDdRbGIzZzdiRmJT?=
 =?utf-8?B?VlNoZEMvM0lIOFgra2VZTHBnTEdSUEJCS25FTUtVK3JtaVkraVB2STlaSmhr?=
 =?utf-8?B?MGlzdTVsZU5sWFJMcDJYVFltQ1hGVUpXU0VwNHd0OEdJVm5sVG1MaW1SZTNv?=
 =?utf-8?B?YWhyR3hPTE9ENjk3dHlHKzRIK1ZOeWhPdzUxNjQ0LytWcW8wSVJmSVE3K0VY?=
 =?utf-8?B?Y1BJa3FYRG9Vb3kydHJJeWVEYjMxM0dEOFVycjJINS9xZ2lQS05HSUVTTTFv?=
 =?utf-8?B?b2RmNmR0U015YmdZa2R4SVB4VUF2bXY1L3VpRVMvdmxIWW9ISi9oS3JlQ05B?=
 =?utf-8?B?ZUtQcmRURnV1VlJwbGN2SERJZHdMd3pmeWZIYU1uMkJ5UGJkTldaOXI5MnRs?=
 =?utf-8?B?cjFGVGNpTVc4RDkvdjl4S0R0alRrUU1WblIwMG9FV1JFNDlPb3hqSEZZMWZM?=
 =?utf-8?B?azNHZnBRYzh3dFBrOEplTi9LeDM5Ymh0V2h6bTVLYU55Nm9oc2FWWk9nZUo5?=
 =?utf-8?B?R1FMYnYwV2l0MFFBdFY3U1NSQUVJblNuZkdXb3dzRnJHbVlZaU9UcUtTQ3lZ?=
 =?utf-8?B?dDZ3QmtYdWJod3ZoemttZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGsxRzFVZEtFUG51aDhLMmRMbC81YjZqUW5MZG5rQnR4SVFLUElhdXFJd2hp?=
 =?utf-8?B?ZUVBaTZHMDhoQlJjUCtOR3NXa244Vno2Rkt0c2lkZDRCSFNQUlRLaWVjMGJz?=
 =?utf-8?B?RjJWbi9kTGJWYm9PZGJnaERIREJQc2NqS2Q1S2ZrbFI1MlBxRFhLVFpCQmty?=
 =?utf-8?B?Q2JxVGNYbVBZbjFNVy94Qkh5emJhUzZZUCthSmlHVmlsR1VPMFZKUFJmWEdj?=
 =?utf-8?B?VU44bXBOL0Nib3RVU2RMTXBxbXlON0h3M0ZQM2xlL012ck1QaHJDVHJiWmF5?=
 =?utf-8?B?a1diLzJWcGxiZG1TU0ViV3lSeU1DYW5xeUVjQVEwMXE3NEI5dDRwYU9DNHd0?=
 =?utf-8?B?V0tmWTZUUjlLWmNZQlBtRlBNL3FRUkpuVUlZdDhXQUhPSDF5QWQ0TkxNMzVN?=
 =?utf-8?B?U0daVkhPcCszZ2ZqTTRmajhvUVFkdGFjcFJEczNYTW0zMGZ4azJOcE1yTit3?=
 =?utf-8?B?eVlFVHgyMmFFZHhHdVRxQXlEWWRXV2pNTFVqckt4SDVJSjJvQlpLQittNjVD?=
 =?utf-8?B?bnU4clBUelFWMGxrWTFnMDdsaHI0Qzk0c3l0N2I1elBVbThzM21uUHdQVUFO?=
 =?utf-8?B?Z2JBNytmcUtGN0Rldm0rYXVtQ2taU0srS0RaQkRseVlTbUFraG1HQnZyYmJS?=
 =?utf-8?B?QUEzUlBkV0ZkTkdOOXV1ZHN1TGY3cDVVNlk5OWgrcXdkSTJveUJUY1gwU2cr?=
 =?utf-8?B?aVpMeGFXc2tHZEdpK0xlZTR5a2FXYm1MRUN6LytUaW9ZektwTWJkWmdJSnN2?=
 =?utf-8?B?QlJaMWV0eTd2aVRxeTgzeXEyNHRlTEVleHFHVVNCM0Y0em9WNkluNFRzNnZB?=
 =?utf-8?B?Nk1MQzZqVGVPdDZDYXp5cDdjK25uNjBjUG1XbFQ4SHg2aGZCWkJXRmR0Zmw2?=
 =?utf-8?B?bnZicmNGQm0ySUpUUUI2NFFNb3BKcWpNSHF5dlYyQ0JZMFZsdUJCOHpEZWJ0?=
 =?utf-8?B?YWtid1dvUEkrb0wrMS9yKzhKVVoxRkhvM3MzbmtvZkhIb0dZNU9sYXBKR1pk?=
 =?utf-8?B?dGNhakk3enJUTklWTDVjTDcyTzRHSU5NdnN1a0dQZERDR25wWGlmait4VGRC?=
 =?utf-8?B?R1VWSGUxU2E2SkYxRkdKV3pFdW03TktjM05tOFA2bGlwTmFOQU5Ra0gxd1BW?=
 =?utf-8?B?SHhZMkU5RXExWnRPYVFHZzBsdHk5Q2hBZW5oeUZVVHNtM0VUMHpWREJ3SFV4?=
 =?utf-8?B?NVZveGJpRDFnZStlQmx5L0pLZC82SmR4VTdtOWVSWi9vc2RHQVArMXM1MGp3?=
 =?utf-8?B?eGx3aTJpd0FBT01QWG4xVW9CZmNuMGxHQ09BQ1FZdmVwcWNDeDJicWxGZmox?=
 =?utf-8?B?WE1KWjI1dHRJSStBb00zeXg4U1doVEtMZVh3dGRLUnZFNlIzOTFOVzN0TnFP?=
 =?utf-8?B?NzRZNFR5YVhBSWtRTWY0MzRGU3RScXVGSks3UFk4Smc1MEF1RjVRalpaRVZs?=
 =?utf-8?B?aGZ0YnlHa2xISHJkZkxnMUFJS0MzbHdkYVlITEVNZkZTZi9LdFNER3hIekRl?=
 =?utf-8?B?cDNuZVNkRzBqTjhGOG5lUnhkY2pEdjM2MzIwaUErYnVNL2RwTC9IUjZQMXox?=
 =?utf-8?B?TmlOTHBnWDUxTnVoV1VnUTA2RExJT243VEsxQnI2U2wybCtMTmJwSWxISzJP?=
 =?utf-8?B?U295VDhsUGYwSjR1OVI4T0Z6MTZyUDc3WXg0ZlQzMGdEaloyeVoycWp4Z1V3?=
 =?utf-8?B?ZGRBVG5pcGhLMSthVkdIeStweUFpQ3FXRk5qRjN4RGlIdEZzMDZZdWNhb0dy?=
 =?utf-8?B?OGVxZ3VjeW9yRTYzNWY1aFNQWmRRb1R6aFJ6TS9PcGd3SlJFQ1hlZkpGMzNo?=
 =?utf-8?B?d01rbEZ5Wm5YSnN6T2RWSkR2K3FJSE9vN1o3K0pTRlYzTENMaStpN1hNNmpt?=
 =?utf-8?B?RTZVVHJSMG9FelMyUzBGdXlKOThDczF3blcvSTJEN1VZdzdFTCsrOFU1TVRF?=
 =?utf-8?B?cDI5bmpKeSt0Yi9CWVBZOVhLNEZucFQ2dFFNQlJhTmhRc1hkb0EycDlnRHVw?=
 =?utf-8?B?bUxIZGhHWjN1RFkvbEZsT3IyQmJnbjJnZ0RxVFZzZlMzMWE5MDNEcGpqUDRQ?=
 =?utf-8?B?SDFHNG1pZk9sbnp2aDhZSUFKc0NOc0hqREwvYVFDOEVRdVJzV25lbVZZb0dz?=
 =?utf-8?B?RWNVdnp2VDBaRW9yQ0Y3WEdVWWZIajdZYnp3dVVwMWEzMVY1M2p3RnRDMTdr?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deda3707-6fed-4b53-c292-08dcc67b9920
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:35:33.3974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vIlk6mO/vKpiWMlyrkMi5YxW8kx8tB9vCcsuEx9Zr+fQWtzTtS2fVZukDstLLh3SAzEMHzOeCUd8UcS8MQiXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5804
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

On 27.08.24 09:13, Sumit Garg wrote:
> On Mon, 26 Aug 2024 at 18:02, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 26.08.24 09:10, Sumit Garg wrote:
>>> On Mon, 26 Aug 2024 at 12:19, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 26.08.24 08:44, Sumit Garg wrote:
>>>>> Hi,
>>>>>
>>>>> On Wed, 14 Aug 2024 at 22:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>
>>>>>> On 14.08.24 11:41, Jan Kiszka wrote:
>>>>>>> On 13.08.24 14:52, Nishanth Menon wrote:
>>>>>>>> On 11:16-20240813, Jan Kiszka wrote:
>>>>>>>>> Hi all,
>>>>>>>>>
>>>>>>>>> I'm trying to migrate the TI AM65x IOT2050 boards to OF_UPSTREAM but I'm
>>>>>>>>> facing issues because I need to still build the u-boot-only overlays. It
>>>>>>>>> is also a bit weird (but works) having to specify
>>>>>>>>>
>>>>>>>>> CONFIG_SPL_OF_LIST="../../../../arch/arm/dts/k3-am65-iot2050-spl"
>>>>>>>>>
>>>>>>>
>>>>>>> Actually, this does NOT work: I just had a long morning debugging SPL
>>>>>>> which no longer started because it picked the non-filtered dtb. The
>>>>>>> filtered one ended up in a folder outside of the u-boot sources because
>>>>>>> of all those ../ and hard-wiring to dts/upstream.
>>>>>>>
>>>>>>>>> for our spl dtb.
>>>>>>>>>
>>>>>>>>> Are there means to still build certain dtb[o] files in arch/<arch>/dts?
>>>>>>>>> I'm a bit lost in the Makefile forest.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Sumit: Any suggestions?
>>>>>>>>
>>>>>
>>>>> Apologies for the delayed reply. I was a bit busy with other high
>>>>> priority stuff.
>>>>>
>>>>>>>
>>>>>>> I would really like to hear some better proposals than my local
>>>>>>> workarounds to far. They don't converge although I already patched some
>>>>>>> core Makefile (overlays are building now).
>>>>>>>
>>>>>>
>>>>>> OK, I side-stepped the spl issue by using one of our variant DTBs for
>>>>>> spl as well - happens to work.
>>>>>
>>>>> That's good to know.
>>>>>
>>>>>>
>>>>>> For the overlays, I need to add
>>>>>>
>>>>>> --- a/scripts/Makefile.dts
>>>>>> +++ b/scripts/Makefile.dts
>>>>>> @@ -1,5 +1,7 @@
>>>>>>  # SPDX-License-Identifier: GPL-2.0+
>>>>>>
>>>>>> +include $(srctree)/config.mk
>>>>>> +
>>>>>>  dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
>>>>>>
>>>>>>  ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
>>>>>>
>>>>>>
>>>>>> in order to then be able to do
>>>>>>
>>>>>> --- a/board/siemens/iot2050/config.mk
>>>>>> +++ b/board/siemens/iot2050/config.mk
>>>>>> @@ -5,4 +5,12 @@
>>>>>>  # Authors:
>>>>>>  #   Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> +ifneq ($(CONFIG_SPL_BUILD),y)
>>>>>> +dtbo-list = \
>>>>>> +       k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay \
>>>>>> +       k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay
>>>>>> +
>>>>>> +dtb-y += $(patsubst %,../../../../arch/arm/dts/%.dtbo,$(dtbo-list))
>>>>>> +endif
>>>>>> +
>>>>>>  flash.bin: all
>>>>>>
>>>>>>
>>>>>> Does that make sense?
>>>>>
>>>>> A switch to OF_UPSTREAM means that we build all the DT artifacts from
>>>>> dts/upstream/src/ directory with the only exception that we include
>>>>> U-Boot specific overrides via *-u-boot.dtsi from arch/<arch>/dts. In
>>>>> case of overlays, is there any reason for IOT2050 board overlays not
>>>>> being pushed into Linux kernel repo? AFAIU, overlays are also
>>>>> describing puggable hardware so they shouldn't be referred to as
>>>>> "u-boot-only" overlays.
>>>>
>>>> We are using the overlay to massage the DT presented to the OS based on
>>>> firmware configuration.
>>>
>>> Agree and more than that I prefer the firmware to own the overall DT
>>> and present that to the OS.
>>>
>>>> So, those two belong to the firmware logically,
>>>> but - with some disclaimers, we could also try to upstream them.
>>>
>>> For historical reasons, Linux kernel source tree has become the
>>> defacto upstream repo for DT sources. So it's better to contribute
>>> there and sync back in U-Boot.
>>
>> Will do ASAP, hope to hit at least 6.12 then.
>>
>> Still, this will delay our next patches for U-Boot by many months. Also
>> for that reason, a plan B for U-Boot local DTs should remain, no
>> left-or-right policy.
> 
> Yeah, the U-Boot local DTs should be used until the board is fully
> supported by the dts/upstream directory.
> 

This is not what I mean and won't help: Given the longer pipeline, it
should remain possible to carry also local changes after switching to
OF_UPSTREAM and while waiting for upstreaming to be done - if ever. We
are missing middle ground.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

