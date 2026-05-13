Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38FBCD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3925838BB;
	Wed, 13 May 2026 11:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BF5dGEBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1213845E3; Wed, 13 May 2026 11:42:30 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7167C8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5YMUyiTZr4hnADEHIugfnY1+URzBeSiAPWUQBDI+c8n/iyh8FXhVoGA9oKmGN/LHNWHYVoste6e5LzWTMzA9IHs9jtPUmaU07epUDgLJinwZbrbViz+RnQJbeFDRy2qMqQDImfbfYfsO5+3F2SQFCGJ7zSU7rh/eiwkXAZSwz3bjiEN4lPVUtKMUbpuxnFg1ADtoglVF5n/8PHFfzk4Eg8NZ/WEMhs63k6M6XgooNAct/+3byqF5XOpm0Bgi1bcNcP5ADWzfqTCYQbYtHo4NEn3VIXZi4PdNM3Ab3LC5sYFV4SFFx4oSL1ylLDv5mhm3fz7Z6LrkKCSw/KDDKLowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGYrPhWmIREqWB9dJJ1tHawAIhIOdO69vyd9+TGBStg=;
 b=B7m/upEL6coP8q2soNBr1KKGPpp7iA6oUtgZvUxqBIw0mcXs+x1MObic+e2N7YMs5UiQKzoqwA7bR0Y3W44RRZvIqofEIjKR6yl3pZeqlB6/u5aC75Uhi/Lw554GXQh/nWlqRP1bqcy76wE8dRXTZ+6nrAlQ1rAfLhofjW+YQFytsZREw8q0PEQYLm0ArfrieyzYxpTTwM+nCrmmaT/HJbYFdSFD8byavJnBx6V9G5OqgXrVgve01tGCP8OIpphEcdIsjdeefSMANF7f5vgGAfcavAzJL2LvSi6kAT/RiMhjoukq3UUD+oTKSOEJWj+ZUcffJcGCymdSlXNcWlmPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGYrPhWmIREqWB9dJJ1tHawAIhIOdO69vyd9+TGBStg=;
 b=BF5dGEBt1t2uTQvUIuL1wL1Bi0IAk14hmneYfVIKYrUhoNkPz+kLeTT+/q25RkLRxQcmLBrtK4GBSYOQKXNkxhGtGy/Hz7XrvqfcJty6haTHny55NX6nSqure1oO4Cem3VTdCKb0pMeHXVsRBxsluAPN12teJIfwSlfLTLCZu+Y=
Received: from BN9PR03CA0958.namprd03.prod.outlook.com (2603:10b6:408:108::33)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 13 May
 2026 09:42:22 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::ad) by BN9PR03CA0958.outlook.office365.com
 (2603:10b6:408:108::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Wed,
 13 May 2026 09:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 09:42:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 04:42:21 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 04:42:20 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/5] reset: Add reset_reset() and reset_reset_bulk() API
Date: Wed, 13 May 2026 11:42:06 +0200
Message-ID: <b8229b9f7b357cf6013e8423831a9af1d69fefdb.1778665323.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778665323.git.michal.simek@amd.com>
References: <cover.1778665323.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6420; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=7PQJPxyZaaQdPN0OrWCS+bxiCKv/haDViT0GZhxOiAo=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSxuJewhl7lnXvr3Pzvin9Ozd0u8DRpUXFXGdubhYJvJ
 U9xu9fO6ihlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJ+Lxn+KcgeG8Hb2h/XfN8
 4RrGlDUr7YU7znw+GLFubfRC45asN36MDBNK/VWLny34qaPxOV17mXzM7pX1rwNuh3VNmWIbbzT
 Xkx0A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 08468141-8d83-4fdd-fe5d-08deb0d3eeef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: p5RrDmsL12A2gfk/URAoZku+mvZWzC+bG05VwJQFb+LNTiSHAhuFKR8XfRpIvcciZWB2Pd1CU2r5hZjG54y4yu/6ge62/IstFxv987dh4h03PwSlRRN90H/EiouXNP5wPTbaIZmn8lCn5l32TP3mxASrL0DyeRJzV38TDk6Usef8QesxfoKnl7tBDc2tbvQCp1uuPNvm8MH1XurOCRQO941Hw0blg15hDNJNFeyiu1RRJjFhz/sN7bBdvHWCkHnIlBc48lhP8DXO0h6tO2vpia1j7n4f7xlF0MoQ8BVQFuQZy+Ot5Zt/EkWsvO4eQVSN4o7bOu+mJS4RGVHpMEZlQLfe6diZrIYlKBorL0RFykxFk/QZP80N/NeqvVtLhoPN6cr69De3GA5YXe782GJWr0fI7YJVLYNqSrfs+Sx4+e3uL1KWFim38Dz0u8ImvngpOCcmNZUkuv6KHAu0T1DDicNhK8dRi5B6+dM1D/RSlojtx3lL4PeBKugd08aWy+Ed3/Q8hjTYsTEr89AWbLPYPxwxcHoeK9ee03lOBtgJU6buwH8QCA5oGYnRz5oOjqvDB2mcOaTJuDLdEfvoePnwWpSVl2Jocb+LpMhKYKDqOwQ9dq8mI1C9XaQ6kokWY5Cb+eSXeS4OjRWsEDYVF2Apt74Q7noTmhCE+NvIzXTeMg/kyuDCmST726sTkbXmWvF++fXF18LvIQ3svgy0g2JlsgE6jII/fv/9yAf0RySblw8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rYjj4sfe2HdemHjW8XZCUALMPMX57Oo+3cOSEODAHJIwAWHZB0yZzFgVAroEZUI9p4GXIpxuEoFfR5MQvr0hnKfYEmDqgKBAm/AeyRZ/I+fsRJbGg3dT4vvipW4jKGR/jPFULvpX1cGNmSoaNpLZxkkB34Jp8CkB2RFqRfLRyC8W2YHKy7FaJXNEQP0bFRse7ZZu8qxKGovhsy9Q3dmr9lG8HmzM3KnVm/LAqGDm8uiOGaIDUAY21xlAS9VHoxsLCgoBYQAwi6aoTIGL9L4xvk1DArG092/4isieEnYCQu3UZG7u22ZWdlsqA/P7+R2InrJuqpcrOiEFRd6VoaouiLYWr14mDHl8wHFXA6Iz/ThrC7KvX5TOlWRBbbHLOg5ESh1P0fJ3Wa7TW9073rpT6606KFA+rhDBszr0cmAoZE4IIWztfOGNlmR5cEVB8o0/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:42:22.6079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08468141-8d83-4fdd-fe5d-08deb0d3eeef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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

