Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535AEC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 14:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B613E8824A;
	Thu, 16 May 2024 16:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BkrmfBJm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40DB48828E; Thu, 16 May 2024 16:04:14 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE2788824A
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 16:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ba09=MU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1715868242;
 bh=z17AzaYlpZOS/JqTVQwDA84sBBh3ezvooe2jW9PxIHU=;
 b=BkrmfBJm6atlQcDvP53NRw2oX5tdnvr638QSND+cQJOG0vndHxYqX2Qr1oJsUk0+kyWGAmzY5
 0tD5m1DmYvyqjpnvUen70WHqIEVe8bV+WSUFTqq/wBvcwY8mQ40ogo22EPbnIFd3MlG+0U5LvUv
 3jtMkUE6ijNgNZMJDgoqLfYMc/0xirW9xp3YxOIgluaa0LT/65jKC6r1Sp8wWS7sOI80Ac6P8Hl
 UFc5PyTCyPODwG7YjMNlP724NBmu6ZduAujfGdYylhAxqIMuHvtLZiOYFEm8+59uNLUr2K4KfJA
 XyLPLcvFTw1iqBVtFe7+n10urSnmC+tGGjzhnxifbh5w==
Message-ID: <2c80d230-7f7b-413f-88f6-f5155414197c@kwiboo.se>
Date: Thu, 16 May 2024 16:03:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] arm: rockchip: Enable display cpuinfo to be build
 with SPL_BUILD
To: Anand Moon <anand@edgeble.ai>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de
References: <20240516090031.2373-1-anand@edgeble.ai>
 <20240516090031.2373-6-anand@edgeble.ai>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240516090031.2373-6-anand@edgeble.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66461250901da2d244f4267e
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
> Changes help enable CONFIG_DISPLAY_CPUINFO to build with SPL_BUILD for
> SoC RK356x and RK3588.
> 
> Cc: Jagan Teki <jagan@edgeble.ai>
> Signed-off-by: Anand Moon <anand@edgeble.ai>
> ---
>  arch/arm/mach-rockchip/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> index c07bdaee4c..6722e7c9ea 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -25,7 +25,7 @@ obj-y += boot_mode.o
>  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
>  endif
>  
> -ifeq ($(CONFIG_TPL_BUILD),)
> +ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)

Suggest you move the cpu-info.o line inside the ifeq/endif block above.

Regards,
Jonas

>  obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
>  endif
>  

