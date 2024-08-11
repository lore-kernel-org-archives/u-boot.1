Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D75C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 18:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B688852E;
	Sun, 11 Aug 2024 20:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=marvell.com header.i=@marvell.com header.b="BRwaU+bA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F7298837D; Sun, 11 Aug 2024 20:44:29 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90F38845A
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 20:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rminnikanti@marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47BIFZ4k018377;
 Sun, 11 Aug 2024 11:44:21 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40xqkys2p3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 11 Aug 2024 11:44:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQTY6qGKJfQ/SA/74EUwNZbfL6VHmoZJRav+YBiVpQomZlOQCiSkLKHqj30yWh99+9HDpouIUtvJP6WMy66WqN1GzfXJP2xv0PaurMX5sFC5aqxB4Sf5EG4QRhQK0GLVZCjYtW81DcMWG5aOM5kvOHugs+1FQoMGzQqhAuHhw3mLHquHuq7zEpBmjEKgzH4h8zrl4fFSqw0fXT89bEhRHuGOLDmUpXZwxMP4fYZ5ApZl9auONQZp/pifGsFyXV0wDmTaFMD8LzVNjqyyhW6tkB1BWY3Aztp2ewEC8WVftfh3NnKLgHzNKnIJZu0wY6ZH6c4I0dHghvz4fjqsZV5uPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCSQO/sJfhcGKpOqp0F1vbkHupZaqX8Iu2O/ViojH+c=;
 b=LO4t6VBCuVUsiqTRCFG3z2dmxyE4pAZH9j3Ft4q3ki8L973HTkSAm0Q/s269vRGokneK5f6HFoIoeMNPfCfU864rKy9LIhGm/kY5yfWk2pzRKRR6jVCIswErSRy0YXZnDHk7w+OehqJjePgqlfv0dL/R8ZHptWS551+XbH9z1qwfkQwK5t7mYgN0ilWt4+R9SnfRuxob8BRMvBX/wxU9rK/KxAl3svO4IGPg7hrFR/j4LbEms/xfb7H3SFiOeOkirRL/1F4uQ+da+9WVJqC+wpuBNvgFmctzOJUBUqq2kxseK+qXQjc+gssCVH3JWM2zS41Mo0NWN+zxlwiIZnLvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCSQO/sJfhcGKpOqp0F1vbkHupZaqX8Iu2O/ViojH+c=;
 b=BRwaU+bAX/W1bnOTkVEtPGATO3VRkUNvzzps80hGGusdAafa/+zN0ZgWLPUmMrK5VwDogjXFVLT2Ji5Cp1VwLl2UW9Lw4zmLsC5Ua14f8Uui9zOKlhpYKKsF5zB/6qkAQNv6zwKB4ptJVNel37Sc/MegrCxzFO8YrVwDt9+gzXU=
Received: from CO6PR18MB4451.namprd18.prod.outlook.com (2603:10b6:303:138::12)
 by IA3PR18MB6216.namprd18.prod.outlook.com (2603:10b6:208:522::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Sun, 11 Aug
 2024 18:44:18 +0000
Received: from CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::4c2b:70d5:95ac:1d6c]) by CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::4c2b:70d5:95ac:1d6c%6]) with mapi id 15.20.7849.019; Sun, 11 Aug 2024
 18:44:16 +0000
Message-ID: <f1a2067c-942c-7e2d-ab28-7906a904a58e@marvell.com>
Date: Sun, 11 Aug 2024 11:44:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: [PATCH v3] env: remove vars that are not in default env
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, quentin.schulz@bootlin.com,
 U-Boot-Denx <u-boot@lists.denx.de>
References: <03cdd29b-331c-76b0-f6d7-a064552ffd67@marvell.com>
 <CAFLszTiCS-jRfL__PJ=uEQf0rUKcw4J8czp-=khzkHB=q9ySOg@mail.gmail.com>
 <b4d4fe48-c3b0-98cc-dccf-8b96318ec204@marvell.com>
 <CAFLszTgN3AqhPzT+Zpe=sfM_cOZOmOQPseG_ipwMcNYzLbGUdQ@mail.gmail.com>
