Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A171E98E10
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 09:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CDD483935;
	Mon, 23 Feb 2026 10:19:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GAOs752G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 969A783BC9; Mon, 23 Feb 2026 10:19:38 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 496638063E
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 10:19:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEpmpeRYt2iTYUfGO7PzfZ/qts+dO3Kn1QzGE2E4bLHPTRQALJuHgGt2xNPoQh3aTRHHii3FBagapCgaabqvWi4aod/q9kh3PYQhMpMfBlVFLln/IZJIvB4kp/AWwH73R0MZ13I9oo7dtUNRLLchEXwcDCr/p7am0I3UU+EKx+kmxoa4Zxh2s4rHFCtxg96NAT70nH4n0SlZSrmIFdu+MR6OmMszUKMAJgS+JMUulR9eI3Eew1sLJn+AsuThJZuRc/I9WQmjEGUKRVf4l0+mjiblPuzsI9ejjNZ7WZe7D4n7ARApZgSW0rfhJSkqunBtFR2Asf9cUES+H0UP8vPLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+rVj6I0NUbp8Cw7I5f1NfFV/NUJNnQg1E5Aa8tj8ug=;
 b=Kkpoh91iUiLneDQCf1DCOR6QdhNUrLd5FKjESp3BxawFo9w1efuD1gXc4lXxjzAWET7zXjE5UcceBTMrlzL14pH19p3RZf8xHu+UsXvtvZHXeZsmAwLnYKI7/coTBBUwEk3LJAJiQtEmyWU/N5qp3Mf8d+xhUeSmzOAq2EodXoEWkBsW951sKW8WKsctZjCyhLSQnzbq1N5yibuy3n6G2LaL7tOsZ0QceSMB5FYo7kjh1qrAx2VUjU1DxIdVbwf0Px5v8K86QUzMC1T3vIJbWVpwNRBaI3BuYJJBJW90vkJnkeUPHakswHg2hB/LVdNOQ5v0gYvk9NC+s0EllZtdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+rVj6I0NUbp8Cw7I5f1NfFV/NUJNnQg1E5Aa8tj8ug=;
 b=GAOs752GvlLNJq15CxnCTYUJegUVK4kyRTDk+If6ZRRBE8pDPktjaAraExi1gzAxWJlMzSyBeL8xsUWBScWDSUIIKea4ybDy10Q+OKCDFiak84/JzpH+mlhYwOcyPdQcS1jzXeV730ofd+TPoUGxbcqTPDOtOtycXhfwgSBsRbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 09:19:26 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 09:19:25 +0000
