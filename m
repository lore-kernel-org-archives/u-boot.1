Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686DDE7C712
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 11:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2E998409A;
	Tue,  3 Feb 2026 12:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0A/0V1+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A86D58409A; Tue,  3 Feb 2026 12:51:46 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42C568401A
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 12:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4Z4n6zgk6805aNBvm3P6er5xq/GxwfwXZ0HYCMYaCkOeJ2SjbfdtzJIWNmO7WwXuWrjVcxRZmn0dP3oQyykaDo2Yo4TR/Kzps+2huGH1H10VFHuhJAu6xExdp/PXQMVZEMiB/XAziOcrzYDB6H0Lf3Ktgyqrd8ZPacubPQxN8YtaehQKaPsZWh5jbUSMPDlHZDomr+Op35FoD9px5A6d2UrFcKlaabs05VxHsWlvs99GAsQ3+kr/SLemUQ2b8QN/9ntNKMr6P10mfIq8jrfcVZxVHv09WGQ3zh83mQIHj/cYoFTRC86jvUbvl6bZeaE+PwKt82xfSgaYu4Fbk+VUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JUhhPWgTC6qqx+qiJ0EI+sF67UQ8n1Sy3bNzP9FGMI=;
 b=y7bYpXMCMjkei+ljVuXwDwoJ7o11b3sSk/2SNdn0ccj2ekA/USDLJveDR8TIxyprujKMTHB7Gl0gK+HzZa9lpAMY40d/MNcxHzWlF6lxsysUtxz6qtf2KUhXYx+JA+lrK7a2QwNBGgT8fMxk0SWokoSD61lBh7997pGiu/DSM44ko/d+3fHDL7aycHuOGKoCxE6XEB65SevED7JgQ1E/GIzg+ivF33RjjWGBsTyWgGsOmWRjx+WDVlqV5hgzLcrT/D9tWvNIFJG/lBn+eFXSzkjgYERhYySgNIBZy6kwEartO5a9pDoVoqJV0x3BCTV9clcnK0GAVJ03CO+wsD8PYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JUhhPWgTC6qqx+qiJ0EI+sF67UQ8n1Sy3bNzP9FGMI=;
 b=0A/0V1+F4cKbhB5ODiLOLsCHOQKQlTCTAjSudLgqBj5hdUr1O5qO56KMsZbFQ3Kh0YT9nt1x/qaNb4JZF7cSWmuJSZkDCxB5ZuTn1GQuNo+Yw2W9JKbnRf5iMb2mU8ItF8JMjurO8n3Z76Djsmd64BIM2BUUwReETyziL9e40ew=
