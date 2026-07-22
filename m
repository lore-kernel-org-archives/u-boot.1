Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76816C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 10:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C73540874;
	Wed, 22 Jul 2026 10:58:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ga0dizY2102p; Wed, 22 Jul 2026 10:58:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 417EE40880
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784717908;
	bh=+c7bByuxeEhsNuslwGmPj9916Q7kGnSmxhHvTk6EPak=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=w9X0Wz2W8IPTPAWpmtM6uOZr1Sdg9L6zPu3G88H5vzZW6ZPMk215QxKFgV0PPN6Gv
	 +UIzC9uc8VqdK8Rqs8KuPIB1TueFWnIp80QURIH7vHNRPognYrR89hj5vBbaUGYAJg
	 1OBalQRffeCaB7b4HhbI+jLjU7DY9X0Sy4xXBDyGLp7sgU0e/Y3Ri/tdQr1lOcTktv
	 aNtkiqsOdojdMoxdPFb3BCbzSQ7CFYNaWaT9rSxayHbgdf9vNXEjg8xtRGvpOU+CK5
	 pRc9cN7WIn0iwL55LAeiwCRFRuorgLrSWiL9l15WGD3e/qqTX9gq9qqisXSCgf5HCU
	 1ySLEWzGjtM7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 417EE40880;
	Wed, 22 Jul 2026 10:58:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C7391099
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1C6540080
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vEbb_AIJp9Ky for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 10:58:26 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AB0494007A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB0494007A
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB0494007A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB658848BA; Wed, 22 Jul 2026 12:58:23 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C12018493F
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 12:58:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuFaIlcvHwLLgce459PlhaEDgPsmvbTFLADWsEAn9HWKIsx991INiItbSo+4IvoZyIDvxpCub+OHK9PFrbQRMgmabawsY9GLmhyaiN4bHRYNvREDZT9GoC1l73L3iFtCuXp1Sn3+qKW0+ifwVdq9w6Aatg/gnkUv8OLkRYjt5Gms7ZUYgNPl1Cihb0SXcUSFWsvmha7s6U0Sac5zqrMyuj6ciTzS/sRtG+iNqfRjSFY6Eh4qhpEcwi4BzwGCXF5DmwQu7ZhFlQtKm+ZvY9IwqH/OvpVMXCkfkUqsL5WELaasRTPZvdgWigoi4s1nvT6wlr54H8FijV95M9hwg5NLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c7bByuxeEhsNuslwGmPj9916Q7kGnSmxhHvTk6EPak=;
 b=sDunkDighaKwSCvae0MFhW6OGbNY+uwiqM+PqFnh+i7Wg7PhYCc9lTI7oYYYyHPAlv5yVk+vnYANcJzsUMzz8YBMyR6L4fYVnWMpoX6iePvUuYbcS2q81mqoYuWlUMGXACDVH3vYtpOh3DJNkkjCVuDGv6BOZE+1Cum/r8DeNPSKtB1Y067c70aQ0aWPA8+qtYEhd/C+H8c0KemtqCcuGK3DigUvYzhCkqCpxbzw58W3mdAD8/i7svToOarikLkhMXlkMOK46pxYx7fasppXGRKIXoUraFE0RU+G5/dHaWgQDGek8HM+lF42kk49NXtJCFzmcZ7VIGzQVfVtd0Y1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.84) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
Received: from AM0P309CA0001.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::35)
 by AM0PR07MB6292.eurprd07.prod.outlook.com (2603:10a6:20b:152::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.4; Wed, 22 Jul
 2026 10:58:19 +0000
Received: from AMS1EPF00000093.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::c) by AM0P309CA0001.outlook.office365.com
 (2603:10a6:20b:28f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via Frontend Transport; Wed, 22
 Jul 2026 10:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.84)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.84; helo=fihe01smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe01smtplvp01.emea.nsn-net.net (131.228.2.84) by
 AMS1EPF00000093.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Wed, 22 Jul 2026 10:58:19 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe01smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id BB74880000AE;
 Wed, 22 Jul 2026 13:58:18 +0300 (EEST)
