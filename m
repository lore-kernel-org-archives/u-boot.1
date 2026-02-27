Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35728FEFB4D
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 13:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6269683F1F;
	Fri, 27 Feb 2026 14:20:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LgkoukIW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C2E083E76; Fri, 27 Feb 2026 13:07:56 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32BDC83AA9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 13:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yc5yq3TG1lcVlNI183ZkVjx0e0/r6dhq7oylJXkR2cvvtBdrdbuctPpE8zbnNqucdOt7K+m+Dbn1Yb82RiXWPZiiYCOCdCLD8rNMM061txs+lZD+FadE2YBg8zdDM0YaJxhqJhG64go4z/iBRmLKVkJrpPGlzuqW0SiXYN3EtRs7IcAisE75Oy1+wr5CZsQhfqOVZH5I6mUvklxFNWEFOMI0YW4M+6oiWD4GVFDxu52/WQ/NL2KbF1g/3gO+/p1PtgwH5Is9vyj690jaqV2A1cVjY8L8t8SXchghXTSk6/tztAgqQuJI7D3xFH33Xlzs5FxDBT4VlLrnEDM21LDt+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JsyjJjq4J4f7xS3URKo7pX+n0HwrOLEOGsXjakYMUk=;
 b=OiQnNizBcBiilEDktrNK0ESYS26ZpnXOvIykgrYHXgJOe+kGeyyv9+Wkt0n7FMawJSsLmpGN8PqA3jCGOX56MUGyyD8l8LMI2bPUNXYZVdqqm+gHGEQC6VtzYwPHcXQEnLUCOCj+8DkQDf+QrBFdurIvFjcYKGZqcCTxUf1dtTKVZ/qs5jQz2OMQMNTjjySP2nW0xze6L5UBHzfE6GfHNymT0yn66EBpFzNbShyvg4FJ5J0ISnr+79vGRglBi8giUIQHSxRuSErvPE7lkXPXsnjHNH0pm4SQvL/CgRCkpGwHtbpg0HLIn6oRtALRKSMHd2Jd97FrbgzJimW+QjkMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JsyjJjq4J4f7xS3URKo7pX+n0HwrOLEOGsXjakYMUk=;
 b=LgkoukIW2aYQIkNIknqeex0u4Za+rAb8uZtXdVO2opDxVJ2xCDQVHpyAsbh2soSw3gG4xxbfGK44BZtLDW0s/htPkvYP7FYW7qthTqVSwqZr7ynWwvmNS+7hcV1T/t5TQ3OdMQ1U5JxF8eYWhxX1AHwAUnsWpqzDSZIkW10Z+DM=
