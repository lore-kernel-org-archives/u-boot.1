Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B2CC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 12:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6415E8788E;
	Tue, 26 Dec 2023 13:28:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w5Zur0sM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B601587895; Tue, 26 Dec 2023 13:28:19 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55BCC8788D
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 13:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a2340c803c6so494518366b.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 04:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703593690; x=1704198490; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X5by3ipExLY+mctIrnEPt1xGOEd7n2NgFcI5HdKwCXU=;
 b=w5Zur0sM9w/l1p7PpnfX9nYN69u82kZRqBKEh0oSP6LpU4Jp4EaWdsSu+TCQKeRHz8
 upxXO0NLgn+BQyDQu5cjymbZpoQaDcn75LBr24FQqRVg7Ih6i/2fba/aOCP7mTXJQ6ai
 EDj4P1Z30YqN3eykN44GlhElMhgFTyShwfozpmTDHNj0ok+wHfFvjoQ6cClbsvHIDC7s
 yPe1WGKoDo84TLW2hG68/tfkr3OWCBZVqxqDKAYP1s1kumi9ZEwcNNXbPWdVbvklSuhl
 XAwn7fRG0tmqR1tt181cErPowb7V8WGFmE4kPr9u5rB5j0eU1BV1EmZdUj0yWAJ7Nm8S
 ZTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703593690; x=1704198490;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X5by3ipExLY+mctIrnEPt1xGOEd7n2NgFcI5HdKwCXU=;
 b=WIoA11+IOCwSoBrA9TdXx3qK+sWY8gUQltndJne2jF6aMTBI7YD1NJT8Up52zbLuc7
 TEtxGKJDfkgsz/5RpO5B9n6w39ZDutuzDxHOVO6XjlyiY214GjBsRIA8sCfAgLpNld8v
 k5aB7wioJWYJafvb3OXFy5KtAzjGmz1m2un8DG/y9G2FsbZkd+SHpKc6dsWwwkmfnR35
 qUSBIviTod19vYnRYYb9vxiZNeUV6iWpiO4KZBrHx6se66A65wxbCaYgu7QkMD224emz
 AhbtKPGCSfzpWyxzRyPvYnFYkenQftVzCrKts/dAEwLFyRi7fhqJFp84Yx4u2qBI+naq
 AOxg==
X-Gm-Message-State: AOJu0YzS3FFAgyAp7Jl4fjjd9CiEb9JNsybq/hPzDSfNNkfgNXASA6ap
 x8NCi1H7cPwDZtJq/+l1n+AQoByP6d+GZK0b8beo7zqOttPniA==
X-Google-Smtp-Source: AGHT+IEeeMmCRli5j56jp966Wbq+def9BNEU/k+SUGyZEwQp3V+piQHS4ONxihUtdHho5jMNrvfrLaBT5u/crxW+iY0=
X-Received: by 2002:a17:906:f910:b0:a26:965a:e866 with SMTP id
 lc16-20020a170906f91000b00a26965ae866mr3269892ejb.111.1703593690656; Tue, 26
 Dec 2023 04:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
 <20231225153929.8284-10-maxim.uvarov@linaro.org>
 <CAFLszTjg2MTAfJZ17dQFe+Of0VTJVADemigh_gki8GSR07FEvQ@mail.gmail.com>
In-Reply-To: <CAFLszTjg2MTAfJZ17dQFe+Of0VTJVADemigh_gki8GSR07FEvQ@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Tue, 26 Dec 2023 18:27:58 +0600
Message-ID: <CAD8XO3bF3Xr=YTfB7Yjb7RydRkGdGXaV-k0Ep9OsxR=2SJnyvw@mail.gmail.com>
Subject: Re: [PATHv2 9/9] Makefile: add dtbs to clean
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com, 
 trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 26 Dec 2023 at 15:50, Simon Glass <sjg@chromium.org> wrote:

> Hi Maxim,
>
> On Mon, Dec 25, 2023 at 3:42=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro=
.org>
> wrote:
> >
> > CI test checks that generated dtb has to be cleaned up.
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > ---
> >  Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 220411a293..ab603191ad 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2165,7 +2165,8 @@ CLEAN_FILES +=3D include/autoconf.mk*
> include/bmp_logo.h include/bmp_logo_data.h \
> >                mkimage-out.spl.mkimage mkimage.spl.mkimage imx-boot.map=
 \
> >                itb.fit.fit itb.fit.itb itb.map spl.map
> mkimage-out.rom.mkimage \
> >                mkimage.rom.mkimage mkimage-in-simple-bin* rom.map
> simple-bin* \
> > -              idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb
> > +              idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb =
\
> > +              ./*/*.dtb *.dtb
> >
> >  # Directories & files removed with 'make mrproper'
> >  MRPROPER_DIRS  +=3D include/config include/generated spl tpl vpl \
> > --
> > 2.30.2
> >
>
> Shouldn't this be handled with CLEAN_FILES in arch/xxx/dts ?
>
> Regards,
> Simon
>

I don't know. It looks like CLEAN_FILES is almost not used inside ./arch
directory. Only 1 place where it appears:

fgrep -r CLEAN_FILES ./arch/
./arch/arm/mach-rmobile/Makefile:CLEAN_FILES +=3D u-boot-spl.scif

BR,
Maxim.
