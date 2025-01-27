Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80985C0218F
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 04:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B6C2810F6;
	Mon, 27 Jan 2025 05:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="nOWclAyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A3AB80ECD; Mon, 27 Jan 2025 05:16:35 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::709])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAF5080FF2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 05:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk/5cxeSrYF9mUm2E5O6WLTb+AixsNPpi8OLFLzFURm7xBanFPlBZHs2GeV4ZrZsDwgKsDAUU0tLuNMXdrOTHSwe2ojOweoLoAb/Lccv8xK9OBg/4rV6C1iwJ9d3Af55cUjIPnEIiIQYGt32mFrlFM+Ngsry93LeSlwrueY+OOjGOICPlR0i5Q4LEg6ora/S4c7PBn0WdfwBO3f3yoocw7f1WcL+S50W3tE4822hOs2g6UoTp4zGIabzsyL7waL3ypCy+qYizHslXM8b1u7bq2vsT2T8CDGzl2eDxOlTdXR4dwRf7zCpH+PyLiLsCc1QQ1Fyzne3J9O/nrM0lmHfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kOP/3nlX3xP3pX4ppETewprEMnRgQw9w/R6uFhNzb8=;
 b=TJ+U98QhyNKpmegB/mNhFQiILzDbnIjiE7YhQ7QZU0ZohFqd6hYzIx9fHAXFXM+ubDpq2/6pIhvSZFZ4/Xb06EX2cx/wiWeW3i3SAnZ+WVhYjvi736srYRojK/rLf9u8fUChiq89WB23SUzpXLR6i6Mm13bJHcFm+sYiASYRvynn+I1UFpIOjfBTYeqFmXnHlKVxWZN7wY1dFoHQPkcE3gutnQBkR2t6goZhI9D7gd2MBftcQvL0lhwPh/6KJFPSw8oE0kQKoylk3T9/ABSYwpQIDIpKXt+2pOf5j6saqx8bwc2jRh3Y6AVcdSO2lpOAvj7IWJOoYu49siQlhEVB2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kOP/3nlX3xP3pX4ppETewprEMnRgQw9w/R6uFhNzb8=;
 b=nOWclAytY9I3cwmPDUaaZU8vX23mhPev7yWz4jBd1vGbxX0mbzyxoEV004cxrhkB+6XMeW7J+KSDF4+XIxyZtZLc9+5PrRDJT70bw7uMjrmDVvf/96yvUN2EU2sA6KY1kgYLdUjJs4dEgjTsN2zxTtU8XuAdL1z08F/Xiqv2upDGIqHKLjzPsBqjg3SbwDJAjLGymI4wnoo8U6+JkSXvYnbT9m3Fgc3XVw63Aho98ATL7Szccgyexgo4wh9FaK5d9VQyzjkyUlKGD8DtFXUYFZ5uhiNcxVhXMh7EnR7S3ZlF45V7eGSJYb3JzHePhk6vkOjk/uA+7CGegHwijlTSqg==
