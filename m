Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDA9C83F18
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 08:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F1783599;
	Thu, 10 Jul 2025 10:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y8pqxWPG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71052835C0; Thu, 10 Jul 2025 10:33:36 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7F598349B
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 10:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-714066c7bbbso7772597b3.3
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 01:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752136412; x=1752741212; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zw7hPpxusImL//De6iS5X/wz9h+wPJhfDnfSl7EEvoc=;
 b=Y8pqxWPG0hwWeRYxXlK6+vzh9eCzgwavCitj3+fDJHcgIM/RbRhGzMqSaofUyf8u1F
 KOFRVLimRrzizZpSCICdRqgTW3aAsdBVTD9NBi8vCCj1TrwVMfvKu0toKB6uPGvS8bJe
 83ybHT0cd6IgVuc5tRb8xpiEPQ0lyJT69tdMc/GlUS1muNI6vHEN/lO6zd4upXt0wbDZ
 Sln6sIJRWlQMmFcim5xlOJfvL9mHKGzcJwED1pJAoo3mzoa/tL1a3wyCYp6njW5eOHKg
 2PFKx3N49zkvuJxJbpeYlsi3r0xC7RjYZ9e/RuHgr+wvTvWU4KyJ7nngHBVfz7cGYbP8
 Qdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752136412; x=1752741212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zw7hPpxusImL//De6iS5X/wz9h+wPJhfDnfSl7EEvoc=;
 b=vZ7A7YYQVDAa3cn7Dmj5VJYfbDZcA+QONs1Xl37Rx/UaB8uCNtdZQW+epvHCrHNS40
 2x/3RmGCbYIgU/ozlSXmnGIIMe9Ykpc4pSXifdUMXqBGA6x8NTTa8+Tvs+SbiveH35o+
 qWZX3M6sHEK53VbCz6ecbyKQpPwzR7cX0aRs7xiRoqWUoqxN81ZrpTw18Mn7EI8R0vv+
 trkojBqAqwQ+fhxMoGe0uoHT57WQtj/FRrNcxj5XzrWhQRbPM/zPkqzmToq8NJrGm+W+
 DNUM3jGwxtj17DIAwiOIL1woxk7xKhQ6vi0Bvq87t74tiCbTFA+d0bMdivD0YK8YYsje
 Q/wQ==
X-Gm-Message-State: AOJu0YwKNTjZFsZd3KEzRWXaqDZE1jnFJo5oB+Ll6OTmdGOfGpdfr7mw
 aFAYpRkLRO9kJtjG2Vo94Xb9xPKlNSecO5wEn8+zP8++aOqfgfD0KmILNq1LeNALmlvz/MQTXNB
 N185wnyx0HrFwLXmhuZO4m5R1BZzBTIzQpS5auwA1rA==
X-Gm-Gg: ASbGncssSzN4MH2jWAY2GVDC/VrZMWScRXKgh8EpXctqzkuZKYPern4dGL3tXMlpDSi
 3/vWFB9Hr7VjLfU8yuKc5SkwNSoJfLZp4NJSk78gWyY0ID0hOw7Gp2micx9M2+JmQXCILDQVz0M
 aKCG4B97aWIQtA92W0WSO3ZExnKycSAKJAenyuQNB2QENhLhJSqAWdgA==
X-Google-Smtp-Source: AGHT+IFkVt2Fkz6BjnbN/zop00fpLhR5ENakiAQEnPdI6nstvTxj7ydWuYzvKMkQq2IAr6HgBb6syqBFvpqdymwkrvc=
X-Received: by 2002:a05:690c:7012:b0:70e:142d:9c6e with SMTP id
 00721157ae682-717c1774710mr42453757b3.32.1752136412430; Thu, 10 Jul 2025
 01:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250708103959.26129-1-pro@denx.de>
 <20250708103959.26129-2-pro@denx.de>
 <CAC_iWjKFBJRG290byhLj0cZjdLKhWOD+7NMZu5OY1sokgNb8Lw@mail.gmail.com>
 <aG0sjC1h5ggy-THS@antares>
In-Reply-To: <aG0sjC1h5ggy-THS@antares>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 10 Jul 2025 11:32:56 +0300
X-Gm-Features: Ac12FXx-aM-JV6TsSAV8RULFrvJk4aZS0U5MC9WB2VBeHFOEiF2OeRS79dQYSeU
Message-ID: <CAC_iWjJD7pY_M9uN1jVPdND8NTBq2JdcKp7JgnW-mPJF0VpLsg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] Makefile: Add size check for u-boot-with-spl.bin
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Paul Kocialkowski <contact@paulk.fr>, 
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Philip

On Tue, 8 Jul 2025 at 17:34, Philip Oberfichtner <pro@denx.de> wrote:
>
> Hi Ilias,
>
> Thanks for having a look at this!
>
> On Tue, Jul 08, 2025 at 02:31:37PM +0300, Ilias Apalodimas wrote:
> > > diff --git a/Makefile b/Makefile
> > > index fa9ce756083..791c00713ec 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1545,6 +1545,7 @@ OBJCOPYFLAGS_u-boot-with-spl.bin = -I binary -O binary \
> > >                                    --pad-to=$(CONFIG_SPL_PAD_TO)
> > >  u-boot-with-spl.bin: $(SPL_IMAGE) $(SPL_PAYLOAD) FORCE
> > >         $(call if_changed,pad_cat)
> > > +       $(SPL_SIZE_CHECK)
> >
> > There's a rule in the Makefile
> > ifneq ($(CONFIG_SPL_SIZE_LIMIT),0x0)
> > SPL_SIZE_CHECK = @$(call size_check,$@,$$(tools/spl_size_limit))
> > else
> > SPL_SIZE_CHECK =
> > endif
> >
> > and
> >
> > isn't this running?
>
>
> Well, before this patch it only ran for the u-boot-spl.bin target. But I
> also need it for the combined u-boot-with-spl.bin image.
>
> I'm not sure if this answers your question?

It does, I misread your email

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
>
> Just for reference I'll put a link to the previous discussion with Tom:
> https://patchwork.ozlabs.org/project/uboot/patch/20250527121049.106825-2-pro@denx.de/

Thanks for the reference

/Ilias
>
>
> Best regards,
> Philip
>
> >
> > Thanks
> > /Ilias
> >
