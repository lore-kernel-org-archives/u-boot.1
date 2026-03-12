Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8708B105A592
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 12:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B36A841A2;
	Thu, 12 Mar 2026 13:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LNxckNHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B58A4841B8; Thu, 12 Mar 2026 13:04:25 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E9A84121
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 13:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnFeZspo65NOh+Th2BaPFgH69bpCZxIeZaEMKmgNvDuH99wgl1xQ//gLiFrOdr7Zve9W1/lT2Vww7fEWirYeewSp+OR8PlAHyubC8Epkuegpcc4CKsExYe9yAU68pH0UA+4b7m07C9CT/DhRVlg/vDvyK14h1nARf+YYxWY4B8xpWz/7q9LjRFm+uniUv+BNuf70Fjk4RfJTAwCzcIeESfPAUxrUEp9hb/y1BAdDb862qqGkjC31bNMsFhcu/G+Ouv0Svet7Zw8ux+dwhpktQGSGgK0TKiTPxeSTZELghpEVDf0VwpHBKcBt93pbPEguOP2gstL1dRaoCyPoWgfS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGt7t/lBT0li02BAtD0uTr2OUzif3aMABN1dX2YPFvk=;
 b=Ill/duBsp28cDTiUk7el4crTQq7dwIXSKFfRSnetCUNOSkCjh5XnNcmp2Mm9MaK0aLrb+rWBcOCz8l3rWq8FJbBVp1U637Pk98hi32x9JrxCThy3bYagHXVNH/QA8o//TeMLv6mDHg0yOInvCTQJmhGuznem+yePKyDF2Xc0zu7/JvtmEOoy1hOFqNjtgPahV4Pr2KWxh5AYMFWn8Dpi+agfxEBO8KFhHjTYIcTxxtRV/eXRnPy6PBu0a3/qSpz/N1PjnRK8P+YU21mRNeLBtVGnf7GeHxHv5r27cpYILiOvBeOFAov7+nI5zypi7X1FVrX29m3bohlnss2AKZUuIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=phytec.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGt7t/lBT0li02BAtD0uTr2OUzif3aMABN1dX2YPFvk=;
 b=LNxckNHovILegyKt/vvWXPj+zPNNVqhAvAnBgE9GHn4G07sYQTAeZ+PfNfpL8SIWSk7HPK3bb4g7lq29379qW6OMl8v38cG6CXby2qwn5/azJE4iLdgFfvkPRPs+Mnmsb5JfJfA4zwg3FGDJVlEo6Y0eX4mRiy0G86Dz9KGrZ2o=
