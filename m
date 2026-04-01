Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8258D35159
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 08:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1031F83CF5;
	Wed,  1 Apr 2026 10:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rxgvblf9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 403FB83F5B; Wed,  1 Apr 2026 10:32:11 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1106183CE3
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 10:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-649278a69c5so8734811d50.3
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 01:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775032327; cv=none;
 d=google.com; s=arc-20240605;
 b=kPW+A7O/XhgXw1b1ELO/3vWys1y1yXiM+q6yUACYoWIPXqcrdL4S5zfuxK25tLMIo3
 avI+n46BvyADt16I9FpnrTe0BXNg6G8INyoqc+hXkUalzXqet09dMeIc7q9YNQBUdA1B
 YND+8alvwAfw0o6iJjqpYtUSvftsAHsPXc5yf76VFtBdpaFY/ZopSIqEi4aLbZbe3rni
 xS4bcXgWDjVAPtvZBx1lmA5Cmt7ARrdAmWu/XOt/gh6mxV8QsiTNhbGlTX4NLyRl5KPE
 2SFKTzYZ0prdQnsZJvatKyxBQ04CWNpLnwep2aqXrhDydAnM7XYRkeXl4sbsm1usSYLK
 VDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=v5l4vMuEMmAuW82Zr1Xx0MeYP+H0PcZNxSUrj2Inj0k=;
 fh=e2myD99loWwh+YvfzV79sM4cC648RzgqB8Qy3Ht1Z8M=;
 b=a8qBDTZ9T2hVAkn303PYz+ADAPR1/uLS95O8U01qEz9ppbOP22xuUStRXFDBr8brtT
 l+vgApmWvyoCe8XwoC6S9qIQHnk11oQerRybxKTrzhDIzL8d/NQyjwhYjtlpm0SL2nJ4
 ahxz1pvf6u/nmTHhI7jjDBbtG0QrIogLsDFKCEmmZ16D7/i5uMiV5dNMerTwSAif+aVq
 RL7c9802J0O10/VMifUj4dY+gmjTOnm7rMy/AKJpx4obnS2uKhOd/TnL3aRTS5pxqR8B
 RBBjao+lz0wvb6Hf855fa0Uyx1esNiu6q9wdQKe45DmWxtQp4BQd5zi0tVemZV5LqC4X
 heIQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775032327; x=1775637127; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v5l4vMuEMmAuW82Zr1Xx0MeYP+H0PcZNxSUrj2Inj0k=;
 b=rxgvblf9kXNjWzqeliXq6kWvdiMMwyvz0JpRtrGP1AmWP27qcBcEuRMOjy8KsUAESX
 JH78voxCytdSl/FSM0qY/sVGZ4vP4p+L56mFmq6g7hFu/9XczK3umff3ygd0TV27X6hP
 vSEfwhqXoXvYBkpiOwIPJolJhovkxZLtpCS0fCQ1/UDea8WD7r5m08jXXKfBCWXia1FZ
 0T9rhHwdx1zvaeaV5m99gPyfKAma6R8siqSWIZH0A85qjIQY5XWHbDtkek2Fz98EEGnm
 wkLl4mEkhzrTZS1vvJws5gfvnUkKHcopqoFPxjmxRRW0ONxTllG25BHJQiu7GAGXO2Xx
 NP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775032327; x=1775637127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5l4vMuEMmAuW82Zr1Xx0MeYP+H0PcZNxSUrj2Inj0k=;
 b=fVY9cYDoYz23c/6joBsSS2gVcEFlTH9pY+PLqocqmmhI07zLperLwiUJpP+/S7MzV0
 qwG0MoYXvhrlYuKkQQ0ed4Fbm85LbSPeQZeGJO/9tWv62WoUIgX9A6UoBfaxlWLXj2RU
 Xyi5U07Qz72D7wTcZh5UZtS8zVgAE4aC/zPq9GzvXV2XzHXmEt+zQZlnhlSC71pu0HI5
 Ul3e4c8wagAMegkW/7vNxZ+NKQhFx8os3jW/6Jop2GApKN+Qg40xnZcVcg9SMbJqzR+B
 p6bMeL2P22fvA4HP31GdaMcF+kyCBR2LwvuVYDIa5WD3t6qZLAP9Lk7MXS6X8bJ1UbRZ
 PQJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlsN9qV4E14h3318IutCVf1aIowEcurg4d6nX6jewOE4QJlGYAT96CKw7VsNtJ6xzpGSxLzic=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8OB8VZI7hXm3bhtJg5WFgIlCSoWjhC9es1dLCUx63HSdiCRh2
 WUsvEUs4O+qqLyUoLIjmGuMjTarrx70OhgY7m6NdFOPWVbLnkRx3S9EiJCmYRtSWwLzfrv4xXjo
 yZMVSKlrkxM1uLEMM4icD41ipAN1gM2Bur3coseIwnQ==
