Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7701C8303F
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 13:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CB218331C;
	Thu, 28 Aug 2025 15:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DnRkj28Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB0683327; Thu, 28 Aug 2025 15:42:45 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CCDE832C8
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 15:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbHYCQwxbXvxT8WISHde+t2njihW9qQz/gHRYTbsplCFR1+Y2FdCxoe4n2tO3aSasRR8W9qSnheELikmy7x6oBdN244ArkjxWziHB9CG/n/mQAP/eVBNpAFNnrmonQwIkm5wCiYVgptFtI0H4y73AiMVLrQXmEhennM+W1PfrI/AHSx7nDqxaWvSzoqWILZDjAPyA1NXVs9ba6HJCRMnQDB8m4L/i+ncr/vZX4u/A3jOYk3PIxeQkOmDPK+z2LgUE8Q+pAjUuVcnO5fAasK2Xle0BsWqMIn6qXmTEMyOMMSp/d5R145MNmOOOcSVRasV9lzv6PJHySVBMYo3nHObYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxy1dwdqKf0cN04G+gcQAu1o4sMQIRajTRn2mhbvYgo=;
 b=gtOzeJzdPZYROK2WNFziDDTLJXluYw7nJq/FW6Zuq4AfKya/f255FIC7GxzNCH8s/0uY4C2iutV0EAA21vmS70lf5fxIt2Ee3QT1A2U4v62Gy8SI16R2hrr7pxPaudujj1m4v/dFA22b6v5x8rbxgNxPzCcuHDySSOKsxhag/RlZMvedg+dclFUuo3Ycnwx2269C2JSsjwwZBZKm/nFNzkN/4b2NgWQsPplX9w36cNovaKKAy22iBeb/PJKk4qcY8A6jZYiMi1xN7MjvR7ejnSYOMN2xculy37Yl/wAHGcxOSqTpnGWXRpHyUNHLcdR43VxEyCyI2nN0QEBWchk4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxy1dwdqKf0cN04G+gcQAu1o4sMQIRajTRn2mhbvYgo=;
 b=DnRkj28Qc18Iw7mSxbz/3K/Y76kngHOWkNNk023yURAsdxcbJPhJ+N30imOFhzVJklloWOp3KKZq/HcHHqPfTLmd8kisjSkpI2CjAWJK8Na3BBp7esk/C5f18ZQSRABXPykie6KtcGnkmf0KFLPxKX1/+nQuS++5FGoXRr89fyk=
