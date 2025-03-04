Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AF9C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 12:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 910998186D;
	Tue,  4 Mar 2025 13:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="VH3Yif5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA1B980FB9; Tue,  4 Mar 2025 06:07:23 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ACBB8006D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 06:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=har51L/VS/r/fFVtsn9XsKk9EqNPW9srWNqLE5etMHort3hmhPRRY1Z7G+aepG9PkTmG7oAD3LlAska95CGThnrPXYK7L9J/YHaMNPF3QW5CZzYXxETBdEHMRolzT+YdySHxf/wodh0OKzwwqWlvyfUbRqRezw10nSQcAdd/cpfVGAudFKXNl3jhTkiX2UUOsvvdEZUrxsfXgEYMgCxAKGZydFNZbb8/cJrkAMf/RijFolauVCkb7+P9zkXHwN+Uh9kKrl7n0eFs2EtzqgcgUR7iZteX90kQd3wFmtG/rJOzULElJS9lpvzV29e26u2o3/9uuAZcvFIOQDG8VDIkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDfjHp4GzM1SYRJmXcwjNHKsXiWWK9wAJ8Oy0/DW8lM=;
 b=Z+KtxTludTrRIOII58d24VUTYd7qRGCCfrhF1KntzHtaxSZc7G/V/G3/ibxeHIpowLjbjjuLp25eFzCQX9li0M5gJjFhH/0s3x+RDYQzzLVdvPL9FQGMkC8n55PWeTSJ3BOr9W+iTLIFbwCdhQOVn3ncX9OZ+/VG1wrb275ztbv/Mxw+SUOEtxD1tyufe/KVdsiXDmOJRc6zjVF9O4BFWtwk6A2zWyJQLK01QxOshEfVPCXUJCF2X37T9AZaIf/7z+PEvCmfh8rSSiJqoxo9fP5ZVFwy5M99mjW3r6Zxz1GcmHw4ukApb7dne5+AJVDsUoQ946coY1wr9agtmrRHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDfjHp4GzM1SYRJmXcwjNHKsXiWWK9wAJ8Oy0/DW8lM=;
 b=VH3Yif5fh9Lb0ERtiv1RRixlAenAIJ3ncmy+0wgQzj/8jKqBU1cRKNxHZQL+mb0Er7gAjCVTwb7x18svIP4kg94p4u1iKJsnkVeXghQZ7TdyR/yLicv2ePkCscMqa1H0hdfHf8Byne7MOHq181jHzxJ2qbciHF/02ASs0yjvli+wrIbiSZ1pS0CIyjR5NCfsh96t0EKfVb/RmzwbWaQXNxJK3nbMTetK3J8lkOQhZmgGb64vnrnfKGC+IaFAoFuyZN8jmF0GIvdtLwEpCoAZxwIf2mXGkX3hkuwA7xOEtTLmamqBAxleVut5kfBCXkf/l+vkV+XLJZM0tswltT3LCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by CO1PR03MB7939.namprd03.prod.outlook.com (2603:10b6:303:273::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 05:07:19 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%3]) with mapi id 15.20.8466.020; Tue, 4 Mar 2025
 05:07:19 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 2/2] configs: Enable VAB flow for Agilex5 SoCFPGA boards
