Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CF9C3DA61
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 20:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A926788AD2;
	Thu, 18 Jul 2024 22:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YFuMTwgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5AAC88AD2; Thu, 18 Jul 2024 22:02:01 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B0E388ABE
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 22:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fb4a807708so11697335ad.2
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 13:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721332918; x=1721937718; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z8nGBOuqIJZlY8MzWiHj27h+4+hbitnBfz+bzvyUP3w=;
 b=YFuMTwgFuXbd/BSmw3vOXMnbdDNfgxGxum1x0EpPzHjQmjxfDfrtaoACxkqPjppdRQ
 7oSpfyahx+N/iUc9DzlxPfvl5CjC1TVH/ClIe5ko8Gpso/iNQ3YjA+qDCn5J9JtDgegv
 i6y+ki6em7ybJZhbyndahc6KCokmIYWjdaNBDxdqZtSqEFIoyzVk1R+dTuMCm7k6Ho6p
 m8wQClpECAowvPMJY/8m+vxpoegf8WlPoi1ezvTDnZFDYq60/JxlqDucephJode/PQhj
 9lvv/Me8JMxWWPhBn64JGO3lLW0W4NJkz3XLQCQMlZdky9UKXuydvysTw0YPqXTWbs83
 WyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721332918; x=1721937718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z8nGBOuqIJZlY8MzWiHj27h+4+hbitnBfz+bzvyUP3w=;
 b=pwbiOeEpa2T4gZYpBU4R5EZkzYL2pVmU5ARN0zVci6qXw17v4IkI39xvIe8HqEONeN
 WxBGySshWrBftRka1Lt1gO447L+OVYnha+3haDzjHQYBWNdO0OuA/BMb91xb9s3ZQm2Y
 MhHBOVmCmahTUAomNwSvMv+Z8c5VTvczI9L2ie8Hr0to5ypHNFdQq9k+rdBQm/LCHMnh
 ThLKdlxsgX74XDTPzgmGcuZ/5WSrE+jdt80495YDvg4w8XqOTobEDSDmmUMjyGKiaUZA
 patugsImUaT8UqHhjJH2WjxmXQW0Giq/xfbDn8fHFnxObJI/lIhT7fZehzmdXq5rXRCF
 NCGg==
X-Gm-Message-State: AOJu0YzhqCdHr68RhjMlHH7c+h5I6p3xn/Vb5Tg0zlQE6X08uum8W2ar
 RwsIsuZHmrKhWUR/UPbvTrirW5VzXotmNUT64DLcEAGhhlkE6Lm7I7SP64x7iJ4a052UHXozg+1
 FERQL2akUF9sM6Xm1mYCwBP6TH2wwlrg/BloJ9Q==
X-Google-Smtp-Source: AGHT+IHMJ1CLQA1vjC1eWhC7cml7lXHCKFYdtfjWlhAuPiUCESPixGEvYyx6VhYzxeKq8uVfyt0J932XQfg2jXQdGjg=
X-Received: by 2002:a17:90b:30ca:b0:2c8:ac1:d8c3 with SMTP id
 98e67ed59e1d1-2cb52927e76mr5158530a91.29.1721332915831; Thu, 18 Jul 2024
 13:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-10-raymond.mao@linaro.org>
 <CAC_iWjKC0sB++5um6TpnOxmkY8DhoNEx76C2UOeKsF7cX8yXCA@mail.gmail.com>
In-Reply-To: <CAC_iWjKC0sB++5um6TpnOxmkY8DhoNEx76C2UOeKsF7cX8yXCA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 18 Jul 2024 16:01:44 -0400
Message-ID: <CAEfUkULg9O=et0pPi1c4ZnbL2mxK7c9CQ5KzdzF9A5y_MH1D+A@mail.gmail.com>
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
> > +               -I$(srctree)/lib/mbedtls \
> > +               -I$(srctree)/lib/mbedtls/port \
> > +               -I$(srctree)/lib/mbedtls/external/mbedtls \
> > +               -I$(srctree)/lib/mbedtls/external/mbedtls/include) \
>
> Most of these paths are explicitly added in patch #3. Why don't we
> just keep them there?
>
> We still need this for building other modules other than the MbedTLS
library itself.
For example, when those files include the "hash-checksum.h".

Regards,
Raymond
