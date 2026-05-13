Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E104CD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:42:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C1D683FB0;
	Wed, 13 May 2026 11:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="udAL/HJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB4198341A; Wed, 13 May 2026 11:42:44 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89DC984663
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SW98tCUrQ+Q/YQjAIDrRjKfbVQX0hvCJa8kBpjY5PAUun4ybSffAV4JDT5bfAowU2sTpNO/KBH2e1htT6IzEGjl4ztVuplZsUS9VSC61s5WOCiLD0Ccbba3sGEZmlha8q2HCdVMqB+Anb4abcuI1yNBoyMNuZA6MZM6t0jsHujq1gy/aTd07afGYW6Y/HYvfQE8dDIZdorTntKtMooz3cKfO6wlOJmGlkdTK7SPeDLk1fORhFWJwESbh4ZtEQ1vCfe5OnWlr75l3IX+ddH6POBahuobJDmwS6I9CUTPZDcpA0844VBjTBvCEAccWqjqM5mWJeKc2+l4YFOjU1riuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94atiW+CifeLoU092t796b94Qs13m64Ooq3RO6eeIzw=;
 b=MnqNTXBxFtkHCPsBn4ErBPAFIEuLhl/TJKVPIROO5d4jVo2wBoaG65m7W374pQ+4tFt5J2WwZmXs5LW4Pd5XBpbxiM2+zbpWurOMXORzb5/9BSa0dhxwlgqvpDLClMg6nldaaQMkR9W2NDuqPrv7NsSIFxgQ8QndHYyZzgjyz7WTSVaPNmAX/XLtx6ctPZjfGX2YPaYKXFA6uCjhoGZgfmPy3GGGSV6vV9xeXkKch2vOdneob5RpJJ7vVgXdWwq8WY4jhlNGwaT+Kb/B16fQ0prg0lYhg7YPr/RP6FafFs8gG26BYksfyp0qqQGZNmpRJNea6yinjOjiubfwXk6RyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94atiW+CifeLoU092t796b94Qs13m64Ooq3RO6eeIzw=;
 b=udAL/HJdtBMJxZHgrnzz+g60cpy9j0kMXXyyGHU4P1lE2B8p000biwsPtqUjkeY0Ui3nC4mV9dUXJkJeFfxl0iXBo2EP/jMhk6v6cS35YK7Xu/yWleHEvHXOJ/UKST4KWYvY4vfgjZj6rTBIXkdhcMzSWV87ZFHdT1FoFD7t6Wg=
Received: from BN9PR03CA0161.namprd03.prod.outlook.com (2603:10b6:408:f4::16)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 09:42:37 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::c2) by BN9PR03CA0161.outlook.office365.com
 (2603:10b6:408:f4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 09:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 09:42:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 04:42:35 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 04:42:35 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v3 4/5] spi: cadence: Use reset_reset_bulk() for proper reset
 cycling
Date: Wed, 13 May 2026 11:42:09 +0200
Message-ID: <94453679a8d874a11346c2199dc48f5411966f7e.1778665323.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778665323.git.michal.simek@amd.com>
References: <cover.1778665323.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=lMPgNlu6ECtkWY0TTvqnpaM2nfLAQkHQm+cqFMYCqW8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSxuJedfCd/O6E6+sAaJ1Oljanzvu3Z++GeUsr94kl2s
 dxOJvtNO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiDb6MDG9fZK5NqnVdt9dQ
 7+LHfIMPr2cZ3OPPF7e+0TNPlWF2/3WG/y4bjx59oXr7ib5DUtqXx45N/dcKPurM5+nm4fXOtG9
 fzggA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: b86dd0ff-198f-4c3e-7efa-08deb0d3f7d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bzIfv300XazRxqT/tSA2gF028XI83ROe0RUfFMx+39nw+axZLUt7aCbFVJAO+Nshw3/YJK7C8CUs7+mj1S9W8/CDY7l/8UegP570TNI/6eBh8pBKtNmPtW3hKdViAgtc6cBsf15T2eL2Ll6Ahd7GyYCyEQI9tgwhTmGpshLx/DB+dAxd+7m1ZDSgfWabFQpbWw6MhYtxqkjDltiW2voMFjDzq4j4temoiutDnKDVFWXzJrFh1+p4d4IblxWRv1TjitqAzA2CmwEjSP3BJwUALFMszn/mJQ0NGv2vy2ua7DqwAap+Mw2VDKCCsNcR59csV7l87huGXwfJ2bt97qXEYewjZRFraoXDoqWhg38wp8UcpAKUfq/L8DKryMZ04QTK0YUNNNY4bf7wtsmknSVl1Pmo91HSgt4NKXH/YU4201j6YtUhwphlVkrD5U3iQwkXoFjWLY0QAjlrcHDFQIdDU6p5au1ZuyyjBXz6Mi6lCf+//hdiFqhi0tooAqcYHDEyZBVTg+QKYYL1V3+I12fsNMCReWHPfRv88Ysg4c40zdSbWrSniPLKwZphWYPpijXB4jFkOV3+hRk0e1yAhNubPCXHFKytiUECbiLLZGAetLENiPVAN2owp/xnYoQjTZTCMrk4bEv05yop+MfSBmZMpqDfGMsnM5fNsM73d4aYmIe1PgnnawsgIqAPSb2wB+oyLGdjVaKyMeMJxo7kENXzk8yyjsmINbq81BNvJb+LskE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(11063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3o+bfm+G/0mLLn9ASPvBYBDI+zJdEm7mAse8oyjhhbCVFnqwpuWo3HWuBQS342xkvVYj0UXuR/nEt1UoDaLFKzFZYkt0EZHUdtlHvUviBTcf5gcc0B5TXvV+BtoKcbKBjHdK5b2eXbWb7f9YxRvJA1Ks2k2rQ+i8hZDexcBy4Af1jPttFOz3iG5QaMNp8F2gb+8quSvHnid5hYihmQlJDsVaGHRDTf23R6QqgzUYSgTh/viEbGDTjSqr99Tg6OV32PT7xkB6/gdMN4Wge5Vz5mPJiwxKBkQoDWraN5iMEHsH/HTR6O0ti/c8Ng7klcYFnMk9ww8/8G3uRjaHsqPWbuzK3aIjZb+oc2gSOUb7ZauDkgKD2FQA7bXPgYdd3Z4ehb7io238/5Vh64GkNOJNlD1KkfKIOp06VhbiRKST8SjdihJYSBCg7pYoQAUD2g57
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:42:37.5189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b86dd0ff-198f-4c3e-7efa-08deb0d3f7d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165
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

