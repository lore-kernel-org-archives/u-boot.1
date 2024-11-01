Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D548E6F06C
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05810892FD;
	Fri,  1 Nov 2024 16:33:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EYdDOlZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BC39892CF; Fri,  1 Nov 2024 16:33:20 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72866889A2
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9a1b71d7ffso319541166b.1
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730475198; x=1731079998; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L72yr7e6VaHHBQZ0cT9yRlTyceRJmdu4je5c6L1XlBo=;
 b=EYdDOlZBzq3tI7Faf/T2QSxT/i3tuBFI2oOAeD/draItM8M3sAyg/NMsSTruIz4NrU
 8uQnM4cG9yaRyd5DM6/uArF5qXV4ly9Utf7vo1lT5DIT/09XUKBYD7Wb7lS7eGHGrOB/
 H7ScnW/QI4GTVRluQmOxz2MYQf1PPRKPT5Nxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730475198; x=1731079998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L72yr7e6VaHHBQZ0cT9yRlTyceRJmdu4je5c6L1XlBo=;
 b=LU3p2bzmJ28g3IaAZ3C6ayD3/yvInOzU3i8To/A9aIzutTj1rV26yukDXcJLZ1aXj2
 xmoHCV9KaNXmfBIm4VgHFBUFQp+7LDnPHJTZp4S3oPtYkLSCWgmuNtE2djTJxbvashaR
 +SbPl4LtIsO7WS9EuDXlP3TB4OEtMmWQJRQdbUNZWa0di8WHjTIL7LszQCc4qBrQTfnE
 SLNFabn3UEVp7IRIlK9T7ZTqUaE6OctX7BxJH9ilWQS2l+gRLAg7jUGWpvCWoi2AwasQ
 HXpHokk3DelqsMDcxQoiQl736hBlpDI251a9zpYMeHfbNAk7q4B+2xD/L1XplMn1gtPH
 BLtA==
X-Gm-Message-State: AOJu0Ywo/H5TPgzJ/IzQ7k/Wdh85xna1JvL0mUWElfNzF2aJD1/84fWy
 JQnxHj2wGNMDWD0T276YJ1EpoGR5JjirAUqalJVA4wBzj/GG1cLoHABdSZfsKv8zB2syPG8CRKQ
 HRPkSCSYzRPTgMVYZUNGpzZypB9OeE/X+YKXjH8Nb6J66uMmQQHnG
X-Google-Smtp-Source: AGHT+IEyt7FCrauNTbIB05o173v9npoWVAc1PrheJWHjxlIpDQpYTcKakzKGFiEFJaRFH/PVyKJA9Yh0WLXAk1Zp2rU=
X-Received: by 2002:a17:907:9728:b0:a9a:4597:a7f3 with SMTP id
 a640c23a62f3a-a9e3a7f435bmr1093142366b.62.1730475197861; Fri, 01 Nov 2024
 08:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241030003649.3506474-1-trini@konsulko.com>
 <CAFLszTgPA0vGCWLw3m_KHVCs7=hCouOGhSeZAx3XxWBHtP7oFg@mail.gmail.com>
 <20241031181100.GW2558755@bill-the-cat>
In-Reply-To: <20241031181100.GW2558755@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Nov 2024 16:33:01 +0100
Message-ID: <CAFLszTh3G2fQEJzD7EMO3idANt_HVYw5-ztnxfRL2DnOa7GjdA@mail.gmail.com>
Subject: Re: [PATCH] test/cmd/mem_copy.c: Use CONFIG_SYS_LOAD_ADDR for base
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Thu, 31 Oct 2024 at 19:11, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 31, 2024 at 06:51:52PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 30 Oct 2024 at 01:36, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > When reading/writing to memory we cannot assume that a base address of
> > > 0x0 is correct and functional. So use CONFIG_SYS_LOAD_ADDR as the base
> > > from which we add a bit more padding and being our tests.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > >  test/cmd/mem_copy.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/test/cmd/mem_copy.c b/test/cmd/mem_copy.c
> > > index 1ba0cebbbe04..67eca328777a 100644
> > > --- a/test/cmd/mem_copy.c
> > > +++ b/test/cmd/mem_copy.c
> > > @@ -21,7 +21,7 @@ struct param {
> > >  static int do_test(struct unit_test_state *uts,
> > >                    const char *suffix, int d, int s, int count)
> > >  {
> > > -       const long addr = 0x1000;
> > > +       const long addr = CONFIG_SYS_LOAD_ADDR + 0x1000;
> >
> > CFG_SYS_SDRAM_BASE would be better here, since it is the start of
> > memory (0 on sandbox and most boards).
>
> Why do we want start of memory? CONFIG_SYS_LOAD_ADDR is the address for
> where it's safe to load things to memory and fiddle with them.

Well the load address is for loading images. It doesn't have anything
to do with this test, so far as I can see. Not a big deal though.

I'm pleased you are finding all the issues I had with my lab...once I
get it running I won't have to send so many patches :-)

Regards,
Imon
