Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068F0CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72309844FF;
	Fri, 28 Nov 2025 12:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="RC5OR5Ur";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B31F84505; Fri, 28 Nov 2025 12:15:10 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25BBE844EC
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGWp1VY2AI5uCLVj0iw9IxLjHkIXDZjUqvosseRY92vMsqNdyR4bLylPzE/yA1/FhzU/+ppjT3FA/ou5D83GXh5fv6ejuEmAiMGjodBR7K9GuWWjM939U8hhX4k1uStkV4m/mHonzjY8njlLq7eVd8m6g6MXXrhONRU7yfVOV7VRmDO4O2dKpCnkjqeaHm0wyB2fXvIK96k5QxZ7V/166V1LxScNjkXhctB8VGxBawKjc13oZhr1BWoTN27zWp0Xn1cQqOCpTeKXR9U2DurpOBzDp8Fc/BR/O+EL3VCvEL6G3qWJfEKJMDGZReQE2GwdmKvv2kpS99dRovsZsT5LDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaApOMaOHwOLvO66Yl/hU1nWusvx9izCj4y4NRkVkl8=;
 b=VkTJQO5vC/rkHiZU+vfrNumKTEyhf25EZW3npnnWCRvyf06vaCixIGsQBupC5hpBrqKSeNxR3jX0G1WIlPZqs2OVtSrhv0Ru8ENlqbRszNi5p3e1Qtxv7PiOKA9KwxEvOL30G/fEu2HShVdJtxAj2mKEKUuCimgDSYOJ9fU4c2GhVuaT69MQAqUQn3x/UlkucmhOVbRQtySumO0FEhELdR0tlx6iLTNOc0nzpruMlsGOI98+5JN5G696WYkjfS7RaWkZcWD23ZBl0KbpOMxpUTJcXVal4pE4hqL3sZqXmn/H9fq9gLA1mVYP0iM6oH62UD99cEv4Y95Ls6mjI1TQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaApOMaOHwOLvO66Yl/hU1nWusvx9izCj4y4NRkVkl8=;
 b=RC5OR5Uruq0k4yciup3ro0B3LxKmMYkWT4nnXhYHx7FP9mkSUy1PDDE2Moxca9tWqlg4em0/yBhImzsQ/BaiI+Sej61uymHba0BQqeOx+IjajbW0qTRE676UeffOieZAX9bd8K+hmna31JLG3Ub0IkSz0VRz+YcRvxK90ANR7IcBQr8gk68MxHMKD/evU1AnQIN/tFdPDoXBzvtcbOcm8qnAzcqazxe2Q56bPCWheN12WqyH/DjdZKbRxCZVMMunRqu5hCQcZdQnLK17WM+WZ8DnXO3PCXXSd1T8Xm/LxbGRD1Y60dmhr0M+STeytr9UQ9sQdfJRKgzqwqtFFiyI4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA3PR10MB9269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Fri, 28 Nov
 2025 11:15:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 11:15:04 +0000
