Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8B3C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 13:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EE22887BE;
	Mon, 29 Jul 2024 15:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JspcSr/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 369F2887BE; Mon, 29 Jul 2024 15:55:31 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D9A887E6
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 15:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2cb510cd097so2439270a91.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 06:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722261327; x=1722866127; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=19hEm6WdnYLiXVxCMUjY5iiin/7v5g8W9RU61eZfRd8=;
 b=JspcSr/90RDbhX59fM2+BO4OfD7sxmMrj9U09A3gBgt2z+FdMFyDptuxDQ+h9GYecx
 cKVl2Vdm/ONl50rZSIRxOYoJiXzW9otmgT+hCsnkolJgBtorVzxBjl7PmCJgHuuqI58M
 6kYWohMaoXk8QdNoz945DTP4PWhgssDbDHA4Wmm3RuLtDmK8Uo+U8dJJk/3Vr+YIUqro
 QnfaejsbdtNNZVg9j0UV5XJqRwwZAiUKeXoT6Qr4CsgTXjfoUx+2gBcgPEsVRj1C/ryw
 wrGT/9872+FsNEK3oVwzSsKFfu11Jq0CopYyOCQAEqD4jIXAzL2P/w8UD7HQja1Wc5VQ
 fbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722261327; x=1722866127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=19hEm6WdnYLiXVxCMUjY5iiin/7v5g8W9RU61eZfRd8=;
 b=q4+jcpFypcPch4527RZVTM9p6MdHYWgG6oopHeIC+/wlUjSzpjqNpJ8Sd6j934KGO2
 jR5+f9MUY+iCKydZHnpsCS/2N4aY7oq07cz0CMvqNCu2JRur5mGsIgd8J1QfI0hD4KJd
 EN6r8AkF7mElbBoGMvPHGbGfycfHWAfLWXwxZ5F7d723gnNGS64WLB+MZwakWfgHum5b
 vFTQDEBaAgOYNPZt7AphIQZs/8VGWBZSkKG4oyiEcZVFqlZaXCJwmkjRz/kQcM8kV5An
 RMDeY75+TcKOTUe67haHbzkK5WbL5ObIXZ4RWMPdcqTseHArNg9aJmDDQopPWhEdshgX
 /NKA==
X-Gm-Message-State: AOJu0Yw7NG16rGLsG9/hWpVkqmVuV4Yb6IKvIWthtcHd35bSrMGHicXt
 eIYjyIUZHiQ/t4oIF8pVKPZgTvzgbENIiPvMEJdjhxFCVpJ/jO8dgPuqMQAiDocgaZk8ZFPkQOA
 4wHQPA7UCtiPKtsrHXoOqd2AXbCIh8/EsaZZcbQ==
X-Google-Smtp-Source: AGHT+IHF3Sv7L3/b0yPvZ3yVOOhTAsl5k+ZmQoqH4xQX/Ae1t1nzb9QFJRA0qbYQO6SjrkmgdWXKx3LK3Zj6TLsojLw=
X-Received: by 2002:a17:90a:5d17:b0:2c9:a151:44fb with SMTP id
 98e67ed59e1d1-2cf7e1fad43mr8912858a91.22.1722261327246; Mon, 29 Jul 2024
 06:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-21-raymond.mao@linaro.org>
 <CAC_iWjLeM3zKfo274FpEhPb11=KxrRASqBW6WDe4o-jmQxmBkQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLeM3zKfo274FpEhPb11=KxrRASqBW6WDe4o-jmQxmBkQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 29 Jul 2024 09:55:16 -0400
Message-ID: <CAEfUkULz5rK7mf_JOiRb2n7Dqis-AYLY9hhHNidJqUaXkSu96g@mail.gmail.com>
Subject: Re: [PATCH v4 20/29] lib/crypto: Adapt x509_cert_parser to MbedTLS
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
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
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

On Mon, 29 Jul 2024 at 09:20, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond
>
> >
> > +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> > +/* Backup of part of the parsing context */
>
> I am not sure I understand the comment
>
> We can remove this comment line.


> > +struct x509_cert_mbedtls_ctx {
> > +       void    *tbs;                   /* Signed data */
> > +       void    *raw_serial;            /* Raw serial number in ASN.1 */
> > +       void    *raw_issuer;            /* Raw issuer name in ASN.1 */
> > +       void    *raw_subject;           /* Raw subject name in ASN.1 */
> > +       void    *raw_skid;              /* Raw subjectKeyId in ASN.1 */
> > +};
> > +#endif
> > +
> > +/*
> > + * MbedTLS integration Notes:
> > + *
> > + * Fields we don't need to populate from MbedTLS:
>
> You mean *for* mbedTLS?
>
> > + * 'raw_sig' and 'raw_sig_size' are buffer for x509_parse_context,
>
> 'raw_sig' and 'raw_sig_size' are used in x509_parse_context(), which
> in turn is not used in mbedTLS?
>
> Both are used by the U-Boot ASN1 library when parsing the x509.
But for MbedTLS, we removed "struct x509_parse_context ", since all
parsing is done under MbedTLS and we don't need to expose them at all.

> + * not needed for MbedTLS.
> > + * 'signer' and 'seen' are used internally by pkcs7_verify.
> > + * 'verified' is not inuse.
>
> either 'unsued' or 'not in use'
>
A typo. will fix it.

Regards,
Raymond
