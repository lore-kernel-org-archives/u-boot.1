Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95574CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:43:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7CF584099;
	Wed, 13 May 2026 11:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QmEqUgcS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3514B84099; Wed, 13 May 2026 11:42:56 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D1A38341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwalBOb0HuaHvoyF19Dp8HBbw9B3ZuBVm8c0WPrmvkgRisET9fQzS/tWhacLfouArTEbLYDCvuxQhi7qBjn/GMmwm3uayIi4qleYlVOE4Jo34ChtuFlFcv1dsiwo3xqzKyZ0PGzXtS7K/ty0xV5rfNJvcUej7T5PfROSNXQ3v30ifkmVCcmj79rPWTZnduOlMAxe3PYdRlGaPQ0v3Y5MR+AGfaQNP0WbGYvrBhivPiXdhHfAieUIcmB68Q/8osxcTcwEGkX/8GLS3ANKdOMYTuR4jm5/KzE2DN/MUi9/f1fkvURRxL73KSfXE1TaQbgWVJXhnRPHX47bMwZ6C2KxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSCINKuBsjCQobK3tVPbRDmSq3J344aaiM9r6zaH39g=;
 b=dBwPYaYHRAErzrRs92T2lG+hW1aXhk4Tx4iVVyMq4N9hLkf8mZ629fn/bR2L2t1hUeD9hFv5giOdfFFcobaHL+2w7ew1Y1aEYQXSD/M5thYQfaV+EFNXXlzmfCqXPRdemE+SqCO+a0r/nLUclbAGOCF/7uOtHiN6cH1xHZJxo288qnrQxQIFlKBU64mG+aSDggpU7usVOUyO5bwn+dA2JSoNdS36Pr8XSxgZ/8/psjYeWCYEbKz848bI2JAAa7GrQtirbZ7u6CTITvQd3Q3q679AKE5++TTo46r0OnaN968jwalnKdW5Cn3TTdcpwjMQ4AJdmzHUAKxWvo0/GupFyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSCINKuBsjCQobK3tVPbRDmSq3J344aaiM9r6zaH39g=;
 b=QmEqUgcSfRYd/6z/uA1ChH7Uqhgt4DPL2RJK29XHhiLX7wmW7d+FuasoNiaRk6wpn+bu5b7ITK0KybAlkhUfve0sNzjntxRDdJY/1QRnLNNFTwKxvLS2pTZlmbuzL2VZ+o8JPMqF5z8DUXJqQzqGKJg0XB/4Vx9zUpJb7CQneb4=
