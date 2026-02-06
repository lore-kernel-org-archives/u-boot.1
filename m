Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA92EB28D6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 08:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 560C18382A;
	Fri,  6 Feb 2026 09:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SgTTWo8Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA28383A64; Fri,  6 Feb 2026 09:23:49 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9216836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 09:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNf4xbqxTGLLMkg4lLq6xV1oLxhouXPT9DmoHtqvdyBsrYQr0BrbSYCBx3k7O/cL7SmFniUqB8n+OfZB+6ROTe9Y+bomuFGr/2kAH9S/aW2dL/Ra5W4KY3KtRoY5tzSrxbeY1QFawrIS4G6aG2/mxqviWrYJz/6LYn2QWyjhqgkBkbc+Vlbzr+Bd4M0j2M2D1GcOW1sgRWcV3aK6hBZI+QUcvg04WgUF2bneWXmVBxGxTj00Qq2rpw1pBdswKX0tbqggDpiOg6IxyCm66yChs3ctvtW35YI4s+0ex3kPMJ2E+ebDSEAYo+npOsZu++eOkupIXpVH2PuLDMIFy3S4Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqqRvmwSs2YFC5yqWp4XgV+5eoALsfUy1KkioyzjHuY=;
 b=gUEIU7mclj+B78fKHl1+RNsqdrv4m272EzJh5/YYFlV+3SM5aIEkWBQwrSvLKszT5uIETZnYtV4KO7O4OGteuVQEJvK+QeA4nYi/ES3TovIutNB0/kz1Vzhppyk/8/XAACSOhcOUeFuN5IHgXb2tlMAdJqRZFziM3nnTBB39/fjvo9RYp3K06mV4hfP+FxaJkvObcJtSew7Wj3SbFi7kwDlrJqoZ2yzbj8PUm0UqDKIEn8DhL4c0HoHj+qQpCwz6ZVOOQ99w81A6szOG3f0WajPNayCwFZeN0tI657/PHdSdSCO1LU7PNu05N3pXGbl/BdrNtHOuR4KG9s77vdSKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqqRvmwSs2YFC5yqWp4XgV+5eoALsfUy1KkioyzjHuY=;
 b=SgTTWo8QezNuLvKwuD7b4plF1sQb/1/oZkhskzog1OXJxmuz3vFQSUlEdY/RCWiTTKWb8P+hsAqlnw7MGxvXQ0IAVGzDLE6ctucCRc8lXwyZLk0x/H4qct8mCh5hYLga5Q9LcDl1GtY3hh8acJ/bfZt6P6d5QDHwxHpJkfV2PcI=
Received: from DS7PR03CA0005.namprd03.prod.outlook.com (2603:10b6:5:3b8::10)
 by PH0PR10MB4742.namprd10.prod.outlook.com (2603:10b6:510:3f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 08:23:42 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::1c) by DS7PR03CA0005.outlook.office365.com
 (2603:10b6:5:3b8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 08:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 08:23:40 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 02:23:38 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 02:23:37 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 02:23:37 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6168NZ3Y879286;
 Fri, 6 Feb 2026 02:23:36 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 6 Feb 2026 13:53:35 +0530
Message-ID: <DG7QG3RE9VPE.N04EZYBXHLRT@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Tom Rini
 <trini@konsulko.com>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>, "Francesco
 Dolcini" <francesco.dolcini@toradex.com>, Garrett Giordano
 <ggiordano@phytec.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Vitor Soares <vitor.soares@toradex.com>, Parth Pancholi
 <parth.pancholi@toradex.com>, Andrew Davis <afd@ti.com>, Gowtham Tammana
 <g-tammana@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH master] arch: arm: dts: k3: refactor common nodes to
 k3-*-r5.dtsi
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
 <20260203133938.t5s5fub7qvgwr77t@bryanbrattlof.com>
