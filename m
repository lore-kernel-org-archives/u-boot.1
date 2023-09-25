Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC05ECE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED26886C35;
	Mon, 25 Sep 2023 15:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JZu1n2Gv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B849186B3A; Mon, 25 Sep 2023 15:11:24 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E478C86CBC
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-532bf1943ebso7674511a12.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695647482; x=1696252282; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1rGhjF73ZHpMBonmBPFXEMXKs0V0OSEU/4t24Bjw/5I=;
 b=JZu1n2GvKqIix6S3peqoZNlryu1ppUxW+QjiKnEfGJrFn12mpW1MOGHaSmKqrYU56Q
 vwxcLqDTuEH3ssTxW57XSQO5oNZm1MNJvoHNwQWffppQoP2GKLBYT1N044G3U1EVMUUH
 zuNI047LViuDw2gBAd3VNplV6SZ5EViPIEmv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695647482; x=1696252282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1rGhjF73ZHpMBonmBPFXEMXKs0V0OSEU/4t24Bjw/5I=;
 b=Udg6v/yEF6VVXCsRJw+ODqyjYfLRovoktNSxvl0vEqaZmZErT8EglrNfL/Azb3ZXed
 CkajVG9e8g+bGDnUx/JtZM176NKCOHYnRrPNhszpR/OBLuYiBgFQkGe3IsItVcCta5nt
 8Edn72dqbURV3zSSMqi7zxChxmr//SarcmUgxBEOjxfDIQCBHICLAYRdovezUz2snQxH
 1FteZdDJBbzzU7PW/13mbKHEYox9nER/pWaGs0O639mP+9x4qvQgQhUnjdABgx9ydNK9
 7CJNA1rpDsRtXKPNaDahYZVgvbaKqjqeAr8fbV0tC4ocZL68wR9v7C4EwpUBlINlMe3Y
 Kepg==
X-Gm-Message-State: AOJu0YzohG8y3mvZr4qVmnrEU/sDikYD9X4aUgphIFooqfvHHL46cokt
 ZjWxN4/PYHrVCHLaiMZ0BILc6yL/HyaDTemZ2y3I6w==
X-Google-Smtp-Source: AGHT+IGji3IbLeoM/54wYEeBot24GoPkh1WZHX2rZXxZVAqYqWU9Zq0NqWvertBVj9tBCroa2cBJvuUJ1QlL/EZTJsU=
X-Received: by 2002:aa7:c6d4:0:b0:533:87c9:4a81 with SMTP id
 b20-20020aa7c6d4000000b0053387c94a81mr5313376eds.29.1695647482100; Mon, 25
 Sep 2023 06:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230915175050.4109711-1-rasmus.villemoes@prevas.dk>
 <CAPnjgZ2NzoYi9vVWxnnCNU0yudbVCnN2qMRm_gq1zVW-=SuUCg@mail.gmail.com>
 <5aa005dc-1767-707c-f40c-61e95602c13d@prevas.dk>
In-Reply-To: <5aa005dc-1767-707c-f40c-61e95602c13d@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 07:10:38 -0600
Message-ID: <CAPnjgZ0BD6wg3=FiYiLG=Aq2-gFjG5d0UX-TujmGCsCE3uEgpQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] make CONFIG_SPL_SYS_MALLOC_SIMPLE &&
 CONFIG_SYS_SPL_MALLOC actually work
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <seanga2@gmail.com>
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

Hi Rasmus,

On Mon, 25 Sept 2023 at 02:54, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 21/09/2023 03.02, Simon Glass wrote:
> > Hi Rasmus,
> >
> > On Fri, 15 Sept 2023 at 11:51, Rasmus Villemoes
> > <rasmus.villemoes@prevas.dk> wrote:
> >>
> >> Currently, setting both CONFIG_SPL_SYS_MALLOC_SIMPLE and
> >> CONFIG_SYS_SPL_MALLOC (but not CONFIG_SPL_STACK_R) doesn't work as
> >> expected: The SIMPLE option means that all malloc etc. calls are
> >> directed at build-time to the implementation in malloc_simple.c, but
> >
> > Sort-of. It is control by both a CONFIG and GD_FLG_FULL_MALLOC_INIT.
> >
>
> Eh, no? The CONFIG option completely preempts any run-time gd flag checking
>
> #if CONFIG_IS_ENABLED(SYS_MALLOC_SIMPLE)
> #define malloc malloc_simple
> #define realloc realloc_simple
> #define memalign memalign_simple
>
> Yes, _without_ that CONFIG option, the "real" malloc() functions do
> check that gd flag and if not set fall back to the _simple variants. But
> what I wrote is not merely "sort-of" correct.

OK I see what you mean, yes.

Regards,
Simon
