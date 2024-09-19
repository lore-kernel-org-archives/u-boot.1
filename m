Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E27CF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F083D89228;
	Thu, 19 Sep 2024 16:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HuqkgNgj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCFBC891DD; Thu, 19 Sep 2024 16:12:10 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4D0589206
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2d8fa2ca5b1so797374a91.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755127; x=1727359927; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9McRdc3ycibwNax0yBHgpHqVxjnf1Cm8ia1n5I/tgII=;
 b=HuqkgNgjtTZ1h4CwlJIJ78wj5bpRGYcw3v5hUQ0d4+j32Jrku1iue8fcImtFSzgz7J
 qoLzkbV43J3oMVFVEpkCZBRPTtJkB+d3MlmNm3uLMSxoScK2cPm1TCo3KQM+KOKaqDHQ
 vSSNrAjkPFmtSny5IVDF8qrJ5xYMmG6VguO/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755127; x=1727359927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9McRdc3ycibwNax0yBHgpHqVxjnf1Cm8ia1n5I/tgII=;
 b=wdC9R5Bx6652JpdqjJq9+FYvgbuerJBVA7UJvcQfxnOJmpaf/CWKx4+RyO/hSO5PVF
 GKt6uH67v2dnLEfxTOIsROG3ziaEj2cB5VKKrk8zWjwZmJxgS4IxmTZt7wdJMldi04qb
 tsNRKOEC/2wgv040bM5RnBHPCyxWBcrzHQ93bf5LHAwhmj6XIafEKkBQ7vH3fJQv2Q9O
 qba7e2JWEP0CDUMw7nS5M1r6bIJaNv7EZe4fdXz7eB19N3+CSJgws7nU+qM6r1cbWKTU
 6qHH2jAmlQt0I6V8FYe3ehlQa9jCuSr+re7UN4maMlHmUgJB3vuQcy2xJs3hAHgAHJF6
 PhIw==
X-Gm-Message-State: AOJu0YzbUlrRiKtjykOLxLTK1zKPwFW01CLpV7OgioPpU0LWWswTKgDH
 K0XAp3bRh25ITBFNStVD2khzjBuEOpFjGmEf8tzGzBlynviNy+mTYsxKtAYT7CbcNJyWYRaWvuy
 DlXnTP8wgyDZJ0N3GTmaiBG9S1fQgNAGHO9K91m200uvd/pDLxXrdfOg=
X-Google-Smtp-Source: AGHT+IFM9dLueDmkixub73uxYMzbm6m1dt+Jgw7JwzJpuCU19+SponYclXwkgjONMyWHrZtWdE/v1pd/xf3HfEWWQk0=
X-Received: by 2002:a17:90b:1292:b0:2d3:bd6f:a31e with SMTP id
 98e67ed59e1d1-2dbb9f3a24cmr30089534a91.28.1726755127254; Thu, 19 Sep 2024
 07:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <CALeDE9Ptr0Ln4H24yMqxuw1+E_Wt5qBGdQabUH54PaYUTPf9Yg@mail.gmail.com>
 <CAFLszThK_t5EwL28vnzmSp5UZQrSEpBRsaXhnNudMQRe8-7Ejw@mail.gmail.com>
 <CALeDE9O-kmnqkosThf8xQpLZ2tEebiHvrUEzVJNDjiEff2-t2Q@mail.gmail.com>
 <CAFLszThD=Haj4M5rUYfpjPDjr9JEOPygQb9tV36frcAM5Ey9tw@mail.gmail.com>
 <c63147f4-d364-4568-8f6e-c0348914446a@linaro.org>
 <CAFLszTgzM-FT64AYTy6FXwUw3FQg-3MQ7x0TZc6xBhX5c+bXEg@mail.gmail.com>
 <20240829152052.GE2479150@bill-the-cat>
 <CAFLszTjqVsZ1owvpCaOer7U-k0ZvtDfLC9g+kFPW8gJJeQ1Ktw@mail.gmail.com>
 <20240830151327.GU2479150@bill-the-cat>
 <CAFLszTiMTRenX_g6jBr3snv5mC50gK2HwCHHgWVjQU-4Dwfiuw@mail.gmail.com>
 <20240903185356.GL2479150@bill-the-cat>
In-Reply-To: <20240903185356.GL2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:11:45 +0200
Message-ID: <CAFLszThWwEUU78vF44=jU0vybKrCnTKWbCq_mzWUZU_mOba7bw@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Tue, 3 Sept 2024 at 20:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Sep 01, 2024 at 02:09:47PM -0600, Simon Glass wrote:
>
> [snip]
> > > As an aside, please review the ti,am625 stuff with some TI folks, that's
> > > both far too specific (you're going to need to add different am62 and
> > > am64 and am69 and j7... and on and on cases) and I forget if there's
> > > some work to have a slightly easier way to know what file to use going
> > > on.
> >
> > Well, perhaps they can take it over and get everything working? I have
> > done the hard yards, e.g. supporting two builds together.
>
> While I'm still hopeful about getting TI to run our pytests in their
> lab, currently there's not much hope in getting them augment their
> kernelci lab (which I think does use labgrid not LAVA) to also do
> U-Boot, so no, I don't think they're likely to pick up and work on this
> part. Given that things are described for binman I thought you might be
> wanting to look harder at things there.

I only have that one board (Beagleplay) in my lab so I haven't looked
at anything else. If I end up getting a different board then I will
probably add that as well. But for now I have quite a lot of
outstanding patches and PRs so some things need to land, first.

Regards,
Simon