Message-ID: <66810c5a-f589-42cb-ab11-b692217dd235@siemens.com>
Date: Fri, 28 Nov 2025 12:15:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Fix socfpga GEN5 boot by spl+u-boot sfp on RAW
To: Sune Brian <briansune@gmail.com>
Cc: Chee Tien Fong <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de
References: <20251127192136.168-1-briansune@gmail.com>
 <1d42f643-41a0-4a16-8269-5bad7bf8953e@siemens.com>
 <CAN7C2SBQOCtCPyJA5+HXd4CU14eNKxkj+GQPCpf+GRsXoAPN+g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAN7C2SBQOCtCPyJA5+HXd4CU14eNKxkj+GQPCpf+GRsXoAPN+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0380.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA3PR10MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: 469c3394-6c74-44f9-0abd-08de2e6f6175
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1NHN0pNUGV2WEZJNUFHc2FKRUFRWjRTNjc1QlNLNXhOdkZOcVVtMUU2WTB5?=
 =?utf-8?B?SVpMZXhlekF2ajNXazNMQVhTamkvV0VkYUJHYnhxRmViRS9aOEx4MlFCZTdI?=
 =?utf-8?B?YXVZVGlLUnBCUjJuNHhYN0gzTU4zenpzbGhiQUpNaHRKL09yREFLMDBKZi9O?=
 =?utf-8?B?VExwUTVLRDFiR05wMDdTclN4ZThqdzJVZkVYd1dGV25hZml0RG56THZVaGRB?=
 =?utf-8?B?UzlRS2RNbGlycytzRlJsK1Qyend3U0Y4d2JxS0ZKUkhpRkhpTFFSUklWakdx?=
 =?utf-8?B?VzI4MUx5dTVGRlIybGtSVFYyNE9TZ1ZmczIxS1VkYnllRzhYZWo3ZUh4Qnpx?=
 =?utf-8?B?dGlLcTJaTm1udmpTTXptQTd4amEwdEFVSnA4K3V2RGVXRXFHdS9Uck1JZUV0?=
 =?utf-8?B?ZUN0M1NqNUZ5SDhFQlFJODRhdmZtdVFoTFFjbjFLUTZtcWVMMi82RFFYSmRt?=
 =?utf-8?B?aGZ2dE9hOE9JUURmejFFYmNvUEpSVGs0K2ZwZW9zRHZON0I5VnRPVklEUGMv?=
 =?utf-8?B?KzdmOTJsSDV2Q1RGT2RESkV3cHhRQkozWUtXZUZqWndxQzlXb3AxSGQzUzVX?=
 =?utf-8?B?eHhBKzZUczRMTVpPVmVzSklIMW9rcm8raGZ3djBlaXVRS0lkZEg2TmNMaCtW?=
 =?utf-8?B?UE1PeDFvYUY5QURaUXFZUklsb0phVzluclNkeE5teEJRYmI0Mmh2NzQwQVhm?=
 =?utf-8?B?UFVtTDNDUW1FTUtQNDNlWnFteis0b3pGTkpHczNQdVpZS2phK1V6cjFrN1dR?=
 =?utf-8?B?OWVzR1N1YUlHenpiNEZXZHF3MFBBQk9MNG5BNlIvN3FUcW5ReU5oOENsRDl0?=
 =?utf-8?B?QTd4R2ZycUx0eFdlS1dncVI3d2tWeFp6YXRxQjFSL05PS0ZGTnJOL0Z1SjNi?=
 =?utf-8?B?UzlDblo4UDRIeU40UnlBdHl6Um1QZ2lDbWU5WHh2cStEQUUvcXk4UnMyM3Vt?=
 =?utf-8?B?TWJnNCtDZlJrWTFmRUlqcFB1SkQ4KzhHWUg4VjVZc1FLa2R5Rk8vWnFrMzdO?=
 =?utf-8?B?blMzNmxLOGdiYzRmWmRyS1N0bFJhbGJwZVc3a0d4azhnTUlIaENmbGc4ZTZL?=
 =?utf-8?B?RGtrNlJCWjIrTURkRUxmSW1zQUdNZFhlbzJJdC9CZG5ZR244dWxUbk9ad1pP?=
 =?utf-8?B?TXB0ci95SU01OWJhenZtSlVJVWhsZ3pGV2VlWEhhZWNvSy83UUhOczFXUjhD?=
 =?utf-8?B?d1lNeSsyZm5YcjFWTkRyS2hRTVJSVVNxT2g2T2p3aEZmVExVcUQrRFkzd24w?=
 =?utf-8?B?WURqR1NlMzFpNWRyRUJGdW1tbUhWUGdkN09MZlc4UWErM2p6SE5pVnZHbU94?=
 =?utf-8?B?N3VGQU91a2UyTnVzdEllWmxrUEFJUE5Ocy9rS3JWTHpXQ2l2b05CS1F3Y0Ju?=
 =?utf-8?B?UjJONXYzcU9rM25xWWRjZXAweklXNms3d20vSkN4dWVEMUMyMmZxZUcyQk5w?=
 =?utf-8?B?WWhmM2htRC96WDk1d1F0WWdjUForV2RrWTh5NjlWRUVOaVlLQTZXMy9qNGtT?=
 =?utf-8?B?bG1zZ0RKRFZrY2VjV2NWTmIxUkIzVlptem9uOGpPM1ZNYmR2ZVhoRU1yTjZG?=
 =?utf-8?B?SVBaWWwzQ2FLejJuR2N5ZHRxRjROemF1MW9JQng4SkJTV3NYdWFtelZVaFZq?=
 =?utf-8?B?SXFGcVp0UG5teDVHdFRQOVRoQnIrUjQ4QTB1UnNpck9OcUlBb2tOZHR5WWRE?=
 =?utf-8?B?RURhckYyWUJBejZGY1pzaDVFQTV3bnJDQlVic1lPMEFMYjNYZ09ZVUh5WmxM?=
 =?utf-8?B?bWx3eWxkMENtZUFSRlh3N21PN0ZnVHIzOVowbER4aVJnZVgwZkRha1JlK1gw?=
 =?utf-8?B?MXZTL29udUtaWU9IM05ZWk5kVGFoamZES2VpVTdFQWQvRnVJc0hOWk5GcU9T?=
 =?utf-8?B?SzJyOGprQW1OZFZJS21zbFV3WWhndGlRSkRDdGNyVGhxVEhDeGlaeDRRdXUv?=
 =?utf-8?Q?U4ZctAiAl8g8xTbKA7NAO68t28eRUMEw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVBBMGJQVnEvSitrSlQvV3EyanRhVUtQOGJhVkR2d25nTHB3RTgxYnYwS1pr?=
 =?utf-8?B?ZGpjYmU3eVpubmJrQ1Qya3J2QWw0SkFQdU8zNlNBSTkyL2ErT2tCV3lRRWVK?=
 =?utf-8?B?OVZCa0dMbEprV2hyVFEzYmEvZ2dZMU84ZDRpUHZ6a0xBTjlqNTdMbVVQZjRH?=
 =?utf-8?B?ZklHQ2xIMXlSSjc4djcxTUZnQ25mRlNESDJZT1BwNzIvWFp2Rjh1cHpCTVdR?=
 =?utf-8?B?OXVZQXVyM2JWZVFEcTZZTTFwOG9mNE9mZE91KzRMTlZkd2prVDJjbUNSYWNI?=
 =?utf-8?B?SGNyYkR3Qjg2blhTdGVrWmRFckRxdHFQdThjTmh4dEowU1NzMmh0Mk15aGl3?=
 =?utf-8?B?NVE4c0hFbmJ2TGhQaU5LcFVBYTBDYkxUZ01qQ080M3VGOFRFUnFsL1k4MXg3?=
 =?utf-8?B?RkhYcTNmTmpXQUxYKytyY1oyMzAzQW5WUHRSV09MTmd1WG1tNFlXa3dMTXpZ?=
 =?utf-8?B?dGxRWkxKdklEeUxkcXo3NFJUOWJIZGEwOXNxamZITzZMbWJTVXlxM2QxdGVK?=
 =?utf-8?B?eXMxM3FFRy9FSktLQnM2cDU3aTYwSEUvTjZRZUg2elpveEFrS1dWaTA4Z3R1?=
 =?utf-8?B?VFRqQ0MwYVBYdVB0L1Nob0p0RkRFNmtxME9PbzhHbk1oancvWUtoNXA4OHJ0?=
 =?utf-8?B?WmdqOFRpN21MYmV0ZEVGamlVejBjYTF5ME5mVUM5QjJuOVhFaTFiKzhCSTVL?=
 =?utf-8?B?N3cvZ240L1F4NlM4aGxVTDVSVXcvdWhWUzkvYXRLcVk3a0pRbERzWU5uWWNi?=
 =?utf-8?B?SFBTNFAwTm9jMUlOam96Q3NZbnJ5TWlzRk5kVHZ4R3p0Tk84WHBQUWd5elpE?=
 =?utf-8?B?N0lrZ3J6aXYwUlBMUm1IT0ZGOFphWnUyK2twRTdPVklBUGE5eGk0dUJNbXND?=
 =?utf-8?B?cUVsMDN3TDBiRUtpeVBFSWRLRmNWNWQ4cjV1L2hsYjQ4Z1JiaGJ2SmpWUlkw?=
 =?utf-8?B?ZE5kekFJOWJzOURxSXVpek5NaEMyREJlTDI1a1Y2T3ZRMi9sM0RBclJnb2NC?=
 =?utf-8?B?Vk9tMjUwb0RibnVBUE05OEErbnZ4NENrVFpHTUxTS3ZTTzdETWFZWGhsTzZi?=
 =?utf-8?B?TzFST2g0ZVFRNUhVdGRLNjJhWFFxOThXN0V5SG5xT3dsLzREYjVGZ0xoWmt3?=
 =?utf-8?B?eGt3S0RSb2hLWTJQVkF5dmNWUTRuNWJzQUVFNkVycXhqeGU5UDlnbVl5YzJ3?=
 =?utf-8?B?UnpaaXJLNlFtQWFiOFl0ZVNvNm9PYitjdlU3cWM3c3p6ZHZuRUt3a3o3WmhQ?=
 =?utf-8?B?TVhtNW5nUzUraWtXMUxZTnRONkQrVE1yZFV3Sno3akhsQXF2Unc5SS8rT1BM?=
 =?utf-8?B?MUE1U2szSjZyYXdzaWFGS091VVVSbWNwRmxYdm91bjVtTXo0dHJkQVR2Z2Zt?=
 =?utf-8?B?RlJjZ2wzSjRBSzZKVHBrM2pwNEJSTGNFc202cUQ5ck9nVlpwOEw2ZkhmcWFK?=
 =?utf-8?B?d2Jsdm83REMyTVIzSDBSdHVCSjc5Z29zUHZGbEJ0bEJwU2EzZnAxb0Q5QWc1?=
 =?utf-8?B?UHZYa2I1aWhwbWZ3UHdML3lUdlhjZGx0eWtKR0oyR05vSHlaZmZacS9PN2NM?=
 =?utf-8?B?eGNueUI3NklmOXV0TWNHSzMxTUVYMnJMb29ORmk4VGxDd3BDQ0w2QzNkVzkw?=
 =?utf-8?B?OW9xY2RHR0xpUkVUYVJhT2hRN3B0YVdhWXJLT1B2TDNxclZVbW12Yi92N3BL?=
 =?utf-8?B?aUVpeFp4dk41RW1paUNock8veFd4SUtYSitxd3lRT0NiM2tNL2FSd2Q1K21a?=
 =?utf-8?B?RGlzeDRrUm9JMmxYVzJtNktqanNidU5aMllYTlFLVzFCQ1BoRHY2eHFhbzh0?=
 =?utf-8?B?UnFFSi96dUdvRzNRc25YcjhmWVVqRGRIRlcxZFRjTGtGOENkalRSR01TTkU4?=
 =?utf-8?B?Q1JyTVNTbk5nMzVpT0pXUVE0WTUydjhQemxNNE1MYVc4SG1lR3hHR0RwS2Fz?=
 =?utf-8?B?TWZkK0JHZTlxQVJsM0ljMmZGSTBrSFJrWG1QL085QUJQSmJwazJVL1RMUFk5?=
 =?utf-8?B?aG5iSFFKYlM4NC9KU2RXcXh3T1huVDBLbUNGNXZNa2xaZjVhUUlsMjVKdHNF?=
 =?utf-8?B?ZkdnVFlVS2phUitaY3l6dWdwTitIdmhRaVlLcVFiQWNKemlKY1h6MEJCOWRS?=
 =?utf-8?B?ay8yL0ZScEVBS2t6dXJyM0NRVmJicGppdnlYNkhTSEJERlVFeHdQamh1clVS?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469c3394-6c74-44f9-0abd-08de2e6f6175
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 11:15:04.5606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfiiDjfw02ffvXboG0zfgAVo32LGvpgtuEMX+vxzvL02QJx1fge5LbPbDmA8raYZwED+Ohghmd1UqVegbOfdhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9269
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

On 28.11.25 12:00, Sune Brian wrote:
>> Most bugs are device-independent. Those should be fixed separately, and
>> I was even asked in the original series to split further. Let us iterate
>> on that, I would say.
> 
> No, I disagree.
> The terms device-independent had already been considered.
> This is a complete patch for GEN5 C5 and A5 only.
> Other than that will not be impacted.
> 
> Read the patch file carefully.
> Or simply apply this patch to check what is the difference.
> 

I read it, and I also disagree - one fix per topic, and there are
multiple topics, affecting particularly
SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE for any board that may want
to use it.

I'm happy to take comments bits by bits, and I'm also happy to drop or
modify patches if there are better solutions. I'm also fine if a subset
of your current patch will go on top of a subset of my series in the end.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
