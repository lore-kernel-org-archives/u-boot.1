Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472A0CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 23:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1075384CE4;
	Sat,  9 May 2026 01:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SeAT22RK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9385484DC4; Sat,  9 May 2026 01:35:29 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 959F584CB5
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 01:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso451238366b.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 16:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778283327; cv=none;
 d=google.com; s=arc-20240605;
 b=VYUQnpod/E7WqHHN+iKFuARajwSm7m9y9AndzivZZ9qtFNIXyBwxOIzMCueJHPha/I
 bQV6Mfa58k4xtLs03ZXqdb+Z90jWD1Hm63ZglhOe3NVkWvdAsaVvgmfTy9EhNQsHN/RU
 3n2+a4G/W6pSgkURmdNgVyKsyVWroahXmnlgpXVLmzqw32TcA0poiTh00v7iqoHeUYDQ
 oyjea4yw8b86LE21F3/4LP6KrtD7+ZYPwfBB+YMqY4NKl4ZwoWA1hXWHQeMycv+iLpIl
 dcoIR05hKbxSv2K/JvRUIm3i/tgeewq+QLatUNZRuCb/Fu3hIPORcJIrtot2As9GMFVM
 8qPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fZlhCMx+5LQgWMnPjrjCKEcpbJAf+CeOF8JLBTGw2v0=;
 fh=OMdMp5zm0Yx9DaOy7mcqcnEdJmI4hTValUV08EboMbI=;
 b=KGYHyu8PauWxfKP3gxWux0GYtwXEHXrvb6ubk2Y0AZioYnbGfPmRIckxhTS1Fl/k+v
 qPzU0+mCrmG4ecesYkPXNq7ZSr+osmh6MUKLjOSfVTC/5Ht99IUKN4KORUO2uJLLeQN7
 /AJxH/Dh3GZKxBSuauskl9eS2gQnJGElVtrUfQWUApA0L1vMDrMyJYdQoZqwSH1VGzW2
 P147FKFphvTcX9hmpReWoPPuRGvCIh2ftMD0VFiqMoODBPGr/5Uw7ZU+HoVkjguVEXrc
 oHA0WjPY3UcwfsRAGvJPqsyCn3zbXzY/HkNcTVoltvj6YiAql1bvmNK3WTDOTowcrlUl
 j7sQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778283327; x=1778888127; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fZlhCMx+5LQgWMnPjrjCKEcpbJAf+CeOF8JLBTGw2v0=;
 b=SeAT22RKFHY1bIT1PEoIJUONrnUfsF+lPiO63637WGARF3x6/a++/PoilLgq6musIU
 btPp/QIAlblUC8s4RWy+0jVhnf3q63PUfkQFdJn665PDaeKo7ELX+zuSg8smHYQUbd1c
 +I2X9ty26bIfLJmcp8jR01U/7O1bT2xMqFSBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778283327; x=1778888127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZlhCMx+5LQgWMnPjrjCKEcpbJAf+CeOF8JLBTGw2v0=;
 b=mO881ZxbryWhoe1YpTtPGmZ0PpkHoESqEi2D135UpHFEvycB1WZid6ZApUk2BCMuhw
 ElfNrxgl0PakBEcwN9QvlkopiOs52stDI3q/FHecTGxhF23DYh6nFrtVLmVY0f4h4zdT
 ykSk2xO/YE7vI2nqtto5+CD6xyaiOneRJ3bEnZG8l4PMQwL7S7mwmQ2pKADEXGL3HiwG
 0h1e8azEmSGBF/myoFczLAMUsNAI5lBXB+VO1pBYrOumQH0Kmg/Oq9gtzCWaXijKn4Xa
 4Qsku1XLUJhuI/RL4POL2SN36dJlG2wdmJyWYb5v6BllOcVLx9wVU4F6ffUjoczQm+xE
 VZ+w==
X-Gm-Message-State: AOJu0YxjYG/6RhjYCT20POu+tkKfK1MegZZBxO8jZ2JB2O7fRMkTXvxO
 o+IEg1m6Y/qkyrKeRAfqN3sgluDFXI8/vunlGO/UWNlVa3/MpmnqsVy8vS5DvFJvN/VjkS+ZUsk
 rZWGUvK25gEqrk4TvSmWpufH/kIRFlxi+qF2NnrD7
