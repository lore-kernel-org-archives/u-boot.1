Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21330C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 10:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C64E87067;
	Fri, 12 Jan 2024 11:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="YOfW8RdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 754098795E; Fri, 12 Jan 2024 11:08:47 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF7FD87021
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 11:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50eab4bf47aso5478383e87.0
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 02:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1705054124; x=1705658924; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dK9wtzR+fGst/AlzwAQMS8Nh4Lq9DbHsbXJzoblbl+k=;
 b=YOfW8RdPZzOyCKhFUMHR76EYT20DXaMO+E3KQ/weT2B0DYrfrowN4qAmRs8aIZodyo
 kLqg33/exYcIWBkIrA9XhldZkdJ1fSznCyrwzK3uVFOOKq6Z9dNKGdRjWMzEJAF+bEsx
 pZfGYvtS5WijvhPs7LWoAKtW4p1CLou0eHkstp0gzeBi5yhG8L8VLSfVEiIyC/8n6L3g
 hP6itxD9mVWQUEevNBqriFsbV9Lxx0xlkQQ3swnDtjW3UT9CEN0fh/mxlwL6vHb/iDBv
 6xHZqk6GAAU0JeV3kJs1OTO7pdcx4JXyGPZ8NoQSqG0heVgwp7Q2x141GwNfrGcbN5Bd
 0MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705054124; x=1705658924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dK9wtzR+fGst/AlzwAQMS8Nh4Lq9DbHsbXJzoblbl+k=;
 b=vZumDk+46BmGi8UEKI9mdcLJZXt9Y7CtStULnHH+k9ndtUY+SlbVIcygnM96FJY8aA
 eHS46FlnxRwqB4PexqRC6viHIDHInMYOuvBU14MUyvFm1FHNklG+TbT+IREr0KOg6fwO
 4bWPsQ1uDzxd2VB0vLoFR425TKqtsCkt+SZvbY5vFEP2cwVhXugCgMVp5dbvaT1iiTFL
 Kn1/Z5Z84cdmR0zLG+Qv2LmgmtuqArrbC5w+Knaggyw8pvAsj36O3gZpKkqoeloh0DMX
 2bV3rX5bQ9xTo5fuxCNSyE+yizk02JioGHF4fJ/AXXC3fwaaQZBhzxxYInB3keS2AtrC
 sqVA==
X-Gm-Message-State: AOJu0YxqKoEZOF3Fr+TldiGGkXpO15CWUzJW+vl3lM+9nV/Nu87hYxcR
 tKb0feM19KLGidvr+ltkE/mgbF06iiX2vSz300ga+r++koOTOw==
X-Google-Smtp-Source: AGHT+IHBDdMmDhF3usXkFNch6Ywh2+DVq41OnMS3XDz2ydXNHR5XDkNsyd+shC6f0H4mcN7Hf5ZbU3zR9PN7DyYHQ1Q=
X-Received: by 2002:a05:6512:39d3:b0:50e:70b9:8600 with SMTP id
 k19-20020a05651239d300b0050e70b98600mr752780lfu.0.1705054124078; Fri, 12 Jan
 2024 02:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
 <20240112-maintainers-ab-v1-2-f2a538eab18a@baylibre.com>
In-Reply-To: <20240112-maintainers-ab-v1-2-f2a538eab18a@baylibre.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Fri, 12 Jan 2024 11:08:32 +0100
Message-ID: <CAL6CDME2sQohvKDcUR+6Y8jR8NMELZ6wNVmg7Xj69-5z1iL+qQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: add Mattijs for Android AVB
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
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

Hello Mattijs,

On Fri, Jan 12, 2024 at 9:41=E2=80=AFAM Mattijs Korpershoek
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

Thanks for volunteering your time to review/maintain AVB and A/B
related changes. Unfortunately I'm not involved in any AOSP-related
work at the moment nor even have a board at hand with up-to-date AOSP setup=
.
If the situation changes in the future, I'll be happy to assist.

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
