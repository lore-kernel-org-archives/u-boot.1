Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225A9CD4F3D
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 01:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 043278467A;
	Mon, 18 May 2026 03:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="q/7FxkAv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B6083AA9; Mon, 18 May 2026 03:13:17 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6412D8467A
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 03:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQ7nmKWLQk/qvXRqjaoM+REIAVsnfUg5wyLQSrkjRZWj+VjetDYtLr4JITFPjV5Zj6+bh7nwjCPHNDQ7TfWMWCKSAylBWybiP5bf1VLv2RCY87XUy+MLYFmT0wCjlb6rm7vkKvIB3KTEx+D2vC9tg2QVrnFNffuyT43LkKgmiWHDkZWe0LF9BqTmzAOUnTeRIjERs5GxQLJnl63IIMt9+I/At2N0DpKzahhvs/+eE3YiWhvF8FGsnqLNfvDBJRYZ8WH8hmCZFUcVli0ETws8D/jGgCmQ2oeyipssStvjIVr+9kMx8Sjsdg3IG7Ec0MATEGSr8ONqse/dKX9D+h8hsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvVdAzIfmrHCV6KU9xCnLS/dtPMAP2+zaQsmcguQYew=;
 b=wDvpohwfNFOCvOqpXOwSRug34TUtyVFBI3IAH6h32EOEeX/AWsHk/57HJuevTw0oswR+p5PsTFUnUto3S3Dl6QjaMRV0DhJO4z5dKF3F1boFysgeSPb+wLLmRAw/L7Vjv75N6t+AbAHeaxftOli4EeT0ZMpTW3TtteVyqtW8QRLtQwNMZH57VwacimunNw3/0txlPN/v8AzxLvwNJBPdyOnzfAL2YyAUfcQAh/t+LnPN7MIFIiZk+yZBr5crJbdf6/75CPvAG/3caaWNKbdH317om+eBSM0Kn0nRiwmSW6oH7XXSW8F7tjOxv84lpqMlE+w5OVzB4oIu1CYoxwO6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvVdAzIfmrHCV6KU9xCnLS/dtPMAP2+zaQsmcguQYew=;
 b=q/7FxkAv1jYczq9A2NK7ot/t4Rm+Xi6L4AOsmFjiP3TYF2uMkK8FqlaEcatx8N0rS5042RSbrjzsVUnmrXFua+rIWt3L7A0qaTRWYzUGfPoBhXPS0/DvFp/fpuoh5cXb/nl5dOFVemzwGt78sVDavz+Q1CoPMm5vjAsl9uV0WFEjG16iif1tUqhNBNouXl60U+Pt8lnzJFmEKKe//8jxjV2IthSkG5Q91DQFkDy7x936gIn6HpZqV6WjnikMtttB8HEVG6et/QaCXiYCAsvY3a7ogKOMKKGIau1jvZ5tZpxYXStVDxgRFzBUHjaMFhwyz3ItV2XvNTHwD6Yx2RigBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BLAPR03MB5556.namprd03.prod.outlook.com (2603:10b6:208:297::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 01:13:13 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 01:13:13 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v3 4/9] arm: socfpga: Update Stratix10 SPL data save and
 restore implementation
