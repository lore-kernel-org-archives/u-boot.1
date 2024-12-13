Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23DBE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 14:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 100168012C;
	Fri, 13 Dec 2024 15:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ddmAtmb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E7BA80104; Fri, 13 Dec 2024 15:09:27 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 231848012C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8teycv4lSMonIycJ8sh10MrDZHOB/hDD8A+VuKeSKgI8XKLuBbmU+ZSAuQFilCYrk815DhsiXgc3Lbjx/x90LUaLN2i0OKDlSqpaVA9tqCGig+QW2g+wKY5McXlTTYB2QfBkpzIPCElgL0rCod3QS3Fs0s/U7QIAad9WXdigbcw8dBRSyrqAQyWkSOr5OvcIdWlRGdEL+Ko3EnDnJQ7kpnYTy4fUj7uyTB3z5+zpalgEp8vk804moDlBNZjkKfuKEJsOvwne0odYkOhpL1dR0GISpwPZXvn4p4ZZ89hENxFPMoA7/MaaU7GVPUk7dVwwFaiKlSYabPuj+ca8oeHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxZx56qfJh4e2D6cJyDnafmOjFgSrd9gOJLJLvD6yns=;
 b=FzDFVNJfdOmvO72GO6AO0rbDP7bs9E+XBw+0redA9lje+TcE+aYiXKZipuAhnA6V0/0Tbjr85q4mMy69X7CNLuwgx765R0qsSaSbiHhFOjJGTLX7rbiyfSTj/P3mDe6BSXrkHxfmn5xNRdes7vsH7PZLQn4DWbWlbxVpLYbclJNR27m72b1vITLm4t9vj5JMKFtMzDQvmrRbh1lOqhy4biy0nrRvuOCdBdNZ/Ev+e+BR6M86uFXanAuSy4JrNjYxu/MF/zEnv1Lo9uskkL5j9VTW7emE767dK61eutCdch0ChgIxG000Q7fTpJN46084Xd1GoSqsCtsveGKv7Hgf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxZx56qfJh4e2D6cJyDnafmOjFgSrd9gOJLJLvD6yns=;
 b=ddmAtmb4iwFYjcrtY6wyOy51Qzwdq9zjpzg2BXHvhnRmLhtfw+6XBiRp8kYqTrFfNZt774Pi9NWVFtoDWD454M2Xhds7hbn/xGgEeoI4/ugEc+YlUc4GygFAyQV4lx9sLZZCseQ0IH+Q+arEIYW6RluMZ4vYKGwQCHj1zLA84SU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Fri, 13 Dec
 2024 14:09:19 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:09:19 +0000
Message-ID: <568df02e-aac1-4e07-95a1-159d404391f5@amd.com>
Date: Fri, 13 Dec 2024 15:09:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] doc: man-page for optee commands
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 jerome.forissier@linaro.org, mkorpershoek@baylibre.com,
 akashi.tkhro@gmail.com, francis.laniel@amarulasolutions.com,
 ddrokosov@salutedevices.com, git@amd.com
