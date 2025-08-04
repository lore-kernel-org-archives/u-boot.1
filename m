Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940D9C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 650CE83EDF;
	Mon,  4 Aug 2025 03:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="W3KaoZ3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BF4483E70; Mon,  4 Aug 2025 03:25:34 +0200 (CEST)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62C4283DB6
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvNxd1nNLRWi8eXIxeTbaVrd+qcsX6u002+Ih4AiN9lWTIV4DPm4R8z8FpTAErltfTTd34tAfPu2R167GPjIIJwk1q+duC9cqbHhqAqtyfcmnzVnRMUJTwQknmvj+vWSpgnTc/stSImzM+T9R8XR79OOnAwHF9T1JsNBI+D3peoUTD/AS/DC2Py7fGICXDkxh4KxVEirsSdjkX/8DtRPRjkm20ZoOnzlRoHBRu64j51rl0iZp5dEbytbaSbfufcoVla+f3mPTVDOI7kaYr7s4iCu4wI2uA0lY+s1ci4BGXLVQ4PfgmFW9nGAq90Xa1FNIWiWwx1wbQC/93p8sYHhQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpxdLkOjVDFmNUw2eouvo22pYG2u5aNLUWMCt6QeMxs=;
 b=ncdKqZ8CdRuCFGGQDXXLias6IfGw/qJaeHjixxWnn7bLxfsRK7ELGnMsLwFbN3eXYpHtxW6EkrL0caruNzRGsOoZ5Hmg6L9DA8mJSXtDFhOFwva7wddnZO7/4wouERgKD3mARKZE0v3K53bjnvW9g0pSvHtucQqDUcV0mfsU3NgBQ2ET4dKjYuZMMS25kTa/ql7xq5rERk0WtlWzrRmuogFBYE84KBVVES10xXQjzIJYsBY+I+gtIgyqpjsjRguS2Lp3l0Ed1t4iM9CDK5FrEB26qlyfqStabeirTzOQjp9xd6hIEfyhJP3lOpBB3XMBaFeQISBoyVHh5Xiy5atung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpxdLkOjVDFmNUw2eouvo22pYG2u5aNLUWMCt6QeMxs=;
 b=W3KaoZ3g+/YHOaeBmD9IUw1omwwrUQWe3tx4WoOdz0xyA3hb9nDjdC+2Cp4oaREAtsi+Zk/TbOkV3PicsVZ6oQPtl6sWoZf+kl5rFNGuiZPNFmhE2HcbKPBWC7q55pSfs/eMeghuG74PQC+85C2p2x60CYIP0JlrFHZLfohLPu/7YMPOjRblyHfVM2ZIRQOlr4fxGR9OQQiLGdAlaDrwt9RdXNNvmJC5uFoozDXEvaR5IkbO8+wpoF1TZbaOZzjsfCFcYL0LM8ex3ceDFGTL9m8ET/Z3PMcVHgEh8nLE5lyKKMuqflU/nfye/3WAOdekOGlzkxaFiLmaTKSq6mv+qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:29 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:29 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 22/34] arch: arm: mach-socfpga: Add Agilex7 M-series
 mach-socfgpa enablement
