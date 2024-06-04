Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD55CC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 16:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BBE388499;
	Tue,  4 Jun 2024 18:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j3Th/rsp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B69E88813F; Tue,  4 Jun 2024 18:54:35 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DC9687842
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 18:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-578517c7ae9so1641838a12.3
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717520073; x=1718124873; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x6vwYDS0ecoZV5NzO14pd+Uwwd/Gu6BobE422eLzlDY=;
 b=j3Th/rspURrItIO8mYJO1O6EsCbGnSE1qAQfIkFhFWUjb+Te7xDG3NeYlYH9gxOx08
 eE4WsWyYcopWv3iHopx3gRsoBJVxzoH1SzrJvbTQQFfhfeZObnsrgh+T9l0rdanOvz1p
 7OE8jMkTbpvZ6od1Fhb4KrZWLpvCjtWqFQpI3JmmdfEG13MApafm8HTJDozybdJ+kNmy
 urSfLyaZWbGPTyxYR+bOKfCbUkMoBGrRgYw3IYyaSZVdfyhUPbTSiVFmDcCSUflRt0ob
 86DH9c4oUXoeVr01vl5lTOBuFS6ELfrMzXAo8us25Zgj2RPPE/7qeC4x+C1Md+ncv58h
 VY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717520073; x=1718124873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x6vwYDS0ecoZV5NzO14pd+Uwwd/Gu6BobE422eLzlDY=;
 b=M9OBRULrN4sjbvqHzrAsub+88KX1++MTge+4bPC5W7q2C+0RT1aWjxCfR45nPLdOjO
 DEP7sVv9k+KV1iHa5rnDelK/dkup9ldkHW6IsyefsIwvUafNZICkx9K9oYbE8mciHDVm
 MzIDTV2/HNQ38l5AXOhsLBJIERWEAvE+C9AbjvHNfApWolmKfY+9p9RCKfXwBIk9jm0C
 poBfKP/PvTV1ll5CNFwi/dlyTkT3xIvZjCyyib9Ntgmu/eVQS/NAwi8+GcczEUUo+hpk
 ZmNPXrxUC79SR9BKHG3ujFE5mwRQsCQP7OMhlwf0iFY237byB0uUNfNR9VKMd1hdSjWL
 0BjQ==
X-Gm-Message-State: AOJu0YxTzrSdMU3h85GpR510NR4uStn4+/KKMo7q2K1wP6jgW4jXvBVx
 R5GcE9EIdq7YgwZWQHgbd6NNJR4sfFXdbV/fqd6N2GfHOVG85SeUCSOeT7qOlVD0N80kDJJNfRB
 BEG8qhbvtHtm95Lzlt2aQN/ciKPt5HyOHb3HaHv2UDWRvCGcg
X-Google-Smtp-Source: AGHT+IExSnSbI+ddkiwoW43JfzbfCA/xjR4Llcdxo+anuV2cnZZd/krsRP4DUFQTuPREwFIkM99T4wjoCo+sZK5rTD0=
X-Received: by 2002:a17:906:24c3:b0:a68:cb91:1b91 with SMTP id
 a640c23a62f3a-a699f88866amr7437066b.36.1717520072674; Tue, 04 Jun 2024
 09:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-16-raymond.mao@linaro.org>
 <CAC_iWjJry9zAU0B5P+dmBj6E9m+NZqGEZhGj3FZ08SB3q7B1Vg@mail.gmail.com>
 <CAEfUkUJ64bwK_+mz5o_R1RwMtYoLD6=3xtMn-o2czJh5NHi14w@mail.gmail.com>
In-Reply-To: <CAEfUkUJ64bwK_+mz5o_R1RwMtYoLD6=3xtMn-o2czJh5NHi14w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Jun 2024 19:53:54 +0300
Message-ID: <CAC_iWj+rrSz+1n+9kqjw-gkX3ja6SK-35S67pMkkVFAcQuyjLg@mail.gmail.com>
Subject: Re: [PATCH v3 15/25] mbedtls: add X509 cert parser porting layer
To: Raymond Mao <raymond.mao@linaro.org>
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

On Tue, 4 Jun 2024 at 19:05, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> On Fri, 31 May 2024 at 07:42, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>> On Tue, 28 May 2024 at 17:15, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Add porting layer for X509 cert parser on top of MbedTLS X509
>> > library.
>> >
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > ---
>> > Changes in v2
>> > - Move the porting layer to MbedTLS dir.
>> > Changes in v3
>> > - None.
>> >
>> >  lib/mbedtls/Makefile           |   1 +
>> >  lib/mbedtls/x509_cert_parser.c | 497 +++++++++++++++++++++++++++++++++
>> >  2 files changed, 498 insertions(+)
>> >  create mode 100644 lib/mbedtls/x509_cert_parser.c
>> >
>
> [snip]
>>
>> > diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_cert_parser.c
>> > new file mode 100644
>> > index 00000000000..b0867d31047
>> > --- /dev/null
>> > +++ b/lib/mbedtls/x509_cert_parser.c
>>
> [snip]
>>
>> > +static int x509_set_cert_flags(struct x509_certificate *cert)
>> > +{
>> > +       struct public_key_signature *sig = cert->sig;
>> > +
>> > +       if (!sig || !cert->pub) {
>> > +               pr_err("Signature or public key is not initialized\n");
>> > +               return -ENOPKG;
>> > +       }
>> > +
>> > +       if (!cert->pub->pkey_algo)
>> > +               cert->unsupported_key = true;
>> > +
>> > +       if (!sig->pkey_algo)
>> > +               cert->unsupported_sig = true;
>> > +
>> > +       if (!sig->hash_algo)
>> > +               cert->unsupported_sig = true;
>> > +
>> > +       /* TODO: is_hash_blacklisted()? */
>>
>> Is this supported by our current implementation?
>>
> This is not supported currently either. I just copied the TODO mark
> from legacy lib.
>
> [snip]
>>
>> > +               }
>> > +               goto out;
>> > +       }
>> > +
>> > +       pr_devel("Cert Self-signature verified");
>> > +       cert->self_signed = true;
>> > +
>> > +out:
>> > +       return ret;
>> > +
>> > +not_self_signed:
>> > +       return 0;
>> > +}
>>
>> the whole function looks like a copy of lib/crypto/x509_public_key.c.
>> Can you move all the c/p ones to a common file that the existing and
>> mbedTLS implementations can use?
>>
> Per a previous discussion with Tom, eventually we tend to keep only one
> crypto lib, that is the reason I prefer to copy/optimize a few existing
> functions into MbedTLS implementation instead of creating another
> common file.

Regardless of the implementation, the common functions should reside
in a common file which will be used regardless of mbedTLS or the
existing stack.
We do not want to fix bugs twice

Regards
/Ilias

>
> Regards,
> Raymond
