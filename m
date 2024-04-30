Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221C5C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 04:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 285FE8816A;
	Tue, 30 Apr 2024 06:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=marvell.com header.i=@marvell.com header.b="XWhqd5r1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF84A887BC; Tue, 30 Apr 2024 06:26:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5A5988087
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rminnikanti@marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TGH6IA005626;
 Mon, 29 Apr 2024 21:25:54 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xt43b0mwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 21:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/aUHgi3qfQXPuv71b74+mdo588eh5v1vdWmIzTEkol9z6M5d+h3w9qWWunOSeuzBcfjWl8aJf2dMqIcpmB7RVGwPSunZTB7rf5jyWeqTclVNNWGk5VhS46oLaiV4LSDJrM65zXx7yUunZo75a4pT8b6u/otFYihiShdzhijJmTNVpzqmqBiw/KLO5Dq72mVPW/kc2j91FohMSum65XQB0iqALzQQ6aPHw5IzpdxhOLHXcZRYhrMd6L5yHw7kk5CrZujyYfVhvhcW+9F34C3sg7p2kFcYAKD0MX/15FmfRQV2ypyxAfANm+s7IhqCtiMp/O1Qf5fVt1jEhID1ld14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clkafuMYYoCWSEayQsqzY3EZj7cYAgLN+6TeGLa566o=;
 b=dTl2tdzZnXVCzZzWE8dwyfWwHOLNTHEda4zgqSFZ/dPV5JZwFDJR9GSe3vLxoZGkG0204COMM8wuMp8ZJEO4Q3b85n7yZs/9scR5cUQF0FcJEtwpKmp2u7WVrVKsZf9WLR77TNIarkceQ7vfPOP33iS/RR/mClGlQz+3KdNfdFU08jrwxt2p0WJUnv44K3dx+FMLtBtbTlO0L7eorszT2Um4g3psSyVdhHNtwMrefagyNinHldJDci2Mom4/R7WCOOxXvT6GQZjAGGTIUtAkgDv9rR7asegBBLtibUEOXv1P/4yeWvTPRg5Q9ijha/yJcM81apdsMOt6pwQMwzptTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clkafuMYYoCWSEayQsqzY3EZj7cYAgLN+6TeGLa566o=;
 b=XWhqd5r1U6/aaz8TRFwPxMgaKmtE25g9s2Yw/q291nq90F96FJSGUmYl1/1d915n3ewNPGI2QSOJN9BPNRDrJw+7fXAHZuLQCD22s40GQQfAK0milzF0AglgDbOiIqXLyDRtAN3COgjfGPglZK0GdFOJRLiYjwOQFwPTkWt0tN8=
Received: from CO6PR18MB4451.namprd18.prod.outlook.com (2603:10b6:303:138::12)
 by SN4PR18MB4952.namprd18.prod.outlook.com (2603:10b6:806:218::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 04:25:23 +0000
Received: from CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::c0ef:b62a:5356:65cc]) by CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::c0ef:b62a:5356:65cc%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 04:25:23 +0000
Message-ID: <7f949d87-585b-8dd8-bd8b-d29766da4ad6@marvell.com>
Date: Mon, 29 Apr 2024 21:25:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [EXTERNAL] Re: [PATCH] mtd: nand: pxa3xx: Incorrect bitflip
 return on page read
Content-Language: en-US
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Chris Packham <judge.packham@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, hs@denx.de, trini@konsulko.com, sr@denx.de
References: <ea0422cd-a8e6-3c36-f551-a0142893301b@marvell.com>
 <CAFOYHZCAKtYiy=3X=u2+oqv3Wx8=W-vtV=+akbo+e479hPoX7A@mail.gmail.com>
 <CAOf5uwm+Am-J6-yiCy0=N=FrcVpYGubtUfW9JT6YN3dp4-zutQ@mail.gmail.com>
