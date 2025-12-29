Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DC9E8FDB1
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 12:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ABED83DAE;
	Mon, 29 Dec 2025 13:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="A3iP9gkS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D7598392C; Mon, 29 Dec 2025 11:48:56 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC938838FA
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 11:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjEfbptJn+1kqJ16TqA/ZZppbJre6oFp1OGBMycCEYbojCVUCcji0JGZ/nSwIpC5tGCN8/QT5V0ChaDxurdlWQSNarPiIPtmzKLKKuyu+5PcM+xJVaMbNyskr0G7C2r4OaBAdcc3Cg2SQOqd0CLENvgEKJHLdIKunvda1W5Wp2bIX4rXqnfYx78OtvlfYGglexZplXAIK1URtH2Ho5417PZtPM+VdiKSf06Y3a5zU30e1ik/8/KE8iD1vIkHPYQ0lLXfT12HHlkMaJLOP1qwLm1qD4dZNUjec7CbWp6e4oGTvbHqOpWeDqu3l4OGH6bQ07+KBSuY0hu2VM8MBK/aZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVglLwOsEU4nL1uhy78gu9msi7vx7qs0JxUGRZEOjLs=;
 b=TANXdyRDqmJEJTKtegWXI+eESKuvrmpcQIRF24/G9ZpyGSjXnOd1Tx9QxX7mh8hC/B+YjyhXHK1nKVMdRPtpYNa5Uck1AIjpQAf4cK3W9a8ZD9g9clZvP1Z0qstNvMiOFMhVhC7LICOkOG/0yaPYk8uPyareesrnlomw5+UhOwCff5gGck4jKhSALYbzN+22346c1TkhEJgqXs+PdqPxmI2TQdp0tKJ/b0PnP0eqaKL7WqjcJa/BoATfdioUGgGWsL+LbQjwOf4J4tiyVxKLughmLa/wmtPDCX5b0ytY7hT13yhWomYwaCHLpZVoX1k08adeVj5n4FBXsadgpI/LEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVglLwOsEU4nL1uhy78gu9msi7vx7qs0JxUGRZEOjLs=;
 b=A3iP9gkSM8q50dUNmnHiCNMwtEdVQGimV0GCqiInnIAIHfel6eehDs1DpC2mn5Hho6YnNL2qsFBAtlR522f3/gcx+GJ75981d7jP1l4CTb9Ol4PDZL0JstTUx3XL9snCyw5ymn1cWa0pjSIYSRVfZebT9VqBFXOA1XsQT61gFskwIy7jg/DHbsbn9Z6b9CJ/80UamDxkmSCQewsR+ejs/pH1dzgX+iaFpTNvbh9oDadNhM6y2Pk+fK+P9pKqEHGFFCQ2G72X60Wu9yVUzsTR71u+aZ7GABAkhdQp6y2WLqGK1PYZbpL1mwRHfdSnUCKAxbZtvgyiwLdMtlcx2T+vTA==
Received: from PH7P220CA0179.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::27)
 by DM3PPF4C91930AB.namprd22.prod.outlook.com (2603:10b6:f:fc00::e1d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 10:48:50 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::90) by PH7P220CA0179.outlook.office365.com
 (2603:10b6:510:33b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 10:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 10:48:49 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 747C1E8F49;
 Mon, 29 Dec 2025 12:48:47 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v2 1/7] video: imx: ipuv3: remove undefined function
 declarations
