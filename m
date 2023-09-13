Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C3BEE01FE
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 18:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED8A86A24;
	Wed, 13 Sep 2023 20:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j4o5jrgk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70DAC86A4C; Wed, 13 Sep 2023 20:07:34 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D208186A1D
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 20:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so58087f8f.0
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694628451; x=1695233251; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nymUw1ZDfcCbfR5nP9Zb3NHcjZLahSZR+IVirRUvIts=;
 b=j4o5jrgkiBmwXjb3bl/QJ+Iq2ZvhBI0Rl4c8NjX+PVWafwxMxG3rPgwkWa0nqrSs1R
 WxZDuUZFuUPIJZvwBpgDjN/SXIumuflWRoD8GTO3SSnIaKjUfeGs3F1QROuxOV+VgAGA
 vWUnzo/4LsdPgRJP9KDrGALwdHLCmvTXxHWr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694628451; x=1695233251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nymUw1ZDfcCbfR5nP9Zb3NHcjZLahSZR+IVirRUvIts=;
 b=M71bS0gHLi5B1exLqXac4zMTtzfy5D0T4uUC/weHirPoP6io/pvmfVf+Ps350nsLAL
 VCikq4di9l2li/4J3iTQL7CxVuo4FheDJDbEHLmLZ/JQHbqsKn/Nv0MbYfeiWnegK3BU
 7ecNaqWnXtZaNpsQSEFEcLh/55pnNw+U31BEhdjFEI5r8s+xwf8yngWIrLE5ycYl4Hw7
 fvgPrR/OVnwjoPqa29uph6ZqVZRLH3sCfpzN1VTS/Fi75oXZg5Ez4L7UbKxT6CIjC9fw
 kxWaPsIesVPlemzVz1B1LZYIOm86ucIOdI1aYnLrYhG83MHoZQ5vRY1Qi1DD1S4eIQ+w
 cGhA==
X-Gm-Message-State: AOJu0YxK63QIvY0zHj4Hr5YXIUSNU4DeXOBF2B6NfV2ZJXYvylJu/MK7
 Crju+8/sVWk8CjuLE1H2eXuhk3X0YwfnOLywFyc3LwIcNMRLEfmEd0o=
X-Google-Smtp-Source: AGHT+IGtmokhZOOWmm2klHEZH7Izg+gBbMFcSyi6pRqHQfmyC2hQjRZJI7vkoPXZ3pzscQTHUDaPu6EUc/j7VzufGJw=
X-Received: by 2002:a05:6000:1110:b0:319:79bb:980c with SMTP id
 z16-20020a056000111000b0031979bb980cmr2792287wrw.64.1694628451030; Wed, 13
 Sep 2023 11:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ11KEV4TAjihfijFNpXmROheGPKmVwVvpgfOpZP7GZ-HA@mail.gmail.com>
 <CADg8p97FOq4ropKF1xbMzBQb6O-QWpJCb5_zyq3Nyjhn4kBH6w@mail.gmail.com>
 <CAPnjgZ2YJ292wMU9Yjom9TdSgHA-J2A5uHxhAZk-d3BsAsf5AQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ2YJ292wMU9Yjom9TdSgHA-J2A5uHxhAZk-d3BsAsf5AQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Sep 2023 12:07:13 -0600
Message-ID: <CAPnjgZ381_UXw5kE4V3v=Tzjt1Co5o0mNcsJfjQSc6xsxqdVvA@mail.gmail.com>
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

On Sun, 10 Sept 2023 at 13:13, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Sun, 10 Sept 2023 at 04:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > hi Simon,
> >
> > On Sun, 10 Sept 2023 at 04:10, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > I thought that all your patches were merged but now when I build
> > > sandbox I don't see the capsule-update files generated. Is there
> > > something missing?
> >
> > The building of the EFI capsules was moved to the corresponding test
> > setup. This was based on feedback from Tom Rini [1], where he had
> > suggested that instead of having the binman nodes for the capsules as
> > part of the sandbox dtb, it should rather be highlighted in the
> > document.
>
> Hmmm that was not how I was hoping it would work.
>
> Is there a way to make the build create the files?
>
> ...I just found efi_capsule_data()
>
> I really don't like this at all...it is running a part of the build
> system in the test. We have to do this in some cases, e.g. for tracing
> we must run with a special build of sandbox, but it should not be
> necessary for EFI capsules.
>
> I would really like the sandbox build to produce the capsules needed
> for tests, without any extra effort. As it is, there is no way to try
> this out.

How about we add a single capsule update to the sandbox build, so that
it produces an update file containing U-Boot? Is that easy to do?

Regards,
Simon
