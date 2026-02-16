Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324F9E63F32
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 07:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D44280B98;
	Mon, 16 Feb 2026 08:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q1Gizf+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 432E083C5E; Mon, 16 Feb 2026 08:24:44 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F188063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 08:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pxr8lb+ik1osnskiVhFbfrBBQbgNCGtjG/6EJ70IxyX2sY75uT57m9wg8g5bsVd4EclGXFOmyOJnbuOAlPPLJiGPGid4Y+NUDxrrI6zP6Q/zXFIDiAtBRZvsDaPPW8R3JtOMrrSK2VZAZq8hEirNeNsLsByRMBUZChKUQbN/zUBRx+W3e3zcda6rtp2HYRF+yVfXhns2Z+uDlOX2L1hv0GZtp2W6KjTN+fzvd2tD1n55GxF/MauP4JE4qijPsxgimowR7v1Gmk+kRDJKxH4hAZ+CfPo81MJYKKaJvXQARuIusDnOv11PdtXuObPfCcIUE7C95A6LPYZXnJNUaW2wRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/d55ZPNIHo+EeLdV/aOnnXPmu4NouMOnhdNKr+7XlI=;
 b=yQP8Myn+Znz/nRdV86OunA9aDZvtGa3XsC0xZ3KogAgN4c5ihr1NSJuyIpbfpnu/+GnQgQpxk60TXE7V/LxRCx8q6rofNKCICCI6KduDWw/wBhPyndJqNutOi3l62gQOqk0SzXTqUw0m2s4TgPC0akQbnqKDi34ElB4opy4lFuz8qteyqMCz3t/48NvuT3zRqSYeiI82rISv/X4bza1L/3Fn7xRFLNzs4er/ZhwkUbKN4g+GMi6qIClZ9touyd9Qt3JOpg3WUfAejQ4rgHk9Du8lRIU34VL31733p+8D77uJIWvtAu2t5B3p8YTsAcg7wqtgkmT0PbGU/Pl2n0Poxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/d55ZPNIHo+EeLdV/aOnnXPmu4NouMOnhdNKr+7XlI=;
 b=Q1Gizf+teBEb9GP8tzIWA0tdUib9QV6lIzNfAZmvpeBAUP53OiXgNY9XAC0y2A79SeX1AVxbKFZ5ENM0FG2bkvuzihBEoPX/GCxULc5i0B6YvOWM+gj76QgIPTIO5+mYQJdfKBoiPHNfhOfFzJbigPHBXnmfDv12rOavtxaeF5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 07:24:31 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 07:24:31 +0000
Message-ID: <e5c63fcb-c88b-4550-bf5c-de46a66db0a2@amd.com>
Date: Mon, 16 Feb 2026 08:24:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] efi_vars: Implement SPI Flash store
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Shantur Rathore <i@shantur.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, git@amd.com,
 u-boot@lists.denx.de
