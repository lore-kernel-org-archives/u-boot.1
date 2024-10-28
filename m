Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A80D3399B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 17:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F3358910B;
	Mon, 28 Oct 2024 18:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UoxMrLp2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B89F98910C; Mon, 28 Oct 2024 18:03:10 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1F6B890D1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 18:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a2cdc6f0cso614163366b.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730134988; x=1730739788; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VmyjHBytuQZhsQeGt6Svls7T2gR7a8m0Fn2a8VAsImc=;
 b=UoxMrLp2y9lqZ2yuU2g+faTo7MwIEYvvECYP0vPgAS+PmvTrIrsv2Q7BlfJozGqjwv
 /6sW0emyjxwy7EvvUG4JKoTixbHtWCSZ3pHHpib6qSypphkZPj18askJ+wQ//rb7xDio
 4z0XEPSGoBqIphP+LZbd0rMBTwkGLKkNX9z+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730134988; x=1730739788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VmyjHBytuQZhsQeGt6Svls7T2gR7a8m0Fn2a8VAsImc=;
 b=pwOZloHYdyFisDYyAiZOEoRC0ZJ2KDOASqlvZPftr+b4or2GhFAJt/WaiFsyx4+TFP
 RtuZJF4q0cSQbc5STmEDIiqsmAS+TYwIwu1u6oh/hLj34uC81L48C6cTCcKrw24Il1Nq
 QKHJSD5ViWXxFIrYMp3vOrUP5EulkK7lWCSEZrj7zWJo7rrW1zo+Trmg2XRSNY0TZqaP
 NeWFvZTt9LVPrELl7DX06TIYna/Knjilx3Y7iJHE6+b2oGw5AEz+gWF/OuIhZ/p/AwEb
 pF3pwbSdaPOyJ34ppCa+gUDWxQKH4odix0UJoo5JHRtH4PeEwxO6gqlqSTo5NJ6gts7u
 OwNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW43aicDXkTAg/2pLBkuMU+Q/nDCrcyhGr/q4YmVJuHZX+mJEShcKtvprEaEy+qnnnOhz/0k+M=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0ahF7uKWf4UEpNwG1WdTXRfP6AG+dSh/s6f57zC/VVONzk14+
 mHIm6YciuK7C1nGlYR66zEWogooNrUGzyNcs9eumspcgVwGsOwfDU+3ffOhfTsdo52PsIawhflt
 zaZm1AjHX67zI+S2ti2zKgVhsVkyszCZCxpc9
X-Google-Smtp-Source: AGHT+IGb11Czae/fC1T+n1P27eP6YfsTcgN72cjFgyNUguqgEbKMdnj2nnewTgymHMFTTyMi9HBUa4GG8Iqqj4XKp4A=
X-Received: by 2002:a17:907:3f20:b0:a9a:375e:c167 with SMTP id
 a640c23a62f3a-a9de5c91a19mr853140666b.1.1730134988270; Mon, 28 Oct 2024
 10:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-2-sjg@chromium.org>
 <f5d2100a-bd30-40b1-a305-44475070c5ce@gmx.de>
In-Reply-To: <f5d2100a-bd30-40b1-a305-44475070c5ce@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Oct 2024 18:02:55 +0100
Message-ID: <CAFLszThm6d7WDksCBAzWT=FGq6LZLXDuAnYK166SRGAJPCGU5A@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] test: boot: Update bootflow_iter() for console
 checking
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Mon, 28 Oct 2024 at 07:07, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:
>
> On 10/22/24 14:00, Simon Glass wrote:
> > This test checks console output so should have the UTF_CONSOLE flag. Add
> > it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   test/boot/bootflow.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> > index 154dea70a59..cc894e804a4 100644
> > --- a/test/boot/bootflow.c
> > +++ b/test/boot/bootflow.c
> > @@ -370,7 +370,7 @@ static int bootflow_iter(struct unit_test_state
*uts)
> >
> >       return 0;
> >   }
> > -BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT);
> > +BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
>
> The test invokes ut_assert_console_end(). But where does it check
> console output?

That is it. It is making sure that there is no console output. But the flag
is needed in order to do any console checking.

Regards,
Simon