Received: from MN2PR03CA0019.namprd03.prod.outlook.com (2603:10b6:208:23a::24)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 28 Aug
 2025 13:42:33 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:208:23a:cafe::45) by MN2PR03CA0019.outlook.office365.com
 (2603:10b6:208:23a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 13:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 13:42:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 08:42:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 06:42:31 -0700
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 28 Aug 2025 08:42:31 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Lukasz Majewski <lukma@denx.de>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 2/3] clk: xilinx: Separate legacy format to own handler
Date: Thu, 28 Aug 2025 15:42:21 +0200
Message-ID: <c4d546553d4f0d69ef75fb1132b7121f36dd306c.1756388537.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d383d5fea680b33d2eddbca108c452cee97e98ea.1756388537.git.michal.simek@amd.com>
References: <d383d5fea680b33d2eddbca108c452cee97e98ea.1756388537.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=PSsZXVhertGeOdUeP+zhuLuEddnC63ygXxpF4xfDD28=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRsiDkQLP/0Dcvl7Xpy55Jk9Q2yt681OegT/uZ4itDrJ
 TutlqRHd5SyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEHk1k+M16Qkqhyu3UNr9d
 Ultsmzx3PVpwzSTmd/VlZndBgx2/28UZGc5cWsz/8ar6Qj/Ds/vTZt7srebfkrIlTeu1aWrp2V9
 nApgA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 3003db2a-e580-43c8-ff7f-08dde638bd7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jRtfcJcrolfVSWlAaQ8QVMnXLrCmueJt7WeA1Y5f7Y1Tw0SwyHHeYxxM2mdF?=
 =?us-ascii?Q?92fez2eaE5tdKoOuczmqIP9xGudyS/Qmoj7++yfMa9606O37OILBB1a/bF5v?=
 =?us-ascii?Q?y7ZbL0YYJ7Bc9OAkN6294nvvxVNPZTEU1pIb2Amf9GibivJSuGRkXQNPq/Wc?=
 =?us-ascii?Q?h3Ga4HXFqPK8xaAxzKJCO7njWW8CPusnudzsRp0f+60FDyKPRGP6ljk/y3wv?=
 =?us-ascii?Q?GMJtZkpuJ3mGhdVVVURVuftykT47klC0niwK/LZce+hmUaw7lB8WyQktFRrc?=
 =?us-ascii?Q?GEXDWkmWYxTNoJvUGYM09G13f484uXRaH/p8o9IgMfVDeFXFXos6pq7gkcjY?=
 =?us-ascii?Q?t7B3bS/FxIcHz29b0Uarr5plyc3Xzlssz/jdDl0b4eNRy+Ur4KLeET8ycux4?=
 =?us-ascii?Q?NLwvp8oiLRtUEzIqKxiQk+TPeM5wPUp3/ocU10SOTLkVqbLuYkhktjVms6N1?=
 =?us-ascii?Q?FUUC/+uunW17u6HgABEIx+2ZWrj4LJ3NeclKJMYu9aC2+N63cJ6sHQteQeUv?=
 =?us-ascii?Q?LiAdkqyW2L2gmKE7tHb3EafbAoffIfaCBuTc4aTkF37vl1Zi3Hv+nPOOuJgp?=
 =?us-ascii?Q?oRxz2B+jv4klecRKnsV5paIbDQetz6T3luAh2Ab9T4yWiw33OKhfyTygq8FN?=
 =?us-ascii?Q?zJMgzSX4UO9v5pWMntSx9i9Ft48r4O4AOrLaQA5YpU2cJ3V3cSpxkqrPehma?=
 =?us-ascii?Q?IMczd20VpTlvmJZjLgZp7fT1iA7WFUf0TygDQ+Kwv8exyYPcyg0SFIqFAENm?=
 =?us-ascii?Q?yw7xP9p8L94M0YvFC30C9SurWsl/RQqjU9jxLCxIR58oygkTHa/fYzfbB0m/?=
 =?us-ascii?Q?8lhCkKHxKsyWrcTfIxGe//9zHqCp+RIVB43e37OYnglcy71OJBIQ4oBoA6Zs?=
 =?us-ascii?Q?6yA7gm8mRlgsGWas3Dq+foxcIKgyfT10tuBk82LV4hy3c6vhS3aNXP8lxZJK?=
 =?us-ascii?Q?uYpjNlmIJSvSv2koBr7oPaY9bRYuEIwyxtze13buAbBxmgH32jx4XPkMYpe3?=
 =?us-ascii?Q?hnJewlqhX8ZiSa39aXqZNcChH2EZVcQrr978HAfNIecFB6dRW7tIJgmxrhus?=
 =?us-ascii?Q?u00Mwz1VUl3vRSnLTSOgsDfmftOvm8zwi7bATJg7mufRV66nn9IpPyslrgBi?=
 =?us-ascii?Q?K14BYDc2RNabHc9qpCwW3uZYjazhGUwR8Z8d2cL/7QYo3Irm4nMk2e9UkXrM?=
 =?us-ascii?Q?rai2voI/ywXYEgSOryBdG3sIwYBomRI39YQJ4R0f7cyDxuA50vhy7tkurP3k?=
 =?us-ascii?Q?DAFj4tcji6maNAx8KYIwHF6ZrPyRsVg1QtQWrUvpQAI5XejfLDH+VZv1Orum?=
 =?us-ascii?Q?dgmZHFtpoKctHW3ipZjXSv6uTr/ai1Dfi/JedZJDLgko9RtZ4GUKfEXersoq?=
 =?us-ascii?Q?IsYFIA2gnhzV5Uqzg1t8kf6mGSk7XTXAOP7QbIC/4hxcqdwQCamn3+mQl8z9?=
 =?us-ascii?Q?97bINXM/HdqPrjcXZDw+Z+bVJ1TnXywGAmuDvyZiCAAWIjkXicP+j0J5drnI?=
 =?us-ascii?Q?Zin7jd722aTU6hIsi4oPu9k6GHKRVmSG6QSZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 13:42:32.7815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3003db2a-e580-43c8-ff7f-08dde638bd7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063
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

It is a preparation for adding enhacement format support that's why there
is a need to separate current support to own function.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/clk/clk_versal.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index 116dfc98f416..5c6972d4d893 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -121,7 +121,12 @@ static unsigned int clock_max_idx __section(".data");
 
 #define PM_QUERY_DATA	35
 
-static int versal_pm_query(struct versal_pm_query_data qdata, u32 *ret_payload)
+typedef int (*versal_pm_query_t)(struct versal_pm_query_data qdata,
+				 u32 *ret_payload);
+static versal_pm_query_t __data versal_pm_query;
+
+static int versal_pm_query_legacy(struct versal_pm_query_data qdata,
+				  u32 *ret_payload)
 {
 	int ret;
 
@@ -668,6 +673,10 @@ static int versal_clk_probe(struct udevice *dev)
 
 	debug("%s\n", __func__);
 
+	versal_pm_query = (versal_pm_query_t)dev_get_driver_data(dev);
+	if (!versal_pm_query)
+		return -EINVAL;
+
 	ret = versal_clock_get_freq_by_name("pl_alt_ref",
 					    dev, &pl_alt_ref_clk);
 	if (ret == -ENODATA) {
@@ -772,7 +781,7 @@ static struct clk_ops versal_clk_ops = {
 };
 
 static const struct udevice_id versal_clk_ids[] = {
-	{ .compatible = "xlnx,versal-clk" },
+	{ .compatible = "xlnx,versal-clk", .data = (ulong)versal_pm_query_legacy },
 	{ }
 };
 
-- 
2.43.0

base-commit: a51b7dfc6fec0aa76367114af59a7114b040b090
branch: debian-sent3
