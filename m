Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256A7C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 03:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F5598083E;
	Thu, 20 Mar 2025 04:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gxvju/HU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D70F80FF0; Thu, 20 Mar 2025 04:41:49 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3F89803CC
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 04:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5dc89df7eccso602094a12.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 20:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742442106; x=1743046906; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u9F736zT/d9VCrYiXEA10ZRXYur9oeqcnLrZLNzx+WU=;
 b=Gxvju/HUcCd1qJcIoAgkJzG6XPdHYj7o+QJMBNJ/S53luvaEl5NznpJ/epQ00Qbnp5
 YqA8qeE+tHSN2pWq/c/0dsdndWR/jzN3QmTIFfk348m7mmkrCPXvZBjGEqHflKJ598uS
 jOOiN7xal/7TBI6v75L8ZiRRXmTTOBPc+hqhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742442106; x=1743046906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u9F736zT/d9VCrYiXEA10ZRXYur9oeqcnLrZLNzx+WU=;
 b=sncYdUOMBCtJvPEJAyIG7CnzbiUJuofujsybznnm8d8vImABY2BkCMeGiMvtDmSb7w
 5lEK6EvoSc/pjSf5TOeLagD5fHPSjwpE6278Mz0/j+cpHImOQyF8EXU9zpaH4QtYQq+w
 4/y4GkrYweCI6vQBAoV29mZdAqippeqwakXmqfG5tZ2+AaR9KWKb1giUniywWlAEpV0f
 ODTEd+bEtozOmBUhG7w/EP78pE19UU0n2/lKcgRvnLiZl5cbRe+toUr0+8u5PgfTJPol
 TZ/J+G+SEBHHOrTzS14I5rX40oFbLyLLSAve/bfSrYksYNEOPYnhNNiJQL+/PULB1xtz
 jDHQ==
X-Gm-Message-State: AOJu0YxtgMkvnuB/D3tmt9RJiSlob5uRxYGt6KfUEFXZebNlYnGzbeAX
 ua/1YTJ1zhzzYGrRvr4tFN3Rp/ct7SMtxRZP1djDkP6E30WNf/NK66jgSw8uqL/vfpxL5ULUgGc
 6yicXRxufmOg6R+RAAe54Dhc8dM1TYGIa55Uz
X-Gm-Gg: ASbGnctxrNEgWbMqVXlre80u+FqIhU7KqvjeZyTXZ0ng43aH3a7NBqWIm3RRe9RXnsZ
 IcYs/+YkccNJ8bItjxhHUunUTRtbaGQLpxEGgMUFzK9ckRC+ETXXpSH8muKSafvP1DsBjobVSTy
 y+sXtucj8uWeUn32sFHVk7p24ZTpknrj0IpjFUtQ==
X-Google-Smtp-Source: AGHT+IH++t/Ni6/l10Eu4Q/GiBB+gUAPS74BTvH8JfbLIyjscHlhG6NOPetjC/EL0VUHWftwqSm9OAcPcrZ0JLu1qUw=
X-Received: by 2002:a05:6402:2789:b0:5e4:d2c9:455c with SMTP id
 4fb4d7f45d1cf-5eb80d16e56mr4325029a12.10.1742442106237; Wed, 19 Mar 2025
 20:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250319143820.2385092-10-sjg@chromium.org>
 <20250319145218.GG2640854@bill-the-cat>
 <CAFLszTiRm3YEQqU1w75uFp5gFZ1HiPv41vNX7VFy8XS80udVRw@mail.gmail.com>
 <20250319153510.GJ2640854@bill-the-cat>
In-Reply-To: <20250319153510.GJ2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Mar 2025 03:41:33 +0000
X-Gm-Features: AQ5f1Jqkmc6x8NxhWgEeSQqs4v2hCj8h_MWc0axNbhADvvhNR1wNik-cUqea6RI
Message-ID: <CAFLszTg8a7CCiyyVVQdHDHNJ3MEP-Zxbbao_riy+iTzDt2u-KA@mail.gmail.com>
Subject: Re: [PATCH 09/17] test/py: Add a test image for Ubuntu
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Julius Lehmann <lehmanju@devpi.de>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Wed, 19 Mar 2025 at 16:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 19, 2025 at 03:04:28PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 19 Mar 2025 at 15:52, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Mar 19, 2025 at 03:38:03PM +0100, Simon Glass wrote:
> > >
> > > > Add an extlinux image that contains a few Ubuntu entries.
> > > >
> > > > Increase the number of sandbox-USB-hub ports to permit this.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > I don't understand what this test adds. In neither the current Fedora
> > > test nor in this new test are we actually booting something, we're just
> > > taking a sample extlinux.conf and making sure it doesn't fail. Is it
> > > that we're testing in a useful fashion now having two labels?
> >
> > I didn't think so either, which is why I never did this before. But it
> > turns out that there were some bugs, too.
>
> I don't understand you, sorry. You don't think so either to what?

I didn't think we needed two extlinux examples on different boot
devices, but we do.

>
> > > We should probably be clear about what we're doing in the tests and
> > > instead of adding seemingly arbitrary distributions add an extlinux test
> > > and testcases.
> >
> > This is not actually a test case. It is simply creating a new image.
> > The test cases are in the other patches, so please take a look there.
>
> Nothing in this series quickly reads as adding tests and fixing problems
> with extlinux parsing, it's all bootmeth stuff?

It isn't about the actual parsing of the .conf file, although I would
like to add tests there as we have none apart from what I have added
in my PXE series. It's more about having multiple devices with
bootable OSes on them. This series tidies up and fixes this. We need
to have an image available on more than one device to spot these
problems.

Currently we have two accessible to sandbox, one extlinux and one
EFI*. I decided to add a third, using extlinux.

Again, this is not a test case, but provides an image for the test
cases in this series.

Regards,
Simon

* The boot_efi() test in your tree is only a subset of the full test,
as you know
