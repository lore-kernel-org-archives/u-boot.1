Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F8FC27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 16:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B397880DB;
	Sat, 22 Jun 2024 18:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pMUNXnSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D7F8880F8; Sat, 22 Jun 2024 18:37:34 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B06F87A09
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 18:37:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-70df213542bso2166360a12.3
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719074250; x=1719679050; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mS9z9N0xbKp6B4n7bBkkDFMc7rIGoPVzkmPiD1X6TJE=;
 b=pMUNXnSJJ3oJZL9rCTrTNFLXnqHhZyzpFKKDgiYUacLohjCMTEFQCutE6+q/VOYVn5
 hgQ5HWPr/ygR9WvEc0JRWQ/BSWGj+DLcRS02RS6sDgs5zEn12JUW3yLpz1Exj8HZTVbi
 kXi+aN+5VCjM1f/TBgZ9oxGrFuHzc+e+ePLqPZVhjUsh3bNvse3oNtTI9FMxccpLxh+J
 x4qQdxhJHoiycNDRePkpd5wir44LgTKnTI2Dq8ie8uuAw81rYyXcdDkYnz3rtcU9UzPY
 O7Ows9mXl1funSFrtOF3a0sE/VsGIMnv3ZsTz6KPp0s7mD0Q+/eW6bc1EYbZMTdHTxJB
 y1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719074250; x=1719679050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mS9z9N0xbKp6B4n7bBkkDFMc7rIGoPVzkmPiD1X6TJE=;
 b=vI/EX/or36kQiG/0oGCRgyrtCk+WL0LrkMrNaut5xLEbf7o57rKz4HBjidEpk2gJWl
 NQA75X92Ic4nDiG7jnqVZVhKL2yYX8E5liSWTJymm8CpDjWuNSgOs14nk8RgPQZvlvFM
 8mnN2ihw+y3PpI8YBick9FMhJDuhpFx6qCHDQYlxvYNmpRAR0B/yjidxJj9l2fHgNl1N
 W6r2rht89aNRc+mKlHgUpUlInGCPxK6knDtqgTzBaVF2NTwuXu0xqTzPeSO5zgrEjSeB
 qAsawaCFjBuzrmNd6sMeWlRFmb9hU/2vM35MifpaLWW6pSDBhcpmEiXLET+H3O0nDv16
 rZtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd1tQ4HbmXN0ZF8ckJ7UkUbtJ6yjglgARB09/6feFUlh7doIcM/+X1N2JEhnMeIXtLUJhV51nM2IpdSQxPEDxlVqkKTQ==
X-Gm-Message-State: AOJu0Yzxahtc+53brxVTwLq7mEJL2USdil2UyFxsD5TvznPXxPvwtMSb
 GgWZRMFf7XPOE1gg6J58qJ4e6HtanPGK6HeEqjCzNbuvFmjZdtwz97s/lPIiMfchjacdN0WEk3E
 fu9wnyfDgFLkNl7Zqsye3tCxwMeLJRIp6yXGupA==
X-Google-Smtp-Source: AGHT+IEPgrCBRS7h5FVGxpMdvja7mNEEZ0g0yJq5NYKLztR1s3nOK44QbI9UsPtGgOQv0ivgrdsp9BpitkkMVtfydYo=
X-Received: by 2002:a17:90b:17d1:b0:2c8:62b9:903a with SMTP id
 98e67ed59e1d1-2c862b991d4mr186638a91.2.1719074250139; Sat, 22 Jun 2024
 09:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
 <20240622143601.187723-5-ilias.apalodimas@linaro.org>
 <02965f5b-d824-48ee-a2dc-f4e5883ef26e@gmx.de>
In-Reply-To: <02965f5b-d824-48ee-a2dc-f4e5883ef26e@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 22 Jun 2024 19:36:54 +0300
Message-ID: <CAC_iWjLo6fA4vUPunU1tfbShesmHp7F0bMJm-O=CXteOJBsjgQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] tpm: Move TCG into a separate library
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi

again many thanks for the quick review

On Sat, 22 Jun 2024 at 19:25, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 22.06.24 16:35, Ilias Apalodimas wrote:
> > commit 97707f12fdab ("tpm: Support boot measurements") moved out code
> > from the EFI subsystem into the TPM one to support measurements when
> > booting with !EFI.
> >
> > Those were moved directly into the TPM subsystem and in the tpm-v2.c
> > library. In hindsight, it would have been better to move it in new
> > files since the TCG2 is governed by its own spec and it's cleaner
> > when we want to enable certian parts of the TPM functionality.
>
> Nits:
>
> %s/certian/certain/
>
> >
> > So let's create a header file and another library and move the TCG
> > specific bits there.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   boot/bootm.c       |   1 +
> >   include/efi_tcg2.h |   1 +
> >   include/tpm-v2.h   | 474 +++++-------------------------
> >   include/tpm_tcg2.h | 336 ++++++++++++++++++++++
> >   lib/Makefile       |   2 +
> >   lib/tpm-v2.c       | 676 +------------------------------------------
> >   lib/tpm_tcg2.c     | 696 +++++++++++++++++++++++++++++++++++++++++++++
>
> The patch series were easier to review if moving header definitions were
> separated from moving implementations.
>
> This patch contains changes that are not described in the commit
> message, e.g.
>
>                 if (elog->log_size) {
>                         if (log.found) {
>                                 if (elog->log_size < log.log_position)
> -                                      return -ENOBUFS;
> +                                      return -ENOSPC;

And this is a great catch. this changed in patch#1 and the correct
return is -ENOBUFS. I started working on 2 trees and obviously messed
up this rebase... Thanks!

>
> I guess you wanted to put this into patch 1.
>
> Please, separate the patches adequately.

Fair enough. I thought it was going to be hard not breaking
compilation hence the big patch. I'll try splitting it

>
> + * Copyright (c) 2020 Linaro
> + * Copyright (c) 2023 Linaro Limited
>
> The copyright lines look inconsistent. Linaro Limited exists under this
> name since April 13th, 2010. Is the 2020 copyright for a different company?
>

I'll keep the older one, same company

[...]

> > +}
> > +
> > +__weak void tcg2_platform_startup_error(struct udevice *dev, int rc) {}
> > +
>
> git warning: "new blank line at EOF".
>
> Otherwise looks good.
>
> Best regards
>
> Heinrich

Thanks
/Ilias
