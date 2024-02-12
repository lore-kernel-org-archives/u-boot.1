Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFBBC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2370C87EE7;
	Mon, 12 Feb 2024 14:56:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NRp+kAWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E65587EF1; Mon, 12 Feb 2024 14:56:34 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F03F987EE7
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5600d950442so3571077a12.1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 05:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707746191; x=1708350991; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3HGMfjcVnVXDNj3Yn+n/yCvvwkNRJaGGSvX8WndJKOY=;
 b=NRp+kAWO8oPgfUwBSsfrU9wUvBHgccB2l8ZmK7wYIhouc9ckkj7fK8t+G3MJnEd8vp
 95yNpD/X452EMIH75w4VzpbTxDIfjirKoua3G6VbKgLcXXsOEBFOxC9OaWh6np8RrsJ8
 Hc4Idew326FQwH1N1ZvkKzKrgR6wJNeQ+CV5zoyg90HfgVGaTayCI3aCjrodi91wD1gC
 9TlWYQP2Gvq3qvHK1W9sJJ8GOGYQPgF2Ws91/ARt1/fMz+81DyNweRkkLlaPFmeY0csF
 +AEarG7OQOpgAj4e7opN0lOujTDW62H7K1VoMBORFPcbplrPS6hglZTmbGlKD8yc5EZZ
 MRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707746191; x=1708350991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3HGMfjcVnVXDNj3Yn+n/yCvvwkNRJaGGSvX8WndJKOY=;
 b=a0f/8GaIuhTeCQf9twYQsLqTdjGXQwm+ZOy6fJV3eSt6zHj1zJCUwGyV8L4/1CLcnH
 cb9viM4n6cutqM25pceOPgIOcynx/WCPgiS+XA6uxsgahh2Ns5TF6ZMrUv2+vPJuzcWX
 8iy1OcFKfC+5dpNm6SJRo833BE5vfIHPiYKAR4dJSzZtNYjW5a3eEOkewW+lct3nzcYq
 YKK3/D+LiL6IWDRfWJP3IsmDeL94qsFNMbs9We96jErqVVNG8WXzveYGDCvbAWYczp3w
 J5olqlhb7ZmlltJ/5JLEszqaB3ZuBRd+YJZLv2E2UQ+AAN9CkUD5qmEcdmFPvcmwy1T9
 gpHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY6hdHVg+tEhuayI5/RXiKWkQv3ljDKlNuoiAGJ0wh1Dg/lDj3LTWywhVX14SW5ZO+l31aX1+SpSuHTcZMcl/cUEgFnw==
X-Gm-Message-State: AOJu0YzUlMyU6yQsG8KSNmLIcikcxraCZLx46p0jb0dB0Vil8zKJqCXk
 dVzBKjP6lkuK32D0lO1PqDEvo5zl3M/f9zhn4z9/XHhPyeLwDn5JBnk367dCBVJXkk/vcb5B6+4
 n4bOjyVlRzt2uaRWGP514uTGIw60=
X-Google-Smtp-Source: AGHT+IGx3flKKXZ7DugJRi/7IoHlobn7W/GJso9qT7D1FYBykbvmutUlTrlTkX6ILpC6zrTuXH0yiIkSvW2HkUT+B9Q=
X-Received: by 2002:a05:6402:12cb:b0:560:209:c800 with SMTP id
 k11-20020a05640212cb00b005600209c800mr5113773edx.18.1707746191305; Mon, 12
 Feb 2024 05:56:31 -0800 (PST)
MIME-Version: 1.0
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-9-6c9ffe09b924@theobroma-systems.com>
 <64ed7a21fa952a3dd9cc76a9cc90216e@manjaro.org>
 <87bk8ppjr0.fsf@bloch.sibelius.xs4all.nl>
 <ff548e7a542b85110da67e154cc7d1ad@manjaro.org>
