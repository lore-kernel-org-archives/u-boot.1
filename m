Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20707C5AD4E
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 18:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D0B83CF5;
	Fri, 20 Feb 2026 19:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FNxv5s0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54CBC83D3D; Fri, 20 Feb 2026 19:45:28 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC19383A5E
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 19:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAIWiEIbMUjIMXBD8rdte2JMJdmUkEBVZf1lWYZZ6Jv4otdHjkT+KktNoO9JBZenseqxwEYm6L392O1fswRbsQU6JA1O8403vc/tx05l58wk983lXRMdO3uZ8iUVFJZpCXoiDqh/i9VJLkQDGTZU070gn/OO+QmhKqD5W9vZE+cTnRvQ4THG/vpVLACd0cP8LxFn0vrkHkkgmM8NQGlN2xEJDkjHzZ95rFAe7VVQ0VsL/jy1fTQeVueXZNCpchotujoD+D2jQq4ZDZaL05M4nagopgzOV48TI4gv19s8vg1EsnL+6AGslCBQrWUwqHy00yboz/4nC1lCPpi++OQbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEme4yo9Xjb07PDRZyPzKx8tEtdZP1wLE8vMqg9XU0U=;
 b=GfTz9w+x2miFsjfgpGI0GuDu51WwHx5iNnfChv1LQbBTzc5TiZx2Lvo0gjdoC1vyRWYPjr18/uioaiDmIw9bW2Q/pbNRSX7D/30LOIbBohyz+7CvpDrLAJXTRER66IZnGI+9n/aT/4TfV6aJwm3NC2/C5JyVePBUJrdsWm/bGs+LpzOuoZre2Sg0+sjzF+TMScFDXyFwX9UMP0hhI1m1qiIg9nKHXy5wBkoTWmt8DYoNXsrWp9dtliPA7CRyGMmjl8Y1t3FPOyS/9wpCrrwhZErRop5Hs3BveDYizRdLocL82USkqDGojclNOJeDfVgny0+JWf7dBD8hfSsKSZbXxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.phytec.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEme4yo9Xjb07PDRZyPzKx8tEtdZP1wLE8vMqg9XU0U=;
 b=FNxv5s0kYRuBfLV43sd8w8a72AC5nlyQCMKrf0u89MpOUE8dV0KpQNyVS+oSawvWAW1HHpvVzeX16urcDYm5k7eeryUy+rom8NE7rnPVIudNX/gNoKXiuJYdsue+k2qjpuKqLRfNPAd4+aOpaeSQr9GwPV8hNCtorBSkNN0CXww=
