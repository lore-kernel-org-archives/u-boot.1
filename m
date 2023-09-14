Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3DEEDE9A8
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 11:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4018D864C1;
	Thu, 14 Sep 2023 13:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kAZo7VdN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7F4D86ECF; Thu, 14 Sep 2023 13:32:49 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1978A8664A
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 13:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-529fb04a234so963792a12.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694691167; x=1695295967; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BvfhpEnd9HUg1VhchGK+0sNDZ6+/6OFLKs1kHi5BgB0=;
 b=kAZo7VdNR5eUHW18cW6LPBJbXq3o6QDb3zeNBUiDnFnQntoKVuVoYh/gmIsNHsR37N
 QW0Gr6km2OEyZYoFYG4K6UFpBj03lUi23fn3zIpwuF3pcbCLTRWdwEjx+I+cF39vWGjB
 IKdTeMttE6YDxYnnxyf+ciN/G5VUpKeZSiW2rQafSuRMHPvUBDCwqIGzoQfIM5yx0OSb
 bl/2f0H1oNgDv9mlP/kdvl0Faj0hto4Vj9qOLQq1uq8TbcOZP6kOh1twdl+EUGonkW8N
 B2tRcVk5A3C389oUjUAbgh1b2QxnE25QbHrC+g9LjpKBsXtgqGe0uHAzMEaqfQvid/Wy
 TiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694691167; x=1695295967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BvfhpEnd9HUg1VhchGK+0sNDZ6+/6OFLKs1kHi5BgB0=;
 b=HWXzeE35jyyzQRIjKjEC8szbQB0OOS11o+rvY/jWcylQkk/NwvTR9O6dVwJm64iap4
 Q5/QuEouqPzkMg1+DlmyePdCbVFcbl+/nU7tTJ6Y0ryWrPRAizp4f+XgNlHDw3tO/Q6T
 +gI/mEpJjjwsmdHiPlbhfAECHGtt/xIcZoLBGzXrILAKG9wH5QXcst1lz/nbFvoVdHKn
 T0rm/QrXAHF6YomEDh7WClWUvPsOPf1bINH3ijjFrBbqqaPuna5WLF/yrmoYrwUQ75nu
 vmE9DP5eH5R8Ar0+R85VDWDiJ9mJBP+LhGwnzKoLaeqLX9pqdoJfXM5zb8ow8kyk+z7z
 rsjw==
X-Gm-Message-State: AOJu0Yz1VZNpcd8nBLXq3vUKTCw5CtdTrr0sk49h1b9AebwhowxGgsgy
 HkQo6MBH2870MmK6CUrtHfyDQRGTDvKlrDYAapJLJfW480xeX/iu
X-Google-Smtp-Source: AGHT+IFzCuHK1bj4V3MxNTgWNzzZQhs9Dqh4jbxy7nKQXw9c1tOl16Pmni/LqLW4/ZsM6uORqW3blaPzpysmMPaklRs=
X-Received: by 2002:aa7:c606:0:b0:52a:1c3c:2ecc with SMTP id
 h6-20020aa7c606000000b0052a1c3c2eccmr4858010edq.25.1694691167516; Thu, 14 Sep
 2023 04:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ11KEV4TAjihfijFNpXmROheGPKmVwVvpgfOpZP7GZ-HA@mail.gmail.com>
 <CADg8p97FOq4ropKF1xbMzBQb6O-QWpJCb5_zyq3Nyjhn4kBH6w@mail.gmail.com>
 <CAPnjgZ2YJ292wMU9Yjom9TdSgHA-J2A5uHxhAZk-d3BsAsf5AQ@mail.gmail.com>
 <CAPnjgZ381_UXw5kE4V3v=Tzjt1Co5o0mNcsJfjQSc6xsxqdVvA@mail.gmail.com>
In-Reply-To: <CAPnjgZ381_UXw5kE4V3v=Tzjt1Co5o0mNcsJfjQSc6xsxqdVvA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 14 Sep 2023 17:02:36 +0530
Message-ID: <CADg8p96j8EsxAEDZwYMh88Vi-GXk8CvnOn_uTypYNJRcJwGv2A@mail.gmail.com>
Subject: Re: UEFI update files missing on sandbox?
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rin <trini@konsulko.com>
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

hi Simon,

On Wed, 13 Sept 2023 at 23:37, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Sun, 10 Sept 2023 at 13:13, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Sun, 10 Sept 2023 at 04:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > hi Simon,
> > >
> > > On Sun, 10 Sept 2023 at 04:10, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > I thought that all your patches were merged but now when I build
> > > > sandbox I don't see the capsule-update files generated. Is there
> > > > something missing?
> > >
> > > The building of the EFI capsules was moved to the corresponding test
> > > setup. This was based on feedback from Tom Rini [1], where he had
> > > suggested that instead of having the binman nodes for the capsules as
> > > part of the sandbox dtb, it should rather be highlighted in the
> > > document.
> >
> > Hmmm that was not how I was hoping it would work.
> >
> > Is there a way to make the build create the files?
> >
> > ...I just found efi_capsule_data()
> >
> > I really don't like this at all...it is running a part of the build
> > system in the test. We have to do this in some cases, e.g. for tracing
> > we must run with a special build of sandbox, but it should not be
> > necessary for EFI capsules.
> >
> > I would really like the sandbox build to produce the capsules needed
> > for tests, without any extra effort. As it is, there is no way to try
> > this out.
>
> How about we add a single capsule update to the sandbox build, so that
> it produces an update file containing U-Boot? Is that easy to do?

Not a difficult thing at all. But is Tom okay with this? I moved the
capsule generation to the tests based on his feedback. So I would like
to hear what he has to say on this. I don't want to keep doing this
again and again.

-sughosh