In-Reply-To: <ff548e7a542b85110da67e154cc7d1ad@manjaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 12 Feb 2024 13:56:20 +0000
Message-ID: <CALeDE9OseqhUPno5ot=ZOZoFL4CN3tv2spu-+V6oiU6fV98vug@mail.gmail.com>
Subject: Re: [PATCH v2 09/20] rockchip: merge misc.c into board.c
To: Dragan Simic <dsimic@manjaro.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, foss+uboot@0leil.net,
 sjg@chromium.org, 
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, trini@konsulko.com, 
 alpernebiyasak@gmail.com, jagan@amarulasolutions.com, 
 klaus.goger@theobroma-systems.com, heiko.stuebner@cherry.de, 
 otavio@ossystems.com.br, andy.yan@rock-chips.com, 
 manivannan.sadhasivam@linaro.org, lukma@denx.de, seanga2@gmail.com, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, sughosh.ganu@linaro.org, 
 xypron.glpk@gmx.de, agust@denx.de, u-boot@lists.denx.de, 
 quentin.schulz@theobroma-systems.com
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

On Fri, 9 Feb 2024 at 18:57, Dragan Simic <dsimic@manjaro.org> wrote:
>
> Hello Mark,
>
> On 2024-02-09 19:36, Mark Kettenis wrote:
> >> Date: Fri, 09 Feb 2024 18:58:01 +0100
> >> From: Dragan Simic <dsimic@manjaro.org>
> >> Please, see my comments below.
> >>
> >> On 2024-02-09 10:50, Quentin Schulz wrote:
> >> > From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> >> >
> >> > The functions aren't used anywhere else than in board.c, therefore,
> >> > let's not expose them anymore at all.
> >> >
> >> > This merges misc.c and board.c together and removes the functions from
> >> > the misc.h header file.
> >>
> >> The patches I'm going to send, which exclude the unneeded code
> >> from the U-Boot images for the Pinebook Pro and the Pinebook Pro,
> >> change the code that this patch moves around.
> >>
> >> Perhaps it would be better to have the move of the code and the
> >> subsequent changes to it performed in a separate series, to make
> >> checking and accepting the patches simpler as a group, and to
> >> perhaps make it a bit more clear what actually happened to anyone
> >> going through the repository history later.
> >>
> >> Thus, I was wondering would you, please, be fine with excluding
> >> this patch from this series and letting me submit it, with proper
> >> attribution tags, of course, as part of the series I'll submit
> >> in the next couple of days?
> >
> > I'm not covinced your patches are a good idea.  Unless we're running
> > into space constraints, or if there are noticable slowdowns in the
> > boot process because of the extra code, I really don't see what the
> > benefit of further differentiation between rk3399 boards would be.  It
> > just makes testing things harder.
>
> Oh, I fully understand your position, but please let's also keep in
> mind that the subject of those patches are actual devices with pretty
> much fixed hardware configurations, instead of targeting development
> boards whose actual hardware configurations, at least in theory,
> depend on the user.
>
> In addition to preventing the unneeded code from entering the U-Boot
> images, my patches would also prevent useless "ethaddr" and "eth1addr"
> from appearing in the saved environments on those devices.  I think
> that's useful and may actually prevent some confusion when the saved
> environment is checked by the users on those devices.

Maybe that code should be guarded on if the wired ethernet is enabled
or not. Would allow one code but the ability to disable it when the
ethernet isn't used.

