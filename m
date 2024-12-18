Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54F1E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 13:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E5868021A;
	Wed, 18 Dec 2024 14:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ggkHHZ1i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B862B80243; Wed, 18 Dec 2024 14:01:49 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EABCF80214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 14:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVXCc4VrwB8MiCEuv+oRu+GCpls/c8i5PCyRN2I06QLTxlo3McaJu0nR4r8zobajGEKK2wIX5Vg73UeI2AF2AneMQ+8xR2BlpQjcuT6cbtsoRSIvTClF2O5bMUTL13AupQYRARZLiXJhWFq/pH8bhOGJo7WFFkZ/N17hadjQG4EY+SsXalgqs14izU3SJ7zd+zqhkCmI/2GHCAvDPxfzLsTLraWgWcj3MwajSmH0U7NVb+mLOU6w/xaO/mFkpks6tS2pMH9RwzjDxTkcvqjuohabF8EHorZ1hjgmUi+BBIyDt4BfG3tW7Ize+U4wvcmFwCw0OIYDpbDziBYLW2N1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVDD1UznqkHM6Nj9EyN3iB9XAyb+kSYr9ASfuADc9ps=;
 b=d7AmtDMo6/Flzn8chKISuH9JloEwt26euDaghVF1cFCGVhplyWXgmvHHlcsMh66JsGI8qJstY42+zszsXbt5m8cEJpZza36Fwrx9MXJjDevNKuo6/osnsj8h82/KRIoKDLYa6v4XWviiiuOBWxej8G+BDQssMOSno/vkDEmd+zlNuI/e39jia+p9Lhp8iM13yRVGlbGghX8GU98R87uTeNUt+6EafrWbxT09wuE0q69b4VUY02lthnLYsVCwt0MJ2SQDMv9B7g076Yi4hRVFz76Y0xC+od4VyY1RoYcXBMhTraKyFP4Las3qJt45vqp5o5x4Udpj2AqOUIrTbsou3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVDD1UznqkHM6Nj9EyN3iB9XAyb+kSYr9ASfuADc9ps=;
 b=ggkHHZ1i1Y++fFjgCjCsm3ChUtutHmh6fZfM9jZ9bDcUth0qPOSLSNZTH1iOrkOzaSlz3ACC4oehCcQURTPxohx4aZ6wWDVXWjlDpjKsp7srnyiiIVWiInLrghNHFze+Nt2AkNmkMankSQUfbv+q+jY1h78krnPIt5uAmP0By70=