References: <cover.1770825377.git.michal.simek@amd.com>
 <35ddf2fe394ee55c66f349dc5cc33fe1dda8f864.1770825377.git.michal.simek@amd.com>
 <1508c7be-0700-43ec-adfa-29ea16081b2f@gmx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <1508c7be-0700-43ec-adfa-29ea16081b2f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0213.eurprd07.prod.outlook.com
 (2603:10a6:802:58::16) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d36db01-10cf-47ff-ae8d-08de6d2c6d67
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2wxbUZqRWJyVnlocWdjNE14MmVPVCtHeE8xNU5oa1BYRVRoWEFnbytlZzl1?=
 =?utf-8?B?SVRheDVJbDBWNmhDL1pSaGIrODhScU1SeXozSDE5VzZSRG5QU1RZdDB6N3dM?=
 =?utf-8?B?R2VwSENWMWdCV1JiaHJHa29MVHF0aXljMWcyUFo2aFJyUXkxNzdFR21MSnJP?=
 =?utf-8?B?UHhKVmo1NjNWRDZRY2c3N3J3azcwQW9wV0R6TFp5ejhwcjJUN3d2WGlUWVRm?=
 =?utf-8?B?RjB0V0NPb281eE0vYUpHSEFrK1ZPcGJLSnNoUjZuUDkwYTd5M1JET2w4aElF?=
 =?utf-8?B?S29GMG5SaWxqYXFJV3lrU0cxY3JXQU51TjU2TitVSkhPQ2wvWDlGY1lxQ05h?=
 =?utf-8?B?Q09YVHk2RG0wdTFOQmZSOGk5WkpZT2syOEFTRGc1dFhwTFY4elNoV3BjYXVy?=
 =?utf-8?B?NTZSYVphTUVTNjNnaGZJRVlDais5azZpNThUU2RCaHkzY0IrN0xkVlJQN2JY?=
 =?utf-8?B?ejdTZTZvWWVTdEFwL0t0Slhrd0dWQlkwMnVBQzk1Si9BSzkrVHdhVlpWYXRB?=
 =?utf-8?B?N3F3azRDa3ZRMnpGcHNVT3cxRWJBbE9HQlZOVGVseUtac2owUnVZWGdaeDV6?=
 =?utf-8?B?SmxTVW4ycTFiQURXWXlXbkUzTHRJdThra0RGWXAvbW5XLys0cGdQY2VDVTN5?=
 =?utf-8?B?bERCWjJLbk9lV0tZTnFYbG5YR2RQVW05cHlPWlNxdTRzMXYwY2krMkRMamdq?=
 =?utf-8?B?Z1FpWTNBMGl4WTZ4REgyUFNwYWIyb0YvTk5UNml5aVRERVp5REwrSXpKeTdK?=
 =?utf-8?B?Qmd2SVpYM2lGcTR6RXNDNEdnVE42N0l6V1orTE9aNURYeXpGbFVSOEk5TEt4?=
 =?utf-8?B?ZGxobTdvanZubVprMjN6OTZ6ZlZIOE83SEFReDdJNXg5NFpHekZYQnpqTVFD?=
 =?utf-8?B?WGtnSGJ4M1M3UVgraTNpMzRuQlFlaURyUm53eldSWmJmOHNReWMvRWNBNXhi?=
 =?utf-8?B?dzV2dlJEa1hPMzROQnMrRDk1bWVFRW5qUDI0YlhpeGJuTW9HaENUc2xnRHJP?=
 =?utf-8?B?Tmlaa1R0MWl1OVhhUHFKT200WlRYbHdOVGw4eE85SEZJYTFtb0JmaExRR0x5?=
 =?utf-8?B?T2U5NnhnUlNtL3p5dGRFMVZDYjVpUmxDdTJPOFRsc0FvYjVQT0hjeDEyV01F?=
 =?utf-8?B?YjJUVDM2Q25ZbTA0ejQ2WUdTdHBqNGZKVTc3aDh4dmdRNEVDYys1MWhsQWNH?=
 =?utf-8?B?UUhmeTBUQnl2cEU5dERzcnJXU1BieWtaL0tlcVo4ck15RWtYWFdnaXYzclZ4?=
 =?utf-8?B?ZlFsSHFQRFQrSGF2MTJzdzNnNWxPK2k3RSthWDZmcWRMcWphOGFoNFBkVzB6?=
 =?utf-8?B?cUFmZlpxYU9teVRpalZqNGRGSzlaRHhzd3JWZGFFaWFVUm9TdGRGOUJjbUZv?=
 =?utf-8?B?TFZHU1poeGdiR1JoMktiN3BoMTMxWEtPcDVlWTlXOEVPRFo3MENNc2JWQzFE?=
 =?utf-8?B?NkM3QStNNkwydVdJYjV2b25HdGFKeisydUdwaHVBT3NVeGY1aFJvTHI2aFZE?=
 =?utf-8?B?MlV2dzdUb2pHbCs5RUo5cURkSDdnNTI3THR4VHQyQ3RWakJ2LzJRdDFqWXlG?=
 =?utf-8?B?elE1TjhTVUlNS0NtblJiNEJDNlNLVmFycElIYjlIQWJhWXVLWVRNdlN1QktZ?=
 =?utf-8?B?M1RLeEZqNHFyUkp3YktQR2xyYWhxL0JyaEh4aDhiVDNmTXNvdXBMYndQTkhD?=
 =?utf-8?B?bjNJb2kvcXRTdUdyT1NDY1pERXRFbUZtNVVxeUdJZWtuN3JkRXEzYk5kL2do?=
 =?utf-8?B?cG5mblNIVmhrRW9EL2lxNVg1QUlENllJV05tT1NmbFIzSDBWcXVIcURKYkxs?=
 =?utf-8?B?eXhBa29ZZDc3Y0JOb211eVdVVWl5OVRuMnhESHR4Ym5YOFR2VnFVN292WDVW?=
 =?utf-8?B?SWw1dHpmeXZqa3I4cXdObkxvaVJmaVlnV2hQUmlUUWRUamh5UzIyWC9UeFZC?=
 =?utf-8?B?SG5zVnZFTjVjQzNHM2lsMkZpVW8xUnI3WkJLWnRHUDRwYk9NL2VpVW43cGsw?=
 =?utf-8?B?RXI5c2p2dUVyTDB6UXlCQlovdUVQRWZ0SjJEOW11N2h2ckRBcnQ4K1NmN0hJ?=
 =?utf-8?B?aW5ka3k2cFhPVDI1NEdUL2kxUnd6WVBIVk5IaWdxNVJWT2ZNd2k4Zm11T3dW?=
 =?utf-8?Q?T2dL5cWNA05b1RWyyj0xCQB3B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1BLSFBMTnNjcnQzbkhqK0lzTXphYm8xbUdieFJuVXJNTG9vbThVZFphT3pr?=
 =?utf-8?B?MytjU0x4bUV4QzdqTHF4K2tKaFEvZC9Zak1CTlRkcks3djE2eENHQlRFODkv?=
 =?utf-8?B?TXZnblgxaUhvODZNVUNzRTZpRC96TUZZeG5QK3dIcml3Z2huRXBpV012YXY0?=
 =?utf-8?B?N3BaVyt2V2hoSmhocENYQS9xYmNPdis2UGhLZElpZS9Nd29YZzBsbU80TnlM?=
 =?utf-8?B?V0ZibndTYW9yTUo3ZWN0TjhKMU9id2JUVFI2cEtMbGhZbmx1K001N1VNdzhw?=
 =?utf-8?B?V1VrK2dWR2dEMWJoL3dDQ0dzVmkyK3pVakVIdzRHM0FFQnNxWDh3c0dwcXlX?=
 =?utf-8?B?RldjV2NIQWpiaC82TU5VZkJhTlJlWWFTTWc2b2lvVUFXa2Z3U2tpMVIxUDdR?=
 =?utf-8?B?WXY4UmJxYzF4UFliU0ZveFFpWVZFbUxIN0FxVEszU0xLTkxXM1NXVzJ1ODk2?=
 =?utf-8?B?dHNPSlNtckFLMUxUc0pzQ2ltdXVuOXFXUFlFV2Z6VUZrNnF2WVdLVHRzL3Y4?=
 =?utf-8?B?TnVaVUJyWCtGSU8vdzR1VjNtVWRXMmR3bGNwU29qcUNsKy95RVpUYWVvOXpF?=
 =?utf-8?B?UXNIZTVqRTdZYU9lNUNPb0VMNkdoMXBXb2ttYjdSTnNiek9La0k0N0JpdUJh?=
 =?utf-8?B?OUtYdkc1cEY2c0FUbElKVHhoQXFQR243QU9GN3l4VlpyUHpBMVBRWEVkejNU?=
 =?utf-8?B?M2VQNlcvVGFKdG44UXpIYVV1R1N0YTBUNnFDd0pOSHB1Ym43WmhUbDBEK1dG?=
 =?utf-8?B?RjByYTV0Nk52dGFvMkdYRTRTUTZ6UTFhUFQ0YndsN2VoVXB2eDEvQ3FnVlFz?=
 =?utf-8?B?b3gxc0dwNUxqYi9OOWNXM2hDMGIyT3BuTmtnUWl3WjR6K0g1VmlSY1gvaWRP?=
 =?utf-8?B?V1JLc0lxSkN5dXpuVzNqdUNRZ3IrVEJHTHEyelZwRG84bkYwcS9ObElTWUFH?=
 =?utf-8?B?RFN6azZqOUxHTUtkaFlzYjBuTTgrT21ZY0VuaHRrQlN1T1ZseDFvN2JMVEpl?=
 =?utf-8?B?bnRhT1Y1YWxiRWJTTEpqNUhOUk9adFd6TUFDM1g3ckVPS2pIN1h5S1N5WmZL?=
 =?utf-8?B?VTJzOWhCVHVEWmZPM2V5NUpBalNsTHR0bE16WWNRcUYrQkI5LzVQM2dOakJH?=
 =?utf-8?B?bDAwYklRbU51NjlES2Vpd2FIZEVpRlIwNjFFYkF5QjFqeEZMN1pFSXR0WjBT?=
 =?utf-8?B?QXhha0gvWmlrcXN6bEdseDdZZHdpdDdSM2VjUERFOTg5V25pWXptL0NQcy9J?=
 =?utf-8?B?bjJDRUxYSXJRMW5NaXQyaEtmTmY1YklVeTlqQ2VnVmlzTmFFWERSUmVoYkpq?=
 =?utf-8?B?blFZUWRCVXBzN2tWSEwzdnBwTXRNM0NUNXZTNFdmbWtDTWVhdjJRandjaDJQ?=
 =?utf-8?B?K0RvS2lHbUxzSDgzL3cxOTU0SGh6Zm1jQjU0eHlVMDY0K3dqZ1N2VmZBWTRj?=
 =?utf-8?B?MEl0TzJhUW5rb0FmVzV2SERnZWxXcm00NmFlbkFhdmhHUm14TVREYi9wZFJJ?=
 =?utf-8?B?OTRxT0xJQ3Y4Zkh2YVYwVXR4Vms2ZlplK1U0VVJ6Tm5QNzJYTDUzUXdZN3M3?=
 =?utf-8?B?cGFKajl3Tk44Z2dEOEp6eGhCVlRVK0xsc0ZJdjFkNW5oWVRjMDZ4d2xKSEpx?=
 =?utf-8?B?T09SME4wSVV2MjJVeGxTRGMvUXNjR0xwSXAxaFVDOTlsaHlRSWQzbUVuSHJF?=
 =?utf-8?B?NThFSUdKK04zZmw3RVpucmdxUzV2bnBwMnRxc0xnTXI0eFFLYmE5SHZKSGFk?=
 =?utf-8?B?Q2pubGd2MWprQUpnSlVXWTYxSzNEVms2c0ltNmhrS0szV3dXbFQwSXlLUmtx?=
 =?utf-8?B?dnRZRGRJcUN5TkJ6SnRSOU9mMURRdzFhb0RmYzVnUldUY2dTSkZTVW1acHJy?=
 =?utf-8?B?QzBtQzJmWlVkR1JrSU1yTWs4NmpCdVQ3VUN1RlNOTzBzblZDbDJXN3dEaXZ1?=
 =?utf-8?B?Vk4wcVlBL24yczg5YTJEdlIxWWx6NEJpZEdSdS9TaEdMRUx1S04ySzY5dGZs?=
 =?utf-8?B?VDJnbGt0UERXWEVPVUZGVXYyN1JFczJDRFpITGRvSkQrS1cvc3dpMmRUQTJr?=
 =?utf-8?B?OEtHdU1tQjl4R0ZKTjB4WUQ4QkQ5K015SGNIVGtxY2JwMTNLRFh0SFd0cGlm?=
 =?utf-8?B?Wm5wdFhDRkdOT1JuSkV5QXQ0alpEN295eHRMRUsyQkNEZmF4anlZTEcydHNF?=
 =?utf-8?B?V2RYWDV3VU9qeWttK240NlJNdUhoZW55OENITURFeVJwWkxGbU5RMnd6WWZU?=
 =?utf-8?B?QTRNdHlCNUVpd0FzamR1ak90Z2YyZUNoTmN3ZllTdHNpZ0VDN0tURFQ1dlZF?=
 =?utf-8?B?MHhleDhDSVFPdnlBNXc3Nmt0a1ZQa0J4Yk1NTVFWM3dIL0F1OG9FZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d36db01-10cf-47ff-ae8d-08de6d2c6d67
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 07:24:31.7278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4bNZpgFu5jVNPVSmQvb7cZ8j1C3POwqS2xsuAoGNFb1M7AVsmxWV2s5kFl63BYA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427
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



