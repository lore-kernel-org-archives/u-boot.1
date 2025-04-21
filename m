Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147A4C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 22:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 625B580FF7;
	Tue, 22 Apr 2025 00:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KZaPojfg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C6F581026; Tue, 22 Apr 2025 00:53:07 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CC8580AE1
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 00:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e5e8274a74so6599512a12.1
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 15:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745275983; x=1745880783; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DcNqDg0jFrPsqXEl/qGfYILzFTkR6QMc8G45hgXPtP8=;
 b=KZaPojfgeLfD7kerXTfbVTNQy8TAxmj8x+XALTjhHhDb2VaD/dKaMSJeg88+31ibxD
 Yss2Q/ARwPUAHgawxk9wE+OpgrRXVR8RxAoyQ+P/cNpUuYWZw/xfERvIPi0NAx/VNsxV
 Kk+RQVcmMyIteuT6AfE3yy9t8ESsFFZ3F7rQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745275983; x=1745880783;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DcNqDg0jFrPsqXEl/qGfYILzFTkR6QMc8G45hgXPtP8=;
 b=Z4SWDD4ZzMcQ8ExT8pt79pGudENxgL22zVP4+TyYp92N+V56gYqhQhoEulfR+bved+
 AAu84rJyzgB800BnXzo5WvJSzoFfR0zNoZvDJIB+wXoqMnvtq93fOTHFKg0gvKeNrQcc
 kqy6xGYsMUgqcyLmi8j81Sipe4UMOmOKfPnbPHCER9pcMhagt7tDBlG8rkGngKk/okBB
 0mav8xkt0cV4xaFYWSo7MvJ9KAiyiQ1qK0r1rgsRkUlGDQ7/k2qMz1sGh6vYOGdvY5K0
 LbwD2qqL5oIS8CA+XcOA7XVXpiaAAiMev55ipSEoryU6g6baG25k5qlgU7OziE9f+7a7
 USqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkhbIgRIeHyKQG8IUv/VS1/3sT1DyQgijK91937tP/6csgqmPkPKLcbuO60PLO6BBmxweBqPw=@lists.denx.de
X-Gm-Message-State: AOJu0YxttcixhQ1WhIdacLB6wM/V1AdvA2cMdop08Pf1BjztYuuWPyiX
 sBEMzwDUlSMldv7Mkp0e9TWMbxd9CmGVQ8p/I38kN9yUwhztGL4of6iPNTZeJBGtqhvQFTTu7dN
 yeidrNegZRSwai46knzqJB0mvgivFu4gXRhR4
X-Gm-Gg: ASbGnctwN4/Dym0kJch1HlRPicLvLoYoyDI+no5lNEq3rETAAF0oOFfmv2PSsxNc85P
 fD5zfw4gtL14vdZZSYnXhoCm03NA435MosvTjr2gYfhV37RVcS47Cx31j3J7Lfq/JOvZEJXp5w4
 xppTAnqXaLoJk1H+S9uQR3aFw=
X-Google-Smtp-Source: AGHT+IHSc2r/oWvDimHlAqWvjrAeSzjGVTswXTKKlTEAcsfhyxrMRq/30b/AgCzsO9K/a95owEb2rKyolvdx/mnm5M0=
X-Received: by 2002:a17:907:3d91:b0:ac1:e6bd:a568 with SMTP id
 a640c23a62f3a-acb74dd4e3emr986739966b.37.1745275982676; Mon, 21 Apr 2025
 15:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250101195817.995321-1-sjg@chromium.org>
 <CAFLszTj_JvCRNQw716CGD=i+eJm1YMb=WjOqpF0VFFiac3GmCg@mail.gmail.com>
 <20250417160423.GX5495@bill-the-cat>
 <CAFLszTgWUNP6L6ZML639wz76CuuBoPDt447vjfz8MRZyLE5gFw@mail.gmail.com>
 <20250417163326.GZ5495@bill-the-cat>
 <5b0876bbed279e41a741fdcaf6091694@sfconservancy.org>
In-Reply-To: <5b0876bbed279e41a741fdcaf6091694@sfconservancy.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Apr 2025 16:52:50 -0600
X-Gm-Features: ATxdqUH0zusBicv--QbllHjE6sU2Zf06xi330b6_CqA_uAjZWjZySQrlaQDLnTs
Message-ID: <CAFLszTjq5-6CZarV=mTmNae9dWAzcCMFQDJSAzkc=xu8ng7KVQ@mail.gmail.com>
Subject: Re: [PATCH] bloblist: Drop BSD license
To: "Karen M. Sandler" <karen@sfconservancy.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Denver Gingerich <denver@sfconservancy.org>, Bkuhn <bkuhn@sfconservancy.org>
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

Hi,

Just to note that I won't be attending tomorrow, but can attend next week.

Regards,
Simon

On Thu, 17 Apr 2025 at 10:45, Karen M. Sandler <karen@sfconservancy.org> wrote:
>
> On 2025-04-17 12:33, Tom Rini wrote:
> > On Thu, Apr 17, 2025 at 10:26:53AM -0600, Simon Glass wrote:
> >> Hi Tom,
> >>
> >> On Thu, 17 Apr 2025 at 10:04, Tom Rini <trini@konsulko.com> wrote:
> >> >
> >> > On Thu, Apr 17, 2025 at 09:58:42AM -0600, Simon Glass wrote:
> >> > > On Wed, 1 Jan 2025 at 12:58, Simon Glass <sjg@chromium.org> wrote:
> >> > > >
> >> > > > Linaro has decided to write their own version of bloblist from scratch,
> >> > > > so there is no point in having a non-GPL license on this file. Change
> >> > > > it, to better fit with the U-Boot project.
> >> > > >
> >> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >> > > > Link: https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22215
> >> > > >
> >> > > > ---
> >> > > >
> >> > > >  common/bloblist.c  | 2 +-
> >> > > >  include/bloblist.h | 2 +-
> >> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> >> > >
> >> > > Applied to sjg/master, thanks!
> >> > >
> >> > > (Tom, this one seemed to get dropped but I'm not sure why)
> >> >
> >> > Because AFAICT you legally cannot unilaterally change the license as
> >> > others have changed the code.
> >>
> >> OK, let's put this on the list of things to discuss.
> >
> > Sure. And I know I'm behind on getting process going with Conservancy
> > but Karen can you or someone else please be on the call next Tuesday
> > (22nd, same time/dial in as before)? For background
> > https://lore.kernel.org/u-boot/20250101195817.995321-1-sjg@chromium.org/
> > is hopefully enough but I'm sure Simon and myself would be happy to
> > point at any other links that might help. Thanks!
>
>
> Sure, at least one of us will attend.
>
> karen
