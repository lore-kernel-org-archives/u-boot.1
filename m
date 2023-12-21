Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A1CC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 14:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60073876C9;
	Thu, 21 Dec 2023 15:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uy/4dRUx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBA32876D0; Thu, 21 Dec 2023 15:15:28 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA4B6876AE
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 15:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3ba46a19689so678603b6e.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 06:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703168125; x=1703772925; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78SOtyitqLcIYEgzlgFFiYay/81587mtS+YlXnpKQHc=;
 b=uy/4dRUxvwTyaw/E8tDCNN5KSEQFi5La3cJTwXfNhXcsXluR3PbCGC9y+FaZepXJun
 kzmregvmLc2y1hARAu5qxn6MFG/6eSTCUwMoth9TfOuQa1Vb+JaPzSgKE0l3ex8t5fr3
 Rdz47RGW45LBFMt5oh5dhvGsCk1aOAsAvpFNvZlqrjt98P33KfztUleIJ+Bvu6Q7SxQ3
 iEUB7LSMoe5HPW1PdNg+5c60ooC+vU5AV3WE92NfnuIegayWB9prz4N999AZxO+xTocs
 WM/h0HHBRQqWIo9tt+s7wR0nS0tkDBRuDHntoEk45jMaq2L0smt7gh/Tho4C6m8Rq4A/
 /xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703168125; x=1703772925;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=78SOtyitqLcIYEgzlgFFiYay/81587mtS+YlXnpKQHc=;
 b=YLO0pmSobHZ3F3v90CEJ35yOmdCfVOjKD0SY9zev3mwDGeNTJqnUYkFLQ90O0PQfoz
 pHCyHmMTMjxsFTeoCdt/468iEhrG1aUkuB2R5Ydll3JZeHRFWKiMHwGmCs7NTFmjyyj0
 VZSt3U014p5+D5aeemIMUinfCh029DDKRnB9HqvDxLkaw47sHrP5xo9OW7DHbJYOcRn8
 2dosG+lSyVJ5VeemY2oOprSLcRuwwfNn/TeQzerrGnF00SBJc+7vdwA4zlC7Ilu0L944
 v2jpj0o7RJL8a7exw94Fw90I0w35PIhAumSh3TUQfiyNg6f7MNOvYGinKgZFdYqmjxHy
 kSpg==
X-Gm-Message-State: AOJu0Yw12NxDBoXBUMid48gFldMonI6vvMstXdltJdWf1i2gIN57Q6i7
 pgHaSj3eMIqUA0pQLxnZ22aZclbi5/Q8TDZh0OKWsg==
X-Google-Smtp-Source: AGHT+IHGZ0O4/5kiDM1AXbm1+eXrEI/Q67lZoP7jRhfj9zbLrHgXSdCAA7i0bgdPvbKoQMyqW3KbTqEUE+kACWyUXSg=
X-Received: by 2002:a05:6358:7f14:b0:16d:edaa:921c with SMTP id
 p20-20020a0563587f1400b0016dedaa921cmr1478648rwn.12.1703168125245; Thu, 21
 Dec 2023 06:15:25 -0800 (PST)
MIME-Version: 1.0
References: <20231220-maintainers-fix-ab-v1-1-dd16fc5285ed@baylibre.com>
In-Reply-To: <20231220-maintainers-fix-ab-v1-1-dd16fc5285ed@baylibre.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 21 Dec 2023 08:15:13 -0600
Message-ID: <CAPLW+4nH3XO1kZrpsc3Q-g=8eX0fuDqTy1f-etynyXntTAFnEw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Fix ANDROID AB unknown file entry
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Mattijs,

On Wed, Dec 20, 2023 at 10:43=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Commit 19a91f2464a8 ("Create a new boot/ directory") moved the
> android_ab.c code under boot/android_ab but did not update
> the MAINTAINERS entry.

Thanks for the patch! Would you mind adding corresponding "Fixes" tag
below your Signed-off?

Other than that LGTM:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>
> Update it so that the maintainer will get cc'ed again.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7c1cb2dc4dc0..f6de883a7d8f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -60,8 +60,8 @@ ANDROID AB
>  M:     Igor Opaniuk <igor.opaniuk@gmail.com>
>  R:     Sam Protsenko <semen.protsenko@linaro.org>
>  S:     Maintained
> +F:     boot/android_ab.c
>  F:     cmd/ab_select.c
> -F:     common/android_ab.c
>  F:     doc/android/ab.rst
>  F:     include/android_ab.h
>  F:     test/py/tests/test_android/test_ab.py
>
> ---
> base-commit: 9e53e45292ee2f1d9d2ccc59914b161bef9b10d7
> change-id: 20231220-maintainers-fix-ab-2afa7cee97bd
>
> Best regards,
> --
> Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
