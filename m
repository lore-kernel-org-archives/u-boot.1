Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFE0CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 14:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C64582C84;
	Wed, 24 Sep 2025 16:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L7N/fFX5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0624683447; Wed, 24 Sep 2025 16:18:45 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF62A80107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 16:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nglizi4IDUplz4UNodA96p+xx6gHqUUJG9ZmZfaU4kgqqVcbxI8o16P75EjlpL9G0LnMayVgfJGnh3ZmwWHQ5uqOy+oE8VkDl41bScnvn50uAOP1In0BrsvgG7dRb7iT9mKnq5IRWEQz++WfuJA1wB9tZzLXnxOuxM2dzARs7GaQqlOK92M+luxMVVX7QB3S3aXI8rbjeKEL7C4hyyaPqakvJCsSrtlLCYQSx4nJjh6e4ekiLdgVuvl1GMqaBy4Ttd18jLQbQNLfzWlx9DzIuLMfre0Jn33sN2zNkDNmB0ZJLoswAyWmSfOEiO3DicvqwJwPo9hiR9XzU3Yxr9mRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydPDfgb6ND8iKbuG63815PvfRhyiGg/9ozlTTbrz0o8=;
 b=NeoNiNeZpvKrMefRga9dM8a0IaWgDEFTlnNDn2TyOF9HQ/micuiyG6bYNZkkwvDWX1vA7SAKqqihP+z/fsdY2d28TKWWWbXlUD6dWZzET+ShFLaq0PFEzm/uhgOdS3WCWuDrJtAKcGHGZ/FFcsbD2Uvo/M0YZqgnml0M8PR+QvP3alunTkbVOnHouX/EwNnT8j0cRMP4XlYlmCtg0+jgn3Z41nC5LiUsOPuE8AoE/t0Qrz5mitQcrnWL6vOgyg0yAVETfC4h9egLsZKX0Ta5Zz9JsgO84CKaf0vSBUvbHnQS9f9PTSvAPzevg9EuKFFUp7eMITWjQiEkR4ySB6Epzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydPDfgb6ND8iKbuG63815PvfRhyiGg/9ozlTTbrz0o8=;
 b=L7N/fFX59Vj7LD8oGr7/ZGvCWPoGGHGy5Ow/TMOT5JEXOh9n7zUV9U6CeOJyeqCZdrLCVPypUjSn3Tlrzv+ZzLNdMJmDXvTWb+ZwNC2MFs/s25GQs6F0j7+UDkSMG3ShmnYon6fM6zFRewBxIfSX8/H0UddiGKjhY0PJdTFrXoI=