Received: from AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16) by
 DU0P195MB1474.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:346::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.22; Mon, 27 Jan 2025 04:16:28 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:208:0:cafe::5) by AM0PR03CA0039.outlook.office365.com
 (2603:10a6:208::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Mon,
 27 Jan 2025 04:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 27 Jan 2025 04:16:28 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 27 Jan
 2025 05:16:27 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 27 Jan
 2025 05:16:27 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>,
 <d.schultz@phytec.de>, <d-gole@ti.com>, <sjg@chromium.org>
Subject: [PATCH 3/3] configs: phycore_am64x_r5_defconfig: Enable
 PHYTEC_SOM_DETECTION
Date: Mon, 27 Jan 2025 05:16:12 +0100
Message-ID: <20250127041612.985929-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127041612.985929-1-w.egorov@phytec.de>
References: <20250127041612.985929-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000044:EE_|DU0P195MB1474:EE_
X-MS-Office365-Filtering-Correlation-Id: 0324b777-268b-4ffa-e177-08dd3e895f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mhv0hSEsI0BtEFVh1xLS7pa0mYRDX2OMi7GZXrBOo8SI5WS9ineGmSVgZmcX?=
 =?us-ascii?Q?8uIY2/O9SGKPw6qqOCgvkPl+V9t2gXGRPPw8Cpta8Ztutnl6L7jgKoJf59sH?=
 =?us-ascii?Q?xyxnwVAR0kX3cxmcc/dG5FrDm2bNUT9P6+FlD12H07GgdQLTg79nrp8m4/cP?=
 =?us-ascii?Q?9/l2TNkjW6tUJ8s376Abq9jXS043iK+dG+Mfo7FoDWU6JNpGNaDEuo0IEhIw?=
 =?us-ascii?Q?VR5NvX0Hhm3whl1u0+hLV+knnjNsl2/xa+LZ8H0pZuvIAvDsjQwLv9WYbzvt?=
 =?us-ascii?Q?0WVqKnCvMl1xkaCDNTXc2ZVnCheVEekVQkmsY8jCTq3W3h5lbXWThtaFciud?=
 =?us-ascii?Q?QNg2J4OTDCJWD1MOEo3GHAAzaxAmTinzPEQ9kP04Tne66DE8fEpVkNjgIf9W?=
 =?us-ascii?Q?P53hUaow42hjwFtzk7ZX6lRaDifVN333H4JGNhy7SOee+RM3tqSOQxnAeafO?=
 =?us-ascii?Q?sozdouYi2rhMPrSwU5VE74wBLeQy2frbcgYq55SfGvZqrydYYL3is0WC98IM?=
 =?us-ascii?Q?UhnEcpOBOjhJns3IpwJ4a9Mjl6c7K4s9cHPlSzKNmIOnRLzreG79VXLqi7Xy?=
 =?us-ascii?Q?YxTjmXhbHI+N6uiFQTiclqRdxoTZeLyVfm+GcmFE7fApo8T+JjR28HSg3I9j?=
 =?us-ascii?Q?mQQP7PFu9FHD7LTXJs7OmvgfUSlGtcLL5OS44A3wnEr0Vk75bsZbBfu/7LZd?=
 =?us-ascii?Q?6WpifHVCEX0YspmVTw578v2bZ5CLQSRJWkY/MaYwua8VES1OKTZRzlW/5Xk6?=
 =?us-ascii?Q?Iam3I5AwEeeqEwvy+hTz/ZBFlEzJFTk5XTDZMB9oo0SNNce0EGZveC5U414j?=
 =?us-ascii?Q?1M4zQ540rky0P3Yttpv4f2+6tSI9SWEzzZPLB9Y2ntpKE48x5dhnW7iciN+i?=
 =?us-ascii?Q?iZM9sRXm1986NZ4iWGBaF9uwm+57CZ5VtcUb20KjrPbC+LEWi1BVqh6SXJia?=
 =?us-ascii?Q?mRanIt7Poe9sLsyBEOpBDU0k445Yrf3XQ8+1zMadWug85xYL0Kd5NY1kDgGf?=
 =?us-ascii?Q?1yjBh7V3wk5YNCGjN43UZNMxiCWraeUt+npDfY+hP/NW52ysr0GfoQq3kPg3?=
 =?us-ascii?Q?U/Ay2Y41TOO1gtANDX2o+om5CqG8EhtzgmYXX4x+knEoFdgXRbdTUM/bo8Kd?=
 =?us-ascii?Q?HTGLN34D5r9WZTfPQBEjpYp2z1T0/Kvk4SdYjEzUeIxvNsyV9G+7Gr5QkYzS?=
 =?us-ascii?Q?jhmx1pqDJHUa2mtmOdAJN2py4pVv2AWHXtdbd0atLD7iSeNvStV0OaXnP0bR?=
 =?us-ascii?Q?T66H15MV7ZkfEhAB7Rwe40XoQKCd8Z/0IrCMHf4VVEEh5N7lP/i4Gp3nyFPh?=
 =?us-ascii?Q?KasPWiyyMaNGkDfXyXeCaVKaq5j0L79fNkQGoVlvU348Qhm0EiL4Zhu4/17T?=
 =?us-ascii?Q?Ec9V8odV6m9WUcFsLFGfUWcNr2UGpNfCem+xyec8cj40OBRKMzt+5YbW5Wi8?=
 =?us-ascii?Q?QTx4DxYYgJ7PXvF6RBw/MjradkoINWB4wo/XqhH/WXf9AVrzHwAj2hpkJMIH?=
 =?us-ascii?Q?aldpAAgrTMCwtsY=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 04:16:28.6784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0324b777-268b-4ffa-e177-08dd3e895f53
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1474
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

Enable configs required for detecting and fixing up for different RAM variants.
Also resync after savedefconfig.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am64x_r5_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/phycore_am64x_r5_defconfig b/configs/phycore_am64x_r5_defconfig
index 2d9ff95d781..a764298b186 100644
--- a/configs/phycore_am64x_r5_defconfig
+++ b/configs/phycore_am64x_r5_defconfig
@@ -5,9 +5,9 @@ CONFIG_SYS_MALLOC_F_LEN=0x80000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM642=y
 CONFIG_TARGET_PHYCORE_AM64X_R5=y
+CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x7019b800
 CONFIG_SF_DEFAULT_SPEED=25000000
@@ -16,6 +16,7 @@ CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="k3-am642-r5-phycore-som-2gb"
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -34,6 +35,7 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
+CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
 CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
-- 
2.34.1

