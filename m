Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631FEC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 06:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B442588CDF;
	Thu,  2 May 2024 08:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="tNvMjItU";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="FoykHzqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D366F88D0D; Thu,  2 May 2024 08:50:28 +0200 (CEST)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ED11882CC
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 08:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id f3a1f8f9;
 Thu, 2 May 2024 06:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=he
 hOA5f8LTYyOyXvmmQweRCihjM=; b=tNvMjItUtAz23fOStiH3uFnrX+O645cd+2
 0094h8DkpNQFgvarv1JbQOEtuqR1QEfC/nlll80232FeUZnYaWB2yoBIFb5tUJKn
 ThWR6A+ON3o/v3iJUzV35wOV2eh1zEb+rE1ABJ+IE8q2FUy4T1YMarjq2szAy6n9
 seNTtB0Dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 tzCGdkMrmx4D8cRK5rsnRC1QLo6bk7YQWggTNO3cZcl9iL8/oBsGp3VWcUFB3pck
 I0i0htoXrNnV9QoCaxpZs9OO91o7+B98ga3jdVJjm9IDQvdYDSTcQIzToqOP2Klt
 U4h6tvCUsjwN+JN3krci5nXtT+7gHDusERj0ckaULKQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1714632622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEEm4DpkcC/VVWtIlP4xCBubCWhxKanE4+WmdKLtUes=;
 b=FoykHzqP92Lxufo7ZwZARp0HFZxkdp7Pdlrtj+6cDYImBi2CH8t5zozDqfsH1KCz7gR1OM
 m1/+qUTOsxYu8L8xzcXOLW5QbuTT6PJFWXwd8p4ecwj9w6UZ6Lc2BkFCAH1oIg0/uqI0h6
 Z+KqSZ+mBXyrrC8vF2vAGgh/AuWupm0=
Received: from [192.168.0.2] (host-79-16-6-199.retail.telecomitalia.it
 [79.16.6.199])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 77c3e0f4
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 2 May 2024 06:50:22 +0000 (UTC)
Message-ID: <14c0cf39-c80d-4c7d-be17-76f1f51a8163@kernel-space.org>
Date: Thu, 2 May 2024 08:49:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 78/81] watchdog: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Michal Simek <michal.simek@amd.com>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 Huan Wang <alison.wang@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Priyanka Jain <priyanka.jain@nxp.com>,
 Michael Walle <michael@walle.cc>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-78-trini@konsulko.com>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20240502013138.2383421-78-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Tom,

Acked-by: Angelo Dureghello <angelo@kernel-space.org>


