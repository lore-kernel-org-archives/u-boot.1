Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA34CD5BD0
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 11:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 148DE846BD;
	Mon, 25 May 2026 13:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="trl+6l1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21B13846CC; Mon, 25 May 2026 13:46:20 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B68F08460E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 13:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QV7bKlsODmg2IXSscqn3l3qdajYuzdRxG7KT5rV3sspuAOpd5+jZ2Jma0DhwmIbZqf/EB0gx54pF1+34+/ECuy/dt4lsU2Hq/A6WK0enBt1TVTc8yAJNjo+ltza1KY75C764iR/Nk0hYffdxatlUZr8HPfKtqNh25G/PyQ4UfsF8XLD13MYUii4Zn3PQkGAhSy9wDVoger4c603g2CVfNahCPcE9aatpCUk8aJn98L6K4x0DPz1HP9532vqNvQth9C15bJ1JO9IRE29tC0hx1rqLvI5ThXd4r4qkcQyTbVwa88tejvr7ML9a5rLvOq0FxQ7wuIM0O0VkZm89NCBP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZyUUYqU8MyaBT6SzU9/mjUDsrVn5TIqkQqwyCr+79U=;
 b=YtZH/rXo5IYxPt62OnEc0FkrMYBPjrsF/R0wxLGowh0WjKbfOsNka119KZmjb1HzXLPoW85qRzznIuG0Ks7bz99tVOwClp+ycsiQmXoa4otZDN5GzZXXkt0oXO/7lfWpEFhe4yU8gzFNcJ5vfVTgr4tL8LAlhBd/KsJ7a6CWTe/RUb5CB0TpVrCpcEJ3kWOP//FPqbrVMCAeV9qYh/G9i8O9XFKpYsZPyeW/L8KcaMAn+eJGUBTQ9Hmadyv2ua+cnXOtMLQ4MT5I+MOuWmCkotgFldHhopgaEnPt2jx4b7sAbGTDVqDEVJMLVcfzM3ZXy6W+/Quy+Qo/W/0R0FzSmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZyUUYqU8MyaBT6SzU9/mjUDsrVn5TIqkQqwyCr+79U=;
 b=trl+6l1UBjo8jDxJLn7mjURCUaNmmf172fMIinzPRC7s8Gzrs81qqN8S98PDPQGq9gjud5PtCbEpjD5p/eOVqWDUFfWe7SDAheM5nB4H9dSreHjtj3PcG+r3bYVGL6xGqp0LjKXPLwfFhqrBRPZdRQREI2QHojdbSefB8B3CJh4=
Received: from MN0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:52c::20)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 11:46:11 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::af) by MN0PR05CA0005.outlook.office365.com
 (2603:10b6:208:52c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Mon, 25
 May 2026 11:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 11:46:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Mon, 25 May
 2026 06:46:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 May
 2026 06:46:09 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 25 May 2026 06:46:08 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 2/5] reset: Add sandbox tests for reset_reset() and
 reset_reset_bulk()
