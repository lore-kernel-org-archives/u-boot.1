Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E35C9EC88
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99FC783B49;
	Mon, 12 Jan 2026 14:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UcsHRzJL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AFB683CBD; Mon, 12 Jan 2026 10:38:46 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CE1C83D6C
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7b+FUJIJEbzgKJ6uhKgKFO9sMK+KHBUA1GR51E2oC2TkKq4UHKaJi45sqCnroUSLsfWn4gFIqzy7PScbBpJxGiUqCQwA2cbsrrN+lShdoEJGyCoiDsyaqjb0+SZ27FNOCOF2yGkCCgO+XLv96CnIdTFc0+5mThJ3Q6B4exGZj+3NjJwqH2uWOAvtdyjEeFoNSimsaYS6946302MCWXKLDCkvEoK3wOaswZ4CplvrbJtUwnotQcE1jPjU1uMneDG5MUCgvJOhh/d3s/v08+RQRY2tbzjtAJ3zvmdjrUB7c3PfLAUIJAc/NVeJja/Jh+UDNtjSVHzr4VnNrKalhLvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZD3uACeidxw3vmoK1tgDsu+zakNkapHbZmMpuXxVdI=;
 b=ke5lzmzFC2RjK5KRAjzqtKUX7eS5PXqItU/KRRYAiuZjexI+vPziYcggrMP+4lRKC156A1hCKwEpHdFlqngcwQTeE2W5HuEKHlh+9LRYrTNeOzqidvrPsDxO6gpT3fhxq+IcQqFg8HnHPUxaE+rE9IdE2RQmccWN2SWgeW7R9VF9drUG6tR7fjY7tLDW+7QRhXqv2w/wnuoEdwmpsNZ4tg6wsRw8bPpaa7Qp3W1yo3R3VnbCRV9iTOBt+RmQKLH+o+QUvo5Q7DuFQw/Rt7GK+xh/GZavkCDLmo+Xf3C0XE90/+bpew6+It2YPC9AWm5Zgj31UtaLAJcdY55gxqgN7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZD3uACeidxw3vmoK1tgDsu+zakNkapHbZmMpuXxVdI=;
 b=UcsHRzJLXjP3kYGLXVpWUgokhVUVnCBc0pSWx3ygTqCgbz1wjsqMPuYESBey2Y4/mrPN1rt/PaES4PbegJHy0geyfWE7wsGAniU8NwcmLcWxPKwZJGOlC3LHEnKDcF1eomRTYKwzHTFYXLOa5s7J5BNxC7FFWTxFpTU/1kGwaTc=
