Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6B9CD5BD0
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 11:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5ABB846A5;
	Mon, 25 May 2026 13:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nQMnS08t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9C1D846AE; Mon, 25 May 2026 13:46:13 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8959A846A5
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 13:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kN2IwcV6BfGziogB1Wx7//AH/Ov6tatQ3dBM0pXkUyF0kWGrdZSKA1Ks+0QMalEjP4iJt6AVdW+oo7nbBup4R7v15NLpct7oxj5EyhYS67Edc/vf7Dkct/katuqI7jOAwfd2DNww8GbvtZgD0oCMpBbOFjIWH0hFnTGYK89LVNJPKgQrkQdVFfoIDqJ4y+vRJTukflh8EExz77S9wCxiTe8GxsZPuXdlhch421n9TGCtLDLkDztpdsUcEygG3hG4CPOFcMXXAVWw+PisBJnpCq76Z54LkdgQqEmoivg9VSZbul276k3I71+TvWzLqs2HB0/wFRxhxpmXsq7GFYLlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tky8EvfGkzuO4jySZpyvrvPo+9sR76zj5TNbj2Zt4yQ=;
 b=ADy9X3VlK7AezTr3A3WZBKy2b3dZOuKl97vxQyEkNv1eNvvLlbBzDFa2D41qUS7rkbfknDcH1j4+L0malgo52snjccC/ol8i9Xgz6W8rRolwa8a5aIkiuHJ88sAi8EY+mqpcaDTgdo6fb8MfZOZh+EFxojsoBIdkpfBlEJfni3xpvUzE6MeemHG3XG2Mt/cStIzR9bubRX65/ZRq4j0HBe/t/FU09UUEuVXsLqRQRxBwsqUqD0dhFn7DOz6RZYMRIzSLOw6kLJvV8BtQBnaU/irUBNjDSahkx+zekIIxNOMt2/EXxTBNPR5dqc+Sfsy6TnY8fW/GQO3eMEzt/LQ9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tky8EvfGkzuO4jySZpyvrvPo+9sR76zj5TNbj2Zt4yQ=;
 b=nQMnS08tWne0ivYRtdCLw4eONxYtiMBjJCXsDEjO2DJ46KG1O4T2aMXhQyyaQsZb7VhI7OK+Gd0J7nKmvJVP0NNLqlMvxO4NC5HlgPXPIb6k3RO3zE7Lmus8B0esVECPvTtZDk1x0Ug6GjpaGVZWSqJ2wm8in9J0OV4stC3/2D8=
Received: from BL1PR13CA0167.namprd13.prod.outlook.com (2603:10b6:208:2bd::22)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 11:46:07 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::ad) by BL1PR13CA0167.outlook.office365.com
 (2603:10b6:208:2bd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Mon, 25
 May 2026 11:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 11:46:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 06:46:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 06:46:05 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 25 May 2026 06:46:05 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 1/5] reset: Add reset_reset() and reset_reset_bulk() API
