Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B21CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8A13848EA;
	Tue,  5 May 2026 14:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SIj+77P9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D80B848DA; Tue,  5 May 2026 14:31:01 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6D2C848E2
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXxdgqK1Gmx76L+Jf8Rlr/vDUT/+4rSR65pI2lH4838y45Bd/nSKYQYlEpRAWjQTv4Dw38FGpIJ9k1fD8iWlORpv0i7wSW9vmDdCep59KcIrGUj4dk4Fxi8A6PdFgf8GHMLUjRcue9nCv60IyxDdDBEdzfG/2vmC0cq2gNDxkIO506EfRAjEcTRAalvOKtszFDlkNBp7ujtmAi6M2TCrnz+IcbvTviqjKLWE9AApFEPHP4LwhN4229RGn4YDBYEC2Gm0yfPGy5JENAnhtleQEM1Rr03Wm2tolIpjof2DBf/YyCLXeyTSSen0JHD1tODuXP0CTSTvkXrTr0aXUQ+09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9ijv/YKIWaVkwVTq98eebp5rizQbCu2nOWXQfjBEFM=;
 b=OSdoty2rOvuABiEbz42/DUwlNgtUBzC9hGsDrlwmMvA5L10HFgjrNS+MqzSUP0I3i0LHIBFx/Ay/0wAenylPbMdQJ8qOe1cBy9JsshKJBy4OySp+eN0pU+4NNcCsi0XzKN2ctu8sRHwi+i6HH/R+ZjJEtlzHElRhaw2k4jhNrQB+2aDIsW+qqloXIOokYR3iD2fFwva9TicP8Yh7rC+REh9sQ0fTrkhdHnG+mFgm8jtCJbmECTp3EfxBsJiFnhitjWILhOs+HGohzBbM0jFX9Aets9lA1CUQ/3UtlOf5rlrMEP7ydNDq5z8za08EGogVXJAkaG9DTTaTda2gRGk8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9ijv/YKIWaVkwVTq98eebp5rizQbCu2nOWXQfjBEFM=;
 b=SIj+77P9REB/StsOvuC3sHBDhT4N9xjrwBPmz5jq+7hxD/MWMoVNmX0IO25yzFEvLYgOMoNaw23brMZVLC/5uIn8iViRnib6BnRKBnb9JD6vcwzS1mqJGMB7uH1T4dhpu53SX9bCqMJ02x+OhVvi/XW+ndLoP62t3ugtRafsI1I=
Received: from CH5P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::16)
 by DSSPR12MB999237.namprd12.prod.outlook.com (2603:10b6:8:377::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 12:30:54 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::87) by CH5P221CA0012.outlook.office365.com
 (2603:10b6:610:1f2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 12:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 12:30:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 5 May
 2026 07:30:50 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 May
 2026 07:30:48 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 07:30:48 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 3/4] spi: cadence: Use reset_reset_bulk() for proper reset
 cycling
Date: Tue, 5 May 2026 14:30:31 +0200
Message-ID: <b29f473500bb3214a7d44495c12e4f152928b6ba.1777984225.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777984225.git.michal.simek@amd.com>
References: <cover.1777984225.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=UnrD+ml8QGmKddaN8sLah81igDE0WNiYefrozswG1Ys=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT+fPR6S4NRtfFitlD54jNXa65PD9I8esN5TyFnnf8RK
 8vTevK3O0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BeAmL2T4Z7H7x9dO546dOh8q
 rzHKHlFjzXdP904ujDvic9CBw2GbHCPDc6mXxaIRO4TNim7uXpxilW56NmW+epzWjwn3a6IX7vn
 OAAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DSSPR12MB999237:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b581e1-ab05-4e89-682d-08deaaa226d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: I9E4B+4V7e9ihYQI19sKZfA9w9J8/Km2OlYMSbsw6dKSUEa/BsFwrINbRmQvGlmiIskSdtBUM0QAphR+VfyKX3ngm2Xhxfj/h3dqDUfrFi8V4UH/0MtRvPwJDdE/hqi9Wdi/L4X0Tec/4+jDV7STWnIfqUSeLZu3p3oNmq4eKocGa0DkaAI2idcGAtp6jbuwjyv+PMcjA8GzDtjYzz7OKhfjaCtZPeWAX6eScSlFLzNIvj9Qm2/Goukrs9G9NA+DfMyufeOjnQQSv59O2EYn93wI+9W1kpUt3fISXY56j7JHlcmfVJgpDZnEVRGOdjU7t5Z2CJ0x01e4o0wI9/VJYeoyliTS/nLHJuQ8Exyu3wpTCTBQtBT1AiN8yCIMntO4OguAA6UXRByuxZGTb3dW/9ksOE/vPLJg/fT/PKMe2z2RxmCykfihTqZwptk0mQNSxoTARzUTzYN7mOy83HMZHiz2aQbYEv7wjbEhQv42EIbcsqFtYh3gniR8ZJwfEFypjRffx1mgb2436+8X6dB6XJP60HC0s44RVNeXBSbP64GA0arru/GsU8ECsgp29ZnbiZh/ZvvPvaOTZSt1myzBFE5PwJlEEASODmLcBYF67DnFkJMwil7gx+tdrSqLSxPkRyZzfxI8jmItC8uRqP7mKQRi2wKcBQDRNz/FZUrLvVAj9ytbxCQR1axLAS6UQwwoqzvhRbp7kQtTSB7vP7QI5lXcJbLJGUXCrbv69q7Sshs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PtM3FqZLFetarAjsvBuh4Hx4tcEy0d4cwaJvrtNkNlb+r4bMC+s3WB35a6XKB33LEFCKdkPBJf2qdxV0Z+L/gtsZhvA+ON+jkrNM2v7Wld7O37C3GVXWX8hP8LDoOPtxx0UwOqAaGkGPURbBuCk7SUX38bZT2yvRZxa0GOVncm3TNT0wzgLDRPdGbAuRhiBzAj7FjIlBqvGsX90rjDydGTB/hwtfMonGDD76e1g/G7vMOTj+4+ryRw6IY6Ekx8kkbbSlOMKOwbLgkmiUrDqYlgZUggFj9F9Var96yt0dssOa/TU4ht1JagUo5IxKSi0q1aakNl5LnC3SkUA4AD9XTll9M+Mkgul4rnmtkUJ/VN4VTuOG5v95lpjPrFGVNeBvYZWDfklrCLORdRWqmAY+ne/KLKqi3/wv2D9+lwJzKlQgJzNoc1/BkCIeEQx31z5t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 12:30:54.5645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b581e1-ab05-4e89-682d-08deaaa226d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999237
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

