Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D650DEDB7F0
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 10:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61616840BE;
	Tue,  7 Apr 2026 12:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xaJt0nyz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8567C840BE; Tue,  7 Apr 2026 12:34:36 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 660A58352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 12:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKbjbiBIuEQKYruAIxbYZrkGOT7z+uS42BKg9z4WbMADYyj1nwRS+v5Ezagcv34jntSQq7E+lCo06Tjzf9gzHqxvwV2LwGXSZa29HV3i+wQf03E9Z2zodv5jUSCR3q0q8B1V3DWdgvPkIHu+ncv43rmF0880/1yw8R7U4G0f+gK46UW2Cay8MZgiaYaFmLHhE5sA5axx2QRZxb8WKnlSCDmjWHxfYf2tUCZQV6IAE2PEgpetZ6aUauyCtGsWI50+dVeOvaCNhk3Nn4ceKUadLrZcbxv2gyCgNsl6ttk7Ka5L1CCeilcOF6Xw4J3jQaZe1eTB0KkBmgckCy5ZzzZ2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSUKcFg5hpzrKCfwDWhq0W4NeVlSXkr9IJO36nsGTDo=;
 b=LQU6/2oy5W3OUmrlzFGmC70fkydPttm+lEs7DJk2Prv1IpskuHEl5QDORsw5fXXsalAyZapW1k0y+oB835IdWs5qmH8tJwcbL5NYSGaO1eLbktqge5mXNcaYXyUhgz9LAqnps8v9FhW5GSTtRvoi3uEggVLGXru8mivZ0lsHbRAZgjJmPst9ubPQ1jQJ0dAltSCmEvfpNbn4PdE3xcTpBwtl2NmDn1ECH7QcWOLoGjD/q8VOMX/UJW/p/IiBu4upWD7aCJyay4g+OZZVOajmGQKBswDtdH5pMf/VPto7GJ4/JGMcmltsGHccrk1cN8xhO7742Ifdzbh6eVdBSgh+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSUKcFg5hpzrKCfwDWhq0W4NeVlSXkr9IJO36nsGTDo=;
 b=xaJt0nyzFNteEuyKFQBd9UUyQjAA8+O7yUQPOFlLoNqw7I6+JbEsrCFm1pPUzTfnkrUdByLCqRSGQycepPmkOJmziwTSyd9dMpXshd/OT9tOTOA6leVmJMoCDZ/qSrx4RwSd85SO4FG96FyvDwXy0vYwpz+LPU8/SxcDwuUJGDQ=
