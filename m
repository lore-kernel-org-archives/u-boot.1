Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3975C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 21:50:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1730C88103;
	Tue,  4 Jun 2024 23:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LNrZ7LhJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D15658813A; Tue,  4 Jun 2024 23:50:24 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F51D866EB
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 23:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2c21d7de619so2404363a91.2
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 14:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717537820; x=1718142620; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ww2NjvJoVotKaomec8YH5lCEqrMpgO8IeSiMTRziwTQ=;
 b=LNrZ7LhJzd/MGyZAbz0FBXGepYnbaiktVOBu9DX85W3TWfYSeSxKqLcI5F6SoCy5o1
 AGFzhpp8M/sZRU+KptX3QuyiQrEYbm7cxTe2xx5PRUppFPuqJ8PQQZ0Dl2g/S7S3NA7j
 jSo/jO7heLPtNgh9cNspHHAFqdgZCWKzRF5tlHDu40BF/ZcHGu6yCgPH6E1avkwGzl37
 UcGxBdT/mxhLrnjuChWRceB5fJOAZJ44rHUHu9cCOAUjin9QvhsFbegBnMr3uZuEwEIB
 Hz2shLQFfznUiTQN/k8Ok5uL0dTXuHkDOQtjRD7UnxVY0oITJIv1FTHv0NrWtUSfOvTV
 vgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717537820; x=1718142620;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ww2NjvJoVotKaomec8YH5lCEqrMpgO8IeSiMTRziwTQ=;
 b=sEgPG+uN/P/uX/RjmREwk7oERiCUA5PGb2PLWLle9iHflE5xFLgMEPpD/ixE03WXiW
 3Gzi4sa20WiG3CE1SWoHAh8Uu2f8Smhm8JbT1NpOAFKnmsu10WMijLNgbKwFDTEaWOzE
 uXOjgUqYs/A/DMvGLkqlSyQtylNlnCr9aM/uD7YIcqo1s11pjf2s8Jkk43ZZIvwVknv+
 MwlkRvEIr/pED0PTHXxxT+i5B6pIrNXXvThgPXTEyhGdT8OTX+/wTF8UDM5oLzvofvGv
 GGUYrUufinJyjh5UcYki8xiYik75pCK4+LT2lnU6fLXvObvbwKMBp/hbWFXiAp5s77N1
 XP3A==
X-Gm-Message-State: AOJu0YzBnpVDgNEYpAAlc73U3A1bhlKJ+32ieVrPgEfPUA2KNVZiDoLe
 5UnBzQAFtmTimtwsd+ic8CpiqDNXkFPbyiQS+g+XaRoM5OBI0OBWNV1bTG06vSmkBw3BrZWxHUs
 TKeO12rsTQsOYDuneFJZk4qu1phHDaSeo6LK7DQ==
X-Google-Smtp-Source: AGHT+IEWkHWGcoRN3FP4joqMk3xtwLy0O3sYYRPbpUWZ2tGu8hbcQbWwB0/UERkqijx3zEnNTc623wNo2yWlsOqnRiY=
X-Received: by 2002:a17:90a:38c7:b0:2c2:53f9:56fe with SMTP id
 98e67ed59e1d1-2c27db19ea5mr627986a91.24.1717537820437; Tue, 04 Jun 2024
 14:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
 <Zl92YrE0tw-15wzZ@smile.fi.intel.com>
In-Reply-To: <Zl92YrE0tw-15wzZ@smile.fi.intel.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 4 Jun 2024 17:50:08 -0400
Message-ID: <CAEfUkU+tcgjs61thzAiNVsBZEVDUTY+BBAxNQFuemHsfzWf9Sw@mail.gmail.com>
Subject: Re: [PATCH v3 03/25] mbedtls: add mbedtls into the build system
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Stefan Bosch <stefan_b@posteo.net>, Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>, 
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

Hi Andy,

On Tue, 4 Jun 2024 at 16:17, Andy Shevchenko <
andriy.shevchenko@linux.intel.com> wrote:

> On Tue, May 28, 2024 at 07:09:14AM -0700, Raymond Mao wrote:
> > Port mbedtls with dummy libc header files.
> > Add mbedtls default config header file.
> > Optimize mbedtls default config by disabling unused features to
> > reduce the target size.
> > Add mbedtls kbuild makefile.
> > Add Kconfig and mbedtls config submenu.
> >
> > Prerequisite
> > ------------
> >
> > This patch series requires mbedtls git repo to be added as a
> > subtree to the main U-Boot repo via:
> >
> > $ git subtree add --prefix lib/mbedtls/external/mbedtls \
> >       https://github.com/Mbed-TLS/mbedtls.git \
> >       v3.6.0 --squash
>
> Is this approach maintainable?
> I don't remember if we have similar in Linux kernel, for example.
> (There are few candidates like compression algorithms that are usually
> being
>  hosted elsewhere)
>
> > Moreover, due to the Windows-style files from mbedtls git repo,
> > we need to convert the CRLF endings to LF and do a commit manually:
> >
> > $ git add --renormalize .
> > $ git commit
>
> ...
>
> >  lib/mbedtls/mbedtls_def_config.h | 4262 ++++++++++++++++++++++++++++++
>
> This is ridiculously HUGE! This is unreviewable. Moreover, this is even
> hard to
> configure by the user! Can you rather make it modular and maybe create a
> separate documentation for the most important options (I do not believe one
> needs _all_ of them to be set / tuned)?
>
> This is a file from MbedTLS and follows its own style.
And this is how MbedTLS is configured - with all features listed in a
config file and
commenting out the unused features with "//").
The modification here is just to control those existing options with
Kconfigs.

Regards,
Raymond
