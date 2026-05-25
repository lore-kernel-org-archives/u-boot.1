Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108EBCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 11:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B08846CE;
	Mon, 25 May 2026 13:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mjAM2lQq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DD3C8460E; Mon, 25 May 2026 13:46:26 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD895846D1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 13:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0qdniyCHvWVNJfyegUiax3Jnq0F/CmERoTQAQp+VMkCU9gjWjjF5TSsf2sVfrU7j5GihKuECorxxSQvARcXf8gOE4Onxi878ZkqqFE1Eu2ICvrl+yiFpodlc+2F0vxVfReH3X7SBXHr7IGaEzBfINjIDFy7v4VgTwgMV50uQSvBD6jWk+MK3yDOO1PjuH7EqHEmaXZu1ShaY09kl5f//Rrq9xNKzLpvJTdFYNbZjBAt6s8Q2ZmFQ37bQ8ELqDN77fcRJf6YYddD/lSJITJcV3QP6NrMOipWuhEvJ0A4iJTS4b0Cc9W8cCvX4yE4cv6o0xkxWwUen6w32hQlSQGYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GrpgxGi+Iiigox10Et694e2qQtE7NVSaxcR/xAw4MM=;
 b=b/uHltfRsnGPsP9xXu0dhzHb3ozM4oIZvEWhKVJfaBbnMRNHvPUVntftIseUVxiqOvI30lpUAckzoTXA51HXP7HSCD5xv9wPkEyFocetjWm90mAz8WKSz1ZvT0a6AgXhxq2skTEC/VbR+Yw/iqatKUgN+lQctLvu4wAyNXOet2UezILR4Tvdhf4yfRuTO6CupACwuqcJ7NG76hrEqYALgXrSCG1x1S7H1LC80E/dP1cU4s9WNTIkJ89Y3UBsVyTvEycruqEWFHaDT1T4QCcAgu0scrw2VWlk5Rx6dOJephRT2uUdexNO/dEb0OCCu8/wX7f9yidi2eDl8PezmIvNdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GrpgxGi+Iiigox10Et694e2qQtE7NVSaxcR/xAw4MM=;
 b=mjAM2lQqGc4+sIAFARcB7SWaHAptMugQNGM2Jy57pgp6IOiLXiDSPRDP1FoVprcbFjmEuDUmQPRwTN2V2dBDBeL/WznAxAXjAwBJElUBnf8Ggy+LinNDyMTLXhnXmNkU1xWi52y2hJh78ewqawT8IaD1igPAoNxApVwQD1wpF7U=
