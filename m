Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A94C4829A
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 19:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A7587971;
	Sat, 10 Feb 2024 20:19:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0VX+yE+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A0F8799D; Sat, 10 Feb 2024 20:19:08 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52AF187947
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 20:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f576=JU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707592713;
 bh=L3jUB0Vc/Ion2InRwUkxpcUQQntUsp5EpHCyjZvWnpY=;
 b=0VX+yE+xwF4NRuViLNixKtKYcC780kvulfArss0o295exXKVH30TTphnAaBdBT77NLxv/xpas
 gy8clvucfqfTN+uzL50uxVRaGZUIWwSSB3QKhU+iYts2BYyKyCmQAE6XMaxajFVto8sPRSInLVk
 MtHAdnaxKmQDRviUkgM4wNalvWe5YBPUazOBX/3CCoVxNVG58StgGV+MH1Qdujem/SAcCeThs/3
 fGayfrLdO14VmtCkWgCCCiI4/ovLvD/rRMC9GDP+xt0rSVThhdjnCNewqsCDlEht7eUju3wRbSv
 tCm5aVPzFLAsSM6XAmCAZ1kVqPISLpFUs3/kvJm3sDsQ==
Message-ID: <45cb7235-3760-4ea2-a8c4-21b781bc2b54@kwiboo.se>
Date: Sat, 10 Feb 2024 20:18:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] rockchip: rk3399: regenerate defconfigs
To: "Chen-Yu Tsai" <wens@kernel.org>
Cc: "Chen-Yu Tsai" <wens@csie.org>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tianling Shen <cnsztl@gmail.com>, David Bauer
 <mail@david-bauer.net>, Xiaobo Tian <peterwillcn@gmail.com>, Peter
 Robinson <pbrobinson@gmail.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Loic Devulder <ldevulder@suse.com>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Christopher Obbard
 <chris.obbard@collabora.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Banglang Huang <banglang.huang@foxmail.com>, "Matwey V. Kornilov"
 <matwey.kornilov@gmail.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, u-boot@lists.denx.de
References: <20240210063252.1065611-1-wens@kernel.org>
 <20240210063252.1065611-5-wens@kernel.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240210063252.1065611-5-wens@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c7cc0844c82cfa50b5d8d9
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

Hi Chen-Yu,

On 2024-02-10 07:32, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Regenerate RK3399 defconfigs after adding imply statements.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  configs/chromebook_bob_defconfig          | 2 --
>  configs/chromebook_kevin_defconfig        | 2 --
>  configs/firefly-rk3399_defconfig          | 2 --
>  configs/nanopi-r4s-rk3399_defconfig       | 2 --
>  configs/pinebook-pro-rk3399_defconfig     | 2 --
>  configs/pinephone-pro-rk3399_defconfig    | 2 --
>  configs/puma-rk3399_defconfig             | 2 --
>  configs/roc-pc-mezzanine-rk3399_defconfig | 2 --
>  configs/roc-pc-rk3399_defconfig           | 2 --
>  configs/rock-4c-plus-rk3399_defconfig     | 3 ---
>  configs/rock-4se-rk3399_defconfig         | 3 ---
>  configs/rock-pi-4-rk3399_defconfig        | 3 ---
>  configs/rock-pi-4c-rk3399_defconfig       | 3 ---
>  configs/rock-pi-n10-rk3399pro_defconfig   | 1 -
>  configs/rock960-rk3399_defconfig          | 1 -
>  configs/rockpro64-rk3399_defconfig        | 2 --
>  16 files changed, 34 deletions(-)
> 

[snip]

> diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
> index 18525c8bf504..12587b1eba10 100644
> --- a/configs/rock-4c-plus-rk3399_defconfig
> +++ b/configs/rock-4c-plus-rk3399_defconfig
> @@ -8,7 +8,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>  CONFIG_ENV_OFFSET=0x3F8000
>  CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4c-plus"
> -CONFIG_OF_LIBFDT_OVERLAY=y

This patch seems to also remove a few OF_LIBFDT_OVERLAY, guessing this
was unintentional?

If you are re-spinning this series, please also include change to:
- add CONFIG_MISC=y to ficus-rk3399_defconfig, its required for efuse
- drop CONFIG_ROCKCHIP_OTP=y from nanopi-r4s-rk3399_defconfig, soc have
  efuse or otp and on rk3399 it is efuse

And possible also drop CONFIG_NET_RANDOM_ETHADDR=y from:
- evb-rk3399_defconfig
- ficus-rk3399_defconfig
- khadas-edge-captain-rk3399_defconfig
- khadas-edge-v-rk3399_defconfig
now that these boards will have proper ethaddr.

Regards,
Jonas


