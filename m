Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07D3C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 07:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34A5F8760D;
	Tue, 26 Dec 2023 08:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x5lEoF3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4879E87786; Tue, 26 Dec 2023 08:53:41 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D668760D
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 08:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7cc4647543aso968263241.0
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 23:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703577217; x=1704182017; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HAxbftN0aN036HsMgXe5QrB4b6ULu6pXVWLHsE9HVNw=;
 b=x5lEoF3lPUZUpLEvAiUHtOnLgqesdjOlNZIp2Ubqvna+bTf9+o7CWY1Dx9KV/5AYdT
 p3EDoB2y6GMTYqXOYblA4IOFhzNzTJ9LmJXOtmPaOCpnCt9HBGd7rlfKQGFc9wAIDKCK
 zrrcD21fNfFRg3Vt5OfsEadfkeEeUw3PjQ5gudEo9ZUSgKtGIR9i6Y49jTGBns420sI2
 K7cNCJJlcyW8wID6XK/38gvPUhYzlj/axzo78BfuiUJ0GbPIYe2if2ZqV+IJCARhWsSO
 8sO8DnpQ5PCe183v4PHyxNQQmuTNLFGvwdTork137tR+DXDBqA27JdEseIc9SsRt1diD
 dq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703577217; x=1704182017;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HAxbftN0aN036HsMgXe5QrB4b6ULu6pXVWLHsE9HVNw=;
 b=V4fvF07UyyYj0hQ1UMuwGP0FEgeIcCN83fE8SDMkQPahGKoAsSrAOGKTdANita+/D/
 5mBof4jtW1zwgD0GAcQjwWb3N2IwVbQq1iC88wB+sgnschfOgAdWAs4FM/CGUpt5c5gU
 DslPEUimj/MJ2+nVl+R0OiwBQXuUHjz9uoyJAG7muvuOgNCvsGLWQKz009IpTxHaPHQR
 RKh10L9myvTRHBHmZo52ox9xsjG1VwNq+JVhwi4bQ4bTxhNjeU3RtZbiPAfm85Lrqps/
 nlx05Ar7XZ+Sg8GgR98tvfSSXWNZxPNe9Vkb0962A3tOppAvhXTmBJowvaSR0Z3c2Nli
 bVug==
X-Gm-Message-State: AOJu0YxAy+LS6KsRBCPfmweKh/wBdnLRqy5TiCQGBrPESVkf3FCN2N1L
 jyX1bH8haU6xOXPwTNDvFSqrBAHDqWjgoI4HsqPDD0/8IRNAQA==
X-Google-Smtp-Source: AGHT+IHAnJ3V6OtZXnmSKou/aW0fWVJXyihV/0ciysZ5EpmVI6INg0ZohlvD/54R+QqfFiRFOH/Mr685sZ7fewY/Skc=
X-Received: by 2002:a05:6122:2317:b0:4b6:e6b6:7f4f with SMTP id
 bq23-20020a056122231700b004b6e6b67f4fmr1625514vkb.15.1703577217348; Mon, 25
 Dec 2023 23:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <02fdfc4b-113b-409f-8aaf-8f4a04822706@linaro.org>
 <CAFA6WYM8EVY-D_Kptggsvxq0ZrFdP0gQ3y4UEbM+vLu0F8tLjw@mail.gmail.com>
 <c6d65491-c407-4518-aee9-f53f6d4a84ed@linaro.org>
 <20231222-whole-canola-81240881c2e7@spud>
 <4a809aa2-0cc5-4ffa-a19f-06d69ae9e460@linaro.org>
In-Reply-To: <4a809aa2-0cc5-4ffa-a19f-06d69ae9e460@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Dec 2023 13:23:25 +0530
Message-ID: <CAFA6WYPY7DmY3+Wf-=xbCpm11ub5BWTVc_C=SeSPVK0dVLTQ9w@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] An effort to bring DT bindings compliance within
 U-Boot
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org, 
 caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org, 
 dgilmore@fedoraproject.org, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
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

On Fri, 22 Dec 2023 at 21:23, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/12/2023 16:45, Conor Dooley wrote:
> >>>
> >>> I suppose we have to relay information to kernel sub-arch maintainers
> >>> who aren't the same as maintaining U-Boot counterparts. How about
> >>> adding U-Boot ML to CC for whichever DT change gets submitted in the
> >>
> >> And every other project? Just setup lei filters.
> >>
> >>> kernel? Otherwise adding U-Boot sub-arch maintainers as reviewers for
> >>> corresponding kernel DT changes works too if that's acceptable.
> >>
> >> You just entirely ignored my proposal without addressing it... ok let it
> >> be. No, CC-ing U-boot maintainers changes nothing because as I said, I
> >> want kernel maintainers and contributors to be aware.
> >
> > I don't think that adding U-Boot platform maintainers as reviewers for
> > the platforms in the kernel is a terrible idea. Certainly kernel
> > platform maintainers for which U-Boot platform maintainers are added to
> > the MAINTAINERS entry will be aware. That said, something like your
>
> The point is it does not solve my concern here. I did not express
> problem that U-Boot maintainers are not aware. They can easily be aware
> by setting simple lei filters.

I thought your major concern was how we can enforce DTS backward and
forward compatibility although the DT ABI stability is already
documented here [1]. My suggestion was really based on recognising
people who really care about DT ABI for particular platforms. I think
adding people from other projects would certainly help with DT ABI
stability since the kernel is the single point of contribution. There
will be DT contributors from other projects too like you may have
already seen people contributing bootloader (U-Boot) specific
bindings/DTS changes.

[1] https://docs.kernel.org/process/maintainer-soc.html#devicetree-abi-stability

>
> The problem I want to solve is the kernel maintainers to be aware.
>

Although Tom has already expressed in the other thread that U-Boot has
been a long time user of upstream DT but if we want to make it more
formal from an enforcement point of view then I liked Conor's idea. If
you agree then I can create maintainer profile entry as per following
example for Amlogic platforms to start with:

ARM/Amlogic Meson SoC support
M:      Neil Armstrong <neil.armstrong@linaro.org>
M:      Kevin Hilman <khilman@baylibre.com>
R:      Jerome Brunet <jbrunet@baylibre.com>
R:      Martin Blumenstingl <martin.blumenstingl@googlemail.com>
L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
L:      linux-amlogic@lists.infradead.org
S:      Maintained
P:      Documentation/process/maintainer-soc-u-boot-dt-abi.rst
W:      http://linux-meson.com/
F:      Documentation/devicetree/bindings/phy/amlogic*
F:      arch/arm/boot/dts/amlogic/
F:      arch/arm/mach-meson/
F:      arch/arm64/boot/dts/amlogic/
F:      drivers/pmdomain/amlogic/
F:      drivers/mmc/host/meson*
F:      drivers/phy/amlogic/
F:      drivers/pinctrl/meson/
F:      drivers/rtc/rtc-meson*
F:      drivers/soc/amlogic/
N:      meson

-Sumit
