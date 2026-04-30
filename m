Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008BBFF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 12:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C858063E;
	Thu, 30 Apr 2026 14:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gNc1esHd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C827880433; Thu, 30 Apr 2026 14:22:21 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C3618063E
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 14:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltCDjrluBQjbAZXSB7RnSniCWmfkr0C7HKVybIAarXNoEySC51QALGtB3tKo/mVQYmPbe6RJi63AE1quP1aUttVkyNoGxSEmsTFeAEgdB7/ztO1qxAuxwnbOHEKzi9sdf3BC8GvjFxdeUJvOAA8zhHRuNcuibxl1Luo1+sGbz2GZQNvSPqJo8wKLui4CGV7V8CO1xXR4CtsIkMfBKlJnqb1yH+lSoQKpdjrfVq6oJ/Q7RDi1Vk7DhBOj+XgrFAYTRxYUt/HmpbJ7DWqX9d1pccjASYSqQ83HEQxsgo6+z39gV7xU6yKdOPeh28r3kHSykxI9geR9DR6HCvIiQSLYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmZrBMQVvnyH74J7Vra3WoO1jNwaeCsb3ZdbOU6iSgE=;
 b=es457Q9BrTxb6J0oAOCUFZI69Ur/m/Z1qyWF7fbPMOCyf3NlXt9pw9Y1Jd6QohuCsTrshu3y78/pPZ7/a2HAyTO0So5+lAZpu3IGOkx0t9V2tGcYZfIuozBrERrnAy/R5c/h37mzCWaSTwAr6Wi4cbojQAAAmQ/Z+Pb+ArQzBS8oH45cyt7ifsZ+Sfx1C6kTyGNm8A2nLHv923MXuWFgfW2dFTLSeitQPgzm+uR6scNy9bV/IrqyT0QWY3cSCeYX1Y/QPb3ogjutxd98RZlF16RpJ1znEBuDes4cN878e07hc3brpmUlVo2UFWdSE8p6XlNOifgz84IyxS49rOCRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmZrBMQVvnyH74J7Vra3WoO1jNwaeCsb3ZdbOU6iSgE=;
 b=gNc1esHdDhX9mgrs6EW72XRhtfrFVOuWD9eFV2L3iakbEIKAZxUVTHK696DfF4L8JkzATa6zlhlZmNM29/DU3tiy2aLUVmTABVATRBbBcZ0wuHTFeoPNopKhuy8kjPMy+NAxTRfAE0PvWH3WW/924ViPIKQrvfzTUoh8jKg7/IM=
Received: from MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38) by
 IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 12:20:32 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:10c:cafe::ab) by MN2PR01CA0025.outlook.office365.com
 (2603:10b6:208:10c::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 12:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 12:20:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:20:23 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 07:20:22 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] reset: Add reset_reset() and reset_reset_bulk() API
Date: Thu, 30 Apr 2026 14:20:01 +0200
Message-ID: <74c8b0830dadc5b7f36c4e2c49a1087a503f7ca1.1777551598.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777551598.git.michal.simek@amd.com>
References: <cover.1777551598.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4167; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=PDesVJMweFQBcX0lSg2ZEZs0PgNxky0WUPjgYx4UDFM=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR+9vjJ/+e+p4M8z1nD661Fd3+fTb737ZHw88kV02pzo
 xl1k26e7ihlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJPO1iZJgieX9LgPmi9EKG
 l1ukreZzSC+Su/Q0MfeLsY9Vsvi272qMDLfFDj/hnvCII3i14r6zT41uZAbem7a/+GTCCyaDMjV
 HB2YA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 73dcad3a-7fbf-4ccb-94ae-08dea6b2dfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0F5MBa846BxYrDRHvdw90g2b+k172znfuP2gpdLnsRdo8WdGCPEJyi9P2GJTxapGoiGJCRbIiEyZWWKz6slbo5ySTax0osH130Qta8cBvK2pCz7kyNaNL9do96j4zA90YkJxlC8aPeufw6utd9HX64OTMPZ9Vb73o3theajhkmOp5GLfD5eyUdDWieoLlftlrwOMPtGa0WP+U3pHmV8pPJx3WYuuIZf/g3sz1K8oMqqA1qRCXP++xnuYo83Urx97sRl3/gEBA5kD77+YD/lcnwexerr68DNRQJigFwF2EPGRzJJ7vpFBsqcSnw9KhanSWmo9QMEnoawmuUVbAiUQmsJ4PPj21bR5vvwpomaKxa96Z5WmKcqX8AxtkFwjTh3uMxD+KawjDJhnbq09/tQBP4EKzkiW7pFlSi3/CarfXP4BNWyDp34wtjpIOiDotx9JnDlJ/25Frcbq2MqLJ+WEOm1pjNUQ+Y6Zpw5qB6N0MepzAaBS88443mitWVcBYfrYE8ATYnXfBy5ai4lbF0MtnX9Tqo7OWgs9UpT9UwRKhizkgcae6+ljr8yFsTPU7/vxDUHtOgC+7/dOXL6szPzZg5E/lo6jBJQawYParczjs0NnSCtKNfdZkSaU2W0rYmq9aJOeUy/dSQKGRooPSNPvq+mUXBOHi7TUD4Ii7PMlWxKSGpoeUUpPkJhntt1jcVr0Q0EDYlR4S54h8F3kshTDzSZnQGAPsU72klNqm7cmVn2G1A1vq8Lt8+0pG0x/IGbFit03FWSkXIvZrm3jl235lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vHbziXNz9HMffPAZuKJB16DWXWChFAs3jY/vgnUPBzf2Uw9KSzi6Nd6YFFobYuWcWykM6xSJGxlm/P4y50N3hNGDCN2H6/nCfiQ9FwwPGcueP+/5JGKXHINSzdY63mphfKHk45bP9pCh3uXFo1r70aeM+4AMUlGkapL5zTBrRicTrDKcN+xmQ3Ahm7Q/ThKTS8XadeUxGDXcg5Y9eHOfeM22ufMvuKfliwJfwt8eDoI4fHdMu24a6W4LDX2O6MZbcAsjfYvAOgRQsxVJ8D4pEACQ6ZgRt9R1nqV04Xysc3C3s+MsRhvAaQpPCX94h6pW5yf9H+hk+UArNOYA/21vkLSZgDfTMqJV1DtVmT4sspS716c7hgGtIDYXT3cgApAqj7eIsO9jLTtq9yTuRU4khCaZjrU02n0VfyOKm2LaPgZSxuHj4B9ZWDqJi9otPJeh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:20:32.2208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dcad3a-7fbf-4ccb-94ae-08dea6b2dfd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749
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