Date: Mon,  3 Mar 2025 21:06:44 -0800
Message-Id: <20250304050644.15174-3-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250304050644.15174-1-nareshkumar.ravulapalli@altera.com>
References: <20250304050644.15174-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:a03:333::7) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|CO1PR03MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c685d3-d601-4614-80cc-08dd5ada7054
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QHBFtw94ZW/4QK4DrLKRMCp+slnD14l/neRD0AGNcQFjQ3e8FAzXcuaNgwrF?=
 =?us-ascii?Q?deRH7snD6Yb+7abyzJLdUjyBz/wPHZX95vJlVfUWv46GEQfjy1MMnj+Qw9W3?=
 =?us-ascii?Q?8GkZq/JVIPtDrvNX1ogmbZsmTpXoyFc2JOefZA6eJqzbMd/102TmJIMtk+sE?=
 =?us-ascii?Q?L7zoj+I7juKYZwMNFhDfToPyO+vaDsVsT20G+7Yy6osq44XmugCZpNwrfB/5?=
 =?us-ascii?Q?y4yoZ2kvHVVLzqLm8dwWmD0UpLoUTl0Sw2+zlJVs/PDYo6QRSr9IVOXCRCcX?=
 =?us-ascii?Q?m2qDxNeGupO7ir0nF/pAgt2DURGP0+PKG9BpxkyLs+7Yve1W7Oeyr6C0SmnZ?=
 =?us-ascii?Q?3Bvtv8GiTX6XWkOU8ztI+ifwIoVKYDlQh9ME7S8Ks9Jl7kYEUNCxcRguIaWv?=
 =?us-ascii?Q?vjH9BvEBT4wQGIBl6EtrXR5SdJCWiSgl69g4Rue+gOG21sPfRHuZNvK9s+5+?=
 =?us-ascii?Q?ffD+aQ7vdEF1muVyb788UHDPMjW11Lp11azHTr/Eqxo5TuqEBGG+sKb09kmA?=
 =?us-ascii?Q?8lukJFkCCLCbpUC8L95FSwhjEnu0sIISaAU3RdbVeSYr+OPWY1gi6xlD6aVe?=
 =?us-ascii?Q?2s3O2d/1K4WQzNuE+4m5lqKK6c1GvjG7HRigSwBzUmtEdEhV9HzDxXBDX1wS?=
 =?us-ascii?Q?sb3ptYijJo6hSV34C0htluwmJP+D8C/NjtMDDLruL3TsOpxzW3HMYGQ8ohMh?=
 =?us-ascii?Q?Jnk7DE9nqwGGBmOal8qW7VC/Sfc85Ec/ihuHauGRzf4ioMZe+9qaXP7AJXF4?=
 =?us-ascii?Q?78TtpTZ9XglQEKvqzMgxlMrG5ROVK7mnkSui45h2y3Nur37KHLoJEDhF+Oe1?=
 =?us-ascii?Q?w47s0japB4reQdvlRlmfOeQe44S2jzkvkYte9S1Py4avnOISZ/1OurgkVhMK?=
 =?us-ascii?Q?+BTy1M23SKouhmfth5DEo/BCqdE3PwtaF8Ldj52AFxhVcoj5QPbKjITA2Rz4?=
 =?us-ascii?Q?n30pCFYnool6jgnLYU6YLJ/iRkvBv512DCkF7piKpnAzb/YIJlXcxg/36nCh?=
 =?us-ascii?Q?tcVQRucY+S4UFHLGK+g3UNV1KFQETmxztx//5kB7Crn8qbwkVcts9pkD90jB?=
 =?us-ascii?Q?AhuoriZtP9gODxlpWR/BTbnLsGKD4inAref0MpFd9ZdnDRuBXGB3gE/LYqAZ?=
 =?us-ascii?Q?52FhX5nZhy9mVTYBHWEYNJvgKTNUTL4/kHvMKrNn1a52+8XBzMWyi62sT0TO?=
 =?us-ascii?Q?2pgKLALirn+masI92f7VPLArvSAeyGU1yP94K/GYjG2JkV56ZxNDvrzYToF0?=
 =?us-ascii?Q?RYlXj2EWPP9xMo0E8xVptLByhPzP/G8WhOh9iczJ8GGlC6nDN3vvRIhs2fSO?=
 =?us-ascii?Q?W6cIN8+TGW9iUcty81Aj7gtHsA7wE8JLAG1vNJQwZVYVXvbQg2AUjid5eIBJ?=
 =?us-ascii?Q?Ny9zPhq0zWDelKwpnnTeOiz6T08i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mSicpxWLWefpN/VPx05KvGKCZQSyMBjC8AbVYCmSgwsz5uQ3N8nq6p4wdJaM?=
 =?us-ascii?Q?qMlwLdzq+zgr+SoegO0st8APU51wATgdh0qzij3fFk3BQexu4mF5kIu8VOey?=
 =?us-ascii?Q?ftAfliuwe9upvJCKh8ngYN4rEop6lX2bU8dk4qA1XZYycALaymQ58X8kJ/Mp?=
 =?us-ascii?Q?hC27bliD2+P4OKCN10ytQS8hnxjWYfYgdxGNqSSCOIInIrCIBvGPDD9gqD6B?=
 =?us-ascii?Q?HcZYkY6NiWBvticXvu+ERmxA/UlfHE8tjljSUGvyfAPvDmUVyI7rMrNwBNXA?=
 =?us-ascii?Q?Bt4Nejk/9FP1RHlyfjfi5t1XGX0uHO4tCVpdkeAahrSxCTvdAKXZ1zMaI5zm?=
 =?us-ascii?Q?/b07XqIzdwYCpWi8k+UXA/8fZ3zJ81jxrcQdz03/EN4GOfrH/YbCejzoaLGK?=
 =?us-ascii?Q?U++TzfZjXCKlCtgnSM+n8xyCnfAg2QSTKL/Feauabv2C+vS9NGtPoF2n9Jo4?=
 =?us-ascii?Q?pEJqm8qRXKJccAs9+J2b7UyI2YxAjlNCsuRYaq6sE0NTwj7vWOQxE4APqrKM?=
 =?us-ascii?Q?AKrhlnCUHfJxiUw7ZUq3OK7mLHkSB1vvkoccGUVaH2A5i8IhUTdvBYmUoYmv?=
 =?us-ascii?Q?49IlQDArGd5cPWAcNCwbxEmQKNwPUKvdt6Ila4n0WYGFEFiOI/a4c9ooWsnZ?=
 =?us-ascii?Q?PGfYIKjoCONZMc7h2pYTzj2WfJLvhBfTpyozhjM+yTUvZE4krqwVmB6hIYim?=
 =?us-ascii?Q?AEvjHNHGvEQhUiUU5o9IvGmp1khcpJEyfZB75lWqBVvLEheG3gJU6BNLHMdm?=
 =?us-ascii?Q?GBKbjQpPdyprsYFJD/6b927Ed8XKCoBdEeqKkvqdCfCl3EWzq+FdO+p4g6CW?=
 =?us-ascii?Q?3FkEE9ti+0jYFrQniXvoPX61DKEokm0ibQI0jHdCD2+EOSG2JfBSg56OEOl0?=
 =?us-ascii?Q?rfdRDgfnf++l2KBmRHJtnP/4aqD/McScbPiXe7L3ljCfBB/Udw9OzEiKWlXA?=
 =?us-ascii?Q?0ISfErMxrkgiaYaHpujTn6/rZ6eL0ro+TtODRs8pXjXLVQYdG7xJg3UaASnR?=
 =?us-ascii?Q?oGdxuV0lVVTV/kf82LNkEVQfoEtXlD6husePcdjZIAuIykHrWCePiGx/oPzf?=
 =?us-ascii?Q?EzLhH7BxMNPYTWay7zC8HNoqoMihIcbOjT/s7kS+Dr36wdzZLeJCvphOD/c5?=
 =?us-ascii?Q?Ch/bTJEzXDhkM9dVmuTLEK1qB8P3dSTcW3nVsdUnHp0VIB/DzBSw31L+Y4YW?=
 =?us-ascii?Q?QE19ITAqEwn6GnE3ba1pDyU47mhIPXjhIpGdqGfLHIiIiuDEDhN4Sb4EJAWG?=
 =?us-ascii?Q?sqoNqzrZPlZ4mg6oRpNgedw6F7IqycVZ8dRwTwaaJUhSd5FnKCZgMYh0PTL8?=
 =?us-ascii?Q?rvrYg7mVAevgj9FSJn4FzruD56LcvorkfOdi0A6a8dgpnjLz9NTycdZkPhUl?=
 =?us-ascii?Q?4BMLR3jX2wRaBSn2tGmwsjrj7RFKGhI0MbLVkg/cxxQjQiFtwlhCjfGBkglT?=
 =?us-ascii?Q?hYgK6lJXvS7WXRQEQOqxMEFGNoeP7+mE8VP4dq8Ozr0tcvX0I8l1bEEiW2Wv?=
 =?us-ascii?Q?cB1fW023+GPF75aHsBuYV8628B+rpzofwik4bu0IQDR+mqqXUkKtrcmkqHyn?=
 =?us-ascii?Q?1WpfGivFQK7EJ7lykI9GLTkJgCdlmDjn91EOB6hjlS3bOubLFY11Ooxpjbh/?=
 =?us-ascii?Q?XzB/Zsk6eLUcdtL8CJxy5NU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c685d3-d601-4614-80cc-08dd5ada7054
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 05:07:19.1381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSgUUSIQw4eTW5IdybV4n5yl4ut5iERutYGYvE6WOvggk+s3rKgXgVLOfSxFomk9rl8xZkizNs5uLcWCCCUVypQvoSkcThJejl6qRJENBZQ9ULIlAg4yFCDFU8vNs/YV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7939
X-Mailman-Approved-At: Tue, 04 Mar 2025 13:58:09 +0100
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