Date: Wed, 22 Jul 2026 13:58:03 +0300
Subject: [PATCH v2 5/5] test: wdt: add a test for max_timeout_ms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-rinta-watchdog-gettime-v2-5-39e249500543@nokia.com>
References: <20260722-rinta-watchdog-gettime-v2-0-39e249500543@nokia.com>
In-Reply-To: <20260722-rinta-watchdog-gettime-v2-0-39e249500543@nokia.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784717898; l=4403;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=Q5UICXGr9TroOg1obVrNc4woBqdUBo9Q4zm827KakqI=;
 b=5Qevm1i1MzemEdSehSCWwCej5NAZoFDuTLhNyZABdJzUv69gpQX80wuGQRZBEHBQOxj68ZQV5
 R6s6EvRNEjsDjkyAKgoAv9sbJOLuWVezJQwln45TgsZqtIgq2Fmcuc6
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000093:EE_|AM0PR07MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: eff357ba-ee2a-46eb-bebf-08dee7e023d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6P7bOfbupxF43SIorg4Y7k1Gnl4zu7Zhx/RqSEL5yBCmP5IidaEuGteqTFuVQl54JgAplZby8FiESdRbRmlCNv0+MevZGREyU1bkl96qncliQ5ikSt1S0++eVjtnf6i8zPSgcqfQFoeqH3+s8Dfp8zzY6U6FZ/gb6KgFYG7YgZztBifBPpTQ0THD8sSl1bzCJ+GGAexQmBPmOaV60qxYl6Q2QeIJZXB9WJAXuHnL77qPJDBaszgICULmRENL3jKt5jxBb/SFsY9szaNc44WrajvUEicggc5u7QU8D9Yxzfy3B5FIwPnd0MxcNYT3rf5WTmsVo3T6GdfhpK4YGw1qUdE7qKw9ANFf5W3BZtFB50eJ8gytIOAy7VQwU5on9U1CbgTYnBhu5aTEAR3KW+H5YMblK/peUFOW3C9TD4AI/6h5/mf9hBBgT2+SIM8KEMLf6CSDEQ+RUem8lovuBDuhT+kaX37NHOOxvIDZawTb8EW1o+KRkKPOAVceD3BGKcSgI9qLPjSh7E/WHzlY54BR14jiX9M5X5PMdED8jqQYgyD/DrROHyAEBOhlbyTR3uOZLI9nO/6CwLimB2IGT2fIMF+m+aMVP8Bi+uaYyDWTC3QtfCpI9vtVIVnmhLB7iRSROVOdVG1v5AR+oFkOo3w9nW28IqJGV1EVGBf9zYEAO5dwriiiDAj/a4dClj1ljSaB
X-Forefront-Antispam-Report: CIP:131.228.2.84; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe01smtplvp01.emea.nsn-net.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qBk3+PCUxaQOPOvSt6yowPpFLfTvliBYYxz///ZYFicsy0j4l3sd99ZWZEDNBzq2AnVXQslmpvUdU4nwV8vgNPMSmBfT51U+T7NiilddDPR5yxUBnTJB+PAmWVOpCxcGkv6Wm2wT692ksYMO3XazPn///+I5iqMeVn69tbSVjhGV3OrfPbaXLYOzYikjSm4Gctipzchy6UwuwrKGrF7SyZiaY6s7Fn94qeW8fNnM+AeTABXnj0NsMVYh2DkeBLRarE+fFhP0XRnzXw/KEcaTKr3wCWGO2AUcIJD5wcW1D84kYeCsIcO966ZEw13q2mtANJDEKgHuobYQEQtB9wkf9UVFQ6vm6PBvfkKz/Sj11/l/iblPqgvxoqmktS7bpf2Won/hXz2lTOmbP3Feh/q4OkLSSW6mE31wA+7sYzNbqCxf8trUml/ztO1XoLbh8iCA
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 10:58:19.2059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff357ba-ee2a-46eb-bebf-08dee7e023d7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.84];
 Helo=[fihe01smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF00000093.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6292
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c7bByuxeEhsNuslwGmPj9916Q7kGnSmxhHvTk6EPak=;
 b=gLXhNE+PFygec/PXQFHZU25bcd1bo9+LFmP831Fw9o2qlxn0Mk3KeNfBfin3GLZ41HsEzjaKxc2P3TbpJ/cqJWErXeIy46ECNptol5Y1cGsZVDPrp9VZ2Mx8RK2osRMN/vgf23QuN316QtWHspoeBC2Ckl/BBegS29SqFHvvOKcflvsiAzCAdP0re0xn3gd1Bl66kDIEU29cc6ql8OfcecfCLQqjaW3PXdcNe5gx6DJ5uPzbw3CH5qWNV28XeSlJOOZT4+ISTFuOBMo/HAIRT88Ri+Ybw4Kjss8Twb+xynGehHOH42Zh2nZg6eS+CLmvRpfhcGYpJb6+aYNSiLo87A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=nokia.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=gLXhNE+P
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=nokia.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=juuso.rinta@nokia.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=nokia.com header.i=@nokia.com header.b="gLXhNE+P"; 
 dkim-atps=neutral
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
From: Juuso Rinta via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Juuso Rinta <juuso.rinta@nokia.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a DM test for the case where wdt_start() is called with
a timeout_ms value greater than the (emulated) hardware-supported
limit.

Add console-print asserts for both the clamped and unclamped cases,
as well as for the per-device uclass-plat data max_timeout_ms field.

Add matching tests for the GPIO driver, which does not set the
max_timeout_ms value.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 test/dm/wdt.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/test/dm/wdt.c b/test/dm/wdt.c
index bef29591d5a..d86620b25ab 100644
--- a/test/dm/wdt.c
+++ b/test/dm/wdt.c
@@ -3,6 +3,7 @@
  * Copyright 2017 Google, Inc
  */
 
+#include <console.h>
 #include <dm.h>
 #include <time.h>
 #include <wdt.h>
@@ -16,34 +17,68 @@
 #include <u-boot/schedule.h>
 #include <watchdog.h>
 
+static void format_wdt_servicing_str(char *str, size_t len, struct udevice *dev)
+{
+	if (IS_ENABLED(CONFIG_WATCHDOG)) {
+		u32 reset_period = dev_read_u32_default(dev, "hw_margin_ms",
+							4000) / 4;
+
+		snprintf(str, len, " with servicing every %ums ",
+			 reset_period);
+	} else {
+		snprintf(str, len, " without servicing ");
+	}
+}
+
 /* Test that watchdog driver functions are called */
 static int dm_test_wdt_base(struct unit_test_state *uts)
 {
 	struct sandbox_state *state = state_get_current();
 	struct udevice *dev;
+	struct wdt_uc_plat *plat;
 	const u64 timeout = 42;
+	char svc[40];
 
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
+	format_wdt_servicing_str(svc, sizeof(svc), dev);
+	ut_assert_nextline("WDT:   Started %s%s(0s timeout)", dev->name, svc);
+	ut_assert_console_end();
 
 	uint reset_count = state->wdt.reset_count;
 	ut_assertok(wdt_reset(dev));
 	ut_asserteq(reset_count + 1, state->wdt.reset_count);
 	ut_asserteq(true, state->wdt.running);
 
+	/* Clamped timeout path */
+	console_record_reset();
+	ut_assertok(wdt_start(dev, SANDBOX_WDT_MAX_TIMEOUT_MS + 1000, 0));
+	ut_asserteq(SANDBOX_WDT_MAX_TIMEOUT_MS, state->wdt.counter);
+	ut_assert_nextline("WDT:   Started %s%s(%ds timeout, requested %ds)",
+			   dev->name, svc, SANDBOX_WDT_MAX_TIMEOUT_MS / 1000,
+			   (SANDBOX_WDT_MAX_TIMEOUT_MS + 1000) / 1000);
+	ut_assert_console_end();
+
 	ut_assertok(wdt_stop(dev));
 	ut_asserteq(false, state->wdt.running);
 
 	return 0;
 }
-DM_TEST(dm_test_wdt_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+DM_TEST(dm_test_wdt_base, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
 
 static int dm_test_wdt_gpio_toggle(struct unit_test_state *uts)
 {
@@ -53,17 +88,27 @@ static int dm_test_wdt_gpio_toggle(struct unit_test_state *uts)
 	 * driver behaves as expected when using the 'toggle' algorithm.
 	 */
 	struct udevice *wdt, *gpio;
+	struct wdt_uc_plat *plat;
 	const u64 timeout = 42;
 	const int offset = 8;
 	int val;
+	char svc[40];
 
 	ut_assertok(uclass_get_device_by_name(UCLASS_WDT,
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
+	format_wdt_servicing_str(svc, sizeof(svc), wdt);
+	ut_assert_nextline("WDT:   Started %s%s(0s timeout)", wdt->name, svc);
+	ut_assert_console_end();
 
 	val = sandbox_gpio_get_value(gpio, offset);
 	ut_assertok(wdt_reset(wdt));
@@ -75,7 +120,7 @@ static int dm_test_wdt_gpio_toggle(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_wdt_gpio_toggle, UTF_SCAN_FDT);
+DM_TEST(dm_test_wdt_gpio_toggle, UTF_SCAN_FDT | UTF_CONSOLE);
 
 static int dm_test_wdt_gpio_level(struct unit_test_state *uts)
 {

-- 
2.39.2

