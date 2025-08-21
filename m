Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9393CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 06:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC68580B9B;
	Thu, 21 Aug 2025 08:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iLCZVozq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 726B281D5D; Thu, 21 Aug 2025 08:17:58 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E533F80422
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 08:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e95011504d4so658870276.3
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 23:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755757075; x=1756361875; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JxAm+9dtG/yAMxzxdnP8QX4p+PxVMuVVkPQogQgWBc8=;
 b=iLCZVozq6632IQ8pOlpN8HV/bz4Rr7J/UejvU9MDc7v0l39oXC8ep2rrqUdzd9uuid
 sHf6eiIcCTOOBWIxphVW0OjacIbyzCEDM2GU2KCfqU0al7g2qABubL9oUkBaYXCcBY/G
 QtDjxtkfUjwI2SRFL2UKRj6YNMDBM/E7a/naFRxWIsA/A7EA5R7U8MiesTdDp8hHXZRb
 2nc7Pvv9GSo3uZb+7+mjbJOyAknkMvu2c9kW7YPpAiNCl2mkhXg45AodSFuYAFeLf53L
 Ugqn5hRI1rTQH6DeqrjEaVdESrEtB5OwMVYNFSJYsZiW/FliDtZ8xj3aPM931mH97VIk
 0XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755757075; x=1756361875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JxAm+9dtG/yAMxzxdnP8QX4p+PxVMuVVkPQogQgWBc8=;
 b=cb/uRhCCPI2acH9QjBQv9PSS0YcFYY0GnHYXhTN5RKHqQMaJRc6VZGXVzxHCcPKSJ2
 vL6+Dal2j0ZYv4r+OL/m4aCzbOiwNQ6ep5P+9qUOB158Xlf3Lua2hXoKC/vnU+r/lQU8
 se4Hr0nItr0er897v4A6Iph6GVCJDICDu+yg352T5afk4C9kyXvTn9/QwoYudl4oXnuJ
 ml4dHPKI5VJPEjhWIULlQT1Iv9uW9TFuKfv0SCE1fsTahbagikMAZBU4CQL2MUTVhJ/5
 U5t3tH0AnTx2/aWf7TjYLigHbC/iMXtjxB1gwRkTkk0IWoWeidO5P8CtG3whAruQN4X1
 Ldqg==
X-Gm-Message-State: AOJu0Yw6boc6kIeujP7cqyTjjefx+VKZPHGB4sJ5E2i161cxV5wJFuGu
 ZudHMLLlnUqvhONSLoU5YMfnndhmooxHyVPgfU3eSLL+NlRM6ylSfL8fbuxJ3NfoFzRIPt8OZ4c
 2We40/OwiN0NgFWSW5lie7v8od7SxO48HZwiAgF71CQ==
X-Gm-Gg: ASbGncs/WLSGKV8iqM8JXS99CZn9sFP5cPOJvM4epAZcqJhFrGjK5Y1y4DJnxga3zN/
 Igo+NGt+29aFBHPGWlQM+ueNLje8Dzwo4mlhaefOCdC6K+1wHgxeQWBSTi5dKl5NB5TkyjU0hZA
 qFkGCwcAFzo8rE6wV6BmmavLFaPNUl0rhx9ChOo4X1YgvNNduwNnp+bqOSi7W/MLYCPLkMrO5V4
 iTTWZTxe8SwLt5NYTSm60r+JZ60HMF3i+tlA/n9
X-Google-Smtp-Source: AGHT+IHS9hIZtcDSCiyHNdvS8wYjTZbm/e0tZzuimd6/m77/aH2GJ3wh9vHsPiNy6/R2kQW9ftYroS4Ayj1KCdZAc2A=
X-Received: by 2002:a05:6902:3485:b0:e94:fa5b:5b9e with SMTP id
 3f1490d57ef6-e95088ffa74mr1305186276.16.1755757074714; Wed, 20 Aug 2025
 23:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250703133533.104758-1-anshuld@ti.com>
 <20250703133533.104758-4-anshuld@ti.com>
 <DB63G6T323QW.2AQUT656TKCGJ@linaro.org> <DC28GWHJ2HQM.2OO7QTNTJ2UMT@ti.com>
