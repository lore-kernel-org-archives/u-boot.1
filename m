Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC1AEE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 07:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44244890A1;
	Wed, 11 Sep 2024 09:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC8B6891D2; Wed, 11 Sep 2024 09:19:37 +0200 (CEST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com
 [209.85.219.180])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F6AE882B7
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 09:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=geert.uytterhoeven@gmail.com
Received: by mail-yb1-f180.google.com with SMTP id
 3f1490d57ef6-e1d0e1bffc8so6031863276.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726039173; x=1726643973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AeJbkvhPJVWaQsL1Gg3KD5A9iDFYoBb81strZRyK6YM=;
 b=v3LqNKIUUXPM8IUomSAboQmuXPLRhqZ6k7wVyP8nIbLs8B7m5h+dNXS7X1sRDSmZpc
 IRPr0P09LOFAWdRMLyfnRc2qrBwnUMSdJOIWtE5eQZgisnI0zzJ9GOlK+jZu8VSD71Li
 BAP5YYrRL4SWnpHgHW2P99N2WqWjXZzT2y2oNI4cvPO50DoPwIONkYX4vWJHRTPZeO0l
 fAP4twLW4mmQL40zcp4gP5RX6qyxZGZiyEjhsVB7z4pt6lBozDt/CmhdAnHJhvU53gzO
 zvIVq5F3tE0hzcsKN3sBY+CqJwj6/t67Xf3VF/j5QUdhAAgMRHjNrt/WWP8b+Zi3HY9B
 lMJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfvjVcTH1rBP0mv2rX2k1G1Vw7+BhesBtpUetamhEN/ZUddOm/gC3p8KVipGBXMFHgBZEsgCE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/tZc2f2uk8ZKh4+1skZEgjqGVGtrRpwlYe1yiQjBuBWAlfnDs
 Wvf8q8SQvXxvy97anid3WF25Qy43fuDpJcue/CIC5eBKwQgPak6qJ9sO69m9
X-Google-Smtp-Source: AGHT+IHLFTyJj5ZJa0ttKFWMO01X8jW6poBl8a/BG4sRxx3RECvv2uAcJv08WBRXo4SnASDv7e/jYQ==
X-Received: by 2002:a05:690c:360c:b0:6db:9bc5:bbb5 with SMTP id
 00721157ae682-6db9bc5c521mr42287517b3.40.1726039173109; 
 Wed, 11 Sep 2024 00:19:33 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com.
 [209.85.128.180]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6db96428054sm5989057b3.14.2024.09.11.00.19.32
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 00:19:32 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-6d3c10af2efso58126317b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:19:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXWUy/r2+MlQ/75KX9SNLPymf22PfEgxfp2O8vRQjChU2PUC65oRpeEo/bqORrycwQXoYjUSWc=@lists.denx.de
X-Received: by 2002:a05:690c:f:b0:64a:90fe:911e with SMTP id
 00721157ae682-6db45154290mr154555537b3.31.1726039172169; Wed, 11 Sep 2024
 00:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240910001612.88569-1-marek.vasut+renesas@mailbox.org>
 <20240910172151.GG4252@bill-the-cat>
 <1cd4c1c1-b709-43aa-aff8-14cb1d21aee2@mailbox.org>
In-Reply-To: <1cd4c1c1-b709-43aa-aff8-14cb1d21aee2@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Sep 2024 09:19:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVvHtVmH+YP=m20U9-buXKi1+Kwcrkf8vWhQYagcg4JRQ@mail.gmail.com>
Message-ID: <CAMuHMdVvHtVmH+YP=m20U9-buXKi1+Kwcrkf8vWhQYagcg4JRQ@mail.gmail.com>
Subject: Re: [PATCH] sh: cache: Fill in invalidate_icache_all()
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Marek,

On Tue, Sep 10, 2024 at 7:55=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
> On 9/10/24 7:21 PM, Tom Rini wrote:
> > On Tue, Sep 10, 2024 at 02:15:58AM +0200, Marek Vasut wrote:
> >
> >> Implement invalidate_icache_all() by clearing all V bits in
> >> IC and OC. This is done by setting CCR cache control register
> >> ICI and OCI bits.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Cc: u-boot@lists.denx.de
> >> ---
> >>   arch/sh/cpu/sh4/cache.c | 11 +++++++----
> >>   1 file changed, 7 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
> >> index d3c480e79ed..99acc599965 100644
> >> --- a/arch/sh/cpu/sh4/cache.c
> >> +++ b/arch/sh/cpu/sh4/cache.c
> >> @@ -33,8 +33,9 @@ static inline void cache_wback_all(void)
> >>      }
> >>   }
> >>
> >> -#define CACHE_ENABLE      0
> >> -#define CACHE_DISABLE     1
> >> +#define CACHE_ENABLE                0
> >> +#define CACHE_DISABLE               1
> >> +#define CACHE_INVALIDATE    2
> >>
> >>   static int cache_control(unsigned int cmd)
> >>   {
> >> @@ -46,7 +47,9 @@ static int cache_control(unsigned int cmd)
> >>      if (ccr & CCR_CACHE_ENABLE)
> >>              cache_wback_all();
> >>
> >> -    if (cmd =3D=3D CACHE_DISABLE)
> >> +    if (cmd =3D=3D CACHE_INVALIDATE)
> >> +            outl(CCR_CACHE_ICI | ccr, CCR);
> >> +    else if (cmd =3D=3D CACHE_DISABLE)
> >>              outl(CCR_CACHE_STOP, CCR);
> >>      else
> >>              outl(CCR_CACHE_INIT, CCR);
> >> @@ -103,7 +106,7 @@ void icache_disable(void)
> >>
> >>   void invalidate_icache_all(void)
> >>   {
> >> -    puts("No arch specific invalidate_icache_all available!\n");
> >> +    cache_control(CACHE_INVALIDATE);
> >>   }
> >>
> >>   int icache_status(void)
> >
> > Thanks for filling this in, I wasn't sure how the implementation would
> > look from a quick skim of the linux kernel code.
> I believe it should look like the above, but lemme CC Geert to be on the
> safe side.

I have no idea.  I removed the corresponding (but incomplete) code
from Linux in commit 25c7d77d695a4104 ("sh: boot: Remove sh5 cache
handling"), as it was a relic of sh5 cache handling.

SH4 cache handling seems to be buried deeper. At least the above
matches for invalidation:

arch/sh/mm/cache-sh4.c- /* Flush I-cache */
arch/sh/mm/cache-sh4.c: ccr =3D __raw_readl(SH_CCR);
arch/sh/mm/cache-sh4.c- ccr |=3D CCR_CACHE_ICI;
arch/sh/mm/cache-sh4.c: __raw_writel(ccr, SH_CCR);

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
