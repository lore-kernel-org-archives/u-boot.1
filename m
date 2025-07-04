Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB6FC83030
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 04:05:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA96801BE;
	Fri,  4 Jul 2025 06:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZOtpC/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65BFE8091A; Fri,  4 Jul 2025 06:05:21 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D380B800D7
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 06:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtsnt9fDfR85Om1AhYF+Hx1oeoklNjz1lUyzDeNE808dBEpYwPxrkmxiG0oJ4qUI58Av2jceO0eguLdHpmGpxE5D4wtrfVsQyzlVndLi95fnjrUfebjeaCreM3rwk8y3BEN9cKcAia6km1Rh56XEvW6SWHSZyYH4lpm36lCyxXhSYjzA/eCmUCP9x/h9decnMiD78AP5fgnK4tz4OLzlc/GNnMOg49unNGACXh74V4e7XcR6Go7NBJRxuRd2/CJgI/duKC2dlEtPI9eQjm8vphhSxclwH5uRUh134ZPjfeFCKzFsvIH8sLA3WQp3He51gL5eTEufsfIYJNr6ng7bWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMTG31yQXDdyRP9G9KW1MqYgoIYtSRcGvERj+Iwrezs=;
 b=ET2l2OwcwYxiq3bMW2TCYA99y92QnTYhpB0Hbtd9TTXhK3eyTe44GTvoKdUKXMzvwRXeZsojH1E1eCOEnKMUtLoaGO6pOU8R0L0M5Bpd0aNJ9er6GPLq6qKjOb8/NjrKRe4Mu1gUa15S1u3n8kQNqkTNJ9KG8+tpLbq5U5zTcWUl5fCwu56R3twzVGlUD8OEz8brHGp/LpMabT2Gr+MCscKtn12pligIFy4tildYqhOWfU9ddvS/fpMLBNHk4zdKK4xYvptS285m37I05tbj1UR9io0IevDfopCa4tjOHRRlEf4x1cvyBh1dg1TybcKX8nZ+putPPYPH5+MQfIzlig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMTG31yQXDdyRP9G9KW1MqYgoIYtSRcGvERj+Iwrezs=;
 b=hZOtpC/xLF1bPVhlVluODcupxdBfTy+qT432Yt+5fowcauyKyuQ4vUismLmY9oGAvnQji2zJETc8fDxAmYFsmw0z5LC2aMgeqCygkZ2JElQJLzlM4WNSnJD6tEdeuIDxqOlSIXv0G4C464u43NJEoBYBld/FmPlOoI3F6mzxRY0=
