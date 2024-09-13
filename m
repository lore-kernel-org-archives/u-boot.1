Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78222FA3736
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 281C588B70;
	Fri, 13 Sep 2024 11:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IdwXL3OX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C141588BB6; Fri, 13 Sep 2024 11:29:45 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC5788BFB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0PxQoMWXQ8Uu6LJMnSVaAY+7EwLHM1F7Y5tIqSmdz/FRQgq+2DUUkvWbkx1Q/2U03XMpOAO0ektUeh6RjgLCjWTm5DtQnYgjVA3cvQH5YCNXVVE2DTOhf8y1EBzmvcKRCDUE7RPjUTbis33JiFNTwOUx1P4jEbev7BKruw8vZqT/2e5vSZEsgysHR5oBZP9B7k7dlURghhxe1IBlpxbU38YmA/FkaYEtX/WAQv1eGYuGOAZQSy8jwtY8yvdEC/X12gNOgw/3aEpe8CxWTzTiwiNlBmESBMaG0TIuAuQzOWHOiXoQctpWsf+sgMrgnzP2TdA9YAAknz9rKEo0APPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJcDvYcmWNOkbeRfQkJXiVPZ4gPwIjiiW+GryQ0YH1E=;
 b=uefN1OeT2plIetJzw6H1PY0KFgMKLLpkN3/HLpY60miWlUpMqdxx1H6WwLrvO25QmlGxf4EhgOROKAzbUrL4nmqv/bfNbzfGO8kVslisv5GuFKp6VElaUaAgVVOtP/BJ2A+vNaCY++0jG3bukg2FdbJjLaFs1ty2JhODG+AMZw2BkmX7gN7HbR/AY1zy+Oxf30tQW0/6b7G9tV+KOFqkV72qDuIOf0jeNStF2Bjr2YxGC7xBptl+mpjipPvNUMRBb+fzd3F6VKw1m/hvMHFMRF7mT9E5utAakx0gZtmDxh+BvfP/V0DNALucZMCpLWpvB4YiJmZiTc+nsR2hjltMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJcDvYcmWNOkbeRfQkJXiVPZ4gPwIjiiW+GryQ0YH1E=;
 b=IdwXL3OXcnxfygTt/sDx9BVVBZpv8keseQWBe9z1KAXrfwgyNGBkxfETdddBKvfNXv7CcrUnbs0wOLSOg0siOpkZzqsJ2HB5XtR+AsRH3oLLbQE92Pi8SWkYNovhDnw8M1/w9d6PaJMt87r8cD/br/OIyPJwX5mqwfkmihs1knI=
Received: from SA9PR10CA0020.namprd10.prod.outlook.com (2603:10b6:806:a7::25)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 09:29:38 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::50) by SA9PR10CA0020.outlook.office365.com
 (2603:10b6:806:a7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Fri, 13 Sep 2024 09:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 09:29:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 04:29:35 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/10] arm64: zynqmp: Use generic spi@ name in zcu111-revA
