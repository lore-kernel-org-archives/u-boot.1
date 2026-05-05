Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA43CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1B6F848DD;
	Tue,  5 May 2026 14:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Puls6oGh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48F69848DD; Tue,  5 May 2026 14:30:57 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4784A848DA
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxWpHKXcTumK5j+OCi1oT9pIPHhVeYB2C5BY0Y6nBd44ofmgUuWHooB+FU0gIAPgyW5wIhPOBkxQzsRXdix/WglrphCr+6/1xVhdMwMxmB4Kyub0Rk2oJvinWsiZgTM8/VNhqolSa8VknP4qvUSO1gNpCIzXygcq0FY156T1u6TT1R1XVooVHIMcmLWMuDwsTW84wLpgwZqCh70m0QqlaQ/W6qwLGVmUMOg29jKp9Bzv596ps1IWPdGrQH5WKzeEin7aTO9Lswr8i61wrx8802Eydt7vxz1TB1cQowtX+q6tXzOMD7tBIqqvWaL1HPe90NC2/qqkHXoXwZuwv8/+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11v8JHHCxGqVuM7DzUXdY0SuP7lwEHIz3xinyqqqiTM=;
 b=EhojnpbcPivcjDSiXHwz+JfsEYgoNVcZLZH7o72my2tDQxGfuZpPAmVxahJb5xsVNf8dTpgot2/2a/f9E3EHFsBNhgBmIXDMXNB/WRXnr1mEdY98qBi0dkmJBQhucBL3nb/KxNwHcK7uOtbhdlQA6A3x4SjXXqwgiP2au78L4mCoiKlvnJRpTDKWuz6/RPl17KHc6nJhrjGQyS97G5AacnsbCdQyBNhH8xvSFoXCgU9Wvd6RlMi06CvdRc3ybzYIY/hkxKkY+xYTIXbhQSDgmrKLhezfnmrq+542qQL2WNPApmh7J348KfqxgsG0/qmUybAg3cTB/JFZN86L+rNzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11v8JHHCxGqVuM7DzUXdY0SuP7lwEHIz3xinyqqqiTM=;
 b=Puls6oGhM3eGH1xhIvMlg7LPjrh76AzFluTwfgmnzK2y1I+W9LcembBMsxvLvvALIFjqn9Z9yE4DE0EoO1R5wL2hWQd8+fJOiuoJ4Br8E2rekVcFdH4t3l1E2zd3lRyQr4EanZUJNzMaiRWtW9wCm4w2qGtheSW+aGneQawZg+g=
Received: from CH5P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::27)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 12:30:50 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::8f) by CH5P221CA0002.outlook.office365.com
 (2603:10b6:610:1f2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 12:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 12:30:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 07:30:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 07:30:45 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 07:30:45 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/4] reset: Add sandbox tests for reset_reset() and
 reset_reset_bulk()
Date: Tue, 5 May 2026 14:30:30 +0200
Message-ID: <21c23cc7403153b45a81c958118b8d9f85f73140.1777984225.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777984225.git.michal.simek@amd.com>
References: <cover.1777984225.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7488; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=37dzEtdvtbPG7oVd+oZ65NdjZEnkJU/bwOn/BlWhOtM=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT+fPSKZTVv5lMbrubfq5YJXNJTWORT1Wjw+O5ahzkbn
 +9kSBPo7yhlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJbPnHyHBsLytnBsuHez+6
 jkiYz955O3E9f1FJ5AGJ2VeW9KVPE9ZlZDhzue6KT6HQjxm5hVtUNG+FL2OYHNEoc+WfKk/VTEF
 zP3YA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d61422a-e278-40ee-1cad-08deaaa2242f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: O80fxVgnQhkWMwDYQSCL/nrMR5fuS+TAiYiNxE1n8znxrI6q8tBIU1Wv9zfqjK2VF2ev8nT1U3iQtgfnU952wwOckd9u0D4n2oulIeAR4PH5/yReol6+kb8Mem3YSWWzGAB5g2w6RyfzXR7Qh7zmKv1RXxEm+Pfk1w3F5pqvN+IoxK7DVBGt2MyCjwiwX/I0H/qjHIDGtM36LO0sOGxzBcwOK3VZh4XiOUVU+qdMMdK+Z1YXGpBnNp5a2fL2TZSeS8qPjXT8u8YTMIfrvxCmNwyTDVk0g6l23ZQkJNgbyPx/NzWPoD3Xg8UTVb6dIutv4zm91/Db8OMo6FnNsQburbxHE3o1y5KLWmBO1DzyAypIy6mqAdDfshyxFp4UfsW/XRI6H5X+O4RbDy7iEr2CAvPK+TzD91TEC9SHQgXZD9vFE/wy7WVgJuJsuVBVRnxmmQVvoAk+MT8Q1gRerv9vinR2Bz7JNuFEN45dzscD70yLwECkgG7Py0kbPdkuir/Sm1q08PiU1HwLx8BPK4JqX4+i1GnkBINhO7hPuA31lFxyvl/1PSTuJgWz9kfAUj9sceYMePkJFq+LTljR/CFZuyGJf8XaGpJyrYYDF5jNVweqWt6qhk4EIQUle/RB463pRfKuilsV3Y5HvbjUb+tsnUBYnG+MPzxXL0fA/uI0SQu4MruuZjoHDFi9QlykmPLH8Q6fSTdO3yPwltIYEG13SQoxx1zAeB6CumRN1JXXT1E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4j/hM5Bw20gf99D+T1FOCpyliUvr/JfWm86uHQfzMIWPoUQAF9ZG/FDwHBu1DwHZ4YAS/ENPWp+IJWmpvHbM1g9bC95cHr2dsJU8GeYHSq4EuoTeFhGu977zJoFXQYbKERCVrPSpCP43/7RTfPuXTiDhHXTImg6vxoJAznkJ/sNXRv7vQGs9E8Yw/63iHvaXjp1OEnUSCXqbXlaxVmhC3KbcDuaxOygSH9cB2lWi6QwbMJ1gPbySEQwz2/ANJO3nCY5IteqBI3io3OTRrVd0+WNKgXxP0Uh921CKaHEfGmASpJud1eOgQBAl8eS4gcfTH2Oj1uFh78Y3PDDhyvM8COnTVBMuBkXkRy/ZEQ9Oy9+9yaC8ogG+/GofLp73FlE+H3ecY0m+D4fD//1qohbC4uUiaEY/hkHdzy4fgEPxyWNCXcSF94VW9+IXrWFqDdOZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 12:30:50.1407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d61422a-e278-40ee-1cad-08deaaa2242f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
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
API functions. The tests exercise the assert + deassert fallback path
since the sandbox reset driver does not implement the rst_reset op.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

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

