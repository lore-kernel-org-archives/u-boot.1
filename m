Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34961C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 11:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8269687620;
	Wed, 20 Dec 2023 12:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lWTS3dKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67996876E9; Wed, 20 Dec 2023 12:26:35 +0100 (CET)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AEB987509
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 12:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7cac4a9faccso1413757241.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 03:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703071592; x=1703676392; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LilU9MTXpQFvcRtIxC4+1nN1E0nnvpiW3FEndOqTiVk=;
 b=lWTS3dKjnf/BUVmrFQCNDDQ2GgqxQNynd6KvlGjNdKpw1Mkp55hagTnxM4sRz7QvOy
 1kBBpwgF9WOG7Dj3uPTzcPd4TtPfEH1dqMV18S4uVr2QPYK7J8kwJAmwwYVuWaA5aoNr
 mU3o21wbKhfwm68Gk7VuwCtSuzzoq8ayCOAZRDsvX65+Il4zNXDI1heDHMtv30nK7Ejf
 Okyc82mqv4grsK158mgWvXjoQwOpRv+PWfnLkm5Rl+rmEmSh9y4xZ7l6lVGLhdWFhnSe
 JtvsEiRBq3qFG7M6vUCg2guaHYyYjuY6SsheSAKgKqr3g7TeCWjt79rFx1CsPXn//fn7
 /yXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703071592; x=1703676392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LilU9MTXpQFvcRtIxC4+1nN1E0nnvpiW3FEndOqTiVk=;
 b=UZ5hVNS+XMEwTiBiP+qP1z2akeZ28Z/x0+Yy3gH9jTLP9LjXtLsO4YILwAgJCj3krj
 8waw5jmxAAy4BT9j3eqILDC9m9D+l2Ca9y5AmssKzpcwwIqj3TZFYhRDEDI9evkukN/K
 N4L39/Rl+OAMzRisIoIpIgtsc5HWqscgTjkLnAPoVAnxqtwtmYs4S7ky1H1qkGg6tNHu
 kxI3oEvsok4fOFxfyVhfxwO3nWiqbRpi4H418r9+o6In2nRdtYVhGKENuAGQgOYQmMan
 YulYNc6Vv9tdcLWgSh2QeU/+a0dVTY43dpmshf92rgAzKf2xjIR1p3xgKeqmISIDwiCS
 zHpw==
X-Gm-Message-State: AOJu0Yz2AGt/T+n1OVC44venjWZL4tmTBSSBhBiYiVfv72Y1D9LbKIYb
 qfGWbOb6+UFQHYD2qU+h7nY5lTHfL+H98UxINjbO3w==
X-Google-Smtp-Source: AGHT+IEQD5Mzukt5P428mdL46BkVUeHxSkiIXEnGI6LEgACV3Aw9rXHqG/BSxrCcNEj9wRanZzV+mnRsjrtZxtV8GF0=
X-Received: by 2002:a05:6102:3706:b0:464:89f2:801e with SMTP id
 s6-20020a056102370600b0046489f2801emr16409275vst.29.1703071592006; Wed, 20
 Dec 2023 03:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-2-sumit.garg@linaro.org>
 <20231214142713.GZ2513409@bill-the-cat>
 <CAFA6WYNNpTeaPkrZiHHYChQ2EnFByH6DyeqfCn5=c0+C452Shg@mail.gmail.com>
 <CAPnjgZ0jzaNUmvUEQVAGdtv1_UKO=_VHJ8HtkofJXu6gFBVXXA@mail.gmail.com>
In-Reply-To: <CAPnjgZ0jzaNUmvUEQVAGdtv1_UKO=_VHJ8HtkofJXu6gFBVXXA@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 16:56:20 +0530
Message-ID: <CAFA6WYOA7umuYv08aqVSS_PgXA7t+hGB7TaH=xLQrm8-s-Gv4g@mail.gmail.com>
Subject: Re: [PATCH 1/8] Azure CI: Exclude devicetree-rebasing subtree for
 CONFIG checks
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
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

On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Thu, 14 Dec 2023 at 07:46, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Thu, 14 Dec 2023 at 19:57, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Dec 14, 2023 at 07:20:56PM +0530, Sumit Garg wrote:
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >  .azure-pipelines.yml | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > > index d6f3fa423c6..f100c4493e6 100644
> > > > --- a/.azure-pipelines.yml
> > > > +++ b/.azure-pipelines.yml
> > > > @@ -65,7 +65,8 @@ stages:
> > > >        # have no matches.
> > > >        - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
> > > >                    :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
> > > > -                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
> > > > +                  :^include/linux/kconfig.h :^tools/ :^devicetree-rebasing/ &&
> > > > +                  exit 1 || exit 0
> > > >
> > > >    - job: docs
> > > >      displayName: 'Build documentation'
> > >
> > > The GitLab tests needs an equivalent change.
> > >
> >
> > Sure I will do that in the next spin of this patch-set, thanks for catching it.
>
> Also, please add a commit message with that :-)
>

Ack.

-Sumit

> Regards,
> Simon