From: Ravi Minnikanti <rminnikanti@marvell.com>
In-Reply-To: <CAOf5uwm+Am-J6-yiCy0=N=FrcVpYGubtUfW9JT6YN3dp4-zutQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::23) To CO6PR18MB4451.namprd18.prod.outlook.com
 (2603:10b6:303:138::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR18MB4451:EE_|SN4PR18MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f8814a-54da-47ae-5220-08dc68cd8d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0YzanNpcnhOM2owV3d2bzNkTHNhSFV4VjNVSDJSMG9MemJIS3VoUWFGMGJw?=
 =?utf-8?B?S0krb0J1U0NmNGNZVmtjekVwRWFIa1ZDQWF0QjJFYmFUU05YSnJmZTNVV1gx?=
 =?utf-8?B?VERZd3JxeUE4K2JhY05kWVN0cW9mNHloOThGQS9HMFM0L0pvTGJHQkEvL2Mz?=
 =?utf-8?B?NVV3R0M5ZHZZMHhHR3ZXUFYwU3owUVA0cTVoSDMyR2F0VVQzWENTakhPMStC?=
 =?utf-8?B?eFp5bmtiZzlQanIxc0JqZzZrclVHcjJ4UDVYRjFiS3VhNXJZaTdvMm16QlAw?=
 =?utf-8?B?TldvV3hrT0M5UzNVL2psb3UrN25ZVmUzWk5tYUJSbmxQZ21JczNxRjNOaUxw?=
 =?utf-8?B?anAvWUtHRnUzdzVDVThSQmN4amJEcEJ1bnRsTWhUZDQ1WitiME5yVVdOb2NG?=
 =?utf-8?B?QjZLUHRIQzJycDlQL3NjTURHR3lxcDhQTUNxR1JqMnEyTnFSNURyaEloemFO?=
 =?utf-8?B?V0Q1Ums5YncrUFROdjJzdVdEd0JMV1Bqaklvc3Q5VUhTazFJeWtMTmRwMFh5?=
 =?utf-8?B?U3A2eHEzUEVmSndGRHhBRTN2QmtEcGRpUzdMMHRjaFVlRm1XNDBLTjZ0L2xI?=
 =?utf-8?B?T3lpcVc1dmYzazMxN3lrSXRxOFFSbVBVNTJXODZRZlh0K1Z0aDRkbmJzYnVL?=
 =?utf-8?B?NXI5S1JWZngxUmpReDRlU3lRTk51dWIzOStOanJGcHFzRy9PV05Td2pCYytX?=
 =?utf-8?B?TkJRUy9JV2tKZXdiRzRKeVNMcElaNTFqcWJLTHNLeFNRYzJrNWlITTFJMHlu?=
 =?utf-8?B?cC94RE5IV1diR3RCb1c4RWN3eWlPYmZnSE5VSFFrVU1yRGYwU1Y1dFl6NUJ5?=
 =?utf-8?B?OW5neDJBcllETFpIYkZzZGQyU0dIcVlzOW5FSkFUdlFwNXNXNm1Nczhja2ZL?=
 =?utf-8?B?d2hMd1NQcVBWK2IvOUEvRE40cDY4Y2tJR2x1ajF5RXB6bVp6dnFpelRiQ25N?=
 =?utf-8?B?SGtnVzFQTjNPUFpTc1BCSzZXbm5RR0NYaDdRYjRpR2RLY1lWd1FJbmFYUTRn?=
 =?utf-8?B?N3NaWmRqWlpDZFU3M3hySnZvTmgzYUxvT0M2WVFVTDNtWStTQkdKVU5EZDB2?=
 =?utf-8?B?VDdiaTBhaG1SZ1dHWEFremdGZDI3RXNva08rY3l0ZUJuWHprWG8wZklVZXZx?=
 =?utf-8?B?T2hQeVozQTNDMWorOWVJODIrdi9ITTBHV2VCRDdjL1ZFMzJiT2x3SWtQVWg0?=
 =?utf-8?B?Q2J6N2hOQk9ndHlXa2tleFpXRExWV3NMb2dBQmNwRVMrWVpBWTUrejdhK2c3?=
 =?utf-8?B?NzBPYXRrSU9ZRXNzOU9SSlZYTTErZmNwTDhjdXVVY3IxbE5QOTRGU0xCZkt2?=
 =?utf-8?B?SzhoeGYwY3VOaCtJcU1jQjA3VGdjVVkwbGFLcDZCb2RNOTVIRVhJYlQ0QW5x?=
 =?utf-8?B?bXcrajR1eWhCUGNWRERQVW02SzRHODlmSldBSjRhby9JZWNwN1FMRDhFdHRs?=
 =?utf-8?B?WUxUc2ZyRzBjcEY1M21WemJJSGdZbVo3L1JpQU5qNEZjK25oRjFpVUNjMzg1?=
 =?utf-8?B?dWVsNGZKUGJ2YitycnBKaGhQLytLTVRrS0NGeVR0dTB4UXlYUEVCSURWQ1hv?=
 =?utf-8?B?SVlzcWlGQXZwMHYzU01QWmJpR1JIYy91OTZCOCtGcGk4L1BPTnUycldDb2hY?=
 =?utf-8?B?WGlDVHVBc3FQWU14bDZTWGFocGpsdEcxWlVzbkoxQklPVGlEZ2JybDUxU0d0?=
 =?utf-8?B?dm1oOGVwbWVac3BKWmVZSXlDTUFuakxFejQzRVNqT0kwNEtOalp5K1FBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4451.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0VaOGRMcnhiTitXK3RSSGswQlZSc3gzVWNEOXR2a0U1VUQyd0JnYVJpK2hC?=
 =?utf-8?B?cTByNExZelJQSWhOSFArT3JnRXY3OXlZTmo5cnMxYXdxcU5senRwL0Z3dFNX?=
 =?utf-8?B?WS9zSExNNm1IdERkamxQR0tRU0NML29qRndyT3prVFFNbzZIVzFqVDYrcjNs?=
 =?utf-8?B?L2hLK0Y1MSs1bnZha0FLWlNPVjgrVHk5M1FhUnF1YUE0WndyajhZU215MHgw?=
 =?utf-8?B?bUV6cXRleGZnZkdGUlJ6dkZIQXh4VGJ5VFMvckEvaDFJTnRwUG1SV0xXRjU5?=
 =?utf-8?B?QUp4NFNOeWkyNmVRdzk5RHpqMGZ6dllsajM0UngySTNNN2pxTU55UVFYUm1B?=
 =?utf-8?B?bitsUHdyUHdLeDUxdmkzZ0hqOGpHUi9BbmtQRTdGSldaV0tkTXVpQWRMQ2J6?=
 =?utf-8?B?akNJQVczY1VXeDBib1k3VTdGNGRKWkFFR1M1WkExMHFoMUhtWHhtS3FUNjNR?=
 =?utf-8?B?MkF5K3UzZlVKVW5LRTZRRkZGQTdqWDk4RWhLMnNzUXJDUCtmSE8vUktVZitl?=
 =?utf-8?B?ZHE1UDBkZVA1eU5Jaklvc0dFS1V5czJjK2VjSldzWUY2ckZOY0pEdVFlV1d0?=
 =?utf-8?B?bUQvaFFFaGw0c3hTcVdpRnh1WW4vTzNSN3ZQTUVvQWZLRmxzMlRDR29YOXlp?=
 =?utf-8?B?d2dPTWlqRDFlQUI0bTRjK0NLdG82ZTJnK0JSMkRMOEhNZWsycEY5dUR2Vmda?=
 =?utf-8?B?WjZNaFdJRnBieHB1dkREU3d2VVcwK2JZZituUmtIeG05WVBOVit5VmQ0aXpI?=
 =?utf-8?B?RVRndk9weWFOUVY0RDlBZVlWdGNzd3g4R1lXNkZhREszSk1mOThNeTNGTTJV?=
 =?utf-8?B?SE91MFZoMnhZT3JKSDc1WUh4c2EvdGZRNmRRbnBMV2JIY2JnMFR5OC9abTJJ?=
 =?utf-8?B?bmVHVkFVTDE0aVMvTzh2T3NzRE1QdkJJRkRMYTZ2Yk12Mng1a1V2dmZReCtQ?=
 =?utf-8?B?UEtQMUFmNlFIaU5EQms4Q2VpUXFleDQweE9YbksxL0FtUmw2UjZNWXpacWJi?=
 =?utf-8?B?RmNVV3pFSlN6c0g5ck45UE5sYjlJS1c3VFpSWjRlSzNmcDhrRUs2T1VBMU5P?=
 =?utf-8?B?bUxLRlJhWmVOZ0xnWDZ5a2pqTjloREV6T3FVR2RNNlBIUFJPdDFERzhGZnlm?=
 =?utf-8?B?ZEhDbXI0bERSL2dCTGFaMjhpMGQ5dFRtVTJtRXY1d0Y4bkRpWWlrZ1VUNGpu?=
 =?utf-8?B?dkdJVG40bEVQMmdpdXd3ZTYrZkUxcFIrTTlCV1o2Vk5MUEUxajVOUXN6WEdj?=
 =?utf-8?B?K08wYmFLVEJZVGpLd3I2WSs2N3ZYL3Y4Y1ZjdWpIWXhNb3BEdGhDMEptZkYv?=
 =?utf-8?B?NElPbmgwWGY1blA4ZVpvMkNodEFIZFhKQW9wL2Y4OEd3U2djOG8xQnQ1K3Q4?=
 =?utf-8?B?K1ZGZS80dmJ4T2JvRUxNNjdVQWlRVWRGR3AxczBldVJJSFFDWWxvaXpQNENU?=
 =?utf-8?B?MXZxdHpBMEtweEdiRElTdXVFTW01eXNYNVJhQTYwOTFRMEpsTkwrTjVXZ1BT?=
 =?utf-8?B?RG9jZ1Fmc2psV2tSNGt5ejZKYzF5RVI3K2V3ZlA3YVNyTDRwR3NqbGdhU3B6?=
 =?utf-8?B?OTZ4WGt6cTcvc2h4MDBOelhEeDZ2Q0VKM0VDT04zdm1WQmdUVXdaVFRmS3Vy?=
 =?utf-8?B?WXd5amExRElrbjAyZWpqREFHNkpsWEZsemhNSWZ3T0hBMkZBQUU4UmVPdE03?=
 =?utf-8?B?K1JRL2FiV1BmQ3FtZHZza0RKc29ZNlU1bEVDemJPTkdGbitxMWVnT01kc3hx?=
 =?utf-8?B?VWVNWmZwT1BaaVhQS0VvNm03WnJTKzU2dFplWmdCZjJmaUsvaGN5alVYaTd4?=
 =?utf-8?B?NHB5L29oaXNQVGtRSCtucm5rbUtlSkU3MHd4bjFKZzVzc1NCdmVTQWtDT2VH?=
 =?utf-8?B?OFRhby9ObUlJa0RjT2dYdk9WaDdYVFVROEVMNG1kZlVzUFZ1RVJabkpCTGFF?=
 =?utf-8?B?UWxqVGFNWkk0NXc0QTVoQlZEcVpwb2VUUGxOZk4yUXhOcFUweGl5WVNOaUhp?=
 =?utf-8?B?bGNsaDZpZjhIa0JjU1pwUnNlQXROZEhOYWY2akNmMytZN01rYWhIVU50a0dW?=
 =?utf-8?B?dUlKOXZ5dHRJbWJlMzRlYjVBUFhSZVdyQVMrZllJdnJZeEJYNHdCMHJ4aUR3?=
 =?utf-8?B?UHYxZWtJR09kOGVOalQvUkdUcjVkUXd3MHlnM2FzUGlhZURoRTRBelpibkNh?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f8814a-54da-47ae-5220-08dc68cd8d6b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4451.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 04:25:23.0874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJC0+TVzU7ZXFiI+/4lMw4f1zshhvPMKQE0sDNHcDJ2YJlIywBvEK93aOTxfsrbd+L+ye0gHc4AwICM0h8KfsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR18MB4952
X-Proofpoint-ORIG-GUID: irxKilph7o0Eo8_OydExmcxHScA-pEcs
X-Proofpoint-GUID: irxKilph7o0Eo8_OydExmcxHScA-pEcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_22,2024-04-29_01,2023-05-22_02
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

On 4/29/24 09:59, Michael Nazzareno Trimarchi wrote:

> ----------------------------------------------------------------------
> On Mon, Apr 29, 2024 at 6:22 PM Chris Packham <judge.packham@gmail.com> wrote:
>>
>> On Sun, Apr 28, 2024 at 4:15 AM Ravi Minnikanti <rminnikanti@marvell.com> wrote:
>>>
>>> Once a page is read with higher bitflips all subsequent reads
>>> are returning the same bitflip value even though they have none.
>>> max_bitflip variable is not being reset to 0 across page reads.
>>>
>>> This is causing problems like incorrectly
>>> marking erase blocks bad by UBI and causing read failures.
>>>
>>> Verified the change with both MTD reads and UBI.
>>> This change is inline with other NFC drivers.
>>>
>>> Sample error log where a block is marked bad incorrectly:
>>>
>>> ubi0: fixable bit-flip detected at PEB 125
>>> ubi0: run torture test for PEB 125
>>> ubi0: fixable bit-flip detected at PEB 125
>>> ubi0 error: torture_peb: read problems on freshly erased PEB 125,
>>> must be bad
>>> ubi0 error: erase_worker: failed to erase PEB 125, error -5
>>> ubi0: mark PEB 125 as bad
>>>
>>> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
>>
>> Looks good to me
>>
>> Reviewed-by: Chris Packham <judge.packham@gmail.com>
>>
>>> ---
>>>  drivers/mtd/nand/raw/pxa3xx_nand.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3xx_nand.c
>>> index 1d9a6d107b..d2a4faad56 100644
>>> --- a/drivers/mtd/nand/raw/pxa3xx_nand.c
>>> +++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
>>> @@ -800,6 +800,11 @@ static void prepare_start_command(struct pxa3xx_nand_info *info, int command)
>>>         info->ecc_err_cnt       = 0;
>>>         info->ndcb3             = 0;
>>>         info->need_wait         = 0;
>>> +       /*
>>> +        * Reset max_bitflips to zero. Once command is complete,
>>> +        * max_bitflips for this READ is returned in ecc.read_page()
>>> +        */
>>> +       info->max_bitflips      = 0;
>>>
> 
> Why this should not be put to 0 in read_page instead on prepare_start_command?
> 
> Michael
>

ecc.read_page is invoked after the read command execution.
First chip->cmdfunc is executed with NAND_CMD_READ0 and then ecc.read_page is invoked
to read the page from buffer. So, by the time read_page is invoked, info->max_bitflips
must already have the bit flip value.

Thanks, Ravi.

>>>         switch (command) {
>>>         case NAND_CMD_READ0:
>>> --
>>> 2.17.1
> 

