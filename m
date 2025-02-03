Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7F9C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 09:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D45A801DE;
	Mon,  3 Feb 2025 10:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tGFpCWzU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CB5A80214; Mon,  3 Feb 2025 10:07:56 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 832C0801BE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 10:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkpXlsROjfTsCN3aMxYkSnqOKau3HMuR3ncsieVLtgmYpVdgRF1xQ/3j9puyezMtWK7ploZT671X8529h9zPa2wZyYFGQH309JVm6sSfcaZSPdaLOBVHPR11tQrIsQe+htMAC5d8hh5C5rdg+Hw7mpqe7HHQzCIT1do2RTLx2CkzMmMHuTYquDxORakuyjxsNLAGSHdsB00iSWtz22XFBOIOnf/cUUL5fbyB8+l3Q10Da8t+CqmEI/1jR1ChA+XHhdfhtUshLv6EuVkEcgT5SPxnxC5U03yqiBYBvNgUJmxLnpsdTxDRIRSx2Kt+XvYGvig8LL4mx6HOgI0WpMHBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e07uzSnFpZOkwAaepJFPSMfZ6eYwtg5gGUKW57lfCII=;
 b=ITBLKpwAjW2U6zoNXv/pcPdX1usGRT4uj+zPpgggHde7/IO9sui/QxhcoP3r0F1rQYPMtClzcKjhznk03rGgScc02Wum/SWzB3mP/HQpRKLWVe1Hm93PL1cbyubrzf5zL7ydZ13K2rN16ix7KEfLKzAJJcz/WHJllF1H8oywsLZXH9Gzo9oTEK/xJe1x7sW32fIeovGIChXfsFOo9n55GD3Rl4/u9ZmTBkiYgwC+JGHQeMrbZ8EgCfBR90fPLlG24hdKsaQOoaPHJl1YHA/0u7pVF37E53n/CKBqbGUiRsDKxZwEJapuaT9RVXikKoOrggwZayDOfMuQZUW+c9fyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e07uzSnFpZOkwAaepJFPSMfZ6eYwtg5gGUKW57lfCII=;
 b=tGFpCWzUvfyyH9evApere+ygqpqaPFwp2taCRezik+JhlyX66ww3euMUkgZwOGEOino4vTRxi9+YyMyDxlzSwvIW0xJi5RfGELWug1cuUOFeZ2VQ2U3rNVdt0uBvQNWj9fvtvc8p5WCzyF/A5zFfvNxps4GTuuH63Qk6aRacMfk=
