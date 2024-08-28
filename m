Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E244FC7114C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E30C88A25;
	Thu, 29 Aug 2024 00:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I4G7JYrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6741888A3; Thu, 29 Aug 2024 00:17:15 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6DE687FA7
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6bf6721aae5so68126d6.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724883431; x=1725488231; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hDWWcj5/c4hfnz+49nSndtwudeloj+MjcR9eaaxC/0E=;
 b=I4G7JYrv1ycO7vNGCWWFetyBKMtxIzFV3/HPqjMHr2QDWcTj4IZEh1YvPXNtgmrtAs
 llgBHFdLS59flBtPIwK6joYs4Y9VAea2nul6/OPcQWNixD9cRR4rT8bvN1a4QnK4AVNR
 I+EfQe/6NNoea60a1lskbOP/bb3hbY2e30llo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724883431; x=1725488231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hDWWcj5/c4hfnz+49nSndtwudeloj+MjcR9eaaxC/0E=;
 b=E3TWS3BK2bbN3E7jx5dCYKT+D4PwRi2IhDlTyOGOpiQEkcc6x8r/fzSpFoql8nXHc3
 PeSxcGwGrxj8AtmBi9PZTRITdIUEzVvrRH39fzLpqIAAaT/LCI0v9QM2RiUg2ZcbA1WJ
 LSPbDYDkSrUORCw3g6DkUZL3GOFCeJeLpYMwzDhbeEVPfppG8z/P+XpKHQo8QAeTxyzt
 wLExDqGBridhzl26qpsFtOJmGJRBpPYW6N6bfZFloERcDmKo4KpaMqD1PZ7iRZfUdxRG
 mje1/hKy2cc5RDxZICtLA0Le9XvZ6e8WokxqEYcYZANuYMn9Wb/xXqW+IE/uEk/BE3Jd
 7KvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmgpRNCxoVnczpfCTPO1i5E0H2SoyPqUeisS11X4/ktbmqkIje0Tz+zWGFK2X1LKNqVOTKvMs=@lists.denx.de
X-Gm-Message-State: AOJu0YzTBhKB5zlWqNVaG2V5JIlCBsoLCeRaz52XhIYTgZT4M23lKOcA
 ZDwDT0HWlDlqGRl5K32vzlz5JeBjO3/lwAILrTWdKty+oEXGwZ3zrOwm/pfOyOZ1NAzHY7FNGXH
 otOUa5S1MjS+XlvpmxO7nQ7GY5//0izDZu6hL
X-Google-Smtp-Source: AGHT+IG73x/5prqshBvcjBN/Mmd+daDzEyEHxE5XY5MtfQleZ1zIFvi6tIHMFnvGczdSFNDsv4HtcgryEudZpKWSYqY=
X-Received: by 2002:a05:6214:598b:b0:6b5:e4da:2d51 with SMTP id
 6a1803df08f44-6c33e684418mr11185356d6.45.1724883430612; Wed, 28 Aug 2024
 15:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <980adca3-27ac-440b-93b4-80146d050584@linaro.org>
 <CAOMZO5A2ZBb9G6krUmfNy3qnoNYgwdb2-DUgeNuvONy9VioEbQ@mail.gmail.com>
 <CAFLszTgZ9vFe1rahWG_QiVJXoCBOTc=umAJ=YZwu7ExyXWsuDg@mail.gmail.com>
 <aeba3da3-b287-481c-a704-4b56884deaaf@linaro.org>
