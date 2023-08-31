Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6E2C83F2B
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 07:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8347C8655A;
	Thu, 31 Aug 2023 09:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F5nxFw4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3573B86574; Thu, 31 Aug 2023 09:04:42 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AAD986558
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYnpeGLlP85F4Jedv41Wj5C6ovVnO9dJJYweSIkN6zhOeuIoCT83ly2wKR3idMMaEM0ERuZCnGD05VjgEjTUESFfN7HCfyX78BiqkQD79nKlLtzITwk6f8sVyVCOjx8d52IezMe2MC/7rdHEhFQyROgx4iQdWlWa0eHmieQjp8eosBPAexRChcSxOobvesT4oaF//5JZLlFXeWlEfUIuXnHuZYYF3VuCO+u+HB4gA33mUB6viWKBOXf+LSlXtB+dBcTonzF++Z1hC+yqcTVWxxj+gOvbB/PN6YIEm1aPez4+MizmPdetOv7idZpdxAIIDxTCIc5ghAfcV3heYCUcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhtEfBp59LGrm63qmb1H8iRZt2GwRtUjxuehYBNnBag=;
 b=cRwaFZWE5pjuz0wd/gZd8+x0S/eKitV7z5Cs67t6scH0S9sDVvON7QQ7xjEUiSZFKrwfE/+OU8VLVrGyxrxAqZ/BRYBkFvKYHI7RHtCUNDXChv9OLSVMPVl0AwBsW1n6q4JoZMNmpXA05Ybs1/uin+UuRRjnyZ4WfjIQFdYACoIf9B6y/Jvq+IM0/sUy8kr4J7gC1w7CHeruZj6O6UV0eOF7LtxLo/DK0Hv0crioCqYV32XIaEHYkI5o734Ng6DnIOtY+HlwX5hAaCx4OCe1qrz9szjqcqImJGQ42+HqAVv4dEYn1Yh85By0NvBcrIR5iiE41XnD2NrKdC/P4DagkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhtEfBp59LGrm63qmb1H8iRZt2GwRtUjxuehYBNnBag=;
 b=F5nxFw4BK3JhUUhA/YcpUVLhlUgaVDBAR7NKT+APrOZW/Ph/STe848IzbWHKWPwfDN9DhMYZv+UCAsg4UPwdR7OwsljeS167HnONWRBc3/cbgDpvnmYNapfk0Kx4yd8WMa73dHk+lhQKDu+f8imD/C0BA5HqWkPMo9KIDEz6BPU=
Received: from PH8PR07CA0010.namprd07.prod.outlook.com (2603:10b6:510:2cd::22)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 07:04:34 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::c6) by PH8PR07CA0010.outlook.office365.com
 (2603:10b6:510:2cd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 07:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 07:04:33 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 02:04:32 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH v2 2/2] xilinx: board: Add support to pick bootscr flash
 offset/size from DT
