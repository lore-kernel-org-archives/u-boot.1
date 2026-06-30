Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A391FC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 15:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE15584A52;
	Tue, 30 Jun 2026 17:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EXrmGdh6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1035D84A5F; Tue, 30 Jun 2026 17:03:41 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACC7D84A51
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 17:03:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3996c9eeebeso38421571fa.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:03:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782831817; cv=none;
 d=google.com; s=arc-20260327;
 b=m4LvNr7/Dg1LhqKcfeWmZO+ldgynYyo53Gd6zdRgAR4SUGbHFIY3r4f7gMAodzqxeQ
 NYSPLEt09RCUM1YTPoLKfBavSBvyTYsed4Z7o1S3dfOQytxRfcIHCeaM9RhRBGvPgKqO
 ocW0WAwS6brA0ut9ySRjVC5dxMHRZbFK50O4do7YVxrjBwRWFih/1I/vSIDtITWmxg8N
 VIPiMgTJam7f1Sg438wGxYf7pHGsaiko/vfrUmgwhioZ+iKAmzdDyktHuq65L2n5Sraq
 v8RsPPQ2yn7hzmQaePJ9C22V4BwFJ5BkBX/MBN20aXEk/tLoWS1l7xSxsauMKJjam/8k
 TEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mhiwZulklIISvFqPn3QFFGV2SUxmi2uWzuI9dOdQh3g=;
 fh=yQOMmv66ww+IIMP0HowOHI/t8aW2a1/LenKsgdXtCqk=;
 b=r/OXHwG3KIzl96eqp1ybOeGxU+5jjL/3cYQGF4mqAuLUuJL+50pjSbMxyAwH0qWYJo
 lX/J05he+LfbLT/Xe1LVlwFq8MV6IBdb4a792TRaI+Rk48nQKcr+3eCC7avSWfK2NV+0
 tmiY5TbSmINjs4HzfhzsEwKdLacRXPMQ0cN83vueTESH4E9z56RjT4RpUev/7LZxZy6M
 LP5+LT8tNBO1t++vvJcNfTMQY9dyIiPRwJESB7LBdFM6IvdtgTIUI13ekRlOaz3qHOXt
 7KDuu8wdG7rpQ2/qpBeWOrARenVRjRkABXRyzpAj2YNncFb3Zqyt8UvS+LPS2pIl5zDB
 XZYw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782831817; x=1783436617; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mhiwZulklIISvFqPn3QFFGV2SUxmi2uWzuI9dOdQh3g=;
 b=EXrmGdh6ll6nkFaC5zBswA8PiNmSjdQ7d8gJMlJ2j/yWrfMXyhtUTnPfEVyli5YTis
 fW8I5kTdCXlfOOnjS6EyaWGh2d9f3BuvaBk5HLKvXaeR6oW1pactNpyzwhBD2roii5Vd
 Iy9fiOKS0BOmKVaUj1aINKjvIz165v3a+XqjBzQ2Di5f9bU645S8KeejmUNCavBrSUvi
 s9w7cSj/8N6d/PgK4lthhvIyoY7NHg9St3NirVsxDvXOKqMTtYLkGUN7JmQ5Qfk6DC/Y
 6E7cJ+KNRO1BUdjiihc3sV/6pjFT2HUJnVJB1D87Ig0y4G7jGTef0f7Z04Om01WNrBLP
 1rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782831817; x=1783436617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhiwZulklIISvFqPn3QFFGV2SUxmi2uWzuI9dOdQh3g=;
 b=KCVj6WeLlkmju27WXslF9PJGzHI+eFh3ETravwvv+sfTaE0ZPuXbRjZ5M6HQYVdJCp
 k7xQregiKlPDMk2g/VE8rEoY649o5nlqCYFpOzeYQ85TXvOtBivxATxPKHPkxGK67pab
 03YtPZpl4g8fJxUFHMXpmV8k5mhH4JXUVcf4l3yROZ1jpkwv4/JN5KX5JpI9SuwZ/FfA
 ep0HtO1flqrXRr81WFlqs78bCnpmzxmomQF7DH8cLkpYKflDJL5rzi44ienJ27+60Yyp
 9Y+Fizw8LVU2ckxEZyiJXj1osKMJ9h0xKxZ6fA6HgmaKsnZX9Y/ODQ8hhuhQEHqou+kH
 8hcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpEIYzZu2yHYUi5z6quMupT+3aweSZ1fGa+Usm+GRgm12AykFcr1FrQxpVdlM8ntN9hlVzPWU4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+JYTB2QDj9bnygF8pQMbsWtNK1fA1xW/RBhte4f//HdyXpgtx
 sjjhSjGYfwxH5wnS2u8W9RYPDfdXRG95xFiCOQxc2ttqH8btSD8VhBLjxra6iSpIRSfF4K1ozBp
 2H09Xz+4xjVfF6eHFVZs2FZ6TrNNqpMgvEpDV
X-Gm-Gg: AfdE7clW+jmXi3xwcCHV5hay7oQN+rhdZpiDQNpQPr3b8MOAqicj8ZSZoyn8fmEZqf2
 88wVaxE2wUtddEN33qGWwIIgCa2YfHdjHBC/ntraDKsDDlCIEtyb3PRKksJVfWiB6KgslCMoau8
 d92UQb+rzgux80z/vmKyR7ZxKjXWNDvrnLDJaenzMTKfL5QSEL7Li4UtRucPdBFfmpY4ooodGho
 83AzMRtjY5nrDkPH2DO3CAeSUCMbJeioGGaPiYzUs4FEGiuE/P+Kjh8ligv7yV/fdtmKi6JHFoS
 EMpU4kfviqL5YLF0aQLs+RRVPRRnAWKYK9TDeFDTW+6t1RVtvZKuUlWQf6cRzqbQVKdjTLSDkK7
 MVMOH9LSS9t9tlcxW2SdvFDuabZfQt4E8I8Sc23WL
X-Received: by 2002:a05:651c:35c6:b0:39b:4a4:10c1 with SMTP id
 38308e7fff4ca-39b1ddf23admr9362831fa.23.1782831816949; Tue, 30 Jun 2026
 08:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260630144244.449753-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20260630144244.449753-1-ilias.apalodimas@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 30 Jun 2026 16:03:20 +0100
X-Gm-Features: AVVi8CeCD8LKO87ANIXPTtJhZfV1EMHqgXPr_IvV0YkyLfe5yCDx1aPyjCEr6sg
Message-ID: <CALeDE9N5D04E4feteT8TGFBKJ+yWiMe7cKDX5Mj6bL0c2oJZVA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for ARM
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, u-boot@lists.denx.de
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

On Tue, 30 Jun 2026 at 15:49, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Since I've added various features in the arm architecture
> support and review most of the patches nowadays, add myself
> as a co-maintainer
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 571af1964654..45e9076de671 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -154,6 +154,7 @@ F:  include/configs/apple.h
>
>  ARM
>  M:     Tom Rini <trini@konsulko.com>
> +M:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  S:     Maintained
>  T:     git https://source.denx.de/u-boot/custodians/u-boot-arm.git
>  F:     arch/arm/
> --
> 2.43.0
>
