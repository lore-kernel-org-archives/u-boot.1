Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96A1CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 12:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18EC48391C;
	Mon, 10 Nov 2025 13:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qVzr1vgL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94C10839B1; Mon, 10 Nov 2025 13:33:51 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B4A08391B
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 13:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iS6fXwd6fwdxFCUeKRKqjJBgct4kFfBBZqbBVd86vfBrwb8xIAESznoLVOGZy3cRExNoK7Bo9L7A2C5fe76tzggBzgjbaTijYVA/RSMfJtak7BnTRawrFldviMc7gUMsBcgLpOdqt7uM1jB8J6tXBpapMJN59D8xhgpM13LUFE05BKpRC1/1bZ1E/YNgGwFdyAGuJxUHo/0ot9W/xuA1YZAAHMpy+mZB/Js0xVGL2KhTJeYisn7Vr7+DrSQb88dBTA5M25oxq9UyngGRhPDYSeA4sWPIQ0sSJbovPGYaBjBeJQdps5YVu49FpxyJQWNP1lxLzWW/KTICcepJENRpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pabsnaCD+6oXtnhq9wlFp05YjB1XbBKqp44NvkcoEDw=;
 b=Atn5VMx6zDc8ghyMiGmzJqNkWSZa+gviz3VUDRAuUeEuIHUxooT/EdFeHx4QgdcZ8uFWSpI4klTYCrDrIGa9GuBebeb2FSuUIk+V+w6aiGridC0ln90nYOBIAZ8cKAw1p5AWO8ntVMZWfAmp3IBHHyXqijzclPL/HhDEIWeL/XrtUr1t8HfY5xa0uASurvkFD19wN9ueipPxjPyydKxhCidx1n6mNn80dRFE5pzwhYnLpd/0m7VkmFr6vukm0NrAAcEQdMPtiyVWbTR0f/Ug8YXZgytk7kNgIWH5XmaVn919Rggb75/EO+xQ4OqlvwAa0+YBQEWVhsdUzEN87N8D8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pabsnaCD+6oXtnhq9wlFp05YjB1XbBKqp44NvkcoEDw=;
 b=qVzr1vgLx55TAkrZGqKdtVWPAM1yCvJVjc4+ix486P5+cD+5WpXuGPZ6Eo74JkeXbnDz0htVxBemfFUmawKRbS/mYnBcl4XUsA/nec6evbXr9DlLRGBZ6uUdaqdmvRlLBeFUuwf/IFz0cDqMoLXFxqgE7NWlU1P3qgkt6LAUMqA=
Received: from SA1P222CA0078.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::25)
 by IA0PPF8CAB220A1.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 12:33:45 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:2c1:cafe::e1) by SA1P222CA0078.outlook.office365.com
 (2603:10b6:806:2c1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 12:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 12:33:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 04:33:42 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Nov
 2025 06:33:41 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 10 Nov 2025 04:33:40 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Lukasz Majewski <lukma@denx.de>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/2] clk: versal: Add support for CLK_AUTO_ID
Date: Mon, 10 Nov 2025 13:33:32 +0100
Message-ID: <647f1d2c7d274c1106558a655386ef92e0baf2c8.1762778011.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2037; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=BNMHtIdTK36U5pI1eU8w3bZcVsvt6UIOeZ+zqRKeNk0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQK3p7LM+fkPwGRN+Ul39+quH46xxv/7gnL49v+X+qNS
 koEurZ/7ChlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJrP3KyHAsWebUw/2lU96f
 mlvdfeWh9J2N2rXdm7fq3FYu29y3TDOW4Z+ysrLbbPmpl4Mup99b3ymya2XAfpU54hnTZVOXT2a
 OXsYEAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|IA0PPF8CAB220A1:EE_
