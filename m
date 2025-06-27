Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FC7C77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 09:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DA1382E52;
	Fri, 27 Jun 2025 11:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UVdVsK4K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 141FA82E35; Fri, 27 Jun 2025 11:42:05 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFBCA82F54
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 11:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reukONI6sqQcP4jc046K+jjta/XSa0A0fr9OQ1orgx9Xa8R31Socrb9Xk4gZuNljNH78SVlmUa/H+66X6UkAC5T5XWpdKVVSO4Y87W9mYtiEwmAKURoLSyZuz8cho0PElLw47vOaWl9hwy5IB3JBBs84/5j8JaajWlNkkUFSVzzS3hOQjz6m2rIeMczzkhjseWgDJFfKiNAPTUEZqtrfRUv5dRmDCrjIgJA2oEdT9mKVFht2qhTydxsdn3nAkpa8jz1+B9Z46PM0kmGXG0DOPyCTUKzmkgkHtABE35/7LdEPhh8F3czjEUVaMPodVYNQznoWbhO541zc3gSDoYPEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c58MRNjO23nB+RbuCygfQw+uKuPXAM1Df8JPpSABH7o=;
 b=nfCSyxDVC2rZJ6YXi4eUlLMONEuxpBKIzcY+rdkniIGw2i04MYG+NQirIUkdmb8Zeiza1ZFX9Uzkhj3l69/JH1n4yl3E8vO6pEQHmKSdSlx+pwERrLp/EZfccqyA7crPHbr2iclpdS66aCFZCR8/gRr0/bVr/fx1livEaHdIEoN1C1SHhQO5fWkeX+ASPcFOdlHU5B57ZyrYjFi19nMqQyAA3yLoWj6TDxNvDmxgYxjo0TO+UUnOV3PgWNQbu8FHueG3rVIg8U0gEUFOwA+tOBB6mIpQ4XxLJzgufX5Q0irzMs4Ub1zx+HMZhtjkCh6CF5CITeYIUMmscZSP9tNPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c58MRNjO23nB+RbuCygfQw+uKuPXAM1Df8JPpSABH7o=;
 b=UVdVsK4Kay/XexGo4FXytAP6rIsB5slzpZqdbTfF1PMPVMncaVS7wx2Pa7K8Nq7gQnsz5+gC7W5WM6kzO2OMxHcvz6TAFj0q7FrYLJWJ6eZHlOcHX37uP/eJk0VUyhJrLn8ldUQMYih0VzFFPTv4mT3aBGOqD0FfeL1k9Zz+fCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 27 Jun
 2025 09:41:46 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 09:41:45 +0000
