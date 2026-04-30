Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36F9FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 12:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A35B8352B;
	Thu, 30 Apr 2026 14:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n2t/seAN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08F0D8432A; Thu, 30 Apr 2026 14:20:53 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAC9A80F0E
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 14:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqIy3/qjMQlDi/tcZScLcYjP44ucQbsC+6pX5+rw44g63Gn8ew85wclDJsRaWduP8AvtTIgwlgghFezoXgTnbnZ62mvoPjkiLooxxq5MefLHmgkFiYfC3n9wZ6HgCRlQsB/PV+YfyajTd5r5D0NmxdTolB4Kij5G3m7+OqTNH8rxq5FSI+jklX2ym4SboneypFfbH7LrkxB2o80rlRwmVlC00pNa+MHbZcniDNQ1/i+ElBgTI4bbm5JHFLxqFJgBTlBa8/HP8tK24aEJ+JPvylggfPFzsTUKrTOwvEHkMrF9ADqPFja5ViKqzvz/WyB5EGObe8ZkD4WMkh4l1MyFig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHuPT2T2mr/lFlRLIWJUj10Y9gs+sJ6U7aBSaqCN/Po=;
 b=CFU7TW7Xr6/k9YWcvuzFILQeV+LHD6HYpABKMMJahi35Mv0s18mPghxourA0SpHI2+S39tpJJ8WIWBkzSW8zF9S2R7OzKvNN0I6IeJC7G2uq2nLvRuL+4Yf/ADX2GsLXrCJAd8NXh/0bb9WMADTPzzlhsIT8pP01YLKfc/GUqJBWY+6lI+Tgge3cu9dZoRL1ynZQUmJKbNSTrej3dRn8uy8qgw7HhMi91wgMCYeFqzxB2M8SXlodgETxaKOCbxAUlkJjhAoGNr9jdlX2ELuC4YL0MPIfZvkuRJBmUNtgVSz9roxEWUS8pS/5NLuTKCn3TauVIdDXrhnV2aUfKgKUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHuPT2T2mr/lFlRLIWJUj10Y9gs+sJ6U7aBSaqCN/Po=;
 b=n2t/seANf2bymMrpwZ1lAFwZFzVdi2uCVuR+AiuF7SZme5YVJ8oKJY/VMkuW6FubxQc23csapBd3aZV5Dv//UFpUmU/6Nv58RMEMOQRxCb94MDXdcpAcUwiSqau48wDjqvd0SiJlw2T9Hfq2MC03l/OMbzVy4Z8A1c09nmlY5dw=
Received: from BN9P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::13)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 12:20:44 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::36) by BN9P221CA0010.outlook.office365.com
 (2603:10b6:408:10a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.31 via Frontend Transport; Thu,
 30 Apr 2026 12:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 12:20:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:20:32 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:20:31 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 07:20:30 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] reset: Add sandbox tests for reset_reset() and
 reset_reset_bulk()
