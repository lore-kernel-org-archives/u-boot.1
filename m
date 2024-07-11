Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEF6C3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 12:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EC3187DEB;
	Thu, 11 Jul 2024 13:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fif9+dCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2933187E2E; Thu, 11 Jul 2024 13:59:54 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3814588049
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 13:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5Lzn2VQK5U0CjTcv4SRbYWtRlRxDnNvyVQIIBwNuzLoYIDH/XsVoNchMh+RKwFOlReCEeQRkRD51Edh5XDthGXs1FAd3y7tH5WD62BhJssGRJGhFEAYq1VaFSoVNkrl0tv9BGO61l9bmEXW+XC6AHNWkoYhuPhlPj6MJ3tNnzGBP1IwajoAeOroWiqcpJ6MrJ8eDvYexCZkYFghlWqNURN4PIHrUTiZ4AfD4Er8T2QdQ9IGjPSYdpaD4tVaiB0Ywx5V3JNQwqKamAccp/n44UgdT1H0EJIzy4gaD9JTCZj2PDVR4c9n2KVP9bY/UycD0l60wPrNozYXgup4UVvtfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rja6SBDTqlce9RZr7BKmZ5Yx9m2FlWe36bXFrUIGfPg=;
 b=IkjHMbzlifC4wrfO0NaT4/I527/h/VamEUVA5yekgiI0MeeyTLh1H/SCD5rczaeVtEVHMGzDWfhsDp6F9ka+u2+2gOoB/GzFfx4tuuTinVxWIXMVyxg/ZJwMRzfSP/NB0xUR2nTmWdGnGFYsd69LbcRXkYAEP+lFdzURpN60eALAVukY9q3vDQ6doCs54ixNEpXDSOYpqD5oy3puOcZ9wgEazeIDNngYq2n9Ji9Hj+FtogVpaf+Xc2eJMuBlYkV/P18ax5hWr0k3XE1us2UgeEyncyy7U4va0MYhXmLgkYZAyXvK1ZgguBg3fviF2yA/J7NUwWpCbVPNces/3eSIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rja6SBDTqlce9RZr7BKmZ5Yx9m2FlWe36bXFrUIGfPg=;
 b=fif9+dCVgjLs+MkPzRMYnrxD+GWYG712XleZ8EPrvQTvyI+M4o8avuGyOlti8Bh7BWVG98p667gDyhZGST+ChIcEAFcqvD96UKc2XQcDGDWGt7XXMftrQRt86BPNOzoLgeigRDzmQx3EC5ESOU60IDP12uvkk3P/qx4mvBX6NfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 11:59:46 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:59:46 +0000
