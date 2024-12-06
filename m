Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B4FE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 15:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEF0E8962F;
	Fri,  6 Dec 2024 16:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NbcdZ0m8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E4CF89638; Fri,  6 Dec 2024 16:31:36 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE328962F
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 16:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5cecbddb574so2535220a12.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 07:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733499094; x=1734103894; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SAVRH3JKUe+yTGkkCUJbbULNfuUE5Z2JVJwWjwVOn8w=;
 b=NbcdZ0m8npWO3Jtv4Aj8pRqu1FyxIO5w4FABgtnuIloef82ENZUr+Ezq+eKCq/Febv
 p1Gb8vOOf65s6aVZWgEpdncWzaNHhnQP8VEEESsWq/3pZhpDL245whx6cJ7TFPyUFJJ/
 FMWwwcVi9h0Q77T+XjN5APEGum+QZLjx+HbQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499094; x=1734103894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SAVRH3JKUe+yTGkkCUJbbULNfuUE5Z2JVJwWjwVOn8w=;
 b=KzWkOtfr6v3Itzx4NpygljAQyhXQR4QFVepvQawAp/4v7TIu9XFtyqaADtJchSjyV7
 Tfh6X3hzd9WhI2zKO8qj3UMiqRFUOUt7XkSKEBu6YLdNLTOSD5pZaPdSYheNKSQfesZT
 leR3loh0ZYJTPpLZ+EJd+2K/vSBWXU+2BEzwZ5Ph+5Gbj+c5W1vtrezwzJ5BRCQjgXbb
 PYob3mf9f4YvnABhLKaXP6iWZB+z7sGBnc9evVQCq1CfqQiLixlAp1C7K2S0v0Z5zbW7
 CB2vUOyLylILw69UZt038MnK4DSVPmP1Lls5HHljg0VcdkSSqvFK7lrlU3fEpNmHhWWv
 LRJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7F1tWOAkEPZ6fwVuM26zRwegIb+cnvKZBQnGkSKv3PIGyXI1EcNho/IQ4UaSAfeSIZuvLdHs=@lists.denx.de
X-Gm-Message-State: AOJu0YwO5TepvZA9zrECIfksW0TeBjcIrfiAEJiyjEIhnO87KpbNcMot
 FRltjuo8sFMvB0wGgKUZsDPTCvvBREut21W1C+Y60P+v/YWDEkUDBk9tulWbj6V4wD+pLdp8Wc+
 GFz1ff07m7r3N8PixU0plEjNFI+Q1GwXSbCLg
X-Gm-Gg: ASbGncsvj96TcLlx4LvgSMuX9sNzid2jG74agcEudkNsRTSs2uo87J8aO0BHPUrZszO
 Dn9TUeEKQneKYSpc2LblPCXx8t6XTkwTI
X-Google-Smtp-Source: AGHT+IFFjJhsBrcpp1GM2fKfx5MH85/IiaQ7Z3ybB+pLTFr+bZCAQt66M3QiDUYzbCwKBiZ5U8DTLvFXE6Y1LRbHbtY=
X-Received: by 2002:a17:907:774b:b0:aa5:2ef2:58bb with SMTP id
 a640c23a62f3a-aa639bf9d65mr245858266b.0.1733499093968; Fri, 06 Dec 2024
 07:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
 <20241202-sandbox_repair_of_embed-v1-2-05aff4b0ccf7@salutedevices.com>
In-Reply-To: <20241202-sandbox_repair_of_embed-v1-2-05aff4b0ccf7@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 08:31:18 -0700
Message-ID: <CAFLszThrHw1cN37+U=UBBSgsRt3v9aqDqO=NpYMq0JROGzWfoA@mail.gmail.com>
Subject: Re: [PATCH 2/5] test: sandbox: fix invalid_use_of_IF_ENABLED_INT if
 BLOBLIST=n
To: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, kernel@salutedevices.com,
 evgen89bachinin@gmail.com, u-boot@lists.denx.de
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

On Mon, 2 Dec 2024 at 06:46, Evgeny Bachinin
<EABachinin@salutedevices.com> wrote:
>
> Having CONFIG_OF_EMBED=y && CONFIG_BLOBLIST=n leads to the link
> error:
> ```
> ld: /tmp/ccRVty.ltrans40.ltrans.o: in function `lib_test_is_enabled':
> test/lib/kconfig.c:24: undefined reference to \
>                                        `invalid_use_of_IF_ENABLED_INT'
> ld: test/lib/kconfig.c:26: undefined reference to \
>                                 `invalid_use_of_CONFIG_IF_ENABLED_INT'
> ```
>
> Fixes: 29784d62ede ("test: Add some tests for kconfig.h")
> Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> ---
>  test/lib/kconfig.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

This defeats the test, of course, but I suppose that is fine.

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/test/lib/kconfig.c b/test/lib/kconfig.c
> index 0c463bb794a5e1f9f2db995d544bd723f5e59ca0..a3645abf9464785461c7250260c816e6bca03193 100644
> --- a/test/lib/kconfig.c
> +++ b/test/lib/kconfig.c
> @@ -21,10 +21,12 @@ static int lib_test_is_enabled(struct unit_test_state *uts)
>         ut_asserteq(0, CONFIG_IS_ENABLED(OF_PLATDATA));
>         ut_asserteq(0, CONFIG_IS_ENABLED(_UNDEFINED));
>
> -       ut_asserteq(0xb000,
> -                   IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED, CONFIG_BLOBLIST_ADDR));
> -       ut_asserteq(0xb000,
> -                   CONFIG_IF_ENABLED_INT(BLOBLIST_FIXED, BLOBLIST_ADDR));
> +       if (IS_ENABLED(CONFIG_BLOBLIST)) {
> +               ut_asserteq(0xb000, IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
> +                                                  CONFIG_BLOBLIST_ADDR));
> +               ut_asserteq(0xb000, CONFIG_IF_ENABLED_INT(BLOBLIST_FIXED,
> +                                                         BLOBLIST_ADDR));
> +       }
>
>         /*
>          * This fails if CONFIG_TEST_KCONFIG_ENABLE is not enabled, since the
>
> --
> 2.34.1
>
