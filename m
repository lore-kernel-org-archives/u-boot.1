Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909EEE6F069
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 286BD88E14;
	Fri,  1 Nov 2024 16:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HlwZXB7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31FF488DF5; Fri,  1 Nov 2024 16:38:44 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3088388DF5
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a0f198d38so314603266b.1
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730475522; x=1731080322; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=swbjd2LPY40mDgoAFjYONSI56U7n49F1M+/IhbaZ9gY=;
 b=HlwZXB7jrZujeAV6VEZeiK6rYVihUaK2jSbUoRQLe219EyvAgilQrMYwaD7o5k2j3E
 kaIPhWzUaD5whoGqWjXSZ4ycGQ3MewjKwfmFefB71IQKEEesG5TdOVfI4ViJakmbnG64
 P7BITC4rJj215CiuYtOTBoZponmLivHg6L7Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730475522; x=1731080322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=swbjd2LPY40mDgoAFjYONSI56U7n49F1M+/IhbaZ9gY=;
 b=ENFavyB9n5dPAnDB6/KY+xQIRT53atk5xYXzn144VJFfiK62NW5WWdKKzLZ8DblLo0
 MIQhJqUH3PukdNPEf1ykFRQ3kPWnAFrD8IRtgpLjgVcJPg6ngNKX1xfyZ1mNALoDAbPU
 7SapexMo3y7Z1iV5aJIaMCIkRNZHASMwwNU5oDJVbBL3PCt91b7NTsITNaAGOTwT84Pp
 KaTorlj/es0dq2h7gnvMDnaCvN+vH46X+vMO1KxkAJf7FS7a46eyZEOSXorEPdSLirdb
 fqRiLv/IHEG/510sVUX7Bj0j9uAvr3dp6YeBagQ4YxYUntpGXW88dA0rvyU2ZFZorLdT
 wEzA==
X-Gm-Message-State: AOJu0Yy+QZuzsm19R4SmQqzgNGtiq81OXIMZ4CaziSbneKaagAqSKq+D
 M7wzaFBYp+Xkx8b7Kaux51tCNPkbLsQm0Jhc2TeIbIlupSeSLXhRYYNKaLt9oVjKfP+lltwNuY5
 TwmND+ZIY70PWdvnCAyHqgUW+dEZ6nG55ckH3
X-Google-Smtp-Source: AGHT+IHlH6cJ3kMLe/s95Omx6Hj/HEPTh6iQB+XUTP0QbS4HLkIAOxqd/tMLoEsJHFux18DSjacvrpCmGIFdB4DJn5A=
X-Received: by 2002:a17:907:1c85:b0:a9a:1f38:e736 with SMTP id
 a640c23a62f3a-a9e654fb423mr373784666b.31.1730475521644; Fri, 01 Nov 2024
 08:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241026120252.865215-1-sjg@chromium.org>
 <20241026223346.GI4959@bill-the-cat>
 <CAFLszTg-Lr3uWu41YX1z=JTbBbiT8Gh2oydLHpq5dtyZbRUtKg@mail.gmail.com>
 <20241027145625.GJ4959@bill-the-cat>
In-Reply-To: <20241027145625.GJ4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Nov 2024 16:38:26 +0100
Message-ID: <CAFLszTikk2GmY0PNc=JZUAsb-SiYSbheAKaOa_msTBVLpBMueA@mail.gmail.com>
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

On Sun, 27 Oct 2024 at 15:56, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Oct 27, 2024 at 03:52:02PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 27 Oct 2024 at 00:33, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Oct 26, 2024 at 02:02:49PM +0200, Simon Glass wrote:
> > >
> > > > Something this breaks, so add a build to keep it working. Since sandbox
> > > > enables a lot of options, it is a good board to use. The new config is
> > > > created simply by copying the existing sandbox and turning off CMDLINE
> > > >
> > > > Once we have tests for non-CMDLINE operation, this can be adjusted to
> > > > run those tests.
> > > >
> > > > Create a new build which will be picked up by CI. Update the maintainer
> > > > entry as well.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Create a new build instead of messing with CI
> > > >
> > > >  MAINTAINERS                         |   1 +
> > > >  configs/sandbox_nocmdline_defconfig | 365 ++++++++++++++++++++++++++++
> > > >  2 files changed, 366 insertions(+)
> > > >  create mode 100644 configs/sandbox_nocmdline_defconfig
> > >
> > > Please use the #include mechanism instead of a full config that will
> > > also now have to be kept in sync.
> >
> > Hmmm we still haven't come up with a way to deal with the #include
> > mechanism in buildman. I've forgotten where it got to, or even what
> > the problem was?
>
> I assume this is related to the issue I filed? Among the problems are
> that buildman doesn't "know" about the architecture for example in time
> and so thinks everything is sandbox (since that's the default). That
> won't be an issue for your use case here (we have a number of defconfigs
> today that work around this issue by setting CONFIG_ARM=y and then a few
> other options too, so that the resulting build ends up correct).

Yes...OK so I think I understand. If we are happy with the '#include'
scheme then I believe it would be easy enough to implement in
buildman. As Caleb mentions, it could likely run the pre-processor
first, or just process the #includes (which I prefer).

Is the '#include' in defconfigs documented somewhere in Linux or
U-Boot? I really had no idea about this until you mentioned it.

Regards,
Simon
