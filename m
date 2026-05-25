Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9614CD5BD0
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 11:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9868D846DE;
	Mon, 25 May 2026 13:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BBOV81Y0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D81C0846E1; Mon, 25 May 2026 13:46:27 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D784846DE
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 13:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuLAQRpDX5lRPGWTv4SRcmVqmHPvkgQJ/y5EqZko8c9uHiWzJxAiMXr6/AZGGPYUtUvCfyApn8fDnH7H1n/8LNLYG3ImAbGqFS7Tp9Lk26aqAnNgPaivzK1mc1GPgiWE00aW8egbRkeSDWepV6qq/+qCyPl9tBOs3TsZ2WpCWqKJfyFnZUH/7wYLjE8ZT8i6evecXF/8QstJUGGzTg4elt6ipr9bFpa4EYtk2N5rBzqT85kcZudgrchbrbSXl1MHMuO/9CIdPhGnNlTtzmG1tfFF1e4q8RwpOkIF2lcKD8g7xYr/SvhyBG1L2c+myvpiUgECgT5gCJ/X9arG9Q3w/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94atiW+CifeLoU092t796b94Qs13m64Ooq3RO6eeIzw=;
 b=jL92OR8Tha3081t6l1V0B+k+y7nr5nImL9tuqZ75qYn4cyLlctVhAGnuTyFBrkSBhJIUy+kImEps1hp9dh6YVkcpVUXNZKvAVwoN0kfinQcd2uxZLBVvfQlLvWNO1i4s8z145gzBXAIYPDpY3Ha2OkY67NP3RZHkqdi9Fb4GE6k4meK+QNe4XRnhtiKt3sATAaXvYdTDDqh9IWQIXUBw00AqD8dFuh8VdQ8VI1lqx90xc+FZ19Z7A6Yvs0MhHwhFpA6jatkCZbmU2X2jet57S00XITIAWZeNAy47W8OLcpCObNX03OdzrBceU9z7YZJYA6zXbjlLpvNnigIEh4E7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94atiW+CifeLoU092t796b94Qs13m64Ooq3RO6eeIzw=;
 b=BBOV81Y0y/858vJBeCmFQ+kzKj+hDniLJqEAvxnVJuaw17rxBSBXLiHRtZ8FKQQvKdno4R+VdcEJd6psI67l2CFQIzkKwYyiZrwkQ2kPHtTCyipddHYFn6AEepAzlEF8kF3SrPQC2nwhAYFPowVnNRqa9YAIWHSrQ08IjeTi8sM=
Received: from MN0PR04CA0012.namprd04.prod.outlook.com (2603:10b6:208:52d::31)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 11:46:21 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::8d) by MN0PR04CA0012.outlook.office365.com
 (2603:10b6:208:52d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 11:46:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 11:46:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 06:46:20 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 25 May 2026 06:46:20 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v4 4/5] spi: cadence: Use reset_reset_bulk() for proper reset
 cycling
