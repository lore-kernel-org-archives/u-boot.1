Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84406C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 17:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D252387712;
	Mon,  4 Dec 2023 18:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VNRNPFjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 066F687714; Mon,  4 Dec 2023 18:53:17 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A8DD871B1
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 18:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dianders@chromium.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c9ea37ac87so34587441fa.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 09:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701712393; x=1702317193; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5o4kl72J4dnliAxYr60gM/uEi8xxxJtEIon7STyN2k4=;
 b=VNRNPFjI1VvQtxPk/zPLYsHVNc7T2vFSKIXU+zyZvkLu/cIG40b6tKpO3M7HKTbrJL
 btR4guwvKUeDiRWpoyt0pBTSBL33wpOhfHzHU3D4H0ldAm4oZftmvXjcd58AM+qcWsvc
 iBcQ33UU+NmTAdQ17RDXaPBDLDZHE+KUOa4WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701712393; x=1702317193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5o4kl72J4dnliAxYr60gM/uEi8xxxJtEIon7STyN2k4=;
 b=o1yLnpE5GE3YqGMOsFmhR4R2iZENzBgbojtmmH8vHamNhGGAIM9zxqC5WWaWay64gw
 CvBl8Qm9g+qEYwlauL+2SOZjhA9uJJkUTzH1fxf+p4VXQrEJaxorSjM6BqLBzdiZoAJf
 dDV4ZDjm1BonQMKhTB6kJNsbqmWL0Vs2C2i1q33mLWOT5ySMKO07PeBzFZsGGpE+Qkdf
 q5E6bnop24eaRSVz/4/CUj8m604hOsHIL4qY6b6hQtE6jYbgBaw/mKo+H6/mXCveozgh
 LLQs3yV+SKAjCtBsyEadnj6oAto+4Razhl8zt/nc8/oqNkBgsxbRar2aUz9AchMZ5KKt
 yojw==
X-Gm-Message-State: AOJu0Yxoe1b3fF6AIm0CKi1yl6ptK5XX+rX8U0NIiA9uQbAYkY24o+VH
 k6Dk0TALUu+p2cf5zjwBFWv6/Jqm5+rMUNwHoO5yYYGp
X-Google-Smtp-Source: AGHT+IGZFg/6V0kJqnlFOTd2HC1RgxNYeCNJIig87nZ0JABoAdfOSzxkCCryh6fZULp9Tqm1ZFkf/A==
X-Received: by 2002:a2e:8789:0:b0:2c9:f9e9:da2c with SMTP id
 n9-20020a2e8789000000b002c9f9e9da2cmr1310864lji.11.1701712393487; 
 Mon, 04 Dec 2023 09:53:13 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com.
 [209.85.128.50]) by smtp.gmail.com with ESMTPSA id
 l5-20020a1709060e0500b00a1884edf923sm5499702eji.76.2023.12.04.09.53.12
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 09:53:12 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-40b367a0a12so135e9.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 09:53:12 -0800 (PST)
X-Received: by 2002:a05:600c:4507:b0:40a:483f:f828 with SMTP id
 t7-20020a05600c450700b0040a483ff828mr458557wmo.4.1701712392461; Mon, 04 Dec
 2023 09:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
 <CAPnjgZ25xoXsi74XYY0E8ucQiowQqPdZgUHrfVNAYWKZEYODHg@mail.gmail.com>
 <875f0dbc-1d78-4901-91b2-6ad152bcea5a@pengutronix.de>
 <CAPnjgZ0UCkm5QCx+JXe1ggSshozPnOLB6cN=UoJyMn6S4wfFkg@mail.gmail.com>
 <06281f7c-e0f2-405c-95a9-0f7e9e84a7f6@pengutronix.de>
 <CAPnjgZ2TT+0BvbjwfnGLQ3EPEXnLW6f1epiFdaBHRYaSAn5xsA@mail.gmail.com>
 <8fbc81b1-31ab-46b0-87f4-b8bd8e8e2b47@pengutronix.de>
 <CAPnjgZ1iyxk0bb56QR10N5aSphRYhLsw7Ly=z2i6rQCxP_AYPw@mail.gmail.com>
 <5e8f42f8-2b03-4033-b6d2-9b3139f081d5@pengutronix.de>
 <CAPnjgZ2RjNzqJTRZSWvuscQhs+f8CG=fDcEO=qKXNeQLP53LnQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ2RjNzqJTRZSWvuscQhs+f8CG=fDcEO=qKXNeQLP53LnQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 4 Dec 2023 09:52:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WXQrbnjeVOLp--vmLzScvW9VLFRu+apSY4WnL9JFk-AQ@mail.gmail.com>
Message-ID: <CAD=FV=WXQrbnjeVOLp--vmLzScvW9VLFRu+apSY4WnL9JFk-AQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
To: Simon Glass <sjg@chromium.org>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, 
 Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 lkml <linux-kernel@vger.kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Terrell <terrelln@fb.com>, Nicolas Schier <nicolas@fjasle.eu>,
 Will Deacon <will@kernel.org>, 
 linux-kbuild@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
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

