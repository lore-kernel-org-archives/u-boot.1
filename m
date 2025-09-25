Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD0CCAC5AA
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 07:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC6A7836C1;
	Thu, 25 Sep 2025 09:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k8eNER2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35CC0836D3; Thu, 25 Sep 2025 09:49:44 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8872B836B4
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 09:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU9kyf3hLcVvdg8xxviPtgRcDgkZUHdeg22tG2qurvt7/+/XCnRhA7fAnUyVOU3pkWPBfy7wfbSjCN999Yn+N72CtH4JFVMWwoCifxfw8UEe8zN1u8fp1NfzV7QDoOSTlnEwDUxZ8SxC3hFTQimVcfCovVeTNQn2ualwKZpjDarvuUZB5It/NX6diAfsFioik0SK5ISebontY9N6oGUJY9Iw+10K6Q6rk2ILmViR6I5NsjgLUgC/g6zN3w7pfQBgPSMOfO61s1xQwYB80RViR4grfOLXysSRCh2cpJ/ScWF0jU/wi4fXP9rbK4SBG0j0X5fR8W1ouD+LZwkx7vEuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMb0If4BHurcNMT1zIuMSCOFDFzsmV/Zqyjr0iyfeh8=;
 b=lWP5daazMuH9R6fjn674BGhjhw9CcRpG6+FN/kh46JqKsnOqSPq/IcHsi8GhAEtRH09GvUC9zaLON0lFwGzV1PMmmWc+ZmaKcO8vjZddrfOfDa5ukg44TCTLkVcjhjeBHGCtAkChezs27YIVqyTG3Tp/nMDaIJ/mr0gaN5ai7hTk7lTkE7s5cIEQbpqCgzIgpUIRWSei5/533Oy9Zz30yFSudyCkRh/Rb3Z06G5IEfh55CRmrIQL57hJym0TiQz+DbtS+6MsIEC2H3gxYhhmYI9RiU6Xn2K30BeFk+3+7XKolZSNXLwbqGX0lKfxgY3X3hE5T6rhhWcqp6nl0Gi8Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMb0If4BHurcNMT1zIuMSCOFDFzsmV/Zqyjr0iyfeh8=;
 b=k8eNER2kHlStYFecRWjnblbQjuF5qN8lB5zqn4GvwQz2N0SqT7dyroXiSLoJR6BhGBya81PUYo7iPOKE4wdZzTQ0HAFWjW8idbkRMcBaGiFCdqTldeUxwBOxKg1dIPTephilTCiETkXBAkfT5sUM3SOGf1qbR2wMMJR96JoA0HM=
Received: from PH1PEPF00013311.namprd07.prod.outlook.com (2603:10b6:518:1::c)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 07:49:37 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::2) by PH1PEPF00013311.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 25 Sep 2025 07:49:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 07:49:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 00:49:35 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 00:49:35 -0700
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Sep 2025 00:49:34 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Boon Khai Ng <boon.khai.ng@altera.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>, "Neha Malcom
 Francis" <n-francis@ti.com>, Prasad Kummari <prasad.kummari@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Ronald Wahl
 <ronald.wahl@legrand.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] spi: cadence-qspi: Remove cdns,is-dma property handling
