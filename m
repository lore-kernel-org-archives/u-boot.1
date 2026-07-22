Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6014FC44532
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 10:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABCBB80F0F;
	Wed, 22 Jul 2026 10:58:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e47f-cRAIWHA; Wed, 22 Jul 2026 10:58:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A531780E2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784717914;
	bh=avlwvcQX2n3rhuYoSrgBNkTMICjyerXFdoWu0rOLdy0=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=v7M9z69m6c6Q85wyHVEXfq1PMbAhH8hxWh8ezL01YT2TuisRH7dnjonXdfpW+Dbf7
	 BJXBi1gIMel9Nj/OIwYnhPWAY+nt5XCI7LKArKvgs944Q4II0omy00ra75j/c3zZ5n
	 zNt26HrqIDFMIVgfdvyQB0uXwJR/Cyzo6Klbip15W7xLosJljEFukfy04t9g3NfJv1
	 KmCVvb+CgTzZ9XvIgrAMoe6I3BvaUbwFb2kePru2K1fRthQj60/GxDocZ+/HcyB0Ts
	 rKfnyWEfBZscaAyq6kZtipK89zPtcV2QBw9MmIWajGQaFfDpxc6m7rHpAmqzBx9EYO
	 9G3p5NjeNuFDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A531780E2C;
	Wed, 22 Jul 2026 10:58:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D1C5A109F
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2ECF4087F
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WtFJndEwgFIG for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 10:58:28 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 83231407EC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83231407EC
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83231407EC
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9E54803F6; Wed, 22 Jul 2026 12:58:25 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC228498B
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 12:58:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F91hl5BHezjMSMhbhLCzKuVMzQGrB4C8AdRDNHUOSoTl/hNLYGFD6e+O4Fx7icDcdK1Xs+jl0g/b+LBKJ707xVrNJvGS0HuQqA8Zr/1xn6alCPak4dtj2Ld00RqA0Jkw9YHD57YMQllDEygvO4lH3G1axEguplMMMxbNKfgvT0odnMrG1Ms5K05walkcy0n85LBDMY2CLiRkZ4BzDlREOZoDVbxTdGPbwA3VPu77b6ImKPy17qa0HFJQwM+grph7gI/9h+ugsfM6XJ3mU6TflHFhHlSOsGSKTd1F0SlDgETE3H69bMTdLmOm0/udrlWJgB1QwL1FuBsBiqhptVF8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avlwvcQX2n3rhuYoSrgBNkTMICjyerXFdoWu0rOLdy0=;
 b=RF7ij2xixktM7pEhYz9WgFH0JgLymE5nVtLUNwYqjKEcVhoDcISa5pWzRrZsaJE9tXLZHNYRrzRHJPZs72uj1XMNlUk1UW2yRdAr1penPtR/6lygND3R2QcTYbociN0QcCVwzqPXqn+ClajVGq0BPCargFcDGRJnbhZ8C/SGx4/NFc1zAEZveh9jheq/f17ue20hOU77xy7qgS0kB8pkKEWx5E2GLCneAygR16MTjDEOUTPi1AoD6FZSoTiVkTH41f+5QMhLoTzzvcrZqQi1FUPEsccAaLFELcAojywvJIlGCsUJPPyN2NWh1Yc5S1NvQrJM6y/6Ybdj66IwSE0EsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.84) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
Received: from AM0PR02CA0145.eurprd02.prod.outlook.com (2603:10a6:20b:28d::12)
 by AM9PR07MB7778.eurprd07.prod.outlook.com (2603:10a6:20b:30a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.5; Wed, 22 Jul
 2026 10:58:19 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:20b:28d:cafe::a9) by AM0PR02CA0145.outlook.office365.com
 (2603:10a6:20b:28d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Wed,
 22 Jul 2026 10:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.84)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.84; helo=fihe01smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe01smtplvp01.emea.nsn-net.net (131.228.2.84) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Wed, 22 Jul 2026 10:58:19 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe01smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id B48188000097;
 Wed, 22 Jul 2026 13:58:18 +0300 (EEST)
