Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C582FC3DA61
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 20:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 455088867B;
	Thu, 18 Jul 2024 22:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IR5VKgO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCC978869E; Thu, 18 Jul 2024 22:12:17 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83BED8867B
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 22:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7611b6a617cso732396a12.3
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721333534; x=1721938334; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NBB5y1lVoJSr7WfOxPb4tdGRbvPwMyiIFLwmhXLcOrE=;
 b=IR5VKgO4dn0StmiWZsw/+twfJHMOm9Ffu7M+WkQyVU35bljBqiuf/gLjkfLWRT9c0g
 R1+jBSkI/mgpBy9R/gIHUxNEEOaqeIEIrGpRMUgEWmk7672Qmec1jxOcffrCbALjI/bv
 DMqVFM/E8YwssjPPrgQP+PP8aCpehdLWUgo8N4zJ9OMaebXQLfXqw7/3UXd5es0qyVYE
 R3OaR4tIN1QIP06lIOsJXPMGw71+b3QOt/U4D6J8yqFc+gAdVppePQrjJnSeGAsjD3Cl
 mqxEred077sMxNkKmnHx75H1f13pxL+0iWtKJ6kJf+k2UyMJlBjThKKPBTNI5rbzDbkJ
 +mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721333534; x=1721938334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NBB5y1lVoJSr7WfOxPb4tdGRbvPwMyiIFLwmhXLcOrE=;
 b=KC2P84zQt9oHOKKrRWk6W7Oa2DpOH4RKeTS1eOV0sVzPPi/kg2PfT9/vZaZzwq5IQS
 TY3OvHUyyelCkMJJFDITxHSjB5aYJhrdQMIn/ThfivvAZMFymVsEFqUXTP161oevFCSv
 G4hwzHAdqoU0SwVDnTxRMFh8GRCZFJ3AJ3YMmp1gDj9WSbQGrgCncKNiC8+IJzj5Z7FS
 mnk07SZUd6wRVRdbRFjGFng1lRZeIt7F+sC6opvfMRM0FnSCmUz+53RdN1zUf8E2RG4v
 9zphlyS4bQJB9h7x8NtVe0mFKPb4n93vDg9xvOUlV77W0g/E/mMNH0p/uJ981GBwlHAC
 g47A==
X-Gm-Message-State: AOJu0YyWNfDEds2MY+mSoD1jtWtBCXyND2O47+0GsR8lKO8QxG79teB3
 Mbi3PxHDMG4PsbPmy/RloLhk/an7m19slI5liaf5+f+R+6o8jJiNjBng/1aHwWXGZfkOOoQ4QHj
 HZoDE3+IXhcfvuVVVtX5VcZdXfua1wQYXbFXTKA==
X-Google-Smtp-Source: AGHT+IGPXKAr1MmNGOaa/db9h9CIsM/8s8yHZICStlT5715ZKVYj26vTlt6zTap7kE7S3TlA/5YZVeaXuUo+FjrauZo=
X-Received: by 2002:a05:6a21:9990:b0:1c2:9084:fcf with SMTP id
 adf61e73a8af0-1c3fdc95392mr8401864637.14.1721333533974; Thu, 18 Jul 2024
 13:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-10-raymond.mao@linaro.org>
 <CAC_iWjKC0sB++5um6TpnOxmkY8DhoNEx76C2UOeKsF7cX8yXCA@mail.gmail.com>
In-Reply-To: <CAC_iWjKC0sB++5um6TpnOxmkY8DhoNEx76C2UOeKsF7cX8yXCA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 18 Jul 2024 16:12:02 -0400
Message-ID: <CAEfUkUJbwB0ArRRjym7rrS2VX992gbdoUo+F7t+3kE9avLfQ_Q@mail.gmail.com>
Subject: Re: [PATCH v4 09/29] makefile: add mbedtls include directories
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
 "Leon M. Busch-George" <leon@georgemail.eu>, Ilya Lukin <4.shket@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

On Wed, 3 Jul 2024 at 07:35, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Tue, 2 Jul 2024 at 21:27, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Add the mbedtls include directories into the build system.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - None.
> > Changes in v3
> > - Remove changes for PLATFORM_CPPFLAGS.
> > Changes in v4
> > - Fix errors when building without "O=".
> > - Minor fix of the include directories.
> >
> >  Makefile | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index 07d7947c8af..fd855dbd5c9 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -829,6 +829,12 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
> >  UBOOTINCLUDE    := \
> >         -Iinclude \
> >         $(if $(KBUILD_SRC), -I$(srctree)/include) \
> > +       $(if $(CONFIG_MBEDTLS_LIB), \
> > +               "-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
>
> don't you need a full path to the config file?
>
No, we don't need the full path.
Since "$(srctree)/lib/mbedtls" is in the include directories, and the this
filename is unique
in the project.

Regards,
Raymond
