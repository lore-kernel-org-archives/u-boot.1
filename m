Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C8FC4725D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D07D38794F;
	Fri, 12 Jan 2024 14:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OiFhCbke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD5A8793B; Fri, 12 Jan 2024 14:47:18 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50FCC87B0F
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6daf9d5f111so4976392b3a.0
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705067233; x=1705672033; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvDaeEHp6dpUe+dll8A8cJThJVY/LQE3rbKxucRVTgM=;
 b=OiFhCbkeEC5bbb/bH7v1TiXj2/W7mkmRQga+VNoLxptSYJOJQAURMOC/XSGWYa2PL+
 +GHa9apMbmBZ51wSbkroivnaKizw+Md2faSVy7EkhLidfc+DIYVaDj9rNjaIQXF8n+Zc
 X/d+a//DjXxfpSnm2QPJxo5mf0fTCIszLRGoTdfAy7mB4XCGzsTtnWRiWPMpLB0tdEt8
 mufTzJs4bfYXKV3WcDinXm5vymyQvFw6MV1/ceSUqGNomh0SuWNzS434xCmgUM7IdvjX
 UvvobEW1ebZyjgnSAmFCK3Qotwvg98msVLJmJ/6v5ghtQH7onn2xrY/Qx0Cm4IY0sBUr
 dlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067233; x=1705672033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nvDaeEHp6dpUe+dll8A8cJThJVY/LQE3rbKxucRVTgM=;
 b=lQJPRckNBTwX7v/M2wnOiWinbTLQUg+dyb1Ks2ZYJJLOVakLhbRc74j8TqVtDRrW/f
 j1KpvtYeGaZzHPWaknBgOcFlKlQSuBaiJuFf7H2kd+XFHwDDyOo6ZekmSXjLZ0u2csq5
 jBWhbwtcSmDrA51hkoqXzsImRXokHiEijlHYswYwv8ooOGGvrgDSgeR94/Ku7jCJZWo9
 B58a4aaUQODPpz6vD2+xdzAuKWeRUji/6Gg3M4+zzOnvUSoIzlyVe/Ocj+UT3E5ochhG
 8ZZ3ZYV86RBxeak3qtGdOoVpp0Y88EJCm2/QqN8ghEk3xtq9f+VzEzOsMAbU7C0EDdbi
 WRyg==
X-Gm-Message-State: AOJu0Yy4fUDaf8kSCzTh1YSz36L+Up4+7HyUZZMqcR1N9AvSdZwtzMpk
 zzL3NGbP4b8BuhDL4lK1IS/a6vtg/vKdP3WsSphLC/6SrwVqMg==
X-Google-Smtp-Source: AGHT+IHaogIqX7XeHOEctiraustOkfRRPgSMyx8OYgEBIhwJkBxTCb+t2EvDgXcztA8hGHMEijT3yXS1srnge6pnJ5k=
X-Received: by 2002:a05:6300:8082:b0:199:a725:9b59 with SMTP id
 ap2-20020a056300808200b00199a7259b59mr1059141pzc.114.1705067233667; Fri, 12
 Jan 2024 05:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
 <20240112-maintainers-ab-v1-2-f2a538eab18a@baylibre.com>
In-Reply-To: <20240112-maintainers-ab-v1-2-f2a538eab18a@baylibre.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 12 Jan 2024 07:47:02 -0600
Message-ID: <CAPLW+4=3CbUYFmK-vG=baTwiwLSULZVYXp8WcWZy93Gijc9hrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: add Mattijs for Android AVB
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

On Fri, Jan 12, 2024 at 2:40=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Igor has not been active for quite some time on lore:
> https://lore.kernel.org/all/?q=3Digor.opaniuk@gmail.com
>
> I'm interested in helping with maintaining the android_avb
> command. I'm a long time android/aosp developer and my daily job is
> still doing android work.
>
> Add myself as maintainer for Android AVB.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3c73d8c35c4a..4978470c1664 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -70,6 +70,7 @@ F:    test/py/tests/test_android/test_ab.py
>
>  ANDROID AVB
>  M:     Igor Opaniuk <igor.opaniuk@gmail.com>
> +M:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
>  S:     Maintained
>  F:     cmd/avb.c
>  F:     common/avb_verify.c
>
> --
> 2.43.0
>
