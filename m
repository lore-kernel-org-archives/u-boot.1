Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3C0CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 12:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E61783A5D;
	Wed,  5 Nov 2025 13:57:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EOWcc90u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69B4B83A2D; Wed,  5 Nov 2025 13:22:21 +0100 (CET)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E612B839F1
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 13:22:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-5598b58d816so288568e0c.3
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 04:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762345338; x=1762950138; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2d8tNnXOWVIdSohaPOqmVZGm2wsol6mh3re6z4a+lMk=;
 b=EOWcc90ubzq3MOKNrFi0T0elA2gB5ZHAnc+9STcP8NUcKH2N/mQIbg84n+7nFOrjfl
 uux0XXkibBU2McHjTkmU9V8MMfmd+fkIUoZ94DuCKjhW1WfLKNSWRZsF5kCMUFpOQbW9
 Jhh80RWS3NC6OAtEDF8GdrXVCGKeVV4z9d5YN+sLHa/iLTTZHadgaXr5lpgjCPNUpJto
 oH20B070aj9ZNG8AD9hEDGKIQNaRKDK6iUHnDGD+mdNfEHSW7D0jMT9fuPA19qD3simg
 Z00QXUrsurAHnrx/ZdqeAvK2bd1O7mx5zWfHXslfKE+PM/4F5LbHceaZw73F2qM2uu7U
 9icQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762345338; x=1762950138;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2d8tNnXOWVIdSohaPOqmVZGm2wsol6mh3re6z4a+lMk=;
 b=nciuYWjenOe5pA4s4/qUM+AWvCFQR56+nUSCaAQ7xhqIa590r2ia7wt9LBsLSz8WC5
 D0GPJR2OV68udNh31wP5bFQJZsq9f2e2mG7yutWWhOGwOKJdI1Y/bX7K7QXVuc5S+V7r
 SQPfjukFOaK74FHS8u0zN7O9zGsT62ifQxF2ImM2LGGm/2yruvhXGSJuh7zCUwRDbI0N
 QcWWmyC48sxxPquZVRjTrKncbldj6cPaUvQuCWbeDXWVI87bQPQBsUcKoooEr0ObwsUH
 URk8bd58GPrql4VwICAPMnKHUku5aS9xi98SuDQkLwT14BhKDv89e8Ylov2bSHkU7+sO
 vRxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbs6x4BfZJDSefY5+1VIQwPwfNWobI7BrDf9hvQ+QG274XPpMxoXFltZCdITnX6gcsTcaqiPI=@lists.denx.de
X-Gm-Message-State: AOJu0YxOV5qoOEGEM76GF6QY518R7cX6i42sBalHIiyWrtTr1topO1mm
 3Unlm+dH7Uz1+gOXiqhAOcn0rB00Kkqqow6mbf3R0dcVEYWnzeTKigXsQnYrv5psnnsPk8x1aEd
 y25L5EEe5hAhXwcxzYKLi49f0wk24cuA=
X-Gm-Gg: ASbGnctBbPp6IYy2k2XgAvRwi8BKIwewPcDX5AjUPI+qfo39AZGnOrPRXs5OKMiJeY6
 ONZS1e+FooN7FRqWNSrqFIK1bOyfcj5A9LudlKfP4SisLPGi5XdSFaVcHPICKLKIRZQUnNngbp3
 EqRLSV1GjQlsrcXMgQZt4DmtusrXLuweLuUEPhzX+9kJJ0/kfWJr/DWU2MJMNUz4so78UqwKvqO
 FkCq1ivQPJ5EkCXl5ftAi60fmhrtpJob7xaLctmhuuGR53kKe6Eow3l6hZE
X-Google-Smtp-Source: AGHT+IEI5EHEBOJgGkDfq14d94acb9KcJTxXREZ/CBJwuF+tKaUcTEcyA6/bzy8t9cBNGlUNeXXqh5Q7J1um82ZY4P4=
X-Received: by 2002:a05:6102:38d1:b0:5db:d60a:6b2f with SMTP id
 ada2fe7eead31-5dd88c1d3f0mr1059607137.0.1762345337621; Wed, 05 Nov 2025
 04:22:17 -0800 (PST)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
 <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
In-Reply-To: <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Wed, 5 Nov 2025 13:21:41 +0100
X-Gm-Features: AWmQ_bnCwEZyO0sIzIuClATF2i1RWWfactGOZXSm1oyYzo6v9Ja3qwH4akfTeK0
Message-ID: <CAJwFiGLHDEPMsFyBhX=ogQxX_C+8ac-_9_jeiZYyo=3o0M8ZHA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
To: E Shattow <e@freeshell.de>
Cc: Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, trini@konsulko.com,
 sjg@chromium.org, 
 alpernebiyasak@gmail.com, al.kochet@gmail.com, paul.henrys_ext@softathome.com, 
 bb@ti.com, y.moog@phytec.de, w.egorov@phytec.de, 
 francesco.dolcini@toradex.com, ggiordano@phytec.com, n-francis@ti.com, 
 afd@ti.com, d.schultz@phytec.de, d-gole@ti.com, ravi@prevas.dk, 
 carlos.lopezr4096@gmail.com, quentin.schulz@cherry.de, alice.guo@nxp.com, 
 Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 05 Nov 2025 13:57:55 +0100
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

Hi E Shattow,

