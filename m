Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1C3C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 09:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F52A87FEE;
	Tue,  5 Mar 2024 10:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wta3XM82";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60A5388002; Tue,  5 Mar 2024 10:56:23 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA3FB879A0
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 10:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8d7b=KL=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1709632566;
 bh=MXq5koU1tbPyTmzhLetq8XmIcB13auNKLujKI6fPvEM=;
 b=wta3XM82EbifdBdjBQD9LIWu526Lv7rzzUZ6aAG89fF2YBdJJC76MR0S2PxuXpGhswWwWnvxG
 Mq/TePNK+baImtD19JH343V7N9/BFVMbhiI9EgrmUACE2jwWJPUk1RJ9+kTMN36lBXXXQSxdlfs
 XeBQEgw5iuDIwOkT9pTeYFMvNB2wUpkWEwbOQS2LellXHfNcQyYqA/+Fw3VQvopyYxafteVpZ3z
 74GLmdB7WMP8fmWLa54VVPWv3U7pwYY0L8waC8Y6QfahTIlP1+Jfne4hQXCUxVz/SRcGK/EeUjk
 Ze2qemIjQrYU00dBqboDdvw9faJ6GOc4pcYBAMtm8nAw==
Message-ID: <a0f743f7-8dcc-4aa4-9cfb-7077e385265a@kwiboo.se>
Date: Tue, 5 Mar 2024 10:55:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: rock-pi-s: enable environment
Content-Language: en-US
To: Trevor Woerner <twoerner@gmail.com>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>, Akash Gajjar
 <gajjar04akash@gmail.com>, Tom Rini <trini@konsulko.com>, Kever Yang
 <kever.yang@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>, Massimo
 Pegorer <massimo.pegorer+oss@gmail.com>, Simon Glass <sjg@chromium.org>,
 Pegorer Massimo <Massimo.Pegorer@vimar.com>
References: <20240305021051.22405-1-twoerner@gmail.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240305021051.22405-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65e6ec350c58f90fb4aa53bf
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

Hi Trevor,

On 2024-03-05 03:10, Trevor Woerner wrote:
> Following the pattern of other Rockchip devices, enable the U-Boot environment
> to be stored in MMC. This patch specifically assumes the environment will be
> stored on the SDcard.

This board support optional emmc (sd nand), forcing env to sd-card does
not sound like a good idea, ideally the env is stored in the media where
TPL/SPL is running from.

Please note that booting from emmc is not working in current state, I
have an incoming series to improve support for this and other rk3308
boards. Hoping to have it on list later this week, see [1] for current
work-in-progress patches. It enables full support for usb otg/host, ums,
rockusb, emmc/sd nand, ethernet, ethaddr from serial#, rnd and fit
checksum validation on this board (tested on a v1.3 board).

[1] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3308-2024.04

Regards,
Jonas

> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  configs/rock-pi-s-rk3308_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
> index 9908a4b4f457..af2cddcc2553 100644
> --- a/configs/rock-pi-s-rk3308_defconfig
> +++ b/configs/rock-pi-s-rk3308_defconfig
> @@ -54,7 +54,9 @@ CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
>  CONFIG_SPL_OF_CONTROL=y
>  CONFIG_OF_LIVE=y
>  CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_IS_IN_MMC=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_DEV=1
>  CONFIG_REGMAP=y
>  CONFIG_SYSCON=y
>  CONFIG_CLK=y

