Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF2ACCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 11:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C49983A91;
	Thu, 30 Apr 2026 13:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IFiZJp1i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F339984119; Thu, 30 Apr 2026 13:59:27 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56DA803C6
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 13:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYFr9SUbfjmFBvf4kYa4x+UlDZwEhLACZ9GCcIsspjK5hMAOvvHkA94SIwQKdp81rmjGcyufWso6vEYm9/z9dfVxPFEfd1tz1pEiOWMomNjGkVmZf02B9oO7u3FQIBiJD15mKSgbUBaJW8GnVaU15eMgwCgsZNVjQbxIwT3qBV7e88FIQwFW0DqsvVuYde/C3U+VXPdCtG9AXABnYSujuEmb/flayhwVNmCs8DtYenw9D8LKej9cCmY3wrrdjmPIWeJtRxSPR+ujCJK91YFEWPRNqfekX8RSyCXAxvAZg0woMe7qIa4zo8C3PmEPuh/q6hJYH0GwELR3W/+xz6p12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTpIdQp89C6oXtldTDx2c1M7MlLJHzzqk9GNE7XFAHY=;
 b=NdGfd3GbYsK746Lpt/O3gb3BqC/Vh724EZluCvcPDM7OZ3C8lXMKBqHPLTqze6EQDyDobvP5qn7ZqOsjROUnYm3gQ1wk9swx0g5yqPDYDLVplgoAS9JZhF5SVbjUX9X1ACpnzMfPI9y97aYGrPo6PzSTv4BySpYBuVP/iPllydmkzKQAplgtO6NGHyk9RYFt3Av8PQVg7M3V6nKm1REtS0Z6iPHkg1GVxKebp3ml2iCzdfaJ6AKG9C4Vf3Z144MnpPmWniPWZTrGMHMSOE/tAavKbg0TVbGCd6k3mq0jQsG42eT/W4WdYtlPQEDIrrd+g8o6j2mMTulwzrp5ESj76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTpIdQp89C6oXtldTDx2c1M7MlLJHzzqk9GNE7XFAHY=;
 b=IFiZJp1iZHJXV2vHz3eD5KSw69A5ixypeevFpyLZxk1Gsu1/aEAB3y3s4petyfhzupkiMTYCaazuhQlknTXrjId0R4+dxcBrUJ48HdB6z8gYSTWumaEzPLsS1JCq6kH7qedGQ+UaCOo3HDDAwouEKdqbdNmCEsVxYbn4mGSFK+w=
Received: from BN1PR10CA0028.namprd10.prod.outlook.com (2603:10b6:408:e0::33)
 by BN7PPF49208036B.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 30 Apr
 2026 11:59:22 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::cc) by BN1PR10CA0028.outlook.office365.com
 (2603:10b6:408:e0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.31 via Frontend Transport; Thu,
 30 Apr 2026 11:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 11:59:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 06:59:11 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 06:59:10 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Ben Dooks <ben.dooks@codethink.co.uk>, Leo <ycliang@andestech.com>, Rick
 Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] riscv: Disable -fpic for SPL builds
