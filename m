Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A3BCAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 07:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF3048328F;
	Thu,  2 Oct 2025 09:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c7+zOHMJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43DDE8344E; Thu,  2 Oct 2025 09:24:17 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 082A880107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 09:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECqVKNRjR+3wqcAS1oIgLpSrU34X3OmRu1HuTruoj1OOopVq47/7VHJ1OPXPEbqcCtCdmmHgjZRA5sHwcrjGGJLoPgenCOrCM5M594FKwSy9unLH6EvUivtgcUh5Lph5Cvn6bZf6WaofUImZ16q+e3eD514m1M4yzsZGtyiTZ9D/RUpQ0/AdBvsh+A0/76odgZk9sF8fUq61dNiCxo1lbcg+CFCgreJGkSlKOPSolH+783HzFbk4BFLsVWHjVq0k2rTmr33k1b9iSkdIt8+MvLzgb5jNpPVGDXeVXJcw0GA2ZGskXaHvDZvG1zjhf8RoN/QvXI4JwbTVEcsFSci04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iERwhMijwfr22c4Iac1EY0P+JTY2RRefVUB2hg//0hw=;
 b=P0f46HF/iB2ebbkM6yDsNJr4ZtYQra5ao9vwwNY3Jw3tuaA7RQV2SCGl4sm07DBLEX8dy7aAdA8MgIbceXzc0jL7OAhs8tX2FR3iDwAKQPZFur+WtIAWD5C6VYXnPhxaZB3baJvfLYZRwcYc+MAHleKcWObeehc2CSGBLoE8gFx1ryUhA+a1FWJJcNePj2BotTpPyS5tdxS0sC9jSroZX91P2dgm5P7tJf1peNAkMLtT5/oumWD88meU5duoiM40NLcR8rdbYIaTnJn40CuiD1ilbeBjDzW8p0wLDvFiNe3ISI3lRZkI+JNRVuOcrgmTnn1ZOaws2kSIbvXXgxgfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iERwhMijwfr22c4Iac1EY0P+JTY2RRefVUB2hg//0hw=;
 b=c7+zOHMJ5ItHVAaEfE74gOIRRbRGjDhYUjg807N4WAbpjn3EcLTDm/yIcuJ7U/qZOgopPXINIaBFYUwtj58Gi7jhTqVyQvBcPV7PkDBuEH0AMTSBXkBbRVqIT2zPmu1DIS404R2pOAAdv2q4HUThPenn8/CYIbdnWz/3VTBs0ts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 07:24:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Thu, 2 Oct 2025
 07:24:08 +0000
