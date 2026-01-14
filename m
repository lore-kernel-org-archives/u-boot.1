Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7E6D37E3F
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 15:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C2058352B;
	Wed, 14 Jan 2026 16:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y4/YX/MB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AC78836AC; Wed, 14 Jan 2026 16:16:04 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5943580433
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETyK5WkEHL+lQAOxuZ0vQLcUfRU0tYXmiJ9Ccdq0tQiLTxwpEsfG90024SBD+yDIhkpoa0vZ/qA41mkKg62MTuxyYPoiegrDMye9kmvRHaBDig5HOImIXnJnzHu8mAyAF4yk3pvYgVbwSeTUhF8VBMsUR27kFO85UDPWcICgYYJyi4AxVnAT49/zPyzmiFqciICmbVUTG7kjA+lN9eg6Gd9UtfjEqxXoixorO5Nj5MeX7dMns3oSwK2aw22qSw4BcDQrb3tnzXZEt+9XJoQPowzNFTt3jtxRYOvPlGKQ75l1hB97gQAJy2mMxWw4Req4pcTiMLuGcJUsUfXdHQlXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiGDEtgRbr9Pic25JDoKfwg9jmrpjB1NpHVql7QRI/o=;
 b=L/wcQ4awXAnJwjTseHFp7SS9NtxxGdYKzBSKlDLZizcWGDGi0Jko36gcbuFpQUUTlTgX1aptQ/DzIYUqMzdtkhLY9MeuLe8444U7I9UFKq15Txg/iH+A5RDZZQpXXk+Oy5+uny490FkGaQb/2Y3bC/FCmqCHelNBgshA1UZw/C+mfLLrskzYbVs/vbzg6Ivwzr7VlBdFMxCssv/KQvB/q8JNn14Y1v9RGpq/q4t3RDc1fnKloc877nvv4L6xm/yNf4H0kcIQPOWpvfgFXqMYMWb4ffLS4chmySIiN9KyF/TukUxsKpTZGvEytrPJDF2HnYCHsRsDyRfbfPqBDxmR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiGDEtgRbr9Pic25JDoKfwg9jmrpjB1NpHVql7QRI/o=;
 b=Y4/YX/MBhlEhTv4Nav+3uW6dzqNaRkvy8n/LlM/7sK5Anj1IcA+tFCS+/zW6Jr3qjfP+n0iqOPF0UbmyP94VkKmAiUQAnrr3JJOHe72/5lBKPmBBEr7WO8AfH7hqAaMgPAI0ny3crPqsIimJI0mDi3XfFuDJFa6E+rf5WyWFPnc=
