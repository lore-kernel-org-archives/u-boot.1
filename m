Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848FEC54FD2
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 09:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FC6780F78;
	Thu, 30 Jul 2026 09:48:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iwv44vnUXxuL; Thu, 30 Jul 2026 09:48:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1822580F70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785404928;
	bh=Iy8z0AwnNiefmUtv/EUVxE1HOzXp9OkAl8dNXWOgKjQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b7G6xI2VO9/xvZoPBohsnOkL6Qel/p0y8LR6UoJn3mFrEkdxIDyhITaW3jtFh6r7t
	 ZakEjWH8b5FpfJQBJhrDBGGcJXx2XiJKNSM4LBDa+FET8BPAahjT5hkNatQEIMl3LR
	 UPkfZSFn+zMCWDolP7+IJhkIP8/o2JtiYlkjx2G7OunA5dPx09fyYqBPSDvaju+qOV
	 FyDVGRCT4r66wIrTSNULaBUxbg0tFBBKW+KbAsaNZpdbSnHe6ZuM5QrWVSDEdpJGlh
	 /w8+sm+4bAG8nmg/Lx0lyHYBEYaVTaF3JZgpFG/biA4L20MOcmxRUJBUNZFHAaGQDX
	 gcVEtguGjwZSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1822580F70;
	Thu, 30 Jul 2026 09:48:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C827926E
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:48:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AEA5C408ED
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YU6ZOh6tAw7V for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 09:48:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 78754407FF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78754407FF
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78754407FF
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihOXzZMb1TrhQPUhxBFILbk0Y2/pXJrZG4LGQ/AWdNdRE7MMqLJV3hq9Sa5gIgER+8kqrRhjXVPDjl9DnNQze2Cv3YMiIzsAcjKGkRPAj+4QxBe3DvTdgqoU2829oOTDJHEo9zcednvS+ZfRrtnRFFwcEnXt6qIMvCFomiRbXXOk5ug39nxvnYcxDdfymbqgZQvyM/W7EAFeR8j2rbS+B8GSINVhhpYcXMArO3BB6F0iuBaV7FqX4dJP0rcqtnzXf5LXuJMEFNa/9wdjgq+bH8wdUAkoQmXTk/pMSwl/N+Bj7v1pnazPtMjfaEhfNs2gxl+Rjvzfb47KIfMilBReVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy8z0AwnNiefmUtv/EUVxE1HOzXp9OkAl8dNXWOgKjQ=;
 b=uCW0ZY/D7wDk1dcAVMU/NjIHlUYC9LnCC5/9LUwsWk3oTgFdnLOuyP2L34jsU7AoZH6kkaXy4DK4j78IFRl3XMbnUFGsFegQ1KOp/5EDcUaCALU/zjKzFd9yjPiaTxqqcmMTyBqZxvlg6hHMAmS7RHdQzToJ3EP0LrOKTs/DRDF8+3uYvm1mEeqyebM9E7fq4nQwqLLs4ApohYS+a1eLVm7lowLCN2hUVCm32f8HfWQPmXUK/t3CZf3OfOsk4H6EQTyJmhozYMqjtfCF3enRMUBukIy4dogrFExF1zyI9r9Qlk3WjG0u1pOY9+r5SpQ3G+mXfT2boktUIFF9k1PgwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from BLAPR03CA0084.namprd03.prod.outlook.com (2603:10b6:208:329::29)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 09:48:37 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::52) by BLAPR03CA0084.outlook.office365.com
 (2603:10b6:208:329::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Thu,
 30 Jul 2026 09:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 09:48:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 04:48:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 02:48:35 -0700
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 30 Jul 2026 04:48:34 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 3/3] test: dm: add sandbox coverage for gpio-delay
Date: Thu, 30 Jul 2026 15:18:17 +0530
Message-ID: <20260730094817.1937340-4-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730094817.1937340-1-pranav.sanwal@amd.com>
References: <20260730094817.1937340-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SA0PR12MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: 2493231c-7982-4ee6-e287-08deee1fb9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: iTXctwMZvbJ+c3U5XpI6QiyN91OgET8PaBmoFPbBmYQCwayFsbF0HgoW1IOUkKomy4vm8M9eCHwwkzPPgWS5Y7CbToqeZOL2whRkvozYraurz6bf+ICsAL/UfrHShcUVQ1F+88aBwgY4bVOPDzzPulhSSv2diAZ1QNPFPAc30xmp+Sl+URjYbMYF1D+jlGTj/HkZaC4EP7qZPhcMwy4AqeFwKk7JZeu5lmVdY1BlbCCHgjVSniqGUtNQamEyzNTKfc6pxot+SycxSzNW9R1iA64H7WqFguvGq9QTIJjqRk0jSp/BQY9HBZgeCpkbSDYluajjfAtQZrn5ekXVFRyn/fJfpwB83KSy0fdnolvtn11PGtkxZqyZf1G3qoWHYPkjQgEwyIhk8U7tAZyVS/Lfg0GGOPy+55uHXPOPt7s5mp9IOWQGotuKDaiiEimVAypVsjdfPI/Q9YOD2dz18vwcfmaBP8QPjbEBrnqmTSCLNKl3YvlHNHG2h8NNz6K2bMhfalGOukQIbEXrYXOR7tXn709crTusZ/p/4bW6S3aagRhCMRvTJsUSgH65/37TOSCRIgYqi5p773n3gp4ipR3wdKMndD5lFsKWGZYef8jO7lhId21MlpRZPXvmtdJMAjcrIhUngJ86UmCEqaop+/GQKNfjMUk1qQwZkXpqyJAxdW8nA3emGkMIUCUMreC+9+ow9Uo1Fv3gvA2oiwmoviqKKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ryTJ6gNXlY8ysyPDjxkA3k3+rX33+6xZJ9UipELTDmvIVMUrpuZJsalQGqFSeDCoVhjz7gOp4fisF2yZSiW6+V7zUpPxQ3nt3URwviMCTBTS3CliqGt4oHfy8S1WTk8oCmFTbiJ74ivFbrL1e8MgqWUx7K5bBCdi9nTwyhgzl9D2u4kPQOLSoadMVVJPlz5mnjwKeC+5UlwV15y9UKMX2QVk56ZxdyqPXA+4YyY8QATscmUL8lS7C2ePiR+BizaL9WDf6B6t+xo6eVcr4IJ2uACl7Awrajs/3BWjZHwclzwqiIaiTt0m204WKnjgqhWkR95MSOlwB0oWK6GmRWosPc/lIr4JhMqyyzgxmtSSprDhE+tHiDCrxGlWuHpsopgab9WExh7ion5520LHsF+laiHum07Pg6a7G0x8UlUWyKD3CFGJpdO3nOy5wufMPiZ6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 09:48:36.3792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2493231c-7982-4ee6-e287-08deee1fb9f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy8z0AwnNiefmUtv/EUVxE1HOzXp9OkAl8dNXWOgKjQ=;
 b=3n29fZ+9TiLYT3Z4s7sEJQE71z4U1aYup+QtFE7E/ljq+XgQlcfyfrdvUb+d/tG+fztJspPqZoeVkfutzZIAo7qtXFDfqKT6/kG0DUlj5BrZlyA4zwikfAoJI0UxKPopxXukKt2Bsmj6jTZ3wGyvPiUPCWyK+2FWYL6osyJ2kro=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=3n29fZ+9
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

