Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F238E7BD83
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 10:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C0983C67;
	Mon, 16 Feb 2026 11:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VMsKfk3k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2ADF83C72; Mon, 16 Feb 2026 11:27:55 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1CAC80086
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kobKAvconMseAfcqGy4Dcj+Z0jXrTIDky+HZmIqhwJBEFQLc2ent2gGSjenjAdkyzA25w1GTAO6KC0NqlDZspFKHyRnNkDB4ApqjgfDmD6B/hTDe6ofXlz7D5M9bQk2UHeGSHOYvEizsRIjH1ReOMSWE81WAAes58lP0XtHiUPZS10le/JGoufTFrl2w74bjZUuWTL61ZQOsYri/Trt/OvXpZk81kwYRC1vg7Ztkom3tp3h9sVa56D7kyVuqBkHlodfhFkNTYp2yj/GWNP0lO9Mbqb4HkV8UTRbtxN+AGH/09PGs3phL3pcKN9q4/SjDvs+lUBJBNJ3RpFkKRgbTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtijoZn7ssSMeshu0tN1zbY4J8ZdjpA1xYMIKWNx4Ac=;
 b=osljKOnNdyDHesCpiRisKb/lZQU10CKA/F1/O3/BY4c1hJ8OJEYjzBaK4F3zQbruS8DiQ/9YP5CMI03KWCoz55GSf1FZECpQHLuRugYIzURH/8BA8EQlODSNswIhcctEsxlU1uUhdnCslOaErA9tGwUtzDXI60jsyyPWGEuUaz8SzV9h2OoBs6J9ACCjLjMSxwoxqyzIV3vhiBfYx52THRAst2bIaaKk2KBOJxayw/JsOo4OvQHbtOfqvTNpUteu2Fhp6KXvv4bSIoYAk6CkN7e3w+uLVZsOzypNzW1WHfW+a1ZNJKdi1YZCTrnXYzbX1KaEVz9cOkC/9Bhp1eJEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtijoZn7ssSMeshu0tN1zbY4J8ZdjpA1xYMIKWNx4Ac=;
 b=VMsKfk3kgapHdNiL/7frkMTsm1u/LtdBfcFlE3+bRVM5YucIzcleVAfKRv6ciw+TsIrTB8raNo3Bqg6OnQxMM+EUed+EzIzjNhrXh4+inmDL7q4BPjJxd++YUEhf7HrGInzhkm2v8vUpJ1bkbEWtoCyBn3IQmFh/Exawmb3FaMM=
Received: from BY5PR17CA0066.namprd17.prod.outlook.com (2603:10b6:a03:167::43)
 by CH3PR10MB7236.namprd10.prod.outlook.com (2603:10b6:610:12a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 16 Feb
 2026 10:27:49 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::2e) by BY5PR17CA0066.outlook.office365.com
 (2603:10b6:a03:167::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 10:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 10:27:46 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:27:45 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:27:44 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 04:27:44 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61GARUHb1147835;
 Mon, 16 Feb 2026 04:27:40 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <c-vankar@ti.com>,
 <neil.armstrong@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <u-kumar1@ti.com>, <j-keerthy@ti.com>, <semen.protsenko@linaro.org>,
 <afd@ti.com>, <anshuld@ti.com>, <peng.fan@nxp.com>, <ahalaney@redhat.com>,
 <mkorpershoek@kernel.org>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 02/10] phy: cadence: Add config to enable Cadence Torrent
 PHY at SPL stage