X-MS-Office365-Filtering-Correlation-Id: e23f90a5-1523-4a9b-29af-08de2055628b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oPMkGYwrMiumM/RbKYwuPiOEqd75sxK26PzmNPCyeWiGOJIzv+hCd1CDEolf?=
 =?us-ascii?Q?FOQEoqNNDPMypX1E2otBekUkHiCjfeZWK+o7pHjtlJSu/4cix+PHaMA+1/gy?=
 =?us-ascii?Q?9DneDXU2pOwIlKqm0ODaipoFV+4Mb9JumGKv2WEhrM5qK61w44sip/0ykMPX?=
 =?us-ascii?Q?p+O454lWnun0PWN14nbJTUnzuMxGQ//4IPcfopuiQ3BEPrYDdOVXyJ9oKZsV?=
 =?us-ascii?Q?J8Hh+d0pB2kbDYEcXnZ9v1DxY5756z6TL1EvFOz/dZbR+bwypXr65DHr1ok+?=
 =?us-ascii?Q?V7LRLwe3LOox9Js37SwFnCFaPGt1yrMaWmUUY3255qzj1zJ7cSHVSZlmd/EE?=
 =?us-ascii?Q?UUYPyPIkrLGY5zAsoxvaG5l4BYFABDl7U3ehW15rb2hjrI1wSWP0TRkkcTbR?=
 =?us-ascii?Q?rAcJoChDvIYCqx36/jr9XanxGeHR1zx2ztlFY175M0dgTbQhqjyD5jhMfjDE?=
 =?us-ascii?Q?CzzDhGWTHV5dDVRVEmbZds31TFsctxgdjZd12FXEkMPAaqX8juLBI8NlZonE?=
 =?us-ascii?Q?OV8Kur8/4dw600HV6Li+rmpCD/EojcSlSi6QOwrkuY6oq3cIiFhJ5Xa3yNNG?=
 =?us-ascii?Q?mkbH7LADrdKm9+IlACODU6Fuq6EwJKWOF476lw6rwcSZZHUK+5xSEY7v3e1p?=
 =?us-ascii?Q?POiIjvs9gtEx6hq9GVfpFdxAEsTwh3yeNyJouJ6c2OlbfeT4HZRwG50yeN5+?=
 =?us-ascii?Q?VcpcUhPdpqnHlmxrlB28M6TwxGL9c2QvCkevJd9+bLL/HuJzgrqF+Oe8Aa2m?=
 =?us-ascii?Q?IWILSNBXvWF6Ps8n/7JUYN1P8cREflyNVogEZoP1aDS9ZfhyhyfHcpuBgsb6?=
 =?us-ascii?Q?BAIwxakP/wzzaPpvxJdNL9tpFCbl6YbLmiJldmJSR4YnMaDhlpk1OizIawAS?=
 =?us-ascii?Q?0C4fx3uOa+cRqSyERD4wiijYz3t+jx/EzBWMtnPXAAO7d4TTkZV4RZPy8cjA?=
 =?us-ascii?Q?/t75ayMDe10Cn7+4sQ/Er/loctxtNjyXfDMLS0CN90Xrj56JNSkOPp9oQwj3?=
 =?us-ascii?Q?ztQBpMCOporV+wXMmHiuM2GZhb6QI6SfuNGW0gVZAaxHlxGgSVdgnRBrRMWT?=
 =?us-ascii?Q?5YlmMjC6j80J5602QnaXAqC43kZs/n363cqpA1PF5Ruu5UcTOZ5EOGn+v5Bi?=
 =?us-ascii?Q?WP/wF2XwGgbOOPimlWml7K4YEwlHTDPXwuPYNaQJbkNkscXLBvq8sLCs6/Ti?=
 =?us-ascii?Q?em4IIWf4Liis5HnASBWFfxAJkWPPT6OBmULt6yY6N7KWzNqPsKkD+nKgf2Hh?=
 =?us-ascii?Q?X2qAEoPYFYy0HKllZgstpdvBnOBgFMaHAVSMTvgX77JGvDB+9zkCGSY2Uu5W?=
 =?us-ascii?Q?we2P5HRA1HszXU9NwzuLhVvaxaMGYT5P3TasKAG65vOlTOPlYPhzg0vUpQzZ?=
 =?us-ascii?Q?PF6BsPebDVU2rJGKYvrzFYlBiAqWw3qCP8JtEzl98f/Bmmh424oLGCRdkTix?=
 =?us-ascii?Q?BLSe26jQOdnJeNZdViZLgV5lvTZE5+7g2/8EWsUA5umeWOzEde3aOb0qcCdo?=
 =?us-ascii?Q?6h19D3NsLbNok+t45AwRYZEPFF7yD4WPnZSRkqyYNyOBcJ3wNc3AmfGRpLay?=
 =?us-ascii?Q?4H6dKyxXS6h/ZK7zxlI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 12:33:43.0179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e23f90a5-1523-4a9b-29af-08de2055628b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8CAB220A1
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

When CLK_AUTO_ID is enabled 8 higher bits of clk->id is unique clock
identifier in clk uclass that's why it is necessary to mask lower bits
which are clock ID.
Also check that ID not bigger then maximum supported clock.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/clk/clk_versal.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index 339676f1e4f4..139f429d609b 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -731,10 +731,13 @@ static int versal_clk_probe(struct udevice *dev)
 static ulong versal_clk_get_rate(struct clk *clk)
 {
 	struct versal_clk_priv *priv = dev_get_priv(clk->dev);
-	u32 id = clk->id;
+	u32 id = clk_get_id(clk);
 	u32 clk_id;
 	u64 clk_rate = 0;
 
+	if (id >= clock_max_idx)
+		return -ENODEV;
+
 	debug("%s\n", __func__);
 
 	clk_id = priv->clk[id].clk_id;
@@ -747,7 +750,7 @@ static ulong versal_clk_get_rate(struct clk *clk)
 static ulong versal_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct versal_clk_priv *priv = dev_get_priv(clk->dev);
-	u32 id = clk->id;
+	u32 id = clk_get_id(clk);
 	u32 clk_id;
 	u64 clk_rate = 0;
 	u32 div;
@@ -755,6 +758,9 @@ static ulong versal_clk_set_rate(struct clk *clk, ulong rate)
 
 	debug("%s\n", __func__);
 
+	if (id >= clock_max_idx)
+		return -ENODEV;
+
 	clk_id = priv->clk[id].clk_id;
 
 	ret = versal_clock_get_rate(clk_id, &clk_rate);
@@ -785,9 +791,13 @@ static ulong versal_clk_set_rate(struct clk *clk, ulong rate)
 static int versal_clk_enable(struct clk *clk)
 {
 	struct versal_clk_priv *priv = dev_get_priv(clk->dev);
+	u32 id = clk_get_id(clk);
 	u32 clk_id;
 
-	clk_id = priv->clk[clk->id].clk_id;
+	if (id >= clock_max_idx)
+		return -ENODEV;
+
+	clk_id = priv->clk[id].clk_id;
 
 	if (versal_clock_gate(clk_id)) {
 		return xilinx_pm_request(PM_CLOCK_ENABLE, clk_id, 0, 0, 0,
-- 
2.43.0

base-commit: 04d178e16e6cf0209efa1b424a86c72067dea255
