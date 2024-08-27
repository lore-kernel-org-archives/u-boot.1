Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA718C54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 15:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E58C388363;
	Tue, 27 Aug 2024 17:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RusKNl22";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E9E788896; Tue, 27 Aug 2024 17:54:00 +0200 (CEST)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 899778657F
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 17:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4fce9f16f83so1750765e0c.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 08:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724774036; x=1725378836; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJ6cKoLZzIoyWlmQ5C+SlcOMXBnQv47e45falXWLncQ=;
 b=RusKNl22K30NuPYsKbz35W9bd00MZWEpebxxeePKv+9sZMaruHNExnMR9aFX7+phfR
 CIj9DjX3qjDtMcXtNIQbivOqjuitAYl+OQGFRHgJmlx3/p9S/wuQ4wv+CF72Pz6eFAgY
 yJmzam16vvXVQCRhYWrnxSnaPUiRrg8t77H90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724774036; x=1725378836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJ6cKoLZzIoyWlmQ5C+SlcOMXBnQv47e45falXWLncQ=;
 b=sqUMrBqHt/2zeOsV08pfON+4plTKWjY7P7ojjp6bTUVz8237JLS3T3CNbEm5VRH4oM
 rtQlPlB6tegWv/ZWsjliYpZjmEtyrvvLm2gISc1h/luRlD7Nm4Hu4L/vXmAvfrU48pjJ
 HveU45o7tg+C53o0bnl1+z+Zr5pOEbJe/DJ46X5bgLGi/rVQ/0XrUOdp51yfdRtGOb7h
 ZbfI7tk3WpT08T3kQdkd0V908NkdKvuloLx1odrQZSe1JSAwBQYskSF2QLSfE/P7V7rM
 7R1V9by/Jx6k8a+hnkFzMzw9aD5gzlJCOOwCqS5lSru3rTWJ2g/NNR0sjgGjI/jmvelX
 9VKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvef+ymRMwr+TUXFOnwceou1dN0lwPv+LKOwORsNcxZPfPEe7hVoVvjkaAw6KjgapdHDvOt/4=@lists.denx.de
X-Gm-Message-State: AOJu0YzRS+ZOscjC+TK53xOhlL4wlWd3SbTWo2uMxzjvQaSNp4R6FwXk
 Dz98doB0s3Kh04sYU35UIX4A76NZxfIeNO/DipIVXBeaRkGPJRNLhf7DHqaRigQwtsSwh7bjs1A
 C3rC2bDKRAZqmxPNSuR8Kt1chNKp2gpzQ8s6N
X-Google-Smtp-Source: AGHT+IGNfWOWFs/69BtXbFOwfHEJFWfF54Xc9TdShTQymaTEx2k7hPNqKEIvge+KqY5uEphYfHUEw8l1vF86ay7kt5Q=
X-Received: by 2002:a05:6122:2191:b0:4ef:5e6b:98c0 with SMTP id
 71dfb90a1353d-4fd1a7dddf7mr16063220e0c.9.1724774036338; Tue, 27 Aug 2024
 08:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <980adca3-27ac-440b-93b4-80146d050584@linaro.org>
 <CAOMZO5A2ZBb9G6krUmfNy3qnoNYgwdb2-DUgeNuvONy9VioEbQ@mail.gmail.com>
In-Reply-To: <CAOMZO5A2ZBb9G6krUmfNy3qnoNYgwdb2-DUgeNuvONy9VioEbQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Aug 2024 09:53:45 -0600
Message-ID: <CAFLszTgZ9vFe1rahWG_QiVJXoCBOTc=umAJ=YZwu7ExyXWsuDg@mail.gmail.com>
Subject: Re: imx8ulp_evk build with buildman fails every other time
To: Fabio Estevam <festevam@gmail.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Gary Bisson <bisson.gary@gmail.com>, 
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

Hi Jerome,

