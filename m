Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7D9F9EDC5
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 12:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0A7B84258;
	Wed, 22 Apr 2026 14:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="DspZ9V0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB9568425F; Wed, 22 Apr 2026 11:47:07 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 794D18426E
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQr5rawKrS65TzewbRO8RcqYv3LbKPFbqb2CYCe7uyVw6yI1llQviwHiSIlphfEG1jzS7804Q7TWaI8OObQZtomTaVdeki8hLgEotJpWTIDPAuhSQSMdeb1SMHcDxz2U/dBb1BVs9bFHgAmSsFmdWmVnYsPw61x1uvqt1TwWujmjDAf5R2hPBmydsILdSPToRYgIYICxOIa82xhXeLs3ab3kPLiC125YZoG/6AljviyDMYoA8uPavuECmT6PSD/xdYDLhXkIqpgXPXgRI1H0MlV8zLbtJAz3QCZpwP/7PMV5joOKLA3qVA80+WcM8UQHDTOfHwgh/lwqwne8K9PDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJyG8EWy5dtHdF20NmYGRPeDQ185wQfPiiwenqv01E8=;
 b=UHa7CUNCFiHYbN839thg7qpNFNFluATpNzVa3w+ZvCn6/O3LjHL7Vt9aXhEYAC7KMddAEUsQ2sUwpqoY3Ks2jXdmkvRrm4ZHmkp8LQRSBmCHhWbdI/VWcZNmiNdHT124LlfVijzs+rqq5KZ4jeQVPfvGjwCcpSBAJg+sGNGlXAlQKPkfY7kci6zL21vuXkFj6SBkD6vvT9k65g2+VFkZfbfw7VbxN5/TBblv9yLZsx5InmZawFaK4bZn4jzNb3kNIJ+imcRnRUFCv59soEzP+jsWLGlFkKWxvw+iSuXGmsEWfyS44GD99noSt2lJEDCvfNq68mJ0b6/D5MW0VyWZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJyG8EWy5dtHdF20NmYGRPeDQ185wQfPiiwenqv01E8=;
 b=DspZ9V0CQ144iAQA1Jicjxo6B3s/4/dR4rv3BKGDxgUKIAElxmWR6PLduXTuSgVI7C0EgjZoqnGEWSAN9LVRbuP5Cuk+GqAiiA/c0ysLJ968EEJfq93n+RZsNsVMqA+E0ApyT4h0JIN6B22Dq1OJs/7dxIZkF/Zf8l97NEP3qLe6sHUS4V/QNCoYvlcrmQzlgCLmtVMFNMdONtZOpRFIxC4+sOZ9qe4IbHYP9OfhWG6baKH29aZlK5cklG6AWSFfUW9Qc/OlYakwrfh790geTYqIkkpPKMRlUq3bcZE/Yw3ziCNPN25/Sj1J7p8ceaFC/0VuebIEj9NJyoZZ+26ngA==
