Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDECD2F33D
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 16:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D2D2808AF;
	Tue, 13 Jan 2026 17:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="oBECqkX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEC6E80B98; Tue, 13 Jan 2026 17:31:20 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8AC803F5
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 17:31:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9oDtQFcS1TBf6v53gzdpOzbG74Ygj0PPoYTuYwJRY3kHbs+u18hom0tEps3wF2id4XJcRL+AGJ4Vz2AYtVMjlQv3VDdtGGPAFCPGaciI+eSHio9jJc/rEXD5WogMkpkMbXPKHMWaud4zw2hf3/HPMjslCrgiCNctlW8u0MKJniH601nyjMzQJc9nnKglGhOlSbraBAPq/APf0DlxIQe/mH5ZFno18Aqwe3QHcJq7E9+S8U9BnY/cdsGwWJoF2MI/lAEany+8d3hGTNJXfXb9IGb99/VCALBz1cN3aVw675FA7LykDUArIdNfyK1N1CaBFyIhuuRX5G83+5//7k2HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s87X1uhVI9VH2kNb8RHMIvrvFvYWwXBVpydqi8RfUq4=;
 b=xF+xuYM/zNkPOPLk53oZs3cvbWAYti3acs90Jz1KfgQhMFXkBpCidwlgHSMCcKev330OG2kjR/d3R94VWn+dettGtbcWB9W1er6NjKS8Iaf4su9y4csio+Ex4wDtRPfJ57ZfppOEUEMMhZhUwoUIinEy0POmle+gKz1bha8TAJpZXjd/AIa5Cd8ofWw4+4ugbJtZ3jj+daUe19HqszFXrVSTcc4XP10ma24X/r/Qz8yMNlNiXTyEymcr7kCUk4xNZd1nxU0oO9R2G5hGN7wMPPOLEHVj9/v/ub3wqn8Gs3KDuLK96eUnkzxJwpNA9CnkfZGAn1BgACUKEd+xWhW8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s87X1uhVI9VH2kNb8RHMIvrvFvYWwXBVpydqi8RfUq4=;
 b=oBECqkX6RRly2Fw6H+run/bwRGMF4o9ZwoOnu2s3r9YKKzJY+1ES47VFqq9NEg+zPWbVPwovr7jvBTh3jXE7ouBnligehOYzO26OhNkfIEiBMK8p8lVgmsFsxdkCgLRmpVCO2xVLlRpbRr+UZNSsyn6rdx8k7CAcNglj1TtiJ10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB8962.eurprd04.prod.outlook.com (2603:10a6:20b:42d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 13 Jan
 2026 16:31:17 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 16:31:16 +0000
Message-ID: <7030eca6-457f-48c7-9729-40f0b684edad@cherry.de>
Date: Tue, 13 Jan 2026 17:30:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: tftpput: Rework to exclude code from xPL phases
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: jerome@forissier.org
References: <20251225153721.1217202-1-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251225153721.1217202-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 689a00b4-b97c-48ff-0b8c-08de52c12cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3B0OE1GQmJ4alUwSEY1Q3hWZUF2Mm5jTzFib1d4SVJFNk5tZ3Q5bVRwODJ1?=
 =?utf-8?B?WkYrTG8xSEtGUzZ3VitnaStjbHZwMTc1THFCKy9SbkxrcFNpVk1mUDZEQ21J?=
 =?utf-8?B?MFpQWmZicklSUm9scytMc3lGSHhBd1RqdW4xaUc0bHo0QkFlWm9CdUZXbkwv?=
 =?utf-8?B?V3IwZUJvTGFjRE4vVGo4dlBBV2FNc0wxbHQyTWI1VXROOTYrNlhuZVdOempH?=
 =?utf-8?B?NWVmQzdBSWZYMmRSQ3pBNUdKSC96a0pkdWdsUFRSWkdHcDRWQzdsUjQ2MnFJ?=
 =?utf-8?B?VUk4Y1NmTUdDY2RPWFJxTU91Y2FXMGJEZzdSSGsweXEwQW9KMzNWbVFQNloy?=
 =?utf-8?B?amIwY1dKM1VwSjlqYXRCS3UvZjdWRmZFMDJsV01JalQvd2VXSkgzRVdYaXAr?=
 =?utf-8?B?eXFQZDYwc0ozbzc1L05hWE80ZDBVekZNa1BjT2tTWVRWRU1QMVVHUlZPNnNx?=
 =?utf-8?B?M2szSURLM3hzOWk5UytIRER0SkJYdEJOV1BYdWdteUYrbkpKYkwyQkJ4YWlH?=
 =?utf-8?B?Z0lXQUxKeSswSkFIZ25wZml4a0ZwUGJUSmJzRUNJMWRud1IxWS9vSGszMjRG?=
 =?utf-8?B?NGY2MmRnVi9CVlpaajNRZ2QwSFRpeEZkZHhxRmxMSW03NFZBQy8rQ1BLdkg4?=
 =?utf-8?B?TXJ3ZGFLYTM5ZXdYUk5rNEZOUHMyRU41b0ZDbW9uWGIzZE5id1pka1Nhc2Vk?=
 =?utf-8?B?dlM0ZUdsN1E3MUYzRmFoN2pDZmx1TVp1a1lERDhWU29DZWRlQitvcytOcVAz?=
 =?utf-8?B?d3F1cnZDTythUVZ6aHhUVkRXZTZNSTQrOFUyQ3VtNkxzZXdHQXZJSmMrejZ3?=
 =?utf-8?B?Unk2Vm5rWFdVMXBWMkNKZVIxQnl4NHl4U3pLREpaSTlEd2dmK3VrQUk5SHhi?=
 =?utf-8?B?U3hyQ0NNdDhNRWY2QkpubEZsRXllWUx2VGtZampTYkF6Ky9uaDlOOFFPaVcr?=
 =?utf-8?B?NU5KR1NpanVJWjNOT2lwc1kvUGV2VVhrSTd2eFlxV2U2b21JSkd0cURuaWxo?=
 =?utf-8?B?c1llVmdLQkpXSXNJVkFsVWVSN0NZVVpqY09ZQU5NWEZDenk4L2RkTkQ1Q2Z3?=
 =?utf-8?B?a3hmVGJUTmpQY2VtWVlYQUZOeitIamNwR0ZnRmVEc1JhaWFlcWhOTG1UODFL?=
 =?utf-8?B?NDhUSVVRY2k5MVYyRFpwdUR1YWF6V0VDM01wcWd5THhpSW95TUFtL0JDamUx?=
 =?utf-8?B?d3M0STNldUJDcFQ4MW5hVlBBTHBlTWpZSUlMTnFhRWQydStNVVAwMGNDai9X?=
 =?utf-8?B?R1JPZHdPRHJDZW5tZlZhK1VQSTRJVmNDMndSTkhPVnB4azlGVy9DZk1sVXlM?=
 =?utf-8?B?U0lWcDBsZFByUi9uV2ZYSmVkWjZqOWhOUXlWSm90eFN2QWxhZ0dSUERNZXEr?=
 =?utf-8?B?ZW9QNktNNmI1eXhlckRyVHErYjZXTkFuRnR6cVR6Z3JJRis4Ky9sSFNsSUYw?=
 =?utf-8?B?dm13S0ZMRll2MFIzQlErSVFGc2g0SkdQVTlSOFJtZW1zd3dTbTcrODdYMUJC?=
 =?utf-8?B?OHMvNm5HQU82UWc4aklGRHhaaGc1bkkvUXBrb1BZK2t3V1l3QWdvVHoxd2Iy?=
 =?utf-8?B?czM0eDJNSFExNHMvV3psTUFTZ2l3MXBHK0RCT2FNVWMvV05JZnZ3dmVxT1dO?=
 =?utf-8?B?UlpTbHJIa0EzZ0d4VXNML25Pd2dSNndqQVVoajQwQXpiYUFKZ3YvYW93UFpi?=
 =?utf-8?B?cnVTRHFvd3R6TmFteENtQ3pLRVcxTDdFU2E5OVVWbk14ckVDTk9pWDJnZUZl?=
 =?utf-8?B?Y2JOSmJ4cEE0a3hXQ1hRVWl3aGVjOVF5Kzg1N2JsVnB6bmphNzJNRm0wWXU1?=
 =?utf-8?B?b2pES0RrcFpvTFRlZkIreEZyY2lOY2RGYXJ3RU5ZR3ZHamZvVlcyaWV6U0R2?=
 =?utf-8?B?TURWb0h2UTNyd3pNRWRrU0RrVXdsdmJBb28zbWN4ckVxWUZWT2JHeEkwQTY2?=
 =?utf-8?Q?CM+qY1oAv2jC3BBSwHLYqXL2Bnot5oah?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHIraUtEakIvbGZGVjN0Y2RYRHpSWFZLU1Y4d0hEdU94V09Za0dhNGVVSEJs?=
 =?utf-8?B?Y1pObldVREloRVJBaU10aXFxYmJVc2VLZSsxWFN0YlNhME8vRGl3TzZhdUYr?=
 =?utf-8?B?cmhSSDR0WlFrc3BxcThycElWYkwxcmVtSnpJalM5YTkvazVvTnhlVEVaUGp6?=
 =?utf-8?B?Uk93aG13cGlXTUtVVkZka1FsUE1wRTcrKzR6QUdYM0hOY2N3NE5DZFFzcENp?=
 =?utf-8?B?Z2lSYU4rVFBkRGE1cUoyT2NsSExFUGY3ZjlmNG5YZFlSSUZqL0VIVlBRcXdx?=
 =?utf-8?B?ZDZZV2Y1U3BoQW8vS0p3V0lTdjBiT2t5WE56ZEgwYTlZWDZVeFZxY0tLcDdT?=
 =?utf-8?B?WnE0eE1ZRVN2Q01UL1BNZ0FJQXRLVFVld3EzMDFXMXBCL0NHWC9ORWpNNXMy?=
 =?utf-8?B?endtNk5vaTJ4YUtabzNlVWRhVXA4MW9WMWhOMEtMTHdhbjk2a1dNLy93cEd2?=
 =?utf-8?B?RlFvUmZZSUkxSmR4SUdyQW1BQUtYWXBQcVBORDJwd1V6dHBGQk1JbjcwaFZM?=
 =?utf-8?B?T21tNnZOUkl5TFdVUlkyYnRXNzZ0ejVlcndpRVRwRzMyMEdJdE52UElzQzVl?=
 =?utf-8?B?UzdndU5qS3lTdnFuRGZET24vUkF6MHhLOFJ3N0FXNjJHbmRNd0o4S0drNHRZ?=
 =?utf-8?B?OUU0aWtaOXQ0UWZOcHREaCtUUFpsdll2eDkrS1pYTDRhYjU0U3E1TktYQUhK?=
 =?utf-8?B?dGhKMUxJZTZ1ak4xZjExVEl0bVA5K003ai9MWVJOME13bmFjdXF2TlNvT2VV?=
 =?utf-8?B?Ui9tTlQ3bEMvNkdaWm1uTGozR0ZwTTFQYWh1RmFoTjlmZS9FenpVOStSdTVO?=
 =?utf-8?B?bzBlRnF6VVNTQWxTQ1VrUk55U1hvMHQ4dTR4a01DK1kwbGVDUm1NdGV2Wk1K?=
 =?utf-8?B?VE1oYlRNZkE1bVFhR2dzK080SlNoVVpOZy9ORUhXTnNtK2JESXhPcW9BTEND?=
 =?utf-8?B?M3RpYTZDWXJ2YWZiY0JKMTBGKzEzY0YrcnhVdG9UT2cybFd1L2F4SzBnK2V2?=
 =?utf-8?B?ZEtjMXQxdDZ4WHFxK284bUVlcTZiRi82OUpnS2JvVjlpeVQwV2Q1eXA1L3Nm?=
 =?utf-8?B?aHpBNjAxZ3lTbFVRVlEwWjZFazJXNTZCNnVMUXQ1RURiY0o0bXFWRWQ1c1BI?=
 =?utf-8?B?Zjg1N0huczBIZjNXVkJtdWNwSngyK3c2S21KN3lDTUg5ajlLSUFaUCsxNGhk?=
 =?utf-8?B?d2I2b0ZOV2d2OUEzS0lSVm44MVVURHN5RWpnWkxRcXRzbWp1ZnJOSDg3dnht?=
 =?utf-8?B?OTFVU1RZd28weDZWRXZqMFF2bjNDNTc4NjVTZlVBRFFyV1NSM0RUMmNnTDcz?=
 =?utf-8?B?MnpoaGdjdHdiQ1VEN0QwbFJmdmJMNWhJRHk1NjE1eWlFK2g5RGRvKzl2TDlB?=
 =?utf-8?B?akkxM0pIL29USVFhMmJPMDd4MWczOWpwR2Npd3JLSDN5ZWlZbGlUZzdxMGlH?=
 =?utf-8?B?MGRKMUM1bFR4YkNEc0ROQzRRamJSQlIvNGppa0hWa0pqMHZ2aXZmOG9kNHFP?=
 =?utf-8?B?SS9vdENKS002Z0J5QlZWQ2FVWUV1UVk2Z3pFRXBqN3hnUlUwcUQ0TWxUdERC?=
 =?utf-8?B?QmVMTHFrL2c2dTZBZ1JPUEkxTElxK0xHQTNJT1VaK2NhalJ3eWNuTHRvZ2pI?=
 =?utf-8?B?YSt1QXM2RnBxL1RXQ0xZeWQzTmhaMHJrckI5KzZIRXpwZzNsa0xTbjhrb20y?=
 =?utf-8?B?dWM3WklrRDFrWmsvL0wvYkwxeTd5UFFUYnB6bFl5bDBtc3pSSDZJM2ZvaHNH?=
 =?utf-8?B?Y1ErU0d3WTRpc0I0YjdwbWJpNkdZWHRrLys2WmRJTnJRYUJEYTRlS0toVVV6?=
 =?utf-8?B?Ym9JeGNMRWpucFlyd3JQVElEZmpsOHJJcEpiSW1RQ2JjaWN3cGlyaXFDMXNk?=
 =?utf-8?B?bTlsbmdhckdkUExrVkF1Q2FrMXJjcytEVWFzTmJsV0pqL0ZBV21JdmcxOTE5?=
 =?utf-8?B?ZnVKdEwxS2ErckcxZFBBWHFVK1VodDdaQ0JmeEx4OHRTUXAyNGVnWEJqRk9r?=
 =?utf-8?B?bVY3NVpITW5ra2NBNDBEUHNKUVZ2dm1SajR2Zmt4Z2ZuaXJyc2FyclVDR1Vu?=
 =?utf-8?B?ZlBkL2pMNnNLWWNTZzExdTNWQUZGTGh1OHo1dVNTOWM1VmRwSUo3YWwwRE94?=
 =?utf-8?B?amZ3WmhVN1dkK0l6OS81N3FPb1FMQVVzV1J2MjhFR01vYldMcnd0aTN5NW9r?=
 =?utf-8?B?a09XeW53Ri84d0NWeG1nT0ZuY2t1WGk5Q0diVlNHdlYzcHM1MnJHRjlwS0pk?=
 =?utf-8?B?a1BLTEp6TXltVC9TcTZ0Y0pOd0Fab1ZJWVAvd0lNYmdxL2lneldBb1B3bndH?=
 =?utf-8?B?VWtGNzVab1laSkVtU0JNOXZPWmFqNVc0SFJ1VDZUUXVlbTdMSGhZZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 689a00b4-b97c-48ff-0b8c-08de52c12cd3
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 16:31:16.8209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0l8UUQd7fwXv9BjYN9QL40IYewClC7xCrC0E/AIzNIzGGTtnvHTsLKZuZbIRTi6EC8wPiCgMsMUHQag9TXMy6s7PeNwcAI3Agkx8sh5OAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8962
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

On 12/25/25 4:37 PM, Tom Rini wrote:
> Given how the support for CONFIG_CMD_TFTPPUT is woven through the
> support for the tftp protocol we currently end up including "put"
> support in xPL phases, if enabled. This in turn can lead to size
> overflow on those platforms as xPL tends to be constrained. To resolve
> this, use "CMD_TFTPPUT" in the code to check for both CONFIG_CMD_TFTPPUT
> being true and not being in an xPL build phase.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> ---
>   net/tftp.c | 31 ++++++++++++++++++++-----------
>   1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/net/tftp.c b/net/tftp.c
> index 3b0f4cd2006e..78ec44159c1b 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -22,6 +22,15 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> +/*
> + * We cannot use the 'tftpput' command in xPL phases. Given how the
> + * support is integrated in the code, this is how we disable that support
> + * in xPL.
> + */
> +#if defined(CONFIG_CMD_TFTPPUT) && !defined(CONFIG_XPL_BUILD)
> +#define CMD_TFTPPUT
> +#endif
> +

Doesn't

#if CONFIG_IS_ENABLED(CMD_TFTPPUT)

work?

Of course, CONFIG_SPL_CMD_TFTPPUT, TPL_, VPL_, ... will never exist, so 
that should tackle it properly and be more consistent with the reset of 
the (recent) code base?

Cheers,
Quentin
