Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B50D116F3
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 07:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 168C383F4E;
	Wed,  3 Dec 2025 08:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Di4WFEQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9054B83F54; Wed,  3 Dec 2025 08:35:22 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5104A83F39
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 08:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho4bRYcV6oOjXA63UmKdVBoDtQBdOiZ0J+effd3LpqTx/6N4Pb53sYGRSI1UzN2kQVxW5oi5iW9TwknZUIDImtxPhZsBUKRKc4vHRUv+DFoKWi1izrJjpkomAqWdlF3sEah9k4kDC4eMYNvHpL6Cz82QfnlfkxOybA4YRtOc+fxAsktigr7LtcSH02LxVgRKjV0I8NCXE2vrYyzZnGBZJYT8efoxqnJWpES45aF1H2AZ0iExn7AqBpYNBrnscTBhno7lBdHTmS7xM0kenbDOiBkt/sc/H5fWUeOoNt5Q2ACmfwcz6ewwIOpEDgtlc9DnyiqwoFltMxVjtFhrBIuwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjGiS0pIL+88N036jyD6utmt2Cb/F8xUWDfRslflSnE=;
 b=cblXQlnp0YYLBeAHN1L+GtNXLjU/zhQhX98s70kqbRwdrlgXw1/SHmWFVDyU0bLE4sYD7MmCHsZbJrh2/1ad10BLZW1dxlQEssydwQX+TUfOLQND+rsHEbHukD9Dr2K3YEqQ6gTBRZo1/X8BXA7ZFUMfsk6vXfR+4AOOMNoUVH7GBx91BPCg6O8GbsvpDUoxeMohtQbfjGXHBpv2ms2CzrVGgQgzI9kxHh70MYFr2zhkP7g4rrVlD1ffFQ4a6ojRNOBIUiM8mbqVd9cNVqpmRb7jRuAuhoTu11P/R0tGClss+yVimhHE5DId64Jk5Ouxk7KFVXM9JA8QKxXN8hHWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjGiS0pIL+88N036jyD6utmt2Cb/F8xUWDfRslflSnE=;
 b=Di4WFEQLsMije/w3ct7SZZ/ifDJvRHNfXQd4g2ZT4NPHVrnLia1DkRRVS51PnP5+VKfP+dcaMchHgLPlqEDhAVW3fcHg+c0DstoGoHXSDNTKQ1Q3h51sFXR/4fefcu6nFg+A+DDjUezZZu7+3HS7zsnfKoQioNDxBslF+ai+teA=