Received: from BN9PR03CA0600.namprd03.prod.outlook.com (2603:10b6:408:10d::35)
 by PH0PR10MB997780.namprd10.prod.outlook.com (2603:10b6:510:3b1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:07:51 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::9e) by BN9PR03CA0600.outlook.office365.com
 (2603:10b6:408:10d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Fri,
 27 Feb 2026 12:07:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Fri, 27 Feb 2026 12:07:50 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 06:07:48 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 06:07:47 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 06:07:47 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RC7k3G3705661;
 Fri, 27 Feb 2026 06:07:47 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
Date: Fri, 27 Feb 2026 17:37:37 +0530
Subject: [PATCH] clk: scmi: Fix protocol version fetch for non-CCF
 platforms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260227-ccf-v1-1-a22c19460b74@ti.com>
X-B4-Tracking: v=1; b=H4sIAAiJoWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyNz3eTkNN0U8zQTg0RjY0sL02QloMqCotS0zAqwKdGxtbUA7Xgr8FU
 AAAA=
To: <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>, Alice Guo <alice.guo@nxp.com>,
 "Patrick Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, <anshuld@ti.com>, <vigneshr@ti.com>, "Kamlesh
 Gurudasani" <kamlesh@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772194066; l=1811;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=TP6nziCl+XxpmgHHureFrsxX2K8X8H1DZhkvT7jfPRc=;
 b=7XNvOWyN9CmNNiuNoUyZ5ZMi5my1u5otvix8ECFS0dEfYmGk3NtjK6/2Nu98ywpqcrkmw2/2s
 Jk/muDWqFCqDoAkVqvYQBQdkn7eng2Ft0DNldr2dOV+819QzzU3BNH4
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|PH0PR10MB997780:EE_
X-MS-Office365-Filtering-Correlation-Id: bb608aa9-8740-45f0-1330-08de75f8d422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|34020700016|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: JuhQIulnbnJuQZDsIUtAl1KTqa3HEHdgrCt4IwyvczrPc2XNA13P09U2/qNv8QOQSv0LKKYH9SkN/AHP1HcVHodzYUFccJAezDN/FSN3xVirVOSYl7PHM3YniE+fXBm1Md3xZXhOhpZwBz8bnlb/Jgo8PqxeakIBwurjpfeWjkthPQcDLojgsmbUzxX+p+N4ek6QYm+dw/fMFs6wbQRmuPyIqGRo4XjNUelhY7CTZlSKiX9QWWnYpLIsvH27Iy8rJXwA1+7eWIPNsptNTEWpXLr2T/ZkfkCpmnt28f05EV638BgcQAv+NVx5KXpXI5AXKvM+6a6vm2YwJd5EuTSM4we65q24Wp/FsjAe7QVrPIMbad3qWXP/qCjOzaFY6sOIVB208RXxR7Fj85kelZfq4YUvrHkUEUTWHjT6/Lq0TJfVNm7Gw+0KudQC3CBRSThYVrs+zShp2lNAkruddFBlYoz7GvVW4eK9+GblONkFEWKaH94lnHZnh1fOA3KrnxIGwG7/iRz35sKe0PEmo0qS3GQNVAFKIDkBY1enCcmbwFuS/TxQ3ShJDZdx6/tIUpmmS6i47IA4ZGp7I5dp++rt6NFRCDSFqjOr8VR1rvpEvPaOffquFfebJdID1301K0W7aGh8cmuAAIPIH+6yE9G9A+e9ddgx9jjvNFybUC3mfKXeoKjWd0sX8MWYdx2+UMyZqB7hoEPz19FVzirizM59xODjmFuxfiFUO0IgwpW8qT6C3nIJymMYWa9Sna+5hV+7ijMdGgenSfN6tvJF//P2qPbxbVGVQjCPvOTG+8izvXF+zl4jMXQ4y8GMtfaS2v/Q81j1JgGb1nPjCWqmwav29Q==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(34020700016)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gj7SZvyyPI2RcXfTlHBLWZpccEcm3ZxJUTbJnfg09AXd3bAFp96ncOw66gfiVNIYjGBH950buSJHUlK/gG1Ts4nm/2IbuztQcBPPa7xe+GbT6EugnNYpSQuX8malrbg54R7S7eY5J3NMG6H6e9glThSwW2usPANW+3OARRo//L6sXbJPbfx/xS0+UOSzrIyyAgr9c0c8qLcLiYJWOxWRnSmT3TTYH0UM3a4ZNfMZrBzHedAaKHgZEXpaPaxi+wyzT0kdRDSStixX6Ehf8iUaS1BGD5UuWVxes5HbDqzfTnP58/lHF8BDVQQpURWDmy4q9SD5EByDyX6AUHKLGr7MPt1hhmTgkDfY06mbwb+GKgvCLQ+qPLZqUecFbr4tATyfswdV9xfXAvG0z5M3gc6TlqfC3kPLo0qkB9gN/eAwTGdtAkYBONNYf5VTJj9YfDIf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 12:07:50.3433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb608aa9-8740-45f0-1330-08de75f8d422
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997780
X-Mailman-Approved-At: Fri, 27 Feb 2026 14:19:56 +0100
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

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
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

