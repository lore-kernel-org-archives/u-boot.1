Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F215C5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 12:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BFA4811E9;
	Thu, 13 Aug 2026 12:08:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6vqNEjR-IwFp; Thu, 13 Aug 2026 12:08:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7D6A811EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786622882;
	bh=+mPD4BKWr/P7hP/NK8uIth8NA3dLo6hmNu5mM8Y0BOo=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZIYRTv4z830E45J2feg2+iiE80owNuqyVAhZGDqqQdZFuMZEY4F0N/MH0bYEYvQPM
	 v/yt1IuuXIVrscEf1iLVf6ZO5qrVxB4aAVu6OcYH31dnrtw609UjIs7Di7W7b4hZf/
	 PbavS3qdJP257+Fm3fo6ZAoJ+hfvyVdSqjjMChz7KOClHvcrX2tc3q5LgC902MOlaM
	 nM7SextwVJk5Q0SxxyITWwFYOLqEeyzkbpHX8Xy9EjG56iFmIQsjGnvBEB7WdqI/6v
	 vY60ODpTqden8eHdpjcl1z1ftXmFBeSBfZIf2aJAQYTZIsS/ukAnTa30WcT4nIN8rL
	 m6qaDIDsPggwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7D6A811EE;
	Thu, 13 Aug 2026 12:08:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 04F951B8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF1D7811EE
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:08:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7SPzpv-iuzDh for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 12:08:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D9EBD811E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9EBD811E9
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9EBD811E9
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8jujsfcY2jYC143o1wsWWDbgdfK+GiD/mDbkiuzqh/ceG0pUwEZYD6aAohatCcEUD8lH4FaL5NOOs7DJrv9xcHvaRpzWVkGXrggPgWotRY/wmT4wSE70q1KMmEoq2LVdERgOj/156RCGNsJnDw5LrGICUbhOVGezuNGs/0kF8iLzBuxgVqXjgksosMh+9OtmDdw31L1yGpLPUgSFVzoKoOz83kKz/wumnfThnb96qkfxzJz7upIBrAL/u9jDSQPUvcuGJoSlerrjRUXs63U80UJpjVi5D9L9H7EkYdUH3ICxbH2LAHddpy0bHlrDeBdPRaBvMdAWjf6kKYkN+Fe8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mPD4BKWr/P7hP/NK8uIth8NA3dLo6hmNu5mM8Y0BOo=;
 b=GzkrGVFpS4qmQ4S975whyx1Q0zuu4y3YFTnRoi7lGvD/vPzOXVNzAQvoXLY17JLRatzaDDxWzV0K4JqNxlgWdcxdDS004nw8/oaq+Wh5q1uyYvXxSqqo5ITEFST2695tobrzfYYXCqU/1wZIcciuaIIzPf3eDBsk9mUs9k7/HVMI2YsAni1FoTcGryLb74NVhyVpPUqNUaMgUaxKsjfbnaoT1ShjF76e3AO+C5krjNgGpKJT4glRSe/5+jn0k4TsygYyci+BpBOCsBvZg0/ZC55h2lhb/Nb3s+UOMnscy0rqhr7aqA05Y9/DjUHTmhlG71Gki/0NCqqUi3oDeqPqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from SJ0PR03CA0112.namprd03.prod.outlook.com (2603:10b6:a03:333::27)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 12:07:53 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::74) by SJ0PR03CA0112.outlook.office365.com
 (2603:10b6:a03:333::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Thu,
 13 Aug 2026 12:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 12:07:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 07:07:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 07:07:46 -0500
Received: from xhdamitn40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 07:07:44 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@openedev.com>, Siva Durga Prasad Paladugu
 <siva.durga.prasad.paladugu@amd.com>
Subject: [PATCH] spi: xilinx_spi: fix premature transfer termination at low SCK
Date: Thu, 13 Aug 2026 17:36:58 +0530
Message-ID: <20260813120718.1707573-1-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f95423c-0634-47c0-5bca-08def9338066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 6LhbiRvMuEhIj7U+iDJfXsziFqV4RnmGRkzr5eaFkpMcWit0X+qYkIEj1FB0QmjfvhEKp0BKC5/20CkW2Q5HoDty81kF63PaleYn2YHB5y3Ld9q4gHRwWKAGKnumhhZb2BfDQLCZ02GqUaDZ6wx9nXCVeSRHdOUbvcFEJnYUvCEdyW/Q2kTnL3HQa8ZWpVLMJ6Y8HbHEQqDH8dNWJT26dwxqe/HMXpVL5ylqXcDkbZ2kh1fqks0azr1CpNRNeSRHYYoQhmNcOZWk47Vr8tbnp/7K4Qzm1jr6qbRhTlXVz0WuJOwOS4h08VxVeuSLxzhU6cPY0WMnCaeifzKFgfGQXxxc7C9IRfluLo+DA7o6oHUb8wwgWeoxZdZmvcCuIbHZNN83X4BOPcEjqVnQ0fHU4oFuVW3jBjT3dsbeFUTM606YaflUtMTmQGm2s3BKukg+KKO0tU1E5ILY/fwO9haUV2xCzIuvN4rhrDgvl3qTWwOHgLTS/fKjqz/E4O4eRtGVMbUk8U9X/xUNMDXi+EtRMqcdFMnmbC6AJ6gqfu/Ft3t57b4QdVgsCWtihMxISmYqT+D2ac7FWBHznTQZ576UKOVho5Wyf4eD9tSp1MYZqh7+F2p6qJe1ffLkYvNIZ5ctSEE4i2Jep6g/wud5TINK59sYXAFu58Walc6F7cUr57rrlDkGqe+kRAntdpiiOfD+e8YQuQVPEjvjr2LZja5skQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oxw4vmEKDNI4dHX4+WDR6iLGOnl30QXeifWj26EKFt8P89rVy1N2vTMAp/p+hgZCxi0+cGKkPbJTavsFEZP6rMeGM9GkwAhppEpHxPV1womKkb5rLhGVThXlBv8Gt8md9pWmkG92lhKTqwqiNbYh/cNqxmDts2UlYnDVoOmZ6LAQ6v3qaS4R4FKXmGm6ThueKx6nqPOvOJob1lnQOi2joaWTeq5VP3bTnnBJKOVg98rr838bR5l+cHk07Pr+YgPHqF3/LUivIKN7iIN5oSkbbNmwfb4gWf2X0nD1NKZMo6LQwd5A7vLvyqDlxgDzoR5nZTXZ0Xw+pHdb4CJE6jt1YJ8sLuN0sjQhlQu+E+7zGKTryI4PT/cQsXs6qpCqshrGHeuo4p72czxJTYg2SxGV+9+AOkMJKKwoWTZo7ol3QjcnuCX2Rjmn2WPYIjfa248D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 12:07:52.5314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f95423c-0634-47c0-5bca-08def9338066
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mPD4BKWr/P7hP/NK8uIth8NA3dLo6hmNu5mM8Y0BOo=;
 b=zYM3JWk27/zmTXzKcy6qwmSaWwBu9w7S3KyPKIg9WRH+uzsix3zw2iUJodFQr0m/i3AYB6DzNMzIrpt9tAoKN+gxoA/yXz9HRJmPSZof5ZIzQ4+xk9QjVZUcx05SfKysP+apzHH+lDMNfyxAJMc5cHyhZcVGT3BG5KFwDVI7b/U=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zYM3JWk2
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

start_transfer() asserts SPICR_MASTER_INHIBIT as soon as SPISR_TX_EMPTY
is seen. SPISR_TX_EMPTY only indicates that the TX FIFO has drained;
the final byte may still be in the shift pipeline and actively
transmitting on the SPI bus. At low SCK frequencies the gap between
FIFO-empty and the last bit finishing its shift-out becomes wide
enough that MASTER_INHIBIT gets asserted before the transfer actually
completes, truncating the last byte and leaving the clock generation
logic in an error state.

Switch to polling IPISR_DTR_EMPTY instead, which is only set once the
last byte has genuinely finished shifting out to the slave, and only
assert MASTER_INHIBIT afterwards. Clear any stale DTR_EMPTY before
starting a transfer and after detecting completion, since IPISR is
toggle-on-write. This fix works correctly at both high and low SCK
frequencies.

Fixes: 0c0de58f7b30 ("spi: xilinx_spi: Modify transfer logic xilinx_spi_xfer() function")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
---
 drivers/spi/xilinx_spi.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index b2af17ebae9..011bbc93076 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -53,6 +53,8 @@
 #define SPISR_RX_FULL		BIT(1)
 #define SPISR_RX_EMPTY		BIT(0)
 
+#define IPISR_DTR_EMPTY		BIT(2)
+
 /* SPI Data Transmit Register (spidtr), [1] p12, [2] p12 */
 #define SPIDTR_8BIT_MASK	GENMASK(7, 0)
 #define SPIDTR_16BIT_MASK	GENMASK(15, 0)
@@ -256,6 +258,13 @@ static int start_transfer(struct udevice *dev, const void *dout, void *din, u32
 		reg = readl(&regs->spicr) | SPICR_MASTER_INHIBIT;
 		writel(reg, &regs->spicr);
 		count = xilinx_spi_fill_txfifo(bus, txp, txbytes);
+		/*
+		 * Clear any stale DTR_EMPTY before starting. IPISR is
+		 * toggle-on-write, so only write (toggle) the bit when it is
+		 * actually set, otherwise the write would spuriously set it.
+		 */
+		if (readl(&regs->ipisr) & IPISR_DTR_EMPTY)
+			writel(IPISR_DTR_EMPTY, &regs->ipisr);
 		/* Enable master transaction */
 		reg = readl(&regs->spicr) & ~SPICR_MASTER_INHIBIT;
 		writel(reg, &regs->spicr);
@@ -263,12 +272,22 @@ static int start_transfer(struct udevice *dev, const void *dout, void *din, u32
 		if (txp)
 			txp += count;
 
-		ret = wait_for_bit_le32(&regs->spisr, SPISR_TX_EMPTY, true,
+		/*
+		 * Wait for the transfer to fully complete before inhibiting
+		 * the master. The final byte may still be in the shift
+		 * pipeline. Poll IPISR_DTR_EMPTY, which is set only once the
+		 * last byte has been shifted out to the slave. Asserting
+		 * MASTER_INHIBIT before this stops SCK and truncates the last
+		 * byte, which is observable at low SCK frequencies.
+		 */
+		ret = wait_for_bit_le32(&regs->ipisr, IPISR_DTR_EMPTY, true,
 					XILINX_SPISR_TIMEOUT, false);
 		if (ret < 0) {
 			printf("XILSPI error: Xfer timeout\n");
 			return ret;
 		}
+		/* IPISR is toggle-on-write; write 1 to clear DTR_EMPTY */
+		writel(IPISR_DTR_EMPTY, &regs->ipisr);
 
 		reg = readl(&regs->spicr) | SPICR_MASTER_INHIBIT;
 		writel(reg, &regs->spicr);
-- 
2.43.7

