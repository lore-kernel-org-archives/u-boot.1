Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76FCC5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 17:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EF5A87B30;
	Fri,  8 Mar 2024 18:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NSfYsBqB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C78687EDD; Fri,  8 Mar 2024 18:56:36 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0393186D73
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 18:56:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dcc7cdb3a98so2490712276.2
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 09:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709920593; x=1710525393; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1eT2gFp9M35pk86W6zKnkd94VtaTtig0KFi30SdBOQ=;
 b=NSfYsBqBQE98RjwiLEPs6USUw5H6CENHYIUsZggfeCyLqTnwkCRnBZYxJYMv/P89Is
 RV8Lld0EQfQPP4SyAaB/t8tyUY3X3Mv7KBQuA+7TL/Qhqmb6voM6PFMvlFn3/CpJPRw+
 9fbi2NfyMWzZJR7XxF95NJqJsic4vK9ffw12hDMeIXmSp0n/BlOGcjRVAOvTmCtU9Om9
 xodEMxHC/EWQepHLRXVxFIxTR+UgP/uk7PgdJdyOfs0QU5KshyHH/U8/Olyk5biNdh4b
 S4tPdiBY+ZcI/ObvwRTEmagfcjFQM8GTteKoYzDnammHAmPPPFmvMXKfrn8i3JFRmc39
 qFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709920593; x=1710525393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1eT2gFp9M35pk86W6zKnkd94VtaTtig0KFi30SdBOQ=;
 b=Hi7x3+7bWHXn0qg/9Dx7amO0SA9PUVpo1dtay6hcZmqdyydQ9L5izEPRtWAK7Y+pwH
 K1gDV35zzk/npBDWVxz6ZLzAU2hG4Ev7GGrA8kgiDHcEpt1/jReo77HLN0jzNCqP43bj
 4OwWKVQsa8UIUt/CG1lJUInNLtQLyyXobHwG1QBsQ21+b+sCy0wnJb7v7AYb2P7F4JX8
 9YaRgivIVua/flqs59+rs7UOEhvfI99JGLBYsw94rzEovm2csJ5C7sCd/1+zZarWbTIC
 ECZCnxvlrJeJPdgmgmeejuPJJn35UYYdeChRrHow6y4L2LvBuoVg1O3m/uQ9sMFH2HBj
 cUxw==
X-Gm-Message-State: AOJu0YzC7mO3id5CvcMr8fSkySfgFsew6EGN3ZewpcZvVcWxkR6ZX5o/
 m9kzMafHmN6tC5bryQS4JN+yuq44t0587FtfuuWXNxvzJpEm9jFwnvY0q2IgDVWtUmAOi6HzmcE
 PQNi5oS7HEhL735jIjOCB8OeRkCekuYr5LBewBQ==
X-Google-Smtp-Source: AGHT+IFgWpwmtCZ07tfyPwu2+8Uaz46RSqKWjvIcqTHvUkw8qnGjVHlTkFrV1MAH0D6P6AYCqRxvz8EpayAbeV6RPVM=
X-Received: by 2002:a25:b983:0:b0:dcc:bc92:6704 with SMTP id
 r3-20020a25b983000000b00dccbc926704mr19121973ybg.18.1709920592742; Fri, 08
 Mar 2024 09:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240308165937.270499-1-colin.mcallister@garmin.com>
 <20240308165937.270499-3-colin.mcallister@garmin.com>
 <CAPLW+4kG7yc2xG4VCLPapsP=cD4QcBQEV=bsPG3zYkwjRJeFzg@mail.gmail.com>
In-Reply-To: <CAPLW+4kG7yc2xG4VCLPapsP=cD4QcBQEV=bsPG3zYkwjRJeFzg@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 8 Mar 2024 11:56:21 -0600
Message-ID: <CAPLW+4kHmPtfACyND4Vc2p0ZrsyGY=+bRU=fdub4K1uX5p33Jw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] android_ab: Fix ANDROID_AB_BACKUP_OFFSET
To: Colin McAllister <colin.mcallister@garmin.com>
Cc: u-boot@lists.denx.de, JPEWhacker@gmail.com, sjg@chromium.org, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>
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

On Fri, Mar 8, 2024 at 11:50=E2=80=AFAM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> On Fri, Mar 8, 2024 at 11:00=E2=80=AFAM Colin McAllister
> <colin.mcallister@garmin.com> wrote:
> >
> > Currently, setting CONFIG_AB_BACKUP_OFFSET in a target's defconfig will
> > not actually enable the #if protected code in android_ab.c. This is
> > because "CONFIG_" should have been prepended to the config macro, or th=
e
> > macros defined in kconfig.h could have been used.
> >
> > The code included by ANDROID_AB_BACKUP_OFFSET has been refactored to no
> > longer be conditionally compiled by preprocessor conditionals and
> > instead use C conditionals. This better aligns with the Linux kernel
> > style guide.
> >
> > Fixes: 3430f24bc6 ("android_ab: Try backup booloader_message")
> > Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
> > Cc: Joshua Watt <JPEWhacker@gmail.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> > v2:
> >   - Replaced #if conditionals with C if conditionals
> >   - Opted to use CONFIG_ANDROID_AB_BACKUP_OFFSET directly instead of
> >     macros in kconfig.h as CONFIG_ANDROID_AB_BACKUP_OFFSET is not a
> >         boolean or tristate value and doesn't have different values whe=
n
> >         building SPL or TPL.
> > v3:
> >   - Added "Fixes:" tag
>
> Can you please also address my comment about CONFIG_IS_ENABLED() in
> the previous mail? It might be just an answer if you think there are
> no issues with that, not necessarily v4.
>

Ok, I just saw your reply in patch #0. Given that you tested that this
change doesn't break any other boards/configuration (e.g. when the
mentioned config is not defined), feel free to add:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> [snip]
