Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1271DC5DF70
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 07:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3FE8B80E9D;
	Tue, 18 Aug 2026 07:43:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xowgRRmRS4Mz; Tue, 18 Aug 2026 07:43:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6527080EDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787039033;
	bh=90jP9MGsQQqKXTzMAjBw4n8vu8tTUIy4edsckGcnZQ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W40mpAJQ3in9UaGwASoAY/GBHzcl0wtbETvFepKUruggsLe0PFSgIpfsNuHCmodYZ
	 rVcTHIxL8LodRD0WBqtMQINRrPRUgz3Opx37HPXW9QJC3rl8/jXgCIUSI0qgLIqUhO
	 jt3g8kczeNOC0DjeKq3HTSNLrOvxZE7ofzCYoh/HlnqGvba2STHG3ma2uYLmY8Bpkh
	 ajxb0uMzHOmYusbZv2QB45lnsdvvWoW4ejFtz31ZJLnfYP1eiSsSaY/B9czHDhXFGL
	 +NbPBa5cnk5BO47MH9Nm5Q28Ypu6/2fIBo34sHZzWHHdtYkbs1vu+g9lWDRmPlbXBS
	 PQbJ0tQm/7OAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6527080EDF;
	Tue, 18 Aug 2026 07:43:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 02A732EF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC6BB40633
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id riROQWF5mFAf for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 07:43:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C3CE6406AB
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3CE6406AB
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=Upko6rIw
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C3CE6406AB
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpntFQdanEsFe/KhxoBwL+MWlx+/J5CHpDyqE1tj+gtpP1G4FZzfWkzwCEVrYw42mtxs25T/beAqK5OXqxCkUknsKg+fhl0KniGxgfxo2OgeyOyWEzARfNo/oUtIPuALf16/qT4I1NJxFMo9UNhxq71u+kOTGGPT2PUvnnr6FJcbu8BWsyd0rtD0X7ReN/isLjpspIRw7rGLWrwNiOr/XM9pcDbK0M/4aOvdXGtXrmgdncObmiBmEUwbKAEYSwmyzTyL0TP7aZ5yb4/96KRuGIttGMQhEPb/OPqPxpZfywCCsW1OmOo+TXuwhytdoqP7XDdHLVMnGuMKJ7DVlcHf6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90jP9MGsQQqKXTzMAjBw4n8vu8tTUIy4edsckGcnZQ8=;
 b=ElTwDzkv7KiCqyI3a/ABVIiDhvD3p4UbnJqFxGMIXv94MOVKADPAhU/3byEEA4oP9exi29cohH8xZDOWbK040oH9u0wgFRasz2x74kN7gmMo8JSS15rslULi+xD3Kp7tdm3wfYjV+ZU5LagfV2WODzqEWPHzCNslg36GNk13JoBkxDERxD+DRzBW4pM0xTyM872qiG2P+T8U7SAnLMFE8r12k3ki/EnXvxC6oJZO4gwdJLQa6OqELf0gttgGhhYg6PY2eKtyzEqJTfWesbxhWNQIAZP0hme9YHrJihkRpBH10zagFqwhX+hoX7bPvqMEe9mgMgEInKKGiDWCRU9bdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90jP9MGsQQqKXTzMAjBw4n8vu8tTUIy4edsckGcnZQ8=;
 b=Upko6rIwggSghwdnvIZL9b+WKWsDM+dB9busCaPOGoxyxeLu2ypwetzWrCEyJdDCXGmweqfiHMRsuBtc5GJMNc43bObLFC78aV6YOSrGxKcUOF31268kr879sJFjSB9kGwE5p42PTYmcXsenaSJJWM0foAsOl48yrUMCH2B7s0gausw1TR5rFvSDCxnFVVeKWEcLRKTKiTu5UagEhwU3x9zyXnyoRaRJRFSCNsapM3Ias2eSDUUEqcJAsYNNPMDQVNHHa6tLJ3sUBgONXdo5+Vp80MOVzVmK63P4RQ0oGnBFecx/JWTHHXVDTa5Ue6BidWAOVb/9lphdJ/Hs6wgynA==
