Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD1DC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3432984A3E;
	Wed,  8 Jul 2026 14:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lykkSBII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D567849BA; Wed,  8 Jul 2026 03:13:17 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4444D838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xki1K97O/zo4KDrEKifVX5ITxdBKrozs3QIuV8WAscX3oSffwbq6t4TgJ2E7ov8WzxejeBOnwMPMLI6Sta/wlIzqsHTPW7/nn8+foCXO5Uh1B945EkReKbLmBxyDCw86C0FqvleOqp0YwzruyqS8Lb3SUtRM5x3+k+D5ZzIlY9QlhX8tZjseB0eT21VnVtFS2aR/ZCtEvgyoLsWWQkdn7htbuRJRdllfgp6XMaTZU46BhNda3q3FSujen7PHIppcd58eYPpwpNnz8et6yFN0ppl6KT7uBE7NgwyaHGzkRz7rSpzvbgtmKVHe429mpAupLN3aQagT1irePmgC1n4wLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUJH08BkN973WZuXMw53MZ5qRoj6NIyWCwqGd8re9LI=;
 b=DlxUZcJ3yvO+Uzv/dlv9A2X1Jf8vmkIEEe/4y8/ridApGS8oITs/uAzzFxjBGJbLF1nEZ3eDXwa6KOlGBKXa7qier4jK2TEoAxLOJDIgskNCI9LjLxHHaqM2QOq/zhNGG0pabMtGxvTUSCJ8YyTtIi31xALc9ReN7PHrxi1FlFTfiW0Wx+M/qoAExV71TogQTx7h/D7A364A3Lq5cQ61RvtiHBPKmg1/ZDWaP9EBnuP0q1Ppr/Sqzoi4Jz2MLIFGwW2+lwNeyxC9Q+pVmADKUuwzHk7DfWKlsbMe3Myu3NkNLN5J3FGPkPWHx/bqdZilLOw7QnhnT87zhG1U3nT1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUJH08BkN973WZuXMw53MZ5qRoj6NIyWCwqGd8re9LI=;
 b=lykkSBIIGtK9J6Qm9ErXHXnHFK+pjN4vyyu8zMQFgvY8dLgxATKbqjZMv1EnW+fe7xYs3M7IH0Y8+q/iV8rQ8DFnS7XsebG2BpMqCDz1bLTl6b2Kf03DfjOGkfB9uySsSegO8+6CIPoX+CKLlXcOZdgag0ebgfkrOecLo9YXHBVSmSaBJD12UW78NZSBKHP2ly4tQ5cSCu6jU9Ysd+e9aLSuQyJdiQY+Wpycp8VOLsyswY1fqthD/7YeaJDZLlK+ju4L3/QcUlxI56be/4r4iDbbxFzML0Jzb8+ov8uzFTegvXMs8TVH13xBkj/9MXsOO9V/aOm6M+D0QTGsQVNDdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:13:11 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:13:11 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 05/15] configs: socfpga: n5x: enable required configs for DDR
 retention
