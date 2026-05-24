Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504AACD5BB1
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 17:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A1083AA9;
	Sun, 24 May 2026 19:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="e9uA++Vc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90CDE846CE; Sun, 24 May 2026 19:14:42 +0200 (CEST)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [178.154.239.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91DCF803C6
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 19:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a49e:0:640:d6fd:0])
 by forward500d.mail.yandex.net (Yandex) with ESMTPS id E167280D43;
 Sun, 24 May 2026 20:14:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (smtp)
 with ESMTPSA id WEaVB49pPa60-skVdxdoE; 
 Sun, 24 May 2026 20:14:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779642877; bh=vOHg/6Nvs0Svgbua1kQvExPGq8KAUwWk71hHZ8Se4jQ=;
 h=Message-ID:Subject:References:To:From:In-Reply-To:Cc:Date;
 b=e9uA++VcBjqtoqWcjdSrXuiVuXG40cZHJsnn7WYeoxbx99WFR0Dv0M6k+g8a33f4j
 wFHcbNGPDfsNqXluqRW+Jl+8AyJ7mdlRnr4tKqDTXwNUVSOeH8mGHhZYIrZdBwVg7H
 Cjs4/TGmYdqbrHMPgqyDEUp1km65lw5+yxMGOC3w=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
Date: Sun, 24 May 2026 20:14:32 +0300
From: Pavel Golikov <paullo612@ya.ru>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH RFC 17/18] rockchip: rk356x-generic: Initialize SDRAM at
 TPL stage
Message-ID: <20260524165917.GA49511@pgolikov-home-desktop>
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
 <20260517-rk3568-raminit-v1-17-a24e16302a13@ya.ru>
 <5cc57912-603b-455a-97c6-0bbfd6357e9f@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cc57912-603b-455a-97c6-0bbfd6357e9f@kwiboo.se>
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

Hi Jonas,

On Sun, May 17, 2026 at 11:06:06PM +0200, Jonas Karlman wrote:
> Hi Pavel,
> 
> On 5/17/2026 9:24 PM, Pavel Golikov wrote:
> > Only LPDDR4 initialization is confirmed to be working for now.
> > 
> > Signed-off-by: Pavel Golikov <paullo612@ya.ru>
> > ---
> >  arch/arm/mach-rockchip/Kconfig        | 28 +++++++++++++++++++++++++++-
> >  arch/arm/mach-rockchip/rk3568/Kconfig | 16 ++++++++++++++++
> >  common/spl/Kconfig.tpl                |  1 +
> >  configs/generic-rk3568_defconfig      |  1 +
> >  4 files changed, 45 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> > index 108713488af..9a6a580025e 100644
> > --- a/arch/arm/mach-rockchip/Kconfig
> > +++ b/arch/arm/mach-rockchip/Kconfig
> > @@ -413,11 +413,15 @@ config ROCKCHIP_RK3528
> >  config ROCKCHIP_RK3568
> >  	bool "Support Rockchip RK3568"
> >  	select ARM64
> > +	select SUPPORT_TPL
> > +	select TPL_HAVE_INIT_STACK if TPL
> > +	select TPL_ROCKCHIP_BACK_TO_BROM if TPL
> >  	select SUPPORT_SPL
> >  	select SPL
> >  	select CLK
> >  	select PINCTRL
> >  	select RAM
> > +	select ROCKCHIP_SDRAM_COMMON
> >  	select REGMAP
> >  	select SYSCON
> >  	select BOARD_LATE_INIT
> > @@ -433,10 +437,32 @@ config ROCKCHIP_RK3568
> >  	imply RNG_ROCKCHIP
> >  	imply ROCKCHIP_COMMON_BOARD
> >  	imply ROCKCHIP_COMMON_STACK_ADDR
> > -	imply ROCKCHIP_EXTERNAL_TPL
> 
> Not until this has been proven to work for all current supported dram
> types and configurations, please select TPL in board specific defconfigs.

I've played with configs a littel bit, and... I'm not a Kconfig expert, but
Kconfig does not support mutually exclusive configs. So, we have to deal with
both TPL and ROCKCHIP_EXTERNAL_TPL enabled. ROCKCHIP_EXTERNAL_TPL is now takes
precedence over TPL [1].

One (and less affecting) option would be to enable ROCKCHIP_EXTERNAL_TPL for
all rk356x boards, and disable it for each particular board when DRAM
initialization will be considered stable for this board.

Another (more affecting) option is to give TPL a higher priority. This means
that external TPL would be enabled by CONFIG_TPL=n (as ROCKCHIP_EXTERNAL_TPL
would still be implied by all SoCs that support it). And we have to revisit all
Rockchip boards configs and change ROCKCHIP_EXTERNAL_TPL=y to CONFIG_TPL=n.

And we still want to support the case when both internal and external TPLs are
disabled, to be able to pack SPL as TPL for SoCs with huge amount of SRAM
(rk3588 with 1MB of SRAM as an example).

So, what is the preferred way to go?