Received: from AS4P195CA0008.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::13)
 by DB9PR07MB10946.eurprd07.prod.outlook.com (2603:10a6:10:5f9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 07:43:46 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::a4) by AS4P195CA0008.outlook.office365.com
 (2603:10a6:20b:5e2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 07:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.6.101 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.6.101; helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Tue, 18 Aug 2026 07:43:46 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 06F811C0040;
 Tue, 18 Aug 2026 10:43:45 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Tue, 18 Aug 2026 10:43:30 +0300
Subject: [PATCH v3 6/6] test: wdt: add a test for max_timeout_ms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-rinta-watchdog-gettime-v3-6-423f5caf526d@nokia.com>
References: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
In-Reply-To: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787039024; l=4434;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=+0633BVh195Jcg8l/GDp1Ro98tvf20g06dKbvXNFfyo=;
 b=wrMQXiZ0RoGBEsrlXwglkH8EDr5m2gFpgWho50mbnYNBKOm/hL32w85f8Mjo6ldl73I0KODUQ
 S6UCNghJTdzBb10PNJW0SPVIdNxRLuqK1GxeYIzKGb7e118rhJS7I7x
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA2:EE_|DB9PR07MB10946:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1b6541-abd5-4b0f-f3cc-08defcfc6f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 65G4xnLCFClTnsP4C1grIQAsBODrVUWkE5dG0HECcyBOHeB4Ys3iEFZ1gT/gq2zXJm9xCHJxqs2RsC/pj2IAHlUKbB+i93BgE3sRo+XXKxzXE04RpHOsJOvqlfDpXYaTEOyd12hb6/ppaJEyG0rZ/u5aiBqIPsqSnNGx9Ym+k0prTRmrHvMuTluqGTdjBRwv30LsEZAV2UwbHT3ZE7R7zPeuJPxDnOYJ6HxL8Z9WM705fRpKw11/m0anSCljQevR8JXglNBQT4stZr7Xk0CB9UBe2Tnf+0FZvqe5SKePOpHigZPl9CWQubVfIvjBYpmAibCJeymEiKwjKk+Q73G8kJQHoif53XamedNZum9HuWw2gzmRLgZgTf0wFbU7EUpvEi5Lk68KQNRAie4zVGn2f7h2T8NglIsV4lK1UamtPh0hpIEIUbZSJKcYS0Q46EM0Xm/kdqtzncv1KSQHJOEEyGU82c0XwvYGYS1W3CgYLBjmbm+KU5ZcHrsBoqb/R3oeN3WMmaBPHYN9KI3662ldEhxE2whjo83kqND4AvErIA0AKl5pFwvJ1Py7oP4EPquCGgQzPhnFWY0o0/HgkRnGvJ4t+A3WvBu4XForn3R7dZzYNyYVt5uOKLf0Fy1VugAT7g1s6kP8IPHRDXYEzVgs2Zq6NXSg1vJZ7yjaYPI9TuquRp8+VkkxstL/XkmpOmVq5w077t5xHXn9aBIUvq+gTg==
X-Forefront-Antispam-Report: CIP:131.228.6.101; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fr712usmtp1.zeu.alcatel-lucent.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2/wD80Ux3jrfZiOwJ2vV77JRozZ6nD0DUVdi89ei6K59/cCVfYBxoyqikaKoafsceJSHw9nS1SE9rjF/iJJC7VL8gLPaewRrReShCcYa9fiVRCuClgHdJtOWanr/hii45aLyXYs/8KUGK2QwbJ7xWChmZvjTV90uL5zBjUj7wpcqwHamLD4oFIbGMgH87VIGYruZFTaksvzS1L4fQwx1lmOBsX/O9gwZRwbuDZJmKtrG6PCmDuxeBcWANqKBX/zJL+C8IvXn4jdrktAWkiOZtvYmlXIeE2bg1+7isnK3yfNZrG/F+8JB10ippcRKyuGGVQ7RZHzXWxOX55wavLwiCdKD3Amqw6fK/6f7rkFdruJt5/VnOGyEketqH084/iynq7E3Q4rIe5xwY8Z4FPBq20IXS2aTmS3Gk4++S/evdzMjAnkVfj8EUO/hT+/0iE0X
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 07:43:46.2435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1b6541-abd5-4b0f-f3cc-08defcfc6f5b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.6.101];
 Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB10946
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

Add a DM test for the case where wdt_start() is called with
a timeout_ms value greater than the (emulated) hardware-supported
limit.

Add console-print asserts for both the clamped and unclamped cases,
as well as for the per-device uclass-plat data max_timeout_ms field.

Add matching tests for the GPIO driver, which does not set the
max_timeout_ms value.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 test/dm/wdt.c | 47 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/test/dm/wdt.c b/test/dm/wdt.c
index bef29591d5a..2e9d641d6bb 100644
--- a/test/dm/wdt.c
+++ b/test/dm/wdt.c
@@ -3,7 +3,9 @@
  * Copyright 2017 Google, Inc
  */
 
+#include <console.h>
 #include <dm.h>
+#include <div64.h>
 #include <time.h>
 #include <wdt.h>
 #include <asm/gpio.h>
