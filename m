Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD3EF417E3
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 14:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 696A983BC7;
	Mon,  9 Mar 2026 15:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="H2Yxh7bQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6962483BC8; Mon,  9 Mar 2026 15:33:08 +0100 (CET)
Received: from mail-m49231.qiye.163.com (mail-m49231.qiye.163.com
 [45.254.49.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A35C83952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 15:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.154])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3646e7fd8;
 Mon, 9 Mar 2026 22:32:59 +0800 (GMT+08:00)
Message-ID: <c4d9304e-642c-4dcf-b934-7af0cbe649c0@rock-chips.com>
Date: Mon, 9 Mar 2026 22:32:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm: rockchip: don't use non-existent
 CONFIG_TPL_TINY_FRAMEWORK
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, u-boot@lists.denx.de
References: <20260225072817.50994-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260225072817.50994-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd303fcc203afkunm6edcfd6216bb707
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0tJVk9CTBoYTUlIGEgaHVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk5PWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=H2Yxh7bQzUpyi6auA86u7uKolPh9PvDfoM66gT7O6FrOTflr/9DBH+EDGSNzRL66y8ePEkrrMrxOQxkcEKzie6f5fKV/OGo7IGJTpJGn1N8NEPPw8O4VbrTnR0loU61WvFVQdedxj+jIYdBBTp56iJVnqyg0BgzlLUWBqxhkoio=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=tg4Ni590uG4KmWkkJJ2iISSSkonZ7dYbH2eTDWo7w8A=;
 h=date:mime-version:subject:message-id:from;
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


On 2026/2/25 15:28, Heinrich Schuchardt wrote:
> Symbol CONFIG_TPL_TINY_FRAMEWORK does not exist.
> Don't select it.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 92bb4aa62f1..d00820b34bb 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -8,7 +8,6 @@ config ROCKCHIP_PX30
>   	select SUPPORT_TPL
>   	select SPL
>   	select TPL
> -	select TPL_TINY_FRAMEWORK if TPL
>   	select TPL_HAVE_INIT_STACK if TPL
>   	imply SPL_SEPARATE_BSS
>   	imply SPL_SERIAL