Received: from MW4PR03CA0113.namprd03.prod.outlook.com (2603:10b6:303:b7::28)
 by SJ2PR12MB8883.namprd12.prod.outlook.com (2603:10b6:a03:538::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 4 Jul
 2025 04:05:16 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::b9) by MW4PR03CA0113.outlook.office365.com
 (2603:10b6:303:b7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.32 via Frontend Transport; Fri,
 4 Jul 2025 04:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Fri, 4 Jul 2025 04:05:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Jul
 2025 23:04:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Jul
 2025 23:04:55 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Jul 2025 23:04:51 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, <marex@denx.de>,
 <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>
Subject: [PATCH v2] spi: cadence_qspi: Fix odd byte write issue in STIG mode
Date: Fri, 4 Jul 2025 09:34:44 +0530
Message-ID: <20250704040444.671604-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|SJ2PR12MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3243ce-c457-47b4-7c48-08ddbaaffb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ys/hfnLOLtIQ00zl70Dy2RS6uS0Kyg/IRepQui8ltAc7Rt1CgMFgCzPU28zr?=
 =?us-ascii?Q?yMDzUOuN6iPCLmHo9C8r5vJ/TK+LZ15kY9IdZHr2oTnZxOZMlnKY/3zwZF3l?=
 =?us-ascii?Q?WiwhpFLgjwuqdrhQd8uwOo0CJHm+exxa78HIYSaac01SjPCh9h/UO7A1bDxY?=
 =?us-ascii?Q?NyUBV2r12BlmskTddyQskr3NGZYXp1ZrIinUV5ljHgvGn9CFW7mksLEsYUUP?=
 =?us-ascii?Q?vORizmyFp3KD3B3lOkRVpkrOW8HvLk/fneMObrPTIvgBFSy7nEuB7+MW/d9b?=
 =?us-ascii?Q?s5tjPwdKSYzhAOanzEkqtvplj9OlidUGW63zEwur7CCLZOSZk99OIpM+2lmu?=
 =?us-ascii?Q?7M+NX9YjEO2zM92YfHH/dMUhL4gPRP8XBKk2t8brA80oFkSWXYQA7Ce0DCko?=
 =?us-ascii?Q?qq/YhWUG5N+AWD/vrEdAJsdoHFoxTbPRsuBIUQQd0RPVHRfAF8qK/pgtHVvM?=
 =?us-ascii?Q?LRS1CVLSAbs1KeBo+KrhdHErlY6eUlZxwf0QNf2KpCwGOvzrSbi07Xc8STsX?=
 =?us-ascii?Q?wGH8sAIErdsPJoSU1saNEQ+loKGwe/AJx0YNfzT42sCMncMYTCmzmCQZdXDA?=
 =?us-ascii?Q?WcN7b5nzcdqg+OBPNk1j1cXEIyMuMZUIeoIwFoeoHtOR3JKY1LZbdXqv2XXv?=
 =?us-ascii?Q?hUjQE8ZwCxqWRZYFvaGWaxTtdKL7oKWHkjzewMPvNwT82lcGhTmwppUuACTV?=
 =?us-ascii?Q?wAx88YbROjLdD6Z3p08F+jEG17dCWiRVBDaKPbkhcmXiIXXhIr6WXzv2CmXP?=
 =?us-ascii?Q?LnjURWuxLOO0lykPP6ALXX1bdd2C2Z7gr/wZ0p5YcPxSDF5nhreHOcCUv44A?=
 =?us-ascii?Q?DTj4pgil08VsMPWmCo+nYLiGNdnwJHYgEqEBXV7y3vj9E4h6dUDOHiP6WHMV?=
 =?us-ascii?Q?f0a9ykQxlcYt3NXdPJ8XHNN/YoitGZiNkKbZitOgGbM+Ca6eWNGSfa/TD4Xv?=
 =?us-ascii?Q?MbS1UAkYTJrg937SROzx486NMBvLiechuRaLJk0mmWZItJO7OnwWLn3e77VL?=
 =?us-ascii?Q?TkP/WzniPuK63OgndOZ5RpJR/Yb+wdBwsC6fenA3ozjFgbkOUIECdOEQShIE?=
 =?us-ascii?Q?HphPgnx9jxwqOz+rCT0akR+5bZUPZ70ov+O9dSCo7TSmQ+z3JaeOoZ/Ztb1d?=
 =?us-ascii?Q?j2EPQh4lm54wb5Uq365RlY+7gr/6CehVK/yU9is+uj9osy8zA5jT29F68ml7?=
 =?us-ascii?Q?tFFlfqZB4lvNd34+Aexvkevailqsxst2IHEKQ3mvxvA1ouH6cex4pn9fLiVX?=
 =?us-ascii?Q?CKQSM/VtMF+VT3M+U6rTQ73QigkJuIY/2wjV6hAvE1usWhTInTDUaL/47rPU?=
 =?us-ascii?Q?oHUBTS2I477R+LTAXOLOQYYEy46YJYjtv87XyKM8Xaf9T/ouuzS06vz1axxy?=
 =?us-ascii?Q?hlL9kdTYUDci6inSX7x0BQfvAd6M4eMJeGlJKPcfCz8LkExTA+zHRU+IAM7G?=
 =?us-ascii?Q?n0lHrSX6Kq1f0dsFuDpZFJT6CKhNwZZ0/xm25mEwdhe4rKjSA0gMwAZ1Cz+d?=
 =?us-ascii?Q?UmRxqGMzJ0dCyqVeYnDUVhkCItraapG3wg8t?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 04:05:15.4062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3243ce-c457-47b4-7c48-08ddbaaffb58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8883
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

Starting from 'commit <8077d296adff> ("spi: cadence-quadspi: Use STIG
mode for all ops with small payload") the utilization of STIG mode
has been implemented for read and write operations involving less
than 8 bytes of data.

However, following this commit, encountering timeout issues occurs when
writing odd bytes of data in DDR mode, as indicated below:
"jedec_spi_nor flash@0: flash operation timed out
SF: 3 bytes @ 0x0 Written: ERROR -110"

To resolve this issue, the number of bytes to write has been updated
specifically for DDR mode.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
-Modified the logic from using modulus and changed to use "logical and" 
operator to check the odd bytes.
---
 drivers/spi/cadence_qspi_apb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index b579699d2eb..76569a8019b 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -554,6 +554,9 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
 	void *reg_base = priv->regbase;
 	u8 opcode;
 
+	if (priv->dtr)
+		txlen += txlen & 1;
+
 	if (priv->dtr)
 		opcode = op->cmd.opcode >> 8;
 	else
-- 
2.34.1

