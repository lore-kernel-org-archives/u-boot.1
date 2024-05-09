Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ED1C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 16:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F92088486;
	Thu,  9 May 2024 18:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nr9Yudz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D437488486; Thu,  9 May 2024 18:42:23 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF630884BF
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 18:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5b20d3ff05cso483259eaf.0
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 09:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715272940; x=1715877740; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lte+lcC8UAF00BLCH9YKIIkdwSiNobhtAO5Srxi2bO0=;
 b=Nr9Yudz/kU/kstrpOObocWbA0zakwniNg77S7jkgwOrsUdSUF0C1OYccRUUivdQ7O+
 f5N8D08OaKcBB/Fp6b9Tx1+FxaOoY3IZHSWj//FmguXZDiTKJx0ljE6AFP7VjmslKtkh
 Ot7yliqA3pO1vJhYYSLdjtaPK6YXcwzXpCYECCXQGzokQIOa10/SJZj8qINt9xcsPsn6
 hoCwugv+oJdnL1BqT3TEfK0bCVmC8gu1qnCTQz2Y3nsZUG4OGK9NasBVvxrrn4ZmJo3x
 wrZgeg8ilEj7esWJ7Pv56ey8iEYTMrc0pLK53J0yCeJiLPusaa+2deQkcRJo0eSI25r5
 y6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715272940; x=1715877740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lte+lcC8UAF00BLCH9YKIIkdwSiNobhtAO5Srxi2bO0=;
 b=eNid0OScEOa5wyJ5qdFDjQIdIzUpMCVUgXg2qPkD+AmBASXTRxZAah7a4K8JqzWB5x
 5xYowLaH/RJRbZBtthKoIFLU4mxHEpSUhT71FRGKueXSala3Me59bfCM3nsUkFjqGFC8
 tOhqUKyllVIrsnKS/yrsBugbxWEUTtOtD7bLJdjbGNPax35R6SSqJl1r+oAqGhMNC7H1
 TW3gMauV58TCW2BJEdcd+fSAFcIb6jBCtHBLLvF2YNkXUU12kRjAV3Wv5rjPFgUfFMnn
 P7aeVzvIyV9p52tVILUAf2sMLWrtnrbqtauIIK9Y+cLBSS00e3k9DlDKtlMH1BG3R4Ae
 0c7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcgyvQ4hazFilksZHU5UXs70Sm5SWKjfgAfXUsvc72ygz3drRIW1LbRqU9yEn/gkjzlmLC8Zr0PjwgXiWqqi8ePFgcqA==
X-Gm-Message-State: AOJu0YxNN8XF6QYQYw05EB7sVxfbmzXCJ2R9uDko3hi8ow5EUG80qbYo
 SCj507nhcCoxK2O4QapuBblGLJcLZEgCimhGEnexYcYqVepARKRK61mWs9515oeHg2hLMVQFEug
 ahe9OIR7iF64ufN/gQz0fJNo2kaT23D+c
X-Google-Smtp-Source: AGHT+IGU2SfsjiVdDyMvd6HOhcRoCP0UmBCWKFgwloApDtDubPrljmyME8jBxpCjRrwiU+p8lXtX1Z6zg0AAUM2NGTE=
X-Received: by 2002:a4a:98a2:0:b0:5b2:3f04:8d03 with SMTP id
 006d021491bc7-5b24d68b29fmr6243042eaf.7.1715272940439; Thu, 09 May 2024
 09:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240509152631.5892-1-linux.amoon@gmail.com>
 <66c67ad0-0d85-43a8-b5e2-b50e155ee3c9@kwiboo.se>
In-Reply-To: <66c67ad0-0d85-43a8-b5e2-b50e155ee3c9@kwiboo.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 9 May 2024 22:12:04 +0530
Message-ID: <CANAwSgQ_iqEFZV2ZKHNpOBTG+4+Rhza8v5b-GZEFyJdA0_U2Hw@mail.gmail.com>
Subject: Re: [PATCH v1] rockchip: rv1126: Migrate to OF_UPSTREAM
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>, Tim Lunn <tim@feathertop.org>,
 u-boot@lists.denx.de
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

Hi Jonas

On Thu, 9 May 2024 at 21:38, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi,
>
> On 2024-05-09 17:26, Anand Moon wrote:
> > Migrate RV1126 boards that exists in Linux v6.8 to use OF_UPSTREAM.
> >
> > Following targets is not migrated to use OF_UPSTREAM:
>

Ok, will update the commit message in the future.

> At first I got a little bit confused about the "not migrated", but see
> now that these are the boards that is migrated.
>
> > - rv1126-edgeble-neu2 : Board is an industrial form factor
> >                         IO board.
> > - sonoff-ihost-rv1126 : Gateway device designed to provide a
> >                         Smart Home Hub.
> >
> > Cc: Tim Lunn <tim@feathertop.org>
> > Cc: Jagan Teki <jagan@edgeble.ai>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Tested on neu2 edgable board.
> > ---
> >  arch/arm/dts/Makefile                   |   3 -
> >  arch/arm/dts/rv1126-edgeble-neu2-io.dts | 112 -----
> >  arch/arm/dts/rv1126-edgeble-neu2.dtsi   | 345 -------------
> >  arch/arm/dts/rv1126-pinctrl.dtsi        | 341 -------------
> >  arch/arm/dts/rv1126-sonoff-ihost.dts    |  29 --
> >  arch/arm/dts/rv1126-sonoff-ihost.dtsi   | 404 ---------------
> >  arch/arm/dts/rv1126.dtsi                | 623 ------------------------
> >  arch/arm/mach-rockchip/Kconfig          |   1 +
> >  configs/neu2-io-rv1126_defconfig        |   2 +-
> >  configs/sonoff-ihost-rv1126_defconfig   |   2 +-
> >  10 files changed, 3 insertions(+), 1859 deletions(-)
> >  delete mode 100644 arch/arm/dts/rv1126-edgeble-neu2-io.dts
> >  delete mode 100644 arch/arm/dts/rv1126-edgeble-neu2.dtsi
> >  delete mode 100644 arch/arm/dts/rv1126-pinctrl.dtsi
> >  delete mode 100644 arch/arm/dts/rv1126-sonoff-ihost.dts
> >  delete mode 100644 arch/arm/dts/rv1126-sonoff-ihost.dtsi
> >  delete mode 100644 arch/arm/dts/rv1126.dtsi
>
> Following should also be removed:
> - include/dt-bindings/clock/rockchip,rv1126-cru.h
> - include/dt-bindings/power/rockchip,rv1126-power.h
>
> Side note, following is remaining after the rv1108 migration and should
> probably also be removed:
> - include/dt-bindings/clock/rv1108-cru.h
>

I will check if any drivers are using this if not I will remove them.
will address this in V2.

> Regards,
> Jonas

Thanks
-Anand
