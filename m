Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467A6CD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0511848BC;
	Mon,  8 Jun 2026 09:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ce7XunLV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF3083FEC; Mon,  8 Jun 2026 03:28:42 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 196E08405A
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 03:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dlt13/LKVOnDX2swpGgulF+EIIxOcVqaR77O8KnylwVFu9cScurnw/CVoAR3DfbfZiPzKA4lbm8VAWL80b9ln7PCv4Mcp0ji5LQbEfPjh4/9sVf/pf87535Atsy7vbBZFPg8VNjNZR0hZJMi41qR3dfOsL3RjNoy6GEhifYItG6lbBvZ6El8ioWRvP2IGcxLoUFKSy7OkYa10CsrMOb9QDZPQIuVEsxXSHkd1MLupQRqrpQfkY9zvhc86zyuj+biLaSbU6oR3tqpqUWmEyYfPtKZvtIKGYXWTI9XPIksv7EI0uQ5G9FBgNqtsDXSU5gUiZf+wbQAWQfg+gqC9PyG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4DPKsiCCcN5eiUY+Qr6qPPTBeYi/03SetCsQM4Zm1k=;
 b=aDrue365QBaaF/qmQJEUBpSYuhyK4aXOzNoyCy4IT7g7jvF/RcOXEDIAqTIkbwXE/dPUU9M2k5t4ZDDd5HnoubjMsrVxZd7VnK4KMSOZEM9+OgF4FJQ/NEf0kWeXwpFiAcL+HMOrRvu9cvx0BKxXJR6pm+Wk0Q7iJ5kFTZRirJaHmoKhhW6TtI0gMBlIj4T/iopHX7o96B8WjXWV2ISHGkBjt4XJy1b+42AXw4P6W9PGJ3gkpIqEhp3muicP9CKyh5qoOBoy3LDnTfYP4XMo2J/KkmhR89X7ynhqs5m2++VXMUFnXkKQCrILd2BXRY28SnRpcqAD39wt95kS5DDcuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4DPKsiCCcN5eiUY+Qr6qPPTBeYi/03SetCsQM4Zm1k=;
 b=ce7XunLVsPCdnj+sOf3HCcZ1D9DbbLFgZ42YfyFeddfjDKZ9Hf8CExUCciyiz/TYevzDx0N6+4r/nGwK3O1ACr2rodNYi5xJ5z+kVVdzmwAije0dJSGavfB4geEmkF06oCsyEt3klgqT+xzjvSd3zNHbkLg1kI6CoeU6/Um9lvlm5Yycuf820Pc1WPgWgXjQDGkA88bNObzT6zq6Fd0IVa6xOluzf7NBW5qO4O+S5MJ5M8p9bY5t6q9YOkieUTv24aaiCeWr9NOLgWfZRskExXjxauWi2uomYtpYdEA4xrEqfzOUT4rVwWcjDJVI66wtSbU9Aq0CPjCm8AKxpHaWdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SJ0PR03MB5807.namprd03.prod.outlook.com (2603:10b6:a03:2ad::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 01:28:37 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 01:28:37 +0000
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
Subject: [PATCH v3 7/7] arm: socfpga: n5x: update SPL data save and restore
 implementation
Date: Mon,  8 Jun 2026 09:27:41 +0800
Message-ID: <20260608012741.23760-8-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260608012741.23760-1-chen.huei.lok@altera.com>
References: <20260608012741.23760-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SJ0PR03MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce35618-780f-4995-e155-08dec4fd43ab
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MLipymGAZFkiy7PQWzvyV/9IxQ3C0DDCTzU6VPLVN/3/NBjZfI0ykeTm2u4FyY6FmM54QkZ9/pbvAjS//Jn75/qtV6CHQ/ZNAm8KFoK5pLBB/VXuZBHCtv8dD6gJAKOEvLbGODqKpwhee0QdFFEfCJtd63n0/j95wHdL4DTcpnRmHh1q+y0pXfQ8IQZxkNPz0l0hT0Ajr3GJ7w3juDFs444++7Ph84l6bckG/RsFkD2j762SYASDnWo/Tm8XdOfTgu5FG8+yUeVCDuI0d+pJhI77798A3Kd7Fn0lIXsfXILFPioPprFyRkfrz5sahdp6LWojiR0+MVSoaHIBEOGs+mG9TVHHBy/GnDGWLXRwLSZ+SIviapKJy1PXE1Ag6WMtzzHH5YDoUEVh1jKbYt+EXSQUWUTgeEvgSYbnf9hamQFSvCEq8376tb1cp+kzblij93cAJpBlKrgr9PitbNmrSNDJfxNl094SHq1SYOixFMatE0888vJTkEhXpLs+ONTIeP1WkOK/xr5guzy4IX0d4r3rTSpMiSJ/uVj9v6F14ULtZD8etAhiPXjRxZJXoSTs5uGpzdT4EGsZptvO8TbAFcT41zlEX2K2sBlkTmwOEt2MjHTTSRsErqzJnitpMlqxW3vut+Zx3AzFo3FD7rsMI3RGr4Jdvl8ZDwoF/J6ZB+kmTrEiIjd46L9pKV4XtyLQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MG5+YAxJX/MgFJCQEo+Cbl9Tfx8UbfmXPMMR6k0HpphZwY82mx3a8A0QSH9R?=
 =?us-ascii?Q?7fLPpAmVlt+pJyWldio7Igscp5FY7y70hUkRsK7qMcAksN8uhUenMNupkNOk?=
 =?us-ascii?Q?N5LZXPFNUd7RpRuOnqrKrHszaMl2/sNAJmKExPfPeXb94tDK4YMft+SdFeoB?=
 =?us-ascii?Q?78KEWOaM6K75C0hd86dgmV69XlAt5KfqcmE9mjaxRNgwAJr8386qwGFub2Eb?=
 =?us-ascii?Q?VN/QAFYCzuXMM8V/GUQ43QFht1AQCK6bL+bgwbTwRn1JQc/XZYtfXyEF8hOU?=
 =?us-ascii?Q?r3DWn1cdI33eGqVNqOhf+GmyzyPpjzClqrPPFbySA498O4I2nKDL5Nkf1Pso?=
 =?us-ascii?Q?Z3zdXDL5X6TmphVxF/hJjbtVjZ+clYwgOKhVqCJ6bwMGLOg/xGKAWf2buL8K?=
 =?us-ascii?Q?RiiTITAUl6hG2YibmEYjUbAHSNc2Cz4jEgGlmrPBJGp94zHtUVX40h1fxvY2?=
 =?us-ascii?Q?XtsPAA13eM5i+NN8Hdbvufjd+1bIv0PaRHOINPbbZAe9gDZmCvHrbkgsGmvi?=
 =?us-ascii?Q?Xd2Bu7Ya8I26CDUXJEmz6pzx1And98MAW66v+FZ8Av0nerEo0ClYW/G1r9Og?=
 =?us-ascii?Q?Bmd3de3ZbfSu0tHZFkM+QALXDYEiyJnItlB1vPaTycODmuopTafjk50nUyGn?=
 =?us-ascii?Q?K1pO/GD6S1xv2wfJ+iaSuZRcB2RuNTP7970/VU1ohMiF9wFG3iH3WIzjb4vW?=
 =?us-ascii?Q?q8uf2AieG7/qdKz359Kn7eVpTXLPfdGYRp8ec9LjuhhnuiFINLbhZo1uc0e3?=
 =?us-ascii?Q?EihD+utzcsGL3NkydWDZ3wYU0rAlHT6k/d9WyvE6nhxWZNEfswXZc2wHsoRg?=
 =?us-ascii?Q?MsSWH1Zfjo/guN5/bBhklyAsadeVgB4En5Y71bneDwYcfvdSnaE0IwQnR5bn?=
 =?us-ascii?Q?VhJp+vjLCsRZfrWNZ+/UuICSPGCNSLHUfLPi9CH+ddN4+FEtpsTbu9DwsQ80?=
 =?us-ascii?Q?ZvX3al9h2S2f/LUo0CnyPgQUD8cRsE+ZEsye1EzGsTxq8g8UJ5qaB2jYDQ6D?=
 =?us-ascii?Q?iZkCNCtvcMT+Y+VpdYGdyJxKs6ZHE6l6igovpYCtvJHxtuYYTXJBJPUo/73W?=
 =?us-ascii?Q?66iUR0lFUA1JTfwI6oHJnkc7j9AFDOzohaGPhmkkF39SrMih0uFlabFkPN8d?=
 =?us-ascii?Q?T0f1d7AtTFRy3Ba4hqi2LGhlcDkgCtFxke/AtFTuVWqqXMVFLab9dJOgu3DS?=
 =?us-ascii?Q?6tv43N0VrW0NVmToXcuAm6wwk+fgmb3mMudOWJBi3lze4Me37g0zrwtmFSOT?=
 =?us-ascii?Q?+wLq2ShlYv4AvOHN29Ocu0TjlW5o7doROthATQfl/WIOIC8V8wHG+MQ2ESgY?=
 =?us-ascii?Q?1irqnT6hP7ucuqkwAQaF/pANKVfhwlg35hYv5rchZ9YZIy70WleH/v0Np0xa?=
 =?us-ascii?Q?JsAaXZKHO8cNvRlWNx180GP5AZMmwVtQAQoPeOmQJ5D6MPPjN7H90UM+xF5d?=
 =?us-ascii?Q?pEXDL9L8RCGVQe68BALNA+Xsi27VphXOfUO+tjhbCdgO3lOb2sFpZTpWelMD?=
 =?us-ascii?Q?qcNEymv4u/SBUB7ys5pBRWZxqMG/Nl2rY8WM6UVqTvvFpR7yhfxyhUq8RYI9?=
 =?us-ascii?Q?fMu0DBYmeGUJBzbX1Ewu+QO9okK6pAIOcgH7HCPOj93X7jCDoSTB+26wzEd9?=
 =?us-ascii?Q?/kKaW8uMUjul71hmN09W6/+rr8Z6Zv+2UpyuIpa8057SoppWMeH/Ax3Kcwxd?=
 =?us-ascii?Q?Gt/KM/jLF9+wtwIq4QltbN2/FOAs135j/LdWgY6dEIl9mTLln5+OWKuQ2oE8?=
 =?us-ascii?Q?J7jvOp2Ykg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce35618-780f-4995-e155-08dec4fd43ab
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 01:28:37.7996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +V/TTBpHVwmEQCWjdNzZFDO+uE072AcIUaFKOjfcB0OfqTKdLF42KpeRdzEljG7LKr/WUMab9UcMhew+/7TbEgWa4xdcKIrpq6Y4ElaFMRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5807
X-Mailman-Approved-At: Mon, 08 Jun 2026 09:45:15 +0200
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

Enable backup for data section to support warm reset as no SPL image
would be reloaded in warm reset.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/mach-socfpga/spl_n5x.c | 18 ++++++++++++++++++
 configs/socfpga_n5x_defconfig   |  1 +
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index 0a8dd6d0fee..8b03d047f33 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -18,11 +18,29 @@
 #include <spl.h>
 #include <watchdog.h>
 
+u32 reset_flag(u32 flag)
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
 	int ret;
 	struct udevice *dev;
 
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_RECOVER_DATA_SECTION)
+	spl_save_restore_data();
+#endif
+
 	ret = spl_early_init();
 	if (ret)
 		hang();
diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index d706366337f..8f4723398df 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -21,6 +21,7 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_n5x"
 CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_SPL_FIT_SIGNATURE=y
-- 
2.43.7

