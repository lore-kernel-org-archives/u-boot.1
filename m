Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB8AD36107
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 19:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D16C088DFE;
	Tue,  5 Nov 2024 20:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SjUGpBzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01D488DFE; Tue,  5 Nov 2024 20:04:05 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD99C891AB
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 20:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a93c1cc74fdso932896766b.3
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 11:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730833442; x=1731438242; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mV2caLbU3+mfakyfvQoUbbMNL8e9LC3T9ZnM48A/sPk=;
 b=SjUGpBzRJFtYdxixeQiib4qJ6Fu6b7fo3rn+t/X6yDhFLa7fSeiGMLYYSDLkxxUJv0
 FQtLcf9Cl8mOHPx2NdEeXNzFr4t6U44LJxStnREVamQabxx5ax/sbfZTNi5UrUewg3Ss
 Ck7+79cne9iN7MQsApBOYjK5Kunmx1GeHN3gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730833442; x=1731438242;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mV2caLbU3+mfakyfvQoUbbMNL8e9LC3T9ZnM48A/sPk=;
 b=SXgqrqZcZ4ITK+YNgc3Ft6/p8u+ppzTyJw2t49awZlRlWTln9fkBC3TjxopIYXrC0N
 yyIHAAsNsoPZQp3DiPUyULmKfsfrB0DD0tmfCebEFE8qVu7hVW8/x1tmGK2Hpu3HnA0f
 GrvdWCE7AJQTJwKW4iEBVj3aZTuOkiFfrNhlrrUupAjoI6OLjKUPOXoYxuyBDQklwrR3
 G/BVXDSlV5hASiHj4JI8SqsNY+wdjP1pUzOBFug9cYNrty9AZbR8Jzru2HwYNNW47O/H
 AaSaKXLBHv0xzzDHExI1z4YHW7wKnvP7nxMbEkrPlxdp57TM4pbcYHx9aaKNRxhJ2JdJ
 5C2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdFhc9yhTt95oRBbqQP61k+hqKZeURr0I5lcsauarfrcGXgG5JPh0tN5xyLegVwPax3n6F11o=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9v1Hs+TKMAK8PnQE6zNDNTt0TrAYuHHcmQyuxyUMARlciIGvH
 mJkKYVJU3T3RSOSY6nFDaKj+caOLem/5MwK3fM9W+G5iYCtuvci1ci579C87SweX3s3OJopWgId
 E8Aa+koaRAKEwJrhjOYf5DOyIene+xDaFEcUV
X-Google-Smtp-Source: AGHT+IFybBAcTEuw+TUBVdD9k04ZHhmJhN2g5xrs54j52xeKYi/kxbmbWsYJ/wHp6ULbNGMV1NlS5VOkiam8DbYBe9A=
X-Received: by 2002:a17:907:1c02:b0:a99:a9b6:2eb6 with SMTP id
 a640c23a62f3a-a9e652c179emr1702974266b.0.1730833442087; Tue, 05 Nov 2024
 11:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
 <20241104233227.GA3600562@bill-the-cat>
 <CAFLszThXiK=EzrUStsOBiSQ_pe1-Vdwtg-238BjQd91SMBym7A@mail.gmail.com>
 <CALeDE9M1PDFmm-oZvSEGwBaN_J77CSKUa8kbkEPQf9XATv8STg@mail.gmail.com>
 <CAFLszTjs-7uWNWdaZjhQe-rA5z0qSZxiFeX+WgFofYemW6qiwg@mail.gmail.com>
 <20241105154741.GI3600562@bill-the-cat>
 <CAFLszTjntxJShjnWK++NkonNrPdL0S-=zWf-N_AWUaZmfmArtg@mail.gmail.com>
 <20241105182619.GL3600562@bill-the-cat>
