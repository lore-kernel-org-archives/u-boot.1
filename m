Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34281C71153
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A780E86CF2;
	Sun, 10 Sep 2023 21:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lqFD6T4Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E92C86AFD; Sun, 10 Sep 2023 21:14:39 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2610C86CF3
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d7b9c04591fso3120273276.3
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373275; x=1694978075; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oGDxYfNWAFS8r6CCpVSbBA8aEinbVX0nCYWZQG993do=;
 b=lqFD6T4ZXs3lSp6MGmKFs2rB1ZY6Rpuwna6Ov/CDDUyGM1W5E+yUAc+XJ1OEQTPmUW
 WZmx/32b+9jIiPc50cAR5if5xzGqQZrBulzdmhbQf/oMEXeMEcaqwMvPm59sE/IhZo4M
 dTcFUg3yHtkbVsQlq/llczw2tM2I9FgI8d5Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373275; x=1694978075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oGDxYfNWAFS8r6CCpVSbBA8aEinbVX0nCYWZQG993do=;
 b=jFgHQven7I9bZrjDBxEQhmeyEnuiXjOUzbgyQAYhWdghpKDKkh6IHT1LO7WA2s9Z72
 sunaVqOQlHPVZcDKBbzpze1DpUNvQCfHLaisBbjnmbm0FmAG7d/sUiddFwXqqQiN4E4X
 iyRS2TCfN968mDA0SV2ao1Pe7IiqTPRNn8jjzNIYSfY5Q1WjiS2gAWEoroNRoQNVpl8S
 0bnb9MrMneFfpgh5xYuCqbjF9oCcr5eG4Bl+7nyxv4n5jqhVqXWyWX2izYj2tz+0GBbL
 IJpQzlIw/vqBE5YsRfPFpx2SXq8ELIhpXQ0yqewa4jQra3zr3eXfhy4kaIyetBXGGL77
 N3xw==
X-Gm-Message-State: AOJu0YwHsDyOyOkxrkkv8t5iZZqwxkHAAtvUhVmDA8qsPOTJdhNKwjse
 vXeDZRDNjvV+zp4NKJu+fv848iSsHeEEBd68LedDjQ==
X-Google-Smtp-Source: AGHT+IEyKeqEr4EaknkWhHNwdeMWToUk9rosykaKHpM6VBjZ7mYmh+TjxU2BUUcNjpWjx3H0R0L1XcfMJrWOFNfvvkY=
X-Received: by 2002:a25:acde:0:b0:d7f:3f07:722d with SMTP id
 x30-20020a25acde000000b00d7f3f07722dmr7156827ybd.3.1694373274654; Sun, 10 Sep
 2023 12:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ11KEV4TAjihfijFNpXmROheGPKmVwVvpgfOpZP7GZ-HA@mail.gmail.com>
 <CADg8p97FOq4ropKF1xbMzBQb6O-QWpJCb5_zyq3Nyjhn4kBH6w@mail.gmail.com>
In-Reply-To: <CADg8p97FOq4ropKF1xbMzBQb6O-QWpJCb5_zyq3Nyjhn4kBH6w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 13:13:34 -0600
Message-ID: <CAPnjgZ2YJ292wMU9Yjom9TdSgHA-J2A5uHxhAZk-d3BsAsf5AQ@mail.gmail.com>
Subject: Re: UEFI update files missing on sandbox?
To: Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Sughosh,

On Sun, 10 Sept 2023 at 04:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Sun, 10 Sept 2023 at 04:10, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > I thought that all your patches were merged but now when I build
> > sandbox I don't see the capsule-update files generated. Is there
> > something missing?
>
> The building of the EFI capsules was moved to the corresponding test
> setup. This was based on feedback from Tom Rini [1], where he had
> suggested that instead of having the binman nodes for the capsules as
> part of the sandbox dtb, it should rather be highlighted in the
> document.

Hmmm that was not how I was hoping it would work.

Is there a way to make the build create the files?

...I just found efi_capsule_data()

I really don't like this at all...it is running a part of the build
system in the test. We have to do this in some cases, e.g. for tracing
we must run with a special build of sandbox, but it should not be
necessary for EFI capsules.

I would really like the sandbox build to produce the capsules needed
for tests, without any extra effort. As it is, there is no way to try
this out.

>
> -sughosh
>
> [1] - https://lists.denx.de/pipermail/u-boot/2023-August/526987.html

Regards,
Simon
