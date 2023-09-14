Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABD1EDE9AD
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 12:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640818703A;
	Thu, 14 Sep 2023 14:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cLZbvrn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF23586549; Thu, 14 Sep 2023 12:47:46 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ED428585E
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 12:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5m7VgzlOehoXq1sRyyM49z79czragCWLABjFRY1HnWQj6Ydm9bWLjsE5FA9E++zf5HRgtHc0UQDBT0YkFJoRrDzHLKhIS/DZHVQuMsJq8lErzqAdqXOzXCF/7SRsLZQrtzm9AUWFVj5oKIlm578WhXBMyN10ZesRgwRBEsNbpcUX+hl/q82H+I++Xfl+MZFb/k/ZWAeJq+2HF0NzYBKfGIRqm/2oxzNRHjXwowDDnfSLcYntAQdEhsqSbkYRCgCO23HTYx16cZTYmXDaJhdOT2FRrjizU1M//03+qr4AUrRT8h0XDd3we1z3CY2yoaKz7MbEBo+38w6Z5qyFCAo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3R8T3Prgd24ZBGSdKd9xxwcZsP3tBKBlQvCPpqrAhPk=;
 b=Ai4OrOe0MJRycUNrPEZoE7mgUIeuWhI0q7vip5z3q7alokwRPcrjGxklXRA29l67JL33mwi0n3V1YXPsD2ZBtwdy8huTijS47XZR/nMfOWSrX+LhbltQZlQ1NwhAhHRu2KO28nyQJvhqFZBtpRAttdgDsnZQwvjtsZUEawxJegyEdRQz2wM19Skm+4BkLE9lBKzqpAgdSFN4vybaN1EsE36xDPmT7rFp2XBu2xs7+w36fZFEf7sU+f5S3YtVmtRBmv8B0dagbbFaL3PqnKIzd8aHV/+zxIi6fB1HCERCf6BadhaH9Hf7P6z0CVqws9lrj0eNdxhYjIz3x6fddtMn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3R8T3Prgd24ZBGSdKd9xxwcZsP3tBKBlQvCPpqrAhPk=;
 b=cLZbvrn8n49bybSZ2pfWu+RUPHKrNWxuq621SoeFyvM00QWBAkVkBjnDAPxn3ySfKlcKcYK3eUpJMdXEe3CuoYlpMPvBq5LJVp6hB48m4QenuUSm+Eom1V/6MCIgEkApVffLwp88CYy+Oi8i/yVvV0aErYl+nCGpy/rOfKUc39s=
Received: from CY8PR12CA0011.namprd12.prod.outlook.com (2603:10b6:930:4e::14)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 10:47:40 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:4e:cafe::ec) by CY8PR12CA0011.outlook.office365.com
 (2603:10b6:930:4e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Thu, 14 Sep 2023 10:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 14 Sep 2023 10:47:38 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 05:47:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 03:47:37 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 14 Sep 2023 05:47:36 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH] spi: zynqmp_qspi: Change flush cache to invalidate cache
Date: Thu, 14 Sep 2023 16:17:24 +0530
Message-ID: <20230914104724.30097-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: b8eac6cb-f8cd-4a39-9dad-08dbb510039d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0waz2UOG/rd+pj+AsAWABNA/XcBOcAEL0sV6OrP0P9rnMVJgTmcHijX5MS2VtkIlmMecC7jGBxWqhpyQtIxqif5TsBWJ24m/x5exYXROGy76aWDgdDbp1ZHPnW7TvyvUcmmT+px8gcnCLnY2cQW6899+I/LjnHbUWwOTR+eSVcF0i9kS7TcZOSp2p5Jxud3gyhIoXeauiljcrUwQ4LmjeXOYnd6wyNYpGSfWozjaiyFEdVpPTXCmhIP7hGO1boRynTx8nkb2ec6dkAdEtfe2kewmACy3N+HwJfKq+yJPeURu7li21XmeWzSahsUJ9cZiykaStuir4bW4OmxHgtWubGEfrX6DaH5IxJLWxmZeNVWk57AvNLeDm2OC/NCCx9HIQhq9UWonL/b9OseL2ZAyw+nyHYy4zOBvob4f6Ucq9lDeC8hXkrZGsEWV2j4uz4YWvWyhbqj+FES2uojJAO8AFLRJ51GabNT4gSC0moP0LgCcG3+96FWYco7As9dKLTs0wMdJzDI4DFORtiJ2ykLepSxy+yuhkEeTUCh2j+YOnIcTbBFFEfV+xX+I7f/tZHgxHUB0hPYry4KMPrAv/EH3rjgTEz6uTxkt871aH/IZjbI1mqc60SNHroSgJXuN8/+ZBQvCcrIFIyzwB9VyIzsrqYpk4zOWd93UVJ6W3zHFfjlW8PSFk4SuQbUim0fE2WvGR+oWL4ytBeqrBhCcT6kTXhS2euusmC6FiunycMTgzuGe8x2+5OLIf8lfNRu775rVlMD6P95W2tF91VxOkyxdEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(47076005)(356005)(5660300002)(8936002)(4326008)(36860700001)(8676002)(82740400003)(54906003)(70586007)(41300700001)(70206006)(81166007)(478600001)(6916009)(316002)(2906002)(66899024)(426003)(40460700003)(336012)(6666004)(86362001)(2616005)(36756003)(1076003)(83380400001)(40480700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:47:38.6728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8eac6cb-f8cd-4a39-9dad-08dbb510039d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261
X-Mailman-Approved-At: Thu, 14 Sep 2023 14:09:23 +0200
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

From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>

Before DMA read, ideally cache should be invalidated, so that data from
memory will be updated to cache after DMA is completed. But
flush_dcache_range is being used which is incorrect. Change
flush_dcache_range to invalidate_dcache_range.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/zynqmp_gqspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index c4aee279aa..a506d15227 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -690,7 +690,7 @@ static int zynqmp_qspi_start_dma(struct zynqmp_qspi_priv *priv,
 		writel(GQSPI_DMA_DST_I_STS_MASK, &dma_regs->dmaier);
 		addr = (unsigned long)buf;
 		size = roundup(priv->len, GQSPI_DMA_ALIGN);
-		flush_dcache_range(addr, addr + size);
+		invalidate_dcache_range(addr, addr + size);
 
 		while (priv->len) {
 			zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
-- 
2.17.1

