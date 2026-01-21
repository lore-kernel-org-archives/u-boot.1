Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036DAC44503
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 10:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 905B183946;
	Wed, 21 Jan 2026 11:58:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TFEtm+9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DCF983A3B; Wed, 21 Jan 2026 11:58:47 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 347248341A
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 11:58:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myVC5MupNMy9PyVhnlqV0aYarBnUBVRQAzsbdoIWs9IU0KT6E0GZFWL9NfsrMT0JKi2anKB4TQcPJV6V5k7rhEPpogL2ZI4XCdF7KoX6iZtSXtlRhoXHj7CLisMn9LgJc8woW5t1u44cdLmT+YiZS5nMTrmDO/IT/UfjfKIbIh6hgYM8169C00JHCEQw1/vaXSWyvT9zRjgenD86AAPcun0zQwAb0XDlk2Z8AzpeU87OLmiwrqP4YcGbSl03NS+kDQ8rf2KyKvI0QneIAhvR+ehz7m84xSYCxOa4en1qtcDPnNkQoPNQuo2pj2x7/64UH0KPbyWNd9n/wXKsCajDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOk5+1hqSvPVHDkBwsmISe7unF+DU0IHwcRxRNJZvoU=;
 b=Mq4490RZcP1Fy+F/lySQg3C912SwTnIaFc+GIu5OkNLH1oz+ilRvQYRkXYQaUQx9tRYQU6mUQo3+o7G4H/MugtQu/piiBXAI5Io1bk36T7NBJCqpOFJGHFzrQlfJCmPnrI1DajDrGSNmYLAPFx+/O+ju/FKoyg5EwgfNDQibxMjvoRbFbsFZae0mIoPJwalUV98xt0fXD9GN3Hg7Rv7NXFI0USkb7CG1Ct0q5wf+fVwq1+zm98QNkdYxrUbzL3oRE5Wszo+TCR+po9WuZSepwBko9VPMpqKp1Nv2fbIHQwa9+JLrQWnSnLB0a7Ph9y1HDXT60bjMGKSu0aw+p7FoqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOk5+1hqSvPVHDkBwsmISe7unF+DU0IHwcRxRNJZvoU=;
 b=TFEtm+9PBkypaOZNi/vNn7H/FXkyi5EIXAP0clJfSVwd3f8a0ONH2OgSB7gsuethFZG8+fRh15EjfiOHzqtsgA/i3hzD7iEZ5iDQK5FhKgNlwDkb0NwnZ8N8/MEzW+QizlF17uicCWv2W8OaPnatvcJoEfBqGRvc9OYVqv5/YvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GVXPR04MB12127.eurprd04.prod.outlook.com (2603:10a6:150:313::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 10:58:42 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 10:58:42 +0000
Message-ID: <6841ded9-e35b-424e-83ea-090c64d3e2de@cherry.de>
Date: Wed, 21 Jan 2026 11:58:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] doc: develop: codingstyle: Update b4 external link
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260120223405.469050-1-trini@konsulko.com>
 <20260120223405.469050-4-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260120223405.469050-4-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GVXPR04MB12127:EE_