Date: Thu, 31 Aug 2023 09:04:28 +0200
Message-ID: <60a84405f3fefabb8b48a4e1ce84431483a729f3.1693465465.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <08a3e6c09cce13287c69ad370e409e7f1766b406.1693465465.git.michal.simek@amd.com>
References: <08a3e6c09cce13287c69ad370e409e7f1766b406.1693465465.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=nSZ1gIUVq05w7pbrHUwXy6HfFURv4YY7LpE3sw/yB30=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpQP1lWzTVs+77YKtzulfXDuhAVcD33jZ+prurzd/GfqE
 qPG9TOKOmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBE1qUwzK9Qbi3yKmy5wXTg
 fvru283W635GizDMM2dM2xdYMu3YPdc1/HVG2UpTVnxKAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7c99b4-a878-48d5-f068-08dba9f087b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmWn6Du8H6tOcnZGwdCM2r+VhHk/SaOq2MUGgWp7URSTjrRiX4mKTmkU+cEDBWcFSvVpLKzQoHNrWLib37hT0gonTQGrO89DnxDhy+z3OivaGvfnMvmEx9MY6DxEKhIqaOEckZlNyk4+SKnEtqkimyGIfWNTssZcEuK/XCG+9TCzn6+9fS/6qI+NWYg8TKmIUkpWy7HIWog0rH4Dcd15W4EEARuorExD/NCOek3mr3UjJoOJJMVHdGTqxD+tLIGO1VubxyCM+sW5EbE6IuDIpsio3QgZF72TXIt3gMKIh23mPptzT2+Nt+b2Z5znWEvHusesDitpCai+tDPuejh9eqYkY8fvVunJ8fLUfy+6QqBH0AGXjkcFnGef4AodxAEp25Yg/8PsXArrefkRuI77lQDYSl6nCEnYmh5Y8j2sWFBBg4+mnIW60gGyLeyhzl00vQikLLc8dT5u05VC6h76IlUvpe6NHHWyBhsA7C1P7nl/Zp9qLsgcpYGBYxNVlwDmK5ruz9xDkWUWUpsr9Kgu5k2Z5h4JugJYM9975kUoRBSOHTMX9ivPH8zCuj5ANZWnbtW0nR5//vawwcgx7OukhN8C1/CIRVIGqnsx2jjFkyTJ5a63DPkx3WScOz9mi09CCZHxd8WiQsw6DHX3cKKziuXBWy7RiPLVf5JSYRnHPnJzDhtBio/WtO3OzW+Ah2kEqfAgpEgq6gmMLqmQx2tlXA/czXqc9qE6/S2QSsOWHbekMByDwumu1aYboHZMiGvwH5VAcJ0iZsesmS9w5C3Irw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(70206006)(41300700001)(8936002)(83380400001)(40480700001)(47076005)(36860700001)(336012)(8676002)(478600001)(6666004)(110136005)(70586007)(26005)(316002)(2616005)(16526019)(426003)(2906002)(356005)(82740400003)(81166007)(40460700003)(5660300002)(36756003)(44832011)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 07:04:33.6393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7c99b4-a878-48d5-f068-08dba9f087b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241
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

Location of bootscript in flash can be specified via /options/u-boot DT
node by using bootscr-flash-offset and bootscr-flash-size properties.
Values should be saved to script_offset_f and script_size_f variables.
Variables are described in doc/develop/bootstd.rst as:
script_offset_f
    SPI flash offset from which to load the U-Boot script, e.g. 0xffe000

script_size_f
    Size of the script to load, e.g. 0x2000

Both of them are used by sf_get_bootflow() in drivers/mtd/spi/sf_bootdev.c
to identify bootscript location inside flash.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Change message from printf to debug not to disturb current users

 board/xilinx/common/board.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index b3fb6acc25a3..126f0d81a9ed 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -411,6 +411,7 @@ int board_late_init_xilinx(void)
 	int i, id, macid = 0;
 	struct xilinx_board_description *desc;
 	phys_size_t bootm_size = gd->ram_top - gd->ram_base;
+	u64 bootscr_flash_offset, bootscr_flash_size;
 
 	if (!IS_ENABLED(CONFIG_MICROBLAZE)) {
 		ulong scriptaddr;
@@ -435,11 +436,19 @@ int board_late_init_xilinx(void)
 		}
 	}
 
+	if (!ofnode_read_bootscript_flash(&bootscr_flash_offset,
+					  &bootscr_flash_size)) {
+		ret |= env_set_hex("script_offset_f", bootscr_flash_offset);
+		ret |= env_set_hex("script_size_f", bootscr_flash_size);
+	} else {
+		debug("!!! Please define bootscr-flash-offset via DT !!!\n");
+		ret |= env_set_hex("script_offset_f",
+				   CONFIG_BOOT_SCRIPT_OFFSET);
+	}
+
 	if (IS_ENABLED(CONFIG_ARCH_ZYNQ) || IS_ENABLED(CONFIG_MICROBLAZE))
 		bootm_size = min(bootm_size, (phys_size_t)(SZ_512M + SZ_256M));
 
-	ret |= env_set_hex("script_offset_f", CONFIG_BOOT_SCRIPT_OFFSET);
-
 	ret |= env_set_addr("bootm_low", (void *)gd->ram_base);
 	ret |= env_set_addr("bootm_size", (void *)bootm_size);
 
-- 
2.36.1