Message-ID: <4c810a5c-13fb-4b94-9fc1-6e15ad276142@amd.com>
Date: Thu, 11 Jul 2024 13:38:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add mini configuration support for versal2
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20240619071733.10256-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240619071733.10256-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0193.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::14) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 600e9fe3-e294-4aa2-81a0-08dca1a0f52b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWZpVXRCNnJmSERxQ2c4bEhXbGJGSjhVTlQzUCtJcmdQSUNuZkI2cko5LzlW?=
 =?utf-8?B?Vll6aTAwYXdEUzRNendHUnp4RTJzbWJUaGZEZWcwdGFHcGVrUXdBeUI4OFF4?=
 =?utf-8?B?dER3Ykt2MUNYVkxPUVBtZFlkN1NQdEg0b2VJd1E5djNiMlU1aGg5Z3J6TDgz?=
 =?utf-8?B?VGtBR0ZKa1crWm0zNUFzRTl4b2p4Y3lWWGhjZ0M0dDd3ZjRwYnRLeTg3ZHJw?=
 =?utf-8?B?dTJoNUFNdzd5c1pjbC9OWEJIQ2dXSzRFeXNYLzl5YU4yS1lOWVl0ak1KNWFL?=
 =?utf-8?B?cHJTK2lFSzFESzNybWhLS2RYN1M2OHlHeGNVeFg2cythNU1xR0RiTWJlaXBa?=
 =?utf-8?B?MDlVaDA0ZXJrY3lkdHhZRVNlWE9LV1p4SFJHc0R3c1QzUkxra3R5UzVQNzFD?=
 =?utf-8?B?RVFVY3NmQ3NmZXNwZi9jRExBc1cwUkZwSys5dHlMV2JKcG1PcWNvUUJEM1Q2?=
 =?utf-8?B?U3ZFMzJjWFB3VVJ6L2l0R0tSamRabnE1YUdPckhITjh6NG91QWFmWGRZeksv?=
 =?utf-8?B?SWhIa2t0QU9zSjJxcmdjdVZqb3JHZ3JnZld4cTEwaFRybVJmZzlhcHBUUHJo?=
 =?utf-8?B?dVFJbEFHYmd4YXViSXo3UStXdmtIQU5nYk5CSkJ1azVpYWJ3VGRia2thUHhj?=
 =?utf-8?B?cVJlMkdjSHpmMWRxeEI0T2JFODBqWlVrellseVV0NE1JTTBGWVMwd2xkc1Jv?=
 =?utf-8?B?TGpycnBrZHZ2VUJWSTRQZmR4QU01SWRyVy96aWdoSktxUWVzbXVBSTFTc1J6?=
 =?utf-8?B?cHZheGpYeVVETDh4WEVheVFSTUNiemc0bWxpTWEvTVVIbGFZRFlYZW1Wc29l?=
 =?utf-8?B?b3UyUWdnSm9pUyszWFFaWlg0YlJzNkZ5MmJVSER3NU9iVCtTL2VHa1dSR0pS?=
 =?utf-8?B?ZlROaE5hQ2J4Ym1QdHFpcFAvNUtSeXZ3VTJpL0hRMXhKaGJtcEZhbG9xSTBx?=
 =?utf-8?B?SEFWa3VaVjNhSUlLR3IxSy9Ic3dBT0drc0FXTGNrdXRoTzZ1OVUwZkNxQmRD?=
 =?utf-8?B?eWF5ZGQvcm05SDMxU2hFakxROEVQNVFzNUZZdmR3K1RJck0xUklMaFNOZXpp?=
 =?utf-8?B?WkpiWVlQRU9NUm50SHpRcUthWnc2QWhReUR5Tld3RzZRN2szRjRnOHo0V0pC?=
 =?utf-8?B?Wi9JRmN5WlJ3bUxmVGpPS05lb2kvcXB5aGwveFdPdTZsME1ZeU1PRzNyd0dB?=
 =?utf-8?B?SHl0b01nMzJKSy9ZWTFQWlVSZzlJcUtiRWJnSytHMnArSWpsT2VZNEpjK2la?=
 =?utf-8?B?bURiOFljZmFhODBBTTRSV2ZKUE1PYUFqdTlUaUp3ZUZLdVhjdnRCTWhEaEJz?=
 =?utf-8?B?ekpFd282c2FadWIwdlhQN2Q3ZTVMNmJYc3NlVG5VTDhaelVNWGtFTjk5RE1K?=
 =?utf-8?B?Z3A1andqZ0VjR094eXRrSklVREZQT1dtcm1IYkFsVnMvVmJGWElCNUU5WmE3?=
 =?utf-8?B?aGlKZDdIQlFicDdFODNEUitlSi9nM3lVTWozR0NIY1ovR0ZOS3EwR3Q4eGh5?=
 =?utf-8?B?VFQ2dnRzTG44NVc1U1ZNdHcyTEFFV2Jld1pSZjJ2RVpNYVVnK0NWNEs0MDUy?=
 =?utf-8?B?ZldzNVhYQ3h3VHE5R1k1RXdISG5hNDhSM2tXN2MwcU8vQWZ2aU8zWk1Cb0pU?=
 =?utf-8?B?WnliOEZoZUxqcjB0YS9wM1hHckhrUWp3WUU0TjRyMUxEYnltZ215RVpWVEEy?=
 =?utf-8?B?MW9hUDJJY1phZFU2UmdHZnZwQ1lHakpmNXlKMW5qVUJNbndZU3lBQ3Brckh1?=
 =?utf-8?B?MXlzVnZjNTg1aWp6VWl2Rk5YdjJyNVpnblNYV3JQQ2hrTThHOVRoTHhjamtI?=
 =?utf-8?B?aS9DV0dTVEQzNUswOEZMdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy8rNUc1MmtrTUp3VGRVRWh1WjVNbG5oRGpiK2pyQmt6WXp3TlhFQ0RyelBa?=
 =?utf-8?B?cVpxQUVUNTNrNDFPZmlqZnMwMW9QV09yeHcyQ2UzNVdjNW5BeHgrcUpvWVZZ?=
 =?utf-8?B?VXpJVlBmZ0NReTZRcUp5SitFV3hVdVZ0ZmJaRkdxYkFoeE1NWUF3U0ZqY0Jh?=
 =?utf-8?B?cDJUS3R6a3hGSGY2V3dpQ0hJOUNFZ1dGek1KVnFldnpneW5WV09sblVwWjZh?=
 =?utf-8?B?TEFESE9UZHhSdlZEbElqYWhjc3FKajdUa1dwUDd0M2UxajBZQmtib1Z4MTFQ?=
 =?utf-8?B?d3BmaXZsOFRCcDR4aEgyWUhRUjFxdGRoa3IxSjZYUUZrL1hsTEF1MGFPOVFn?=
 =?utf-8?B?V0IwZVdLaUNyb1JFVWlCR2RlR0w3L29BUmZyck1ycGZhU1NNN0k0b3NwbGR4?=
 =?utf-8?B?K3RCRUpuTVpnUlEzcjRBUzBJa2ZURkRrdUVzMkpCa0tBV0s0SXhJVC8vT0Vo?=
 =?utf-8?B?SC9qSjZvd2RrS3F5c1o5c083RmdRcGxKS2JGeGE4dHpaYnRkR0ZVOHBzVlJX?=
 =?utf-8?B?UkNrUldxbDVzbVNwNVJkTWpnWDJ3OWJzRkp2c2d6bmhPM0xVczdibUlxYWdL?=
 =?utf-8?B?TjZnSVVjTVRIbkNIb1NrdlR0RlRQenpjRXdLdjBKY3FUQkVRNmQzUnFIMHF2?=
 =?utf-8?B?UGlTVXB5RmxTL0JkbXRMUkc1dkFuajlGL2VXSEdkZ1h6NFlQZVJnbXVKWWRh?=
 =?utf-8?B?YWZpYWZ2WnZ1R1IyV05QOVkxTWZGNVVrbnBRaGttOEQ4aE9jQTB5L1hYTnJV?=
 =?utf-8?B?UXFGVVF2dEpPZ2xBUDhPVlpFNzdtUEhmNmdHMXV6WFNXRERNV2ZxYmFGSXp2?=
 =?utf-8?B?SDZsZHhWQStiUFpNaDZhZXhFYys2UGdzN3NjVXBkSkZzOThKSUVVUlNRcXRR?=
 =?utf-8?B?V1hvREVsaCtFQjNTQW9hZldlSGwzMklCUHF0M3pyM1Z1VnpCMVZRSnl6SzRW?=
 =?utf-8?B?VktCMm01eXVPdFZKYllVRWoyRXBJZklxakVUREZRVFJqNUVla1JUNnBLdGh1?=
 =?utf-8?B?U1NxUHdpeVZKZUpWcFMwQ21MSU0zMVdralJjM1pVTW1DTkx1dVRiK2xzd1Yw?=
 =?utf-8?B?ZWE1L3ZwTG80b25vTWVYbkhQZGc0OTJrK0h2NGw4ejVFZDVqSzlTVFBqVFk0?=
 =?utf-8?B?TFdZUURTanNiWk40K05vRnE3UWExWFhpYkh2eHZYTzBSY0FGRTBCT0dyYWlP?=
 =?utf-8?B?eEZKOStCWTlOWWRNay9sS2NPNk13bjhnUFBaaUZGVTBXS09SVjhjb0d2aDFh?=
 =?utf-8?B?bzhrbzdjRmZzVWZzNU5JT3NpN080QzV3L3NVVTFtSTVBQ2ZQYklUdExzZ25Y?=
 =?utf-8?B?c0xDN04rOGMxeXBZcnUxbFhCV1pmL2UwNGJkekhzTUppeVZtMC9wdEVZaldM?=
 =?utf-8?B?VWlOZ01mM3gwcmI1RzB3UlhkMmFtTWsyVW1UOWptY2IzWElkMWpNRVltRWhQ?=
 =?utf-8?B?SXR1VStYRnNTOUNkM3BOQkMzUzRKV1Z3T3VYTDFTSmdrZUtkRlI0NUJPMkF4?=
 =?utf-8?B?MnpGME9icHR0cldHV0RsV2YzUExiZzF2TlMrNHlyNnRWcnhxalh0TlJuU2JJ?=
 =?utf-8?B?QjFTSmUwS3JCOThFeER4RGxjTlgzRUE3OHh5TEpVTW1PTVE1SXFhZkoraW8z?=
 =?utf-8?B?LzUwM1plWHdYK0o0U1hZWmxia2YzdWE3QURpNFh4SE5SRjFuV0x4ZmZ4WnNS?=
 =?utf-8?B?MGozSEdJSFg0aWU2dFpCVzJlUkwya0syaDdlNlhpT1FCenZwNDBoY0tnTXZK?=
 =?utf-8?B?TDcvcWkrVC85OW1rbEtvMHNzbXFGcmlwamNMTEV3QW1jZlIvZEcrOVBYd3hm?=
 =?utf-8?B?cG53SjFqblZTTjdKVzhIYnhVNGdpNGJ4WTZJL2FzSi9QNkN5OXVxUnFtY3Q2?=
 =?utf-8?B?d3RQYTF6ZkdqWXFSREFWclQ1eXMvZmk5emQ3VjZETmdoSW1CWHdlbElMSFpR?=
 =?utf-8?B?TXFCVWc4UFdpZ0N4dzBXWG5PZHpGL3NjbXZHcjM3eHV4dDVmZVB5cnR4M2ds?=
 =?utf-8?B?M1d0aW5DTVVsc0FaQ1BvRVFjYVhwM2NHRGxJV0IxQzJQWUNEU1dYdzRRcCtK?=
 =?utf-8?B?Qk8vbDRqejNDUmpaSGM5M3NONzJ1SzJ0S1ptMkw4U2M0a1JZNnQvNXNrenB3?=
 =?utf-8?Q?Qi0CbQb83dDVRBwYoELOBkRqq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600e9fe3-e294-4aa2-81a0-08dca1a0f52b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:59:46.7119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fb3yBas+qlOWjcT+5xwEYvNTkHil4n2XoQZ8JIeBwvXnyZhW/aGoXCnkwGqT2+Xy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907
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



