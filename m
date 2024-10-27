Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B29D13569
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 14:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F95B88E78;
	Sun, 27 Oct 2024 15:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DUu4Osrj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64F498897F; Sun, 27 Oct 2024 15:53:20 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F1D08897F
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 15:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a99ebb390a5so841505866b.1
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730040790; x=1730645590; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nrDNY7dg+qBjlYKVBfcEYgoWKloYuNguJRe+u/Vk34o=;
 b=DUu4OsrjdXAb/nV+DRwqkMx3LjwVSRvpSRd1mWA43m8KEfiRRw6+fxNt0INoR2cM+w
 PxEN0/nc6v4kOz9Py52aHsHFdrHkgBs4cFmkqGoWC7E4IE/w1Tuj9o+gUx/qsKCvvUm5
 unc5Bv3QofKLdrsC13pK/IubTepPVhbLaDdt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730040790; x=1730645590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nrDNY7dg+qBjlYKVBfcEYgoWKloYuNguJRe+u/Vk34o=;
 b=W6AXay+LYc0FsBSH6S6MCUJ235r75H7U9jL5j8Z5krxXX1H9owCAHmevoiBhx+omaZ
 5gpiAGhSwhmVURuxZkd9C6qzng481Y4VYhx115Zaz5Z31uUf1tTsQS5Xf7Rolh/1Qb+V
 udI7e7eSXe1nQAQCpz9YprLL8T3JJXvjPvKwxsYQtcR+jvi71jxiX0OPJUoHBeBr1R5Y
 eW5WYV3Pq4C4yT7eDeHFYwBq1B5LvRbzRFLi2CABBKGlPD7h2QmNoh73NIMwC1a/8nLT
 Fqwwrf1e4qshwLT43G8MJiFOAiu2b9/X0X4YwAL/nkYAtVDqwfQb9FAHsg8Uk/+/e3oL
 FlQA==
X-Gm-Message-State: AOJu0YxMS0Th+gOEWrNfH2KFUF3rcy3lO46HKPwXxsFWP6l1/alP69lT
 qy3SVJDlojLg22dGqhcdqod4hY/I8DbEBL7yeFei7lfIdCqAce0EzzPtjx1sJrRfEBlsLaA0BR/
 DeMAKveF2OoVbekM+XjbeuOlVH5VtCAoMOJRV
X-Google-Smtp-Source: AGHT+IEvTYFpg+SLLC5T8NZ/uPugnXXth7uQGAS7MpPzt4UVCme6ZNes/F1zZyFEPAtLUcPhYlWuHMgo+M55ci2Y9T4=
X-Received: by 2002:a17:907:1c0f:b0:a99:f209:cea3 with SMTP id
 a640c23a62f3a-a9de35b0eddmr559941266b.11.1730040789890; Sun, 27 Oct 2024
 07:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241026120252.865215-1-sjg@chromium.org>
 <20241026223346.GI4959@bill-the-cat>
In-Reply-To: <20241026223346.GI4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Oct 2024 15:52:02 +0100
Message-ID: <CAFLszTg-Lr3uWu41YX1z=JTbBbiT8Gh2oydLHpq5dtyZbRUtKg@mail.gmail.com>
Subject: Re: [PATCH v2] sandbox: Add a build without CMDLINE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
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

On Sun, 27 Oct 2024 at 00:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Oct 26, 2024 at 02:02:49PM +0200, Simon Glass wrote:
>
> > Something this breaks, so add a build to keep it working. Since sandbox
> > enables a lot of options, it is a good board to use. The new config is
> > created simply by copying the existing sandbox and turning off CMDLINE
> >
> > Once we have tests for non-CMDLINE operation, this can be adjusted to
> > run those tests.
> >
> > Create a new build which will be picked up by CI. Update the maintainer
> > entry as well.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Create a new build instead of messing with CI
> >
> >  MAINTAINERS                         |   1 +
> >  configs/sandbox_nocmdline_defconfig | 365 ++++++++++++++++++++++++++++
> >  2 files changed, 366 insertions(+)
> >  create mode 100644 configs/sandbox_nocmdline_defconfig
>
> Please use the #include mechanism instead of a full config that will
> also now have to be kept in sync.

Hmmm we still haven't come up with a way to deal with the #include
mechanism in buildman. I've forgotten where it got to, or even what
the problem was?

Regards,
Simon
