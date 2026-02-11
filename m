Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C02EA3F27
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 15:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E37E83D9C;
	Wed, 11 Feb 2026 16:57:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xSy07bny";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AA5F83DA7; Wed, 11 Feb 2026 16:57:04 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68E8483015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 16:57:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXm/kNsD9HQcdtCsxK+eXP/Ex0/TxJuOhXFp3cOgUXG7bruLRrwdIAAg/88leY+QHgmv8sblfz1kp6+914de4KZTyBzpEFWhA4jEN95msOVEp8LtEHAOPsQKcyK7w8abpYsgkLYgm5QCX0qci6mjs/51ECQo6NkIXZgBOSD4isZNkwCrnxR3o4rtAdrX63+wF+xEgLrZZlCV5wI4zK57hZ8s12b5oYSs928mRYg8nXdb40dsHmOLRW6Yz2Uc2CDOJ3ujD/x5pSlM9XhRcogSLu++DV69ZO0fybzayd02AtDRFuSq8Myz2SYNx14RppxjPRRE5G+DdWuuukT3f2zlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEycBmpFkj/+Fy9dLQEL1QujKrYgbBi+ItNYWtlx+zs=;
 b=EI8t9NQCjLuw79seVo0WWEpxDtSfTxvyiXAc1r/DuJ0BRfObaBksIYoILZIwGr485IG5zLhmzFfNT/HLaM2m8t4y+0Unp59HaAR0Xj2ieSYOFGirig10ntMtdK4uk3oQDThtKhzEZAXsJYrNIPR8aa0LSZ29+H9jZi0kpVbrkVcScWvLyA9+PkzuM9zHvzxuKM4lUaAPuJIWYlSj9lfICBeagilWTBe7c8lCJuA/sk1GFVXML8k58LgEZmBXh5tCGnGX0kp1xk6P0415dhtrPf9t+mWbPm+wH9q+HJGuHaL9oQnASJBwOdvxtN5DC7C2XblMowC21aAjkZnJMwh7cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEycBmpFkj/+Fy9dLQEL1QujKrYgbBi+ItNYWtlx+zs=;
 b=xSy07bny8AgEN7A03l+D+PqXTQM6MuECqAugoBT1MZyDCVhoapdC1+2bKN/7fClPWlUybFoaXs5KHpxPZ+mv/BZj+MasEsKQhXUjFaiVDg7+CdncDrILC0VQwemt0R6UrZzoWPeZqSYH4g2uaIdYdXu+infws6E2Slojo0Ai+fY=
