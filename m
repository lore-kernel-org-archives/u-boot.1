Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107E2C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 17:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C41F8708B;
	Tue, 23 Jul 2024 19:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GdQgULLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53C4B86FB1; Tue, 23 Jul 2024 19:05:33 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 649F4884BC
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 19:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7a0b2924e52so575136a12.2
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721754322; x=1722359122; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iC24oS3XU9L3EekRuR/LwdCcsR7furXkeeFv1SeM3MA=;
 b=GdQgULLcPRz6aCaR2PKYndWnpmMsOwphQwhypEmn9wK6KCtzTLZpLQ81H+1F0OTPMg
 oH209FovMERsmtjHSNp+8a5e4IyFD9xcm/5PCrHPbvEI+SzipMIOPoxjyzuAUSfOXDPv
 KNNlmE14Vb0CpOHeYV/V373FcKEZPqgcWQUEqW6Oq+C57sddI5kW7pbd+pHxoLOb07uR
 Dmlx2d4mUIASgOqQMBA3Pd7G7E/uk25V+90Z3Gj8Z+UmGdRcTcpGIKvTRWS6jGM9k930
 Frmq5hsR7fr4T4fV0mtUafOx527k+wz/0nvbLFizRJJ7wqYxYiUBf5kxXi1EqqL2MqTr
 cmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721754322; x=1722359122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iC24oS3XU9L3EekRuR/LwdCcsR7furXkeeFv1SeM3MA=;
 b=TPexW+iyNSNtjy8llny95bOtL7zHrwQZ/KGhPfVEcHLplYTqD+GClxj0Cr/L00teD7
 9B8xmb/6ALO63CyY3hgLoDkkFAwvMRG0y6dW7uqF1r1wmZs+SyQar7s+J0IPaD4yiUoS
 DQTSLQy2pBnv+gypMnzR3UstM/VDG8N9HuvIPOYFteMlP5C95tgNvtrluXoNyNb4rdg+
 TlJIwnknmAj3ZsyRU4x6x0B+UC1qstdhBHhUe4kBtCZMQzYU3QWkVwsrBz9rZKiKTWWk
 6sOCWOA6M0rzeAzAE74APIvt5nz4K0IIenRo3YxbWehgtZgUtvD73OgG1ZJ2A/h1i8DP
 KHhA==
X-Gm-Message-State: AOJu0Yx2z993UFMXEGHyG/W8+Dx2h+NMN/r1OaL37SndUww5m4fSTqdy
 Sygch4RbOcXbfUyK7HNlicyPgsZeSQD0hMlKG4SV+dgekeYVMyY3HIWLXFHelLKIQB5nSWvUY98
 Nuq6ZkP1Tgf+xzmrK2eFp0imucl2twUSY7qDwog==
X-Google-Smtp-Source: AGHT+IFa9QFqa+Vi+D3Fz/XC1RO/TbIyxGwamhoregSimkh401mRYQUO2FAvH8PeZY/Qu5dkmOZygVAbdwW3ErIXxso=
X-Received: by 2002:a17:90a:d905:b0:2cb:4c32:a7e4 with SMTP id
 98e67ed59e1d1-2cdae32bf39mr322142a91.15.1721754321738; Tue, 23 Jul 2024
 10:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-10-raymond.mao@linaro.org>
 <CAC_iWjKC0sB++5um6TpnOxmkY8DhoNEx76C2UOeKsF7cX8yXCA@mail.gmail.com>
 <CAEfUkUJbwB0ArRRjym7rrS2VX992gbdoUo+F7t+3kE9avLfQ_Q@mail.gmail.com>
 <CAC_iWj+66_PsWpaRhT7FRiC3GDMV+S+WbrOE7OxSsMTTiSA3wg@mail.gmail.com>
In-Reply-To: <CAC_iWj+66_PsWpaRhT7FRiC3GDMV+S+WbrOE7OxSsMTTiSA3wg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 23 Jul 2024 13:05:10 -0400
Message-ID: <CAEfUkUJskfWPs7HH_sE1SgbYdTCmN2OJOoaB9frCpVxcJMTyYg@mail.gmail.com>
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

On Tue, 23 Jul 2024 at 03:45, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Thu, 18 Jul 2024 at 23:12, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 3 Jul 2024 at 07:35, Ilias Apalodimas <
> ilias.apalodimas@linaro.org> wrote:
> >>
> >> On Tue, 2 Jul 2024 at 21:27, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> >> >
> >> > Add the mbedtls include directories into the build system.
> >> >
> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> > ---
> >> > Changes in v2
> >> > - None.
> >> > Changes in v3
> >> > - Remove changes for PLATFORM_CPPFLAGS.
> >> > Changes in v4
> >> > - Fix errors when building without "O=".
> >> > - Minor fix of the include directories.
> >> >
> >> >  Makefile | 6 ++++++
> >> >  1 file changed, 6 insertions(+)
> >> >
> >> > diff --git a/Makefile b/Makefile
> >> > index 07d7947c8af..fd855dbd5c9 100644
> >> > --- a/Makefile
> >> > +++ b/Makefile
> >> > @@ -829,6 +829,12 @@ KBUILD_HOSTCFLAGS += $(if
> $(CONFIG_TOOLS_DEBUG),-g)
> >> >  UBOOTINCLUDE    := \
> >> >         -Iinclude \
> >> >         $(if $(KBUILD_SRC), -I$(srctree)/include) \
> >> > +       $(if $(CONFIG_MBEDTLS_LIB), \
> >> > +               "-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
> >>
> >> don't you need a full path to the config file?
> >
> > No, we don't need the full path.
> > Since "$(srctree)/lib/mbedtls" is in the include directories, and the
> this filename is unique
> > in the project.
> >
>
> Then why are they needed on patch #3? Don't we include them already in
> the generic Makefile?
>
> I will remove the ones from #3, and then squash this patch with #3.

Regards,
Raymond