Message-ID: <79494419-79ec-4566-be3c-f378dc00a0e5@amd.com>
Date: Fri, 27 Jun 2025 11:41:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynqmp: Enable xilinx ethernet phy
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, venkatesh.abbarapu@amd.com
References: <20250624084645.1185428-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250624084645.1185428-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 3470efdc-c0cb-4fa3-ec17-08ddb55ed4bd
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1dnTnN2ZU5hUW4rbEVQTVlLZHQzem1uS1dXSml4S1owcVY4Nm1Wd1ZyYmJQ?=
 =?utf-8?B?bDNRS2p1N3MzcndSWThodXhhZThsZTdXNTVYOW9ZYklodHNFRU1kMG1pSkdO?=
 =?utf-8?B?TWJSVm5xTy90NGJmdEhnVVdmTUdyRTNvQWhIeFUrWU8xL05XRzE0SVc2ZHZH?=
 =?utf-8?B?dWpVa2Z3Nms1ZS9YSFpOKzR1TC9qWW1HS1p6bHMrOStHdHhEUTRtTVZvOTh2?=
 =?utf-8?B?ZndPbm5BdmtuUkVDOElid29aTzVWRVk5UXRuT1N2ajR6cUY1TCs3UWJnR0FF?=
 =?utf-8?B?N1RnYVNJV2h1dnczazZ4Qk1QUWRsbFFGbG50S1RIeXBiQXNsZzQwbmxLNnN3?=
 =?utf-8?B?ZzRWNjVkQ3lPQXREL3EvR2NURk90SWtzaklDYmhqVDE4M1ZyajBPSVh3bWRC?=
 =?utf-8?B?V3lJN1puNWZwQ1d2cjFMejk1TUZyS3pSUXRkU2ptRVlIR200bm5IeGVPNitm?=
 =?utf-8?B?eVJYaTBtWmdJVlhvR0R5RC9BSW9iYmlNMm5JNnVYNHdwZjFzN2dja0J4SWl5?=
 =?utf-8?B?dHdyZHhLUzhiN3hyeDJpTXNwY3NKTlY4Qk41YkN1NmNENzh1UEY0aXNhbmFt?=
 =?utf-8?B?ZlJZZWFiOWZ6MmRzRGZjT2ZnbXVwbDE1anZQZzBkVlY4RGtvb002N1RjU3RS?=
 =?utf-8?B?bFkzUmxIb2NwNFBTMkYwL2Nrc2daakcxQXBkZzdMWm1CYVd2MCs4T1RnaExU?=
 =?utf-8?B?TW1VNzl0bG85Yi9VZlJ2REdVQkVKVDNlellYUmJiOW5rdDk1STQ5Ulc4S3By?=
 =?utf-8?B?ZlJvbUZRY2RJcUhmb2NSTTV1bURpU0xXdjJjY3ZYSHMxNnhjSkxxeHQ2N2xJ?=
 =?utf-8?B?bTJ5RkcyK3dVZkFYN1lHejdwK0xxQzl3bXB5UlczRm1sVXppMC9CeTZUSWlJ?=
 =?utf-8?B?bzlCZDgwbGpqRytYL0F4TDJ6Nk9pVFRXenlhYzRJWGd0UDBwMmFaL1A5UVE1?=
 =?utf-8?B?ODN4WEtWeklDQkN6R0JxVmxNYnFkYmlxdlBNelFkMkhhVDJkdkNMOHN6NzJC?=
 =?utf-8?B?bEo4TWFDcXJwK1NYMWJyQ2F4Y1pROXJxcjFDR1lHM2RvekVBSTFXWVVWQ0ph?=
 =?utf-8?B?WUxISjRyYWRuTXRhNWpRMXZTRk9BdTlzOTMzZERiUFgwY05EZTBpWXJwZkNH?=
 =?utf-8?B?TW4rM3FGZUZCYUlJWTFLdEFlOVNxSWxVZ0NXRkhaaXgzcHhlVzhXUmd3dVJW?=
 =?utf-8?B?UW1PUmVzZEJYQlhScGNlK3hoU2xIVFhDSVQ1Y3owZkRIK3lnYXl6VkgwTkhV?=
 =?utf-8?B?K3prQ1RSYlh2aGRyNHo2Vjd1Ykh4M1ZLSFkwYVczNGl1eVM0L1poeS9DNzEw?=
 =?utf-8?B?c2FXcG52QTBCNUFxcGFmNHYwSlZzQnpwU1pnT3BIOSs2a3daYmxSZDNWUlJh?=
 =?utf-8?B?em9hVXBCRDdjSnU0NHIzdzFuUHhqblBmbkhuemw2R0preUtyRk5iRktiZm5D?=
 =?utf-8?B?R08xZTQ5Q0pMUGx5ekJjMHFpdE01MXBQaXhYcGlGdjYxUk1SMjNlUGdkZit5?=
 =?utf-8?B?SG1MT21MSFdQU3B1NEtWN0xYeVpvcDQwZ0J6T1B2UkxsaHZMNlVrSEo4N2k0?=
 =?utf-8?B?QmJqQTJPc0p4N25teUtaR0JOVTFBTEdzbnlRSGQyUHg1aENNdnpuMWZFbHEw?=
 =?utf-8?B?V2FrUjhHWmwrNVhKRFJ4NUJ3bTlFMDVYdHhncmxONmhPVnhnMmZZMUZvdHZn?=
 =?utf-8?B?Q3RmOTZjUFV3Zy9ycjZjWG1rWEtqcm9UcU5QZDdReC9oeGpVRFg0NUZYWlA0?=
 =?utf-8?B?TXBPZXg4ellJMTBJSGlVOEpTdENXYThEREZDV3BFaEZ5eW81MFEzV0NQdGFq?=
 =?utf-8?B?QWtsbmhMd2I1Mm9MZnRhUVBiZTZOZjErM2JEMHQvSURTaEN4T20zRkFZVkly?=
 =?utf-8?B?dWNqVEVERndCWVZidWFVMER6SndydjJ4NGE5OElOUDZERVIvTXJOZ3BHMUQy?=
 =?utf-8?Q?Y77pypSaITA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC9YVUJhVmhaZWpLUDNabmlvd2Q1TlZmbnlvRExMYlhSa1l4QjNyTnJoakZW?=
 =?utf-8?B?cE5VWWpqZHp5T3lFYkcyMlo1V1UvM3lrTUJXQ1lqamhHTnRoMGU0TEZYVDBM?=
 =?utf-8?B?b1Z6bEFKSjdqOStoV2l4b3Bjc2M2ZTZiSFc0cWZyMmNSSEdtV2NHUGZTMThB?=
 =?utf-8?B?VEh5aTlLZXg3MmwyV0c3Z3ZPY0dpUGZLWnpIUko2cmlkQlRqeU9rWkJ1L1lY?=
 =?utf-8?B?V2JTdSt4MDVnK1o1SkVpN0tjM09UTWtxdGRIM0NDb3FWTGpMbXJsR1VuazFV?=
 =?utf-8?B?ZHp0RHdidVRpcGtYVlh5WFl1VU9WUm9IazcwSjNhZXJoT2pqM1F4eTFPSzdD?=
 =?utf-8?B?blFlanFra0pDTjJpMm5VM0lJSDdmNVBlZzFHVDZSVWlCWHZqTUNGVGI5S3RO?=
 =?utf-8?B?cVNaVnhwcnFodjFWRVBMUnFQcWNZc3haK2xwY3o1YVB6cHBMNWZ3SUZqeEQz?=
 =?utf-8?B?VWVlUFBXUVhiQ1dIck9URjBEZTREajcweTZjaFFDTVpEZUVWUHQrZU5GTi9K?=
 =?utf-8?B?OVFCSzNZYTBWZEo5SVhtK2JIMXJYc2h2dnlKWnZLVjYwV2kwWG9Ibndpa0hM?=
 =?utf-8?B?cjZraFZ2NGVvSWxIcVorajB3NG1QdUUrUzBmQ1Z3ckU3UnYvYUF2Mk1mS2xl?=
 =?utf-8?B?UkN2anJqSlcxdnJTcUlLTnJNNjlkOVpYVDVwRDY5L2l6eFNuZlRST2o0QXZ6?=
 =?utf-8?B?cXNyd3NHU2VGazZNY3JQNENGVjRMMlpWVXBSaUlGR0ZDRnVCSFhqK2lwLzFt?=
 =?utf-8?B?OXZkMGwrb2EzVzAwMHNrT2NUV3FRdzF3VExNUkhDOWNZMkhmNmdZYVJjazJT?=
 =?utf-8?B?T3ZXYzQrUE1XSDE0OGlwOWszMC8rVU9UWjdOTGVaUExuV1VrV0F4QUtnd1ds?=
 =?utf-8?B?YWtNMlk0MEJ4b2ZLeEQxOUpZZmJ3MTlINUdQWWd1UDM1U1dlbXBCVHdDbGo1?=
 =?utf-8?B?T2JkV3RwZHl4d0Y1NDFjTVBOcUFQeklwaGhxWWhVdjQ2cm1FRE5qdWJmWTdE?=
 =?utf-8?B?TWhRanh2T2FZaFVFSkE1dEpySGdOSnBtZzFqSGZPSVliRTFKUUdFa3FleXQ4?=
 =?utf-8?B?MjlZYXVreDNndTJRZGdQdjN0cEdrM3FDM1B3YWNvVk9BQm5LcEZjc2pHT1dX?=
 =?utf-8?B?MnNvQ0oxVWNleWZoYjQ5QzNsblVWMnRUNXpkT0FMYkRNVnAzYXFtK2IxVEFT?=
 =?utf-8?B?SzhhTXpVemxvRjNnWThNSElsMXFJVjFCTWZIQUZ0SDdWeitYZ0QxSDJFTld4?=
 =?utf-8?B?cjNLcU5ldWN5N1VJTm9vVms0Z3JHTThtWHF6cWc3aE12RmRxYnVETVZ6VUVh?=
 =?utf-8?B?SkE5bitncnBDMHp3aEk2cU0vNTFTbnNNYi9JMmNDSWNGNlYyelFLQUpsblc3?=
 =?utf-8?B?Ykxtc0JEZFRIcllKdkNkdTFPZ3l3Y05ZSm4vblpveWJJQU5WSTE1UGNwK2tM?=
 =?utf-8?B?dGF6ZlFldE9UVjh6d0FLSlRtU3kzMkZHRVZTdVp1MTgvdktuMnFxM0JRaFZj?=
 =?utf-8?B?VjZzK1B2RE9saWJEdktRVXhteDd5VGl5WU1abk1XN3NNOUI2UDRvZFkwck81?=
 =?utf-8?B?Vitxc2xiOTRIRWhqOU1pdnI2YkZ2SlR2dm9NeWp4emFhWGpsdThBdUhhcjE3?=
 =?utf-8?B?ZUIvY25sK3JHRmIydTNSTENKcEp2ZFVxY2xoM3NKVEtoUXdXMzQrN2s3ZmxH?=
 =?utf-8?B?SHpZcDJvYndLbUkzNWEwUHhvVzRwbXRPbnBYYm55aUxRcVNzN0NlSXBQd3Fn?=
 =?utf-8?B?Tnp3c2ZpQ2diOGdiMHQ2OFhLQzFjQlBTWlRoWXJEOS9DSXZHUFRaSDViSStO?=
 =?utf-8?B?anpEcHVSTWc0S2F4NmkrQmNIYVBKSEU0N0Y0WmswalV3bnVzdWNQM0kyRFVJ?=
 =?utf-8?B?NXhHc2t6SHczMWJOd29wMDIrdXdWK0x5cFZBWmlVemdTRE1uQ0syZ1dJNXhq?=
 =?utf-8?B?d0Y4ZDYxNW1kR0hNVmVhMWZpN2ZFNitDN1VTbWFEdExieWc0QXNOVms1eUR0?=
 =?utf-8?B?YVp3eDlOV2h5T0xPLzlHN1lrdkJ2U25DL2tNVUFIaWt4R2h2UFk5U3JFVG1S?=
 =?utf-8?B?cXNPMzljS0QwS29sS0FOWmpFeGdvQ2NxbjR6b3lOQjZHSFNUODkxM3F3WHpm?=
 =?utf-8?Q?HF1dUUmwnqoAqekc11pk0V/Fx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3470efdc-c0cb-4fa3-ec17-08ddb55ed4bd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 09:41:45.8420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nftEiJdSgxBqpAfmbpknP8An6u2SfKQlhKRze34sRXj8bzjl2hF4P+8D5ALy85fb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848
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



On 6/24/25 10:46, Padmarao Begari wrote:
> Enable xilinx ethernet phy on ZynqMP by default.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   configs/xilinx_zynqmp_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index 7807f6240e3..a6afcd00b5d 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -182,6 +182,7 @@ CONFIG_PHY_NATSEMI=y
>   CONFIG_PHY_REALTEK=y
>   CONFIG_PHY_TI_DP83867=y
>   CONFIG_PHY_VITESSE=y
> +CONFIG_PHY_XILINX=y
>   CONFIG_PHY_XILINX_GMII2RGMII=y
>   CONFIG_PHY_FIXED=y
>   CONFIG_DM_ETH_PHY=y

Applied.
M
