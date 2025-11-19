Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B9FCF2591
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 13:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D81F883F2D;
	Wed, 19 Nov 2025 14:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XGiehkBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489C083F3F; Wed, 19 Nov 2025 14:16:40 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D46C83F2B
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 14:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b737cd03d46so617106966b.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 05:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763558197; x=1764162997; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Aw2KAwSqZXnR1n7zKPS1M3j2vhk0LW74nFFN+coPuGM=;
 b=XGiehkBTud5k/aqpGUQ54mBwPILXco/lzbav3yuaUuy2+cB72oGARZJI8QbHaI+8An
 QjJh+iSRRzfo+Oi71YqveuOT4T8NOPEZIV7LOJbbec7qNYG14OKkVybFm5UEsGdVzMeb
 Ptf34v2AaMadFGMRzOmLiyQWBYXzoCYQiUkbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763558197; x=1764162997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aw2KAwSqZXnR1n7zKPS1M3j2vhk0LW74nFFN+coPuGM=;
 b=r5rBVpGFn5NwmBRk71+TCLXT+C+oW2RBVuJbb0vtjooYD7hYWLE0U2mNapYNNN4icy
 BBT7tB8sauBPvkM1npme/wCR6shsZuHS1DFOMU+/GWO/4fMz0IPX5GoMZ4iOHGXprbCI
 5+Q156JiOtmlzX+sStYUhgCB7gLs5DH3FaFVbZm8nraOCm5OhqUOqDiyO5WwWSusYLF3
 +ermqEk+Lg9IZUBk0ptcosIK1kIvzSsBMnWHwoVm5VWCOXbFnytNreuEwqMqlgSSjehs
 /TKJIAxBjH/HE2IIIMGNk+EqnCIDCqGRSAg4wE0M3Jf3dRXcFmhzmm5RPcEY5yC11Liv
 3BFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6cFRXwYGD6gP+Xsg30sDS0T+2+tz27ynliy3eiJYGVVwMTg/O/DX1FM9yUW28xwhv6d10rWE=@lists.denx.de
X-Gm-Message-State: AOJu0YzIK9z7dKo+6fEr8yRSqD87wmcnWD01qU6gKQCBhuGFy11Dxh6H
 vHpqwG27zG5YOTLlHD9AChf76b3lwYTCOHRnZkvQD4Y2WrSaH1gtUCZuS80MofFAJgusiROLxTC
 3pFkgChqzzdpjnZJmGZd4mTwVQfSYU5JYt5VM96n/
X-Gm-Gg: ASbGncuwSORBmrOiAEnEf6D2XCaQ3bGAotOfyuKoV6c1RsuY1U/5D5CKb5TdvMiP2nH
 EW1O9R7w3ml18gCE81wx4ETRbCSMt8y41/di+4RAHKNxL6lZz+jFYzQ56r7xYegR6q4/SKtfhn6
 G9329ig1sNeLEOCuZN8UCsatgucvr2vc00OESYiW2YFV0P/2wP4q9cFSgx+aS1FiiMkCcYtAcLj
 BzQQLZ5PmHpD7SWa3geOvR4gSESrUg4r4hjy+m7naeLy6gng0UQGXY0Tfk5MQ8WwSImC+qKHEPR
 AwUU
X-Google-Smtp-Source: AGHT+IEFiEgJ7MK3lIrFaD7sSIdCSqj9yXnsx0zpKcGibCWRy/kfqBuDJv0F/Ad0LcsYFFFw2ViFjxsItPSrn0nXXLw=
X-Received: by 2002:a17:907:3f05:b0:b73:4fbb:37a8 with SMTP id
 a640c23a62f3a-b7367880f9dmr2216238166b.12.1763558197522; Wed, 19 Nov 2025
 05:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
 <20251118201733.67297-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251118201733.67297-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Nov 2025 06:16:12 -0700
X-Gm-Features: AWmQ_bnmleyFbyte7K1gbVlcpJB01zlf8bSCt-x0oV6Lnt5mqyMJLwfRHfIUjDM
Message-ID: <CAFLszTjo9hhnOHD0iWJnma1+eTty-d5tTzxkBb9eijd-Chdtqw@mail.gmail.com>
Subject: Re: [PATCH 4/4] doc: describe return values of C tests
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
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

On Tue, 18 Nov 2025 at 13:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Enumerate return values of C tests
> * Reference assertion macros
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/develop/tests_writing.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
> index b6972489d4c..1a020caa411 100644
> --- a/doc/develop/tests_writing.rst
> +++ b/doc/develop/tests_writing.rst
> @@ -228,6 +228,14 @@ Note that the MEM_TEST() macros is defined at the top of the file.
>
>  Example commit: 9fe064646d2 ("bloblist: Support relocating to a larger space") [1]
>
> +* A successful test returns 0.
> +* A skipped test returns -EAGAIN.
> +* Any other value signals a failure.
> +
> +Include ``test/ut.h`` defines a number of macros to check values and to return
> +from the test function if the assertion fails. See :doc:`../api/test`
> +for details.
> +
>  [1] https://gitlab.denx.de/u-boot/u-boot/-/commit/9fe064646d2
>
>
> --
> 2.51.0
>