Date: Mon, 25 May 2026 13:45:45 +0200
Message-ID: <92e614075d2c4820d3e4485aa0bdda11efd1f7ca.1779709539.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779709539.git.michal.simek@amd.com>
References: <cover.1779709539.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=lMPgNlu6ECtkWY0TTvqnpaM2nfLAQkHQm+cqFMYCqW8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSJmBWdttpmf7UhyV+tmsdZS2rL1bXBux4urWq413Y2P
 2rurJPzO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiZ+0Z/kftCt+6ufeRXEgY
 8/Pu19fjTv+7x3R/Ds/fiwb77k1kUrViZNjHeWrBSbNlCtxs589azjm6sXCrWFW7NqPw8oecc3r
 Wb+QHAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ec1b99-2316-4b49-98fa-08deba533dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|6133799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: GoO2QMo2nDbkIqIWvENyTg96f3OP7FnmUBhNIuiXUgdwTj/Dn7RQuOQJ9nnIsx3Xf+nCVmhrhP6t0lk0kkFyQxIlycZeX3qbIAJ9du+/8/CBjwL2qWMhTgrM/2HRdV3U+gURj8c2FXypr8NyqRfPi1kHjlXXHbTofx14O4GNYNvqTh/gwQ7p2+PANPqJFK/T3hbN1iypgor+lPMCROCxA3A4Sy20qgz2KXqby6JTb69CkECVe+Gez0HCtc4/k2zr2hH7qh8HghIwI947ECeyys4dSy0aEs3rt6etj09tReU2TW5eVu+rFmI6okEo3L8yhmQKg+3cF48r5wFonHtojDqRm66eS+3X3CLoHCgY8rvuhCRlCN24FbwHmgrOhUCPrFjitiLsz2+9S23QzqLt8YXCP6daNFeudKI3PlsS1PAi0l3OrytrQoa086Lqiarsd/9L/GI7qXnHEpzjv6znJ3kh9BLTI34yHTzrhoDJ9VZYallWUdCWu39f7RLncrDCkVLtjrH36px3H8+DDhgoKOvaFaxIGY/yPoYtTnifeBRJVDZSyftgg9YtggewmQbzbqdB878w9KJlfO4QXRPFOTqq/Wjj6OElV8pEukKR6Untw56C62qaB3TlMDxhL3okjqm1ihEmfmO868v/FOCp5ksjoCVKQBOBFxqYlM4P+tpAYMCAOK3vfiGO5MblgcMD8BWC9tC1/dRy7XPMCQh2o6FKJ6KbbD3OzQ9B+YK+qX4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(6133799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q/Q5VoOf4CigfNbVuTpdd9tz1oVGYkuZOMagllRjUMLsXh9VsZqqMrOu3SDS1rRYM0VFZdkru8BOxlusb6lVp+EYD6QQIuQm0KItIrVaMspqdrAH7gx1cuibyHAScHkNgZO/mY1bAwF2Mq46EmE63u49uVCei0OO/ivk8Y2dGHPDFR8XEHUIR32h21gjkrfzZr6Il4ON/ugH8MKftZXiT8eOUsugbq9QffBJVOW67VZRC7TRN1ueNnf9U4JRNKEfJowyLGD7Aco++hpDjNrJzO539IQCrZ+QLzIZ4pjceVyNJb45tpa9SXVzwfr1cKIy4cadgX9ulnIdUBwG1BgiPZyk8FN1F/R5250WUs3fLYl1AuHXBP0rlPzEBnjjmZE2JzvabqEYt/yDvvzBLByEjJzepUE+E1OBOTwxEpFWIAINZCUeiPssjX1vwNNQVxrB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:46:21.6593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ec1b99-2316-4b49-98fa-08deba533dea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676
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

Use the new reset_reset_bulk() API to properly cycle reset signals
during probe instead of just deasserting them. This ensures the
controller is properly reset before initialization.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Pass 10us via parameter

 drivers/spi/cadence_qspi.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 2a4a49c5f1cf..984d4a39ded4 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -31,6 +31,8 @@
 #define CQSPI_DISABLE_STIG_MODE		BIT(0)
 #define CQSPI_DMA_MODE			BIT(1)
 
+#define CQSPI_RESET_DELAY_US		10
+
 __weak int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 				     const struct spi_mem_op *op)
 {
@@ -256,19 +258,9 @@ static int cadence_spi_probe(struct udevice *bus)
 
 	priv->resets = devm_reset_bulk_get_optional(bus);
 	if (priv->resets) {
-		/* Assert all OSPI reset lines */
-		ret = reset_assert_bulk(priv->resets);
-		if (ret) {
-			dev_err(bus, "Failed to assert OSPI reset: %d\n", ret);
-			return ret;
-		}
-
-		udelay(10);
-
-		/* Deassert all OSPI reset lines */
-		ret = reset_deassert_bulk(priv->resets);
+		ret = reset_reset_bulk(priv->resets, CQSPI_RESET_DELAY_US);
 		if (ret) {
-			dev_err(bus, "Failed to deassert OSPI reset: %d\n", ret);
+			dev_err(bus, "Failed to reset OSPI: %d\n", ret);
 			return ret;
 		}
 	}
-- 
2.43.0

