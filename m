Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BBBC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 07:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EA71885F5;
	Tue, 23 Jul 2024 09:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZNXTEb6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F9D488681; Tue, 23 Jul 2024 09:45:35 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B093D885E7
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 09:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-78aeee1068aso317577a12.2
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721720729; x=1722325529; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CrIS9Mps1j0JrJTs1+wFZEKrU8puIK3pot6ZppuMwyg=;
 b=ZNXTEb6r1mZhTbq9u/tnqQj3pUAot0c+eHhe+pACusoWyH9My0Ow9TqI4a/V6Fbgif
 QzdPh/2zPkm/Do0HPVEQirzYA7v9DNilVwNwvbRHR9WZztJfoAjPWa+gndKjZIkqg1ka
 cAAhlf3zBXa0zg7wHkc2R2J2xvsKG78SVTvIvJssRikebXCoUzEAfOcZZix3axc0/Uum
 fGdSZBbMUbSB0NmZlry7ta9V0z3isvm8Pk/xG9KTRTAAFyE3qU3Q8XICl+NvWPsEWf2r
 9A4sM/PrT88wRotgPlx400Ms6+gMRfC8GwpvXS092IN/pr/DLfI2T0XcDKVQ6Plumrvf
 ed/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721720729; x=1722325529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CrIS9Mps1j0JrJTs1+wFZEKrU8puIK3pot6ZppuMwyg=;
 b=AxMeea4DzPFZ8U4Aqoa4SuVvtWCk1BYeY0re1NzrF+tyjZRnPZR/FCwOMJA+phybQT
 sQnQXV28umqjJXjQPgnArXnDiRZNSTgBkLFcdIwB+nxE9vxHEVkvAiQW0vt+ziiSoPX2
 aTjALF5YDRNUGopNNHjmxHfQzK8RtvwASSTiZxaITp/ZtKpMToBZB5DuavjILCbiG4aC
 fP6nqPBoB5JLvsZaJ96bU4pZscvnH74EXnG1voKUB0+AKbMgz5w4vrv1PwISqc19xceA
 4UAsHcafi7t+pGL79UJmydhVVWMFOnmp91/UdurHxf/pErKuqrV0nFuvqV5TbHGa9PUW
 xfnw==
X-Gm-Message-State: AOJu0Yx6X6dnGQHL2d8StCjBih+fZRgX3dgWbOSSfvUDqXu+2fC7dZxS
 cRR9wh4Ury7PIA3JSRVg1aTLEXldHIXedjShl8TRC4pKQGn+i1ltXSJhk6jcfIx4/ms/l1MTW37
 ixMQ3aF3hOVghWnIwk4w2l7oPfHTt/Ojn1R1XVg==
X-Google-Smtp-Source: AGHT+IG50I6DqiO1wvIu4GHmqpKc0IN2ZorOyLo9zqyv+9V653pL5hV04Sq/oD2Ibwi9h02s1KyYw4E7BYOxtTjBuxI=
X-Received: by 2002:a17:90a:589:b0:2ca:4a6f:1dd with SMTP id
 98e67ed59e1d1-2cd85dc8686mr1747391a91.41.1721720728965; Tue, 23 Jul 2024
 00:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-10-raymond.mao@linaro.org>
 <CAC_iWjKC0sB++5um6TpnOxmkY8DhoNEx76C2UOeKsF7cX8yXCA@mail.gmail.com>
 <CAEfUkUJbwB0ArRRjym7rrS2VX992gbdoUo+F7t+3kE9avLfQ_Q@mail.gmail.com>
In-Reply-To: <CAEfUkUJbwB0ArRRjym7rrS2VX992gbdoUo+F7t+3kE9avLfQ_Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jul 2024 10:44:52 +0300
Message-ID: <CAC_iWj+66_PsWpaRhT7FRiC3GDMV+S+WbrOE7OxSsMTTiSA3wg@mail.gmail.com>
Subject: Re: [PATCH v4 09/29] makefile: add mbedtls include directories
To: Raymond Mao <raymond.mao@linaro.org>
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

On Thu, 18 Jul 2024 at 23:12, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> On Wed, 3 Jul 2024 at 07:35, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>> On Tue, 2 Jul 2024 at 21:27, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Add the mbedtls include directories into the build system.
>> >
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > ---
>> > Changes in v2
>> > - None.
>> > Changes in v3
>> > - Remove changes for PLATFORM_CPPFLAGS.
>> > Changes in v4
>> > - Fix errors when building without "O=".
>> > - Minor fix of the include directories.
>> >
>> >  Makefile | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/Makefile b/Makefile
>> > index 07d7947c8af..fd855dbd5c9 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -829,6 +829,12 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
>> >  UBOOTINCLUDE    := \
>> >         -Iinclude \
>> >         $(if $(KBUILD_SRC), -I$(srctree)/include) \
>> > +       $(if $(CONFIG_MBEDTLS_LIB), \
>> > +               "-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
>>
>> don't you need a full path to the config file?
>
> No, we don't need the full path.
> Since "$(srctree)/lib/mbedtls" is in the include directories, and the this filename is unique
> in the project.
>

Then why are they needed on patch #3? Don't we include them already in
the generic Makefile?

Cheers
/Ilias
> Regards,
> Raymond
