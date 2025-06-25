Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C1CC77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 05:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6783B82B18;
	Wed, 25 Jun 2025 07:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGyYJ0ko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 305C182C84; Wed, 25 Jun 2025 07:26:57 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1E5682977
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 07:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srUjkRy21JcRY9ZbCDXzf9dBULsETSPQxKEGay+LD/6yBoCaKmN6xb9Jyyhp0tC3+2mNgl7mNXHpo3lT2oIy9KYSXwQF4D3pUJdoeoTfPp0iQpt/yoV6wtf1N73qIxYnZ3+xWnusgmGe2B2MgbV+gOEP1hARcj8zQMx0lvg2N6EHn5nXJf8PEZ7gYD2iC13XMhO3K8LdaC3L3fkT4tdwUMpg/F3WcJctBfiGCXbjWa4Dp64POdZIPvhiXk1UgmgvzHQeElWog/viYvLByl5AvmQINllgpP/Z3OCKnG4nne9mMrRQwDUZceszufk8MklTjhotwbYAIMEMJ7EacHExyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqz6BvkB+PpkhyD02RsIWHUQST6MlisCgeoOAMBMB4M=;
 b=srZNQ1DVASdcLa8hVYQNaCw7twxuDuyltVzwxczGrVp3fbInSVySS4q+x+KhGYsNkYQ96feBoA0iYnSFvZ7DNVK8MnjHmFXTr/lpPmi7f/NhR4LYrRNxUXxRcOTbEviPyVVB0shas+Ijo04YIxcWfkjYrBWhCUOArJ6hszmsQtWctj6kRWC1fWEYQgtNn+I/RNE/YWwXf3bd/2oqyT3EivEjp9G6ZZXJeWXmgcRtAVZv3vi3FYF3arFzMvLsP9/7myh4eK+VjrPR2KVsjI9pbgq5Mmh4qiu/nQwGFDfrnhaRl+M1bB+POIbVbknHgrWZuQCexx3O14Clm9o1FEBmwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqz6BvkB+PpkhyD02RsIWHUQST6MlisCgeoOAMBMB4M=;
 b=ZGyYJ0kopVI8877aXWwM0qxdRhaeNsxgs5Fe4mC4MTLgSkNrAib1E2vIXdPZgw9Qfm7JRhKSJocruzYirK1Rd9TSuRAmTMW4N6oKn0J5GS4mW8cbHCXnMqRJ6xSXHXw8Ygf1C0UcN6TyBK5/PyFozy1FwzGdC3/O0Jucfv7sZIY=