Message-ID: <e3470dfd-da37-43e3-a214-9378ccd8d30b@amd.com>
Date: Thu, 2 Oct 2025 09:23:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Replace PHY_VITESSE by PHY_MSCC
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com, Tom Rini <trini@konsulko.com>
Cc: Anshul Dalal <anshuld@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <0a441e488a29bd1c93677a6f63a4a04a3cc1c9f5.1759216164.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <0a441e488a29bd1c93677a6f63a4a04a3cc1c9f5.1759216164.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0126.eurprd09.prod.outlook.com
 (2603:10a6:803:78::49) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b37cd8-a151-4692-03c3-08de0184acc4
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qmx1dm5neEpkeUpCb0hLVUJ4eTBiYzdXYUNiS1lYRU9tU3NyaHNWTktwQ2w4?=
 =?utf-8?B?YTBHY2R6MEZHUzg1UXQrSXR2WmxybHdUUlhZKzMwVnFreTJwOHdwNkQ4c2hs?=
 =?utf-8?B?eWMyaGJTV081T0w0UEVMOFEvMkRzM0MvZWp5OW9sOG9kR0VxWTVEaUR0WWEr?=
 =?utf-8?B?bTRtd3pjSU01VHl5ZlVtNGExbGFUMnJEMHRWWDViTmpCWjhSazRkQVpmNElp?=
 =?utf-8?B?cEswTGpQeXVObDF4Y20yd1A2TUtZL0YyZ2NDVWhQSzJ5dDd0eks3bElPNEs3?=
 =?utf-8?B?MStxYWFFU1luWW10UUhETndicnVXRFJwU1BkeDR4WmY0U3JTNWRWL2VMVENJ?=
 =?utf-8?B?d3Z2SEx5R0JyVW4xTm95OFlIVnhBbG85UklKN216dy92c3ArcVZkN0orQyts?=
 =?utf-8?B?Z0ZiT1ZodUpad1dDbmxNV2VIaVp4dkN5SEJwYVlpeHBFKzNhVHRnTXIxZFpk?=
 =?utf-8?B?TUVaQVlYb1FvTG1SdmlmVksvejdGREt0T25VYlRtWnkzS005VjhMVEliNDE5?=
 =?utf-8?B?Sm0rZEFmbkg3WXlnZTlCV1kxcDJsSFdVd054bndIVVI2b1pxOWRUOFM4OWZ0?=
 =?utf-8?B?MGdzZmhLelJ3cTYwN3F0Q2dhMGIxaVh1c2FNR3hoSDdmTkpGVWhLVkdYeW9X?=
 =?utf-8?B?WWY3bURBZUpobGl4WVkwRHplVnp6OERCdDBzYjA4Vk83aW5XY0NXUVczTGdL?=
 =?utf-8?B?bExmNGM3OVd0MnhsMVQ0TjVpRE5MazVWMmc1WnB3WW5HU08zYjdUMW9iYUp1?=
 =?utf-8?B?SlNpSVp5eUNCdU1USm1ROGhaeUZoNzA2dEtKSFV5TWhsRTR6bklyUnB2NThX?=
 =?utf-8?B?blBxaVF0TVZuN1lLUWFWc3JCOWg3SEhubWxidnQ1aVg2b0t1b1Z3aEJjbmhX?=
 =?utf-8?B?VjQvZ2dZNVh1UW5KRVVhOTVEWVNDcXByN05zUkNNak5wai9VVWlpd2xhQXRX?=
 =?utf-8?B?bi9JcE83ck8rbm1BSFNhejk2QkpCY3AxbWY4T0kzOHVMbHZMdHFNL29yalpB?=
 =?utf-8?B?WkZQM3dqVCtTUVJ6cE5peENCTHZpMHZRV0N3QTEwT2kvaFdWOTVXV1Fkc0R2?=
 =?utf-8?B?U0sxdWFvSGkvRmYxbEJ0Wi9sUitzQTNmWi93angwS1dybHY1WmRkZjNWOXlK?=
 =?utf-8?B?ZG1XakJwaSs1eGdnM0xIaEY2blJrUDRlYU9STFQ5V0UzUHRFMmtQWVNUcHdq?=
 =?utf-8?B?cUl0WnVyU1puaEtWRHRDMWl5Z211MjdMc2ErZUs4VVF4UFFpNnZYbDVjOURT?=
 =?utf-8?B?WGtVYzUvNW9oaXlYZ0w3akw2TFB0bVJQcXRZalVkZEFkMnRWUW01L1A3U1ZL?=
 =?utf-8?B?Q0NrSWtiSm5oeGM0djVpdTFMMkZvSUdQS21VR0ZLNmo4UTZWbkorREhRVkNp?=
 =?utf-8?B?VkhZMUdTdk5LY29DMjFtVjdWdTdpb1oyQUF0NXhrMTcxNWo2OXFyS0RRSWNk?=
 =?utf-8?B?Q21HdTdPVTlyLzllL2lzaDcxaXpSUExGNU5adE5SdlllMW1HT3dqVUNVN0p1?=
 =?utf-8?B?b2hJZ0ZocnVQaWlQZ0w3bzI1MmI1cm9pZ0ZRVS9aYU45WFNvZmFkN09VeS9P?=
 =?utf-8?B?TnplU2g2MlZLVWdmWnJCMHlRSms0T3RWMHVBZ2pRUkozeVRXcDkyMU5idlpW?=
 =?utf-8?B?WmQzZlZUcDdhZFcrRmVRVUZhR0FINXEyRG5TWW9YdnRCQnI4SGM1bVkxRDVs?=
 =?utf-8?B?Nk5vbFBNZnlsbDA1djE4Y0hJTkZqbzkvaFVGTTRieTdzZ1AwajVWV2NvbjdY?=
 =?utf-8?B?L3hWVmR0Ryt0VTZPWFJaUGRoZ1lBWnl5NWtNVlRRL2VvWUhJUFJ5SVJsMTVC?=
 =?utf-8?B?Zjd2VnhYUUdQYWF1elRNVkFGTnUvYXEyK290MVR0R0R5bUFCYkNMYjhiV09P?=
 =?utf-8?B?eEpIRWN2RDVCeEFtY3gxb3QxbzNTOXVVd2pSU1NMZDRNNHBXUGVTL3c4MEFT?=
 =?utf-8?Q?gWZ1YZRWfoGJo6tbsniRSJoRz6eynJ40?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUM5bkRQSXdNditMc0RGYUVCVnVFUVprTCs1ci9Lb0xMSU5BUHJLNlN6SGFi?=
 =?utf-8?B?NzBJUXNsdExJY1J1c2Y0MC9XVmo2VXlUKzZxY29vTHJXWE14emN2N0JpRDdp?=
 =?utf-8?B?Tmg0UnBoS3dYRnZwUlVxdGhyNm4rM0dFTldlQ3JJR0ZnQ01BVlo2OGxpcCtJ?=
 =?utf-8?B?WjcxdXZ4RkFya2xqTTduWEdmZkNkdjhxbTF2YURBVVAyWWxxVjRqZDZ2dmhX?=
 =?utf-8?B?djFxTUhaZTEwSURLN0lRZXNSMUJtZFN2eFE1VlZMb2FFQ1diTWhoYndVOEdi?=
 =?utf-8?B?UVhKTStpakRKeGxnTXdZck5remxHOGtMcE40Q0RIaVFDVDhXTUEreUpScy95?=
 =?utf-8?B?Y3Z6QUZIcFBYeWZwU2NOOU9acnhvUC9nREVEZHlxdVFoZkxWby9Lck1hQzNF?=
 =?utf-8?B?L0VtZDVkTXFQRVlKaXdXbHFLR3ZqZUZqcWoxMFAwcmJocWd5NzNKSUxZOFUx?=
 =?utf-8?B?UVRCQUpRalZTLzNJNmhDc1E3WVlpR3lIVjdlUWlNd2NzSExLSVI1V1V5MVpW?=
 =?utf-8?B?SzRTZ2d0TWlMT0hVNitwd2haSG80eEVIUnNvLzVzMVlWaEl4ZDdINFp2Rmxn?=
 =?utf-8?B?NHBXQjdOTUpJWlNYN0tYNHJEK3VXalRwV0I2R2VFMnR4d0VSSEJXb0VTVEgr?=
 =?utf-8?B?Z1VYWDc5WHVZZXIxMndnaXhOMFZVNTAzOUh3c2tjdmpSQWRzWk8xTkVTQTlO?=
 =?utf-8?B?TVpGaEx0UGp6bTFkczhmU1BGUXQ5a21xOXVQV1J3SUtmVTBkL1R1aGNTek41?=
 =?utf-8?B?QmRnT1h1b280Q1M4MHltOUVlNXA2T09McTB2OENIV1BzTjR5ajI3UjRvM0VW?=
 =?utf-8?B?YmRJbld5cldnVzF1MlZibkwySHcyVnMzd3dlVkdjQ1FaRFlVTFlZczB3UzNp?=
 =?utf-8?B?Y1JJbEczblIzZ0lYS1JZUGhjTWFuY3lMSXl0a3ArU2hiR2FSTm9iQkpPcU5Z?=
 =?utf-8?B?UlhvemNxckx3ci9ycVFKZHM5ak5LTWNIY2RGK05TVmo4U0sxNHdsMGVibWhJ?=
 =?utf-8?B?OGtOeEsrT3UvV0txOXlrSk5PTVVqcmN2ZnFhalRVRnNWai95YUpnNGJEbDc0?=
 =?utf-8?B?TklHdVBhSzNUNmJmbnBwVURubVFWY29lQVUzMGhKUlhzRXdUT1o5TmxrWFIz?=
 =?utf-8?B?NlB3R3NHa1hFTlVZQithOGIvOG9Rd2dscUpGSVpZZjZrUDlaWHlLdXp4VDFO?=
 =?utf-8?B?VnNWVlVrMnYwMjhtdkFOaGw3NjlyWVQzL09rcjgyM2dta2s2MTBXRmVXTHlI?=
 =?utf-8?B?bVl3VEJGajlqRU92UTAwVjJDd1JIRy8xYWVaRHV4eVpmTS9yNldXK0ZqMUNk?=
 =?utf-8?B?UUZUNkljWWttb2MvSWhoajVHN20wT3JkN1h4aWo2VkJKSTJ5V2swZnJ6WHht?=
 =?utf-8?B?TWg0TlVBNitIQXNkRDlnVFRNVHlNY2J6aGU4OEVKcTJSVmFUS1ErejQ2eTFW?=
 =?utf-8?B?R2JZakRtQTh0RVNVVnBUcVZvVy85LzA0VjlTdzcwVkN4RCtyNzJUYktNQmRw?=
 =?utf-8?B?aEROeGcxZU9pUEpKVnhvK0toTm53VW9Wa0E2dnVWMzh0dnVqekc2eGRVd0Zp?=
 =?utf-8?B?citEN204RE9DZFQ4SG1ETXRxeEIzRkRqNEtXNmJEU3greWdKRG16dFJzRnBX?=
 =?utf-8?B?NnBMT0QzalZ3UUZIYm14M0s3UjkveUk3OTdmUEVLOHNiemtNVG4rWVd5dWQ5?=
 =?utf-8?B?dGhwWC92WlpKbzZWUEU5K2tSQk05K0VhaHJCOEVLdnpKdDFLTTBWVlNGMkdZ?=
 =?utf-8?B?MExidzVRSmJpQWp1aERzdkxDOGhNTURDWlJzWEZJdmVNMXlNUlF4Sm96TTNL?=
 =?utf-8?B?aWdRbE5XZHQ3SmxHaWcxcE9BN0FyaG0zam5Uc1kxakVTOG9rVGVDTXB3cTd2?=
 =?utf-8?B?QnppMjIwNENNNE1GTS9JQWV3eVd0bzl0dnUrY1NTL2xucnNHemVWcm5WeVFR?=
 =?utf-8?B?YUhVSU80U0pZY1MxSXk1SnRydisxcVB5MnhOb2ViQ085d28wVm42ZGNwS3Ni?=
 =?utf-8?B?cTFIVXhsOTB4ajAwalJwNGJpOUtRSzB5cHhyL1JqQXpLK1dpbFJNM0g2ai8w?=
 =?utf-8?B?QjNPZHY4aEx1SG1rTzM0czlMRGZhdGFRZ215bU9IZVZjY0Y2L2NMWFJERDRI?=
 =?utf-8?Q?20VCwbiE/p6CYsFHMkeHsYXbC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b37cd8-a151-4692-03c3-08de0184acc4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 07:24:08.2350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nk/awPWtsaHdvBFRvAF1AGXZd/98y/I+f9MavEZ5GTZYgSvlvBaoB0Y7a8gJwHMW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
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



