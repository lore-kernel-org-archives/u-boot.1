Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757FAC36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 19:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2605982063;
	Wed,  2 Apr 2025 21:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RN6WXnMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0C088205A; Wed,  2 Apr 2025 21:22:54 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5401B81F44
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 21:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso19642666b.3
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 12:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743621772; x=1744226572; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pvmtak8AcYEiqqcKYPGHVpxZ/BVY2Gr5xublHlPJN20=;
 b=RN6WXnMfwUqejEP50RrJ1d6IJBU8m0ZfNu6mAoiZPy/3mvG9PzSAdwIGqOGY8a2Uzs
 bzCNMT0q4q5oHJj5Fw4H8ifH+V8eJhtUCC2MIyvT0bbIGIYq+YpUaja96nhqOtITPVN+
 euFDpedM/QmU+1vwMIhzbiZkB+WeoEhhCVDCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743621772; x=1744226572;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pvmtak8AcYEiqqcKYPGHVpxZ/BVY2Gr5xublHlPJN20=;
 b=rSFyfXVW2J/s+lZnuy/Jckb+Urb8GOj8z7L/2liabXM4vQ0+IssiSFX8Z2YHhBgJDK
 MHD9RKn+XRmdPAn0Rft5AUdlet3GGLkNSuUinTXxnRtDwUZl8TNCU/F98XA2pjYMurF/
 WyLFc4bXFXY+xXOHikdTsaopcgefMvjFgC04XCkLtnDbQNuG017bUQZdf0N7U5WV4Amv
 6ip+UT2FtyZ5fTUZvcPCzpR5TX6n7uXxbfeJ0t5hgBlj0p5k/qSvjiHZkJ2uMibCCgwv
 CW/GsXGp8KMLqScuIkwyn05FGDuoPd9jT76OEBxbK1sjiehl/IAUoGe80i+t2ozenOxr
 CPtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXMulekPs3qtvA92O0xoQw34t+X2KUQDQIBrBTCzcAOwnUZCdiLYC9xXKScZIOVz+5sinUjA4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1r/clCJ5xbZ0Chc8k4TeD+S4Oompc7XWwA2Or/NIbiRV1oVWa
 qWWWrK0LP1p34rWEo0jxXK+ZBr34TPQz8yfxLkUmkM/bk8Et0Uaq36lSDjDgAE5DH0NIoHTHHi8
 ogMH+rLENieleFKZp74FNZvE+jxPlUIpDpIfNxqnTy72u0FvZtA==
X-Gm-Gg: ASbGncvge6/C8FUvuMgWl6NlZDhJNcPZqeV4OKVsp2rEIe0pHj8c4RaBDT0R/0muKQl
 ENev3/8JlNXreSTlCPB5JLzlfsnHGRpdbOPxDuUtujPQPcMNBhV0+hbrTeTx77YKSYO9h2H7N5X
 oiSYU4uNujcQN0mYK33vipS1ruL7g+
X-Google-Smtp-Source: AGHT+IFsVYO+Ye6TPKAnCp+8X8MAGHkE+psy3EOj2G74sLCEsqiNnCjapDaJkgh0cQQSLm2rEfIhrFDdzZCfcKySsRs=
X-Received: by 2002:a17:907:6e88:b0:ac4:5f1:a129 with SMTP id
 a640c23a62f3a-ac7a16c1307mr290043966b.15.1743621771491; Wed, 02 Apr 2025
 12:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
 <84e047e7-f90e-4435-8f3d-132d970749ac@linaro.org>
 <CAFLszThN_0aRhtTRmEGmjyiekz1XtzZdH1qq0oLSyYcO5yKobA@mail.gmail.com>
 <CAC_iWjLHPLeX2DhnVqS3QtjhyPVd-Hkuqr0vF_dCXmBQApwvng@mail.gmail.com>
 <CAFLszThH3a7pLJG+zppu2qr5RwXAOk9Sj+S+RAT0B758hzOsyQ@mail.gmail.com>
 <9869b70e-0fec-4682-8ba0-c679df9c4603@linaro.org>
In-Reply-To: <9869b70e-0fec-4682-8ba0-c679df9c4603@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Apr 2025 08:22:37 +1300
X-Gm-Features: AQ5f1Jo2wGjjRXhAeGe6uFM-t0DSgJqhnVMy6FD5tgwAAhfAZnhJSIqr_6s04z4
Message-ID: <CAFLszTiAUh3O_8i1-zF2V4p2AW+0kmZsz2ft5phPcE0LzhQu4w@mail.gmail.com>
Subject: Re: [PATCH 00/12] lwIP sandbox tests
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Jerome,

On Wed, 2 Apr 2025 at 20:48, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Simon,
>
> On 4/1/25 19:55, Simon Glass wrote:
> > Hi Ilias,
> >
> > On Wed, 2 Apr 2025 at 05:33, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Simon
> >>
> >> On Tue, 1 Apr 2025 at 18:42, Simon Glass <sjg@chromium.org> wrote:
> >>>
> >>> Hi Jerome,
> >>>
> >>> On Tue, 1 Apr 2025 at 03:14, Jerome Forissier
> >>> <jerome.forissier@linaro.org> wrote:
> >>>>
> >>>> Hi Simon,
> >>>>
> >>>> Any feedback on this series?
> >>>>
> >>>> https://patchwork.ozlabs.org/project/uboot/list/?series=448553
> >>>
> >>> No, not from me, but thanks for doing it!
> >>
> >> Aren't you maintaining the sandbox drivers?
> >
> > Yes, I'm listed as maintainer for lots of things. What sort of
> > feedback are you looking for?
>
> Well, you were pretty explicit that those tests were important to
> you ([1], [2] and especially [3]), so I was expecting some kind of
> review/ack on your part. The series is currently assigned to me in
> patchwork and I got zero comments, so I'm not sure what to do with
> it. Unless someone objects I will probably add it to my next PR to
> Tom for -next.

OK, good. Yes you can add my review tag to the series:

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks again for doing this.

>
> [1] https://lists.denx.de/pipermail/u-boot/2025-February/581988.html
> [2] https://lists.denx.de/pipermail/u-boot/2025-March/582435.html
> [3] https://lists.denx.de/pipermail/u-boot/2025-March/583362.html

Regards,
Simon