Message-ID: <4722d5af-edb9-48dc-a97e-721d4ed05abc@amd.com>
Date: Mon, 23 Feb 2026 10:19:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable GPIO delay driver on Versal platforms
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <6744d3a93f48658178a53d218a4a6ca2fbb050dd.1771325431.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <6744d3a93f48658178a53d218a4a6ca2fbb050dd.1771325431.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0128.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::12) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de317b7-b6ce-4141-abc5-08de72bca373
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTBUUmNPWkRyUHpOcEF4L0Y4SllQVWNtK1pxRk1sWlNKdVFJMFJacDhZMFFO?=
 =?utf-8?B?RmNyWkpLVEw0VXo4M1VxK3JPbEV4RVN6YjV5dk92RjEvUjN6S3FCWWUyWjVa?=
 =?utf-8?B?K2ZXTE9xL3ZLNUkxSnVvS05vZmhJOEVYTGF2dk9mNFhqNWlWVzdnNFJQcXVm?=
 =?utf-8?B?VWczU001czdDcFBxZ1dldEoyUCtvVUc2VXJEUExaMXQ0S2RjZ3JRcnZ0akw3?=
 =?utf-8?B?Mk9VbVh0WFFaZFZXRk1ZMkV1V3FjdUJ0Z25adHFQUkdoQVhBMU9qOEQ1YTdE?=
 =?utf-8?B?S2VUbnFma2N5aTcwV084dWpiV1djV1ovbXp4TG4zZ1JkN2JQWVlFSUhNRjkx?=
 =?utf-8?B?amE3ZG1UZEZTNWEyN09CbThOdi93c1BOSkxkeitwd2R3UDNWVHhUWldGMnZD?=
 =?utf-8?B?NzlucnBpWjdlbEFSTzZHVDVTOGFNbk5KL0lYK3lnQlcxRTN4S0FZYnVxN1Zl?=
 =?utf-8?B?R3hvWWlpQjVIMHhSS3NUOW9xNHh5M1JqWHhUT1UybGZnNklsSG15ZFJ0R25j?=
 =?utf-8?B?ZVBOZGZia1h4REhiR0xUYkFLMVVtRG0ya2IyK3VwOGFJbjRxSVdrQTdNUmJt?=
 =?utf-8?B?bjMvNHhidm9aL0VuWVZuT2hkcEtJejNrNWxpU3dPSlowTXl4ME5kdDZCdzky?=
 =?utf-8?B?QnQxY3haL2p1Q2hSRU53bHhPanVYd1I5MHM1amtBWUNzQllwbGRXQzNOY3By?=
 =?utf-8?B?VUlGZHloQUlKajBaSFFJQU5ja2RrYVZ6NjlMck50bmFrSEhkOUl2Ym1IWC9I?=
 =?utf-8?B?eldaQ2RCYkpCaUtYT0pZaEJWcGliVE1UZDJqbGg0cHFlbFQwN3FubmdBTzY3?=
 =?utf-8?B?TjFydXVRRnByVEtMQWIyQTNmWFc0d2MzUWtTZUJuZTUrZE1XN05hL2RFRFFk?=
 =?utf-8?B?OTlxbFhnNXVPVWxsTXdDamx3d1VXSG9jQU11enNUdmhEbjc1b0VLTVBER1Rq?=
 =?utf-8?B?L2lnVW0zV0xaczRqdy8rM2ZaN0k2Yy92MTBncks5aGpMYlB5cDJPV296N1Y2?=
 =?utf-8?B?K3owY2dWdUpmbS9FTDNPK3ZIQ011MUhzMDRIMGFUckJHWUFORXIwVkJMdng0?=
 =?utf-8?B?MEFzMm9xOWxGZ1Z6SURTMUxsaUFxTVNOS0ZuSDE2R3Q5ZDdpdjVsODduU21o?=
 =?utf-8?B?UThSWXR6Um53L2JkVkZ3YkhtLy9wUDR4MVQ4UEVjMUhvSmpORlV1RkZhdkJ0?=
 =?utf-8?B?Y1NoRlkvTURZVVZRUFdHUm9ZN2ptYWdXSjRqNGY4bEdqRlVxamVWdjJHbHRj?=
 =?utf-8?B?dGp0N0w5NEFab3paMXVIR1lpVldnWWtld1pzd0dZT2VlNXplNVRZVk9ieWVE?=
 =?utf-8?B?Q2JsNFBSYUl5Sm9sTVVRcHF2T1QrV3Q2RFVQb2ZJcWk2VWJVbi9CRjk5QUxG?=
 =?utf-8?B?VDRnMXFQR2lGMWdvRCtFRHV6bmIwUkZLZ1R4eVp3N045bkdHNWt3NHdWYVZJ?=
 =?utf-8?B?Zzlwb1U5cGhXOUVmQzZkWFlGMTdUekRpNjdKRzJOcnpMRTVFR0dmcDVjWDVV?=
 =?utf-8?B?Slp3RFdBa3o1RHZJUDJkekdMNjlad2FidFd2bG1taC95NHUxVVFMNGdJcWlw?=
 =?utf-8?B?TzFSVzFoTHhMbUJhZHpzSGw1UTl3eXRNcy9DbERLazJjWm1rTVIySk1LR21j?=
 =?utf-8?B?NGRUbHUxdTVWRGtMY0xPSitHSk5lbDQ0U0MzdGRiSlMxM2JDKzNnNHZuZ1hr?=
 =?utf-8?B?dmRQSXd4UjkvcGxKY0ptbE1ybitkRjFyaFUrWjVtcnRzNStBcmJDdkh6dDhk?=
 =?utf-8?B?Z1M0STNVN2ZDc1dMK2Z1a2FMVWNpay9HZXZ2QlF1dlgrbE53R0Qwb0tjWDlY?=
 =?utf-8?B?TnNYWGtLTUc1cm5nSFM0T2orV2ZjUjdhUmp4NWF4R0Nxby9IUUdubEV5MHd4?=
 =?utf-8?B?ZEpRTGUrTy9oMXNJbUVGS1VDY3BWOWF4MHh4d3QwYXBGUGJkRnh1STJxZExl?=
 =?utf-8?B?ZUYwdTdmMTJVaHJYNmh1WWZvaFBUYkt3Tm8rRGRoSGQ4UDZ6U21WOWlza2Jr?=
 =?utf-8?B?a3NPbjl3NGVUVkIwa2dnZCtuWHppNytRKzI0OWU5Y1BMTUtTOHZxcHRVbW5t?=
 =?utf-8?B?cC9SNkMza2NrQlVYSUdQQmV3TzFweW9relJsU0x2R0o1ckcxSHcwMkFjTVZj?=
 =?utf-8?Q?fXQw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3ZrYmRQVjJsbUZibjBhR0RwQVpQMWJud3ZRa0p4MldQeVVab1gvRjJKc2JU?=
 =?utf-8?B?VXE4YkVLUUpkMCtERW9zQU5aR2RyOGdVUG9iSmJjMkZQQkxUY2pPUkRHT2VZ?=
 =?utf-8?B?Y3NjaXZTZjNHbTB3Um14d1dGMTFQUlpMUWhLVmp3akhkYWIvSDlaUE5iUzM1?=
 =?utf-8?B?TlhxdDh1bnQ1Z0tuQ1VaWk5kT3o1emszVFhsN2YxdWRmR0dUTFcvclVjcGVu?=
 =?utf-8?B?TXo5dDBZemVSZTBINU8xSi9XZlJPd1MySGZDTzZoN2tyeStoQUw3Z2JWV2RZ?=
 =?utf-8?B?RjA4ajhSSDQ0ODVUV2dXaGNjL0dEbUY2R3kyNW81WVJjTm9mVGR0VEovTEJo?=
 =?utf-8?B?bWpocld4ck9XRDlJdEtyWndzd2kwRU5mUU9yTHFtQnhhaXVaYmRsTTRSaCtP?=
 =?utf-8?B?Y2p4bWJlTS94b21maThWL3pxU1Nac0haZWtXSVJCVmZUZkhRS3BLUVhlVEty?=
 =?utf-8?B?WEMwUm9Sa0p5b0ZTYVhZNVlNOEFqOE9wTVZRUGRjSjdKMFpMSGJaVTN4cnk1?=
 =?utf-8?B?Z3RPOFNMM3g4RlpHL0ZZOE4wVEp1K1ZaUFNzbHhKZVR3aGZNamsxR0xEbU9j?=
 =?utf-8?B?VGdqbVFIaHl0aUtacmNxbXEvT3lWRnpoazg4enNHM3J6M2F6eGJRb05adVVS?=
 =?utf-8?B?NnN0aDg5WitkUmNPS0RjeGxzQmlZd1VpZE05S0lBZWNQN1BOa2xycGFyN0ZE?=
 =?utf-8?B?QTFjdVdFbzE4RCsvRGphSVdTRkd2WGRUdm5lV3ZIWUZxcXNicHY3L0wrMmNL?=
 =?utf-8?B?blVEWE9DcllmQmdVOGVQajc0MFdIOXFvbVRscG9BOTJNdS9zbkxKbE9WZWlH?=
 =?utf-8?B?UkZ6ek1zQXM2RTBjaUNZTnZxT0xsTmY5L0JaQUNsaTdMWE10MVNUOUpOa0Vs?=
 =?utf-8?B?eS92K2JlM0ZBb1EreUpaZ2l0SCtBTjExR3E1T1Y5RnVBYjhzbmROREt2Unhz?=
 =?utf-8?B?ZW1KZTBITmlIdzJUUnY1bStYTWI0WTU4bHBlaGc0Tm15OElKU2x5NVlDMmRL?=
 =?utf-8?B?c1N1eHl4YUl0U0FYYWNJUkQ5MjdVSktqKzR3TTBRejcxbW85VU1Rb1hnK0Iy?=
 =?utf-8?B?N3JUR05PRzFFL29lNnZSWWpZVThRa000VEJxNTY5ODZQVkhnR3hXVGlIN3R2?=
 =?utf-8?B?a1RsNDlxdk1nSzlEbHBFdXR6cHNVZWhYYzBtUEZyUVQrYXpwTzF1ZUJBY3li?=
 =?utf-8?B?NEVyNXEwNXYweVNsUkdLSHBhMkFsZTlmbWhVemloaHdmYkxXcldYeGduc3NK?=
 =?utf-8?B?SjJUbVRRRGpDbzhhb0R4eHlmc254L3ZFK2p2amZPNzJaQnRucTlqT1BLaWhm?=
 =?utf-8?B?VU8zMEU3TVA2NzJKTS8vWXdSNmkyeTlZVlpmT2VzYjdWSUVjNzUxODIzbXNs?=
 =?utf-8?B?UWlJeHR3N2lWbXRLZ2RiSnJ1blBMbXlHekh0RnlGUE93ZVp0NVZGWG9LYm5J?=
 =?utf-8?B?aHNyKzVKaitjaG5NMlhmcW9yU0h5VkZFeDdvRCszck9yK3lJcS9VRTBOTFhx?=
 =?utf-8?B?TDl5c0srYzJPSzRjMUVKZUorMzYxYlF0REErMnY5K2ZXVlY5WDlTZk54ZUFo?=
 =?utf-8?B?cGhwcjRORXdiSVZkRkU0K05hYVZlY2V4YUNCT0dGMjQ0am1MQmpUYXpPOVQ5?=
 =?utf-8?B?eVpZVHgyZkdNa01GZlk2UlNpYi93YTFrRXpzdXAvSENCUWFDTS9JZFYva0RK?=
 =?utf-8?B?VXhRMHdCYjJJeENqRmtRc2Nlb2xnVjREVGt3LzJOeENxWEF6Zm9sNjlOU29u?=
 =?utf-8?B?ZVZsZ3ZoYjZTY0NLenFaTThJRGtXR0crcTI0MzB1OVpHOHIwdjZjSW9TKy9F?=
 =?utf-8?B?NVdKZENtTW5nL3BLWlBZNHFhTC9sUmhNRmVIdUVzaVhXVi9hak1VTmhSdm9n?=
 =?utf-8?B?TXprSVYzT2QzZUpLYXEwS1B5ZllVeG5zRVAwQU9IckhiZStwTVo3Q2F4MGRi?=
 =?utf-8?B?cSsrOG04dWZLZkUxMGN3cVBjQVlPUm84bmFFN1EzZ0R4V1hicTY4Y0lGSC8w?=
 =?utf-8?B?d2tiZUY0YjB3ZlFvT0RKc01JY0tqbExpRUw5V0hYQ2xpazVzZHlBVlhuQnN0?=
 =?utf-8?B?K0tSdHNCVms2QUd0K2NyNjFDWWlZcWwxSGhnL2gwTnh0U2R2MmpvSWJlblhB?=
 =?utf-8?B?MFQ5REtHZFN3R2dRNFEvWktMZjRPMmR1UHcrODc2MStPU1pnYklnNGVoU2hW?=
 =?utf-8?B?L0dHc3h3YzJmUjFHdjk5MTBjWmd2dEM1UG12b1pjZk15TWFQTW52aVAwWTBk?=
 =?utf-8?B?QnRQTjJyaTJvMGowNzlLem0xNXNOMGlialppS3JSMStKVzNYY21iYXgzbXpr?=
 =?utf-8?B?UTlpTldXdG1yTUpWMUZSMmJjSkJDRDFxK01Fb3lnaUNsQm1WL2c2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de317b7-b6ce-4141-abc5-08de72bca373
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 09:19:25.7499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhyN0pjFPjFrgyqwZmGSBgqKLfRe/oeWQdKxG6OogIFo6pATuVGcdZTmk3SBM8sm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975
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



On 2/17/26 11:50, Michal Simek wrote:
> GPIO delay driver is necessary to use to extend delay times for USB hubs.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/amd_versal2_virt_defconfig   | 1 +
>   configs/xilinx_versal_virt_defconfig | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 94dce5c191c4..0296f378ea7a 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -82,6 +82,7 @@ CONFIG_DFU_RAM=y
>   CONFIG_ARM_FFA_TRANSPORT=y
>   CONFIG_FPGA_XILINX=y
>   CONFIG_FPGA_VERSALPL=y
> +CONFIG_GPIO_DELAY=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_CADENCE=y
>   CONFIG_I2C_MUX=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index e8d6f4cf6d63..d5d60d7f87d0 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -87,6 +87,7 @@ CONFIG_ZYNQMP_FIRMWARE=y
>   CONFIG_ARM_FFA_TRANSPORT=y
>   CONFIG_FPGA_XILINX=y
>   CONFIG_FPGA_VERSALPL=y
> +CONFIG_GPIO_DELAY=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_CADENCE=y
>   CONFIG_I2C_MUX=y

applied.
M
