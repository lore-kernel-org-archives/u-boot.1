Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCB3EC01CD
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 11:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C8CB84113;
	Mon, 23 Mar 2026 12:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d8JQyxEP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 388A784114; Mon, 23 Mar 2026 12:29:45 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD99084099
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjdZ0Rjg6jP9B4KSop+5SkWGd7oJ26GeDKpUNbUiQ9IyCOEih+RQJCIlrv1VsuBGjcfONn2AuEKGNrj8ieV2s/VLRN2ISonn8qWgEBMxiJYA12JGVlXnIvUdKrp6NAh17L3QytiFT+Rx1Gq76zeP15d4l4p4f/DuqvpEhVZegp6KZ+ZDOUnSkl60r7hrbHmD8RevL3DMv8K+4UdPmdV8BAEOIKQDCQsvEdsTmhsPwfu6dAE1GE/9qRUedQgPFXXVnnAw3jffLCC9xDi7Me6X+qrnhnF6r8pv4RUFJ2ESroi+mvHqLDNCz1yr0vxLyVkjhNWToZqasF39p/72SXBG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1yVo2uNRQ6R0pvfZj2yibYPxQZW/5qv62RiVuyMvZg=;
 b=dt+87EulqYEVCNCrJe82wlKIDICPUG7WFYfS3bpjzDtx9+D0K59U3U5AHFU93+2Ll66GOFE4DVRzbElTCJARk6DLEaHv4/nHO1SElEK/m3K3yuq8m2xetK9OtAtItmGUfnGjugLUGnT8S74RhyJqwPGr4/XgmHkn9EXvFvSgnDA18Ejlz0wJZggMNW3EDiD0O4mhgH+g+A26t4HED8zg4NE3IWkw+be6QV20mm248PWV9Cc1J/LxwcYuL4ckC1I5aK8XANoZPTmrZF08ACU3v4ZeznJh6VFHH7Y6nZWRiRI6N8gHiQDjSawfcB4fumu2YnnhmRtVYF84lBG5jx7DAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1yVo2uNRQ6R0pvfZj2yibYPxQZW/5qv62RiVuyMvZg=;
 b=d8JQyxEPlhHz3FeRxCB5aQOS+WOYAAp5EJuSGowmIa3hGX/zc5P1Rf+r6ezB4UZpwUlGpKN/S1UhC+eVDR/ecoQtdKSqqq7YN1VTU8a6DEEr96WXStk0sF+g/USWHb8M6vfGsSPpsyEL8bVJfV0sYmDDA//NGO/7SUNYhOgHSH8=
