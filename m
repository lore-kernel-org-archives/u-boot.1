Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285A9D6552C
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 11:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51B7C83AA0;
	Wed, 17 Dec 2025 12:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vFibK9Tk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 166C983AB7; Wed, 17 Dec 2025 12:38:05 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76FB1839FA
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 12:38:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTOSgZyJBut6NEIiS2DiLW1E5w2pOInTUuJfjd1J3nlECQtYR5ssGBgwT6K5RbSvj9MGYCA+9mZlLvH3Y4d+3EEWjf14MFmCccpBnAueXK9MyfLZoh3CmmYZZhMRFCdTCYYx1FZMvlrXmec0cdlpRJ8OJNTGyoglH4YXAJPL+ZKJhPwcxUiIIuuz2M2RZnMAC+AlgOi5vJGkFci8zthQTomYPdeX28hayoLSusK5JEmvaVM1jVQ6AcSyG9pMt4DkmmZfwxHv1dcccXK5LpBecZ9ZBVaFq0iG2sX0j/YVyFWKIARWf7CNRCx7rYbi8qp0A+XOnmG1UR05P2sqqOz+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcGk/uHXQuZUPEEidUOqk0fm7IkdMVoCEM06+fKNglM=;
 b=V/JzXgQyCS+EZ0ugglvrhZ8LS1ODpYXliGJiS0bYQepBm2gzSkO6LgozHjmd/bvNVgDFZs1pm7kCzSt6ULWDsjvQvMq7EiC2DeX0K0PBC2WnoxYO1XwWw66j3YivXSex30XEtm3856MZtq6/TZbo2EDvGWgL25juP/dBNyPDciuDWIAZe2cfPBG3TT+XIrn5OJG1H4TTVs88i6ZpqZcEER62D2LO2OrI3FqoRRzU9nh29GFHnOo2ssOnjsodAlFz3/sW/QYEByCadATnLfL4zM05fr/d5BP04evVt+pp2r9pnbq/rMGeh+5C8ZtlAuwskqh1knkTdQjeNa64NtKG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcGk/uHXQuZUPEEidUOqk0fm7IkdMVoCEM06+fKNglM=;
 b=vFibK9TkQ6C4y2GGRepZ5m5INhPx1rH4N0MVRKnSiUTk5szTeWDaI6DEkM3089sYhu8+YW7BJVDIUX03AHVlpSJIVN1e38ZIodJuqri+JZTvQOEDpoxmaCe8p7bhwKcvpVTgDg3lTzYsyRKGo6w78KJCxNShH7HV4EBklpQhElo=
Received: from MN2PR01CA0020.prod.exchangelabs.com (2603:10b6:208:10c::33) by
 SN7PR12MB7179.namprd12.prod.outlook.com (2603:10b6:806:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 11:37:57 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::ff) by MN2PR01CA0020.outlook.office365.com
 (2603:10b6:208:10c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 11:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 11:37:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 05:37:55 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 03:37:39 -0800
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 17 Dec 2025 03:37:39 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>, Christian Marangi
 <ansuelsmth@gmail.com>, Kaustabh Chakraborty <kauschluss@disroot.org>,
 "Lukasz Majewski" <lukma@denx.de>, Maksim Kiselev <bigunclemax@gmail.com>,
 Marek Vasut <marex@denx.de>, Michael Trimarchi
 <michael@amarulasolutions.com>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] clk: Do not return signed value from clk_get_rate()
