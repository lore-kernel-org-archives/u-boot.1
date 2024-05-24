Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B504C25B79
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 08:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA5B88635;
	Fri, 24 May 2024 10:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f+HoywIz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD88088582; Fri, 24 May 2024 10:48:33 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC98388568
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 10:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-24cbb704135so2743fac.3
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 01:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716540510; x=1717145310; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yE5Fbu1pqQUUo8157gy4i39kp9TThBLGZlhl/97I0jk=;
 b=f+HoywIzI0Cnvznhr7Rbt8LdZpEW236m4vB9oEx7J5Y6IweSBHnBasND5TNTOx6B8J
 woxvahk4IyH/AqfzqmCzT1Xu7i+JegxMU88x0pKmsGBg32PZR4QdMxMPxzrDGucvHGKJ
 YmjB8hzKbKFHbFLNIWXFopE67RprQdmctZc8SVfYUkRTMsbirtcm4DqVetxRtVhQDe+U
 UQeOcctcgc7WaOkATngl8SEB/fOosaviD/F2bf19Lpvdct5Ez6AXjaxRPU9JA0k0v+46
 w156M+D6Ls+qyuE+joiD4kqGqnwUbG8HsaC5LuOJ4kC+Eh5wIUup6vUHCqhJJ3J9ncWP
 e1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716540510; x=1717145310;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yE5Fbu1pqQUUo8157gy4i39kp9TThBLGZlhl/97I0jk=;
 b=IlPfKoazfm0xrHlb3IgOBQNM03jRsePgX+tYjKzGUqBnG7M8b5g9BgmBNn8XJB3wag
 0OYVstvlxNMhWTXlDvC8mBy0EADE0SUaXEGrAuz62qzXhvatqRfg0nWNsrjEzkueS++z
 Xpbih9hfr834daE+/6AFsxHJ+1drcKzoL4SId6/3Upqnws0HbbL4K8IYL0OE/OxMFjVS
 t/f7O6nhbK2G/TaXJ9ZqDNOjNBdASwRFIG+YrUHG840/bxurGeScthBPLfMaVJcahzLh
 gJDyzH7vz6xqkLisdFa7qFI9OTGLr1Of7IU4Xjx6k9Z8XojcU3LdZ7fL1svy5/1FdWzh
 ntKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDUAEt9esZfk0OpGtRNKawgIKvV0NqtNgS08Vg/qwwaY1TjoHyoYmxQypKMS6Kn8RF9Ek0OoyKXNuuD1X41QssohlOwQ==
X-Gm-Message-State: AOJu0Yy0YBhcCoyZZbX4UBlUl9G+VuV6RvIPcgzRXSGQ98YBYxlKto+a
 gkC07hPuO0+bi5aydOzyt8O0gZFMjgQPBlL9N5aVQvkYcHg6DJg6kFzG8WwypUXD/G/DYCzIAYp
 8tzES3KsBlh46KeiE6sjwVL3qR+PzvTfvpys=
X-Google-Smtp-Source: AGHT+IEaLn0hnWyB4FyMToY1KH87JOTDpNRa01UQgysiXJ+S7TfnG/rYSssaF1VnL/fxc9bSd1bNrxd56zQVgW4B0bw=
X-Received: by 2002:a05:6871:5228:b0:24c:5ad9:ed72 with SMTP id
 586e51a60fabf-24ca11dda1emr1765197fac.16.1716540510205; Fri, 24 May 2024
 01:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240516090031.2373-1-anand@edgeble.ai>
 <20240516090031.2373-7-anand@edgeble.ai>
 <d7230a5d-e74a-4b12-9e97-b19e8024afab@kwiboo.se>
 <CANAwSgRJx8ok4yDi9+76=PjvQdcJg2WLUHcVdGk_jOKsM=+RbQ@mail.gmail.com>