In-Reply-To: <20241105182619.GL3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 12:03:49 -0700
Message-ID: <CAFLszTjf69huO+NMJ2vSvEamgzcxnxA7DhiSk9qmfsRaP8QAvQ@mail.gmail.com>
Subject: Re: [PATCH v12 00/13] net: tcp: improve tcp support in legacy stack
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Anand Moon <linux.amoon@gmail.com>, Baruch Siach <baruch@tkos.co.il>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
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

On Tue, 5 Nov 2024 at 11:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 05, 2024 at 09:07:17AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 5 Nov 2024 at 08:47, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Nov 05, 2024 at 08:15:25AM -0700, Simon Glass wrote:
> > > > Hi Peter,
> > > >
> > > > On Tue, 5 Nov 2024 at 06:10, Peter Robinson <pbrobinson@gmail.com> wrote:
> > > > >
> > > > > On Tue, 5 Nov 2024 at 13:03, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 4 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Mon, Oct 28, 2024 at 05:31:30PM +0300, Mikhail Kshevetskiy wrote:
> > > > > > >
> > > > > > > > Legacy TCP stack is bad. Here are some of the known issues:
> > > > > > > >  * tcp packet from other connection can break a current one
> > > > > > > >  * tcp send sequence always starts from zero
> > > > > > > >  * bad tcp options processing
> > > > > > > >  * strange assumptions on packet size for selective acknowledge
> > > > > > > >  * tcp interface assumes one of the two scenarios:
> > > > > > > >      - data downloading from remote host to a board
> > > > > > > >      - request-response exchange with a small packets
> > > > > > > >    so it's not possible to upload large amount of data from the
> > > > > > > >    board to remote host.
> > > > > > > >  * wget test generate bad tcp stream, test should fail but it passes instead
> > > > > > > >
> > > > > > > > This series of patches fixes all of the above issues.
> > > > > > >
> > > > > > > I know Peter asked on the last one, but I want to ask as well. With lwIP
> > > > > > > merged, why do we want to add features to the old stack? I can see
> > > > > > > fixing issues, but not adding new functionality as well. Thanks.
> > > > > > >
> > > > > >
> > > > > > Let's apply this. It has tests and the old stack is still used by a
> > > > > > lot of boards. At present lwip is only used on one. There is more work
> > > > > > to do on the new stack, including finishing off the sandbox
> > > > > > implementation.
> > > > >
> > > > > I agree with applying the fixes pieces, I do not agree with apply the
> > > > > HTTP server pieces. This series should actually be split into 3
> > > >
> > > > But what is your objection?
> > > >
> > > > I would much rather just apply it ASAP. It has already gone through 12
> > > > versions, during which lwip has been prepared and applied.
> > >
> > > Yes, and to be blunt, the first bit of feedback I provided was "can you
> > > please look at the lwIP series instead?".
> > >
> > > > The HTTP server is a useful feature and we should be able to use it to
> > > > test networking in U-Boot in a more self-contained and performant
> > > > manner.
> > >
> > > I very much do not want to add more features to the legacy TCP stack.
> > > We're likely, long term, to still need some cut-back version of the old
> > > stack for the limited SPL cases.
> >
> > This series has been in progress for a long time and it seems unfair
> > to just drop it, with one one board on the new stack.
>
> Well, I continue to not say that we should drop the series, but that we
> should take the fixes and not the new features. Because as far as I can
> tell, the current TCP stack is in such a shape that it's not
> production-usable anywhere and so the number of users argument is
> irrelevant.

It's a strange thing as many people use the existing stack. I
certainly didn't know it had problems and it has always worked fine
for me. It just seems like an extreme position, to delay a series for
such a long time, then drop it because a nascent competition thing has
landed.

Let's take it as it is, then say that future bug-fixes and
enhancements need to be based on lwip (perhaps add something to this
effect to the headers and docs if not already there?). No one loses
and everyone should be happy. Once people start using lwip they will
build confidence in it. I will grow in confidence once it supports the
sandbox tests.

Regards,
Simon