Received: from SJ0PR03CA0107.namprd03.prod.outlook.com (2603:10b6:a03:333::22)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Mon, 3 Feb 2025 09:07:50 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::45) by SJ0PR03CA0107.outlook.office365.com
 (2603:10b6:a03:333::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 09:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 09:07:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 03:04:58 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 3 Feb 2025 03:04:21 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <Prasad.Kummari@amd.com>
Subject: [PATCH] configs: versal: update initial stack pointer
Date: Mon, 3 Feb 2025 14:34:09 +0530
Message-ID: <20250203090409.844403-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ff4019-254a-409e-e621-08dd44323bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pgfRny7qy5qF3thCmlACM8D02eRazW1lUXq9hkNIC8tUg7//XJZ+7hBq6Mej?=
 =?us-ascii?Q?ZyvuoD07qhSMZiZeGPc5jQTZyvB18epOQH75sPbINixQ7YvzHrpPIKFZ9/cE?=
 =?us-ascii?Q?pZVHN916nausvcSUnt0r9Snejj1fgnl33fYpMLvB9EARBchc4CEzJ90JFqg+?=
 =?us-ascii?Q?h3jEf0DSNb4XP9kO+oDsUrQnXrDZTYNaGqCTjNOhQrHzjA47SKmJhZZxn9Ms?=
 =?us-ascii?Q?r+Gik83xEN1aWepgCLJQD52Hlv1vWnWC1RYJGins8K9t4tMc4QgtjZRbiZpY?=
 =?us-ascii?Q?wQ92rorGJRYDj2qv7mxZNip89QA/i6JyDUkIjK4zq8xpizOR+HU74wQ8Qpi/?=
 =?us-ascii?Q?3MIx7oZJtmMTZoqPSBLXHp/Xd4/Uou9Clbc8CEdmp21LssI7Db06hOuibPkw?=
 =?us-ascii?Q?1Jtn0yaQpOqlDKFba8XZZGsr6p71A40ysIwI7BJFXDSuThzCQ6NG+PNkiwOV?=
 =?us-ascii?Q?bi1hxvdmuW34n4TUaaV3fQPDbTJ7QUV0IbV/xgtpwHKwmsXFZTj3sYPIUClq?=
 =?us-ascii?Q?YFlxTb3ZM2z0LiOZKH/Yynb0bjUqrNuMB17QMf+kpBqqhkYdRc1vKgmbY4d8?=
 =?us-ascii?Q?QZ8n7/C2o4AnuY9adi70lXhDFreT11spcqDk/o9Tv/rsg5TVliN2cPZqmjV9?=
 =?us-ascii?Q?dWR2++jnnzxQUVILqAJ2M3qM3GpjPgiOcUKUhzGduJlqUr+1a/J2OQ9W3hsn?=
 =?us-ascii?Q?TPHFNul/pzdJ6Q70lrrlNucnZn/7CzbQU87ZB5oyR/mYcigbT9k98c/rhnRs?=
 =?us-ascii?Q?8uuhQKwRgFXR/qB/0q9KiAPwpuq43zELr+q8OUakG7UB7R+gHVECUIKnw9MA?=
 =?us-ascii?Q?fGmrTZtIbWYnThdKJyKYp92rm5G8VyJ3oYLkS1DuOflZ05xyTc6EGNCEyN8I?=
 =?us-ascii?Q?emTDCW2QZMIPV1TGYRd3jj1fjw88+9MYF1atjbaUuV+QV+EW72s22VGTslm1?=
 =?us-ascii?Q?4GkNZUV2GH+XvB6JSK6eaOin8Ag8xvp9+weO5zggXRE3ssp6c+0wsNSUxgVt?=
 =?us-ascii?Q?tVt6Ax2cm9PoqdRJqKhU52HVhIiwIRkU6a9uVhvIw7XhtkbIj6wgpd7eMfdi?=
 =?us-ascii?Q?Y1BrNdRcc27ZtSvtDsYsDnIMRx07XFgAxgCfoUdS2fHtXID8M/JM3SVOAqup?=
 =?us-ascii?Q?FsjkhIwtrXEQpQhWpH3uKVkXAdE/TMcSY/fPuqG3cPHsuujEvJ6A1qQE0QAE?=
 =?us-ascii?Q?wsdFkKc4KVWJtnxL1dWlkdpHpPGfa8X1U3zsdAPB4L2pPV3bd27/G4L7Q8uh?=
 =?us-ascii?Q?VD53PudHucYLhbePEIyjTIcqPSZSR1Do6onbajkboQS3ArsRLqPGoNeSK5zb?=
 =?us-ascii?Q?wpjtDAHjcQqA6OSpj1xKnE1TCGxWUv0YEtrh+cWchTre7EzeoWsg7a7hE+9W?=
 =?us-ascii?Q?HLBrizjZ2qQGzmFziSqkp9QDKM6kto5I3D701V8f7O+F+GDRhRdS+ArpIjGR?=
 =?us-ascii?Q?sjiMRM8/A0tL9PG5/OMdEG5xPIsoMlV8RJ5jlNDn35b0wndZoKQ2Zg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 09:07:49.7384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ff4019-254a-409e-e621-08dd44323bce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472
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

The mini u-boot is hanging because of an initial stack
pointer address is used at half of the memory, when mini
u-boot is called reloc_fdt() function and doing memcpy()
for the fdt before relocation, and there is no sufficient
memory for the stack pointer. To fix, set an initial stack
pointer address to near the top of memory. The new stack
pointer address is assigned before calling the relocate
of u-boot based on the stack relocate calculation and
this new stack pointer is used while executing u-boot
from the relocated memory.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 configs/xilinx_versal_mini_ospi_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index 9af3817c82..e1cdc186fb 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000
 CONFIG_SYS_MALLOC_F_LEN=0x500
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFE0000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFFFE00
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x80
 # CONFIG_DM_GPIO is not set
-- 
2.25.1