Received: from SA1PR02CA0008.namprd02.prod.outlook.com (2603:10b6:806:2cf::13)
 by LV3PR10MB8179.namprd10.prod.outlook.com (2603:10b6:408:28a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 12:04:20 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::85) by SA1PR02CA0008.outlook.office365.com
 (2603:10b6:806:2cf::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 12:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 12:04:19 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 07:04:19 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 07:04:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 07:04:19 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62CC4HCX2778068;
 Thu, 12 Mar 2026 07:04:18 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 12 Mar 2026 17:34:17 +0530
Subject: [PATCH] mach-k3: move k3_falcon_fdt_fixup out of r5/common.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260312-move_falcon_fixups_to_common-v1-1-d7c61bb5a77e@ti.com>
X-B4-Tracking: v=1; b=H4sIAMCrsmkC/x3MQQqAIBBA0avErBPUQqKrREjZVAPphFYE0d2Tl
 g8+/4GEkTBBWzwQ8aJEHDJUWYBbh7CgoCkbtNRGVkoLzxfaedgcBzvTfe7JHmwde89BVPVopFa
 qNrKBvNgj5ubfd/37fp5Fwn9uAAAA
X-Change-ID: 20260312-move_falcon_fixups_to_common-34b602114608
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Dhruva Gole <d-gole@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Bryan Brattlof <bb@ti.com>, Vignesh R <vigneshr@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Chintan Vankar <c-vankar@ti.com>, "Wadim
 Egorov" <w.egorov@phytec.de>, Moteen Shah <m-shah@ti.com>, Neha Malcom
 Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Simon Glass <sjg@chromium.org>, Nishanth Menon
 <nm@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773317057; l=6343;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=tHzhga/A8lhywS/jMf4lcn6bbssSF667dz2i6mmFGYM=;
 b=QFAuQRRCzkIUfoOri9beKdSxPntTLYRuH+WSmU2OuUjoBbnhKB/losKuww7iJk0ZdXwCW2SrG
 6tmRpQN0MRgBOxoQWxQsrYE+VCtDXhPlFj0kWMJuyeU3s7WeI3VQ6YH
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|LV3PR10MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a80fe4-1c12-4661-465f-08de802f7df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0lEM2NK6ngfEJuM75dP6ebGRHzlHcLKNiHrvnTAIr0akqLPql5t4oUJNLmu04v3mLHWOOOIQSSKXt0iprrGpzThlubGTLEpQdlSCWqgTLEF/jwGO3rgssi8CkFfCbrS6d7EsKPfo33J86xIGys0NXeA/FLh45Ls5djbZwAiROusNna3xwwSH5Yl1qAS7cn/8Acy8sUs+7nv2g1OLQmu8QP5wzKbgI342I5Vc8gZV9r4V+Ma6pfqA/pRIU9JokGx/g2xs9hL1F336jFpNM0NbvYP5tpLRAsF7pKWwHcW3VdH/BOCe4OHYkOXuxAYyEhVNqiF6Qaf7gy1M1BAP+CnwM/a+kBNKJhwpOV6GNPKHX80yG1we6QzcPhwDGDFq3I36dXKunRY3TiaCB1QWUzs+il+g77Ie5VvnGypZZszXMS0imUK7uKAY4jTD6rRuipKFH4PT4A/6klV8/PLzmiR8vagGzHm/n/ZQRRbGuV7FQ8JFDXL3i7EZa5TzUI/8IW9udMYWa749gSD44TdHt8qP4ZIPpGtc+UL5HhxuFt0DbhRqjZptCN+kD02cPVNVkg3eor3AriUfgWSTDUYL9dddWBKG4vpoSzD7rjRXNbBrJoCI8KjJTK1lruC35W+pIXMXMH6TMZgA27DcDQoOgdC0Vx7JuZWCjCvujjMx0CE1N5MljoLX3/1oyIMZOq32roj3nCngbmunoxRC8XSiNDdGVjAQ4z6Hx/7M+syUmVcR2uT6ea4SsHZnIjJufilE/Oph9pusGQ9H72pnD1bc58Couw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jAP7/tc/lyZSsfT5WL4xxxkXAvrQ4ZRk8O0s5BzVWDuSrG22drSwbvMAaOSDF0uuC8xOslvZzjN0ehpKPC2NSDliQGyOXt8Nr+wmuz2sIAKkslyOJcS4jbrkLSBBMaioJGZodLUjLZWPIHKRA81EMzH8uGvY2x6gUvr8nMA8jyD1x8y1VHYXi9RHsuXEawbW8g11ewSJPn4kvrJuiyWh7qanXSl/NPuUg4pWdBpBvVIh6mcKn+Jg46oChh1J4ixybvCYKuhjT7m4VbKCkpZRo0QnI2XsZUnVo3yczKVV1YSAapjRUs/kf1BRFeZulRhow/X/x3a+hW2oWysquCu7yYe+1YNaNlXQmuYamZBsDiAGFf3QisNPp+pEUNy7xe0kk5b4lfYrYGYi8i/y08mQl2GlWMPqWYzpqSkKnBXdamQxMtuVVRg3KJAvDXB+nb0t
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 12:04:19.7662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a80fe4-1c12-4661-465f-08de802f7df7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8179
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

k3_falcon_fdt_fixup is used to perform fdt fixups at runtime in falcon
mode such as adding bootargs. Currently the function is only accessible
to the R5 SPL but could be useful for A53 SPL based falcon mode setups
as well.

Therefore this patch moves the function from r5/common.c to common.c.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/common.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h    |  5 ++-
 arch/arm/mach-k3/r5/common.c | 77 ------------------------------------------
 3 files changed, 84 insertions(+), 78 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 2f3df5519c5..b0a75988714 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -457,6 +457,83 @@ static __maybe_unused void k3_dma_remove(void)
 		pr_warn("DMA Device not found (err=%d)\n", rc);
 }
 