Date: Thu, 30 Apr 2026 13:59:07 +0200
Message-ID: <6ada697cef076eaed1971c4877c402a91ad5cb48.1777550346.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1558; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=1CHZDk9doaP8v5fxW7d3lcwbsLa2nvIpT5BZo7wFhhQ=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR+duG5/n3dtccu/K1/pKMmvekqePimMXX1CS/F3ztkk
 x5Y6qcWdpSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBE5lgz/M8sfWugz3Krbfat
 FbZb6riEX04snuwjZFuclJ4SJySwiovhv7f+lKuft4pO9Joh+PrMka0lR7bHu2UoMxya+unF7lv
 uX7kA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|BN7PPF49208036B:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f1d4bf-564f-4fa6-a5d6-08dea6afea1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: K/Q4d/hWZ+dt7VGljeEabrbQ/d3q/L6Xvn761Y2CxfLkq3y4hQVajo0ajiQhHWLB5qmoK/YUPyCO9TO/F8lYWw/bhixvY3DLpd+h6GRMMwHTX/hTxoUz00NE4zdLXUv6VWmPe3kKTD7556ik4bOP9aT/x+TcjL7k+F2PjGDdRHASi78IzaaiV8FmoBxNKExTqwXdfQznGHE2ACHlF8ekWsP37P+lL0qgMxbHKHfzCOVUreVZfBpEeX9nQAnPeOSPqzwK9ELkI+HlhikRZuNdZZHfto+WeNVMiKMNxZ5Vg5BqG3+yS00kXpXtIvaLTi53+UOWsDxNLfyM1r4WiOHWkDRgq27snw5YFbCA/CFO+Fd+bwz3ousanM7c7Say2grro08+BRL3mY8pNV1vWx+tQesa7oj+fA0aQAcIausrbMpmDRho4GFcJCiJXofPvpbetC4u3Q8N4bXPcDOzVDRz1Ker44y0PN9e12IXCoXdGt+LD2Do0ZDlfUtmtBdMaQOTjxCH35Fmm6R1tbjfd5G4qEtCwVM8xZA3fLb8Ad+P2D+6ixSD72wySLjWeO63iBeUDCpNrF9fzQyPo6FyhbZdlVjJQtYVIGkEkQNjXkb4r9wTJavQyOk/ZQw+gpR7rtxTGOSpSA4yOV28sG4RHGcGnn9nFhzUNVv2q/NTuMmdj8zjqSkHvK5qYGCJJkEGxeRv65OlB6agPyyqlkEUnR+GcoXSMSvN928oWhA1JC+b3EE4q4b7Pb8fzQutmnAkDcdKLPlOkmq3cpJK7sHigzJZlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RXUngAV4Qd6HkQcSM+MsZ/zD09GCZyt0/Xc3xIOWUJxyiWSKi4RR+7Blo7XKmfegoVIb2CfsnjKcYusZ4Mq/HYQeJ8xgvlePsIQdFDx8lDaS9O5zOdJgUDLawzUKNiKbQc0VYMCbV7yQWzCu2pVJzBkxL8wvTCWXxoQVLomFv2E2dTcyUWQaI4lidqKA+E5+LDBcBL6YO/diEt25aGvwSa19XxoduqJKBduQedxuomd+KHiG5GY4JSG8d+M/RrJiL455cA/mUVxdpaVpwAX5zXInO737OAg/3O5YRMibXKp8rFMBlu6XZb8+O/hWZ2ip07fBXeN28fQKLLEG7UpUlPZN8tAPsxyuDB0zwgzeDLCDTXPuMYu5K9cfUM8m9E3VYI040JSkt30TsvxhIiZhmS5O2wmXhDF3N/E+LfKmB+R2yqte8AF7T74fQr8ZIBlo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:59:20.9935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f1d4bf-564f-4fa6-a5d6-08dea6afea1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF49208036B
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

When building U-Boot SPL for RISC-V with position-independent code
(-fpic), the linker fails with relocation errors like:

  relocation truncated to fit: R_RISCV_PCREL_HI20 against `symbol'

This occurs because SPL's linker script places .bss in a separate
memory region (.bss_mem) from .text/.data (.spl_mem). With -fpic,
accessing global variables uses PC-relative GOT addressing, which
fails when the distance between code and data exceeds the 20-bit
signed offset limit of R_RISCV_PCREL_HI20.

The main U-Boot binary requires -fpic for runtime relocation support,
but SPL runs from a fixed address and doesn't need position-independent
code. Disable -fpic for SPL builds while keeping it enabled for the
main U-Boot image.

   spl/u-boot-spl: all -1187 bss +4 data -2631 rodata +2440 text -1000

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/riscv/config.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/config.mk b/arch/riscv/config.mk
index eddd6a3b9a29..b1cfb25e7ea3 100644
--- a/arch/riscv/config.mk
+++ b/arch/riscv/config.mk
@@ -35,7 +35,7 @@ EFI_LDS			:= elf_riscv64_efi.lds
 PLATFORM_ELFFLAGS	+= -B riscv -O elf64-$(large-endian)riscv
 endif
 
-PLATFORM_CPPFLAGS	+= -ffixed-x3 -fpic
+PLATFORM_CPPFLAGS	+= -ffixed-x3 $(if $(CONFIG_XPL_BUILD),,-fpic)
 PLATFORM_RELFLAGS	+= -fno-common -ffunction-sections -fdata-sections
 LDFLAGS_u-boot		+= --gc-sections -static -pie
 
-- 
2.43.0

base-commit: 75160eb268d7a445e8483b357f7814bef30b12d4
branch: debian-sent3