Received: from PH8PR05CA0015.namprd05.prod.outlook.com (2603:10b6:510:2cc::16)
 by SA1PR22MB4185.namprd22.prod.outlook.com (2603:10b6:806:38d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 09:47:01 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::db) by PH8PR05CA0015.outlook.office365.com
 (2603:10b6:510:2cc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.19 via Frontend Transport; Wed,
 22 Apr 2026 09:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 09:47:01 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id EFE281290C;
 Wed, 22 Apr 2026 12:46:59 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
	u-boot@lists.denx.de
Subject: [PATCH 5/5] video: imx: ipuv3: enable ipu clk before writing
 registers in CCF
Date: Wed, 22 Apr 2026 12:46:43 +0300
Message-ID: <20260422094649.57611-5-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422094649.57611-1-brian.ruley@gehealthcare.com>
References: <20260422094649.57611-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SA1PR22MB4185:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e5e79cad-9af5-4a1f-2cbf-08dea0541a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18096099003|18002099003;
X-Microsoft-Antispam-Message-Info: JXZcvT6MBARjDSoP5pQUVNyPa8akaVvRMSZF2ayxxqOfx1I5mw9Y6XZ72Nzj4H1nn/rbR4dl8DwZt409zLCnKAxOXUy5m9XISN/EykchOe5wUJU6DihcRaU2+vTjM5UxGytJAmn0fmqyYq6iI+TC7mJriCyn25FYnqHEp6vKl2PWlAick62Y6C2PhvKZkCoa2bSBDrciGi7xXs4VrKnGhSSNpl91rnGzLmhR3CkkxaJV8pWSBMIBHyyBltRrSxFOZiF+7t+3i3JjtwPUyXBqeY+p1GNGjeribz0PB+7TssvBNY8AnahjgQWYi3sFh/krmtmnR15WWAODQ9EWR0Y8YzJJcZm8gCxnw+YBYBMjDldGCi1aJAj25GRcCzIVLQCbW8WWk2A24Kc7Y8602d8Anyri0ev91ZCjGACVHL3qd7buL4axIdlYS0VQKm6PX8kGmNixPXLBOlLhN1kp5sdAyLW1mUxpRT6DW/7uBquaYMOF8cXwqegaUsuccgfLeTuxljKo00QLdG/76SJOaxaNO/ebmd2TkeqggGSJUBzX3Z6Hv80w2p1FaNwvPeYfy1RZctxWmN3z0UyqivYxSG16iLPeG679sGdPmtFvCzEmsmmbjQR5CPkBBON7Q1A7V7LD1Twn8zET22XRGjZR0FTaySG8gxEyAAyP6PTE+ryInI96xiTVGGPBW6Ssh2hIcoWw8NKB0EtV45LMxuylzQFxe2t7h9PnsThd+ouDDYek6nv37SwCteHGcZ/Cn0Gb0t1CV+bfSORZWgzzxhCpMCYZ6w==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18096099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jPQUJF+VrAAoZFSxqtwc3uyBGTQsIR1LNXmLNND+SU07Anr86fDtM182dYhyWXhSJI0YwPxhPGokqNIuzXDr0mFlnq6NWZDwUbxnEcE9Fi5NG5Q7Mc4jTGXy8rYUv+MEmjGMqlI7y/tAzsMdEuCkH9wtCI1X3yEI9KwnYmTeRRnSBI728SJ7Y2BEEB9dWf4Rvp9QvNSiWzBzCv/3yC6Ym86hEb3N+04I2IivEkQEyxIp7fg0tfe4eGgFqtg4IsDifp0ACp/ccSnWb5VjjI1D/gfSENPGv43qtAHS3ABM5vtVwIun48uZnQPdiaqqWBbMJq8U69QK/HQEXiE/knOAxK3irlL/Amqbd9LzRhqhG4tAKdcftvRYw379ygCIkLuomuEskecZPkBYWx61RLZtATTBzG+3uCzQo7b1xjw7A8rqP4X0Drw0GqPEA99J9rWU
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:47:01.1006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e79cad-9af5-4a1f-2cbf-08dea0541a62
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB4185
X-Mailman-Approved-At: Wed, 22 Apr 2026 14:34:21 +0200
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

Obviously, the clock has to be enabled if writing to it's registers.
This was missed because the board I tested on had enabled the clocks in
early init.

Also, remove the completely useless "ipu_clk_enabled" struct member and
use the accurate usecount / enabled_count instead.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
 drivers/video/imx/ipu.h        |  1 -
 drivers/video/imx/ipu_common.c | 13 +++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/imx/ipu.h b/drivers/video/imx/ipu.h
index ae40e20bc28..aecb6adffce 100644
--- a/drivers/video/imx/ipu.h
+++ b/drivers/video/imx/ipu.h
@@ -136,7 +136,6 @@ struct ipu_ctx {
 
 	struct clk *ipu_clk;
 	struct clk *ldb_clk;
-	unsigned char ipu_clk_enabled;
 	struct clk *di_clk[2];
 	struct clk *pixel_clk[2];
 
diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
index 8630374a055..d3b52605731 100644
--- a/drivers/video/imx/ipu_common.c
+++ b/drivers/video/imx/ipu_common.c
@@ -299,9 +299,9 @@ struct ipu_ctx *ipu_probe(struct udevice *dev)
 #if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
 	clk_set_parent(ctx->pixel_clk[0], ctx->ipu_clk);
 	clk_set_parent(ctx->pixel_clk[1], ctx->ipu_clk);
+#endif
 
 	clk_enable(ctx->ipu_clk);
-#endif
 
 	for (int i = 0; i <= 1; i++) {
 		ret = ipu_di_clk_init(ctx, i);
@@ -384,10 +384,8 @@ int32_t ipu_init_channel(struct ipu_ctx *ctx, ipu_channel_t channel,
 
 	debug("init channel = %d\n", IPU_CHAN_ID(channel));
 
-	if (ctx->ipu_clk_enabled == 0) {
-		ctx->ipu_clk_enabled = 1;
+	if (!ipu_clk_enabled(ctx))
 		clk_enable(ipu_clk);
-	}
 
 	if (*channel_init_mask & (1L << IPU_CHAN_ID(channel))) {
 		printf("Warning: channel already initialized %d\n",
@@ -543,7 +541,6 @@ void ipu_uninit_channel(struct ipu_ctx *ctx, ipu_channel_t channel)
 
 	if (ipu_conf == 0) {
 		clk_disable(ctx->ipu_clk);
-		ctx->ipu_clk_enabled = 0;
 	}
 }
 
@@ -1045,5 +1042,9 @@ ipu_color_space_t format_to_colorspace(u32 fmt)
 
 bool ipu_clk_enabled(struct ipu_ctx *ctx)
 {
-	return ctx->ipu_clk_enabled;
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
+	return clk_get_usecount(ctx->ipu_clk);
+#else
+	return ctx->ipu_clk->enable_count;
+#endif
 }
-- 
2.47.3

