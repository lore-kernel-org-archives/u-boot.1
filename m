Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08722CD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 21:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D34846D1;
	Sun, 10 May 2026 23:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="EnoBj2EW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F3F2846D2; Sun, 10 May 2026 23:12:15 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazolkn190120000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d114::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86CF4846CB
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 23:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmGkQCeJMxh5DZUmy5s3QBEoB8Bl9lxkcgi7/OY6aRR6HmD4wTHL+kMjrSWdRI/yC12e6X5k1aM3nHF/TQiVSbkaN2Mcle/RDFszqj3EHQEd6Np5mgKCdcBE9sJQOLHD67FLq4L+Zo2fTs6nBM3obnnwSMujYXyfOsHhtS3XW0OGvDwCsEOkh8v6IVZzMcu/SxSHZryddE2vLc8xCFGl+svlVoy9bwJ+k3GDqE1Yia4MGbBz62s43IzThBxpR4LHLE4RYZLASyrbK/qAlr8+RCW1Vy3G12d4kvIDOHyqhlQ1j2LCgbLzXY9XfqEOqqGZKnj+ZCxSKV6xkYB1xi1IQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKGTGcvHDX2aeNEtIDGnSuApNFEqzKmxI52BRLDpggo=;
 b=vmplKn1VzZY8ldtOF09bpZsYtgQ4wX/NWSuhrohSacG9FWK/xarSrnT2ghGjec9OKBM7Kpu0CbhnlUQ1my21Sr4D/rj38aLg/PpfQ/Rlku70vZRVXZ1f7wr9B4V3WNX9OvXbB7BzNxBl/J0iPcNvWTCHVqklol05U1muPfhl8ualRTARsq60u3T7jwhL39FLUvWzA5bcgQoxxNf5ITMYVtrvYmIVIBSrGZcJj++NZe1HQkAGvpN8adotOGmGrehpb/PM4ibtBV5dm12ZEBQAlNPkilL9nGPgvS9GtNrR0An2TFRvI8Mhhgp++DCetOGvjMCobDlDjRJW+hkYWP2PZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKGTGcvHDX2aeNEtIDGnSuApNFEqzKmxI52BRLDpggo=;
 b=EnoBj2EWTIAUioHGptaR0ILQi/n9lsWpcmkYvqXnuzS7p7wnOhaJybf5g5k9qLf+tOwnKlnmb1sGuxCHCPjMpp41jDUPn2np6gBp9BnkivREV3CkPONaGpcEsyykL9Ed5B3T8tU6XwLRB0+YgqsrDqwnX7wW+rtTGjPT+8XG8C2GOEzaaPf4zCJGrPlaV6PVUrD/wlYKoE4oXbYK+kZ3lsXTotMHcarN8Ntd8tTjo9e/6ovsvDuCpwcveEU3GmbifAraEhQSynRo1PGvxHEY/qXN4KvJlyuiR98m7Dv3qChxE6N+INiPl4+esaOVayJhndtha1YV12zVTk8gfQUD8Q==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by IA0PPF371656EDC.namprd19.prod.outlook.com
 (2603:10b6:20f:fc04::c9b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Sun, 10 May
 2026 21:12:08 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 21:12:08 +0000
Date: Sun, 10 May 2026 16:12:05 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Subject: Re: [PATCH V2] board: rockchip: add Anbernic RG-DS
Message-ID: <PH0PR19MB9973382D88B09E3663BF0F1A27A53B2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260427175553.21426-1-macroalpha82@gmail.com>
 <977aa4b0-ead7-4df9-9ce3-8626c3b0f845@cherry.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <977aa4b0-ead7-4df9-9ce3-8626c3b0f845@cherry.de>
X-ClientProxiedBy: SA9PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:806:23::16) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <agD0pdj_9OSxe8-D@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|IA0PPF371656EDC:EE_
X-MS-Office365-Filtering-Correlation-Id: 1704e560-b730-41e9-2a0e-08deaed8cb34
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|19110799012|8060799015|5072599009|24021099003|6090799003|37011999003|23021999003|25031999004|10035399007|3412199025|440099028|40105399003|52005399003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fzw/tivph0C80xzD9Jhc7tWS/fR/+JPwcVQ7lZFJjr/mcOrrXFCfKHlr6I2R?=
 =?us-ascii?Q?k80VF4q8iXIxX7AoVNeAmGCd8wMk2dqQwQNEmwqt2iKJj8LQI7ljHekFqrYh?=
 =?us-ascii?Q?SkUyGgaGFkgjhjibiDajqnyIERLHBMXE0LiU1w4ljz4wrDUK2X3RFNboHV8I?=
 =?us-ascii?Q?ySOEjrXsuSSC1OUvsl1JM8pSlYwMeOX15TrArjX0nyfH5rV5yj9i01Pqt+Va?=
 =?us-ascii?Q?6QLHFTjJ1VkxoFVF3UtRJonWW2xPbH9M1Be3N4dXSDBE+AUWJ4jxyzeb+oui?=
 =?us-ascii?Q?vqVF18rzRFBSOf3pqGhyJxkw04auvMGf63Vc/MCE6BUvum4kXQM20fMmbBWr?=
 =?us-ascii?Q?RSNzMlnzenZIPGQopbSJESbFeZWpP9RmcvgCFBhp4xSgoMRkgkzZPR09E4Fb?=
 =?us-ascii?Q?7Y1SM7HsDwvAdBQAGSljTTXd7DYZNB0i7LwbI3lRAx2Mmb6nkx7hCtOq7cdC?=
 =?us-ascii?Q?qvpWueSiyM0AjGzZ2y4ZvsquREdCSYB5uukKheA4s3Y7B5+I6Asn2TWrl3Qr?=
 =?us-ascii?Q?dosB86fm0MDnEVIAHrrgxtj/oXYiGj9R6+75xBEbHsAUJiOYU8g7ZU4H24PZ?=
 =?us-ascii?Q?4bUh6QJVGvYxXiSwk7UGgwwt+N6y/Tt/AiHDaHfcKWXsjRgjvxZ441xOCeQV?=
 =?us-ascii?Q?Ux2KW1Hiu3e0prTpeUT1Mb4GUzw9Qku//Aq+p40QWyIxeh1MTtv71G/dsAaq?=
 =?us-ascii?Q?7hDHG6EnG8lEtJqoqiE4+CinTmowGb5T48s50vqvizXPbz97uatNbYgH+8s9?=
 =?us-ascii?Q?Wvl4uDtFCf9QAwZN0+aJHxF2IZ/JRmxVKIVK75Jl/FII5x78V/oGAjC2883o?=
 =?us-ascii?Q?HATWv0EFV+cwMdOzqSM15S1Ni7sestzEJdQLNqHOK2QHNbQtqMK56tQK4UNq?=
 =?us-ascii?Q?qLmPfTnO/CV3sXlfip6rtBVEzaOkA4eXfGuAc16uHJ3a4EWe+2RviRJLrMmE?=
 =?us-ascii?Q?CBNVOdjZu2b+LB/g1Pj3mRs9FZJk0oAnmxYkpcEsiYd/99HfcBY9P6GcZKrf?=
 =?us-ascii?Q?RoQ1BDnbslS9Da8bPKnEtrrlIf9REg12JOFisi84rhkK95+eHhPw/epKhHMl?=
 =?us-ascii?Q?Fh/dtXJV?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m6pNANm4nuvHSi9LFb/8CvXVmdtLmlQVv/RW6rHiJFwyvf5wpOUWl3jUm8Yn?=
 =?us-ascii?Q?/VZ7+yx1FI6wdQEndi9OpsvoTz+Ri5N71q77hXHQUpbFjWh6nZjdwxnPvEuT?=
 =?us-ascii?Q?yl+XdUbZlaH65GBHJ/aQZDEPZ2K1h2+QJAUlbYlF9E2UHIJoH060Ey1JqVbh?=
 =?us-ascii?Q?VXzkfmOIrbcru8w0VCLFMwlr4zYnOxPLIoDGyvO24bDltA9nUnVX0gxQ78g2?=
 =?us-ascii?Q?asKdLw8pmbWo7Qxu9Kf/1DUp1kmUZMVtpY0NdZ6NVZVwfG1t45IOtMvgP431?=
 =?us-ascii?Q?QzDtbyrz5fNHOc/P2c37yE2YOzookCIh5wNyPWEgLJBf9s3xqdNWinB/Amy3?=
 =?us-ascii?Q?ntimT2g71B9obf/ktTudeLiCisU/0royU1jPr4Ndg5xQeFjYVkvdClhCA9nF?=
 =?us-ascii?Q?G+CwQFj18HmnOkjG6GE84b1sNlWISQqRT+OiuG/GcHTgFoMKMCYHQ03E3JG3?=
 =?us-ascii?Q?CHZQCasOsTSbJEEDY4u3emXoOCpSfmTt0FtSes3WJTTtDD9as4KKRKfHUbdv?=
 =?us-ascii?Q?tkAsQ5fRwwVYliFKwgJZv9hgolVj+R0eHxVT6iz7t96EMmUFUmUL3yKQ0cu6?=
 =?us-ascii?Q?3foVFgl1p7DozmievBKez9gF2mCDE6IPfrjcPddAOaKsLENpFAUWSv8dokp9?=
 =?us-ascii?Q?XBLMR4EMWwP3z4creXPeuj9EIJbCsAQ9CuZk3nVxTWR2V9tkd8oKssuXPFtA?=
 =?us-ascii?Q?uCH5pzHjJbkV27uIWzhpkd21bTlMSWCBzIKah7i8DPE1qM8nxibgPGV5ox9h?=
 =?us-ascii?Q?WkALK7zTNOc58FDszhsJRuuBk70Wj6VVpVkbSS+TPEW7JQHUyysy3Dw5bX25?=
 =?us-ascii?Q?klBkqA5CGScjl6KYy/IQeWDeSGtwYggllPkC0KQDafbgJ9TjdLb7lNGnhhKi?=
 =?us-ascii?Q?8fdYr2NUh5Y5MGjltjAFxT43YNrSYf4jQ3SA6QDeC/Kq3cBLp75B9BHVQCxQ?=
 =?us-ascii?Q?71VQwejvTAMiFVbYz/9CSkBzY03l91lXD67GzD2r7h1AakM1cXFFcllDm8VR?=
 =?us-ascii?Q?wB7JuK0aBXBAqBjtvirlLZtibDxEwbJbq0et25l2uhXTJG+ibOtXU5QbKnta?=
 =?us-ascii?Q?nIr41QF1ZXdWaZt3l9TY+gf9BhM7Q+sOxDiwm/gVInODIuGCCKAjqXjLG/8W?=
 =?us-ascii?Q?iXo0v8uyi/XBpyZ1N7v+rE0VMZRJQSAQ520hfPpONOzGaVdt96xCACgvWT9j?=
 =?us-ascii?Q?c4F28WJM89URUqpcOIfuz7Lx4SNEKNShMUl2u3bQqtaccGj3ucluxonmqOzr?=
 =?us-ascii?Q?79FKovgwqaLdmi67+29Ap6NV+mbSbTcJ6nTcwnPJSlhNUA5RM2BxTV2LUQRA?=
 =?us-ascii?Q?1micKib4B4ekCzqTQQVswPi1tFeHm5qj8VunRN08vwUE/Z4u9smDUSftTkET?=
 =?us-ascii?Q?5LqgHetwxWwPAr0ws+EMXpdFIv02wi/+T9Eu6dI+0n6OBDHIhg=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1704e560-b730-41e9-2a0e-08deaed8cb34
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 21:12:08.2835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF371656EDC
X-Mailman-Approved-At: Sun, 10 May 2026 23:44:29 +0200
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

