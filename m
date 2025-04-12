Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A8DC369A1
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 12:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D456A82CBC;
	Sat, 12 Apr 2025 14:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GJimqPBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EFF782BE3; Sat, 12 Apr 2025 14:45:17 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ECEE82D34
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 14:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-abbb12bea54so563497066b.0
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 05:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744461915; x=1745066715; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vtoU6MUBGK0ObQuTj6heqJ5LT/NUCO63UhxXOcWuI8k=;
 b=GJimqPBdsIGJq1nhnhmER3XWcUpRIE2uOZHQfkYwNdKLnk1Bq5OZIa8fwKgNZXhIH9
 m7m4ohf5fxsDO01Ld0iAKNLJobt4aj0iLYQTtNoVs/LfK1QdfyOMgUnoNXkP7LOOiFAf
 2X8IOKVAWiGJMEEOO3Axrgc14A19uPt0RbeU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744461915; x=1745066715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vtoU6MUBGK0ObQuTj6heqJ5LT/NUCO63UhxXOcWuI8k=;
 b=Yo0qQuif4BshocY25epCJx/gy9anUevzntrX23WsFMB0CHLQayh6pK9bT1d5jS5OQk
 4YNTffrPOJ0yTSjdbfz7aQruIAY9PCB552v5o7RJbxd7+JeUIGcheuCpIvu1FhSf9rEd
 zd0CPIG/1PAilyl5BOh83VAt0UWcQ9xHbltxGHtGlKjYjzlcSvZ11f6fptkdwZEXyOeD
 9ieE6ht9wabuIJ9FYt1k7RHC5xusGXI9IE8fo+wspUHLgoI+pm37vFqUgGfYp5E1kqyk
 GVo/ch7QKuzTaW4fR+rdwYmpbBDLndJHY3Eyhdh4esSH4YyF7iivcydA2VDJhRSHuLPq
 4dfg==
X-Gm-Message-State: AOJu0Yx/6NWYr9ZwHLH2Yk6g9ToS9Lxe1FRt9sns3H35S8mGtuQJ83CV
 YM2l6klYAhZxxThOFH8MuSO5aCgsfzzK+62l6uJSCN0Qtf2VNhQZoq2m/PPbtXpMQa7s2UysAab
 YE0wU5ozUUWnMe5Ci9ycPnB8SysBhILxxBkjc
X-Gm-Gg: ASbGncs4b+MKAQj43UOomMwMNzdofZyOSvhpNOe464W6kL2SxZisPN6yZ0dGjb0YJyb
 2xHtPqr/mYDKCnM3rwFz8WOgNIr/Plf8tVMlbAACKQ138KTuHbHPQC41zMdiRVZ8C/wR0U00IVL
 Ei8fvvbgbnrOgN7l3uMEo9sG0=
X-Google-Smtp-Source: AGHT+IGj8nHwY56Zo5ZOe99WDapATpxxbFODohXmA7dyrlUDD8kyl2iVYTlOv6s29IZ/ep549tr7ReGeZMlYHJIrFUg=
X-Received: by 2002:a17:907:2d06:b0:ac6:b639:5a1a with SMTP id
 a640c23a62f3a-acad34d95afmr587092166b.28.1744461914509; Sat, 12 Apr 2025
 05:45:14 -0700 (PDT)
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
 <CAFLszTiL2=RVf9u96E=0=JKraaeKwFiTf+W1De3bQvFCCnwdGw@mail.gmail.com>
 <20250411191301.GZ5495@bill-the-cat>
In-Reply-To: <20250411191301.GZ5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 12 Apr 2025 06:45:02 -0600
X-Gm-Features: ATxdqUEMYHH-IDkZHHXMeGRddb4aZCWltyHF3XMjBSdu9X8kCXPD6Oy_2tcHYmo
Message-ID: <CAFLszThC+P+3RRAakH2vdfWAsitOJ9us74EOeqq_UhxBfvw4CA@mail.gmail.com>
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