On 9/30/25 09:09, Michal Simek wrote:
> Enable MSCC phy driver instead of VITESSE. Vitesse driver is much older and
> is on the way out that's why switch to MSCC driver which covers VSC8531
> which is used on one Versal board.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/amd_versal2_virt_defconfig       | 2 +-
>   configs/xilinx_versal_net_virt_defconfig | 2 +-
>   configs/xilinx_versal_virt_defconfig     | 2 +-
>   configs/xilinx_zynqmp_virt_defconfig     | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 4a7bc1951451..aca03ea50f16 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -108,10 +108,10 @@ CONFIG_SPI_FLASH_WINBOND=y
>   # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
>   CONFIG_SPI_FLASH_MTD=y
>   CONFIG_PHY_MARVELL=y
> +CONFIG_PHY_MSCC=y
>   CONFIG_PHY_NATSEMI=y
>   CONFIG_PHY_REALTEK=y
>   CONFIG_PHY_TI_DP83867=y
> -CONFIG_PHY_VITESSE=y
>   CONFIG_PHY_FIXED=y
>   CONFIG_DM_ETH_PHY=y
>   CONFIG_PHY_GIGE=y
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 770bd0643c19..192ace8b530c 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -111,10 +111,10 @@ CONFIG_SPI_FLASH_WINBOND=y
>   CONFIG_SPI_FLASH_MTD=y
>   CONFIG_PHY_ANEG_TIMEOUT=20000
>   CONFIG_PHY_MARVELL=y
> +CONFIG_PHY_MSCC=y
>   CONFIG_PHY_NATSEMI=y
>   CONFIG_PHY_REALTEK=y
>   CONFIG_PHY_TI_DP83867=y
> -CONFIG_PHY_VITESSE=y
>   CONFIG_PHY_FIXED=y
>   CONFIG_DM_ETH_PHY=y
>   CONFIG_PHY_GIGE=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index ac78dea587cd..18b972f8ba46 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -120,10 +120,10 @@ CONFIG_SPI_FLASH_MTD=y
>   CONFIG_PHY_ANEG_TIMEOUT=20000
>   CONFIG_PHY_ADIN=y
>   CONFIG_PHY_MARVELL=y
> +CONFIG_PHY_MSCC=y
>   CONFIG_PHY_NATSEMI=y
>   CONFIG_PHY_REALTEK=y
>   CONFIG_PHY_TI_DP83867=y
> -CONFIG_PHY_VITESSE=y
>   CONFIG_PHY_FIXED=y
>   CONFIG_DM_ETH_PHY=y
>   CONFIG_PHY_GIGE=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index 6e4ba7269f85..525744b0f61e 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -171,10 +171,10 @@ CONFIG_PHY_ADIN=y
>   CONFIG_PHY_MARVELL=y
>   CONFIG_PHY_MICREL=y
>   CONFIG_PHY_MICREL_KSZ90X1=y
> +CONFIG_PHY_MSCC=y
>   CONFIG_PHY_NATSEMI=y
>   CONFIG_PHY_REALTEK=y
>   CONFIG_PHY_TI_DP83867=y
> -CONFIG_PHY_VITESSE=y
>   CONFIG_PHY_XILINX=y
>   CONFIG_PHY_XILINX_GMII2RGMII=y
>   CONFIG_PHY_FIXED=y

Applied.
M
