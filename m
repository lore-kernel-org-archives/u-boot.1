Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799DDC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 14:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1626C80137;
	Wed, 29 Jan 2025 15:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="T3dl4xGh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64FA280711; Wed, 29 Jan 2025 15:31:05 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A759800CF
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 15:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtG6He9GQIbMYGBNGRvGZG/pfDzjaSVYBhcDo4zinlIkeKXEWkykZp9ng/I4NniP3Z8l9wKp4yfDwUr2Vn4DVyEaUhLBsh0nd+osrLKU7YXeDvbUSqpvyA/7U2zkpR9I0ecJILbyYHIDZloPYSA8DA3TdDPHsZeIrpEYC6L0fORYSHVYI4UVWZZHJ/7WKwUZNSUmhKc5XKRPjXeyKlN7emOq+vGy5VBGSLvgzdvB4zi1gS9y/F9+xcMQr7Cp4lehtpP09dcXd8xKN5/fILo6XtyZhcsx56Rd7A7m0QK8YWMAfsBGLrvZYrTCDXBhiBXfVHCsramh236TzG1P32mVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlUtlQRVgAV4mFxuReYCKKiYjeeVMVm9KKMzAKeNgzM=;
 b=Eb+xdORbTovDkwSzRFASFAIAQsfnOzs/FsKRhxn33dcLAq/9zF/k9hkXyXQ+Te56KZ1LfTZ2kGvaBJTAAOB2GbrvisStxvEoHU6sKzO1LSxq+EWE2n2MV/cR81uaq2gzuT81cxyMA1nKYPi0WqhFlam1DiX3Z7wpSK3zQzQ/Sb/uzycdCUd92JlHiohPUdMmHUFPr5gejWJqgI8ERz576NGD5xgmn/BsABU6ltbH9tpcnhfdm5UHwtmTU3c8pfjoBU8u3VZ51GeVwx+Cz7Kz5mNMhHCdTk85Xhy0/vA0/p9ouQlrglLizj8/GTPTWGCRq3x47vbM+5IE9RKmwTy8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlUtlQRVgAV4mFxuReYCKKiYjeeVMVm9KKMzAKeNgzM=;
 b=T3dl4xGhD2qW5Stc0ap6Ng2rnnF/UHmTmZiMOvV4sZF40KwcEy7S2shXPDy2SHUdnUggIzpgo/3OdPIjPm29nHJjQJI1ZwSzd06T8YHN0ASpBteIW7QV1NH4ZI8TvQ8r+rJF9UY5WxFu2RuaXffHW4baSTxuTywohR1tWoUxW+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8188.eurprd04.prod.outlook.com (2603:10a6:10:25e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 14:31:00 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 14:31:00 +0000
Message-ID: <748dc6d5-fc51-49df-a0ed-ee2a80f47ab6@cherry.de>
Date: Wed, 29 Jan 2025 15:30:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] ARM: renesas: Rename board/renesas/rcar-common to
 board/renesas/common
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0095.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::48) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdf85f7-3a11-4e7a-bb2f-08dd40718d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NU5pVmp4a3BZVTUxQi9ibXpCcHVtMFVYNVVHOXYySk0zcTZMQ1VuSEx1UFFL?=
 =?utf-8?B?L0hTU0gzcDZ3YjRWNTZVUUtPM1VmcU1zOXk3YTUzVE5zT0pnMTZqbFpXbmVT?=
 =?utf-8?B?dTMzTUJsK2lvL2x3NGNJNXVJQ3dtY3ZwV1A3bGdsVWhpTmczVXJVNENGTFEv?=
 =?utf-8?B?ZWhBTGJHWWFpdU9oOFdKVGpzZnlVcmlwMlRBNEZuOW9KZXFhMlhUaEUwc0xs?=
 =?utf-8?B?enQ3dzh6NjhnTnd2L01zaW9FQ3dyejVkZ1M4azBMTjBaS3ZNOXpDeTdteExI?=
 =?utf-8?B?WS9uKzhSc0JIZGlVYm11R3FaSFRyTzFmUklsc0l1ZmdlMkRvQU43WHlydmlx?=
 =?utf-8?B?aEtoSFZ0dGZBd3dOTGM4YklJSy90Qi9IaFltZFFySU40RGQzSk95QWpGZ3VK?=
 =?utf-8?B?R3l5ajIwYzJkSjVrTkZGZUtUQ3FqNGJLMlhkYWNWcTJWNkVHbjZrQmYyZy9K?=
 =?utf-8?B?Y0ZjOVErb2VFKzNkTTFFSUN1VVdkQlBKUTRWYUNPajFFZ0JIWmxqblh6cHpp?=
 =?utf-8?B?d2ZDbnJ2anFpaUs5aE9id1VXUHdWK0NiemppdDY5YXQxUVZoQWRFSUtzdWdR?=
 =?utf-8?B?OHZkMjAvK1V4Ujk3Yk43WWQzYzhYQWdlRGVFd3BOMVNvREp1bVlCWVcxYkxj?=
 =?utf-8?B?ZitHQnM5KzhTSzFtRS9RMXNrQkljMnBvWWl2b3VrRi9UU1B6alU2NDlBY3NT?=
 =?utf-8?B?UGtYY29LRGRUd1lUTmRnU2UydHhEYTQ2ZVFDdmJnaVZhQ3owN2x2S0w1d2Y5?=
 =?utf-8?B?OVNLUURVa3hiN1dTVXNsb3J3MnJWQVFMRm91em1sLzN0SHlwNEZhcEd3aHlG?=
 =?utf-8?B?M0F5VGQ1eFhtVXduWENFVFgzRVhEUk9ZTGRRNWUwd2h4RjFhRzJNSnFpZHVM?=
 =?utf-8?B?a0hITjk0UWZWZDRXa0JoeHZvUjRndE5vNTFPaUdPelNxTFhsNCsxbEhzQTlJ?=
 =?utf-8?B?ZzFERGlPSm5DMUJpV20zOVE4TEhOUzRuUWhsUHFmU0lyaEpsUDg5VFhic2Fl?=
 =?utf-8?B?bVNqcERjWkpTZFZzU2d1VjlnbmlzUWZVYXFoWDhyVlNuZGczc1VkVXYvWHpF?=
 =?utf-8?B?REk5QVkxQ1hFL2RLOTA3bGlYVG9nTEUvVXVLR08wZDFCanF2YVNsWXFNV0Z6?=
 =?utf-8?B?NGlXZzE0Qk9ydUtFOTVjRitReCtPZnVTall5UFp1L05TK0tZUnl5U1VrWkh6?=
 =?utf-8?B?SW4xRmJCZklEcTRVQzlBQXk0cStYdXl1TGYxdXNIUWUzVEFrNTdzd1FiVjdn?=
 =?utf-8?B?aTFPM1FNVGloK1pUNm1vOWJRc2FMQzhDempueENFVU9QK1M2WGMyM3ZyQ0Jy?=
 =?utf-8?B?cURzRm5KSkU3cW0yY3RNV3lmZGdTWlZkWXN0ajlKOVZJb1pUZGtnZ1k2WnZr?=
 =?utf-8?B?ODl5YkhPNUJENXQzeXNqK3phOFk0ZE5DQldWalpYMjBsWXJPV21OMjBOaFNS?=
 =?utf-8?B?ekxNaFdnTFpZdldhSVZlMENlT05YcldiWVNkcS9hdGMzbFdWclRjRDFLMkhQ?=
 =?utf-8?B?MTMrcjRqcFUvVHFWMG42NzRKQldidWhFOFpKVVh5WGJIL3kvc0JrL2RzQXov?=
 =?utf-8?B?Yk12S1VuTUVUeSsrMytlWVJUbk1ZL2tzY1dRYnVWejQ3VENGQlRGVlg0d25i?=
 =?utf-8?B?WWoxaVVRNXRpY3VaSm9sS2lZOElsSEdSbm1oQWJva3U3and4bjBTODNKM1VR?=
 =?utf-8?B?T3M3WjV2RDQ3bkJvdGxpZ2ZtS3F3WktRaGlYZ1lSM1FXQzJycmRNSGFXWlR2?=
 =?utf-8?B?a1Zqc0YvYVB4Ym1zNzNmbEdzNFZmVVFvV1VwRWE3OEJWN3JWQXZEMVpvUzdH?=
 =?utf-8?B?REJ5Vk5wUThlYXVRaGNObGYxVkJZeTVlODYrdUl2VzVKMlFtbVBzUUFtclZK?=
 =?utf-8?Q?e63H5ojrzZmhL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUE2cGRYbTJ4VDM1Yi90d3h4aWZQdEFpOUsyRW5IYi9ONkduVXo4WDdCa0FG?=
 =?utf-8?B?ekpNU3ZiU2N1MmJaREZWdFFFbDN1Q1JLa0dBOWNqNWxHMHJYbGpvNE1WSG9E?=
 =?utf-8?B?WlU1WWkrUGRUdENFZTBSaU1TQk40M1l1MjVnbkh1SHlxYkdHanZDS2ZadXN4?=
 =?utf-8?B?bmZRK3dhRW1NSjVMNFg2VjVCRzY2RmFOZ21jeG9ZZWhPeHRqZ08yTCtXYVJP?=
 =?utf-8?B?VlZ5d2t6Q3FGcGJYQWplTjdVQUcxSnc0cXRFaXZBNUlNMTNjQ3FmSS9ld3Q2?=
 =?utf-8?B?SGZUYk5vL2RYUi9uSDlQa3p0WndrbEhYUUd4T2w1UnV0eWI3VmRobkJCTEtF?=
 =?utf-8?B?M2RjS0VFdGpEZFZhclNqQTRSdy9sVGxDN2NNZmx2bm81VVVGOW9YQkFwTlBK?=
 =?utf-8?B?NjUzekVWR3pJcXVsYWJTZFR1cFdIbENZQjF3YkN2K0p3NlZ1cW4rZzczd3k3?=
 =?utf-8?B?K1J1eCtWTTZHTmFkOWlCVDRjTnhpMUM4a0FhYTF1cUtzbnFzY2VKcjg0VXZR?=
 =?utf-8?B?RzhkU1lMVXR2Y2ZmclJwWjlYREp6cGNVOUU5SzBiNmZCZnhFT0pOYTNFUXhh?=
 =?utf-8?B?RkJSNTJaS0hhMExFc0h5bWk2azM5Z1lMNkg3ZHlPZzhKR0hLSDRwaGl3TVZD?=
 =?utf-8?B?OHpWalVmcFFBSEhkS2FnSDhRQUlVSis3Wm5XR1pyZXlod0NlM29odG9taVM3?=
 =?utf-8?B?MWxxM1Y2YkU5OHRUclF6Tk1xUXFhZm9nZ3doRDRzcGpGcU5QcnhBZDFDZy9Q?=
 =?utf-8?B?N1hpWjRQUmJKdWJqbmsxOGdiVXdLN3BMaVZ6L1g1VnFqaC9mUThQTkFabFZC?=
 =?utf-8?B?UFRmOWRFM2VFaFhBUFYrYktrdURaN0p2UzRtY0VIdXlWZE5hVFlYWnRqQyt5?=
 =?utf-8?B?Qm1LMFVDL3lxYkx1bGhudjJlUThpdTlCaG1SYkpQQjQ2ZkllYmFmZno1M280?=
 =?utf-8?B?bGhKMGJuMC8rQXdiYzdZL09hUFZTQVVxaWZ3aU9LbFNJUmZEUG9PZk9EQ3hB?=
 =?utf-8?B?RTVSUjNNb0J0Q3JaWU5ONkZnamFjaHJnQ1BQUkRBOElyTmRtT3RDQTRNRlh6?=
 =?utf-8?B?aUNHc1hSWk9KV2hyMEgvT3FuM01ITk5oZXdDYzVyL3ZINzZWWDVuSVU0UkR5?=
 =?utf-8?B?WWNUSXphb0NYclhsMXFLcDBiRGplcDhEVjhsbTZqYjgvWEVHNjFrVTE3SEd6?=
 =?utf-8?B?Wlk3TlB2RHA1K052eEVOMGZwQjc2RHpWUkxBcVJPVUF5a2RlV1NQcFhOK25L?=
 =?utf-8?B?VTg1SFE1NHJjUGx4T1RoVkNZTk44S2dwT1d6NkE5Njl1d2JBYmY4Rm1pZDBi?=
 =?utf-8?B?UW51bTFCRXZ3NVpteUx5SS9Ub3FmZ3NVK3J0Q3BEUkJScHA4MjlVRTZnVFlu?=
 =?utf-8?B?YitiMllWTVdWWWxhOE55TTJwM1FKNXZqbzV4ZkZ6MFZuUjJvZE93dC80NVFt?=
 =?utf-8?B?WmxqTis3L0V3bHlZM2RQbHJ2Ukt0V3o0dlpuWWhVamgwMHMzSEdRblI5RXlU?=
 =?utf-8?B?UjRLSVYwOGNlS3Bac1d4eWgvOTY5MjVQYmNXVkN0alhyQVZ6bWRDc1BiM0ph?=
 =?utf-8?B?VTFTR0IwNkR2S2RqS29tSHVJU09RTjB3RXZmWVhzd1Z0azdaTGhUSmVtVTVI?=
 =?utf-8?B?bjhKM1lmd0Zzenh5VXBDazZWQTRwNmRwT1lIeFpJeU9DbUZTRFJrdGE1SVRI?=
 =?utf-8?B?bnRaYmpObFJLbXpIdGZNQWIydW5waHFHSGtRWlYvSVpYYVZtVG0vWklRWFcz?=
 =?utf-8?B?MVpqa3lGWjhSRXhkZUcxb0E4Y2tLdlVKMmpRSjJNTTladHNNRTIxdEFIbCtG?=
 =?utf-8?B?Sk5tcXk3dzdXdWN1MHBkR0dCWS81L2lJa2d4N0Nsb2hTUmQyMVhIeEdFcC9h?=
 =?utf-8?B?ZU5ScGF6V3ZWQ0pBVDBIS2hTenRmbEpkWGxPb3lLMmZSdmdZKy91VnlDVVNS?=
 =?utf-8?B?QUxOaHhidlBSbDF4bklJZ04yZDZMTXB5S0ltMXJ3SDZ6ZzBsSWRYTnZsckRs?=
 =?utf-8?B?WElKbnE3dm03d2x2R0xNV2t3N0dXaFdYMGMvckJ2UFpMbDdxYUU4Vk1rK01S?=
 =?utf-8?B?djlzdm1LR0pGbkc1cWEzRTRmLzJZM3MraUh3Y0hIcDhpNmZIYTBRRmdab3Y2?=
 =?utf-8?B?blZVSzJ1R3ZkSHl0NmpLeURTWnBKZVlSbXJicUovdTVaQ3lQdWRmN2FqNnky?=
 =?utf-8?Q?mANf31dLMCluZ2pJvyWIAxM=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdf85f7-3a11-4e7a-bb2f-08dd40718d2b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 14:31:00.2224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1UJP0KsE4Ld3/J/f+CP4nx71xi2RZBNCV14Y0uZbKiSCJvArBoxz4T8ufG4ILIW3zlOjyXsbeHOz4Vev/XqEX8if3F/ri5vbc+GlS9MkRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8188
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

Hi Marek,

On 1/18/25 12:15 PM, Marek Vasut wrote:
> Rename directory board/renesas/rcar-common to board/renesas/common and
> move files. This allows the build system to use HAVE_VENDOR_COMMON_LIB
> which automatically includes board/$(VENDOR)/common/Makefile . Create
> temporarily empty board/renesas/common/Makefile to be extended with
> actual content later in this series. This is a preparatory patch for
> board Makefile simplification. No functional change so far.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
