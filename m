Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4859C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 12:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9986681EDD;
	Sun, 30 Mar 2025 14:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lLMtk+/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781698171B; Sun, 30 Mar 2025 12:52:49 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF0080FF7
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 12:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1dca=WR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743331965;
 bh=kFtph2Ue/Nxd7ULDWLxidMPUzbuccIt3Krr2sL7d9vI=;
 b=lLMtk+/Gi3IDLn809aniGZ7/56CZTjEW0uC+1rBtedWothUD/72f3VgVXaQ7FcpWi5Kad8xRK
 ltUKWSNuDDhCVwcPUUbekqYbDWTJkbqAF76eJjvMECnwptC36TBW42wkQ5zK3fMx8Fy0G5LsJ9L
 1S05nRvOGmL/aJHE+oW6Z9T2oVkM4puQnQr6pa4aHRWnMAE8+n6vKnk27zgmkraS4UbsJXtYn+D
 YFBXHVu6iY70+IbqjifsH5W1lAjiSXOkdr7J4Xdfz/OLgSQxvPHscg6utDfR4KWm7STQKjWwNTe
 nPO2pXMlfojB34HMOc4ZnrZgbwJ9GWfjNmEGxnlmq53w==
X-Forward-Email-ID: 67e922790286204565e943d7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <2c9fbc74-aa8e-46e0-a73b-26894442c56f@kwiboo.se>
Date: Sun, 30 Mar 2025 12:52:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: io-domain: Enable by default for all supported
 SoCs
To: Chen-Yu Tsai <wens@kernel.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Chen-Yu Tsai <wens@csie.org>, Akash Gajjar <gajjar04akash@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Deepak Das <deepakdas.linux@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Heiko Stuebner <heiko@sntech.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>,
 Levin Du <djw@t-chip.com.cn>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Nick Xie <nick@khadas.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Peter Robinson
 <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Shantur Rathore <i@shantur.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Xiaobo Tian <peterwillcn@gmail.com>
References: <20250204172319.3361870-1-wens@kernel.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250204172319.3361870-1-wens@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 30 Mar 2025 14:28:18 +0200
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

On 2025-02-04 18:23, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The IO domain driver controls the I/O voltage for various pins,
> MMC included.
> 
> Enable it by default for all supported Rockchip SoCs.

This will also enable the IO domain driver for evb-rk3399_defconfig,
something we want to avoid as that target has typically also been used
as a fallback/generic rk3399 target.

The IO domain driver was excluded from the evb-rk3328_defconfig for that
specific reason.

I have sent a series that adds generic-rk3328/rk3399 targets that can
help replace such use of the evb-rk3328/rk3399 targets. However, I
suggest we keep IO domain driver disabled on the evb targets for one
more release before enabling it. Will shortly send a v2 of the generic
series with ROCKCHIP_IODOMAIN=n for the rk3399 target.

> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
>  configs/chromebook_bob_defconfig             | 1 -
>  configs/chromebook_kevin_defconfig           | 1 -
>  configs/eaidk-610-rk3399_defconfig           | 1 -
>  configs/ficus-rk3399_defconfig               | 1 -
>  configs/firefly-rk3399_defconfig             | 1 -
>  configs/khadas-edge-captain-rk3399_defconfig | 1 -
>  configs/khadas-edge-rk3399_defconfig         | 1 -
>  configs/khadas-edge-v-rk3399_defconfig       | 1 -
>  configs/leez-rk3399_defconfig                | 1 -
>  configs/nanopc-t4-rk3399_defconfig           | 1 -
>  configs/nanopi-m4-2gb-rk3399_defconfig       | 1 -
>  configs/nanopi-m4-rk3399_defconfig           | 1 -
>  configs/nanopi-m4b-rk3399_defconfig          | 1 -
>  configs/nanopi-neo4-rk3399_defconfig         | 1 -
>  configs/nanopi-r4s-rk3399_defconfig          | 1 -
>  configs/orangepi-rk3399_defconfig            | 1 -
>  configs/pinebook-pro-rk3399_defconfig        | 1 -
>  configs/pinephone-pro-rk3399_defconfig       | 1 -
>  configs/puma-rk3399_defconfig                | 1 -
>  configs/ringneck-px30_defconfig              | 1 -
>  configs/roc-pc-mezzanine-rk3399_defconfig    | 1 -
>  configs/roc-pc-rk3399_defconfig              | 1 -
>  configs/rock-4c-plus-rk3399_defconfig        | 1 -
>  configs/rock-4se-rk3399_defconfig            | 1 -
>  configs/rock-pi-4-rk3399_defconfig           | 1 -
>  configs/rock-pi-4c-rk3399_defconfig          | 1 -
>  configs/rock-pi-n10-rk3399pro_defconfig      | 1 -
>  configs/rock-pi-s-rk3308_defconfig           | 1 -
>  configs/rock-s0-rk3308_defconfig             | 1 -
>  configs/rock960-rk3399_defconfig             | 1 -
>  configs/rockpro64-rk3399_defconfig           | 1 -
>  drivers/misc/Kconfig                         | 6 +++++-
>  32 files changed, 5 insertions(+), 32 deletions(-)
> 

Please add following to evb-rk3399_defconfig in a v2.

  # CONFIG_ROCKCHIP_IODOMAIN is not set

With that fixed, this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

[snip]
