Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748FACD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 05:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4707184855;
	Wed,  3 Jun 2026 07:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="l5JSQvn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7976F83EF9; Wed,  3 Jun 2026 07:50:01 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2CE584881
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 07:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUOQ/+7jcMqaRutfid0GOLez+S+a6qDJxG5rw76HS+Q8rBljIAgYsWt4/AgwVfq/Yi+5dylsfsdK+aSRkFqZQVMkrRDXpyxjAwEdmbNUJZreHqAeZRILEp9Dv7NBLZqZ7KSo3HcRazjlbH9Yw6VCpEFVh6zIQXgRaLWFsfRVrocp3THcqFkV/a0xZqfiADrHBS/f/FcqGwgCEltxqRxK7UliGnSuAs5ekSzrMUqRYtihenMZz/7P8mCXHfCioi08HRajytajIm1bi3iBwkuvDtrdiav3bfENyrgnuYenA2fUXEuTHZ2eFzG/lltgmfz72yD9YqkTmAlLIoFTigdATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q8P89Dh5qGZIThLykyl2tK2lJnEnOw5ahtaz3hzMX8=;
 b=ZBgdKtxX+irhSqmAt96ynNhPdrqB0rB36+T9BmujmfJpnwyhPgb0lBE09cdoyvo9ZLQXHtJ3HJvwBVF/4VdoSvxIe7JtT41Vta+0higdqHlhiAsf3li/57N/iYjcM33y05JShGPbVXb5C5nr8NXh20S+uml67bSJlMNPZW3SxoBXT5qwozMYvHB/nc1KqqdEFhuNAP7IyFpnwInRpu3kZz3xqUKNTX+vHprxIa/9ZXo/kqZgxB2K9Ql8WrtnKx4zHTV9fk9rAqCtkDjpuHCKTTR1IJfkh0rdmNnnBTfhiNwxYMIrifT0Dt7iFGxIDPrHdEI3RafuUCkG5mJM467d3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q8P89Dh5qGZIThLykyl2tK2lJnEnOw5ahtaz3hzMX8=;
 b=l5JSQvn99r+xLJtnIFELmG2SZgZe8aIgCvHaLaIyq9zy/lzOEfzKArWiNeKmDgjQaYAz8rx/MvAvURCrb0iEyT2Me/zsPEM1bbxHWaMP+dypo2jWj+QWAD/t1GFnqeDBLBL1Wd2tfOkKf0p3fbAxeV8K3hMb5meBeXXPsMiIyK8JNr3PHBj0CR7pFK6lcLMMykOgN9Wzj00EQpZxqAbFcbDcSqP3zDTw4gxH1BhL7es0v3mjeRZAAZKcfcsyJLHwa+v4z6IJO0k27nllIyfiR2UuwUSRTkSEmxCWl7/uCdif0TWdFONfwKTLfaciqYdfwsv96BDYGGNQ9DfGaH7zTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com (2603:10a6:150:2d1::6)
 by VI0PR04MB10370.eurprd04.prod.outlook.com (2603:10a6:800:214::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 05:49:55 +0000
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6]) by GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 05:49:55 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH 3/4] iMX9: scmi: Disable fused modules for iMX95/94/952
Date: Wed,  3 Jun 2026 13:51:58 +0800
Message-ID: <20260603055159.414338-3-ye.li@nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260603055159.414338-1-ye.li@nxp.com>
References: <20260603055159.414338-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0165.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::7) To GV2PR04MB11760.eurprd04.prod.outlook.com
 (2603:10a6:150:2d1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11760:EE_|VI0PR04MB10370:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad97cc7-63a1-43a1-9c8a-08dec133f026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|42112799006|366016|1800799024|38350700014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mxCaRViXzGA/RsBnFF/j4wfaBnTnG5fMFzAdAaaqzEYNsTKYnqu2BkyDbZiWuhUVRq+Z56Mopqzqhc9r4C/D4zCA7X4mDTM7YFi7wfpy/R8LrZfSZcDlutM9mUwEFJu2D4FLURJ+RNYEFG/F5Ivh4CkvC/R7W1nZziON84kyDvG24kvSz8AkpcYoKROtBtV0OBaVWU4fsMHfdYcOdzpzxCoMYP/ZOBC0aygPj0lX3E5NFha8wzJ1CNigHcEwVfHYIOQj34KM+Bhfy9GM0Tf6DS4QqW4dGcZqU5FwheaBjAIBW5xs7hz0i6bffcpqRSxnrZ0A6xbJejOKlSP2ziRWqJ+4yumFdH9jrCLHpb5t2IUlWlYfTSoXZGE2EWashXmqWap/YVJUlmPX5UGWaFDd7bOcl/ZnexEk5v7/EZcv1OVso3Eyeo+P1jc1tOLnsqv033gcpeiylCp0DUUG8qs+nZAxr8wT52S0Zg1Kn6iz34h0KZdjxGPmxX+MXMSYlTff4yk0JyobiKLhDoqEo6aCK/eJspORE7AzaQpwtHJKxkh71GxSE6KjJGPQ5kqA9FQJ5t1uGSOHZ3CrEww2Xe3pSuAGPPqA7puE+R9nJUHJKZDe2AYfvGElYVAJ1awrXfHbGYnz9W0YsiGxp3iGENdazszOqhScgrR3+B+kAMz+2a9FV96SoTBIbgIC9M6GhJak5YjMt6wbzMXbDkkUK/Ci4IWnKQZVgT1wDyvjJLnc+75lLIOudR+VjygB/BP4hUkl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11760.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(42112799006)(366016)(1800799024)(38350700014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X6SveMJB3Tb97L3lms14UIZc4Fu8lw0r40suo2ZIW7xJG5xnXwTgnpJWxJP7?=
 =?us-ascii?Q?T4F3OO5nSWAfd/kD+F7MRCeX6rBBSsT2OcJAJXxJYSYUUsq/tfjmn8IGYulL?=
 =?us-ascii?Q?eM9ubCIyL1V4jeo3+3Q7oNlpKPES0JmpqnhbsBSUXoPeHH9nd9aVVILoiGa7?=
 =?us-ascii?Q?4t6fTWotqYkIJDj37r+cWVg5DBDp0CDG1a9xcSPqW0zQZOHZ6oMWB8Mv9S5l?=
 =?us-ascii?Q?Oq8+vQ4Jt9Ks5Y3UGM2UOgVuoKFOTlT6K0+btKINSLMXZE+RGqk1QHjlnAnK?=
 =?us-ascii?Q?LomuVSzro6P+XbsDs0wtbWM6oDdA5ukhmN9DUmLv+4wQYZEKZ2jezOCUdcFD?=
 =?us-ascii?Q?rZFSBnMsaZE1Ytb26F1oTY5PXQz8Ws0FKOLtlqLkVBpaSwkbpxCHukJQYpmm?=
 =?us-ascii?Q?iacveaWhDFb79X8tYUQ7pBryHDSUo0MZQLohBwyzec8byY27tzYNYxnICoWu?=
 =?us-ascii?Q?5f4y3JrL4WVV5EOLZqcVQ+Rx0vSQG3xhOdsgGmBMynYjj0vs2c1wTxOjNJBA?=
 =?us-ascii?Q?SPDUk+TJsWaPd3jsqH+3BGSozWQIB3tDhw0JLVFxH9ehKFN3kTpZMgFaDGEn?=
 =?us-ascii?Q?jhjPUrply7lramR5g/Je+hNphIwPB9+1yUvXnUpydSR5WP5G2BUNRkMkjclv?=
 =?us-ascii?Q?8lDNQ0fh9rIE0Ykp8RFcQay5em0tXyVEHVfMue8aLUbrh+6cF34wnlopODFu?=
 =?us-ascii?Q?/RzjxZdHAenW+isY+J/27HTh+JJkniwsE/kFryFd+nqNaW7LJJ01b90rRMbe?=
 =?us-ascii?Q?73ODfbjkmSqocUN/fNBEdTU+zrd903WcC2/sSj7UjQgJWGoKUnH/H4J3b0B8?=
 =?us-ascii?Q?Nql3tC3VvA/9RFlM5oByfpRPEKky8Kw/SQu8g+ttKvs71Rz8u/9iD/+bmfp3?=
 =?us-ascii?Q?I9BNp0pjcriw7DFLqny19zjrp+4SMfiw1siD786MQ0qqHeC64+Y9fU4Xya/P?=
 =?us-ascii?Q?wtIhGlBCFc76TCEYno1MH2nDSi4sYgg0/tPKvrAoIR5/7GHmCZJpq/oEBfGk?=
 =?us-ascii?Q?Xjs7gHaANkgKfuI8Fh0Sm8vTfJ+Cqdf/NCWaZmpjsIVV0QDlUZQJ4CZfRHEA?=
 =?us-ascii?Q?I6TXebUGXfMY6K0lJiehkAg4H2keDOrwRBrk9BE/BDaEkSS61npwVaPFhEUU?=
 =?us-ascii?Q?HNZEJdJ1ZIFphIUg5etbM1pl9v8R8kROPfI3lOA1wx4LeS/ElIeCPuGhLp2j?=
 =?us-ascii?Q?BRs5TF5HyQWWwCeuCTIOMa8FAHHSlMxlqvuugB0QNasiS0NXXTLL3qyApRsY?=
 =?us-ascii?Q?ScfW0GTO5Ljrp9NZdTKAO+ysJ9sTVMuCD9Qxu55atzBjBstphMDedGdy9QUW?=
 =?us-ascii?Q?3lk54kckd+yHDQ08pK11Lj1IjvyWladkzBxRo+A0t5WEZVX20K+qWcQgYcYw?=
 =?us-ascii?Q?fUxnW621Ytqb6zThn1nfbSC91PdB3O/jtSBEE4dHMD2mk+XNvZm53t6lLGxG?=
 =?us-ascii?Q?l5Jhk6ZxmbCaUX/go8xk2SjcU/4QrPq1+fQJ8WtJXESQs+hDWtWIroh9CUKB?=
 =?us-ascii?Q?lGJ1zYP+ersQyNT2IJsYbhqwxxtH19H1WmjOd95cVL4eQDWxAcz8H8uXoSyu?=
 =?us-ascii?Q?YmOItkhfjRDjfIjOX/7j33MX0KGVLjMVE/ttnUvp8Ru0hxOKHrAqPBXVoF9A?=
 =?us-ascii?Q?ysyBq+SYKZjQ/PowCYABPOJWO+tREgQP9QM5F7xEKFCGyMsxG0InDLzrTccc?=
 =?us-ascii?Q?+rsnxmD4tKo0A9QazY2ytf9uYfEqWQKWHLgd94qiXRd7QDWM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad97cc7-63a1-43a1-9c8a-08dec133f026
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 05:49:55.3250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7YHFewLH3O88/nWgmb69A3pFonTrubkahk2Ce+wUS7kcN5iNahtn8HxMFADFtHD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10370
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

Disable relevant modules in kernel FDT and u-boot FDT according to
fuse settings on iMX95/94/952.
For u-boot FDT fixup, introduce a common function that each board
needs this fixup could select OF_BOARD_FIXUP and implement
board_fix_fdt to call imx9_uboot_fixup_by_fuse.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/arch-imx9/sys_proto.h |   1 +
 arch/arm/mach-imx/imx9/scmi/Makefile       |   2 +-
 arch/arm/mach-imx/imx9/scmi/fdt.c          | 644 +++++++++++++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c          |  12 -
 4 files changed, 646 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/mach-imx/imx9/scmi/fdt.c

diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index dead7a99a66..6843e81f3f7 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -22,6 +22,7 @@ int low_drive_freq_update(void *blob);
 
 enum imx9_soc_voltage_mode soc_target_voltage_mode(void);
 int get_reset_reason(bool sys, bool lm);
+int imx9_uboot_fixup_by_fuse(void *fdt);
 
 #define is_voltage_mode(mode) (soc_target_voltage_mode() == (mode))
 
diff --git a/arch/arm/mach-imx/imx9/scmi/Makefile b/arch/arm/mach-imx/imx9/scmi/Makefile
index b98744e1ecb..e83d27327cb 100644
--- a/arch/arm/mach-imx/imx9/scmi/Makefile
+++ b/arch/arm/mach-imx/imx9/scmi/Makefile
@@ -5,5 +5,5 @@
 # Add include path for NXP device tree header files from Linux.
 ccflags-y += -I$(srctree)/dts/upstream/src/arm64/freescale/
 
-obj-y += soc.o
+obj-y += soc.o fdt.o
 obj-y += clock_scmi.o clock.o
diff --git a/arch/arm/mach-imx/imx9/scmi/fdt.c b/arch/arm/mach-imx/imx9/scmi/fdt.c
new file mode 100644
index 00000000000..a1d9afbf69a
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/fdt.c
@@ -0,0 +1,644 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ *
+ */
+
+#include <asm/arch/sys_proto.h>
+#include <linux/bitfield.h>
+#include <fuse.h>
+#include <fdt_support.h>
+#include <fdtdec.h>
+
+struct periph_fuse_info {
+	u32 bit_mask;
+	u32 soc_type; /* 0 means for all */
+	bool of_board_fix;
+	int (*disable_func)(void *blob, u32 fuse_val);
+};
+
+int num_a55_cores_disabled;
+int gpu_disabled;
+
+static int delete_fdt_nodes(void *blob, const char *const nodes_path[], int size_array)
+{
+	int i = 0;
+	int rc;
+	int nodeoff;
+
+	for (i = 0; i < size_array; i++) {
+		nodeoff = fdt_path_offset(blob, nodes_path[i]);
+		if (nodeoff < 0)
+			continue; /* Not found, skip it */
+
+		debug("Found %s node\n", nodes_path[i]);
+
+		rc = fdt_del_node(blob, nodeoff);
+		if (rc < 0) {
+			printf("Unable to delete node %s, err=%s\n",
+			       nodes_path[i], fdt_strerror(rc));
+		} else {
+			printf("Delete node %s\n", nodes_path[i]);
+		}
+	}
+
+	return 0;
+}
+
+static int disable_fdt_nodes(void *blob, const char *const nodes_path[],
+			     int size_array, const char *prop, const char *value)
+{
+	int i = 0;
+	int rc;
+	int nodeoff;
+	const char *status = "disabled";
+	const char *prop_str;
+
+	for (i = 0; i < size_array; i++) {
+		nodeoff = fdt_path_offset(blob, nodes_path[i]);
+		if (nodeoff < 0)
+			continue; /* Not found, skip it */
+
+		debug("Found %s node\n", nodes_path[i]);
+
+		if (prop && value) {
+			prop_str = fdt_stringlist_get(blob, nodeoff, prop, 0, NULL);
+
+			if (!prop_str || strcmp(prop_str, value))
+				continue;
+		}
+
+add_status:
+		rc = fdt_setprop(blob, nodeoff, "status", status, strlen(status) + 1);
+		if (rc) {
+			if (rc == -FDT_ERR_NOSPACE) {
+				rc = fdt_increase_size(blob, 512);
+				if (!rc)
+					goto add_status;
+			}
+			printf("Unable to update property %s:%s, err=%s\n",
+			       nodes_path[i], "status", fdt_strerror(rc));
+		} else {
+			debug("Modify %s:%s disabled\n", nodes_path[i], "status");
+		}
+	}
+
+	return 0;
+}
+
+static int get_cooling_device_list(void *blob, u32 nodeoff,
+				   const char *const path, u32 *cooling_dev, int max_cnt)
+{
+		int cnt, j;
+
+		cnt = fdtdec_get_int_array_count(blob, nodeoff, "cooling-device",
+						 cooling_dev, max_cnt);
+		if (cnt < 0) {
+			printf("cnt incorrect, path %s, cnt = %d\n", path, cnt);
+			return cnt;
+		}
+		if (cnt != max_cnt)
+			printf("Warning: %s, cooling-device count %d\n", path, cnt);
+
+		for (j = 0; j < cnt; j++)
+			cooling_dev[j] = cpu_to_fdt32(cooling_dev[j]);
+
+		return cnt;
+}
+
+static void disable_thermal_vpu_node(void *blob, u32 disabled_cores, u32 gpu_disabled)
+{
+	static const char * const thermal_path[] = {
+		"/thermal-zones/ana/cooling-maps/map0",
+		"/thermal-zones/ana-thermal/cooling-maps/map0",
+	};
+	int num_cpus = (is_imx94() || is_imx952()) ? 4 : 6;
+	u32 array_cnt = (num_cpus + 2) * 3 - (disabled_cores * 3) - (gpu_disabled * 3);
+	u32 cooling_dev[array_cnt];
+
+	int nodeoff, ret, i, cnt;
+
+	for (i = 0; i < ARRAY_SIZE(thermal_path); i++) {
+		nodeoff = fdt_path_offset(blob, thermal_path[i]);
+		if (nodeoff < 0) {
+			printf("path not found %s\n", thermal_path[i]);
+			continue; /* Not found, skip it */
+		}
+
+		cnt = get_cooling_device_list(blob, nodeoff,
+					      thermal_path[i], cooling_dev, array_cnt);
+		/* VPU map does not exist in cooling dev*/
+		if (cnt <= ((num_cpus - disabled_cores) * 3 + (gpu_disabled ? 0 : 3)))
+			continue;
+
+		/* Remove  VPU it the last two nodes in the fdt ana blob */
+		ret = fdt_setprop(blob, nodeoff, "cooling-device", &cooling_dev,
+				  sizeof(u32) * (array_cnt - 3));
+
+		if (ret < 0) {
+			printf("Warning: %s, cooling-device setprop failed %d\n",
+			       thermal_path[i], ret);
+			continue;
+		}
+
+		printf("Update node %s, cooling-device prop\n", thermal_path[i]);
+	}
+}
+
+static void disable_thermal_gpu_node(void *blob, u32 disabled_cores)
+{
+	static const char * const thermal_path[] = {
+		"/thermal-zones/ana/cooling-maps/map0",
+		"/thermal-zones/ana-thermal/cooling-maps/map0",
+	};
+	int num_cpus = (is_imx94() || is_imx952()) ? 4 : 6;
+	u32 array_cnt = (num_cpus + 2) * 3 - (disabled_cores * 3);
+	u32 cooling_dev[array_cnt];
+	int nodeoff, ret, i, cnt;
+
+	for (i = 0; i < ARRAY_SIZE(thermal_path); i++) {
+		nodeoff = fdt_path_offset(blob, thermal_path[i]);
+		if (nodeoff < 0) {
+			printf("path not found %s\n", thermal_path[i]);
+			continue; /* Not found, skip it */
+		}
+
+		cnt = get_cooling_device_list(blob, nodeoff, thermal_path[i],
+					      cooling_dev, array_cnt);
+		if (cnt <= (num_cpus - disabled_cores) * 3)
+			continue; /* GPU map does not exist in cooling dev*/
+
+		/* Remove GPU and VPU as these are the last two nodes in the fdt ana blob */
+		ret = fdt_setprop(blob, nodeoff, "cooling-device", &cooling_dev,
+				  sizeof(u32) * (array_cnt - 6));
+		if (ret < 0) {
+			printf("Warning: %s, cooling-device setprop failed %d\n",
+			       thermal_path[i], ret);
+			continue;
+		}
+
+		if (cnt == array_cnt) {
+			/* Add VPU node back to ana thermal-zone. */
+			ret = fdt_appendprop(blob, nodeoff, "cooling-device",
+					     &cooling_dev[array_cnt - 3], sizeof(u32) * 3);
+			if (ret < 0) {
+				printf("Warning: %s, cooling-device appendprop failed %d\n",
+				       thermal_path[i], ret);
+				continue;
+			}
+		}
+
+		printf("Update node %s, cooling-device prop\n", thermal_path[i]);
+	}
+}
+
+static void disable_thermal_cpu_nodes(void *blob, u32 disabled_cores)
+{
+	static const char * const thermal_path[] = {
+		"/thermal-zones/pf53_arm/cooling-maps/map0",
+		"/thermal-zones/ana/cooling-maps/map0",
+		"/thermal-zones/a55/cooling-maps/map0",
+		"/thermal-zones/a55-thermal/cooling-maps/map0",
+		"/thermal-zones/ana-thermal/cooling-maps/map0",
+	};
+	u32 cooling_dev[24];
+	int nodeoff, ret, i, cnt;
+	int prop_size = 3 * ((is_imx94() || is_imx952()) ? 4 : 6);
+
+	for (i = 0; i < ARRAY_SIZE(thermal_path); i++) {
+		nodeoff = fdt_path_offset(blob, thermal_path[i]);
+		if (nodeoff < 0) {
+			printf("path not found %s\n", thermal_path[i]);
+			continue; /* Not found, skip it */
+		}
+		cnt = get_cooling_device_list(blob, nodeoff, thermal_path[i], cooling_dev, 24);
+
+		ret = fdt_setprop(blob, nodeoff, "cooling-device", &cooling_dev,
+				  sizeof(u32) * (prop_size - disabled_cores * 3));
+
+		if (ret < 0) {
+			printf("Warning: %s, cooling-device setprop failed %d\n",
+			       thermal_path[i], ret);
+			continue;
+		}
+
+		/* Add GPU and VPU nodes back to ana thermal-zone. */
+		if (cnt > prop_size) {
+			ret = fdt_appendprop(blob, nodeoff, "cooling-device",
+					     &cooling_dev[prop_size],
+					     sizeof(u32) * (cnt - prop_size));
+			if (ret < 0) {
+				printf("Warning: %s, cooling-device appendprop failed %d\n",
+				       thermal_path[i], ret);
+				continue;
+			}
+		}
+
+		printf("Update node %s, cooling-device prop\n", thermal_path[i]);
+	}
+}
+
+static int disable_ld_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_ld[] = {
+		"/remoteproc",
+		"/disp-mu",
+		"/soc/syscon@4b070000",
+		"/soc/mailbox@4b080000",
+		"/soc/mailbox@4b090000",
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_ld, ARRAY_SIZE(nodes_path_ld));
+}
+
+static int disable_npu_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_npu[] = {
+		"/soc/imx95-neutron-remoteproc@4ab00000",
+		"/soc/imx95-neutron@4ab00004",
+		"/soc/neutron-remoteproc@4ab00000",
+		"/soc/neutron@4ab00004",
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_npu, ARRAY_SIZE(nodes_path_npu));
+}
+
+static int disable_arm_cpu_nodes(void *blob, u32 fuse_val)
+{
+	u32 i = 0;
+	int rc;
+	int nodeoff;
+	char nodes_path[32];
+	int num_cpus = (is_imx94() || is_imx952()) ? 4 : 6;
+
+	num_a55_cores_disabled = 0;
+
+	if (fuse_val & BIT(2)) /* A55C2 */
+		num_a55_cores_disabled++;
+
+	if (fuse_val & BIT(3)) /* A55C2 */
+		num_a55_cores_disabled++;
+
+	if (fuse_val & BIT(4)) /* A55C3 */
+		num_a55_cores_disabled++;
+
+	if (fuse_val & BIT(5)) /* A55C4 */
+		num_a55_cores_disabled++;
+
+	if (fuse_val & BIT(6)) /* A55C5 */
+		num_a55_cores_disabled++;
+
+	for (i = num_cpus; i > (num_cpus - num_a55_cores_disabled); i--) {
+		sprintf(nodes_path, "/cpus/cpu@%u00", i - 1);
+
+		nodeoff = fdt_path_offset(blob, nodes_path);
+		if (nodeoff < 0)
+			continue; /* Not found, skip it */
+
+		debug("Found %s node\n", nodes_path);
+
+		rc = fdt_del_node(blob, nodeoff);
+		if (rc < 0) {
+			printf("Unable to delete node %s, err=%s\n",
+			       nodes_path, fdt_strerror(rc));
+		} else {
+			printf("Delete node %s\n", nodes_path);
+
+			/* Remove node from cpu-map/cluster0 */
+			sprintf(nodes_path, "/cpus/cpu-map/cluster0/core%u", i - 1);
+			nodeoff = fdt_path_offset(blob, nodes_path);
+			if (nodeoff < 0)
+				continue; /* Not found, skip it */
+
+			rc = fdt_del_node(blob, nodeoff);
+			if (rc < 0)
+				printf("Unable to delete node %s, err=%s\n",
+				       nodes_path, fdt_strerror(rc));
+		}
+	}
+
+	disable_thermal_cpu_nodes(blob, num_a55_cores_disabled);
+
+	return 0;
+}
+
+static int disable_jpegdec_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_jpegdec[] = {
+		"/soc/jpegdec@4c500000",
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_jpegdec, ARRAY_SIZE(nodes_path_jpegdec));
+}
+
+static int disable_jpegenc_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_jpegenc[] = {
+		"/soc/jpegenc@4c550000",
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_jpegenc, ARRAY_SIZE(nodes_path_jpegenc));
+}
+
+static int disable_mipicsi0_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_mipicsi0[] = {
+		"/soc/csi@4ad30000",
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_mipicsi0, ARRAY_SIZE(nodes_path_mipicsi0));
+}
+
+static int disable_mipicsi1_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_mipicsi1[] = {
+		"/soc/csi@4ad40000",
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_mipicsi1, ARRAY_SIZE(nodes_path_mipicsi1));
+}
+
+static int disable_isp_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_isp[] = {
+		"/soc@0/isp@4ae00000",
+		"/soc/isp@4ae00000",
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_isp, ARRAY_SIZE(nodes_path_isp));
+}
+
+static int disable_vpu_node(void *blob, u32 fuse_val)
+{
+	int ret = 0;
+
+	static const char * const nodes_path_vpu[] = {
+		"/soc/vpu-ctrl@4c4c0000",
+		"/soc/vpu-ctrl@4c4f0000",
+		"/soc/vpu@4c480000",
+		"/soc/vpu@4c490000",
+		"/soc/vpu@4c4a0000",
+		"/soc/vpu@4c4b0000",
+		"/soc/vpu@4c4c0000",
+		"/soc/vpu@4c4d0000",
+		"/soc/vpu@4c4e0000",
+		"/soc/jpegdec@4c500000",
+		"/soc/jpegenc@4c550000",
+		"/soc/vpuenc@4c460000",
+		"/soc/syscon@4c410000"
+	};
+
+	ret = delete_fdt_nodes(blob, nodes_path_vpu, ARRAY_SIZE(nodes_path_vpu));
+	if (!ret)
+		disable_thermal_vpu_node(blob, num_a55_cores_disabled, gpu_disabled);
+
+	return ret;
+}
+
+static int disable_vpuenc_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_vpuenc[] = {
+		"/soc/vpuenc@4c460000",
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_vpuenc, ARRAY_SIZE(nodes_path_vpuenc));
+}
+
+static int disable_vpuwave511_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_vpu511[] = {
+		"/soc/vpu-ctrl@4c4f0000",
+		"/soc/vpu@4c4b0000",
+		"/soc/vpu@4c4c0000",
+		"/soc/vpu@4c4d0000",
+		"/soc/vpu@4c4e0000",
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_vpu511, ARRAY_SIZE(nodes_path_vpu511));
+}
+
+static int disable_gpu_node(void *blob, u32 fuse_val)
+{
+	int ret = 0;
+
+	static const char * const nodes_path_gpu[] = {
+		"/soc/gpu@4d900000",
+		"/thermal-zones@1/ana/cooling-maps/map1/cooling-device/gpu@4d900000",
+		"/thermal-zones/ana/cooling-maps/map1/cooling-device/gpu@4d900000",
+		"/thermal-zones@1/ana/cooling-maps/map1/cooling-device",
+		"/thermal-zones/ana/cooling-maps/map1/cooling-device",
+		"/thermal-zones@1/ana/cooling-maps/map1",
+		"/thermal-zones/ana/cooling-maps/map1",
+	};
+
+	ret = delete_fdt_nodes(blob, nodes_path_gpu, ARRAY_SIZE(nodes_path_gpu));
+	if (!ret) {
+		disable_thermal_gpu_node(blob, num_a55_cores_disabled);
+		gpu_disabled = 1;
+	}
+	return ret;
+}
+
+static int disable_pciea_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_pciea[] = {
+		"/soc/pcie@4c300000",
+		"/soc/pcie-ep@4c300000"
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_pciea, ARRAY_SIZE(nodes_path_pciea));
+}
+
+static int disable_pcieb_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_pcieb[] = {
+		"/soc/pcie@4c380000",
+		"/soc/pcie-ep@4c380000"
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_pcieb, ARRAY_SIZE(nodes_path_pcieb));
+}
+
+int disable_enet10g_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_enet10g[] = {
+		"/pcie@4ca00000/ethernet@10,0",
+		"/soc/pcie@4ca00000/ethernet@10,0",
+		"/soc/syscon@4ca00000/ethernet@10,0",
+		"/soc/netc-blk-ctrl@4cde0000/pcie@4ca00000/ethernet@10,0",
+	};
+
+	return disable_fdt_nodes(blob, nodes_path_enet10g, ARRAY_SIZE(nodes_path_enet10g),
+		NULL, NULL);
+}
+
+int disable_enet25g_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_enet25g[] = {
+		"/soc/system-controller@4ceb0000/pcie@4ca00000/ethernet-switch@0,2/ports/port@0",
+		"/soc/system-controller@4ceb0000/pcie@4ca00000/ethernet-switch@0,2/ports/port@1",
+	};
+
+	return disable_fdt_nodes(blob, nodes_path_enet25g, ARRAY_SIZE(nodes_path_enet25g),
+		"phy-mode", "sgmii");
+}
+
+int disable_mipidsi_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_mipidsi[] = {
+		"/soc/dsi@4acf0000",
+		"/soc/syscon@4acf0000",
+		"/soc/dsi@4b060000",
+		"/soc/phy@4b110000",
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_mipidsi, ARRAY_SIZE(nodes_path_mipidsi));
+}
+
+int disable_dpu_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_dpu[] = {
+		"/soc/bridge@4b0d0000/channel@0/port@0/endpoint",
+		"/soc/bridge@4b0d0000/channel@0/port@1/endpoint",
+		"/soc/bridge@4b0d0000/channel@1/port@0/endpoint",
+		"/soc/bridge@4b0d0000/channel@1/port@1/endpoint",
+		"/soc/display-controller@4b400000/ports/port@0/endpoint",
+		"/soc/display-controller@4b400000/ports/port@1/endpoint",
+		"/soc/display-controller@4b400000",
+		"/soc/syscon@4b010000/bridge@8/ports/port@0/endpoint",
+		"/soc/syscon@4b010000/bridge@8/ports/port@1/endpoint",
+		"/soc/syscon@4b010000/bridge@8/ports/port@2/endpoint@0",
+		"/soc/syscon@4b010000/bridge@8/ports/port@2/endpoint@1",
+		"/soc/syscon@4b010000/bridge@8/ports/port@3/endpoint@0",
+		"/soc/syscon@4b010000/bridge@8/ports/port@3/endpoint@1",
+		"/soc/syscon@4b010000/bridge@8",
+		"/soc/syscon@4b010000",
+		"/soc/syscon@4b0a0000",
+		"/soc/interrupt-controller@4b0b0000",
+		"/soc/bridge@4b0d0000"
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_dpu, ARRAY_SIZE(nodes_path_dpu));
+}
+
+int disable_lvds_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_lvds[] = {
+		"/soc/syscon@4b0c0000/ldb@4/channel@0",
+		"/soc/syscon@4b0c0000/phy@8",
+		"/soc/syscon@4b0c0000/ldb@4/channel@1",
+		"/soc/syscon@4b0c0000/phy@c",
+		"/soc/syscon@4b0c0000"
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_lvds, ARRAY_SIZE(nodes_path_lvds));
+}
+
+int disable_cm70_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_cm70[] = {
+		"/reserved-memory/vdev0vring0@82000000",
+		"/reserved-memory/vdev0vring1@82008000",
+		"/reserved-memory/vdev1vring0@82010000",
+		"/reserved-memory/vdev1vring1@82018000",
+		"/reserved-memory/rsc-table@82220000",
+		"/reserved-memory/vdevbuffer@82020000",
+		"/imx943-cm70",
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_cm70, ARRAY_SIZE(nodes_path_cm70));
+}
+
+int disable_cm71_node(void *blob, u32 fuse_val)
+{
+	static const char * const nodes_path_cm71[] = {
+		"/reserved-memory/vdev0vring0@84000000",
+		"/reserved-memory/vdev0vring1@84008000",
+		"/reserved-memory/vdev1vring0@84010000",
+		"/reserved-memory/vdev1vring1@84018000",
+		"/reserved-memory/rsc-table@84220000",
+		"/reserved-memory/vdevbuffer@84020000",
+		"/imx943-cm71",
+	};
+
+	return delete_fdt_nodes(blob, nodes_path_cm71, ARRAY_SIZE(nodes_path_cm71));
+}
+
+/* There is order dependency between cpu->gpu->vpu */
+struct periph_fuse_info f17_grp[] = {
+	{ BIT(30), MXC_CPU_IMX952, false, disable_ld_node },
+};
+
+struct periph_fuse_info f18_grp[] = {
+	{ BIT(0), 0, false, disable_npu_node },
+	{ GENMASK(6, 2), 0, false, disable_arm_cpu_nodes },
+	{ BIT(9), 0, true, disable_cm70_node },
+	{ BIT(17), MXC_CPU_IMX94, true, disable_cm71_node },
+	{ BIT(22), 0, true, disable_dpu_node },
+	{ BIT(27), 0, true, disable_lvds_node },
+	{ BIT(29), 0, false, disable_isp_node },
+};
+
+struct periph_fuse_info f19_grp[] = {
+	{ BIT(6), 0, true, disable_pciea_node },
+	{ BIT(7), 0, true, disable_pcieb_node },
+	{ BIT(17), 0, false, disable_gpu_node },
+	{ BIT(18), 0, false, disable_vpu_node },
+	{ BIT(19), 0, false, disable_jpegenc_node },
+	{ BIT(20), 0, false, disable_jpegdec_node },
+	{ BIT(22), 0, false, disable_mipicsi0_node },
+	{ BIT(23), 0, false, disable_mipicsi1_node },
+	{ BIT(24), 0, true, disable_mipidsi_node },
+	{ BIT(26), 0, false, disable_vpuenc_node },
+	{ BIT(27), 0, false, disable_vpuwave511_node },
+};
+
+struct periph_fuse_info f20_grp[] = {
+	{ BIT(12), MXC_CPU_IMX95, true, disable_enet10g_node },
+	{ BIT(12), MXC_CPU_IMX94, true, disable_enet25g_node },
+};
+
+static void ft_disable_periph(void *blob, u32 fuse_bank, u32 fuse_word,
+			      struct periph_fuse_info *info, u32 info_num,
+			      bool board_fix_fdt)
+{
+	int i, ret;
+	u32 val = 0;
+
+	ret = fuse_read(fuse_bank, fuse_word, &val);
+	if (ret)
+		return;
+
+	for (i = 0; i < info_num; i++) {
+		if (val & info[i].bit_mask) {
+			if (board_fix_fdt && !info[i].of_board_fix)
+				continue;
+
+			if (!info[i].soc_type || is_cpu_type(info[i].soc_type))
+				info[i].disable_func(blob, val);
+		}
+	}
+}
+
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	/* Common peripheral disable fuse process */
+	ft_disable_periph(blob, 2, 1, f17_grp, ARRAY_SIZE(f17_grp), false);
+	ft_disable_periph(blob, 2, 2, f18_grp, ARRAY_SIZE(f18_grp), false);
+	ft_disable_periph(blob, 2, 3, f19_grp, ARRAY_SIZE(f19_grp), false);
+	ft_disable_periph(blob, 2, 4, f20_grp, ARRAY_SIZE(f20_grp), false);
+
+	return 0;
+}
+
+/* Fix uboot dtb based on fuses. */
+#if IS_ENABLED(CONFIG_OF_BOARD_FIXUP) && !IS_ENABLED(CONFIG_XPL_BUILD)
+int imx9_uboot_fixup_by_fuse(void *fdt)
+{
+	ft_disable_periph(fdt, 2, 2, f18_grp, ARRAY_SIZE(f18_grp), true);
+	ft_disable_periph(fdt, 2, 3, f19_grp, ARRAY_SIZE(f19_grp), true);
+	ft_disable_periph(fdt, 2, 4, f20_grp, ARRAY_SIZE(f20_grp), true);
+
+	return 0;
+}
+#endif
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index aedaa0d4bca..b75e29c99b6 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -826,18 +826,6 @@ int arch_misc_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_SPL_BUILD)
-int board_fix_fdt(void *fdt)
-{
-	return 0;
-}
-#endif
-
-int ft_system_setup(void *blob, struct bd_info *bd)
-{
-	return 0;
-}
-
 #if IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)
 void get_board_serial(struct tag_serialnr *serialnr)
 {
-- 
2.50.1