On Fri, 11 Apr 2025 at 13:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Apr 02, 2025 at 06:55:02AM +1300, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 2 Apr 2025 at 05:49, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Apr 02, 2025 at 04:49:18AM +1300, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 31 Mar 2025 at 03:45, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Mar 20, 2025 at 03:41:33AM +0000, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 19 Mar 2025 at 16:35, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Mar 19, 2025 at 03:04:28PM +0000, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Wed, 19 Mar 2025 at 15:52, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Mar 19, 2025 at 03:38:03PM +0100, Simon Glass wrote:
> > > > > > > > >
> > > > > > > > > > Add an extlinux image that contains a few Ubuntu entries.
> > > > > > > > > >
> > > > > > > > > > Increase the number of sandbox-USB-hub ports to permit this.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > >
> > > > > > > > > I don't understand what this test adds. In neither the current Fedora
> > > > > > > > > test nor in this new test are we actually booting something, we're just
> > > > > > > > > taking a sample extlinux.conf and making sure it doesn't fail. Is it
> > > > > > > > > that we're testing in a useful fashion now having two labels?
> > > > > > > >
> > > > > > > > I didn't think so either, which is why I never did this before. But it
> > > > > > > > turns out that there were some bugs, too.
> > > > > > >
> > > > > > > I don't understand you, sorry. You don't think so either to what?
> > > > > >
> > > > > > I didn't think we needed two extlinux examples on different boot
> > > > > > devices, but we do.
> > > > >
> > > > > I'm not sure it's particularly clear what you're doing here then, or
> > > > > why, but I'll find some time to read it all more deeply.
> > > >
> > > > OK. This test case is how I found the bugs/problems in bootstd that
> > > > are fixed in this series.
> > >
> > > It should be (a) better explained and likely (b) instead of dropping in
> > > a seemingly verbatim installed file a specially crafted bit of content.
> > > We aren't testing "Ubuntu". We are testing multiple labels.
> > >
> > > > > > > > > We should probably be clear about what we're doing in the tests and
> > > > > > > > > instead of adding seemingly arbitrary distributions add an extlinux test
> > > > > > > > > and testcases.
> > > > > > > >
> > > > > > > > This is not actually a test case. It is simply creating a new image.
> > > > > > > > The test cases are in the other patches, so please take a look there.
> > > > > > >
> > > > > > > Nothing in this series quickly reads as adding tests and fixing problems
> > > > > > > with extlinux parsing, it's all bootmeth stuff?
> > > > > >
> > > > > > It isn't about the actual parsing of the .conf file, although I would
> > > > > > like to add tests there as we have none apart from what I have added
> > > > > > in my PXE series. It's more about having multiple devices with
> > > > > > bootable OSes on them. This series tidies up and fixes this. We need
> > > > > > to have an image available on more than one device to spot these
> > > > > > problems.
> > > > >
> > > > > And the existing tests for pxelinux that we have in mainline already,
> > > > > don't forget those.
> > > >
> > > > Yes. But those tests actually don't use bootstd, do they?
> > >
> > > No, they're testing pxelinux, the thing you said we don't have any tests
> > > for.
> > >
> > > > > > Currently we have two accessible to sandbox, one extlinux and one
> > > > > > EFI*. I decided to add a third, using extlinux.
> > > > > >
> > > > > > Again, this is not a test case, but provides an image for the test
> > > > > > cases in this series.
> > > > >
> > > > > Adding mocked up things for use in sandbox is adding test cases.
> > > >
> > > > One is a test image for use by tests; the other is a test. Perhaps you
> > > > are just saying that there is no point in having one without the
> > > > other? Otherwise, I'm not sure what to do with this feedback.
> > >
> > > Maybe I clarified better above now. You're not testing Ubuntu (or Fedora
> > > or Armbian or ...) you're seeing if various pxelinux files parse
> > > correctly. Making the tests be clearer about what's being tested is
> > > what's missing at least in part.
> >
> > You want me to remove the word 'Ubuntu' from the test files? This is
> > what I get when I install u-boot-tools so I am trying to use that,
> > rather than invent my own thing. This is the same approach I've taken
> > with Fedora and Armbian and I think it makes the most sense.
>
> I seem to be unable to explain that if you're constructing tests, I'd
> like to see it clear that you're constructing test files. You're not
> testing "Ubuntu" or "Fedora" or "Armbian" here. I'm not nak'ing this
> patch as at the end of the day, it's adding some test, even if it's also
> I believe being done in confusing ways.

I actually do understand what you are saying. Indeed I am not testing
the OS booting, just that we can parse the files that they use to
describe the OS. I think it is better to use real files rather than
invent things that are not used in the wild.

Perhaps the commit subject is bad. 'Add an extlinux file as used by Ubuntu' ?

Regards,
Simon
