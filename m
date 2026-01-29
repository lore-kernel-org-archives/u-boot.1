Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0781AD46BED
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 01:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE4C883C14;
	Thu, 29 Jan 2026 02:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="npblF0Nk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 791D483C91; Thu, 29 Jan 2026 02:07:01 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 940B383BC4
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 02:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFx0xBfjEMtofv8aF92ngFPboE/R/BCPhk44+5Ci3eiDL4RZV/xtzdQ9pICyqKbtSEpKJQfg/F8USlmLKv2Qeot3336JUTepyn16v+pg7ynEylb4kEsTNZ9M13hjAdhO+wJwmIKaoDH5Mzh/fF73UKAsQDLBHuM7R0U0YXmJZLKaJg9KIlWtB/w7Wdcex3QALhY//paQ4kT8QGJYrciQcFhqFxoIbSzNTAGi7qoG4HYEDHK3JZOHmB991bjzf+y2T0r917w2fXaXKk9j9LIlVJ4mt0PSyKlOOi/DrgdTkex+CC3i7M9nN8C56RNPZBFzRGPYaDR9Wbj8RB/534ofKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jil41LZnIiczsXVBOxAP0tO6gYVWPiAYehPkZzPErjI=;
 b=HnS/PaiAu/KMISPElxutAWl6rHInCfCDpQzGr2jyZaI62bwfbD6tAK2vEPVAcNbP3iqYbjY5I0UNuqQ3c2kmSW0IRaEJxvk4dGcWMm3djInddp6/wvw9GmShQFbyTn4VTTTqVuV5ZmWABwmjDMRv6J5hzj/SRbQgIhjhe4mK8gYJg68T86MdBSXuEk7WnEYEvw/eETMwK1u4qviDrjzTAMNj6NsTKtgnPgxfQTU4xh4wnt4NGDtROCeDcpIkDv8qSTEK4H7hCAVHWQY/+mwE2K+v+fc0uiWAHcJJAPGwT2MKY+aqkqsdJAFrwPkh4FMpPWQyvYCF9p4LtHKbd57RmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jil41LZnIiczsXVBOxAP0tO6gYVWPiAYehPkZzPErjI=;
 b=npblF0NkCQWkER+xsOa0ryy9wrQC+pXdOptoAkh2JWXdNrVq3eoASWjbvwglDSILBZbuN83SRdR/KoRKCPgOdtdotAdsgKVjz9ZEsO0Q27sjLCnVVOYjM+AN7bmcRINcnIy2XJl80mwi6oHFWWFBvCwCs/UU4uBduQt5J/JSVty6H7oQH5RzZ2w+Dj5N5h1ozcEUhbPzLZF+2Eo1ceB4ZmUTeoNNPxtaFU2S23sDw7IE2ewvYEI9kCP789mXZ7FhKNdAUJRkm3cq90W13aiDC29X3xHHRePt+FUaEIyQyGjBh0HAabPJ7zK2w1BRSVXDTkzpjKSTKHcbNCvONTL2yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by MN2PR03MB5023.namprd03.prod.outlook.com (2603:10b6:208:1a7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 01:06:55 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 01:06:55 +0000
Message-ID: <8ac381a4-c614-441a-b3e0-2323a388a188@altera.com>
Date: Thu, 29 Jan 2026 09:06:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] Add CoreCourse socfpga Board - AC501
To: Brian Sune <briansune@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>
References: <20260128141816.329533-1-briansune@gmail.com>
 <20260128141816.329533-2-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260128141816.329533-2-briansune@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|MN2PR03MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: 74043495-e977-41f9-2238-08de5ed2b103
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjA0bkNpR2VsOUpheWpQaksvSXJsR29UOEd4SmhvQ09DcHp3MjN3eXVlYW5J?=
 =?utf-8?B?VndmMDhMTVpqZkFmNGUydGZtdFVpcmphajRVRnZ3azhKdVlCdWxPdERwV1VD?=
 =?utf-8?B?bGx6a3FaTDJLR0dZKzlzVEoydjlnVkpWc3ZFZEhpeVpNVGxEMFBHc0xGd0hq?=
 =?utf-8?B?WUZicDVuWjdEbS96NXFQMHF6ME5vRkUyMFVKQ01ITE9EcUNHc0Y4MTYya09s?=
 =?utf-8?B?NlBNS05DVTB1WnpGak0rZEZOT3h4K0xyS2FhVm1VRVlqdVVKREx4c1llcyt3?=
 =?utf-8?B?eGdoM1JrOFpCTnhsVjJ4aTVqdHZWbHJqRDhCYjcxMm1YRitXNHRZSTM4ajBy?=
 =?utf-8?B?Zi9QT2VPLytBK2NTQ1lsQ0pENU8wRERmdGxGdGhzcm1CbUorRkVKTE40MytP?=
 =?utf-8?B?YmpaTS9OSlBWcTdSeGRqdWF1dDIxSVFXbkFleGFyWXRnZ1dtOVEzQ0VOQVVl?=
 =?utf-8?B?eUh4K0V6TjVTY1ZyY2N6THkwUUhMZlJIRy92d2ZpNlJ6c2pZemsrcHl6UnIw?=
 =?utf-8?B?ODJWcUlaMVJhU0dOaWtkdjROYkFBMXF4SmtjOEJ6TStGVzdaR0VDbytMZHlo?=
 =?utf-8?B?SGE3bDQ4NU02MzhTVXlaNkdPbzVFZXc5cUJZQzl4UWRPYUduKzd1VW5EY3Av?=
 =?utf-8?B?c0VRd0ZWRGg5YWNLTW9rdlFCVHNWc1RnU2JaZnd2aDl6Q2JNUkt4SXJNK0Yr?=
 =?utf-8?B?R01CSDBKdkUrM0JaT0syQm1yTkJ4akhiSk9xbWgyZElrRnEzL1NHNG5QTlYy?=
 =?utf-8?B?aEtOR1gvcTg2RlBXOEp4RnJiR1FVa004d0ZlL05DOXY0ZmdQTmNYd3JPSHZZ?=
 =?utf-8?B?NElOK1Ryc1dQYzJjSGFQbFkya1pJMnQ4RUNNaGpVN0dJbVNQMXlxamxFRk56?=
 =?utf-8?B?akZVOVU3aXg3TGFpVTJpODBrNGRqN3pudTVQNHJhYTkyaGRrT1AydWpBNUJ0?=
 =?utf-8?B?NjdNcHF1dWl2aEdTSDAyOUZSWTRDU09nV1hZY211VE93Qzk0WVZzeHNWRTlE?=
 =?utf-8?B?WXZOcFVKZm1iTlVmREsvRHZ2cVNPU2dzRjNXcTVUY3VLMGtTOVMwQkE1YmF4?=
 =?utf-8?B?SzgxaW12NlF0SE1iekpnM2RKb2lGanlSKzZPTGlvUXJxTm1ZM01kZmhtc1RS?=
 =?utf-8?B?M3RTWDB5VUlEZ0VSeEtVbU1DaFBybURzd29zc0lSMFh5ZXhoc0FIbm1Fc2w1?=
 =?utf-8?B?bTVZU2NFSFNFQ3VDN1pBcnFxdnovUVE0T2FiV3NCcHVXVnNydkNMSzlmVnFR?=
 =?utf-8?B?QzFNeitJSmFNOGVxa0Nxd0JuRFN5Q3FiK1BaWitPNkxZRGhDQlNCT1BiYytV?=
 =?utf-8?B?ZjJsUUREOVZhQ0hwZEVoV2Q3b1VITWlOQWhqb3NYRTRtTUZ1T1VkQjVTM01i?=
 =?utf-8?B?eE1FaDlPRVZ0RS9xMHExYldxWDRtbk5mMllIekJWS3V5TWxuQ0ZMU3MrRlow?=
 =?utf-8?B?bHlUeXNvQUJWTno4TThjc202S0NDYXJqTXJMMk1ETEdOV2FiOTJnZng3NWJy?=
 =?utf-8?B?NnZnRFFjZ1MvemQrTjFpaDdRQWtMTDRSZm4wbDJoQ0J1NHZuZ3I1dW5uNG1h?=
 =?utf-8?B?YWNFWnU5Sjh0ZjM0NjRNdm5ObVZuUWFmaFhDUHpXSStQc1lEZ2VhNWE3YWR1?=
 =?utf-8?B?UFh0UTh6elhmZ0M1cTJpMi93SFQrYithc1FaeHlZY3RCWW43NnlGdk1UOVpJ?=
 =?utf-8?B?cndIOG9hZlNUay9FMDMwdElpSk1CeEJMbFlqekhGN1NhRnBidUN5bDhPbHhK?=
 =?utf-8?B?dExJRHZtaSttenhES0V3UkZSTlNSWmpHSHNiNVdkZW9mZjR1Rlc3SFlXUFVa?=
 =?utf-8?B?OVNGcnZ4TnlVOHRrMDJLRGJhbkQzV0tjaysxSUlSdnBkUkd4TGU1UWxkdzln?=
 =?utf-8?B?RlB1ZnFXS0FzektlVXo1b0REWlgvR0huNkNmWFBERGFLaHhIdG5USG1DcS9F?=
 =?utf-8?B?WVUvZSttZ2JabUV3ZXdhaFRnUS8zbjlkT1RnL1VYT1BVTGIyVno0RnhaWGgv?=
 =?utf-8?B?MUFEK1Z4SmZjQ3RzY0t0ZktCZmoxNjhaaGV6cUhoYjl4ZURXR1o1L3R2Wjl1?=
 =?utf-8?Q?P/1l++?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDA4SG5BY0t3cnFWQUhFcjQxVkpvV2Y1S0lZemRMQzU2R1NzN3lIYXJVb0NF?=
 =?utf-8?B?YWMwZWsxOGk2cWpQNTdTQlZwbE81dEdoUG5zakwzVjhoMkhGamk5Zkg1aEd4?=
 =?utf-8?B?TG50SzlXRnp5VlMzKzJUNk1pZ3JkVVNTVWFCVm0wclRMNFdVTitweHoyZm5q?=
 =?utf-8?B?NERNbTFndXNoZ25YSUZWMnFBVmF4RERFam1ZOGlQQTllVktZSFVoWHlKemRF?=
 =?utf-8?B?cHllejFCekdhREFCZDVpRVpNY3BPamxDelJOSjU3ODRNSWxqdlgzL1FOQ0xm?=
 =?utf-8?B?U3poL29NU2hmYlZhbEtSbWJkSldPR0NrejRGQ3g5VW5FRjdQMmI4dTR4a01F?=
 =?utf-8?B?eHVXeVJuOWFBcUNYb0cyUjc0dFh3YnRuZ2w4eWtXNDFKUXFTRzU3azdKeHlX?=
 =?utf-8?B?R1orVURLeEQvMGJIVVBLenphWUpSeVRtYlBYb3F6Z3FJRlU0M2V6N2xsVEk4?=
 =?utf-8?B?ZFZmaEgvdEhLV0RqV05ZV2JCdFdzVjgxZHhkREFUbHRnd2x0VDFwZnNsSmQx?=
 =?utf-8?B?MytBMmExSzM0SjFwRWtaa1VUc01QRktnTGsxNjN1L0cvOTNDZFBZNkZJbnJN?=
 =?utf-8?B?ZVY0Z29taWMvVGFyREJVd1FMKy8vRU5xV3p2THRldFdQbmduOEh3VEVBLzlt?=
 =?utf-8?B?V0RkNy9uTGxOVzJUT0NUT2tFVEhZdG1uRmtyOGdhcXY2bkVHYnRNMlpqZzNX?=
 =?utf-8?B?SHp0c2c1WDI4SGxjWk05RDhNL3Nzc2ZhVjBaclhkRXhTUmZiZG4xVkluMzlF?=
 =?utf-8?B?U1FkamdUYi9EdCs1dXJjUUpGSDk3Z05JdEJKYVhpcTJreGlhS01uanNDU1dk?=
 =?utf-8?B?NDJUUEtiaUorUGk1REtmMGhoMHFPTysyY2lCQWdVOFpCdStvN1ZzMmxWWW1C?=
 =?utf-8?B?ME0xNkNmMTBmaGp4REdtSHVFelFPdHNwNzBZSDVhblJNZXBjTVFUbWl2SHpK?=
 =?utf-8?B?Z2JGYU5QcVQvMlVIVVV3SmdRb1ZES0dPTG5leEU3Z3B5MUJreXNCSyt2TjF2?=
 =?utf-8?B?V2J2a3pTaXdIL3BRTWRGbDZvMk5ndFJ6aUNMWmZrbEN5WHo0ZXlMd0l1YStx?=
 =?utf-8?B?L3hIa1hwWFBzRnphNFhncUR0bGhCeWh3M05wckRORG1lL2JudmhtRFpHN3Iz?=
 =?utf-8?B?RjBzZHhPdjVacDU3UVNLaTluRkFxemVxMlkyMU5UdGRsRDFXOEdBRmp5dit0?=
 =?utf-8?B?dDU3YzgwcHNhSm9IMDFiRTdZcUhRYUZJcHNrNnVaOExockRsbnRMSUQzck1K?=
 =?utf-8?B?b2lKaWJLTDJuaVRMdkFBRXROUTNIczQ0em00bGYvQURFemFSSVIrRVlIejVX?=
 =?utf-8?B?NlFtUEpWOGVxcXJ4WnVBczlGcTZtc2ZscUVWeG9DaVNEdFMvS2d6cFFpbE96?=
 =?utf-8?B?enJLSmRaenh5RHJtd1hhTzFWUVpFSDA5QWluVXZGRG9rbU9YYlFDbEh2emhS?=
 =?utf-8?B?SnlKMDlIbFR1SkNLTTVUZG9pbjhEM1BSZjhsdURFdFNoekYwT2tyRlJaSlJJ?=
 =?utf-8?B?dnBWVGVURXQvQitpTmRmdXVaN3UzVUpzYVp1dWtUT3oyM1plejhQTDRlTHgx?=
 =?utf-8?B?YjdTMDNXTlk2UUVRZjYvWFM2SVFRalBheFJkRjNhcmh3bThjYkQzeUFEdVNu?=
 =?utf-8?B?Q1hBZUJKOWxBVHRzSXN5cCtNT1B4dVFqZjNaVkd0ZEF3Q2ZkRGZ3VjJhaUZB?=
 =?utf-8?B?VDVycHdEdjI0Y3NyZ2dnQ1MxKy94d1gvSHNaNWV3Z0x1bGZSc0o1TXgzRk5o?=
 =?utf-8?B?YkNMTFFrZXlaR01VZ0tsbDFRa3VPUzRhRXpGQkpxWFJXTXdjSmM2bG44eDY0?=
 =?utf-8?B?TUNHYnFUS0FPUG9yMkNraHRiMkFOKzg2NkcrcW1OOC92a0wzalNGaDgyWm45?=
 =?utf-8?B?eEFkNUZNYUJ2S2JRc3BnOVFwK2s2cDBWRDljeXQwcjg0S0lsK1dpblIzUU5l?=
 =?utf-8?B?RkdGVkVIbFJZd24wRWRjUXNCSHUxdFpBL1VNU2gwRTUxcTlXS3VuSzQvZGY3?=
 =?utf-8?B?N3JpVDd0WnczRExCNUhDQU5LV1NSaGtJTDYzdS92S1B6WENrcmxXcnJaOVBs?=
 =?utf-8?B?ZWoyQTNwd2pRMGV2MGlDTE9jYjhlWUJaK0ZCcTJRK09rSWtKUGdYMGpITzhG?=
 =?utf-8?B?NlplWTFKK3BPTFYxQVNNRjl2Y1ZvK3QzZFVDTUxUMkdyQmlLN3VOMWg0TjFJ?=
 =?utf-8?B?UGRIeTY0STByTnlUb3doM2VkUXlSeUoxZzRvaTNyMElPWittRnJtVmtyWHZ2?=
 =?utf-8?B?aGdINTVmUThhUHQrVC9Xb3h5MlVrRlN4bmpxQmRHbk1VR044UFpYbi9LZkVj?=
 =?utf-8?B?VkJwZjZrSFd6Nm05UmVWbHJlU0h0ZWpXNkh0VFFkVmdHcVQwUXYwWmphcUwr?=
 =?utf-8?Q?/0uSAUbwWuORSTag=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74043495-e977-41f9-2238-08de5ed2b103
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 01:06:54.8205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T85frNnC7y0b3XH12IAzv1GDHgunbhKJ2UpFLW0rEmFr7wMgDn2y2pnfC/YUl9pYSJJpd5X6zBd5FE0dELrfw8hz5SqwJoco690IyUTIK6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5023
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


