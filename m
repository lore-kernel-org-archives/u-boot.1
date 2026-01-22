Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEC1D2ED14
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 12:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C5083AC5;
	Thu, 22 Jan 2026 13:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mI1nTT55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A65BA83B23; Thu, 22 Jan 2026 13:50:59 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E3FE83B03
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 13:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBII4thdOSoRlchyw9U4zxnwRnMQE37j0YsiQBQnEDw1DS8w/g7dw3atofplY0JxE0TKNbAQQPRSvLTv35zZu4EooT6fyLGmIL3agpBSfHS+jmIix124TaWLniwmlXrwqzpK/wzUbpKoSAvtMH2/k5BTx8BQRjLk0yMiDTrOyx2lUmxBP99ZE1IqcnRUXYFPZpj+5CzGxyWOjVBT4enBEWLKaAfRGIF63/ihoYwNkW28U7zF9S2w1uqurp4/MUKjw1N9FHnXdztt2cSC2etf+9pmx8/q4K3wFPC9CfnGUe4vEK9AM07vlhcS2M8CIBJCFerpCRwo/o0fU/X57bhyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SkV6ct06bl08plHl4ZWClql6FXGxajHA8SpmTwvdzg=;
 b=FJ/2UtZncttFPR9r/U1Od09Cs+zuqoBz6LQonINUNIxLL/5+WlizJZRcd9IhdsR+xvTp0QaD3ya/9Cp73OfYwAfQ1xEXVSPht0xkVN5pgJjvzPNp5LQ76xwQe9hbU0SpkKfq/55NC80hlLcTd2d2LoSrBFYV3h7ZA0V28lsu514Q3r0upDXcTMQj8b1/n076qsrSdh0JQlPuIzLcxR7ayDkDKrXe53iU9mDckX05pD1X++X4sJPcbdXV8SIiYUnl/4/x9Ed35jpemPg2TObq2eyPldi10oGtYmFlv3Suvw7qW1DgVugGPGAQ+1Q+8QdWaVFIE0sMiAZJQLpN8HIVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SkV6ct06bl08plHl4ZWClql6FXGxajHA8SpmTwvdzg=;
 b=mI1nTT55YNqWzzuL6DS8ukUpNdQgxO/BogO1yZkmqTV8MBZ9s/N5aJChWK88yIUHOhvI972HICcA4ZbK7dGQ07QfIGvpKc752ZdoHdVohUHhlrjIbQkeeOkevHusCkov9G5liRykZv0Vz79i8JS/9Dfc5OC36egw/JhbvyG4fTs=
