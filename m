Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCBD108B8EA
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 10:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AB4183E36;
	Fri, 20 Mar 2026 11:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qcHBM2za";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B31383F8A; Fri, 20 Mar 2026 11:10:46 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB75083CF5
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 11:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFv8yPWqWOn/lKsKsupqlBm2/c4y2bwnZMl4ErcqHXCogaY5Ow9HlWBJ8YgnHIl6w9P0bqGdLzYai1xqvfg3U1uqN4UJJsORwcINKtaPYqlTXD/CNog43iymn0iB3dGER76/b0SfEi8G7xJmW3URTgq9fffGHs/r/Sve6zEe08iWf+pWal7IBPcuyywsNpwnke6brJLYIl4pA1u/yB7zvnpMAfFTKEOHEGfTJRXzADzFalxKBFXwvPzPeUFam24UnoRkwCKE68yWh1ZfMBOlhT2yGtIg9U5CXsvN1LLHouAb1zSz+p8ZHNI9tpomQTmvmP/Yerfdb1lAsdB6/tz2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZosVwfSZlXOfe3PJG3hXeB0OCbBiYFT/r49zXdCDzJU=;
 b=q5uMfkuz23GA80J5Rs+ZjqTBzsEDF39xcvf+ZYUJeFlCVB1so6vtqFLC4a0WCf9OU2crnFpo3ONfwdY6paQTn5KoqS9U7/w2Bz8pCvXpFDCKtWm0N2S9VrlYLhx8oJqETnEMcyJdPqOapmD3RK6eiTa3Jbco3bbpVYza4BMgG6roK62RvNW3RBun5ycvv5lrCRTGLDVuzIaX+ko1fJMha3wyYjb9yC4Ro38i6nmtJvrF/24/biIrmylKYbezfvW3Z4QtwdDkC7wl88IHW03xtJg8S8JiM86BTnLpzguxy5CEyGdjkrcx3qBbumBaPGkt9C3kbUIF6admwGSgElVoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZosVwfSZlXOfe3PJG3hXeB0OCbBiYFT/r49zXdCDzJU=;
 b=qcHBM2zaH6T4BDFM28H6o9GzLYQbymz+UMw1+aDYrsIZ+Q5L6lriFW5ee/D+TaLMMJYOlhNhIRCqCp4oLTzff2835cHDx0gkMxEVfVtCNXQbxfTpQYivbv7g0OrqBue0MVtA/a5qLE8vt5pDZQE2YDb7GKQV2r7hJ/2L8h4iGjo=
Received: from BYAPR02CA0045.namprd02.prod.outlook.com (2603:10b6:a03:54::22)
 by BY5PR10MB4337.namprd10.prod.outlook.com (2603:10b6:a03:201::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 10:10:39 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::fb) by BYAPR02CA0045.outlook.office365.com
 (2603:10b6:a03:54::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Fri,
 20 Mar 2026 10:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 10:10:38 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 05:10:36 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 05:10:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 20 Mar 2026 05:10:35 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62KAAYOj4142741;
 Fri, 20 Mar 2026 05:10:35 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 Mar 2026 15:40:34 +0530
Message-ID: <DH7J0W8ZJCDY.27ZGBQPIP4TP5@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: <rs@ti.com>, <robertcnelson@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/3] k3-am62-pocketbeagle2: add support for 1GB variant
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260317223800.776581-1-rs@ti.com>
 <20260317223800.776581-4-rs@ti.com>
