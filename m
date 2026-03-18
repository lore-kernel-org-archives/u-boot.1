Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6715DFCD0A7
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 04:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71C71841D5;
	Wed, 18 Mar 2026 05:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PiqUO0eu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99E7C8422F; Wed, 18 Mar 2026 04:02:34 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D2CC840F1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 04:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHEU6mPN904Ax8LnRZ2xKJEIEO8KCA1ELiMpIh5lfdOx/5NjSJxH5Qt4fzqIpHLZxCfz/lxvxKyKAVtE7g9nU2GubNDH8y0dpz/4rZ30iMZkxSNG6qcw0SQRtG6R06psS4qzGv5oxg8mcQ+gu9dV3hVXUDxn0Ker7DpQaENhwuM7NU4YJd2J5UGy7tvu2KEG+sGkfJskzeE/KzZcU73cdkpXL7EbEsKZ2JcWncXT+3mSpQzLisJJ36oD3qlLcfYSqn+P0XXnEM+AKT5D4n9FwdiftQClWggU8rkmpIA8ZkLXePDI7Pop/HiYFHMU4cPNMD5UrpHnplwOkkeyCIYvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqimzOFU9f+vGuTfAFf9yk4Wz8QseK6x5x+ZsTeefGE=;
 b=G9+9entqmNcMtnAVxpLCspDucaXRfbeOngPc697oOaqjXfgOsayiQ968oModePT7ZZbya2+wuHdMkfnkY/qzHkh+bsPnhZ1pyv9Bor0+8RuiUJaD7MIZeIgC9ywzru2iC/xrwkLQqLBvE8jkV0LZxQz6gmsH0FLJfXm2kV6nutueMD1zY7H9RzEo7BGh4TG++sYtPbPKqj5Nhvxi63B3heHWQgKl8JkMNuiA2zFWI/P/Zve6nJ1t56SacXmPBBNvFpTBBORiWvDcXJ6quFh4e1ScDEagIBttYj9dolUCuKjxIwE5/rBCru8fo+qdN0cI9a/3/YHTPcGlB3pmkOGBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqimzOFU9f+vGuTfAFf9yk4Wz8QseK6x5x+ZsTeefGE=;
 b=PiqUO0euYHlmCqLMu1vUqU3UrMjdsqHNziLlA6LnwBi8dzGFgnHezyfWtTknc2m3ECHI3rT9PhlwZrD15vkktIyTvWTb4lpumG87ueHhOnPRSSvsTryZZSDcymigbZYeBDrVhHzP9BPsJt2ccsA4kbcvrQ6JTEBSMeTMxbjzEZ7jNTYW0Cx9YYU1OOvm4M/yzMHRS3mzIoRocYzlto5gazZYQed/qxEpyHuraEW23qoiM9NCxDVT3oDWYJFt/aGNkLeo7ejIhtvNH7YC5gYzndzUaQNjy3qUE5oqNWc3qHUpdd02AIbs9AVh3otrvbmqlG2R3tHCvkCYfzfI/6JxSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BN8PR03MB5092.namprd03.prod.outlook.com (2603:10b6:408:da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 03:00:54 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 03:00:54 +0000
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
Subject: [PATCH v1 1/8] configs: socfpga: n5x: replace defconfig with ATF
 variant and simplify VAB
Date: Wed, 18 Mar 2026 11:00:27 +0800
Message-ID: <20260318030034.25889-2-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260318030034.25889-1-chen.huei.lok@altera.com>
References: <20260318030034.25889-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|BN8PR03MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: eb79fb97-b3c6-41bf-95b5-08de849a91c5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|55112099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: GUI33q2W1rogEMQ/ARgPZCS0HIPspuQ3yf3YvodhRJichjyVAzT/F193RnuXmLFBmD95Xiymtdd6Jm8ZRoXlKnqa+4bGLEt7BnsvXfp2aGUyLaZ0X4MeS3PfIUuFOeXXqLqriTsJtlvd0zhlBHW91fjZlHR46UW12iWc1RAfVCeau+KBrv7rsGZ7gaZ3+L+OsCTMZGwR40LmJNeyWXFzeUOuFQFbqY/jrk4+xL2ZWRs2VRn7ZWhgtt4+UgPQI9wI7hTs7ByYRNUGz1DP2kxKLM5Xf6W1X3c0oojqsfLpsa149QbWdPBrwpjwVNZXfDXQFjnZ55+mYICpkdJi7xSWg1uf2byBOVx10GeNgu2C4afzFJxQyQB5kN9O8EDWGsHZ/8Gyw6qi3EUcBF/aOEEvpDdw9RSe4154YREk1SKKa37HdyYHw9BoWa40cxRfJSxOY2qgntuZpC1vwr4rMD6NQURerYYuCgkrK0qR4MEQHqLcyWoxBFY86lJcu+63goOKoh5RpO4FrqFROVpHJ8NW4BLjmbU+jcvW69/cfJQx3RUa7AtMVNiXEE6vbE9eY+5NkIfMsXwk0puuKOfWzY8zniSdG8tTYfQXaOZYNKVzf8aaiY5/58x/TGyorZfyZfGK3tX8xjTuAdZ6YiVtC46EXCpnI8eN1ZOgkS3B/g7TupBs4V0Qgw9gDK/kVce1tx7QhrKX9976bK2dYl015Go+prY+K2XR601lfm5qdu/ueBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CgXo5NDzHVev/kSsX7bJ2vv+IgYN7xwyLwS42P0VwMLx0DUczUQnKYus2Q9B?=
 =?us-ascii?Q?0zQiz6qvjit0X8YXD7rCPBEOT1PfLt8cUq662M+m2Z7llO1M88KGCBNt5/th?=
 =?us-ascii?Q?w73sA7sYIdqzoKV9K0KsrDmUUJaGS6g7pXqwTZ5PxNhs8oP1iUwkjm+ADj3X?=
 =?us-ascii?Q?AxcAcopc/C/np/DoVdEoRD6qypNjkh4hRPfT59dpTkD+3Z0MIkV0moWOH7Ch?=
 =?us-ascii?Q?ckjPz0X5aDmjNSDxy3khx28WYJoxI5o/QNU10/gxP6WHC4m5NYVrKFmbjWNV?=
 =?us-ascii?Q?NRvQYYhp5GdOO044bo3WSrR+0jA2uKrlgJw4CRl2jVEvxr72f5l3FCFbTKHE?=
 =?us-ascii?Q?lnbddHc3jkEbDqFOk18sGlUPv1iLGTgYesPg0ybcY/iW+hJoSp25SWxppTKy?=
 =?us-ascii?Q?tdULWYpmZpQsbgF4n4dxn4ms1ULHntmD+sMXM2CxUjJgd871Pthp1yMJU7Md?=
 =?us-ascii?Q?7WskwZoZBurLN/4+pwtUC/E4h5HRCW41y2vtglgg7wkD50UzjEhn+6TTfuXn?=
 =?us-ascii?Q?M7RYL58B8aNMpNuRquVJFr01ideGZJDBDUmprZyu/5PGIyrg9ash+zCjvkWo?=
 =?us-ascii?Q?HfDXARCM0STzC6O+U/vgMQt+K9LUKw2DhjNSRpytXwwZGqmOFyiBGdA157+s?=
 =?us-ascii?Q?3D/fPfVKFeNGtvHZromAHuV7Y1r85ZFG74fKF+hi/ZjV5dX0j+o235wH0UM6?=
 =?us-ascii?Q?FJwV4U2K1pLaqh6soXXUamdlu4P/hMH7pJRQo14gsOBjmdn21LCIO5vamTgE?=
 =?us-ascii?Q?UKoKm4bOjxZJ51SwA2sb5oz/6eNaHJMeFYiVXlONNoQ+2lY8xncb7TdmUno1?=
 =?us-ascii?Q?72czfMV1ynliYEkzkV7RaUhmvc8qt5aHry7hHJc3vS5zI5sKtdHM6H9826Bk?=
 =?us-ascii?Q?46RxgArrSVzWWE5gtnhEQSGbdQD2hrSHKlWiSNZUsSWQNIDwYo838mLb2xjW?=
 =?us-ascii?Q?F+1AKusABpC6SBY7/SVuF2obBDRgbMTV974uVuXnKFnQPlo/qGokzfYVGDB+?=
 =?us-ascii?Q?1zDS6N/+IY0Qq333Ue3sVTiOy75lQ5ZZOyIMSXQSkOhprgY7KYdsUjV8VL+b?=
 =?us-ascii?Q?FfDpaF1A6Rv/P5Zeer6ciaQeeQAUxbyPvaXyp/KKXYYzA5Ihh/bVHQmwCTPI?=
 =?us-ascii?Q?s5HjvKbh/c5ZKBYS9JsrCzVdbPrLTAG+sBC9/w1RSF28oHJZlM0MMR/fzn43?=
 =?us-ascii?Q?XV/kJcF8Mc0ZabOJ/j9wjmt2SOXHZZJGAwiptjrWX5fLY8CcUt3az/tdmxx8?=
 =?us-ascii?Q?pGpPAAwFNbV8kAZq3mmWMGZ+54DEbSA2wXE4Keyyj8HCA96/qYVmUQZX0Pfa?=
 =?us-ascii?Q?kVvbMuyDa1l2eUgxsAKCfgUcym2hc8RUSTMlsLp47ZSOtaNVmu5DVG97yP7W?=
 =?us-ascii?Q?kUUKFc8cyYUzBzic0XFvR+5CvPp5ky1eZEHaEC3uiB4BsIYRh7b+0JRMNcdu?=
 =?us-ascii?Q?W70DVu8D4tVYJVYrMrf4nMAV8du4iGcc2PhIW4+MS8u98umQCs+6wH/eI8zT?=
 =?us-ascii?Q?fqPZcwWevCvkYwTp2mvJPeXMDqY43a2sONwCTxuxrx+boOiE9x6rIz2mfXw6?=
 =?us-ascii?Q?W5va2/PKeSjgAjwbHBteEYVswQCPPZ1xIj2BqudRTv3USuHR0Otdt5WDBEbY?=
 =?us-ascii?Q?H+oMi0pm5xefdtw+4f+PxCf2Yck0TX7to7en6RZUisU3aNE7boxCJpW4q1gS?=
 =?us-ascii?Q?VLWdxdti0yqprpVl7/khD6cXjBTkETLMtyo8XlqiJsBVCPJ1Sc5cvu+9EVxw?=
 =?us-ascii?Q?ZRy9Fb85wi+P3JHQgUNU+Je+nnJgTRo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb79fb97-b3c6-41bf-95b5-08de849a91c5
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 03:00:54.1933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBRkQ3AEBfOuZfxGlfCiGFGZxNta5RqVXFVyIFUrX4CAftufQ3SpEjnAru2iKOR+9Ht9VoB0AvzM9BXzfzzTtzX9XAHDaS/5vVj4nkJNbD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5092
X-Mailman-Approved-At: Wed, 18 Mar 2026 05:11:17 +0100
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

Also simplify socfpga_n5x_vab_defconfig to include
socfpga_n5x_defconfig and only enable
CONFIG_SOCFPGA_SECURE_VAB_AUTH.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 configs/socfpga_n5x_atf_defconfig | 90 ------------------------------
 configs/socfpga_n5x_defconfig     | 21 ++++---
 configs/socfpga_n5x_vab_defconfig | 91 +------------------------------
 3 files changed, 15 insertions(+), 187 deletions(-)
 delete mode 100644 configs/socfpga_n5x_atf_defconfig

diff --git a/configs/socfpga_n5x_atf_defconfig b/configs/socfpga_n5x_atf_defconfig
deleted file mode 100644
index 1ef20ba97a8..00000000000
--- a/configs/socfpga_n5x_atf_defconfig
+++ /dev/null
@@ -1,90 +0,0 @@
-CONFIG_ARM=y
-CONFIG_COUNTER_FREQUENCY=400000000
-CONFIG_ARCH_SOCFPGA=y
-CONFIG_TEXT_BASE=0x200000
-CONFIG_SYS_MALLOC_LEN=0x500000
-CONFIG_NR_DRAM_BANKS=2
-CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
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
index c9fa50b3aa9..e32eaacf0ad 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -1,11 +1,12 @@
 CONFIG_ARM=y
 CONFIG_COUNTER_FREQUENCY=400000000
 CONFIG_ARCH_SOCFPGA=y
-CONFIG_TEXT_BASE=0x1000
+CONFIG_TEXT_BASE=0x200000
 CONFIG_SYS_MALLOC_LEN=0x500000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x101000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_MODE=0x2003
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x200
@@ -21,15 +22,19 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
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
@@ -38,7 +43,9 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
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
@@ -56,10 +63,7 @@ CONFIG_CMD_CACHE=y
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
@@ -85,3 +89,4 @@ CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/configs/socfpga_n5x_vab_defconfig b/configs/socfpga_n5x_vab_defconfig
index a4798e2f953..3fe74846d01 100644
--- a/configs/socfpga_n5x_vab_defconfig
+++ b/configs/socfpga_n5x_vab_defconfig
@@ -1,90 +1,3 @@
-CONFIG_ARM=y
-CONFIG_COUNTER_FREQUENCY=400000000
-CONFIG_ARCH_SOCFPGA=y
-CONFIG_TEXT_BASE=0x200000
-CONFIG_SYS_MALLOC_LEN=0x500000
-CONFIG_NR_DRAM_BANKS=2
-CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
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
2.19.0