Date: Wed,  8 Jul 2026 09:12:18 +0800
Message-ID: <20260708011228.15613-6-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260708011228.15613-1-chen.huei.lok@altera.com>
References: <20260708011228.15613-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW4PR03MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af41429-eabc-4746-e468-08dedc8e13c5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: zTxabVKcNYUkJsN7dxTn1TyF7MPw3x7GS0bvBhTWGuBX1SF8QgyznDDov9/Q3gkeEm+YSiP4uAYwu5xRh6i97EhKDjYhfWPLwFI7xem4mPNCIhTFa/vw6YCpBcC+GURcry4MdKtIYYG6OC47rXv66PMqSQIoyY3FctVIivzXzJN64Kzp75bvhZWiiIIn5Eana33cJSUlxkRTRg3EOjHa31QorxRhKswT/z2E4zL/fdVSX3yKXPK/8D3K2QCGt+ZXfeMRdx66TlcEM86bqOden3YOKkjtzU3xPhh+FsSp+FCAsGqkPsO/jw0bVwb+Ee7VQMce75FsND9/yxEhWLPUooI+nft/qIDEuHEWnk/VB6/9o9YUKQNJO3V+TrlPx4LDFXf/i9eflrNQtJ2Y8uUbIe9i7I3KmWOUXtZjDJZ0SkTuGY2EnBLnQjIeNqrSFmE2f0zNpNPTSeREt8ZuIuXTHccCD6j31RhDDoWVkTPmOrEXzRmji2ZBSCuSkMY7Ig63DHE36+YF9xrA/2VNmG2b9dXAAC6+RL6lrI7RZyz+l+MngM/nKkX7RRVdNpEiS9ScKGWaGDz9Ar0ZMtkwkQQJ7163yUaEpziFh1PtLUYcx4XVZMt63NLwKZCiwhT+XxLOVyj/YQ6Uj0hzRYcs4hSPX4LyLtOTBaJmJLDqWenTJ0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ddt7NOXpSKJmrTCpCQqodchdq5Qo5M8fNqdNfPMQCQ/+8vxHRRK5uXLv6/wv?=
 =?us-ascii?Q?B3BVhQ25x3LXkX/M3KGjnXqX55hYrGzE8wrrQmSWyT/ovetNfKhK2kWEFqZx?=
 =?us-ascii?Q?2pf4bukIcm7AgIevORMzy1AdVCHZmJfd96Pv10fqqkC1Hv1So2L1OK/g6fNZ?=
 =?us-ascii?Q?OQpwh+5BQYpszpkxaeSZZXAFO7vMqsD/XnNIx9pyTkKRXHigoICHsY6ViREu?=
 =?us-ascii?Q?UAJYQePa5iuFNO/7MFE1xU3n8mYHVg4NRWYmZ0WnVHpGpoJUm3GRuJMBK1/8?=
 =?us-ascii?Q?+ZHgMraS7RD5PVedr0OH4EIUlcV3fZ+qaPcHuSGpU63yzRXmUf/7B9KDHIrv?=
 =?us-ascii?Q?mHzNYV8nskWRDwhl/EnNR5+yvmg4V00HUsqKvh3+z2ARYSN+Z5mlW6iQsJ3f?=
 =?us-ascii?Q?vcj7hcXRV6OjDVs2Hn2dpw8f28HVNL/jjWuDlMuY1mzES/wyhG4aeO5FLWsE?=
 =?us-ascii?Q?vYg4cp0BW5IFa5eTC98lMKdvB3tv5ZGQyQGGYd2tY58jeT9LFj7/4HqwbBwJ?=
 =?us-ascii?Q?Ynn/K8o1FWxobLoYJn8nH8K/n2FuSwN/dUVFsCa/It8hm6Dw68dRELrP9kLQ?=
 =?us-ascii?Q?nRs1Q1uVC8pvkfvayOOooQOC2A3ekWqOY16fFG2RfqTXvDBlTlfrJO4X0C2A?=
 =?us-ascii?Q?jKbEuN9U8pPlb3/n7j5Qqwrm1fxpPmbnUPf2r25TI+PQDsqJdksWK2pD4XiZ?=
 =?us-ascii?Q?SeoFamrjoGjY9lDOa50HiIQkIUWQ4kDrr1JmVnE8/Be4UKlrl4uITKESPx1x?=
 =?us-ascii?Q?grwherhntYJpLPYU9cWngsKmTkdGjvzY/4Ly9wRlmTg/fJS4GFK3lD3PXt27?=
 =?us-ascii?Q?uLA0sKZr/HqM58UHMz0NFqLQo+XJy2rm2VGuIWUBqiNu4znL2bPJ8yfLlt8J?=
 =?us-ascii?Q?/W5g08+iCzx7Ttes68362P/LKXCWiVJcgqdTPbJo6BpgA1aBLX83uvupgUV8?=
 =?us-ascii?Q?LHuIqDt/9smh/udBfZvtIdLDWk+3GLQDOGv9n+b1VmXsBNl6rviKue75xYQv?=
 =?us-ascii?Q?eBpVEPtjutlYhsTe6t6lOQk212xybvYttJu+eH1W1UnUy/UXxu2RxbIPt2D1?=
 =?us-ascii?Q?9qHBR6uAOaEk2IiDsYNNOqpDfNJq8G1KKrgnc75SWq1uL+WPDmoPDuWEFHFK?=
 =?us-ascii?Q?0QHv7etDtE/Ge/eo4AxwacTuVaTHzsIkLXueRb81OAWpAZc1tlAlU5fxNRVR?=
 =?us-ascii?Q?NGgUlcM3Pqj46WHOaJR30Ti/qOlsP7hpxrTSeoQRqdDDlTHnvivkw7qcaLsi?=
 =?us-ascii?Q?VdyRUC20ucgKqiA7qI9i2vsruMnCgowxPL460SKkpJDxgaT6K2dwHcoF2Hsh?=
 =?us-ascii?Q?ggl3ZVHU9Umh/tFpcZ16e3IW1nnCzH25p6bn+l4ERLhgtQGRKTcQKwHuSqEy?=
 =?us-ascii?Q?dN6SnG8vh9qaoOwp6g75ZI0w3lIGK7loFstE3wODDO2Ff7kFs77ypcNOpOcp?=
 =?us-ascii?Q?N5xClh0n8zTzF06gRWlznlSMjs+ff+/PpKyP/8OKU8WfauTqtDw2pO4qaH7Y?=
 =?us-ascii?Q?T6Nq9h2+Us9F7eOpJ8Egf3RsqqH53xJtZCas6g8WUpj901I5Q35kvbY9SIX8?=
 =?us-ascii?Q?4O+tdia7bwxAOSSs0VMnTP11n2RN8sRgvG9qDCQqFNEUAqU20QnwXvg7IzOy?=
 =?us-ascii?Q?fhwASiMAsbrpzKFsVei5mYOC0NjAh+1ujPdNQBxB+r4+SEDUham8iMoDwCFS?=
 =?us-ascii?Q?E1V2AGgQqgpMfbvXctX3inGWVyN9LQCTKreVlPtXGTsbnpuTHtbspDRwYw8L?=
 =?us-ascii?Q?GfJDZ4LsutP9UZb095Lu1qB182BFWSk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af41429-eabc-4746-e468-08dedc8e13c5
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:11.2905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWEWLhhQsoAdTW56QiQSWo7th6AAv2MktGbNX2oOaj4pyHavXUHFOjtl+KxPfnn+qh8byaCS7YaKuRtKlJx/GlhAVwPDijE9z2QxDxvE3bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6473
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

