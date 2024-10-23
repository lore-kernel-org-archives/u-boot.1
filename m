Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B901CFA45F
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 19:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857D489092;
	Wed, 23 Oct 2024 21:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vvxVSnKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B28B88DEF; Wed, 23 Oct 2024 21:10:25 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AF8B8931D
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 21:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=SRS0=1a9f=RU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1729710579;
 bh=IlWbvY1ll0mXS0PPIPk3kRHi7fv0pxJMkUPjuiep+ls=;
 b=vvxVSnKF/2uqeFdYUTVv9NKUBQ1NDwem8ERWVjT1+GVqaQk4t+e0/GPhAf+s+RyOn97nYrQmE
 lKysfjSLsTvsj/+rN99Hnn0U+UkpQrYXUVDGZ317Kqd8j2ylojPhUHD6tjDKetqx+l5j7bNgB8k
 PFX9bhjwIBc43VGk85SnLu+jWTOjEHJ/K1amRgciPLYYCEnMnQUIfKG1cWvxLG8WreO7nPOr1Eu
 bEZCVUff1ECrlOQIp3iVVw6hyYk0pRlQv5bzZYNvCN1/ujJHXoZwVLIqsMgOPqUSAKumvZN1zTw
 GF+Qqy85Q7P0Sj3D7Srj+nECClF113/79VhnhcE1Yd8g==
Message-ID: <4dcb2c33-eac9-4f33-883b-95ed89893b31@kwiboo.se>
Date: Wed, 23 Oct 2024 21:09:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: orangepi-3b-rk3566_defconfig: Enable
 CONFIG_MULTI_DTB_FIT
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Ricardo Pardini
 <ricardo@pardini.net>, Tom Rini <trini@konsulko.com>
References: <20241023085225.403545-1-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241023085225.403545-1-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 671949f3ef4e1f7bb2995cfb
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

Hi,

On 2024-10-23 10:52, Jianfeng Liu wrote:
> Orange Pi 3B uses board_fit_config_name_match in rk_board_late_init to
> decide which kernel dtb to load. To make it work with system using grub,
> we have to enable CONFIG_MULTI_DTB_FIT.
> 
> Tested with opensuse using grub2, without CONFIG_MULTI_DTB_FIT grub will
> load rk3566-orangepi-3b.dtb in u-boot, which has no gmac ethernet
> enabled.
> 
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---
> 
>  configs/orangepi-3b-rk3566_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/orangepi-3b-rk3566_defconfig b/configs/orangepi-3b-rk3566_defconfig
> index 2181c9caf58..e87849a9946 100644
> --- a/configs/orangepi-3b-rk3566_defconfig
> +++ b/configs/orangepi-3b-rk3566_defconfig
> @@ -48,6 +48,7 @@ CONFIG_SPL_OF_CONTROL=y
>  CONFIG_OF_LIVE=y
>  # CONFIG_OF_UPSTREAM is not set
>  CONFIG_OF_LIST="rk3566-orangepi-3b rk3566-orangepi-3b-v1.1 rk3566-orangepi-3b-v2.1"
> +CONFIG_MULTI_DTB_FIT=y

SPL should call spl_simple_fit_parse() -> fit_find_config_node() ->
board_fit_config_name_match() to select correct FIT configuration and
load correct FDT for U-Boot proper.

Based on runtime testing making board_fit_config_name_match() always
return EINVAL in SPL, I did not see this Kconfig option help U-Boot
proper load correct FDT. It only made my debug log print out:

  fit_find_config_node: Cannot find /configurations node: -1

And U-Boot proper still used the base "Model: Xunlong Orange Pi 3B".
Not sure if this behavior is different when vendor SPL is used.

From my understanding your issue may have been because of a mixture of
older SPL and newer U-Boot proper, and was not really fixed by this
Kconfig option?

Unless there is other uses for MULTI_DTB_FIT, e.g. if it is required to
load correct FDT from a kernel FIT with multiple FDTs, I think we can
skip adding this Kconfig option.

Regards,
Jonas

>  CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_SPL_DM_SEQ_ALIAS=y