Received: from PH8PR07CA0008.namprd07.prod.outlook.com (2603:10b6:510:2cd::16)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:15:52 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:510:2cd:cafe::15) by PH8PR07CA0008.outlook.office365.com
 (2603:10b6:510:2cd::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 15:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Wed, 14 Jan 2026 15:15:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 09:15:43 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 09:15:42 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Raymond Mao
 <raymondmaoca@gmail.com>, Shantur Rathore <i@shantur.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>
Subject: [PATCH v4 0/3] efi_vars: Implement SPI Flash storage for EFI
Date: Wed, 14 Jan 2026 16:15:32 +0100
Message-ID: <cover.1768403729.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=2RJOOK/8G7iMBttHYyMUpwfFdFTFe9H6R5CvEx1IaUE=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSmbxZdI2Du/Uj7/e1ZCZI/mzhMpM4/iuFQZltm2aK8Y
 UL97kSFjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZhI9DdGhstZlmaPjQ6XfJl0
 msF0fq9HfcJ6tWN9djn+RjIdVR+0g4AqtmeWJx+sa2yfu6kvLjw8bEMO05PLlaWbIpZ8TYrjzGA
 HAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1a3933-c2db-4026-5804-08de537fce12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bokK7WV+3gsURUIX+SKriHNben4uJqTLOHtdUE70Pn6vFsAam2Pd0prNFh/i?=
 =?us-ascii?Q?1uW2fbpGAipWpYeR2euuhXeNmUyiBRYXSEQgqqORQuT9b8BJfEDr8dLSUnUr?=
 =?us-ascii?Q?C37K01KUPySHKqZDGFVmUjJFy6/+7CecD3TLSUkEbXrvkNVIWfXcKB2VKNV2?=
 =?us-ascii?Q?06qeU8IOTo6P+dApsb4+177ixN5WhxeF0ihuf5GKSkwF2pg9AjsTi0lzXtAw?=
 =?us-ascii?Q?YEPls+3Vkq+2n/xPehrFd0aMN4WbmZ7T6wddb8At9eSVNfg+224FR6hap81s?=
 =?us-ascii?Q?6zoNRbs+VNVxjOnGr5cMOV7qLdH7HbLb86nQstPFFK+j9Ian3VPNKPHYLd11?=
 =?us-ascii?Q?HtL2Ib3cJclhOZLTYykGwvDweUB55IR90T51K3dPT0VGWCqktQGYH32HmP36?=
 =?us-ascii?Q?O5jZ4C7LZ7a6+lM1dEedF4fqqOnMft9EMyeWJUkwjTiyugt7rhoUZPI/w0ht?=
 =?us-ascii?Q?OVSagV4C6x5ypjuD3alo8Mi01vVXmlLEUSidp0FuWTNB8Iz8nsz2AgDe1yaI?=
 =?us-ascii?Q?VP7e+J9GbqWTG2gGOelEOOnnt1rw5zXFgoZNyu7hOejG3CWvfQjVEKrvwGAw?=
 =?us-ascii?Q?zTLCwViYsQVBcOeqLPEG1Kef97DLEiZ30mqKPQLubWPKGcsUMdgwXbNXwJCR?=
 =?us-ascii?Q?4qnsDCp++XPSf/nmZRdGg4LxsXvQO3rbFjHdcDFtM0V7lt9pa3xRs2bDBlUz?=
 =?us-ascii?Q?Gg5+OcQ+ormoFlML0dT4/kjgi2a6Yix7sU9vBvVXnKwZ70EVO4yJoALwi8Oe?=
 =?us-ascii?Q?OM7Dk9mq9O8SE9H66UrtmxOPR6inz7c0HgE7Ys1r03ojbiBNl00r6XxIIR1p?=
 =?us-ascii?Q?YlpXqwTAVeMPT8U/QMBIYPFJ8OxLddtFfwlc7eRb8DcxwZZ2KngvRh78pr3x?=
 =?us-ascii?Q?Z1kYDcAKZ8j3rROOmiP7d3OdHqvmKTH3O/pBfHmajzmhNzoQH1le9Yyq2AF4?=
 =?us-ascii?Q?D2PwERGclbUq8xeh7gscpvmg7OgNxjWd6oRr726jS0obzSNa2dxKfJvGLIei?=
 =?us-ascii?Q?t8mJ74k89hv35yojxZSDkubgQKdwwCowY0HoRIj2jgZbJJO0haYivfA7bHmR?=
 =?us-ascii?Q?+pQRSMaBfzhM4m4INwALb+h6aI3e9wCAQ1kzhWmQoq7sTt0McTZME4qoiXYM?=
 =?us-ascii?Q?pppXWx5rvcnzRZr+u31J2fWRF2WO556nDl34ByFkmtQ5KDkcIUw+MPJnfaH9?=
 =?us-ascii?Q?j+mIwniXMDF2WhqGrRgbqsgQnzWbXBF4w0ArAR++ZHp6jJ6j992+/pD4C2LJ?=
 =?us-ascii?Q?ua8X1g0KYxxgXZlBQnUQzWoXh6VMUqSEc3oAExawvdCRRiDViHV31/2c+QnW?=
 =?us-ascii?Q?TUbvtjXdsn0qklWa9F0I042GNFz5NVzJQr+cvwTdoQhpwhgjKfnui+M0fhnu?=
 =?us-ascii?Q?IjcZbcWmyJBL4aV85vuFRy+joNnWZKhc5nOqG4M7L2bWsCJ7g+TrpFE5GkTU?=
 =?us-ascii?Q?8IaAzbJ+wmzBV6fItaJnTp/AGDQXJlYGfPsNpjq2mg6G265Y135oTMS5bK8g?=
 =?us-ascii?Q?rV4TTnanXUtwwzzD2ersj9Gs64TTkawbu0cbP3w1lSSTD5q/nu1t9AH1YrVs?=
 =?us-ascii?Q?gJ3UODWIu1KE6W6PXhVyWgsGu+YSTVUM7s8GyHdFeu1c0DExO44vr2AHYZ8F?=
 =?us-ascii?Q?57r+tp8etYcybDlgX97nBuncTSvhSBVc3BYj9GBRUkzAukuAmvfVMTLEX+z3?=
 =?us-ascii?Q?mFoYBg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:15:51.5680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1a3933-c2db-4026-5804-08de537fce12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899
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


This is updated series based on v3 version sent here
https://lore.kernel.org/all/20231126220836.374956-1-i@shantur.com/

that's why I am continuing on v4 instead of starting from scratch.

Tested on kv260 with saving variables to location where User MTD partition
is.
CONFIG_EFI_VARIABLE_SF_STORE=y
CONFIG_EFI_RT_VOLATILE_STORE=y
CONFIG_EFI_VARIABLE_SF_OFFSET=0x22a0000

Thanks,
Michal

Changes in v4:
- New patch based on review comments from v3
- use unify methods for reading/writing variable

Changes in v3:
- Fixed compiler warnings.

Changes in v2:
- Refactored efi_var_file to move common parts out as requested
- Changed ifdefs to use CONFIG_IS_DEFINED
- Fixed typos

Michal Simek (1):
  efi_var: Unify read/write access helper function

Shantur Rathore (2):
  efi_var_file: refactor to move buffer functions
  efi_vars: Implement SPI Flash store

 include/efi_variable.h          | 18 +++----
 lib/efi_loader/Kconfig          | 26 +++++++++-
 lib/efi_loader/Makefile         |  3 +-
 lib/efi_loader/efi_var_common.c | 44 ++++++++++++++++
 lib/efi_loader/efi_var_file.c   | 65 ++---------------------
 lib/efi_loader/efi_var_sf.c     | 91 +++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_variable.c   | 16 ++++--
 7 files changed, 187 insertions(+), 76 deletions(-)
 create mode 100644 lib/efi_loader/efi_var_sf.c

-- 
2.43.0

base-commit: 4aa15db6ff8b2bbdcdb082e547967bf4a96fee52
branch: master-next-test
