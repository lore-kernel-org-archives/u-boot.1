Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1219C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 16:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14DBA884B2;
	Tue,  4 Jun 2024 18:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WykIrXPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD7A884B8; Tue,  4 Jun 2024 18:05:53 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D63C188476
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 18:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c1a5913777so4659119a91.2
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717517149; x=1718121949; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QJ+3T4d30VuYQNzRz6/3yWJ5jKtidQG/weK/xG0/S6g=;
 b=WykIrXPX3EhQ/K9Gie+mpOl5wHzqqYZqLbCW9vZctvc+aODO/htstWNeAk6m7YAcYY
 eeLu7E6fSYAx8M5PpsVBAO/kxRXiup+AMkOzT2THNKSUUKfo/I4Tt9lvxhM2qyLp9n86
 JUx3TTiNTB9huSbjmMadz0BRIukEx4wNEBk/wvB+3u6udYnRdDBA1jj0wOnozaSl1MH9
 ty9K+SbA8+D5H/vSMO9BKZ79c+Zmx0Pj4oQBUVygCUpC6Zral4m4IoCObu9jUJe2xSP9
 NKhU6eQnt7mTYqHoX5MsZd6+xieAZuHrPvwefTF2Z4HGgp2bfb5rQWm/m0aV5mV3bFaI
 kq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717517149; x=1718121949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QJ+3T4d30VuYQNzRz6/3yWJ5jKtidQG/weK/xG0/S6g=;
 b=uVE8QJho4NdKzntOXMQ7VgloZ2ZsBH18FrdpBGWT4POag+ppfgW0aUS8cN6wq0bAQm
 wfh5aW5r1kGBuNsJs8JV0RHw3cUfaqSkbMnRFnl7nJ+5A2d/uoYzpm291iepj/n41NqX
 7D50qMXViPgj9hSNdR0jpPuSCeHHAFSB+47g3GY3h0CX0Eq9+9MSI38DbsB/HxmYwGjS
 WlwOS5YndN5MFtMTemHz4KwECBzl3ufYJNbL+eGp6NPhXavYSrffWcXAYe2jU1Q/HJTi
 fMATwx8nEGXHouVukwoEL18FCiFt02BjEynY/ueBJSrsJsXRUxUEhUUbhZTOBmc2k8Br
 lp9A==
X-Gm-Message-State: AOJu0YxUAbX6zfq3hMKmsYJhdrTM4IaI9mLNy+jpHRRufvHa/onAg73n
 2HQCznlV1OZyMu+dRdGB7GcrrTDCDLpbdfMj6j+TV4P4y0IB51XD70Mm55r6ynM/g2UM94BiiaU
 7ZJL/OPqfJ+hT/WOHH4oiAFU84dcbCZWkYLEwJmYyuVAz/5gW
X-Google-Smtp-Source: AGHT+IHQWKyFNdzPVfGFRAoP9uO8h2ctSq5VPorg8P6hjMMFYpDV0myC7cS0JRONoQOthKT2Dxj09tjU9lugXAaDm+U=
X-Received: by 2002:a17:90a:f982:b0:2c0:15e1:b96b with SMTP id
 98e67ed59e1d1-2c1dc56c3b0mr11564890a91.6.1717517149111; Tue, 04 Jun 2024
 09:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-16-raymond.mao@linaro.org>
 <CAC_iWjJry9zAU0B5P+dmBj6E9m+NZqGEZhGj3FZ08SB3q7B1Vg@mail.gmail.com>
In-Reply-To: <CAC_iWjJry9zAU0B5P+dmBj6E9m+NZqGEZhGj3FZ08SB3q7B1Vg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 4 Jun 2024 12:05:37 -0400
Message-ID: <CAEfUkUJ64bwK_+mz5o_R1RwMtYoLD6=3xtMn-o2czJh5NHi14w@mail.gmail.com>
Subject: Re: [PATCH v3 15/25] mbedtls: add X509 cert parser porting layer
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Michal Simek <michal.simek@amd.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Bin Meng <bmeng@tinylab.org>, Eddie James <eajames@linux.ibm.com>, 
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

On Fri, 31 May 2024 at 07:42, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Tue, 28 May 2024 at 17:15, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Add porting layer for X509 cert parser on top of MbedTLS X509
> > library.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Move the porting layer to MbedTLS dir.
> > Changes in v3
> > - None.
> >
> >  lib/mbedtls/Makefile           |   1 +
> >  lib/mbedtls/x509_cert_parser.c | 497 +++++++++++++++++++++++++++++++++
> >  2 files changed, 498 insertions(+)
> >  create mode 100644 lib/mbedtls/x509_cert_parser.c
> >
>
[snip]

> > diff --git a/lib/mbedtls/x509_cert_parser.c
> b/lib/mbedtls/x509_cert_parser.c
> > new file mode 100644
> > index 00000000000..b0867d31047
> > --- /dev/null
> > +++ b/lib/mbedtls/x509_cert_parser.c
>
> [snip]

> > +static int x509_set_cert_flags(struct x509_certificate *cert)
> > +{
> > +       struct public_key_signature *sig = cert->sig;
> > +
> > +       if (!sig || !cert->pub) {
> > +               pr_err("Signature or public key is not initialized\n");
> > +               return -ENOPKG;
> > +       }
> > +
> > +       if (!cert->pub->pkey_algo)
> > +               cert->unsupported_key = true;
> > +
> > +       if (!sig->pkey_algo)
> > +               cert->unsupported_sig = true;
> > +
> > +       if (!sig->hash_algo)
> > +               cert->unsupported_sig = true;
> > +
> > +       /* TODO: is_hash_blacklisted()? */
>
> Is this supported by our current implementation?
>
> This is not supported currently either. I just copied the TODO mark
from legacy lib.

[snip]

> > +               }
> > +               goto out;
> > +       }
> > +
> > +       pr_devel("Cert Self-signature verified");
> > +       cert->self_signed = true;
> > +
> > +out:
> > +       return ret;
> > +
> > +not_self_signed:
> > +       return 0;
> > +}
>
> the whole function looks like a copy of lib/crypto/x509_public_key.c.
> Can you move all the c/p ones to a common file that the existing and
> mbedTLS implementations can use?
>
> Per a previous discussion with Tom, eventually we tend to keep only one
crypto lib, that is the reason I prefer to copy/optimize a few existing
functions into MbedTLS implementation instead of creating another
common file.

Regards,
Raymond