Received: from MN2PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:23a::26)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 13:01:41 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:23a:cafe::2b) by MN2PR03CA0021.outlook.office365.com
 (2603:10b6:208:23a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Wed,
 18 Dec 2024 13:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 13:01:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 07:01:40 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 07:01:38 -0600
Received: from xirengwts09.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Dec 2024 07:01:37 -0600
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>, <git-dev@amd.com>
CC: <michal.simek@amd.com>, <love.kumar@amd.com>,
 <Jayaprakash.Chilakala@amd.com>, <raghu.udatha@amd.com>,
 <nava.kishore.manne@amd.com>, <ibai.erkiaga-elorza@amd.com>,
 <luca.ceresoli@bootlin.com>, Neal Frager <neal.frager@amd.com>
Subject: [PATCH v1 1/1] board: zynqmp: zynqmp-sm-k26-revA: release DP from
 reset
Date: Wed, 18 Dec 2024 13:01:29 +0000
Message-ID: <20241218130129.687650-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: neal.frager@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ded96e5-1332-4c46-30e6-08dd1f641d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MqIVlQamzEXG7kpvatMgHcfRtQ+vc+Hk8jParO5S8mF+Qv9/hJjYjtBR3m4X?=
 =?us-ascii?Q?fbHkJjHLjGRpOjzP+0YzMUaefjNgE9KXp84dsZ7Hl+Kmv2Tg/OogoIsQ6oJJ?=
 =?us-ascii?Q?en5hPHz13sBJpdEvFwu37ARxBNEv6J2d8WVd2h12yxfHrv1FCZUXmMHJ5gmp?=
 =?us-ascii?Q?EtG/Zkj0HInkRAxQ7ln5x7cxKylQ2Q1n94BVMMeEiad7qTNyz2raTzstxoF+?=
 =?us-ascii?Q?AAVw6bVo5+5IN4AFwPHrnm4ftNuJB5R/QXX/YTKf9UEJFvR3lsLScABtm+/E?=
 =?us-ascii?Q?PYw5nK1O19PDYiBSdUGHdbM3oBhd4dDPuIArN1Ie+5lbq+7Mcp4xYgWS0AE1?=
 =?us-ascii?Q?BmcEYSGHrbHFK/UtA1hy+N35kcvr6s0tg6QLwrCP4Nyol8RPOHwTAK/t4nLm?=
 =?us-ascii?Q?871QBZT5UgfTwT2i+kT9Q/YoN40m48tJjAeYVGoAuBAzlOjM3knspLAtL5pm?=
 =?us-ascii?Q?AFgBd5PuxJYO+PYVGUviJUj1GQJ7KqF9QmuwZraKRMVYSf5fwzxzBuV62czJ?=
 =?us-ascii?Q?Km/mZUVoQ1AwEfK1banRRrt84iakJmGpmJkJEikySAcxUI7dlxyyGCXyU7w0?=
 =?us-ascii?Q?MliHG3RfHg1j1cG+zNSV/EnqMQbyZLCHlYv6cJ7ye4cR24M+AiemhhN2P/6V?=
 =?us-ascii?Q?379Xjy1L1M33bPSxPW/XHUDJvH/Oz++MJ2w3rks7OmpFCN/rr/+UakDcpfXk?=
 =?us-ascii?Q?tYMGuvs+v0bF6RTx5y1E5528LI2j+oUGPoZ0Mf6/1qfyuOQMrRKPqovImGvl?=
 =?us-ascii?Q?EcGoVX4cLI+LcTfaPzt1zDsA5IQKq0mjJHvexq2nYRNed87oueoy1U/vWUdd?=
 =?us-ascii?Q?s/fRF4phYAXJf59Q49FdngRdyJ1RKJuOBU8iaidUNjT6m0e6sMuhdVWL9rM0?=
 =?us-ascii?Q?RB5SgCDgdTvVoV6elrSjgugruI6FfxI9JhXZjF2G2LsMx5DFm0VpTyqW0H27?=
 =?us-ascii?Q?LBbiKMsKkkpZLHYMXowR4aZNVXUmoJZQnNqpcko0GZPl7wNbjOg+ir/zOT8w?=
 =?us-ascii?Q?HLMZKBO0RDY7jWsSY4d8j+6+pEHY3RPOa8EADd957icO0cYxhIL5MQv5TfnG?=
 =?us-ascii?Q?jJ0uD4DTFI6emR73UDNC8hRIVtn6PmK2nSKXYXAd+UeZxEWD3V0XyTWN1IKB?=
 =?us-ascii?Q?y1wxeU2duV0tC3EsWOQ/FmXQE84N4W0towOqXGh5o6uHlR+IZ+42xwuM9ves?=
 =?us-ascii?Q?vF9JsSEfbZw1Y0QoGYUEq5roH2xZhSnlAQDEPfOsUfstt7wuPWSwHdW1rmYc?=
 =?us-ascii?Q?BHSU4UxctoBgRYzaCwHJTq3KDhtPI1eVp4M58d7TSfYF/3alfUetagN+hItV?=
 =?us-ascii?Q?VhSYS0k+u8sl3XMaZ9BA7g1qWH+07xd5OzWtd7ipq82a7Q3qzGwuZoXXAxdO?=
 =?us-ascii?Q?pTXXMsWUSjPrkUWRN2zj43NHHxryxe5WgJFHIzhoFTklvhWPyLmKFCzeHbBn?=
 =?us-ascii?Q?lva87h39CUCCysucKjre5sAUEiYkI25v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:01:40.7067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ded96e5-1332-4c46-30e6-08dd1f641d72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
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

This releases the DP configuration from reset early on during the boot process
for K26 SOM.  It will also avoid the boot hang situation should any attempt be
made to configure the DP registers while it is still in reset.

Fixes the same issue as described by this commit:
https://github.com/u-boot/u-boot/commit/8b81010a2fe385524b58bea9116f1b6954c3d2bd

Signed-off-by: Neal Frager <neal.frager@amd.com>
---
 board/xilinx/zynqmp/zynqmp-sm-k26-revA/psu_init_gpl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/xilinx/zynqmp/zynqmp-sm-k26-revA/psu_init_gpl.c b/board/xilinx/zynqmp/zynqmp-sm-k26-revA/psu_init_gpl.c
index e5598807e8..f8d7c8466f 100644
--- a/board/xilinx/zynqmp/zynqmp-sm-k26-revA/psu_init_gpl.c
+++ b/board/xilinx/zynqmp/zynqmp-sm-k26-revA/psu_init_gpl.c
@@ -465,7 +465,7 @@ static unsigned long psu_peripherals_pre_init_data(void)
 
 static unsigned long psu_peripherals_init_data(void)
 {
-	psu_mask_write(0xFD1A0100, 0x0000807CU, 0x00000000U);
+	psu_mask_write(0xFD1A0100, 0x0001807CU, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x001A0000U, 0x00000000U);
 	psu_mask_write(0xFF5E023C, 0x0093C018U, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x00000001U, 0x00000000U);
-- 
2.25.1