Date: Mon, 25 May 2026 13:45:43 +0200
Message-ID: <be5411daf0de8eb64fbddf06e8ad82f50066e811.1779709539.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779709539.git.michal.simek@amd.com>
References: <cover.1779709539.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7749; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=FVVBeJDourev2agZ5+YkTfngmq+nTIgSaa4gclcVnHE=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSJmBUETA9faDc551P1Je4Xnh1dPr1XVvf2vzU31nPQ4
 r5zSfNDRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAExk5mGGv2LNu356s7wu8wnq
 +TXH85rx460mzlvYKwIl7p49FRTI4cnwP32S9i3Ogk7NkEZvTduULtX/JWlGG7mnHRQrlOYz4V/
 KBAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: af265237-a066-423f-3e4d-08deba5337c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|6133799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: XsG3odd/OGA/OORVuW15cKvOTF5BU3MSooENViYZDHjgiLmKfoW2FjP2oIm4N+QB0KrBr+hyoPQ1C1PnWISqGvzn0etYgx9ORP6nYftKZSNYMrN30cVnZA1qSFwgb4lJqqs4Te1lPC0pSG6237l7oZYEtm4cz72fyX0ClSr3A7m9WyjIUJsStYcURgrruxoSsXfelZhEGHXN+dYmilzHRz3rJE+77FyPONloG9X+EiLWEwjUYJjEUrKXcC5mt8fuA9UNoQO4vhRuPMEblDZykcp9N0L+1dDJHAojsCV1MpMmRAGZ7p5Tq5dsnv2Ti/XvTfZ4Wauhfu0c7utMtsjuZCqz9wduQBm83CbHTrSygm8VJyo2msl5hgr8jILMwHyJWZhVm+MDH8Us1FAvBg/Z/jDFK3x4AbQGVptgoKYUPBu4eqN/lGEbQFaa8aM72P+xRmdz/oMbatiAcr4EFoKbPwYWpGe8m5ln0QvdtRPzwtuwOHYIYI1HoS12ldeM3CETMkD2H1cr7GfYar1hVoWaqTFydRN2Cp64Nv3A2Pds2Gdq8fUwQb8HyH76iETBALP5ub1FeVXPCqgFeLuz27THPoBmuU1lgBWd1YfLES6IQA/jIJTNfeV18/c1Oy9/ALqPiGVpCB32QAN0WhLqI+l7lvOSPtTIbwO1IqAEmOVO1CWl2H3kcqXaHbJSlKQywhgjQ9KnniEfz9Xyl1v8ko44jlNnrXGPf6WG2LidGrGiXYY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(6133799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EkjKz99ikTlUd4wXwZpMAhFi6LH3jtK3E6zTrNT/H4zkFJE49CE2148nMliypt08xIhydn0sjhdA1JIJ0HuR319IBTnt2jUIBh4//sBwGkHQgwxh+BiAyeb5jEH7CS+w2gkrZYLeFGDDjrXS9/2yo/rpma3yTGCsI117bsYGnFRX6S5bzKQKEmJfuvxUaLnphT3zBI0MsDUAFfUPBrni/Z6HyGoaSFSe5FPv1XO6l1nKOS3tzkpIgBQOvDam5eb8NbaWTG3SUKYdyFiv6CrGX+UP3Wqs6XSNMnDFSS7hXoB5F/5IGsdyWBy6wDldmRfV3rWKHeRzrG9H4jo8InlHGVhHzgaFZYJmCxuOJ2Gb0DFut/HhIzjOS6N3EJqdSYysuZN3QA4PMhPLDzVpO9Sz0eQEWBQ4NT2yMDPc4n8Zw3DHrX9IaqZ33CgGk8AyOtFJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:46:11.3418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af265237-a066-423f-3e4d-08deba5337c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
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

Add DM test coverage for the new reset_reset() and reset_reset_bulk()
API functions.
The sandbox reset driver implements rst_reset so these tests exercise that
op (not the assert/udelay/deassert fallback in reset_reset()).
reset_reset_bulk() calls reset_reset() on each bulk entry in order, so each
line's rst_reset runs in sequence.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- align commit message with implementation

Changes in v2:
- Add reset_count field to track reset pulse operations
- Implement sandbox_reset_reset() for rst_reset op
- Add sandbox_reset_get_count() to query reset pulse count
- Clear reset_count when reset is requested
- Update tests to verify reset pulse actually happened

 arch/sandbox/include/asm/reset.h   |  3 ++
 drivers/reset/sandbox-reset-test.c | 14 +++++++
 drivers/reset/sandbox-reset.c      | 31 ++++++++++++++
 test/dm/reset.c                    | 67 ++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+)

diff --git a/arch/sandbox/include/asm/reset.h b/arch/sandbox/include/asm/reset.h
index f0709b41c09f..2890e0dc09bd 100644
--- a/arch/sandbox/include/asm/reset.h
+++ b/arch/sandbox/include/asm/reset.h
@@ -10,6 +10,7 @@ struct udevice;
 
 int sandbox_reset_query(struct udevice *dev, unsigned long id);
 int sandbox_reset_is_requested(struct udevice *dev, unsigned long id);
