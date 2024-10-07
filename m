Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339D5CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 10:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE2BE889E1;
	Mon,  7 Oct 2024 12:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oySwsCmI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CC6788A7D; Mon,  7 Oct 2024 12:21:08 +0200 (CEST)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91E298863E
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 12:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-84e8aa83898so854015241.1
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 03:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728296464; x=1728901264; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61eFrVmawtbuxB+fQUfEYuTsFopFR85HNTaaSBBwd7M=;
 b=oySwsCmIoik1u8hBxunhJlxuvhAbJNTOzIxuGNPmIoJGug6cSHUo/tWd2iYZfWzVUq
 wDB5qtUP86Yppovm3q3TB6BmQ+sr+be/Q5Vv/r6RnjO9x0U6oFXm5EPc7Y3pbJW4LXLH
 KMR88hSPNIvkWvk8fzZG7aBTtW5mSWEaLk5vh4YH4o16tH+gC0ruPm9BhVuI+I2dTS+i
 i7kmPs2RSEFcZ3RKxbAVdL3wdSILvV9UnMOFO7IUN+2N2Tp1EqHH0T6F9mbmV8aStgzf
 ottsQSqoi1g3dd6CWtHCdpLG3t/aBE+iaESO2UchfP+ai1kpeICdm+ifmPIozt41B0ol
 UPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728296464; x=1728901264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61eFrVmawtbuxB+fQUfEYuTsFopFR85HNTaaSBBwd7M=;
 b=CSdi9AkIpmKw2/29fwINdy/EdCaDqZgJ7UsRNuWFK913j0+0OfcXOY5Y+3rkQQw3dy
 MII3WFAyyYDVWxYzzZ6Le29IyRA4Kf8BSIMg7NuZHF9FjsHd6P+jQN0GiAHeuAQNHWwL
 Jj3QWxo9//vWHEF1o+04QdDa5f+HWTKOvO1gpcwD0Lh0+2RiTOeyu68izxEgQflkIR1u
 SErrXArJBMTnypC1llSsFmpWx2KsEI8bvIrmtjP2W6D4grGEDhwMkWAaPDeACIDiOyug
 1Ndak1HHA8eCEJ9pOBc/3avWM/P48DQVADagfBVQY7kdudpRz9JLaU+5Fofx/bGPxDl4
 o58w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhCKCnjnB1n/piTs3TQSNqGBDH4dDfpcH94Ty6uAs9TdRJ+aBEmneFNiKK9LJlhgLQpV0+IPk=@lists.denx.de
X-Gm-Message-State: AOJu0YyR6edPZjx7mfRv1KhvLGtH3ngDs5r1cr63mdxBOO0aZcic9Vtd
 mEkfT9M5k2+lov5j6cvf77zPnYNxvg1R9Z+miWKbyomLAtwZGkzu6bnQPbIW2jciXq7kPzhzffV
 VaoXZ6mirA3kYR/TpP1ouQFH+8e5All1jbLbjXA==
X-Google-Smtp-Source: AGHT+IG92GkcHOTN5zoDL0SA/0xv8i3Ci+eSd88kpeqCeJvBo9qPZJW/C95PXsn+9SHgy9NP+L77KGQ/va1uqftRJuE=
X-Received: by 2002:a05:6102:548b:b0:4a3:a89a:67f8 with SMTP id
 ada2fe7eead31-4a4053ed772mr7301581137.0.1728296464336; Mon, 07 Oct 2024
 03:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-3-l.rubusch@gmail.com>
 <bf99c2bd-f43c-4041-907f-f60b42163cce@denx.de>
 <CAFXKEHbOpv4g5LZ4dkUpwo1OBrRQ7YKZf10=S-2HqMtSK_OE9g@mail.gmail.com>
 <e294ce74-9b77-4de0-b7fc-0d8db9f1226f@denx.de>
 <CAFXKEHZVJiLO_qsy8wtRS9BAs4SG8crTXjoJxwgN45a8GP+JKg@mail.gmail.com>
 <57a00da7-ec38-4c3a-8e5a-b44929358337@denx.de>
 <CAFXKEHYvNC5WKphy2LZ=w5tSv_0W3DM4BjSgT821RY5wsYB1jQ@mail.gmail.com>
 <ac106ee6-d8b8-45d5-a344-85aede3e7c1c@denx.de>
 <CAFXKEHZCtXeJupi1H+V8pgumBe8m1Vgdg5-OrQ870H-_nSbJhA@mail.gmail.com>
 <91b1de6d-b686-4f21-86c2-f5a3bef8c56c@denx.de>