On Wed, May 06, 2026 at 05:14:43PM +0200, Quentin Schulz wrote:
> Hi Chris,
> 
> On 4/27/26 7:55 PM, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the Anbernic RG-DS dual-screen handheld gaming device.
> > 
> 
> Can you please augment the commit log to specify why we need to list
> clock-names in CONFIG_OF_SPL_REMOVE_PROPS? It's quite important as it's not
> meant to be an oversight! Verbatim what you said in v1 as an answer to my
> question is perfectly fine :)
> 
> I'm a bit puzzled as to why removing clock-names (I'm assumign the one in
> &rk817) helps. Isn't clocks property still here? Don't have time to
> investigate today though.

I've double checked, and it *does* not appear that it's necessary to specify.
So I've eliminated it from the config file.

> 
> > Link: https://anbernic.com/products/rgds
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> > Changes since V1:
> >   - Added entry to doc/board/rockchip/rockchip.rst.
> >   - Removed &sdhci and added &vccio_sd to u-boot device tree.
> >   - Added rk3568 to board path.
> >   - Corrected defconfig and include files in MAINTAINERS.
> >   - Removed CONFIG_EFI_LOADER, CONFIG_LEGACY_IMAGE_FORMAT, and
> >     CONFIG_DISABLE_CONSOLE from defconfig.
> > ---
> >   .../arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi | 41 +++++++++++
> >   arch/arm/mach-rockchip/rk3568/Kconfig         |  7 ++
> >   board/anbernic/rg-ds_rk3568/Kconfig           | 12 +++
> >   board/anbernic/rg-ds_rk3568/MAINTAINERS       |  7 ++
> >   configs/anbernic-rg-ds-rk3568_defconfig       | 73 +++++++++++++++++++
> >   doc/board/rockchip/rockchip.rst               |  1 +
> >   include/configs/anbernic-rg-ds-rk3568.h       | 12 +++
> >   7 files changed, 153 insertions(+)
> >   create mode 100644 arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> >   create mode 100644 board/anbernic/rg-ds_rk3568/Kconfig
> >   create mode 100644 board/anbernic/rg-ds_rk3568/MAINTAINERS
> >   create mode 100644 configs/anbernic-rg-ds-rk3568_defconfig
> >   create mode 100644 include/configs/anbernic-rg-ds-rk3568.h
> > 
> > diff --git a/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..00d57104775
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
> > @@ -0,0 +1,41 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include "rk356x-u-boot.dtsi"
> 
> We know it's based on rk3568, so include rk3568-u-boot.dtsi instead.
> Considering all other boards are including this, I guess it's fine for now
> and a follow-up patch to change them all would be ok.
> 

