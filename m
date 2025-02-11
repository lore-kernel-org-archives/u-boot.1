Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64775C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 14:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD41C80BAA;
	Tue, 11 Feb 2025 15:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RnHKG/k9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E52F080BAA; Tue, 11 Feb 2025 15:00:27 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5088280077
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 15:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4ba722d3916so1286020137.2
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739282424; x=1739887224; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IOpHiCvFAZXzuVXHx1Lcc08HMEarVZvczP0R/JeCdDk=;
 b=RnHKG/k9e7ZjtU4apXMJ81uaXRI6E7GaMZzavQ1mbJ+KtCbuIY10gm3ZSGCBM1/CZk
 a5PqRLYSRBSrNWi0gzN91TzP8pDPg8VvdclpjRlRFRh+2nSfZc6rS21PwO4NbEo8oxMh
 jGWxWUKDLOwv5msBx1IPQsTAYwQnCnjmT4lBNMve/dEKN1QmteEVmXCr4O/N8rfeOI1Q
 yVDLcDjRxxeAo+RoFXAis3bGOMwHgAJcaOk1IGEbBHiXVufUSGlrOoo3aZYDEm6piiFf
 Hpl+buyz67CE+CS2iL/1lQvY6RzcISRWqKBmI1b6fbaVHGP/knoShKHTCb/K4eUAPw/q
 DCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739282424; x=1739887224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IOpHiCvFAZXzuVXHx1Lcc08HMEarVZvczP0R/JeCdDk=;
 b=dy7DwYuPoRVw+VuNXdKT8F2QQP9qK2TuSPK0akQP/+fIBI5s8a4mhZ6VZBAb/zDH2E
 91aF45/XQBQmESYv+Y8ke6gUkyT7E3Gqr664jcQlsDVYMZof2nLfJvLjR8xjwl0IlUbR
 04vLOUBpRaPIucUwfhXn4q1GNpCqPrj3rOZjIUxVCU51j+nXMMSC8o0fl0XFclJg8ZRR
 CSE3PLlMohlZzwwp0T/y1bgVuncojG7VsYICMLy8QgI7sUxVVe3jxL4Lr6MHL/MiaYvx
 ve5lyxkqc/Cm4cGMWV9kmEPQWowC7FIgcmWtAcPosYOnUafE5JvXLD2ZQP47gLIGNaLJ
 9hOQ==
X-Gm-Message-State: AOJu0Ywh4CadaGsi/kROc6sfnVxJULedKhdynxxbe+7se97MReBoFy6X
 Oon/H3iTkEWHUKjHU55X/ddCVwUQtk41+Wcoa7suQQy9GyrOECMfZpPaP17COLr3Ah/fvc4nYX/
 orgq5FPWZEDEHQeOjJmkVkUN7uO7shs2hZjrwm8nC/4FFz88d1To=
X-Gm-Gg: ASbGncuE0yYKeuyXuZ0qr4lHFo/J7nWyWVdJU90mBbhHP/1QNxIANEYawBKngR2lqa/
 7rOJYxEdKZsMAxCDraLBfwTdo+d6PC3MurSwBRcFKF12pCx4ekWYzXMswBriHfd8mGVFm8TIy
X-Google-Smtp-Source: AGHT+IGOv67RNg4TrQh+pbbyr05ohethHlWuTmEsiWtH4pJq33PbqFBuIBTp2MskzcddYc1HChdUMF2/XdV0oexatrA=
X-Received: by 2002:a05:6102:26c4:b0:4bb:b857:7d0f with SMTP id
 ada2fe7eead31-4bbe05226a7mr2324036137.20.1739282424053; Tue, 11 Feb 2025
 06:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
 <20241015153717.401371-6-sughosh.ganu@linaro.org>
 <20250117-molecular-quicksand-e80bf947313e@thorsis.com>
 <CADg8p97Q70PnsXd=GtTLncg8B8LMTN7bda4YXxb+VDnCU4HL4Q@mail.gmail.com>
 <20250120-shine-extended-134d3ccac85f@thorsis.com>
 <CADg8p96wCZppfKBrVok6nU1eyx=dHcAH9iZaiHa_jMkYd1LHUg@mail.gmail.com>
 <20250211-distract-whooping-739989988035@thorsis.com>
 <CADg8p94iMJv5ph51ng8r=HaiMSdSMj08Lj03=Amt+2JzyFySYw@mail.gmail.com>
 <20250211135407.GY1233568@bill-the-cat>
In-Reply-To: <20250211135407.GY1233568@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 11 Feb 2025 19:30:12 +0530
X-Gm-Features: AWEUYZmFy0Vl_qJQaxmUQH8Su8wjd08-Cjy6Psgta0ajMEd2J_MpXDbxDtaF9ZU
Message-ID: <CADg8p96rNvxQ7ugmexKhmJ092WJEMwYjF50KpASjVbNrA7xxsA@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] lmb: notify of any changes to the LMB memory map
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
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