gpio-delay had no sandbox coverage, which is how two bugs in it went
unnoticed: gpio_delay_xlate() never propagated the requested index
into the descriptor offset, so every consumer past the first silently
collided with the first consumer's already-claimed offset 0; and the
claimed/name tracking arrays were sized and bounds-checked against a
hardcoded 32 instead of the driver's actual GPIO count. Both are fixed
by a companion series that is a dependency of this patch: applied
without it, this test fails outright, since it directly exercises
both fixes.

Add a test requesting both consumers wired up by gpio-delay-test in
test.dts (gpio_a 9 and 18): a third consumer colliding with an
already-claimed offset must fail with -EBUSY, each consumer's write
must land on its own wrapped GPIO line, and a request past the
wrapped GPIO count must fail with -EINVAL rather than succeed against
a hardcoded bound of 32.

Gated on CONFIG_GPIO_DELAY, since not every sandbox variant that
builds test/dm/gpio.c enables it (sandbox_vpl, sandbox_spl,
sandbox_noinst, sandbox_flattree).

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 test/dm/gpio.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/test/dm/gpio.c b/test/dm/gpio.c
index b872dac9082..17a0dddf083 100644
--- a/test/dm/gpio.c
+++ b/test/dm/gpio.c
@@ -432,6 +432,75 @@ static int dm_test_gpio_get_dir_flags(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_gpio_get_dir_flags, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+/*
+ * Test that gpio-delay correctly routes each consumer to its own wrapped
+ * real GPIO line. See gpio-delay-test in test.dts, which wraps gpio_a 9
+ * and gpio_a 18.
+ */
+#if IS_ENABLED(CONFIG_GPIO_DELAY)
+static int dm_test_gpio_delay(struct unit_test_state *uts)
+{
+	struct gpio_desc desc0, desc1, desc2, desc3;
+	struct udevice *dev, *gpio_a;
+
+	ut_assertok(uclass_get_device(UCLASS_TEST_FDT, 0, &dev));
+	ut_assertok(uclass_get_device(UCLASS_GPIO, 1, &gpio_a));
+	ut_asserteq_str("base-gpios", gpio_a->name);
+
+	/*
+	 * Requesting both consumers must succeed. Before the offset was
+	 * propagated in gpio_delay_xlate(), both descriptors came back with
+	 * offset 0, so this second request would fail with -EBUSY as it
+	 * collided with the first consumer's already-claimed offset.
+	 */
+	ut_assertok(gpio_request_by_name(dev, "test6-gpios", 0, &desc0, 0));
+	ut_assertok(gpio_request_by_name(dev, "test6-gpios", 1, &desc1, 0));
+
+	ut_asserteq_ptr(desc0.dev, desc1.dev);
+	ut_asserteq(0, desc0.offset);
+	ut_asserteq(1, desc1.offset);
+
+	/*
+	 * A third consumer mapped to the same offset as the first must be
+	 * rejected as already requested.
+	 */
+	ut_asserteq(-EBUSY, gpio_request_by_name(dev, "test6-gpios", 2, &desc2,
+						 0));
+
+	/*
+	 * Drive each consumer to a different level and confirm the write
+	 * lands on its own wrapped real GPIO line, not the other one's.
+	 * gpio_a has no set_value op of its own (it implements set_flags),
+	 * so dm_gpio_set_value() routes through GPIOD_IS_OUT_ACTIVE.
+	 */
+	ut_assertok(dm_gpio_set_value(&desc0, 0));
+	ut_assertok(dm_gpio_set_value(&desc1, 1));
+	ut_asserteq(0, sandbox_gpio_get_flags(gpio_a, 9) & GPIOD_IS_OUT_ACTIVE);
+	ut_asserteq(GPIOD_IS_OUT_ACTIVE,
+		    sandbox_gpio_get_flags(gpio_a, 18) & GPIOD_IS_OUT_ACTIVE);
+
+	ut_assertok(dm_gpio_set_value(&desc0, 1));
+	ut_assertok(dm_gpio_set_value(&desc1, 0));
+	ut_asserteq(GPIOD_IS_OUT_ACTIVE,
+		    sandbox_gpio_get_flags(gpio_a, 9) & GPIOD_IS_OUT_ACTIVE);
+	ut_asserteq(0, sandbox_gpio_get_flags(gpio_a, 18) & GPIOD_IS_OUT_ACTIVE);
+
+	ut_assertok(dm_gpio_free(dev, &desc0));
+	ut_assertok(dm_gpio_free(dev, &desc1));
+
+	/*
+	 * An index beyond the wrapped GPIO count (2 here) must be rejected.
+	 * Before gpio_count was set from the "gpios" property, this bound
+	 * was checked against a hardcoded 32 and would have been let through.
+	 */
+	ut_asserteq(-EINVAL, gpio_request_by_name(dev, "test7-gpios", 0, &desc3,
+						  0));
+
+	return 0;
+}
+DM_TEST(dm_test_gpio_delay, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+#endif /* CONFIG_GPIO_DELAY */
+
 /* Test of gpio_get_acpi() */
 static int dm_test_gpio_get_acpi(struct unit_test_state *uts)
 {
-- 
2.43.7