Received: from BL1PR13CA0385.namprd13.prod.outlook.com (2603:10b6:208:2c0::30)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 11:46:19 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::2) by BL1PR13CA0385.outlook.office365.com
 (2603:10b6:208:2c0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.10 via Frontend Transport; Mon, 25
 May 2026 11:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 11:46:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 06:46:17 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 25 May 2026 06:46:17 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher
 <hs@nabladev.com>, Lucien.Jheng <lucienzx159@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>, Martin Schwan <m.schwan@phytec.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Tom
 Rini <trini@konsulko.com>
Subject: [PATCH v4 3/5] reset: sandbox: Cover reset_reset() fallback with
 second sandbox provider
Date: Mon, 25 May 2026 13:45:44 +0200
Message-ID: <c1d40db6e2332a8b23ba842385b3f8c3d0290109.1779709539.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779709539.git.michal.simek@amd.com>
References: <cover.1779709539.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5378; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=3FX5kq2wudv7ZdjBEB6xOHCA5bdisNnUhtkW7cKzFM4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSJmBW2nynzPiO30jWAMWrmuiPrTtx+ozU9RqAw4tXcT
 t9fpU5uHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRn7mMDJsOT9y017UuL92p
 okaylufkduf3ahseVS84dsx0/oOroYsY/hmc/K4u3/egrfLms/y7LXvnbe5cvnOLytmOrhKdqyv
 UPVgA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: dea1223f-f1a4-489f-4f00-08deba533c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|11063799006|5023799004|6133799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: eWCRGgWGV/9Lude4V/ZLeLnriUO/9Bm/V3Z1tAlfjdo9PS9eboJAzCmvy7LEqa0WuMHZY59KB55EbzLrpvUZvK2lGu0RQHk21idpTAXIkJit9IZ+llKdnI/G/cOhTHUhSQ+Q3IKo5u8lzYcSQnjy4Iz5vB67HYHWcJOZd+BI5dzMF6jAZPgJVmQffiJjikA2/zZkukhp4dWGIZ6/5QX4pZXgw3O1JTPJCPHtcqiLnjckh4Akt1N0Tk4S/ZBt2ByxmF753OG4AbQj84SzcQVbWONCXEOoAWo/BQ/8qrPywH7y8X7fpnTDAqeWoG8HEciuK9UI39mHRSz6fdQ6UmH4ZUPbK5aLTGXCRyt0BelrTvwPDBpw/Sh/NWmN0BPiHRY6pYPOb+jYL07JYH6SzWGdF2ackEDVhe50w07+q/aOep8DmxnlACOSxBzYVNo6nJSkXmt0uuJFT0iULpKz/OyQ6sG4QpckFi0Q9IkGAqmN1xkI2YLoxcoVnsTOT1lQ7BYlhM6hcZ29fkFBRAppMv3WzpqYuYuybE64aKcTlxTftTv+MiaEICdI1uSNSdcrac1f/W9+4FN5fAOp6XA09eqhJ+yMZi84k7y53su42ADbmPNn1wuUXlt0aPfCEBTU1n3Ek9IqJL/UkWxvfEGsoJQ0Fs2TAi2p0h2mdjyk/CTSzOdU0nxTgPX3RWQlRM4JDhSAvz1eWLaMGk8+1pbFs8fO2vzJgDAztQW8mko35HvEwFE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 742RJDFpyslVW5pTLDKZZkiylOohfkiVuOmEwHo5q0wbH/6PFlVFS6Zmb/OctrVdU0epHy+VyazO1NdEo9J7rlnVQW13vjXsVx7KV+wlaaW8eVBXpxWbnVX8NLjGJ1VGrWqURZqPOXh110QIOez2UpsLBhIUv2Vs5+3LAzOAiFKumsU4+jdWDQjzxni9Fm2lpYkrmuWXDdHyF/1zWyzRVuyCD9a4IkuPMLuFPWbCt8NkUzodx4w1k7DWsk/5x+Ovqy8EVo6TnzeBtQf7gCj/5PSoXzFsPX9IPs5AVIeuwbRXdx5a4ggtFUZEBLj1rFWfsbf3Pb6XTTKaUxjgBfIAkLPexqk74twfB1CJhsDdQ361EY5a0IrOpIla3XgBAutTzoIXh9VxrLVkDImqpMs6sz2TVuK6//OZyoCJaVAg8ccJjfp06OybnqzekoZvmrhf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:46:18.6005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dea1223f-f1a4-489f-4f00-08deba533c19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- change reset test logic

Changes in v3:
- new patch in series

 arch/sandbox/dts/test.dts     | 10 +++++++--
 drivers/reset/sandbox-reset.c | 27 +++++++++++++++++++++++
 test/dm/reset.c               | 40 +++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 2 deletions(-)

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
index 043d7cb7e0fc..91fa7ff723bb 100644
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
@@ -151,6 +154,43 @@ static int dm_test_reset_reset(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_reset_reset, UTF_SCAN_FDT);
 
+/*
+ * reset_reset() fallback path: controller has no rst_reset op, so the
+ * core does assert -> udelay -> deassert. rst_reset-only accounting
+ * (reset_count) stays zero. Leave the line asserted before reset_reset()
+ * so we verify the fallback actually pulses it back to deasserted.
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
+	ut_asserteq(FALLBACK_RESET_ID, ctl.id);
+
+	ut_assertok(reset_assert(&ctl));
+	ut_asserteq(1, sandbox_reset_query(dev_reset_fb, FALLBACK_RESET_ID));
+	ut_asserteq(0, sandbox_reset_get_count(dev_reset_fb, FALLBACK_RESET_ID));
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

