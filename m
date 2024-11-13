Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E66DD597C5
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 02:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB38288CEC;
	Wed, 13 Nov 2024 03:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T4cpgMrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C80388CF1; Wed, 13 Nov 2024 03:30:22 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A59A188A3C
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 03:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6e5a5a59094so59242677b3.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 18:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731465018; x=1732069818; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WjVZwrO6w+4zjafpx+DYHqlo8bFe0VkAH8RfTp0wos=;
 b=T4cpgMrVqk0HcktMQZ4rBGiLBTCmxFRECKGOxm7riZDOFWYS53lnM/LOizV4JQbAKy
 Qyp0cH6LQQSWU8nGKMcqLBq1sMm/NXBHlEgZnj4YHpRv/Oq3hM7/n9akWOrOsVmny1HW
 RSxy4fG4l/zENBqxvVrspluIrLtj2qNLVsMU9sBffJ353gKW4tqTHy7ItHXjIta75iqj
 7AdSyGuu8iejSldS9hhlsxUVykK1sqihlPsaEhRFLCdjDb+fJ7ESMuYEO6q2zlvOPocL
 ABODiXA65aYegd6H8Am2rUStP66A4uNovQMJ6/M5UrGxEyZmWGFgT70aMqg5d1dE9N+4
 jWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731465018; x=1732069818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6WjVZwrO6w+4zjafpx+DYHqlo8bFe0VkAH8RfTp0wos=;
 b=IU72CIf07gnBbh/nqdiPpCKdWyGpceEYcJGSuxiJAClb0lKIUIAh5C1+ToH8B3eO4U
 yWNvMrEVjcg9Kg5RyFYqgzxdDUP3Mh/H5/wwmUnaECwOei7tvqztxismCJJ4Y1eBe0Dd
 fYKYTu0yxnvE6VvccPm0NNA3SDAbFgeYwgNbKvoZjvzM+kog/rGMzoRkN8fTXN61nuOY
 kEYnqLxDbsN6VMsgrHEdVoG8YW2J81jgHo0IzOWuNLwIgBPzJxyVZzUcwJpz8wUz/aYk
 zO24zy/YvOs1ZnjD0e3Osa48zO0xR3Y/nPLu5ZPiOmTT7q6AwIOF1uYgLUsRF/AFeyjF
 GsQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6eW/G7PRnDMWuC84x2t9iGUoKyoFLNXOeeLKjAYKjl9DH/BAjCM9sOGay+xo6SIpw4anRGQ8=@lists.denx.de
X-Gm-Message-State: AOJu0YwVACHmFiET3d6gDbwCMJRmw34qBiXaK7e7UoGWPpLCunetjWxP
 qrW8FVC7RrEConogwj4knYExEPJyy9XyCpEdWNKYU6YAjlGiZmYGzl5yiRi1bgwoLWwKayzObob
 u3BhjQ5bE4/ScgqUoRg9gEqOfJSRoeZ3+ZDjzFA==
X-Google-Smtp-Source: AGHT+IEjSFBd51/SHWMIrbEBbGdvP2RREP6P6ZuoXfnuvnKBaWVwqBOdQaIrosj2XcQLs8hE8sy4ongp6Z6a1FhZz4w=
X-Received: by 2002:a05:690c:7308:b0:6e3:3521:88ff with SMTP id
 00721157ae682-6eaddd9507amr195263597b3.18.1731465018536; Tue, 12 Nov 2024
 18:30:18 -0800 (PST)
MIME-Version: 1.0
References: <20241107025831.5459-1-semen.protsenko@linaro.org>
 <CAC_iWjJVRvi2WB5ChTq26KLVdhoACq2FyFqM5jrk5uKM_CZ93A@mail.gmail.com>
In-Reply-To: <CAC_iWjJVRvi2WB5ChTq26KLVdhoACq2FyFqM5jrk5uKM_CZ93A@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 12 Nov 2024 20:30:07 -0600
Message-ID: <CAPLW+4kuBoprcOXL-rYCWU5w9-Q8X78eE4=7KmnCdDT=4HiaTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] armv8: Fix get_sctlr() return type
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Feng <fenghua@phytium.com.cn>, u-boot@lists.denx.de
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

On Mon, Nov 11, 2024 at 8:48=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 7 Nov 2024 at 04:58, Sam Protsenko <semen.protsenko@linaro.org> w=
rote:
> >
> > SCTLR_EL2 is a 64-bit register [1]. Return its value as long (64 bit)
> > instead of int (32 bit) in get_sctlr() to make sure it's not trimmed.
> >
> > [1] https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-Reg=
isters/SCTLR-EL2--System-Control-Register--EL2-?lang=3Den
> >
> > Fixes: 0ae7653128c8 ("arm64: core support")
> > Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> > Changes in v2:
> >   - None (this patch was introduced in v2)
> >
> >  arch/arm/cpu/armv8/cache_v8.c | 2 +-
> >  arch/arm/include/asm/system.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v=
8.c
> > index e6be6359c5d9..5d6953ffedd1 100644
> > --- a/arch/arm/cpu/armv8/cache_v8.c
> > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > @@ -825,7 +825,7 @@ void dcache_enable(void)
> >
> >  void dcache_disable(void)
> >  {
> > -       uint32_t sctlr;
> > +       unsigned long sctlr;
>
> Although that's correct since it's a 64bit platform, isn't it better
> to define it as u64 to be sure we'll have at least 64 bits?
>

Thanks for reviewing this! I considered making it uint64_t while
reworking this bit. This 'sctlr' variable is assigned to get_sctlr()
return value, and then passed to set_sctlr() as a parameter, both of
which are 'unsigned long'. So I made 'sctlr' unsigned long too, just
to match the signatures of mentioned functions. As for get_sctlr(), I
just followed the style already existed inside and around that
function. As you said, both u64 and unsigned long are 64-bit long
types on ARMv8, and that's definitely ARMv8 specific file, so I guess
that should be fine? In any case, if you have a strong opinion about
this, please let me know and I'll rework it; both u64 and unsigned
long look ok to me in this context.

> Thanks
> /Ilias
> >
> >         sctlr =3D get_sctlr();
> >
> > diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/syste=
m.h
> > index 52f6c9b934d7..dbf9ab43e280 100644
> > --- a/arch/arm/include/asm/system.h
> > +++ b/arch/arm/include/asm/system.h
> > @@ -171,7 +171,7 @@ static inline unsigned int current_el(void)
> >         return 3 & (el >> 2);
> >  }
> >
> > -static inline unsigned int get_sctlr(void)
> > +static inline unsigned long get_sctlr(void)
> >  {
> >         unsigned int el;
> >         unsigned long val;
> > --
> > 2.39.5
> >