Date: Sun,  3 Aug 2025 18:24:49 -0700
Message-Id: <20250804012501.21811-23-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 684c163d-99da-4488-44cf-08ddd2f5cc80
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/X/QIuhrwC9lYqrTl6O99d46RR4GjYbpoOy+C/bkuhvQaolXS95AUMJjyPLw?=
 =?us-ascii?Q?l5uLy1gM8TeC7WNULhiVKQlBT6md+QuZjihP/zwplUo3fWGfK7KVhBrsTUXD?=
 =?us-ascii?Q?MIXoIAS71fVfH/umkI8Inpe2leNoqW1V+DseP+VZHpbbpkqbxFITeF64xGC8?=
 =?us-ascii?Q?XBepSLmt/LB/mSNEcdVGDIt7mhOkppssumpql0w8lAywLG60NusIvmaeGIIe?=
 =?us-ascii?Q?AiUesgb5dNaLU5rtMml1cVJArFSfxehqGk1SZSinQry957KX8RmT8hGwlHxb?=
 =?us-ascii?Q?t+7Z2UdqmQkMVJ2p8ezOU/vhXohPs3x+YX6ketXxM/pb/LwHmWsgR+sPfASR?=
 =?us-ascii?Q?k96vVKXasxPabYR8+9GVF7ItqnVS4lei032nB/IldvhBFQTFbIShRgXsA0Pe?=
 =?us-ascii?Q?hGBkNgdSniYB2ist6tfjJPR/cwVLZmu0KYsd/oIYuZQT7VVioO9REk0q6llh?=
 =?us-ascii?Q?4uAxZ3t1DgxZJbZI3nIC38s4OXfSj6V4HSuVd9arzMR79wVbAUK15yjIDYP6?=
 =?us-ascii?Q?qE+2wYEWtrDgVtMSsCGk1yaBNluzPYZWr+1pv6DONBD+5IGgsl3us2bDtdzB?=
 =?us-ascii?Q?En8sdR68oOAYBbjdBeqDoGtiQZCuk1By5JJJx/9IKV8VjvpQEHEdpjHprhnz?=
 =?us-ascii?Q?GweVDRDuVCuxUuP6x7K07G0x1m7llhRxHeHtMHH5sumUz59FdclVwnCJPpea?=
 =?us-ascii?Q?i8+lEQgg5rb8K776eAsLkRC5FRmpOdCb8gqMSPNAklK+CPT/zyrzc8ofIxRC?=
 =?us-ascii?Q?JGlfOywBn9pdFpdlcg0JFzEc4cJkr2Sw8uTEIa7hSRMMhS/WTJmnj24oSE5b?=
 =?us-ascii?Q?q9MfyV09YfKczAs9FF0x7lpoXlOxxeUPFg2mAQocusIcgWkjWVFHJlbBoRF8?=
 =?us-ascii?Q?mEugCI1Fy2X3P4btIE+NjfXfB3CUZiTkOBgl+8KRkfO6SGpezfy9YHvitege?=
 =?us-ascii?Q?rclSwQ5999AN8qBzlE1EcSU0/lrEpzlzdYOdNpk1TrKpsNoVozMaed42MiDI?=
 =?us-ascii?Q?OyfaDZEmpN1pRSp9kh/6UNlAewh3tTo0lEmhRqBmAHP4QnpTHlo82hLPtCDN?=
 =?us-ascii?Q?6wXTFqRaVTN0+RMQKHjUNascqH2BJbFBCDmEfneZPt9NlG0d6AtfdTDaGDW0?=
 =?us-ascii?Q?m0mPzXjpDzIbFikJGF65TFgzy7pRxPPYiJ6OhQZKhq8z0g6G4J8ePr+lszF8?=
 =?us-ascii?Q?5N2o2B63/S1CFeLGAwq2rAYQgOls5RFt4pVrTMcx45fITiS/OUQtkk9Y1laP?=
 =?us-ascii?Q?CHYZCDbr5VK3bvklAvrZrPpHpGg3M+oxgFj52KT7qSlIVpNyshmXx44cOGhK?=
 =?us-ascii?Q?SPb7wX2szOnw0tDvb0YFjBlFoiNV5Hud+5ekXesPdxWyMo92GOqFuoS7EiDN?=
 =?us-ascii?Q?6ZYsisb8zMHBinkbzjcLAXPJ7cH/gEOvpuCMzowERmIlfyabv/gGkervpind?=
 =?us-ascii?Q?iOq38mpH5wM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6l7BcTUwsr+qrSFUDIZVA10198MvL1y8ZUJf+Qs9W3xSCiiiieT0pHocRSoa?=
 =?us-ascii?Q?hUB4MDhkSaf/cKlQEUuQTl8lwV28uCdJL8P+OUfsQYEllypqPUguCwqvtZWT?=
 =?us-ascii?Q?qTLN+G9YOoP2CTLy9Azqe31ayJRINZ+J6FZIN+ZkV1RuPxFMNdk0NHTbCWs9?=
 =?us-ascii?Q?UYBsZVde4DGC3Y1IPdSHkAOikWdogxlYw4JXObmzkLNFs+ZjaDdoVP5oFRl9?=
 =?us-ascii?Q?+slr67qQFC7pGM+Hw7FRldSBqEF8ILb7nqOk+LVm7yyKbbjx2aFKGquWukXz?=
 =?us-ascii?Q?+GmWQtILCZkqB6cLpzB+1uxOyjLXIRODmveScXUM6t3bMdYNmfYO8nKYxzy0?=
 =?us-ascii?Q?TJkjYlM81OFtICkZKoUfP2ywTj5H7dUmFbCqWgU2jDubPqKmK+QFP9idDpmz?=
 =?us-ascii?Q?enwFV9a91Hm5ta2V8JNpRNGF71voZ/B+FFUCLeKZXaWbfocRaX5aU+KWhS+9?=
 =?us-ascii?Q?v8hbPgICyEUTxZIALHQZZyIlX760+2KEBLxgPE2cKOZEAZAKdyWqGPl8A9v8?=
 =?us-ascii?Q?ErEOG7hY+lry8TbViHq6uqlYGbuwCr1Rw+0jb3FNmYpXuckPKbD6/lW6aZS7?=
 =?us-ascii?Q?/tLZau4tmUR69J0My9kEfTqic/vBIkJREjL328wgOW6AVga/xyNG6+8d55zM?=
 =?us-ascii?Q?3VHvV/Q5bRLF1nlipa5V+12hDWrLFwvI2CKDc6K+77pdn+PubE5Jd6mqZe00?=
 =?us-ascii?Q?N+MgQwZnlT3ghgKvZYcIWPTTRxoL95ag2wCizs9cGxX3LINMgoHPV/wjC6E1?=
 =?us-ascii?Q?z19ObfxNQgtKBHr4kciGC3LlpbTQmsxA4gbduiwymsZufZJQmRTCn/srUOIB?=
 =?us-ascii?Q?fnYPA8OsTsiR3VacmizLkghjhElEf0wipM6c8lMw1xzspuA90QkdaK4nUwM3?=
 =?us-ascii?Q?1BlnxsURNH1fxArDiyY2h7UylQd5lYmQN3XYeEcDoZeO+oU+r6gUdd6q/gyy?=
 =?us-ascii?Q?s5Jh9MN1I4LtsLFuRsIfoRbP5wavk5RyLaTtMAktRm11XT5Ow+5h0X+jdke0?=
 =?us-ascii?Q?Wm8HW07AS1emvfFIc/J7T3fg/UStHTjyu1NwnXvaJF1sE0SZDJWry7TJT3PW?=
 =?us-ascii?Q?KSa1MombBVbAocR9lUrIBsDl0lRBhlJkkiGCvPRqaeHVYDkg35nxi/6tKNp4?=
 =?us-ascii?Q?fsTDXwL5YcgM0LgqGSVXkZ9k77lyvpV3r6BZC5o3tyKyGyrOE5GwpLT/laTS?=
 =?us-ascii?Q?5A72YN0lPxuePdC7u5A+PQF1fQ8KkmrV3OPiRYuO1xJpHM46I2hGGZXCUFcJ?=
 =?us-ascii?Q?oYe2lswgrAjkpwJll9BrTpwXiiwVdaZdvYfTNMRqS1kP5cTXwWVDT8FQ5lJd?=
 =?us-ascii?Q?Pc1GD0WmzghM4bz4aoUhx1yRmQJd4YSFtU3Xlmzf8tr0lfiQl1peP1WyxP4o?=
 =?us-ascii?Q?JCYOrTKaW52CyDByiUVR3Ctp6SgOcD/Cgw070p8li+vGDpM4l26ZFUY8hx+4?=
 =?us-ascii?Q?HCLcz+M5pSbbp8AMHgAVY112YWw3sQPlsDhpzGn6vdiux56HJc4iqcOz4WdX?=
 =?us-ascii?Q?atDb4PkYDE0OTx7NTo03JrnCY/4hvnahaNOpzjrmqn5Hhzlep83543ZE8/uf?=
 =?us-ascii?Q?OGeATK3HTlxl6S1NK3zzyDeFpLgMkdKgT+LU1rfCtElrymEMPea83afc3lfh?=
 =?us-ascii?Q?Y9yseH9JBpEY9N6MSmO1W78=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684c163d-99da-4488-44cf-08ddd2f5cc80
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:29.7909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+TnDEAL7MGKZlYvidjaWxi4BSPiTgI7mN7xK45lGitlNmjASaNJ+wUWOQzTtiQb+i+lfE37UiJd2srFx+/P6Ev9NkIh4bHDm0/GKTdMiTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

