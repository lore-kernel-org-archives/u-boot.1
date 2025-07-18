Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6AAC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 08:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D0FE83559;
	Fri, 18 Jul 2025 10:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tum6GuKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD8C783564; Fri, 18 Jul 2025 10:02:55 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D9198353F
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 10:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKwgtJ9mB3fjC4iJdUQrGkSvWSwV45joLEiPkKCJcScOT5+csl/C6yWAXBWEWGFv6/odPGeIuJLhqDdFTKPXvEu48Pt0DLdkDamxf4mVYtXmV/1CYqqi5bz2kG2y9dkBuna/np+GE/g04wH0lWDHneqCMGa9umB8BbCvfwyVnzxPYpzzEA1d4Ep6SKSNjoVfpX/LrE8vPiGnvCnrUjDztuxwNZDrB36fjAA1ECS4FDELO6ENsvSf3IFyMVf+ReI/fNEhdp9qUp+bYOhOaEorwiB+mEikZ2UCSSrXkxSzklZ9lj7e5fnAqq+s0KGdWHNpzPahCuODa/ors0Z/AXHBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ttrga7/yc1FAmVbcyXR38QettlIGbMxOp7ondCU5sI=;
 b=LNiPY2mNAlZEM4k2ZnRcJlO+vbyWtKONl5y2yD13+zz1eDZg1GIpEPieflfBFFyfZgk62GXkyqheGGBo8TofwzYDvwoM7EJEgPidQDAI7bREzQd1805qhYeXCf5eyjHyHGFaMnPBJmC/1//MRNyaaII6tZr9gDN9dUfVrpfANCG9BhUL1eftkpoXpHjTUTZb+d9Y7l+dYSdHDIGZ3J7spfYsGnWYSLng+4YeC5yVVPA6aUbwDDgL+lmLEOy8MERQTs2tqkvoVsP40SsGqdp4rZv/aRnzjZME66faFdx/iPDRMsrMgpviqjMD8yYoZViQgibudQU19HcDS5DJFiEyzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ttrga7/yc1FAmVbcyXR38QettlIGbMxOp7ondCU5sI=;
 b=tum6GuKWhSKwI/5goJImDRwSh4kKjxIiQVm27RxoTEl8/olSwuqiUHwtHLWKCDchMqLjKVjEZeLBepiNMwhyb1LfSRToe/26Z83AmmXfo27fvxJiqsue5rN+1yCaPGfdSQ4g4qWx6TIdz3vaDZ9ZiJBRAfv1cKssKX5yUjtTbGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 08:02:49 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 08:02:49 +0000
