Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9811D2F031
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7632084081;
	Tue, 27 Jan 2026 14:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rNIaTAiI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A47F83FCF; Tue, 27 Jan 2026 09:17:46 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75AED83F9D
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 09:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEVsob1dWnpb8Ac3LyEt951Eaxs1zJs8IOl1lCIva5BqkYON24BfNdR313ik48nRAuZBEDbza7NjEu1fv8007Td8pxWsNKEhUQk2Jpd8ul0eeE6fXX/tDxiXeSbb1G5ve9i9WgaZqeHpPe0rVKrvlGUt8bJaCYRRB83xqmTOOGSPSlngkfpVivXxqbktW/z47cYQ1KI9CLyEVVsBWZq5UvcMDn6WfF5qLzx12PyRX4OPWuVEdIrWmOyy8xlT0jPWCDwn0x+AQ9gvp38/w7dIFsp3gl74Fwr+1Qbb8kGUG5cp2FR3biV7PFz0NCdkz/OzGxIAaDBZZYlva8y2i97xhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZD3uACeidxw3vmoK1tgDsu+zakNkapHbZmMpuXxVdI=;
 b=W3lNIJukC8UoZw0h5qH6RH7jHlImhfnDtbqiTWaa/pTxHLI6QwcFshF1AWfbzww2z7aY97O+aotIRqyQXv8NRzuX4l8Ag6RH/McVWSJaqGjZQ4Z00lGoPQQ1RMJJdj50Z4j+O8rJbbofJBUh85eeL9etGiJJl7DjzkLmHA28v/txqJsOAZrfoF5KaIoZp2A3Mm+P4OltqGoLqvkQISyiBn0oRoTwLv+DNRpn4TyO9xqOxwVFGuKbsRy+1B0Azg91mAEeOogQ75HEWmIv1Zu8n11Dmk4BA7niznfwP1OYNEcgyM8L5ptQfsD3117qz74SxdPBbHabDw0y6KWTi5s48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZD3uACeidxw3vmoK1tgDsu+zakNkapHbZmMpuXxVdI=;
 b=rNIaTAiIolCPbgmgNVKTaEEnSVkpMOfMIgSCy9XAFuughlqwcE376j5XrrJJAP+Ysx9ZQfjkCymnNOZRz//FnHZHK8ZBjT1C/o8FpRjbJnnwRv7DFsYHb972WlTWiN6Ah61PuCjzkC09hO7hinVw9X7deHT2rT541jn2uMscwmw=
