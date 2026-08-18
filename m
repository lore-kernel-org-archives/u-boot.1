Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D27C5DF7E
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 07:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02041608A3;
	Tue, 18 Aug 2026 07:43:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fCOtlT85EdKw; Tue, 18 Aug 2026 07:43:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC3E16084B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787039036;
	bh=/kIHMl7BNk/Nr+/FK+ODnx2w3I0cDq3OgEanQwMcWAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QhAjXuf0pS+gjnEvvhzcfJ8T7tsHqAVHDmMAxICgGS9tg2806BhK7x7MsrUAEfrP1
	 F5XzfE4RPuaNzXnXAWY9mL3LBVowVdlS4hd8ZiRaX6/nUOoJHe9NxxgDUdDSsI2M5g
	 QE+a6bBR+BYWrBT5cb2325MDcOorPVg/QU62oYZzNuWVPdCTQDLEgVu2h2S+Zh/NrC
	 Qn4ruafv8cJ4ozMB3hJ7ZD+jA0M30dulYNmqqK2ULlJkGTa691NXXLUz0uAqgDdR2H
	 zdjvX6n5NnRLK5jj++scleVMNXQ67svg8wcsm7a4N8Fs8fuDviuQs4MB8IqWqB7fu0
	 rI7dIBJWVIkPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC3E16084B;
	Tue, 18 Aug 2026 07:43:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 955C325B
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 87A3580EDF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QR_dWUksmDfF for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 07:43:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C2A8080E9D
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2A8080E9D
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=n+CU8xZr
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C2A8080E9D
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7ZKh2VCjnyHovfYJRcicdDJaDSWCzeRXik/QfwOqnNa7K+YTGQWgtdROclzwbk/x7P1medILvvXOmml+IGUC/LTMPMdgKOCNUVrqEvxgjSy82I4MHZr5beJ7ICOym9IsKUmGKwx/4V3YNIWpypIFrXFQQ06Rb1+UAY8UCqsK/HN/QgZkkhHsrDy4Zlp6phSFse+a1rbJpfPZtJeckYNMODpqY3NG6USQrX7G1QEIpleMcr4THSF7HwmwGca822zYuCmE6f6hMg3QuEY6cR39gbZRCfaxegaF+w7S93bznzxQj8cM2LvLHLL3uBeHR1zRRz+ejcFqgXEjmA0MsAPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kIHMl7BNk/Nr+/FK+ODnx2w3I0cDq3OgEanQwMcWAI=;
 b=wRz6M358ZWHEhfk764+oC2zRADNJiVI2HmiXYrP9+w5MA86Bx/ZvgZcq8aRoaWYAGQ4OdqYEkqL0Pk+mcRo2Kn35/emJZxKOK82zLZLNY8tB6BJlMS6jclCTbGEnnQFNB2Ga5VmXKzNlpiIu6Wn5fT1+qNR1bbjdaZVA38te4fMnkMZWm5e28oTZytTloPN1Cmn2LmtX8BxFn18n8Z9Y3O+jE0yNUngjWP1wK2IqH4H78o/poTA0A7Lztxwmy9qCZPXs8GD75jEhy+3mAv8o/+ZUIsHUe49uRNkvR6JU2ovBmBuAqptuTeQX5oGSaflLnZSTYZewjbaMupwo4nq7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kIHMl7BNk/Nr+/FK+ODnx2w3I0cDq3OgEanQwMcWAI=;
 b=n+CU8xZrMomcejWBFzCsZOCFFK+vuNWIfzJdLyTV8qKJful4jGQWNvg9svXKBagHFODV+sEACnkr0TwNyo3HCUBPuyeKS7V2LVXV6A2ufJc3JzpDyP8xpYCEsqlxqOUgV2zKkuEtOve1Sgp79byj+quPjvkyBxxutjUvR6hDCF1W9TOEJX1qg8CkJXgNldg9AR/8UFZHrquXxExWsiH3AggfmKp6Gf8ss2eDTrrRo6AMfpI5IWcPrkU+3aElN+oi5ADxl29tHcTFX3V0WN+J/Gc3/chZHDl+kTgJRGbeqpD4jOdpnWieYY2qN77beEmTwLHOMSh7nAChCgwuX9x1Tg==
