Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43C7C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 05:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD00987BD6;
	Tue,  5 Mar 2024 06:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Qorg2eFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB59D87D1A; Tue,  5 Mar 2024 06:40:57 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B513879F6
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 06:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1709617254;
 bh=UjOW1pPCxYBj8+NBre8vhAKkCZZXj679fMgFD14JEBE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Qorg2eFYVkEoJIzSezoHr7si4ofdmV+53N56o9MXJUCAVKAGBcrRJ6FRq3HDpTPmy
 DKNeNQsv3KsC2g1jKZqVra143Y55wp+O2zIL46w8hI2aOWmMujgpPl0apQJaeuR+sG
 5GFLp8ExjGRWORzoh9X2EsB7LIlwikg1LTW8GysqG2sKnWpTMJiwgpfc75c+/tZlEF
 Xmq3xAy1acC877K98e5+bAVSXR2Fmn3s6N2NhE2jWf1Jx7tHb2J2ZfJKilLfNemK/J
 jI1Gv6coDY+TAksDN5qWMCBr5IlnkT4zfwIq52ikkjzVdf+0JaOntl3NuLkxwsahpz
 WLj9Wk+bpn9MA==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id E5CEA3780627;
 Tue,  5 Mar 2024 05:40:52 +0000 (UTC)
Message-ID: <cbe1b045-b8f1-4ea2-b831-2dbb52aade35@collabora.com>
Date: Tue, 5 Mar 2024 07:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: rock5a: enable environment
To: Trevor Woerner <twoerner@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>, Weizhao Ouyang
 <o451686892@gmail.com>, Jagan Teki <jagan@edgeble.ai>
References: <20240305021051.22405-1-twoerner@gmail.com>
 <20240305021051.22405-3-twoerner@gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20240305021051.22405-3-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 3/5/24 04:10, Trevor Woerner wrote:
> Following the pattern of other Rockchip devices, enable the U-Boot
> environment to be stored in MMC. This patch specifically assumes the
> environment will be stored on the SDcard.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  configs/rock5a-rk3588s_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
> index a6471a519514..ac6411667d9a 100644
> --- a/configs/rock5a-rk3588s_defconfig
> +++ b/configs/rock5a-rk3588s_defconfig
> @@ -8,6 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
> +CONFIG_ENV_SIZE=0x8000
>  CONFIG_DEFAULT_DEVICE_TREE="rk3588s-rock-5a"
>  CONFIG_ROCKCHIP_RK3588=y
>  CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> @@ -48,6 +49,8 @@ CONFIG_CMD_REGULATOR=y
>  CONFIG_SPL_OF_CONTROL=y
>  CONFIG_OF_LIVE=y
>  CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_MMC_ENV_DEV=1
>  CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_SPL_REGMAP=y
>  CONFIG_SPL_SYSCON=y


Hi Trevor,

What will happen if there is no Sd-Card, and we boot from eMMC or SPI flash ?

The rockchip pattern is usually to have a standard config for all boards and it is
not stored anywhere.

Kever, Jonas, please correct me if I am wrong.

Eugen