In-Reply-To: <CANAwSgRJx8ok4yDi9+76=PjvQdcJg2WLUHcVdGk_jOKsM=+RbQ@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 24 May 2024 14:18:14 +0530
Message-ID: <CANAwSgSAe4fZkeTwkuqdMfLpSKc=0Gx9gz5Vx-j6pQ8ZYOufSA@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] rockchip: RK3568: Read the reset cause from clock
 reset unit for RK356x SoC
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 17 May 2024 at 13:15, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Jonas,
>
> Dropping @edgeble.ai email ID as it is not working
>
> On Thu, 16 May 2024 at 19:48, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > Hi Anand,
> >
> > On 2024-05-16 10:59, Anand Moon wrote:
> > > Read the reset cause from the clock reset unit for RK356x SoC.
> > >
> > > Cc: Jagan Teki <jagan@edgeble.ai>
> > > Signed-off-by: Anand Moon <anand@edgeble.ai>
> > > ---
> > >  arch/arm/mach-rockchip/cpu-info.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
> > > index 77833c8fce..114608b506 100644
> > > --- a/arch/arm/mach-rockchip/cpu-info.c
> > > +++ b/arch/arm/mach-rockchip/cpu-info.c
> > > @@ -12,6 +12,8 @@
> > >  #include <asm/arch-rockchip/cru_rk3328.h>
> > >  #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3399)
> > >  #include <asm/arch-rockchip/cru_rk3399.h>
> > > +#elif IS_ENABLED(CONFIG_ROCKCHIP_RK33568)
> > > +#include <asm/arch-rockchip/cru_rk3568.h>
> > >  #endif
> > >  #include <asm/arch-rockchip/hardware.h>
> > >  #include <linux/err.h>
> > > @@ -22,6 +24,8 @@ char *get_reset_cause(void)
> > >       struct rk3328_cru *cru = rockchip_get_cru();
> > >  #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3399)
> > >       struct rockchip_cru *cru = rockchip_get_cru();
> > > +#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3568)
> > > +     struct rk3568_cru *cru = rockchip_get_cru();
> >
> > This is strictly not needed for RK3568 after the commit 6e710897aa31
> > ("rockchip: cru: Enable cpu info support for rk3568").
>
> Ok, thanks for this input.
> >
> > Suggest you use same/similar workaround or cleanup the include/define
> > statement in arch/arm/include/asm/arch-rockchip/cru.h for all SoCs.
> >

I have made changes for all the SoC that supports this reading of CRU
only build these SoCs,I don't have all the boards to test.

On rock64 with reboot command, it shows (RST)

U-Boot 2024.07-rc3-00021-gb23d5619e6-dirty (May 24 2024 - 12:55:26 +0530)

SoC: Rockchip rk3328
Reset cause: RST
Model: Pine64 Rock64

with poweroff command, it shows (POR)

U-Boot 2024.07-rc3-00021-gb23d5619e6-dirty (May 24 2024 - 12:55:26 +0530)

SoC: Rockchip rk3328
Reset cause: POR

> > Also at least one RK SoC have other bits set in the glb_rst_st reg.
> >
> > Suggest you add following:
> >
> >   GLB_RST_MASK          = GENMASK(5, 0),
> >
> > and use something like:
> >
> >   switch (cru->glb_rst_st & GLB_RST_MASK) {
> >
> > or "unknown reset" is reported on affected SoCs.
> >
> > I have also seen POR always being reported even after a reboot so please
> > confirm that reset reason works on the SoCs/boards you enable this on.
> >

Actually, for RK3568 and RK3688 SoC, we are not able to read the reset
cause via CRU
glb_rst_st is always set to zero.

Either the user space with poweroff and reboot command not updating the CRU
or the u-boot is not registering the sysreset to read the reset cause.

# dm tree
 clk           5  [ + ]   rockchip_rk3588_cru   |-- clock-controller@fd7c0000
 sysreset      0  [   ]   rockchip_sysreset     |   |-- sysreset
 reset         0  [ + ]   rockchip_reset        |   `-- reset

>
> Ok, I will check this and update you on this.
>

Thanks
-Anand
