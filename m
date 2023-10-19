Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FEAC004C0
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 21:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40C5E86F9A;
	Thu, 19 Oct 2023 23:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="ZhuVD22i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F4386FC8; Thu, 19 Oct 2023 23:56:38 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D8A86F9A
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 23:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
 :Date:subject:date:message-id:reply-to;
 bh=LlRFCzIvOw4OT+35wKm2HPRq+vrQeb+QNBKPopu5kiE=; b=ZhuVD22izOE5qxq3q5ULdFH79c
 b+1mhmaKLGEFVu6huM5AzPCHc7gFhWUaTIO0sM/7Zmb2TGnuBSZypJYxsT/iYKvbj9Q3GQRtcO1gJ
 NyyQa1vrU9JCZWzmBwJ0EtVOcr3NH3iApRw9Y3r1AsDM8Joir2nkbYEad3CXMeqX3Bjw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48042
 helo=pettiford) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1qtb0J-0001LD-LG; Thu, 19 Oct 2023 17:56:32 -0400
Date: Thu, 19 Oct 2023 17:56:31 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, Fabio Estevam
 <festevam@denx.de>
Message-Id: <20231019175631.7690b3cd59e7f71f7549b0d7@hugovil.com>
In-Reply-To: <20231019215113.1833803-2-festevam@gmail.com>
References: <20231019215113.1833803-1-festevam@gmail.com>
 <20231019215113.1833803-2-festevam@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH v3 2/2]  imx8mp_evk: Remove unneeded header files
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

On Thu, 19 Oct 2023 18:51:13 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> From: Fabio Estevam <festevam@denx.de>
> 
> Cleanup the file by removing unneeded header files.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>


> ---
> Changes since v2:
> - Also remove <asm/global_data.h> and DECLARE_GLOBAL_DATA_PTR. (Hugo)
> 
>  board/freescale/imx8mp_evk/imx8mp_evk.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.c b/board/freescale/imx8mp_evk/imx8mp_evk.c
> index 42291c958e39..024b46ef8bc2 100644
> --- a/board/freescale/imx8mp_evk/imx8mp_evk.c
> +++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
> @@ -3,20 +3,7 @@
>   * Copyright 2019 NXP
>   */
>  
> -#include <common.h>
>  #include <env.h>
> -#include <errno.h>
> -#include <init.h>
> -#include <linux/delay.h>
> -#include <asm/global_data.h>
> -#include <asm/mach-imx/iomux-v3.h>
> -#include <asm-generic/gpio.h>
> -#include <asm/arch/imx8mp_pins.h>
> -#include <asm/arch/clock.h>
> -#include <asm/arch/sys_proto.h>
> -#include <asm/mach-imx/gpio.h>
> -
> -DECLARE_GLOBAL_DATA_PTR;
>  
>  int board_init(void)
>  {
> -- 
> 2.34.1
> 
> 
