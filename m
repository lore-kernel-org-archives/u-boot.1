Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3019C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 04:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5EB9843B6;
	Fri, 10 Jul 2026 06:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="FN/Kalgb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 227BC849D2; Fri, 10 Jul 2026 06:51:47 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C7383E76
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=juuso.rinta@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3zTQVRS/pNVfvEvyXFO3xWS9LKuSGlQJ32L5ZHJ83KgNhE4OIo/+wGebH4YjhiV8/6qn14U1R7iXgDLQRf4znpxUQ1MhvaVCdlHYxfsV7gbTe2rUdx4zWeAoVjA6w8O+lBdkStV9yOjxSRiqgx6lQGNd12SZZYO/2zEdTEAju+ZQI4Y1xaTkc6nK/6E8ZqoHlWR9f2cpFx4PcqwSHlqPz2hXMUSifYM5rml+g8gJ1plBCiCLznITXQPRiobwZIBmwK9js3SMRBXIxFwQLILqS1AAfZ2bBvs9DckSI6tCrg3i35X/z77WrxWdgUT2AAb+95TTfFLqND1l6QGobkWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QABPw1vzDp4w8tefiAsrDXaKkHK3UbJVj0tsyMXZ9dA=;
 b=BB7mQwIPml0GVt6DVV83EMaZI7xhypxlxUJn5ZaLBYp4p4Q9MSulp3Op92Gi3f0DX2Dh4XRsYxnoart95SxjMh9g5yIWsTKY6WrgJC4UodXG9YABqH03bFyJl0IXRsQuorJ/g0sRdJ+259qSX65VUKhcZRRpqLe6jP+8oAOoAn//Ok8H2xRV9eVmlEuwUNjNTZt93oE/G9veEN5QjzWuYRv/q6H942GNtoTBmZhwfBpwYIVcXGBIOi6iWjscID9Qm8RSWVZjYN9MtS+XJH96qMeb6xPgEGpmNORf/BJKsnN/RKZvCE5gPmru6aarqzNnv7KRUXGmnjAuoVLiXgRPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QABPw1vzDp4w8tefiAsrDXaKkHK3UbJVj0tsyMXZ9dA=;
 b=FN/KalgbrpYK1f+K7EQAe6xgTb2m5zwYJ4rNdnkt0DvksPJBzyMaDBATKecoPii9CnuBVEKCnQZWvwnjePwKsr8iazosmcgQO2Obtq4o/94sH9/JCOgxrtvz1bHOdVjQW9QKFhR0fQDvPF7TX0lBcbyK87hG0fL6cgAoo0fTuNiP06t+Zu8p2f+AM0TTVz6gTwyuSRGDcSS4wb3vSBgmo+zGUaRklC1flcgsPaOnaNkYaXGu35VeuQa0YC4t86VCSrjayGweddQSEonbs/6tMkaIOCK2xBADpu1OW//3u7oonpkVC8VPQDL3gjhqQI7o3u/hsCPZlLZ79dNZCTLVxw==
Received: from AM0PR02CA0183.eurprd02.prod.outlook.com (2603:10a6:20b:28e::20)
 by DU4PR07MB11768.eurprd07.prod.outlook.com (2603:10a6:10:635::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.10; Fri, 10 Jul
 2026 04:51:43 +0000
Received: from AM4PEPF00027A68.eurprd04.prod.outlook.com
 (2603:10a6:20b:28e:cafe::4d) by AM0PR02CA0183.outlook.office365.com
 (2603:10a6:20b:28e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Fri,
 10 Jul 2026 04:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM4PEPF00027A68.mail.protection.outlook.com (10.167.16.85) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 10 Jul 2026 04:51:42 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 7014B23C15;
 Fri, 10 Jul 2026 07:51:42 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Fri, 10 Jul 2026 07:51:17 +0300
Subject: [PATCH 1/6] watchdog: wdt-uclass: add get_timeout operation and helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-rinta-watchdog-gettime-v1-1-9a982fb93f49@nokia.com>
References: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
In-Reply-To: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783659102; l=3654;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=q3HQqOEseVUbza+besVTr9k5EEsJDWV/OuUV17n/HRQ=;
 b=HgYEKVqkB5bQsEIpLFj/IrE4NsIrguhXIFrAY5WFjFB1/w2VOfbs8WRK+q0jtXeLUvKYGblFw
 5RSqDViiy2TDOFQ52dkLO9xy4ZZ51H4CWnK6wpaY83Iqi+vkZYQS+Mm
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A68:EE_|DU4PR07MB11768:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4d96ea-3499-4b31-5727-08dede3ef005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WBbjfbcJOVxTdPrie8jzg4zaraQxNMonSHAkitFoWW7fEMRcOCKJB6/vMCLkGNgPf+OXEgQqNtn8bFQ/zOgn0qoqOiZWu/ToeIdaVjLXn7vv1ge2k8P7xPPCmImC0tvqkrixTrtOOHgtim+f8b8N4vkiZdz7SbOlS39MO9n+IuQiyQ9/kGEpO6BJkd23a0I8HiHwsUybdStWs3Bq1pCTd5pp1eziHHHrqfOdwOEzDWf2NSyyNFT91nQ5iPPZGuQUTf1fWyTjpJM2XoYMN61XGEqhBlyjTSc3IRABrM4B6AtdZP4RyA4xBmDuTHV7cwV2NWifGUTky5aK8xgfarVEfVI4GUdg4z00AyHVy4EMcdDZQzExIWvPHhp286mK9O8ojs39rJuyorFcbmyXQUd7k5s0uEkob8XqcmCZJIQy86HdprolOpikkIxMoKv44sUNEvr/2gm+IL1aetKvUfGrazoMGxyPQWpGgACioTSI50Ff/RD1OSgK0p7wD6PUFuIdAQ9fzLORvENekvK/z/KD+E19hkqTaP6VHahEsKb/NkrrdgfUmOpoftQzqJ0IM4EPFZChkOrbs+u9CO+eruYQBQsXnkETOgTdKTiwA8zAIGsK9V+gICGOZ7V/UGONwJjk8gLlT98zuPcyKkDV9DE48y8KKJg9LeKhvwCt+Vjt7UOC+Y0DH0yG56/cbMzRncOXV4YUTOFR3YEWLGdUQkMaXA==
X-Forefront-Antispam-Report: CIP:131.228.2.240; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0735.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vxQJ/InFOo7xw88ZpCI6vN2P4hOfEX2TF2CMZV0RdgXEMb+ff8rYwiPtSHIF8NEH9jY2BveWeWWRqmH5J6DU0zQCcu5JIVy5+8JtZTUlfaNoz6iS18wWX5njUv589jp2jouU1XO0fWG5tl3SflLNX7MALPWeGQaX03DZzQkzi+UAZUzcpbEx/tV/AVViCGDjlfCRYDI2CQ8TUnzMnE+n91eDFCwdRGzb7p4eoWsK3bnyZfiWL9psVdw8F4sD859yTvwqeK6r4lAD7QbMONQJ+4sxDGj+4LJqv+dw7sCj02xl5kiDyk8rO9Bic6MpVxWV0K97D3cU0ZV55ka7bDuP8Rzqntd99/F4OaLFlNzUIkdskFr5FZOlggbYmCh7WgYf0yGMLs1c3XHPTpKEECmA23IW6BMjpv9x4QKW0pyEx1H7hS5oXv6YYFunos6PAyTz
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 04:51:42.8460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4d96ea-3499-4b31-5727-08dede3ef005
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.240];
 Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB11768
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

The wdt_start function may be called with a timeout greater
than the hardware-supported maximum. This in turn can result
to bogus print, e.g.
Started <watchdog@> with servicing every 1000ms (60s timeout)

Add a uclass get_timeout operation and helper so drivers can
report the effective timeout. When available, the startup
print now shows both actual and requested timeout values, e.g.
Started <watchdog@> with servicing every 1000ms (10s timeout, requested 60s)

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/wdt-uclass.c | 35 +++++++++++++++++++++++++++++++++--
 include/wdt.h                 | 22 ++++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 438833b2245..c9ce5c07afd 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -116,10 +116,28 @@ int initr_watchdog(void)
 	return 0;
 }
 