Received: from AS8PR04CA0024.eurprd04.prod.outlook.com (2603:10a6:20b:310::29)
 by VI0PR07MB10149.eurprd07.prod.outlook.com (2603:10a6:800:25e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 07:43:45 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:20b:310:cafe::91) by AS8PR04CA0024.outlook.office365.com
 (2603:10a6:20b:310::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 07:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.6.101 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.6.101; helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Tue, 18 Aug 2026 07:43:45 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id EFE3D1C004F;
 Tue, 18 Aug 2026 10:43:44 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Tue, 18 Aug 2026 10:43:28 +0300
Subject: [PATCH v3 4/6] watchdog: octeontx_wdt: set max_timeout_ms in probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-rinta-watchdog-gettime-v3-4-423f5caf526d@nokia.com>
References: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
In-Reply-To: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787039024; l=1680;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=2GCLSdoMevILWxMeYC/kUjryv+SKE6TaERrz3BGig8s=;
 b=bLRdn/Z+4zMWsV7OT+r/j7C6rl5UZDL5QVBWlLrWGzJfHlSONmJkxJ/MJAK1bvh1pr5m2HLmu
 HDj+TdDvmgpBmJk/zy0kOdXizGI16SckT3U+BEOIw6kaGcoFua9vMnb
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|VI0PR07MB10149:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed93516-9c49-47f8-2e7b-08defcfc6ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8/eTFLLVvfcfoaVjW6zpuXkawwIKqqhxz5D5Vb8gia8X5QNuugm2y42BaNX+M7cvUZGYJXJOPZDZlSmpsPSwPj2JoqGiuphNDf+t6uQHzWtdGExPmSMgeHxsewxD+iimccWKcYAMIYT5roRS+No1CN6y6oeCOM7dXUZEh95qgwH4AXi/VC7+/I0zX7T5Y60YLYU+YqIUsj0GMtFQCyEmZyUyo2SMBGn5ojQVtula4+7+2znMvTOHeVtJM1nafKMm0SNRwHdW9Y6JRiUUCuZJlzs/ke8qQhDPJ7wHB2AyemfBAyiSlJYRHPApc2r0BqpvbRa2eVkNEzG0H4KbBz8ndI98aW50kEiCik0mWzKiH3gOvqKW6Sei0qGYg6JKq+ZfmVPx933LDjcep7S8f+TJcnQjzb/s5aXicZ9u+A7j6HKKjI8TvBZEVHJbKeZ+g4EhoVJtMamuJdFqwaQpH0B518I3RMLnNffV+wP3ktTyyE5Sok15nPkQBmL0OdURlz/2vpgdQkHbq+BM4lU1O2Ra+pk04WdsPnRAJbyF2cDhuOB0OawuaPXPZQG3VmhlgdPKP0BqTTeBQvw+Bgh9cetSyocHBNWCdWxnMqZ0ulVkqd1P7T7OgiZDnhRnYobNXz/2nOi/doRmC0sBiig/VGOtxaeG+tSWXAThfS+XDdOwQ4YbLwB7t9XIBpSYL6t92YFt8Q83mntTUzpoKIcTelao5A==
X-Forefront-Antispam-Report: CIP:131.228.6.101; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fr712usmtp1.zeu.alcatel-lucent.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qHbhl1fDd6T+Ah49pvfdB2NHKa6zkB8EPIgAL+Fy1GVFCrd6Ge3QAdItcg4ImlDn+YGIczdf16ES3VUaJ0EIMgR9zfvytKyDCT05Wc1rytTBH1vbov6DxQF9DzGhtYPwStJ3SzAogWdamMM8x3Q6D7ZZrvDXTg5u0ZH17JHXrpe++8Q6Gy1EbONydE2y/nYtFKSyNNJ3Cp+HcTFIXZzsU6x57FeMZeYJDeP5oNCM4ZXhlFCI/26dJXEezE4yDDYpMlHLqCSZ7T/7OREn/gDIiZ4LVosQ8qEZUaoywdvH8EIqDif//mwhtghheahzJ3/1t/27YYO9d+yPm2ojoLDWhZwPdcuO51QsUdjUZxauPkup83FR3pa5Pw+r7PNiidAeTxhsI2Kr88KbwmKNoMEkQqf0cixXWdGMzEVPCjcudVEauNGlCL9x9u4RgCuffUaJ
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 07:43:45.4783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed93516-9c49-47f8-2e7b-08defcfc6ee6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.6.101];
 Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10149
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

Report the hardware-limited maximum timeout value to the wdt
uclass by setting max_timeout_ms in the per-device uclass-plat
data during octeontx_wdt_probe().

The timeout is programmed via the 16-bit WDOG_LEN field in
configured steps, so the largest representable timeout is
(0xffff << 8) steps. This is then converted to milliseconds
via the timershift and clock rate, and set only when the rate
is valid and non-zero.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/octeontx_wdt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/watchdog/octeontx_wdt.c b/drivers/watchdog/octeontx_wdt.c
index 7299a9f9739..749a899c5e8 100644
--- a/drivers/watchdog/octeontx_wdt.c
+++ b/drivers/watchdog/octeontx_wdt.c
@@ -107,6 +107,8 @@ static int octeontx_wdt_remove(struct udevice *dev)
 static int octeontx_wdt_probe(struct udevice *dev)
 {
 	struct octeontx_wdt *priv = dev_get_priv(dev);
+	struct wdt_uc_plat *plat = dev_get_uclass_plat(dev);
+	u64 clk_rate;
 	int ret;
 
 	priv->reg = dev_remap_addr(dev);
@@ -132,6 +134,20 @@ static int octeontx_wdt_probe(struct udevice *dev)
 		ret = clk_enable(&priv->clk);
 		if (ret)
 			return ret;
+
+		clk_rate = clk_get_rate(&priv->clk);
+	} else {
+		clk_rate = gd->bus_clk;
+	}
+
+	/*
+	 * WDOG_LEN is a 16-bit field counting in configured steps, so the
+	 * largest timeout the hardware can represent is (0xffff << 8) steps.
+	 */
+	if (!IS_ERR_VALUE(clk_rate) && clk_rate) {
+		u64 max_cycles = ((u64)0xffff << 8) << priv->data->timer_shift;
+
+		plat->max_timeout_ms = (max_cycles * 1000) / clk_rate;
 	}
 
 	return 0;

-- 
2.39.2

