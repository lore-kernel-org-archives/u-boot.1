Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3E2C3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:07:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2021C88607;
	Tue, 30 Jul 2024 16:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OI0NynUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F8E3887B9; Tue, 30 Jul 2024 16:07:57 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADADB88276
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70eaf5874ddso3274433b3a.3
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722348473; x=1722953273; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rPnmFE7TVhRzyujJycznLpvEQumdxhMgfWUAB4l1ZYQ=;
 b=OI0NynUsx7m9twel0NTv0oSTkMhhQCShzhjs6zIM7xBpW2cr6kyc6KNlZ1jA/qDrnL
 p6NfCmdS4JCNCpqJB6gmnHhO4HJ243vNueMFGZhcW7OXbi3v5iNAa2hCUZwdij+zk1g9
 QgXYBNkTp0Ke7JpdGqivXkBJcWWi+yxRaUipOjE73Fo+Z7kX6CM61TNpW94/4S6x1J/F
 bdBnnNbOOYjh2zStIF3isbi6szWDQVSIVV9HnK2xENnTaNgxa+zmRRUt8E/tNYpsP1m8
 WErGEmvg7pM8G/yE1ncFcr5DN8GhTKL6W4+lan834UZ4f6+sdad7yncv/ZZICNMypeuU
 qpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722348473; x=1722953273;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rPnmFE7TVhRzyujJycznLpvEQumdxhMgfWUAB4l1ZYQ=;
 b=RMhAGVx5+ZII1J8beyXfcCY286l88+Bp0OIxdm00c6ha1t+uOtytHZHGNvqWTTJAsp
 kBpHRkoOb5RtGYtxW6JglM0ByMDLZqOTWoqwp5HtGZ7u+4/2xbaKySAfrRDVDqwdY0HS
 4WDshm9QLOyFY8WFxM09Kz03FRN0xWp7c863gB08SdG3vTuhL2CHh4LgWGfS6w7mvuyX
 JvQOE//rgZWO/U4RsOMuabaeTo9aHhWaAwo+a9cuK/R8GXZvNBz7+gbDl1ES/oprMQF1
 SFuQ5fsyENdCmfI7th6eUUjTjCek6sHPmZzgzLFKSW3hWozRa/XQTA+Yrxd5TSMWvRPy
 TRyg==
X-Gm-Message-State: AOJu0Yy2Rwk2NlhiPj83UI43UaqArtdyljTM9y9PuQc6ibp0XmZ+gnA7
 tt+ZF01XJp/SVkWkYvoEeD1qQ+30p9xXlnlQD8qxhT7j2fP03MKtZeIfbvqI20tNmWzoXRdqJEG
 oNhs0kzQHPQ+Gnac3spSjLem+rZFSQfAg6wcOuw==
X-Google-Smtp-Source: AGHT+IHdVDLXsIC8O/vEuILtednmq5mJXSF+bNem3zj7XJv+RO+rg7972DGP4WPM+CYRw3DqXNAEWES8vGw42RFEo1Y=
X-Received: by 2002:a17:90a:a60c:b0:2c9:6b02:15ca with SMTP id
 98e67ed59e1d1-2cf7e879c76mr9706519a91.39.1722348473113; Tue, 30 Jul 2024
 07:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-25-raymond.mao@linaro.org>
 <CAC_iWjLfbb4OZOxxmY2VCOagWV2OBTghD=zJsN89u3QTvT4fuw@mail.gmail.com>
In-Reply-To: <CAC_iWjLfbb4OZOxxmY2VCOagWV2OBTghD=zJsN89u3QTvT4fuw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 30 Jul 2024 10:07:41 -0400
Message-ID: <CAEfUkU+1yRFqbgEcDsPfxnV2H2SJLrzpkFz36mvRuZCTe=oCBw@mail.gmail.com>
Subject: Re: [PATCH v4 24/29] lib/crypto: Adapt mscode_parser to MbedTLS
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
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
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

On Tue, 30 Jul 2024 at 04:04, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> On Tue, 2 Jul 2024 at 21:33, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Previous patch has introduced MbedTLS porting layer for mscode parser,
> > here to adjust the header and makefiles accordingly.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Move the porting layer to MbedTLS dir.
> > Changes in v3
> > - Update commit message.
> > Changes in v4
> > - Control building legacy library via '_LEGACY' Kconfig.
> > - Minor fix of the include directories.
> >
> >  include/crypto/mscode.h | 4 ++++
> >  lib/crypto/Makefile     | 2 +-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/crypto/mscode.h b/include/crypto/mscode.h
> > index 551058b96e6..678e69001b9 100644
> > --- a/include/crypto/mscode.h
> > +++ b/include/crypto/mscode.h
> > @@ -9,6 +9,10 @@
> >  #ifndef __UBOOT__
> >  #include <crypto/hash_info.h>
> >  #endif
> > +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> > +#include <mbedtls/asn1.h>
> > +#include <mbedtls/oid.h>
> > +#endif
> >
> >  struct pefile_context {
> >  #ifndef __UBOOT__
> > diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> > index 428dcba0a6b..9bbd8b48d77 100644
> > --- a/lib/crypto/Makefile
> > +++ b/lib/crypto/Makefile
> > @@ -63,7 +63,7 @@ obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
> >  #
> >  # Signed PE binary-wrapped key handling
> >  #
> > -obj-$(CONFIG_$(SPL_)MSCODE_PARSER) += mscode.o
> > +obj-$(CONFIG_$(SPL_)MSCODE_PARSER_LEGACY) += mscode.o
>
> The change it self is correct. But patches should be self contained as
> much as possible without breaking the compilation or functionality.
> IOW I think this should be in a different patch where the
> MSCODE_PARSER_LEGACY is introduced.
>
> No worries, I can move them into the same patch.

Regards,
Raymond
