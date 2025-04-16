Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C289C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7981082DB4;
	Wed, 16 Apr 2025 13:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LX/GX6DV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98EC082E03; Wed, 16 Apr 2025 13:35:19 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B13A882DB4
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2OeCBDF6p/9+VDw4x4WsO5vVK9ZrTWjqEN3kBGRM4sBCm5Xtc/xH175KUP2fTIRKjxFJ8mx9l1N6DgyRoiOlSCDmopmnRH7vPbwvroX9X98zj9crtf8IBaTctUorMSmV5gRNa4f53eb6IjsQG+/Io029XHnwxdoRQ6kzCWT9UpN+CiTRZZsebtVDlDoNQfAQZ3v/c1FcnK1TSN9znWks1bYS9TiE55AlPgP7Av/WouUv563hj3rVfNzx0q4qOP8Z5gU+LyF9DtZoabxbQrFEK4wDzkTrpxf/Khur5KiHOM0DlkDPRfYDWAWPt1MkJ4HT94nPLs8RSaGhEZFAC9gaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FT93bLrDf1I6JasJQ6Kt9FidSsQVFzw2Sg5kgdbWYJo=;
 b=tqYPUXhB5iNyux8qXnVXq+22IPqBuBFIWisJ4fGQnR4paQ8I11i6huUZW7wVr448nNKqS0rtjTL3qPCTH4d5ih8tD9FG83rI0Dqk48XQacq6mcU+A63klG6XzCQ1d4vEG3dpMxWRTltCTHJgbOTdV9d5GGVpCpksyvFL/9InpKZZXRQoAD1/nuLgAIEwMfbzozMe1eBidCqOtU/TxE1nebt1LSXIcSsR2jg+e9pAN4WEcLB+5eJ5ooqbWscb9FbJH8GULOAXzDZjUd+EvxcTgmTC3Mp2Xv4WHtGLRFlIUIKRAAJJB4lrzsKAKR4Ul9FYdEtNZiCIVhG2KGavI4FEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT93bLrDf1I6JasJQ6Kt9FidSsQVFzw2Sg5kgdbWYJo=;
 b=LX/GX6DVNARfpQGBoWG0iJpKzBdjMceYwhTmANS6e822RaI5GxyKfqz0XYbagmDTVmxUqXj8rRjP0S0Cilp3/GXHyu9WYyfUHPWYMsQcDHncQbmTOdKEvTAO9hA9t6j9zkuMR75kGRzIClnqhdCXEOZ8aWiLOmCbWyV7pzMJW9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Wed, 16 Apr
 2025 11:35:13 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 11:35:13 +0000
