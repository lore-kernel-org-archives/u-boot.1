Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBFDFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75ADF84660;
	Tue, 28 Apr 2026 09:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="iXlFSG7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 319EA8416F; Tue, 28 Apr 2026 08:50:16 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD4CF83A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 08:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7L7HsIphgJMtEKREWuZe7KRbIxa8WWTFd+0zId2CldhvL2+4MGS7Xm+a9kfVRBkkiiu5fjXyGGMg8D2eh1p3KB2aiYHLnLkASNRoZP2Dw1YKcpLQhXUargTfqNj13FFbplo6P31aWbTnUk0JX1X0xfMYYvO3j1Mwe8wK9JxKBC7tm/Ns/rlX8p9oiunzudGbqCEf9n229pk5/WYBeu+0f5OyCb6+5s4/NlUSnnXBbl8Y+HlRXSbwI8emxROkcZi48BBAf8hEp7poP+LKzBqGe6SIPQtcmexvrjgeBNFzQRUfPaoRrD982GFljhnancPEO7X+HEf6yZ9C4Wk9dq6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzB4ru0SZZ/0HUSxbH+dKb9eP1cBq8h1k0gM0wxUhjU=;
 b=jXMEYmPtYY8C7wVLRlDWDeG2BHcnf37JjCWN+rkjUoEDtW1joj1ngK1Wu9/GdvfS06yCX04/PwLKE2gxvKugMQkzRkm+xwsL36Qd36KPM4zWy/3hXSP21hhUl7ZnNmdvQ++xxG4n9Vrc7ba5YN5Xv7SqctBO8COAEN1JuoyyTW10mR/dKXc44E51Zin3+aQcM/vlDI/A5M69WAy8kHPDzMQOUCmdAwGkiwQVcEp16lGlRLF7iSKCS4L4gnKlcEFCI7MhdkWmmEBx46Ewt8QNgTVZYHEcTpYGKYBgS0YysXQZGS6Uo/Ep3mHk1rcWUYpczj827orCkb5MfFocmnjZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzB4ru0SZZ/0HUSxbH+dKb9eP1cBq8h1k0gM0wxUhjU=;
 b=iXlFSG7HZtl0k3/Bpk1VLdSV8lcBkdbH6yqHFtyK2kDxr3Gtd+XlcqGu740Q2GcibvZmA8dhR7fUQ4Gh0f4y8Y5XqeFy90KyZpWTKvEesgAPGFHDTkX/BGB2nGyyiADSnxs4ogXj+kGCZVBb0XSdMv7Qtpx/6ec7eKolqKnhP/+HAh/JhIUq5nskq1Vtu2LC/XG+Hv/k26VBquhd3mbE+ZmGDTbsZujV6khGjg3Yx4thFkEteYMKkfgwbeT95a2xCCiEWUIwP67m6bixz7+4b2vxQRSYYc1N9IY4aeHXelBm+ywvbFST5YUeBd2cq2K8x8s4a5hY+BCWV2yAOckclQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SA1PR03MB6356.namprd03.prod.outlook.com (2603:10b6:806:1b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 06:50:10 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 06:50:10 +0000
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
Subject: [PATCH v2 1/8] configs: socfpga: n5x: replace defconfig with ATF
 variant and simplify VAB
Date: Tue, 28 Apr 2026 14:49:45 +0800
Message-ID: <20260428064952.3965-2-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428064952.3965-1-chen.huei.lok@altera.com>
References: <20260428064952.3965-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SA1PR03MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb51585-8be9-4ccc-78d7-08dea4f26425
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: irqJ7RELkckCjIH4VbWiquzAjzop4v+furyvRyjjuBs+CjCNIcpbhHB21BMDIu9ilvwcrr+7p3Q48tgkBEt3oRHQgKQeXpaRg0vKT3TtjU2iWDioLCv1RIZhlbTNgt6abnwY3GZwSX62eeEKvpDQvRAW7wZp6ylhnInEkNYw7VqKtHAQ1UpSIXELj9Y52LBM5P67q1RRtKFbflNW9HpHH6bPOjQf0B1IR7linlWTAOA6QCtTZTIXbbUOBtaOoVOueIkWOEc6dIg4KqJqx2bAcshBLnrJkxqfcmFFKkaQqanahP8c5yielkgcrb41uJTUjZS1VY7McWa+7aNHBv9xHDsZlygpUNGTo2oMpMDIwgxgOAW6gZJ9SPglNGA9hWBnI4ubNQebH4YW/PdszipQoFNKq8W43a8lq03jtYvLkxTZulSeANuKMMuvsthi0+ajXqNltYKfcBOKbN1bfynbHAF3pIVQUM5thF18CEOZqH2ODhwV9n+4btWwL1ARmjq0gOCUyqffrTD8xxy2YJ6tm97Tz8eYUAjg/SN/SYF+F+Jf6ySppTbrUfUCQjglQmPopfUN1P9cLOQyEwKxQDuckPft9CiU2ItwBKvP9tkcPCKTj4Xsad/7vCb8VZw4I7p8AVz2qqONKEHAIPaRSFB+B7z1Za1BvRv8o3LVhu2BxRysVzCfsPJhUzCO6NKqDlKPpa+a+hrEJHG1nHP2yjM7RsIFwXJkEZkHY41kIpgrsgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PX2tEszM7aqwxVNAtHYz0D35JzI2cgFgCShx1Mq4n2fFNFYw7HxHPuERi7r7?=
 =?us-ascii?Q?ssNQuA2eDGtv3eseaQdZig1/Wo6Yszmlus35ZZ3OXFehT9n6b66Pk5jpRCIj?=
 =?us-ascii?Q?Ik99w1ZGVZlmkeYx2hvruPJhI4gi18volUKgXv54qpXkIKTEsckuvWz38sbt?=
 =?us-ascii?Q?rrWQxF3XzDtK5+iNXAk/5XcK0xchaxa021AcdrFcGzhjFeo6xQDPEtHPkPdr?=
 =?us-ascii?Q?bNxqTc6v5/CvQtr1nOQhxPM9CiQRIdm0SEERd795xZ5TfNJbgp64z/+O/WbB?=
 =?us-ascii?Q?cA7V96T1OksV11QBHRWnzqp9/sgdLjuJ19ZGF9zjZKS628e0Y6T6NFOqQuDb?=
 =?us-ascii?Q?j6HjRJo2uPKACJO6ccAeKTuchDy/FwzqK4bzBnaN0TryWFy3+XqkUhMadmfO?=
 =?us-ascii?Q?76mA2nWs3VmR2b4fhJB7cL4Qa+e7SdjBI+YFLUXDsjSWxPChiqQdY7NBTu69?=
 =?us-ascii?Q?a5M8JJFrJs2tuSxmYUvDfWUg3LBjoP2I0He+NvnlBUoscrFPyz74Zl7sCkhz?=
 =?us-ascii?Q?mZOAse7noJVmS2OkZjxViXURWUPgYebeb6I2U2fnE1gz0FC92KZQ70N25AFq?=
 =?us-ascii?Q?Y5kZ4BtkoY1sLNoOZK8Ii6+5OF0WjkZxg0u2v12TzZSnYPuJqBuP9eUaSgPX?=
 =?us-ascii?Q?irp5kKWl3Ex9LJQUJxntHcUISSPhMl4u2o1BxK99UcZNADnoONlTSpPxoT9s?=
 =?us-ascii?Q?BR1ubrMrZXVmyA7AhGLUWxu1YrOfSeRjqyOMrIOQK2ZazHA+ZxICFT9bpgnI?=
 =?us-ascii?Q?4hf445QgQecFbfaR+UsWvTTqjhG3FOLCh4aU6qn7qzariP90Uu1b0P4hqlIz?=
 =?us-ascii?Q?YieKPODAIAoE7XV8r1m+sXZDvP0HlS0CWNAZl4rB+mykcIYRUrgTRuRc5o4V?=
 =?us-ascii?Q?4nO46N95NG3AnRuEkQoc9h58XOJEBZzC+deWvcjOjD9KeCnf3AAr4GtXtZkE?=
 =?us-ascii?Q?UMwlFOqdBjFbHl5qhGdpOfn8nkLcVaEXFqgRTb++trltrrXbxB4EQI92nypL?=
 =?us-ascii?Q?doB5KPs7Qa9dwwhCN0uQm0Nfasgdgm5fdflzynvbVHiioePJ9J2WPyXZy3mf?=
 =?us-ascii?Q?E+MH9M5jk59xty0qfYJVSZHh/E0XW2hybjoMkIjkOCoD0yVCUbx9yrkv2WN+?=
 =?us-ascii?Q?+BidrWVjGUt7OUvEGG4kAjmiP2Hz6oyPxd/xGGvTFAbOntfL3fiNpsARe270?=
 =?us-ascii?Q?s4aiDUWL4lyD3NwmdZCMU3FE0JhZDFIW5AgMmbkNKH+Js5ILTsWw4hH6pGpr?=
 =?us-ascii?Q?08dqAdqkkQsJ3Z8r09CJeY+NkCxjvZkGeeQKuMtC1Iv48C4H7RccDUlt2i1z?=
 =?us-ascii?Q?Z1ujAw/s8kdngnnXU/mMgTcbMKoIhKlsaz/wmtekRW/5uLzu6PgPVi1sFcfk?=
 =?us-ascii?Q?TQGRCWx06OCn9+GDNXbfH07+iVH7KjzzpWOTdYVkgdgB2jtvQyRkuQLRWGi6?=
 =?us-ascii?Q?6GQ9jYlVGC/QmOJhbYmjLhWiALEA7p8DhRJYkHSsEEhnCgeK1WlxR84bhUad?=
 =?us-ascii?Q?cB+0t8ZfjU6sequb5BhMeD+AT6lTD1cWeImC4FZx5NlKY6+UMsP5uPDki0xq?=
 =?us-ascii?Q?SkRMjn+e1yEMpzvB8tDAQCN9Zd1QSivsLYF7YHayLitq7O4dkZqlIg+7sMjQ?=
 =?us-ascii?Q?g+lyNOSSzlzjpLlnVxCl/G+qRNyt9uUy9cVVaAu/sU39gafDRZnAfntJOpq4?=
 =?us-ascii?Q?Ujma+bT9a+B0iCVRAp3dJ7AB0WHBdx/o8IZDjtuP7+9OPHHVu5/GeKLQRkNp?=
 =?us-ascii?Q?sPzUCrT7AIyIGkJYMskwLPxOyfHVQng=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb51585-8be9-4ccc-78d7-08dea4f26425
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:50:10.6674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qq57dWpS/qVhi9kxoQgx2ykuVIwPMsuD1O5FnifJXwBAOdUFaVoKjV9+Szw793L7yL/cnB2H4se/zK/U1EzyiqcdLroBIOa2KHZlPMC1MPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6356
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

Replace socfpga_n5x_defconfig with the configuration from
socfpga_n5x_atf_defconfig and remove the latter, making the
ATF-based configuration the default for N5X.

Add # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set to disable raw image
support in SPL.

Add # CONFIG_TOOLS_MKEFICAPSULE is not set to disable building the
mkeficapsule tool and prevent build errors on hosts without GnuTLS.

Also update socfpga_n5x_vab_defconfig to align with the new ATF-based
socfpga_n5x_defconfig baseline. CONFIG_SOCFPGA_SECURE_VAB_AUTH is the
only VAB-variant-specific addition; all other settings are shared with
socfpga_n5x_defconfig.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 configs/socfpga_n5x_atf_defconfig | 89 ------------------------------
 configs/socfpga_n5x_defconfig     | 20 ++++---
 configs/socfpga_n5x_vab_defconfig | 90 +------------------------------
 3 files changed, 14 insertions(+), 185 deletions(-)
 delete mode 100644 configs/socfpga_n5x_atf_defconfig

diff --git a/configs/socfpga_n5x_atf_defconfig b/configs/socfpga_n5x_atf_defconfig
deleted file mode 100644
index bb8f1eb7264..00000000000
--- a/configs/socfpga_n5x_atf_defconfig
+++ /dev/null
@@ -1,89 +0,0 @@
-CONFIG_ARM=y
-CONFIG_COUNTER_FREQUENCY=400000000
-CONFIG_ARCH_SOCFPGA=y
-CONFIG_TEXT_BASE=0x200000
-CONFIG_SYS_MALLOC_LEN=0x500000
-CONFIG_NR_DRAM_BANKS=2
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
-CONFIG_SF_DEFAULT_MODE=0x2003
-CONFIG_ENV_SIZE=0x1000
-CONFIG_ENV_OFFSET=0x200
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="socfpga_n5x_socdk"
-CONFIG_DM_RESET=y
-CONFIG_SPL_STACK=0xffe3f000
-CONFIG_SPL_TEXT_BASE=0xFFE00000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x3ff00000
-CONFIG_SPL_BSS_MAX_SIZE=0x100000
-CONFIG_SYS_BOOTM_LEN=0x2000000
-CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
-CONFIG_IDENT_STRING="socfpga_n5x"
-CONFIG_SPL_FS_FAT=y
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_SPL_FIT_SIGNATURE=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
-CONFIG_BOOTDELAY=5
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="earlycon panic=-1 earlyprintk=ttyS0,115200"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run fatscript; run mmcfitload; run mmcfitboot"
-CONFIG_SYS_PBSIZE=2079
-CONFIG_SPL_MAX_SIZE=0x40000
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
-CONFIG_SPL_CACHE=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
-CONFIG_SPL_ATF=y
-CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
-CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="SOCFPGA_N5X # "
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_WDT=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_DWAPB_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_DW=y
-CONFIG_SYS_MMC_MAX_BLK_COUNT=256
-CONFIG_MMC_DW=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_PHY_MICREL=y
-CONFIG_PHY_MICREL_KSZ90X1=y
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_MII=y
-CONFIG_SYS_NS16550_MEM32=y
-CONFIG_SPI=y
-CONFIG_CADENCE_QSPI=y
-CONFIG_DESIGNWARE_SPI=y
-CONFIG_USB=y
-CONFIG_USB_DWC2=y
-CONFIG_USB_STORAGE=y
-CONFIG_DESIGNWARE_WATCHDOG=y
-CONFIG_WDT=y
-# CONFIG_SPL_USE_TINY_PRINTF is not set
-CONFIG_PANIC_HANG=y
-CONFIG_SPL_CRC32=y
diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index c9fa50b3aa9..aeeaa1636ae 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -1,11 +1,11 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=400000000
 CONFIG_ARCH_SOCFPGA=y
-CONFIG_TEXT_BASE=0x1000
+CONFIG_TEXT_BASE=0x200000
 CONFIG_SYS_MALLOC_LEN=0x500000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x101000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_MODE=0x2003
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x200
@@ -21,15 +21,19 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_n5x"
 CONFIG_SPL_FS_FAT=y
-# CONFIG_PSCI_RESET is not set
 CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
 CONFIG_BOOTDELAY=5
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="earlycon panic=-1 earlyprintk=ttyS0,115200"
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run fatscript; run mmcload; run linux_qspi_enable; run mmcboot"
+CONFIG_BOOTCOMMAND="run fatscript; run mmcfitload; run mmcfitboot"
 CONFIG_SYS_PBSIZE=2079
 CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
@@ -38,7 +42,9 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
 CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x3c00000
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="SOCFPGA_N5X # "
@@ -56,10 +62,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-# CONFIG_CMD_MTDPARTS is not set
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="Image"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DWAPB_GPIO=y
@@ -85,3 +88,4 @@ CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/configs/socfpga_n5x_vab_defconfig b/configs/socfpga_n5x_vab_defconfig
index 78fe42e107c..3fe74846d01 100644
--- a/configs/socfpga_n5x_vab_defconfig
+++ b/configs/socfpga_n5x_vab_defconfig
@@ -1,89 +1,3 @@
-CONFIG_ARM=y
-CONFIG_COUNTER_FREQUENCY=400000000
-CONFIG_ARCH_SOCFPGA=y
-CONFIG_TEXT_BASE=0x200000
-CONFIG_SYS_MALLOC_LEN=0x500000
-CONFIG_NR_DRAM_BANKS=2
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
-CONFIG_SF_DEFAULT_MODE=0x2003
-CONFIG_ENV_SIZE=0x1000
-CONFIG_ENV_OFFSET=0x200
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="socfpga_n5x_socdk"
-CONFIG_DM_RESET=y
-CONFIG_SPL_STACK=0xffe3f000
-CONFIG_SPL_TEXT_BASE=0xFFE00000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x3ff00000
-CONFIG_SPL_BSS_MAX_SIZE=0x100000
+#include <configs/socfpga_n5x_defconfig>
+
 CONFIG_SOCFPGA_SECURE_VAB_AUTH=y
-CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
-CONFIG_IDENT_STRING="socfpga_n5x"
-CONFIG_SPL_FS_FAT=y
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_SPL_FIT_SIGNATURE=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
-CONFIG_BOOTDELAY=5
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="earlycon panic=-1 earlyprintk=ttyS0,115200"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run fatscript; run mmcfitload; run mmcfitboot"
-CONFIG_SYS_PBSIZE=2079
-CONFIG_SPL_MAX_SIZE=0x40000
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
-CONFIG_SPL_CACHE=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
-CONFIG_SPL_ATF=y
-CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
-CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="SOCFPGA_N5X # "
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_WDT=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_DWAPB_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_DW=y
-CONFIG_SYS_MMC_MAX_BLK_COUNT=256
-CONFIG_MMC_DW=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_PHY_MICREL=y
-CONFIG_PHY_MICREL_KSZ90X1=y
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_MII=y
-CONFIG_SYS_NS16550_MEM32=y
-CONFIG_SPI=y
-CONFIG_CADENCE_QSPI=y
-CONFIG_DESIGNWARE_SPI=y
-CONFIG_USB=y
-CONFIG_USB_DWC2=y
-CONFIG_USB_STORAGE=y
-CONFIG_DESIGNWARE_WATCHDOG=y
-CONFIG_WDT=y
-# CONFIG_SPL_USE_TINY_PRINTF is not set
-CONFIG_PANIC_HANG=y
-CONFIG_SPL_CRC32=y
-- 
2.43.7

