Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC04C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C023087751;
	Wed,  6 Dec 2023 06:34:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ws+pXkNz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4421E876F0; Wed,  6 Dec 2023 06:34:40 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94C38876EA
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSdhVD6WV8uHRbLAXzeHlCfRyz8f486nBVC8PU9nsJZRJ7FHvqVre/+lNQM0dks6h/5ayqTvUTOz9m1AvkOuBL+kcoLWDOZiHwNPeiFpNIxin2ZCtGlDn+MVnZV0rAYdERKX8qBfL/CQT3Rf5yVnSkI9FWsP+zmhDMKdhzkeFX9oEGwe1OWx7PakS/GsGFBoo/dKxUqgqoKDB/CQ89OdiFFOO4vcWpzTRRYPo4uErg+ZksaSxRNsl2i+uVGKKiwXyBjceCyQtUjiglxpdBuMcX6bGeYS4jhYMAMocE3uanB/aDYmSmMzZ1WNZi+UiWM4Nim9pfsjwXEoXGbeg7I8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlybIRd3dgqBt58XjLdd4KvLoJpo79Iz9gSYOxKxh44=;
 b=iPfctGXfynut/xC1Zbi98GANomC/Z4pJVHmmG/dLWrgCHQVtF8fzUcBhM8MYmvxlyxC7QHzKD8a3Gax/flA6MGn09f/8AQGw8BXFPwOhWiUHkIa/yPN5iQdgsk/KUMCozZnSRkBgdbjnRefuyqmEgxJREzrKWhRPHbGNT10Q4c0bBOZ8ZP97e1BR6kfb/LsRIwV4YerfzepCLSpBVn1VUEmyY2wgP/opOiDCVh+TBy3LTPy8OBiNgngZbBoLlz6mnjI+vc8CJ7oRRHaiqQpsYreVikpP45QA5kgZV9GxHCXP2EoCPRJHDEBgFYWQI2DU5zUl1Rk7l9L6t7TttH8ijA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlybIRd3dgqBt58XjLdd4KvLoJpo79Iz9gSYOxKxh44=;
 b=ws+pXkNzw2fjUmBdiTDihPb0BIWLL5ADQ7MiGwfckniVubP+aJiJjNIsTm2omm6q01H1orawVU6DEX8hv8z3suFuQpiGPs+yPR4+l0I0qS38s0QkdhNL/kdwLO2xmLrTKIfHjC9QbtvwfWKGi2jmZ/erXtFnnlSHUmNUFV4Is8g=
Received: from PA7P264CA0519.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3db::14)
 by CH2PR12MB4908.namprd12.prod.outlook.com (2603:10b6:610:6b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 05:34:29 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10a6:102:3db:cafe::21) by PA7P264CA0519.outlook.office365.com
 (2603:10a6:102:3db::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 05:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:34:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:26 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:26 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:34:24 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH 18/30] spi: cadence_qspi: Set tshsl_ns to at least one sclk_ns
Date: Wed, 6 Dec 2023 11:03:52 +0530
Message-ID: <20231206053353.3745918-9-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
References: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|CH2PR12MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: f59cf8e0-83e4-40e1-82c0-08dbf61d039f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pe0Xqqn6n3fyu3oQj/pKPEXclscZZa3xskl+oQQwPvTwaBV7Qzd6Tz+1ulzwrTdcldNJHB7jKzKx312SB7QuqXzx2YyttmZGBBb77gFl/pQb01zBitJrQmLAdXGpsFO3uhXVTdJNK4pv393uq2cphMdfYaz5VMAVrWscuLqjo04YQXhLt9Md1HsaJdt11p7pBBXENgJwjk7F3okesHaLCHy9Uu1OERdnPzvnUhQSCDxVt2neu093eWXOLDoS4ZG0/GeLsAS1HhnPpm0PPLmWCdyL7zbPJaxZDPxJfQEtij5ApjgfKWmnzAGyt48tmYBzuMM/76xkr5/tYq1cSO1G+zAXVeTG+iFdfKRO42qHrmyOixXmsrlMByKQF/rbuOvxLRk8HrVzvsbIbNnnGeSWDXKf5r2oR3Q6gY7k/Ye5/qaHUgfJUHhNKwrPs5HT3os0oxe9Uq4/lHCfdjNRW6iRbr8lenTqzLtJLdJELHwz9X3OvvSXXV3TaWSBRNW31CwojdixvCHLtUGeZa/EaawxXbaj5XsqIPKd73Ikf0TA3bQILts55twyA9V5DNjwiIKvGPEWu5zPd7SPPcKAFJgy02RJeV6Aq2PvYPA0knOMWmNqayN9XtXjYQFDF1VJyd53QuysP4H+XCHT32+mlG41jQo/96T6Xb0TxRAWpyG1BJAEdTwwOD9fbTkGnTEIVhUefR5YaXncD/zlbRSHE7Q74Raj4jUUxFNmC0KI1jpj107W0xewcuOLn+/Cb1e7/5TOYD9+vF9JPZsu5hS6YlEONQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(426003)(83380400001)(478600001)(2616005)(26005)(1076003)(336012)(6666004)(316002)(54906003)(6916009)(86362001)(36756003)(41300700001)(8936002)(70206006)(70586007)(8676002)(4326008)(36860700001)(40480700001)(103116003)(2906002)(5660300002)(356005)(82740400003)(81166007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:34:27.7702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f59cf8e0-83e4-40e1-82c0-08dbf61d039f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4908
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

From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>

tshsl_ns is the clock delay for chip select deassert. This is the delay in
master reference clocks for the length that the master mode chip select
outputs are de-asserted between transactions.

The minimum delay is always SCLK period to ensure the chip select is never
re-asserted within one SCLK period.

That is why tshsl_ns delay should be at least one sclk_ns value. If it is
less than sclk_ns, set it equal to sclk_ns.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_qspi_apb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 1b649abf21..0bb46f6ac2 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -306,6 +306,10 @@ void cadence_qspi_apb_delay(void *reg_base,
 		tshsl_ns -= sclk_ns + ref_clk_ns;
 	if (tchsh_ns >= sclk_ns + 3 * ref_clk_ns)
 		tchsh_ns -= sclk_ns + 3 * ref_clk_ns;
+
+	if (tshsl_ns < sclk_ns)
+		tshsl_ns = sclk_ns;
+
 	tshsl = DIV_ROUND_UP(tshsl_ns, ref_clk_ns);
 	tchsh = DIV_ROUND_UP(tchsh_ns, ref_clk_ns);
 	tslch = DIV_ROUND_UP(tslch_ns, ref_clk_ns);
-- 
2.27.0

