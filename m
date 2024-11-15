Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5826D65C7E
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34AFF89698;
	Fri, 15 Nov 2024 15:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eMi0UHBR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B84B896B9; Fri, 15 Nov 2024 15:27:34 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A3989618
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7eda47b7343so1353441a12.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731680851; x=1732285651; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C3yWMmlkqc2rWkMqHgl9pFb+TUWCakRkBuQW5MrAvic=;
 b=eMi0UHBRh8nj1nxNtm9vL98EH4YnA1JFI1hAoRg+13qWswolfiZsgZYe8wYCAN9kFH
 bjne1+72KwHQWHsHsIj64b9hUK5MxlPhqOfLa6OP3UBH6Mkyl3Z7trzehU4TaKT9gPP/
 jSnp8wEyg1akHpvHAT1ZGj7mBNqhxClrsDZyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680851; x=1732285651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C3yWMmlkqc2rWkMqHgl9pFb+TUWCakRkBuQW5MrAvic=;
 b=O/pbAH8KUzztz48JBC8F0Ksj9I6sHKXqy8msIw2I6kgzWUpvyll0H4wRVDJM9BWzk+
 /RvqyA5mRrL8UUIXfqdq0yc78oRpkZDDJT5RRGDzV23j2XJ9O7kNKONzQU2zUNLaPDcf
 Iv1pY5q+1y5EjMT4EP4HNk5QJ8jnR9q3w76fARJSvJv84BAMQJ9yhFkeUjEA/RPHF9UC
 dniFfiVxCjPhmBBO+3icAQ3eInnjC37x4yVnhPzh5OQaOYYK+fqJysCKGhU3LVNtMlAJ
 qS1v5qgUWYi2/OkqjSTPZY2iGbU/Q1jylS6ZkY+9cd3VEAp1nBXa0QlSbDqHnMvcI2LT
 Kqhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjeE+kjHlp+j8q2gWf47CqgXirDtl0HZiG+L/kk+FBlFP2us8rBhFpf0Ykm8FZutf904rex4I=@lists.denx.de
X-Gm-Message-State: AOJu0YzRnFUsUCtX7DQOC2tdduvAtOdwotKDJK3U3xT9mzh+8Szs9Tfp
 6jvw6eGgsWHNmI35RqWJTjb03lnRbXKP83eQbOFG92U6+yrb8rtpLGecG0QbkGP/knLd809iEla
 ov7XTLs7dQamW7Bw4dfKxMQMjFKEytyKxY4U0
X-Google-Smtp-Source: AGHT+IHE41P0mUJvSgCHBKyhdgOdaz50dX7iMahr+K4UC8/jmL7Wmz9rJC5CbKBz5D2q1rjmFRhKeqERTyioHJSMbX0=
X-Received: by 2002:a05:6a20:1596:b0:1db:ee36:796 with SMTP id
 adf61e73a8af0-1dc90b258demr4063754637.13.1731680850758; Fri, 15 Nov 2024
 06:27:30 -0800 (PST)
MIME-Version: 1.0
References: <20241102193715.432529-1-sjg@chromium.org>
 <20241102193715.432529-7-sjg@chromium.org>
 <231691b6-d730-44aa-a8ca-9eee3e7521de@gmx.de>
In-Reply-To: <231691b6-d730-44aa-a8ca-9eee3e7521de@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:27:07 -0700
Message-ID: <CAFLszTgD=v+EOrVJ4z_TRaRwof21beyKwU135cv=Yyu+ZJTc3A@mail.gmail.com>
Subject: Re: [PATCH v2 06/20] command_ut: test: Move test into lib
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 14 Nov 2024 at 04:09, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/2/24 20:36, Simon Glass wrote:
> > This test doesn't belong at the top level. Move it into the lib/
> > directory, since that is where compression is implemented.
> >
> > Rename it to just 'command', since it is obviously a unit test and the
> > _ut suffix does not add much except to make it different from the names
> > of other test files.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   test/Makefile                        | 1 -
> >   test/cmd/Makefile                    | 1 +
> >   test/{command_ut.c => cmd/command.c} | 0
> >   3 files changed, 1 insertion(+), 1 deletion(-)
> >   rename test/{command_ut.c => cmd/command.c} (100%)
> >
> > diff --git a/test/Makefile b/test/Makefile
> > index ff621344a03..48d8bc91ae6 100644
> > --- a/test/Makefile
> > +++ b/test/Makefile
> > @@ -9,7 +9,6 @@ obj-$(CONFIG_$(XPL_)CMDLINE) += bootm.o
> >   endif
> >   obj-$(CONFIG_$(XPL_)CMDLINE) += cmd/
> >   obj-$(CONFIG_$(XPL_)CMDLINE) += cmd_ut.o
> > -obj-$(CONFIG_$(XPL_)CMDLINE) += command_ut.o
> >   obj-y += dm/
> >   obj-$(CONFIG_FUZZ) += fuzz/
> >   ifndef CONFIG_SANDBOX_VPL
> > diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> > index fe7a2165af2..6231a08186d 100644
> > --- a/test/cmd/Makefile
> > +++ b/test/cmd/Makefile
> > @@ -5,6 +5,7 @@
> >
> >   obj-y += cmd_ut_cmd.o
> >
> > +obj-$(CONFIG_$(XPL_)CMDLINE) += command.o
> >   ifdef CONFIG_HUSH_PARSER
> >   obj-$(CONFIG_CONSOLE_RECORD) += test_echo.o
> >   endif
> > diff --git a/test/command_ut.c b/test/cmd/command.c
> > similarity index 100%
> > rename from test/command_ut.c
> > rename to test/cmd/command.c
>
> There are CLI variables using env and others that don't.
> The latter we seem not to be tested.
>
> Maybe we can add a test like the following after your series is merged.
>
> => a=123
> => env set b 456
> => echo $a$b
> 123456
> => env print b
> b=456
> => env print a
> ## Error: "a" not defined
> =>
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Hmm yes, that would be useful. See also test/hush/dollar.c for
example, which has some related tests, but not quite the same.

Regards,
Simon