Received: from CH5PR04CA0015.namprd04.prod.outlook.com (2603:10b6:610:1f4::16)
 by MW4PR10MB6680.namprd10.prod.outlook.com (2603:10b6:303:21a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 18:45:21 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::4e) by CH5PR04CA0015.outlook.office365.com
 (2603:10b6:610:1f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17 via Frontend
 Transport; Fri, 20 Feb 2026 18:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 18:45:20 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 12:45:20 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 12:45:19 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 20 Feb 2026 12:45:19 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61KIjJkp605804;
 Fri, 20 Feb 2026 12:45:19 -0600
Date: Fri, 20 Feb 2026 12:45:19 -0600
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: Wadim Egorov <w.egorov@phytec.de>, <trini@konsulko.com>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>, <m-chawdhry@ti.com>, 
 <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: Re: [PATCH] arch: arm: dts: k3-r5: Drop a53_0 clock overrides in
 board files
Message-ID: <20260220184519.ixz662xb3bncd6hf@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260219102721.102254-1-w.egorov@phytec.de>
 <DGIVQZB5G0NQ.36KCKDY96KAL4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <DGIVQZB5G0NQ.36KCKDY96KAL4@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|MW4PR10MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3d9cdd-b0d3-4e2a-0b54-08de70b0330a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1RKc2lhbWs1UGRuV3k0akIxYjQ5WFhEWUE1S2xxQytzZjFnTXJUTkpUNnpn?=
 =?utf-8?B?aXl4aFFrazVQaXNKeEpsWXYwOEdIcU54WUZjMmgvenBONWJqNHN3ZlUyTnBX?=
 =?utf-8?B?bFh1UXZkV0p5c2hiTGM4NmtSNXJ4WGsycXhTaXZOUkFNVzYrV3dBZWpXbE9k?=
 =?utf-8?B?NERneS9QMEVKQXJvMllzWmxOcGZuNEJkdUV1UmRzNVBobFBEZE8rWnlpTDFK?=
 =?utf-8?B?dUhLNHUrZ0lqa1htQVQrM0M5NTl4eGZHdlFsTTJCRVV1UzZoNkU5dHdjaloz?=
 =?utf-8?B?TVloZDNnbHNHaTBBdW5vTy9VZHIrTko0L0piTXFLOUNDTjFmeWU2aXNvdGdS?=
 =?utf-8?B?QzhMRzBmaTRnc1VHZDFtQ2MzQnR0U1I1L2ZNSzBHMlFEQm8yRzhwZEhEa0Z1?=
 =?utf-8?B?V3dZNU1TQ1pMZklDQU05VmkvT1E3RXBQQzN5Z0txSkdLMHRuTTg4ZVhqZ0pp?=
 =?utf-8?B?eVhWdlRBZWlwQzMvWUl0Y2NNbHRUV2VxeERhS1pIQmQxcWR5ck41M0F3TTU1?=
 =?utf-8?B?eHdvR0pjMG9Xd25abVhDMmhINWc1TjVDWGZDYXMzWk1ublIzdnJjVUk1NWdz?=
 =?utf-8?B?amZ0L0x1RkxnNVVabVNvSHBnUmJlR1dEaHpQQ2x0WkFKMWFwK1lXM3l6Ny9E?=
 =?utf-8?B?NFlEMmNzK1pQS1ArdjFLS1F5dG14bUFIdnRqbDZwZVl5NEtrQ2lTZ0JYeGhs?=
 =?utf-8?B?cG9KemtIZHJqQWpabkx4NThQemVkcG83UTZzZ0gxWTl1UDk5K1E2dXR4ekdE?=
 =?utf-8?B?RVUwSXJEd25heVN3ZGgzcmZNUE53TTYzTllLbTJuUlhyc3Z1Q2FhZkdRb2tp?=
 =?utf-8?B?Ujhock9tNU5FZC8rMG5yTGw2S1FoaS94ekJPMHMwdDJOengvRGswS1FBWEpt?=
 =?utf-8?B?dG5lU0o4TEtuS2NtVTlXcTdsc1V3RGh2azNsZEd1Vk5odzJzaGNpN3VoSWdL?=
 =?utf-8?B?a2k0OFJsWEpKcHJoZ0hVdmJJTUw1VmxudzZSakRPTDh6Y0x6Mzg1Z1QrMWxw?=
 =?utf-8?B?dkltRjBEN0tXdG1ZNHNqWExRWlhUUGhabis0ME5aaERmYTAxZ2xNdG4vQWY5?=
 =?utf-8?B?ci9BbjFxVEpXSnNEVjhERzhqOUpOZkFvYnc5U2t5Z05nUFhiR2VYMHQwSDk5?=
 =?utf-8?B?OWxyTlVNWVlzU2FTcEVwb0dBKzdIaUhsM2ZjNnB0Y2ljcVpZYlh0NzRacVNm?=
 =?utf-8?B?ZUtlaEdjYys3dEQ2TExEQmJRMW92VFRKYmdFQ2JxWjFNejVJcWRGTGNQc2xV?=
 =?utf-8?B?UDhEcnV3V0liYWNwSm9mYytiVlEvZVBPQWFnSWRDbHhJUG41Q0NrYmxsbjNl?=
 =?utf-8?B?TmpDbWJYSVlNQmdFeWIzU2llVnkzVHdyVzVrREt5U1pQcVFjbmQyYkxVdFhN?=
 =?utf-8?B?TVFLbXdEcytZVUtILzQwY1JubS9sR1VsMGZ5ejdJWUdOY0g4d0hFVG4rUDVP?=
 =?utf-8?B?TEVyUjZkOGFMeTBoUEZ0UkRpeFdLZ0NaMHFoSlBYbFVVT25XdWRqNk9CcnQ3?=
 =?utf-8?B?VFBnbXJqK0JwL2dsTlByTGhOeTNNbE55a1NkQ0RqWHl3TFd3aVlETW1LSlhB?=
 =?utf-8?B?Z3BLSFNhbFo2alpTUFlNekRCWjVjbzJTQVQwaW1BNGZpZUZtMGlDZmRFYVhz?=
 =?utf-8?B?MWdXQjdwbm1IajBTbFFuTTFZdUxMNXNiRjhoUEJWOTcrZUdLMGNYbWg2ZE1i?=
 =?utf-8?B?US9vRSt4bVJqbjVBRFpZODhpd0t6bmIyTzljRzNZSm9GeVQzL0ZjTlQ1UVRP?=
 =?utf-8?B?QnMrcFBMVXRyenpuZ3Zma1NMVEZzYlVkbFg4WXFocDYzNEJzWUJPRUVzbzhF?=
 =?utf-8?B?OGhxWmw1ZUZ6TjVEL2NuLzRPL2MxRXAzeFNhM3NzTGd3cnhHekdWS1c3Nmtm?=
 =?utf-8?B?K0FLL2wvaS9RRnNvWlJocUE3a2VxbWRoS0VLMm9mTi9OWkRJbnIrNXZCSVU4?=
 =?utf-8?B?R1RsNmVjMitTYlZ5S3JsLzRELzFlTjNtWmF4bFh4eVYzbnJiSzRuRVVWS3JC?=
 =?utf-8?B?OWg4MGRHNnVXV0MzQldvR0wwbmc3bWhxdEcxNVlSclZ2MDZjRXZTODdvSHU1?=
 =?utf-8?B?M3RZcjFTdEpZd0J1aFFHU1NqTXFnajhCTXh0cVVLdC9BSTFpcUFCdXRNdW9X?=
 =?utf-8?B?azZYMXFudUd0NEFyRE5wLzBwc2FQR3ZxU3gvZzRXQlAwaWg0UXc0NStyb0pz?=
 =?utf-8?Q?7MzIWEDthkQQgkKd2SRLYdQ=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NqNrqepn/s5IpQXHOiI8ILRZ0acssaLILigl29c2VSz5a+W3JTM9xCdCbORRZxXZ6kwIKA/RW0a9nSTK8RqgpLv/s4bsmZos/Qt5Ld42H4MDjKC6TFIkmbtbuvqaOPgFNOCu8ldligtWPGCZTkxZLojN/3oDcMkjyR8WtfDQI61UNP4AMlyvbfdRWY+3MihVVpw/jGxTGjSZD9NJebga1/pk9qkMh7fB8YoEeBgWcObU1zRZlXnllxBgKxfkFhIZ4pBogsEaQYfiAYbTIvxwR/McGmFt0zK1CEvWCgvswyukKuLpy0gu/cRLvuS+0ivM/uWLxHU/4RWG4FDirLZTNPdLmDWOyYL8MhHHwfHL6aCww5Eu45WoIKDvmK24wSedqB643X6y6rGY0N6YX5sXKRIzOOH9SYiGz0/UCwxS/JtmH1Zpgy60unkke/yMi8to
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 18:45:20.5112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3d9cdd-b0d3-4e2a-0b54-08de70b0330a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6680
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

On February 19, 2026 thus sayeth Anshul Dalal:
> On Thu Feb 19, 2026 at 3:57 PM IST, Wadim Egorov wrote:
> > The a53_0 clock properties are already set correctly in their
> > common k3-<soc>-r5.dtsi includes. Stop overriding them in
> > the r5 board device trees.
> >
> > Fixes the following error message:
> >   Failed to set clock rates for '/a53@0': -61
> >
> > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> > ---
> >  arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts  | 5 -----
> >  arch/arm/dts/k3-am625-verdin-r5.dts           | 1 -
> >  arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts | 5 -----
> >  arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts  | 5 -----
> >  4 files changed, 16 deletions(-)
> >
> > diff --git a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
> > index 46b621242b5..ac6f1022a55 100644
> > --- a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
> > +++ b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
> > @@ -21,11 +21,6 @@
> >  	};
> >  };
> >  
> > -&a53_0 {
> > -	clock-names = "gtc";
> > -	clocks = <&k3_clks 61 0>;
> > -};
> > -
> >  &main_pktdma {
> >  	ti,sci = <&dm_tifs>;
> >  };
> > diff --git a/arch/arm/dts/k3-am625-verdin-r5.dts b/arch/arm/dts/k3-am625-verdin-r5.dts
> > index dfd960aaf3c..971bb752052 100644
> > --- a/arch/arm/dts/k3-am625-verdin-r5.dts
> > +++ b/arch/arm/dts/k3-am625-verdin-r5.dts
> > @@ -24,7 +24,6 @@
> >  };
> >  
> >  &a53_0 {
> > -	clocks = <&k3_clks 61 0>;
> >  	/*
> >  	 * FIXME: Currently only the SPL running on the R5 has a clock
> >  	 * driver. As a workaround therefore move the assigned-clock
> 
> I wonder if there could be a better way to handle the hacky solution we
> have here and in k3-am62p5-verdin-r5 to configure the clocks for
> ETH_25MHz_CLK. Though that's a discussion for a separate patch, what we
> have here looks good to me.

There is but it will require us to re-think some things. The R5 SPL 
(before DM firmware is loaded) must use essentially a bare metal like, 
and very minimal, clk and lpsc driver before it can load DM along with 
the rest of the main domain binaries in the tispl[0]

The original idea was it could remain small enough for everyone to use 
regardless of board. As things have progressed though we have needed to 
modify the reset defaults[1], like we're doing here, or even configure 
different uarts[2] on other platforms if needed. 

It's hard to keep increasing this tree though and still fit in the limited 
sram space. Maybe we should look into allowing the /board folder to 
override this clock and power tree if needed? IDK if that helps anything.

Reviewed-by: Bryan Brattlof <bb@ti.com>

[0] http://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-k3/r5/am62ax/clk-data.c
[1] https://lore.kernel.org/u-boot/20260128123623.2737451-1-s-vadapalli@ti.com/
[2] https://github.com/beagleboard/u-boot/commit/c6678d3338ac2b8429028b5b36c6096761531142

~Bryan

> 
> Thanks for the cleanup,
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
> 
> > diff --git a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
> > index b54cd9d48a4..c949485017e 100644
> > --- a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
> > +++ b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
> > @@ -22,11 +22,6 @@
> >  	};
> >  };
> >  
> > -&a53_0 {
> > -	clocks = <&k3_clks 61 0>;
> > -	clock-names = "gtc";
> > -};
> > -
> >  &cbass_main {
> >  	bootph-pre-ram;
> >  	sa3_secproxy: secproxy@44880000 {
> > diff --git a/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
> > index 4b7a63db4ce..6f3a2628353 100644
> > --- a/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
> > +++ b/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
> > @@ -21,8 +21,3 @@
> >  		ethernet0 = &cpsw3g;
> >  	};
> >  };
> > -
> > -&a53_0 {
> > -	clock-names = "gtc";
> > -	clocks = <&k3_clks 61 0>;
> > -};
> 