Date: Mon, 25 May 2026 13:45:42 +0200
Message-ID: <55ddd313c9e7b2d4dc79ab36bdd0040f871610f6.1779709539.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779709539.git.michal.simek@amd.com>
References: <cover.1779709539.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6445; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=72v8dHP1Y0IncxtGOC9qbOFPb7jpSrG9GMnK9QBVnVA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSJmBVw2Ru/79t5JPnfDs0bdan7l7LvXHc9XCaqsFfVR
 X662jGGjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZhIzGVGhoVHfqe8+njwNIdq
 4rm50zZ9y3/+eVevwtGYXc+FjrVW3bnC8D/ZRurthH+XH13oPDnDP1+r1nvD1AS73bfK+r4c39X
 g7ssJAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b067f0-ba40-4aba-4a03-08deba533560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|6133799003|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Xt6Si+Htbk8ECt5Q4oRpWU7SEsGTgVshVL+o5zENY6cQvCwGRO7c2utIxJShtuQLwsmAXbZTjDhFrUwZzyIXAhxbwQ53/FmigIkzniexMT36bXA62axgaCTVQqP1B0v8sJKtDZl9yg6JVKZnXJZtc2uOniDojGfqZkI0tmsLXI0Gwm8aXPLBhAYNywRJ4EHTH51jdvAyDFiL38E8GtPV67SS/2cS8TeYTWEZWhsDTh46CHfaf6XsKOI3EnU7zuzOWNihXYjfOjLcozy/t0D4rsHkcPjIALLJ51msmcjLbB6qTKi51nhkmAwI1ch8HYVN5T9Gy3nD88MaPxhz9Wyk9fOIVDzq1CY1QbqZXRr931zNNeSGoT1qOhvjPKkJ39jkM31IKdvalYk4OmnEpoTtOvuTEnW1+kYUXY84++Ggm2MLVWpuJg9PfPmbGcjOSbQvLIfAqm+4YQe0DHAOLAlIf353o7NA/AF6lxngh3wQ1xW8cVWnot7tjh9/KfjMsvkQKkF4VR3+yzWwRtApHQ967WGjyJSy8FW4LzuTkM/QaDJ7J6klW5xC4H7ih8EdnR1yQdFrrc+FtKxeNNDzn77BhYxbylMt4QwJJBVRkgUwnVNgHvehMCa/PI2PCsPXVRQvKPQEMFtJXDadUvy/hs55p0nnAey4WcifpSGyzPRTyg0ZZRWclBjJzH7vqKC/bDuu9oj/aw7srX+tHrH5ZDLVE80bYSYu+2yvEzXN9OkTET0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(6133799003)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ML2zCLjCxoDejOySpL+SD2XOE5vM2I4XIubBs+8Fa8ibM77C8PFTlnMdihRAlUV9LBK9GkAiTuqvcZyhioV7I1GDfmTUHfj9lm6xG5NlFnmboZKhl+zND5kRokKuGmtBkatWU7/SRjSCuKzv3GP33kBR4IXmSRqrXqwEB/k9/QPX2KqFcV9Sqvddw0yA2dg7as3kk3hbrfTHUQgG31dXvgYAo+y8OBgpS9kXsULliQ+5l4DLoALojvoaS3H3P5zmQUBhmdZtan5AM8mHjZlopCmJvc9aopYHvMI/BDSUjdFvZD3qC2Bqyb8hAzz3YrYdmPHV19ZqBwZCFqWWWZEOsVIK5IvUEM2TpEPP6ZUHLGTNU8rx3WTV38NBbj/mCbP3YFDwx5UlMTJUGVZxXWOyMTvN0Y1ZWXi6+Xxm+5ae4geJuYdyd3swNyvUZaVFQgUP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:46:07.3319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b067f0-ba40-4aba-4a03-08deba533560
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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

This mimics the Linux kernel's reset_control_reset() and
reset_control_bulk_reset() APIs. The new functions are useful for
drivers that need to cycle a reset line during initialization or
error recovery but with also passing delay parameter.

If a driver implements the rst_reset op, it will be called directly
with the delay parameter. Otherwise, the reset core performs
reset_assert(), optional udelay(), and reset_deassert() as fallback.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- extend function documentation

Changes in v2:
- Add delay_us parameter to specify delay between assert and deassert
- Pass delay_us to rst_reset op so drivers can use it if needed
- Return -ENOSYS in stubs when !CONFIG_DM_RESET (like clk.h)
- Fix line length to stay within 80 characters

 drivers/reset/reset-uclass.c | 34 +++++++++++++++++++++++++
 include/reset-uclass.h       | 19 ++++++++++++++
 include/reset.h              | 49 ++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/drivers/reset/reset-uclass.c b/drivers/reset/reset-uclass.c
index fe4cebf54f15..c199e3e5da71 100644
--- a/drivers/reset/reset-uclass.c
+++ b/drivers/reset/reset-uclass.c
@@ -13,6 +13,7 @@
 #include <reset-uclass.h>
 #include <dm/devres.h>
 #include <dm/lists.h>
+#include <linux/delay.h>
 
 static inline struct reset_ops *reset_dev_ops(struct udevice *dev)
 {
@@ -225,6 +226,39 @@ int reset_deassert_bulk(struct reset_ctl_bulk *bulk)
 	return 0;
 }
 