Hi,

On Sat, Dec 2, 2023 at 8:37=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Ahmad,
>
> On Thu, 30 Nov 2023 at 19:04, Ahmad Fatoum <a.fatoum@pengutronix.de> wrot=
e:
> >
> > Hello Simon,
> >
> > On 30.11.23 21:30, Simon Glass wrote:
> > > On Wed, 29 Nov 2023 at 12:54, Ahmad Fatoum <a.fatoum@pengutronix.de> =
wrote:
> > >> On 29.11.23 20:44, Simon Glass wrote:
> > >>> On Wed, 29 Nov 2023 at 12:33, Ahmad Fatoum <a.fatoum@pengutronix.de=
> wrote:
> > >>>>
> > >>>> On 29.11.23 20:27, Simon Glass wrote:
> > >>>>> On Wed, 29 Nov 2023 at 12:15, Ahmad Fatoum <a.fatoum@pengutronix.=
de> wrote:
> > >>>>>> On 29.11.23 20:02, Simon Glass wrote:
> > >>>>>>> On Wed, 29 Nov 2023 at 11:59, Ahmad Fatoum <a.fatoum@pengutroni=
x.de> wrote:
> > >>>>>>>> The specification says that this is the root U-Boot compatible=
,
> > >>>>>>>> which I presume to mean the top-level compatible, which makes =
sense to me.
> > >>>>>>>>
> > >>>>>>>> The code here though adds all compatible strings from the devi=
ce tree though,
> > >>>>>>>> is this intended?
> > >>>>>>>
> > >>>>>>> Yes, since it saves needing to read in each DT just to get the
> > >>>>>>> compatible stringlist.
> > >>>>>>
> > >>>>>> The spec reads as if only one string (root) is supposed to be in=
 the list.
> > >>>>>> The script adds all compatibles though. This is not really usefu=
l as a bootloader
> > >>>>>> that's compatible with e.g. fsl,imx8mm would just take the first=
 device tree
> > >>>>>> with that SoC, which is most likely to be wrong. It would be bet=
ter to just
> > >>>>>> specify the top-level compatible, so the bootloader fails instea=
d of taking
> > >>>>>> the first DT it finds.
> > >>>>>
> > >>>>> We do need to have a list, since we have to support different boa=
rd revs, etc.
> > >>>>
> > >>>> Can you give me an example? The way I see it, a bootloader with
> > >>>> compatible "vendor,board" and a FIT with configuration with compat=
ibles:
> > >>>>
> > >>>>   "vendor,board-rev-a", "vendor,board"
> > >>>>   "vendor,board-rev-b", "vendor,board"
> > >>>>
> > >>>> would just result in the bootloader booting the first configuratio=
n, even if
> > >>>> the device is actually rev-b.
> > >>>
> > >>> You need to find the best match, not just any match. This is
> > >>> documented in the function comment for fit_conf_find_compat().
> > >>
> > >> In my above example, both configuration are equally good.
> > >> Can you give me an example where it makes sense to have multiple
> > >> compatibles automatically extracted from the device tree compatible?
> > >>
> > >> The way I see it having more than one compatible here just has
> > >> downsides.
> > >
> > > I don't have an example to hand, but this is the required mechanism o=
f
> > > FIT. This feature has been in place for many years and is used by
> > > ChromeOS, at least.
> >
> > I see the utility of a FIT configuration with
> >
> >     compatible =3D "vendor,board-rev-a", "vendor,board-rev-b";
> >
> > I fail to see a utility for a configuration with
> >
> >     compatible =3D "vendor,board", "vendor,SoM", "vendor,SoC";
> >
> > Any configuration that ends up being booted because "vendor,SoC" was ma=
tched is
> > most likely doomed to fail. Therefore, I would suggest that only the to=
p level
> > configuration is written into the FIT configurations automatically.
>
> Firstly, I am not an expert on this.
>
> Say you have a board with variants. The compatible string in U-Boot
> may be something like:
>
> "google,veyron-brain-rev1", "google,veyron-brain", "google,veyron",
> "rockchip,rk3288";
>
> If you then have several FIT configurations, they may be something like:
>
> "google,veyron-brain-rev0", "google,veyron-brain", "google,veyron",
> "rockchip,rk3288";
> "google,veyron-brain-rev1", "google,veyron-brain", "google,veyron",
> "rockchip,rk3288";
> "google,veyron-brain-rev2", "google,veyron-brain", "google,veyron",
> "rockchip,rk3288";
>
> You want to choose the second one, since it is a better match than the ot=
hers.
>
> +Doug Anderson who knows a lot more about this than me.

Hopefully this is all explained by:

https://docs.kernel.org/arch/arm/google/chromebook-boot-flow.html