On 02/05/24 3:31 AM, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Stefan Roese <sr@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> Cc: Huan Wang <alison.wang@nxp.com>
> Cc: Angelo Dureghello <angelo@kernel-space.org>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Priyanka Jain <priyanka.jain@nxp.com>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   drivers/watchdog/armada-37xx-wdt.c   | 1 -
>   drivers/watchdog/ast2600_wdt.c       | 1 -
>   drivers/watchdog/ast_wdt.c           | 1 -
>   drivers/watchdog/at91sam9_wdt.c      | 1 -
>   drivers/watchdog/bcm6345_wdt.c       | 1 -
>   drivers/watchdog/cdns_wdt.c          | 1 -
>   drivers/watchdog/cortina_wdt.c       | 1 -
>   drivers/watchdog/designware_wdt.c    | 1 -
>   drivers/watchdog/ftwdt010_wdt.c      | 1 -
>   drivers/watchdog/imx_watchdog.c      | 1 -
>   drivers/watchdog/mcf_wdt.c           | 2 +-
>   drivers/watchdog/mpc8xxx_wdt.c       | 1 -
>   drivers/watchdog/mt7621_wdt.c        | 1 -
>   drivers/watchdog/mtk_wdt.c           | 1 -
>   drivers/watchdog/omap_wdt.c          | 1 -
>   drivers/watchdog/orion_wdt.c         | 1 -
>   drivers/watchdog/rti_wdt.c           | 1 -
>   drivers/watchdog/s5p_wdt.c           | 1 -
>   drivers/watchdog/sandbox_alarm-wdt.c | 1 -
>   drivers/watchdog/sandbox_wdt.c       | 1 -
>   drivers/watchdog/sbsa_gwdt.c         | 1 -
>   drivers/watchdog/sl28cpld-wdt.c      | 1 -
>   drivers/watchdog/sp805_wdt.c         | 1 -
>   drivers/watchdog/stm32mp_wdt.c       | 1 -
>   drivers/watchdog/tangier_wdt.c       | 1 -
>   drivers/watchdog/ulp_wdog.c          | 1 -
>   drivers/watchdog/wdt-uclass.c        | 1 -
>   drivers/watchdog/xilinx_tb_wdt.c     | 1 -
>   drivers/watchdog/xilinx_wwdt.c       | 1 -
>   29 files changed, 1 insertion(+), 29 deletions(-)
>
> diff --git a/drivers/watchdog/armada-37xx-wdt.c b/drivers/watchdog/armada-37xx-wdt.c
> index e09f5ac9e34e..4b51178e1b8c 100644
> --- a/drivers/watchdog/armada-37xx-wdt.c
> +++ b/drivers/watchdog/armada-37xx-wdt.c
> @@ -5,7 +5,6 @@
>    * Marek Behún <kabel@kernel.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <wdt.h>
>   #include <asm/global_data.h>
> diff --git a/drivers/watchdog/ast2600_wdt.c b/drivers/watchdog/ast2600_wdt.c
> index bc9842089bea..190490f3692b 100644
> --- a/drivers/watchdog/ast2600_wdt.c
> +++ b/drivers/watchdog/ast2600_wdt.c
> @@ -3,7 +3,6 @@
>    * Copyright (c) 2020 Aspeed Technology, Inc
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
> diff --git a/drivers/watchdog/ast_wdt.c b/drivers/watchdog/ast_wdt.c
> index f7b5a1adc108..e61e13fdc49d 100644
> --- a/drivers/watchdog/ast_wdt.c
> +++ b/drivers/watchdog/ast_wdt.c
> @@ -3,7 +3,6 @@
>    * Copyright 2017 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <log.h>
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index 647ae325e9ae..c809a8936b89 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -18,7 +18,6 @@
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <asm/arch/at91_wdt.h>
> -#include <common.h>
>   #include <div64.h>
>   #include <dm.h>
>   #include <errno.h>
> diff --git a/drivers/watchdog/bcm6345_wdt.c b/drivers/watchdog/bcm6345_wdt.c
> index 677b1347ca7a..6ebe901c2b82 100644
> --- a/drivers/watchdog/bcm6345_wdt.c
> +++ b/drivers/watchdog/bcm6345_wdt.c
> @@ -7,7 +7,6 @@
>    *	Copyright (C) 2008 Florian Fainelli <florian@openwrt.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <wdt.h>
> diff --git a/drivers/watchdog/cdns_wdt.c b/drivers/watchdog/cdns_wdt.c
> index 743ab6487bcd..cb5a786c5891 100644
> --- a/drivers/watchdog/cdns_wdt.c
> +++ b/drivers/watchdog/cdns_wdt.c
> @@ -6,7 +6,6 @@
>    * Author(s):	Shreenidhi Shedi <yesshedi@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <wdt.h>
> diff --git a/drivers/watchdog/cortina_wdt.c b/drivers/watchdog/cortina_wdt.c
> index 7ab9d7b2db97..9f09ac0e15ff 100644
> --- a/drivers/watchdog/cortina_wdt.c
> +++ b/drivers/watchdog/cortina_wdt.c
> @@ -4,7 +4,6 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <hang.h>
>   #include <asm/io.h>
> diff --git a/drivers/watchdog/designware_wdt.c b/drivers/watchdog/designware_wdt.c
> index b22e0ee06a4e..bd9d7105366b 100644
> --- a/drivers/watchdog/designware_wdt.c
> +++ b/drivers/watchdog/designware_wdt.c
> @@ -4,7 +4,6 @@
>    */
>   
>   #include <clk.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <reset.h>
>   #include <wdt.h>
> diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
> index 1f5f301b1251..4769b967e527 100644
> --- a/drivers/watchdog/ftwdt010_wdt.c
> +++ b/drivers/watchdog/ftwdt010_wdt.c
> @@ -14,7 +14,6 @@
>    * 22/08/2022 Port to DM
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <wdt.h>
>   #include <log.h>
> diff --git a/drivers/watchdog/imx_watchdog.c b/drivers/watchdog/imx_watchdog.c
> index 894158b304a7..ea770217e590 100644
> --- a/drivers/watchdog/imx_watchdog.c
> +++ b/drivers/watchdog/imx_watchdog.c
> @@ -4,7 +4,6 @@
>    * Licensed under the GPL-2 or later.
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <hang.h>
> diff --git a/drivers/watchdog/mcf_wdt.c b/drivers/watchdog/mcf_wdt.c
> index b36488bb5b96..5092a256af0c 100644
> --- a/drivers/watchdog/mcf_wdt.c
> +++ b/drivers/watchdog/mcf_wdt.c
> @@ -6,7 +6,7 @@
>    *
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <dm.h>
>   #include <hang.h>
>   #include <asm/io.h>
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index f28636ca9015..036ff690d3fd 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -3,7 +3,6 @@
>    * Copyright 2017 CS Systemes d'Information
>    */
>   
> -#include <common.h>
>   #include <env.h>
>   #include <dm.h>
>   #include <wdt.h>
> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> index f7d201b921a1..6308d9632a81 100644
> --- a/drivers/watchdog/mt7621_wdt.c
> +++ b/drivers/watchdog/mt7621_wdt.c
> @@ -9,7 +9,6 @@
>    *   Copyright (C) 2013 John Crispin <blogic@openwrt.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <wdt.h>
>   #include <asm/global_data.h>
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 368b36849c8d..706deb9da846 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -6,7 +6,6 @@
>    * Author: Ryder Lee <ryder.lee@mediatek.com>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <hang.h>
>   #include <wdt.h>
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index f0e57b4f7286..5fd02ddf564f 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -36,7 +36,6 @@
>    *	Use the driver model and standard identifiers; handle bigger timeouts.
>    */
>   
> -#include <common.h>
>   #include <log.h>
>   #include <watchdog.h>
>   #include <asm/ti-common/omap_wdt.h>
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 127766df58af..4562b2a37e34 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -12,7 +12,6 @@
>    * warranty of any kind, whether express or implied.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <clk.h>
>   #include <log.h>
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index 8d93f19b984a..99168d0cad03 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -8,7 +8,6 @@
>    * Derived from linux/drivers/watchdog/rti_wdt.c
>    */
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
> diff --git a/drivers/watchdog/s5p_wdt.c b/drivers/watchdog/s5p_wdt.c
> index 80524a00101b..c244f15a8952 100644
> --- a/drivers/watchdog/s5p_wdt.c
> +++ b/drivers/watchdog/s5p_wdt.c
> @@ -4,7 +4,6 @@
>    * Minkyu Kang <mk7.kang@samsung.com>
>    */
>   
> -#include <common.h>
>   #include <asm/io.h>
>   #include <asm/arch/cpu.h>
>   #include <asm/arch/watchdog.h>
> diff --git a/drivers/watchdog/sandbox_alarm-wdt.c b/drivers/watchdog/sandbox_alarm-wdt.c
> index 71bb5d924ea5..8dbbfc249e7c 100644
> --- a/drivers/watchdog/sandbox_alarm-wdt.c
> +++ b/drivers/watchdog/sandbox_alarm-wdt.c
> @@ -1,4 +1,3 @@
> -#include <common.h>
>   #include <dm.h>
>   #include <os.h>
>   #include <wdt.h>
> diff --git a/drivers/watchdog/sandbox_wdt.c b/drivers/watchdog/sandbox_wdt.c
> index 535614f04d63..cd5eadbfd213 100644
> --- a/drivers/watchdog/sandbox_wdt.c
> +++ b/drivers/watchdog/sandbox_wdt.c
> @@ -3,7 +3,6 @@
>    * Copyright 2017 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <wdt.h>
>   #include <asm/state.h>
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index 96d04665d52c..03585529bb63 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -7,7 +7,6 @@
>   
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> -#include <common.h>
>   #include <dm/device.h>
>   #include <dm/fdtaddr.h>
>   #include <dm/read.h>
> diff --git a/drivers/watchdog/sl28cpld-wdt.c b/drivers/watchdog/sl28cpld-wdt.c
> index af5a6b1a28ac..c5b4f8a9f665 100644
> --- a/drivers/watchdog/sl28cpld-wdt.c
> +++ b/drivers/watchdog/sl28cpld-wdt.c
> @@ -5,7 +5,6 @@
>    * Copyright (c) 2021 Michael Walle <michael@walle.cc>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <wdt.h>
>   #include <sl28cpld.h>
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 6d58fd3cfdab..10fe3e282323 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -8,7 +8,6 @@
>   #include <log.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> -#include <common.h>
>   #include <clk.h>
>   #include <dm/device.h>
>   #include <dm/fdtaddr.h>
> diff --git a/drivers/watchdog/stm32mp_wdt.c b/drivers/watchdog/stm32mp_wdt.c
> index 7ebcd2552668..97ab8cfe7ab1 100644
> --- a/drivers/watchdog/stm32mp_wdt.c
> +++ b/drivers/watchdog/stm32mp_wdt.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_WDT
>   
> -#include <common.h>
>   #include <clk.h>
>   #include <dm.h>
>   #include <log.h>
> diff --git a/drivers/watchdog/tangier_wdt.c b/drivers/watchdog/tangier_wdt.c
> index bdc65597dcff..8fbfac31b1e1 100644
> --- a/drivers/watchdog/tangier_wdt.c
> +++ b/drivers/watchdog/tangier_wdt.c
> @@ -2,7 +2,6 @@
>   /*
>    * Copyright (c) 2017 Intel Corporation
>    */
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <wdt.h>
> diff --git a/drivers/watchdog/ulp_wdog.c b/drivers/watchdog/ulp_wdog.c
> index 0eea04ed2c6e..83f19dc0e86b 100644
> --- a/drivers/watchdog/ulp_wdog.c
> +++ b/drivers/watchdog/ulp_wdog.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2016 Freescale Semiconductor, Inc.
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <asm/io.h>
>   #include <asm/arch/imx-regs.h>
> diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
> index 417e8d7eef95..c88312ec7218 100644
> --- a/drivers/watchdog/wdt-uclass.c
> +++ b/drivers/watchdog/wdt-uclass.c
> @@ -5,7 +5,6 @@
>   
>   #define LOG_CATEGORY UCLASS_WDT
>   
> -#include <common.h>
>   #include <cyclic.h>
>   #include <div64.h>
>   #include <dm.h>
> diff --git a/drivers/watchdog/xilinx_tb_wdt.c b/drivers/watchdog/xilinx_tb_wdt.c
> index b38c40001611..8a8e55370a0e 100644
> --- a/drivers/watchdog/xilinx_tb_wdt.c
> +++ b/drivers/watchdog/xilinx_tb_wdt.c
> @@ -8,7 +8,6 @@
>    * Copyright (c) 2011-2018 Xilinx Inc.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <wdt.h>
> diff --git a/drivers/watchdog/xilinx_wwdt.c b/drivers/watchdog/xilinx_wwdt.c
> index 963ab22fb452..41eff1a46450 100644
> --- a/drivers/watchdog/xilinx_wwdt.c
> +++ b/drivers/watchdog/xilinx_wwdt.c
> @@ -9,7 +9,6 @@
>    */
>   
>   #include <clk.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <regmap.h>
>   #include <wdt.h>
