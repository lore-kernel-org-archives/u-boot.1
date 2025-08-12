Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76058C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 09:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B468329B;
	Tue, 12 Aug 2025 11:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="TzMiACCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 420CC832BC; Tue, 12 Aug 2025 11:45:40 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3794083087
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 11:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiTFWWt/xeUJpGUDfOYyrvMUoM3jFsQYel3nxwpeL85xmQXq7osfCpnzEER439b2Pmr8O2H9afoViAcSZ0xuM2becb2uK7LVULutqs46AEMm1w4hkhQDgVjFEreo9tPKADopuFOZOzVS/GxFWJnVAR7S7tTQXi+1ud3Rb+os63nIYitC+OTgv6mhf7fdB49na/HM0kHcc0kGtkV+yww94Gfw1RHsWILunIYG3/8p0I0yAH242MEWqoMEnKh0MGeQLlpHQlTghSj1taIbYw2SUCNUp5pynX7ZVEh8Yuzf0LRlbk9iw03ziXb4j44UJ4qEvPzyeJf9k/+yRvgw7VELzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPAe1pNRBBXYQHmeBoLzQItXcbA3KcMQXlLkcqTV3XY=;
 b=IrkVj3Qu+iX2kLmC5Zy1IJtoJi9RYWz64i5dIuLZsMa8rPdlmzCIoP7WTOHt44vzAKqQ6u/SWrBPee0JkG5oybUHfDg5IMz7NVQNxeOr/f36VIxxLgxhvFj5SThFs7CAEs9/Gfg2CMTtrpWj0Dqz0aCp09ECOtCExsfG9RqPuSFhGHVB4+UDgKJJbYVeUleM6pZ2Xuy+bY8YMJZpVkc/iTp4qucSYzYNxHuBFzPaCU3E60MySmmupaEW/jlpe0iMmFurrO9AqyaYUiDyiUscnYbLVu4GQyPhnl0ASRaSh+hVBzjctb52uemkl7UYTNzKtTvJ82KT8+ZIJpm2qLy27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPAe1pNRBBXYQHmeBoLzQItXcbA3KcMQXlLkcqTV3XY=;
 b=TzMiACCxPQ9JR4l0NzAl/rrY3ZtM8LTrySfZ2/GQdo/hg0J2xFkae3Rjji1tt1vMtMIl+hVxOck1q46qYVVE8mg6nOl6E7q4ado4xVzqXEZITz1ATOGHOEEDrYwlhjd4+JjPofTStZjtIDgje0wjveQiJutXUpn6ZsCMJyy5qLik8eThgGolRcZZHjJkTjb3mIYyX44F98Wo6+ejMmdyqJzYYwczXrM738XGKhivJ7Y2YY0D9nTrFHhvweYhRox1PEn4G6SE04y1zEELIX2MEDe/ciGgH6Emc+IhSWjSwp1IF4B8cIGC+Y2QIFQX4/1dYVzvz5XH4JdETFu8VtXr6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU4PR10MB8974.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:562::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 09:45:37 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 09:45:36 +0000
