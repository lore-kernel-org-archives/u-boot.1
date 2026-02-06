Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A95EE20A5
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 13:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 962DB836D3;
	Fri,  6 Feb 2026 14:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d0XuEY9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B486983AA9; Fri,  6 Feb 2026 14:47:56 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A82358352B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 14:47:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H45Q+TMLvLoWpzGNyj8B7wLaX+EzYMZPJIycXQq9OVMloji/WOB+mhvNPim5L44F1ef1tqyo0MygFSFmQpS7iveclK2QBu2g1QalHlA/PkXHSTP26GvseM9E7e66lB2xCnun5DFH7O0lDdBctEu1Z0NMrGX7iE0vGlX1RI+36tI2TXYeSgkdJBL1hgBwriSZpDaiXn2+YkWsWmVuw1OESB+qbUQZDYSxzUKTtcNgKBodGSduvWptkaFHOb8S7NGWsuy+wAHEirJ6KF9juMTzPMu3teUequ1OCNxAK9LJ3knOeiBE+kLjoDXIJ3YxWxQru7erqOoa+MCqARHgetLDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nMLO55Y7kclH5XvKLfNIiXU54gS3Txq1qswHnxs5Bo=;
 b=vWnouiVbsBJZVyT3G6XbhZ8aLoaGR+YNb7lfJTGD99EDYjBXm8EvvTi40md9gXOBA6/tL/oX/czApyGqDHY0ZRATNH17nasiJiKj3IOq6vq1JvNN5VagSJwcazXohF9Ho02h2DNsy97RwpGFbXLm1Zc1wVpPxnPi7aaa4kk+ysGkQNEhg6Rlj7FGKexr2I7SMoecDtjrZZcuz2VtunUrW4tvBbgAuYvOrsKQEzPPz8Phw4TTX6mkcmIQwZpAv0NCIWHwdYAmpmZO81RGEAqSSj2MD0y6r0ZhfmotNdGT1lEfBMr0Tl368t31MO69WlUcihGOWskoDeZzJcW2QysWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nMLO55Y7kclH5XvKLfNIiXU54gS3Txq1qswHnxs5Bo=;
 b=d0XuEY9g57rLy65D8b77RBoS//buuPSz7fAvuGTne134xS2b+7GXu1ybYBra5Uulw52g0Qg9rOVjAFDhTdehjz/ehWottr+0uYQVr0LwFNQxtOS+C6PNttM6O8GO92Y/DBygMYhd+gKI329IbNW47be6ezWl8oa2lai5maxm/UQ=