Date: Mon, 18 May 2026 09:12:40 +0800
Message-ID: <20260518011245.19083-5-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
References: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|BLAPR03MB5556:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc77fcd-6cc8-479b-b7df-08deb47aa1cb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003|11063799003|55112099003;
X-Microsoft-Antispam-Message-Info: Y3cEtVAvzGRxxyQTMTGJWHVbbMllADb9MgNSNjUHg8ZRH10Od9SJIgPUmGjt1UfwaQ9CE4oAyIkLZdvCTkvAzCZUwgcgpoE9uiCIZ8bbcJ9iCPUiEGP3AvqSFJ1fEE1g8XsQX29TZyhGzRZcuQgze+k0ZnU0fdRVhhpXjkJRvlO5+WcGqfwx1itaEc9pBU9OSnjyWT0VHhg5KKEXsKmcdo9USaAUQVzEOgXFMCwiL8mhFR5gsLxypfWljX9sIl+oBYedoIknqzrltYd9nBboR439Yl5J+3t7csSrfhoEz0ErhNwRRLQnPugZA5K9Gzf9UbOlqZdHI66iosiHGG3f7hHLS5WJvuiNUi4aYWeqWOYKCYRh2U3SLoC3NM3kVhRWX07RwXE2PKmTD1oB7lPGaGezZifddfm/cXtdEKK0K4J+hn2WfltHy6B2MwP8Lj4ZB8N+u/s61f2FCBD2I+qBxhfWN8rLr+pTAtTIFDuAfL3dd9YciSfWlQ8D6GulpcFFzDy7BohUKqOwXQvGROliD4UkKaAh0eay5YXa8QlRk6Y6Xvg9O26Dv4gHcCENQwAWJ4tC06EjcUxMSWD+Odm/UFMmN3jhMb3e+dQcRyPJ39Slx3N7ALVUg4TVScDrTAs9fVEPpYuiYmlFoEBXYK+b6htuSYti0e4UnctOIUfDT7byvfUSACd/aLPoyCNJ2b+e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003)(11063799003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gHGvw/WEhi0D2cVirmyjtJbNi3RevbE7JYz94Bc3gRpSErrQcb6URc6kU0Ex?=
 =?us-ascii?Q?AV5/zjRv+Z6KTLgFnGnCpOAZuGd7b7QyTKg3ihI8hvVqbMYPTQ2l4SDZICRP?=
 =?us-ascii?Q?Ed4QPhY3q0ruK8OrwUBSR0AcuVS1HVQiFdHM6bYoH+tKaHspWzjD3OvGwHnh?=
 =?us-ascii?Q?Mp8MkBWvEr/zN8ALaMDBlM83V1A01+g9f3US4omaBN6By1iycdoNaPT/T6Md?=
 =?us-ascii?Q?Q1tiTi0VDQiFmTnNFeiNaxf1/biAg+6Iyq4OKbVBpZZ3SldKWW4+8zW20MCi?=
 =?us-ascii?Q?pEpcEYWUb3hV4EJrTvQFucpdgBrvWs079JcJIJKAsC0QJW9ECzc8n1yO9UhM?=
 =?us-ascii?Q?KQ58EXBeOUbF6GC06gv8zzXYCWwsQCAUVp1/yXdC2+x60u8M9E2Nkh/PgGPD?=
 =?us-ascii?Q?0N4P74tTVmEuZcdvdEVbEALXo7/e/SYSqAz1/IBCMsqgalsYPBup/Zbok76o?=
 =?us-ascii?Q?mKJXHQSVByZGxrbvDFLJb9CsHGrIU2mouNAnsr8IhEThY3AVIVeOC4WZ4B6v?=
 =?us-ascii?Q?mUVqQV0w33OwuEZdt7bEqhhCTTrejDJVAmjUjXza77DjM3LtRNK3qGqJEjZW?=
 =?us-ascii?Q?oBlghqRC7zjKFOdZ63110zfhBoIhkDBDOP/zFLyVfI+u7EXz4qgwCxhy8PJj?=
 =?us-ascii?Q?7z0KzrcbfxivshIVri4z7Japy+gQX8V+GR4h/QeLsCTVl+bfbMBT9sjdJriP?=
 =?us-ascii?Q?+zASqdWkCSbfc+Zlfyb6nWY40K9yvLE4Dib0obtfaSrSSkGfgInZzyCWCf2r?=
 =?us-ascii?Q?r8ndMhtQ9CG6cnkjXc0S0LBMWxMAnYe7nu7fTZQTvV302PUGSPMVVZE6y+My?=
 =?us-ascii?Q?W3YchykSRMcO8alg1wFzc77fyOxLBLGJOZN9fH0ux/vbMrX1QmjzjkiI8xsH?=
 =?us-ascii?Q?ipiHG7hfr9d71HR8Fo/Ug9Eqz2KQ/BWIhudS6EXtrJoXg1SuckCh8D1Mk8NI?=
 =?us-ascii?Q?Il9lst4da58pHSkHJHhy8zUU67kZkqefximbbLxF8uvxyBr5taPcaA9szBkd?=
 =?us-ascii?Q?j/eCpQ+ztlp6M9KHG01fv0D1IUWR4gTrhe5InYdKUOS2XDGCKB2kmS3jrpVK?=
 =?us-ascii?Q?XDw2k5diaZNQSZP8voY7+kPS8eGopkoJEZhVRs0Ph9QxnyW8u1wW6am+bhsB?=
 =?us-ascii?Q?fOR/FpSu/l00JdLb2vwO9HqErUvLB8Mji2/WdWwJx5J6UaAkWYTVX3NVEbJz?=
 =?us-ascii?Q?GYuWspYNcx1/xWKxWDz0a7lx/hrgXvCg7oqmPIkReRVdT1WWTBjAss5ay3nD?=
 =?us-ascii?Q?+7zqXdrjysOAOKb4zT2chSMkdRVHkAte+or8VamYfJUeaxY96egiq0vwoZJz?=
 =?us-ascii?Q?o2x3WyXmWdCJ0ZvTp89O40y7oYY+Nl4YxtU5GOXe+KY3f4GI6yJq3k0U69jR?=
 =?us-ascii?Q?INZn7xhR5XEgeeukEnL/HdoaqdxMGnWa560XHdjLNz9QzizHLJ7MUedQjg+l?=
 =?us-ascii?Q?0FHY7audVO0Sde4XQ+IAHNCwYFbEEakdrgInjooHIZ0scbw/YPjipp3JIF4m?=
 =?us-ascii?Q?BL/iJ2y9+Jpo+Z+HEpfnEC7ROzgUH0hCzQqy1IGNA/QCz3TVrP0wBlcC4MAS?=
 =?us-ascii?Q?bUwZFJoy9TjU7k75wNsdojicmmfQHgoLAstBqgQC85C7ivab+qplXUuiaLIP?=
 =?us-ascii?Q?FeMdxaZT2bOcAcqkP1VDBlx2avosekzNpQ23+Vz4IncR+rBhGci9Wuip3WCV?=
 =?us-ascii?Q?GOpXWXoXOnav6vP2hPhlQgm2hLNM6HitFBkzLwQlzw6un5vtjZM1M3GXwP1y?=
 =?us-ascii?Q?gVU9B+0r8uDOa++Q0iT/xjxAFDQDJJw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc77fcd-6cc8-479b-b7df-08deb47aa1cb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 01:13:12.9380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Lz08Y9vazjsa4gc8XogrR8VZ+cAk7LSfd0TlbcnxGNf7jbGxZEO0BeGnDVj62aAZJiYBhjF3ATN3siSWALdsyA772n1AvVKFjEyebz/jG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5556
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Enable backup for data section to support warm reset in Stratix10 SPL as
no SPL image would be reloaded in warm reset.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

(no changes since v1)

 arch/arm/mach-socfpga/spl_s10.c     | 17 +++++++++++++++++
 configs/socfpga_stratix10_defconfig |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index 8ab80740c6e..ce1d5d4c8ff 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -21,12 +21,29 @@
 #include <watchdog.h>
 #include <dm/uclass.h>
 
+u32 reset_flag(void)
+{
+	/* Check rstmgr.stat for warm reset status */
+	u32 status = readl(SOCFPGA_RSTMGR_ADDRESS);
+
+	/* Check whether any L4 watchdogs or SDM had triggered warm reset */
+	u32 warm_reset_mask = RSTMGR_L4WD_MPU_WARMRESET_MASK;
+
+	if (status & warm_reset_mask)
+		return 0;
+
+	return 1;
+}
+
 void board_init_f(ulong dummy)
 {
 	const struct cm_config *cm_default_cfg = cm_get_default_config();
 	int ret;
 	struct udevice *dev;
 
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
+		spl_save_restore_data();
+
 	ret = spl_early_init();
 	if (ret)
 		hang();
diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
index 82f0cceafb4..be0c452ead0 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -3,7 +3,6 @@ CONFIG_COUNTER_FREQUENCY=400000000
 CONFIG_ARCH_SOCFPGA=y
 CONFIG_TEXT_BASE=0x200000
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_MODE=0x2003
@@ -19,6 +18,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x100000
 CONFIG_TARGET_SOCFPGA_STRATIX10_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_stratix10"
 CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
 CONFIG_FIT=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
-- 
2.43.7