Received: from DS7PR05CA0047.namprd05.prod.outlook.com (2603:10b6:8:2f::26) by
 DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Wed, 3 Dec 2025 07:35:14 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:8:2f:cafe::b7) by DS7PR05CA0047.outlook.office365.com
 (2603:10b6:8:2f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Wed, 3
 Dec 2025 07:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 07:35:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 01:35:02 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 23:35:01 -0800
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 2 Dec 2025 23:35:01 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Leo Yu-Chi Liang <ycliang@andestech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Martin Herren <sputnik@on-the-web.ch>,
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] xilinx: mbv: Disable SPL GZIP
Date: Wed, 3 Dec 2025 08:34:52 +0100
Message-ID: <339520b249a3c69a36faf5432cbd581459563e32.1764747291.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=714; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=9h5TIhtI/8WmVJJwI8WXXUkkjCJRfpZDZpiPl7EbpiM=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTqv5BNjn8Xo/I6illeaWr2vXfXpRm3duwIP2oSqRFVd
 pxNjsero5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACbyXY7hv39u/kZhZf65//bP
 3Njx/qSaZ2GnRtiUuayJTXLPDtp9U2L4H3SZo2Gl4MN3BW2ifz/WWF2xbPis7Hzoy0/9f0ZrT+z
 bwwIA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: b1979115-4755-4ccc-7b9f-08de323e7f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CcXwgGIRoD6JGeKlZIX25N6Zyy3cbyydKHRbDmMR9YR1SnbBtwuY5iuRTM35?=
 =?us-ascii?Q?jAt3XOI3/33ySaqL7O+RiOylXC2iqZP3UeQp5QlY3Bkct3AjzWyyvXgVApRm?=
 =?us-ascii?Q?pbia/vyIsf0GP3CrS12cXZE8jHF7szxsLxDChLLPqd7LUTD9dcziovMqXO+N?=
 =?us-ascii?Q?3Y2iBMOEaj1t+XJA4LZ4/K6U5iN3iCNxBmdaI66QDhaJuIdvz+9sV2xcN03+?=
 =?us-ascii?Q?UUoKu62GGjSlUlOs62jDBXh78kiLcYfjQdkiqa+YO44QIhPq6p34rFR/Rbkr?=
 =?us-ascii?Q?z1iB/QsGf+LYy2jCAYlkQFBx4JILS6j1lB5HlF+ig0B2IndoEPu01kPZISBz?=
 =?us-ascii?Q?WesdSYoi42g8XVCGcUEAzxB0DeFqlVTas9L+R6FoN5Vhz21qrY9hOI4mrloe?=
 =?us-ascii?Q?Cf7Pc21mP9w3tK2+DxK7rLpc3jIrFg2SlmnrrUAD5m5LtJajkLmwjYwTdYDT?=
 =?us-ascii?Q?uPZ6YjmZ5yZFyM4S1t7G2oPL8gePtpUPqA4yzFz9KYDbzOXzdcs2vfmWLleB?=
 =?us-ascii?Q?Zng/vKtbpPX0SyM6S46pAnqzchAtx7KYQwWQHMC+sbFdlo3oizJR4OKD1+GI?=
 =?us-ascii?Q?OTZnQRFDUpraSRF01y/qyQPKsPI5jANvcecS+ncTuXevytpbIO/gcNGzMUj4?=
 =?us-ascii?Q?k8+0/nE4Xj5r6VGXK0rZkgZpt4vwE0vz1k59/lO3PyT+9PcGNIe2SQNGi+pd?=
 =?us-ascii?Q?sf8LzyekwmGewPxbDXABUmYjbZUH82Efw8ojsp3TGWkTtDtpoGoJEaR0b8Kr?=
 =?us-ascii?Q?mf+Vj8BDhLhMqApo83zwnrXOe37TKzSA0RnCMI8fpzbHP4Le6b3eVD22E0g/?=
 =?us-ascii?Q?DDAAaFIgL3TqE35mzL8wCCe+9jl+qvqMaK5lSsSWk4vZDGf2ITPG/3gdnykO?=
 =?us-ascii?Q?SugrctX4u1KPi5M1btnX6oG//0Y7d7JKQjptGP0xasZOa/eoA+jFkQWAStlK?=
 =?us-ascii?Q?IYf0vRK7YCcQ+iYuGd03smwEMqnKxBSQQIW+e7L5AD3g5JyA/sZJaDwjstuP?=
 =?us-ascii?Q?Ej5NGc9ZVHEfvR0Ry+yRPsh3L9u475JaOHoYA2oLuOneOCtTerNbzTaR46Le?=
 =?us-ascii?Q?XUct9OhTUKaY6ZenfFfIQ0t2GiSTgp1TMHMZ/9IvBg3CKkCnGBHX5WVgirYR?=
 =?us-ascii?Q?Q8/0Cv7whsVlTSCSkLUuk7NK5EJYn23CoErmQzp6H4V+h3IWLdG3oPZQywRg?=
 =?us-ascii?Q?ruCngT37I6ZY6F6MDZswR/4QR6rIaMgOwtUQdS3pHj+EqWWrRl/bPxdNquZW?=
 =?us-ascii?Q?VaehAaU/sIELITYnTEdKZ0GkEmm2C7Rr77PzFs8IBAwRKmkbKyvvUab+PHWV?=
 =?us-ascii?Q?jstSq81/IKixda4SreaIN/5/pZ9xz878TSq+CHudxzIuoter2SRBTu4DOSgR?=
 =?us-ascii?Q?A2xZgelmdzZLbSY4rNQNvoJT9PTOqDONgon1PIiKN4tPu1SpOgD8NihEVG5r?=
 =?us-ascii?Q?H8kUeXg33mssMWauVTcbNpj2kgvBXPuRvyE1/LX+MZPA2+tLQDkjcrbsA2X6?=
 =?us-ascii?Q?IFFTHP5JSBiPXZ8XmeFeK4ceZxgxXzZ6XoUYzKUl8rwxkwq/9dgm7WW4AQXJ?=
 =?us-ascii?Q?Q0wqSNkoVhztENlTtA8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 07:35:14.1789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1979115-4755-4ccc-7b9f-08de323e7f8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309
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

From: Padmarao Begari <padmarao.begari@amd.com>

GZIP compression is disabled to reduce the SPL size by 12KB.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 81c0f8e9e936..d10517094c61 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -47,4 +47,3 @@ CONFIG_XILINX_TIMER=y
 # CONFIG_BINMAN_FDT is not set
 CONFIG_BINMAN_DTB="./arch/riscv/dts/xilinx-binman.dtb"
 CONFIG_PANIC_HANG=y
-CONFIG_SPL_GZIP=y
-- 
2.43.0

base-commit: 2c043ed05643fee200a79eb08bfd5c0041663bd2
branch: debian-sent3