Received: from SA9PR11CA0027.namprd11.prod.outlook.com (2603:10b6:806:6e::32)
 by CO1PR10MB4691.namprd10.prod.outlook.com (2603:10b6:303:92::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:38:35 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::b9) by SA9PR11CA0027.outlook.office365.com
 (2603:10b6:806:6e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 09:38:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:38:33 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 03:38:33 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 03:38:33 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 03:38:33 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60C9cVQQ156339;
 Mon, 12 Jan 2026 03:38:32 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>
Subject: [PATCH 4/5] arm: dts: k3-am62a-binman: Configure firewall for
 ATF/OPTEE
Date: Mon, 12 Jan 2026 15:06:42 +0530
Message-ID: <20260112093643.885903-5-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260112093643.885903-1-s-joshi@ti.com>
References: <20260112093643.885903-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|CO1PR10MB4691:EE_
X-MS-Office365-Filtering-Correlation-Id: 835c8563-db43-428f-52ab-08de51be5a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|34020700016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p9c6ame5TgDPxutiWPU/JIGGUqms+jFW8T14Fpxx9pLlp8KgQ0tnRIohVvVi?=
 =?us-ascii?Q?6er3UhsjtqyDdXj+JtrLOd9ObiNJJ8z6GTRSL0UzuQ5JpsMTJz0SyQZYkJcz?=
 =?us-ascii?Q?7LUB8u8zHXehCLrKi58LiRSFR0Pidv0om4lgWc1Gb+TmRr5nN+8QqTDs5gZw?=
 =?us-ascii?Q?T0pyW88manCQUPqc0ntTX6kZOkbHbYb4QocDQ2RaJZjwrs1ZzubnLmpMAFJm?=
 =?us-ascii?Q?+rlEkJtclMyyEbXh2catI7geIClZAz8vpyu+J7cPVhCNnpWXY1b6WsGj+XPU?=
 =?us-ascii?Q?GSpS/niP2AX0ldEh+lr+y4jLo8hYoED2eQEhBH32lr+KfLgUMOHBFU2Aok2S?=
 =?us-ascii?Q?b50kHTEE7/I6gXXpGvNu68feqikfM/hR4EnAYAemIuf/p8th9W6cIkDxSjf1?=
 =?us-ascii?Q?u0Ui5A020WpHT+VAiYzu3XCESN8xvJx2NOHIeOTit3PNaeNIY5uze+021Ibq?=
 =?us-ascii?Q?6MvvaoJk0jhSdi81wxKGYhEpxxiFs+6/2B/fWT9sE7VpBClD9WzOrJO5VgCm?=
 =?us-ascii?Q?4pDJpP7KJV2RfIC/n5KLooOIMk9bsOJuZid8S+VLGl6qFtLT7aN1XYdWCBgy?=
 =?us-ascii?Q?heeANjkJNHH74nlVhYsk8dIGbuhg6uzxzBsLNcuBWalIQB3qmbxWFHZPih/f?=
 =?us-ascii?Q?fYNJqQLYOzBKmnBeyuLe/FxSr+C72P41ATfpQnWXZxxFEn+YjLSRTTKfvBUV?=
 =?us-ascii?Q?f8PMqPFTT9kVGNkojzrs2C4BXDyUG1aqw4yuo4En/wpLS39fF/7wxQFnx0Zn?=
 =?us-ascii?Q?bnCbh1ZZCXX2LxETGT6QqKIxrTEkujX8DSHq06nOMDDVKRmY2GWnjx8tL42h?=
 =?us-ascii?Q?u2B2VakswF5KqkXWfcOUAsO+tGuUVFb4wMQ/m6KEMKhPPbG2zYh/fAlh4h1p?=
 =?us-ascii?Q?8O/KIbXIPqdgUn9EiguqBt3Py/tUxkfz5zPdkb8RzNYTZsfM/yMeEs9CK7f6?=
 =?us-ascii?Q?vigCcx50czbPRPsrHosYBHxXZmAso/r0+bZIQIn65tHRgieLmzELMJoRh6Vq?=
 =?us-ascii?Q?ADuobUV7vSgwOTH2zxwF8BpZUBIBLCsCRR4R2ksUMiVLYl+PBpUphF4scC76?=
 =?us-ascii?Q?zee/vXqOfNYQK80H84r1lZqFJkaiuGDyD+a/1ONSA5TIfQnD3Vr3NDvgXvpv?=
 =?us-ascii?Q?WBuKmLqbdLjsSd2QLUgw70MRu9iCGMrwoMPEkyjHOD3T5XIWcLHdHt/Ce3xg?=
 =?us-ascii?Q?rWpBRhdB161bXf3IlSIMJZiNkwpmklgNlQEN9eFq/lhmEVr6d6ZO01ytZFYg?=
 =?us-ascii?Q?vdTj+m+5to86ucvWh5gsOjVHcfkfmutUXjnzlmRukZ/4E8u5gihOPJroBZjS?=
 =?us-ascii?Q?jufS5Dj1v7v4cYIRJ5GOeBCZnL81ktTf3LUzSqbmaHyS3ki8foPexwWtsynC?=
 =?us-ascii?Q?U2kUzxHdHkPbGGUHqLBSuR+vsGK0EN1/24bJDP0boA+eL0EMQi7xEuOlut8w?=
 =?us-ascii?Q?Ogu9Rx822iS5n8vO0RosWxCmP2NdpkvC1U5nTxCz3xasagYmDacfrDRlmeuL?=
 =?us-ascii?Q?lYKXwaSmxoVEG+o8rUfZPTYZYv3NStLTks1+cu3hTJpdJSAgEBrsuYvdR6aT?=
 =?us-ascii?Q?02Zh7VCk0REsISEuRGE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:38:33.5812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 835c8563-db43-428f-52ab-08de51be5a77
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:09:41 +0100
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

