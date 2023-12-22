Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCD7C46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 13:48:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1785487801;
	Fri, 22 Dec 2023 14:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ngl64XLO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5A6D8781D; Fri, 22 Dec 2023 14:48:24 +0100 (CET)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3CB2877E2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 14:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7cc4fdfe799so334858241.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 05:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703252901; x=1703857701; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WPid/ft+mvZtaPWmg5GYjl4VtlEonprjqhs+p6xFiLA=;
 b=Ngl64XLOiWIbZSfIrn2mXJIBr3cL6/Z2fJ8a0j1Z+GhMQfZsyBsVJezCa2W6Vzf//x
 vdQqmvfpJSRU3gWZT56d261hNYe18+nTIMJe5RVaSddn3Wp6IYRTGrkN9h/h79tl6amg
 PL38OLDh4Zm6g58KzdjGYFqHtnRBl9tTps9x+GjM8w9l0HVY+5FJeM3MakEtHRJEQI3m
 1iCFw+zb4/XpNmBJV01cOXB/PKzPgouiRSnfmVQQiCOYvwkoDZGHHJFDvo00IXIw+7ut
 uOMz+L5prD4O25haWAeBoGZl0TFVJr4jCKDyUKV5RzuXs2qOI0yc8ipQegVTrUtdC2ya
 tObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703252901; x=1703857701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WPid/ft+mvZtaPWmg5GYjl4VtlEonprjqhs+p6xFiLA=;
 b=BP1kSCQK1KnOmM6fUL9eykd0oJVVClRvVfdi6ReyQBkFKHhwWAzMWC3zZAglbOEccA
 YqbU/RZF1000B6nJoFiC9/KMecCQLizEofTIv7ZEoVh9Tf0/FXJH6QYbGrYE2HWZVBex
 kZNK+PefUcmklzEzyBvySemWK7c3HRc6bscun3AC0z7q/WpZd7Zqn4H7CztKkWVcieq5
 UvWOcAvmag4RScvzCN5X1lEhZJlXwD+uY6M6uki3jIbnfNXB5lFvRtUz9vOai17ryqMq
 aLMPyKeh8ICJy4pBmMS6lVq6+0OVldHVf9y6hmZ4pgZjZ8QkDlUS3Iyq/AbsCzyJymw6
 ew9g==
X-Gm-Message-State: AOJu0YyCVfnPV5xflpwND+qo5RhAjlkc5x1U8GBoRr/B+9wg3q16aZgJ
 IinXtKllAmzMsWB9m4HkdDW0s/dJ3EYUnf7jpqhoRWsYj/25kw==
X-Google-Smtp-Source: AGHT+IHrl2Ddc+tzvoHnuQ/grXKkzQTPcWk13A3yakmfXbs2ZwqqB9flWoGPonuelsdHg9NXiP9ErX9lOZuVbQWdnnM=
X-Received: by 2002:a05:6102:4404:b0:466:2f2:4d4c with SMTP id
 df4-20020a056102440400b0046602f24d4cmr761133vsb.24.1703252896496; Fri, 22 Dec
 2023 05:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-6-sumit.garg@linaro.org>
 <20231222123504.GA2513409@bill-the-cat>
In-Reply-To: <20231222123504.GA2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 22 Dec 2023 19:18:05 +0530
Message-ID: <CAFA6WYNo3mNE94tHo0-iogbk49ZSo4WXzRWPME=XPZ7F1H5a8g@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
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

On Fri, 22 Dec 2023 at 18:05, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 22, 2023 at 11:42:05AM +0530, Sumit Garg wrote:
>
> > Encourage SoC/board maintainers to migrate to using devicetree-rebasing
> > subtree and maintain a regular sync with Linux kernel devicetree files
> > and bindings.
> >
> > Along with that add documentation regarding how to run DT bindings
> > schema checks.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  doc/develop/devicetree/control.rst | 108 +++++++++++++++++++++++------
> >  1 file changed, 86 insertions(+), 22 deletions(-)
> [snip]
> > @@ -81,18 +94,21 @@ Failing that, you could write one from scratch yourself!
> >  Configuration
> >  -------------
> >
> > -Use::
> > +Traditionally, U-Boot placed copies of devicetree source files from Linux
> > +kernel into `arch/<arch>/dts/<name>.dts` which can be selected via::
> >
> > -   #define CONFIG_DEFAULT_DEVICE_TREE        "<name>"
> > +    #define CONFIG_DEFAULT_DEVICE_TREE       "<name>"
>
> Oh, oof. This never got updated for Kconfig rather than config.h. Can
> you please include re-wording this to be setting <name> when prompted
> for DEFAULT_DEVICE_TREE by Kconfig? And the rest of the text you're
> updating as well to match, thanks.
>

Sure but how about changing it to say via board defconfig as
CONFIG_DEFAULT_DEVICE_TREE="<name>", since AFAIK most people use
defconfig to configure U-Boot.

-Sumit

> --
> Tom