Date: Thu, 30 Apr 2026 14:20:02 +0200
Message-ID: <7c16f629d85dba0118f8d67831adb8f167bdb8f1.1777551598.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777551598.git.michal.simek@amd.com>
References: <cover.1777551598.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4153; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=M5/FX47sA4iIluNzP7Trs3yNNqpOLmPLPFP9j3WfMNI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR+9vgl7WtzcifDLqa5Wim7zIuiDpZyXzzKFBrOG/Hn0
 05N/ZaFHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjARIVuG/8FTfMSMgp8zzEo/
 8fFZ2K5IvTsnOI/z/yxccKQh2e70AiVGhslNufu2iMXZs2Vfq11W5Oa8aLeorB5/5JKK7RzZDGn
 qDAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f111d9-0369-443f-939c-08dea6b2e71c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ncaDJq7liptvjD98Kxfrg0GQ/VVlPFSXOLRxko/3S2hFnX6Kyzbwj38CJ1G1WlI5MdsaJJV1nYg9YYQ1GyTnqcXyk1WUQfsJTPPkFM2IbVv2Lf1bKSkCABOgHbHoDPLJtRRbayYzyopZ1nVB0Y1RDZv5xz/UIlmm0rQCUOi917f+zGScWLqMVCHsgZzR6AoJHqzBKGATJTICeJuD4MoMsMRYktlFdkWbPG9Sce9ieunGOl6GLtc/6CcrY3BVRWI34G5rAzmej1zc2L0/+R0oig7uYuGqyujf2FMOufsV5s0PY/+01mC54KCzwvbcDcCnNjmQ32sFvXYk9Gh3KTmnKdpvMJMahZOfnxIl+cFwr9DqTmmTt6E2Xpq+BI2Sfg2IcqsWXhC9B3wbe0O8RySmdgdnzLCpoG1eIDdeJMX1AETYtnzQLCwAq79zSWzpwE7zAKvIGbO9vObz0vH5Klp6WheE7T9VkiMH5KZCTzZYLFFZwSzdAZMHJvuUmtYo+E/TF+V3zRilIOIvAteB7fCS7HTrccLOOOSwm71610A5qoMciI6wbuBz/Iw1/OP4hS+qNe5tpi4MW1Tg8SnAJXSED4pN2CfTgX4cZOxhjezPMUi5u7+YVHIrazmnbp8VD6+FCUbydAuH4NK7rSBxDNT0l+CQzebSBHwXgqt6JaPCR5XWvYUMBhBHKkxIEHK6tC/cysrb9iGKBsuqbKop949Ig0x5RRrj/6ye68A1L1OKLuaqnDHf9svYmHeWYb8hw3SE7Mg0AGwH0xeX333AoRmmxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qn5s6BE8MjEwJIYzTstKVXaWCRqKMGu3m0DKIQWTCIVWVgQ5lBR+t01/bAjYVk4DBfKjVn3xQUGXQbaCpmDK14CRzpkEH7GMoFrWNF0sbCN1Eu2dtVgk811/3u0uLyziELiAhxIZ+0lCtC+w6sykm7raR9dkP8s2twJYTr+oOsd1GVxumi495LKEsMmlu+XSJktuu8SiBrWQWUiLe38LjrqeW/T3lO6D7SFdNqtZvB4KHyNednmPc6o6ivbDTP3XSz1xeYh7FVuQFflSKe/Na1QP4XvsjgS7zK34iD7TWNHOqMQ9eWw9HJ6FBgBZY13zOtOq2nkI/AeMfM2MH7jf4IIv/alk5fX+HfhTQ0yg/ZhzQWaqtP6oz9tn4XFtPAkecMPyD7dUysSFxhKclsYZ+b9yChaclfzoXEn09TBzUYm1QDHLcxB51LAE/DtK9n0y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:20:44.4589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f111d9-0369-443f-939c-08dea6b2e71c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999
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

 arch/sandbox/include/asm/reset.h   |  2 ++
 drivers/reset/sandbox-reset-test.c | 14 ++++++++
 test/dm/reset.c                    | 53 ++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/arch/sandbox/include/asm/reset.h b/arch/sandbox/include/asm/reset.h
index f0709b41c09f..5b48c2fe7bbf 100644
--- a/arch/sandbox/include/asm/reset.h
+++ b/arch/sandbox/include/asm/reset.h
@@ -19,6 +19,8 @@ int sandbox_reset_test_assert(struct udevice *dev);
 int sandbox_reset_test_assert_bulk(struct udevice *dev);
 int sandbox_reset_test_deassert(struct udevice *dev);
 int sandbox_reset_test_deassert_bulk(struct udevice *dev);
+int sandbox_reset_test_reset(struct udevice *dev);
+int sandbox_reset_test_reset_bulk(struct udevice *dev);
 int sandbox_reset_test_free(struct udevice *dev);
 int sandbox_reset_test_release_bulk(struct udevice *dev);
 
diff --git a/drivers/reset/sandbox-reset-test.c b/drivers/reset/sandbox-reset-test.c
index dfacb764bc77..1f599d629eb9 100644
--- a/drivers/reset/sandbox-reset-test.c
+++ b/drivers/reset/sandbox-reset-test.c
@@ -96,6 +96,20 @@ int sandbox_reset_test_deassert_bulk(struct udevice *dev)
 	return reset_deassert_bulk(sbrt->bulkp);
 }
 
+int sandbox_reset_test_reset(struct udevice *dev)
+{
+	struct sandbox_reset_test *sbrt = dev_get_priv(dev);
+
+	return reset_reset(sbrt->ctlp);
+}
+
+int sandbox_reset_test_reset_bulk(struct udevice *dev)
+{
+	struct sandbox_reset_test *sbrt = dev_get_priv(dev);
+
+	return reset_reset_bulk(sbrt->bulkp);
+}
+
 int sandbox_reset_test_free(struct udevice *dev)
 {
 	struct sandbox_reset_test *sbrt = dev_get_priv(dev);
diff --git a/test/dm/reset.c b/test/dm/reset.c
index dceb6a1dad38..343c2feb190d 100644
--- a/test/dm/reset.c
+++ b/test/dm/reset.c
@@ -120,6 +120,59 @@ static int dm_test_reset_devm(struct unit_test_state *uts)
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
+	ut_assertok(sandbox_reset_test_assert(dev_test));
+	ut_asserteq(1, sandbox_reset_query(dev_reset, TEST_RESET_ID));
+
+	ut_assertok(sandbox_reset_test_reset(dev_test));
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
+	ut_assertok(sandbox_reset_test_assert_bulk(dev_test));
+	ut_asserteq(1, sandbox_reset_query(dev_reset, TEST_RESET_ID));
+	ut_asserteq(1, sandbox_reset_query(dev_reset, OTHER_RESET_ID));
+
+	ut_assertok(sandbox_reset_test_reset_bulk(dev_test));
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