> > The smaller the number of special snow flakes, the better!
>
> I'd agree that having fewer special cases helps, but again, handling
> the specifics of some devices also has its benefits.  Additionally,
> perhaps simply the fact that those are actual devices makes them some
> kind of special snowflakes. :)
>
> >> > Cc: Quentin Schulz <foss+uboot@0leil.net>
> >> > Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> >> > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> >> > ---
> >> >  arch/arm/include/asm/arch-rockchip/misc.h |   5 --
> >> >  arch/arm/mach-rockchip/Makefile           |   1 -
> >> >  arch/arm/mach-rockchip/board.c            | 125
> >> > +++++++++++++++++++++++++++
> >> >  arch/arm/mach-rockchip/misc.c             | 135
> >> > ------------------------------
> >> >  4 files changed, 125 insertions(+), 141 deletions(-)
> >> >
> >> > diff --git a/arch/arm/include/asm/arch-rockchip/misc.h
> >> > b/arch/arm/include/asm/arch-rockchip/misc.h
> >> > index 4155af8c3b0..ef37ff1661a 100644
> >> > --- a/arch/arm/include/asm/arch-rockchip/misc.h
> >> > +++ b/arch/arm/include/asm/arch-rockchip/misc.h
> >> > @@ -6,9 +6,4 @@
> >> >   *      Rohan Garg <rohan.garg@collabora.com>
> >> >   */
> >> >
> >> > -int rockchip_cpuid_from_efuse(const u32 cpuid_offset,
> >> > -                        const u32 cpuid_length,
> >> > -                        u8 *cpuid);
> >> > -int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length);
> >> > -int rockchip_setup_macaddr(void);
> >> >  void rockchip_capsule_update_board_setup(void);
> >> > diff --git a/arch/arm/mach-rockchip/Makefile
> >> > b/arch/arm/mach-rockchip/Makefile
> >> > index 1dc92066bbf..c07bdaee4c3 100644
> >> > --- a/arch/arm/mach-rockchip/Makefile
> >> > +++ b/arch/arm/mach-rockchip/Makefile
> >> > @@ -23,7 +23,6 @@ ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
> >> >  # meaning "turn it off".
> >> >  obj-y += boot_mode.o
> >> >  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
> >> > -obj-$(CONFIG_MISC_INIT_R) += misc.o
> >> >  endif
> >> >
> >> >  ifeq ($(CONFIG_TPL_BUILD),)
> >> > diff --git a/arch/arm/mach-rockchip/board.c
> >> > b/arch/arm/mach-rockchip/board.c
> >> > index d5cb59c10fa..80b4514852f 100644
> >> > --- a/arch/arm/mach-rockchip/board.c
> >> > +++ b/arch/arm/mach-rockchip/board.c
> >> > @@ -1,20 +1,32 @@
> >> >  // SPDX-License-Identifier: GPL-2.0+
> >> >  /*
> >> >   * (C) Copyright 2019 Rockchip Electronics Co., Ltd.
> >> > + *
> >> > + * Copyright (C) 2019 Collabora Inc - https://www.collabora.com/
> >> > + *      Rohan Garg <rohan.garg@collabora.com>
> >> > + *
> >> > + * Based on puma-rk3399.c:
> >> > + *      (C) Copyright 2017 Theobroma Systems Design und Consulting
> >> > GmbH
> >> >   */
> >> >  #include <common.h>
> >> >  #include <clk.h>
> >> >  #include <cpu_func.h>
> >> > +#include <env.h>
> >> >  #include <dm.h>
> >> >  #include <efi_loader.h>
> >> >  #include <fastboot.h>
> >> > +#include <hash.h>
> >> >  #include <init.h>
> >> >  #include <log.h>
> >> >  #include <mmc.h>
> >> > +#include <dm/uclass-internal.h>
> >> > +#include <misc.h>
> >> >  #include <part.h>
> >> >  #include <ram.h>
> >> >  #include <syscon.h>
> >> >  #include <uuid.h>
> >> > +#include <u-boot/crc.h>
> >> > +#include <u-boot/sha256.h>
> >> >  #include <asm/cache.h>
> >> >  #include <asm/io.h>
> >> >  #include <asm/arch-rockchip/boot_mode.h>
> >> > @@ -297,6 +309,119 @@ int fastboot_set_reboot_flag(enum
> >> > fastboot_reboot_reason reason)
> >> >  #endif
> >> >
> >> >  #ifdef CONFIG_MISC_INIT_R
> >> > +int rockchip_setup_macaddr(void)
> >> > +{
> >> > +#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
> >> > +  int ret;
> >> > +  const char *cpuid = env_get("cpuid#");
> >> > +  u8 hash[SHA256_SUM_LEN];
> >> > +  int size = sizeof(hash);
> >> > +  u8 mac_addr[6];
> >> > +
> >> > +  /* Only generate a MAC address, if none is set in the environment */
> >> > +  if (env_get("ethaddr"))
> >> > +          return 0;
> >> > +
> >> > +  if (!cpuid) {
> >> > +          debug("%s: could not retrieve 'cpuid#'\n", __func__);
> >> > +          return -1;
> >> > +  }
> >> > +
> >> > +  ret = hash_block("sha256", (void *)cpuid, strlen(cpuid), hash,
> >> > &size);
> >> > +  if (ret) {
> >> > +          debug("%s: failed to calculate SHA256\n", __func__);
> >> > +          return -1;
> >> > +  }
> >> > +
> >> > +  /* Copy 6 bytes of the hash to base the MAC address on */
> >> > +  memcpy(mac_addr, hash, 6);
> >> > +
> >> > +  /* Make this a valid MAC address and set it */
> >> > +  mac_addr[0] &= 0xfe;  /* clear multicast bit */
> >> > +  mac_addr[0] |= 0x02;  /* set local assignment bit (IEEE802) */
> >> > +  eth_env_set_enetaddr("ethaddr", mac_addr);
> >> > +
> >> > +  /* Make a valid MAC address for ethernet1 */
> >> > +  mac_addr[5] ^= 0x01;
> >> > +  eth_env_set_enetaddr("eth1addr", mac_addr);
> >> > +#endif
> >> > +  return 0;
> >> > +}
> >> > +
> >> > +int rockchip_cpuid_from_efuse(const u32 cpuid_offset,
> >> > +                        const u32 cpuid_length,
> >> > +                        u8 *cpuid)
> >> > +{
> >> > +#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE) ||
> >> > IS_ENABLED(CONFIG_ROCKCHIP_OTP)
> >> > +  struct udevice *dev;
> >> > +  int ret;
> >> > +
> >> > +  /* retrieve the device */
> >> > +#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE)
> >> > +  ret = uclass_get_device_by_driver(UCLASS_MISC,
> >> > +                                    DM_DRIVER_GET(rockchip_efuse), &dev);
> >> > +#elif IS_ENABLED(CONFIG_ROCKCHIP_OTP)
> >> > +  ret = uclass_get_device_by_driver(UCLASS_MISC,
> >> > +                                    DM_DRIVER_GET(rockchip_otp), &dev);
> >> > +#endif
> >> > +  if (ret) {
> >> > +          debug("%s: could not find efuse device\n", __func__);
> >> > +          return -1;
> >> > +  }
> >> > +
> >> > +  /* read the cpu_id range from the efuses */
> >> > +  ret = misc_read(dev, cpuid_offset, cpuid, cpuid_length);
> >> > +  if (ret < 0) {
> >> > +          debug("%s: reading cpuid from the efuses failed\n",
> >> > +                __func__);
> >> > +          return -1;
> >> > +  }
> >> > +#endif
> >> > +  return 0;
> >> > +}
> >> > +
> >> > +int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length)
> >> > +{
> >> > +  u8 low[cpuid_length / 2], high[cpuid_length / 2];
> >> > +  char cpuid_str[cpuid_length * 2 + 1];
> >> > +  u64 serialno;
> >> > +  char serialno_str[17];
> >> > +  const char *oldid;
> >> > +  int i;
> >> > +
> >> > +  memset(cpuid_str, 0, sizeof(cpuid_str));
> >> > +  for (i = 0; i < cpuid_length; i++)
> >> > +          sprintf(&cpuid_str[i * 2], "%02x", cpuid[i]);
> >> > +
> >> > +  debug("cpuid: %s\n", cpuid_str);
> >> > +
> >> > +  /*
> >> > +   * Mix the cpuid bytes using the same rules as in
> >> > +   *   ${linux}/drivers/soc/rockchip/rockchip-cpuinfo.c
> >> > +   */
> >> > +  for (i = 0; i < cpuid_length / 2; i++) {
> >> > +          low[i] = cpuid[1 + (i << 1)];
> >> > +          high[i] = cpuid[i << 1];
> >> > +  }
> >> > +
> >> > +  serialno = crc32_no_comp(0, low, cpuid_length / 2);
> >> > +  serialno |= (u64)crc32_no_comp(serialno, high, cpuid_length / 2) <<
> >> > 32;
> >> > +  snprintf(serialno_str, sizeof(serialno_str), "%016llx", serialno);
> >> > +
> >> > +  oldid = env_get("cpuid#");
> >> > +  if (oldid && strcmp(oldid, cpuid_str) != 0)
> >> > +          printf("cpuid: value %s present in env does not match hardware
> >> > %s\n",
> >> > +                 oldid, cpuid_str);
> >> > +
> >> > +  env_set("cpuid#", cpuid_str);
> >> > +
> >> > +  /* Only generate serial# when none is set yet */
> >> > +  if (!env_get("serial#"))
> >> > +          env_set("serial#", serialno_str);
> >> > +
> >> > +  return 0;
> >> > +}
> >> > +
> >> >  __weak int rockchip_early_misc_init_r(void)
> >> >  {
> >> >    return 0;
> >> > diff --git a/arch/arm/mach-rockchip/misc.c
> >> > b/arch/arm/mach-rockchip/misc.c
> >> > deleted file mode 100644
> >> > index 15397cff009..00000000000
> >> > --- a/arch/arm/mach-rockchip/misc.c
> >> > +++ /dev/null
> >> > @@ -1,135 +0,0 @@
> >> > -/* SPDX-License-Identifier: GPL-2.0+ */
> >> > -/*
> >> > - * RK3399: Architecture common definitions
> >> > - *
> >> > - * Copyright (C) 2019 Collabora Inc - https://www.collabora.com/
> >> > - *      Rohan Garg <rohan.garg@collabora.com>
> >> > - *
> >> > - * Based on puma-rk3399.c:
> >> > - *      (C) Copyright 2017 Theobroma Systems Design und Consulting
> >> > GmbH
> >> > - */
> >> > -
> >> > -#include <common.h>
> >> > -#include <env.h>
> >> > -#include <dm.h>
> >> > -#include <hash.h>
> >> > -#include <log.h>
> >> > -#include <dm/uclass-internal.h>
> >> > -#include <misc.h>
> >> > -#include <u-boot/crc.h>
> >> > -#include <u-boot/sha256.h>
> >> > -
> >> > -#include <asm/arch-rockchip/misc.h>
> >> > -
> >> > -int rockchip_setup_macaddr(void)
> >> > -{
> >> > -#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
> >> > -  int ret;
> >> > -  const char *cpuid = env_get("cpuid#");
> >> > -  u8 hash[SHA256_SUM_LEN];
> >> > -  int size = sizeof(hash);
> >> > -  u8 mac_addr[6];
> >> > -
> >> > -  /* Only generate a MAC address, if none is set in the environment */
> >> > -  if (env_get("ethaddr"))
> >> > -          return 0;
> >> > -
> >> > -  if (!cpuid) {
> >> > -          debug("%s: could not retrieve 'cpuid#'\n", __func__);
> >> > -          return -1;
> >> > -  }
> >> > -
> >> > -  ret = hash_block("sha256", (void *)cpuid, strlen(cpuid), hash,
> >> > &size);
> >> > -  if (ret) {
> >> > -          debug("%s: failed to calculate SHA256\n", __func__);
> >> > -          return -1;
> >> > -  }
> >> > -
> >> > -  /* Copy 6 bytes of the hash to base the MAC address on */
> >> > -  memcpy(mac_addr, hash, 6);
> >> > -
> >> > -  /* Make this a valid MAC address and set it */
> >> > -  mac_addr[0] &= 0xfe;  /* clear multicast bit */
> >> > -  mac_addr[0] |= 0x02;  /* set local assignment bit (IEEE802) */
> >> > -  eth_env_set_enetaddr("ethaddr", mac_addr);
> >> > -
> >> > -  /* Make a valid MAC address for ethernet1 */
> >> > -  mac_addr[5] ^= 0x01;
> >> > -  eth_env_set_enetaddr("eth1addr", mac_addr);
> >> > -#endif
> >> > -  return 0;
> >> > -}
> >> > -
> >> > -int rockchip_cpuid_from_efuse(const u32 cpuid_offset,
> >> > -                        const u32 cpuid_length,
> >> > -                        u8 *cpuid)
> >> > -{
> >> > -#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE) ||
> >> > IS_ENABLED(CONFIG_ROCKCHIP_OTP)
> >> > -  struct udevice *dev;
> >> > -  int ret;
> >> > -
> >> > -  /* retrieve the device */
> >> > -#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE)
> >> > -  ret = uclass_get_device_by_driver(UCLASS_MISC,
> >> > -                                    DM_DRIVER_GET(rockchip_efuse), &dev);
> >> > -#elif IS_ENABLED(CONFIG_ROCKCHIP_OTP)
> >> > -  ret = uclass_get_device_by_driver(UCLASS_MISC,
> >> > -                                    DM_DRIVER_GET(rockchip_otp), &dev);
> >> > -#endif
> >> > -  if (ret) {
> >> > -          debug("%s: could not find efuse device\n", __func__);
> >> > -          return -1;
> >> > -  }
> >> > -
> >> > -  /* read the cpu_id range from the efuses */
> >> > -  ret = misc_read(dev, cpuid_offset, cpuid, cpuid_length);
> >> > -  if (ret < 0) {
> >> > -          debug("%s: reading cpuid from the efuses failed\n",
> >> > -                __func__);
> >> > -          return -1;
> >> > -  }
> >> > -#endif
> >> > -  return 0;
> >> > -}
> >> > -
> >> > -int rockchip_cpuid_set(const u8 *cpuid, const u32 cpuid_length)
> >> > -{
> >> > -  u8 low[cpuid_length / 2], high[cpuid_length / 2];
> >> > -  char cpuid_str[cpuid_length * 2 + 1];
> >> > -  u64 serialno;
> >> > -  char serialno_str[17];
> >> > -  const char *oldid;
> >> > -  int i;
> >> > -
> >> > -  memset(cpuid_str, 0, sizeof(cpuid_str));
> >> > -  for (i = 0; i < cpuid_length; i++)
> >> > -          sprintf(&cpuid_str[i * 2], "%02x", cpuid[i]);
> >> > -
> >> > -  debug("cpuid: %s\n", cpuid_str);
> >> > -
> >> > -  /*
> >> > -   * Mix the cpuid bytes using the same rules as in
> >> > -   *   ${linux}/drivers/soc/rockchip/rockchip-cpuinfo.c
> >> > -   */
> >> > -  for (i = 0; i < cpuid_length / 2; i++) {
> >> > -          low[i] = cpuid[1 + (i << 1)];
> >> > -          high[i] = cpuid[i << 1];
> >> > -  }
> >> > -
> >> > -  serialno = crc32_no_comp(0, low, cpuid_length / 2);
> >> > -  serialno |= (u64)crc32_no_comp(serialno, high, cpuid_length / 2) <<
> >> > 32;
> >> > -  snprintf(serialno_str, sizeof(serialno_str), "%016llx", serialno);
> >> > -
> >> > -  oldid = env_get("cpuid#");
> >> > -  if (oldid && strcmp(oldid, cpuid_str) != 0)
> >> > -          printf("cpuid: value %s present in env does not match hardware
> >> > %s\n",
> >> > -                 oldid, cpuid_str);
> >> > -
> >> > -  env_set("cpuid#", cpuid_str);
> >> > -
> >> > -  /* Only generate serial# when none is set yet */
> >> > -  if (!env_get("serial#"))
> >> > -          env_set("serial#", serialno_str);
> >> > -
> >> > -  return 0;
> >> > -}
> >>
