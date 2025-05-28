Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EBBC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E9AE83904;
	Wed, 28 May 2025 14:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IyePrwiP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 400988394F; Wed, 28 May 2025 14:33:15 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61AF1838E6
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-60497d07279so6389056a12.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435592; x=1749040392; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fVYlIs1k1Rnb+68WTHJYxf5BsDVc6LM9bDlYK5VY67o=;
 b=IyePrwiPVbl+Jpy1ECmqcJEfBUS6jiJ9Io97pgjet9kksBgVtyE31NPzN/q0iio3Fg
 cx/Cv5e76FMsq7t2O0Qp+6SOBp0YMb0XXBGupD6lOzUn1ljH1Swq1CPAn3+WvVO43Yka
 4g/QHLrkrKmr4ajbhNPT1/S6jtKgIVeD7xLho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435592; x=1749040392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fVYlIs1k1Rnb+68WTHJYxf5BsDVc6LM9bDlYK5VY67o=;
 b=Sg8w3QNmx5njDdWI88N/OdNqpxj10JFcXpOnTDeStO2ab3AmNA2jY2xsTXpl+W4tfn
 Ln/QhuoTg6+v9QxLznJczepN1Iu0fChPThRwf+e64Rd9BScBxfTejlipY+w1E6jjMHlO
 SR07VLsWNvSxECgT5E7qikKLLcDiiHpvdLgUUgQa55Ssz3Sk/k/bkjIc6OpRbENoJDa7
 Jq3MxtQOTPJaC/Qtv/tQqVmev1DOc+fQdQ/xwEUwBBngtsA1aOzcokIifOx2YHYjC+U6
 JAl3OCNmArX+ZyTEa0Xya+9ASxkSXcdt0D+wxT1NxTuK+9L8o4kWXR4H4w3xi/BT+OvY
 rq2g==
X-Gm-Message-State: AOJu0YyXB/X/n2HTD/o7cqnZ1vpAy4oZRG5CMUg9EhJ7I88+xD7ZWHZV
 0+/I/c59kfh3u5X0+OesK7J7LCJNhyOWgTabA2g4x0e7+v1VL+m1x4lXAyLi1511qbP5rPnpHud
 nTmgovxaEVb5mKea031/Mb+j6K7mVnW+zWWxB/Dpy
X-Gm-Gg: ASbGncsEI0DyKeJvzfgb2oScZHgiXhrlS9Uv42MZfxLkp16b8V0y8QxYVJWZ+9bZPvr
 7I8fZ6l0V/F2NjCDau0SH2LEigx4AIUBphcD0W++wH7NKvPRQpdwJUuXB0tdXGbru0GKrqrOFtc
 vwrH7b5c3QxF9FpiYs3DClFuGKDINNYDY=
X-Google-Smtp-Source: AGHT+IGcSv/BhXml54hZJHYvh38ywiJr+ZYxv+cTMrxJQSQl/N2htviyilN24Ds7epJ92yUFUTicN5gGe3ODRoO/PDo=
X-Received: by 2002:a05:6402:3490:b0:5fb:87a2:5ef9 with SMTP id
 4fb4d7f45d1cf-602da402b06mr12577451a12.23.1748435591768; Wed, 28 May 2025
 05:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThhKENznk_+7TpxjtSdcsHB=mosyS=ftqFMUbZAY7xuxQ@mail.gmail.com>
 <20250526144234.GV100073@bill-the-cat>
In-Reply-To: <20250526144234.GV100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 13:32:59 +0100
X-Gm-Features: AX0GCFujKSFQkk8gIse6zLzvgF2kGkKzBhkTEP5pwXA52qmP1CIBTUE7Lng5K8o
Message-ID: <CAFLszTjHMmz3-C=zx6xbVzQZDfMWsQB5PQGcrf5UmdE+KV5ksg@mail.gmail.com>
Subject: Re: Bloblist request
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Mon, 26 May 2025 at 15:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, May 25, 2025 at 09:43:14AM +0100, Simon Glass wrote:
>
> > Hi Tom,
> >
> > Bloblist is IMO a bit of a mess, with 2-3 maintainers who don't agree
> > on the direction.
> >
> > You have requested that I:
> > - implement a handoff protocol for x86 in the spec
> > - do the same in the code
> > - convert x86 boards to use OF_BLOBLIST
> > - remove BLOBLIST_FIXED
> >
> > I also want to enable VBE, which would require further work. I'm
> > sending a v4 today.
> >
> > I am willing to do the above, but to do so, I want to make bloblist a
> > first-class citizen, available on any arch, built into global_data,
> > with no reliance on weak functions.
> >
> > Please can you allow me to maintain bloblist?
>
> First, OK, yes, fine.

Thank you, I appreciate your flexibility on this. I'll prepare a v5
for that series.

>
> Second, for the record, I am compromising and "Saying Yes" to what you
> want to do, over what I think is a bad idea. We have had a mechanism to
> allow for saving off registers early so we can make use of them a little
> bit later as a "first class citizen" for 14 years come this July.
> Bloblist is not unique or new. What you want to do instead will come
> back to be a problem for some other valid use case later on and require
> some further architecture work at that time (or be an "ugly workaround"
> that we have to accept if we want that case to work).

I'm not sure if it would be helpful for me to respond to this now,
since I have already stated how I see things differently.

But perhaps we can take up this discussion again once my series is
applied and we can see the result?

Regards,
SImon
