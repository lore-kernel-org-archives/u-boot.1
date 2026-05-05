Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F99DFF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D3DD848DC;
	Tue,  5 May 2026 14:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wcQEQq87";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B447848E6; Tue,  5 May 2026 14:30:59 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1AB8848B8
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkp8H5KAP8Pt4+T+U7aDRLZlIyL+ykKN1eKq5x4DboMoCurN9V2ULZgZZxqqoawGVSbjH+JcDdgNY/2N8p/+mA0HkGMFgBZXTWkckrysugYwvI57SNM9PyA3tn88ZR0BMU3iBWnfIOhk3V8p/s/Int8nu2aeKymz7ypAlA6hdgE5cc63V6Tl1IeKWm8ekFRm0BrcEgBhvUb0a4GnltPimQ0bxl6vwJ6ALLhDjhHsvcC3T/ZV4nLSu2eAa9E24iUfxnJs63GBB/ePa0c629zck7zQtYlXq6nkvm+wyNybfo7OJcXL2F5T0rFNaWnQXoNWT0mQz2zTveKxEFL9dNoLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqh5p8wmHmfuvyKmm+SuY9ueYvobII1vJ4No24/jl9Y=;
 b=wW+xUhP7w7GtkC7QT+Gi+0hTsjM86eYtE1Y8bpQaPeISf/IxVcdBty9D+XH3L8yDoL+QrPhF9p6zPuQXyyRLJAcT5zexDVSBNdMp70cNSpyAzfS/bZObm7tpPFK3sGchpszkPnX8/ahJk910qp+4yGHHz52A5uwJhA0la9wc5294Ntn07BdqLag35M81pyVPO/uZgniOeOp3pqWoYMo1vLlzMZJFoMeyJL3l9mtJcRFpMehMVc8zaB60wkUUgcG6nM4AoZpJsgTBs+CAXA4/8B2IUnRDwnB4pPN9KTSXVHKfdehaQowq1p4/dkrnDEsSIjEaE8Q+HkQM56DqEn6BwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqh5p8wmHmfuvyKmm+SuY9ueYvobII1vJ4No24/jl9Y=;
 b=wcQEQq87/GrjLygckboT/bbB0kmrgKlCkjtwl1N4NZpGr9sqtjA/F/3Zz2pq6rSRIJsM8/8RhQQ02E1ZjwAvzlvUQAxV+Hoyc3NJ77vspHdp4dLexYNY81GqH6rNsV6xWs9q+M2KAx+zy1FKd4wsTuBq+FxJkiLZ9btmu4eJT1Q=
Received: from BYAPR06CA0002.namprd06.prod.outlook.com (2603:10b6:a03:d4::15)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 12:30:52 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::1a) by BYAPR06CA0002.outlook.office365.com
 (2603:10b6:a03:d4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 12:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 12:30:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 5 May
 2026 07:30:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 May
 2026 07:30:42 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 07:30:41 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/4] reset: Add reset_reset() and reset_reset_bulk() API
