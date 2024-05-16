Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C38C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 14:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB72B8829E;
	Thu, 16 May 2024 16:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="bvZlzPRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF3CD88297; Thu, 16 May 2024 16:17:49 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43EC188003
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 16:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ba09=MU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1715869058;
 bh=cEYgROBzvmuy+S3B2tMvnnhQP19JhEN72rsrlhN8J80=;
 b=bvZlzPRE2RCKQ8jsGARAvxn3JaSG8wPAYHIkrtSL6G6gqTRxAXOc8crhnbdCgAisSrK6Jz3A5
 MoDH5gAJV4hfCMBXyh1L1H+ybVA0TwnIBRmhY9/u/wOj4gPPK82h/M+xUBadtrnb9dv3VYWmdh4
 Qp3dxq0xrJLuWgNW1CjKxKIqpZfamfilS3otSF+dknDUsePpN9qwN6KwtYu0Emc2KJPoHKMGLWi
 GODP8tLw2fsUrS9BqN5shI9vue2Rmw+lhCuUMQYkLSK+30XtRSFBJwVTkpZv0h4ER6foxuTeM+a
 Lz2dLvDcYD7V93Twj0LRwoExBTO1oWXxfEZ8mLsIZnMg==
Message-ID: <d7230a5d-e74a-4b12-9e97-b19e8024afab@kwiboo.se>
Date: Thu, 16 May 2024 16:17:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] rockchip: RK3568: Read the reset cause from clock
 reset unit for RK356x SoC
To: Anand Moon <anand@edgeble.ai>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de
References: <20240516090031.2373-1-anand@edgeble.ai>
 <20240516090031.2373-7-anand@edgeble.ai>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240516090031.2373-7-anand@edgeble.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6646158061b373473707346f
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

Hi Anand,

On 2024-05-16 10:59, Anand Moon wrote:
> Read the reset cause from clock reset unit for RK356x SoC.
> 
> Cc: Jagan Teki <jagan@edgeble.ai>
> Signed-off-by: Anand Moon <anand@edgeble.ai>
> ---
>  arch/arm/mach-rockchip/cpu-info.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
> index 77833c8fce..114608b506 100644
> --- a/arch/arm/mach-rockchip/cpu-info.c
> +++ b/arch/arm/mach-rockchip/cpu-info.c
> @@ -12,6 +12,8 @@
>  #include <asm/arch-rockchip/cru_rk3328.h>
>  #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3399)
>  #include <asm/arch-rockchip/cru_rk3399.h>
> +#elif IS_ENABLED(CONFIG_ROCKCHIP_RK33568)
> +#include <asm/arch-rockchip/cru_rk3568.h>
>  #endif
>  #include <asm/arch-rockchip/hardware.h>
>  #include <linux/err.h>
> @@ -22,6 +24,8 @@ char *get_reset_cause(void)
>  	struct rk3328_cru *cru = rockchip_get_cru();
>  #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3399)
>  	struct rockchip_cru *cru = rockchip_get_cru();
> +#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3568)
> +	struct rk3568_cru *cru = rockchip_get_cru();

This is strictly not needed for RK3568 after the commit 6e710897aa31
("rockchip: cru: Enable cpu info support for rk3568").

Suggest you use same/similar workaround or cleanup the include/define
statement in arch/arm/include/asm/arch-rockchip/cru.h for all SoCs.

Also at least one RK SoC have other bits set in the glb_rst_st reg.

Suggest you add following:

  GLB_RST_MASK		= GENMASK(5, 0),

and use something like:

  switch (cru->glb_rst_st & GLB_RST_MASK) {

or "unknown reset" is reported on affected SoCs.

I have also seen POR always being reported even after a reboot so please
confirm that reset reason works on the SoCs/boards you enable this on.

Regards,
Jonas

>  #endif
>  	char *cause = NULL;
>  