On 28/1/2026 10:18 pm, Brian Sune wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> CoreCourse Altera GEN5 Cyclone V board
> do support different size and formfactor.
> Now introducing AC501 C5 to mainstream u-boot
> This is a UBGA-484 based board with basic
> feature. More info on [1]
>
> [1] https://corecourse.cn/forum.php?mod=viewthread&tid=27704&highlight=AC501
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>   arch/arm/dts/Makefile                         |   1 +
>   .../dts/socfpga_cyclone5_ac501soc-u-boot.dtsi |  44 ++
>   arch/arm/dts/socfpga_cyclone5_ac501soc.dts    |  72 ++
>   arch/arm/mach-socfpga/Kconfig                 |   7 +
>   board/corecourse/ac501soc/MAINTAINERS         |   6 +
>   board/corecourse/ac501soc/qts/iocsr_config.h  | 664 ++++++++++++++++++
>   board/corecourse/ac501soc/qts/pinmux_config.h | 222 ++++++
>   board/corecourse/ac501soc/qts/pll_config.h    |  86 +++
>   board/corecourse/ac501soc/qts/sdram_config.h  | 349 +++++++++
>   configs/socfpga_ac501soc_defconfig            |  85 +++
>   include/configs/socfpga_ac501soc.h            |  13 +
>   11 files changed, 1549 insertions(+)
>   create mode 100644 arch/arm/dts/socfpga_cyclone5_ac501soc-u-boot.dtsi
>   create mode 100644 arch/arm/dts/socfpga_cyclone5_ac501soc.dts
>   create mode 100644 board/corecourse/ac501soc/MAINTAINERS
>   create mode 100644 board/corecourse/ac501soc/qts/iocsr_config.h
>   create mode 100644 board/corecourse/ac501soc/qts/pinmux_config.h
>   create mode 100644 board/corecourse/ac501soc/qts/pll_config.h
>   create mode 100644 board/corecourse/ac501soc/qts/sdram_config.h
>   create mode 100644 configs/socfpga_ac501soc_defconfig
>   create mode 100644 include/configs/socfpga_ac501soc.h


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