Received: from PH8P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::25)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Wed, 13 May 2026 09:42:45 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:2d8:cafe::51) by PH8P221CA0007.outlook.office365.com
 (2603:10b6:510:2d8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 09:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Wed, 13 May 2026 09:42:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 13 May
 2026 04:42:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 May
 2026 04:42:32 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 04:42:32 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher
 <hs@nabladev.com>, Lucien.Jheng <lucienzx159@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>, "Svyatoslav
 Ryhel" <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/5] reset: sandbox: Cover reset_reset() fallback with
 second sandbox provider
Date: Wed, 13 May 2026 11:42:08 +0200
Message-ID: <ced1fd0e7b531fcfae9ee7c0a107ee660d27d580.1778665323.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778665323.git.michal.simek@amd.com>
References: <cover.1778665323.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4989; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=tZLK/I2k+qW9i83lNPYxEhw9hejRbjgW7vvPGhy7S7A=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSxuJc2rDU6VD+ZQe1in34u47odoi2/Mj1y0xiZO94FL
 5/05eedjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZhIxkVGhqdnKt5VRD9JjH94
 1WT7IfnsxktLmHK2ffh6e7/V46eNGk8Y/nBPe7KKcdErdx2dkOqDWor2Sy8FT3+rkF7RfvJSmli
 7KAcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbe0388-bb0c-4832-a77d-08deb0d3fc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: tUqShWPFPmU9BB/lM3/P7UHr84AJlUmHYwIMlhreF/VWp6FHEFksZfjPGPCO5fGY7eI0aJSpfcso+7QEni0XaR/VYCBMXBVrSo7CPGHKq/i6jmvzD2ci2sE8PnRjrARvdNP2HyIK3rU3UemvqkUJTr0ktTfxJRrGu/CFljqPAEjDUAfqo9Z+gHio6ciU0K/15sBYpx8pxjJ1QlnkvZrcPxQH/0+lC5BOLKLU8hv5UtgQ1B2G3F/azBlXk7ghvUoLJfM4wwzm0xeX22iGs2cvaYw5XkXkG+DP1z7GvF20AxjSNznjjCeO/mv1m4b4a+ynY7VkBHZOAobz2QMW59cMhiLKKrAD1eYDOHreTWj8ETrqi2Eg8x7vFQAlhuFNHxbC6zjHMD90G7wix9K4yRJn78T4zlcymRr1M8C+/v4KMheppEbFpZddkeMGyT6CQ1S6jKzCYFCt/VClKbOzD2r3jij3O5v/HZ9Ko5QwIbdvvMtJfdP7MLpTR0rXSKG2hxKC/OMvBmVjsqyX5rW+M4gjDBlc1RQbTkLiNST2x+dz4j+qp+R3S6KCOKqR/4NbtbvL2ii9FqrZSNMIFeS2PonnaiEwSeg5aW7cyXADR57f2jFR3u8OqV2bE09OuCGL2z0wwFN5IlCzPynqPThC7cjcyvwbdmqKRMfUbRE+ZA/S5rRqTDsc/k3pLbs36aGFu7EoYE1yEgH6IK2Ne8alFvQZ0frOQbsT0EsFS+yfe7BetZk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qalv7Jj//xS+ZURxiamRJjsLAbive8kGIKVCgPDGpNBOtNz19rj9AlFjSTE/znBlJwzrTekqxwRoHuak+aWH4ulWJWGyNUoKFu4IcwxZ0B4kW2KNqt3BCw6KAQbtXcHKd/ISCAhKTAyaiLutpM3SD5roDc3ID1ELZwr+cTKgyMTPlANuaP9YwGyQ+U51Pl0nsvnBoxRyOc1LIyrLtVckKsMlHtIdaA/RMJE5OzvPAgvVBi+vcJiau1ALT52M6dHZY87VBtteOFkEvH1fFLVOMfcpu0vStBI1fbcaUGa0IhM6/OBwsMAtCZvbYTnIGOKizDB6kJMfNKkstpC4pak0SIoGl2Qc2KnlsK3vZcumkTE4l30ig1+vMQKbtc+gsFe5O7NznSXxOagK96k7ZmRwVwMSMXWnuHVvjVkEmfQhRRdqmK/pIv2OZrYu7XaWayF7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:42:44.8260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbe0388-bb0c-4832-a77d-08deb0d3fc38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416
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

Add a sandbox reset controller compatible string
"sandbox,reset-ctl-fallback-only" that reuses the existing sandbox assert,
deassert, request, and free helpers but omits rst_reset. That forces
reset_reset() through the core assert / udelay / deassert fallback.

Extend the reset-ctl-test DT node with a fifth reset line named "fallback"
that points at the new provider, and add dm_test_reset_reset_fallback_path
which verifies sandbox_reset_get_count() stays zero (rst_reset is never
invoked) while the line ends deasserted after reset_reset().

This complements the existing rst_reset coverage on sandbox,reset-ctl and
matches the approach of using a separate controller to exercise the
fallback path in unit tests.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v3:
- new patch in series

 arch/sandbox/dts/test.dts     | 10 ++++++++--
 drivers/reset/sandbox-reset.c | 27 +++++++++++++++++++++++++++
 test/dm/reset.c               | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 0887de4333b0..074e5c06ec82 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1530,10 +1530,16 @@
 		#reset-cells = <1>;
 	};
 