On Tue, 27 Aug 2024 at 08:53, Fabio Estevam <festevam@gmail.com> wrote:
>
> Adding Gary and Peng on Cc.
>
> On Tue, Aug 27, 2024 at 11:42=E2=80=AFAM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > Hi,
> >
> > Can someone explain what's happening with the imx8ulp_evk buildman buil=
d
> > below? It either fails with a mkimage error, or succeeds with a binman
> > warning, every other time. 100% reproducible. /me confused :o
> >
> > =3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > $ docker run -it --rm trini/u-boot-gitlab-ci-runner:jammy-20240808-21Au=
g2024
> > uboot@42aa85c2d6b7:/$ cd
> > uboot@42aa85c2d6b7:~$ git clone https://github.com/u-boot/u-boot.git
> > uboot@42aa85c2d6b7:~/u-boot$ git log --oneline -n 1
> > ee2af844ba (HEAD -> master, origin/master, origin/HEAD) Merge tag 'efi-=
2024-10-rc4' of https://source.denx.de/u-boot/custodians/u-boot-efi
> > uboot@42aa85c2d6b7:~$ cd u-boot
> > uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
> > Building current source for 1 boards (1 thread, 24 jobs per thread)
> >    aarch64:  w+   imx8ulp_evk
> > +WARNING 'mx8ulpa2-ahab-container.img' not found, resulting binary may =
be not-functional
> > +WARNING 'bl31.bin' not found, resulting binary may be not-functional
> > +WARNING 'upower.bin' not found, resulting binary may be not-functional
> > +WARNING 'm33_image.bin' not found, resulting binary may be not-functio=
nal
> >     0    1    0 /1              imx8ulp_evk
> > Completed: 1 total built, 1 newly), duration 0:00:09, rate 0.11
> > uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
> > Building current source for 1 boards (1 thread, 24 jobs per thread)
> >    aarch64:  +   imx8ulp_evk
> > +WARNING 'bl31.bin' not found, resulting binary may be not-functional
> > +binman: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n spl/u-boo=
t-spl.cfgout -T imx8image -e 0x22020000 ./mkimage-out.spl.mkimage': Fail op=
en first container file mx8ulpa2-ahab-container.img
> > +
> > +make[1]: *** [Makefile:1126: .binman_stamp] Error 1
> > +make: *** [Makefile:177: sub-make] Error 2
> >     0    0    1 /1              imx8ulp_evk
> > Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25
> > uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
> > Building current source for 1 boards (1 thread, 24 jobs per thread)
> >    aarch64:  w+   imx8ulp_evk
> > +WARNING 'mx8ulpa2-ahab-container.img' not found, resulting binary may =
be not-functional
> > +WARNING 'upower.bin' not found, resulting binary may be not-functional
> > +WARNING 'm33_image.bin' not found, resulting binary may be not-functio=
nal
> > +WARNING 'bl31.bin' not found, resulting binary may be not-functional
> >     0    1    0 /1              imx8ulp_evk
> > Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25
> > uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
> > Building current source for 1 boards (1 thread, 24 jobs per thread)
> >    aarch64:  +   imx8ulp_evk
> > +WARNING 'bl31.bin' not found, resulting binary may be not-functional
> > +binman: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n spl/u-boo=
t-spl.cfgout -T imx8image -e 0x22020000 ./mkimage-out.spl.mkimage': Fail op=
en first container file mx8ulpa2-ahab-container.img
> > +
> > +make[1]: *** [Makefile:1126: .binman_stamp] Error 1
> > +make: *** [Makefile:177: sub-make] Error 2
> >     0    0    1 /1              imx8ulp_evk
> > Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25
> > =3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >

I can't quite explain it but I have hit this before. It is why I have
been unable to land [1]

Perhaps binman is writing a file which is being picked up on the next
run, but is not valid? Or perhaps the file from a previous build
confuses things? I notice that some of the sections have filenames,
meaning that they are written and persist between builds.

You can try BINMAN_VERBOSE=3D4 or 5 to see what is happening, or
BINMAN_DEBUG=3D1 to get a stack trace.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240623175515.1466908=
-14-sjg@chromium.org/
