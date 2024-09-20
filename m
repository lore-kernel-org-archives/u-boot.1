Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBDDCF58E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F19F8940D;
	Fri, 20 Sep 2024 09:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JLinYKcM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B80E08941A; Fri, 20 Sep 2024 09:26:01 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 301398940E
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6c34c02ff1cso10691946d6.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817158; x=1727421958; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8B/aCCVrvyX4SbyDr5NlkHjMKSa3A81mJy1qSgw1YmM=;
 b=JLinYKcMkKHq4FM+Er4VoFH3K0BJCiggPQY0FmI9OS4RFaMCLDVTzFmkp3H7nbx6VQ
 uS08J3Unv8M08Ocm9oVKfNwd/tQ1tJBd9oERBzNTvga7iZMPJy0gRCo+FudYJnT7DyBd
 sotM4N9M7U0mpAfDFWFnPXhl1RE2UDxcueQVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817158; x=1727421958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8B/aCCVrvyX4SbyDr5NlkHjMKSa3A81mJy1qSgw1YmM=;
 b=oLQT0Cul11R+uAd9oLmqFaAvD4fHO5ga3lE66Brod9M0yj0oYO5qS5J8Rg+2271XB0
 JidJTgnjYIZqMVrWhFiVurZhogRIk1olbnsshykOP1ldU+bJ6TLX+QZ/+sOLNfM2mGX/
 Pv4TGnOD6L3RkhAaEVJA45+yZUwvWrT33j00pYo+p6F5KgaQuPo4OKTiwo229GFnnMQa
 FrVMlXWin2AjmmrUm0X4PrwV8PY21nPZOEORHpn/ZY3Ou1ZCRygY6FzCqkET7bkszv2c
 FLUPkuu5PG5pvDT3eVxTrTfrLSXh1naqRKKQqLewFCMS/DLPyWtlcycyMEt/R/pyfbfw
 49pA==
X-Gm-Message-State: AOJu0Yyef4/lWp/TUzq4m//Ni8mOD8PR8/4Fj+5hjC1mTFVAPAm3S6FP
 hgvIK9nJayz3pFq/wLr5aeNvJjYoEReSmavJgcBJVIOzZw1DqTc353socLntKj8ihV3jnX+VSrU
 gfCXMZBUKwDMNMewgSDJBpUMUh8Fe5kdyxYuS
X-Google-Smtp-Source: AGHT+IE640lmvBcAqyjtRYVXdhe8Z7Ok0mjWQT2mJzwHTUOkpqhbaX/WkH9k2NpMUXffAn2MeCDi3xYcEI84Yc3j6RE=
X-Received: by 2002:a05:6214:460f:b0:6c3:6f1b:bbe4 with SMTP id
 6a1803df08f44-6c7bd50bc30mr31911916d6.26.1726817158158; Fri, 20 Sep 2024
 00:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-19-sjg@chromium.org>
 <20240829173115.GM2479150@bill-the-cat>
In-Reply-To: <20240829173115.GM2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 09:25:46 +0200
Message-ID: <CAFLszTi4vmf=_jb9PKz1bq3bnxhHWUptLNzRCkd+DQk4sfrJWA@mail.gmail.com>
Subject: Re: [PATCH 18/19] boot: Imply CRC8 with VBE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

On Thu, 29 Aug 2024 at 19:31, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 08:58:01AM -0600, Simon Glass wrote:
> > VBE uses a crc8 checksum to verify that the nvdata is valid, so make
> > sure it is available if VBE is enabled.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  boot/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index afe04c7327a..49e99e5e155 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -716,6 +716,8 @@ config SPL_BOOTMETH_VBE_REQUEST
> >  config BOOTMETH_VBE_SIMPLE
> >       bool "Bootdev support for VBE 'simple' method"
> >       default y
> > +     imply SPL_CRC8
> > +     imply VPL_CRC8
> >       help
> >         Enables support for VBE 'simple' boot. This allows updating a single
> >         firmware image in boot media such as MMC. It does not support any sort
>
> I really worry the lack of "if SPL" / "if VPL" here leads to Kconfig
> warnings that CI doesn't pick up.

So far, BOOTMETH_VBE requires SPL and VPL, but I've added the
condition just to be safe.

Regards,
Simon