Received: from BLAPR03CA0138.namprd03.prod.outlook.com (2603:10b6:208:32e::23)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 15:56:49 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::1) by BLAPR03CA0138.outlook.office365.com
 (2603:10b6:208:32e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 15:56:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 15:56:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 09:56:49 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 09:56:48 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Feb 2026 09:56:47 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Shantur Rathore <i@shantur.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonathan Humphreys
 <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>, "Ying-Chun Liu
 (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v8 4/4] efi_vars: Implement SPI Flash store
Date: Wed, 11 Feb 2026 16:56:23 +0100
Message-ID: <35ddf2fe394ee55c66f349dc5cc33fe1dda8f864.1770825377.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770825377.git.michal.simek@amd.com>
References: <cover.1770825377.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7198; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Xe29ciy68ajdRTTX00FTuxkLGH7EBTbCc+CKfZIfGI0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT2LFsfb7jyRM31e8pcrx2+3Z8S05l70qpw7m5VKQHbx
 c5v+LYGdpSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEXj9jZGjLOvwsaPr+6btn
 6v+q9C1SsOHJltA77cmyP+BlRfWGC9cY/pnInK/2WrjhqQVnpIlT4rH7MwP4/y7ufTb97ibhiav
 WnmEHAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f373510-98fa-47d2-9c67-08de69862a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dVX7XMvxEMn5NYRwrN+rupDYA3Pd0Kps5hMbo2ktxFgzn0uAURbyf5SV8Pys?=
 =?us-ascii?Q?xCuPasmZUHm59yH2sV8ODxTNbE7yI1AzFIe0kxwYwxxjNdWOc/PBqG/RBc4S?=
 =?us-ascii?Q?jciEiVGkTQf7GI+ANBWnJProSBFwQfauBc8UICbGLMtrHdhFRXyFd3QoPkwd?=
 =?us-ascii?Q?rfYD3ezGp2k0E120Oq4KgCEtU48K3KhCqIDmpqljjYn6+FTA7exVnH3V5cE6?=
 =?us-ascii?Q?sxIhfoC/YmDm8FtABPhg7zA5NW/pss8iWb8RYGaKC75zUMSJoW3tUVgvZRUX?=
 =?us-ascii?Q?ywzS3l6z2OUeVS4eZ7wuHNw5Mg16Ynb1H8ba57xHY9SsgGo1TpkU6k1N2LxS?=
 =?us-ascii?Q?xecRmzy4BeW5MMvEMEFneb5+PpirKBB21J8bzF2j2HwxTwwSzgC6SDVwAXM8?=
 =?us-ascii?Q?9nDhMn+clo6Y/i93L54JqARRcsCn3EW8c2nWkmfPuPFWYiE3gD6uB8eZxfxR?=
 =?us-ascii?Q?U9PY1BxMcfxEhHxBUKCLuvw9fxqriz9LiETZKRHAoFdQS8TKMCoaBY1bKDuY?=
 =?us-ascii?Q?b6czrScfWOxpdYP9yhXLispl2leGSbn6htgle3/MupEZf+t0CiguEx3eBxXH?=
 =?us-ascii?Q?ByMxpWWwzgPMVH2edFtniwXfjy1QnNJFoRTTpi4iulYDvtuniLOH1Z+Vs5zY?=
 =?us-ascii?Q?wLzcD1Kg8+b5Wf8CiPnxwaFThhzlrvSCPWaJjhvi8uxeSyZCP0cwKIVGd97k?=
 =?us-ascii?Q?9p8JU0uNPnM4Coc8k+rZEHE1Z7YB9/rdhSiA/IVgGJJKsffAsoBagyxFmKzJ?=
 =?us-ascii?Q?3P6kvADuUXOT/OD22iIKEn6wtVgLjbs0i2Tgsk0s/HgrHthZcNxSynn9Z2Wl?=
 =?us-ascii?Q?vVby8PLpnGhNSN5p7HwqAE+JZX+sQ+f0YOlKGzyXxQhDlbQl288D/YjrxTfY?=
 =?us-ascii?Q?KVshmO+RQBO3/VcyDoE+DSVBrijPoKDOYYAeRVg5HZBAdHNX2tmkUZagBRLI?=
 =?us-ascii?Q?kTfDPHcbthPVqOph8Q7uft9bJjWdb+rnHOzOZdZPIHpuon5UQAeHLMq97bZq?=
 =?us-ascii?Q?U5uvQdwuhL41fs3frC9Aw3BhgOBO4qTqphqT7X6Z1X9wFbN1WF9Utgh8nVNs?=
 =?us-ascii?Q?epjKRk7/ypWua7Kr/i4Ve5uN0D3mhRPKGLi6veG8YMG3RLe/jPcnIjpB2CSb?=
 =?us-ascii?Q?gxlKCOVB6/WIBqWH4EwyvZ5qPO/jaNZXjLPIpKILLrPxgjF7bxemVTkATGNJ?=
 =?us-ascii?Q?mchmDA5QhjCWgZck6UEHEWZSeOcEWAVcFLioll9spO2Vn7BRaa8AuS1688wA?=
 =?us-ascii?Q?HpkNqSxsn0FhJfrG6iR3W3aotwZkib8ZSYTYQjSMdZtaA/6sKYJ1xZObKo65?=
 =?us-ascii?Q?9PYizxsvK7DilCnvi91NmQKTMLz920FmqpRqWTA8sWzB25LJkZsGH5rJbGhm?=
 =?us-ascii?Q?s1He2l4M2eGlNssL+muP9mGkBijCd+LcTXhIea9a12i0vwb7D8eDdaqrv3vA?=
 =?us-ascii?Q?eLWVgG5+m8dIyD8vLgja/5XJ1jQEGrPmXsp4yhNPKbg4o8frCzAukP6b0p27?=
 =?us-ascii?Q?oUo4axv8hDJqK6s3nsKko+K/duXb+IBC7BfVmJQjdQxoDQLGImm0ZQ8/3Mxu?=
 =?us-ascii?Q?DH2u9z/Je3LuB0ZZnh5dDSfMB14wZU47nZFX7z1pdtH2sHQBWnclFeRlCD76?=
 =?us-ascii?Q?nmjoD5yAekpVWdATNbkuJLM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tyZjzGdBlnLEMB+cPpR/nyq4pNrJ5XktZM/dvBZEuob1bSXyA2otd1126NZ/E/BVNFCU62uKP7gcVPI/k+5SQMMhoXq7owGGl1K4ZlFf2PYY3pzCYyJbBkC5ug6HYSDjQl8wbMyDE4erps2xj97MNfR9bdvY2A0m6xf45KUiZhKXe1FpfzR8ULsmhDnUJ+enahutrQ0T5qmGNFCgjGR5rZP6Ps5+WaM9L7qujsAJ3FvPjyEPJ6u+FBVB3AJreVa6vb7lkPJiiRt9beCENJ3D4tB899D06BBk9xjPNrNx5WxlCjiJ9HPxG2nYlfEN70MLqT5HoxcwQtlcUpa2RjC7ASuB25rdlXwCIs6bD0vId+mbfi9G+JFPI55H7DK+uqrjZ6/TTJEhtUdMana5TL/E1e71h2xuSBYwAW5vQ/WDOOqOE4VeaJaaznY4U8KIlQVC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:56:49.4188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f373510-98fa-47d2-9c67-08de69862a9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409
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

From: Shantur Rathore <i@shantur.com>

Currently U-Boot uses ESP as storage for EFI variables.
Devices with SPI Flash are used for storing environment with this
commit we allow EFI variables to be stored on SPI Flash.

https://github.com/rhboot/efivar
is not updated to support this location that's why you can mimic it by
running:
dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c \
   of=/tmp/vars skip=4 bs=1
flashcp /tmp/vars /dev/mtdX

where mtdX should match location defined by
CONFIG_EFI_VARIABLE_SF_OFFSET/CONFIG_EFI_VAR_BUF_SIZE.

Signed-off-by: Shantur Rathore <i@shantur.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

---

Changes in v8:
- Add missing EFI_VARIABLE_SF_STORE dependency to EFI_VARIABLE_SF_DEVICE_INDEX

Changes in v7:
- sed -i 's/efi_var_from/efi_var_from_storage/g'

Changes in v6:
- sed -i 's/efi_var_read/efi_var_from/g'
- sed -i 's/efi_var_write/efi_var_to_storage/g'

Changes in v4:
- Extend Kconfig description
- Extend commit message and describe efivar missing part
- use unify methods for reading/writing variable

Changes in v3:
- Fixed compiler warnings.

Changes in v2:
- Refactored efi_var_file to move common parts out as requested
- Changed ifdefs to use CONFIG_IS_DEFINED
- Fixed typos

 lib/efi_loader/Kconfig      | 35 +++++++++++++-
 lib/efi_loader/Makefile     |  1 +
 lib/efi_loader/efi_var_sf.c | 92 +++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 lib/efi_loader/efi_var_sf.c

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 579eed658801..0f6f927ddaf1 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -124,6 +124,24 @@ config EFI_VARIABLE_FILE_STORE
 	  Select this option if you want non-volatile UEFI variables to be
 	  stored as file /ubootefi.var on the EFI system partition.
 
+config EFI_VARIABLE_SF_STORE
+	bool "Store non-volatile UEFI variables in SPI Flash"
+	depends on SPI_FLASH
+	help
+	  Select this option if you want non-volatile UEFI variables to be
+	  stored in SPI Flash.
+
+	  Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use as
+	  the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
+	  needed.
+
+	  Note that SPI Flash devices have a limited number of program/erase
+	  cycles. Frequent updates to UEFI variables may cause excessive wear
+	  and can permanently damage the flash device, particularly on SPI NAND
+	  or low-end SPI NOR parts without wear leveling. This option should be
+	  used with care on such systems, and is not recommended for platforms
+	  where UEFI variables are updated frequently.
+
 config EFI_MM_COMM_TEE
 	bool "UEFI variables storage service via the trusted world"
 	depends on OPTEE
@@ -153,7 +171,7 @@ endchoice
 
 config EFI_RT_VOLATILE_STORE
 	bool "Allow variable runtime services in volatile storage (e.g RAM)"
-	depends on EFI_VARIABLE_FILE_STORE
+	depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
 	help
 	  When EFI variables are stored on file we don't allow SetVariableRT,
 	  since the OS doesn't know how to write that file. At the same time
@@ -194,6 +212,21 @@ config FFA_SHARED_MM_BUF_ADDR
 	  the MM SP in secure world.
 	  It is assumed that the MM SP knows the address of the shared MM communication buffer.
 
+config EFI_VARIABLE_SF_OFFSET
+	hex "EFI variables in SPI flash offset"
+	depends on EFI_VARIABLE_SF_STORE
+	help
+	  Offset from the start of the SPI Flash where EFI variables will be stored.
+	  This should be aligned to the sector size of SPI Flash.
+
+config EFI_VARIABLE_SF_DEVICE_INDEX
+	int "Device Index for target SPI Flash"
+	depends on EFI_VARIABLE_SF_STORE
+	default 0
+	help
+	  The index of SPI Flash device used for storing EFI variables. This would be
+	  needed if there are more than 1 SPI Flash devices available to use.
+
 config EFI_VARIABLES_PRESEED
 	bool "Initial values for UEFI variables"
 	depends on !COMPILE_TEST
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index ca1775eb03be..d73ad43951b1 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -54,6 +54,7 @@ obj-y += efi_variable_tee.o
 else
 obj-y += efi_variable.o
 obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o
+obj-$(CONFIG_EFI_VARIABLE_SF_STORE) += efi_var_sf.o
 obj-$(CONFIG_EFI_VARIABLES_PRESEED) += efi_var_seed.o
 endif
 obj-y += efi_watchdog.o
diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
new file mode 100644
index 000000000000..61d68f7c5c94
--- /dev/null
+++ b/lib/efi_loader/efi_var_sf.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SPI Flash interface for UEFI variables
+ *
+ * Copyright (c) 2023, Shantur Rathore
+ * Copyright (C) 2026, Advanced Micro Devices, Inc.
+ */
+
+#define LOG_CATEGORY LOGC_EFI
+
+#include <efi_loader.h>
+#include <efi_variable.h>
+#include <spi_flash.h>
+#include <dm.h>
+
+efi_status_t efi_var_to_storage(void)
+{
+	efi_status_t ret;
+	struct efi_var_file *buf;
+	loff_t len;
+	struct udevice *sfdev;
+
+	ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
+	if (len > EFI_VAR_BUF_SIZE) {
+		log_err("EFI var buffer length more than target SPI Flash size");
+		ret = EFI_OUT_OF_RESOURCES;
+		goto error;
+	}
+
+	log_debug("%s - Got buffer to write buf->len : %d\n", __func__, buf->length);
+
+	if (ret != EFI_SUCCESS)
+		goto error;
+
+	ret = uclass_get_device(UCLASS_SPI_FLASH, CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX, &sfdev);
+	if (ret)
+		goto error;
+
+	ret = spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, EFI_VAR_BUF_SIZE);
+	log_debug("%s - Erased SPI Flash offset %x\n", __func__, CONFIG_EFI_VARIABLE_SF_OFFSET);
+	if (ret)
+		goto error;
+
+	ret = spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, buf);
+	log_debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
+
+	if (ret)
+		goto error;
+
+	ret = EFI_SUCCESS;
+error:
+	if (ret)
+		log_err("Failed to persist EFI variables in SF\n");
+	free(buf);
+	return ret;
+}
+
+efi_status_t efi_var_from_storage(void)
+{
+	struct efi_var_file *buf;
+	efi_status_t ret;
+	struct udevice *sfdev;
+
+	buf = calloc(1, EFI_VAR_BUF_SIZE);
+	if (!buf) {
+		log_err("%s - Unable to allocate buffer\n", __func__);
+		return EFI_OUT_OF_RESOURCES;
+	}
+
+	ret = uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);
+	if (ret)
+		goto error;
+
+	ret = spi_flash_read_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
+				EFI_VAR_BUF_SIZE, buf);
+
+	log_debug("%s - read buffer buf->length: %x\n", __func__, buf->length);
+
+	if (ret || buf->length < sizeof(struct efi_var_file)) {
+		log_err("%s - buffer read from SPI Flash isn't valid\n", __func__);
+		goto error;
+	}
+
+	ret = efi_var_restore(buf, false);
+	if (ret != EFI_SUCCESS)
+		log_err("%s - Unable to restore EFI variables from buffer\n", __func__);
+
+	ret = EFI_SUCCESS;
+error:
+	free(buf);
+	return ret;
+}
-- 
2.43.0