In-Reply-To: <20260203133938.t5s5fub7qvgwr77t@bryanbrattlof.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|PH0PR10MB4742:EE_
X-MS-Office365-Filtering-Correlation-Id: 670d2d65-35a8-4be8-d930-08de655908d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXpMWHJxdFBpV1NJYzViSmhxVnJocGFaQnRuOUFNYjFKRk5ialJ6T1dleUhG?=
 =?utf-8?B?a3o3VHFEN3ZKZ2w1WFRFZWxBOVYyR3ZsV0pvY2ZBb1FuOGYvc05hblA1akls?=
 =?utf-8?B?SjM1THVpTDYwUzBqZzVaMzl5TERaODA1bjVxNjd4MzhieXVzUkQ3OFYyZ2Y2?=
 =?utf-8?B?U1Iwekw2ZTg5Y3B0eWRDbWhVdlRwU1g4NUY5TlBjUjRHdVNaQi9FZktpRThu?=
 =?utf-8?B?bkVSQ0Q4aWh3MENrNW00MEZWYUlmdGNYcmVobGpPaTNVbWpuOUt4T3ZReUhN?=
 =?utf-8?B?aCsxcjRXTzFaTnhXTVRZMWRYYzllck5YWU1FQWxXSjBIOWtaOE9TTFFFYWJT?=
 =?utf-8?B?bWpWS3BpRXozVzFwUVpLTEp3MWd6OVJuNUdLcGl0U2I4VE5KVHRtN01wYW5q?=
 =?utf-8?B?dGxFK09OL2ZQeXVqREF4Z21ZRncwWGxTMGhicnZKL0liUEc1VlRXd0p2Z1Zx?=
 =?utf-8?B?bTlGSTVJS3dCdVdORFMyYjZIbUp5d2I4R3czM2YvcCt0TmpaVWMrK0ZFSzhi?=
 =?utf-8?B?YTl2MWtjcTdXVkEwenpLMnJTOHNxMTcvVW9WWS9CbTdRSExINnlNSDU0SXJT?=
 =?utf-8?B?c1VMSDJDcHJySEI5OWVQQ2krV2NFTnI2UWJ1bWR0dWwyRGNHNDBOTi9VbjFz?=
 =?utf-8?B?K3pCL0lXTVRwYWdLYkRGelBRaFV0V3pwN3FvZ0JmampqWWdBNkkwb0NUQllN?=
 =?utf-8?B?TEFvMGtkdHRuS0kxcGFJSWJzUVpQdUV2dWRuckxpMXJ1V0t1UDlLY3JxTDNB?=
 =?utf-8?B?all6eGFVT3hYOTBOOXREa3pUR3FVRWVMSTVYdEVieE0veHpTNVpuMFkxSXl4?=
 =?utf-8?B?SU9neVY5RW8rTG92M3BBazFYc2thZTVEZUFpWC9qUS9vQmlRWjhQaDgydkFp?=
 =?utf-8?B?WVpIQS9BMzEvQ3FrQkJKb2t0aGh3V0RGMUx2ajZKUUlWY3FmU3NlODlkT3Er?=
 =?utf-8?B?MVdYOUQrSVJXR3JPUExNMkU2NTRPRUM2T0hHZDc0cWNVRUwzcW05VFhSV1V3?=
 =?utf-8?B?UVlBQVk2UktZZk96TnRaelEwcXFWK0RKWlVpeEdVTStyYWZGOXNSYTVBM3M3?=
 =?utf-8?B?WHhzRGVDWENQaTVLdm5vWUNVTGFPczU3bnJ0M0Z1Q2xVOExYOFVVcDFFWXRR?=
 =?utf-8?B?MVZEQVYwcDk4U0lHQ0FTMHVtVnd1TTBCTmpEWEd1dmxkc1Q0UXg2QXBQWk9J?=
 =?utf-8?B?UldaRjdEbE9jOWxlUXBPMjNrK3BVVU5iVms2UVB3Mko4emtNQ2hRSzRGcXZL?=
 =?utf-8?B?SGRsQlVGODliR1dNZlRHVG95cFpOM0R6a0IxNzhTMXNWUGFWRHYxblNjY1Jh?=
 =?utf-8?B?bVhNakpScG54Uk42UnhoaTNvMlp3K2J5b1VPTzNQTUZGakhyUGZlOHNqMFpw?=
 =?utf-8?B?NTdMVHdjaStjdStFYW52c1VMSkFjaWtja1VtWTJmKzlxSVByOXpISzFoNjdx?=
 =?utf-8?B?anpBSDVuMFoxQ0lRbTNMb3puNG1mYmVNZVFWNHJpOGU0cHBKV2tYbXhGeWEy?=
 =?utf-8?B?UFBGWWozUGVGVytDcGhEekVGYVgvQXFacTh0SllHeDF4ZDFQMlM5YTlTb2xt?=
 =?utf-8?B?TmJpZjBzUHlTU2RJY0lNSjNMbHNMVTBwNDVDT1ROQitzc3NMSXRKQ0tPb1Bt?=
 =?utf-8?B?WmRqZzZHL1FFaXJSOTcrUFBZWWxWanozS2ltamtHV1I5NHUxOEFpSUNyZk5j?=
 =?utf-8?B?T3lZL01JQ3dUTmJYSWhvY2VYRFlxQURUUXJhWjRjcWVVRlRFOE8zNWNTWHBn?=
 =?utf-8?B?NXo5WkxRM09pdEg5L3A1MzhrSEhNcVBGTUNpYkhZdlJNT3dpeFpiV2dhT3FT?=
 =?utf-8?B?NHpJWm1TcXhmRmx4cllIN24ySFBkLy9oT0JRQnFyUk0zQytQYmJFeUZRcWdy?=
 =?utf-8?B?T2M4YVIwdHAxdDR1bndnRkxJTVZlYUNoM05UdE92bDl1TDVIRFduekZjK08v?=
 =?utf-8?B?RTJabDRsZ1RkbmpYamVXQkQrQmg1a20wSU42M2czYzhWODVQNVA0MW02R2hj?=
 =?utf-8?B?RjZ0YlVTdEZPbGNYN3FvY2FQcmhpSzdDc1h1TlEya3VOa1d1ZFVZMTVwMUV1?=
 =?utf-8?B?emR4MlVkSEkxT3JhbWY5NGRhQ2tzTWZBU2FoN3NPd0ZFR3NHQ3lPVVgyUXZ5?=
 =?utf-8?B?MWFEbkQxTDBXYVVqYU9rS24wOUdRdjhMSUYwM1pGNVJrYkw2SmlkVTRLZXM4?=
 =?utf-8?Q?jCj040lA9tG+RKJtaqLu4bY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ADeCObNVbEINYMOyas0vt5in75uvwJD1mFGUM3+CER0h+LvaO4g8Z4/nAJ4w9Q7yDCQwbwWwEyOC0/dG/dlVYR84+9MQEXvY8KU5UnYg9DZmjBrFpKC3eGTYMGNEgt/Ir3ohvRhxLBciVzbG1iYzXDEfwcLpR1lizh2lEAGzbO79e5GIE/Ozo7JRty5e/OP/fDtkJB3m4TJ4TlN2Mt5EpBnKl0LyxrOyBtETb5vSuTvoQp+yuIIEMIyqA7zRpPB670YVKE3r9QV2cUEHmo66RGuD9NvgoaGO1l3CVBAl0pKxbRKCN+mGL/pHcb2qgaAcUA+XGY6jKivyq0d1NobhKX9BZK1AYnl4T8BhuHLr9FVFLYH8KUfH6ppb/um0DwqeL/nT5ezTkBjZcWmdLNisCLIoqN1AjzF3I7rtBh811NsIuAvJQmswrfg3c/LJLL6W
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 08:23:40.6613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 670d2d65-35a8-4be8-d930-08de655908d0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4742
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

