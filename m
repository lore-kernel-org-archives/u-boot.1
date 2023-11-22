Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71A3C61D92
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 05:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48CAF875A2;
	Wed, 22 Nov 2023 06:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YyDdyU+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B35A87582; Wed, 22 Nov 2023 06:24:39 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6842E87118
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 06:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-548f35e6a4bso2551879a12.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 21:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700630677; x=1701235477; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ab/57ImaMKDlDZq200GHJyNqEu/1rvm5INzWKUmzoDk=;
 b=YyDdyU+aquERbjhRvzFUa/AQ+W4px3WDCRrDczBPqWK3Wn/HYuBHnW24Q3/V1E/TGi
 vb20mwKR3daiuuLsJ+85zN7FawvcJsxFzQGu0CjyE/r0OUnWTrxYorCE9VCjmveB0lG1
 z+oDIvcUvclPKTqbi1DYMWP1+V48mySYh9GHN5X9NZ+JgrudfAVkI2i8t9tKXdAx3cKL
 GB7UmVIg35Ha4IGDJV7C8hrD01UqkdByJGpqWvTiMlt2pDDTS9hQO79f/Dw+liC4A7XJ
 vTBbYuEaKCCZQtDnWYVAyWSjOroNQGEDMyEUb7aH5h47SJEf/T+6ASK8F/u/KHwlE9w8
 Pgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700630677; x=1701235477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ab/57ImaMKDlDZq200GHJyNqEu/1rvm5INzWKUmzoDk=;
 b=TC1I7USnedKC9pbXffYsDk7IzcNk2lr8Z7BmwhBKweBPIzXi0kYrjdXIf6p80WCkAC
 Yi6YJRno+7MjmPlILvhH8zhwKNQP9hifNopxKTFMq/QSBKK5SQLPgYOCBMWi5otSli8T
 /mPyqgPI9N3mCf6LlwHcWykAcOxJqs/nJTmqOgrkAxxhTHCgLMDEIuzEw7g8yhanZJEA
 ZMlqU4RiCljMOK3N5rauV/mNxmBvoG2xXciYeFfOkEsrUXB4iXsT6nML+aFgZDxEPCkq
 zGfUCkHln8HByGFEq7ZxHIEMDnTsR7HszHOohUh9GFaTulOKdCG/wwe5z55/OczvfA97
 jJKg==
X-Gm-Message-State: AOJu0YxmFc3eh6vvbs8s9lWd+ePByTBRy5I2NnJ18TWqQ1RiHv6SxaZK
 k7hAPZmMPQbEDU0rGgp67cFxjEl8h236h+u3fcD12Q==
X-Google-Smtp-Source: AGHT+IFPJGVr/JMlZZxOZg8VeIjhAaTMlTvRwx1RiRGw7QahwPXC6fOKt+ZK76WUq7WmlCd9TZCF0UalS+/z02ggRgc=
X-Received: by 2002:a50:ee94:0:b0:543:5cfa:ba41 with SMTP id
 f20-20020a50ee94000000b005435cfaba41mr985572edr.25.1700630676902; Tue, 21 Nov
 2023 21:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
 <20231121070028.2614095-2-sughosh.ganu@linaro.org>
 <CAPnjgZ1croWnY9nYYEjiJZB1kO4SB_+aQOb6_yhYJcj-McfuAA@mail.gmail.com>
 <20231121222440.GM2513409@bill-the-cat>
In-Reply-To: <20231121222440.GM2513409@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 22 Nov 2023 10:54:26 +0530
Message-ID: <CADg8p96OaNr3gANYMXnOvey5dhkUrhK5AV_cHTXQ2GshWV8H7g@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools: mkeficapsule: Add support for parsing capsule
 params from config file
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>
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

hi Tom,

On Wed, 22 Nov 2023 at 03:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 21, 2023 at 03:11:50PM -0700, Simon Glass wrote:
> > Hi Sughosh,
> >
> > On Tue, 21 Nov 2023 at 00:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Add support for specifying the parameters needed for capsule
> > > generation through a config file, instead of passing them through
> > > command-line. Parameters for more than a single capsule file can be
> > > specified, resulting in generation of multiple capsules through a
> > > single invocation of the command.
> > >
> > > The config file can then be passed to the mkeficapsule tool in such
> > > manner
> > >
> > >  $ ./tools/mkeficapsule -f <path/to/the/config/file>
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >  tools/Kconfig              |  15 ++
> > >  tools/Makefile             |   1 +
> > >  tools/eficapsule.h         | 114 ++++++++++++
> > >  tools/mkeficapsule.c       |  87 +++++----
> > >  tools/mkeficapsule_parse.c | 352 +++++++++++++++++++++++++++++++++++++
> > >  5 files changed, 538 insertions(+), 31 deletions(-)
> > >  create mode 100644 tools/mkeficapsule_parse.c
> >
> > This patch keeps coming back :-)
> >
> > Can we not add multiple capsules in the binman description? Why do we
> > need a new file format? How can binman decode images produced in this
> > way?
> >
> > Also, could we get sandbox to produce one EFI capsule as part of the
> > normal build? I think that discussion trailed off.
>
> I believe part of the answer here is to support the config file format
> that other capsule generators use. Do I recall this all right, Sughosh?

Yes, that is correct. There are some other reasons as well, which I
have mentioned in the reply to Simon's email.

-sughosh