From: Tingting Meng <tingting.meng@altera.com>

Add platform related files for new platform Agilex7 M-series.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/include/mach/misc.h |   3 +-
 arch/arm/mach-socfpga/spl_agilex7m.c      | 106 ++++++++++++++++++++++
 board/intel/agilex7m-socdk/MAINTAINERS    |   1 +
 board/intel/agilex7m-socdk/socfpga.c      |  12 +++
 4 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-socfpga/spl_agilex7m.c
 create mode 100644 board/intel/agilex7m-socdk/socfpga.c

diff --git a/arch/arm/mach-socfpga/include/mach/misc.h b/arch/arm/mach-socfpga/include/mach/misc.h
index b200c877d43..0b80e952131 100644
--- a/arch/arm/mach-socfpga/include/mach/misc.h
+++ b/arch/arm/mach-socfpga/include/mach/misc.h
@@ -41,7 +41,8 @@ void socfpga_sdram_remap_zero(void);
 #endif
 
 #if defined(CONFIG_TARGET_SOCFPGA_STRATIX10) || \
-	defined(CONFIG_TARGET_SOCFPGA_AGILEX)
+	defined(CONFIG_TARGET_SOCFPGA_AGILEX) || \
+	defined(CONFIG_TARGET_SOCFPGA_AGILEX7M)
 int is_fpga_config_ready(void);
 #endif
 