Date: Tue, 5 May 2026 14:30:29 +0200
Message-ID: <2a5fee05be84fa1cb333f3ab3db732311da321cf.1777984225.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777984225.git.michal.simek@amd.com>
References: <cover.1777984225.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5472; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Ux1gzPlD4qk0LtpfXuVjY+9ENYPKil8nbMuVwqgd1vw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT+fPTqMdsdjgurg9mYzlXMXT3J1V5aIsn557d/HZEtZ
 1cuXnhtYkcpC4MYB4OsmCLLdCYdhzXfri0VWx6ZDzOHlQlkCAMXpwBM5IwuI8MLVkFRv1mli3XL
 p/azzr7y7FtK2omGoq5OG6XMpEqlr7MZ/odprfzZO/Gpg8turrW9S9MadYyXl7jLnss71OKlcH8
 /My8A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2e4ba2-f055-4c5c-9f5c-08deaaa2255b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 34tSIlsxuPr560wp7umDWPapv8RQ8A1RSUHBAlzQVn+BtE9oOb30mlYOE+PGojEvpEDAZe6HOmA29+gpyHmZRMwiwQALqNFENlmL+JmCZ/CmeygMcW6MQPGRNE8Abdv0pZp8EaoS8nkVcQ/Ln2K3vVefvQboflBslkum1w5cXZRGtaGCfFSSFYbrJRSdug7DlwCzRkP5/xKAkBNfVLRzT0WwKL/x30tEqMAg/qEihaZLJvXwU2xsmSf5NOQcFhEHCsfFu1Cuj8m4O6Bomvl2KURYB75+4jgPmu/IoFWlpQVlns1niGNo/OVAu+Ul1zkRlPeXJc4hhGyFvdHAmTzWJXt8ad+/mxZHN1lei01Zjr+KHBctHJcAyr3dNbADU4TVmKW1/spMfcl6a9npKZsashGayCYLmqyXYNUqkv6TD5HDbFxgvfUbQH7fb8JEW/a+OANCsCzpHlmNSLoEHbHo2wOolAqIQ1xFtjT0HpIlVd7CcEPjmrAfycc7eseJKFwcyeQK9egaXRPg2sFEZ8XirCUQm6gYist9KOOKBr6Ro3ejhGr+AVJuwsNlUkcgJAV48obv7/Rg8GBH8A4GKSxnXBgzwhLzb0PxvXO07ieUrLZabiGK0PmZ6e/EB7ccPUpU1D4Dutak5VDRtH12EvaOOlKROjnLaknFo1WVDTBzqLfsFjyRldH/fXeXxfOqOhbjzLRXrlQm82ataRvRclWnJCsboAyeFXauxwvpYcGOB6w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5E33mpjSGDw/f+iI6DXI2qh3wFXxHpTusG5H26oBJvUITCC4qEhQPXgnC9as8i/TUCxJBmGDTsmn7Di+H04EE/8JyADnfeyJ+jEafmU45kiKkleYnmm+9jvtqRmRSR32hVEgVIjl/WyYSC41KnSXTb/l3I4jXx+moy9mlPs5ZQ4ufiyF4U+5VcRG6MDSEruG5Zyb0dbPOPcM2ZWDGyW0L6sWQwBHX7fCa8wIhLosv3v9VeH2YbcP+1R96m0RviLps5DxiA7OAcAIf6cTv+2J6rLHgIy1XM8BMCNhrKnxdsACGS/AGHwIqeamPWXzmnwifBuxLoHjglLb5yhJ/DZ3o0/RdKOaboWHAdS+T9IX5AW/1hTneLnIkJADfRCURV5BgbM9S4esufl0B23YNT9db5Xm55+zwzRqkhDmxZYydKSisHoRPM/N3lWE/mfeu9Z6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 12:30:51.9992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2e4ba2-f055-4c5c-9f5c-08deaaa2255b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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
---

Changes in v2:
- Add delay_us parameter to specify delay between assert and deassert
- Pass delay_us to rst_reset op so drivers can use it if needed
- Return -ENOSYS in stubs when !CONFIG_DM_RESET (like clk.h)
- Fix line length to stay within 80 characters

 drivers/reset/reset-uclass.c | 34 ++++++++++++++++++++++++++++++
 include/reset-uclass.h       | 12 +++++++++++
 include/reset.h              | 41 ++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

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
index 9a0696dd1e3b..706fcffd234d 100644
--- a/include/reset-uclass.h
+++ b/include/reset-uclass.h
@@ -76,6 +76,18 @@ struct reset_ops {
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
+	 * @delay_us:	Delay in microseconds between assert and deassert.
+	 * @return 0 if OK, or a negative error code.
+	 */
+	int (*rst_reset)(struct reset_ctl *reset_ctl, ulong delay_us);
 	/**
 	 * rst_status - Check reset signal status.
 	 *
diff --git a/include/reset.h b/include/reset.h
index 036a786d2ace..a4a6ea962b2b 100644
--- a/include/reset.h
+++ b/include/reset.h
@@ -320,6 +320,37 @@ int reset_deassert(struct reset_ctl *reset_ctl);
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
+ * @delay_us:	Delay in microseconds between assert and deassert.
+ *		Use 0 for no delay (or when the driver handles the delay
+ *		internally via rst_reset op).
+ * Return: 0 if OK, or a negative error code.
+ */
+int reset_reset(struct reset_ctl *reset_ctl, ulong delay_us);
+
+/**
+ * reset_reset_bulk - Reset all HW modules in a reset control bulk struct.
+ *
+ * This function will assert and then deassert all reset signals in the
+ * specified reset control bulk struct, thus resetting all affected HW modules.
+ *
+ * @bulk:	A reset control bulk struct that was previously successfully
+ *		requested by reset_get_bulk().
+ * @delay_us:	Delay in microseconds between assert and deassert.
+ *		Use 0 for no delay (or when the driver handles the delay
+ *		internally via rst_reset op).
+ * Return: 0 if OK, or a negative error code.
+ */
+int reset_reset_bulk(struct reset_ctl_bulk *bulk, ulong delay_us);
+
 /**
  * rst_status - Check reset signal status.
  *
@@ -443,6 +474,16 @@ static inline int reset_deassert_bulk(struct reset_ctl_bulk *bulk)
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