+int sandbox_reset_get_count(struct udevice *dev, unsigned long id);
 
 int sandbox_reset_test_get(struct udevice *dev);
 int sandbox_reset_test_get_devm(struct udevice *dev);
@@ -19,6 +20,8 @@ int sandbox_reset_test_assert(struct udevice *dev);
 int sandbox_reset_test_assert_bulk(struct udevice *dev);
 int sandbox_reset_test_deassert(struct udevice *dev);
 int sandbox_reset_test_deassert_bulk(struct udevice *dev);
+int sandbox_reset_test_reset(struct udevice *dev);
+int sandbox_reset_test_reset_bulk(struct udevice *dev);
 int sandbox_reset_test_free(struct udevice *dev);
 int sandbox_reset_test_release_bulk(struct udevice *dev);
 
diff --git a/drivers/reset/sandbox-reset-test.c b/drivers/reset/sandbox-reset-test.c
index dfacb764bc77..64c205596c5e 100644
--- a/drivers/reset/sandbox-reset-test.c
+++ b/drivers/reset/sandbox-reset-test.c
@@ -96,6 +96,20 @@ int sandbox_reset_test_deassert_bulk(struct udevice *dev)
 	return reset_deassert_bulk(sbrt->bulkp);
 }
 
+int sandbox_reset_test_reset(struct udevice *dev)
+{
+	struct sandbox_reset_test *sbrt = dev_get_priv(dev);
+
+	return reset_reset(sbrt->ctlp, 0);
+}
+
+int sandbox_reset_test_reset_bulk(struct udevice *dev)
+{
+	struct sandbox_reset_test *sbrt = dev_get_priv(dev);
+
+	return reset_reset_bulk(sbrt->bulkp, 0);
+}
+
 int sandbox_reset_test_free(struct udevice *dev)
 {
 	struct sandbox_reset_test *sbrt = dev_get_priv(dev);
diff --git a/drivers/reset/sandbox-reset.c b/drivers/reset/sandbox-reset.c
index adf9eedcba6d..71fba5b15da0 100644
--- a/drivers/reset/sandbox-reset.c
+++ b/drivers/reset/sandbox-reset.c
@@ -9,12 +9,14 @@
 #include <reset-uclass.h>
 #include <asm/io.h>
 #include <asm/reset.h>
+#include <linux/delay.h>
 
 #define SANDBOX_RESET_SIGNALS 101
 
 struct sandbox_reset_signal {
 	bool asserted;
 	bool requested;
+	int reset_count;
 };
 
 struct sandbox_reset {
@@ -31,6 +33,7 @@ static int sandbox_reset_request(struct reset_ctl *reset_ctl)
 		return -EINVAL;
 
 	sbr->signals[reset_ctl->id].requested = true;
+	sbr->signals[reset_ctl->id].reset_count = 0;
 	return 0;
 }
 
@@ -66,6 +69,21 @@ static int sandbox_reset_deassert(struct reset_ctl *reset_ctl)
 	return 0;
 }
 
