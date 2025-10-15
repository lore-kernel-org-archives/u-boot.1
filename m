Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701F0CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C89208388C;
	Wed, 15 Oct 2025 17:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AolyupjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B26D832BC; Wed, 15 Oct 2025 16:09:29 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3995C8313B
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqawQSPGkobYH8UsNTGs6BImOJx7xrVId6hvhr9h0y4T3wkQTmK38XkbpY3OPt4U5T2kNbZzSonZiP+bcvPpYu8M/ZuE7pN3BkKVYLq8RG/8/lK4kr9MsETYjh3UJzW70qFwkroNC12BfXjcl8I58PNcmBmqimGMvSwep55gmSrO4PktsdWbAP2aMEAaZ3ClqvzI7OZTS0tyk7ZpExlRa9eAVOe8KI0/bUmUHG3Msjw5O6eFWchOJPqpzxfuocNAUbgFyG+/nx210tffCzbFyCUR2V2Vd3Lh98umEXYvEvd0oLzSxIqCpQALGOzzwpU9zejsdeY5dr4vZLvhbiDHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7chN1huBBhS0J/7ji7qzQ0RdpfveW2Rvan6e3LjUmsI=;
 b=K32gI/Uf/uYPyNa5W1NuSRn1n/6exzViT8TMO0+fYdrJsv09ZQHrDXw6xAuIAVDxiefkvfZ3rVUKdtH9AlH2sVS6WPfZlHUjcsYmUZEO33ibOSVsx5FCOYF194nf2jmeR0imj96lPF+c5WSj2fvTkrWj2FymhKdK0gD+gvdYBmadBYZYxQbxLELjadVctpePYE7RsvWqywZAsT4rHeF0bgfbXG1RQuX5/EYuMm2ktqgg7AN3SVHNzh9C/qUKD7F9yisGwXCHIj45RSPK/R1D71fqU2MUKwyrbkgtY9qjMvxHgeJfoaE5+MLLRJcn5x/UVcrBsc8xsS+hoeKqT9CxYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7chN1huBBhS0J/7ji7qzQ0RdpfveW2Rvan6e3LjUmsI=;
 b=AolyupjZxlmpt+TdqdVddBxYGEUXY/f0x58kgfaXDbqjqfXjLxu1jtGePQ5vfinvVKM8T/VcUVIs/6XMAflrPX2b28snbuwO/Fvg1/aUPDms4SyzGGpWtR4ojpyqVyiyLkPUIfUYRcqa7zVFMjOn31ekFRMNuO4oWlgxpTZYTNxiSYBzEkFrF3W4tVFPH+S0SKbah8Uo5ksZCZix16/irmVvFOsgqm5FpdJIOSpP2hO81SyOKwaX3Y8/w40ZMYiS6Z+jhwmwfw02zaXK5hIg+0KuzIZLHTg/v/hEA7zUV4r9Ebh/uvz1r4GP3s6xqsfsKR6avR8LbV3j2DSUWViIkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by LV8PR03MB7373.namprd03.prod.outlook.com (2603:10b6:408:189::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 15 Oct
 2025 14:09:21 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 14:09:21 +0000
Message-ID: <88066f8c-70f1-426d-9291-1b91ab246824@altera.com>
Date: Wed, 15 Oct 2025 19:39:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: dwapb: Enable SPL support for DWAPB GPIO driver
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tien.fong.chee@altera.com
References: <20251012185558.23808-1-tanmay.kathpalia@altera.com>
 <20251012190534.GA6113@bill-the-cat>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <20251012190534.GA6113@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::17) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|LV8PR03MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 58de5f48-c72d-4475-f7ba-08de0bf47005
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1FGR3RDdHJLSjZURnZJS0tmbm5QV1FVdDRXcVg4VGdNckF6U211RVJJR3Uw?=
 =?utf-8?B?L204YXpHUVppWUVFQ09RdXI1MDA4UjBnK3Z3S3MrU1lGZTM3S2hHd0RHMFVR?=
 =?utf-8?B?NTFHVHdlekJPV2Q3VkRwa05qcC81aVBKM3FKTmhHZ0NtSDdpYUlNM2ZwOHQr?=
 =?utf-8?B?TXZjaHhLNmR6T2RQOCtRUkE5SFpmNlF5NEVBYXJZTVd2MjBua01FTTBYLzZY?=
 =?utf-8?B?YjRmazY0MldvYXVXeVlyczljTllKYjgxMFFpQUx5WHJacWh2MmpYQlBJWjhK?=
 =?utf-8?B?M295L3Zob2g5ZE9YaWFCajBWQ2dHbDRWQm4wVFNjWlU4QUE3a1F2a3U1bHRp?=
 =?utf-8?B?N0U0cTVReUlFd2w2QU9XZzJ2MWhtOGxNdXVDQXpOQ1pQOENTeGtBSDBhWW1Q?=
 =?utf-8?B?d3pOMTBKcWxJN1o0a0VGRDlNcWJyeTBrSmVqYURNeHZhYzUwcCs1WHpHWDhh?=
 =?utf-8?B?WExWc2QxUzlKZEJleWVDbVlLUElMWjV0dmVuSExWUG85SVE1Z1A3L0d2WVhw?=
 =?utf-8?B?TjNTY1dld28xZ0VnaVE3eSs1MzVUT3crS1ZZbFFsdTZPUGRYczVTMTIxVDZL?=
 =?utf-8?B?REhtTGZBcy9JQk1xNEgxb1VTUXNrV2R4NTdzcVlRcGhSek0wamxCWndRUGNJ?=
 =?utf-8?B?L0lZUG9mY29sNFdpbXVCdFdPRVZYeFhjRG1JUHJjZW45Y2VtSTlleHE0eFBZ?=
 =?utf-8?B?SVo3eW9lUXJzL3lONkRwZEMxeEM5dUdyQm9uTWJPWFJIajIwUUN0VkJ5dTNt?=
 =?utf-8?B?M0dKRno1UWRLSWordmlTeDlmSkdQOXpsYjFSSG1MMm9BclZTNUJYRERabmFL?=
 =?utf-8?B?N1NvbDJCRGppOXhqWDcxYTEwNWZsaGk4RmZZUC9xTVFqRHRuaUdOMzQvYkVH?=
 =?utf-8?B?UXhLWXIzWU9zMERHelAzWmIxTFBEWkxIa3hSVGNtTjhqTDAvb1FHWmVPVHI1?=
 =?utf-8?B?clpXdlAxVmI3blJUbXJHeVlHWW1QZFAzVlpIelpOYXhJaXB3N3NWM2RWb3JE?=
 =?utf-8?B?NjlRVjh3djV1VVZPY2FLRXlPL0owaFlBZmRVcWpwUjF1QnJJclJXTFBucWxm?=
 =?utf-8?B?cUE4dW00OGQwdG5UQ29OdEp6c2g0blRKd1BYb1E4dEtwbXkvOGNoVkdNRjlq?=
 =?utf-8?B?V05FRDRnSVRSVVBIamdOVGJsN0pQaDlFT0xKUEEwVXlHaXlpQ2FxeWk3bllP?=
 =?utf-8?B?WWF5c0Q3aGIzT0RFN05JOGl1VVU3MkcyeGNvVk9tbWw2TkdNRUo1bllaT1ZN?=
 =?utf-8?B?cnJHSnRmTE9QL2pDVTZIZEQrUEMvcHZNUmUrRTV0N2VZaDVoRHZJS2hwTjFZ?=
 =?utf-8?B?SXNxbGxaSDR1QWd4UzIyTjVKQlA4aThSRWxoK3ZlQTAvUnpnaEM4MlZMOHM4?=
 =?utf-8?B?ZE9pdnZTUm5BWUc0Rm0yK2R4a25KUFp5YTIxSkhYVFQ1NUN4aGh0RDhSdHN1?=
 =?utf-8?B?dGZqVUZPT1hyZVVPeThKejZLc0dZNU4vS3NVNEJaV2x6U0IvY2ZvMjJLMWdR?=
 =?utf-8?B?RGpraytSbXAwd3paYnBxaGR0NkdtNFBxWXZhOTBLdy9pT0FVWlFIbG1oRWRj?=
 =?utf-8?B?ekg0VFBzakRWL1N4aUNSQkE4YmViQUpaMVoxSW9ReGhlWG9aOVVRMkk4UnM0?=
 =?utf-8?B?OHcvODRBajViWkRCUE5JL2FFRVRsdlVjUjBHSlRHWGd6Ky9EaTlRT2o1dDFm?=
 =?utf-8?B?SXIvbDEyRi92RHZGemVyd3FTOUtvL1IrbFcyUHZIaVNGUTRqZTJWWVpSNGN2?=
 =?utf-8?B?M29tdXFKWWFrRWh3ckdaQUFQSUNaMFhkQUExelZmR1lCT0lLR29rVHQ3RjNF?=
 =?utf-8?B?OVArTkhwR25IVHRPTGZHZEtFUXpmN2hidlRJU2JYUEZRb2FRWHlJOWtodml2?=
 =?utf-8?B?L2M4WkU0WXAzbHpFZmFxOE9SdXA5K1JLM1pjMjNiYXRIUkVyQTB1RUE5MFIw?=
 =?utf-8?Q?qt/BjCDqKdD6huScU6amSaly7vjCrwqe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VllUbVFYNHVCMnJmc2dzTXIzN1NabHZMdzk2WGZDWlNad2kydGpWZVFJVUlY?=
 =?utf-8?B?WS9GcEQ3anV2MDBZKzk3d3M0amhxOE14ZVpScDU3MjE3R0tGaytSZlFXZHFy?=
 =?utf-8?B?cERDeC9iTmdJNEt2Z29Gek9hSEVGVlRzSjN0YXZuR05QVTdsQlRNZno5d0E5?=
 =?utf-8?B?ZXo0cjEwSGlzbnB3Rnd6dUgrbzV1WEZDVGo3RHBSWlhwdE9MenVGdEdwWmtv?=
 =?utf-8?B?L0o3d2tYMmJpUW84TlZUcTVoVldINnFaNlh5UlZrM0x5UGdPODRON1RJWVNv?=
 =?utf-8?B?SXQ4UURySjBiSkl2OVYxWXp0ZzJlb2V1TnE4S1RscVRUYUY3SUMwRHJ3cHJm?=
 =?utf-8?B?djRtZWkzSDBTdmlWVFZ1MzNWeGFDMWNkbUJWTHgvVGJ0ZHA5bDZEVlpaMkJL?=
 =?utf-8?B?Rk1WVVlHOUZ1ZysyMXhWTWYxd1JZZU9NdWsvZ2VTWDVkdlVleWxTdENQWGZB?=
 =?utf-8?B?bmpxUDRkbkZlT3hLZWluSEJLL3FsYzF4YWw1alNhNUVIdzYvYmxvYkNnMTgz?=
 =?utf-8?B?VngxMlN1YURiSHlLcVMyUFEzbkk4U3RZRU4xQ2xlZFlwUVlSaFY4ZmR0cGRK?=
 =?utf-8?B?OC9pRnVrM3pLK0xNLzZyQTVqazJTcmtSOEgrc0dCWGN4Y05EckxTT1ZXVHNE?=
 =?utf-8?B?QnV2c1BqNVZrREtkclIwVzZXcHVnRGF4V2EwSUdaZHpEOFhZcjk1Q1JDVFRE?=
 =?utf-8?B?ZFZVQUx1Vm1ZWGJ1cFNEcUE3TEVOU1I5dGlFQ3c5Q2hsb2xvZmR5RzRqTWpZ?=
 =?utf-8?B?Zm1qS1RBdFZnTEg5Unl3L3loNWVtellPOFU2MEpUTm9MZytjaEMvb3Y4bm5N?=
 =?utf-8?B?Z0c1bjA2QzJaM3h2ODh6TTRNODBSUXh0cVY4ZmUwOGs1NHcxdVN6L25kZmVr?=
 =?utf-8?B?c0RzenZBL3FFYVVZUEFKWHg4cXpsQ2lESityTVdTR2JOdmJRQkwzd2hCdExB?=
 =?utf-8?B?TzBhT3YvU0tHR1NxTHJibFBwamdCV256Snd2dkFma1BUWmhremJkQ21iWGt2?=
 =?utf-8?B?dStTOExYenQwWnBZaHF0cVI2eVpnQUMvTkV0RFhKeXMyelFvdXZpQVMvbnA0?=
 =?utf-8?B?L0pvMVFxc2g5SEJwYURUejc0NEJxYlcwWEIvTnNrYU9OZDFwRmUzck5haE5R?=
 =?utf-8?B?UTczblpzY0oxYW9wTjJaVEZDM0R2SHBnaThNOTEzWENpQ2drTzZ5aitnWVdR?=
 =?utf-8?B?LzdxSnRFNm4rUjdlVmxKQi9GbDhiL2RyZ1ZWNkUzWGlibUVVdDc1dWFCOUlq?=
 =?utf-8?B?SWF2VkIyc1Fhd1o4ZUIva2o4aUNJZjFkNDN1dGhUZCtoUm05bm9qSTg3dnlV?=
 =?utf-8?B?TG9meFF6dWNoWnYxU20vRHJ4Q0ozd29mVzEwM3RtRDdpeXlvWjBkaVlhcS9i?=
 =?utf-8?B?YnFueENhclVxYUgrVndNblA0T1hsYmMyVHRrdEk4ZUxIZFdNR3BqcVNQalNU?=
 =?utf-8?B?a3IyQUVvMFpWc3dEV25hcE8rNGJKaC9QNVhLS3lrazgzS0pqeDlJTTNZNkVl?=
 =?utf-8?B?cThKc3BuWGxZUDZTZmZWWUVyR2Q5TS9WQ0h6UElUNUJFTjg2bVErUlQ2WnVy?=
 =?utf-8?B?NnYwamN2cnc5OFN2Z0lpZUVPbG10eE5mLzRlc3ZRSXB2d3pmcURsQnFvb0ZD?=
 =?utf-8?B?RkpuRHV6VEczYVduRlFtTHRpcWRxck8rQTl5b3ZwUHcwdGgzN3B0dWFKTnlL?=
 =?utf-8?B?QloraGtQTlZOby9GNW1IVGxrV3lZekhYREprRjNzZ1FPOVp1b3paQmRETUdZ?=
 =?utf-8?B?Qm5QUkVlMDRUL2RrakxqTTdoaGtYOGFIa0FRZm93MERtTkN5UmVIeVlrSzlw?=
 =?utf-8?B?VFc4Wmx1Mmg1Q01ZRWE3M0poZSs1K2JEaVp2aTVkYno1eENYWXVNVXZoU3pr?=
 =?utf-8?B?RFY2MTZydEhsQVdnRHFPR0tsVjZ4Q0gwZHNsNVgwTVJnRE85eGV1OEVRb0VB?=
 =?utf-8?B?UzU0VFpiUHlobGc1U3Q4bXQyOG9TeFdoTUtRc3BOSnBuUGRjdWhEa3RuNmg1?=
 =?utf-8?B?VklhcGJYamlKajNTWDh5VWlJMjkrSEFqdU5PSE5KTHVHcEYzSks4UTJCNmdu?=
 =?utf-8?B?aUpHL0pWVWJ5Y1BJR3VqNnh6MlY5cnBvbVM4V1lDaE1DM3ROK3RSK0hKbkVR?=
 =?utf-8?B?cGhUNnJVN1VBVEp2bVhVbnVxNFNkRis1Wk5FRUlRa2hJZUFiMmRoakVlSXZ4?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58de5f48-c72d-4475-f7ba-08de0bf47005
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 14:09:21.6309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fEfGgxYA5pnAGmksyigz13UbkFAajiIrUqv36gcjLyjeIi7TpKKKbtiDPW9dK/V7I3cZXEukDaQerP3tU6oSF0UlXnJh+6hbR9NFaYxJng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7373
X-Mailman-Approved-At: Wed, 15 Oct 2025 17:56:06 +0200
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