Add reset_reset() and reset_reset_bulk() functions to the reset
controller API. These functions assert and then deassert reset signals
in a single call, providing a convenient way to pulse/toggle a reset
line.

This mirrors the Linux kernel's reset_control_reset() and
reset_control_bulk_reset() APIs. The new functions are useful for
drivers that need to cycle a reset line during initialization or
error recovery.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/reset/reset-uclass.c | 30 ++++++++++++++++++++++++++++++
 include/reset-uclass.h       | 11 +++++++++++
 include/reset.h              | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/reset/reset-uclass.c b/drivers/reset/reset-uclass.c
index fe4cebf54f15..b26712abc366 100644
--- a/drivers/reset/reset-uclass.c
+++ b/drivers/reset/reset-uclass.c
@@ -225,6 +225,36 @@ int reset_deassert_bulk(struct reset_ctl_bulk *bulk)
 	return 0;
 }
 
+int reset_reset(struct reset_ctl *reset_ctl)
+{
+	struct reset_ops *ops = reset_dev_ops(reset_ctl->dev);
+	int ret;
+
+	debug("%s(reset_ctl=%p)\n", __func__, reset_ctl);
+
+	if (ops->rst_reset)
+		return ops->rst_reset(reset_ctl);
+
+	ret = reset_assert(reset_ctl);
+	if (ret < 0)
+		return ret;
+
+	return reset_deassert(reset_ctl);
+}
+
+int reset_reset_bulk(struct reset_ctl_bulk *bulk)
+{
+	int i, ret;
+
+	for (i = 0; i < bulk->count; i++) {
+		ret = reset_reset(&bulk->resets[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 int reset_status(struct reset_ctl *reset_ctl)
 {
 	struct reset_ops *ops = reset_dev_ops(reset_ctl->dev);
diff --git a/include/reset-uclass.h b/include/reset-uclass.h
index 9a0696dd1e3b..3ff665c947ea 100644
--- a/include/reset-uclass.h
+++ b/include/reset-uclass.h
@@ -76,6 +76,17 @@ struct reset_ops {
 	 * @return 0 if OK, or a negative error code.
 	 */
 	int (*rst_deassert)(struct reset_ctl *reset_ctl);
+	/**
+	 * rst_reset - Reset a HW module.
+	 *
+	 * This optional function triggers a reset pulse on the reset line,
+	 * asserting and then deasserting the reset signal. If not implemented,
+	 * the reset core will use rst_assert followed by rst_deassert.
+	 *
+	 * @reset_ctl:	The reset signal to pulse.
+	 * @return 0 if OK, or a negative error code.
+	 */
+	int (*rst_reset)(struct reset_ctl *reset_ctl);
 	/**
 	 * rst_status - Check reset signal status.
 	 *
diff --git a/include/reset.h b/include/reset.h
index 036a786d2ace..cd10596825a3 100644
--- a/include/reset.h
+++ b/include/reset.h
@@ -320,6 +320,31 @@ int reset_deassert(struct reset_ctl *reset_ctl);
  */
 int reset_deassert_bulk(struct reset_ctl_bulk *bulk);
 
+/**
+ * reset_reset - Reset a HW module by asserting and deasserting a reset signal.
+ *
+ * This function will assert and then deassert the specified reset signal,
+ * thus resetting the affected HW module. This is a convenience function
+ * that combines reset_assert() and reset_deassert().
+ *
+ * @reset_ctl:	A reset control struct that was previously successfully
+ *		requested by reset_get_by_*().
+ * Return: 0 if OK, or a negative error code.
+ */
+int reset_reset(struct reset_ctl *reset_ctl);
+
+/**
+ * reset_reset_bulk - Reset all HW modules in a reset control bulk struct.
+ *
+ * This function will assert and then deassert all reset signals in the
+ * specified reset control bulk struct, thus resetting all affected HW modules.
+ *
+ * @bulk:	A reset control bulk struct that was previously successfully
+ *		requested by reset_get_bulk().
+ * Return: 0 if OK, or a negative error code.
+ */
+int reset_reset_bulk(struct reset_ctl_bulk *bulk);
+
 /**
  * rst_status - Check reset signal status.
  *
@@ -443,6 +468,16 @@ static inline int reset_deassert_bulk(struct reset_ctl_bulk *bulk)
 	return 0;
 }
 
+static inline int reset_reset(struct reset_ctl *reset_ctl)
+{
+	return 0;
+}
+
+static inline int reset_reset_bulk(struct reset_ctl_bulk *bulk)
+{
+	return 0;
+}
+
 static inline int reset_status(struct reset_ctl *reset_ctl)
 {
 	return -ENOTSUPP;
-- 
2.43.0

