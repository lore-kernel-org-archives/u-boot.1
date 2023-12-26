Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A75C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 14:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7A2D878C1;
	Tue, 26 Dec 2023 15:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yEOcDd43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F096878CB; Tue, 26 Dec 2023 15:39:24 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 257D587849
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 15:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50e759ece35so1676324e87.3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 06:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703601560; x=1704206360; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LeQDrQad80nn4o3KEJXbxopxoGwBFw2ElCz8yfz+CoY=;
 b=yEOcDd43hX+GXHlrmincULyHDen5Ip2B3DU2oXSoOo75kJ2ixgPjp5/9TvOt6bBEWa
 RehsPmAnExvgE2HdCsNqRcH/Axdz6VG6SaJfiWwPE8M6B6VPs4bpuKYo7cHtsCGS6oWU
 0ifgBwf/AAQB+8gxejyj4sc8NaVBtTOyoaHga0C/mfRhFmsCQXkn0lTHlgbIcVcD1tov
 +jp3hg+lZ1/w6nJpwkzZ9jIMrXBJ14Y3lC2PKcux3ZvlY8VxAi6sBqRxhi/4Rooo7jjJ
 +dKsPBbE5Z9Od1vlZ9Ri/Tbc6puWaBFRLayW0BTRH4H5QcEzn0LOQ3ITCWE7ZG1cvAp+
 D2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703601560; x=1704206360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LeQDrQad80nn4o3KEJXbxopxoGwBFw2ElCz8yfz+CoY=;
 b=heylMPIKYRJsC9og0X8S8an90YyfFU3+CI6YUwbFdrty9i5nTcrD6YtnBYcMUBOvoV
 P98YNeCjYVf8HhYIgfeoPPY96xcpsV9TmMGI/L0xRO7f06Bm+wYOpli7aw76448quFiV
 EslNQOJBqYPqPj9rf8C4z6XslHInTXynhBkSJEXsKN5u9uLO7GAeJCmjhrUwG1uVJ3Qc
 JpKF5r6yj9jwn8xIISp1WGqMXEWLrV6gIEz++zJn5ubnIc311TXjthjiOdPtDwWL11t7
 c590x7jvg6FuuqCihyXbMhMGDhotiQXxSzx+U9IoEN+bsLbqx+nmhWDf/x/xvTbwU9b7
 inuw==
X-Gm-Message-State: AOJu0YyL3SQ5BGogQ1mdxtANWAaMAlmBiBPaUBWNvytUbGIXaVVl91wx
 AVs7AvUADbuk8neJ8Jv6qZ/deFPDubHiJkq0HdZnqU6+slSUcg==
X-Google-Smtp-Source: AGHT+IHiTsSe176ugexKgKj5h8P1XSpgZvT9b0+wvRxIdhvPb6oso7zqDYQt9WKTjR7UFXIJ7IwIcbDysUCt8g0Qkvs=
X-Received: by 2002:a19:6549:0:b0:50e:558e:1259 with SMTP id
 c9-20020a196549000000b0050e558e1259mr2358799lfj.19.1703601559069; Tue, 26 Dec
 2023 06:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
 <20231225153929.8284-10-maxim.uvarov@linaro.org>
 <CAFLszTjg2MTAfJZ17dQFe+Of0VTJVADemigh_gki8GSR07FEvQ@mail.gmail.com>
 <CAD8XO3bF3Xr=YTfB7Yjb7RydRkGdGXaV-k0Ep9OsxR=2SJnyvw@mail.gmail.com>
 <20231226142635.GI2652760@bill-the-cat>
In-Reply-To: <20231226142635.GI2652760@bill-the-cat>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Tue, 26 Dec 2023 20:39:06 +0600
Message-ID: <CAD8XO3aqVucahW1Dm3TisOAkntGU7pZ4ZMbQ1zkekGeZdMexrw@mail.gmail.com>
Subject: Re: [PATHv2 9/9] Makefile: add dtbs to clean
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com
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

On Tue, 26 Dec 2023 at 20:26, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Dec 26, 2023 at 06:27:58PM +0600, Maxim Uvarov wrote:
> > On Tue, 26 Dec 2023 at 15:50, Simon Glass <sjg@chromium.org> wrote:
> >
> > > Hi Maxim,
> > >
> > > On Mon, Dec 25, 2023 at 3:42=E2=80=AFPM Maxim Uvarov <maxim.uvarov@li=
naro.org>
> > > wrote:
> > > >
> > > > CI test checks that generated dtb has to be cleaned up.
> > > >
> > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > > ---
> > > >  Makefile | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Makefile b/Makefile
> > > > index 220411a293..ab603191ad 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -2165,7 +2165,8 @@ CLEAN_FILES +=3D include/autoconf.mk*
> > > include/bmp_logo.h include/bmp_logo_data.h \
> > > >                mkimage-out.spl.mkimage mkimage.spl.mkimage
> imx-boot.map \
> > > >                itb.fit.fit itb.fit.itb itb.map spl.map
> > > mkimage-out.rom.mkimage \
> > > >                mkimage.rom.mkimage mkimage-in-simple-bin* rom.map
> > > simple-bin* \
> > > > -              idbloader-spi.img lib/efi_loader/helloworld_efi.S
> *.itb
> > > > +              idbloader-spi.img lib/efi_loader/helloworld_efi.S
> *.itb \
> > > > +              ./*/*.dtb *.dtb
> > > >
> > > >  # Directories & files removed with 'make mrproper'
> > > >  MRPROPER_DIRS  +=3D include/config include/generated spl tpl vpl \
> > > > --
> > > > 2.30.2
> > > >
> > >
> > > Shouldn't this be handled with CLEAN_FILES in arch/xxx/dts ?
> > >
> > > Regards,
> > > Simon
> > >
> >
> > I don't know. It looks like CLEAN_FILES is almost not used inside ./arc=
h
> > directory. Only 1 place where it appears:
> >
> > fgrep -r CLEAN_FILES ./arch/
> > ./arch/arm/mach-rmobile/Makefile:CLEAN_FILES +=3D u-boot-spl.scif
>
> I see that our top-level clean target is missing dtb related targets
> like the linux kernel has, and that's how this should be fixed.
>
> --
> Tom
>

If I understand right you just refers to kernel's top level Makefile
clean:
find
                -o -name '*.dtb' -o -name '*.dtbo' \

                -o -name '*.dtb.S' -o -name '*.dtbo.S' \
| xargs rm -rf

 I will fix it in that way in v3.

BR,
Maxim.
