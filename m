Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058A7C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 08:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5238F883D2;
	Fri,  5 Jul 2024 10:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K7uaDmB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B5FB883D2; Fri,  5 Jul 2024 10:36:12 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA84D88254
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 10:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-48fe544ce8cso472919137.2
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 01:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720168568; x=1720773368; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7XdPvr9JIiz40wSaNKPVCpKO+7dmvAXxqXg18qtvisI=;
 b=K7uaDmB5FpKulQykndlftocpSNa2bvRRYRrzU6yZLkwl7d6TZHo9bsQmLK/FPpnlnz
 cGWxul2DS8Y+1NdalkXc8PfHbU82QIXe82rIrHN82Q2GYu+7kHJvKQw3ln4xEi0/RgOV
 zOeSPgR7Dj2unHMtj5dbIQm8SYnWyaX9DrN88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168568; x=1720773368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7XdPvr9JIiz40wSaNKPVCpKO+7dmvAXxqXg18qtvisI=;
 b=q7aRwJIIWlGWa6QQh888CQG3OGnaWXL4wLWOD2Glal5jiN5VtouG93oQqgcPcjGxI7
 P9Jc19Hp6QDzqfbaibVIwcMWzQgo3kAuDQKROVGgZih+1UJDOC4/RNWf8D37ad48SUZD
 Sqw3+RaENv3mH7tS1ndWpZR2MIAqxE4iCli/M/R1szKjOq7VPKbTsgZy/ZXxeWE4/lDP
 qsoR/uNKUg3egKtH2MsH8MhQbgO8I99j03BhdEha30XGzblSoWyHuXMgLV0O+tuyZubr
 AKZA0uzbLVEi/I0ps0iDYIn5J6Rof7/GiSydiT/eGwVGUeWO1Mq83VRqoPAoiczTSBOg
 2VaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK6YvWBF8v20bjs3gglHq5UvQaCzyHvpwAsaJVDLHRcswkhTBZ5vXQx+LHfjT3SKspufhMAZjg7n1usrhg3GYq/GHQ6Q==
X-Gm-Message-State: AOJu0YwaRv1r9t6wEI0V/qHrWv4Du9HMDvWVIjHWhb2JvS/2ifjykMuC
 BltrZ8uSnxTbmXQbb0ZQ2UnjptM32IC6N7+6LW1SK80590+wulj6AQxmDRgzDyqtOkMnJtdQ4xI
 lxMqV4OlwfoSdDiBt2teEO/KT0OPtEX+LKxiu
X-Google-Smtp-Source: AGHT+IGztOY17pBwTxp1Qot9hFzp3rnExI9xOytrt/FKtMUZinAcjZa8X92GA1qEWbjyFtl46MZFrts50jWPu/9fNyY=
X-Received: by 2002:a05:6102:21b5:b0:48f:b592:bb2b with SMTP id
 ada2fe7eead31-48fee87132fmr4472055137.10.1720168568737; Fri, 05 Jul 2024
 01:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-9-raymond.mao@linaro.org>
 <CAC_iWjLxSbtcSwM1iQjj7DG3sJLY5Q=3fnuOphkJKXcQyO4TtQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLxSbtcSwM1iQjj7DG3sJLY5Q=3fnuOphkJKXcQyO4TtQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 5 Jul 2024 09:35:56 +0100
Message-ID: <CAFLszTiezZ4hx-ToVT+CzE6aAwvjea_5-=VuqBWcGjAqOoH2Mg@mail.gmail.com>
Subject: Re: [PATCH v4 08/29] hash: integrate hash on mbedtls
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Eddie James <eajames@linux.ibm.com>
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

Hi,

On Wed, Jul 3, 2024, 09:56 Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>
> Hi Raymond
>
> On Tue, 2 Jul 2024 at 21:27, Raymond Mao <raymond.mao@linaro.org> wrote:
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
> >
> >  common/hash.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 143 insertions(+)
> >
> > diff --git a/common/hash.c b/common/hash.c
> > index ac63803fed9..96caf074374 100644
> > --- a/common/hash.c
> > +++ b/common/hash.c
> > @@ -35,6 +35,141 @@
> >  #include <u-boot/sha512.h>
> >  #include <u-boot/md5.h>
> >
> > +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> > +
> > +static int hash_init_sha1(struct hash_algo *algo, void **ctxp)
> > +{
> > +       int ret;
> > +       mbedtls_sha1_context *ctx = malloc(sizeof(mbedtls_sha1_context));


Why do we need allocation here? We should avoid it where possible.

> > +
> > +       if (!ctx)
> > +               return -ENOMEM;
> > +
> > +       mbedtls_sha1_init(ctx);
> > +       ret = mbedtls_sha1_starts(ctx);
> > +       if (!ret) {
> > +               *ctxp = ctx;
> > +       } else {
> > +               mbedtls_sha1_free(ctx);
> > +               free(ctx);
> > +       }
> > +
> > +       return ret;
> > +}
> > +

[..]

Regards,
Simon