E Shattow <e@freeshell.de> =E6=96=BC 2025=E5=B9=B49=E6=9C=8824=E6=97=A5 =E9=
=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:31=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Aristo,
>
> On 9/24/25 04:43, Nishanth Menon wrote:
> > On 06:37-20250924, Nishanth Menon wrote:
> >> On 10:59-20250914, Aristo Chen wrote:
> >>> This patch series enhances FIT image robustness by adding **memory
> >>> region overlap detection** to `mkimage` and fixing existing overlaps
> >>> in DTS files and `binman` tests.
> >
> > [...]
> >>>
> >>
> >> Looks like i see a build regression in linux-next after this series.
> >
> > I fat fingered that one.. sorry, I meant u-boot next.
> >
> >
> > Fails at commit 4d84fa1261eb, last pass was on commit d81c1118580f
> >
> >>
> >> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f76
> >
> > I  believe there are outstanding comments on V1 that have'nt been
> > addressed either. Can we revert/drop this series for now while the
> > comments are addressed?
> >
>
> Similar to Nishanth, I am seeing a build regression, itb.map:
>
> ImagePos    Offset      Size  Name
> <none>      00000000  <none>    itb
> <none>      00000000  <none>    fit
> <none>      00000000  000c1698  uboot
> <none>      00000000  000c1698  u-boot-nodtb
> <none>      000c1698  00202128  opensbi
> <none>      00000000  00202128  opensbi
>
> Yields this error:
> ...
>  MKIMAGE fit-dtb.blob
> Warning: not able to get `load` of node 'fdt-1'
> Warning: not able to get `load` of node 'fdt-2'
> Warning: not able to get `load` of node 'fdt-3'
> Warning: not able to get `load` of node 'fdt-4'
> Warning: not able to get `load` of node 'fdt-5'
> Warning: not able to get `load` of node 'fdt-6'
> Warning: not able to get `load` of node 'fdt-7'
>   CAT     u-boot-fit-dtb.bin
> ...
>   MKIMAGE u-boot.img
> Warning: not able to get `load` of node 'fdt-1'
> Warning: not able to get `load` of node 'fdt-2'
> Warning: not able to get `load` of node 'fdt-3'
> Warning: not able to get `load` of node 'fdt-4'
> Warning: not able to get `load` of node 'fdt-5'
> Warning: not able to get `load` of node 'fdt-6'
> Warning: not able to get `load` of node 'fdt-7'
>   COPY    u-boot.dtb
>   MKIMAGE u-boot-dtb.img
> Warning: not able to get `load` of node 'fdt-1'
> Warning: not able to get `load` of node 'fdt-2'
> Warning: not able to get `load` of node 'fdt-3'
> Warning: not able to get `load` of node 'fdt-4'
> Warning: not able to get `load` of node 'fdt-5'
> Warning: not able to get `load` of node 'fdt-6'
> Warning: not able to get `load` of node 'fdt-7'
>   BINMAN  .binman_stamp
> Wrote map file './itb.map' to show errors
> binman: Error 1 running 'mkimage -t -F ./itb.fit.fit': Warning: not able
> to get `load` of node 'fdt-1'
> [Config: conf-1] Error: Overlap detected:
>   - uboot: [0x40200000 - 0x402c1698]
>   - opensbi: [0x40000000 - 0x40202128]
>
> make[1]: *** [/tmp/u-boot.2.git/Makefile:1339: .binman_stamp] Error 1
> make[1]: Leaving directory '/home/es/build/u-boot'
> make: *** [Makefile:198: sub-make] Error 2
> make: Leaving directory '/tmp/u-boot.2.git'
>
> If you would like to reproduce the issue, use config
> starfive_visionfive2_defconfig and pass to OPENSBI env variable the path
> of opensbi object 'fw_dynamic.bin' built using PLATFORM=3Dgeneric, with
> the ordinary gcc riscv64 toolchain. The starfive visionfive2 board
> target in U-Boot supports multiple vendors and boards selected at
> runtime and is an example of a more complex FIT usage that you may be
> interested in for comparison and testing.
>
> Best regards,
>
> -E

Sorry that I didn't noticed that my previous email sent to you was not
including other people

Long story short, I am now able to reproduce the overlap issue that
you have encountered, and
I spent some time trying to understand what is opensbi, please correct
me if I am wrong

AFAICT, there will be 2 types of firmware built, one is
`fw_payload.bin`, and the other is
`fw_dynamic.bin`
- fw_payload.bin: contains the next-stage binary, so the file size
will be bigger
- fw_dynamic.bin: provides information about the next boot stage at
runtime, so the size is smaller

and here are the size of these 2 files built in my environment
```
-rw-rw-r-- 1 ubuntu ubuntu  273048 Oct 25 14:49 fw_dynamic.bin
-rw-rw-r-- 1 ubuntu ubuntu 2105656 Oct 25 14:49 fw_payload.bin
```

When using my overlap checking mechanism, and passing the
fw_dynamic.bin to build U-Boot,
there is no overlap issue. However, when using fw_payload.bin, there
will be an overlap issue.

AFAICT, the SPL will load the opensbi firmware(assuming fw_payload.bin
here) first, then load
U-Boot into memory, and then jump to opensbi firmware, so I was a bit
confused why the
overlapped opensbi still works?

I will find some time to figure out how the whole loading/booting
process looks like, but it would
be greatly appreciated if you can share some insight, thanks!

Best regards,
Aristo