Date: Mon, 29 Dec 2025 12:48:01 +0200
Message-Id: <20251229104807.3104-2-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251229104807.3104-1-brian.ruley@gehealthcare.com>
References: <"CAOMZO5DOUE2PexcBcVcg3vYTo5eV=LT3=S9cSBosLCyir8Kw5g@mail.gmail.com">
 <20251229104807.3104-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DM3PPF4C91930AB:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f2088b61-02f5-4563-743d-08de46c7d9b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q+cmjkyXZlobefzW20vtVbRnEb7sww9x6G+FmxdNcMY2Y5xO/umAvx0ZhfW/?=
 =?us-ascii?Q?5bwMdqCDBcRurWeJCaj7KGiVbdbvrqWu2vlVC6hfb9biYmmaLvnrlEaxFZLL?=
 =?us-ascii?Q?Pk48k3LdTh36HnB7la4nscyB141zE791d+oblZi98CzG11XoCgBxejZfP+L8?=
 =?us-ascii?Q?zPtimBXek6Z/TrCP0FdI7XTEdnvAn4HxuaPDWSnNrO7/xsp5bObhZoyK0J2C?=
 =?us-ascii?Q?qgNET/4vgV2q5MJmQbyRrFzmS52Ca4xHBrAuVDsmwPEod8GV7Nrw9y2fOOnR?=
 =?us-ascii?Q?0M6D080lH/qNP02IWye1ZhHrWEcyi3Kwn+RJ4Dny95U7BMa7JF0t6LmkcfN9?=
 =?us-ascii?Q?/BNJ4vrcw+fTRGCvPV/htxBAr3AZfDD3Kz2QrHWiNz9EH2D1RTxlyx1/4peh?=
 =?us-ascii?Q?NWnoo1nraKj1VAF60SJAnKRQBcBvmUZgk54ofBBFHc75xhG6P5b4KqT2J+Eq?=
 =?us-ascii?Q?cRpvtFHpVMslqqWShQnr1OqBUKfX8sSI4PiblMMoV9GWzBa3LxMqT9cnWuCj?=
 =?us-ascii?Q?xWZ5YE8Hhq5XhMTstIqLhD3AICk4DzH+K3IyybEcVXmAwR6WiBF426kKppjZ?=
 =?us-ascii?Q?6Uqa5mXMDR5Hq/k0NbfDLthki66mJ2ymIgaq9BWMLwpuTtncpQBa61LN0und?=
 =?us-ascii?Q?34/SqYJ1QSR7fo7vGvk9tJU340tPlk0Pcd7b4JFiS63za0Vci4FgoT1zsqck?=
 =?us-ascii?Q?FMthldFp5BsAuUujZe9W5203gfIJ6iNAp37om9804lkNlg0No6BfU7e/YHMu?=
 =?us-ascii?Q?Tb4KfOaQagW428GIwUQ5d2dgJxqrXygTLP3iI60EE94Wwl/mty3J2Y1Imc8V?=
 =?us-ascii?Q?MUIZNh7gpHnS5m010qe1fnNdk55Zq+MEKJwpq3RV1X14Y45v/9FU8YnWAEbt?=
 =?us-ascii?Q?zFWNh8DRtgOhhfXz+ofXeBPBUEGXfanbi0S9pHcZ5HUweBwH6Mi4Ba8fyJWY?=
 =?us-ascii?Q?abeEqZ65YFMJAm3tCknfIb6TiY4SIoP0JrPy/kCWD9kykiv/w2pdIrwROgUv?=
 =?us-ascii?Q?qoLTzJTIUddOwbb1ZTZ+S89pbCIgEORjCf80KaKM6XJ+FwQwMQZWRyO7mDq2?=
 =?us-ascii?Q?Kwc+x69eMBDrJgWi70G9wuc+EcNI2A0TEyeFZ92eQJ5b+wAPpXrJC+TailjE?=
 =?us-ascii?Q?+s1T1RYWb2z3h8g0+wNkDoE4ehekoSgMyDeUT93+6hqUZGB0gKWMzM9gmr7+?=
 =?us-ascii?Q?X8gI7E/JbYWshDD51y8/H09FMfXbeqQgX9rFSFkSJmyvDEIRD13rYV9ghLg1?=
 =?us-ascii?Q?MfdBD9X/fZ549yyECCFFvTFC5VXcyiArK/SeHO+jnMhTNmPVPSeWmasc5zK+?=
 =?us-ascii?Q?idnO7caJVZMn+DnPC5YGZmxTEYK7vBL+VKq4zr32WjMiX4GB1yyOuhfi3L0L?=
 =?us-ascii?Q?X00FKINCfhC2CebuP58Kry7CZ/fpeYv2WcxdwtUzZKI03Ff4JuJMLVGC8x7p?=
 =?us-ascii?Q?zY9oVepbBvPgQOnlLdEnvYYvXSAMU6fj9UNaPRcbTJlo2N0XjUCNArjvXWGH?=
 =?us-ascii?Q?2Mu18FlzfCBV1MCXRSfog9ZEI3e7KNnL+qvhQm2I1BuX8qcFEpbm8gsTilb4?=
 =?us-ascii?Q?8a7WNc6pSWPm4uq9J4k=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 10:48:49.6551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2088b61-02f5-4563-743d-08de46c7d9b7
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4C91930AB
X-Mailman-Approved-At: Mon, 29 Dec 2025 13:40:49 +0100
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

These functions don't seem to be defined nor called anywhere so remove
them.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

(no changes since v1)

 drivers/video/imx/ipu.h        | 4 ----
 drivers/video/imx/ipu_common.c | 8 --------
 2 files changed, 12 deletions(-)

diff --git a/drivers/video/imx/ipu.h b/drivers/video/imx/ipu.h
index 4c13c9342f7..93bc97e6300 100644
--- a/drivers/video/imx/ipu.h
+++ b/drivers/video/imx/ipu.h
@@ -215,10 +215,6 @@ int32_t ipu_init_channel_buffer(ipu_channel_t channel, ipu_buffer_t type,
 				dma_addr_t phyaddr_0, dma_addr_t phyaddr_1,
 				uint32_t u_offset, uint32_t v_offset);
 
-int32_t ipu_update_channel_buffer(ipu_channel_t channel, ipu_buffer_t type,
-				  uint32_t bufNum, dma_addr_t phyaddr);
-
-int32_t ipu_is_channel_busy(ipu_channel_t channel);
 void ipu_clear_buffer_ready(ipu_channel_t channel, ipu_buffer_t type,
 		uint32_t bufNum);
 int32_t ipu_enable_channel(ipu_channel_t channel);
diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
index bd1ef0a800d..61a3fe1e83b 100644
--- a/drivers/video/imx/ipu_common.c
+++ b/drivers/video/imx/ipu_common.c
@@ -1249,14 +1249,6 @@ ipu_color_space_t format_to_colorspace(uint32_t fmt)
 	return RGB;
 }
 
-/* should be removed when clk framework is availiable */
-int ipu_set_ldb_clock(int rate)
-{
-	ldb_clk.rate = rate;
-
-	return 0;
-}
-
 bool ipu_clk_enabled(void)
 {
 	return g_ipu_clk_enabled;
-- 
2.39.5

