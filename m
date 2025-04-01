Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE3DC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DDC681703;
	Tue,  1 Apr 2025 19:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QPZRSxXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF61A81F0D; Tue,  1 Apr 2025 19:55:17 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0B981703
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac41514a734so978110866b.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743530115; x=1744134915; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IosuPiF0IZomvbSE771O3Kzqq6UvHkM3Ok8U8q+OLnc=;
 b=QPZRSxXYzLPR85zK3Cyptwczb7XWlaPwj5lIFv8jTx9pzTBmOMgmWTJsXPv8QIrvAy
 PSPQLCSt5pTA/IxuMvcXqax4+efPO5BgylbNmcP7NR/bPsnG0mTW9xLYah7hYgK0SaDo
 mOQz1RQy0BuzFypCcnAUzCpYliP2ScAcZRWyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743530115; x=1744134915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IosuPiF0IZomvbSE771O3Kzqq6UvHkM3Ok8U8q+OLnc=;
 b=IJsIljauYowamOgWjFmKfHL4uo7DKtjSXA5GFXi+2XJfHbhDJJ/36aJhPeKVh7wXSl
 eTR03ByUo3pub8ENOGYsKJz8k0XA8GAaJUU8qiC4mFNOkjM8z8Aq1OqRSgndpa+WHhl+
 hMiBv8HfTXdCQoPwRiPD+FDatAa1WQlsuHNLrRJgOQrFCQDXsT5SaJuF4jdxpEEkDqtG
 pM5EhhskUy0Ua+7ZSXr5ijR5TksOIFIKLaQ7LXsJU3N/Ybz67892G7X+hp3We/kBgvBK
 PRFp08Jlt05ffeM0eoE/HmvwKKcEahhcEuVVtN21ku4Bd3O77qSzWqVe5ounWMGc1hyn
 Kilg==
X-Gm-Message-State: AOJu0YxfB4WhymSzvuDpLw6QljYpwC7OE1vXxTd78zVxSx/bxdWQVrwg
 kmvTfwSqiVOCFt2j4H21YEtPzGu8/Gb+qCuVfaEwy5g2Bj1gSonRYVoP551S8rs7TjCQ6ZjmKww
 PdesDGMEnfvOdLXGwzqn5glQBXB8yFzNUwyfS
X-Gm-Gg: ASbGncsNgAreKv8oTPtdBZlraNg3vtm08SNynSoi7LWqDnR9tmGUHw7/GH2hXGp7vdC
 /4DxmWPyBLapTinvhrkn+TSVEoxGwDmYyAEFn6u7svXXJ5iEkOgCGEWHf6Mw2LYOdfo1v5Tyukz
 UG3TxZeNyrJJBRV9LAuC3zv5QgQMru
X-Google-Smtp-Source: AGHT+IGj44/rJkhiCCAjwWOdg3qvTkLN5osXv7vPZBQMNQ/QEUNoNIiROPolj5BbGk6eWQrIq7mok0qjUHZqGOoThl4=
X-Received: by 2002:a17:907:869e:b0:ac1:ea6e:ad64 with SMTP id
 a640c23a62f3a-ac738a3f376mr1473883266b.28.1743530114728; Tue, 01 Apr 2025
 10:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250319143820.2385092-10-sjg@chromium.org>
 <20250319145218.GG2640854@bill-the-cat>
 <CAFLszTiRm3YEQqU1w75uFp5gFZ1HiPv41vNX7VFy8XS80udVRw@mail.gmail.com>
 <20250319153510.GJ2640854@bill-the-cat>
 <CAFLszTg8a7CCiyyVVQdHDHNJ3MEP-Zxbbao_riy+iTzDt2u-KA@mail.gmail.com>
 <20250330144542.GQ93000@bill-the-cat>
 <CAFLszTiRXB+DpXOgyHiNCF9HoitzYW0EO9fyS2cKKCP8cQaR4A@mail.gmail.com>
 <20250401164856.GH5495@bill-the-cat>