Received: from BY5PR16CA0016.namprd16.prod.outlook.com (2603:10b6:a03:1a0::29)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.29; Wed, 25 Jun 2025 05:26:50 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::d1) by BY5PR16CA0016.outlook.office365.com
 (2603:10b6:a03:1a0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 05:26:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 05:26:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 00:26:48 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Jun 2025 00:26:46 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <peng.fan@nxp.com>, <jh80.chung@samsung.com>, <git@amd.com>
Subject: [PATCH] mmc: zynq_sdhci: Reset the host controller
Date: Wed, 25 Jun 2025 10:56:39 +0530
Message-ID: <20250625052639.229461-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: fd863246-4210-48eb-2ad5-08ddb3a8e301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JTTB8Awg0MqYBH1Zk1w3lJSbwsZvp/bQWF3GR/RDe6lxqSFVLJjZVBxGGqSd?=
 =?us-ascii?Q?CpKZEfRXr4sFzKrrEh5ILwWj36GTvOeh0Oab2ayuA8lfSnNPTTo8kogDjlkX?=
 =?us-ascii?Q?FHdAU+hgIB31EY8HIdFpaQSvJPJZehxsRS0E68bJ20ZQW60QamqCyansj6NI?=
 =?us-ascii?Q?sivThLUdXo+X1QPGiH1BDGwhzPgLxcfPCY3MiOES8yu/bBuChe6OQT/ZH9pO?=
 =?us-ascii?Q?zruoxwMsKLhOZSNwUilxRUUrFH+vhiNauBjvpU0yjLeEkpt+n4z3oxIvicA/?=
 =?us-ascii?Q?vcyxcrAdRlfuYyOOrbY5Gm6VgDZxEBKU+VIVN9nJhiqJEHBiRwkd8Um7dg5b?=
 =?us-ascii?Q?THrO0htf8LaM0XKwSAvghHvS/c7D7mVXdwnvibpkS+ZGzVIuz8n/lPD45nZZ?=
 =?us-ascii?Q?hReBNZ/WqD6L02wOQ4AL3Btt7JwFA2NvQMdgqPCpypOgu93PkEKs+EWC0uG8?=
 =?us-ascii?Q?RVAAweo7QBwXDmpIfK0X9zoGCyU0AYPgBzG/eIlaIs23us/+dcHdvdlwNjme?=
 =?us-ascii?Q?jILeznAASouamOJDiQDbWZl6bkE+NYb82PK5phxCu3KI9tYQrlSqoA42gqKD?=
 =?us-ascii?Q?2oYT77V75DGppyOrTBDHnT/txTlhmuQ/injHt0XIPBx6GSwdblxyp5H1191x?=
 =?us-ascii?Q?r2RBDkcT0ArqJZuSUCsLSpd6rmlbyoahNhumpn0y+V6A1fI2KnYwoHnVPFe0?=
 =?us-ascii?Q?/riyjpc12PPuLoOweQUuD/ZrpRCmfv0R0CJ5Mi8FG2Mcy0iFmZIbHOi/6sAz?=
 =?us-ascii?Q?50ybER8WLP2iRvR/tET4ru75KIQ4k/c1vf2iKt1/iyU17qVljNuB/dbD7IgG?=
 =?us-ascii?Q?jo1o7lUBnoMOecu9uLqfdE+NdQkcGfxUfQXb5VpBjwt11DiVvKF2TRPPW57i?=
 =?us-ascii?Q?/nRnKH0mdn1qxWsCZ3StOKjoq3EQl/n8idj2jzapBgA0f1LXTwUoUUJXbemX?=
 =?us-ascii?Q?8V8xSyBoj00mhkEBXXO5usnA4VgMj7KZVOgBi7tWyRMPiyfKWk3VojfKSdk4?=
 =?us-ascii?Q?2i3MMX7wKlKkWrAdVoVbghKlWwxxbmkhxMpO+voHI/CqvZAPTkEEMl8Wr3Yq?=
 =?us-ascii?Q?L69Pvg7h5vVRQ2G1ptTuxFTfb8SXu4yOUCVegVwCb8kCVtJep8yXazIZVHKM?=
 =?us-ascii?Q?BdzOC5AcIxzJ3np7abtQpA8y0ZcKsCPTViag0yZmAV5PUVUg727vPO5AAooO?=
 =?us-ascii?Q?suJ+Y6LlD5U3rQ24W206G2PQnov0UC0Ll41gRk4Dev52DVRQrkFR1hmN9qS3?=
 =?us-ascii?Q?xPMTZSMUVJ/C2h6dol4TRFyQItzGfBO+x9Lsc7IisvxM06wB+bV+J0XMU3r3?=
 =?us-ascii?Q?V4Tp0s7PL/5vhtRarVf+SyX0hMIEnh0k/Pla9CMDu4ACSGABXGs3nRRSASmo?=
 =?us-ascii?Q?8piukYVAbxyn7Rv8hlj3W50FRHUusD94Hi11zIli3ZI70QObK8GEDtpfoiO1?=
 =?us-ascii?Q?SY873XREXPb4OspBvJgsrrHcZN3KPteis5XsJdZL2YrwEVgf9/zzXzmP0LdP?=
 =?us-ascii?Q?S+dM20SxAkviWccrwMy1idNhx5bMYZ2KOaPB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 05:26:49.9472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd863246-4210-48eb-2ad5-08ddb3a8e301
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010
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

Reset the host controller at the early stage of probe so that the
configuration will be done properly for reboot cases.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mmc/zynq_sdhci.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index 0e2bdab4e7e..5d797dfd0c4 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -1127,6 +1127,27 @@ static int arasan_sdhci_probe(struct udevice *dev)
 	if (arasan_sdhci_is_compatible(dev, SDHCI_COMPATIBLE_VERSAL_NET_EMMC))
 		priv->internal_phy_reg = true;
 
+	ret = reset_get_bulk(dev, &priv->resets);
+	if (ret == -ENOTSUPP || ret == -ENOENT) {
+		dev_warn(dev, "Reset not found\n");
+		return 0;
+	} else if (ret) {
+		dev_err(dev, "Reset failed\n");
+		return ret;
+	}
+
+	ret = reset_assert_bulk(&priv->resets);
+	if (ret) {
+		dev_err(dev, "Reset assert failed\n");
+		return ret;
+	}
+
+	ret = reset_deassert_bulk(&priv->resets);
+	if (ret) {
+		dev_err(dev, "Reset release failed\n");
+		return ret;
+	}
+
 	ret = clk_get_by_index(dev, 0, &clk);
 	if (ret < 0) {
 		dev_err(dev, "failed to get clock\n");
-- 
2.34.1