Message-ID: <8b94fff2-046e-44d2-8ef2-e4c245a846b9@kontron.de>
Date: Tue, 12 Aug 2025 11:45:35 +0200
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v4 09/24] mtd: spinand: more refactoring
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250809010457.3125925-10-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
In-Reply-To: <20250809010457.3125925-10-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU4PR10MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: d61d7551-f102-4c3b-27e0-08ddd984fd73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVVzT1l3bVRBYS9EQ0Nod1VhUFdYOWpaNk9ORC8raE0zTkxUbXVrc2ZveGI5?=
 =?utf-8?B?NDZ5NjY4ZTRBWVl6bzdraWhnaVRiaUNFaFhwczNuaHlGUWkrMVVabDhmNnRa?=
 =?utf-8?B?eEk4Rlg2bU5ROU8xTi9JMlRhbmZCTC8wQ2xaMXo3V01lY25PbDFDS29ZNGtt?=
 =?utf-8?B?U1dmWDlaQmozS1BoRUhTbVdwRlNzQ1U4M1ZtUzhZais2TVJySE1jeFZZcmpV?=
 =?utf-8?B?S1loK21TdERMUFA1eXlLUDFwK1VNYmtZSDBiRDFJRW1LZFhMTmtKQmtaRXZj?=
 =?utf-8?B?dUhYSGthRmYxcnZTbElsaEt0K1I4UUx6SEo0SDduTGFLNGxZcG15dU1TR05m?=
 =?utf-8?B?aEU0ZVlBSXV1ZUVTeHdCNFRVRTFtM21TWUpQa0tsN0lEb3M2RW92WmlyVlp5?=
 =?utf-8?B?ci9CY0N4SDhKNXNUN2IvbVNOUjFFNXNjc3pSZzFWd2dYYVBVQ3kyU2NCUFRj?=
 =?utf-8?B?cmdZcWlMc3J0ZFBrT0dnU1BkSDZWUDhtcmxFT2ZYaWQ2OXlwdXVxR29nYXRM?=
 =?utf-8?B?OXU4TnZuUTk4MGxibjFYNlg0aC9vZVlKSTV4azliREkzbGJEQ0QwcDBLaktu?=
 =?utf-8?B?bTNqS3JTYnJwSnJCN2ZhYWg5SiszVTZoQXR1RnErZWVIZmF2dW54MVBrWlBC?=
 =?utf-8?B?aGJtWVBqS2RzNUxTQ2lhWHd0RUJLLzdMOURQTmYrV1dNcWN4VUVQdFh2ZXNI?=
 =?utf-8?B?RGlHcmlicmk2TDVuUjZES2M0ZW9vUGIyejJ5SmsvM05OTnRYS005cHZrL2Nt?=
 =?utf-8?B?KzA0UHlTL3lSdG1YY1kxZFRQeVY3T3NIVW1XSFBXTDh5ZnhLWXVDTjY0ZTVZ?=
 =?utf-8?B?ZTRSVGJleDBDc3RCRzlmaVUxTUhIL3RIZ1AweFcrMU5nVEdmcVB4b2lTZ25K?=
 =?utf-8?B?Wi9VTFN5UkwvZFBIZDhsUjV3WVhvK2I1MzJrdXVncTk1ZWdyU2Y2cEI3MVFI?=
 =?utf-8?B?Nlh0RFh0MGp4ZlRQYnJUL0VkQm5QSmZGbnhjcDlqWSs2aFJiZm1hdXdkVDgy?=
 =?utf-8?B?VTNxZmNXeGoycDFCM294d2lmOVRoQ3dGZnRmbkh3YlRNeWFHY3VJSUgzbnlH?=
 =?utf-8?B?enhycUcxQndUQ0czc2JINW9sbkwydk9kOGt1NkpEM2pnd2FLVWg0U3U0b3p0?=
 =?utf-8?B?MVFjdi9Pa0N4V2IyajNLczZsdHFlNlhJTEk4MkJOUU96SDF6VWEwaXJkRkhm?=
 =?utf-8?B?bUs4eUtwcWhyU3BmdFF0OGQzcnozZllwVmRmQ1Z0VDh4VFVyOG1ERGhnSXZk?=
 =?utf-8?B?ZTdjOThOdW1BczZhSGdQdGxMR2JSV1lqZG1hSzVCeDllM2N2N05hZWpwUnBM?=
 =?utf-8?B?TzFGM1JZV05RcnNqd2ZRZjNrTFE0STBUd2dla0o1SWJKMjlBK3dwazFuNk12?=
 =?utf-8?B?ZmFzU29Bb2s1TmIyc3FKcHVuRTJTeU9JbWxBYkt5cjFsZVBPalhtMFRsSGFy?=
 =?utf-8?B?dGs0eVpVN1Exd2ZTSmkrNEFIY1A1S3NJYTZxUDNUU2o1d1Njb1U1QzV0cHR2?=
 =?utf-8?B?NWFaUjkyemVVTVZwalR4QXkzeGtSenNlQ3hzVFBNTm5odnFORTdnSUtvWlQv?=
 =?utf-8?B?VTdiMzZsOVYzYW9nTmFCNGxGdUNHSUg0VEZFVERkaVBuWHdCWnFGcmt6TGwv?=
 =?utf-8?B?UmRzSjJucWRBNm9tb3BJNVhHeWxPejVKQXhMTDNNci9yaHhUb24ydUhJSmk1?=
 =?utf-8?B?ZzJRdVlNLzQ3cERVcUppTTd3enV2UTdMRDBIbHpCS0pYVmNuWXZTUzNRNmpI?=
 =?utf-8?B?aUlJU3dVWjY4eU9yTWo1TGFZMTFWK0VjUytyMFlUMXJLS2QxTHcrRm9CelBq?=
 =?utf-8?B?MjdpUm5aWjN2RXozVUdNRzJ3SlBSZHEzUmpWVDdjeDh5NTZiTnFpNUd6TFlG?=
 =?utf-8?B?WVlQbHM0OFdmejNoMWNRTjA3WkYwbUoyNGU2Ukp0WmZlZGc1WENuTnZzYXJO?=
 =?utf-8?Q?C5RXCJAYQw6FR9cYJZjtft/+CTp8xlfc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTBjT2ttRzZKN2I0OXdFR0xBbHBDVTNkaDVFa0x1VzlFZXBYUmFjam9jdjhq?=
 =?utf-8?B?UWlvR0NtM2hQS0thZWFWM1h4TVpoSUNXUkxsOGtnSEFaRXV2Q1dzczNsekdX?=
 =?utf-8?B?VERrQkhuK0FZbjdReDdYTk9vNG52ZzJ2VWNDZzVNcFE3dVhDNEFmOHUrMFlo?=
 =?utf-8?B?dmdKNm5DSmFNb0ZEUklCME5WUEova0RnZG82VnliUUd3SWFZOG16MzNseXZL?=
 =?utf-8?B?SndQS0ErMHpoN2JzbWVlRjlDS09iS0VGeEdjaGp0UGdkdGw1TVE4K0VNUWNC?=
 =?utf-8?B?cmdMWkhHNEQ0dHkrcTN5dFdHVjlVOTk3b2JZVm5NQTVQQ21jT1pXOU1tUVEy?=
 =?utf-8?B?L084RXl1UityTHBCS2I0VVlWR0xjM082c2FoaEZWWjM2ZG1qc0c2cnplRHhj?=
 =?utf-8?B?N3MrN2krdDN2b25YcG8vTnhEYlZXanJ2VlJUUDM0U0x0VXl0ZTFDdWlieEgy?=
 =?utf-8?B?aksvRlNoM2tLUVNuQ3Rac0VWKzlyL1Nic2xETzNmR3N3M0dBQnBTU2RaQnZM?=
 =?utf-8?B?VkFsc043dG96dmhKR0ZiSXFFT3pWcXFya2JZcG5oblo2endEbVpmc0ZZcjQy?=
 =?utf-8?B?cWFrbVM2ZFFCRTZ1ekZ3czVFcVRBQXNDZ25ZTy9rZC9KQmZGankyNzFsUWtj?=
 =?utf-8?B?WjZoalh0bDgyQmxnUnFETDBtZkhqOHhBL2xKSGd4VWd0QlAwTHBtUUN1YzFw?=
 =?utf-8?B?eHpDUHpORG9MZU5mVTFnTS9ER21wMTdUK1ZwSEtFUHc1VGlyb2ZQbjBKMXda?=
 =?utf-8?B?RStDd29ybVdlYm9tTWYzdVpJYnJ0UVVCYzNpTGRlK1N3a25yTm0vdjZQYjhk?=
 =?utf-8?B?ekVNeDk2L0tHSGhLVlZyT2xQLzBEQ0ltNlVUbTd4OWNsemZqQ1pSbEhsOU9v?=
 =?utf-8?B?K1FmclVRTjR5dGJMYzB5S3JSYWord0ZLOGZZSmJacHNYcWNaRTAzNlZ6T0FD?=
 =?utf-8?B?QURGcFltMXNhNnNDbEtpVFZrbFpvNzNzQXFQMmRTemJJVWZDOElYR0N1bXRZ?=
 =?utf-8?B?TkhIbGp1U3JYN1hiTkd1WW1uVmYyWE50cFBxRko1SDY3eXRwRzl2S3dSYkNq?=
 =?utf-8?B?YW56cUxPWjBzcXczbEtrc0hvdk9XVjVoUWpPKzJQQ0hDbVVnZlRVZzBNdXJF?=
 =?utf-8?B?c210dGMwWitDRVBRSkdkM2t1MmhPUHl5aFVjby9lV0tRSEEyTDh3VS9uaXVL?=
 =?utf-8?B?aE9hMnltT0hJa3I5YTBZK3Evd3pFWDJ0VTFRTUtDazdXSm40clIzNlI2SEFM?=
 =?utf-8?B?V1NURUpnYkVkbUdlaENLc2x5ZTR2a29RWG93RzIrNTQzRlZ6SGY5OHVTRDly?=
 =?utf-8?B?Mzc1TEN3MEE2UFZHUmJkQ2I0RDl0dDZTWUVjN1J0bjA4aG9QVXR6eDUycEZL?=
 =?utf-8?B?SUZlekhVUkhOdW5OOS9rZVl2L1V2YWhwQm9HTGNFL2xONEdKY21BOTI0SnRz?=
 =?utf-8?B?RlVoVjNVcVE4Q1dIQ1lFZnpxWXV5VE1MMHpIZDI1QXNzMEFMbmdONXNuQWNn?=
 =?utf-8?B?TGY5eHF2QVVUSnBOQzBRTmFHdjMrdDgvTVBRdDdnbUpXaTYvZ3VxcmMrTWNv?=
 =?utf-8?B?WEh6cVhiY1pSSWJiQks5SFlWelhobjFvQUEwb3piUi8rNU5YVDNJVlRXTWVm?=
 =?utf-8?B?cWswT0xwVklXUkM0SGNuZ1FXZ0JnVTZ0ZCtzQ0E1enQzZjJISnBHWWhBZS9E?=
 =?utf-8?B?eGxZNkdWMk9oRTFVYjN1OFBXMko0bU5qMmJtUVo3d0FpNkFKejB3YkpkRlU3?=
 =?utf-8?B?Y0poejQ3Vld4VmNFcVErTm05OVdKV0t4TVpRR3hNcE5HV1hmVUI3MXNnSmVr?=
 =?utf-8?B?alg4T0RpMURybm00Mk1TRW10WlRrSzJlbFIyWjcweXVKM1ZyZFFXV28vQ090?=
 =?utf-8?B?aHFycHJpRVQvNkRCUEpERTRRMGNWU2FvRXdGeDhDSkNIZ0IyRkFlaUFxd3F6?=
 =?utf-8?B?bTdRL1hMaERWSEQ2Y09iaVAvWVg3Mk9RSHh0MGJnUEQvWGpidUk3amF5UlE2?=
 =?utf-8?B?Z21vRFdPckU5UEhFc1A1VHhrb2dHY1JJeTJqVG8yWVd0UE0zR25HdFRmMDZm?=
 =?utf-8?B?RmRhRFcrbTlGVHRzdTdXU3BQQ1FPZ09yV1hKWlp3cFcxREI3Zkl5b05EVnk2?=
 =?utf-8?B?MVE1WWJkWXRjK1VQMDM0dFBoZHVzN0kweURoYmdKZENCSS8wY1lERkk3UDRi?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d61d7551-f102-4c3b-27e0-08ddd984fd73
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:45:36.8925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEkhoYxGF8SWeK7UW2fSWYfJDsLpy3iPOY23CVxtFSHEHFRqJFfk7okc/jsNhVUuwnDOVJa0aduivokVOTX2xhxwNbJdjVtjxPhW6j5u10E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8974
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