On 10/13/2025 12:35 AM, Tom Rini wrote:
> On Sun, Oct 12, 2025 at 11:55:58AM -0700, Tanmay Kathpalia wrote:
>> Add SPL_DWAPB_GPIO configuration option to enable the Designware APB
>> GPIO driver in SPL builds.
>>
>> Changes:
>> - Add SPL_DWAPB_GPIO Kconfig option with SPL_DM_GPIO dependency
>> - Update Makefile to use CONFIG_$(XPL_)DWAPB_GPIO pattern for
>>    conditional compilation in both SPL and main U-Boot builds
>>
>> Signed-off-by: Tanmay Kathpalia<tanmay.kathpalia@altera.com>
>> ---
>>   drivers/gpio/Kconfig  | 8 ++++++++
>>   drivers/gpio/Makefile | 2 +-
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> index db077e472a8..00bf974c0f3 100644
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -138,6 +138,14 @@ config DWAPB_GPIO
>>   	help
>>   	  Support for the Designware APB GPIO driver.
>>   
>> +config SPL_DWAPB_GPIO
>> +	bool "DWAPB GPIO driver in SPL"
>> +	depends on SPL_DM_GPIO
>> +	help
>> +	  Support for the Designware APB GPIO driver in SPL.
>> +
>> +	  If unsure, say N.
>> +
>>   config AT91_GPIO
>>   	bool "AT91 PIO GPIO driver"
>>   	depends on ARCH_AT91
>> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
>> index 73c94329e36..da2c02b32da 100644
>> --- a/drivers/gpio/Makefile
>> +++ b/drivers/gpio/Makefile
>> @@ -4,12 +4,12 @@
>>   # Wolfgang Denk, DENX Software Engineering,wd@denx.de.
>>   
>>   ifndef CONFIG_XPL_BUILD
>> -obj-$(CONFIG_DWAPB_GPIO)	+= dwapb_gpio.o
>>   obj-$(CONFIG_AXP_GPIO)		+= axp_gpio.o
>>   obj-$(CONFIG_DM_74X164)		+= 74x164_gpio.o
>>   endif
>>   obj-$(CONFIG_$(PHASE_)DM_GPIO) += gpio-uclass.o
>>   
>> +obj-$(CONFIG_$(XPL_)DWAPB_GPIO)		+= dwapb_gpio.o
> This should be PHASE_ not XPL_.
> 
> -- Tom
> 

Thanks, Tom!
Updated as per your suggestion (replaced XPL_ with PHASE_) and sharing v2.

