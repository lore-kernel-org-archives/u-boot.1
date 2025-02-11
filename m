Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BAAC021A1
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 10:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31778800B3;
	Tue, 11 Feb 2025 11:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eAgTv2eg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6914800CF; Tue, 11 Feb 2025 11:53:28 +0100 (CET)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 950E580079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 11:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-52054c55991so683661e0c.1
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 02:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739271204; x=1739876004; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUigf2+nVjmKSa/2jgc0dRsOr5qa1VicuVe26x3qzuQ=;
 b=eAgTv2egDdbgv2D2JSbanVAwFbI4/4DkPWK6p8Z+4rXRrdiW4Csoe2gbzq5dMXkIzE
 PDYLeW9+yxbuJbPdbncWBIv2/1WFUlQoqwjqk/4nTcl4FsPtLPZdIn2xzb8jITBGI3ry
 C4vSpUfpkI+cBBSpwaBRyl/Hp2oX7OXAY3QfW2BzgbD6CQiL9eDUhrxqlZyQ+Su4Jpo3
 Dx7SnHmlEfJzqtK0vaDsnktcN6AjHdzhxl8UU2h70rDks0tq2pLrhf0St+tzfGAOH6lp
 r9EqcBiKmlQdV4DvCMyd874ia4GW+FqJpnJ8PKbX9nl085C4Mgto1d9+JCyzfbQnFIsD
 FR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739271204; x=1739876004;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUigf2+nVjmKSa/2jgc0dRsOr5qa1VicuVe26x3qzuQ=;
 b=XIvRfVWr0tMKqABNsKHiflPu3NvuUR9BPsrs9tHdluFec88kDCym0iwgyr/g/PN65O
 8/c+VCfHtCs6m9A1MnjGAgC8xE0885+zsfM19UHAVlkPEU07qmLiWZEn0mG3g4dRH9YN
 b8DP3ZpjQm6zQC7mmCs6cC40cMyDHdkzsZ4uKljphrh+IbNP0+qF+Wz4jJ0J8VABuL/u
 AcKdgEqTQY1h/r7iW8U6QUvbAc2WyRe09l6Qh0c5ywKFIKWg/QcTt55zelu2iLwmT/4C
 Av5kPFa32rvhEjZox16WBHiI4AnoW6iSId3lKbT+tNop4TS663yQidujnsQWX7N3uung
 2f4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCkdGrCGAb+Z1sV0l4DnMVBHSwUxAP79uiJzyAe+ApXh/yxxBoKiELd5wX/dROD1KS+2pCTAg=@lists.denx.de
X-Gm-Message-State: AOJu0YwhWHJz9wkWEDxmiLg96C7WzmNvf33zaQCJ9ZUx9jSO8Z5DShif
 hK0gmnXwpXV9+GxXAA/54lGVIFbym+QMM6oH7tnh9veEDFhZ4g62aychw7tKz06O2zvW9RxH2OI
 ev0cILChGK+DpXJKnwg4mHtjlLDaz2CMW/EBbTg==
X-Gm-Gg: ASbGncsYqRPYmLfX4hEK5RcKNE0Oq3DR0Agx6+uOn8/cimBxOLoeOIlKqTozIfZBiTA
 7l1q3emkro2areBXlB+PeJss92O9IQ+1X0r3d/NuC4nobFkUIh4kHUVBifNwLXeQmfYUrai0RZQ
 ==
X-Google-Smtp-Source: AGHT+IGW+k8a9ADpftUmZyy7F/rl5dpTWlE/++9kSSEYG/hOVHA2H/JVJLy1fFnkH20sIoGfr3bhILPW+X4QK0X7szo=
X-Received: by 2002:a05:6122:e53:b0:515:20e6:7861 with SMTP id
 71dfb90a1353d-520584235ddmr1248647e0c.2.1739271204395; Tue, 11 Feb 2025
 02:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
 <20241015153717.401371-6-sughosh.ganu@linaro.org>
 <20250117-molecular-quicksand-e80bf947313e@thorsis.com>
 <CADg8p97Q70PnsXd=GtTLncg8B8LMTN7bda4YXxb+VDnCU4HL4Q@mail.gmail.com>
 <20250120-shine-extended-134d3ccac85f@thorsis.com>