X-Gm-Gg: AeBDies+RCfDmxRazgUp6M944U4Zxy2Fqzam0MNfUIt/5MOl+y9p0X5Kxc8BJ9Myphp
 pn93EX2GK+wuOD3lcTaVXfZ1T5eIUJYTQLg5Otv6gStJws4W1PKJ+0FB4+i1ng50upPVpKbHAzo
 gnGjioDWQUs1gzNikxVPj8ppvI3Di/lPTZjN5c4PxJB9T2Ji3ipakvCOHMAwIX6AMrUd/o7N/ua
 dlAcTaOZawnXclQP5hmCtuXro2EZHsqDMBhDviRcVNm1CZhqXEPFiow2x0qdUS+QxLa7TyY/BcF
 dahMCg==
X-Received: by 2002:a17:906:ee84:b0:bc5:114c:956 with SMTP id
 a640c23a62f3a-bc84cc73483mr460949166b.1.1778283326917; Fri, 08 May 2026
 16:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTh2DQoNKvMEBaArMhmrN87Sjo8Wnp00AQUEN3XMnCa1mA@mail.gmail.com>
In-Reply-To: <CAFLszTh2DQoNKvMEBaArMhmrN87Sjo8Wnp00AQUEN3XMnCa1mA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 17:35:14 -0600
X-Gm-Features: AVHnY4Kq7GFKz5fSM-YPQGotduoNIRDufz3sEbQ4v29krZIxf5KDItrkCR13q2o
Message-ID: <CAFLszThRtzgm-PR7OJBOeCfVmdsHES7=YZrxdTcjbsM-0Mcadw@mail.gmail.com>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>
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

+Peter Robinson

On Wed, 29 Apr 2026 at 17:31, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Marek, Mark,
>
> On Tue, 27 Jan 2026 at 16:49, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
> >
> > Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
> > and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from
> > same bank"). These are based on incorrect premise of the first commit, that
> > "U-Boot does not use memory above ram_top". While U-Boot itself indeed does
> > not and should not use memory above ram_top, user can perfectly well use
> > that memory from the U-Boot shell, for example to load content in there.
> >
> > Currently, attempt to use that memory to load large image using TFTP ends
> > with "TFTP error: trying to overwrite reserved memory...". With this change
> > in place, the memory can be used again.
> >
> > Fixes: eb052cbb896f ("lmb: add and reserve memory above ram_top")
> > Fixes: 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank")
> > Reported-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > ---
> > Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> > Cc: Casey Connolly <casey.connolly@linaro.org>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Holger Brunck <holger.brunck@hitachienergy.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Jonas Karlman <jonas@kwiboo.se>,
> > Cc: Mark Kettenis <kettenis@openbsd.org>
> > Cc: Sam Protsenko <semen.protsenko@linaro.org>
> > Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: u-boot@lists.denx.de
> > ---
> >  lib/lmb.c | 17 +----------------
> >  1 file changed, 1 insertion(+), 16 deletions(-)
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index e2d9fe86c14..8f12c6ad8e5 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -611,7 +611,6 @@ static __maybe_unused void lmb_reserve_common_spl(void)
> >  static void lmb_add_memory(void)
> >  {
> >         int i;
> > -       phys_addr_t bank_end;
> >         phys_size_t size;
> >         u64 ram_top = gd->ram_top;
> >         struct bd_info *bd = gd->bd;
> > @@ -625,23 +624,9 @@ static void lmb_add_memory(void)
> >
> >         for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> >                 size = bd->bi_dram[i].size;
> > -               bank_end = bd->bi_dram[i].start + size;
> >
> > -               if (size) {
> > +               if (size)
> >                         lmb_add(bd->bi_dram[i].start, size);
> > -
> > -                       /*
> > -                        * Reserve memory above ram_top as
> > -                        * no-overwrite so that it cannot be
> > -                        * allocated
> > -                        */
> > -                       if (bd->bi_dram[i].start >= ram_top)
> > -                               lmb_reserve(bd->bi_dram[i].start, size,
> > -                                           LMB_NOOVERWRITE);
> > -                       else if (bank_end > ram_top)
> > -                               lmb_reserve(ram_top, bank_end - ram_top,
> > -                                           LMB_NOOVERWRITE);
> > -               }
> >         }
> >  }
> >
> > --
> > 2.51.0
> >
>
> A bit late, but this seems to break rpi5 for me - the board in my lab
> has only 2G of memory.
>
> Has anyone else noticed this? I can send a patch if not.
>
> Regards,
> Simon
