Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0003CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 11:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 484F38497A;
	Fri, 26 Jun 2026 13:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tlov0Hm+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAF0A8498C; Fri, 26 Jun 2026 13:08:43 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55BC38495E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 13:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvRmEUEzXpp12G8+KEZh4Z1X4CW91etALXyQqCQreBsxofg7h0Lj3qUjnl3FiX8mULQ4AyDnPpYDo2t+8aeROaLU/SsN2n7EzWD/die9sLDVS66QlaFgnMCOdCBkRnKSn05hz21iiWOIOk6pUKKPJSPOOGh93iEjxGNzqgQ/oKhE5Jip3vtPJ4N1rxD9rsEFbfSiIATJdpyh6JzenVznG0UZ+Grn8nQAgpWMjStHGBoiN0J5oaLU5I879FA+TZ3XozbAi1Hsjzops0OnVLi1qDc6W9O4vDcCo1hjndNhjD8B3tXRVzk3D3BrK89uFHBIE21JfAbq3cTyyYrfxDqr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdWcoDlUazj4dqU8FqoOiAurOY7ME1DP7DAMpdFPUEU=;
 b=PxAV4JXJnIPU1yNBa0f7b1Nt+qonZxZgjbDPRVma4VbXJ2HFsWhYE6HSNN416trOabbcNpxHP8ZoZ14c2W9nZ/KvT/zMMysGollaJMrCxpF4ff11CH60PTVLZqaUu1PfV2Uk+wYNFvJpP18+Gia62Bdvyh9UfXjmXueSHV7FRPgAJx2x7b4SZKma3fpedRtv0V4Z0XMwXouNdEYMhsbkWfUxJj+ZK9oqymmTIAIn3ESawnyvXEv/bE+n6MyrATw95JfWqSZda5k1vF83YSSndoNCgbeWa269aBUsOK7K9c1bXE+3BNgtvRLhkt1O0y/iBi2VqOccO41ORCpYhExEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdWcoDlUazj4dqU8FqoOiAurOY7ME1DP7DAMpdFPUEU=;
 b=tlov0Hm+uBycaLZNr2AWixMCD5oas4Lfds/yWxYprVSn5w1zqYAoP+//Qw1U3LfCyHV4dKe1jDvktVh89wZcvnCmTOqXOYLnunW4A/8gY/N3RvJdF6m6uxDJyCUGLnV5KtWRCa1DkeNRW7QKkQ5mz9CEru0S+KX4qXB/eFmUBwIOfIBRbo4vDtq4jFfQLbBCvG1PAYzyAf2SjSlv9U/NhSDPGfKELoWKrJVWrPgu/WvoBP//lI9k6ckLB2Ac9dvqvbZUJqvCEwX1M30M8crTD0FeHj3cVRvmpamgm1vzUnmoEPl4qqljhiEBxVTK04MgZXnSSRdHA5F/6ONh4G0t/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by GVXPR04MB10081.eurprd04.prod.outlook.com (2603:10a6:150:1b0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 11:08:39 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%7]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 11:08:39 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com