On 6/19/24 09:17, Venkatesh Yadav Abbarapu wrote:
> Adding the basic mini u-boot configuration changes for qspi,
> ospi and emmc.
> 
> Branch:next
> 
> Venkatesh Yadav Abbarapu (4):
>    arm64: versal2: Add support for mini configuration
>    arm64: Add versal2 mini qspi support
>    arm64: Add versal2 mini ospi support
>    arm64: config: Add versal2 mini emmc defconfig
> 
>   arch/arm/dts/amd-versal2-mini.dts       | 11 ++++
>   configs/amd_versal2_mini_defconfig      | 77 +++++++++++++++++++++++
>   configs/amd_versal2_mini_emmc_defconfig | 69 ++++++++++++++++++++
>   configs/amd_versal2_mini_ospi_defconfig | 84 +++++++++++++++++++++++++
>   configs/amd_versal2_mini_qspi_defconfig | 79 +++++++++++++++++++++++
>   include/configs/amd_versal2_mini.h      | 20 ++++++
>   6 files changed, 340 insertions(+)
>   create mode 100644 arch/arm/dts/amd-versal2-mini.dts
>   create mode 100644 configs/amd_versal2_mini_defconfig
>   create mode 100644 configs/amd_versal2_mini_emmc_defconfig
>   create mode 100644 configs/amd_versal2_mini_ospi_defconfig
>   create mode 100644 configs/amd_versal2_mini_qspi_defconfig
>   create mode 100644 include/configs/amd_versal2_mini.h
> 

Applied.
M