References: <20241213110034.1113036-1-venkatesh.abbarapu@amd.com>
 <20241213110034.1113036-3-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241213110034.1113036-3-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0140.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bed27dd-d7f3-43c9-6c87-08dd1b7fbc5a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y01WNjRVa1d1NnFBOHpyM3drQjdYbUlGc0RZdE5XemNtS2R2VGovdUFkQ0tZ?=
 =?utf-8?B?a01TdVJSRzhtZEJVQTRDdGJsNE9xSHVFMVo2ZHE3b1N6dGUyS1NwVytNU0NQ?=
 =?utf-8?B?YjhrSzRxVTF6aENKQ0YyZWswdm1jQm1MMDN1ZWM5c1FrNFdDenhXNHFPak82?=
 =?utf-8?B?Uklsajhod3FLdVI1ci8zVTZvd0xHbVkrcnZsdkFDTVRNRkw2cVh6ek1TNTYx?=
 =?utf-8?B?UThiMnNkanUvVmNqcjZLSW11QnZqTEdYUm1kc2V3UmlzNWxoWkYrS1N2OE4z?=
 =?utf-8?B?VEVDSlBoWTI4eXVjTmlLVUZpRk5oTjdJWXpKV1doUUk3end3OTZ5ajR3L1pv?=
 =?utf-8?B?VnZOUUhOUW5PL3lHektpQjFPeTMrbjFiV0JidVpUdEc4NnRuTmk2NEhCdC9H?=
 =?utf-8?B?eWMxZVMwWWFFMHpmcVhCcW9UVlRSUXY0c2tQVGxRbng3dmkycTVkWlNSK1RW?=
 =?utf-8?B?emM4R2J6M24xVWovK0lHbmFWSHluaTlsOGlFb2QxeE8zNlU2WFpacmF0RVJR?=
 =?utf-8?B?NWM4NXMyQXpJa0xDUW9rL2t3MndTb3Jxajhya0NEekFmcXplcis5UkZVZmF2?=
 =?utf-8?B?a1JrUUJxdGlRNzhNMlRQK2xOYlRlTmd1b29MS3B5RXdZWHY2alpZelgyU1Jm?=
 =?utf-8?B?VnBxMHRkaW9KRlVEdWJaZC9kekRob1JNRmF0UnBDcFJSSWxoOHlUOWVhY1Uz?=
 =?utf-8?B?VmNUZEZVd0gvTFg5dGNHNjRTcGw1K2ZhUGxlVzFEanlnL3hMdUhuUHhrblRX?=
 =?utf-8?B?a2xPS2d4SDdES1I2NklmQjVzQ0VLU1NRVEhaazk3ckFjNmtuVkdzV2YxcElB?=
 =?utf-8?B?NHMvMGIzQ2x4WGVjRUtjTVJ2ZmxmK3ZId0RmNVRuNXlRSkNoTzg3QVU0cXFH?=
 =?utf-8?B?ZDlBV1pqakcwZ1FZQ21QNjZ5Q2dXTysyUldvL2IxN0tCaGFldzJ5anhDZHFt?=
 =?utf-8?B?LytlTDlJNkxheGVySitsVy9KYWNjbGFvNDMxT2ZIS2ZhSW5xZjJnTXVEeWtQ?=
 =?utf-8?B?akQ0aitCMFBjVVpMYlQ3QUQwL1BXSFZNalV2MjhVTU9xbUs5QStQaWRpN1lQ?=
 =?utf-8?B?R0VBQ0lISm5YY2IwMTBCY1JLY2JYeGcvMzlEeVJJNGI2L25CVXdmcFc4WFlU?=
 =?utf-8?B?c2dHZTM0SzQ4ZU9mUUkvTENwbGRJZG92WW1kaEpLQzBTNzdzd25jMGdSR2pN?=
 =?utf-8?B?V0NKY3ZSUXNWTTZFbnkzVlRVZmRKZldmUmRzMzJrODVGYlVmcXFOUm04QWQ2?=
 =?utf-8?B?SXlTUGgraGN0cGZ3bnpuWUJ3bFREdmthMktVcEFzdjdFcjl4UE85aU53bUUv?=
 =?utf-8?B?VTdPL1pqdFRDaXREOE1YKzYreGl6N1NuWldhWW8vN2tGeXVQV1loaVYwQXlo?=
 =?utf-8?B?NEF6ZXJZeEVRazR4Wkt3R2Q2T3ZSbjlqcWUvb0VPNTU4dVJaVE82OWNKYU1G?=
 =?utf-8?B?TWFYSFpQbEJ5SkpTV0dkQzhpSzZqQkRkK3E2OXN1K01Qa3JLOXlZMFNJeGE1?=
 =?utf-8?B?Ly9XOHR1eGNZdGVUeHBkM1NNRCsvMDExNjFmbWlxOE1NS2JEcHU2TEpnTTRS?=
 =?utf-8?B?TXZUK1UyczMzSXBGeE5XQ21hdkpPZWEzWWx3NW1EL0lod1g5OXhscFp5R0V3?=
 =?utf-8?B?VjJQTloxenB5WjBBd1RsMDMxRjdHekFpajNjMlNrMTkvMzZSN0dTeG14MXBh?=
 =?utf-8?B?MWdPMWY5dUFrYmFCRkZuRDhNK0FYNzMrTWMwaUl4ZGlrc0h4TXRxd3MyYzRh?=
 =?utf-8?B?blVZaWVwYmczeklFZWFVejRJaWRXUUM0MEJuOUR6Z3MwbWlxU2ZYYTVaU0RO?=
 =?utf-8?B?K2Z3U1EzWFVqc1AxNHNDdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjlzUVdHc05PcTdKNCtRNGNzM3Y4VkczN2hURmJDM2t0QTlXM1JMZVpBQXUx?=
 =?utf-8?B?Smd3WUF3L3ZsMVByMVZNaVYzbWg0dXFnVndva3BBdmk2WmlhVFliTzdOMGxV?=
 =?utf-8?B?OEpvQzExeW90OUlZYU93Q2xGTnJSME05U0JtUGlOVUJkdWR3d2dYdEdxWENj?=
 =?utf-8?B?YjMzWGtrUGdiS3BlS0gvWWJkTWJETFBOUzZnMkduSlZBTzl1Y2RWM3h0V0Nh?=
 =?utf-8?B?K1h4ZlNNc0IveEtLV1NIVldGYURNVWpsSVJZSWNxL0FTVXZqTEJCSjF1T2pq?=
 =?utf-8?B?NHkzdHFEdUdUYzVjYittWUJxSTVFUWp0d1l5dFlkdWNTUXNiSUJId1hYdlZK?=
 =?utf-8?B?VU1CL1ZVRXNlK0prQThiNkM5M3U5dU1BWDg2ZC91QUJKNzAxZWZIRXJvREtY?=
 =?utf-8?B?SEhHcTRGR1Y5NC92VFFhQXgyMEMxWkIvdnpSM2V0aWtDNStNZFFCUDdGSCs4?=
 =?utf-8?B?a1pjYThZeEQrVHA0VW4rOWoydHNCUmtvcHEzbEZDZ25qTjZudE5UenRISUlk?=
 =?utf-8?B?R3l4Zlh1d3BxcmFPd3dsaklpWjJoNmhkN05aQ2VqRE5UbGIwNEk5a3VYNXc2?=
 =?utf-8?B?ank5VmxobGhXdEowc3FTVHNKWnRTYVJ3YjhaOWtWU1VLYldkbTMzR05IMkRx?=
 =?utf-8?B?TG14WWR2dkdaNjZYQlBrU3RIbG10MVRDZjZZUnNiQmppRStXZlVqRXNOSEc4?=
 =?utf-8?B?dTJhOU1uZWNCcjFoTFF6L3BtdHp0MjRFbUJmVTNtWkR2OUlLQ21kYUNMd3Zu?=
 =?utf-8?B?dklsWld1ckRucWhEUW1HS1VTN2l0aEltZyt5c2NSR1IwN3Jrc2x1dUZxTXJG?=
 =?utf-8?B?Q082RUY4aEhrSGY3ZmtCaUlUV3ZaSExZMjRXN21NcS9iai96d0R5WmFnNjI4?=
 =?utf-8?B?bVcvcXJNb2ZxUFhaSHlnNXJVQzJBTVdrSU5ocE5yL1hxWGFEMDRpR1RrejNP?=
 =?utf-8?B?elgzSGZQYkR4b1NURURIVGJlMmJQQjFIMmlvLzR1djE2YTViWjVlWnpFRVdi?=
 =?utf-8?B?NHVSN3VETDlHdFN3MTlpck9LdUZ2Yzd2c1cvVWthSWh3K052WEdxL08vM3BL?=
 =?utf-8?B?dkVlY1QwUDMrbFVKcUZhNzlVZlROOVlHaW5lWkNKOVFmbFNUNkRldURrcGt0?=
 =?utf-8?B?dC82K0l1Y3dGTVFIbmZjQSt3ZFgyQmZWendDeHFMRUFLQ1I4dzlDVzhTWUZj?=
 =?utf-8?B?cCt3VjRIQXNETE1WR0p3REliYWY2OUtQTFVwdGduNlRxdmJxS2xMeExWTlc2?=
 =?utf-8?B?VFBjcktZVVhoNFpMazFQeGpxN2h2a0lIVGJ3Y0I3dHlaamNpS0tCWm1icTl1?=
 =?utf-8?B?OTVrb3kxOStCTUluMi9BRGhGMWdJZFBQNzdFTEJ0b05kQjRLQW1zaC95UFZR?=
 =?utf-8?B?V1JWZU0yNXhreXp1T3l4bVNweHJRUUQxcjF6MjVtWE9sQXc3TW8yOFJuN0gx?=
 =?utf-8?B?UnF0RXZsRDNFcUJvQmFLOWtYdmlYZDEyaEtlOVVkZjhOSER4WkNWU0djUXF4?=
 =?utf-8?B?TFF1NStVbm9nZEVmUHUzVElMaWpXOTdpTTE3M2ttSW52VVJidE42Z0Nodmcz?=
 =?utf-8?B?cUxrN2JVSUJOL21vam9Zakk4Smg0VUtLdXRrV2ZadHlpMGk1QVl2bTNjWlhm?=
 =?utf-8?B?My9nWFg2V2dhK0tiSkdXUytkd2h3RDhaTVo1bzFTdFZJTVI4Znk0Y2xJVVF4?=
 =?utf-8?B?TEJlQzZYZVptL1A5NVQzQnNOWWpiZVZNSTBOR2tVT1RSck5BV0pQOWFmbjRp?=
 =?utf-8?B?cnZ2eTcwalIxaktJajZQNnJoSXFVaXlzNlEvMDMvS3pQWXExQ3B6Y1FJNHNs?=
 =?utf-8?B?ejY2djRwTHFHVUFMWnZFUE81Yi9ZcTlwOW1rZzJkdjQveGIwOFc4Z3F3OTM2?=
 =?utf-8?B?ODV6bTRTVG9xWlJ6NUZQdFd6d0lNa2lVY0dJWTRIVCtSNGdpczg5RlZsWXNO?=
 =?utf-8?B?c3FEVk4wVVNzWGg4MHAwWDQ1K0xDQW1jZXg1azM0SWVxYXJSMC82MURjTi9s?=
 =?utf-8?B?VzN2bFgzV2hrWTN1WVRYQi9qYVU0M3hGRXBsVnpET0JBUEs2RktRWHRkWW5G?=
 =?utf-8?B?M3plR0FMUFdkM0laeThndXlFYnhCa29VMkU4MWU3UmlLY0JSaVJ2UnZGR3Rr?=
 =?utf-8?Q?cDjnXSgZIY5BHomqhdA8e+I3/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bed27dd-d7f3-43c9-6c87-08dd1b7fbc5a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:09:19.3951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjPAKRsdP6+vJuJGlCFxxZ0qA1/tSs77rl5JXd4u3fWPlQMTw80v/LRHE5JX4JMS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793
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



On 12/13/24 12:00, Venkatesh Yadav Abbarapu wrote:
> Provide a man-page for the optee command.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   doc/usage/cmd/optee.rst | 75 +++++++++++++++++++++++++++++++++++++++++
>   doc/usage/index.rst     |  1 +
>   2 files changed, 76 insertions(+)
>   create mode 100644 doc/usage/cmd/optee.rst
> 
> diff --git a/doc/usage/cmd/optee.rst b/doc/usage/cmd/optee.rst
> new file mode 100644
> index 00000000000..a8a19e3e983
> --- /dev/null
> +++ b/doc/usage/cmd/optee.rst
> @@ -0,0 +1,75 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +.. index::
> +   single: optee (command)
> +
> +optee command
> +===========


make -j8 pdfdocs


/home/monstr/data/disk/u-boot/doc/usage/cmd/optee.rst:7: WARNING: Title 
underline too short.


M