@@ -21,29 +23,57 @@ static int dm_test_wdt_base(struct unit_test_state *uts)
 {
 	struct sandbox_state *state = state_get_current();
 	struct udevice *dev;
-	const u64 timeout = 42;
+	struct wdt_uc_plat *plat;
+	const u64 timeout = 4000;
 
 	ut_assertok(uclass_get_device_by_driver(UCLASS_WDT,
 						DM_DRIVER_GET(wdt_sandbox), &dev));
 	ut_assertnonnull(dev);
+
+	/* Sandbox driver sets max_timeout_ms during probe */
+	plat = dev_get_uclass_plat(dev);
+	ut_asserteq(SANDBOX_WDT_MAX_TIMEOUT_MS, plat->max_timeout_ms);
+
 	ut_asserteq(0, state->wdt.counter);
 	ut_asserteq(false, state->wdt.running);
 
+	/* Unclamped timeout path */
+	console_record_reset();
 	ut_assertok(wdt_start(dev, timeout, 0));
 	ut_asserteq(timeout, state->wdt.counter);
 	ut_asserteq(true, state->wdt.running);
+	ut_assert_nextline("WDT:   Started %s with servicing every 50ms (%ds timeout)",
+			   dev->name, (u32)lldiv(timeout, 1000));
+	ut_assert_console_end();
 
 	uint reset_count = state->wdt.reset_count;
 	ut_assertok(wdt_reset(dev));
 	ut_asserteq(reset_count + 1, state->wdt.reset_count);
 	ut_asserteq(true, state->wdt.running);
 
+	/* Clamped timeout path */
+	console_record_reset();
+	ut_assertok(wdt_start(dev, SANDBOX_WDT_MAX_TIMEOUT_MS + 1000, 0));
+	ut_asserteq(SANDBOX_WDT_MAX_TIMEOUT_MS, state->wdt.counter);
+	ut_assert_nextline(
+		"WDT:   Started %s with servicing every 50ms (%ds timeout, requested %ds)",
+		dev->name, SANDBOX_WDT_MAX_TIMEOUT_MS / 1000,
+		(SANDBOX_WDT_MAX_TIMEOUT_MS + 1000) / 1000);
+	ut_assert_console_end();
+
+	/* Clamped, subsecond rounding ignored in the print */
+	console_record_reset();
+	ut_assertok(wdt_start(dev, SANDBOX_WDT_MAX_TIMEOUT_MS + 100, 0));
+	ut_asserteq(SANDBOX_WDT_MAX_TIMEOUT_MS, state->wdt.counter);
+	ut_assert_nextline("WDT:   Started %s with servicing every 50ms (%ds timeout)",
+			   dev->name, SANDBOX_WDT_MAX_TIMEOUT_MS / 1000);
+	ut_assert_console_end();
 	ut_assertok(wdt_stop(dev));
 	ut_asserteq(false, state->wdt.running);
 
 	return 0;
 }
-DM_TEST(dm_test_wdt_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+DM_TEST(dm_test_wdt_base, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
 
 static int dm_test_wdt_gpio_toggle(struct unit_test_state *uts)
 {
@@ -53,7 +83,8 @@ static int dm_test_wdt_gpio_toggle(struct unit_test_state *uts)
 	 * driver behaves as expected when using the 'toggle' algorithm.
 	 */
 	struct udevice *wdt, *gpio;
-	const u64 timeout = 42;
+	struct wdt_uc_plat *plat;
+	const u64 timeout = 4000;
 	const int offset = 8;
 	int val;
 
@@ -61,9 +92,17 @@ static int dm_test_wdt_gpio_toggle(struct unit_test_state *uts)
 					      "wdt-gpio-toggle", &wdt));
 	ut_assertnonnull(wdt);
 
+	/* GPIO driver does not set max_timeout_ms */
+	plat = dev_get_uclass_plat(wdt);
+	ut_asserteq(0, plat->max_timeout_ms);
+
 	ut_assertok(uclass_get_device_by_name(UCLASS_GPIO, "base-gpios", &gpio));
 	ut_assertnonnull(gpio);
+	console_record_reset();
 	ut_assertok(wdt_start(wdt, timeout, 0));
+	ut_assert_nextline("WDT:   Started %s with servicing every 25ms (%ds timeout)",
+			   wdt->name, (u32)lldiv(timeout, 1000));
+	ut_assert_console_end();
 
 	val = sandbox_gpio_get_value(gpio, offset);
 	ut_assertok(wdt_reset(wdt));
@@ -75,7 +114,7 @@ static int dm_test_wdt_gpio_toggle(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_wdt_gpio_toggle, UTF_SCAN_FDT);
+DM_TEST(dm_test_wdt_gpio_toggle, UTF_SCAN_FDT | UTF_CONSOLE);
 
 static int dm_test_wdt_gpio_level(struct unit_test_state *uts)
 {

-- 
2.39.2