In-Reply-To: <20260317223800.776581-4-rs@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|BY5PR10MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d6fa55-d115-487d-e1ca-08de8668efa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: h21A9MFZsCwIC9FbniE8q8oq3Y8quOT+JEui3lD0Pd+Q5mAkzOu2EWWilL8kbwqTJUucwCJ3paW+OUcPKW2g8oYctYbSye7wu88/WT2/HIzc/tM1gKFjrsz/DK9vWJRfGUhT71+Og2WsHhBVpZdN7RF5SUzWYdTLTd7Bn7EN49DRwnAbdx3ONboBUkPItoCL+4ouRe0cDkE5ufxgZ/mLPcyxjt4P3Cyt8cwCfP15VjKUVfVhSYNm3SnEXPxzoIus8ZoDs4Kj27w2F0P9vK5k7eHlUcX4NLpmrAhogfSzOXnH6LlGhILc6IGspj4xwATlpVfpgZiYVdVVwDsGSzLKkqaNqUnM5GX9kfX5nAX9bLNI/lz3j5j28xadYaL/9blIr9oxw9VH7HRdiyyLo7O9Si7RU3D20MuKn7hVpwAFR5KoDD6aZ9byOF9c+j7heeGMjkqOHxVsiKcRY1Umnah/GLV9OuWYsY5+LmCf3AdjKVu7Czsu9vQO6bLhifKCir6utpu6LNZdLJqs5tOkMdXht/pwXOtVxoEUlcW2O3ESYHmjqg64zdx5AMZfAIcuQEugnZV0kzk1K1bbF/ZrZAvRn5h2QE92Pc4ycqEvjk3J9DkjyBG9I4Rm+cR7PT40zez6tYFR7o0XCLSNPXe/dj1Akd7px4JyzZwV60S45TVRL1dMu5vWq3MdbKbI6JxyJc1NoXSjz34qGMiM7D1B6bFWMdKzLSZa3fSZB1olk0PmNaQ=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NVCTfTz0aaffdV21raA7Pd5HfFGWBiNHI21qSvfiqEi8O95uvGKxgw2gPcywQr2p6pJb5WwS+exftNruCILrzb/gzqrbTMRqRiPw34xSrZckZWmux/HEBZ91fBUhsjWzwYImBif7YI8eeiW79X+bjMXPOJPEE/jOVlDxHuHsa4flTsVxVl0G+boY1HHP9UQA2qSJBOVmwZbtrzhGIUQKLPA2xMZ59Na262PbgIt11u0smGBJ0/gbAxh6CWzhEqRWWewc+Tp6bmQMsszWxTCXngMBnU3K3vVzNxJ4v/iQT/FZSbJiwCJNjvZwj2u0hb9svgiMoLRJqR+dOxiQLKjTUVq7Yvh/vwH0VcX6YOsoG/MvWrx6qQjZ/bBxLoEZ9EP07XPeDHhfj9laoF0UBxvceEcBKoyacPu+yGIew/sKTuLOW18iv2DLkMv35aGj6Svi
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 10:10:38.7482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d6fa55-d115-487d-e1ca-08de8668efa8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4337
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

On Wed Mar 18, 2026 at 4:08 AM IST, rs wrote:
> From: Randolph Sapp <rs@ti.com>
>
> Take Phytec's current DDR fixup functions and utilize them to
> dynamically adjust for variants in the pocketbeagle2. There are
> currently 3 skews, two of which are both 512MB with the same memory
> configuration, and one which is 1GB using the same CWL and CL settings
> but a modified density [1].
>
> Based off of Bryan Brattlof's patch [2].
>
> [1] https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/5411/8G%=
20Bits%20DDR4%20SDRAM.pdf
> [2] https://github.com/bryanbrattlof/beagleboot/commit/fb2f022e27427e990d=
7a33fd001ffb571e13cfc3
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>  board/beagle/pocketbeagle2/Kconfig            |  26 ++++
>  board/beagle/pocketbeagle2/Makefile           |   2 +
>  board/beagle/pocketbeagle2/pocketbeagle2.c    | 112 +++++++++++++++++-
>  .../beagle/pocketbeagle2/pocketbeagle2_ddr.h  |  50 ++++++++
>  configs/am62_pocketbeagle2_r5_defconfig       |   5 +-
>  5 files changed, 192 insertions(+), 3 deletions(-)
>  create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
>
> diff --git a/board/beagle/pocketbeagle2/Kconfig b/board/beagle/pocketbeag=
le2/Kconfig
> index e957b8e8377..a361fcebfc1 100644
> --- a/board/beagle/pocketbeagle2/Kconfig
> +++ b/board/beagle/pocketbeagle2/Kconfig
> @@ -12,6 +12,7 @@ config TARGET_AM62X_A53_POCKETBEAGLE2
>  	select ARM64
>  	select BINMAN
>  	select OF_SYSTEM_SETUP
> +	imply TI_I2C_BOARD_DETECT
> =20
>  config TARGET_AM62X_R5_POCKETBEAGLE2
>  	bool "BeagleBoard.org AM62X PocketBeagle 2 running on R5"
> @@ -23,6 +24,7 @@ config TARGET_AM62X_R5_POCKETBEAGLE2
>  	select K3_DDRSS
>  	select BINMAN
>  	imply SYS_K3_SPL_ATF
> +	imply TI_I2C_BOARD_DETECT
> =20
>  endchoice
> =20
> @@ -58,3 +60,27 @@ config SPL_LDSCRIPT
>  source "board/ti/common/Kconfig"
> =20
>  endif
> +
> +config POCKETBEAGLE2_AM62X_RAM_SIZE_FIX
> +	bool "Set the PocketBeagle 2 RAM size instead of detecting it"
> +	default false
> +	help
> +	  RAM size is automatically detected through the device revision stored
> +	  in EEPROM. This overrides the detection logic with a fixed value.

