Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAE8C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 13:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54DC5881C6;
	Wed, 19 Jun 2024 15:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lIxAc5Y6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFF0C831A1; Wed, 19 Jun 2024 15:20:27 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1BE28844B
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 15:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-704090c11easo5471704b3a.2
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 06:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718803223; x=1719408023; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rb9SJEYarf/kwmATfhCjOp9a8e0JW+85v1BAgtaBGiw=;
 b=lIxAc5Y6tsl4+9T8h2F4QgU8gCew1qe+dCKvfjWL0whoJ/Lpn3FM9ELX65Iy0g980E
 6Xx8LZDEqDaM1DgQspj18xWVIaMS5zi7QWqfzpJDNTipSpXcnioylINIXzPooxcFpfDB
 vYj/vaMUjeDA+apCf7GWivcRNQUjeBqlqUiKpy6PFGYVfp3NDLR5SARERfC7+OQOuHLX
 hNFVokVLUUJscmlzoKYhtNb964gTSeY3jddU8PsQ5YLiYWoFQz/nli1QVBoGEooYA0Wk
 tyw0rGcCAn4uaGqZhXZ09HwJ3M0Y9gX5dPjrzXWEMf25I4U4N1OJ/wZZe5o7jLoGzLOk
 oDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718803223; x=1719408023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rb9SJEYarf/kwmATfhCjOp9a8e0JW+85v1BAgtaBGiw=;
 b=P9mA0laMMMHgamfk9tVUWkM+utZfaSnXPG409JOV94wE7HXtXE78Yig5HO5wlsqgPo
 tbjxnBpbS2RYNbSy8cItfYgdf6Yz+d/n2599mF7mKozLRwpWZqsPBXS/FYIHEL29gWU3
 ELEtwuVpmPNoXI4GgnAsLRT1Bnl0/Xal4i6dzFn5003Y5O0pj+SBZ5G7pYK78YHP0swn
 eYgglKysZEBrU2g6oVnT/dDz03LuZmap2RzL5y5qkKUg0mrKL7ePPVjDd9ls6T7b1uY2
 4G/z59Nt2yAOmKYe9V1A7Vu8vJXoQmlBJf0ZNn/Wfdwkbi9sPyq1gCl2sye0vNPbwAHo
 VxJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2DjfNcINeBeAeMsOBAbGLDhXzr3HzVMNFrjmOevBUTjrnzrULH7kT614u0+Q3lE6nUiNLj79Uxdt22otCZN5KDM00eg==
X-Gm-Message-State: AOJu0Ywsz0xwCVmV8XziXCj4fdRKYVZ372j2yNIjJdYhywBbyxbmYwMq
 EckiLhXp97OrgzjZ53yzh5g3bujJBcfBzaggWc0TxEDCVriSFjtYsfwI14dM2YaAL68lKMWY0ef
 S9yVaTNyfCexU3P+UsSPKfg9eckrZrqsrqK3hrg==
X-Google-Smtp-Source: AGHT+IHwjTLIhDzwM6xQL0dq67K/0e4A6wmqxoOc8WMvzp0cPOuJSIGXBvUDgJzIFpIF7aVnXQ4LHUSqMF9D0EMVy10=
X-Received: by 2002:a05:6a20:4c82:b0:1b8:94a0:4a65 with SMTP id
 adf61e73a8af0-1bcbb5cd4bcmr2322542637.36.1718803223119; Wed, 19 Jun 2024
 06:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
 <20240616173105.7430-2-heinrich.schuchardt@canonical.com>
 <CAC_iWj+W5grPjuD9=v7ZOYGPFDE7_mFxF7fJhERTTJCjjpk4aQ@mail.gmail.com>
 <e1fb4d81-a20c-4a10-904e-8b19eb17f4e5@canonical.com>
 <CAC_iWjKwP0psK0cuQLion54h5ZQdYL8-R_1oDvTYktin56OFDQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKwP0psK0cuQLion54h5ZQdYL8-R_1oDvTYktin56OFDQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Jun 2024 16:19:47 +0300
Message-ID: <CAC_iWjL3pSQDgkNvLQjUEO2JbhtaRhCy81ZDn=WPiONmEZvVWQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] cmd: avoid duplicate weak flush_dcache_all()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Sam Edwards <CFSworks@gmail.com>, u-boot@lists.denx.de
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

On Wed, 19 Jun 2024 at 16:05, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 19 Jun 2024 at 15:36, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 19.06.24 14:23, Ilias Apalodimas wrote:
> > > On Sun, 16 Jun 2024 at 20:31, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> If we have multiple weak implementations of functions, the linker might
> > >> choose any of these. ARM and RISC-V already provide a weak implementation
> > >> of flush_dcache_all().
> > >>
> > >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >> ---
> > >>   cmd/cache.c | 3 +++
> > >>   1 file changed, 3 insertions(+)
> > >>
> > >> diff --git a/cmd/cache.c b/cmd/cache.c
> > >> index 0254ff17f9b..16fa0f7c652 100644
> > >> --- a/cmd/cache.c
> > >> +++ b/cmd/cache.c
> > >> @@ -52,11 +52,14 @@ static int do_icache(struct cmd_tbl *cmdtp, int flag, int argc,
> > >>          return 0;
> > >>   }
> > >>
> > >> +/* ARM and RISC-V define a weak flush_dcache_all() themselves. */
> > >> +#if !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
> > >>   void __weak flush_dcache_all(void)
> > >>   {
> > >>          puts("No arch specific flush_dcache_all available!\n");
> > >>          /* please define arch specific flush_dcache_all */
> > >>   }
> > >
> > > Aren't we supposed to add a single __weak function so the linker can
> > > replace it? IOW why is the declaration for Arm/riscv a weak one?
> >
> > Some sub-architectures override the architecture specific weak
> > implementation, e.g.
> >
> > arch/riscv/cpu/andes/cache.c:44:
> > void flush_dcache_all(void)
> >
> > arch/arm/cpu/arm926ejs/cache.c:17:
> > void flush_dcache_all(void)
>
> Ok, this does fix a problem, but afaict this is a band-aid and the
> cache management is a mess overall -- e.g invalidate_icache_all() will
> suffer from the same issue if a sub-architecture decides to define its
> own in the future.
>
> Would it be less bad to define
> static inline __weak flush_dcache_all(void)
> {
> }
> static inline __weak flush_icache_all(void)
> {
> }

ugh, this but without the inline!

Thanks
/Ilias
> in include/cpu_func.h instead of a random cmd file?
> We can only define those if !CONFIG_ARM && !!CONFIG_RISCV and add a
> comment on why.
> It's kind of putting lipstick on a pig, but at least we'll have them
> gathered in a single header file and know what we have to fix.
>
> Cheers
> /Ilias
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > > Thanks
> > > /Ilias
> > >> +#endif
> > >>
> > >>   static int do_dcache(struct cmd_tbl *cmdtp, int flag, int argc,
> > >>                       char *const argv[])
> > >> --
> > >> 2.43.0
> > >>
> >