Date: Wed, 17 Dec 2025 12:37:27 +0100
Message-ID: <cb4ee3c0a81dda3cbad24ca4b6f69f8a20b29f53.1765971445.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=fSgv27vn5r50K/IkZAXwv0CyeRutDC7+jRpYw+EAPm8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ6Tf0xY93DS7s2a83s/6Z5IWjq1Z9Sz89aznQ46np/x
 m6tMLONEh2lLAxiHAyyYoos05l0HNZ8u7ZUbHlkPswcViaQIQxcnAIwkWeyjAyd32+9n1+aGLT+
 3KfnjFPXm67ktyuyyjzoma6+5L6Axv4tjAwzPdyexjfIhD1WaZtlXT1Hr3nC6c/H/31dFLvGome
 1hhcTAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SN7PR12MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: b907fafd-e8f5-400e-4567-08de3d60b9c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5UsezZRwC3aYODLwQqmpRxitGC7iDdUss+Nx6ZxiZeb2kHDuA2qcol1K0mpL?=
 =?us-ascii?Q?GZzZM1BsisJRxJ8wsRAhpHu1eE71Fmys8VvV/ctJSJJWNl4RhVXStkQfBiAJ?=
 =?us-ascii?Q?Q+KRYHH88T2hQBWQ1YTWepKI4cPAKxnN9pzQXcMZLoH7x1Xt5LU81i0OLeCI?=
 =?us-ascii?Q?dX0k22b7aTLQZJdrLntk2LgAYXxY7jqzTFWpFyTP4EaOJFMT817Ljxh78nmz?=
 =?us-ascii?Q?NN2RNhpmTBK569aDwE+u6GI/XvJFZlbHEtrigo3ORXIDJFym8I91L/MQwPyi?=
 =?us-ascii?Q?V8m9EVE8PICGqFIRBbFp6ex2UQ69mW8KMpunK4KktElfO3kv1YPd/wGYklxW?=
 =?us-ascii?Q?Ce7S4sQugRfrANpB+XnVJYOC1qTljvTykeHYhCxDXDe21P4ev8LhspXEVI4t?=
 =?us-ascii?Q?AaiUgr/pEcnJqcEmJmMeN1R3IqFKIcQ5jxFzW1ZtzOsmGvBR4iiFkszOwHpw?=
 =?us-ascii?Q?YliGUme2/6i97l3o6kMx8STxbfFXYAcrNJ/4naqAMlMi1y2LHhGSnml+OyeU?=
 =?us-ascii?Q?UGZvGCoBsdjXiCRCC/PAAWKTLENLMP63ah+NGvhRiZpD1V5SmVs+waABQqYZ?=
 =?us-ascii?Q?0P99KRKEALMaRx1NTW5hd2zOQxednTp0L7ee36bw2Q5b3w1heUdqzGHORJhz?=
 =?us-ascii?Q?9Gwj/I9VzogHo2SshdI5Y/D/KygTN9DM3TDkkSzluQgpEnmQRNNvlRteZiF3?=
 =?us-ascii?Q?I+H9eT0LDmM1V3ekEZ0RGBmXF0VFHyWcLAXKHud25+IB7ua0HDGa8Mg94+UC?=
 =?us-ascii?Q?IhObKKqfDbKxqMXJ8GuJ8eLRxjVOg0mNSRDQONw0XfQ6O4veUZ8+C7HtXXMA?=
 =?us-ascii?Q?YMfoYlFYQORbAV0yVLbVcRwTJUlkWSvH0h351qIzOfAz3kUrF80m2xaHY6vF?=
 =?us-ascii?Q?GPPCZjAFy/paLaoVvU2XAVBEbltZGLFzbUUGmHu07ONwzDVCot8VjYpaGU7G?=
 =?us-ascii?Q?ihXG/t2icCe2J+gz3JBgHJdxFbu+2pmUi2frrizlpW9QPWJ28ulB6XACPmhF?=
 =?us-ascii?Q?01f2+8S5LgTN7EZhv9+yskYdE5GSrbc/sNuJ2mUQJSdhfVR8FliPMphclm0g?=
 =?us-ascii?Q?Mk9oHRE8arVNvaTaopMbY3e6B7vAt8/n1jxm46RZNV4rfjxWLr+byeytVyAP?=
 =?us-ascii?Q?0pHSxglzRSMAAZbDOn07pp+VwVS/cpR4prKcBc4qCX/IFI8Pnc+amDBtJR/3?=
 =?us-ascii?Q?a+U1iePMniCVV7QqjWSQojYgzJc0TfS5nvun/lx2soWhbOx4PBm3PU2xjf3n?=
 =?us-ascii?Q?tMQLf18AjTl8KqxyzT+19C2YcazBADhtePTqT8i4D1sqTvLXqyeXavMfqL4+?=
 =?us-ascii?Q?sQgFDNa6uY62ttipxvlUrq/h6jAcFv0Ru8Oipl5jvhHTzPhL8ABKvbfRp1iO?=
 =?us-ascii?Q?vfRpaivh1TUNhgT/qhj6TPW4ZweWj97sO8rBxdHPlTY9ep7OC3o8UcaB9GMm?=
 =?us-ascii?Q?QS2/ORwMBOVkZFt8+DFRkXujtfIh/K0/OiQPeiU7UwzoUEep0hrC3JwfH7uO?=
 =?us-ascii?Q?3/VAoeGl/BFe/XDW1DGp5LJZMzNr6Fd67n1pw09E0e9m+MFZrGzIBc89MPhs?=
 =?us-ascii?Q?z+uXJUmmL90YdwuDtKU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 11:37:57.5758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b907fafd-e8f5-400e-4567-08de3d60b9c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7179
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

As it is visible clk_get_rate() is returning ulong:
ulong clk_get_rate(struct clk *clk);

Also struct clk_ops is defining it as
ulong (*get_rate)(struct clk *clk);

That's why return 0 rate when ops->get_rate is not implemented which is
the same value as is return when clock is not valid.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Another alternative is obviously also return only long and fix all
get_rate calls.
---
 drivers/clk/clk-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 4420651f765c..bca818530d4c 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -490,7 +490,7 @@ ulong clk_get_rate(struct clk *clk)
 	ops = clk_dev_ops(clk->dev);
 
 	if (!ops->get_rate)
-		return -ENOSYS;
+		return 0;
 
 	return ops->get_rate(clk);
 }
-- 
2.43.0

base-commit: e1082054610fe73d4487d12f4274315030592c77
branch: debian-sent3
