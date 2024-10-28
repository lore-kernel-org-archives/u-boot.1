Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CACD339A1
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 17:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 452CF89099;
	Mon, 28 Oct 2024 18:02:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jVe1dusq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF443890D1; Mon, 28 Oct 2024 18:02:06 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7865289098
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 18:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c95a962c2bso5631556a12.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730134924; x=1730739724; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MGWX11XM7sJ05wwTEzBQRHOo2sEVDCtd2sgOszjcZXc=;
 b=jVe1dusqUQAFXzPpFH+QMYRHG8Jp+iYata0b7j6nNFn/meKW6+ZCXsmQYwD5rofSxp
 hAkfQlnp60Up9TTYWhjdt0sLMTkctVgjhkWHo7DiANNPPD1ib9c6FJExo0luO0yhqnnO
 WGKgV5/GP831WpDjaMAbFiurocNGnADAIL/zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730134924; x=1730739724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MGWX11XM7sJ05wwTEzBQRHOo2sEVDCtd2sgOszjcZXc=;
 b=GyDCgukE1tp8Q1rxUHVZmYivKwJvJ4g5KOyM1wfrs5GdYxFgdpnArqDHFg+K010M3i
 llF6O5l/Wtoz4FQn4WawhPgo9yfUxg2encw3FzjvQu0K/bxtAtGRez8bcoRYTllLN/JE
 DuNpybx9PlHcRf9joedx/JOvZIqUHcYM87kYLW2JYoJbeGUpM/nC8lXLfmuRcR97rVNr
 aVj4qHNYEC+qmq+NsTuhwNBWWwokfBocsaBZsQIgAlYSNTwlL3iKY9WzJTwljiqy2o/5
 st4QA5fltbBAeFW8jspWDGvOVbdws/I8zIeTrTTA5lHIp+KaPy6LrTFiT86Vlfs0YrI1
 yGUw==
X-Gm-Message-State: AOJu0YwdjfsMpdAQW+Hqt+ExNwavkoYWpUtRDW6XqXdkrdgVuMhooemS
 OEtAPfxt9h54YKiGCPcCdM6dQXRXuzBXp0moJMP5MbSB8mhS2xw3ROjV6WFmhsCDLEI3AC97sd/
 E+MszeHvrlYy0cJrNFZDR0rnI5FwUUku2ElPA
X-Google-Smtp-Source: AGHT+IHIoWPUX4pGdTJDHtnsq8jMZlK8Z/KB7/+tHv+oTVaZXBnwqBAjEKcMGcIP8VeZMSZ6yt4b0xvmu13qCgIeylw=
X-Received: by 2002:a17:907:7f06:b0:a99:fb56:39cc with SMTP id
 a640c23a62f3a-a9de5ee1998mr759049266b.38.1730134923810; Mon, 28 Oct 2024
 10:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-2-sughosh.ganu@linaro.org>
 <CAFLszTgpUOpjMogv5q0EhLHe-i=VBYHtdaGyBp6as99BkbE0pg@mail.gmail.com>
 <CADg8p95SAYvhTaAYWOSHmZXNbyuNdB2=_2Mhwdn8eU+aBtNioQ@mail.gmail.com>
In-Reply-To: <CADg8p95SAYvhTaAYWOSHmZXNbyuNdB2=_2Mhwdn8eU+aBtNioQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Oct 2024 18:01:51 +0100
Message-ID: <CAFLszTjXS9XQmENZ29saUzsmcz9jHw7kowvUWa1jzCvfPVix5A@mail.gmail.com>
Subject: Re: [PATCH 1/4] fdt: add support for adding pmem nodes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Sughosh,

On Mon, 28 Oct 2024 at 12:29, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Sun, 27 Oct 2024 at 20:30, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Fri, 25 Oct 2024 at 13:15, Sughosh Ganu <sughosh.ganu@linaro.org>
wrote:
> > >
> > > From: Masahisa Kojima <kojima.masahisa@socionext.com>
> > >
> > > One of the problems OS installers face, when running in EFI, is that
> > > the mounted ISO after calling ExitBootServices goes away. For some
> > > distros this is a problem since they rely on finding some core
packages
> > > before continuing the installation. Distros have works around this --
> > > e.g Fedora has a special kernel command line parameter called
> > > inst.stage2 [0].
> > >
> > > ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
> > > don't have anything in place for DTs. Linux and device trees have
support
> > > for persistent memory devices. So add a function that can inject a
pmem
> > > node in a DT, so we can use it when launhing OS installers with EFI.
> > >
> > > [0]
> > >
https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/installation_guide/chap-anaconda-boot-options#sect-boot-options-installer
> > >
> > > Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >  boot/fdt_support.c    | 41 +++++++++++++++++++++++++++++++++++++++--
> > >  include/fdt_support.h | 13 +++++++++++++
> > >  2 files changed, 52 insertions(+), 2 deletions(-)
> >
> > Can you please use the ofnode interface for this? We are trying not to
> > add more of this kind of fixup, as it means someone will have to port
> > it over later.
> >
> > See EVT_FT_FIXUP
>
> Are you suggesting using the EVT_FT_FIXUP interface for adding the
> pmem node? If so, how does this work on platforms which enable
> livetree? Looking at the code, I see that the EVT_FT_FIXUP gets called
> only when the livetree is not active. However, I am not able to find
> any place where the livetree is getting disabled. We do have a
> function, oftree_to_fdt() which flattens a livetree, but I don't see
> it getting called from anywhere except from a 'upl' command. The
> of_root pointer does get set in initr_of_live(), but apart from
> dm_test_pre_run(), I do not see where we disable the livetree and set
> of_root to NULL.
>
> So on platforms which do enable livetree, how does this fixup work?
> What am I missing?

It isn't implemented yet for OF_LIVE in image_setup_libfdt(). Most of the
code is there though. It just needs to be hooked up - see oftree_to_fdt()
and oftree_from_fdt().

The idea would be to remove the of_live_active() check, so the event is
always sent (will need to 'select EVENT' for OF_LIVE).

Then in that same code, after the event, call oftree_to_fdt() and copy the
fdt back to blob.

If you have time, it should be a nice mini project and will allow us to
migrate more things to the ofnode API.

Regards,
Simon
