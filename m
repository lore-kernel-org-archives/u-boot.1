Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01CBCD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 15:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 156DD84849;
	Tue, 26 May 2026 17:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="lY9U/+OM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4671B8484F; Tue, 26 May 2026 17:15:08 +0200 (CEST)
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d500])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19267846B4
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 17:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:25b4:0:640:a124:0])
 by forward500b.mail.yandex.net (Yandex) with ESMTPS id 48F05C0EDB;
 Tue, 26 May 2026 18:15:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id sEaJxt0d78c0-hJ0K7BIY; 
 Tue, 26 May 2026 18:14:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779808499; bh=lvp9VVRASGN0Rx874jB7+tjgfhdBsqMSamjkOzWUM18=;
 h=Message-ID:Subject:References:To:From:In-Reply-To:Cc:Date;
 b=lY9U/+OMx9why5bHE1veF3A5Qi0NRX6Hdm90ksgf67MU4gJlCxz9uDwk33YtGwc8g
 FA0kypGqun0bDuKydH4jfa1dPqAZzRLUMqBWxxD6k0WjDy9wjxwUmY0s8qfWg+LQQK
 eHebxKV3EIV2UyVOOGcAo877JBbp2QTUOk53pStw=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
Date: Tue, 26 May 2026 18:14:54 +0300
From: Pavel Golikov <paullo612@ya.ru>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
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
Subject: Re: [PATCH RFC 02/18] clk: rockchip: rk3568: Fix probe with
 OF_PLATDATA enabled
Message-ID: <20260526151454.GA265884@pgolikov-home-desktop>
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
 <20260517-rk3568-raminit-v1-2-a24e16302a13@ya.ru>
 <bc4973d8-2b04-4f24-a6bf-62b182a100be@kwiboo.se>
 <20260524193908.GA144447@pgolikov-home-desktop>
 <1b37b5cc-5fe6-4cc6-8eae-cad50a584319@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b37b5cc-5fe6-4cc6-8eae-cad50a584319@kwiboo.se>
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

On Tue, May 26, 2026 at 10:17:16AM +0200, Jonas Karlman wrote:
> Hi Pavel,
> 
> On 5/24/2026 9:39 PM, Pavel Golikov wrote:
> > Hi Jonas,
> > 
> > On Sun, May 24, 2026 at 08:42:33PM +0200, Jonas Karlman wrote:
> >> Hi Pavel,
> >>
> >> On 5/17/2026 9:24 PM, Pavel Golikov wrote:
> >>> Properly initialize cru address space reference when CONFIG_OF_PLATDATA
> >>> is enabled.
> >>
> >> Do we have to use OF_PLATDATA for TPL to fit into SRAM?
> > 
> > DRAM driver is heavily based on one for rv1126. rv1126 utilizes OF_PLATDATA,
> > even though it is 32 bit (with the same amount of SRAM), and 32 bit TPL should
> > be even smaller.
> 
> None of the existing Rockchip TPL implementation is very optimized and
> likely not a good candidate on how optimized DRAM init can be handled :-)
> 
> >> Also, why do we need CLK driver in TPL? Based on small glance at the
> >> code it looks like the DPLL was handled by the RAM driver itself.
> > 
> > I'm getting
> > 
> > aarch64-linux-gnu-ld: arch/arm/mach-rockchip/rk3568/clk_rk3568.o: in function `rockchip_get_clk':
> > <...>/build-tpl/../arch/arm/mach-rockchip/rk3568/clk_rk3568.c:14: undefined reference to `_u_boot_list_2_driver_2_rockchip_rk3568_cru'
> > aarch64-linux-gnu-ld: <...>/build-tpl/../arch/arm/mach-rockchip/rk3568/clk_rk3568.c:14: undefined reference to `_u_boot_list_2_driver_2_rockchip_rk3568_cru'
> > 
> > when trying to build TPL without CLK (both with OF_PLATDATA and OF_REAL).
> > rockchip_get_clk is needed by sysreset_rockchip, which, in turn, is always
> > built for ARCH_ROCKCHIP (sorry).
> 
> Correct, as I mentioned, there are dependency issues that needs to be
> resolved, the question remains, does the DRAM init code need to
> initialize any clocks that is currently handled in the clock driver?

No, it does not.
 
> Or could macros from cru_rk3568.h be used directly in DRAM init code
> to save on size?
> 
> Anyway, I have some work-in-progress code [1] that cleanup some of these
> dependency issues and should allow for a very light TPL.
> 
>   make generic-rk3568_defconfig rockchip-tpl-lpddr4.config
> 
> With that I get a ~2 KiB TPL that could be used as a starting ground
> for a size optimized DRAM init.

Did a quick rebase on top of your branch here [1]. It works without TPL_DM, but
requires CFG_SYS_NS16550_CLK and CFG_SYS_NS16550_COM1 definitions to make it
all buildable.

46184 vs 37288 bytes for TPL, and no malloc in the image. Impressive.

But still board_init_f_alloc_reserve(0xfdcd8000). I also wonder why we move
stack pointer on TPL start, instead of using the stack provided by bootrom.
I suspect that 0xfdcc0600 - 0xfdcc1000 is a bootrom stack region.

I also noticed that debug_uart_init() is called twice. Once in
crt0.S/crt0_64.S, and once in board_init_f. Is this behaviour intended?

> Implement board_debug_uart_init(), sdram_init() and the missing RK3568
> specific TPL Kconfig options, i.e. TPL_TEXT_BASE etc. and hopefully that
> should be enough for a size optimized DRAM init.
> 
> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/ci
> 
> I will rework some of those patches and send to list later this week.
> 
> Regards,
> Jonas
> 
> > 
> > We could actually delegate DPLL to CLK, but there is no API to configure spread
> > spectrum (although it is disabled by default in loader_params). I also have no
> > idea of how MSCH clock tree looks like.
> > 
> > Regards,
> > Pavel 
> 

[1] https://github.com/Paullo612/u-boot/tree/ci-rk3568-raminit-rfc-v2

Regards,
Pavel
