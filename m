Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D72CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 20:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52B8786F6F;
	Thu, 19 Oct 2023 22:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="pMBWZrMw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1700874B4; Thu, 19 Oct 2023 22:30:33 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D6F86F67
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 22:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
 :Date:subject:date:message-id:reply-to;
 bh=4K/wVhrack2ySLcyMpK06viSaW0t/90+h87cjpvUS1Q=; b=pMBWZrMwp8xj8LltSHjluTFb1o
 g8plymSvSqUE1Laa4reQhVCGBC4L0iYXp2ZP2zjkoEK9LIzu1EHO7489d+cIwwO2x8CR/TPttzbCi
 IA+ohSMynKZ83a7r65ouK4R4dCiU9He/Zpk5bLux47GNeoUsKM6hiankpgBrI99x/Vq4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55572
 helo=pettiford) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1qtZf1-0000LF-3N; Thu, 19 Oct 2023 16:30:29 -0400
Date: Thu, 19 Oct 2023 16:30:26 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, Fabio Estevam
 <festevam@denx.de>
Message-Id: <20231019163026.9546f04cb2eb26cd5ca41d0a@hugovil.com>
In-Reply-To: <20231019192155.1735199-2-festevam@gmail.com>
References: <20231019192155.1735199-1-festevam@gmail.com>
 <20231019192155.1735199-2-festevam@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH v2 2/2] mx8mp_evk: Remove unneeded header files
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

On Thu, 19 Oct 2023 16:21:55 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> From: Fabio Estevam <festevam@denx.de>
> 
> Cleanup the file by removing unneeded header files.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - Newly introduced. (Hugo)
> 
>  board/freescale/imx8mp_evk/imx8mp_evk.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.c b/board/freescale/imx8mp_evk/imx8mp_evk.c
> index 42291c958e39..e62e27db48d9 100644
> --- a/board/freescale/imx8mp_evk/imx8mp_evk.c
> +++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
> @@ -3,18 +3,8 @@
>   * Copyright 2019 NXP
>   */
>  
> -#include <common.h>
>  #include <env.h>
> -#include <errno.h>
> -#include <init.h>
> -#include <linux/delay.h>
>  #include <asm/global_data.h>
> -#include <asm/mach-imx/iomux-v3.h>
> -#include <asm-generic/gpio.h>
> -#include <asm/arch/imx8mp_pins.h>
> -#include <asm/arch/clock.h>
> -#include <asm/arch/sys_proto.h>
> -#include <asm/mach-imx/gpio.h>
>  
>  DECLARE_GLOBAL_DATA_PTR;

Hi Fabio,
after that, do you even need DECLARE_GLOBAL_DATA_PTR and its associated
header file?

Hugo.
