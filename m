Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF82BC54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 10:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AF7588019;
	Tue,  5 Mar 2024 11:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="W18f7xrT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 012038801A; Tue,  5 Mar 2024 11:02:07 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 904F587FFE
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 11:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8d7b=KL=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1709632904;
 bh=d2jR7Av8AqSWUnP7RoA3OoiVQ95+0tJBeFdGgr8gOZY=;
 b=W18f7xrT/ZwYhSgqg534C5aTgeBkONz86I1X5AUuKr4fN63xUJbF955GTZgonjTXOirmRVK9x
 yHNz052BqKVG1nY2dWBqcY0a+r+cS9z82tE697u1CQzuv6sh2v0pjAaioYn7lMmwpFqX3SyExCI
 ebXvN9OwQEteAvtecBQNLMvIq9fi/OeYSvcRJfuLpUhxw6wDu2J3gSQH3ClGQRH+rYuP8pJjGhX
 xh0WVJZk4Qxb//n2Gq1I66LAnSoc6ElmAkUfpk+WTamtuAM2P8zl7Y0vA7Ch5dnkBYBAzTyoIbU
 CxKqG62Lus4ALq+W+WK8qHaT2rC3b3ozt1wfM6Zmzi6w==
Message-ID: <a4a592c8-9693-4789-ac68-07c1b23ef570@kwiboo.se>
Date: Tue, 5 Mar 2024 10:29:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: rock3a: enable environment
Content-Language: en-US
To: Trevor Woerner <twoerner@gmail.com>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>, Akash Gajjar
 <gajjar04akash@gmail.com>, Tom Rini <trini@konsulko.com>, Kever Yang
 <kever.yang@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>, Simon Glass
 <sjg@chromium.org>, Jagan Teki <jagan@edgeble.ai>
References: <20240305021051.22405-1-twoerner@gmail.com>
 <20240305021051.22405-2-twoerner@gmail.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240305021051.22405-2-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65e6e60f0c58f90fb4aa518c
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
> Following the pattern of other Rockchip devices, enable the U-Boot
> environment to be stored in MMC. This patch specifically assumes the
> environment will be stored on the SDcard.

This board has SPI flash, so storing env in SPI flash is probably a
better default. However, preferably the env should be stored/loaded from
the same device that TPL/SPL was loaded from.

What is your use case for being able to store the env? Personally, I have
never had a need for storing an env and use ENV_IS_NOWHERE on my boards.

Regards,
Jonas

> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  configs/rock-3a-rk3568_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
> index 28d157dbd7a7..44158a4d34f1 100644
> --- a/configs/rock-3a-rk3568_defconfig
> +++ b/configs/rock-3a-rk3568_defconfig
> @@ -58,6 +58,8 @@ CONFIG_CMD_REGULATOR=y
>  CONFIG_SPL_OF_CONTROL=y
>  CONFIG_OF_LIVE=y
>  CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_MMC_ENV_DEV=1
>  CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_SPL_REGMAP=y
>  CONFIG_SPL_SYSCON=y