Received: from PH0PR07CA0074.namprd07.prod.outlook.com (2603:10b6:510:f::19)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 12:50:51 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::a7) by PH0PR07CA0074.outlook.office365.com
 (2603:10b6:510:f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 12:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 12:50:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 06:50:49 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 04:50:49 -0800
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 22 Jan 2026 06:50:48 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Anshul Dalal <anshuld@ti.com>, Fabio Estevam <festevam@gmail.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 2/3] xilinx: Enable GPIO delay driver on Kria platforms
Date: Thu, 22 Jan 2026 13:50:34 +0100
Message-ID: <6f8e496a9d402449356eba8f02dce2804a75fc6b.1769086229.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769086229.git.michal.simek@amd.com>
References: <cover.1769086229.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=688; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=gagkgLunzG7CQVTXAJPZKVfc8GCzeQpT44RaBfmtNG4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQWycq3vonL6/396/2R3jPzZxSmBtaZNcxqVBZf65d+8
 033fs4bHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRT02MDF/X8qUUyR47VbhS
 Wsp/21bOPrHy4nMreLT9rlvODBfYZsrwV8J2371FPwWlWfyzvj1+VCI6/UOarWH7zaaad84fYpR
 c+AE=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0f9fd5-dada-4d57-1299-08de59b4dfb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4FgmUKbRBab3cc9tpTa2I2tlGf8hwAzbGREhZ1ps1fcy+tjhcNRdmmLzKqac?=
 =?us-ascii?Q?qzVWWcDdg9iXmsDxC7AwE0S/rlZ81f5YKYish3L8mPZMqETQ68Ye8GDJ8lBH?=
 =?us-ascii?Q?npPLQiMUqxfJctSim11FMRgb8xxM9B7yNEAjzwQQnVMFfxvBrr7Vm12HtopS?=
 =?us-ascii?Q?3kWPqwyL2L5clE0E5KkhiHLa9igIW/FnXAjv0HhFLikp/cEX555x6tGP5/rm?=
 =?us-ascii?Q?doz0ZmwEMMJCQ9R7i7MzB5fzVo5/CdWL/1diDHNjk64HlYdjwq+GVj+BYUbd?=
 =?us-ascii?Q?kZCiEb6+mnQhqHsuD2rRFuG+rGTfHL4TwwyEfbQtBaKuhyekOnCaLvbWhWGQ?=
 =?us-ascii?Q?xR/6yYRmP2fJo4Tf3uFHCb+w9EUgfPQJSRiNuC3NF8BAAzibcvTrICdItZO0?=
 =?us-ascii?Q?vH7bkeoGfIOPzHuXqYL4GjxsMeeAJGyoiOv1w4UL9Vev8Qijd6MOZlcp530D?=
 =?us-ascii?Q?CIxNFDKuCJyGCL7Uuv6Fst7tFj5fYsUEFp86TMyxRvP7QLsJdRN0sqLKcH73?=
 =?us-ascii?Q?Uh++VXZEHMxET+fsCazbqPiTvRbzHQt6Se4Wl0+775qUwyB4J9lz1hNfjvxM?=
 =?us-ascii?Q?AzzQedderpJLEpPTBc+NB4X2yMCNeMIHkhbRxyCWG0Y74VU4OpDDv9HUJdK0?=
 =?us-ascii?Q?JvynjJTxlf1wiN1DqFqQO4E79UEiWi1Z7hdgt+gw4Xufl/Oy3LgblyiinSwZ?=
 =?us-ascii?Q?cRKtqg4B9xmaP9b1Etxb4Uh7AeLzZtWb4lxabZAjtmMaMBE62q2iyFGaE3B5?=
 =?us-ascii?Q?0fsTKfP+haUgdwKEqDZJqsZknblLd8wjbC7MYxgbkhXFEciDxS8RejDBh79W?=
 =?us-ascii?Q?bASZWYcUE2ewySs1C+KICEM9G66lyUjh0v+52h/qSA4lXpFiOXDDY+lOBOcf?=
 =?us-ascii?Q?+dPrzax4oVLjq5iYCsoOUEa1D3MJDLzAbx3qAElsKg1gUc4aUAuYxSn0cR1G?=
 =?us-ascii?Q?K49xnegqZVLksCz8RH5ffOM0aKB6kkyIn9Q1Ru6GNVl9mADlgCoDlyxMk7gx?=
 =?us-ascii?Q?3knBseG5o9YRg+wiXBKK4uRqieyFZHQ1PEDPbqPGRf1kVwHPIqUjNRRbDhnY?=
 =?us-ascii?Q?6538/LpLr3Pup+uGmS5Tq0hehnbF5zZadGEjAJ3p8sLjKUdJzBnHKzhpeIQZ?=
 =?us-ascii?Q?ZYNJCV9juhBug65u27YltWIpUKHnHCCKEt0SHZ51Z3xwQsy9wHmFSt3amnR7?=
 =?us-ascii?Q?L3ZKnj0E6KBqr3Ut2K6mC35pfZDowrnAH1pgt2padAvtPFynnzA5s9k1bt8l?=
 =?us-ascii?Q?Tldqdl6EfFFL9Nf+m5eVvJ9ZxXKt4pQdKKX5fjWVTxT3DWerXYj5HkVe4k5P?=
 =?us-ascii?Q?+ogZgTMk8ROXVAFlHhtsWpZqhe+vVDm6AXG97WSvNsm+ALBHPfIMfy+47jg6?=
 =?us-ascii?Q?jj3oK7y/ywVlynIkVwogycB30kYsaZRIwGjMmehJN+UeXEALDIGEDvVAuc1n?=
 =?us-ascii?Q?hwK28xHZtua5KX0msd375sY4yJa+cYjqYWYlyaWP8JTnQZceIHvbk0MSKhj5?=
 =?us-ascii?Q?bpxoygNC+M+yAOG+HT0cdXduct086wMtoYaPZQkqpSbnsQzf3/T+Yym8aURz?=
 =?us-ascii?Q?TEVHhFQo6zSRHYSqiM3RxU0F4K8wG8IRCaJWqRAZWxNfHQVfSoJDBzCEqc7f?=
 =?us-ascii?Q?/ZW2vVsnptCk3Jcct1dBR89g5TgiC29ss3hKg2X6JoOgwoYm0+YWbe6/sqiM?=
 =?us-ascii?Q?tZA7sA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:50:51.4471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0f9fd5-dada-4d57-1299-08de59b4dfb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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

GPIO delay driver is necessary to use to extend delay times for USB hubs
available on the Kria platforms.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_zynqmp_kria_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 8ad05e371892..1e0728fa4f3f 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -136,6 +136,7 @@ CONFIG_XILINX_DPDMA=y
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_ZYNQMPPL=y
+CONFIG_GPIO_DELAY=y
 CONFIG_GPIO_HOG=y
 CONFIG_XILINX_GPIO=y
 CONFIG_DM_PCA953X=y
-- 
2.43.0

