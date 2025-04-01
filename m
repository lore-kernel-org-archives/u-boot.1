Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40891C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D063C80FDA;
	Tue,  1 Apr 2025 17:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JCRbuIfK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B01481782; Tue,  1 Apr 2025 17:49:32 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 185E380584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ab78e6edb99so817062666b.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743522569; x=1744127369; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m8RasxnkxyDkflOXztTSsCT6tdrY/ZDRthg/Fr2awSc=;
 b=JCRbuIfKAjB1iQjS/vlINXCur7O/J09tl/CkxAyxNyZXQlRVEkbFXHY3DOO0MJumdw
 YGKnMqV6HKmo4Am8tBC5yjZJy7Ceq/TwMcloKaK3rwcX93WXlLPGr302iaOe03dapCRy
 izCmy8D9Klmpny8P8+VxHkTQSZmFgewAD34G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743522569; x=1744127369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m8RasxnkxyDkflOXztTSsCT6tdrY/ZDRthg/Fr2awSc=;
 b=IHQi5VzbdGcTPVk7T+ka7pKp6P97sQcM9nGz7fskiI64+0Ly5+owzfl3l4ZPistZ5J
 E5zqaSiiDdiVmAsm4F3MStRmoOEYX83fl2xY+JQr8kp80DFALibnbtQB/Dj8xIKX7ar9
 zv7vrX7BBk4IcrXXe9LIbQ1dmkm2wRpoeqSg7GGUg4cskeRCy8wfIbnuD4EWXHMrcUur
 sircUDgQu6fVpus7E6FNXnaA95WIcr8q3HFEuoCC7cwpeYvQQDKue5eRLvufuorRCFbZ
 n9C/OrCxLBlU4kRdjuwrq1N+mK8k3P6Jx/4/g/PtLbutLR0niNQQTstoIkdqkdjT0huR
 0AmA==
X-Gm-Message-State: AOJu0YwY16LE9nWDQB0m3aWATEYkSSBYNxIi+DH4OeYTON/RST4ELCBT
 vs4P3FlXUQteoPKkdEDnpppQl+SgyMKbTDa7kcOtwSEd7DEaD33OGXvmep93vR9Fx57Z1IdFFGq
 YsQtMAdEcTR9lW6NB1+0Vde87LdSgJwKvpLBD
X-Gm-Gg: ASbGnctYLTWKaFO/XjIKUhHe9TyZRAMKflsx7O43y5UHIx73WKcQoaRqG/b+K40hWfj
 mVWSkLB4NhIzCf/iY5nWzNWuONgAz/pbA9gfNsE8H7PxGHfPUp6urDK8Y8yMYxvuAgIxmQIAsgl
 uqenpz4Q7Uvb55h2utavK+84rn9eCWYVPt97OSMXQ=
X-Google-Smtp-Source: AGHT+IGsw/T3Mhj7TiwQYgIw4bhOG4PJBkDt6sd9CTyLPxBjlqXSWQfWC3nC6AWeXzXkd+ur7APpqk0hqCXTgVZaSjQ=
X-Received: by 2002:a17:907:9693:b0:abf:733f:5c42 with SMTP id
 a640c23a62f3a-ac73895f8b0mr1187047666b.8.1743522569463; Tue, 01 Apr 2025
 08:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250319143820.2385092-10-sjg@chromium.org>
 <20250319145218.GG2640854@bill-the-cat>
 <CAFLszTiRm3YEQqU1w75uFp5gFZ1HiPv41vNX7VFy8XS80udVRw@mail.gmail.com>
 <20250319153510.GJ2640854@bill-the-cat>
 <CAFLszTg8a7CCiyyVVQdHDHNJ3MEP-Zxbbao_riy+iTzDt2u-KA@mail.gmail.com>
 <20250330144542.GQ93000@bill-the-cat>
In-Reply-To: <20250330144542.GQ93000@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 04:49:18 +1300
X-Gm-Features: AQ5f1JoTHBBE4E2xNk9rfZ7is28XMuxOIvXwS2Iu_a_eKT6IPTcc7jZ8sYOJ_bA
Message-ID: <CAFLszTiRXB+DpXOgyHiNCF9HoitzYW0EO9fyS2cKKCP8cQaR4A@mail.gmail.com>
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

On Mon, 31 Mar 2025 at 03:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Mar 20, 2025 at 03:41:33AM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 19 Mar 2025 at 16:35, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Mar 19, 2025 at 03:04:28PM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 19 Mar 2025 at 15:52, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Mar 19, 2025 at 03:38:03PM +0100, Simon Glass wrote:
> > > > >
> > > > > > Add an extlinux image that contains a few Ubuntu entries.
> > > > > >
> > > > > > Increase the number of sandbox-USB-hub ports to permit this.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > I don't understand what this test adds. In neither the current Fedora
> > > > > test nor in this new test are we actually booting something, we're just
> > > > > taking a sample extlinux.conf and making sure it doesn't fail. Is it
> > > > > that we're testing in a useful fashion now having two labels?
> > > >
> > > > I didn't think so either, which is why I never did this before. But it
> > > > turns out that there were some bugs, too.
> > >
> > > I don't understand you, sorry. You don't think so either to what?
> >
> > I didn't think we needed two extlinux examples on different boot
> > devices, but we do.
>
> I'm not sure it's particularly clear what you're doing here then, or
> why, but I'll find some time to read it all more deeply.

OK. This test case is how I found the bugs/problems in bootstd that
are fixed in this series.

>
> > > > > We should probably be clear about what we're doing in the tests and
> > > > > instead of adding seemingly arbitrary distributions add an extlinux test
> > > > > and testcases.
> > > >
> > > > This is not actually a test case. It is simply creating a new image.
> > > > The test cases are in the other patches, so please take a look there.
> > >
> > > Nothing in this series quickly reads as adding tests and fixing problems
> > > with extlinux parsing, it's all bootmeth stuff?
> >
> > It isn't about the actual parsing of the .conf file, although I would
> > like to add tests there as we have none apart from what I have added
> > in my PXE series. It's more about having multiple devices with
> > bootable OSes on them. This series tidies up and fixes this. We need
> > to have an image available on more than one device to spot these
> > problems.
>
> And the existing tests for pxelinux that we have in mainline already,
> don't forget those.

Yes. But those tests actually don't use bootstd, do they?

>
> > Currently we have two accessible to sandbox, one extlinux and one
> > EFI*. I decided to add a third, using extlinux.
> >
> > Again, this is not a test case, but provides an image for the test
> > cases in this series.
>
> Adding mocked up things for use in sandbox is adding test cases.

One is a test image for use by tests; the other is a test. Perhaps you
are just saying that there is no point in having one without the
other? Otherwise, I'm not sure what to do with this feedback.

Regards,
Simon