Message-ID: <5ba1cd6d-4a27-4900-a042-c9eafc793a05@amd.com>
Date: Wed, 16 Apr 2025 13:35:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd: versal2: Enable NVMEM framework
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <b6714165aee393528812ddbfc3cd18a3bbcf202e.1744270647.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <b6714165aee393528812ddbfc3cd18a3bbcf202e.1744270647.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::12) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: a85aec30-2d75-4642-434a-08dd7cdac0cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXdOczBKQzBYbjVQR0I0LytZNmphUTFqU0hBSlM1dG5qY3luMktjK0VVUFpF?=
 =?utf-8?B?eGp1VHA2RE1pd1ljM1pzY2VKbThxU3E4VnllbGRxeVI5TW9FOUROTlFqT3JY?=
 =?utf-8?B?S2RkQ1cxZlZHaXkxR21BRmlRaHRwK3NlM3hobU1rcFNzcWpUUEVNcXpSNldG?=
 =?utf-8?B?d0o2Y3o2NW4vT0s2R3VkNVlGbWVTSTdDUDJiNk42UHd2eDRmVmNHSkVwSGhm?=
 =?utf-8?B?QVROZStBQU1vL0o5M2UwT2ZxZDd4U21mM25aYnhsekREV212VERySXZFUDhY?=
 =?utf-8?B?eXc0K2E5d0ROQlUrTkFFbDV4YWJKR2xRcWF1dUJ2N1QrUnYvbCtvS2grbFRi?=
 =?utf-8?B?NzY5R0J5YU9NWlEvYUZNODJuMHU0WUlTS2JBQ1NCVmp0ZE4vWWlsT2tIL1Bu?=
 =?utf-8?B?QXZZWDRVL2FSNUtBcFgvd2cyNnZLOTZ4R3J5eTlKWllSVk1HVWJ5VE1mVzl6?=
 =?utf-8?B?QmRSWWMwYXJGVGdJWkIveFkzQ3kzNGdGVjhPaXF3VU5ORkZRcUg5aHRKWmlP?=
 =?utf-8?B?YS95MWwwaVl3S1RzWmxKTjMzTUtvaFd3SW12aytHSVNrYjhiUG5LK0ZXWThi?=
 =?utf-8?B?TmtOcFZ1aHdmUjZsTUMvR1VsL3R2bStLUWhZRGdVeGdYcXZ6YXgvRDFNMVB2?=
 =?utf-8?B?c1lmbGlIYnc1SVBMWmZuWUZteXVLb0VlV0tWM1pYSWhCU3NMSzM1RjBnVmNu?=
 =?utf-8?B?UTNHazJXL0YyeVAvZXU2ajBPY2ZoUHBNeHZHY1BQWWY2L1cwdHdiUU9ta0xj?=
 =?utf-8?B?YjlnVk5rdnZiNjdNem04cytxa1hldGJhLzBTMUcydDFSWklaUHhJRXBrWnFp?=
 =?utf-8?B?OGFyL2ttRDNFY0orTUxNQUNGNk9meTllbldDbHcvOWFibDY2ZEFRdWNUZUVz?=
 =?utf-8?B?d0VRVkFtNy9DMnY2dmVReXR4d0Mrc1dxaDVLQnRLd2txc3kzejBtS0pBQzVI?=
 =?utf-8?B?cUI1T3U0V2tWNXBaZEpIZnpVMmpVem9aRGIzekoyZG42anhlNEpSNkFiZjJP?=
 =?utf-8?B?SHFEdlRDM1lVVm1zZStVZ0VUMHkyTkozN09RR0dLOXVObUxpUldlcUM5dSs1?=
 =?utf-8?B?YWtra0hSVVYxeWtLeG5WNVlRZTVvMm5PMTZmK2pVQ0dHNlU2U0RzQ253TFpz?=
 =?utf-8?B?d2R1ekNGNERRS3BDbTM3dDdhZlhxVXc0U3F3ZzdqZ1dYQ3AzV3cySDNOdkpy?=
 =?utf-8?B?SkhQWFpIMzNvV2JEejNPa0lWdGpnUU1hNEhwUGxnQmFlTG5lL2lYNmtGQkVq?=
 =?utf-8?B?ZG1XSEIydWltU3FNMU53OW02R0VMam9uWVBwRkh1djFnc2xuenBvSzdhRjJi?=
 =?utf-8?B?K05oRy9WSWVJSFFadFBMME5XNkdxVzNxQTNmLzNrMFJ2bTFaSUZtQnd6NCt5?=
 =?utf-8?B?UVlhc1RrRlFmQnl2UE4rSjJCTzVUQzF4VUErTEM3Q1QzS1g5WEhnOVJ5WDd1?=
 =?utf-8?B?YWovSjBreFF1WFgzNkJsU29GYTVnWWFYYlpPUkpXMERiUEVTL2dyRjJHb3hl?=
 =?utf-8?B?bkx0RWNTTHNvcG1GeVN4MDAxSmdNM1pUSStFY3dJeVRFTW1ua0tJcllQeTQ0?=
 =?utf-8?B?SkFBRExWRy9HRXdXRFJRYU9ZcXY1UWpyYTB4d0FYclJLSWJGVCtyb1Q0SFYv?=
 =?utf-8?B?Z1MvUnFzU255aDFNWFFmZVU4akt1OVNPREw1TU9JeUI0ZUJ5OEF4NFd5V0tN?=
 =?utf-8?B?VERTcmg5Ynd6S0lqNzBpQmJiNndNQ1ZkL1YyWmp0eHFWbmRMdjdQTEk4eFFP?=
 =?utf-8?B?cTRhMDY2SVpsTTVneitianA3NGMweUFEWTIxSlAyTW0yWW4yNmZJcVZreU5C?=
 =?utf-8?B?cE5pZG9keTA4WFF5clBBVlZlTVpzV0kyVnh0VFMySmJIVUdtRzNWVVVlRUJY?=
 =?utf-8?B?UkE0cVpVaklxbXVPcVlNMDc3ZE90UFJMNW9DRy93V1RYOXlBOThrRlk0d0lu?=
 =?utf-8?Q?mFbVphva+yo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUJobFJJYkdDL3d1NjY2eWo3TzdyaG9qRUFRN2NSOWtqaUM5WGgvcUtHaVh4?=
 =?utf-8?B?Z09MdEwrVkd4QVlRcS9tSWQ0bmFTS0ZDNDFFam9qTW4xTTlHbW5WZklnczlE?=
 =?utf-8?B?OVRnQ1cyVHZJbU1XTjNRZVBHSTNDZFZ0TklNWmxDQllqcU5EQkZDUmZIRm5S?=
 =?utf-8?B?N2VndzJpcDQwZHRZMzUrTGg1TGJWMS9CbEpCdjl5QmwvOWpQUm4wWm1VdGFz?=
 =?utf-8?B?RnpnVVNxdlg1aHM3QTdpZHB6a21GTGZ1bHdLdXJ6UzNhT1hIWXU2Q0pDVjZx?=
 =?utf-8?B?V3ZrQ0Y3bWRmNzlieGp5QzNrNXJTajVhRElOWWtHb29mdFF4TklhV2pKS3ZJ?=
 =?utf-8?B?SGZoMVprSzcvNURNUEd0a3AzQnlPV3VZRTlMMDhJQURtUHAvaDhvUGkrMldC?=
 =?utf-8?B?U3VFOEUzeGJhVXpkRXZZTHdXRGJWSXJWRlFrMllHUzFFbVlFeC9EMktkNVIv?=
 =?utf-8?B?ZWFPQVJMVHJvS1pPMFU1WFhtelNLaFNNaGdma1NNeXIrVjRCOFgva21FWHJZ?=
 =?utf-8?B?ck1TUGJGK0Jnbm5NRCtoMmVpNjMvUVVHdFBvcFNsSWtTcEpXelV4bG5lSWJi?=
 =?utf-8?B?UUdTTEdlMWgvcWhxVlJPUDI4WTJBdTBxTG9oM0FyVUU5ZkxlSU5OUGVvbklp?=
 =?utf-8?B?VmZZQkdYdEwxRU5DbVlmbnNnRU5wUlk0MTdPZFJheDkzT2RkMXlCRit4YVFm?=
 =?utf-8?B?MVo1b0NPVVhkamp4VXU0K1NGL2VtUkxvank3cmVjQXFDOWlCWmpBOEVsaHJ0?=
 =?utf-8?B?Tjh6WTBpQUhYUzd4Q1p2MUVGTnBZVEdlRUQweXIzVmlVTkZDcklhT1FQMUwx?=
 =?utf-8?B?UVJ4bGg1VVFqTU9FemFjSU9hV0lGdnRBSjJad1M3WHBqdHRnb09kQUk1Q05x?=
 =?utf-8?B?QlFyNWFWamVPeGVsc1hQV0tWWHVFbVNvblM0THVYUi96ZE5FQ1VxN0FWdDMw?=
 =?utf-8?B?Z2drRGlQcGlNUzZ1OTRYVnROQndESVl4UUZ5SWh2Vmg5MVZUcm1RVGhMQkx0?=
 =?utf-8?B?UDRwaHM0OS9XRkpVSDlXRDNJTTVsdzNSdW4reEpWQVJxR0Yxai9DTFFJbVJ6?=
 =?utf-8?B?K3FrZFF5YTNKR3FCbTBPZWl0b0RMOWQwOUllTmhiUktyOEdJaWhPUXFEbWRP?=
 =?utf-8?B?NFVOaTNWVzVMYWhpVjVhSk9tcncwRGcrR05oVStMUkVuSmdWWW5jT013U1Na?=
 =?utf-8?B?d1ZDQUJWMnJ0V3FRNk94TVM2SXd6KzlBKzNEL280SGllLy95SG9IUjhNOGNE?=
 =?utf-8?B?aG5zb1NES2k5QmlyMk5NbmltWThLQXFLcXpSODZOTUtrVnk5SkJDclNCSXNs?=
 =?utf-8?B?cnNxQTd5VWhiSTYwT2VnTXJnUUpDYWVpeWNUeVlKaFNnQ0hWck5oS3piZVN4?=
 =?utf-8?B?elM0UWVLbHlLbTRmOEE4VXRZdythcEZmT3dDcGEvejdTR2N1Z0owUFAwakMz?=
 =?utf-8?B?RnE0SVlreUhqOVNFOEhIdDEySi9GcGhVQkNMa3NNMkErZSsxbFh4UzBrRlBG?=
 =?utf-8?B?UytHUjY2QzF6STh6ZElQTWZnS0l2SENTU1dQM0UvcEhhWmtYdlpYWjhSMWNQ?=
 =?utf-8?B?NGpUR2J3Y3BxNXVqVVRLTFpwdUdIVU9FZFJyaDNmZEVUbmhvWlRJeE9kSTls?=
 =?utf-8?B?aHNzNE5MditjNmFkcWpnN2tHMUgxMlcwRXJTWHUzUmVSenc3ZWNQZE80Nmli?=
 =?utf-8?B?dUk0QWNxdTRhS2JqaVIvWWQ1bm85RUFSM0VreWI2OFA5bnVPK0gyZG1OZzIz?=
 =?utf-8?B?VVV5R1dXWUNHTFJ5SHNzc01Hc2ZiUGhXMm9wZ0FpQlUvYmppTzlLYkE4NC95?=
 =?utf-8?B?VU44MERaSE5ydlZaS3FxaU5nTVlIYjUvMjBJQlBFWUJNTkhDN2s0OUxCd2VM?=
 =?utf-8?B?c1pzYXdyMVBqQVZvNHBuLzBkTjBWUkNCL0JyWWFUaFNJOHlQcWxXdHNJOXhR?=
 =?utf-8?B?cU9VOXBkOEZQaVU3UWo0N092dUlMbEFSenhITGtYUE5GQWRBbzB4S1BVTlkw?=
 =?utf-8?B?VFdwc0QzZ1FPeWpQTzZPNytwQTVRRFBNUFQ4UjU3U21zV1ZSdWNlc3VwcWRz?=
 =?utf-8?B?UnJZekpIRVZIVWpDQVdDMGFLOWRrTWZYWlAwNjdxOVZZRTdzR0lVcjZvVlpr?=
 =?utf-8?Q?7yZFnoBkWUhkW9aekJ8oPPfcr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85aec30-2d75-4642-434a-08dd7cdac0cc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:35:13.8045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKdlc3ouC1gp5//C+/ekWVazbv1EeK+7f4uQtRtrKcJI3jgDKzvfxfKmQvqDzPoR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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



On 4/10/25 09:37, Michal Simek wrote:
> Enable NVMEM framework to be able to for example read MAC address from
> eeprom. For more information please look at commit 5db5b7e2a336 ("xilinx:
> Enable NVMEM framework for all platforms").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/amd_versal2_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index d722f3c811b4..5ae558e14198 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -82,6 +82,7 @@ CONFIG_I2C_MUX_PCA954x=y
>   CONFIG_DM_MAILBOX=y
>   CONFIG_ZYNQMP_IPI=y
>   CONFIG_MISC=y
> +CONFIG_NVMEM=y
>   CONFIG_I2C_EEPROM=y
>   CONFIG_SUPPORT_EMMC_BOOT=y
>   CONFIG_MMC_IO_VOLTAGE=y

Applied.
M