Received: from PH8P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::28)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 10:34:29 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::16) by PH8P220CA0018.outlook.office365.com
 (2603:10b6:510:345::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 10:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 10:34:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 05:34:28 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 03:34:27 -0700
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Apr 2026 05:34:27 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jonathan Humphreys
 <j-humphreys@ti.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, "Naman
 Trivedi" <naman.trivedimanojbhai@amd.com>, Neal Frager <neal.frager@amd.com>, 
 Tom Rini <trini@konsulko.com>, =?UTF-8?q?Vincent=20Stehl=C3=A9?=
 <vincent.stehle@arm.com>
Subject: [PATCH] board: xilinx: zynqmp: Register alternate FPGA device for
 zu63dr_SE
Date: Tue, 7 Apr 2026 12:34:24 +0200
Message-ID: <591134b1c66701fa14a21fecac4f7a772ddba876.1775558062.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=9PXsSImsEkqrydka5x91AVWb895ovWQGEKM5nG3yNEY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWReubuBXb9+2/LlZRezvgZnVNaoil6/f6Im/Yhv6kadM
 tWI/da/O0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiWeoM/+wrJ+coq5oaGDCa
 Lt+2m19uT/zSuzWmQq+nb6oqWZ/hJM3IcOCz2Gt731jJaVs2Sl2aNJvn3kzlzZd3d+3YF7Am5IO
 qFScA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b35df2-7260-41ef-52e1-08de94913f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6LtL5RnxS32K6vsabvZ7cOKNmQf/CnmCt9us3kH+M8Gi1SQXBsWp7Amk7B/j8GXRdTRiez4lz3o3kIl/u0u/OrWF9yUz+/bhxTJJRrXmYjiiRZE9cSjgvwkouIaqfXUViGM5Dw26h7oz7zaqGn0c6AOUlBTACRIhMQFiyLRwuKnYCnx6bItf82cZmk3XLvX2hgtd9IH8jJGDgrSSh7M/ZXup8eUcObelLs6zS4iSKaLS+9o5p3SJc+M5VjtUXpmYPVMBMATvKp8FK0g8sMrLF88yNxje3GX7lcnqgbojSSxcyiwcnIyqpN5S0nDWZ8z9DYjTCmlXfNN6E5X5I6PaQJCudn6IJV3HnaVkrlqNOwxMRvNiRQqvmy29NBX8L8HGD9ap5Bh6GxHVi/bIJp7UpUI3N3ob2KbyB7MAJQRIzmL00SqZI2MX5ewQGGFtxol6q1xfsqQ0LsP7r0qWid1i8/eRmOZI/pkN5ObecsgberqoS9LdZfD9c2jUj5HEvbCXMUTHWk7tT68QX8KCeQkhjFQDyIthomukJ9DY1TGNullr4HyIw6E2RNopp+IKkAm0V3rwdwBia9YRqBQU3uZNxgkA7o1JJ763TwP1F01tGNxVBIQOxMuqds4tUk3EPSDSpVIB2ASOQYDZnvRmS2wZSsxGTMbibM+MfJH6Bn+VcT5S9Cbq3AqQ5Mf0JjLoqDWb5ppydPfqkp5gB8gB/13DI7sP+ueGw2qx69j3wgPcnrV3rcoODBut8aeTAbQoz2b/7d2gbsqVozXEKRBhkvnLsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /UfJ3TwuQhdEzRYIokK80BhFMPxNGOSAOzwzKYCKteve/+jFS5IEEBqc9kMpZ4RL8tMuSe9sL2PCP1L83KIdwvYqo/B/g+C0diK61u6DIB8zKA9rMdVjvI6kMiHFs/6y7WzU09G+686k5pGa3TCVWzKMplwFeDiC0bQqERylJvq5A9ftt752rhQbd5Zv91BUpOao1ynziKvjYnVh6v2ZdA9i07fqINScxjncnJlN+LDPmCngRWIOOFEYKuLEI4cSk6RZCSAPvIqdt8bwhk0FtNKwy7lUiYzG2UA4qrRTqUxWaI4kqElNJ9djWVx2i+liCn6ygKPDAQELKEZToz1c3at5idNOaFA82899pEPyWKfBdiS7xdz45EQ+bvqtSOy0fHdw7yaUVgn4v+qdrXyfvWXWzf2jORPZn1WZX+yjV/Seg4aOu0OhFzpV6kQEN2B+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:34:28.9766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b35df2-7260-41ef-52e1-08de94913f8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
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

The zu63dr_SE and zu67dr_SE devices share the same silicon ID code
0x046D7093 and cannot be distinguished at runtime. The SOC driver
reports zu67dr_SE for this ID, which causes fpga loadb to reject
zu63dr_SE bitstreams.

Register zu63dr_SE as an alternate FPGA device when zu67dr_SE is
detected. This allows users to load either bitstream by selecting
the appropriate device number:
  - Device 0 (zu67dr_SE): fpga loadb 0 ${loadaddr} ${filesize}
  - Device 1 (zu63dr_SE): fpga loadb 1 ${loadaddr} ${filesize}

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynqmp/zynqmp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 769e52bcfb5f..a1d8ae266730 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -183,6 +183,23 @@ int board_init(void)
 			zynqmppl.name = strdup(name);
 			fpga_init();
 			fpga_add(fpga_xilinx, &zynqmppl);
+
+			/*
+			 * zu63dr_SE and zu67dr_SE share ID 0x046D7093.
+			 * Register zu63dr_SE as alternate device.
+			 */
+			if (!strcmp(name, "zu67dr_SE")) {
+				xilinx_desc *alt;
+
+				alt = calloc(1, sizeof(*alt));
+				if (!alt) {
+					log_err("Failed to allocate alt FPGA descriptor\n");
+				} else {
+					*alt = zynqmppl;
+					alt->name = "zu63dr_SE";
+					fpga_add(fpga_xilinx, alt);
+				}
+			}
 		}
 	}
 #endif
-- 
2.43.0

base-commit: 4951c9780b251212ee38ae0f368fd79e6a571c11
branch: debian-sent3
