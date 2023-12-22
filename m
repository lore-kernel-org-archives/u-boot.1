Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8BAC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 13:20:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D04E877F1;
	Fri, 22 Dec 2023 14:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TemK6GD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2114B8781D; Fri, 22 Dec 2023 14:20:48 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F06D2877CD
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 14:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6dbc2914825so371494a34.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 05:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703251244; x=1703856044; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yb1C1ThATTnjjnvl+E7i/asKkB20QwLF7h84rO3TohE=;
 b=TemK6GD/q50NpiDj7y7y0psNVNJQjb/eLDYKgyYKWjJYlSW9GQBqqNl0FclHPR4nCQ
 F7mUUWA9cNGoiCHbI8qC5Qvy6VQn11AXe/1yO9BOThoSR0Ipw4tIoV4TeN+AeT5MgDVD
 umeNP5QjkgQ8+jqWxKPZvKOrdn5C2+ZUD/50mSJGobJm3G+5yM1TGvIh6yoLOK/SdaiA
 +zXjRHYVXq4m0A2vPA68SRtGTDIFzMeAR1UcOINZZUXzXpDc5SdXRNmIIAIWFnDUUjEM
 IRviOgaK/kgAPjturkr8IY8/UiagDOm3i6HcJTBO+EgDnEy6mihu88EGNFDMKezaanYM
 26cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703251244; x=1703856044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yb1C1ThATTnjjnvl+E7i/asKkB20QwLF7h84rO3TohE=;
 b=unw4gUis6eLq/mTPVOJ2tyMX62GXR19yKdYA7nXtd/OCiojPfx+f1+csZUf2RzyEax
 G3OM03FaXsskAn+/X5KYzmn59AGTvh6p/XVMiHx9IEwa4nnWPuCkfIU99yKplSKI0em8
 AJld9Rn9g4SpNtgSVZee3s8o6Wvb4b7l8VNHUMuj+SqSsE8L7r8Y9UUxqekmrN89J1NG
 LRyYAvTzJb4shF80CXnvIK9oJmMjJSyOEf563D7JOWnPtZcsUJR3GTC6k/mcWkjyNPva
 +kfy0CKvdyblpivX5xwPQ2o0fyvEwkf//F5oViu0ubwxzKVcHAPPOvVv5iWA8eyF2JVV
 guUA==
X-Gm-Message-State: AOJu0Yw9+vjsAI+yFooMffigWBlteHx0SoRmPXgKiJtvMaw+KKEPktLI
 Q7Tzkg1yC/ETus5DIHcEDOsHaHyQBmG4eUzA6gILfctS8w8QCg==
X-Google-Smtp-Source: AGHT+IGhBq6q5xmrUR+xDaOdzM2R5mDHs5b/2pGa0uZoxm9nIY9YaCZCfjU6eUUk7+PMBue0D4EdTtUxxBtgcpbmNGI=
X-Received: by 2002:a05:6830:164b:b0:6db:ce9b:7af1 with SMTP id
 h11-20020a056830164b00b006dbce9b7af1mr103602otr.14.1703251244575; Fri, 22 Dec
 2023 05:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-8-sumit.garg@linaro.org>
 <20231222123133.GX2513409@bill-the-cat>
In-Reply-To: <20231222123133.GX2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 22 Dec 2023 18:50:32 +0530
Message-ID: <CAFA6WYNbLRVZJq_geK4h9Z4oDdJ=8ne39AUqLMfL-Bf4zpnF_g@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] dts: meson-gxbb: Switch to using upstream DT
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 22 Dec 2023 at 18:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 22, 2023 at 11:42:07AM +0530, Sumit Garg wrote:
>
> > Although there were still some variations in board DTS files based on
> > meson-gxbb SoC but I think those were minor differences from upstream
> > and shouldn't impact boot on these devices.
> >
> > So switch to upstream DT via mirroring amlogic/ directory from
> > devicetree-rebasing/src/arm64/amlogic/ directory. And thereby directly
> > building DTB from there including *-u-boot.dtsi files from
> > arch/$(ARCH)/dts/ directory.
> >
> > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  configs/nanopi-k2_defconfig           | 3 ++-
> >  configs/odroid-c2_defconfig           | 3 ++-
> >  configs/p200_defconfig                | 3 ++-
> >  configs/p201_defconfig                | 3 ++-
> >  configs/videostrong-kii-pro_defconfig | 3 ++-
> >  configs/wetek-hub_defconfig           | 3 ++-
> >  configs/wetek-play2_defconfig         | 3 ++-
> >  dts/arch/arm64/Makefile               | 9 +++++++++
> >  dts/arch/arm64/amlogic                | 1 +
> >  9 files changed, 24 insertions(+), 7 deletions(-)
> >  create mode 120000 dts/arch/arm64/amlogic
>
> Do we need all of the Makefile portions of this? One of the things that
> works today is that trees listed in ONFIG_DEFAULT_DEVICE_TREE (and a few
> other variables) will be automatically built. We might just need the new
> Makefiles to just have:
> include $(srctree)/scripts/Makefile.dts
> and then the trees a given config will need will be built.

That sounds fine for Amlogic SoC and many others too with
CONFIG_DEFAULT_DEVICE_TREE="" CONFIG_OF_LIST="" options available.
However, if in future we have truely generalized U-Boot (like efforts
for Qcom platform) then CONFIG_OF_LIST="" may become an overloaded
choice.

For now, let me drop the Makefile portions.

-Sumit

>
> --
> Tom