Received: from MW4PR04CA0095.namprd04.prod.outlook.com (2603:10b6:303:83::10)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 14:18:37 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::11) by MW4PR04CA0095.outlook.office365.com
 (2603:10b6:303:83::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 14:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Wed, 24 Sep 2025 14:18:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 24 Sep
 2025 07:18:26 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Sep
 2025 09:18:25 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 07:18:25 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <ilias.apalodimas@linaro.org>
CC: Adriano Cordova <adrianox@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Raymond Mao <raymond.mao@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>
Subject: [PATCH] efi_loader: Cleanup UEFI Variables menu selection
Date: Wed, 24 Sep 2025 16:18:18 +0200
Message-ID: <626d2f37e4026622d797f4806625b00c1c4b17b7.1758723496.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3738; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=LitlA3bUJP6oiAFjnp2kYHMGS3LHepKZ+FC6EBKPkTs=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRc/rt6+UtGJ6HJFgKWK8xa3L6lHFG4JKTzdcqiZbvv9
 LWXrrQJ6ShlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJvO1i+CuzRjxi71xzkXXW
 DNM5FoWmzXtW/nm3ZXjovj8XLnzqYj7AyPD1XtLxALFOL3v2s3Pv5ZT4FPEvNmg7OXOj8nzJGe5
 7BdgA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 65fbc37e-93cd-461e-2bdd-08ddfb7540c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iMoOjgEHPCQpPxoxx33Mzo1uLJ3r4Q48Ku3e5pmuUZWxTbRusOvZp5eZq/99?=
 =?us-ascii?Q?8d0U5xQqaaIv5aZ5a34IVxsxo9K0n/M3U9rylBwzWEx1tKsFx1LMXBfFURhz?=
 =?us-ascii?Q?yo8psi3Qmhzi6oGQGtmtTjI7ksfH6H8bZMfK7prUEPUZtD4TL0Ee6kIfk1vN?=
 =?us-ascii?Q?6imc4710OAEp+ztj31BhL1svWK7fD0rrBrTf2X6UsLTD7d/aEn3Wy5UTcynV?=
 =?us-ascii?Q?JPbEBV6kvU3Mnox+zEEuNs5st4zT1qWMW4vfrDhIlR08acctwW6dkU2sXKOP?=
 =?us-ascii?Q?DJ0FjzyaIOwEmAZ3w9kUxpwuQjILQV0HPuSqrZHn/bqVSpWbxjtOYPXml3Us?=
 =?us-ascii?Q?3oT16qkVqewuTDMcoKzDWiESHUrHv9kfhYIMzxJuT/4bRqU4ZmF/tfe65O8G?=
 =?us-ascii?Q?xzFstMFR0pGOFqXgxaCskr5wosvf+AEM7Ks45QmleN6x2TrybI0a9cg0YfFh?=
 =?us-ascii?Q?5POmPrcLG48GgkH0ZjvgkoyCV9Sp2n1FRCM2u6CORGw8OExlX3drY2cFWbNQ?=
 =?us-ascii?Q?CRiKOmz+XOVmZ5CBom6UO6AjSqb3hQHpeZPNNw4eIf5fIm2k0s6wbxiWFbM+?=
 =?us-ascii?Q?swlOtTfOCowkROhNv9vlj5zKce0zHUhhABbqqB+HOFrll4xNH8U3aPn8HDIt?=
 =?us-ascii?Q?zpexe0LJ4X9VCivKzVt0zLWufvjs7AsFJdjH7X+1LiMQIBJ9j4rgwyCE2pkR?=
 =?us-ascii?Q?bw4HtGWZVLnnnrgoUxpfkhmyN9pNpHRJByiEfLl2H2gszHBnC+v6tvO88WGy?=
 =?us-ascii?Q?R0B2i0SdI7ZTfhzYSb4svHf8nHtQwrmQoabYe+hhfGfp3CJojbqzV2/a/zhp?=
 =?us-ascii?Q?EfiH7+vrfOb22JrwwugA2fWZvTXdMveNp983KeS/vgYvn0+MJuwu2o4sQg3d?=
 =?us-ascii?Q?pd7m10cogIL/UB9r+c3hyq09+cqESXrH7vqpYLC9Fr9Qdy0Z8qO8AHhOErl+?=
 =?us-ascii?Q?HjdroCcpnk8Qge8jRXha019LCEpGO9wZINaG7Lgbucri7Ldjb/EEMPe2gmD5?=
 =?us-ascii?Q?vNCs+e2R3c3LRyA71DxiggAY4horOXB4aA8Wf4uGCdbGb75YmZaMAn0eDFy9?=
 =?us-ascii?Q?CTVmL1Y10ZlfENK4hl/eeQ5sLoXhQhNUUHyAZA/tfg6y72fVOsh6eXaiZdl6?=
 =?us-ascii?Q?ec6htkWL9oaIFvKDD777RPw+NgWQ99xUS4q2JbBB2bZ6asU7ZgI73UqgS5Mo?=
 =?us-ascii?Q?icYyR2eAvJx7pN4s2le1j5amL9inqigYh43UXu3wuEsJF2sS3WwFJgoB1k3i?=
 =?us-ascii?Q?LQfEYDtaxc2CTpaFliHX+YSDAca4GRBfQG7nP3Rc7XffuORSg30+lQvjaygW?=
 =?us-ascii?Q?WQSRNqPfGGBJH63e/NL4Fffbb6oFAaI88ImiL0yo08wlOUNB2ev72MkOnXdM?=
 =?us-ascii?Q?zL4vF8Y8iFqbWKIUGGV8xEHVSlxCysxaTtErvVa/hfpjS/4c6Kpdog/KF2IZ?=
 =?us-ascii?Q?1qncY2pEp8LlGApzkre9LHlj7z1jaZ+DKgxvnaqJceSFmcaZKK3x/rlpemni?=
 =?us-ascii?Q?UqDXfla0bMHDKayVuqu2cPj0RSZuc6LNWViX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:18:37.1422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fbc37e-93cd-461e-2bdd-08ddfb7540c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
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

There are 3 options listed between choice/endchoice FILE/TEE/NO_STORE.
There is no reason to add other config with dependencies between
choice/endchoice because they can never be selected because they depends on
only that 3 options which can be selected.
That's why move additional configuration with dependency below choice
section.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 lib/efi_loader/Kconfig | 50 +++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 900113ca3e9a..13e44be1d067 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -123,22 +123,6 @@ config EFI_VARIABLE_FILE_STORE
 	  Select this option if you want non-volatile UEFI variables to be
 	  stored as file /ubootefi.var on the EFI system partition.
 
-config EFI_RT_VOLATILE_STORE
-	bool "Allow variable runtime services in volatile storage (e.g RAM)"
-	depends on EFI_VARIABLE_FILE_STORE
-	help
-	  When EFI variables are stored on file we don't allow SetVariableRT,
-	  since the OS doesn't know how to write that file. At the same time
-	  we copy runtime variables in DRAM and support GetVariableRT
-
-	  Enable this option to allow SetVariableRT on the RAM backend of
-	  the EFI variable storage. The OS will be responsible for syncing
-	  the RAM contents to the file, otherwise any changes made during
-	  runtime won't persist reboots.
-	  Authenticated variables are not supported. Note that this will
-	  violate the EFI spec since writing auth variables will return
-	  EFI_INVALID_PARAMETER
-
 config EFI_MM_COMM_TEE
 	bool "UEFI variables storage service via the trusted world"
 	depends on OPTEE
@@ -157,6 +141,31 @@ config EFI_MM_COMM_TEE
 	  MM buffer. The data is copied by u-boot to the shared buffer before issuing
 	  the door bell event.
 
+config EFI_VARIABLE_NO_STORE
+	bool "Don't persist non-volatile UEFI variables"
+	help
+	  If you choose this option, non-volatile variables cannot be persisted.
+	  You could still provide non-volatile variables via
+	  EFI_VARIABLES_PRESEED.
+
+endchoice
+
+config EFI_RT_VOLATILE_STORE
+	bool "Allow variable runtime services in volatile storage (e.g RAM)"
+	depends on EFI_VARIABLE_FILE_STORE
+	help
+	  When EFI variables are stored on file we don't allow SetVariableRT,
+	  since the OS doesn't know how to write that file. At the same time
+	  we copy runtime variables in DRAM and support GetVariableRT
+
+	  Enable this option to allow SetVariableRT on the RAM backend of
+	  the EFI variable storage. The OS will be responsible for syncing
+	  the RAM contents to the file, otherwise any changes made during
+	  runtime won't persist reboots.
+	  Authenticated variables are not supported. Note that this will
+	  violate the EFI spec since writing auth variables will return
+	  EFI_INVALID_PARAMETER
+
 config FFA_SHARED_MM_BUF_SIZE
 	int "Memory size of the shared MM communication buffer"
 	depends on EFI_MM_COMM_TEE && ARM_FFA_TRANSPORT
@@ -184,15 +193,6 @@ config FFA_SHARED_MM_BUF_ADDR
 	  the MM SP in secure world.
 	  It is assumed that the MM SP knows the address of the shared MM communication buffer.
 
-config EFI_VARIABLE_NO_STORE
-	bool "Don't persist non-volatile UEFI variables"
-	help
-	  If you choose this option, non-volatile variables cannot be persisted.
-	  You could still provide non-volatile variables via
-	  EFI_VARIABLES_PRESEED.
-
-endchoice
-
 config EFI_VARIABLES_PRESEED
 	bool "Initial values for UEFI variables"
 	depends on !COMPILE_TEST
-- 
2.43.0

base-commit: 321508004b343679e9dad0fc0f7c230c68de648d
branch: debian-sent3