X-Gm-Gg: ATEYQzyz+lHXO65PydmAZCaHKfGg3WCpp2gAGHhGO6H2YaHBvVYOMjBQoj3rOFVj+Yj
 cOnGMblUqkV3O8pfnJ9NW7Poo3S1s5NPEdUe1nZXdlyjvSiOZ3ztWcO/N+sNx4Ztz33SBdgo7rt
 xH4r0FnpnmWrpzAxDUsSqCnnZWWKW8ONs5quLMx/pJAIniLr0PHt2oF1FFVXYqXaQRvS8AzqW4E
 iZgMIttrn1nhmBQjUBjppVBWnoXbN3GbPqOlYUiLYJANnOFPR5KAMh1whV1mKGBoh3rDUWVwdpW
 uIMNgHRaGtgFJHirdh7n+a0JuOORmLtxr5X521geGJRovGA12GLKjl8J6C7gW24CkWi0X5EH25E
 9kkkB0gNz0dEOzk2oCITAZdFYwaydQpxj4tgPWimOHZtIXPnXNSd/Db1iIYlzotVOC32N6+J6eq
 0q9fPS1YS9wPPnO9s9Lh1sb14asnKnUGbwd0hWRJKqpwfza/g8RT8A/VIs+tFg//U0QesuW4cQ7
 nzmlamky8sRGTFuhydm0dIVhhdz7Xy4GOXQMHlA3FP1s2HyNNC2Fl7Bffu8vn6UaYMOf1Jamt78
 oY219h8QULl3CbilP8T0wHd+qtLBWT92QVBmK2oFjF+R
X-Received: by 2002:a05:690e:1349:b0:64f:fd6b:e52b with SMTP id
 956f58d0204a3-6502fea4946mr2617685d50.68.1775032326751; Wed, 01 Apr 2026
 01:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
 <564fc8c9-90de-43ed-a312-5a92b16078df@kwiboo.se>
In-Reply-To: <564fc8c9-90de-43ed-a312-5a92b16078df@kwiboo.se>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 11:31:30 +0300
X-Gm-Features: AQROBzDyiMYDLHPTMdf0YMIW-c1BTy2itQRHSBkvkF7-6XNkTq1AHuywZVOFQ-E
Message-ID: <CAC_iWjKRrL8CtU5Fu-ZM=Yg8XQztfC8e6TAoCY_SGX_Ds8xHCg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] common: Allow relocations on the top of the last
 bank
To: Jonas Karlman <jonas@kwiboo.se>
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
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

Hi Jonas

[...]

> >  #if defined(CFG_SYS_SDRAM_BASE) && CFG_SYS_SDRAM_BASE > 0
> >       /*
> >        * Detect whether we have so much RAM that it goes past the end of our
> > @@ -321,6 +323,19 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> >                */
> >               return 0;
> >  #endif
> > +     if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK)) {
> > +             phys_addr_t old_top = gd->ram_top;
> > +
> > +             ret = fdtdec_setup_mem_ram_top();
>
> This seem to make assumption that memory is already fully described in
> FDT? Maybe this should instead be based on gd->bd->bi_dram, however that
> is possible initialized at a later initcall.

It is. That was my first approach in fixing it, but the
gd->bd->bi_dram contained garbage at that point.

>
> If I got the call chain correct board_get_usable_ram_top() is normally
> called from INITCALL(setup_dest_addr), and gd->bd->bi_dram banks are
> typically initialized in INITCALL(dram_init_banksize), a later initcall.

Yes

>
> On e.g. Rockchip there is no memory bank information in FDT at that
> stage and memory banks is populated to gd->bd->bi_dram based on
> information from dram init and only later possible added to the FDT for
> booting OS.

And that happens after u-boot has relocated or before?

>
> Rockchip does have a platform board_get_usable_ram_top() so this will
> not be an issue, but the new generic Kconfig option added here seem to
> have a dependency on FDT containing memory bank information, if I am not
> mistaken. Maybe something worth mentioning in help and commit message?

I can amend the Kconfig option. However, people using that default
function are already aware of this.

Thanks
/Ilias
>
> Regards,
> Jonas
>
> > +             if (ret)
> > +                     debug("failed to relocate to ram top");
> > +             ret = fdtdec_setup_ram_size();
> > +             if (ret) {
> > +                     debug("failed to calculate RAM size");
> > +                     gd->ram_top = old_top;
> > +             }
> > +     }
> > +
> >       return gd->ram_top;
> >  }
> >
>
