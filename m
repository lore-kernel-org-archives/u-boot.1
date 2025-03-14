Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B519DC35FF3
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3144981D6A;
	Fri, 14 Mar 2025 15:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KNgStmhG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D06EF81D42; Fri, 14 Mar 2025 15:43:54 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 584C781DE9
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac2b10bea16so441676166b.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741963431; x=1742568231; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9i5sQ6P4rPBYPdLC4uyF8Q5Jq/umC6V/6J3pGwEQO9g=;
 b=KNgStmhGxxcYk6zckq6fgQblc3MabqUQ2Hm/f0OtV/QvFvvsw2z5/90aRETk/G4zGm
 UYFh6iyLeIGWCE+kT6yBW5Fr5ZNBaVXp4mVgJ3p4UB9EOdsoVhBr94o9JdXF51NLMslx
 kFW3TkZnAFG5SAqzKe4bbpawJBXo754TSz46M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741963431; x=1742568231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9i5sQ6P4rPBYPdLC4uyF8Q5Jq/umC6V/6J3pGwEQO9g=;
 b=Sf9u0fu6Y3lyi7aY0VdbZYfWswr7Y2FJzZa6/NeB5/C/XOGS3HMZZ3NO1FDcyN2/wU
 4bVGLLB583icU8vgaB4BgQlUF7ieu/clWvho3Bup2B4TwEj9pqi8DuahAad+7wW6IXg+
 JdNDQPzbV6AVl8nPuVH/ZxkuZxYymt1WLT1j8MT3wbrGHqusAO6cSHJwxgzzWlCITFQx
 J9YDn1WEdm+LfzpsOnwwKPjvBqQVjaLA93f0qv6r/rXu19p+EzpoYo1ehSBQPciCPskQ
 jKCFX6iu0qolXgongH4UaTl1k8HX5e07E7XOIyLVQU14tAjDBQi9LkSKVuV2PnbOPltZ
 ywiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/D5AuwGPEmPxHPGHLvO96BMJaNCKzRuUILQFB8EOUMgdCqUb6Ii/khIehS8bhYJRMDEQvrTU=@lists.denx.de
X-Gm-Message-State: AOJu0Yyizb58qG0HVyi2722Hac1vcUCbGiKPuEQPBTh9q7RN84cjm2Fn
 InyFqGcmwHFZ09MbuuGhirL7QrHgJGtYCHg0uzDIikXUtjT1I8lrcBVAOxyICTtDaHO3wGTHLfR
 1LFJ62tIdeZtmVqs4kzaO/fYO7XNllRNP9Scu
X-Gm-Gg: ASbGnctHX/z1pBCwUsw1z3ZX/gzYA5ySLKirRAUE82c0K3Mx2VH7FjOLKlahHeDrXTn
 OCFSvdGOyvMMgBC4bAUUrELMBDXEB/dWg2zEZXybs/QxoVf+HMfZ04JOP756f5cLvBTU7ypTChS
 knV4tFmX01kzZtvqXyMMtu7RTRx87c
X-Google-Smtp-Source: AGHT+IGxpiuq8/22HjYHLtWGrg/0hsH8tEqOFXh+/X7+OtLAmpPseZMUyf+xpSp+e/MpqmY7IVyM5X756BqkwxzBX3c=
X-Received: by 2002:a17:907:d92:b0:ac3:154e:1391 with SMTP id
 a640c23a62f3a-ac330109516mr388831066b.10.1741963430812; Fri, 14 Mar 2025
 07:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250306002533.2380866-1-sjg@chromium.org>
 <20250306002533.2380866-8-sjg@chromium.org>
 <c2ec9cf9-75fd-4f2e-9c0a-16269e42d148@gmx.de>
In-Reply-To: <c2ec9cf9-75fd-4f2e-9c0a-16269e42d148@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Mar 2025 14:43:39 +0000
X-Gm-Features: AQ5f1JqYqxSOoIB-t1JksDcfRAiFq8_G7f4r6BNU4RDDILC4yid0Th62f42ig3U
Message-ID: <CAFLszThLKo809gmSB6Nr2y4=Y6cTMqgXf2K3JvGRf6qMmWwTdg@mail.gmail.com>
Subject: Re: [PATCH v5 07/29] bootstd: Correct display of kernel version
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Sat, 8 Mar 2025 at 05:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 3/6/25 01:25, Simon Glass wrote:
> > The address of the bzImage is not recorded in the bootflow, so we cannot
> > actually locate the version at present. Handle this case, to avoid
> > showing invalid data.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   arch/x86/lib/zimage.c | 13 ++++++++-----
> >   cmd/bootflow.c        |  2 ++
> >   2 files changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
> > index 7f4b117b403..d71285e71d9 100644
> > --- a/arch/x86/lib/zimage.c
> > +++ b/arch/x86/lib/zimage.c
> > @@ -558,7 +558,6 @@ void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
> >                bool show_cmdline)
> >   {
> >       struct setup_header *hdr;
> > -     const char *version;
> >       int i;
> >
> >       printf("Setup located at %p:\n\n", base_ptr);
> > @@ -595,10 +594,14 @@ void zimage_dump(struct bootm_info *bmi, struct boot_params *base_ptr,
> >       print_num("Real mode switch", hdr->realmode_swtch);
> >       print_num("Start sys seg", hdr->start_sys_seg);
> >       print_num("Kernel version", hdr->kernel_version);
> > -     version = zimage_get_kernel_version(base_ptr,
> > -                                         (void *)bmi->bzimage_addr);
> > -     if (version)
> > -             printf("   @%p: %s\n", version, version);
> > +     if (bmi->bzimage_addr) {
> > +             const char *version;
> > +
> > +             version = zimage_get_kernel_version(base_ptr,
> > +                                                 (void *)bmi->bzimage_addr);
> > +             if (version)
> > +                     printf("   @%p: %s\n", version, version);
>
> I cannot image that a user cares about the location of the version
> string in memory.
>
> If this is an information is really needed by developers, please, put it
> into a log_debug() message.

Sometimes the cmdline doesn't work properly, e.g. with ChromeOS
images. So I want to show the address so that people can use 'md' to
figure out what is going on.

Regards,
Simon