In-Reply-To: <20250120-shine-extended-134d3ccac85f@thorsis.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 11 Feb 2025 16:23:13 +0530
X-Gm-Features: AWEUYZlD__Z2mxNUDSu-AT4FiGuJ5t43V-PbS38aBZmoCKzOEv7UBAgqrMhkfZM
Message-ID: <CADg8p96wCZppfKBrVok6nU1eyx=dHcAH9iZaiHa_jMkYd1LHUg@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] lmb: notify of any changes to the LMB memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mark Kettenis <kettenis@openbsd.org>
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

On Mon, 20 Jan 2025 at 15:43, Alexander Dahl <ada@thorsis.com> wrote:
>
> Hello,
>
> Am Mon, Jan 20, 2025 at 02:40:38PM +0530 schrieb Sughosh Ganu:
> > On Fri, 17 Jan 2025 at 16:40, Alexander Dahl <ada@thorsis.com> wrote:
>
> [=E2=80=A6]
>
> > > This changeset breaks build with CONFIG_CC_OPTIMIZE_FOR_DEBUG=3Dy for
> > > me.  In a usual non-debug build, everything is fine.  However in a
> > > debug build now I get this error:
> > >
> > >       UPD     include/generated/timestamp_autogenerated.h
> > >       GEN     Makefile
> > >       Using /mnt/data/adahl/src/u-boot as source for U-Boot
> > >       CC      common/version.o
> > >       AR      common/built-in.o
> > >       LD      u-boot
> > >     arm-v5te-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_up=
date_notify':
> > >     /mnt/data/adahl/src/u-boot/lib/lmb.c:458: undefined reference to =
`efi_add_memory_map_pg'
> >
> > Can you share the details of the toolchain that you are using, where
> > can I download it from. And the target that you build which shows this
> > up. Thanks.
>
> Although I'm actually building with ptxdist and
> OSELAS.Toolchain-2023.07.1/arm-v5te-linux-gnueabi for a custom board,
> you should be able to reproduce the behaviour easily with buildman on
> master when building for boards sam9x60ek or sam9x60_curiosity like
> this:
>
>     buildman -o ~/build/u-boot/buildman -e -a CC_OPTIMIZE_FOR_DEBUG sam9x=
60
>
> My output when running the above is this:

Sorry, I haven't spent time debugging this issue, although this is on
my todo list. Btw, since you already have a working setup, can you
please reset your tree to the following commit and then check if that
fixes your issue.

92e75ee47f1 ("board_r: Remove duplicate headers")

-sughosh

>
>     % buildman -o ~/build/u-boot/buildman -e -a CC_OPTIMIZE_FOR_DEBUG sam=
9x60
>     Building current source for 5 boards (5 threads, 4 jobs per thread)
>            arm:  +   sam9x60_curiosity_mmc1
>     +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_not=
ify':
>     +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
>     +make[1]: *** [Makefile:1824: u-boot] Fehler 1
>     +make: *** [Makefile:177: sub-make] Error 2
>            arm:  +   sam9x60_curiosity_mmc
>     +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_not=
ify':
>     +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
>     +make[1]: *** [Makefile:1824: u-boot] Fehler 1
>     +make: *** [Makefile:177: sub-make] Error 2
>            arm:  +   sam9x60ek_mmc
>     +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_not=
ify':
>     +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
>     +make[1]: *** [Makefile:1824: u-boot] Fehler 1
>     +make: *** [Makefile:177: sub-make] Error 2
>            arm:  +   sam9x60ek_qspiflash
>     +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_not=
ify':
>     +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
>     +make[1]: *** [Makefile:1824: u-boot] Fehler 1
>     +make: *** [Makefile:177: sub-make] Error 2
>            arm:  +   sam9x60ek_nandflash
>     +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_not=
ify':
>     +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
>     +make[1]: *** [Makefile:1824: u-boot] Fehler 1
>     +make: *** [Makefile:177: sub-make] Error 2
>         0    0    5 /5              0:00:40  : sam9x60ek_nandflash
>     Completed: 5 total built, 5 newly), duration 0:00:22, rate 0.23
>
> Greets
> Alex
>