Received: from BN9PR03CA0598.namprd03.prod.outlook.com (2603:10b6:408:10d::33)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 11:51:38 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::43) by BN9PR03CA0598.outlook.office365.com
 (2603:10b6:408:10d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 11:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 11:51:38 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 05:51:37 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 03:51:37 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 Shantur Rathore <i@shantur.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, "Ying-Chun Liu
 (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v7 0/3] efi_vars: Implement SPI Flash storage for EFI
Date: Tue, 3 Feb 2026 12:51:25 +0100
Message-ID: <cover.1770119483.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2806; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=MH75QrGjHEN+XaO+BLeVpOhgw92r3RjWqrDT8uWS518=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ2PnTIm1hwbucua9HmHSnXCreucMmbWLJxg+KGZcnvZ
 MWFjopGdpSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBETh5k+Ctvprh3UtG0tXHM
 WbL+GWJJMmIJt488Mz7w4VtObWes4g+Gv6Lm4cI/mZ8qTQhsEL16a/5738XVJ/qkru8IufRv05G
 jKfwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: d8491e31-1c00-40ce-c661-08de631a971e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wjC1NAQ/HrI7oISCGFEvUi4s+ahy+nhV/BwQAul03bl5L9+f6zikFirHHFJr?=
 =?us-ascii?Q?qRo2OiorDgxPhsjERse2cLDS19/lGmdTPASFHJlc6QI2/FfuVaU8NaeI4BrL?=
 =?us-ascii?Q?mUqFiVgQ0NxycY6rKBfD85HXKNbpNwmVLJ/rrDerm36bPqHKhIoq6F+QGuYD?=
 =?us-ascii?Q?lktvNISm3Lbd0BJe/GI8yh3/3UXwZTd2IKBrkMu84b4Wd5HGFmZH1Lld7MV2?=
 =?us-ascii?Q?ru5yklYb0ZcSl+5p95QYZgt1tRL4/r8qu3wDFFTZJp1M53ncWn4H1QolELfM?=
 =?us-ascii?Q?rXOXr/zLUaEBqztcvfTu6FKw5iL6lURrMny/0rRQN6IJq2BdQTE0ewN+rl11?=
 =?us-ascii?Q?XpTn6gMNx8QfBmQRWCUs9baHQ8ZM35SJbm4iN/406FoNNp5zP5OP8+H6mcOC?=
 =?us-ascii?Q?MHlEKjglBeaOUyoH7wVzMTjOWAPqdzxowqJrmydjgRt6HwcVg0pWMJ6j14Ch?=
 =?us-ascii?Q?gQ/g02Sat+QcnVjrvFje+BiVKz+85BjcxZ50Lt2+lrJ+TF03cJjFViplw3OJ?=
 =?us-ascii?Q?qW1cCbfTlKAA3jVShzMoFR8XW+YNC5wmbajMBxbPYU41ToGJyW1RELz1WaHh?=
 =?us-ascii?Q?xFfHLMo1z/Nu2HWGJ/NQbbPRYc/ck4mtDnsXCLqy2fuW6BcnxKbTFug1bGR2?=
 =?us-ascii?Q?+SF0aCSBiD+lGmf0466wKEMCvHxE9vWnl+k14gGyPgVwVXBOR8VAmQdxzIAn?=
 =?us-ascii?Q?bf/YCH6TkZqh3XjQSvTmSlN6CexZ4qXYzaHaVkl9RBiCkSE3YOv5s/o5zEVt?=
 =?us-ascii?Q?zlVsTqsoaQoukY9UthHiyKl2VS6AsKc3EnAMMdwl9f6GwVAxCRnfZNup8Rm8?=
 =?us-ascii?Q?YZxWjjA5H88x80/AGdiK+B5czVvMb8JU5EUIHTFjU/2Uoo45rX/PYjXSFCum?=
 =?us-ascii?Q?wpgUA/IXG3EypJabCaL4/x9yDmZZGVrvvQ1ItI0+jQa+YvEo3Z08WWr0gNyR?=
 =?us-ascii?Q?F6wOgZAPoWxVMNtwEM6NyaYpmGAS+UcjJXpxa99ELU3LRRK5z3gDD1tVlemL?=
 =?us-ascii?Q?syNfvIhcRswj/2CJRUHkODvNjEZ/hiSkJKzGizlVkk7JhSKluG6mmNEC1uHf?=
 =?us-ascii?Q?MBj0YGwup3q5KOHd0klZtFNwin0GmqVVw5yKCXt3k8xPHMYcKbwYS+pOqMv4?=
 =?us-ascii?Q?kG7EAMsMNrX4cAV6Q6wYnvk5Gcb48QCh2VQjr5kyyfYZiMR5NsSnZdU+NQKy?=
 =?us-ascii?Q?6ta7mdZyuNSGB+IKVUyR1jGnw6h4fyx2nIeTSPiDVBEtRd+CKKPXk4Zw3+JC?=
 =?us-ascii?Q?kaaQG8IPck4/6K4q48fryJUftvU70HihpHXjtF0qwMzLUOfyBrzP/eLJ/bWl?=
 =?us-ascii?Q?t54Jf6GBIOfn2ADzxJW50F5lHA1RQenC/07nkYToV2NYb7Cq2aXNVmGqNDFP?=
 =?us-ascii?Q?9rwtc43I+lk62UrjuCas1BHg04Yo2zHVesN6qzmyiR7qBr7EryUY/NssN46f?=
 =?us-ascii?Q?jWN5vNUugMytEy/4HS8cEU2dV+41siIQpPiZEH1yHfJ5z2vAydjTWeTFj8+A?=
 =?us-ascii?Q?qUGXvWQjKszZ2rwrVcY0DPQ+SM6/vbsjVe+MlqkvJWUVxQvgXj55+oPOJC3x?=
 =?us-ascii?Q?OtC1PODlBBWJyS4yE0jOh2Su/0nn/HQ+fsO5PdBhrNPkK6FD884cwNY1cUsR?=
 =?us-ascii?Q?Wg/1E7xLsiWSTl6Es3c50k9xu7KDpGNP6lOUmxyKHWjStZCzHMl+9THH172u?=
 =?us-ascii?Q?ddpYFA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B/nFG9GC/B4HbZi1dSAgsw3XYakoUnROYzuQKBfKwz3XxbtnzcIHt/apN/owTIdIBXXOTyK2kt1EI7W0lNFy+otSGp4L0DDBOxdT2T8dtao5nep9dEG0oluxdGcixEft74cg1EPzVWVL933yEA5d41eQDXMQOfvSx/f6ILunRuxHiVdaNvW/NUSUt8SEOdvekDnDh5xRoIp9n676e4KT7E2GEUuztT5T6Blsm6YqqsvvLmYcVcHvtOdvv7CV+H8HTf9LcOENnU/KJoZHt3FeRWTEcwJLqQ92jSLzYyeyTZ702OEHo1bMWWD/ZX22YUILumK+HZGpSDgPMTcROAUlRanjfLdTr0pgyLBp2VzDtRFNl+THLrTfSVUpt+MsSIMI/kUnGMinm98gwoA0lbX6Lfb/OGLxVFwcMa00Xovk7L4HYY9oeKJTsnuF6LuNluct
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:51:38.8457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8491e31-1c00-40ce-c661-08de631a971e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257
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

In Linux:
root@som:~# mount | grep efivars
none on /sys/firmware/efi/efivars type efivarfs (rw,relatime)
root@som:~# printf '\x07\x00\x00\x00Hello' \
  | sudo tee /sys/firmware/efi/efivars/TestVar-12345678-1234-1234-1234-123456789abc
Helloroot@som:~#
root@som:~# dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c \
       of=/tmp/vars skip=4 bs=1
1352+0 records in
1352+0 records out
1352 bytes (1.4 kB, 1.3 KiB) copied, 0.380992 s, 3.5 kB/s
root@som:~# flashcp /tmp/vars /dev/mtd16
root@som:~# reboot

Reboot and then in U-Boot:

ZynqMP> pri -e
...
TestVar:
    12345678-1234-1234-1234-123456789abc (12345678-1234-1234-1234-123456789abc)
    NV|BS|RT, DataSize = 0x5
    00000000: 48 65 6c 6c 6f                                   Hello
...

Thanks,
Michal

Changes in v7:
- sed -i 's/efi_var_from/efi_var_from_storage/g'
- sed -i 's/efi_var_from/efi_var_from_storage/g'

Changes in v6:
- Return EFI_SUCCESS in efi_set_variable_int() when
  CONFIG_EFI_VARIABLE_NO_STORE is enabled
- sed -i 's/efi_var_read/efi_var_from/g'
- sed -i 's/efi_var_write/efi_var_to_storage/g'
- sed -i 's/efi_var_read/efi_var_from/g'
- sed -i 's/efi_var_write/efi_var_to_storage/g'

Changes in v5:
- Invert logic in efi_variable.c and avoid #if

Changes in v4:
- New patch based on review comments from v3
- Extend Kconfig description
- Extend commit message and describe efivar missing part
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
 lib/efi_loader/Kconfig          | 34 +++++++++++-
 lib/efi_loader/Makefile         |  3 +-
 lib/efi_loader/efi_var_common.c | 42 +++++++++++++++
 lib/efi_loader/efi_var_file.c   | 65 ++---------------------
 lib/efi_loader/efi_var_sf.c     | 92 +++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_variable.c   | 19 ++++---
 7 files changed, 195 insertions(+), 78 deletions(-)
 create mode 100644 lib/efi_loader/efi_var_sf.c

-- 
2.43.0

base-commit: e206e3ab2ad266935b81f5e9d3af2ed47b866826