+int wdt_get_timeout(struct udevice *dev, u64 *timeout_ms)
+{
+	const struct wdt_ops *ops = device_get_ops(dev);
+	u64 tout_val;
+	int ret;
+
+	if (!ops->get_timeout)
+		return -ENOSYS;
+
+	ret = ops->get_timeout(dev, &tout_val);
+	if (ret == 0)
+		*timeout_ms = tout_val;
+
+	return ret;
+}
+
 int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 {
 	const struct wdt_ops *ops = device_get_ops(dev);
 	int ret;
+	u64 effective_timeout = timeout_ms;
+	char requested_timeout[32];
 
 	if (!ops->start)
 		return -ENOSYS;
@@ -143,9 +161,22 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 		}
 
 		priv->running = true;
-		printf("WDT:   Started %s with%s servicing %s (%ds timeout)\n",
+
+		/* Get the effective timeout from driver if supported */
+		memset(requested_timeout, 0, 32);
+		if (wdt_get_timeout(dev, &effective_timeout) == 0) {
+			u32 effective_s = (u32)lldiv(effective_timeout, 1000);
+			u32 requested_s = (u32)lldiv(timeout_ms, 1000);
+
+			if (effective_s != requested_s) {
+				snprintf(requested_timeout, 32, ", requested %ds",
+					 requested_s);
+			}
+		}
+
+		printf("WDT:   Started %s with%s servicing %s (%ds timeout%s)\n",
 		       dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
-		       str, (u32)lldiv(timeout_ms, 1000));
+		       str, (u32)lldiv(effective_timeout, 1000), requested_timeout);
 	}
 
 	return ret;
diff --git a/include/wdt.h b/include/wdt.h
index 1ef656585c4..5c38eba3a5a 100644
--- a/include/wdt.h
+++ b/include/wdt.h
@@ -74,6 +74,19 @@ int wdt_reset(struct udevice *dev);
  */
 int wdt_expire_now(struct udevice *dev, ulong flags);
 
+/*
+ * Get the effective timeout in milliseconds.
+ *
+ * The effective value may differ from the value passed to wdt_start()
+ * if the hardware has rounded and/or clamped it.
+ *
+ * @dev: WDT device
+ * @timeout_ms: A pointer where the effective timeout in milliseconds
+ * is returned to. On error, the value is left unchanged.
+ * @return 0 if OK -ve on error
+ */
+int wdt_get_timeout(struct udevice *dev, u64 *timeout_ms);
+
 /*
  * struct wdt_ops - Driver model wdt operations
  *
@@ -120,6 +133,15 @@ struct wdt_ops {
 	 * @return 0 if OK -ve on error. May not return.
 	 */
 	int (*expire_now)(struct udevice *dev, ulong flags);
+	/*
+	 * Get the effective timeout in milliseconds (optional)
+	 *
+	 * @dev: WDT device
+	 * @timeout_ms: Location to store timeout in milliseconds,
+	 * written only on success
+	 * @return 0 if OK -ve on error
+	 */
+	int (*get_timeout)(struct udevice *dev, u64 *timeout_ms);
 };
 
 int initr_watchdog(void);

-- 
2.39.2

