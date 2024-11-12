Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFA4D32D81
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 18:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02F7589465;
	Tue, 12 Nov 2024 19:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytec.com header.i=@phytec.com header.b="FddXxHL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BF7D8911E; Tue, 12 Nov 2024 19:40:53 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::723])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 807828897F
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 19:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ggiordano@phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XevE2tpFXCjfELVukJrK2/HUW1UsriI0i49tGPMznTtXu2B9l6D/VNnMFiPGuGmbmMM06/35eqNWcuKELwJh/zxzC3WA7dtEOKqKSmdLJcNBVS5kSRPnnqVFDen2ucltLSbff2BWYtl09X1pCpqquaL2fulhGmdaDnMW21SGrS1jfIAHDL/3pz9l1k4e/8nUQGqjnGiNRt3QdeQFaIjzJrobvWKaDmEuthObn0JuwAQDuEkfLnT8asI29xMdwib2A0bK9KWXSYTSfKUMpAw/05nXPFDb+9zfFVrHueHwqdr8q7jvyEgxvXVcjsY+/KHYsOIoZPZFMIKI11tbgTK+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTx7z7+JxzP68rZTMieTPVqVowPBQzLPgLuPHsdYfQQ=;
 b=jN3ZqMLUnTxYM8h0+HOijyvtmekWlp+DuCvXMqsMiQsxc+9aE0FJgRXgbluNOqakDH0/I8dZ7i5sG4YproY0XIg3DzUbr+DG7w1k0kj86Jgyy+SJ9L+KQnadfSFpE/tc65T3yGjrBm6MpneL7vksXdXdghQHSYB6z9kFYM3pu/2WVyxyv9n/STyGRZsSCl/HTF6G3EocWKpal4Ej9oXYLiR15tXkwJQ4mV/pWanSjyl/h1vM/QMeIuGkHhykETegDgRHKQKWhy3tl5w4Ybf1Gdsk937Dq7Sp2dCZWuU21T2JvdX1pc7CeBcE5XMN8YuON+V654GNBgKKt1CaOY131Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTx7z7+JxzP68rZTMieTPVqVowPBQzLPgLuPHsdYfQQ=;
 b=FddXxHL0WyVgjXkkNZdb/E8d0kRoCRqdj18aGv6VP4ufyJbVSZlzZTw4Ya7A5fIpAztOUekqVIyO5xURGbobqRztc6KLbr94RQM8+n/q5A9Lf6AFoTLAubFR3qyZ0ZnnMtrq9Zm41lvM5wHELSkhRGKXxGS7wZXCqtz0BmI06k0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by SA1PR22MB5178.namprd22.prod.outlook.com (2603:10b6:806:3c7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 12 Nov
 2024 18:40:45 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 18:40:44 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: trini@konsulko.com, afd@ti.com, d-gole@ti.com, marcel.ziswiler@toradex.com,
 sumit.garg@linaro.org, nm@ti.com, d.schultz@phytec.de, w.egorov@phytec.de
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [RFC U-Boot Upstream] board: phytec: common: Introduce
 CONFIG_PHYTEC_K3_DDR_PATCH
Date: Tue, 12 Nov 2024 10:40:29 -0800
Message-Id: <20241112184029.1030756-1-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0461.namprd03.prod.outlook.com
 (2603:10b6:408:139::16) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|SA1PR22MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: b9be2e10-bee5-48b9-e936-08dd03498462
X-LD-Processed: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+/CqhKJGFVfiJ7DXCCcEHXV7QAilqHLYiJZtHrSRjQJkxcFCvVi3gpBE0ddf?=
 =?us-ascii?Q?gMAgyX77/V9vxCDUBXFL5D3UskyR+1d1LRAoSZIbJRMsko/N/S8BlApQw8Sb?=
 =?us-ascii?Q?QogLeQXyWy/pp1Ew0klwexajARC/irZjdEESjH/jt8dOOc/wKZdg/okfALX5?=
 =?us-ascii?Q?+8NkAhkFbdG+WtmPXF06Cs6t9lIj8Aj4mvNv/arMl3DUwDqHyXIPxUAWfkyQ?=
 =?us-ascii?Q?w1oIBCQ32aoQBfsntjnzaxkXCTZHHvsyl1ipSEmSfGDG/yFZOPM4zg9tMHIx?=
 =?us-ascii?Q?G2BjpAKq3frGIeKz8SYwOb9vqcMO9oKtFBa1CTRDbJvi5FE2o8UpQENtNajr?=
 =?us-ascii?Q?9Ax2SSNSys0kId4sAVaSi12aebPtERUcMVnKHEBFgzBvffe/RofXjPS5esKC?=
 =?us-ascii?Q?poGNV86u12WVcxv1NDD327KkYpfj68d/kxHjkjyFJd1JytNfqu4R8NJF8rkq?=
 =?us-ascii?Q?Hqw/myJHCMQpMG5K8FhtCWBs/48DUf2GHbfc+0gzR3kjKgojqdy5MA/ogL+a?=
 =?us-ascii?Q?VGjzdNW27mNTIKfUaRQP5nLi1U0b0uHnxD2UoFJJ/gyyqDFEAc0guN4jGSgf?=
 =?us-ascii?Q?KIK7Y2/bkodteb6chUo4n584BaUb6oKsyYgFCXsDD3KTWMwdz6m4okzsE5yb?=
 =?us-ascii?Q?XUTTZvopd2XIr+y+HGPXYsWt7jNjPfC9Wxw4qCt0zjtclodshsNMKCuL4oeZ?=
 =?us-ascii?Q?ZTQAiuWWBCLKGwACx0G2aQSHB7AS+w1CpyRSzRxn+GmWngP8EFFwo0qHV5il?=
 =?us-ascii?Q?Q5//JwknocZvPo85Tt/eLvkL8za/jFJvClIrdIpX6lNxuNST5eL0F7HMSJxN?=
 =?us-ascii?Q?N19Y4mu9wS/pcrFZfXv32PJikV7qc2rBYBqFOYAYMVSUaxLgtmStumiCzOyn?=
 =?us-ascii?Q?S50vUW12pQuAfGwoytmasfPbkJFJk1byXuJ/LG8YYsvLbWScatDzrliKR0L1?=
 =?us-ascii?Q?u/NV0bUxP5eHy96SnYVfPMLi7O1uFLcEhKO28UUmPSzU/FnCcFhoxyphzpV1?=
 =?us-ascii?Q?czczEGmk8spClvkUnmayqZI+xm7wvwSMFsOmLQ3aq2qpKO1k81247iUmuS9C?=
 =?us-ascii?Q?RnmzyLyE5DKWHOMZLUE5ylxEk/a7ewb2Eyg4mhfLtGZjnKBwmOM0xqo8WK/6?=
 =?us-ascii?Q?xFHjFbofr3JW3+0KUJ/pDTpYuX01iGImEWEA8FKBpntChMsneDorO7w2MUyr?=
 =?us-ascii?Q?lONZpQgUL5gIMhYvgeQXoe/Muy8nFqB+iFNpegH+grL9NCBL08y3RmSs39Fe?=
 =?us-ascii?Q?INRNkKnOpCvP2VPnB0rkNof20IthKNsvsUJ0Vq+Rp0HwcuRQAqg57C3itbAQ?=
 =?us-ascii?Q?DRV9rZCJkWoqJiFavuWks2B0m2ld1jyyuGVXXL3a/B4YpOmReP0Lx2kZZlS4?=
 =?us-ascii?Q?HwXW0y8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR22MB4354.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vGWEhXl+KqrZXtLJs3oljCnjWINSjkHSjiWJrCNRscsvs+vD9rF27sSdrPKd?=
 =?us-ascii?Q?gqwmKITegzkToVHVMf4Vt5w+jotLEAKJjtq9EPp1/4/xfJtKTVCq0pUoXKvO?=
 =?us-ascii?Q?5alg+44MjHkrvhqKu/8H7vRFfsnFRr9StX2RL0zp25i2TwLY8tBNL4sGr0vP?=
 =?us-ascii?Q?LzZRm49QN0aSKI8KBMXO+cSm/gO9gEkheHFxjBWwcjaLPenqSk5cXkttuyR8?=
 =?us-ascii?Q?vwayxSNOsU8uL8GgH6ErAb0AkclTE1pWn2ap5FfwcdP4kZAFhena5WV+jxkd?=
 =?us-ascii?Q?0yyqD9NPB6bdkpBkJbFl/v5lkanTpsh4MgZ9KmtXP7ylZLB/HJPcjZBsD0/C?=
 =?us-ascii?Q?jIfniEBOUziWVrxDyDZYkKoi80814Ewzl35OW9vMBlxnYTNcRzd4+66a2VKb?=
 =?us-ascii?Q?56H+Fu6pX4ABRrgCfdl79CfoM25tjHyadsxFfibyEno0Lr2Clas/4Bj9siLe?=
 =?us-ascii?Q?AjNavzaN5td8CXFkDcX6+ZZFSNdkBWp/Q/6dqyb7F6xwKXVdBDT8YaTmn3e1?=
 =?us-ascii?Q?6YE9eQXTPbVRBW9waZrO2HPt36mtMpQrmGeLI8xjHOXlhIUEdaQL1mLzO7Hd?=
 =?us-ascii?Q?KFIo2+9EQvzFONrL8KXk7b89kYXrZxcKlzn1lUPs9RP9r8N1mAv6tS5mtX9C?=
 =?us-ascii?Q?5JKGU539xUf9V6tTbdfAJNM1p59naKWjluHfMnRxNCEbs6qGHpoIbEjsPbw3?=
 =?us-ascii?Q?fuO5C0XoTM2Q2Ni+G1h9t571pfueEPo4Hhw4WB5hDxGJ1v7Qi0X5sJxsiFlZ?=
 =?us-ascii?Q?abn6soVDUXhbZiFwB3SsrwjArMdk/Hh69Ooz4st4JBOUEMWyt0QrWX9Ji9BJ?=
 =?us-ascii?Q?atd9lltcC93TvhWAuSxUgdPW3tHBsxcZUb6NfqwzI4YG1ztiXdwskeO224eU?=
 =?us-ascii?Q?A0Atfrl+2poqOmS6DqdwpN8DAgMQYSv34kBa20Aj0cNwJ6GGf5UUhZJs8HEW?=
 =?us-ascii?Q?gGqyqvwKLNArBhuI9sGO+j2XRiuvUuAZW0fbAGBESK+2tsKj6bZSyOay84L3?=
 =?us-ascii?Q?+Ye9Zx5qzsNVI/M5QYEJTLecI1S6SIbZeeQC+GZy1OEbn42jZHH2by2fMgjp?=
 =?us-ascii?Q?ZafH8yTjitMXNbUW6j2aM2NK5F9JPCfzSb4jJu2bG8cqsD9BBubiQciZ8GZa?=
 =?us-ascii?Q?IiYMOxENcWzSn27pSxKIGnrJo2esa/vuTUOQK4593Z+wQPY5+nT8DgcrQKyb?=
 =?us-ascii?Q?gyf7stgEPvIm/VBdPp+vnypLKPkTlwP8+lPndS+BeOpCBHM2rzDZHz+AeQtA?=
 =?us-ascii?Q?FVusW/cq9ttlb4hC9x7PZrYDB3Xb2tSTLtnL1M+jgKK+PVSzrZ8FNChS6JUA?=
 =?us-ascii?Q?f35IL0CSWZ0E3PJxAXRs6AvzUUjGw+cFOxsf/wOWxwRpTacDZsoVVzaHWMg2?=
 =?us-ascii?Q?8f7hG+Zo94WntEL47JXPqlxTCP1Seh4wb1+P1tV5FPrUnYZNldGEPmOW7enP?=
 =?us-ascii?Q?5EBI3FdSouXe/WMLKZuBFdKQ2SVyJ8Fl39s+fy+5PtodA7d3A/F/3pnkkfi4?=
 =?us-ascii?Q?Q5QBcEYQoXI9quvbBo8MaOWubOrznhczz0XZSZkHepWs4AHKGX1+p9V64cpi?=
 =?us-ascii?Q?PVVkG5PhiN/rHgrf9fYpuDvO0wgHt+JQgJ1oTnCi?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9be2e10-bee5-48b9-e936-08dd03498462
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 18:40:44.6961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAmU5kZS0WT+wK5jxLoPnmTI85Lef5pHatSwj75XrdV2FhMCbzNXdU3R0JXi6/wPtUqIqRKMLXvq+Pbv955AwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB5178
X-Mailman-Approved-At: Tue, 12 Nov 2024 19:41:23 +0100
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

Introduce CONFIG_PHYTEC_K3_DDR_PATCH to make DDR timing patch code
optional for PHYTEC K3 boards. This allows better control over which
boards receive DDR timing patches, rather than compiling the code for
all boards with K3_DDRSS enabled.

Also enable the feature by default for PHYCORE_AM62X_R5.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 arch/arm/mach-k3/am62x/Kconfig     | 1 +
 board/phytec/common/k3/Kconfig     | 5 +++++
 board/phytec/common/k3/Makefile    | 2 +-
 board/phytec/phycore_am62x/Kconfig | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 board/phytec/common/k3/Kconfig

diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
index 8b0cdd74f4f..81199ada3a1 100644
--- a/arch/arm/mach-k3/am62x/Kconfig
+++ b/arch/arm/mach-k3/am62x/Kconfig
@@ -42,6 +42,7 @@ config TARGET_PHYCORE_AM62X_R5
 	select SPL_RAM
 	select K3_DDRSS
 	select BINMAN
+	select PHYTEC_K3_DDR_PATCH
 	imply SYS_K3_SPL_ATF
 
 config TARGET_VERDIN_AM62_A53
diff --git a/board/phytec/common/k3/Kconfig b/board/phytec/common/k3/Kconfig
new file mode 100644
index 00000000000..282f4b79742
--- /dev/null
+++ b/board/phytec/common/k3/Kconfig
@@ -0,0 +1,5 @@
+config PHYTEC_K3_DDR_PATCH
+	bool "Patch DDR timings on PHYTEC K3 SoMs"
+	help
+	   Allow to override default DDR timings prior to
+	   DDRSS driver probing.
diff --git a/board/phytec/common/k3/Makefile b/board/phytec/common/k3/Makefile
index 40e91a43e99..6861c70e17e 100644
--- a/board/phytec/common/k3/Makefile
+++ b/board/phytec/common/k3/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0+
 obj-y += board.o
-obj-$(CONFIG_K3_DDRSS) += k3_ddrss_patch.o
+obj-$(CONFIG_PHYTEC_K3_DDR_PATCH) += k3_ddrss_patch.o
diff --git a/board/phytec/phycore_am62x/Kconfig b/board/phytec/phycore_am62x/Kconfig
index 7c179ef0078..ecee5873c0c 100644
--- a/board/phytec/phycore_am62x/Kconfig
+++ b/board/phytec/phycore_am62x/Kconfig
@@ -33,6 +33,7 @@ config SPL_LDSCRIPT
 	default "arch/arm/mach-omap2/u-boot-spl.lds"
 
 source "board/phytec/common/Kconfig"
+source "board/phytec/common/k3/Kconfig"
 
 endif
 
-- 
2.25.1