+static int k3_falcon_fdt_add_bootargs(void *fdt)
+{
+	struct disk_partition info;
+	struct blk_desc *dev_desc;
+	char bootmedia[32];
+	char bootpart[32];
+	char str[256];
+	int ret;
+
+	strlcpy(bootmedia, env_get("boot"), sizeof(bootmedia));
+	strlcpy(bootpart, env_get("bootpart"), sizeof(bootpart));
+	ret = blk_get_device_part_str(bootmedia, bootpart, &dev_desc, &info, 0);
+	if (ret < 0) {
+		printf("%s: Failed to get part details for %s %s [%d]\n",
+		       __func__, bootmedia, bootpart, ret);
+		return ret;
+	}
+
+	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
+		printf("ERROR: Failed to find rootfs PARTUUID\n");
+		printf("%s: CONFIG_SPL_PARTITION_UUIDS not enabled\n",
+		       __func__);
+		return -EOPNOTSUPP;
+	}
+
+	snprintf(str, sizeof(str), "console=%s root=PARTUUID=%s rootwait",
+		 env_get("console"), disk_partition_uuid(&info));
+
+	ret = fdt_find_and_setprop(fdt, "/chosen", "bootargs", str,
+				   strlen(str) + 1, 1);
+	if (ret) {
+		printf("%s: Could not set bootargs: %s\n", __func__,
+		       fdt_strerror(ret));
+		return ret;
+	}
+
+	debug("%s: Set bootargs to: %s\n", __func__, str);
+	return 0;
+}
+
+int k3_falcon_fdt_fixup(void *fdt)
+{
+	int ret;
+
+	if (!fdt)
+		return -EINVAL;
+
+	fdt_set_totalsize(fdt, fdt_totalsize(fdt) + CONFIG_SYS_FDT_PAD);
+
+	if (fdt_path_offset(fdt, "/chosen/bootargs") < 0) {
+		ret = k3_falcon_fdt_add_bootargs(fdt);
+
+		if (ret)
+			return ret;
+	}
+
+	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {
+		ret = ft_board_setup(fdt, gd->bd);
+		if (ret) {
+			printf("%s: Failed in board setup: %s\n", __func__,
+			       fdt_strerror(ret));
+			return ret;
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_OF_SYSTEM_SETUP)) {
+		ret = ft_system_setup(fdt, gd->bd);
+		if (ret) {
+			printf("%s: Failed in system setup: %s\n", __func__,
+			       fdt_strerror(ret));
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 void spl_perform_arch_fixups(struct spl_image_info *spl_image)
 {
 	void *fdt = spl_image_fdt_addr(spl_image);
@@ -465,6 +542,9 @@ void spl_perform_arch_fixups(struct spl_image_info *spl_image)
 		return;
 
 	fdt_fixup_reserved(fdt);
+
+	if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
+		k3_falcon_fdt_fixup(fdt);
 }
 
 void spl_board_prepare_for_boot(void)
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index e970076d08e..466ad22f895 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -61,10 +61,13 @@ void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 int shutdown_mcu_r5_core1(void);
 
-#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE)
+int k3_falcon_fdt_fixup(void *fdt);
+#if !IS_ENABLED(CONFIG_ARM64)
 int k3_r5_falcon_bootmode(void);
 int k3_r5_falcon_prep(void);
 #endif
+#endif
 
 #if (IS_ENABLED(CONFIG_K3_QOS))
 void setup_qos(void);
diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 03638366046..484d96f9536 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -406,83 +406,6 @@ int k3_r5_falcon_bootmode(void)
 		return BOOT_DEVICE_NOBOOT;
 }
 
-static int k3_falcon_fdt_add_bootargs(void *fdt)
-{
-	struct disk_partition info;
-	struct blk_desc *dev_desc;
-	char bootmedia[32];
-	char bootpart[32];
-	char str[256];
-	int ret;
-
-	strlcpy(bootmedia, env_get("boot"), sizeof(bootmedia));
-	strlcpy(bootpart, env_get("bootpart"), sizeof(bootpart));
-	ret = blk_get_device_part_str(bootmedia, bootpart, &dev_desc, &info, 0);
-	if (ret < 0) {
-		printf("%s: Failed to get part details for %s %s [%d]\n",
-		       __func__, bootmedia, bootpart, ret);
-		return ret;
-	}
-
-	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
-		printf("ERROR: Failed to find rootfs PARTUUID\n");
-		printf("%s: CONFIG_SPL_PARTITION_UUIDS not enabled\n",
-		       __func__);
-		return -EOPNOTSUPP;
-	}
-
-	snprintf(str, sizeof(str), "console=%s root=PARTUUID=%s rootwait",
-		 env_get("console"), disk_partition_uuid(&info));
-
-	ret = fdt_find_and_setprop(fdt, "/chosen", "bootargs", str,
-				   strlen(str) + 1, 1);
-	if (ret) {
-		printf("%s: Could not set bootargs: %s\n", __func__,
-		       fdt_strerror(ret));
-		return ret;
-	}
-
-	debug("%s: Set bootargs to: %s\n", __func__, str);
-	return 0;
-}
-
-static int k3_falcon_fdt_fixup(void *fdt)
-{
-	int ret;
-
-	if (!fdt)
-		return -EINVAL;
-
-	fdt_set_totalsize(fdt, fdt_totalsize(fdt) + CONFIG_SYS_FDT_PAD);
-
-	if (fdt_path_offset(fdt, "/chosen/bootargs") < 0) {
-		ret = k3_falcon_fdt_add_bootargs(fdt);
-
-		if (ret)
-			return ret;
-	}
-
-	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {
-		ret = ft_board_setup(fdt, gd->bd);
-		if (ret) {
-			printf("%s: Failed in board setup: %s\n", __func__,
-			       fdt_strerror(ret));
-			return ret;
-		}
-	}
-
-	if (IS_ENABLED(CONFIG_OF_SYSTEM_SETUP)) {
-		ret = ft_system_setup(fdt, gd->bd);
-		if (ret) {
-			printf("%s: Failed in system setup: %s\n", __func__,
-			       fdt_strerror(ret));
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 int k3_r5_falcon_prep(void)
 {
 	struct spl_image_loader *loader, *drv;

---
base-commit: 8bc2a5196c1c0bb5dbdaca073323da0015a0de37
change-id: 20260312-move_falcon_fixups_to_common-34b602114608

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