On Tue, 11 Feb 2025 at 19:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 11, 2025 at 04:41:09PM +0530, Sughosh Ganu wrote:
> > On Tue, 11 Feb 2025 at 16:34, Alexander Dahl <ada@thorsis.com> wrote:
> > >
> > > Hello,
> > >
> > > Am Tue, Feb 11, 2025 at 04:23:13PM +0530 schrieb Sughosh Ganu:
> > > > On Mon, 20 Jan 2025 at 15:43, Alexander Dahl <ada@thorsis.com> wrot=
e:
> > > > >
> > > > > Hello,
> > > > >
> > > > > Am Mon, Jan 20, 2025 at 02:40:38PM +0530 schrieb Sughosh Ganu:
> > > > > > On Fri, 17 Jan 2025 at 16:40, Alexander Dahl <ada@thorsis.com> =
wrote:
> > > > >
> > > > > [=E2=80=A6]
> > > > >
> > > > > > > This changeset breaks build with CONFIG_CC_OPTIMIZE_FOR_DEBUG=
=3Dy for
> > > > > > > me.  In a usual non-debug build, everything is fine.  However=
 in a
> > > > > > > debug build now I get this error:
> > > > > > >
> > > > > > >       UPD     include/generated/timestamp_autogenerated.h
> > > > > > >       GEN     Makefile
> > > > > > >       Using /mnt/data/adahl/src/u-boot as source for U-Boot
> > > > > > >       CC      common/version.o
> > > > > > >       AR      common/built-in.o
> > > > > > >       LD      u-boot
> > > > > > >     arm-v5te-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lm=
b_map_update_notify':
> > > > > > >     /mnt/data/adahl/src/u-boot/lib/lmb.c:458: undefined refer=
ence to `efi_add_memory_map_pg'
> > > > > >
> > > > > > Can you share the details of the toolchain that you are using, =
where
> > > > > > can I download it from. And the target that you build which sho=
ws this
> > > > > > up. Thanks.
> > > > >
> > > > > Although I'm actually building with ptxdist and
> > > > > OSELAS.Toolchain-2023.07.1/arm-v5te-linux-gnueabi for a custom bo=
ard,
> > > > > you should be able to reproduce the behaviour easily with buildma=
n on
> > > > > master when building for boards sam9x60ek or sam9x60_curiosity li=
ke
> > > > > this:
> > > > >
> > > > >     buildman -o ~/build/u-boot/buildman -e -a CC_OPTIMIZE_FOR_DEB=
UG sam9x60
> > > > >
> > > > > My output when running the above is this:
> > > >
> > > > Sorry, I haven't spent time debugging this issue, although this is =
on
> > > > my todo list. Btw, since you already have a working setup, can you
> > > > please reset your tree to the following commit and then check if th=
at
> > > > fixes your issue.
> > > >
> > > > 92e75ee47f1 ("board_r: Remove duplicate headers")
> > >
> > > Does not change anything.
> > >
> > > Note: my tree is not special in any way, it's a clean mainline u-boot
> > > checkout and I'm building for a board with an in tree config.
> > > Everyone should be able to reproduce this by using
> > > configs/sam9x60_curiosity_mmc_defconfig, enabling
> > > CC_OPTIMIZE_FOR_DEBUG and building with the default toolchain
> > > downloaded by buildman, which is also mainline u-boot tooling.
> > >
> > > My assumption is: some efi code is pulled in unconditionally here,
> > > but efi is not enabled on armv5 and it can not be enabled,  efi is no=
t
> > > needed on this target anyways.  Furthermore: I assume the code is
> > > optimized out when doing a normal build without CC_OPTIMIZE_FOR_DEBUG=
,
> > > which is basically building without optimizations and keeping debug
> > > symbols.
> >
> > Okay. Please give me some time. I will try to spend some time on the
> > issue this week. Thanks for your quick response.
>
> Yes, the problem is that CC_OPTIMIZE_FOR_DEBUG disables compiler
> optimizations that we normally rely on to avoid having to #ifdef the
> code. In this case, lmb_should_notify() causes this to normally be
> optimized away as CONFIG_IS_ENABLED(EFI_LOADER) will be false and the
> compiler will do the right thing. The "fix" is to instead make most of
> the body of lmb_map_update_notify be guarded with #if
> CONFIG_IS_ENABLED(EFI_LOADER) ... #endif

Yes, that would be the obvious thing to do. But I suspect that because
there are no optimisations with the said flag, it might be needed to
even protect the function calls with the ifdefs. Which I am hoping to
avoid.

-sughosh

>
> --
> Tom
