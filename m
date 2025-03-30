Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A40C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 11:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E87528144A;
	Sun, 30 Mar 2025 13:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uRGzQJPL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4E6281951; Sun, 30 Mar 2025 13:45:12 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 124F780FDA
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 13:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1dca=WR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743335108;
 bh=qC8MvXyfUmPFI2e+jkjA02OD/frRHrpLZdfiCirzR2g=;
 b=uRGzQJPLOXgTebbY1MeHUW96klfiiSZ+SNiPSpIEIPD8iV6gLtV7pgQdxZfHpODv6eDXGJ3Mr
 LWG3njO+XZbphA9UYgHQzgN1yPiWCZ8d5BYUzzGKAr4SYpIlRDM+7uYMLEmMhS+vwQuKn1J4uFI
 iImR2Rfm/OAuFYNNFyUnunlphiyQ2Lvj1AiFZgonwtBjBYTSjaouMOfSxDMBGcW2CL2oRNA2XiV
 PuVv03Dl15hG7GRECQWUdKxGI5U6v9zTPYYRrtz1uRcNlGYNVaUQGIiq1EdW4sHd3g3+F3bZCqS
 upZgilsYIc8kdW5nubeJrOysWqypnRYP5Kxpc+ZUumQQ==
X-Forward-Email-ID: 67e92ebd0286204565e94ddb
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3819cbcb-5fa6-4939-a2b4-643cadcc50ff@kwiboo.se>
Date: Sun, 30 Mar 2025 13:44:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] rockchip: rock64-rk3328_defconfig: enable HDMI
 output and USB keyboard
To: Vasily Khoruzhick <anarsoul@gmail.com>
References: <20250323225134.2369473-1-anarsoul@gmail.com>
 <20250323225134.2369473-3-anarsoul@gmail.com>
Content-Language: en-US
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Anatolij Gustschin <agust@denx.de>,
 Jagan Teki <jagan@edgeble.ai>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250323225134.2369473-3-anarsoul@gmail.com>
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

Hi Vasily,

On 2025-03-23 23:50, Vasily Khoruzhick wrote:
> Enable HDMI output and USB keyboard on Rock64 board
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
> v2: no change
> 
>  configs/rock64-rk3328_defconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
> index 6d00b52e62f..ae3512625cf 100644
> --- a/configs/rock64-rk3328_defconfig
> +++ b/configs/rock64-rk3328_defconfig
> @@ -21,7 +21,9 @@ CONFIG_FIT_VERBOSE=y
>  CONFIG_SPL_FIT_SIGNATURE=y
>  CONFIG_SPL_LOAD_FIT=y
>  CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_USE_PREBOOT=y

This will add a large delay during boot as it forces a run of the slow
"usb start" and is something we want to avoid for normal use, please
drop this.

>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock64.dtb"
> +# CONFIG_SYS_DEVICE_NULLDEV is not set
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_SPL_MAX_SIZE=0x40000
> @@ -72,6 +74,7 @@ CONFIG_DM_ETH_PHY=y
>  CONFIG_PHY_GIGE=y
>  CONFIG_ETH_DESIGNWARE=y
>  CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_HDMI=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>  CONFIG_PINCTRL=y
>  CONFIG_SPL_PINCTRL=y
> @@ -80,6 +83,8 @@ CONFIG_PMIC_RK8XX=y
>  CONFIG_SPL_DM_REGULATOR=y
>  CONFIG_DM_REGULATOR_FIXED=y
>  CONFIG_SPL_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_SPL_DM_REGULATOR_GPIO=y

The ROCK64 does not use any regulator-gpio, this look unrelated and can
be dropped?

>  CONFIG_REGULATOR_RK8XX=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_RAM=y
> @@ -104,6 +109,11 @@ CONFIG_USB_OHCI_GENERIC=y
>  CONFIG_USB_DWC2=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_KEYBOARD=y
> +CONFIG_VIDEO=y
> +CONFIG_DISPLAY=y
> +CONFIG_VIDEO_ROCKCHIP=y
> +CONFIG_DISPLAY_ROCKCHIP_HDMI=y

This will force a small delay of at least a 300ms timeout for all users
that does not have HDMI connected during boot.

Maybe this could be extracted to a rockchip-hdmi.config-file to make it
more optional?

E.g. use "make rock64-rk3328_defconfig rockchip-hdmi.config" to build
with something like:

  > cat rockchip-hdmi.config
  CONFIG_VIDEO=y
  CONFIG_DISPLAY=y
  CONFIG_VIDEO_ROCKCHIP=y
  CONFIG_DISPLAY_ROCKCHIP_HDMI=y

Regards,
Jonas

>  CONFIG_SPL_TINY_MEMSET=y
>  CONFIG_TPL_TINY_MEMSET=y
>  CONFIG_ERRNO_STR=y