+static int sandbox_reset_reset(struct reset_ctl *reset_ctl, ulong delay_us)
+{
+	struct sandbox_reset *sbr = dev_get_priv(reset_ctl->dev);
+
+	debug("%s(reset_ctl=%p, delay_us=%lu)\n", __func__, reset_ctl,
+	      delay_us);
+
+	sbr->signals[reset_ctl->id].asserted = true;
+	udelay(delay_us);
+	sbr->signals[reset_ctl->id].asserted = false;
+	sbr->signals[reset_ctl->id].reset_count++;
+
+	return 0;
+}
+
 static int sandbox_reset_bind(struct udevice *dev)
 {
 	debug("%s(dev=%p)\n", __func__, dev);
@@ -90,6 +108,7 @@ struct reset_ops sandbox_reset_reset_ops = {
 	.rfree = sandbox_reset_free,
 	.rst_assert = sandbox_reset_assert,
 	.rst_deassert = sandbox_reset_deassert,
+	.rst_reset = sandbox_reset_reset,
 };
 
 U_BOOT_DRIVER(sandbox_reset) = {
@@ -125,3 +144,15 @@ int sandbox_reset_is_requested(struct udevice *dev, unsigned long id)
 
 	return sbr->signals[id].requested;
 }
+
+int sandbox_reset_get_count(struct udevice *dev, unsigned long id)
+{
+	struct sandbox_reset *sbr = dev_get_priv(dev);
+
+	debug("%s(dev=%p, id=%ld)\n", __func__, dev, id);
+
+	if (id >= SANDBOX_RESET_SIGNALS)
+		return -EINVAL;
+
+	return sbr->signals[id].reset_count;
+}
diff --git a/test/dm/reset.c b/test/dm/reset.c
index dceb6a1dad38..043d7cb7e0fc 100644
--- a/test/dm/reset.c
+++ b/test/dm/reset.c
@@ -120,6 +120,73 @@ static int dm_test_reset_devm(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_reset_devm, UTF_SCAN_FDT);
 
+static int dm_test_reset_reset(struct unit_test_state *uts)
+{
+	struct udevice *dev_reset;
+	struct udevice *dev_test;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_RESET, "reset-ctl",
+					      &dev_reset));
+	ut_asserteq(0, sandbox_reset_query(dev_reset, TEST_RESET_ID));
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "reset-ctl-test",
+					      &dev_test));
+	ut_assertok(sandbox_reset_test_get(dev_test));
+
+	/* Verify reset_count starts at 0 */
+	ut_asserteq(0, sandbox_reset_get_count(dev_reset, TEST_RESET_ID));
+
+	ut_assertok(sandbox_reset_test_assert(dev_test));
+	ut_asserteq(1, sandbox_reset_query(dev_reset, TEST_RESET_ID));
+
+	ut_assertok(sandbox_reset_test_reset(dev_test));
+
+	/* Verify reset was pulsed (count incremented) */
+	ut_asserteq(1, sandbox_reset_get_count(dev_reset, TEST_RESET_ID));
+	ut_asserteq(0, sandbox_reset_query(dev_reset, TEST_RESET_ID));
+
+	ut_assertok(sandbox_reset_test_free(dev_test));
+
+	return 0;
+}
+DM_TEST(dm_test_reset_reset, UTF_SCAN_FDT);
+
+static int dm_test_reset_reset_bulk(struct unit_test_state *uts)
+{
+	struct udevice *dev_reset;
+	struct udevice *dev_test;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_RESET, "reset-ctl",
+					      &dev_reset));
+	ut_asserteq(0, sandbox_reset_query(dev_reset, TEST_RESET_ID));
+	ut_asserteq(0, sandbox_reset_query(dev_reset, OTHER_RESET_ID));
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "reset-ctl-test",
+					      &dev_test));
+	ut_assertok(sandbox_reset_test_get_bulk(dev_test));
+
+	/* Verify reset_count starts at 0 */
+	ut_asserteq(0, sandbox_reset_get_count(dev_reset, TEST_RESET_ID));
+	ut_asserteq(0, sandbox_reset_get_count(dev_reset, OTHER_RESET_ID));
+
+	ut_assertok(sandbox_reset_test_assert_bulk(dev_test));
+	ut_asserteq(1, sandbox_reset_query(dev_reset, TEST_RESET_ID));
+	ut_asserteq(1, sandbox_reset_query(dev_reset, OTHER_RESET_ID));
+
+	ut_assertok(sandbox_reset_test_reset_bulk(dev_test));
+
+	/* Verify resets were pulsed (counts incremented) */
+	ut_asserteq(1, sandbox_reset_get_count(dev_reset, TEST_RESET_ID));
+	ut_asserteq(1, sandbox_reset_get_count(dev_reset, OTHER_RESET_ID));
+	ut_asserteq(0, sandbox_reset_query(dev_reset, TEST_RESET_ID));
+	ut_asserteq(0, sandbox_reset_query(dev_reset, OTHER_RESET_ID));
+
+	ut_assertok(sandbox_reset_test_release_bulk(dev_test));
+
+	return 0;
+}
+DM_TEST(dm_test_reset_reset_bulk, UTF_SCAN_FDT);
+
 static int dm_test_reset_bulk(struct unit_test_state *uts)
 {
 	struct udevice *dev_reset;
-- 
2.43.0