From: Ravi Minnikanti <rminnikanti@marvell.com>
In-Reply-To: <CAFLszTgN3AqhPzT+Zpe=sfM_cOZOmOQPseG_ipwMcNYzLbGUdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:a03:100::26) To CO6PR18MB4451.namprd18.prod.outlook.com
 (2603:10b6:303:138::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR18MB4451:EE_|IA3PR18MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: abbb8085-7c7b-48fc-ca14-08dcba359a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yyt0YU9iM1VKQkJ4WnVjYUw1ZFVmN1FRK3dqbjlKRGpldVh3YU41TUxxOG1s?=
 =?utf-8?B?TWNEaWRBK050dVczQ0E3M0w2NFpGZ2hwU1JjV0diZStYQUd3UVZCN1RhZ2RE?=
 =?utf-8?B?KzJKVmlLZytVU2l1N3FPZ0dqZzlXL1BhQXdFdXByZEhnS0NpSzM0MVQ4T3hX?=
 =?utf-8?B?T3Ewb0llV0RvNUExVWoyVnFlc2NycTlqQmY5d2c5T1dYVFlhaHJFdUV0Vyta?=
 =?utf-8?B?TnV4WjZGOXZTbDRxd0lZV21LSlVBQ3VaUmdRU0tRY0lmWmpieUl0OG1KYXJO?=
 =?utf-8?B?WnIvblpuOS9Fa2NuS2VkYm50ZG5YRHROK2tIVEp2RGZzNkZVL3ZLRVgrQUx2?=
 =?utf-8?B?eHFTMG9Sa2tyNGJhN2JYVW1EQkFTZ01CaWRta0VYa1hBMG94eDlRME9rckJl?=
 =?utf-8?B?N3VrN0twcE9scldGQUl4UU5qSyttT2hZMTg1elZpQmVzR1JGVFE1NUIySnRk?=
 =?utf-8?B?VGdvODF3a1JXc09UN09oK1QwUTN0cURoWEhtN1diaGRPZjRoYkxYSURCc1ZN?=
 =?utf-8?B?OWw5WGhWczVTU1ppSjhkTjcxVzlGbGxwanM4WDIzNkxKeGs0RXh5cjRKLzRu?=
 =?utf-8?B?SThPMjdxMjIyUE5WRFhFbTBGT0dKSEh1dmxoNUZ1NWhWREV6d0cvRWVkcW1J?=
 =?utf-8?B?VEp6UktseWlVVnRzSlR3MlVqS09KNVVweVpvdGMydDJBRC8vN3hiTVV3ZGQz?=
 =?utf-8?B?eFFjWkxhcS9jaGZ4ZENIRitlUmZ0NkF0YlJDZnIvRTlaT1N1ZXFSMEFQcjFN?=
 =?utf-8?B?SEtHN3RyWkRMMGs0cWJNTU45QjJRNFBnUE9YKys5dGJuaS8yRHU4SGRwVVhE?=
 =?utf-8?B?cloySjZURHpJcmwyNlNFZCs2dlcvb3RXakhJc3NxWEwzR1hwWmRDaDR2dVdn?=
 =?utf-8?B?WDl6dFFNd1c3cElZYnMxVmRSZkVqdE5yRmpoZlFEMHFXNmxXRk9mZ01od245?=
 =?utf-8?B?YWJkdFpTSW50blJNbTFCTDJaWVA3STVUdFFpcHl2V3Z4dzJRS3VoN3hHeFdT?=
 =?utf-8?B?RSs1aU53bERBcjJUT3I4NkFhWTNQVElydTRGSFQ1dzV6cFl4TDd1S1lJeHRL?=
 =?utf-8?B?KzIyNHN2dzRWaUhkMTRKS213NzdxamJ0NGFERWN3VXpYSGNqR0txYXNwRkdh?=
 =?utf-8?B?QkxveEsyZFlXNjRyRkFGRzZ6ZEhDZWZiSmhOMHJBZ0oyQlArNjMvUGxsSktl?=
 =?utf-8?B?U05MclZhb1RRK0tQY1VybUwrOE1wbzFNZm5KOUNVa29KaU9aWWpIR2JSK0lE?=
 =?utf-8?B?aWZjZWtUTWlrN29mTXlWQ0pyL0J6bVlVNzVNM01LU2lCajJXeVY3bnBrREtM?=
 =?utf-8?B?c2R0dndWby90R1JWUWlFc2xNVkkzL2dZOWlTTU11Ry9ZSXgxcElCdW5icU5K?=
 =?utf-8?B?SytVUU0rNzFwMGo4K0Q3TVpjRlhzSGZ6cWZCNHVRZFpRcU00SEpNZ2hRcFlY?=
 =?utf-8?B?blBBZXRuYVJMcWtYbFAwN3NTeWQ2WFNVYTNkcTA4QmE1TzA1WEk0eXMrb2h3?=
 =?utf-8?B?dGprUThwaXNUU3JGcHRDVHFmNFRDY1JNTVJ4NWR3bDBQZlJPT0pDM01LZUtK?=
 =?utf-8?B?Y29Ka2IyNTBYV3Jyck96SHBlNlNiYWphQTN1Z1pRazR2eGVvdUx2NVduYmFh?=
 =?utf-8?B?c2dpMXl6dVRUdU0wM29kVlF3bVNhd0w3VENyS2VkQm1kYW9Oc1lwaU1vVEtj?=
 =?utf-8?B?UEJaL2pyMEx1MitiL29FL2FPV0R1UTdwbDJsRks0L0ZHdVc3UVIyMHU2ckg4?=
 =?utf-8?B?Z0lHMW0wN1BZS055SGZhK293QytOTVlyWEpEMm4yVENWWExtTGpVY0QyeXFU?=
 =?utf-8?B?Vjg1cnF4V08xZVdsbjQxdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4451.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVMrbXBhbmFtWFYvU0UrMWRnalhYTEFvTnp4NE9GcXJEREw1Q2xURFE4YUo3?=
 =?utf-8?B?TTVVenlPOXdCRlRURFpNZ1B6NDNCMzBEUVZxNnlzcC9OdWtEaS8xb2krTmtH?=
 =?utf-8?B?LzFUWTdQNEEreXplTlFOcGVsVFVvenhvZjVsK2gyK3lXTUlyczlDV2k0VWha?=
 =?utf-8?B?TXl6UEU1d2hFUUlDVkhCeXY1QmVxT0dCdUZ6bS9MYVpTazlrdjhxSWZab2JR?=
 =?utf-8?B?NzF6aTZRSWQvZUtKOUYvc1ZyMFhzNExFN0Y0Q3V1UlpKaytYdkVkMWtDMXhD?=
 =?utf-8?B?eUxLTmsySkoxd2dXQkVJbUowQmRHVTQyTGlYcHRlN3VveUdtL3dQY1ZMSGho?=
 =?utf-8?B?M3ZNZFNIY2hWRmlSTGorZXJKaWNETU80bG9XRmN3Uy9LYnVXcjk5Z1FGaG9G?=
 =?utf-8?B?U1J5N2NyNFpYVWJQNGQ3K1FqNEltQzAxZTVCalQ2anNLeEdwRU9RcHEyVmNa?=
 =?utf-8?B?TUVzdXdTamxiMnd6WXJuYktuSTUrd1RjT1pHb1hZQ29vTklMQVhDOTBWcll4?=
 =?utf-8?B?VWF2eVh5ak9HSE8zWTl5Wi84bXI0MjNHOTFGV2R0aVR0enBOQnJSK1A5ZFpn?=
 =?utf-8?B?Mk9tbTZkU1Z0eEV1eG4welh4WkhHTVRPdkd4MHo3TmJ3cmY3RG1vcjFqTi9B?=
 =?utf-8?B?TjhHdFNjcWFNa2RrRCt5aFZLcXczcnpDOThpTTZOb1VMTm9TNzRSQ2VmSFFK?=
 =?utf-8?B?MkRvWmRZeGpITThlbHZBM0pyWXkvNVlabWxPRXBNQUpETUx5c2JNdTFkTjcz?=
 =?utf-8?B?N3p2cGpaS28zQk53NXBwcGRtcXpXWTBSMGxvMzNJbHhmNklPRVZZZ1RFWmlT?=
 =?utf-8?B?cEkxVjljYWpEWkNpWmRlVTZMNUl0RXFOS2pQSlVsUXNIMDdBdEJjQythMmVH?=
 =?utf-8?B?Tkw3dmhDQnUwdVF3MkNQOWhxSmswOGJnaTdDNjZYVVpxVGdQbzl5NDM0VGVx?=
 =?utf-8?B?SzcrVFhWUnEwUnF5cjdnd1JWUHlidEg5UlgyTC9oTDdWSWRPbkNuVmUrS2kz?=
 =?utf-8?B?MDk1cFVQTXVwTTNPWnphRHFtNFhrVWU4cmlRdXJjUjI4NGtodTlqY1M3SGl2?=
 =?utf-8?B?ZXgvWXcxR0FGdWdhV3VwMG4vK0U3V1k1Y01IaEtPcVpHem4xUzZDT2ljVkgw?=
 =?utf-8?B?VkdBeVJFK1ZMUEhzVUJnY0RGMVh6TUc0Q0FDeno1dGRkK3k2SzNWOGZjMTZj?=
 =?utf-8?B?WFRJa1BjNzVuck4zbGkwbEFXOXE0L21Sak5WNTdYZWlvWXJMcWdjVm9LZWkw?=
 =?utf-8?B?NWEydDl4OE82MzdPSHdjbURrOVUvRGM0eEhhUFNaaThHVHkyV1JYRGkxa3p4?=
 =?utf-8?B?M2xaRlByOGdudGVLWXdRN05ySFVISWpodEdWek01Z0xtV1ZMMkpIZi9wV2Zh?=
 =?utf-8?B?b1JoaUlBUVQveTdQbHFyaFBmZmlhcDNucU1keGU2ZzdsS2ZacDRKczdYRHJB?=
 =?utf-8?B?UFk3TXpJUjFOKzFGZC9QRTViYTYzazdsUVRhd2NiK00rSXFINy83RWpsRFZj?=
 =?utf-8?B?NGhHTVpUV2Z6VDlQUnA2T0piRVNyUnRoaEpKQVlDL1hVc1RVTmJYUnphS2t1?=
 =?utf-8?B?T3BFeG1kaXk5UFVpZHJCVGpjSVQxQmhuN1cvZTBidHFPVE13b2VUMklQV2kx?=
 =?utf-8?B?bTUvL0ZIc1V4WWJrb2ZXaGQ3amVoNGZ3djM2VE5zMm5ybHhOTkF5U1NqYStM?=
 =?utf-8?B?dHJKQVkwejFrM1lpcjV4UENoTGh5TkQ2dzdBS05lcTRLK0cyMFgwRGExRVcz?=
 =?utf-8?B?T2c5dzBGbUJZNjBIVjR0ZTNGb2hlMCtJMHZFYXZvN015VjdaUVV4WFhYQ01P?=
 =?utf-8?B?Z1VFUTRTLzFDZTlXNVZ5M0dkVXMyb0Ywbk1FRk45M3hlck41NkRBb2xoZ1Z3?=
 =?utf-8?B?cVBJc1h4V01reU1lOFRHMGcwQnc3djh4NG82bDkrTlEyTSs4V2VyOXVETHRJ?=
 =?utf-8?B?TG00MHVFdHdXdi8xdlQ3dDdGajBDR0pucHNnUHFvS1hscWNQUGVRSndUNlRP?=
 =?utf-8?B?T0N1QisyTDJSd2FPVmVYOG5xZE8vYkgrVWRyU0dGVGxRdWNLc1VDWUx2MjRZ?=
 =?utf-8?B?MERmckNtSlEvLzBqMWZnbWQvaUkvSUd2bHlmYnA5V0U1YTVkS01wR2U5KzRt?=
 =?utf-8?B?dkphTlk4OHVQZzRoa09WU28xa0Z3dUNFTUJaVEE2RS9kMk03TkZVUGpVN3R3?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbb8085-7c7b-48fc-ca14-08dcba359a7a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4451.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 18:44:16.9017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRS58NTS9tQ36j0XRIcIUlksS2qMeTVayNcLDuPtzDVbKplBwUdOhDoJdrvJOEfBr4HRyM/vT3de9Nd85SwidA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6216
X-Proofpoint-ORIG-GUID: AYzupHE5RPhGqYUWgW2WE9Lm4Q6S-3th
X-Proofpoint-GUID: AYzupHE5RPhGqYUWgW2WE9Lm4Q6S-3th
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_17,2024-08-07_01,2024-05-17_01
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

current env_set_default_vars() doesn't delete
var that are not in the imported env. hashtable
removes vars that are not in the imported
env but present in the current env only if H_NOCLEAR
flag is not set.

This change is to avoid passing H_NOCLEAR flag if
specific vars are passed to env_set_default_vars()

Without this change:
Marvell>> env default boot_mode
Marvell>>

With the change:
Marvell>> env default boot_mode
WARNING: 'boot_mode' not in imported env, deleting it!

Signed-off-by: Ravi Minnikanti <rminnikanti@marvell.com>
---
Changes in v2:
- Added env ut to test the scenario
- Updated doc usage/cmd/env.rst

=> ut env
Running 5 environment tests
Test: env_test_attrs_lookup: attr.c
Test: env_test_attrs_lookup_regex: attr.c
Test: env_test_env_cmd: cmd_ut_env.c
Test: env_test_htab_deletes: hashtable.c
Test: env_test_htab_fill: hashtable.c
Failures: 0

Changes in v3:
- Fixed review comments
- Ran checkpatch.pl and fixed trailing whitespaces.
- Used UT_TESTF_CONSOLE_REC flag instead of console_record_reset_enable()
- Removed unnecessary ut_assert_nextline_empty() check
---
 doc/usage/cmd/env.rst |  4 +++-
 env/common.c          | 10 +++++++++-
 test/env/cmd_ut_env.c | 27 +++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/doc/usage/cmd/env.rst b/doc/usage/cmd/env.rst
index 9629f97ffc..b65d85b668 100644
--- a/doc/usage/cmd/env.rst
+++ b/doc/usage/cmd/env.rst
@@ -79,7 +79,8 @@ The *env default* command resets the selected variables in the U-Boot
 environment to their default values.
 
     var
-        list of variable name.
+        list of variable names. If variable is not part of default
+        environment, it is deleted with a warning message on console.
     \-a
         all U-Boot environment.
     \-f
@@ -309,6 +310,7 @@ Delete environment variable in memory::
 Reset environment variable to default value, in memory::
 
     => env default bootcmd
+    => env default ipaddr serverip
     => env default -a
 
 Save current environment in persistent storage::
diff --git a/env/common.c b/env/common.c
index 8d47d72605..6cba7f1c18 100644
--- a/env/common.c
+++ b/env/common.c
@@ -401,7 +401,15 @@ int env_set_default_vars(int nvars, char * const vars[], int flags)
 	 * Special use-case: import from default environment
 	 * (and use \0 as a separator)
 	 */
-	flags |= H_NOCLEAR | H_DEFAULT;
+
+	/*
+	 * When vars are passed remove variables that are not in
+	 * the default environment.
+	 */
+	if (!nvars)
+		flags |= H_NOCLEAR;
+
+	flags |= H_DEFAULT;
 	return himport_r(&env_htab, default_environment,
 				sizeof(default_environment), '\0',
 				flags, 0, nvars, vars);
diff --git a/test/env/cmd_ut_env.c b/test/env/cmd_ut_env.c
index 13e0998341..238cf31036 100644
--- a/test/env/cmd_ut_env.c
+++ b/test/env/cmd_ut_env.c
@@ -9,6 +9,33 @@
 #include <test/suites.h>
 #include <test/ut.h>
 
+static int env_test_env_cmd(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("setenv non_default_var1 1", 0));
+	ut_assert_console_end();
+
+	ut_assertok(run_command("setenv non_default_var2 1", 0));
+	ut_assert_console_end();
+
+	ut_assertok(run_command("env print non_default_var1", 0));
+	ut_assert_nextline("non_default_var1=1");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("env default non_default_var1 non_default_var2", 0));
+	ut_assert_nextline("WARNING: 'non_default_var1' not in imported env, deleting it!");
+	ut_assert_nextline("WARNING: 'non_default_var2' not in imported env, deleting it!");
+	ut_assert_console_end();
+
+	ut_asserteq(1, run_command("env exists non_default_var1", 0));
+	ut_assert_console_end();
+
+	ut_asserteq(1, run_command("env exists non_default_var2", 0));
+	ut_assert_console_end();
+
+	return 0;
+}
+ENV_TEST(env_test_env_cmd, UT_TESTF_CONSOLE_REC);
+
 int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct unit_test *tests = UNIT_TEST_SUITE_START(env_test);