In-Reply-To: <91b1de6d-b686-4f21-86c2-f5a3bef8c56c@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 7 Oct 2024 15:50:53 +0530
Message-ID: <CAFA6WYOxiQarHHhoJAbbgV9y4OOnWVZFh-aV_wvpNKix0G6_mA@mail.gmail.com>
Subject: Re: [PATCH 2/9] ARM: dts: socfpga: add Enclustra Intel AA1
To: Marek Vasut <marex@denx.de>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, 
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
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

On Sat, 5 Oct 2024 at 07:14, Marek Vasut <marex@denx.de> wrote:
>
> On 9/29/24 9:19 PM, Lothar Rubusch wrote:
> > On Sun, Sep 29, 2024 at 6:55=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> >>
> >> On 9/28/24 12:47 AM, Lothar Rubusch wrote:
> >>
> >> [...]
> >>
> >>>>> Ideally I like to setup some Kconfig choice for base board selectio=
n
> >>>>> and one for boot-mode.
> >>>>
> >>>>> 1.) In the documentation control.rst I read that the u-boot.dts is
> >>>>> combined of several elements. Is there a way to take this base .dts=
,
> >>>>> then add a base board .dtsi by Kconfig option, and similar a
> >>>>> boot-mode?
> >>>>
> >>>> The -u-boot.dtsi is preprocessed by C preprocessor, just like all th=
e
> >>>> other DTs, so you can have a -u-boot.dtsi file which contains C
> >>>> preprocessor conditional statements in it to conditionally include o=
ther
> >>>> .dtsi files:
> >>>>
> >>>> #if IS_ENABLED(...)
> >>>> #include ...
> >>>> #else ...
> >>>> ...
> >>>> #endif
> >>>
> >>> Going through the include list setup by the Makefile made me find my
> >>> mistake. Currently I may use u-boot specific stuff in arch/arm/dts an=
d
> >>> include generic .dtsi fragments from dts/upstream. Note: I'm not
> >>> setting CONFIG_OF_UPSTREAM since I'm using the regular include list
> >>> which already contains dts/upstream/src/arm/intel. Is this ok? Or,
> >>> shall I try a different approach, which involves having
> >>> CONFIG_OF_UPSTREAM explicitely set in the defconfig?
> >>
> >> I'm not quite sure I understand the question. Once this platform DTs
> >> land in mainline and the DTs get synchronized into U-Boot, you should
> >> then set CONFIG_OF_UPSTREAM. Until then, you could patch the DTs into
> >> dts/upstream/ to test the result with OF_UPSTREAM enabled .
> >>
> >
> > Ah, sorry. I did not explain well. Currently I patch the DTs which
> > should go to kernel/mainline into my local u-boot:
> > dts/upstream/src/arm/intel/socfpga/ as a preparation for my test
> > builds.
>
> OK
>
> > For U-boot I will need to build a devicetree file from archarm/dts. I
> > cannot rely just on the upstream fragments for u-boot. Imagine
> > settings like initial fpga bitstream loading, handoff file setup for
> > initialization, etc. In parts I may use .dtsi files from dts/upstream,
> > though, but most of the u-boot particular devicetree setup will reside
> > in arch/arm/dts, I guess (you may see later in the patches).
>
> You should be able to use dts/upstream/src/arm/intel/socfpga/ with
> -u-boot.dtsi from arch/arm/dts/ for this purpose, right ?

Yeah that's a possibility. But are there any plans on pushing
currently U-Boot specific DT bits to upstream DT (Linux kernel
source)?

>
> > I noticed when setting the option CONFIG_OF_UPSTREAM in `make
> > menuconfig`, it prepends `dts/upstream/` to the included paths of the
> > devicetree files. The resulting path for the .dts was then
> > dts/upstream/arch/arm/dts/ and could not be found anymore. When I
> > don't activate CONFIG_OF_UPSTREAM, dts/upstream is in the Makefile's
> > include list anyway so that I easily can include from both locations.
>
> +CC Sumit
>

Yeah that's true it's done on purpose to allow reuse of DT sources
includes (.dtsi or header files) even when CONFIG_OF_UPSTREAM isn't
enabled.

-Sumit

> > In conclusion, currently I'm calling a .dts for building the u-boot DT
> > from arch/arm/dts. The file includes upstream stuff as .dtsi fragment
> > from dts/upstream and handoff from local. CONFIG_OF_UPSTREAM does not
> > seem to be necessary in this case.
> >
> > This approach currently works for me. If you strongly disagree, I may
> > invest more time to find a way (or why there is currently no way) with
> > CONFIG_OF_UPSTREAM.
> >
> > This was my question about. Anyway you may wait on v3 to understand
> > better in source what I'm doing, or if I'm just messing around.
> I'll wait for V3, sure, good luck.
>
> Sorry for the delayed reply.