X-MS-Office365-Filtering-Correlation-Id: 3befe76e-2aff-4e49-5440-08de58dc0a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXNzMEZRMVpjbXRKRk84bmd4c1hWWFJvaE5YS1cyeGd6dkdRUGw1TlBJS3du?=
 =?utf-8?B?UGFVSHBGVWx4anRGT3BJZUFpTlpzRW4xZk8zM0FHSEVsYUNFYmxDSDBmSzlK?=
 =?utf-8?B?MlBlTUgwOUQ4aCtNdEFGdnZDUCtTN3oyNStONDNVVGZHcU1nSkVtSjc0c2FQ?=
 =?utf-8?B?UkMzTnhEb0oreTY1alZsUkxRWjJScWZ4eVdwbEpsR2luem0yb3kwZWIvNDZr?=
 =?utf-8?B?eXpWRE81a0lvY21JZHZnNTFPZWcrM01xR0VnVjRwS1VDd2hQZzlNUDhiNFNF?=
 =?utf-8?B?QjRlNGtVZnE2dVliRlJ4WGpRYjZHZG5DK1RYV0dlTTBBOVJCZDNZL3kvYWxT?=
 =?utf-8?B?TzBZc3NXYjZldU9JaUJXRnFXRmpEei9RY2RiUnI4N0VzckFkSUFkajJ2Nkxq?=
 =?utf-8?B?YnRwbmphWWJyK0Q5UmlkWW14MHNRU1pIdlVTbHJDZUE4emQyUVhPZjEreHNF?=
 =?utf-8?B?QnBLTXpCOCtQb1ZheEx1bmRLMk9BZnluaml5NEZ5STJiN01uOG5XbUlUc3VG?=
 =?utf-8?B?QmhjcXNlbmFLeWRQZ1UzV1FuWVJ2M3RIYTFHTUd1cTJTb2grTDd5OVJBV2wv?=
 =?utf-8?B?UHJMelEvTGhBeFVkdnZlN2dwdkdienozSzlaWXVEdDQ2Z0pFZ2hHaTdzZEVQ?=
 =?utf-8?B?c3RLWGxEck96ZVZYei85dnhsRHdSempqN3lGbDFodzdsc2t1L21EWHNCS2l1?=
 =?utf-8?B?Z3pZcDY3ZGFnMUJCL1hMNnJ4VzIvcHRvY1hneDZ6SitHUGFIY1Y4Y01VMjk3?=
 =?utf-8?B?bVhUMk4yVFNXdjZqazVQYWJkM1Iza1pOT2JnTndSdkN0dUQ2T3JINmxCS3oz?=
 =?utf-8?B?bWFnVGF0NTlwR05ub1UyVnYrSkp4S2RZZDBDbmFEaVdQeVk5eDI0WlV5NTI4?=
 =?utf-8?B?SjBFN0l5Vm1CK1hjVVZFR1BNSnl6RGNzMVVmRm1pbkFETy9QbDlJaXVOWXdv?=
 =?utf-8?B?RDhhV0JlWlFsTU1lSjFHbWFxNFU1QklqMzIzb0JOZ08xL20xdDBHV0hMSVJz?=
 =?utf-8?B?VGxZWURJQTA1REkyaW5MOXF6UXRFS3cxOGtNQUxSUG5zZGEreFJ1dHZNR1JH?=
 =?utf-8?B?TnBrTW9zaUhzUmc1bGpRd25pU2FUVkZnekd2NGc3L0Y1KzlpRTJEYXpuVmhS?=
 =?utf-8?B?cXNaR0kvbHdrZm80d2pUMDRhRTZ3d1dUUDYvNC9EQzZ4WjVUR0tVMDFXTGxq?=
 =?utf-8?B?SnBiaEc2TGliLzRVOVZJYUZMRzl4OEJCczdod09lWk03SXBLb2tkK3oxNzBL?=
 =?utf-8?B?VzhiMEtsS055T0lMQ3hhTm15bkZ4Mmh4d0hmajhHVWpWMmNwQUMzNEc2UEVZ?=
 =?utf-8?B?U3FkcHVpNVRJcmFkZEJlMWJEeWpEYkhyV2hKNHB0NEUwR3g3ZzJ3WjNYMFFR?=
 =?utf-8?B?a0ZlWmlVd3dUNUE3MW5BUDN3eWZXbDJwYm9jZ2tCN3F0K2xPY082ZktYTGZS?=
 =?utf-8?B?aXQyT2RXNHl2YmNZOFUvYXlCWW54VGllSW5mNnRJd2FMTE10WEhEZTFIUUZr?=
 =?utf-8?B?TGRJSlgwb21pVFkxM0lsdFVuVGtaeDFGSHAvZ2pvMUpRdDJHR1hkU2JQcXJK?=
 =?utf-8?B?WWRwUzVwd2VyeFQ2UHVqMHN0STdwdjF6eFAySmdqNk53KzRUS3RZL2M4NlV3?=
 =?utf-8?B?V0ZnWnpqUWJvM1p6UGVaYjlvd3g1V1FmUHJEUDFLWm9DNEZsbmpUQkw4QWdJ?=
 =?utf-8?B?T2xDNjI4Nzh1cEd5OFIrUFl4UFhtbDJ5STBLcUJleHZ2cU9JcTJpM0FRam1O?=
 =?utf-8?B?VU5CT29USVQrK1NJakR5aVdLenovODZ0Tzk1bjRqa1BCUjd6aFh1T1dKL1JX?=
 =?utf-8?B?eUxGNkJqR2x1UjZRU21nbkgzMGJkcTJHUUlsM2VHNS9Ec09jOFROR2JhdEhN?=
 =?utf-8?B?ZURFNWQ1bHF5eWd5eEN0Q0laRVc2QkVDTDArNUE3THBjd01CVFlMWkpCZ25V?=
 =?utf-8?B?WlpObTg0am1ZOFJBVnc3dk5QbFFQQVZPTXlXelRwZ2ZFUWc2YzVBS1dTbzY3?=
 =?utf-8?B?ZnpKQVc4NHkrVGYxWkZHMXJ3M2t3YnpnS0lNVkxheXM2dXlGU1FuYWlaclRD?=
 =?utf-8?B?akx2eURkKzRZNTdHZFlDTTZVaW5LZDdZMlFaZ2tRS1pSVzRkT0F6SzhWNzN4?=
 =?utf-8?Q?8KOA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmNqTTlxTkVxSEt3UHlCM1YwZEFKdllEVlVQWW1xNTE1bGRwNTNmekZPYlg5?=
 =?utf-8?B?T3lXY2gxQ3B6VmliR1IzYjhUclVyUHNoN05Ua0F2c2t4V0trUVZsSkhqdEVC?=
 =?utf-8?B?bnBMWWtHQzFSK2l3UUpoc2czVFp6V2RaSFlSejcyOVFSVlV6Qi82ZWYyQ3ha?=
 =?utf-8?B?cHdLbTZ5Y1k1TDczZVhFWE93eFM0UHJLL05kd2Qvb0l6WHZMa1MyQXQ4TUlk?=
 =?utf-8?B?MXVNVXdrRHJNNHlZSThKdlVVcnp3NWw2WWZwa0VGRnB6bHFPc3VZMklQMjlr?=
 =?utf-8?B?ejg4WTFwVTlFM2tqQTlGdk9MV2UxcjY1b0xXUkZBdHpMS1dhNFI2NXRXeDh0?=
 =?utf-8?B?MGlIOFF4WDd5ZERBd0NyOW9XNUtQZUFWZjJCTXZ5SWdpL0NhakRxVTFTL2Rt?=
 =?utf-8?B?L3J1U3VONXRoMEVnWHNDUUpSYnRvNGY1ZWZoTFBTUE5NMEJPTFV0ZHZFZHRj?=
 =?utf-8?B?UEhVWXhXREd1N1BWaXA3bE5CUnJTbWZuR094aU1HSVVKNXlKZENyK0xyUExN?=
 =?utf-8?B?VnQzWmtYOHEwSk9ydjFGWGN1bTlIdU9FMzI2Y3MwRFcyckkzWUh2WnlBRTIr?=
 =?utf-8?B?MVlrc2MzUWRiMmJTMC9IOXZTMW5JNnZCM1hmVGlzdlUzaHdLUExrZXJxdEFW?=
 =?utf-8?B?TTZ5TjM0WWZoY2wzMjlNSVBqekN1blJvNlArK1F5YnAvdkU0anhZajU2dStk?=
 =?utf-8?B?UWk4T0NPWWNDVWdaRkluR0RnQjE3SzJNa2JBakZ4V09wK3ZQT0gza2ZZZlJS?=
 =?utf-8?B?Qk93dDU1ZEtEODd2QWtNalBxckJnT2xkZjhYS2xremk4bXd3dW5WQ1Vkb3RR?=
 =?utf-8?B?bnd3RDcxd0YvbWVSc3JIUTFGR21WNUduamIzZk9INUVZWlJCeWlyWnhNTm43?=
 =?utf-8?B?N1VoQ2ZFRlg0QVlLZGR1TWozQVlnaERabnpyZE8wRmdhd051eFBXcnNRUmQ3?=
 =?utf-8?B?WjNab0RxeXdzeXRTSGlqRDJjUGVhK1hFY2l6aDhvbkMvQ21sT2l2cCs1ZnNI?=
 =?utf-8?B?RXRsZnBuMlBkZS9vZ0Fxb3hTT09qWmYxclNIaDdwdENhZ3NCQ1BzenhUR2lU?=
 =?utf-8?B?NmRhN1d0Y24xRHp1QklPc083WWNudGRMRE9OcFZ3RVhGbFc3WkdWVWlNSWpp?=
 =?utf-8?B?UEtTeVhjUTRrTktzQTRlSGYyekcvcEZpODZDeVJWWGx1bXZvQklnZTM5TGZI?=
 =?utf-8?B?WU5rNG9nSXpOeE9oR3d5Mk8yY0luVGxrc2dzY2tEei9FMXNMdXlJYVRLeXlS?=
 =?utf-8?B?QXBuT1p5MzN4K2diM01xRW10KzkvTnpDeFZmSkIzQ2k4Z1BtTFJTL2hxaDV2?=
 =?utf-8?B?TXQvZnl6bGFKVWcyWE0xZmJkSDZlV2FkaXFKQmJZODdNclZMZ1ZQbVBXZDd6?=
 =?utf-8?B?dlQ5MWJ6T3dYTlpmZk1GaDVkdk9IeFRiUW14NHkrVzVFNjJMeUxEZHVSSzcx?=
 =?utf-8?B?Zzdpb3drYU1xLzVEbGh0UVI2K3h5dUxBdDFEd3N5YXFDdlFaSnZjUWxac1l2?=
 =?utf-8?B?TE1IMGJSWDVCNWxIWnRPOFV3cVhEWENkQzNoZ3VMbTdtbDZld0ZyM0dUeENy?=
 =?utf-8?B?TGZaUGxIMVNPRGFlUHJZTnE2OHl1WkZkM1hMWUI1ZDJlcTl0ZkxsNERGM2Jl?=
 =?utf-8?B?OTg4NFIwUnZLcUtJeU9lZU9SV24xaFl6b1M5YXFOWUZ6OUlCTGdVM29Wb1ZG?=
 =?utf-8?B?U3J3bW1OSldVTlFGQVhjV1dVNG5zV3RUbm4xaEg1QWlNb1dkQ3d4NGFCV0dt?=
 =?utf-8?B?WGZxRStwMU9WWGpSTGk0Wm01c3Q3Z0hXdVY1aUdFWlVZNjArNTlmQTI4VUdS?=
 =?utf-8?B?aG5yaVMxMWwwSUgzcWo1dUxnNHBwenlBNDRBMFpBdndITWw1a2ZhOEovZ2J6?=
 =?utf-8?B?Nkl5MTZxZ1M5NHpmOUZMbDBZQUJpb2N3ekdTdDhMLzRxQ3lOVWZVbTN3VExx?=
 =?utf-8?B?YjZTaHM5d3c5MjZzQ3c4Q3JNUU5CVTBvMnZ6WG9nczA0WldyQlZiNDBRN0Vj?=
 =?utf-8?B?MmMxdTFnU3dYUzkzbWFJU2NlbE03YXRvTkFXamkyL1hLRjg1T1hKOTRzcEVS?=
 =?utf-8?B?MER5eDNIY1FRQ2RyZkVuMmRiV3ZTNW5QcGZ0d25oU3dkT2xmL3dPOUJNOFI1?=
 =?utf-8?B?MFdHRjUyLzRraG13VlVhTkFhUXFMNTM5TGx2Q0NoVUNyNG9wYnJDd3drZFZi?=
 =?utf-8?B?UU9Za0g1TXpsbjFQMHNSS3FYWGQ4eDcwUWU5V0JCTEFUQXprV3Zrc3VkK0t2?=
 =?utf-8?B?d2hobEN6UzBjcGtwTnBvczhSYzB1dEEvU2NCTEhTU21kcm1wNExUSWVLK1pF?=
 =?utf-8?B?eUE0NUtOVFZ0QWpGZFgwaWErQmxQSm1TeVdEcmg4ZWwzeGRGSnNNMDdpNTB3?=
 =?utf-8?Q?nZtXaQuJukCZU4pLRwVXOFEmXRBsyhzs3u6C6?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3befe76e-2aff-4e49-5440-08de58dc0a2b
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 10:58:42.1216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwLvQnGI/evODj4yye3rfCb3QEMahSjT4NQzg+Mb+gFQiHp7muzCwgzLHxFeYeVCJtlWIUAnprHmGdwl4RXFXUyO6q6VowRo8lzv187OB+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12127
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

Hi Tom,

On 1/20/26 11:31 PM, Tom Rini wrote:
> Rather than pointing at the source code for b4, point the the official
> documentation. Also, use an anonymous reference for the link, per rST
> best practices.
> 

TIL :)

> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