Date: Fri, 13 Sep 2024 11:28:50 +0200
Message-ID: <394cc43935d41eea3cfa4e3745edf495009b98d9.1726219714.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726219714.git.michal.simek@amd.com>
References: <cover.1726219714.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=743; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=G9HTnxEnBsmB8g56eZN5niI6NKuzMVgd4IyoiDRA8Jc=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQnrOfvb7w1vdJT7PFvtosPTi1922B+6utzpireBGk9v
 1kPFa42dcSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJCF9hmF+7VM87dbrck9g7
 r+0F/PrDSpYF8gNFmfJnLvK91n390HF3qxzrOzJWxTIA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 12280dd1-581b-4d2a-fcbf-08dcd3d69644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aDWj4+7fmrIc8MKo4ejXDBuUkTt2Lzg2w8V8GwA3jYn/YRHqT0nL5g+GsMjd?=
 =?us-ascii?Q?xTdqyGIn27+SrnzLhK6tBmaIT1r+9hebzYoXP/sWBHh4nw1bIm1ezA0PkIj3?=
 =?us-ascii?Q?ftPQwu36hUei+j8anKbio7hFFIqqJ8/faQz9hM2TDYWfWENPyz6Mu6IpP4D9?=
 =?us-ascii?Q?YlvVwErEjfk19N1xIx3c0EXnlNCdTWhEv6Qu49qPR40Nh2Sej/rS+opO1Ktd?=
 =?us-ascii?Q?zWJRRMK55Pgn82rvvcJxABxjLM+Sk8dZRN60yqflFzZ3O3zIRnMqZluiIneG?=
 =?us-ascii?Q?Wyd1o+ukMFzaUetYUnWv3cg5LzAF+QbFOIEVrRI0plX1n55hGDM21wJM3+FF?=
 =?us-ascii?Q?WjGZe//bYgQwwga9HXoKofMkTIYwWOrtOndiwSubfuUGt2+zLJWi3gn7nwLa?=
 =?us-ascii?Q?SMZoaoGGJeouET7AIEgJGK7TfBDk3+diUUs4KQS/9n3BX/SDDdOEjIT0t9X3?=
 =?us-ascii?Q?lfMjo9bSJHpD2VWEntrG+6JbjbXByLePX0sX3dv238PHondrGh0R+IHIINXO?=
 =?us-ascii?Q?06UxlB66KDkGzVNP7Stw2798PSsnsZkujWEbhQbhcOZ0AuB52s73CAH/JCHW?=
 =?us-ascii?Q?YTsYfk2Hgfbq1uX1LCpAD0cZX+1gZF7AQ5KFkuQSopoSuSsWi+SYG5piiDYz?=
 =?us-ascii?Q?gZYB8/xvIUzIJDtdi7QCY68V99b1FDSA2PyzIwd7iCeHQ7IwqjxBEKvRpuzU?=
 =?us-ascii?Q?HfHg6V2wMrLQG5FY8GnoKgl6Z3F8g/c364i+Dn027OaP0kHcfrthStIyY//M?=
 =?us-ascii?Q?HrQdYUmno8H7eFOGt8iUYnYsitLIWdlhCIA/RyMR18eiTpXMBicI0eiXwiYa?=
 =?us-ascii?Q?1aG3oQxyNEKkCt5wVzjDSpuNagat5w7e4MbItWOexoI24XzHuGoUvY35o1Lo?=
 =?us-ascii?Q?OpI0EX60n9vX+h0sxOHwklQ3DK33Kmg8ye/wROG1aPlGeAJs8i3Ae4twIG65?=
 =?us-ascii?Q?yoY61+EDqobcTGO5AFWzQcpyOm33Fl+WovJpMVIqA69l9Fk4ihSpjppKHSUx?=
 =?us-ascii?Q?D0RJKwFraqfuhSXf1qaRK3/7nh/hANYFcsDEDtxlUNgNCxbhIVappUjk1xtZ?=
 =?us-ascii?Q?8kSaigizMnPNUyB/HRXx1w5JtNI6pR8LC3548plHy1j+4IYFVA8Uv0YJqsXQ?=
 =?us-ascii?Q?Ba3Ab3LWZ2spC3jlQrCpvlef8vve5UTslk2O5IOR/3bL1hTpHlEMgbIQ3OEh?=
 =?us-ascii?Q?vlC+CCrIlZ2aZGZn4p2tszRXkghSbUkE+C2xz9kAAegbGbpWkFfChhvVrUkY?=
 =?us-ascii?Q?Gc6Yq4CG6fgDNZZYhcX/32x5LLftdF8UqbdCNlKGf8knsGfnALhJKSN/APVs?=
 =?us-ascii?Q?aIPuXR4N5Z+DaDEZFE0+5R+d6XSFeVCyY3MRtpD/zRHunr0uVxaTsQcUyfNs?=
 =?us-ascii?Q?guV6pfNQJJVyoHOXN2Kkei17jbF8EBvp/0kzzjWYAPMJqyE9b2EDryopSYyq?=
 =?us-ascii?Q?9NUZTGxQFsM/L78I4+eL7+GSOgmiNCjI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 09:29:37.6552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12280dd1-581b-4d2a-fcbf-08dcd3d69644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
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

DT schema requires to use spi@ name for SPI devices that's why fix it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-zcu111-revA.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp-zcu111-revA.dts b/arch/arm/dts/zynqmp-zcu111-revA.dts
index 787cf0d87f9f..3a1580dfc400 100644
--- a/arch/arm/dts/zynqmp-zcu111-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu111-revA.dts
@@ -494,7 +494,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
-				sc18is603@2f { /* sc18is602 - u93 */
+				sc18is603: spi@2f { /* sc18is602 - u93 */
 					compatible = "nxp,sc18is603";
 					reg = <0x2f>;
 					/* 4 gpios for CS not handled by driver */
-- 
2.43.0