Date: Thu, 25 Sep 2025 09:49:30 +0200
Message-ID: <c6a5b4bfe565668eb3299d5c5a5548a2163b129a.1758786568.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4827; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=QAs0RRxLfTmUU4bvE65k8N0A509aKftP2eqC+dQQ8to=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRc+cKzbGH16XalKwdWF33bv8joSmd5ZOLeipneUlxmk
 vpB7RvWdJSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEVuxj+O/DYT7xg9PZRxHP
 57BXlOac7br24PLd4z5zgr4mbOZdKdzI8Ff8Tqbvk1evtx5lmKyWlrf7+ZolK+Y3bDl4pkD3U+i
 uJ1FsAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ddb094a-dd74-450f-507f-08ddfc0812e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xLCQQE/sgKsJrdFY9TUCQD49EtYURc+vfoGQ6QqReggzxEBJ3v9OVQCyWbLl?=
 =?us-ascii?Q?R103BAo3zA57UyR8TV+MSXw1uuUxxiGX3ftJPylhDAfN+wSb9OywPhFSHFeF?=
 =?us-ascii?Q?v6jceAWSgcO6cb5ft/CQxF7feSkHsMe9EJd3rGZlmDX+QX/OSIxVzpwEMDtf?=
 =?us-ascii?Q?BCVPPod5uReW2z80fIJVrVFwtWPwtJMdBXEz06kvjD7dCRZ3Gi7xDfZkHATF?=
 =?us-ascii?Q?Ba6mj2wgprXDb3KL/WoFzQrYVti7Zwl8+Iqeq26hCzpkie4T/MCvzhlBFtIx?=
 =?us-ascii?Q?1OPo0G4hh9ouEFZzqSfvnMWIgSMmD6zfjl4CE9hykpvJC8rd0D82z0hbAHCs?=
 =?us-ascii?Q?kzdAsP7e8iJk8Oh2tPwYrRyiVEKxslz4lM3RrjlwHqnNXFj7RU2dD9mYhzXy?=
 =?us-ascii?Q?Fa01s7QfU1evQB0B7LLU/jK5NcSgs7w9sfwPT2I+Ev0zyilo11gh3kqKu3bz?=
 =?us-ascii?Q?7NoIktf7IrgW8UttNDe/zH6iwOzZDTw1p8Tc8mATE+AJ4FW0qC4HSD3HAG42?=
 =?us-ascii?Q?7Hrco2GKsuvd0/Q7gd9I96Smy4QPCMidKNXiq20qwAvX16EeXSM33Yu9azKm?=
 =?us-ascii?Q?+nsE6z0GwTFHmEjx1q7hMKkAh2L2cmhR+qhBM7YSqiLe9pSq37BOhxLsZEtY?=
 =?us-ascii?Q?9KpiPak92MoPSJ4LxN38GJ+q2YNZJ4hunllN9ZsQgZkSv3tHiKH2G5zT2wK4?=
 =?us-ascii?Q?CJv3Mu3Qbig7bC2JHqgEKBIOQb8q2AGVVW9b/xzgfzBfA/JcXqluf6Shy1QD?=
 =?us-ascii?Q?99Ucd8a/sv2F2yQMPLs7i+IOQVpG+xTXAi+9L226PA7cKgtkJz32bx+gL04B?=
 =?us-ascii?Q?Tsph4g6bo/cOOhSymzeRlT+IrNIxkE32TpHLO65DOLqIHUuHcpivmIyQcmOG?=
 =?us-ascii?Q?Bqsi6AqeOWeIHLuAf3sJXvErVsuw5g1to7OOcU8RTMH2bRhNamtrRl6WQ1iq?=
 =?us-ascii?Q?k/NkjIuTcbxQEi5/pBlPcOW/h+pSqoKFjAF3y2vEv5oG/yIWxR3CXjhIwD4L?=
 =?us-ascii?Q?ydSSUkVlV9GO/+6VjAHcKp+W0clxgwnAm4NCY52TGpyz3+N6Hrqkc3fYfNtx?=
 =?us-ascii?Q?Ap9U/C4M0b4bvGlFwTHbwC80TlmL78BS1LRwoyQDoC0YgzQlzPMtuh610jxC?=
 =?us-ascii?Q?ecUJP99wtd5D2a53nFzH8ZCe/5j6/9Fcu6w0J0THNGENWH01hv3evXOkedk2?=
 =?us-ascii?Q?m9sVR7NVeueYYPNNypZxw7nkJOxwsKb4T9Ceu8wqRuPTOJgmMkPZiCNKZNmg?=
 =?us-ascii?Q?JjmVt1Yl5BckOJSS/vHnqRqSW7IIRKAMm7mFxPXE4ROhLsWqMPCVrpZmssQK?=
 =?us-ascii?Q?Ptm019KczmrYxaWX0mtvp/YnAiZei3UHjbKyIgmoV9di+N8ZEnmDIfCqwegh?=
 =?us-ascii?Q?pjoBvL3KT5GF5TmU8LGAQPA10yfJbGNOmCqO/eBJteqFrY7I+VDs8TDobXVI?=
 =?us-ascii?Q?gt258Ubf3zOOQbiHl/f6ypSLNXd/xiSe9Aky2NdiqpLodaM6/J/DFTChDRV+?=
 =?us-ascii?Q?EQPwzQkdnzkYzCZ20ZO81Z3MJ1cdbAWRK9A7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 07:49:36.2831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddb094a-dd74-450f-507f-08ddfc0812e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
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