-- 
2.25.1

Thanks,
Ravi

On 8/11/24 07:50, Simon Glass wrote:>
> 
> Hi Ravi,
> 
> On Fri, 9 Aug 2024 at 13:36, Ravi Minnikanti <rminnikanti@marvell.com> wrote:
>>
>>
>> current env_set_default_vars() doesn't delete
>> var that are not in the imported env. hashtable
>> removes vars that are not in the imported
>> env but present in the current env only if H_NOCLEAR
>> flag is not set.
>>
>> This change is to avoid passing H_NOCLEAR flag if
>> specific vars are passed to env_set_default_vars()
>>
>> Without this change:
>> Marvell>> env default boot_mode
>> Marvell>>
>>
>> With the change:
>> Marvell>> env default boot_mode
>> WARNING: 'boot_mode' not in imported env, deleting it!
>>
>> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
> 
> That should have your name at the start
> 
>> ---
>> Changes in v2:
>> - Added env ut to test the scenario
>> - Updated doc usage/cmd/env.rst
>>
>> => ut env
>> Running 5 environment tests
>> Test: env_test_attrs_lookup: attr.c
>> Test: env_test_attrs_lookup_regex: attr.c
>> Test: env_test_env_cmd: cmd_ut_env.c
>> Test: env_test_htab_deletes: hashtable.c
>> Test: env_test_htab_fill: hashtable.c
>> Failures: 0
>>
>>  doc/usage/cmd/env.rst |  4 +++-
>>  env/common.c          | 10 +++++++++-
>>  test/env/cmd_ut_env.c | 36 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 48 insertions(+), 2 deletions(-)
> 
> Just some nits below
> 
>>
>> diff --git a/doc/usage/cmd/env.rst b/doc/usage/cmd/env.rst
>> index 9629f97ffc..9104c88525 100644
>> --- a/doc/usage/cmd/env.rst
>> +++ b/doc/usage/cmd/env.rst
>> @@ -79,7 +79,8 @@ The *env default* command resets the selected variables in the U-Boot
>>  environment to their default values.
>>
>>      var
>> -        list of variable name.
>> +        list of variable name. If variable is not part of default
> 
> list of variable names. If a variable is not ...
> 
>> +        environment, it is deleted with a warning message on console.
>>      \-a
>>          all U-Boot environment.
>>      \-f
>> @@ -309,6 +310,7 @@ Delete environment variable in memory::
>>  Reset environment variable to default value, in memory::
>>
>>      => env default bootcmd
>> +    => env default ipaddr serverip
>>      => env default -a
>>
>>  Save current environment in persistent storage::
>> diff --git a/env/common.c b/env/common.c
>> index 8d47d72605..2f783e3a69 100644
>> --- a/env/common.c
>> +++ b/env/common.c
>> @@ -401,7 +401,15 @@ int env_set_default_vars(int nvars, char * const vars[], int flags)
>>          * Special use-case: import from default environment
>>          * (and use \0 as a separator)
>>          */
>> -       flags |= H_NOCLEAR | H_DEFAULT;
>> +
>> +       /*
> 
> There is a trailing space on the end of that line. Be sure to check
> your patch with patman/checkpatch.pl
> 
>> +        * When vars are passed remove variables that are not in
>> +        * the default environment.
>> +        */
>> +       if (!nvars)
>> +               flags |= H_NOCLEAR;
>> +
>> +       flags |= H_DEFAULT;
>>         return himport_r(&env_htab, default_environment,
>>                                 sizeof(default_environment), '\0',
>>                                 flags, 0, nvars, vars);
>> diff --git a/test/env/cmd_ut_env.c b/test/env/cmd_ut_env.c
>> index 13e0998341..99961311aa 100644
>> --- a/test/env/cmd_ut_env.c
>> +++ b/test/env/cmd_ut_env.c
>> @@ -9,6 +9,42 @@
>>  #include <test/suites.h>
>>  #include <test/ut.h>
>>
>> +static int env_test_env_cmd(struct unit_test_state *uts)
>> +{
>> +       console_record_reset_enable();
>> +       ut_assertok(run_command("setenv non_default_var1 1", 0));
>> +       ut_assert_console_end();
>> +
>> +       console_record_reset_enable();
>> +       ut_assertok(run_command("setenv non_default_var2 1", 0));
>> +       ut_assert_console_end();
>> +
>> +       console_record_reset_enable();
>> +       ut_assertok(run_command("env print non_default_var1", 0));
>> +       ut_assert_nextline("non_default_var1=1");
>> +       ut_assert_console_end();
>> +
>> +       console_record_reset_enable();
>> +       ut_assertok(run_command("env default non_default_var1 non_default_var2", 0));
>> +       ut_assert_nextline("WARNING: 'non_default_var1' not in imported env, deleting it!");
>> +       ut_assert_nextline("WARNING: 'non_default_var2' not in imported env, deleting it!");
>> +       ut_assert_console_end();
>> +
>> +       console_record_reset_enable();
>> +       ut_asserteq(1, run_command("env exists non_default_var1", 0));
>> +       ut_assert_nextline_empty();
> 
> You don't need that line. It means that the next line should exist,
> but be empty. In fact this exposes a bug in console checking which I
> will fix.
> 
>> +       ut_assert_console_end();
>> +
>> +       console_record_reset_enable();
>> +       ut_asserteq(1, run_command("env exists non_default_var2", 0));
>> +       ut_assert_nextline_empty();
> 
> same here
> 
>> +       ut_assert_console_end();
>> +
>> +       return 0;
>> +}
>> +
>> +ENV_TEST(env_test_env_cmd, 0);
> 
> Set the flags to UT_TESTF_CONSOLE_REC and you can drop all the
> console_record_reset_enable() calls above. Unfortunately many of the
> tests don't do this as the flag was added later.
> 
> 
>> +
>>  int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>  {
>>         struct unit_test *tests = UNIT_TEST_SUITE_START(env_test);
>> --
>> 2.25.1
>>
>> Thanks,
>> Ravi
>>
>> On 8/9/24 08:58, Simon Glass wrote:
>> > Hi Ravi, On Fri, 9 Aug 2024 at 09: 38, Ravi Minnikanti <rminnikanti@ marvell.
>> > com> wrote: > > > current env_set_default_vars() doesn't delete > var that are
>> > not in the imported env. hashtable > removes vars that are not in
>> >
>> >
>> > Hi Ravi,
>> >
>> > On Fri, 9 Aug 2024 at 09:38, Ravi Minnikanti <rminnikanti@marvell.com> wrote:
>> >>
>> >>
>> >> current env_set_default_vars() doesn't delete
>> >> var that are not in the imported env. hashtable
>> >> removes vars that are not in the imported
>> >> env but present in the current env only if H_NOCLEAR
>> >> flag is not set.
>> >>
>> >> This change is to avoid passing H_NOCLEAR flag if
>> >> specific vars are passed to env_set_default_vars()
>> >>
>> >> Test:
>> >>
>> >> Without this change:
>> >> Marvell>> env default boot_mode
>> >> Marvell>>
>> >>
>> >> With the change:
>> >> Marvell>> env default boot_mode
>> >> WARNING: 'boot_mode' not in imported env, deleting it!
>> >>
>> >> Signed-off-by: rminnikanti <rminnikanti@marvell.com>
>> >> ---
>> >>  env/common.c | 10 +++++++++-
>> >>  1 file changed, 9 insertions(+), 1 deletion(-)
>> >
>> > Could you add to usage/environment.rst and also update the tests for
>> > this - test/env/ - I suppose your patch fixes a bug, but it is hard to
>> > figure out what it is supposed to do from the docs.
>> >
>> > See for example dm_test_acpi_cmd_set() for how to check output from a command.
>> >
>> >>
>> >> diff --git a/env/common.c b/env/common.c
>> >> index 8d47d72605..2f783e3a69 100644
>> >> --- a/env/common.c
>> >> +++ b/env/common.c
>> >> @@ -401,7 +401,15 @@ int env_set_default_vars(int nvars, char * const vars[], int flags)
>> >>          * Special use-case: import from default environment
>> >>          * (and use \0 as a separator)
>> >>          */
>> >> -       flags |= H_NOCLEAR | H_DEFAULT;
>> >> +
>> >> +       /*
>> >> +        * When vars are passed remove variables that are not in
>> >> +        * the default environment.
>> >> +        */
>> >> +       if (!nvars)
>> >> +               flags |= H_NOCLEAR;
>> >> +
>> >> +       flags |= H_DEFAULT;
>> >>         return himport_r(&env_htab, default_environment,
>> >>                                 sizeof(default_environment), '\0',
>> >>                                 flags, 0, nvars, vars);
>> >> --
>> >> 2.25.1
> 
> Regards,
> Simon
> 
