Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FAAC44532
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 10:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9AAD408A9;
	Wed, 22 Jul 2026 10:58:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id as8-IMq-lbqj; Wed, 22 Jul 2026 10:58:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 887B6408FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784717912;
	bh=ZpmvqfH+Yfde7g3LDFXVwYuWrV42vEhZZ1dBMhqMi5Y=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Vbxxgsy5XdQQU5vrtuwcg8V/Nd/FWLYhkMBFevCTMHh5UQuYdLqPLEFmY/vq0BpQv
	 13BlWph2MQQiOnDf3aEelhLdgh1oDjF6/wqOiAa3pPSWD2ctcLg0Gvkk+WxjUTnXS/
	 fnxvBTR7zkG3bjkK1Tlc2hwG+Zoozvhhg6hX5U2Xz6H5V5FNgl7gJn25y10rD+L1+N
	 EdEFFditrpG3n1SWYkfAjx/2l2YBsjuNegEkpL4+d9Ns5St8AigK1UJFK5VEXRPpZ4
	 SqwiCJDACB8uXGzhC+OKdDamtX88cFbrVQ99cOFkWiqhCAbv0uIOSXHxtgjzCD8xR/
	 MHVwgSDRahjIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 887B6408FE;
	Wed, 22 Jul 2026 10:58:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C784A42A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD6F940080
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IfgKvhQNbq4l for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 10:58:27 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 73E074007A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73E074007A
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 73E074007A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:58:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B17F78493F; Wed, 22 Jul 2026 12:58:25 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BB9B849EB
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 12:58:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oa/I3OeCDq0Uc/ADEtHZWlsRHOwOUsDJqzJOk/SQbFFRh5SX3Cu+PuxalwxuMA5KHka/kQ/z5ie1EwIONkNLJ37e6bC5JZehaA0OxY+Ryd9SHE1QFP3/SPzHQ0HtL1J2GTneNPWXcQk2A4TxyeNnNHxj1UyI//wNWIoTvJ9DawXPC+952he6nAqMPB0kxFgS/DG/NUJTBoYp3Xxcfx5qKY7mbJTgPM0bzeKnDMQZZUEWWJftZyFjm8e5TuBbQTEE/HdsGxUouSXN+7FLm2kiieiZsqNGpyZUuR3EmmHcQ04z/9CNS6x/+sLs73xXZmANJS8zxkwuZ4/aL7NkTFnz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpmvqfH+Yfde7g3LDFXVwYuWrV42vEhZZ1dBMhqMi5Y=;
 b=MiX33pBR/4ZikX910rLi6CgkculGcb12EMrII2wiRkcym7a0NFnZJ6bdP+z8dnz9oCoHF2/RzaDvXDdrNF1qUFpKKfKSD+MAoxaBYNf41GOCYJS9YWtiV+SaUkCGwwozhVCAA2/URrVuQyaH2S4IPKiiCz7MSrckkpo3XgNEF+OeBNyI/jRAdVjmyUf0uV3FsNBd0hs8YDp4mQftVN+l1FVmjiuJE5QpvfvQnrsLRvQGGYeozvJEmalJuNTSWrV7ljhbMaz0ASUr6iWXdaKWTC3eCrsNj5XsDMg86c8hEThjfkDjTLvhtyJTTjDCYnhAraG//E6vN4q8n/29S5bGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.84) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
