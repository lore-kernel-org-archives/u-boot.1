Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC439CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F19C88464D;
	Wed, 13 May 2026 11:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cLvmC8z8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5990C83FB0; Wed, 13 May 2026 11:42:38 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BEE58460E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyIFTda7nV1yr2pGBF+FsxgXAvuL+k8GvkzfZAfzweTAJshtIt2B6pOdDSORpivGYBCuw8D9r9PlDf0slHkyE15tu9D/lezaljKGFresItrD4sIrJu7wcRWb5y/o+KYCq/1lhPl6AHIwwy5hXdEmwiCZvBxmp1T3XwK64+GA6pJpWyA5BoJkS/3uFOQMRIb1hrFCMM0AWXD7ytObNagoJiXpy+bPyvLQ+jDZ7FCQiT3PSya+P5EKHnA+rwnJKT286lsWCyRl5JbS9Wf3YeBJqouTAylGn0TgqHmDVQ4tCKPV0azC83lHfEF1ZyKzhmhqM69xndzHOsJM09VYqhgwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cf4sK9wg67vsBN744fSjx09uMKSBBZayWawhRnjTXE0=;
 b=MWQx5WtIOK1bxOH1aDIbeFDsDF74EDo+f6h1eZ45T7TOWay7SW43EJVQexQ4iO0fgUzjoSGYJfOaUWe6yRz0uhF+h2zOkbK+QEigaZwPdG3+iykfr7gj8boaUoI1xfikyHjxhkxcwtA2Lx+NhOGROe5jB+o+wZdtf1pokVUjCZGEEwTU9qJY5XfaBEBUnpva68lbIK9RnPvuAzhU92bblqCiYMNwXQ5p19pL473sqIutv5fUTzDxCa0/6KhjXlLwOV+J+ij33Ad6sQNg4x3U4Gl7UXM7UzoVf3Ph5sZJSsUpFHHxPzTsE8+gn+emPJa0LO1n5SaoPP7Y+QfOTf7dOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf4sK9wg67vsBN744fSjx09uMKSBBZayWawhRnjTXE0=;
 b=cLvmC8z8xKZ9N7YUh1MBwV9rcsn9JBrrWQnor0V/YPxIb4YR675LWQtWMCqmBZHG6EyduxVdGFvQXmpAcokn0ycowvqzPkAkyeczq0TPQ+fFrjvzOn0gG73UMQv1pcWQRzAJ4XiAHYxxQvjehGyUQGyqPaDPxDBy7uCwLWBMAFA=
Received: from BN0PR10CA0017.namprd10.prod.outlook.com (2603:10b6:408:143::26)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 09:42:31 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::79) by BN0PR10CA0017.outlook.office365.com
 (2603:10b6:408:143::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 09:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 09:42:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 04:42:29 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 04:42:29 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/5] reset: Add sandbox tests for reset_reset() and
 reset_reset_bulk()
Date: Wed, 13 May 2026 11:42:07 +0200
Message-ID: <44e89b8fa832b961c44c60e7ff7c0dc0306bec20.1778665323.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778665323.git.michal.simek@amd.com>
References: <cover.1778665323.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7724; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=MAkzmr/3vDiM5gBvRxeg6/PAwfS4kZqZ+5fWxs5XyHs=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSxuJd8CtoWo51qXcw1Uy+Az1zzy85MpkC/to+yV4Rvx
 R4+4lPWUcrCIMbBICumyDKdScdhzbdrS8WWR+bDzGFlAhnCwMUpABO5L8nwV3Lbn4y7vY6XM6au
 ybTo2jnv57mSsweOzMureb5y0b9z1nMZGRawhLyPnlkjbCz1Mcpx85KLRSH3JZ4Eb0rcYL3TeZP
 IBw4A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d22c58-a2ff-4568-e817-08deb0d3f3d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: ye3k4kY5Yl9Wgc0M9DJTpZltff3EZhS5Ho5zAVK5FpfOClBcOF420QzCsVaOmvZD6hvgvdB8XTfUNkPgqd/hnZm6RYBAHQk6zEhWb0usCnpEnamYsrniHvkGgjD0btkcS3M/Q0nslKFAYGe8BLWTC0rgCo068SrqhPdkkGf15SuxLAO2kR7/F0AMZMAUypiRwuY2Ca9WEwVb5Ser/SHw9ry+BwKK3hEyAkfmwNAUPD7UmaylvxtqTIVAF2OIzue+obDaB7Kix/BVIJ1PcLn23vKmvMjWDnJJ3t539hLIu54PAXdPKduW7R35BPOHwiXq+RahYsAjNUxjFXQ46ds+m9SnhKEeiNcJvdEnEWzrEeqcn8SYniBPnqIsq6Ta1lFosXPLhPGw7ZF7kNIW3L1zCoHsZ9V/jKSvyPwrCT+pGAFza1jlQor++zE/RXRCysS3d2ZTKu3pbW6PAuSfINm6/N2J2DmRAbgbO5hWCj5vbHkN6zH08LrqkrhwO01BJcZY9ASazBkD9goTtmQ1PDj8FV7AJE1o9dBdDelRDIeCX/9ktg2yGNRHXEfgOSnuMnLtq84ugIxGpxLEypgd+a3A27VkZmznbVuEOJ6jK9hRlwmVElPeZxAUsKdTWyfWmZvR/eHyqmEW2PIZjaHZz6NDEK3kx7nsPtD3F7oMX4mL0ojIwe+hQ0f+QT7g8Isi3r+rhGHr/j3cFJIV7PzM6d9J9JWgdapTVaDuTNyqozf0ZVI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: haA/t8/xrsW1MTGE7YVWb2cLAljs3F74tb95H2j6qUucrUfmZxJA4/98sEV5dMgl0OPj+ObnS7MDsTbmIeSF6WOxu+0iDzjHc+2KrVCH+zu2OMgHBcbsvgpZWAYJmv7YglODUg3Adn0OB/cRYav9KO/1UaW3Fk1Wp2pF1+yzJkVr4mV24sZgyt3QcsVg8nYrKJAv0ey8qvJG0Xq0FCn8sI1VW5BvqT/qfgOWHLahvFA+M7W0MQ7LI8GdN9elpGfitqL7lV6T+sA6sROcqOjsPjVEty183fl4SGLOWYvj2d9+aeP784oYIfZuEFoyArpATg3TrXHO/0QOpK2XY0GePa/CLe+Pumh3gOfN4h27z5Q1tJr3VbW8hyTUebW0EexF2LMB97lsc7a8/Mfk3x4unoHz05U8iyK8PqM4vqUv/Mao6fx6+RgI2FLY8z5FzUUs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:42:30.8172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d22c58-a2ff-4568-e817-08deb0d3f3d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
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