In-Reply-To: <aeba3da3-b287-481c-a704-4b56884deaaf@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Aug 2024 16:17:00 -0600
Message-ID: <CAFLszTjZVFCoPBTojmHwCoo7jKsyEYzFBLq9SxjOco7uLzJ_ZA@mail.gmail.com>
Subject: Re: imx8ulp_evk build with buildman fails every other time
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>, Gary Bisson <bisson.gary@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 28 Aug 2024 at 09:40, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 8/27/24 17:53, Simon Glass wrote:
> > Hi Jerome,
> >
> > On Tue, 27 Aug 2024 at 08:53, Fabio Estevam <festevam@gmail.com> wrote:
> >>
> >> Adding Gary and Peng on Cc.
> >>
> >> On Tue, Aug 27, 2024 at 11:42=E2=80=AFAM Jerome Forissier
> >> <jerome.forissier@linaro.org> wrote:
> >>>
> >>> Hi,
> >>>
> >>> Can someone explain what's happening with the imx8ulp_evk buildman bu=
ild
> >>> below? It either fails with a mkimage error, or succeeds with a binma=
n
> >>> warning, every other time. 100% reproducible. /me confused :o
> >>>
> >>> =3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D8<=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> $ docker run -it --rm trini/u-boot-gitlab-ci-runner:jammy-20240808-21=
Aug2024
> >>> uboot@42aa85c2d6b7:/$ cd
> >>> uboot@42aa85c2d6b7:~$ git clone https://github.com/u-boot/u-boot.git
> >>> uboot@42aa85c2d6b7:~/u-boot$ git log --oneline -n 1
> >>> ee2af844ba (HEAD -> master, origin/master, origin/HEAD) Merge tag 'ef=
i-2024-10-rc4' of https://source.denx.de/u-boot/custodians/u-boot-efi
> >>> uboot@42aa85c2d6b7:~$ cd u-boot
> >>> uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
> >>> Building current source for 1 boards (1 thread, 24 jobs per thread)
> >>>    aarch64:  w+   imx8ulp_evk
> >>> +WARNING 'mx8ulpa2-ahab-container.img' not found, resulting binary ma=
y be not-functional
> >>> +WARNING 'bl31.bin' not found, resulting binary may be not-functional
> >>> +WARNING 'upower.bin' not found, resulting binary may be not-function=
al
> >>> +WARNING 'm33_image.bin' not found, resulting binary may be not-funct=
ional
> >>>     0    1    0 /1              imx8ulp_evk
> >>> Completed: 1 total built, 1 newly), duration 0:00:09, rate 0.11
> >>> uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
> >>> Building current source for 1 boards (1 thread, 24 jobs per thread)
> >>>    aarch64:  +   imx8ulp_evk
> >>> +WARNING 'bl31.bin' not found, resulting binary may be not-functional
> >>> +binman: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n spl/u-b=
oot-spl.cfgout -T imx8image -e 0x22020000 ./mkimage-out.spl.mkimage': Fail =
open first container file mx8ulpa2-ahab-container.img
> >>> +
> >>> +make[1]: *** [Makefile:1126: .binman_stamp] Error 1
> >>> +make: *** [Makefile:177: sub-make] Error 2
> >>>     0    0    1 /1              imx8ulp_evk
> >>> Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25
> >>> uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
> >>> Building current source for 1 boards (1 thread, 24 jobs per thread)
> >>>    aarch64:  w+   imx8ulp_evk
> >>> +WARNING 'mx8ulpa2-ahab-container.img' not found, resulting binary ma=
y be not-functional
> >>> +WARNING 'upower.bin' not found, resulting binary may be not-function=
al
> >>> +WARNING 'm33_image.bin' not found, resulting binary may be not-funct=
ional
> >>> +WARNING 'bl31.bin' not found, resulting binary may be not-functional
> >>>     0    1    0 /1              imx8ulp_evk
> >>> Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25
> >>> uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
> >>> Building current source for 1 boards (1 thread, 24 jobs per thread)
> >>>    aarch64:  +   imx8ulp_evk
> >>> +WARNING 'bl31.bin' not found, resulting binary may be not-functional
> >>> +binman: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n spl/u-b=
oot-spl.cfgout -T imx8image -e 0x22020000 ./mkimage-out.spl.mkimage': Fail =
open first container file mx8ulpa2-ahab-container.img
> >>> +
> >>> +make[1]: *** [Makefile:1126: .binman_stamp] Error 1
> >>> +make: *** [Makefile:177: sub-make] Error 2
> >>>     0    0    1 /1              imx8ulp_evk
> >>> Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25
> >>> =3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D8<=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >
> > I can't quite explain it but I have hit this before. It is why I have
> > been unable to land [1]
> >
> > Perhaps binman is writing a file which is being picked up on the next
> > run, but is not valid? Or perhaps the file from a previous build
> > confuses things? I notice that some of the sections have filenames,
> > meaning that they are written and persist between builds.
> >
> > You can try BINMAN_VERBOSE=3D4 or 5 to see what is happening, or
> > BINMAN_DEBUG=3D1 to get a stack trace.
>
> That one wasn't super easy to track down :-/ but I think I have a proper
> fix. See https://lists.denx.de/pipermail/u-boot/2024-August/563355.html.

Nice work!!

- Simon

> >
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20240623175515.146=
6908-14-sjg@chromium.org/