Vendor Authorized Boot flow configurations are enabled for boards
based on Agilex5 SoCFPGA. Also, required changes are made to the
SoCFPGA make file for building and linking relevant secure source
code files.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/mach-socfpga/Makefile        |   2 +
 configs/socfpga_agilex5_vab_defconfig | 102 ++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 configs/socfpga_agilex5_vab_defconfig

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 22d48dfae1..c43fdee4a4 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -68,6 +68,8 @@ obj-y	+= altera-sysmgr.o
 obj-y	+= ccu_ncore3.o
 obj-y	+= system_manager_soc64.o
 obj-y	+= timer_s10.o
+obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= secure_vab.o
+obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= vab.o
 endif
 
 ifdef CONFIG_TARGET_SOCFPGA_N5X
diff --git a/configs/socfpga_agilex5_vab_defconfig b/configs/socfpga_agilex5_vab_defconfig
new file mode 100644
index 0000000000..a66add2b84
--- /dev/null
+++ b/configs/socfpga_agilex5_vab_defconfig
@@ -0,0 +1,102 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SOCFPGA=y
+CONFIG_TEXT_BASE=0x80200000
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80300000
+CONFIG_SF_DEFAULT_MODE=0x2003
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk"
+CONFIG_DM_RESET=y
+CONFIG_SPL_STACK=0x7d000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0xbff00000
+CONFIG_SPL_BSS_MAX_SIZE=0x100000
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK=y
+CONFIG_IDENT_STRING="socfpga_agilex5"
+CONFIG_SPL_FS_FAT=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x82000000
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_QSPI_BOOT=y
+CONFIG_BOOTDELAY=5
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200 initrd=0x90000000 root=/dev/ram0 rw init=/sbin/init ramdisk_size=10000000 earlycon panic=-1 nosmp kvm-arm.mode=nvhe"
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xbfa00000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_CACHE=y
+CONFIG_SPL_SPI_FLASH_MTD=y
+CONFIG_SPL_MTD=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x04000000
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SYS_PROMPT="SOCFPGA_AGILEX5 # "
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_NVEDIT_SELECT=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_WDT=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_UBI=y
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+CONFIG_OF_LIST=""
+CONFIG_ENV_IS_IN_UBI=y
+CONFIG_ENV_UBI_PART="root"
+CONFIG_ENV_UBI_VOLUME="env"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_USE_BOOTFILE=y
+CONFIG_BOOTFILE="kernel.itb"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_ALTERA_SDRAM=y
+CONFIG_DWAPB_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_DW=y
+CONFIG_MISC=y
+CONFIG_DM_MTD=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_RGMII=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_DESIGNWARE_SPI=y
+CONFIG_TIMER=y
+CONFIG_DESIGNWARE_APB_TIMER=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_DWC2=y
+CONFIG_DESIGNWARE_WATCHDOG=y
+CONFIG_WDT=y
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_PANIC_HANG=y
+CONFIG_SPL_CRC32=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_SIZE=0x1000
+CONFIG_BLOBLIST_ADDR=0x7e000
+CONFIG_HANDOFF=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_DWC_ETH_XGMAC=y
+CONFIG_FIT_IMAGE_POST_PROCESS=y
+CONFIG_SOCFPGA_SECURE_VAB_AUTH=y
-- 
2.35.3