In-Reply-To: <DC28GWHJ2HQM.2OO7QTNTJ2UMT@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 21 Aug 2025 09:17:18 +0300
X-Gm-Features: Ac12FXzYP9JYVKJJmSRxc9H2POvmpezh6NlGuz65vf_mThy3MxEZATVt8FIo2k4
Message-ID: <CAC_iWjJNTw7DKOuJ0_hJiVMZxWZn0cAY54ybJaWdbBNuWira4A@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] mach-k3: add dynamic mmu fixups for SPL stage
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, trini@konsulko.com, nm@ti.com, 
 robertcnelson@gmail.com, w.egorov@phytec.de, francesco.dolcini@toradex.com, 
 ggiordano@phytec.com, m-chawdhry@ti.com, a-nandan@ti.com, afd@ti.com, 
 bb@ti.com, u-kumar1@ti.com, devarsht@ti.com
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

On Thu, 14 Aug 2025 at 17:52, Anshul Dalal <anshuld@ti.com> wrote:
>
> Hello Ilias,
>
> On Tue Jul 8, 2025 at 1:39 AM IST, Ilias Apalodimas wrote:
> > Hi Anshul,
> >
> > On Thu Jul 3, 2025 at 4:35 PM EEST, Anshul Dalal wrote:
> >> On platforms with spl splash support such as 62p and 62x
> >> (CONFIG_VIDEO=y), the top of DDR is reserved for the framebuffer.
> >>
> >> The size of the framebuffer is computed at runtime by video_reserve.
> >> During the MMU configuration an entry corresponding to the framebuffer
> >> should be dynamically created to properly allocate the required space
> >> for the framebuffer.
> >>
> >> Therefore this patch adds k3_spl_mem_map_init which adds the required
> >> MMU entry by querying the gd after the framebuffer size has been
> >> computed in spl_reserve_video_from_ram_top.
> >>
> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> ---
> >>  arch/arm/mach-k3/arm64/arm64-mmu.c | 13 ++++++++++++-
> >>  arch/arm/mach-k3/common.c          | 17 ++++++++++++++---
> >>  2 files changed, 26 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-k3/arm64/arm64-mmu.c b/arch/arm/mach-k3/arm64/arm64-mmu.c
> >> index 49dd6fcb23b..b1b287f2114 100644
> >> --- a/arch/arm/mach-k3/arm64/arm64-mmu.c
> >> +++ b/arch/arm/mach-k3/arm64/arm64-mmu.c
> >> @@ -131,6 +131,13 @@ static int k3_setup_extra_mem_banks(unsigned int *map_idx)
> >>      return 0;
> >>  }
> >>
> >> +static void k3_spl_mem_map_init(unsigned int *map_idx)
> >> +{
> >> +    if (CONFIG_IS_ENABLED(VIDEO))
> >> +            k3_mmu_add_cachable_entry(gd_video_bottom(), gd_video_top(),
> >> +                                      map_idx);
> >> +}
> >> +
> >
> > I don't know wnough details for this board, but generally speaking we should be doing
> > this commonly for all arm64 platforms. There's mmu code for that. Can you explain why
> > this is only useful to k3?
> >
>
> Could you point me to the relevant mmu code for it, from what I know
> U-Boot doesn't map the framebuffer region at SPL stage by itself. Though
> I'll replace k3_mmu_add_cachable_entry with something like
> mmu_map_region in the next revision.

We have functions like mmu_set_region_dcache_behaviour(),
mmu_map_region(), mmu_change_region_attr() etc. If you are missing
some configuration for the MMU, we are better off adding it for all
Arm platforms, not k3 specifically.

Thanks
/Ilias
>
> Regards,
> Anshul