On Tue Feb 3, 2026 at 7:09 PM IST, Bryan Brattlof wrote:
> On January 22, 2026 thus sayeth Anshul Dalal:
>> This patch refactors the nodes in each board's R5 device-tree to common
>> SoC level dtsi. No functional change is intended from this patch.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>
> ...
>
>> diff --git a/arch/arm/dts/k3-am625-r5.dtsi=20
>> b/arch/arm/dts/k3-am625-r5.dtsi
>> new file mode 100644
>> index 00000000000..c509857ac5d
>> --- /dev/null
>> +++ b/arch/arm/dts/k3-am625-r5.dtsi
>> @@ -0,0 +1,88 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.c=
om/
>> + */
>> +
>> +/ {
>> +	aliases {
>> +		tick-timer =3D &main_timer0;
>> +		remoteproc0 =3D &sysctrler;
>> +		remoteproc1 =3D &a53_0;
>> +		serial0 =3D &wkup_uart0;
>> +		serial3 =3D &main_uart1;
>> +	};
>> +
>> +	a53_0: a53@0 {
>> +		compatible =3D "ti,am654-rproc";
>> +		reg =3D <0x00 0x00a90000 0x00 0x10>;
>> +		power-domains =3D <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
>> +				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
>> +				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
>> +		resets =3D <&k3_reset 135 0>;
>> +		clocks =3D <&k3_clks 61 0>, <&k3_clks 135 0>;
>> +		clock-names =3D "gtc", "core";
>> +		assigned-clocks =3D <&k3_clks 61 0>, <&k3_clks 135 0>;
>> +		assigned-clock-parents =3D <&k3_clks 61 2>;
>> +		assigned-clock-rates =3D <200000000>, <1200000000>;
>
> I wonder if it is time to drop the A53s to 300MHz (the slowest we sell=20
> binned parts at) and let the speed grade detection logic speed it up at=
=20
> runtime once we know it is safe to do so.

I had actually recently worked on modifying the clock rates at R5 SPL
stage based on the detected speed grade of the SoC, check the commit
65a6b83a9b7f ("mach-k3: refactor A53 speed grade clock-rate fixup").

Currently we support runtime configuration of clocks based on the speed
grade for AM62a, AM62p, AM62x and AM64x. We can expand the support to
other SoCs in the future.

However I do agree that the default clock-rate in the A53/A72 node
should be based on the lowest possible speed grade however doing so is
out of the scope for this patch where I tried to keep functional changes
to a minimum.

I can take a look at this for a later patch series :)

>
> 1.20GHz is not a listed speed we support according to DT[0].
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/arm64/boot/dts/ti/k3-am62p5.dtsi#n107
>
> ~Bryan