Received: from BY3PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:39a::25)
 by SN7PR10MB6382.namprd10.prod.outlook.com (2603:10b6:806:26e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 13:47:50 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::dc) by BY3PR03CA0020.outlook.office365.com
 (2603:10b6:a03:39a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 13:47:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 13:47:50 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 07:47:49 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 07:47:47 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 07:47:47 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 616DlljL903580;
 Fri, 6 Feb 2026 07:47:47 -0600
Date: Fri, 6 Feb 2026 07:47:47 -0600
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
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
Message-ID: <20260206134747.55ikpxr7xate7okr@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
 <20260203133938.t5s5fub7qvgwr77t@bryanbrattlof.com>
 <DG7QG3RE9VPE.N04EZYBXHLRT@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <DG7QG3RE9VPE.N04EZYBXHLRT@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SN7PR10MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: a02e7b35-f48f-470a-f62a-08de65865194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tm1PRUN0SnZlQUd2dkpkY2NDWDBKWk5oSUdiMGNzSTZXNzN1bUZXK0dHNG1N?=
 =?utf-8?B?VFpKZGdpSnMrOGhCZ28xWk1VbHdZOG00ODZVd1V6TDRHZklwd3ZQTXIyZUhp?=
 =?utf-8?B?N2xHdDdhMnhwSDFPSlFkUkV6Uk1scmpDWDBrWUFHNlR2VzFNNkNhVVZqeUJP?=
 =?utf-8?B?VGZNZWlDcjJRYVVnZlZabFBqVDVaek1qRkNmVS9rUmd4RmQxSDVqUmZPQyt6?=
 =?utf-8?B?LzRwVE5mOGh0WVNIQ0p4SFd0SDFmekRWYWlEbE5xREN4MmdyUkpFd2FGKzFU?=
 =?utf-8?B?enRqQU5kaVFhQjU0bFg2UG83TUZORURGcDBQSG1IOGp5R3BrZ0R6cTFWN3lR?=
 =?utf-8?B?NXE4N2oveVIzZUVsRUlrdHI4QUtpb0xjUjl1aDBNS2tNcm1qTDBmYVZyVXZj?=
 =?utf-8?B?OGNjRGVxNU9KbW1TM0tnRjZyQ1VxMXh4ZnhaRXkwOUJVNDF5SGlFaGwrUHJt?=
 =?utf-8?B?cEhkOG1jbU5rNEJnc29BWDJRL1lIU1Q2cFlvTFRpMlY1QzhodlB6L28zM2Vv?=
 =?utf-8?B?YXY3SzhkMmRwWXNvUkhSRlYrTGNlU2tmTC9EV202cFlPc1BtMUwzRUZDOC9Y?=
 =?utf-8?B?V3Z3ZXB2ZkFSRUZuTnFJay9oMmNxSngzZENQc0U2citTdVd4a3FHbXU1NnRy?=
 =?utf-8?B?ZzRJQ045Y0JFVnpvSnZRTFBiNmFTV0xoU1ZGNWJ5eXdKclY5TUZzeEFtUmFj?=
 =?utf-8?B?VEVudGNKL3B4R3dITXFLa0xmbE5URm5tQTI2UENvY1ptUkxpNGgrb1hDUnA5?=
 =?utf-8?B?SERsc0JDSEdRNHhWNDNtYTZPVGEwR081Slg0eUNTRXMxM2FPU2dFRlB5U0F0?=
 =?utf-8?B?aEFObmN0NkR6SHc5OUk1WGhhOUpFeWxtUXVMbmtSQ3dtMzg0ZlpwYVJUTGU5?=
 =?utf-8?B?Wi9VbGNhdGlRcitEZkV3aXJsNllBdS9BVGxLaHN3YVQyalVmeTd3YmpqeVF3?=
 =?utf-8?B?cnI2U3o5RS83OG9PL0ZONVFRbnliUW5MRkVERFdRc1hEeTFOVHJ4Q0IrZzJ5?=
 =?utf-8?B?cGlBdDYwQTZYZ041U3k3Nmxaazc3MTh0M0ZPS24yd2k5UUZ5dllBdDN6bDFF?=
 =?utf-8?B?Zk9BdFdNbGFNcm9laHdVWVd4cTM2SVBuelY4Zm5mN2tRbmw5MGtZM0hCLzl1?=
 =?utf-8?B?U3NKR29mVnZnbzZPaUVqVlR1Y3BmckU1R055bHFrK3pqNHp3Zno5cDdvVWxJ?=
 =?utf-8?B?aGRoR3k2dC9YekFiOWsvSjlHcVpQM1ZxY2d1VDBCclQ2MmlQWTluWkFJTnUv?=
 =?utf-8?B?ejZhQllUV2FMKzhadUdjZFlDcmdOc1JwRi9HcXFFYkNpT0JaUkVIZmEweHUw?=
 =?utf-8?B?YmdhSEVNZmdMd1RNZ2dteDkyTlJNZ1c5Um5pejM3YVhTT0txU1NpYWxjK0lj?=
 =?utf-8?B?d2toNGVvdGpxWFRvQ3dPdWdtV0xiWG05Ly9EQ3I1NTA1NTFIcUtDMVk1dERl?=
 =?utf-8?B?dnNFeGFjcWNBakVpeW5RL1lWdjVyUFp6bmkvZHlLajZHLy9JUDExM3lKN253?=
 =?utf-8?B?UHRVcUx5bG5aQkZmdk5KWXZBKzY3UFk2SVBWamxTOWNrcVBSdXFOdzRBUzNJ?=
 =?utf-8?B?TUFMKzBQbmVPVDNrQUlUazFMOEJNMW9DMnZZZ3lFcjhHNjJpakJGUG9jY0Ru?=
 =?utf-8?B?WEdDU2RmVDRPekR1dVdvRlQrMWx2ZE5tSjJjYWpPMm8xVjNIRVJRdXdUTHY4?=
 =?utf-8?B?MzN5VHNyS05jQVZCL3d0eTZ5WTV0RzRadkd4NWdQZm1ZNFVlOTFtYm5YRmFa?=
 =?utf-8?B?bVJCRFd1THk4Yng5aE1kWG1hbDBJMWQyU3dBNFhUcTNOOHFGUkpmaEw5dVJl?=
 =?utf-8?B?R2I3VzJ3WENjQTFYbDZIa0VsSUU1QTdBcmdLWWpMczlqeHdhYUJwYkdoVFpH?=
 =?utf-8?B?c282RHduZm9UUHV4NHZyazJLSFcvamgwMW1KT3d4Nnd2NlYrbjNSQjNIRWpn?=
 =?utf-8?B?ejVDdzNKdFVwT2ZHSkJkVk1pdG50VVZLUnV4K0pzbThDK3pyQnQvU1lxcHRK?=
 =?utf-8?B?ODFUZ0FKK2lzM1ZkY0hlTlFib1ZmaGxXNnhsQ1MvMEJuTFZuKzVkSE15aE80?=
 =?utf-8?B?QlZmUG52NU1kYmplT2FINEtxU2xWUmpmMlZzTnAvWm5EMFNOdm11ZCt2a0xh?=
 =?utf-8?B?dUxwUEpRNDViMCs3cHZ1U2hJWUxWcXB6RmlFVGQvSzVCV3VpbjRzNXlydFYr?=
 =?utf-8?B?T1E9PQ==?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +36qIJEnIQqQifvkBOFAN6flnGJuKvat6iHbawXlXamRXdzjvQAaBWbH5Wuu4FOOZibsgg+8hNFqMZEjTQimRXUWje1vB+FD0LEDw89svLnMfl3NAsq91W1EELle7xBeFw/XyPj4TCFzfqjP2qJKMkPYvkBTjdvGElOahshPIzFNbvI3bAAnT2ridI94N0McSAnpvIWzgf+PLTq8nRsOBjrctC6NgdaGfoR0pf3bOTORXqqu+rSwcbidGa+VulEHY8ijmnz95gje5viyXW5czTukUmkAmh6a96uzNB/KWOTry7kK6tSzmecuRNfiEyKCsPpLgtqnJ50Hna3btUk5pSD+lcEri7X5ARNv95W5+JbWMWDyCxIZz4kG1rcJx9ilbyLiZyg5KAFS33TuVf6Y3VG29HBNwZdswf10hNdS9WvSF4FQiyr86cqopDC2TF9e
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:47:50.0572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a02e7b35-f48f-470a-f62a-08de65865194
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6382
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

On February  6, 2026 thus sayeth Anshul Dalal:
> On Tue Feb 3, 2026 at 7:09 PM IST, Bryan Brattlof wrote:
> > On January 22, 2026 thus sayeth Anshul Dalal:
> >> This patch refactors the nodes in each board's R5 device-tree to common
> >> SoC level dtsi. No functional change is intended from this patch.
> >> 
> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> ---
> >
> > ...
> >
> >> diff --git a/arch/arm/dts/k3-am625-r5.dtsi 
> >> b/arch/arm/dts/k3-am625-r5.dtsi
> >> new file mode 100644
> >> index 00000000000..c509857ac5d
> >> --- /dev/null
> >> +++ b/arch/arm/dts/k3-am625-r5.dtsi
> >> @@ -0,0 +1,88 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> >> + */
> >> +
> >> +/ {
> >> +	aliases {
> >> +		tick-timer = &main_timer0;
> >> +		remoteproc0 = &sysctrler;
> >> +		remoteproc1 = &a53_0;
> >> +		serial0 = &wkup_uart0;
> >> +		serial3 = &main_uart1;
> >> +	};
> >> +
> >> +	a53_0: a53@0 {
> >> +		compatible = "ti,am654-rproc";
> >> +		reg = <0x00 0x00a90000 0x00 0x10>;
> >> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> >> +				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> >> +				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> >> +		resets = <&k3_reset 135 0>;
> >> +		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> >> +		clock-names = "gtc", "core";
> >> +		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> >> +		assigned-clock-parents = <&k3_clks 61 2>;
> >> +		assigned-clock-rates = <200000000>, <1200000000>;
> >
> > I wonder if it is time to drop the A53s to 300MHz (the slowest we sell 
> > binned parts at) and let the speed grade detection logic speed it up at 
> > runtime once we know it is safe to do so.
> 
> I had actually recently worked on modifying the clock rates at R5 SPL
> stage based on the detected speed grade of the SoC, check the commit
> 65a6b83a9b7f ("mach-k3: refactor A53 speed grade clock-rate fixup").
> 
> Currently we support runtime configuration of clocks based on the speed
> grade for AM62a, AM62p, AM62x and AM64x. We can expand the support to
> other SoCs in the future.
> 
> However I do agree that the default clock-rate in the A53/A72 node
> should be based on the lowest possible speed grade however doing so is
> out of the scope for this patch where I tried to keep functional changes
> to a minimum.

Sure but this patch assumes all the minimums are the same for all SoCs. 
Otherwise we brake this out into their individual files again.

Anywho the more I look into this the more the clocks are all wrong which 
this patch didn't cause. Just something I noticed reviewing.

~Bryan
