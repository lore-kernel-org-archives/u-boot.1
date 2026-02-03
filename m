Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70B1E8782E
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8FD2841DF;
	Tue,  3 Feb 2026 14:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HKqmbTEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0452D8413A; Tue,  3 Feb 2026 14:39:52 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCEEA8420D
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QD568uQ+VGjRc3fZoGkIpUcxJg3v754EnVALGhKalxFRtMzkO758LvXfwRo/A4Rr2h+wsIJs8fCeFOocY94ZBbcMUpO8dwG9OEprvckpu6BDKNALIUgQtz6FaK7ipftB8+XKNXE3LYPvRKqPoMbfXvlvEusv78ihXT/xU27WQoHuQPhi0qxtrSvluFwnqZ1ZyargpFWKFI7iyCGZ1Ts9VX6ah2hbWkaw69i1ElwO7Ggb2K9kaFL9by3MX4O0E+XRADKX/1gKUkXlb9ot9fL2QlRccZI53n8eXLZoDLFPYSr8L3H9EZvACEFxCwaX6xmGlDED347PBVdTLUDiN4rCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+ZDYvCrIyqvOdCo87SVoHXSyrF2VxPLRHUTORt96y4=;
 b=s0bFvaf9pynkfpIR64PTvq+gQliJ9WcyOanFUbqINcLr0UztADvSICb9TnSI7k1FtN8ZPcVzgsZIFepu81c6ki8tozrobi0GSxXNV/QG6QuDua5FCRAVYQZtHJ6Jd3DWeifqAsoBTq/By3yYnWDznfbH9qeLOa54PlGkHGo1osTdburcwgRqdEQ0g5apvU4CgV9iNFNPMwzrCt5t+9sHs0flRvBsRL2yd+gjTFY0VLGRQllNge9ZKuTSeJAIV0dajnSBW/VhHuG+ZfDjN3N9wR4DQKAb72djV+tlq7r37FcQQPfcKIO2LbieYbws0M9U1CwkfgieVIaH5CrtVgZ+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+ZDYvCrIyqvOdCo87SVoHXSyrF2VxPLRHUTORt96y4=;
 b=HKqmbTEZzauzPQCdohhNZHiRvdrYJ0bZRti2M2A1s/NLWZ69BmwpFXP7g7Zh9Iz3sG0odro7/ZMhCSRNXlV8HNjh8S+07wytjdXUGrzUmV0+8iRu7D1lR/7l1oVJV+2LbYBTvPVUA8mZNpMO5UnygFlVo/e164ITR8IVm0jAQf8=
