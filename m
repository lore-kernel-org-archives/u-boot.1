Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEBCCE7B1B
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 14:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A8988D02;
	Fri,  6 Sep 2024 16:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="birfrYXR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C094A88CD1; Fri,  6 Sep 2024 16:00:45 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F8E8899C
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 16:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso1494054a12.2
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 07:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725631242; x=1726236042; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6FivzdsDh8O0I40npjXnE/zEKtgrZ0tSIoAuQDqnIxI=;
 b=birfrYXRwrLF7yYdP5Tep9Fk+LaRW4qHCci4wJxdZpDp39pYou7AMufmP39PvNTWZa
 8BKjCsL9r1n8bvIHd5NlCltt6aW6gHw1xuCh+yL7Fq8jyjykxO8tHA2/esqvWbhJZNDJ
 +t1hZzsgybvHjzc0APAGkinq6rjgRjB/DSdOk5XOgSBHz1zK0QUib2lThXAOfk21XlFc
 Gjmll8klyGBi40qEn88orAApqxwjDlWnhl4GbwJueinq8DxQDNk8VVOoKi+n8IPPBaZl
 JjkcwR8zvK3q74lk0SI7buQpyLkMDE48tgzQhw+6nSYv/5lmABumPexSDxPjywAtOl+6
 /3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725631242; x=1726236042;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6FivzdsDh8O0I40npjXnE/zEKtgrZ0tSIoAuQDqnIxI=;
 b=wAYgvDH/I2JZKG1NAnYcbazpvubTtt0NYkTtbMdgS/egXPjTxxBMDJFK2uv39Dg1+J
 oP5Fte45tyiwUWWAeSA9gU6bLYcDY2wCINR8h0c2mLHBwz6z5VV0N/k3OywRJaVVHD0W
 YNxp7GuP9WU0881bLdXdXHbTFYs4yBQSiNjERy5Cs61nZbnaCF8TTzJPzeS17ZbMYaRL
 itHxzmkhys/FMkJLuCgzHZDOXQ1OM52U2ImGlT4PixNgJNuM7smH5amDK7sPwzpLjAPb
 N/83Vifn97GEx0WEH6Hfkh9ZPM9Iq3Gx1ed/tW2zy6pYCj9ujWpFcIm3E24kMEBwofrN
 eqPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZBpVH8eXnmZ2zc3/PDBlOiaG/MRUngKjtu7tQNiIhZwqs1TsjzTU6Gvf1ojHWsqtLIyxNAUs=@lists.denx.de
X-Gm-Message-State: AOJu0YyCiK6KuaFrPhdpMGrEbLrIuzU3zMto8ycrCBaiOqzONaKNwul+
 m5zPj1QpIOZStznWrH6Zsx/yhE65nu4S1unW9Igg/N6MJ3GN4FVJkO2V8efuWXcxg4vZ0L/WSSw
 Pnn+/uDy0mXFwO7qAgo0go5iv5xDm8R2wkSBVVA==
X-Google-Smtp-Source: AGHT+IEEh2PirmXSvBl4MI14jGoUxDAsksbCd0Gy96tMBd0eDkCmYj0UtMrug+IHuL1EQeTTQuxQMxcg4YhMPtysVe0=
X-Received: by 2002:a17:90b:1d92:b0:2da:905a:d88a with SMTP id
 98e67ed59e1d1-2dad5011d4fmr2972803a91.21.1725631241423; Fri, 06 Sep 2024
 07:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-8-raymond.mao@linaro.org>
 <CAFLszTiWFD2dpb6z_5cibDe0aOpuPYug-mrC-ZiZ7v+SEDFhdQ@mail.gmail.com>
 <CAC_iWjJpfrK+-o_0x8ZJbWxhG4O-tprf1-oQvWmLZWOf=5qZMA@mail.gmail.com>
 <CAEfUkUKD4CC4YkU58zehmVdkUA9UwTGk3=Prpw=JHMNMYwHcHA@mail.gmail.com>
 <CAC_iWjJbTVoV6vjGfRkYn5jOnfsmcVSseeCvN=stA4fmbZV25Q@mail.gmail.com>
In-Reply-To: <CAC_iWjJbTVoV6vjGfRkYn5jOnfsmcVSseeCvN=stA4fmbZV25Q@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 6 Sep 2024 10:00:27 -0400
Message-ID: <CAEfUkU+8VQJhmjzsfAc2yFJwg0ZSM+M32sXRqVJzR81TGFxLZA@mail.gmail.com>
Subject: Re: [PATCH v6 07/28] hash: integrate hash on mbedtls
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

On Fri, 6 Sept 2024 at 03:36, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> On Tue, 3 Sept 2024 at 18:54, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Ilias,
> >
> > On Fri, 30 Aug 2024 at 05:37, Ilias Apalodimas <
> ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Simon,
> >>
> >> On Thu, 29 Aug 2024 at 18:01, Simon Glass <sjg@chromium.org> wrote:
> >> >
> >> > Hi Raymond,
> >> >
> >> > On Fri, 16 Aug 2024 at 15:47, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> >> > >
> >> > > Integrate common/hash.c on the hash shim layer so that hash APIs
> >> > > from mbedtls can be leveraged by boot/image and efi_loader.
> >> > >
> >> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> > > ---
> >> > > Changes in v2
> >> > > - Use the original head files instead of creating new ones.
> >> > > Changes in v3
> >> > > - Add handle checkers for malloc.
> >> > > Changes in v4
> >> > > - None.
> >> > > Changes in v5
> >> > > - Add __maybe_unused to solve linker errors in some platforms.
> >> > > - replace malloc with calloc.
> >> > > Changes in v6
> >> > > - None.
> >> > >
> >> > >  common/hash.c | 146
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> >> > >  1 file changed, 146 insertions(+)
> >> >
> >> > I am not seeing the benefit of replacing U-Boot's hashing algorithms.
> >> > They work well and don't change. Also it seems to be making the code a
> >> > lot uglier, with an uncertain timeline for clean-up.
> >>
> >> A lot uglier where? It adds a few wrappers that fit into the current
> >> design and callbacks.
> >> I don't think what you are asking is possible. To do assymetric
> >> crypto, signatures  etc -- and in the future add TLS support in wget
> >> mbedTLS relies on its internal hashing functions for the cipher suites
> >> it supports. So what you are asking would just make the code even
> >> larger. Raymond can you please double check?
> >>
> > Digest is the basic library of MbedTLS, I don't believe we can disable it
> > but only use the ones for certificates, unless MbedTLS makes changes
> > to allow hooking external digest libraries -  as I mentioned in a
> previous reply,
> > I don't think this is what MbedTLS wants.
>
> There's a config option on config.h we could use to override shaXXX,
> but given that mbedTLS can be used to add more hashing alogorithms, I
> dont think we should do that
>
> If you mean the _ALT macros, they are used for porting HW acceleration.
Maybe we can point this to the original U-Boot ones, but I didn't try.

Raymond