Subject: [PATCH 2/2] imx9: Add v2x_status and ele_info commands
Date: Fri, 26 Jun 2026 19:11:53 +0800
Message-Id: <20260626111153.2438623-2-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626111153.2438623-1-ye.li@oss.nxp.com>
References: <20260626111153.2438623-1-ye.li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|GVXPR04MB10081:EE_
X-MS-Office365-Filtering-Correlation-Id: 9531f5a6-6508-4542-503c-08ded373466c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|23010399003|376014|366016|22082099003|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: Y3AUnfGbzU2e1eKxAdkYJahTO1/ndPxxDUkcvETKOpAXPWDxEJtY5Xmb17OBKFV2vOGP7mDBiTcD7FXH+OwzgbUKo9UqUQTNubs0eVgwKaPrPeSmff0j9cpoyNNkTVDk8xIgQpx/XXNWrLBS4YAMFHqhKWWr98P9xTdFoVbLQ0pf6XjuFTjlEP6EPfPJYDwxdthDiXFEDv7GSPrsXXSuJ/FfavEbwfcEYHfvO6h4hBCcHG4rhPyEtlm2qgQrl4sfRpmkWaVOMDMczIsjW8PeoMQsQjpUfEPzrn+HbcD7zzPlUU1gKKcFEl4tZdOFEsqR1xQAoUlAUSh9U0beKLAKP9N5UZnXUUmhG94e3wiq6eM3ccWZdzWwcLcapQJyxJv0C0umAveOLtfuZZ4bbbeTVCReoBHfPIWeKdZjy89M+CWa/HujGVT9l8OivbbBU/aOrOTFj/5mAl5p46q2nMU4rdnE94IaQuGsLHXakT5ry3TWK1VJWx8BSkNKrcoTvYcQTIaTZfIzM9VPgn/sZi1i2mk1LhBiZDeQCyyhNN0WO/BcQzcWPqYgL6DouvcoDfUuFlf+X5jzWcFo7kX0WpYHZS2kxnykSONV9hlZArRCCdapL3xSfN5KhA+1k3e3sgHewZo86vzxWn6T65kMdXcZxWJlIlQFlRybhHgW7LodfqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/BAUpTq1tzDt8e70PHmuOZuLh2zbYH5ReoW11zXoQAf3KOgKvTnFjjq891Gs?=
 =?us-ascii?Q?ey2NoQjvwSga6zV0UH5xhfn0S8pX7sMOCf050Ev6XH7FxkDEk7J2SYycLPxI?=
 =?us-ascii?Q?WoUvQvYdXHRCvA5zlcPK9N4irivdg1to7O2lJyWW18hLy8vwsnTn3Y9cQnJY?=
 =?us-ascii?Q?WDO+TbVdAGgOvZuRR8Xs3eolxdPqsPGYPoqTU36Y4wqzu6MuZJz/XkEGXuwF?=
 =?us-ascii?Q?Vw9OkhHoRlWqyZgdJ2qo+XXsR1/blYCq9KYyPnsLJjsqEu4HrSLTndys3XvF?=
 =?us-ascii?Q?iCIfTYXc5trlV5O88qaYCWiq4TwrPZ6fRvkoHo/sZdn2J6md8MpJEyK9wZ+6?=
 =?us-ascii?Q?p2z+S9doZvfmgrYFJeAacypp/61UnfPzAxW0KYwAgf9Pd9DuHPa/wQSZdScC?=
 =?us-ascii?Q?9sPksLX91Ng+D9xW2QquASgSSRZ5TSjjo+z4W7cDmwyjQZhg+ko2SNx9YyEN?=
 =?us-ascii?Q?OURQ+P/zMjfV4zQNudInSsvzxZqwqDo/MWcRattCb5AVXwS3OG2kW2H/AqR7?=
 =?us-ascii?Q?Qusbeh7KIX/wHAE+j7y6DB/gSReO3eMMXz9U8obuquGKjZ0KDFit04wJ1u6V?=
 =?us-ascii?Q?1KqkNh+WZC6DCOl6e1to1iX8hoby16i+ueypk4z3lHlE54kJtOJcAv6cZqSp?=
 =?us-ascii?Q?IwgapUkUG+cnV2w3nqBtkK90VsJTK40AlbdTmLG+Ax2V5d1WOQ16DKOyjcHi?=
 =?us-ascii?Q?4fPF3d7EMKJvMie3m3YnAOTU6ht2l2YQsgdL/3vTKLk/YnKnx7oYLejdK8IH?=
 =?us-ascii?Q?s2vQmcwBtnA/v/aA5iyLKF3QDnxob+JjcLGS9tP3AAGwfqqcEYUTT2cqzMux?=
 =?us-ascii?Q?oiPcj4j0FOgvEmHMfPxVsbdHGOe6ryU/N+ErkXU9aDtXatrKSh+jMC5duj2P?=
 =?us-ascii?Q?fpVkPiKmDVlpUUyawac6xRAg+fqopfyUD4pJRZ4loizinSWn5vM4zQYXdQd5?=
 =?us-ascii?Q?2fe85y5H4NN16cn6raoyXEIA2izfciiI6b15JZHRFxRo5gl8a1FKz2fIGIqi?=
 =?us-ascii?Q?oAdBnutvgchZi9SPWny8JuolGuJcA3D9Q8u7sKvyAl3bmE3Ue6A6UrciyMeV?=
 =?us-ascii?Q?Vz4QGmDn4QVqKx1PD2AWE5OPGt1VN8h3G+5zdp68x8E8NbHvF4081oFl1Pkr?=
 =?us-ascii?Q?y7TO01MZHeAWENAF5I+9p9lEU1PwGV2zkzTi6u+I663L+cH+6ERKBw7OQCfA?=
 =?us-ascii?Q?mN1xPkfJ94MuWKvGry63llBXXNwh9o+TP2r7inskplpYWRmGlMnRgx8J3yrl?=
 =?us-ascii?Q?gbllvRXdByEPpielvXI26hg1jBRPS4LvK1kJh94SA2pc/P0o/1E0rWBuGyjw?=
 =?us-ascii?Q?B29cYEGwjrg0uN0mNu/ePQGEfGui4/+/XhKFSxraa8+8YJmds8DK71b2YIpN?=
 =?us-ascii?Q?mLBPtzSh3S4q5S3Z3D6zGz5FNs8bEQ2lseoXEIkcHL2mb4UJeUqU0ZvcBRPs?=
 =?us-ascii?Q?SPOu7Q3lzKIPKPYiWG2aezo9ZHE7K4zJuYvegxXd7KeYoLhZWjoygDg9cKI/?=
 =?us-ascii?Q?CLlBLVhp1zuA7udM0MKqH0AAaOt1wKXok2BQfWz/7n7p7hkQgctDdu9DZMEB?=
 =?us-ascii?Q?F4w/fVqE9BRiN8Wp0/8yqKdEcFDZ82QzdMu0Cla52kBMCZ/laNdPgnV2Wwmh?=
 =?us-ascii?Q?BLM764QCkEuiLbddpwmeFbtYkPFqHcpubWSHf+ShktJ8eKjQbcoqbSSJLCye?=
 =?us-ascii?Q?Vzbx7o04Mu+LDU9Xt19f4/3mjc3GweyOJxlmCbmNZXKGb4tQQwBXj0wXyi3S?=
 =?us-ascii?Q?yELd0k/qlC8tEoFZS35qTQy9oLMISbw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9531f5a6-6508-4542-503c-08ded373466c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:08:39.1367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBCZRNmKioE0Fus24WJxa5oZfdP3LN3gEa59/ZV74+cmAi/03kwc+3nZOYVbOkzSq2r/Ma0vQOzIb2FxSGov0Rv7iC0sVZoqskTeIWlh8PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10081
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

