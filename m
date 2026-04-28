Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB031FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:39:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E300384683;
	Tue, 28 Apr 2026 09:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nGIsjmvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40D1F83A91; Tue, 28 Apr 2026 09:00:41 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A46C284106
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BC2cPAhLA2R9lYwbgj4dA/5AyVfXfRQrMVDGtYTSM6yxOH1TgrKPkqqiVtiClHFd1YqUWmlnmdbf5eNU2uRvZP41bVdwIRswHmczfNnRIUkcBYJeBWsyabH+/p730pM4Wqu2oqSyP8zjAD7Q+5w7IyIwr69he387goR/QOlK26JX9zWpZAwRKDGUN1qqipPauYwZnsygnkwqs0W1A0XQ/wiEmWtCRlX/YoA7OYEDFOA64FpK7elCwqr8zxpTuiL6SD9RTDvE3Mw93a4OWaNlYbpLB30mW+KNMi7Avqc9b5BhLAF6TuMPlkflZbiQWan+rx1hJaKg52HYZDpUwTruHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzB4ru0SZZ/0HUSxbH+dKb9eP1cBq8h1k0gM0wxUhjU=;
 b=Tf51myPQkc46x+dt1uUmAKSSuaeZ7eYimopoJe+tJV97zMR5Xq4UnaaZr+dH4XNeVAH14fXPMdSaaT4vJ4LXgajSpzYjOl3xQkUQA1R46Cqa32wWy8UkJJOFWl8YN8aGc94RtFfl1Gn1BJ22zaYIVnjUe3Hu3BXhB8NdCNtBWLdxZ4cbZ+ZjhZU5zlbdgk7RqRzvDje6Y6BrZHPImGY3+AYuI5Ouu3g5pRznPgMY9/it3eYxW4paOc4rxrXT/ZXj2cdSxSwACMalZAbexSCc5wIbDtySq2uHrn43O+R6czVqKrzBp/PJuM57lk/9ttAnhNP87nAZ4k6kkrmoevA1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzB4ru0SZZ/0HUSxbH+dKb9eP1cBq8h1k0gM0wxUhjU=;
 b=nGIsjmvovGnYWVyxYS/47NihJbfVfIyp/w2gk9cKikz3IObpQYdQCZ25vxjLz7BOT7PmINWA2m4amge+q1j0lwYZ+wnMhxCib2LE1W7HNeUPAyFyGk5rbcu01xktd3xq0rz6mEK1SfBeYw4E++P/C3zZexxD6CEFxqtxXuH28MPMYVLh3rfC+nhrgk/n1RullMWVU1qyc6OFJDWsRRAYrKN8YXi2ZD6nb3cO/lEEK4kCMFtNQPIyJ4v5T8cAr3GQT+i4eXDlBWN0sdnqU8PUc67dhOptKoBBg91T9BY/BQC4klVi4kVkvr/W7fW4L60j/oqS5vAeLiVwGsLLhkostQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW5PR03MB6960.namprd03.prod.outlook.com (2603:10b6:303:1ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 07:00:34 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 07:00:33 +0000
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
Date: Tue, 28 Apr 2026 15:00:10 +0800
Message-ID: <20260428070017.16807-2-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428070017.16807-1-chen.huei.lok@altera.com>
References: <20260428070017.16807-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW5PR03MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 76318f48-af9b-4203-4b62-08dea4f3d76e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 0UYdmEFUQv1PcS02YcDYLu58qGS88QYkY5lvKWZbXyOnmGSDFGJ24uYHJ7MeDTsN1Zc50Qj5NT7gSbRuyANrzVwdk/fHyy8GnUCP3tcWcVS6Efm/L8wohJiByhPNmw+icU3PMbeEBTjV4pe/6F24GiEQLwracwJURYnbWGVFKFA28OgZcgDn3ICNqEpwK3EuHy0xbI/qrqVYtaTDzWng79Edi+psHeqxsG8Q3h1u4SItVzpJti/K60hcbaT3N7h0ZbjRx2jr52agEZP+QVFI+R/Paj27JTweAU3UCFiEymjk35WfNkzimurwWm3B2OKOGBqPcAapsz7KXzgc2g0JXlwpeOAoh7Y3sNLU4FQYhknlzCx4LhUeD4o9DHG1XY7EB0NyUJI8lpttv0Gkin4Yi+vThtNCplzqUdvC86E2HmKoCxyEJXchO9yrd05CYegKjMLHjeAo1L61muSVpcAamW/qlY5q6UhBZZEDq9S/ej5ZkEsy8EmYqFlO1qWgDhr/j9IoykgCngHEQftcnrjnYevXOIy2cGAVOwG2iH72HQcLaI8tflOaqiS99yMofU3B1zjXPYDUxw4ueHzGL2Fh0LZSt+Xucpfbv9cWIxNY0YcwRcC7/Uqw7muCxCFG1Q28itWrzY0b5jFq3cACAY5Mq28iwhIetgT7gQh4/PXR0vkBBE4RkdeWTpll16yWadVBdjmqZA6nj881w1VvJC9YjrDgnfAaHiizK2Lk7oiJnQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FnkGZNC62RwMSsOnwY7ri3uG0tiJufLd6A7JF5WyWnsViryzOifvoDCHNsVf?=
 =?us-ascii?Q?iWvlKrZQmq1tmtQKa5oa8HD4G/stD12Y3DsLSu6EIVmmopYqWoDYwHaJ09W3?=
 =?us-ascii?Q?r4VrbsCqoFWtpYH5e06PXZN+ueKN7f1VsDbjtBtXAZdlSF2qkPCva1lg9uKs?=
 =?us-ascii?Q?TIYmmZzC+W05pzyltYqUM/AVZDq9QZsVNy2QFngjzyPge5q2+u2FQ9nrFT7v?=
 =?us-ascii?Q?lmC2/Um2bnCbsMfE48SNgDFKkD5C0UDk6j+qk7zGNAeE2g2SgcZ+yHaj0KHj?=
 =?us-ascii?Q?Sv61D/GoWrql64CvjzQwEQ2my7rLKG6WMdBUVvd/zHhU7pVIRPHr7hI4ZAqz?=
 =?us-ascii?Q?r91F7EH775aG0+zEQUN+8TK10ynwx+Svz8ljPwtwZ1hgMZYfn58mA5HAQufG?=
 =?us-ascii?Q?QH1fNHz6qZq8E5fFpmO0D0BZTIdIv3H6M+ud4zw9O7+yqh3PFuwvvj2TR235?=
 =?us-ascii?Q?+QjRdCmsBYF/wRfIThtZFaKJtf06FRbwaFzghv1liplsrqDcSnbWpUN9zRBH?=
 =?us-ascii?Q?iIuxX50eODp9Apo7GZDtTQNLKWe9NQ5AZ+5OvfJsMuLkxuKbxB4apT2/CtA5?=
 =?us-ascii?Q?t4mvqi84ecqSKw3Sh2lo35qqu3KHs7COqQyu3QqxzexMtyt2rRZYE7phAvfS?=
 =?us-ascii?Q?+6JUOIA65oaCkSbG/nGo/73Cj0mI2Pe7WVLAr5A2fY4vY9+41tLri4/zYUSq?=
 =?us-ascii?Q?/11L+NTrjYVXOr7VNhtKzleqjq5acp8Soy1j8kHujJkpojPwEwgp4LuuaXIA?=
 =?us-ascii?Q?J0PEcmOn1LFLjeIrLys+J2MrzCS1Ry/SOAPpnWyHemN2+FtFtddNeKGkExy2?=
 =?us-ascii?Q?L0wBxhp1Pf39QWHDUybS2cI9KuL2GJoo/t0Tkf8tSAOjg5eArRb8dn8OE8QM?=
 =?us-ascii?Q?ryEdi71OOzvwgCHJgep4fbKDHMFrV1qq8LGcTt+2B4R5BXGg3efRZwQQxYzc?=
 =?us-ascii?Q?Xn4X3mn/sxUuBCKZx+4HeJV5b1uYGiufk69xp5rKgvspkie3q6HwUAZLslf/?=
 =?us-ascii?Q?bUFICRZlaK4N5tfpGM/acMdPj/dF/n04HUMPhkXOg9mzgAiy1jGd9KNruCQG?=
 =?us-ascii?Q?A8mj8qBjFuI1+bIbuv1YYP0Hns42EKYIdhiXMWb6M/+unoqNgwqWW46Jfmy5?=
 =?us-ascii?Q?U4Owrwd0oS+Pdvps8zfVDB9PfvSUMMgUId/RM3brJ1I9jkUWQ3VduKsfrnfI?=
 =?us-ascii?Q?MFCEqUkYoxc1To0vtWmkTRLu6CFRACF0cfo8ktM7dFVWNGjegWLC4Q7IuSWt?=
 =?us-ascii?Q?cQbuV8bNbJxR7dj2yO/gVMQsjhEPFELdSHh+kBc+NUZJec5EQPDmLBvvnCDC?=
 =?us-ascii?Q?wNCT8VZcs6CRR3WgerDytL0NPqrvYJxEe3kxHrW0F1oa3OHnGmlSiJGB6SK3?=
 =?us-ascii?Q?Zphv7AKyeNX0x7TINsmg8qlRX6+kaqPj/WI74h3wp4wASX/4ijYNVxSlmVjd?=
 =?us-ascii?Q?dbjEP4AByWgfxELvKSSjql+oaCPVbw7vllMjpy/cD4Os6qbYa0nS7piKbJPF?=
 =?us-ascii?Q?LPZV9r369yvNesOn+cSf1C7IqZzmlUo4dUNrKIpeOrmEm+PR9V6f3+G/ChB9?=
 =?us-ascii?Q?3hHV/xY/+2nKoadYEqgSuasYekisyqDtEDPRt9e0Dq1Muwqswg/R2bxBr9Wi?=
 =?us-ascii?Q?3XSP4oJf68JJopZNHrc4Oo26ZBFeeq62Gcougttx/3WfNJQ/TXyTqnuKDZdw?=
 =?us-ascii?Q?meljL5cKzm2NrfWhy45IefiLE9m0Xp0WI02GnBwiX7D4AwunkAwEHGkPx/rE?=
 =?us-ascii?Q?qrUa2ORq4gS+YOuCidzQchQ0a1rIhnA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76318f48-af9b-4203-4b62-08dea4f3d76e
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:00:33.5378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zu+DS7X88W2zukhnus/gwLrp7b0AGHkZyGXU7eaozCmTjE4jE4ZoGUwYPdP9g0WTeM6lm/9zr3d5d6uIgt6gkn6kvuem4UQ9bFdcs5pC/Hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6960
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