diff --git a/arch/arm/mach-socfpga/spl_agilex7m.c b/arch/arm/mach-socfpga/spl_agilex7m.c
new file mode 100644
index 00000000000..90065ccee6f
--- /dev/null
+++ b/arch/arm/mach-socfpga/spl_agilex7m.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <hang.h>
+#include <image.h>
+#include <init.h>
+#include <log.h>
+#include <spl.h>
+#include <wdt.h>
+#include <asm/arch/clock_manager.h>
+#include <asm/arch/firewall.h>
+#include <asm/arch/mailbox_s10.h>
+#include <asm/arch/misc.h>
+#include <asm/arch/reset_manager.h>
+#include <asm/arch/system_manager.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/u-boot.h>
+#include <asm/utils.h>
+#include <dm/uclass.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+	struct udevice *dev;
+
+	/* Enable Async */
+	asm volatile("msr daifclr, #4");
+
+#ifdef CONFIG_XPL_BUILD
+	spl_save_restore_data();
+#endif
+
+	ret = spl_early_init();
+	if (ret)
+		hang();
+
+	socfpga_get_sys_mgr_addr();
+	socfpga_get_managers_addr();
+
+	/* Ensure watchdog is paused when debugging is happening */
+	writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,
+	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_WDDBG);
+
+	/* ensure all processors are not released prior Linux boot */
+	writeq(0, CPU_RELEASE_ADDR);
+
+	timer_init();
+
+	mbox_init();
+
+	mbox_hps_stage_notify(HPS_EXECUTION_STATE_FSBL);
+
+	sysmgr_pinmux_init();
+
+	ret = uclass_get_device(UCLASS_CLK, 0, &dev);
+	if (ret) {
+		debug("Clock init failed: %d\n", ret);
+		hang();
+	}
+
+	/*
+	 * Enable watchdog as early as possible before initializing other
+	 * component. Watchdog need to be enabled after clock driver because
+	 * it will retrieve the clock frequency from clock driver.
+	 */
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
+	preloader_console_init();
+	print_reset_info();
+	cm_print_clock_quick_summary();
+
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-system-mgr-firewall", &dev);
+	if (ret) {
+		printf("System manager firewall configuration failed: %d\n", ret);
+		hang();
+	}
+
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-l3interconnect-firewall", &dev);
+	if (ret) {
+		printf("L3 interconnect firewall configuration failed: %d\n", ret);
+		hang();
+	}
+
+	ret = uclass_get_device(UCLASS_CACHE, 0, &dev);
+	if (ret) {
+		debug("CCU init failed: %d\n", ret);
+		hang();
+	}
+
+	if (IS_ENABLED(CONFIG_SPL_ALTERA_SDRAM)) {
+		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+		if (ret) {
+			debug("DRAM init failed: %d\n", ret);
+			hang();
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_CADENCE_QSPI))
+		mbox_qspi_open();
+}
diff --git a/board/intel/agilex7m-socdk/MAINTAINERS b/board/intel/agilex7m-socdk/MAINTAINERS
index d69e614a0be..9a5b80ae4df 100644
--- a/board/intel/agilex7m-socdk/MAINTAINERS
+++ b/board/intel/agilex7m-socdk/MAINTAINERS
@@ -4,6 +4,7 @@ M:	Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
 S:	Maintained
 F:	arch/arm/dts/socfpga_soc64_u-boot.dtsi
 F:	arch/arm/dts/socfpga_agilex7m*
+F:	arch/arm/mach-socfpga/spl_agilex7m.c
 F:	board/intel/agilex7m-socdk/
 F:	include/configs/socfpga_agilex7m_socdk.h
 F:	configs/socfpga_agilex7m_sdmmc_defconfig
diff --git a/board/intel/agilex7m-socdk/socfpga.c b/board/intel/agilex7m-socdk/socfpga.c
new file mode 100644
index 00000000000..60c8704b391
--- /dev/null
+++ b/board/intel/agilex7m-socdk/socfpga.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <asm/arch/misc.h>
+
+int board_early_init_f(void)
+{
+	socfpga_get_sys_mgr_addr();
+	return 0;
+}
-- 
2.35.3