Remove cdns,is-dma DT property handling. Property is not the part of DT
binding and it is also hardcoded to value 1 in all DTs that's why remove it
because none is also testing value 0.
If there is any use case when this configuration should be supported this
patch can be reverted.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/versal-mini-ospi.dtsi     |  1 -
 arch/arm/dts/versal-net-mini-ospi.dtsi |  1 -
 drivers/spi/cadence_qspi.c             |  8 +-------
 drivers/spi/cadence_qspi.h             |  5 -----
 drivers/spi/cadence_qspi_apb.c         | 22 ----------------------
 5 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mini-ospi.dtsi
index eec2a08e7c70..6991f6a51db0 100644
--- a/arch/arm/dts/versal-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-mini-ospi.dtsi
@@ -38,7 +38,6 @@
 		num-cs = <1>;
 		cdns,fifo-depth = <256>;
 		cdns,fifo-width = <4>;
-		cdns,is-dma = <1>;
 		cdns,trigger-address = <0xc0000000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versal-net-mini-ospi.dtsi
index 1c94b352dc97..d2d5ec8e5cbf 100644
--- a/arch/arm/dts/versal-net-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
@@ -52,7 +52,6 @@
 		num-cs = <1>;
 		cdns,fifo-depth = <256>;
 		cdns,fifo-width = <4>;
-		cdns,is-dma = <1>;
 		cdns,is-stig-pgm = <1>;
 		cdns,trigger-address = <0xc0000000>;
 		#address-cells = <1>;
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 599596f9f087..849bd930edf0 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -210,7 +210,6 @@ static int cadence_spi_probe(struct udevice *bus)
 
 	priv->regbase		= plat->regbase;
 	priv->ahbbase		= plat->ahbbase;
-	priv->is_dma		= plat->is_dma;
 	priv->is_decoded_cs	= plat->is_decoded_cs;
 	priv->fifo_depth	= plat->fifo_depth;
 	priv->fifo_width	= plat->fifo_width;
@@ -348,10 +347,7 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 	case CQSPI_READ:
 		err = cadence_qspi_apb_read_setup(priv, op);
 		if (!err) {
-			if (priv->is_dma)
-				err = cadence_qspi_apb_dma_read(priv, op);
-			else
-				err = cadence_qspi_apb_read_execute(priv, op);
+			err = cadence_qspi_apb_dma_read(priv, op);
 		}
 		break;
 	case CQSPI_WRITE:
@@ -412,8 +408,6 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
 	if (plat->ahbsize >= SZ_8M)
 		priv->use_dac_mode = true;
 
-	plat->is_dma = dev_read_bool(bus, "cdns,is-dma");
-
 	/* All other parameters are embedded in the child node */
 	subnode = cadence_qspi_get_subnode(bus);
 	if (!ofnode_valid(subnode)) {
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 879e7f8dbfb8..10c4ad14cc05 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -223,8 +223,6 @@ struct cadence_spi_plat {
 	u32		tchsh_ns;
 	u32		tslch_ns;
 	u32		quirks;
-
-	bool            is_dma;
 };
 
 struct cadence_spi_priv {
@@ -261,7 +259,6 @@ struct cadence_spi_priv {
 	bool		ddr_init;
 	bool		is_decoded_cs;
 	bool		use_dac_mode;
-	bool		is_dma;
 
 	/* Transaction protocol parameters. */
 	u8		inst_width;
@@ -292,8 +289,6 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
 
 int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
 				const struct spi_mem_op *op);
-int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
-				  const struct spi_mem_op *op);
 int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
 				 const struct spi_mem_op *op);
 int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 4696c09f754b..243e29ae1c4f 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -764,28 +764,6 @@ failrd:
 	return ret;
 }
 
-int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
-				  const struct spi_mem_op *op)
-{
-	u64 from = op->addr.val;
-	void *buf = op->data.buf.in;
-	size_t len = op->data.nbytes;
-
-	cadence_qspi_apb_enable_linear_mode(true);
-
-	if (priv->use_dac_mode && (from + len < priv->ahbsize)) {
-		if (len < 256 ||
-		    dma_memcpy(buf, priv->ahbbase + from, len) < 0) {
-			memcpy_fromio(buf, priv->ahbbase + from, len);
-		}
-		if (!cadence_qspi_wait_idle(priv->regbase))
-			return -EIO;
-		return 0;
-	}
-
-	return cadence_qspi_apb_indirect_read_execute(priv, len, buf);
-}
-
 /* Opcode + Address (3/4 bytes) */
 int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
 				 const struct spi_mem_op *op)
-- 
2.43.0

base-commit: 626d2f37e4026622d797f4806625b00c1c4b17b7
branch: debian-sent3