Done, I'll make the change.

> [...]
> 
> > diff --git a/configs/anbernic-rg-ds-rk3568_defconfig b/configs/anbernic-rg-ds-rk3568_defconfig
> > new file mode 100644
> > index 00000000000..34528b22420
> > --- /dev/null
> > +++ b/configs/anbernic-rg-ds-rk3568_defconfig
> > @@ -0,0 +1,73 @@
> > +CONFIG_ARM=y
> > +CONFIG_SKIP_LOWLEVEL_INIT=y
> > +CONFIG_COUNTER_FREQUENCY=24000000
> > +CONFIG_ARCH_ROCKCHIP=y
> > +CONFIG_SPL_GPIO=y
> > +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-anbernic-rg-ds"
> > +CONFIG_ROCKCHIP_RK3568=y
> > +CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
> > +CONFIG_SPL_SERIAL=y
> > +CONFIG_TARGET_ANBERNIC_RG_DS_RK3568=y
> > +CONFIG_SYS_LOAD_ADDR=0xc00800
> > +CONFIG_DEBUG_UART_BASE=0xFE660000
> > +CONFIG_DEBUG_UART_CLOCK=24000000
> > +CONFIG_DEBUG_UART=y
> > +CONFIG_FIT=y
> > +CONFIG_FIT_VERBOSE=y
> > +CONFIG_SPL_FIT_SIGNATURE=y
> > +CONFIG_SPL_LOAD_FIT=y
> > +CONFIG_OF_STDOUT_VIA_ALIAS=y
> > +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-anbernic-rg-ds.dtb"
> > +# CONFIG_CONSOLE_MUX is not set
> > +CONFIG_BOARD_TYPES=y
> > +# CONFIG_DISPLAY_CPUINFO is not set
> > +CONFIG_DISPLAY_BOARDINFO_LATE=y
> > +CONFIG_BOARD_RNG_SEED=y
> > +CONFIG_SPL_MAX_SIZE=0x40000
> > +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> > +CONFIG_SPL_POWER=y
> > +CONFIG_SPL_ATF=y
> > +CONFIG_CMD_PWM=y
> > +CONFIG_CMD_GPT=y
> > +CONFIG_CMD_MMC=y
> > +# CONFIG_CMD_SETEXPR is not set
> > +# CONFIG_CMD_CLS is not set
> > +# CONFIG_SPL_DOS_PARTITION is not set
> > +CONFIG_SPL_OF_CONTROL=y
> > +CONFIG_OF_LIVE=y
> > +CONFIG_OF_LIST="rockchip/rk3568-anbernic-rg-ds"
> > +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> > +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> > +CONFIG_NO_NET=y
> 
> Please disable NET instead of enabling NO_NET, I would like all users of
> NO_NET to eventually stop using it so we can get rid of it (or make it a
> transitional Kconfig symbol once our kbuild supports it).
> 
> Looks good to me otherwise!
> 

Done, thank you.

> Cheers,
> Quentin
