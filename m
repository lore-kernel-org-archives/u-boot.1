Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA95FC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 16:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3293888476;
	Tue,  4 Jun 2024 18:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i4KBvzSn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 464C5884EE; Tue,  4 Jun 2024 18:26:48 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8DD883EA
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 18:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f480624d0fso42843805ad.1
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717518404; x=1718123204; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dEx1rVAHtKZQlt52qabqIe8rKfgt3hzrdz8GYgFFs/w=;
 b=i4KBvzSnTYxxl2yN1sHUqJAq2EyP7MquJkofiQ8dQW4gxsriqawQOoyUn6dHarTv9V
 yJashYzBLAYhZCo0xIcwUXcsaJyan25d5ZSz6Sfqy8xkytj7MfE1CuCm63m3aU9ho4Zt
 3bqeVFy6+FpKoOhGuR23STksu14OwAFF515JUCl93B3B8Dcl1lwbUrK6gdbwnpcF+HAY
 pdL6AZTzI0EBHFyHXjUZxXz+rfVpvNyxxwfUFd+lf4Z5Vj4x5eU+3nCB7blsKguQ5zVh
 gashID6A1xzovE4Jm44LTE65cG5bsssLX8gua1H1L0J7pwN3kW3yhwhX3K/5C0027ULk
 pBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717518404; x=1718123204;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dEx1rVAHtKZQlt52qabqIe8rKfgt3hzrdz8GYgFFs/w=;
 b=epr7a8pvbD+XyWNNZuFFVdVxbBUOaDwMLxv7fy0byIaJ8prSc2KrcbL6ht3UD79iG+
 06QZZx5Y29aHtGaoW18zK9kLf9T4SdrYunZtMlJhIJj+u6FHs2YaWWP4naiH1axYU9o8
 ULuIjD1sRUY0yFK9ap1V5sQn2g4fqew+5aw+y5nkPXNO9yDAvqr+yuHe900Ftf74mfr2
 53V9MOhzJ1kew7bkdSkkRV5l0xWRpSGrYxLjxKpqIpe0f1TMBwefOxqoGPc4M+RAliGj
 D57C5nRvt+iyBOfKGr2uyloM3XBxnKynaqP6bbA2Z96qYIo9hvPW4wvFHXwMHp18tha/
 CSSQ==
X-Gm-Message-State: AOJu0YzGu3eNYngfU30EJETIFyelflIm84tlqaOQy46Qj9CwEHyHyt7D
 4WnDjsWPAfxlZqTahh7Qn80fhpt3jL250k7I43abeyyEtAkMZbZEEWrWCvFZxpq/iFtUPy5yLT6
 cAliAaHxlony+Q2yBaPkzLINdzyBfqTx8qc5AAQ==
X-Google-Smtp-Source: AGHT+IERL+A+ttrFeCpZ9NRfUfE19cuckxLwiKs7GuoN+52Cumh/ziYAHqz792WlRgOfR7tOo6arP6m1dr61cDkkZbM=
X-Received: by 2002:a17:90b:534f:b0:2c1:a068:ba83 with SMTP id
 98e67ed59e1d1-2c1dc57e027mr10789642a91.11.1717518404086; Tue, 04 Jun 2024
 09:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-20-raymond.mao@linaro.org>
 <CAC_iWjK7st0ttFuuX22eMtRraGin2dikMUu5_C1cY8J9KvKESw@mail.gmail.com>
In-Reply-To: <CAC_iWjK7st0ttFuuX22eMtRraGin2dikMUu5_C1cY8J9KvKESw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 4 Jun 2024 12:26:32 -0400
Message-ID: <CAEfUkU+08oVT1ZKaEM=vONoqT64gX8pAyntruwwPNZ_CjfXg3g@mail.gmail.com>
Subject: Re: [PATCH v3 19/25] mbedtls: add MSCode parser porting layer
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
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, 
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

Hi Ilias,

On Fri, 31 May 2024 at 06:03, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Tue, 28 May 2024 at 17:17, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Add porting layer for MSCode on top of MbedTLS ASN1 library.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Move the porting layer to MbedTLS dir.
> > Changes in v3
> > - None.
> >
> >  lib/mbedtls/Makefile        |   1 +
> >  lib/mbedtls/mscode_parser.c | 111 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 112 insertions(+)
> >  create mode 100644 lib/mbedtls/mscode_parser.c
> >
>
> [snip]

> > diff --git a/lib/mbedtls/mscode_parser.c b/lib/mbedtls/mscode_parser.c
> > new file mode 100644
> > index 00000000000..34715f3a137
> > --- /dev/null
> > +++ b/lib/mbedtls/mscode_parser.c
>
> [snip]

>
> > + *
> > + */
> > +int mscode_parse(void *_ctx, const void *content_data, size_t data_len,
> > +                size_t asn1hdrlen)
> > +{
> > +       struct pefile_context *ctx = _ctx;
> > +       unsigned char *p = (unsigned char *)content_data;
> > +       unsigned char *end = (unsigned char *)content_data + data_len;
>
> Why are you dropping const here?
>
> mbedtls_asn1_get_tag requires the args without const.

Regards,
Raymond