Date: Wed, 22 Jul 2026 13:58:02 +0300
Subject: [PATCH v2 4/5] watchdog: sandbox_wdt: set max_timeout_ms in probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-rinta-watchdog-gettime-v2-4-39e249500543@nokia.com>
References: <20260722-rinta-watchdog-gettime-v2-0-39e249500543@nokia.com>
In-Reply-To: <20260722-rinta-watchdog-gettime-v2-0-39e249500543@nokia.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784717898; l=2211;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=HyOUyDpFCatif0rH89qZ64AgYE0pCQjEVdwsviJfcvs=;
 b=oVP1hb9XGEfLBBPnZKo5Atzptbmns+Wsk8lvD05R0A6m9zfJWd2ApGyyw+eykwabLkMTG9Qqv
 cKXUw8rbeqRCLwCmcF17G3dhaGaWZJ9XFS6bG2xXt0MJaPkbf08p4YI
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000194:EE_|AM9PR07MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e9201a-ef74-4983-a531-08dee7e023d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: qcBsJgsUF73f/vdp5L/8Uvs8aJiFd0cMPHkTv5msnhlQKXK/mhTLAY7PXNxx02YJ2ZT7/QE/1ZbcEF7JlcC/BxbapLlcaDQis2djOBEfXoeIjIMmgyTOpRBFxhvSbYBUQV9++2XNIoTDac7L/sjZOjasjLhcnqH7NaoU2hxIBhql6BUSZDVh4zbLuIdP135dIIaC8dRdh12bqZ75pKBGCAmgJXZg1QmxlEZo0GNGep3eZjr3s0Q7BCcwBF/pM3dIoXbmHeirz0dN8zLfeGoUk6ja546UUU0b9QR7q36p65hLOd5N6+oPZ+jJ78sxZ9w0xP7sZSNSf8Pobj7IwweJunL0JtuKb6GK2miuI3vS83+szrPXUO+LdjwYKmLhxcCXoCCTGTZr1V+q2g3myefcPC6kti3alljWFC5XKm+PT+EqoeRAi6VxfTr4vnPv1gc+gvKFt6MyMZ3TPoj6O+RTZhvBXOEXjFlgq8mPGX4IQ863FmZthEk+0OdkS4p7LXotIsqyKWsWgeGDHhuXZXfIPv4Tj4zpIqNUhORI/kFlgNi+HUe67v9JxoXF/VKq963J/BqRow295qKh5iCHvBdKdK4uaGKrE5dIZySq1vRAm44DLl47OfIvFFU7Krj1qmZW3l/jspHnIhq7mMje/h2bIgy6sO350KuDrzjbD12W/WgFWHnVo73ON0LIM18A1rb3K/GzPj1GEEUr6renqxafqg==
X-Forefront-Antispam-Report: CIP:131.228.2.84; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe01smtplvp01.emea.nsn-net.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SvpPLYsn+xyJ/TW1JUHugdvwUfGg4W7ubO3JiASWPEPrUHKI2+J7S4Ax3zngOuqRKpEKVQSXygF/T04UdkPYoqvV7HcW9wWvhqp7PdoAKmp/e7vjuECsfL8paNO+sAU/nt8v6aDzdjJm7stNZR7TGVUt1wSqKyn0EGsEey1cI+FuwEfG6C4ttnxITsMUT7YR7GLAa+GpiNK9c8PbJvVH9UuvTKvleccggIg6XO6+plBSNXjizbBEsTK2vuJTmJF68Rv/3eWyGS/vm7uXVehYzTtOInZyxEPiXvJ8wDZuH2zuQ6RB/mvTwgv+UrXLtVNXXYY1D9+cQ0KH0LgRsTJhG3D24yUvhyKjO+gAyJbJlcpMwAHTz0zrcyGOUg8KU/JkWPZtgGcXPte8ibEomsXnQdOQILLH50X6/6V1WQ/g4c+ynDh8zsglcJ0m99NgnEZQ
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 10:58:19.2086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e9201a-ef74-4983-a531-08dee7e023d6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.84];
 Helo=[fihe01smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7778
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avlwvcQX2n3rhuYoSrgBNkTMICjyerXFdoWu0rOLdy0=;
 b=bTWagsmSfRI3Yu8/glRwIQEhje+I6FwI6CCstFVaL7qBjzzKPyZwroX+2wDFK6elkR4i2cABOYkDpqVNc1s/k5D5EcyxMWZ22buZikadCnX58TudiS+eZgzgY68YYJ0HAVrQK0UWPaPmAAl7sS0DS4eQWfZU7BRcA8spmxEF1VTg55e0aykDK8yb3SJQBBD/ndOjGpPyO35ydn67SEEdKSlKk12OXTUV5P0EIBt6qYhYE3EdkP6a4aoHd/hPxixb58uhoYCd+nH39bHgdbrkihwfj3/nX3Fi24+tRCxRIUya/R1tkjvtTatq/IXdL2aIWeqLKTW6xqmB5Rw6MC39UQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=nokia.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=bTWagsmS
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=nokia.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=juuso.rinta@nokia.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=nokia.com header.i=@nokia.com header.b="bTWagsmS"; 
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

Add a SANDBOX_WDT_MAX_TIMEOUT_MS define to sandbox asm/state.h
to emulate a hardware-limited maximum timeout.

Clamp the timeout_ms in sandbox_wdt_start() to the defined max
timeout value for testability.

Report the maximum timeout value to the wdt uclass by setting
max_timeout_ms in the per-device uclass-plat data during
sandbox_wdt_probe().

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 arch/sandbox/include/asm/state.h |  2 ++
 drivers/watchdog/sandbox_wdt.c   | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/sandbox/include/asm/state.h b/arch/sandbox/include/asm/state.h
index 9dea0980bfc..742e4f5c6e9 100644
--- a/arch/sandbox/include/asm/state.h
+++ b/arch/sandbox/include/asm/state.h
@@ -38,6 +38,8 @@ struct sandbox_spi_info {
 	struct udevice *emul;
 };
 
+#define SANDBOX_WDT_MAX_TIMEOUT_MS	30000
+
 struct sandbox_wdt_info {
 	unsigned long long counter;
 	uint reset_count;
diff --git a/drivers/watchdog/sandbox_wdt.c b/drivers/watchdog/sandbox_wdt.c
index cd5eadbfd21..d64dd154c70 100644
--- a/drivers/watchdog/sandbox_wdt.c
+++ b/drivers/watchdog/sandbox_wdt.c
@@ -11,6 +11,10 @@ static int sandbox_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
 {
 	struct sandbox_state *state = state_get_current();
 
+	/* Clamp to emulated hardware maximum for testability */
+	if (timeout > SANDBOX_WDT_MAX_TIMEOUT_MS)
+		timeout = SANDBOX_WDT_MAX_TIMEOUT_MS;
+
 	state->wdt.counter = timeout;
 	state->wdt.running = true;
 
@@ -43,6 +47,16 @@ static int sandbox_wdt_expire_now(struct udevice *dev, ulong flags)
 	return 0;
 }
 
+static int sandbox_wdt_probe(struct udevice *dev)
+{
+	struct wdt_uc_plat *plat = dev_get_uclass_plat(dev);
+
+	/* Store the emulated hardware max timeout in uclass plat data */
+	plat->max_timeout_ms = SANDBOX_WDT_MAX_TIMEOUT_MS;
+
+	return 0;
+}
+
 static const struct wdt_ops sandbox_wdt_ops = {
 	.start = sandbox_wdt_start,
 	.reset = sandbox_wdt_reset,
@@ -59,5 +73,6 @@ U_BOOT_DRIVER(wdt_sandbox) = {
 	.name = "wdt_sandbox",
 	.id = UCLASS_WDT,
 	.of_match = sandbox_wdt_ids,
+	.probe = sandbox_wdt_probe,
 	.ops = &sandbox_wdt_ops,
 };

-- 
2.39.2