Received: from BYAPR06CA0052.namprd06.prod.outlook.com (2603:10b6:a03:14b::29)
 by LV3PR10MB8011.namprd10.prod.outlook.com (2603:10b6:408:28b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 08:17:41 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::61) by BYAPR06CA0052.outlook.office365.com
 (2603:10b6:a03:14b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 08:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:17:40 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:40 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:40 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 02:17:40 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R8HcuU185482;
 Tue, 27 Jan 2026 02:17:39 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: [PATCH v3 07/10] arm: dts: k3-am62a-binman: Configure firewall for
 ATF/OPTEE
Date: Tue, 27 Jan 2026 13:46:49 +0530
Message-ID: <20260127081652.506357-8-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127081652.506357-1-s-joshi@ti.com>
References: <20260127081652.506357-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|LV3PR10MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f799848-f309-4bd0-0ca3-08de5d7c8a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wMuvmWxBKVEagSW4B+yGHO8XgDAc3OTZ5VZoZhx9PYTgRCOLBjsPGVjG0mCP?=
 =?us-ascii?Q?hnWf9h86K6wQU53UbM5o8kj8lrTiiRPRbYkNSKtAgxM5n/begskVWnkz7kdL?=
 =?us-ascii?Q?y2C0EzRlO9XPkGi126n7iWI8y18gfxHudCHQL3kraiqs4Z/C40ugihziv0eO?=
 =?us-ascii?Q?Qnx/a9EH0fRxzHuKcYEqB6JRt5Q8DCaB0DT5XhDP65A14OXK3/vMI8NjZ0zn?=
 =?us-ascii?Q?Cm/sPlmkumjhMX2P9N5Z9Fh/kXnlLz+/1oQdPn+09xp4KTS0+xiWgDd3o9Cc?=
 =?us-ascii?Q?PaYrunHiD9Wq2rvgfB0MTS9DwcCPuF0ibw5nctWizt4kbgUJDCE9b+awfWkb?=
 =?us-ascii?Q?xsq5o0Jmnu5WWtYLQy32B6KLc6PA8EvJ9NLdEUwJQlyMoQgVS/AoI0r4lF52?=
 =?us-ascii?Q?P+L5fKdGbf1b2xYWcLgvnJCNcfvNopEkntxhVaYFvZhdgKnA4FNlOgNsYKGm?=
 =?us-ascii?Q?bmVin4zFPrwIL9Ee+yXP9e+hxT1KSam0nG4twT00yPKaD3XEhE2nqh/+SvPJ?=
 =?us-ascii?Q?q1CJaqg+jj25ioybaBcjrUIQoBP3xvUJ9x1d23VRGGexfTXZUCaot8Won+Xp?=
 =?us-ascii?Q?sw0QLzRM6MWC7a42VlJe2XpG2iL7ruHeCv4eQLH5JylgF2c1EkdXS7glCqrZ?=
 =?us-ascii?Q?SRWk4IKtgkrVAXM+nBzEMAIhjPCgA7/wkHjNLc65j2imGpiAcIEPMiPm4IfN?=
 =?us-ascii?Q?Aub702r1gk2O+snGsr2h3S597A12OJ+cmrbpSRyDDZrl1+Oz3vhDASxkmR7c?=
 =?us-ascii?Q?8007x3l93xOg1Kz9AucGYitIGu8QLTGYkqi3NSY9+MRbvzYlgVzMJE/1obGn?=
 =?us-ascii?Q?vThVATLLjjeOKvA0OGTUtNGvRT0SUEk40AfhpjvDsbHdaLI3qSQzQz8tAaDA?=
 =?us-ascii?Q?8yX1D6ywAIB/7DjJFgq+7V9q62nHyDXU6BPIEkrSKRBTkm7vcM+pcC5ndxsR?=
 =?us-ascii?Q?dvJ2slFHPcVpEkjxuAaY/ynuhapQx0cK2Zd78XD1/L7BG+BizVvoP92WIhr8?=
 =?us-ascii?Q?Gh5ECUyLJT/Wt23z77m1n9iLK4HWEfh2Wrs2Yng/NCNoCzE6BpVcsyHFgwPT?=
 =?us-ascii?Q?oY/ZPiLBSifQ3y1xI9VPndgGUcXq9Ex5Y/GDW7SnSH4yrcxxLWDiqs8Zdg+V?=
 =?us-ascii?Q?gcwxgtC/dmjkZedy60Fi/oP8kG1yM/alQJ4r6IMhxP8fG2rl52P7pce4BBDE?=
 =?us-ascii?Q?KWAfjky5Pxbhl1PkREgJg1k8C0aiPKXy2NsNOhBpBqY9kZzjGLH+UPuylcXd?=
 =?us-ascii?Q?E3C0JTTLFGOHyG34sIzeukxiXk7JO3MsWczChTdWm1Xf2+NLn3KFqueMrlP5?=
 =?us-ascii?Q?/PcgFsnu/9IabeahIHYaTA2pVwhqU8Z8tduBlN2AAb6jB3kpqOO/yVzDRyof?=
 =?us-ascii?Q?1o+K5pDPBr3Gs/d89WIafqIw0SR7Ep+F0dHcXB+0nccmDcKP2WHyKvHvO1Kx?=
 =?us-ascii?Q?Ajbw+vH+Xpd+la7qJvNsZVhS3n66GNFMumCYsCLZ0LUgV8nRtSzswbko9o7a?=
 =?us-ascii?Q?kUuEQj3BYmDjVKHYoBKq8EdvC0Qm/F7FQvK/elP6yr5Bbred6M5pwMFmdebV?=
 =?us-ascii?Q?AcbV09Git1nw2i/MSPMF57fV8DMbaYyDZ0OyZyIKCveMWwPgjJpRheIXtkz4?=
 =?us-ascii?Q?4iu7IwXb7Wpx8qHfkTMTIQYoZ1a/r7VmZJ9g0XMX7EfHCPQRAv/H4c4dl/mt?=
 =?us-ascii?Q?0lQLww=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:17:40.7717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f799848-f309-4bd0-0ca3-08de5d7c8a32
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8011
X-Mailman-Approved-At: Tue, 27 Jan 2026 14:54:50 +0100
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

Add firewall configurations to protect ATF and OP-TEE memory regions
from non-secure reads and writes in AM62A.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-am62a-sk-binman.dtsi | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/dts/k3-am62a-sk-binman.dtsi b/arch/arm/dts/k3-am62a-sk-binman.dtsi
index cb9a56b8c37..49c90f5855c 100644
--- a/arch/arm/dts/k3-am62a-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-sk-binman.dtsi
@@ -200,6 +200,36 @@
 
 		fit {
 			images {
+				atf {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-0 {
+							insert-template = <&firewall_bg_3>;
+							id = <1>;
+							region = <0>;
+						};
+
+						firewall-1-1 {
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <1>;
+							region = <1>;
+						};
+					};
+				};
+
+				tee {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-2 {
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <1>;
+							region = <2>;
+						};
+					};
+				};
+
 				tifsstub-hs {
 					description = "TIFSSTUB";
 					type = "firmware";
-- 
2.34.1

