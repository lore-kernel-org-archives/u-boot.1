Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6227CA0EF9
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26F84885A5;
	Fri, 30 Aug 2024 11:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JP26Ah67";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D36DA88966; Fri, 30 Aug 2024 11:37:32 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93265881A9
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-201fbd0d7c2so15036125ad.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 02:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725010649; x=1725615449; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1XGdeZBWDrF/0E12RXPqkDAgPgzGlnaq2frJlgQxV0Y=;
 b=JP26Ah67IEqhOt6T8B9nI8US/LSJZex4nnT5gLAzyZg/azzRVLr+jvIUiJ0MhNjB4n
 KuJjuWexKqI8EZ4cymZNdBSKPMd3ko9Vy5NRt30ozsl5ZoMtWKOq6U2jfbyvfUqPmH+0
 ddc9w+KFvlpDKoHhixaq24BpbENzXU6Ez6B1KOXLT4+HGtmqEUbdQkA97Bjk+Nk9kfBV
 hCkQAM+pA2B92TSnTolvSgn+ILBJyTGGnUr5vemp3FD9fVyPr0ol4TaoG/VpkGp+hI/0
 KKuhbo6tcCF9MbkrErxFtlkZpBdDzhSEwFL+xnmU/dk6/ctdGNAabp++JQUQJg92VlKl
 CkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725010649; x=1725615449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1XGdeZBWDrF/0E12RXPqkDAgPgzGlnaq2frJlgQxV0Y=;
 b=IaT/kOer6huK69ZowvaU3WaMxZiyEPbq+a123HO/pZwRx23DgxxZeeZ15A0uVkVUbo
 3VBmKd4X1t+y9ubsf04BJIELE2zy/hEV5zwXHSS7dVbeZNtHgLR0CYSWh5DFE2OG4Ide
 XPnp+PvYi2e/DUcl8lel7iXykCdjL2zan/FV7d4CzFNq1NGkdp4hhx5/yTNsPzBVAdpk
 g6CGgiRZ7RCuuHRlB0OlEZVINfnw4c6EJS/uxgJL4+CvXx4E4hlYo/k6lNFFmqnZW0i2
 bgX9LCufTpNFL3TTc8gr2OGdlZz1aujblWT23COdxB/Z5Adom8wO2Fk5P3+p8vvBn5YX
 Ot3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh7IIpT6s7EU24s6UbbUmLAgoDmNP41XZEiozmJSoFDyktmqD0GBdmFCQ00qvylmLfg7+INnw=@lists.denx.de
X-Gm-Message-State: AOJu0YwD8vYEjiB5xZD/MkVBsdMBCOZnpnuRLn8uq87OGerZj2RyHToS
 xn2CeHnc9AHaOThD5FY1+anxuzc/YwMM4m3no9f62yZ8CIGkWKJOyOlN1EkT+dGpdMrqRm9nu+a
 yj0WtWAnp1pP0D1GXV5x9UfsVynXSbxD3Gt0DXA==
X-Google-Smtp-Source: AGHT+IEDJDB8O8ydUwPrd7Cctdl4uCPWFBUwSdc+eP+Y6kTuLTtJZWvKutne6nFYvPJ3n362uNMsKtp8xRHAH7ybU4I=
X-Received: by 2002:a17:903:18a:b0:1fd:9d0c:998c with SMTP id
 d9443c01a7336-2050c4a5032mr57038725ad.56.1725010648807; Fri, 30 Aug 2024
 02:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-8-raymond.mao@linaro.org>
 <CAFLszTiWFD2dpb6z_5cibDe0aOpuPYug-mrC-ZiZ7v+SEDFhdQ@mail.gmail.com>
In-Reply-To: <CAFLszTiWFD2dpb6z_5cibDe0aOpuPYug-mrC-ZiZ7v+SEDFhdQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 Aug 2024 12:36:52 +0300
Message-ID: <CAC_iWjJpfrK+-o_0x8ZJbWxhG4O-tprf1-oQvWmLZWOf=5qZMA@mail.gmail.com>
Subject: Re: [PATCH v6 07/28] hash: integrate hash on mbedtls
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

Hi Simon,

On Thu, 29 Aug 2024 at 18:01, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Fri, 16 Aug 2024 at 15:47, Raymond Mao <raymond.mao@linaro.org> wrote:
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
> > Changes in v5
> > - Add __maybe_unused to solve linker errors in some platforms.
> > - replace malloc with calloc.
> > Changes in v6
> > - None.
> >
> >  common/hash.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 146 insertions(+)
>
> I am not seeing the benefit of replacing U-Boot's hashing algorithms.
> They work well and don't change. Also it seems to be making the code a
> lot uglier, with an uncertain timeline for clean-up.

A lot uglier where? It adds a few wrappers that fit into the current
design and callbacks.
I don't think what you are asking is possible. To do assymetric
crypto, signatures  etc -- and in the future add TLS support in wget
mbedTLS relies on its internal hashing functions for the cipher suites
it supports. So what you are asking would just make the code even
larger. Raymond can you please double check?

Thanks
/Ilias
>
> Can you do the rest of the integration first?
>
> Regards,
> Simon
