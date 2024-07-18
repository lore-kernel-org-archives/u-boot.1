Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9647C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 16:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AFB18855C;
	Thu, 18 Jul 2024 18:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uHJrWQM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1BC78867B; Thu, 18 Jul 2024 18:49:56 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A7878855B
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 18:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fc49c1f3e5so10032315ad.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721321393; x=1721926193; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WsdFGgBeCXt31CgqGOQ3PDprlUAHEh6tkzBrb47EwmQ=;
 b=uHJrWQM00dp+ErGH4iBKvXH7X5TiW//fgiaVoIxygBiJjImCFthCtJ5RY5Z1zMbQre
 LyQOBaUbEo2IRy+AzFPiYrUZYlIB4PpSEMDGYyu6NbhJL6Nsw+hhU5fUMSkFnwe1JZkT
 7htTPvTdrYimPiR0GNuX4aYkn9ehjQeqdMAuRn5Uzr0rN2r8EVBqPUF+sySfsyoz9TsP
 fl4uQTQyOp5hhdSgRIQJJNvqwRd2qeRq8pe/Pvecr3Tw1zdbxCfqGDi2mzluJLKGCH2V
 gtmn3H2rc5U5+EwFm++5vFC6VGn6yfqYzlKdK8oSJpHMQ79LltUcmE+93CqGjVF2eEdy
 WlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721321393; x=1721926193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WsdFGgBeCXt31CgqGOQ3PDprlUAHEh6tkzBrb47EwmQ=;
 b=fDGyqKfdC2HXEhlOY6zquPsZLehdEPLUzrkN1V1uVVtF86GeACWRVfcoXe189TiKGN
 O7m8xOPOaLQeCUhY59oSTwxyvCYJHXIYs0oJR3woaF7giQ2rqpiunTw1gezZQQFDFxGi
 noB6EtNEFUGzKOFRx4kNdLjrutJw0PBg03OmpG8E1haqUPb60B/XLnqRfBcGLrAH2FY7
 dFQaH0cFh5YvvwcOKMKY6tE3+w6CVDQ06AQmLYYZ6S1AoxG3DXAJMoO1kDFlK7iNiS4m
 0YA/GxVapUqeWXj+EpYQYfFvT1A7z+dPNbcQHexTPf1oomvREeuxH1+rPMoecqki2A8V
 NFAg==
X-Gm-Message-State: AOJu0YyNvWKuAUZjY1btOMk1K0I9N7Yvm6TeSnbFgCqgBNy2bmH2F44n
 21HrDj+Vtc2d5WdaX7oWOEWpffkr3FWK/k/iOoWhO7Sv2t2fC2zjpFFWfjACEF6CJKOmeZ9hADH
 GTtMRNHD/TPhxhE/2nyhFJ+otVqvpSPfxVG850Q==
X-Google-Smtp-Source: AGHT+IEBCAWs+UJvXICO33wIZbx7A+6W401G9HLMvw6na3Zjaoy91GicKftqdzTMKcIrrzymsgra9IZWQRX+v/w6gig=
X-Received: by 2002:a17:90b:14b:b0:2c8:8a5:c1b9 with SMTP id
 98e67ed59e1d1-2cb5266ae26mr4569072a91.13.1721321392849; Thu, 18 Jul 2024
 09:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-9-raymond.mao@linaro.org>
 <CAC_iWjLxSbtcSwM1iQjj7DG3sJLY5Q=3fnuOphkJKXcQyO4TtQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLxSbtcSwM1iQjj7DG3sJLY5Q=3fnuOphkJKXcQyO4TtQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 18 Jul 2024 12:49:41 -0400
Message-ID: <CAEfUkUKG8NLz+our5gtaGyd0CZC1cbgd9dMLCRFjx8cbA+Ce7g@mail.gmail.com>
Subject: Re: [PATCH v4 08/29] hash: integrate hash on mbedtls
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Eddie James <eajames@linux.ibm.com>
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

Hi Ilias,

On Wed, 3 Jul 2024 at 04:56, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond
>
> On Tue, 2 Jul 2024 at 21:27, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Integrate common/hash.c on the hash shim layer so that hash APIs
> > from mbedtls can be leveraged by boot/image and efi_loader.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Use the original head files instead of creating new ones.
> > Changes in v3
> > - Add handle checkers for malloc.
> > Changes in v4
> > - None.
> >
> >  common/hash.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 143 insertions(+)
> >
> > diff --git a/common/hash.c b/common/hash.c
> > index ac63803fed9..96caf074374 100644
> > --- a/common/hash.c
> > +++ b/common/hash.c
>
[snip]

> > @@ -267,10 +404,16 @@ static struct hash_algo hash_algo[] = {
> >                 .hash_init      = hw_sha_init,
> >                 .hash_update    = hw_sha_update,
> >                 .hash_finish    = hw_sha_finish,
> > +#else
> > +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> > +               .hash_init      = hash_init_sha512,
> > +               .hash_update    = hash_update_sha512,
> > +               .hash_finish    = hash_finish_sha512,
>
> I don't have strong opinion here, but you could alternatively define
> sha384 wrappers for mbedTLS and avoid this ifdef.
> In any case I personally don't mind.
>
> I will prefer not to create a new wrapper function in order to save
space.

Regards,
Raymond