From: Ye Li <ye.li@nxp.com>

Add v2x_status and ele_info commands to print useful information
for development and debug purpose.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/Makefile |  2 +-
 arch/arm/mach-imx/imx9/misc.c   | 98 +++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/imx9/misc.c

diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 80b697396ea..ec08430d41d 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -11,7 +11,7 @@ obj-y += soc.o clock.o clock_root.o trdc.o
 endif
 
 ifneq ($(CONFIG_SPL_BUILD),y)
-obj-y += imx_bootaux.o
+obj-y += imx_bootaux.o misc.o
 endif
 
 obj-$(CONFIG_$(PHASE_)IMX_QB) += qb.o
diff --git a/arch/arm/mach-imx/imx9/misc.c b/arch/arm/mach-imx/imx9/misc.c
new file mode 100644
index 00000000000..3cad67aed43
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/misc.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023-2026 NXP
+ *
+ */
+
+#include <command.h>
+#include <cpu_func.h>
+#include <init.h>
+#include <log.h>
+#include <asm/io.h>
+#include <errno.h>
+#include <linux/bitops.h>
+#include <asm/arch-imx/cpu.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/arch/sys_proto.h>
+#include <linux/delay.h>
+#include <linux/sizes.h>
+#include <display_options.h>
+
+static int do_v2x_status(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	int ret;
+	u32 resp = 0;
+	struct v2x_get_state state;
+
+	if (is_imx91() || is_imx93()) {
+		printf("No V2X supported\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = ele_v2x_get_state(&state, &resp);
+	if (ret) {
+		printf("get v2x state failed, resp 0x%x, ret %d\n", resp, ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("V2X state: 0x%x\n", state.v2x_state);
+	printf("V2X power state: 0x%x\n", state.v2x_power_state);
+	printf("V2X err code: 0x%x\n", state.v2x_err_code);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int do_ele_info(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	int ret;
+	u32 res = 0, length;
+	struct ele_get_info_data *info;
+
+	/* ELE can't access full DDR */
+	info = (struct ele_get_info_data *)(CONFIG_TEXT_BASE + SZ_2M -
+		sizeof(struct ele_get_info_data));
+	flush_dcache_range((ulong)info, (ulong)info + sizeof(struct ele_get_info_data));
+
+	ret = ele_get_info(info, &res);
+	if (ret) {
+		printf("Get ELE info failed, resp 0x%x, ret %d\n", res, ret);
+		return CMD_RET_FAILURE;
+	}
+
+	invalidate_dcache_range((ulong)info, (ulong)info + sizeof(struct ele_get_info_data));
+
+	printf("SOC: 0x%x\n", info->soc);
+	printf("LC: 0x%x\n", info->lc);
+
+	printf("\nUID:\n");
+	print_buffer(0, &info->uid, 4, 4, 0);
+
+	printf("\nSHA256 ROM PATCH:\n");
+	print_buffer(0, &info->sha256_rom_patch, 4, 8, 0);
+
+	printf("\nSHA FW:\n");
+	print_buffer(0, &info->sha_fw, 4, 8, 0);
+
+	printf("\nOEM SRKH:\n");
+	print_buffer(0, &info->oem_srkh, 4, 16, 0);
+
+	printf("\nSTATE: 0x%x\n", info->state);
+
+	length = (info->hdr >> 16) & 0xffff;
+	if (length == sizeof(struct ele_get_info_data)) {
+		printf("\nOEM PQC SRKH:\n");
+		print_buffer(0, &info->oem_pqc_srkh, 4, 16, 0);
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(v2x_status, CONFIG_SYS_MAXARGS, 1, do_v2x_status,
+	   "display v2x status",
+	   ""
+);
+
+U_BOOT_CMD(ele_info, CONFIG_SYS_MAXARGS, 1, do_ele_info,
+	   "display ELE information",
+	   ""
+);
-- 
2.34.1