Date: Mon, 16 Feb 2026 15:58:30 +0530
Message-ID: <20260216102858.2745657-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260216102858.2745657-1-s-vadapalli@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|CH3PR10MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: cd416d8e-7a27-4232-21d7-08de6d46073c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?31dONqsMRCHjT2XSNK/4ZKXWBevMS/T7f8u30Pvp6rqhFqQOkj9S8OQDu40h?=
 =?us-ascii?Q?4aP8wtUJ7BpsRbQ2hK8INEsyPFVEuTnPSXwChtBI2pmgg/2/GYFv3xAP6yh+?=
 =?us-ascii?Q?LV3zrsgrPlUrxHG9sA/dW1iz4NEc0O8JYC71xFne88RjB2nbwzP1sCZdiYF+?=
 =?us-ascii?Q?tDcUVSTnzfpIGm1n5fbwXrZjqG+IfowrOoBtziwrFd33o9fn3tJKo7WKrLon?=
 =?us-ascii?Q?aTohob0EnUg4EPxkZQJVMH9ytDJnMxgAHe5squ2TtkYUPFMROgVuQHAgdo4T?=
 =?us-ascii?Q?QVT6a7rJ859wEfJdHf7qwMkvnal9PXnFRt3jQ/ORQQmaHuA+0c9ZLOcmWeTf?=
 =?us-ascii?Q?2x98sY7VYnT8X933N3tvi9iJpemoqEWNavXhhB7gcGCc/ILqy8I6myx7Uvfy?=
 =?us-ascii?Q?cx/1J2VsYTV5llJweTJrrpLbV8SVLF+KNCa9wqO/5ZzMPpihoOohL0PjMzy/?=
 =?us-ascii?Q?j7nN4H5atZAusW7QrmAz92a8oY/YejZqf6yEpVZq9u9Aq2Uuwonc+XCg+gPg?=
 =?us-ascii?Q?8gPxUvl7xJhmdrqok2hmVzgSUMm27mhi1wwWnHeKT+DPj7HxsGxeI4TiEiXd?=
 =?us-ascii?Q?8cm+zhJ8Ah4ipgy+YBFg2rfdqOyqozu2l5UF8+bfj73hsl613KCcIS5ZYYvY?=
 =?us-ascii?Q?IKXlCH0aA/+erLzmzYJ/B5EkWlAueqhOgl+46DJA16UXHuZOj0b0ag9FcFEe?=
 =?us-ascii?Q?zzUTxNBGuVeStYEfGwbjaeUELWklPH7R+cb3IYNxqxmDYV9y+UzHS96msCrJ?=
 =?us-ascii?Q?Sq1MASMYZaEIp4cU404qktpdgEKBlJsk5AZ4X2fHZ3MaWdx4gdz0ldIZmr3z?=
 =?us-ascii?Q?LX8LmrqVLusU7UiLZb4nXo9JJZNLA2//8/SoQh37gptybxcbNtFZdRVdMDeR?=
 =?us-ascii?Q?klwfrC1FRLGU7MJEjIDuDtf/9Fct2ySY1viY9m/qXnadjLJjZNMT0GwrVmIS?=
 =?us-ascii?Q?0CJJOx+T/bbEf/4Nc8a5Zk1UPZaQXq/0TJqQgHvySW7toWnZiVfcYbO7bR9n?=
 =?us-ascii?Q?vsA9dWlp0v3v32a4N/1A5SnG8avgNhD+aEPGOFeKMLzwa1Yfk4wPhK/JS44t?=
 =?us-ascii?Q?zVuD7tp1kp4I2Qg0zXr18OEahwLNQ+7RI5NwZMoovp6srxXlLKGhoJJTv2sn?=
 =?us-ascii?Q?EH9gRwcunOzFxOMqetL+XJY514xnp853sUiD8dpx2tedvGTV6ocOoOcb+09a?=
 =?us-ascii?Q?Mr4jS9nhY1USvfW0kyJUYe97vF8VDbT+6NG83Xy78CXEhcqIWD5JAm8BnlLG?=
 =?us-ascii?Q?vOQGaj5shHArpMeSJ2dBp43OHO3Deb8X3BX/n1tf+/FzB3DUDr0uWVdvC0dI?=
 =?us-ascii?Q?ZwzBQpCcvR/QqoGKidgPYCPektXVwX+8Mb/+RhCPQwcXKaBCoAQS8Vxci7ah?=
 =?us-ascii?Q?Wuo5jvA7YjfZ5pd6IkinX0CB4YMCxPWVSO65ksMWQAe8Ws1+8LtikWMf7r4K?=
 =?us-ascii?Q?oYZwolqbij0ANRbHCbinO+67Q30ue2Gr73lQnzqubUgDTcpjkqe5x3tlOXRP?=
 =?us-ascii?Q?k4Y7Wn0bJW6MLnHb27IBwm6GTGNninpPMvVYSZcEQsVJCc/qqnRcvGi8Petm?=
 =?us-ascii?Q?wQUdLRstjhSCX8ZUkNh/u6JytK3XhvDA2XZlurVL5bLUU74GUHBTysHFlRh4?=
 =?us-ascii?Q?YO6oR5gSawUmEFwyaYEN0O4IzQJJPAAaSmXguQ/JzJJEBuC0JVLzz0OpbowG?=
 =?us-ascii?Q?mrL1drHhYTMEG8xptv862M76Rs0=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZS0GHDAwpRLx4G8RaSXm9/oZ1nZgixmZfE3RqiTVZ+/S/m3I2OjSy+FSi/49N5TKOMh4FBUkHRUATJHDvS/aklSk8ncAbeT/+HF1E41EZJR3QrlrzWXYLYrvVFauMKl1f3bXGB9l3ZYYo4akFPfxzj1Vh4MUcLw/5KLJ8lwdxzQpA1H1n5OnRDOSF1KSJAnzRrdZtWPc9XNaEdMQ+DkPdUzWOnl3puVBgNyxwZSBM7+WkaOuFhUdbe51u6bt3vDlJ15XIODj4D9XCGEXJTvHChVNEtAVF4NQ3oxidEj1J3ogL4ULXP9EHeLwjJMerHHp47N+pRBHx3InN+VzG8piqYuzpLZsQvavARsyjksffsVCCxJMPByePvKuyVuofr5O6jS/2ZCaIHeL/rjiqDmOi/szaCvKSbnBeQrEuzHs7thlqjvRv/aDunoIb0YUo2Cu
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:27:46.8374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd416d8e-7a27-4232-21d7-08de6d46073c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7236
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

From: Hrushikesh Salunke <h-salunke@ti.com>

Add SPL_PHY_CADENCE_TORRENT configuration option to enable the Cadence
Torrent PHY driver in SPL stage. This is required for PCIe boot support
where SERDES configuration must be done early in the boot sequence
before loading the bootloader image over PCIe.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/phy/cadence/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
index 549ddbf5046..8c0ab80fbbc 100644
--- a/drivers/phy/cadence/Kconfig
+++ b/drivers/phy/cadence/Kconfig
@@ -9,3 +9,10 @@ config PHY_CADENCE_TORRENT
 	depends on DM_RESET
 	help
 	  Enable this to support the Cadence Torrent PHY driver
+
+config SPL_PHY_CADENCE_TORRENT
+	bool "Cadence Torrent PHY Driver"
+	depends on SPL_DM_RESET
+	help
+	  Enable this to support the Cadence Torrent PHY driver at SPL
+	  stage.
-- 
2.51.1