Message-ID: <9fdfbdcc-865e-4ed5-bf40-9d25551b3dab@amd.com>
Date: Fri, 18 Jul 2025 10:02:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: zynq: Fix the documentation warning in
 zynq_gpio_get_bank_pin
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20250717044632.1353588-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250717044632.1353588-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0150.eurprd07.prod.outlook.com
 (2603:10a6:802:16::37) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2608bc-d6b1-440c-9bc3-08ddc5d17cf9
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3l4Mjg4WmNTTzN5cFBWcGx4enVzSjQ5T01UQ1JTREI1eGdOVDlLTVVXTFJo?=
 =?utf-8?B?K1FIZVlLNDFPOVkyNVJRcFpLUG9XU3lZaVQxNSt3TDcwaExYYjZHci9MVE5k?=
 =?utf-8?B?ZHlvV0Z0eVhFOU1ROE1OR043ZTN2Wm9RMjZybjlLSFRxbHJYRTZORW8xbGdh?=
 =?utf-8?B?Z2k3Y1g5QzljZXdHbEpDVjk3dGFYaVUwRTRwLzRRcWFEWTZHRUVlMXhJeU5x?=
 =?utf-8?B?dGEwWk1BdHcwR0grUGl5UFUzYmpROWE1V2VuTkZQWnBqT3B4MzFZeU1jTHlr?=
 =?utf-8?B?YVloL3RXZWtZeXV1OTBIR2VhZ2luSTBEbjRyNnhtZUlYUkx6R1dDOGZTeFg1?=
 =?utf-8?B?OXkvMjJuL0duaXBCUnEvOWpHSks0ZzRkM2d5a3lncXdTd0tIVDYzT2RhM3lL?=
 =?utf-8?B?MjFvZm9ETG5rd29NcVVtUDdXcjhaQWJLdjhPNU1yd05rRG1EYmdPbkFvbElX?=
 =?utf-8?B?N1dOZWdpcXFzNWtENGo3OTlORzZ5dEVDekxia0RHWm9MRi9LRFBCOWU2Rkxq?=
 =?utf-8?B?NkZTcEZwblc2SUxSVHJ4NjRyNWZhNHBzR2dvcGxYMm5jMlYrdTlzN0dLblJD?=
 =?utf-8?B?SE5CV28rZ3lCanV3OGhTUy85bldWNTFWak9udHAvSjY0NjdNblJuR1NqMHY1?=
 =?utf-8?B?QkNTN1VkY0FZWklhNTBPaFRNODlUeVhVU3VpTW0xekpzR003dmNmVWpIQkVs?=
 =?utf-8?B?a1lIMjFZelQwNlRkWVBKOExvL1dGSW5vTm52aEFxK2FmL3U3b1FCN3VtYVNF?=
 =?utf-8?B?Vm85aDkxV3d2dkRvamZwUWdLOXZUcUpTQlVEU0lsMFlPQVNGNTVQMm9TeGk2?=
 =?utf-8?B?R0pjblhDcnhyL0p2dDN4N29qamhPNFN0ZEVYUDZJK0dKNEFvU3A5OWpGMTBK?=
 =?utf-8?B?QXpma0dJR1FxSHd1cWptbUxTem4vNlJ5cmVIUVJ1V1JDL3cvOHhBZzA2Kzky?=
 =?utf-8?B?WnZDMmFkMVo2U3gxZHVocVM2QXExa3RSekpDMjd6eW9CaVd1SW0wWi9yWkl1?=
 =?utf-8?B?NXh3VlhENE9adXhZY2E3RWFRb3J1dlAyeGVTaUxGZ3pKay8wZUZjay9vU0xR?=
 =?utf-8?B?ZFlVWEkrMDM2OFd4b0VxclpKbmRoclQ4K1VtazhmRWpwWEVqZzRmdXEwTkxP?=
 =?utf-8?B?U0FIZEx1T2JVVVBYeUE3SHhuekpDSEFzcFRwVkEyTmh3bmgzSWtjV25YOW96?=
 =?utf-8?B?UGFhUW5uTE9mK0tSMHB1MkNJcVdHaXR4SzVuQnUzeTI3QS9taTNvSUR2RjM1?=
 =?utf-8?B?UmV1L090S3I5UzVTeWxOQVZSVm93TEdtZmsydVNrSmZKSnNTc0FIY3NUMG4y?=
 =?utf-8?B?enVScnhMUE0rc0RGZ204ZWxYTnpUQ0h2dXRQZzJxMFY1ZVhkeTFjWXlEcVNT?=
 =?utf-8?B?YzgwcC9yZTQybndhMmVFVXUyYi94ZWk3am1veElsOHU2ZnRrTDIxeEZJUnln?=
 =?utf-8?B?Z0FGeVVHOGRERlduV2k2c3RESnVVd0RDK3IrWTduUG5zM2JWczRROTJBak1w?=
 =?utf-8?B?TFcxN0p1elRadjdrcHI4QTJOb2llV1lpL1FGeFo5K3NYWG1Oc2ljc25OTC9K?=
 =?utf-8?B?cENCZ25acHhNcTdrclFFNmhkSGxGTVFFL3FDaTQ3Z0dPUE5GVWlaWFAyZjNi?=
 =?utf-8?B?M1JEY2ZPT203RUprTXBLUlpqeVRMVkNWaWNSSnI1TmFEVHNoOXBrdndQRGdP?=
 =?utf-8?B?WjU1N29GUGpDOVd1MUd4ZWQ0Q1pKVXBSdU05Ti9wSW1MVUdZTk1iMkJsV3Vr?=
 =?utf-8?B?UWJrYXJ2VXIwdGkrSnV1MnBqMXlzU1IybC8ycWpzMWtmUXZ5eElmUExGckxO?=
 =?utf-8?B?cVNFT3hna3UyNjhUT2JQVnJFbGJqRE5XeFZDZzhha0w2cDMxQTdjaTZaaUly?=
 =?utf-8?B?QjhzYzVndWU2VXBJS2duRkZId3M5dmlHTi9oQzY1OHV3QVRWZmM4cWFGdEM3?=
 =?utf-8?Q?2eLu0lALTfE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmJHNkxLL3JJcjhvczhBYndJeHdTbUdVU2FQM0RXblU3WFJPb2dTVGlxd2NT?=
 =?utf-8?B?RnVwV21admw2OVZVUEtsQWk2RnFycndOc1pYVmNxODR4b3laSWN3Qm5WaG0r?=
 =?utf-8?B?S3htamVzK0hIcGZnRTdhSkZaMjYvU3M2YUFtZkk0SFhFaWpYdW1zcFVXM2J5?=
 =?utf-8?B?OEY4ZEdLVDVac3ljdFVpNk9YRFJ3SlF2bDN2Vll4bjNRT2J4enNLZitlb3BL?=
 =?utf-8?B?dnBnK2F3M0pYRWlFSzE5QXZ0ZUU4R0FzTm1Dd2tLYUlxS0MwQnBzQ3VhSTFp?=
 =?utf-8?B?bVNvdU5vTnZ1dHBlWEdhdDNZNjBhU1FQN2tmREtyNFhDL2FLK2VFT1BNS3Ry?=
 =?utf-8?B?SC83V3JjRDZIWTFmYXNQODhYazltb1FlMi9zelc1S2FuK0hHaVlJS0U4Tmty?=
 =?utf-8?B?S1ZselpMdS9Ed2xFSnRzeThWeFBhUnJEekJsajVjWW91dHhsZ2dYbVhmVDRh?=
 =?utf-8?B?emk0WW94RHE2cER1NzlJMDViVThlQkZDbjNGaURLeUtuRFIrWERZUDdGSXRC?=
 =?utf-8?B?V29UZDh6WjFtMFREdGlCNEFGMWtBN1Jqd25GYXU0c1pjTkhya1dyaWp6dmJj?=
 =?utf-8?B?aW1pWWIxNVFnYmFvQ0x5OFdDZ2prR3NSZXJPUzRMQ1hFVXBtK0lsQlhNQmZa?=
 =?utf-8?B?bmdhcldQUUMzV3dhNVJBenRzR1FBRXQyeWxMZWhEUTR1NHlFV0FESTQ5eFIx?=
 =?utf-8?B?bTBkV3lGVkFQRW42THl2QWNBUWpTa0VDUHpNbjQ5blFaUDVIRzFLRzUxMTUz?=
 =?utf-8?B?THFmZktCU1NHL0lCb00zdXNRR1VlWUlmbTNNV0JKZERqNEk5TDNaZDQvMW9r?=
 =?utf-8?B?L2dYakZYTTNIK24ycTRxckV0d1FMR0pjcEJtRGR6eTE1K3BqNldiWm02bGpR?=
 =?utf-8?B?Y3MyR2hVZVhySEdhY3QraXBscDV6MzhJbXY3OXB5VXYwOVBnbjFxaWh6T3pU?=
 =?utf-8?B?VDlkSTV0WXJPZWlDYS9Qc1BkU0M5b3QzRTI1cUt1Q2wwWTQwcm5EbTN1M3Bn?=
 =?utf-8?B?bERUQ05peFdLUWR3VlFObTJXTjdGcGRqbUdLbVhnRE9IUVlROU5TUTc2cCs3?=
 =?utf-8?B?alNsWldaNmFoTjlPOExWTzZtcllBVVo4MDcza3ltTzhMUE5nMmdnbVhZTEly?=
 =?utf-8?B?Yit0dFYrdkwwV1YzQTEyOGJuT0d5MVNkeG9JYkY5TDI3eVJGSWJqRVN1U21Z?=
 =?utf-8?B?MHAxOXFaNGwvT3hKY2RjOHN1b3doVDlXWEJoSDAzZkhWRlNyRVQyWDNmQ2Fo?=
 =?utf-8?B?S1BtVk5YbldnSzdTZDl3SnhLTUpJd1VHc0MrMkFMWk9ESmhhSkhsSkxpd2Jy?=
 =?utf-8?B?ZWdmazhNdHFVZVFYQUhtWHNRY2IwVkpoNzZrZGt5dTlzY2lUaFhYUVd4MXR0?=
 =?utf-8?B?SkVvamlzKzV3a3lSakduWWF4YS81OHdERXk0YUpFSG5qMFVKM2IyQzhSdjBR?=
 =?utf-8?B?ekhmb3k5b2cxeFNIdWZYZGx5V2pSeTZQUzBtQzNRekxUVXFCV1U5ampRYlAz?=
 =?utf-8?B?dkZrbVNLK3NaRXBmdFJhZ0FqQ0xMYU04RmdXUmRSbmY2cVR4Y1NYSUFNYzZr?=
 =?utf-8?B?Wnk3WUJVbG5JUUIvdnJwSytKSXVDSk5QUTFBbWEvYXJuL3lPMlBSeTJNRGxG?=
 =?utf-8?B?S3lBQTZnVW5SODVFZEpLRS9TL0VtakwwOGIrdFJjTk9QNmlXMEcxT0lCK3Zm?=
 =?utf-8?B?OGp3QTNoVlEzY2JNc2JhdytQZ2hGM3pNTEt3c2d5SVJIZlIxaHRlQ1BVS3Nn?=
 =?utf-8?B?enR2YlBHYSsweEVMMk1hT1RtbGxKTVcvSnhITFpKbUthOHNqdXJ0blBBY3lX?=
 =?utf-8?B?eG0wVmNpcHdlSHV3QTByNjJsYjdJOUN4TStJUy90STRYMTQyZ3UyZ013d1hw?=
 =?utf-8?B?TWNxcW1XcUFJUGt4dm5WdVh4TUlQR0lGekV0YXBwWktQY0Y4WlZzSndwdHR1?=
 =?utf-8?B?c1JrOXEwdFZ5M0QxR1RoZ28wQU11WWtSbnh5TUFNMi9LRi9UcEJSWmpCWTVZ?=
 =?utf-8?B?d3ppdzZjSFB1Nll6K3dRSkcrYXhvcno1SkRsdGQ4YlFCdTYrN3huSnk1YjIy?=
 =?utf-8?B?V21VQzV5ZFZpMHo0bFZCV2RjdlBVUUREUkZiNVozMlRVbzNYUFVYUEZpQ1JF?=
 =?utf-8?Q?/ZTkLZ8l38Lw/aoZ7J5eVaY5N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2608bc-d6b1-440c-9bc3-08ddc5d17cf9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 08:02:49.4528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgzC3H9/v0aBnnODSh88Dzhhu9Z7jUXpoQnR+e3PvB4tDJWFDWPhPFLNHs39WkwZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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



On 7/17/25 06:46, Venkatesh Yadav Abbarapu wrote:
> The 'dev' parameter in the zynq_gpio_get_bank_pin function was not
> described in its kernel-doc comment block, leading to a Sparse warning.
> 
> drivers/gpio/zynq_gpio.c:194: warning: Function parameter or member 'dev'
> not described in 'zynq_gpio_get_bank_pin'
> 
> Add a description for the 'dev' parameter to satisfy the documentation
> requirements and improve code clarity for this function.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/gpio/zynq_gpio.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/zynq_gpio.c b/drivers/gpio/zynq_gpio.c
> index 7db58c70663..ef4f33f84e9 100644
> --- a/drivers/gpio/zynq_gpio.c
> +++ b/drivers/gpio/zynq_gpio.c
> @@ -184,6 +184,7 @@ static const struct zynq_platform_data zynq_gpio_def = {
>    *		pin
>    * @bank_pin_num: an output parameter used to return pin number within a bank
>    *		  for the given gpio pin
> + * @dev:	Pointer to our device structure.
>    *
>    * Returns the bank number and pin offset within the bank.
>    */

Applied.
M