> >  	imply ROCKCHIP_OTP
> > +	imply ROCKCHIP_SERIAL if !ROCKCHIP_EXTERNAL_TPL
> >  	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
> >  	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
> > +	imply TPL if !ROCKCHIP_EXTERNAL_TPL
> > +	imply TPL_CLK
> > +	imply TPL_DM
> > +	imply TPL_LIBCOMMON_SUPPORT
> > +	imply TPL_LIBGENERIC_SUPPORT
> > +	imply TPL_OF_CONTROL
> > +	imply TPL_OF_PLATDATA
> > +	imply TPL_RAM
> > +	imply TPL_ROCKCHIP_COMMON_BOARD
> > +	imply TPL_SERIAL
> > +	imply TPL_SYSCON
> > +	imply SPL_CLK
> > +	imply SPL_DM
> > +	imply SPL_DRIVERS_MISC
> > +	imply SPL_LIBCOMMON_SUPPORT
> > +	imply SPL_LIBGENERIC_SUPPORT
> > +	imply SPL_OF_CONTROL
> > +	imply SPL_RAM
> > +	imply SPL_REGMAP
> > +	imply SPL_ROCKCHIP_COMMON_BOARD
> > +	imply SPL_SERIAL
> > +	imply SPL_SYSCON
> 
> These should all be sorted alphanumerically, also this is adding SPL
> related implys, probably something that should be in a separate patch?

For some reason I decided that it won't compile without selecting SPL stuff
explicitly when TPL is enabled, and blindly copied this part from rv1126
configuration. All needed SPL configs are implied implicitly. So, would it be
better to leave SPL implies for clarity as it is done in rv1126, or drop them?
 
> >  	help
> >  	  The Rockchip RK3568 is a ARM-based SoC with quad-core Cortex-A55,
> >  	  including NEON and GPU, 512K L3 cache, Mali-G52 based graphics,
> > diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> > index 2730220a18e..893185291d8 100644
> > --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> > +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> > @@ -61,6 +61,10 @@ config TARGET_ORANGEPI_3B_RK3566
> >  
> >  endchoice
> >  
> > +config SOC_SPECIFIC_OPTIONS # dummy
> > +	def_bool y
> > +	select HAS_CUSTOM_SYS_INIT_SP_ADDR
> > +
> >  config ROCKCHIP_BOOT_MODE_REG
> >  	default 0xfdc20200
> >  
> > @@ -70,6 +74,18 @@ config ROCKCHIP_STIMER_BASE
> >  config SYS_SOC
> >  	default "rk3568"
> >  
> > +config TPL_LDSCRIPT
> > +	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
> > +
> > +config TPL_STACK
> > +	default 0xfdcd8000
> > +
> > +config TPL_SYS_MALLOC_F_LEN
> > +	default 0x2000
> > +
> > +config TPL_TEXT_BASE
> > +	default 0xfdcc1000
> > +
> >  source "board/rockchip/evb_rk3568/Kconfig"
> >  source "board/anbernic/rgxx3_rk3566/Kconfig"
> >  source "board/hardkernel/odroid_m1/Kconfig"
> > diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
> > index a535b61ecd3..e64316b8eb3 100644
> > --- a/common/spl/Kconfig.tpl
> > +++ b/common/spl/Kconfig.tpl
> > @@ -127,6 +127,7 @@ config TPL_TEXT_BASE
> >  config TPL_MAX_SIZE
> >  	hex "Maximum size (in bytes) for the TPL stage"
> >  	default 0x2e000 if ROCKCHIP_RK3399
> > +	default 0xe800 if ROCKCHIP_RK3568
> >  	default 0x8000 if ROCKCHIP_RK3288 || ROCKCHIP_RV1126
> >  	default 0x7000 if ROCKCHIP_RK322X || ROCKCHIP_RK3328 || ROCKCHIP_RK3368
> >  	default 0x2800 if ROCKCHIP_PX30
> > diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
> > index a33c3af9255..4510fa94775 100644
> > --- a/configs/generic-rk3568_defconfig
> > +++ b/configs/generic-rk3568_defconfig
> > @@ -81,3 +81,4 @@ CONFIG_USB_GADGET=y
> >  CONFIG_USB_GADGET_DOWNLOAD=y
> >  CONFIG_USB_FUNCTION_ROCKUSB=y
> >  CONFIG_ERRNO_STR=y
> > +CONFIG_RAM_ROCKCHIP_LPDDR4=y
> 
> This generic-rk3568 target is explicitly created to be generic with
> dynamic DRAM type lookup. So we cannot add explicit DRAM type support
> for this target.

Yep. generic-rk3568 should live with BLOB forever. Made this as an example to
ease testing, as the board I am testing on is not upstream. Will drop this in
v2.

> Regards,
> Jonas

Regards,
Pavel

[1] https://source.denx.de/u-boot/u-boot/-/blob/987c93fc68a641cc735c9828872511a947e54191/arch/arm/dts/rockchip-u-boot.dtsi#L175
