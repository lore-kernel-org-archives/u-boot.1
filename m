Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF18D2CE14
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 18:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8EBD88F2A;
	Tue, 22 Oct 2024 20:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iqrkimD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C01E88ECB; Tue, 22 Oct 2024 20:13:54 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9251688F4B
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 20:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a99e3b3a411so17747566b.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 11:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729620832; x=1730225632; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oLTOyUpwAPo+j8HdVsUdKm57HwxiZ7EEi4EwIjFDm1w=;
 b=iqrkimD6quhuj+JZl8BbX0UU83T8ktPxP340PUQ7TlKeHst58RBPrb2XuIbczPGabi
 z9MmDqH4m1TlPT3Szt9oVnQ8QerCUpTuGkbrAD32b1qclhFjfq3RRPGRAH7TixefnBK/
 j/WyIQdwxZWgYceVTse+6A08a04+a20s1oQB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729620832; x=1730225632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oLTOyUpwAPo+j8HdVsUdKm57HwxiZ7EEi4EwIjFDm1w=;
 b=j5WmKlk+BL42ff00aJt0W5wWgAZ/QYXr6M0lVkzBFn3N9QUs1mJNP+rc7wU0etJ7bx
 MPLkKXqpSrMNATtFZl4VWVBk6bhnQnFEcYIKJ6gw9zWN+QkdZwkuUxytxssdDs+B4RyN
 iBf/G+pRjBu5eekOUJ/bgt1wRx3/ErmmY2hV+h0BVnEUWcvSSBRHghfUTLjBgXq4o0FU
 V5ywCerv4pqx8ou1jgodey1GdmfiutSCcnK14ylNNlEtaHqbE7z8SiPm/tAiY+vI3+tG
 zZyirpDyNlbmnBmW4n0WZSr1pM688UeHBtb5zAvbwclA+pO/UT5e8eOY4n/EYeR/67Gb
 Z/jQ==
X-Gm-Message-State: AOJu0YwbW1HxKhQGaimtUOrNlXrcBuhZF37flfRXzB9UHhTpbphaz7IS
 t5IsbZD/jICaJvFeaO8RQqnCZxpdziePvIiP5TB0MfJXcj75bU64T6BHAPTKQgTLRp6Ok04mU2I
 QbaAJkv40JpkONqfNPSzFZnSK6H4ZRoCRiQRT
X-Google-Smtp-Source: AGHT+IFRfkfcRdh9rsqiI5sjALgfPl21VG9FGU97WFFEvOMU3+XqkWNFzgNmLI9q+2zrdldlQ7nbItR9AaP0Tb2t1fY=
X-Received: by 2002:a17:907:6ea9:b0:a99:ff33:9ba5 with SMTP id
 a640c23a62f3a-a9aaa6218f7mr426650866b.24.1729620831998; Tue, 22 Oct 2024
 11:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <ZxZk4K4ff1T3gUVm@smile.fi.intel.com>
 <CAFLszTjuodDFZW8fJDL1Q3nByLVzcTTEAeJfws-sbtupCwNd8w@mail.gmail.com>
 <ZxenO05qCbt5IIZS@smile.fi.intel.com>
In-Reply-To: <ZxenO05qCbt5IIZS@smile.fi.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 20:13:40 +0200
Message-ID: <CAFLszTj4pot8tCjesT9-cHewTUMogKMdGj+pSQDHXsnFV3rwUQ@mail.gmail.com>
Subject: Re: enabling W=1 by default
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
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

Hi Andy,

On Tue, 22 Oct 2024 at 15:23, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Oct 21, 2024 at 06:32:21PM +0200, Simon Glass wrote:
> > On Mon, 21 Oct 2024 at 16:27, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > looking at the redness of the output of `make W=1` here is the question:
> > > isn't it a good time to enable `make W=1` by default. Yes, I understand
> > > the impact, but at least we can do it mandatory for a _new_ code submitted to
> > > U-Boot, right?
> > >
> > > Ideally I would have what Linux kernel has for a few releases already, i.e.
> > > Werror by default and getting close to make a clean builds with that and
> > > make W=1` at least against default configurations (yeah, with U-Boot there is
> > > probably no default, but sandbox one).
> >
> > Warnings should be warnings...
>
> Yes, and ideally the code should not have warnings, right?
>
> Otherwise how can we do better? It's quite similar to what you wrote WRT
> documenting the function prototypes, the same applies to the new contribution
> WRT `make W=1`.
>
> > if you would like to enable it for CI that is fine by me,
>
> Yes, that's the idea, but I'm not the owner of any U-Boot CIs,
> hence it's a proposal.

You can still do a patch...but I see we already use 'buildman -E' in
CI, so perhaps it is already working?

>
> > but the U-Boot makefile shouldn't do it. It defeats the purpose of
> > having a distinction between errors and warnings.
>
> While it's not what I wanted, I disagree on your comment. The idea is to make
> rules stricter (for new code) to make it better and that's why Linus enabled
> Werror by default in the Linux kernel. And personally I consider that as a good
> thing to follow.

I'll note that coreboot enabled this and it is a right pain. Since
coreboot always produces copious amounts of pointless output, there is
then a warning hidden somewhere in the middle and the build then fails
inexplicably. At least with U-Boot we can use -s and only get messages
which require user action.

But anyway, so long as we have this enabled in CI, we are not
introducing new warnings. But another point is that we tend to get
more warnings when moving to a newer toolchain...and devicetree has
tons of warnings now.

Regards,
Simon