DDR retention lets N5X skip a full DDR re-calibration across a warm reset
by reusing previously calibrated PHY data, which significantly shortens
warm reboot time. To do this the SPL must, early in boot and before DRAM
is usable, locate a known-good backup of the calibration data, verify it,
and replay it into the DDR PHY before handoff. Enable the configs that
this restore path depends on:

- CONFIG_FS_LOADER / CONFIG_SPL_FS_LOADER: the generic firmware loader is
  used by the DDR driver (request_firmware_into_buf()) to pull the backup
  calibration header and data from the QSPI/NAND RAW partition into the
  OCRAM scratch buffer (SOC64_OCRAM_PHY_BACKUP_BASE). The loader device is
  resolved through the "firmware-loader" phandle on the DDR node, falling
  back to /chosen. SPL_FS_LOADER is required because the restore runs in
  SPL, before DRAM is available.

- CONFIG_SHA384: the calibration backup is bound to the current DDR
  configuration with a SHA-384 digest (sha384_csum_wd() over the DDR
  handoff image and the mem-clk table). On store the digest is written
  into the backup header; on restore it is recomputed and compared
  (is_ddrconfig_hash_match()), so a backup that no longer matches the
  running DDR / mem-clk configuration is rejected. Enabling SHA384 selects
  the SHA-512 implementation it is built on, so CONFIG_SHA512_ALGO does
  not need to be listed explicitly.

- CONFIG_SPL_ENV_SUPPORT: the firmware loader reads its storage selection
  from the environment (storage_interface, fw_dev_part, ...), so the
  environment must be accessible in SPL for the loader to bind the backing
  flash device.

Init order and failure modes: the restore is best-effort and fully
guarded. The buffer load is bounds-checked against the HPS handoff region
(SOC64_HANDOFF_BASE) to prevent overflow, the header magic must match, a
CRC32 over the data must match, and finally the SHA-384 config hash must
match. If any check fails (missing loader, read error, bad magic, CRC or
hash mismatch) the backup is discarded and DDR falls back to a normal
full calibration, so an invalid or stale backup never corrupts bring-up.

These symbols are enabled only after the fs_loader RAW-partition support
and the N5X self-refresh / retention restore code that consume them, so
the series stays bisectable. The defconfig is kept in canonical
savedefconfig order; CONFIG_SPL_CRC32 is now selected implicitly by the
options enabled here and is therefore dropped from the explicit list.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 configs/socfpga_n5x_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index 8f4723398df..4683726208e 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -42,6 +42,7 @@ CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
 CONFIG_SPL_ATF=y
@@ -71,6 +72,8 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
+CONFIG_FS_LOADER=y
+CONFIG_SPL_FS_LOADER=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
 CONFIG_SPI_FLASH_ISSI=y
@@ -91,5 +94,5 @@ CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
-CONFIG_SPL_CRC32=y
+CONFIG_SHA384=y
 # CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.43.7