Received: from MN0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::15)
 by CO1PR10MB4433.namprd10.prod.outlook.com (2603:10b6:303:6e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 11:29:39 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::f1) by MN0P220CA0004.outlook.office365.com
 (2603:10b6:208:52e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 11:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:29:36 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 06:29:35 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 06:29:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Mar 2026 06:29:35 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62NBTYLO166533;
 Mon, 23 Mar 2026 06:29:35 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
Date: Mon, 23 Mar 2026 16:59:27 +0530
Subject: [PATCH v2] clk: scmi: Fix protocol version fetch for non-CCF platforms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260323-ccf-v2-1-0f3441631702@ti.com>
X-B4-Tracking: v=1; b=H4sIABYkwWkC/1WMQQ7CIBBFr9LMWgxMsVhX3qPpAqdgZ2Ex0BCbh
 ruL3bl8P/+9HZKL7BLcmh2iy5w4LBXw1ADNdnk6wVNlQImdRDSCyIvJeC1t2/bXC0F9vqPz/Dk
 qw1h55rSGuB3RrH7rv5+VUMIikup1Jx9G31c+U3jBWEr5AjeRAoCTAAAA
To: <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>, Alice Guo <alice.guo@nxp.com>,
 "Patrick Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, <anshuld@ti.com>, <vigneshr@ti.com>, "Kamlesh
 Gurudasani" <kamlesh@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774265373; l=2074;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=Sp5e3g5vA9yUZgPxnivhgOUkxxj2sPuJejXXNu7KQpI=;
 b=oXE7kJpN9yZ61AP/pr9KYKaQa7uFMuQmhiFvIYx1nyN1vlNY9UtD26nV+Q+Mzp/FsvLzi+1IE
 txCXp2YAnA4DWZTIDjJyqH67vU0GygiDDkcz1Ge2UY41jNx0f9cwOUC
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CO1PR10MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e63852-ff79-4015-bde7-08de88cf7707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: kUXOZAAVJ8sMV0Ge72pdHEVKQ+26CPy/qqGGrHI4HM75nzITHLbS5iCw3M6llc11KW0vzY8k+9mW4e9JcWR/d1GsU8UyBeOyLkLpxQCOdwZWITDd4h2eaJdHTsTJzldJXjahA53Ja0a0iTiS+tkQC/egKRM9dIO/i833yp5yqznRPLLlV3TygN3kUURnMuyR230+4iRYQauYWz8jYArFFu0BOtuQvzVkkYs6Sk4jmgttGWSjebklKaQO1kmF9qJtKXdB4m60xszPRqZ3GOKU0NbyBi9qo8Ku0O9pkPrDtT3oi3s5Qwie0poVTRjKJWR+oPr5YKw+8pKsUaeYDqbQisJB5F/R4k+tUWBSy8YWcLe4MUeKRYq2kRPgje7QbD8bDIGBpxJL5kGulLEMbwEO+dQhAXRo3LVRkD443ySKQSjMNV3+gNey1jzzo9qnpHqbg87b/geIAo3PXOUd1ghXP2F/aCGbrRDq8i+xx8ttru3SYfBPUH8RvmkOXJuoUfNhRXeLggMBFoTuxaEU7pEhfMM7eNfdRG9g+fdjEUozJlbN84+z6KxnQmjDtREDMQtGnKI2VUjTPQZJZY00oBfi7uJF5u9KH2xHxslBs+3EM2rHfw/iJK2o/4NLC+47N00IzNz2TuXpwW5capKdfueHSzIDEEOgZMssOy1wNuT71RzsQSZbsRDCbus4oZwz7KuoNu3M29CpTg3sjfguiS/cW3/w+mry8Mk3syFsVi6OeYUh6VjZP2bM31VY5XcafoLLqlacARV20gvln5hf7R8eCQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KNy4hFR9kX2zpPOXDYiV9aLlcrFIavtm0TsCULVS7NoVKM31K5RmYiLLn6FA5Zu20993GszMhKoVe38KkiV7esvlNWGZdnTXPJZA6dcQ4FixxfCwuxZwUG/+fBaEZwz+b4u28Pw6dAnSgY49/cWHRPHtDer7Vaz/ttdaqpxlV/E/WIoE1rUrAubF0zFhJR/kUG70vVYE65hHAKWhJnbvBjKkZQo1yXRV2DliNhhCDZlarFXAP59HFsc1d/i6ZowBw8mLbjrQrSxXws4xhuvTMpAL+dw5eZWtjuv3ExalihFGjMwkQ706zYvPJI24gx67W+HJppxHpUrdBXWqgfrUYMhfzPe8yJjNgauZCYAcnjeId25s9dTgg8/XQ9HrkP8rH/E8bOLk6mqopBMkVxZR1uNAIDb3mLxyUiBglssV4P0Wspr5Lys9lcbfJvoZKGTM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:29:36.8596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e63852-ff79-4015-bde7-08de88cf7707
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4433
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

The SCMI clock protocol version was only being fetched when CLK_CCF
was enabled. On non-CCF platforms, the probe function returned early
without fetching the version, leaving priv->version as 0.

This caused issues because code paths like scmi_clk_gate() and
scmi_clk_get_permissions() depend on priv->version to determine
which protocol message format to use, even in non-CCF mode.

Fix this by moving the scmi_generic_protocol_version() call before
the CLK_CCF check, ensuring the version is fetched for both CCF and
non-CCF platforms.

Tested on am62lx_evm.

Fixes: ae7e0330ce22 ("clk: scmi: add compatibility with clock protocol 2.0")
Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
Changes in v2:
- added fixes tag
- added platform on which it was tested
- Link to v1: https://lore.kernel.org/r/20260227-ccf-v1-1-a22c19460b74@ti.com
---
 drivers/clk/clk_scmi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index ee237ed6337..12c7b1e8254 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -341,6 +341,12 @@ static int scmi_clk_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &priv->version);
+	if (ret) {
+		dev_dbg(dev, "%s: get SCMI clock management protocol version failed\n", __func__);
+		return ret;
+	}
+
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
 		return 0;
 
@@ -352,12 +358,6 @@ static int scmi_clk_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &priv->version);
-	if (ret) {
-		dev_dbg(dev, "%s: get SCMI clock management protocol version failed\n", __func__);
-		return ret;
-	}
-
 	clk_scmi_bulk = kzalloc(num_clocks * sizeof(*clk_scmi), GFP_KERNEL);
 	if (!clk_scmi_bulk)
 		return -ENOMEM;

---
base-commit: f6963fc232603007c661411fb31c57f1a9678a87
change-id: 20260227-ccf-d7f40a33985c

Best regards,
-- 
Kamlesh Gurudasani <kamlesh@ti.com>

