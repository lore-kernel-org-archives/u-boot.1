Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DF2C8303C
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 05:16:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A775583280;
	Fri, 11 Jul 2025 07:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BjIt32Ny";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CED2683423; Fri, 11 Jul 2025 07:16:05 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF0BB83123
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 07:16:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e81749142b3so1486106276.3
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 22:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752210962; x=1752815762; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GG6OxkRI50oKLdXPvpX+/0YiHk8HM2fZsDol3/hKSjQ=;
 b=BjIt32NyJr8iQ/8npnC1CE2bKeoVMZuBXhFJKpybavULoWGfmxL53G89amtrXLqopo
 MRz7StxgP3Vg+dfGubtJeMYFYe6iyJui3jFHmvqDwczJHKAdK+AUi6AULaTIJ5/flJG5
 d/Bzp45zyD4vrCbWvVPIMWLUpGxYWeucaINnRRI7Lwlfs6pExtusdPZQR9JpFRA1Z4dV
 yVMU3uCxtRTxRyGOP9sJoad8sAxHHuLDtOAVWhBIBxTOwy9MJXjuesn5mVDcvXs9ihrw
 B3vIFR7eEcff+0nOZZ8wvf3q/G9hBVDLhfZuYfBK4iudqPpW80NXmF/1FzVWVEwMNY+E
 Rv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752210962; x=1752815762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GG6OxkRI50oKLdXPvpX+/0YiHk8HM2fZsDol3/hKSjQ=;
 b=vK/GWQqHhUE8IPrd20yl9vp0kt0mN4MMFCDqkbbupllJ8xS2O6uC3+jFhZlc7OcF3+
 XGkfB3DWcJNzSs0fPEVnFoy795EOXqwe6Hp8tReGy+AyTt1s51zSoPf/e3/dz8tvikmO
 hSnAyk9PQ2xQixOajiqvUyhkc/FqsEQy4yS51xPpXmbw6BqY+ty2VWs1d8Wyr795xIQN
 EwCZJ73pDwWXEx2LEcwvOT/38pLtOA4N+zfu3SAcLMTzG03+ckTo5d95IUX0fizm/56M
 VNiXhQzMw/Sx0+A3imsTC9/HfhZ1BP3lACNVG6Zt9ttypYpImbahwoR6FJUphkXR12wJ
 fzYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl0lEjqjocjTbOEtIdym66jIZrj3Uv6efbvh2gHKCc5EzYNW8xbl6x880xQHBMOXltIEqTQz8=@lists.denx.de
X-Gm-Message-State: AOJu0YztDEka+htPtRMkBLdPx12RCT2s5r90WZ/3nYB/BaveP+DrySx3
 EdRqlNzX4K2TQ+P+p//FDBlSeL0oACUaOcVOKfkoSc5fLaLKMXSvH8nnSzGdNyj9A7rZOmEqakq
 W7XYi/vrNOrIT0TcX7v3Lzbuu3SsDPXLOaQBkXn1EiQ==
X-Gm-Gg: ASbGncsgZ71LCPMfDKq1CtenEfPBk3nqgPeZjX2sCAZUEgYIwgP/NT0KDIlRQ/kVsvQ
 am/iiMf4lnzSZE83qaaGPPtNA5Cfxe93AgaviRwX4lqWSr3c1g580F9MUk9t63cmYlefdXv0ptv
 Sx8u0aSNp9+BOoTSh+O72L+KJ7CD3I9ltWMTlrCJx/QUGfC761IVqEcbSAQGwiCOxQwpNpdNgz1
 UebK8sHWoaABOTkMg==
X-Google-Smtp-Source: AGHT+IG35i3KennLclQ+vfTPr/dSzLtP8zoAKWEZAqWXomwcUgJQ6ao5bUU9FWk3naiEwJacYKuPHv1Y2tds95pITs4=
X-Received: by 2002:a05:690c:c09:b0:716:69e0:bb85 with SMTP id
 00721157ae682-717d5dab701mr39435697b3.18.1752210962384; Thu, 10 Jul 2025
 22:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
 <CAOMZO5DP=8Jebnm32mPQ6s7rcTX62dgKqyzyrdco9dHNewyWKQ@mail.gmail.com>
 <CAC_iWj+rJgUGkpEV-vYRei9R-UPj3J_2ix++K3P-ZXK8C7Vneg@mail.gmail.com>
 <CAOMZO5CDkeD633fG-pELUF+QyzW3ftP_eQ3LmrjUTuaidY1c1g@mail.gmail.com>
 <8df9cfba-662d-416e-ac21-5ae6d4448708@amd.com>
 <20250710150154.GC6424@bill-the-cat>
In-Reply-To: <20250710150154.GC6424@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Jul 2025 08:15:25 +0300
X-Gm-Features: Ac12FXwJzk9OUNHBb2qEc0MIjtt9L6KbUE5hod0U00w_1DV5z9prT8SWXbJ6ohM
Message-ID: <CAC_iWj+B2p-xfcdJS14LZAAjxGsxXeuBbm0CxJf_DL4E-0ytFA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>, sughosh.ganu@linaro.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, 
 Olaf Mandel <o.mandel@menlosystems.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>, 
 Prasad Kummari <prasad.kummari@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
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

Hi Fabio,

I can't reproduce this on my Ubuntu and Debian boxes.
Can you paste your Ubuntu, make & gcc versions?

Thanks
/Ilias

On Thu, 10 Jul 2025 at 18:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jul 10, 2025 at 04:58:00PM +0200, Michal Simek wrote:
> > Hi,
> >
> > On 7/10/25 16:34, Fabio Estevam wrote:
> > > Hi Ilias,
> > >
> > > On Thu, Jul 10, 2025 at 11:28=E2=80=AFAM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > > Thanks I'll try to reproduce it later today and let you know. Do yo=
u
> > > > know if we build this defonconfig in the CI?
> > >
> > > Yes, mx6sabresd_defconfig is built in CI, but no CI error was seen.
> >
> > I have seen this with other targets too. Toolchain from binman has no i=
ssue
> > with it that's why I expect it has something to with different toolchai=
ns
> > builds.
>
> What host OS are you using, and are you using separate object
> directories? This feels like a "make" issue at first glance.
>
> --
> Tom