With the ability to detect the board type via the EEPROM, is there any
use to having this option?

IMO we should just let the board boot with runtime detection for DDR
size everytime. This config option just makes the execution harder to
understand while providing minimal value.

> +
> +choice
> +	prompt "PocketBeagle 2 RAM size"
> +	depends on POCKETBEAGLE2_AM62X_RAM_SIZE_FIX
> +	default POCKETBEAGLE2_AM62X_RAM_SIZE_512MB
> +
> +config POCKETBEAGLE2_AM62X_RAM_SIZE_512MB
> +	bool "512MB RAM"
> +	help
> +	  Set RAM size fix to 512MB for the PocketBeagle 2.
> +
> +config POCKETBEAGLE2_AM62X_RAM_SIZE_1GB
> +	bool "1GB RAM"
> +	help
> +	  Set RAM size fix to 1GB for the PocketBeagle 2.
> +
> +endchoice
> diff --git a/board/beagle/pocketbeagle2/Makefile b/board/beagle/pocketbea=
gle2/Makefile
> index 3d42c160716..dd529fe6d75 100644
> --- a/board/beagle/pocketbeagle2/Makefile
> +++ b/board/beagle/pocketbeagle2/Makefile
> @@ -7,3 +7,5 @@
>  #
> =20
>  obj-y +=3D pocketbeagle2.o
> +obj-${CONFIG_K3_DDRSS} +=3D ../../phytec/common/k3/k3_ddrss_patch.o
> +obj-${CONFIG_TI_I2C_BOARD_DETECT} +=3D ../../ti/common/board_detect.o
> diff --git a/board/beagle/pocketbeagle2/pocketbeagle2.c b/board/beagle/po=
cketbeagle2/pocketbeagle2.c
> index b6768caa34b..1bfc79350b6 100644
> --- a/board/beagle/pocketbeagle2/pocketbeagle2.c
> +++ b/board/beagle/pocketbeagle2/pocketbeagle2.c
> @@ -15,15 +15,123 @@
>  #include <spl.h>
>  #include <asm/arch/k3-ddr.h>
> =20
> +#include "../../ti/common/board_detect.h"
> +#include "pocketbeagle2_ddr.h"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +static int pocketbeagle2_get_ddr_size(void)
> +{
> +	// check config overrides first
> +	if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_FIX)) {
> +		if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_512MB))
> +			return EEPROM_RAM_SIZE_512MB;
> +		if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_1GB))
> +			return EEPROM_RAM_SIZE_1GB;
> +	}
> +
> +#if IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)
> +	// dynamically detect the config if we can
> +	if (!do_board_detect_am6()) {
> +		struct ti_am6_eeprom *ep =3D TI_AM6_EEPROM_DATA;
> +
> +		if (strlen(ep->name) > 11 && ep->name[0] =3D=3D 'P') {
> +			/*
> +			 * POCKETBEAGL2A00 (am6232 512MB)
> +			 * POCKETBEAGL2A10 (am625 512MB)
> +			 * POCKETBEAGL2A1I (am625 1GB)
> +			 */
> +			if (!strncmp(&ep->name[11], "2A1I", 4))
> +				return EEPROM_RAM_SIZE_1GB;
> +		}
> +	}
> +#endif
> +
> +	return EEPROM_RAM_SIZE_512MB;
> +}
> +
>  int dram_init(void)
>  {
> -	return fdtdec_setup_mem_size_base();
> +	if (!IS_ENABLED(CONFIG_CPU_V7R))

I don't have a 1GiB pb2 to test with but I'm assuming the fixed up
memory nodes get passed from the R5 SPL to A53 SPL and then finally to
U-Boot as part of fixup_memory_node from k3-ddr.c.

Could somebody confirm if this is indeed the correct flow? I wanted to
see if both A53 SPL and U-Boot receive the correct memory size as part
of their DT.

> +		return fdtdec_setup_mem_size_base();
> +
> +	return 0;
>  }
> =20
> +// logic after this block assumes that there is only 1 DRAM bank current=
ly
> +#if CONFIG_NR_DRAM_BANKS !=3D 1
> +#error Unsupported number of DRAM banks!
> +#endif
> +
>  int dram_init_banksize(void)
>  {
> -	return fdtdec_setup_memory_banksize();
> +	u8 ram_size;
> +
> +	if (!IS_ENABLED(CONFIG_CPU_V7R))
> +		return fdtdec_setup_memory_banksize();
> +
> +	memset(gd->bd->bi_dram, 0, sizeof(gd->bd->bi_dram[0]));
> +
> +	ram_size =3D pocketbeagle2_get_ddr_size();
> +	switch (ram_size) {
> +	case EEPROM_RAM_SIZE_1GB:
> +		gd->bd->bi_dram[0].start =3D CFG_SYS_SDRAM_BASE;
> +		gd->bd->bi_dram[0].size =3D 0x40000000;
> +		gd->ram_size =3D 0x40000000;
> +		break;
> +	case EEPROM_RAM_SIZE_512MB:
> +	default:
> +		gd->bd->bi_dram[0].start =3D CFG_SYS_SDRAM_BASE;
> +		gd->bd->bi_dram[0].size =3D 0x20000000;
> +		gd->ram_size =3D 0x20000000;

We can make use of SZ_512M and SZ_1G macros here.

> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +#if IS_ENABLED(CONFIG_K3_DDRSS)
> +static int update_ddrss_timings(void)
> +{
> +	int ret =3D 0;
> +	u8 ram_size =3D 0;

Having a u8 of "ram_size" is confusing, we should  make it explict that
it's an index into pocketbeagle2_ddrss_data.

> +	struct ddrss *ddr_patch =3D NULL;
> +	void *fdt =3D (void *)gd->fdt_blob;
> +
> +	ram_size =3D pocketbeagle2_get_ddr_size();
> +	ddr_patch =3D &pocketbeagle2_ddrss_data[ram_size];
> +
> +	if (!ddr_patch)
> +		return ret;
> +
> +	ret =3D fdt_apply_ddrss_timings_patch(fdt, ddr_patch);
> +	if (ret) {
> +		printf("Failed to apply ddrs timings patch: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +int do_board_detect(void)
> +{
> +	void *fdt =3D (void *)gd->fdt_blob;
> +	u64 start[] =3D {gd->bd->bi_dram[0].start};
> +	u64 size[] =3D {gd->bd->bi_dram[0].size};
> +	int ret;
> +

Nit: formatting (done with clang-format)

	-	u64 start[] =3D {gd->bd->bi_dram[0].start};
	-	u64 size[] =3D {gd->bd->bi_dram[0].size};
	+	u64 start[] =3D { gd->bd->bi_dram[0].start };
	+	u64 size[] =3D { gd->bd->bi_dram[0].size };
		...
	-	snprintf(fdtfile, sizeof(fdtfile), "%s.dtb", CONFIG_DEFAULT_DEVICE_TREE)=
;
	+	snprintf(fdtfile, sizeof(fdtfile), "%s.dtb",
	+		 CONFIG_DEFAULT_DEVICE_TREE);


> +	dram_init();
> +	dram_init_banksize();
> +
> +	ret =3D fdt_fixup_memory_banks(fdt, start, size, 1);
> +	if (ret) {
> +		printf("Failed to fixup memory banks: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return update_ddrss_timings();
>  }
> +#endif /* CONFIG_K3_DDRSS */
> =20
>  #if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
>  int board_late_init(void)
> diff --git a/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h b/board/beagl=
e/pocketbeagle2/pocketbeagle2_ddr.h
> new file mode 100644
> index 00000000000..6d248ce6dfa
> --- /dev/null
> +++ b/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * DDR override logic for AM625 PocketBeagle 2
> + * https://www.beagleboard.org/boards/pocketbeagle-2
> + *
> + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.co=
m/
> + */
> +
> +#ifndef __POCKETBEAGLE2_DDR_H
> +#define __POCKETBEAGLE2_DDR_H
> +
> +#include "../../phytec/common/k3/k3_ddrss_patch.h"
> +
> +enum {
> +	EEPROM_RAM_SIZE_512MB =3D 0,
> +	EEPROM_RAM_SIZE_1GB =3D 1
> +};
> +
> +struct ddr_reg ddr_1gb_ctl_regs[] =3D {
> +	{ 317, 0x00000101 },
> +	{ 318, 0x1FFF0000 },
> +};
> +
> +struct ddr_reg ddr_1gb_pi_regs[] =3D {
> +	{ 77, 0x04010100 },
> +};
> +
> +struct ddrss pocketbeagle2_ddrss_data[] =3D {
> +	// default configuration
> +	[EEPROM_RAM_SIZE_512MB] =3D {
> +		.ctl_regs =3D NULL,
> +		.ctl_regs_num =3D 0,
> +		.pi_regs =3D NULL,
> +		.pi_regs_num =3D 0,
> +		.phy_regs =3D NULL,
> +		.phy_regs_num =3D 0,
> +	},
> +
> +	// industrial configuration
> +	[EEPROM_RAM_SIZE_1GB] =3D {
> +		.ctl_regs =3D &ddr_1gb_ctl_regs[0],
> +		.ctl_regs_num =3D ARRAY_SIZE(ddr_1gb_ctl_regs),
> +		.pi_regs =3D &ddr_1gb_pi_regs[0],
> +		.pi_regs_num =3D ARRAY_SIZE(ddr_1gb_pi_regs),
> +		.phy_regs =3D NULL,
> +		.phy_regs_num =3D 0,
> +	},
> +};
> +
> +#endif /* __POCKETBEAGLE2_DDR_H */
> diff --git a/configs/am62_pocketbeagle2_r5_defconfig b/configs/am62_pocke=
tbeagle2_r5_defconfig
> index e863204cfef..d72f78b932c 100644
> --- a/configs/am62_pocketbeagle2_r5_defconfig
> +++ b/configs/am62_pocketbeagle2_r5_defconfig
> @@ -14,7 +14,7 @@ CONFIG_DM_GPIO=3Dy
>  CONFIG_SPL_DM_SPI=3Dy
>  CONFIG_DEFAULT_DEVICE_TREE=3D"k3-am62-r5-pocketbeagle2"
>  CONFIG_DM_RESET=3Dy
> -CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x7000
> +CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x8000
>  CONFIG_SPL_MMC=3Dy
>  CONFIG_SPL_SERIAL=3Dy
>  CONFIG_SPL_DRIVERS_MISC=3Dy
> @@ -42,6 +42,7 @@ CONFIG_SPL_SYS_MALLOC=3Dy
>  CONFIG_SPL_EARLY_BSS=3Dy
>  CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x400
> +CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_DM_MAILBOX=3Dy
>  CONFIG_SPL_DM_RESET=3Dy
>  CONFIG_SPL_POWER_DOMAIN=3Dy
> @@ -73,6 +74,8 @@ CONFIG_SPL_CLK_K3_PLL=3Dy
>  CONFIG_SPL_CLK_K3=3Dy
>  CONFIG_TI_SCI_PROTOCOL=3Dy
>  CONFIG_DA8XX_GPIO=3Dy
> +CONFIG_DM_I2C=3Dy
> +CONFIG_SYS_I2C_OMAP24XX=3Dy
>  CONFIG_DM_MAILBOX=3Dy
>  CONFIG_K3_SEC_PROXY=3Dy
>  CONFIG_SPL_MISC=3Dy

