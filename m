Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E92C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 13:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B4578845A;
	Wed, 19 Jun 2024 15:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s9krlbeL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2637E88445; Wed, 19 Jun 2024 15:05:59 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DAE58845A
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 15:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-6c5a6151ff8so4696507a12.2
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718802354; x=1719407154; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q2jCCjKWHJ5l2wQIlGarBbyqUCJz1LZtjlhL5xn3A24=;
 b=s9krlbeLcKfrZr3I/HHiCKqvYSeLUI/KFKUKAzo+cwWQHDcw03uizZfTAcxhmYjCQD
 LV3G5Sqsm6/WNaevJg/oJ8m2KOmzusIZO5y3/5cnn9GAfGMs6M2Ge4rZMK6ftlqAvv6y
 J7TwUeTjv+3x+k3P1hP0tsinygOv6YLsMqVJiJx1n8U9/wGXzZ8ATeqiGzFdofozrQE0
 Z/AO6tuspXkYOHt/EGBRlcoHeFBsVTVdp4Gh+QqDYRS67kIbt7+NbnuqeQolC090ku6O
 d1IcpbjlmnhZZcY9SaVrCPVJWjNnF0CDsfs5vByOZl0yDv4zPuxpSiSGZQXo72i931oe
 6YBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718802354; x=1719407154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q2jCCjKWHJ5l2wQIlGarBbyqUCJz1LZtjlhL5xn3A24=;
 b=rd/1h44Zsp4IpkKrswP9JPNvPV+sdOrHBeLs8DFwpDnePEk28kz8b11ODs4Ofzh7c+
 qPhZzjECXWwsdlQ5JA0kKVgIQMkXwoUfQY46pa5/5MS2CG0kAbaZJhBa5z97ZdKi9zph
 OKEK8fmGUJ1vwkkQWXD7/kCe55r/ep/CgbG/HuCYjGagu1uPtS8L/JXkEQrAhip8U2nh
 iITTt/8g7AescaCW/RvK3VTlNpLrJ8eHQAIYHP/Q2+NWl8DPH2f+ymgu5Eh9pPl2GKne
 oGOqW3XyhnzHvqHx7ZLA74+sjvGq13eCVjqsZbqM629Pcokw821ogc/tKixvQK49ZVMg
 NU/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwtNTJMJq4V2MLKfdC7K7ZB4E10D7DBKVV9i/S43OfWNWKJPEmlMSkjWJLPbymJM3yA++Vylh9t43phMEyBOb1N3MSMA==
X-Gm-Message-State: AOJu0YxWDmhQ2EMaqT38UOZU1NZhenTZLL+ZLVyOswV01yVOO/OMW19v
 IZHmk1Ql5HvM2GW1TbxRViPgUPaMdXeHe7Tp/knnGvXChFHuK9KyeWnEO5B9VnQZNRmLB3oOuWb
 +O/KojRRCyhCsA/jJYTDsGqFQdyykH8hbEopC9Q==
X-Google-Smtp-Source: AGHT+IGNpkWftePOWNK4TzxhQOXuQRcV3a7V6Tmt+B3hQNZV0xjTs9u+iWoeKZCGTdJVKOH+Sg8FeempNVm/vcOvuUs=
X-Received: by 2002:a17:90b:fd8:b0:2c2:fed1:769f with SMTP id
 98e67ed59e1d1-2c7b5c8234cmr2460571a91.13.1718802354011; Wed, 19 Jun 2024
 06:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
 <20240616173105.7430-2-heinrich.schuchardt@canonical.com>
 <CAC_iWj+W5grPjuD9=v7ZOYGPFDE7_mFxF7fJhERTTJCjjpk4aQ@mail.gmail.com>
 <e1fb4d81-a20c-4a10-904e-8b19eb17f4e5@canonical.com>
In-Reply-To: <e1fb4d81-a20c-4a10-904e-8b19eb17f4e5@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Jun 2024 16:05:17 +0300
Message-ID: <CAC_iWjKwP0psK0cuQLion54h5ZQdYL8-R_1oDvTYktin56OFDQ@mail.gmail.com>
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

On Wed, 19 Jun 2024 at 15:36, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 19.06.24 14:23, Ilias Apalodimas wrote:
> > On Sun, 16 Jun 2024 at 20:31, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> If we have multiple weak implementations of functions, the linker might
> >> choose any of these. ARM and RISC-V already provide a weak implementation
> >> of flush_dcache_all().
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   cmd/cache.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/cmd/cache.c b/cmd/cache.c
> >> index 0254ff17f9b..16fa0f7c652 100644
> >> --- a/cmd/cache.c
> >> +++ b/cmd/cache.c
> >> @@ -52,11 +52,14 @@ static int do_icache(struct cmd_tbl *cmdtp, int flag, int argc,
> >>          return 0;
> >>   }
> >>
> >> +/* ARM and RISC-V define a weak flush_dcache_all() themselves. */
> >> +#if !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
> >>   void __weak flush_dcache_all(void)
> >>   {
> >>          puts("No arch specific flush_dcache_all available!\n");
> >>          /* please define arch specific flush_dcache_all */
> >>   }
> >
> > Aren't we supposed to add a single __weak function so the linker can
> > replace it? IOW why is the declaration for Arm/riscv a weak one?
>
> Some sub-architectures override the architecture specific weak
> implementation, e.g.
>
> arch/riscv/cpu/andes/cache.c:44:
> void flush_dcache_all(void)
>
> arch/arm/cpu/arm926ejs/cache.c:17:
> void flush_dcache_all(void)

Ok, this does fix a problem, but afaict this is a band-aid and the
cache management is a mess overall -- e.g invalidate_icache_all() will
suffer from the same issue if a sub-architecture decides to define its
own in the future.

Would it be less bad to define
static inline __weak flush_dcache_all(void)
{
}
static inline __weak flush_icache_all(void)
{
}
in include/cpu_func.h instead of a random cmd file?
We can only define those if !CONFIG_ARM && !!CONFIG_RISCV and add a
comment on why.
It's kind of putting lipstick on a pig, but at least we'll have them
gathered in a single header file and know what we have to fix.

Cheers
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> > Thanks
> > /Ilias
> >> +#endif
> >>
> >>   static int do_dcache(struct cmd_tbl *cmdtp, int flag, int argc,
> >>                       char *const argv[])
> >> --
> >> 2.43.0
> >>
>