In-Reply-To: <20250401164856.GH5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 06:55:02 +1300
X-Gm-Features: AQ5f1Jpc5zCVCZmE3qarWrdxsUuOcn3m52fx-LLmveBZ6k06zsWAESvdUQovYv4
Message-ID: <CAFLszTiL2=RVf9u96E=0=JKraaeKwFiTf+W1De3bQvFCCnwdGw@mail.gmail.com>
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

On Wed, 2 Apr 2025 at 05:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Apr 02, 2025 at 04:49:18AM +1300, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 31 Mar 2025 at 03:45, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Mar 20, 2025 at 03:41:33AM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 19 Mar 2025 at 16:35, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Mar 19, 2025 at 03:04:28PM +0000, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 19 Mar 2025 at 15:52, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Mar 19, 2025 at 03:38:03PM +0100, Simon Glass wrote:
> > > > > > >
> > > > > > > > Add an extlinux image that contains a few Ubuntu entries.
> > > > > > > >
> > > > > > > > Increase the number of sandbox-USB-hub ports to permit this.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > >
> > > > > > > I don't understand what this test adds. In neither the current Fedora
> > > > > > > test nor in this new test are we actually booting something, we're just
> > > > > > > taking a sample extlinux.conf and making sure it doesn't fail. Is it
> > > > > > > that we're testing in a useful fashion now having two labels?
> > > > > >
> > > > > > I didn't think so either, which is why I never did this before. But it
> > > > > > turns out that there were some bugs, too.
> > > > >
> > > > > I don't understand you, sorry. You don't think so either to what?
> > > >
> > > > I didn't think we needed two extlinux examples on different boot
> > > > devices, but we do.
> > >
> > > I'm not sure it's particularly clear what you're doing here then, or
> > > why, but I'll find some time to read it all more deeply.
> >
> > OK. This test case is how I found the bugs/problems in bootstd that
> > are fixed in this series.
>
> It should be (a) better explained and likely (b) instead of dropping in
> a seemingly verbatim installed file a specially crafted bit of content.
> We aren't testing "Ubuntu". We are testing multiple labels.
>
> > > > > > > We should probably be clear about what we're doing in the tests and
> > > > > > > instead of adding seemingly arbitrary distributions add an extlinux test
> > > > > > > and testcases.
> > > > > >
> > > > > > This is not actually a test case. It is simply creating a new image.
> > > > > > The test cases are in the other patches, so please take a look there.
> > > > >
> > > > > Nothing in this series quickly reads as adding tests and fixing problems
> > > > > with extlinux parsing, it's all bootmeth stuff?
> > > >
> > > > It isn't about the actual parsing of the .conf file, although I would
> > > > like to add tests there as we have none apart from what I have added
> > > > in my PXE series. It's more about having multiple devices with
> > > > bootable OSes on them. This series tidies up and fixes this. We need
> > > > to have an image available on more than one device to spot these
> > > > problems.
> > >
> > > And the existing tests for pxelinux that we have in mainline already,
> > > don't forget those.
> >
> > Yes. But those tests actually don't use bootstd, do they?
>
> No, they're testing pxelinux, the thing you said we don't have any tests
> for.
>
> > > > Currently we have two accessible to sandbox, one extlinux and one
> > > > EFI*. I decided to add a third, using extlinux.
> > > >
> > > > Again, this is not a test case, but provides an image for the test
> > > > cases in this series.
> > >
> > > Adding mocked up things for use in sandbox is adding test cases.
> >
> > One is a test image for use by tests; the other is a test. Perhaps you
> > are just saying that there is no point in having one without the
> > other? Otherwise, I'm not sure what to do with this feedback.
>
> Maybe I clarified better above now. You're not testing Ubuntu (or Fedora
> or Armbian or ...) you're seeing if various pxelinux files parse
> correctly. Making the tests be clearer about what's being tested is
> what's missing at least in part.

You want me to remove the word 'Ubuntu' from the test files? This is
what I get when I install u-boot-tools so I am trying to use that,
rather than invent my own thing. This is the same approach I've taken
with Fedora and Armbian and I think it makes the most sense.

Regards,
Simon