Suggestion for subject:

mtd: spinand: Refactor ECC/OOB functions

Am 09.08.25 um 03:04 schrieb Mikhail Kshevetskiy:
> changes:
>  * Move spinand_check_ecc_status(), spinand_noecc_ooblayout_ecc(),
>    spinand_noecc_ooblayout_free() and spinand_noecc_ooblayout close
>    to each other.
>  * some code formatting
>  * remove comments not present in linux driver
> 
> This make code more close to linux-6.10 kernel driver

Nitpick: "This aligns the code with Linux 6.10."

With the subject line improved:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/core.c | 115 +++++++++++++++++-------------------
>  1 file changed, 55 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index df59d3d23ce..a6353b37e7f 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -222,6 +222,59 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
>  			       enable ? CFG_ECC_ENABLE : 0);
>  }
>  
> +static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
> +{
> +	struct nand_device *nand = spinand_to_nand(spinand);
> +
> +	if (spinand->eccinfo.get_status)
> +		return spinand->eccinfo.get_status(spinand, status);
> +
> +	switch (status & STATUS_ECC_MASK) {
> +	case STATUS_ECC_NO_BITFLIPS:
> +		return 0;
> +
> +	case STATUS_ECC_HAS_BITFLIPS:
> +		/*
> +		 * We have no way to know exactly how many bitflips have been
> +		 * fixed, so let's return the maximum possible value so that
> +		 * wear-leveling layers move the data immediately.
> +		 */
> +		return nand->eccreq.strength;
> +
> +	case STATUS_ECC_UNCOR_ERROR:
> +		return -EBADMSG;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				       struct mtd_oob_region *region)
> +{
> +	return -ERANGE;
> +}
> +
> +static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
> +					struct mtd_oob_region *region)
> +{
> +	if (section)
> +		return -ERANGE;
> +
> +	/* Reserve 2 bytes for the BBM. */
> +	region->offset = 2;
> +	region->length = 62;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
> +	.ecc = spinand_noecc_ooblayout_ecc,
> +	.rfree = spinand_noecc_ooblayout_free,
> +};
> +
>  static int spinand_write_enable_op(struct spinand_device *spinand)
>  {
>  	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
> @@ -413,9 +466,8 @@ out:
>  static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
>  			      u8 ndummy, u8 *buf)
>  {
> -	struct spi_mem_op op = SPINAND_READID_OP(naddr, ndummy,
> -						 spinand->scratchbuf,
> -						 SPINAND_MAX_ID_LEN);
> +	struct spi_mem_op op = SPINAND_READID_OP(
> +		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
>  	int ret;
>  
>  	ret = spi_mem_exec_op(spinand->slave, &op);
> @@ -445,35 +497,6 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
>  	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
>  }
>  
> -static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
> -{
> -	struct nand_device *nand = spinand_to_nand(spinand);
> -
> -	if (spinand->eccinfo.get_status)
> -		return spinand->eccinfo.get_status(spinand, status);
> -
> -	switch (status & STATUS_ECC_MASK) {
> -	case STATUS_ECC_NO_BITFLIPS:
> -		return 0;
> -
> -	case STATUS_ECC_HAS_BITFLIPS:
> -		/*
> -		 * We have no way to know exactly how many bitflips have been
> -		 * fixed, so let's return the maximum possible value so that
> -		 * wear-leveling layers move the data immediately.
> -		 */
> -		return nand->eccreq.strength;
> -
> -	case STATUS_ECC_UNCOR_ERROR:
> -		return -EBADMSG;
> -
> -	default:
> -		break;
> -	}
> -
> -	return -EINVAL;
> -}
> -
>  static int spinand_read_page(struct spinand_device *spinand,
>  			     const struct nand_page_io_req *req,
>  			     bool ecc_enabled)
> @@ -1074,30 +1097,6 @@ static int spinand_detect(struct spinand_device *spinand)
>  	return 0;
>  }
>  
> -static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
> -				       struct mtd_oob_region *region)
> -{
> -	return -ERANGE;
> -}
> -
> -static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
> -					struct mtd_oob_region *region)
> -{
> -	if (section)
> -		return -ERANGE;
> -
> -	/* Reserve 2 bytes for the BBM. */
> -	region->offset = 2;
> -	region->length = 62;
> -
> -	return 0;
> -}
> -
> -static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
> -	.ecc = spinand_noecc_ooblayout_ecc,
> -	.rfree = spinand_noecc_ooblayout_free,
> -};
> -
>  static int spinand_init_flash(struct spinand_device *spinand)
>  {
>  	struct udevice *dev = spinand->slave->dev;
> @@ -1187,10 +1186,6 @@ static int spinand_init(struct spinand_device *spinand)
>  	if (ret)
>  		goto err_manuf_cleanup;
>  
> -	/*
> -	 * Right now, we don't support ECC, so let the whole oob
> -	 * area is available for user.
> -	 */
>  	mtd->_read_oob = spinand_mtd_read;
>  	mtd->_write_oob = spinand_mtd_write;
>  	mtd->_block_isbad = spinand_mtd_block_isbad;

