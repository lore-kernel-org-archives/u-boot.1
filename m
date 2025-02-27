Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBDAC19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC70781197;
	Thu, 27 Feb 2025 17:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sv7+kF6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E565A812BE; Thu, 27 Feb 2025 17:27:50 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5C0C81113
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22114b800f7so24244315ad.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740673667; x=1741278467; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x2rSM7AeGwmv7MydkJh/8sc7JEU8Bl9H3K96S07eQ1k=;
 b=Sv7+kF6R9niUXBimqUfhziawiCUJ8Q2CPRm/lwH2aITWQ2gD8ckHUfVTTlhnfY3M8V
 SMREoLxhIe2dNRR/2HydJL6wNTeIswnhv+qPT05I4N+WoMLCE5snVyFj0aU9UbUOtYIN
 R43mbnbE+fTuOteN6La+fV9q6Gw+BRj9S5wfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673667; x=1741278467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x2rSM7AeGwmv7MydkJh/8sc7JEU8Bl9H3K96S07eQ1k=;
 b=uHqFHsx6zqauy6Uy4z5Ps73KfuUrzfVYqWac3qYLj5eukjaK4H+K0eD3pT2MaL4UvE
 pEh9rEAcoGitcILxx2DOv9BRNxedzPZRzhJdtHVvYCep2PfcGWvZfObAcWKIXEladr2U
 h7lKtlRc2vqhoF928qAIZiHnJbf1798SbCD0AWF2HiIpICkaHggcKafTNL4v+b0YOVs+
 LtvBBpmVgxc3jDD63EkmAcnawXgFpnnITo9r29y4UxNe6SetMR1JYzfhPEej8o3WbkpH
 1GmPLPmLX9gABpbfcyAYKDMLU3peTYouYSLOerfWTxl7lq/tfmuqyaOmWNkHnerLaJ0b
 2Szg==
X-Gm-Message-State: AOJu0Yw2t630jMEshFZtQqRy9q+7uz6jpPQG9mEzyCnm9zSZ1xZvP2cf
 i1LVnM5BSkvsKu3WC0xoY9nVc5eUoeO9RLmmEuI1bf/FSPRPIfnK1SKWPHngCO4x0jdVwHj3kc7
 oUUvUk9gH3ZoKAZ9rRBnLE9O7+NfgTjd53ZE2
X-Gm-Gg: ASbGncuQzd+7zvz+iCM/nq8WnJb5/8RsEXs/5PWXQuOGIyGDTU1wD3S1qb7ZT2CiQO5
 8dWPCLcHVrVGtj6buR49LdxPbcI0Xg1MF/HCLeHO0EDXqZ2/yI8EGaqlSeCcyYQaKbkv+ENbyQL
 c4afoPGBA/
X-Google-Smtp-Source: AGHT+IH++IHyus3oSYu7XMqwk5mKcLSUs6xFUmD6HmHw5vg54FmvrPVrlKNkJ+O9q3/s528UxvtpSDYrXM4pVbxwLg0=
X-Received: by 2002:a17:90b:2751:b0:2ee:94d1:7a89 with SMTP id
 98e67ed59e1d1-2fe7e2fad68mr11690098a91.1.1740673667142; Thu, 27 Feb 2025
 08:27:47 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-5-sjg@chromium.org>
 <0180063b-7300-4156-97a8-2e5e12b061cd@kwiboo.se>
In-Reply-To: <0180063b-7300-4156-97a8-2e5e12b061cd@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Feb 2025 09:27:02 -0700
X-Gm-Features: AQ5f1Jod_4xcI0f2HtTbCiNPzlYpvQMbaTy-BEKLfROVDociImkC-sb0G1B1ou4
Message-ID: <CAFLszTjL5qk8r8X6evT1D2ByS0bbwHWZsrGsXUnhmsRaFf4jWw@mail.gmail.com>
Subject: Re: [PATCH v2 04/35] arm: Support a separate stack for VPL
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>, 
 Gary Bisson <bisson.gary@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Jonas,

On Mon, 17 Feb 2025 at 14:22, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-09 22:14, Simon Glass wrote:
> > VPL has the same needs as TPL in situations where the stack is at the
> > top of SRAM. Add an option for this and implement it for arm
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Reply on existing CONFIG_VAL() to select the VPL stack
> > - Correct reference to TPL when VPL was intended
> >
> >  common/spl/Kconfig.vpl | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
> > index cf6b36c8e38..4abb96221bb 100644
> > --- a/common/spl/Kconfig.vpl
> > +++ b/common/spl/Kconfig.vpl
> > @@ -266,6 +266,20 @@ config VPL_MAX_SIZE
> >         The maximum size (in bytes) of the TPL stage. This size is determined
> >         by the amount of internal SRAM memory.
> >
> > +config VPL_HAVE_INIT_STACK
>
> Please see my remark on the name from the TPL patch.

Yes I replied to that.

>
> > +     bool "VPL requires a initial, fixed, stack-pointer location"
> > +     help
> > +       Enable if the VPL phase should not use inherit its initial
> > +       stack-pointer from the settings for U-Boot proper, but should set
> > +       its own value.
> > +
> > +config VPL_STACK
> > +     hex "Address of the initial stack-pointer for the VPL stage"
> > +     depends on VPL_HAVE_INIT_STACK
> > +     help
> > +       The address of the initial stack-pointer for the VPL stage.
> > +       Usually this will be the (aligned) top-of-stack.
>
> Here you are using stage, when you changed it to phase for TPL and use
> phase for the above symbol, please be consistent.
>
> As already mentioned, please split patch 1-4 into a separate series.

OK

>
> Regards,
> Jonas
>
> > +
> >  config VPL_BINMAN_SYMBOLS
> >       bool "Declare binman symbols in VPL"
> >       depends on VPL_FRAMEWORK && BINMAN
>

Regards,
Simon
