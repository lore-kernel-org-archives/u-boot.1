Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18356C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 15:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6076E88667;
	Wed,  8 May 2024 17:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sj0Q4bU8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FBBE88667; Wed,  8 May 2024 17:02:47 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29936882E5
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 17:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2b338460546so3392433a91.1
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715180564; x=1715785364; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OIcN2mj8/5XzzXblf+JhzwElEsyM/gBMQ55dntMGHYc=;
 b=Sj0Q4bU8omlNnIN78qMjHSjXf5qNksLLgB3505kIxk4REIiI5JPPfTHx+NZtZ2vFbe
 09NNk9rI8TplhbOTe3vClMa6lBRrxbq5ygEdZKOsz/c3Sban7tp1kQwW2q1wXFwB170Q
 +ACQsdFnXi1nkDJ39RK29ibyZJdUUELsj2Pqz9H31PEDOQV3uSqhhwTx0AzpXd3fcwVv
 bADcwjlTIQl1EzLq6fJXok13kZYizYDYAmrYRtb3JtOf2TNL++dvb9mSavWewQ/zjdO7
 7TXNK4wIG0OeXozsKizkoA670eAfZ8LR0nPKUg5kwtxno6CDHmMyU8msvTnAizrxptC1
 +cOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715180564; x=1715785364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OIcN2mj8/5XzzXblf+JhzwElEsyM/gBMQ55dntMGHYc=;
 b=dUoQ0JTkQzSQxQ8XAX8dj7A8BFzPkG9mWsMZZ0aiG0uqiGgFgiKwYPVB9893J0BuS0
 Bq5pk7ZjILqYA0PLiGH9kEO66yXQl9IZPiNWSReUYxW0iJvGUKRHDueSzLJzH4gHGmhJ
 WRrqjLchkq8wSoA9PXQ6Ec/KjeNsk4pqd0gRbY+VrwF6+mALpAuoSkv1YYi+cqAIfmyF
 ScDv/nzi4nWrlGOmqVHedoIkbMZShF24l2GEEjnjV2nvnTUkT1tOntVHK4C7kGyagAcL
 lHvfmKH85go4FFw3KgE5k4rLhYDjI1YxeJRf/3d5LlSFhJO6NmuctWicqDyDmaxf2oGM
 h7eg==
X-Gm-Message-State: AOJu0Yw3nofkxceR91bHGuSAh428bWPMO0J6GuvoQJuMdYuLbtBR2K1n
 PVA4WuXsYl4ihudGM0ob8xp1VuUB2vg+n0OBW+EZ2mDdusv6WQRLWF7j9UurU38J/borwBy+D7a
 0iGeiTLnSgUAY+SW+C1pYrL1M/84dEa+dKPvtkw==
X-Google-Smtp-Source: AGHT+IFwQI3jY4cRSq+v65w81hp+VhozDqpD78+am/SGns+JF1J6NG5CMysogcPVh5d6+ZVWjZFb4QBQOSOV6/PQCyM=
X-Received: by 2002:a17:90a:6503:b0:2a0:3dc3:8a8b with SMTP id
 98e67ed59e1d1-2b616aeba40mr2469940a91.47.1715180563233; Wed, 08 May 2024
 08:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-16-raymond.mao@linaro.org>
 <CAC_iWjJ2nNub7q-qnR2jj-uh6oE2VicLtZETRWOoCGpiMmCLog@mail.gmail.com>
In-Reply-To: <CAC_iWjJ2nNub7q-qnR2jj-uh6oE2VicLtZETRWOoCGpiMmCLog@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 8 May 2024 11:02:31 -0400
Message-ID: <CAEfUkULxAcreL7WZ7NLBiRPhgLP_9aLTeSENHbFN0Q9rM8H+-g@mail.gmail.com>
Subject: Re: [PATCH v2 15/28] mbedtls/external: update MbedTLS PKCS7 test
 suites
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andrew Davis <afd@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Wed, 8 May 2024 at 10:33, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> On Tue, 7 May 2024 at 20:58, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Update the PKCS7 test suites for multiple certs.
>
> Please explain why. Does this belong to U-Boot or the patch should be
> sent to mbedTLS directly?
>
> It is sent to MbedTLS upstream as well. The patch here is to keep the
codebase
consistent with the upstream, and for the people who want to run the MbedTLS
test suite under U-Boot, until they are merged to MbedTLS upstream.

Regards,
Raymond

Thanks
> /Ilias
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - None.
> >
> >  .../external/mbedtls/tests/suites/test_suite_pkcs7.data       | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git
> a/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
> b/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
> > index d3b83cdf0aa..2dd1c56109f 100644
> > --- a/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
> > +++ b/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
> > @@ -14,9 +14,9 @@ PKCS7 Signed Data Parse with zero signers
> >  depends_on:MBEDTLS_MD_CAN_SHA256
> >
> pkcs7_parse:"data_files/pkcs7_data_no_signers.der":MBEDTLS_PKCS7_SIGNED_DATA
> >
> > -PKCS7 Signed Data Parse Fail with multiple certs #4
> > +PKCS7 Signed Data Parse Pass with multiple certs #4
> >  depends_on:MBEDTLS_MD_CAN_SHA256:MBEDTLS_RSA_C
> >
> -pkcs7_parse:"data_files/pkcs7_data_multiple_certs_signed.der":MBEDTLS_ERR_PKCS7_FEATURE_UNAVAILABLE
> >
> +pkcs7_parse:"data_files/pkcs7_data_multiple_certs_signed.der":MBEDTLS_PKCS7_SIGNED_DATA
> >
> >  PKCS7 Signed Data Parse Fail with corrupted cert #5.0
> >  depends_on:MBEDTLS_MD_CAN_SHA256:MBEDTLS_RSA_C
> > --
> > 2.25.1
> >
>