Received: from BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28)
 by DS4PPF381FEA7CA.namprd10.prod.outlook.com (2603:10b6:f:fc00::d14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:39:40 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::11) by BY3PR05CA0023.outlook.office365.com
 (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 13:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 13:39:40 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 07:39:39 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 07:39:38 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 07:39:38 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 613Ddc8P3593591;
 Tue, 3 Feb 2026 07:39:38 -0600
Date: Tue, 3 Feb 2026 07:39:38 -0600
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
Message-ID: <20260203133938.t5s5fub7qvgwr77t@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|DS4PPF381FEA7CA:EE_
X-MS-Office365-Filtering-Correlation-Id: c277a00f-1f98-4f7a-81f0-08de6329ae46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NURGaUhGYW5mc0JzM2pETndVZ0FSWUJpNjYzMEUwaC9sR3hNQ25PSDM3ZnZx?=
 =?utf-8?B?a3FKQ0loQUlLOURqYTI3NHFuVG5JNlErV3JRaGFQSDl2TjlEYm1vRUR3aTlN?=
 =?utf-8?B?WDFBWXNBajRjMUpydWptM1NNK0RxT2VONGk4MFRjMmQzS25lUUJUbFExUjlu?=
 =?utf-8?B?STNTMXBOYnRXOGovOE9NVEFOODZWV2JrOVcyQnIweU8vK0oyK3Ewb3FQS0dU?=
 =?utf-8?B?SlVUZDFvTitJWjZ6bUpXOUFaOHdyamhxOEkzNlF2ZlJKQkNmV2svY1VlVHUz?=
 =?utf-8?B?UW8yQ0xiTGtGRjZYb1cvamVseDE5NnFVMzlva1p3SEFSOUI2elpPVWphMldo?=
 =?utf-8?B?TzV0MG5jRTNTaEdLS08xUlFwa2JENUpiOGpKdENUbUpFR1BpRVNpTXV3dUpX?=
 =?utf-8?B?Vjd4dFplK3FwUEQxaDJnQzNGK2xwTEtGN0YxNGp0KzJrajZXQkJYd1p1QjQ5?=
 =?utf-8?B?UHF0c3g3cUtvM0RnUExraWhNZ3BLcHY2alJ6SEtHc1VNUUFDcDZUelFXL1lu?=
 =?utf-8?B?NS9jM0NqMmUrS2tsZlYyeElINDY1SjJJcWtUVTJpL3pTYzY2Q3lldTN1eWRx?=
 =?utf-8?B?K0txRmZmUldWTmNoNTR3Z1pPV2wrOWQ3NVVqakRwd3JHL2tVSlJuY1dxRzFm?=
 =?utf-8?B?cGFMdmNjejYva1QwMW9LVFFZTzBJZU9rdUk1bFIrVHJxTXh5aC95UjgzQllS?=
 =?utf-8?B?K1JlMkdxUHBPQ0FhWFJCWlNpa1FSQ1hzTzhONzFqQUtrVGEzZndoUDhkNlVh?=
 =?utf-8?B?RW4wYTBWVm1qRld5d2tKdHhVc1R6ZElsT0NNVHdRTlM3dk1DdUxNVWNnSVFN?=
 =?utf-8?B?cDFUZTNyM3h5TnBBVmZKczVlNE42cE1CTmhvRDhXZ1RkYWFpOE9CQmxTSHRy?=
 =?utf-8?B?bzIyZUxvTW1CVjA3bk9oVXErVkNGS1YvaHBidUUzemZOM2svZGFLTkxVZ3RM?=
 =?utf-8?B?UE0xODNmdGZkK203QllOTGxpZDZoT05oUGNQRVc2Z0VIZWQ3QVlhWStGQ1NG?=
 =?utf-8?B?QjZTZG9zSmRpakFyY2dUNmRPMUJiaTJ4bnNPTkh5VVIyMTQ0RkdxTFBhRHAw?=
 =?utf-8?B?dSs1WFFRVWpUZSt4RkIzbGdYaWpMYnl5NXo4ZXIwc3pQczJESHNQZ2RuSnZL?=
 =?utf-8?B?U2VEQzd6NWFBSWNiNkxaeXBMd0xlL3RBbnBWNkpIeDlPQWJQMzZBRWhXMzcv?=
 =?utf-8?B?NHJxWmtUWGY5TndOdjhKcDYzQmUvZmRqRlZEYmdiREVpVEh1OHA1TDN5cnlI?=
 =?utf-8?B?NVArMWgwOFRHN3VVbzlldm1ZbXg5Y3JMTGFsTFFINUtHcmMrZmNlWDZVTEhi?=
 =?utf-8?B?aGs4YXpydi9kcXdFbCtWL3NYdXhtY1Rod3RiU3ltcVlpVXFHNFFNTVI5dzJO?=
 =?utf-8?B?czJqRmNZZVlPV1ZmVFZJNXBTbThWLy9Uc2FyZmtCaEVrelpiK2NXQmlqaGJw?=
 =?utf-8?B?M0thNUpwL3FEckxsYnRHQjNheTJTa2VmWnI5ZVQwNFQ3YzBLZUFLNXlKQnky?=
 =?utf-8?B?eFNDUVFLWW1JcHFURGZCdVBZM3QyMStRQTBSbXNLMXlwdmNPdDhaY1N4S3l2?=
 =?utf-8?B?NWdDUldMUFM5dGFUZUtra2grSlVWUmlYZXFXVTRqMWJ3cjFKUW9YdWtPNVAz?=
 =?utf-8?B?bjl4Qy9nQVFxTjZNTkk2WTFtY0dKNUNXaDR4RTcwSjMxSnZTZkRqeDhrUG5w?=
 =?utf-8?B?cG5pK25xbGk4RWFtNFNURVN2MzNxbUVrZ2tvR3JQbS9yY0hSVmZKbjRadmNT?=
 =?utf-8?B?b3M3d212QVhvS2liZXNjeDJ5VllZcUxrYnFFZ0xwRUh2MmR1c21SQWE1dmtP?=
 =?utf-8?B?d09hVHJvcjBMa2t6aG9KRHhHaFIxK2pvS0FrT3FicnR1WmJoQ1BDcVBrR3FX?=
 =?utf-8?B?eFgzUDVmZWVoeU9Zd3RTMGZ1ZEtOSWNoNkJQWG9sazBnekp3MmN3TFF5UDIy?=
 =?utf-8?B?VnlydmpSaW50NTFIWXgyU1p2WTVzNlUwRnJUeUs5Y0JGcXlBRHNFSUVOYzBn?=
 =?utf-8?B?K0tHWWRsUDA5S2VrQnNmai9PYTdoSTNpV2ViMElTZFJhTzlnY2Vwb1BmTEho?=
 =?utf-8?B?aUgyYXRCR2xodmx0ZlA0ekhFVkdWRTFIaW9sbjNoRHJpUk1qZjBsMHE0cTQ4?=
 =?utf-8?B?MjhIRmJ1Y1JTaW84NXh5d2tnUS9kNDJ1YTRrV0ExcDJNMFhRYzM4d201Q0cz?=
 =?utf-8?Q?UqC3BL0PdvCpZ4ift1znP3c=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n4slxnVJPMJpP+YopYsidtu5AMAVokmPL/odXAEbtoNjPRr79GqKXuaOp6p9YhWtN5vNHyd3Xa/mnKATyBidRq+nnRjkQy58HyCUrsAS2cjoy8UcZg0P4PMfk33RYgIMSox3IlJ33Vpayu3kw/oKzegCwF+2zuHTQ9nOvGhS5RjoeW8+MBMxlg0+VwnvRDLdMt3FrByzYR3tPHJ412yZ2GWZuQgmsiuSLKGXiS+BFxBJekx8XdFJejk9YZePCBxKDLXLu6lC/ZKkFa/LlenoJOoopD15EVvZsOIerw7UM+vpG1FptIRIw8Qny8sH8xN2TY76ooM71CwsiclghvK4fcjJJo3aDoV25Z4Aj/9B9K3sQ7/1lw8IENMZtYr0zUCsvSnVEqRQGUjnBW1GQBdGR/FLNQRP4ikK0FyuW9ioBhzHxjesWVn6GwToGsB+uptv
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:39:40.0563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c277a00f-1f98-4f7a-81f0-08de6329ae46
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF381FEA7CA
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

On January 22, 2026 thus sayeth Anshul Dalal:
> This patch refactors the nodes in each board's R5 device-tree to common
> SoC level dtsi. No functional change is intended from this patch.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---

...

> diff --git a/arch/arm/dts/k3-am625-r5.dtsi 
> b/arch/arm/dts/k3-am625-r5.dtsi
> new file mode 100644
> index 00000000000..c509857ac5d
> --- /dev/null
> +++ b/arch/arm/dts/k3-am625-r5.dtsi
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/ {
> +	aliases {
> +		tick-timer = &main_timer0;
> +		remoteproc0 = &sysctrler;
> +		remoteproc1 = &a53_0;
> +		serial0 = &wkup_uart0;
> +		serial3 = &main_uart1;
> +	};
> +
> +	a53_0: a53@0 {
> +		compatible = "ti,am654-rproc";
> +		reg = <0x00 0x00a90000 0x00 0x10>;
> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> +		resets = <&k3_reset 135 0>;
> +		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		clock-names = "gtc", "core";
> +		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		assigned-clock-parents = <&k3_clks 61 2>;
> +		assigned-clock-rates = <200000000>, <1200000000>;

I wonder if it is time to drop the A53s to 300MHz (the slowest we sell 
binned parts at) and let the speed grade detection logic speed it up at 
runtime once we know it is safe to do so.

1.20GHz is not a listed speed we support according to DT[0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am62p5.dtsi#n107

~Bryan