Received: from AS4P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::20)
 by GVXPR07MB9941.eurprd07.prod.outlook.com (2603:10a6:150:11f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 10:58:19 +0000
Received: from AM3PEPF00009B9B.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::8a) by AS4P190CA0030.outlook.office365.com
 (2603:10a6:20b:5d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 10:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.84)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.84; helo=fihe01smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe01smtplvp01.emea.nsn-net.net (131.228.2.84) by
 AM3PEPF00009B9B.mail.protection.outlook.com (10.167.16.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Wed, 22 Jul 2026 10:58:19 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe01smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id AE1A080000B3;
 Wed, 22 Jul 2026 13:58:18 +0300 (EEST)
Date: Wed, 22 Jul 2026 13:58:01 +0300
Subject: [PATCH v2 3/5] watchdog: octeontx_wdt: set max_timeout_ms in probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-rinta-watchdog-gettime-v2-3-39e249500543@nokia.com>
References: <20260722-rinta-watchdog-gettime-v2-0-39e249500543@nokia.com>
In-Reply-To: <20260722-rinta-watchdog-gettime-v2-0-39e249500543@nokia.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784717898; l=1809;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=9lGGguECSQJsLf/4MuF8Dpu2N/6tnjhsMp5yMMCuTEk=;
 b=3tvFcKS4MpdIjVyqNkdATfdle+AZUyu158/Nf7sxHBTCmUJULhf8WVwm1GyrIq0R4CD5NdHQe
 cUW1CnkuAElDvsHG4B5w8Aaf4LIEnHfK505Uf4fNx0q9RZCcVpt8l8q
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9B:EE_|GVXPR07MB9941:EE_
X-MS-Office365-Filtering-Correlation-Id: b1899862-8706-4532-3145-08dee7e023c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: TmGLCX82HRsJFGayjLvplTqKqUiQ/hkwF/bOmXhgUqYOwbVrHWyjE8sTBifhPvuMSkNDsk3+jYarK/gQsk0T8vbmysu10Ea2almFDQKR2ENf5bzSKCs3tsIIVKA09nJYFh0G6R1uMbzvVa9qDuTNp5AF69bMgQLBQO6hY58M8XJT22NBGvi1GRWVEouLJnZmPCB8vmUXruc3bOEFpVsEYBZoaIVMQQ/KYbETJiiRa6Hsym0DWLoNrx/2arUENf+EkCgc4hXonX5+qYOsbnUqVmqYyLmYG7elAnmGbFR+2lolsaKMg+8A9cb/zGwipvn9+fmBrJyGYo0sWbRcGIwyFKYg7SqQUR5UxF9IrHMWE3cApkW0amxCBEt7mq14EoMmoMUotQfYPmrI5BOfg0VQoP9Su0N4RPcubXHQ4Ormf2uEDEDbG1WKW3JUQMzzDGegNpRyWHtJdzzPtrQ4vCMT/ku3JwDbtsm8Nqv+bHT1MHUQb6Bm/y2wxuwSlbmvMD1NRY2z9mUIIWM0/aYIEQLDIal9c6DafTFE22Et33xj3fZLDJaaUs1KegGo+pXTWoQUNTKnS5a0ezIrnmo5I9NSBILcJaP0aBiSISrLG6JNuwyveTe2jhtZDoyDyMdlt1yGR9Y7XbMdgwe0Bk7B7acWqaLnbg1gZ45K1jFH9dw0GZKPuDpllGd0d+hVxWyTWUnTL111IQCAJXvx0dmOFBOBUQ==
X-Forefront-Antispam-Report: CIP:131.228.2.84; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe01smtplvp01.emea.nsn-net.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EZzEFGLbg6GWSfYyJkrRyyu7eBNJTmuQk+JPXFIlKksQUVTBWzdL9nt2NrYmOQNLHkKDbLs6NazkQystwoaz84KbyjheCcl8zA5oqDRx2XN5aS3F17H8O4L7UAnG2jBu+54U5aikMUeC/bDnMo+N7pYY6Gbm7hl6y023nADKykL/p0w2Laa/v39S5kmUKMxfjVzKzqEfzFbHdU/J3JPv9gXSe/l69odzHFJ8PfwpOzUtx0dD35CXIoh8LfKZMyLL3sa24kNnvCGDmuRM4WkAO7FPOpCdkY0tPzdS8vVauxxXKx1lFfldTFNTOPhYW9p6ObmINe8KBdA6358QrGbG7Cd0A/o0Ss9fX/RlSEl58F95JlL1MC+bA//cTYdQaCKUQ1aHjR7GFPqDjVwtUDVgSP28WRxGsWqmIpzspHwjXmuL/BXZ/pFjFHvx/UX4qfHk
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 10:58:19.0851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1899862-8706-4532-3145-08dee7e023c2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.84];
 Helo=[fihe01smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9941
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpmvqfH+Yfde7g3LDFXVwYuWrV42vEhZZ1dBMhqMi5Y=;
 b=DhucHb7Sr99NlAM023HkcAGSYSnLZmTpLeIxtso7gdeiQOQyNwXIRiESNMlg8W90o14Ye7U6TVsMerT5ISMpXM/VBw8l74FBfxA87t0PddvvD7P8IiTt3sOngMwSTjUCvttObu2b9OXEtTPs34112hpzBAa8NX3GpXug1cIt8Czxo5TmPb81jRdH6d1oN1Sgm/I17L1LEZbw7YndPreyQqXPdNT2d2cIdZA0UhvDtsPuIiZ69C+y04CJbaG6QAE/kNPGB2I9bUKb2GT14NRZSnzq/67gpW2CwODkxgkdcWcap23oCvNItMyXpSrvnw8quhREuvuaAH45KYlEAbrwqA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=nokia.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=DhucHb7S
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=nokia.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=juuso.rinta@nokia.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=nokia.com header.i=@nokia.com header.b="DhucHb7S"; 
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
 drivers/watchdog/octeontx_wdt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/watchdog/octeontx_wdt.c b/drivers/watchdog/octeontx_wdt.c
index 7299a9f9739..5f8a7dba547 100644
--- a/drivers/watchdog/octeontx_wdt.c
+++ b/drivers/watchdog/octeontx_wdt.c
@@ -6,6 +6,7 @@
  */
 
 #include <clk.h>
+#include <div64.h>
 #include <dm.h>
 #include <errno.h>
 #include <wdt.h>
@@ -107,6 +108,8 @@ static int octeontx_wdt_remove(struct udevice *dev)
 static int octeontx_wdt_probe(struct udevice *dev)
 {
 	struct octeontx_wdt *priv = dev_get_priv(dev);
+	struct wdt_uc_plat *plat = dev_get_uclass_plat(dev);
+	u64 clk_rate;
 	int ret;
 
 	priv->reg = dev_remap_addr(dev);
@@ -132,6 +135,20 @@ static int octeontx_wdt_probe(struct udevice *dev)
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
+		plat->max_timeout_ms = lldiv(max_cycles * 1000, clk_rate);
 	}
 
 	return 0;

-- 
2.39.2

