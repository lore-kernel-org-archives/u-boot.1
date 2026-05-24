Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981BECD5BAB
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 19:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC372848E3;
	Sun, 24 May 2026 21:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="m5zv4ySp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C30F4848FC; Sun, 24 May 2026 21:39:17 +0200 (CEST)
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net
 [178.154.239.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 593B1848D7
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 21:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:1199:0:640:2d84:0])
 by forward500b.mail.yandex.net (Yandex) with ESMTPS id D9257C0668;
 Sun, 24 May 2026 22:39:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id 8dcYMLbdVCg0-INziw3I6; 
 Sun, 24 May 2026 22:39:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779651552; bh=Zy485yGbPUIde/xxSueJlejVj3yAdfOEGPcdY9BrKW8=;
 h=Message-ID:Subject:References:To:From:In-Reply-To:Cc:Date;
 b=m5zv4ySpI3bzQCjRmWd1m6Toz8fiozGtT32cB2cN62DnZmqSlIZsQ/CDZBtCYceJP
 cKjdytR24grvgBfwuBFGkKk2NpvItroTivIEUBAZWpw30u39RLGn0nSqWHguGeDVaw
 6s829w5uUKR/GaxfS5GMov3N3K6n7iJetBkjpUM8=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
Date: Sun, 24 May 2026 22:39:08 +0300
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
Message-ID: <20260524193908.GA144447@pgolikov-home-desktop>
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
 <20260517-rk3568-raminit-v1-2-a24e16302a13@ya.ru>
 <bc4973d8-2b04-4f24-a6bf-62b182a100be@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc4973d8-2b04-4f24-a6bf-62b182a100be@kwiboo.se>
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

On Sun, May 24, 2026 at 08:42:33PM +0200, Jonas Karlman wrote:
> Hi Pavel,
> 
> On 5/17/2026 9:24 PM, Pavel Golikov wrote:
> > Properly initialize cru address space reference when CONFIG_OF_PLATDATA
> > is enabled.
> 
> Do we have to use OF_PLATDATA for TPL to fit into SRAM?

DRAM driver is heavily based on one for rv1126. rv1126 utilizes OF_PLATDATA,
even though it is 32 bit (with the same amount of SRAM), and 32 bit TPL should
be even smaller.

> Also, why do we need CLK driver in TPL? Based on small glance at the
> code it looks like the DPLL was handled by the RAM driver itself.

I'm getting

aarch64-linux-gnu-ld: arch/arm/mach-rockchip/rk3568/clk_rk3568.o: in function `rockchip_get_clk':
<...>/build-tpl/../arch/arm/mach-rockchip/rk3568/clk_rk3568.c:14: undefined reference to `_u_boot_list_2_driver_2_rockchip_rk3568_cru'
aarch64-linux-gnu-ld: <...>/build-tpl/../arch/arm/mach-rockchip/rk3568/clk_rk3568.c:14: undefined reference to `_u_boot_list_2_driver_2_rockchip_rk3568_cru'

when trying to build TPL without CLK (both with OF_PLATDATA and OF_REAL).
rockchip_get_clk is needed by sysreset_rockchip, which, in turn, is always
built for ARCH_ROCKCHIP (sorry).

We could actually delegate DPLL to CLK, but there is no API to configure spread
spectrum (although it is disabled by default in loader_params). I also have no
idea of how MSCH clock tree looks like.

Regards,
Pavel 
