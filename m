Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771B9EB491B
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 12:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A743E83B9D;
	Thu, 12 Feb 2026 13:44:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AmiI66dN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3C2583B64; Thu, 12 Feb 2026 06:42:25 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 383FF83015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 06:42:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLHuSck0Oxc7lJyl/mt7HMCPJUN56Y7uyz3/ZstoChygfnGFD2pJa0JphCUyzKNqflNgGhKmzvfeMsLKTqv9ECQ5RVREkfbadTtavr+G0QOUDdrUXPO0A9eK8tOJZD87JSr3xAgFYuINrPRFdMU84UIICNVLofTg52NVUj37NskWRg0mWTtbKz2/SYTcugppx1RniosHj8fzmte+mSLsjcwsQe23NqOOWWI2LPo5kW+L+MgyBfFy1TZOUC1TsH9QBWflRu2+U9t1BnDKGKzcp4wbz1ubw5qVhw+6trftWPQmkEUsUgZSVJ2N0M5dFDtxFH8zVUY6ES9NC1S/aBb7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oc0baPkr3xAmSO38H0jbK1NxQ4Pt19RDcm+NX9Cajo=;
 b=xsFfV6u4x+5bcQOM1Idfakk2GO1JBywvrcMK2FKPMqW6raG4bDxy0UKN/EzCV0CK6w5wYlmgxemoQ8lM7ZXeCMJAUY9uKLYorzVjoRfOLW2nLCT1akNv0WVJlzzYmWRvBR0X4w73NAxDHEgHEndNVI/sLZCB3NZklbJpihn0amXofmcIeW9ckG7tYdGwibnxqgk/cfWODWBbm51p9AVVMmzHe7gJdZfc2UZF3NfPqDI/j5+L9TeggrBUG639Mtn5BGGcc/+I/Ph+B4uDK23U3cij7lYIc+4TrmD0Gq3wByEaqE0FNPNx+6E/EawILpbeI0L+JZgaTpd7QwZQu3t9PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oc0baPkr3xAmSO38H0jbK1NxQ4Pt19RDcm+NX9Cajo=;
 b=AmiI66dNw46AZeJkj5VPnyA2dQHSEUUTbuEaMCu/BWFmHyT9PtkXdJ+J7zrJ2cZSaEB+ohz8T0J1P5Ar36G+Ej1jI17y1a77QGOm/SUW1RGySt9AQNH+qowlWiKxwGOZYpQBiKpiF07LdZc6qOGr7cOu50CrJPpT6LhcGEdsf7Sw8BcUBae6nVauSUtTVbWVvKZ6Xt8EbfIPkHeMbiyE+BqeD9Hzyi6xU6vpxgn2Mpem0EL02xTJcOwE6srC5DVB5pzTeX2Ye03IpJir7BeY9Gh62ahobih6iA9QBCqW1xlCp/3JFsRknJKwUbS4ymETJXOCyNtVRmSZrpigVhcPWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SJ0PR03MB6949.namprd03.prod.outlook.com (2603:10b6:a03:43f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Thu, 12 Feb
 2026 05:42:20 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 05:42:20 +0000
Message-ID: <e83ce331-e8ff-4b0b-b4a0-e0b292c79238@altera.com>
Date: Thu, 12 Feb 2026 13:42:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spl: Add generic SPL MTD loader support
To: Fabio Estevam <festevam@gmail.com>, michael@amarulasolutions.com
Cc: jonas@kwiboo.se, trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
References: <20260211222550.739727-1-festevam@gmail.com>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <20260211222550.739727-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SJ0PR03MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: ffdc20d6-372c-40e7-0d5f-08de69f97d0e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGd3cGRITlQ4bHNVZkJ5cTlYMFZyNEw5ZlhVUHJHZXpXZ2pHNms3VDY3L2lQ?=
 =?utf-8?B?bWRkVFVBNHJ0cTlsMlVQVDZLVlNuMlFTeFVRL2ZmZ3NKdFkxWE9xRVhTZEdH?=
 =?utf-8?B?NEVlUnpFdXhrYzAweHBWR2YzYXlIM0hxNENSRk9GQTRhdVFhcUVRK1lHd2Rz?=
 =?utf-8?B?MitLY1FWek90ZmtLUmt3NHhNZURuQi91WHRKTE1nUzRlSUZOYlFNczBmd3lw?=
 =?utf-8?B?TGpFV2tXSGtxTUswbVcwWTljN2xnU0JOVTlnWTYzUTZmNWUvcklJTUo0dnpQ?=
 =?utf-8?B?cEV4UDRiRS82N0NNOWN4TjJUWXlXR3dBSDNZQjl4eXRvaE10Q3lTTWkwK2tJ?=
 =?utf-8?B?VWJ1Tk4zaklaenhCMDNKV0xwRjc4dkdBQ0JCZXhHQWV5aUVFQkpHQjgzUUxv?=
 =?utf-8?B?cExZdS96aHlSUWhYN2gwTnRJR1R6SEczS0dzMVlyakh0dGxqeTdnd2VRVUJ0?=
 =?utf-8?B?NDloYUdGdFJtT3lNQ3dLODhZMGJrdmZNai83Y3F1dFlkUU5QS1NwTUJucmVm?=
 =?utf-8?B?LzJUM0F2VGJPYzRKTHBOM2Z0ZEFtRXMrTVJ2L2J6SE9kMktSYko2MGdPUjQ1?=
 =?utf-8?B?SXQ4akdYdE9WNU1zQ2F6WDRCcHZ1Z001aWxrRmRNMkZBSzNZcy9JQlA3NVBY?=
 =?utf-8?B?RVNiLzBCZm5kcGFMZ2E3N1c0ODBDdnVXbTR6bk1NVVFObER0YitBU21yQ2tH?=
 =?utf-8?B?VmF4UFNjN1Q5L2t4SlViVjBpK1pxNXl6eFV5WFN0ZGlsQ2d2L0hxNkYxVEM1?=
 =?utf-8?B?N1AvYjdpdXUvTEhWSWJRdlpDanpHYnV2UTZJUUpCdlNjU0E0WTBlTGErK2JW?=
 =?utf-8?B?d1k5eFlNUkVwOWhPT1Q5SVBOOFgvcXdRYkpGNDdvd1M2b0ZDOCtwNytyanZJ?=
 =?utf-8?B?QW5WVDBLNGVNOFhuNTREblhuRGpWeUZzbThWV2J6ejROMWNOMEJpMGh0SHBD?=
 =?utf-8?B?VmpLM05hU2xIM0F5NnFZMjlxb2gxVmlWY0UwVXFhRXVvbEdIV1o1YUZNQjJk?=
 =?utf-8?B?b3JTc0wyZ0VNdkZhWWNVMkdLSHdjL3o5eElrL2crSkVWSVhBUzZoclk5RS9U?=
 =?utf-8?B?aDY0VWh5ZkZGTk43ajNRYXphTGxVK0ZZNkhVWHFLSDFJdTZmTUtQTmFEYzhr?=
 =?utf-8?B?VkVlQ0xzUEg5NkpMbzJjbFpiam5GUjZ0UkZKRjN6enlsZ1kwZUIrRnlSejEr?=
 =?utf-8?B?NVNuMm9IUzlEeHhBV09tNnN0SUYvNjRNU1NFcHpybnZPQUJ4RzZjQzVGZCtS?=
 =?utf-8?B?UDAzR09HQzZWMnlVcGZ1dy9iNytyNmFkUzFxNUs5aTdRazQ1cUMyUjhUTHd0?=
 =?utf-8?B?WlJLa0R3dUxzTFo3c0JuZGE4dGtlWE5wc2ZMY3ZpZXcyYjZQODFjQXFONFRx?=
 =?utf-8?B?M0pRV3lFTDNmejNCS3hwbjg5K08wZ0JCT2ltc25ReVhheDgxZWZYcEx2TDhM?=
 =?utf-8?B?aEFhcDZGbDQyMzIwbUZvTjJBSzdDU2lIY3ZHNnBncHRxTGtialZ1c1NTZEpl?=
 =?utf-8?B?QjJ2NHNYNS83Z0pzLy9xblE4TFoyeVVJb2xneE42VGxzRVlBZitqbEhKSWZy?=
 =?utf-8?B?Snp2ckkwQlJGbjhwOHpiNnYxN25GYk8rT3NHMkdSbVo4MjMwSXRhL2R6bE5k?=
 =?utf-8?B?STFMaHlSRkxKMUZLUkF6RzFzV3Rqc2ZKWFQ0Yzg0UnVZbmc3d2djcVdDdVV2?=
 =?utf-8?B?Qmk1eTQxYjY0bHE5a3RYVTBIOUhaa3g1VU82VHlSaUVySGJXUmRxcThzOXZ0?=
 =?utf-8?B?TGR2S0E4QnpPMUhoblNNK0tLZ3h6azhmV0pCeFU0QjRQVnNyc2xNdVRHVUZa?=
 =?utf-8?B?RGNmU3FiaW5WemtxYXdEOXMzTjg2ZXJRbkQyMEJMQTc0KzFpQTBibWZQL2w0?=
 =?utf-8?B?Y3I5dzBxMENleWRmSGpMNkNDdUxmUEdCWGludWdweVExUE5qQUw3R3JyaTBq?=
 =?utf-8?B?YmRENC84Q1BHT251azQxMjBDMk9tMWR0N01qbWRNM0V5ZE85eDB6VDFLRmtk?=
 =?utf-8?B?cXVHSTJsa0dUK3ZtTnNyQnhXUGNLZFZoQ0ZGNlU0T2F6QmI5U01RNDZyV1dW?=
 =?utf-8?B?NVJPcndkK2MyWTBOTmk0amx5VmFpVXh0NTlFRXlBYUdocVBoZWFDak9neG9G?=
 =?utf-8?Q?2EmQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHN3OGt4SVplNlo5MVNrT0poNmNNaFFOclFucUgyVXVQSDQxaElkSXJWMW16?=
 =?utf-8?B?L2RTZHVzMXR6QkRkbWZSTDZLTFQwUnorSHlyYzZzZklmQjdMWThheG1aSlRs?=
 =?utf-8?B?ZFpJUDVvZUcvZldhazFJTEY2WHNMT3plaSt6WGpzOXo2NFdQMXlXUTZqL01q?=
 =?utf-8?B?Qm0yM1VVc1kwT0V1L01saW1Pa2dOMmZ2Q25PN0xoOGdDb0QrVFY5MVNRQ1ZK?=
 =?utf-8?B?MlVzY2RQeDhBQStuczhLTkNzdnNhSEhLdW83Z1FhNCtXV01iejY1Z0txLzcw?=
 =?utf-8?B?SXpxeE5yT21EUXhuZDdsK3lycnZRalhKS21yQnlSZlE4V1VhVTk3L1Qzcmla?=
 =?utf-8?B?WXhnRHk3OExwVjUwSE5heGRTUnIyRmxLczJnOEFvZlFRUnNHWkthd0VEWFhn?=
 =?utf-8?B?K0d2SDVQSTFHekV0amRXT2twMy8rZmVjZDVJdE93S2FjelkrQ3g2Yll3SGR3?=
 =?utf-8?B?cnE4S0JOMWxFbjNFTDYrQVVBZnBwYTBncUJWbVZWZXRFb2wvTWhMRzFkS3hW?=
 =?utf-8?B?YzA4WGZOMGU2UFBtRkdaeEIzdjBtaTg3YzZ4bUI4M2NLcVhCZkp4WTZaNTU3?=
 =?utf-8?B?MzJmVGVkT3M0L244ZTRuTExrb1lFTm96S3NEUXlmTzN4aHF5aElYTXJabE12?=
 =?utf-8?B?REhId0RwZElvUUZvak9wRUZtN3VmRzFhNTdpbEpWUnA1SEFBUEs4K1BpUVFs?=
 =?utf-8?B?MFBwK1BNWFMzNG9lRHk5TS8yQVlJd1NVcVBlejRnWU03SXhFV091eE9jUVhE?=
 =?utf-8?B?N2lCcDJvTTNVN253am5KRnNIZGhxdDBycFJ1ZlV4bDFzQ1pETXhlZklLVTVU?=
 =?utf-8?B?aUVVZE5QY25UendhWGN4NkdaU3RZQ1hmSU9rdlNRY3EyWkVIQW5qNzFtSi9x?=
 =?utf-8?B?TS9uVDBWNG5ybDJOWFFpRzI5WDNvM3FuRlphcGh0V0NBZ2haeWJWR3FGbWVD?=
 =?utf-8?B?dm5HbmtPaXA3MmlhSU0yQ3NZTHhmbVJ6LzVjb3J3d1F5SGFHV09TOGtqcDlP?=
 =?utf-8?B?RFlZSnp6ZklhQTRjSTI2dVZPZkpqNXhTRnR5MXdqVjU2eXVXM1YxRkFUQmNE?=
 =?utf-8?B?TWdabUswcGdMY1o1OTVuYjhUNDFESC9GYTd2ZG84MFBzK204N2NvYy9HcnhX?=
 =?utf-8?B?VjNjaFBIT2tWWnladE4vMnZ4ZUZ2N1JrN2tEa1Fqc3IzTytEN3Y3SHdrNWVa?=
 =?utf-8?B?eTBQMFJhSUYxVXI4MWE4Tm0ybUYrek9wRjN0U0YyRVZIaUxaWGlyNjJiczFr?=
 =?utf-8?B?cklrd1ZpS0MvK3prY1JQb0QveGh1WEN1SFNjRVU3Wk5sSGl5bk9rV2I2YXlG?=
 =?utf-8?B?ejFTcmlPT2NUSzlCMGpSTHRKeDJMOEtjUC9ZY1NwaWNIT0g4eTlZemI3LzVi?=
 =?utf-8?B?Nk1ublVKRmdlWU50cnFwVzVBUkhCcGI4UlFJRlNnWFBxYUszVWhjdnBjTDNP?=
 =?utf-8?B?ZTNUTTNGbXZhL3ZUdlZ1TStyMjVSelFQNTVidUhhSDlCUjFsTzNwN2xvSUNv?=
 =?utf-8?B?QTdrRDZaSHh1QnRyQkFPaGdmZXBnazlQbWhWR0l1dldTVUF6RUZGSjlXeUVa?=
 =?utf-8?B?TzNCSTR2OG9ZOUdEa3VQeDJvSXFCTFBEV3FrN1djcmUxL1k5bmZ2M205YmZx?=
 =?utf-8?B?WWdaSndKWU1Vb091aklnVDFRci9Ea3M1bC8xVVNteDlhMzBYV0VYWW5zMzE3?=
 =?utf-8?B?MDRDd3lyamVGeVpMcHNmdXFkU2ZRWHdWZWdIVjcyRzVoS0U5Snd0am4xbVYy?=
 =?utf-8?B?STNsUW1GNm9JdDM1OHNUaGpkUUV4bVh2andqK0srOHQxc0hQTDdnSzU4akNZ?=
 =?utf-8?B?eGdvWDFMK1ZFYWxtaHZqcmo4NVpZQnp5UkpUbVNHTzhXc0sxcDhiU2ZkN2px?=
 =?utf-8?B?amNmRG1xMXd2cnhicE1qZFZmTkU0NGdaMGVhQjhxdElCaEJkZmcwbnV6Zktr?=
 =?utf-8?B?a2xsdnpoUXJ0d2M0VHh6Z2cwaU5VYTZEWENLMS9MQ3lNaFlua0xlamY0dVFn?=
 =?utf-8?B?aVVWMGh3bUVHcjdza2huMmV4QmRrbllNMU5VYkFyMjQraFV2Q3llUHByYzRr?=
 =?utf-8?B?aEx3UXZtQ3Izd1RBcUJDcG5YQU8rbDZ5YXBuYytVcGYvWDZqNDFTUkJsb1g0?=
 =?utf-8?B?VmRPUFo0dEZ1YytmMk5mSTRLOENHa3FiRDcxWW14Uk45M09LM2hjdUZpN1JE?=
 =?utf-8?B?dDduRWU5bUcxaElwTXVJaDlSaHJZenBrRk1CRFNuYTlrSHErQWhQWjlTTk11?=
 =?utf-8?B?bFFsYU1KUTFRYWgyMlV3ZlVWYm1wTnhET3NOVXo4eWQ0VGNnZFB5Wkh0bUl6?=
 =?utf-8?B?ekhqdWpidFp6b2k4cVJNOG1WeFBHRDBpanVxNkJ1MG9tOFF0cUE2dVVYeC9N?=
 =?utf-8?Q?cZCB4o4rCs3FfvN8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdc20d6-372c-40e7-0d5f-08de69f97d0e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 05:42:20.2287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIVh8z+lCXaznpYejs/v3tME7gEc3DqOryUpre82klLvVdQWHTiJit+vN43sM5RfH/v8Oimj0w1L/57dwD61nkJipA09FpFKD8ikkXO2nkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6949
X-Mailman-Approved-At: Thu, 12 Feb 2026 13:44:52 +0100
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

Hi Fabio,

Thanks for the patch.

On 12/2/2026 6:25 am, Fabio Estevam wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> From: Fabio Estevam <festevam@nabladev.com>
>
> Add support for loading the next stage from an MTD device in SPL.
>
> Introduce CONFIG_SPL_MTD_LOAD and a generic SPL MTD loader
> implementation that uses the MTD subsystem to read the U-Boot payload.
>
> The loader works with any MTD-backed storage, including raw NAND and
> SPI NAND, without being tied to a specific NAND type.
>
> The payload offset defaults to CONFIG_SYS_MTD_U_BOOT_OFFS and can be
> overridden via the device tree property:
>
>      u-boot,spl-payload-offset
>
> To support both raw NAND and SPI NAND boot flows, the loader is
> registered for BOOT_DEVICE_NAND and BOOT_DEVICE_SPI. This allows it
> to operate correctly on platforms where the ROM reports either NAND
> or SPI as the boot source while using the same MTD-based loading
> infrastructure.
>
> The required NAND core and SPI NAND drivers are built for SPL when
> CONFIG_SPL_MTD_LOAD is enabled.
>
> This provides reusable infrastructure for boards that boot from MTD
> devices without relying on SPI-specific or NAND-specific SPL loaders.
>
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Dinesh,
>
> Could you please test this approach on your boards?
>
> Thanks
>
> Sure, seems like the approach is quite robust.
> Let me try the approach on my board and will update you
>
> Thanks
>
>
>   common/spl/Kconfig        | 15 +++++++
>   common/spl/Makefile       |  1 +
>   common/spl/spl_mtd.c      | 88 +++++++++++++++++++++++++++++++++++++++
>   drivers/mtd/Makefile      |  1 +
>   drivers/mtd/nand/Makefile | 12 +++++-
>   5 files changed, 116 insertions(+), 1 deletion(-)
>   create mode 100644 common/spl/spl_mtd.c
>
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 2998b7acb75f..2aba6da73c10 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1576,8 +1576,23 @@ config SPL_SPI_LOAD
>            Enable support for loading next stage, U-Boot or otherwise, from
>            SPI NOR in U-Boot SPL.
>
> +config SPL_MTD_LOAD
> +       bool "Support loading from a generic MTD device"
> +       depends on SPL
> +       depends on MTD && DM_MTD
> +       help
> +         Enable support for loading next stage, U-Boot or otherwise, from
> +         a generic MTD device (raw NAND, SPI NAND) in U-Boot SPL.
> +
>   endif # SPL_SPI_FLASH_SUPPORT
>
> +config SYS_MTD_U_BOOT_OFFS
> +       hex "address of u-boot payload in the MTD device"
> +       default 0x0
> +       help
> +        Address within the MTD device where the u-boot payload is fetched
> +        from.
> +
>   config SYS_SPI_U_BOOT_OFFS
>          hex "address of u-boot payload in SPI flash"
>          default 0x8000 if ARCH_SUNXI
> diff --git a/common/spl/Makefile b/common/spl/Makefile
> index 4c9482bd3096..9f5ddcad17af 100644
> --- a/common/spl/Makefile
> +++ b/common/spl/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)NVME) += spl_nvme.o
>   obj-$(CONFIG_$(PHASE_)SEMIHOSTING) += spl_semihosting.o
>   obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
>   obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
> +obj-$(CONFIG_$(PHASE_)MTD_LOAD) += spl_mtd.o
>   obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
>   obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
>   endif
> diff --git a/common/spl/spl_mtd.c b/common/spl/spl_mtd.c
> new file mode 100644
> index 000000000000..8c6c94e592d0
> --- /dev/null
> +++ b/common/spl/spl_mtd.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * Generic SPL loader for MTD devices.
> + *
> + * Based on spl_spi.c, which is:
> + *
> + * Copyright (C) 2011 OMICRON electronics GmbH
> + *
> + * based on drivers/mtd/nand/raw/nand_spl_load.c
> + *
> + * Copyright (C) 2011
> + * Heiko Schocher, DENX Software Engineering, hs@denx.de.
> + */
> +
> +#include <config.h>
> +#include <errno.h>
> +#include <image.h>
> +#include <log.h>
> +#include <spl.h>
> +#include <spl_load.h>
> +
> +#include <dm.h>
> +#include <dm/ofnode.h>
> +#include <dm/uclass.h>
> +#include <mtd.h>
> +
> +static struct mtd_info *spl_mtd_get_device(void)
> +{
> +       struct udevice *dev;
> +       int ret;
> +
> +       for (ret = uclass_first_device_err(UCLASS_MTD, &dev);
> +            dev;
> +            ret = uclass_next_device_err(&dev)) {
> +               if (ret)
> +                       continue;
> +
> +               return dev_get_uclass_priv(dev);
> +       }
> +
> +       return NULL;
> +}
> +
> +static ulong spl_mtd_read(struct spl_load_info *load,
> +                         ulong offs, ulong size, void *buf)
> +{
> +       struct mtd_info *mtd = load->priv;
> +       size_t retlen;
> +       int ret;
> +
> +       ret = mtd_read(mtd, offs, size, &retlen, buf);
> +       if (ret && !mtd_is_bitflip(ret))
> +               return 0;
> +
> +       if (retlen != size)
> +               return 0;
> +
> +       return retlen;
> +}
> +
> +static int spl_mtd_load_image(struct spl_image_info *spl_image,
> +                             struct spl_boot_device *bootdev)
> +{
> +       struct spl_load_info load;
> +       struct mtd_info *mtd;
> +       ulong offset;
> +
> +       mtd = spl_mtd_get_device();
> +       if (!mtd) {
> +               debug("No MTD device found\n");
> +               return -ENODEV;
> +       }
> +
> +       spl_load_init(&load, spl_mtd_read, mtd, mtd->writesize);
> +
> +       offset = CONFIG_SYS_MTD_U_BOOT_OFFS;
> +
> +       if (CONFIG_IS_ENABLED(OF_REAL))
> +               offset = ofnode_conf_read_int("u-boot,spl-payload-offset",
> +                                             offset);
> +
> +       return spl_load(spl_image, bootdev, &load, 0, offset);
> +}
> +
> +/* Priority 1 so boards may override */
> +SPL_LOAD_IMAGE_METHOD("MTD-NAND", 1, BOOT_DEVICE_NAND, spl_mtd_load_image);
> +SPL_LOAD_IMAGE_METHOD("MTD-SPI-NAND", 1, BOOT_DEVICE_SPI, spl_mtd_load_image);
> diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
> index ce05e206073d..0856a8f68732 100644
> --- a/drivers/mtd/Makefile
> +++ b/drivers/mtd/Makefile
> @@ -34,6 +34,7 @@ else
>   ifneq ($(mtd-y),)
>   obj-$(CONFIG_SPL_MTD) += mtd.o
>   endif
> +obj-$(CONFIG_SPL_MTD_LOAD) += nand/
>   obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += nand/
>   obj-$(CONFIG_SPL_ONENAND_SUPPORT) += onenand/
>   obj-$(CONFIG_$(PHASE_)SPI_FLASH_SUPPORT) += spi/
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index c8169cf73902..cd6eaa87739c 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -1,10 +1,20 @@
>   # SPDX-License-Identifier: GPL-2.0+
>
> -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
>   nandcore-objs := core.o bbt.o
> +
> +ifeq ($(CONFIG_XPL_BUILD),)
> +
> +# U-Boot proper
>   obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
>   obj-$(CONFIG_MTD_RAW_NAND) += raw/
>   obj-$(CONFIG_MTD_SPI_NAND) += spi/
> +
>   else
> +
> +# XPL
> +obj-$(CONFIG_SPL_MTD_LOAD) += nandcore.o
> +obj-$(CONFIG_SPL_MTD_LOAD) += spi/
> +
> +# raw NAND still follows the normal SPL rule
>   obj-$(CONFIG_$(PHASE_)NAND_SUPPORT) += raw/
>   endif
> --
> 2.34.1
>