On 2/15/26 09:48, Heinrich Schuchardt wrote:
> On 2/11/26 16:56, Michal Simek wrote:
>> From: Shantur Rathore <i@shantur.com>
>>
>> Currently U-Boot uses ESP as storage for EFI variables.
>> Devices with SPI Flash are used for storing environment with this
>> commit we allow EFI variables to be stored on SPI Flash.
>>
>> https://github.com/rhboot/efivar
>> is not updated to support this location that's why you can mimic it by
>> running:
>> dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c \
>>     of=/tmp/vars skip=4 bs=1
>> flashcp /tmp/vars /dev/mtdX
>>
>> where mtdX should match location defined by
>> CONFIG_EFI_VARIABLE_SF_OFFSET/CONFIG_EFI_VAR_BUF_SIZE.
>>
>> Signed-off-by: Shantur Rathore <i@shantur.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC
>> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>
>> ---
>>
>> Changes in v8:
>> - Add missing EFI_VARIABLE_SF_STORE dependency to EFI_VARIABLE_SF_DEVICE_INDEX
>>
>> Changes in v7:
>> - sed -i 's/efi_var_from/efi_var_from_storage/g'
>>
>> Changes in v6:
>> - sed -i 's/efi_var_read/efi_var_from/g'
>> - sed -i 's/efi_var_write/efi_var_to_storage/g'
>>
>> Changes in v4:
>> - Extend Kconfig description
>> - Extend commit message and describe efivar missing part
>> - use unify methods for reading/writing variable
>>
>> Changes in v3:
>> - Fixed compiler warnings.
>>
>> Changes in v2:
>> - Refactored efi_var_file to move common parts out as requested
>> - Changed ifdefs to use CONFIG_IS_DEFINED
>> - Fixed typos
>>
>>   lib/efi_loader/Kconfig      | 35 +++++++++++++-
>>   lib/efi_loader/Makefile     |  1 +
>>   lib/efi_loader/efi_var_sf.c | 92 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 127 insertions(+), 1 deletion(-)
>>   create mode 100644 lib/efi_loader/efi_var_sf.c
>>
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index 579eed658801..0f6f927ddaf1 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -124,6 +124,24 @@ config EFI_VARIABLE_FILE_STORE
>>         Select this option if you want non-volatile UEFI variables to be
>>         stored as file /ubootefi.var on the EFI system partition.
>> +config EFI_VARIABLE_SF_STORE
>> +    bool "Store non-volatile UEFI variables in SPI Flash"
>> +    depends on SPI_FLASH
>> +    help
>> +      Select this option if you want non-volatile UEFI variables to be
>> +      stored in SPI Flash.
>> +
>> +      Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use as
>> +      the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
>> +      needed.
>> +
>> +      Note that SPI Flash devices have a limited number of program/erase
>> +      cycles. Frequent updates to UEFI variables may cause excessive wear
>> +      and can permanently damage the flash device, particularly on SPI NAND
>> +      or low-end SPI NOR parts without wear leveling. This option should be
>> +      used with care on such systems, and is not recommended for platforms
>> +      where UEFI variables are updated frequently.
>> +
>>   config EFI_MM_COMM_TEE
>>       bool "UEFI variables storage service via the trusted world"
>>       depends on OPTEE
>> @@ -153,7 +171,7 @@ endchoice
>>   config EFI_RT_VOLATILE_STORE
>>       bool "Allow variable runtime services in volatile storage (e.g RAM)"
>> -    depends on EFI_VARIABLE_FILE_STORE
>> +    depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
> 
> Hello Michal,
> 
> If the backend store is SPI flash, we should not publish the variable 
> "RTStorageVolatile" at runtime as currently defined.
> 
> For the background see this commit for the efivar library:
> 
> https://github.com/rhboot/efivar/commit/68daa04654acbe1bbaa17ebfc23c371b39e69c6b
> 
> The first three patches look correct to me and I will add them to a merge 
> request for efi-next.

Do I read it that when I don't allow to select EFI_RT_VOLATILE_STORE you will be 
fine with the patch itself?


> The usage of efi_var_mem_ins() and efi_var_mem_del() when SetVariable() does not 
> change anything is not flash-friendly. Michal, do you want to have a look at 
> this area?

That's known limitation describe in EFI_VARIABLE_SF_STORE Kconfig Note.

Thanks,
Michal