+	resetc_fb: reset-ctl-fallback {
+		compatible = "sandbox,reset-ctl-fallback-only";
+		#reset-cells = <1>;
+	};
+
 	reset-ctl-test {
 		compatible = "sandbox,reset-ctl-test";
-		resets = <&resetc 100>, <&resetc 2>, <&resetc 20>, <&resetc 40>;
-		reset-names = "other", "test", "test2", "test3";
+		resets = <&resetc 100>, <&resetc 2>, <&resetc 20>, <&resetc 40>,
+			 <&resetc_fb 5>;
+		reset-names = "other", "test", "test2", "test3", "fallback";
 	};
 
 	rng {
diff --git a/drivers/reset/sandbox-reset.c b/drivers/reset/sandbox-reset.c
index 71fba5b15da0..ada9ea6f4bf9 100644
--- a/drivers/reset/sandbox-reset.c
+++ b/drivers/reset/sandbox-reset.c
@@ -121,6 +121,33 @@ U_BOOT_DRIVER(sandbox_reset) = {
 	.ops = &sandbox_reset_reset_ops,
 };
 
+/*
+ * Second sandbox reset controller for tests: same assert/deassert
+ * behaviour as sandbox_reset, but no rst_reset so reset_reset() uses
+ * the core assert / udelay / deassert fallback (reset_count never bumps).
+ */
+static const struct udevice_id sandbox_reset_fallback_ids[] = {
+	{ .compatible = "sandbox,reset-ctl-fallback-only" },
+	{ }
+};
+
+static const struct reset_ops sandbox_reset_fallback_reset_ops = {
+	.request = sandbox_reset_request,
+	.rfree = sandbox_reset_free,
+	.rst_assert = sandbox_reset_assert,
+	.rst_deassert = sandbox_reset_deassert,
+};
+
+U_BOOT_DRIVER(sandbox_reset_fallback) = {
+	.name = "sandbox_reset_fallback",
+	.id = UCLASS_RESET,
+	.of_match = sandbox_reset_fallback_ids,
+	.bind = sandbox_reset_bind,
+	.probe = sandbox_reset_probe,
+	.priv_auto = sizeof(struct sandbox_reset),
+	.ops = &sandbox_reset_fallback_reset_ops,
+};
+
 int sandbox_reset_query(struct udevice *dev, unsigned long id)
 {
 	struct sandbox_reset *sbr = dev_get_priv(dev);
diff --git a/test/dm/reset.c b/test/dm/reset.c
index 043d7cb7e0fc..319f6cce8df8 100644
--- a/test/dm/reset.c
+++ b/test/dm/reset.c
@@ -19,6 +19,9 @@
 /* This is the other reset phandle specifier handled by bulk */
 #define OTHER_RESET_ID 2
 
+/* Line on reset-ctl-fallback (sandbox,reset-ctl-fallback-only); see test.dts */
+#define FALLBACK_RESET_ID 5
+
 /* Base test of the reset uclass */
 static int dm_test_reset_base(struct unit_test_state *uts)
 {
@@ -151,6 +154,38 @@ static int dm_test_reset_reset(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_reset_reset, UTF_SCAN_FDT);
 
+/*
+ * reset_reset() fallback path: controller has no rst_reset op, so the
+ * core does assert -> udelay -> deassert. rst_reset-only accounting
+ * (reset_count) stays zero.
+ */
+static int dm_test_reset_reset_fallback_path(struct unit_test_state *uts)
+{
+	struct udevice *dev_reset_fb;
+	struct udevice *dev_test;
+	struct reset_ctl ctl;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_RESET, "reset-ctl-fallback",
+					      &dev_reset_fb));
+	ut_asserteq(0, sandbox_reset_query(dev_reset_fb, FALLBACK_RESET_ID));
+	ut_asserteq(0, sandbox_reset_get_count(dev_reset_fb, FALLBACK_RESET_ID));
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "reset-ctl-test",
+					      &dev_test));
+	ut_assertok(reset_get_by_name(dev_test, "fallback", &ctl));
+	ut_asserteq_ptr(ctl.dev, dev_reset_fb);
+	ut_asserteq(ctl.id, FALLBACK_RESET_ID);
+
+	ut_assertok(reset_reset(&ctl, 1));
+	ut_asserteq(0, sandbox_reset_get_count(dev_reset_fb, FALLBACK_RESET_ID));
+	ut_asserteq(0, sandbox_reset_query(dev_reset_fb, FALLBACK_RESET_ID));
+
+	ut_assertok(reset_free(&ctl));
+
+	return 0;
+}
+DM_TEST(dm_test_reset_reset_fallback_path, UTF_SCAN_FDT);
+
 static int dm_test_reset_reset_bulk(struct unit_test_state *uts)
 {
 	struct udevice *dev_reset;
-- 
2.43.0