+int reset_reset(struct reset_ctl *reset_ctl, ulong delay_us)
+{
+	struct reset_ops *ops = reset_dev_ops(reset_ctl->dev);
+	int ret;
+
+	debug("%s(reset_ctl=%p, delay_us=%lu)\n", __func__, reset_ctl,
+	      delay_us);
+
+	if (ops->rst_reset)
+		return ops->rst_reset(reset_ctl, delay_us);
+
+	ret = reset_assert(reset_ctl);
+	if (ret < 0)
+		return ret;
+
+	udelay(delay_us);
+
+	return reset_deassert(reset_ctl);
+}
+
+int reset_reset_bulk(struct reset_ctl_bulk *bulk, ulong delay_us)
+{
+	int i, ret;
+
+	for (i = 0; i < bulk->count; i++) {
+		ret = reset_reset(&bulk->resets[i], delay_us);
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
index 9a0696dd1e3b..7af090b60b57 100644
--- a/include/reset-uclass.h
+++ b/include/reset-uclass.h
@@ -76,6 +76,25 @@ struct reset_ops {
 	 * @return 0 if OK, or a negative error code.
 	 */
 	int (*rst_deassert)(struct reset_ctl *reset_ctl);
+	/**
+	 * rst_reset - Reset a HW module.
+	 *
+	 * This optional function triggers a reset pulse on the reset line.
+	 * If not implemented, reset_reset() falls back to rst_assert(),
+	 * udelay(@delay_us), then rst_deassert(); that delay is therefore
+	 * observed only on the fallback path.
+	 *
+	 * When rst_reset is provided, @delay_us is controller-specific: the
+	 * implementation should honour it if the hardware needs a minimum
+	 * assertion time before release. It may ignore @delay_us when the
+	 * pulse shape is fixed elsewhere (for example a firmware pulse).
+	 *
+	 * @reset_ctl:	The reset signal to pulse.
+	 * @delay_us:	Minimum delay in microseconds between assert and
+	 *		deassert where applicable; see above.
+	 * @return 0 if OK, or a negative error code.
+	 */
+	int (*rst_reset)(struct reset_ctl *reset_ctl, ulong delay_us);
 	/**
 	 * rst_status - Check reset signal status.
 	 *
diff --git a/include/reset.h b/include/reset.h
index 036a786d2ace..58574b983f66 100644
--- a/include/reset.h
+++ b/include/reset.h
@@ -320,6 +320,45 @@ int reset_deassert(struct reset_ctl *reset_ctl);
  */
 int reset_deassert_bulk(struct reset_ctl_bulk *bulk);
 
+/**
+ * reset_reset - Reset a HW module by asserting and deasserting a reset signal.
+ *
+ * This function will assert and then deassert the specified reset signal,
+ * thus resetting the affected HW module. This is a convenience function
+ * that combines reset_assert() and reset_deassert().
+ *
+ * If the controller implements struct reset_ops.rst_reset, that callback
+ * is used and @delay_us is interpreted as documented there. Otherwise the
+ * core performs reset_assert(), udelay(@delay_us), then reset_deassert().
+ *
+ * @reset_ctl:	A reset control struct that was previously successfully
+ *		requested by reset_get_by_*().
+ * @delay_us:	Delay in microseconds between assert and deassert on the
+ *		fallback path; meaning is driver-specific when rst_reset is used.
+ *		Use 0 for no delay on the fallback path.
+ * Return: 0 if OK, or a negative error code.
+ */
+int reset_reset(struct reset_ctl *reset_ctl, ulong delay_us);
+
+/**
+ * reset_reset_bulk - Reset all HW modules in a reset control bulk struct.
+ *
+ * This calls reset_reset() on each entry in order. Each line therefore
+ * completes its own assert/delay/deassert (or controller rst_reset) before
+ * the next entry starts. That matches Linux reset_control_bulk_reset().
+ *
+ * When several lines must stay asserted together for @delay_us (typical
+ * multi-reset controllers), use reset_assert_bulk(), udelay(@delay_us),
+ * and reset_deassert_bulk() instead.
+ *
+ * @bulk:	A reset control bulk struct that was previously successfully
+ *		requested by reset_get_bulk().
+ * @delay_us:	Delay in microseconds passed to each reset_reset(); see
+ *		reset_reset() and struct reset_ops.rst_reset.
+ * Return: 0 if OK, or a negative error code.
+ */
+int reset_reset_bulk(struct reset_ctl_bulk *bulk, ulong delay_us);
+
 /**
  * rst_status - Check reset signal status.
  *
@@ -443,6 +482,16 @@ static inline int reset_deassert_bulk(struct reset_ctl_bulk *bulk)
 	return 0;
 }
 
+static inline int reset_reset(struct reset_ctl *reset_ctl, ulong delay_us)
+{
+	return -ENOSYS;
+}
+
+static inline int reset_reset_bulk(struct reset_ctl_bulk *bulk, ulong delay_us)
+{
+	return -ENOSYS;
+}
+
 static inline int reset_status(struct reset_ctl *reset_ctl)
 {
 	return -ENOTSUPP;
-- 
2.43.0

