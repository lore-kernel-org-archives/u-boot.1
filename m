Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F63C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 14:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B1AD8712E;
	Sun, 19 Nov 2023 15:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G4VJ4SlO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CCC087124; Sun, 19 Nov 2023 15:49:54 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31A7386F45
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-54366784377so4836714a12.3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 06:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700405389; x=1701010189; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Trkp/64Bzc5cixlO+Z8AJO4bH5Vl0KMTcBPMfmov5A=;
 b=G4VJ4SlOMAB3mKWXjcFoTsJg/csAST+3OTPpmz67F2ApOi0RwfGuYUUUEOnU+3nZ0/
 adQHG+tttQjoVQCFn/nFRN4tvkX/KJjUnBLS4QbkGpkd4lUpyBkbAZJigvbl0R+iYT7a
 Q+LAAIHvE99qL3odLBfHIOlD9lhzd96M1beyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700405389; x=1701010189;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Trkp/64Bzc5cixlO+Z8AJO4bH5Vl0KMTcBPMfmov5A=;
 b=blr0irpqhrVdJ6LNwz09BZ+nvBgpAp8XQ2UELBxH4IKMgfHImJWcDCqexUfSl6Z4CN
 KdVvU2MSDWsKU9oS4oDn+fX9f31kfJx1pJRyviEPJ0eyhIrUxKeL1TZbQW6+c2eBJpXk
 jQwr8N/2439PhCbBOBKR6pw+fc5clVl/kITUGVW6jxtWLraqPb5lVPSzu/SBR4WVGHUZ
 MoKcX6ZtAbkhNZ+Vs1ZjJ7SSOxOtzCFasrTaPeuF50Vh5GsmJzz3SNArNxBK2kCBvhvm
 X/1GpFa9VZfs3xg3c6pUk7D3ZagvWbeqknzAKZn7WMitzVayqRyLuIzoUEaZ7owoDTIm
 jg3g==
X-Gm-Message-State: AOJu0YzfLGO07QYPBH0zkuOCND0DhFEKggWOVEpRZxzEcuHjXN9MRond
 SwAAwO5q1RljpEXH//8Iay0XTzdSOjMbrPU5Gmncag==
X-Google-Smtp-Source: AGHT+IHM5GLg7HgDWgEGZZv1FpPdWT/E3oeHAdNPennQwCSU0EyRRTrAH2XPvl5HCT0BsKBeg85X7XVpz71fZQuO97M=
X-Received: by 2002:a17:906:a219:b0:9e4:a597:ffe with SMTP id
 r25-20020a170906a21900b009e4a5970ffemr3075990ejy.44.1700405389440; Sun, 19
 Nov 2023 06:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-3-sjg@chromium.org>
 <f5201167-c4a3-4867-ae9f-6110f685652d@gmx.de>
In-Reply-To: <f5201167-c4a3-4867-ae9f-6110f685652d@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Nov 2023 07:49:32 -0700
Message-ID: <CAPnjgZ1X7k2THgD7-os04OXyrPgYwp+GgdQdtWvXg3s=ZjJnkg@mail.gmail.com>
Subject: Re: [PATCH 02/29] mmc: env: Unify the U_BOOT_ENV_LOCATION conditions
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Peng Fan <peng.fan@nxp.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 15 Nov 2023 at 03:02, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/12/23 01:08, Simon Glass wrote:
> > The declaration of U_BOOT_ENV_LOCATION() uses a different #ifdef
> > condition from the code it calls. Use the same condition to avoid a
> > build warning if CONFIG_CMD_SAVEENV is disabled.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   env/mmc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/env/mmc.c b/env/mmc.c
> > index cb14bbb58f13..da84cddd74f0 100644
> > --- a/env/mmc.c
> > +++ b/env/mmc.c
> > @@ -495,7 +495,7 @@ U_BOOT_ENV_LOCATION(mmc) = {
> >       .location       = ENVL_MMC,
> >       ENV_NAME("MMC")
> >       .load           = env_mmc_load,
> > -#ifndef CONFIG_SPL_BUILD
> > +#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_SPL_BUILD)
>
> According to README CONFIG_SPL_BUILD is not defined for TPL builds.
>
> I assume that we don't want to have below fields in TPL either. Please, use
>
> #if CONFIG_IS_ENABLED(CMD_SAVEENV)

I missed this comment in the new version. But note that
CONFIG_SPL_BUILD covers TPL (and others) as well.

It is a bit confusing. Perhaps we should introduce CONFIG_XPL_BUILD to
mean anything other than U-Boot proper?

>
> Best regards
>
> Heinrich
>
> >       .save           = env_save_ptr(env_mmc_save),
> >       .erase          = ENV_ERASE_PTR(env_mmc_erase)
> >   #endif
>

Regards,
Simon
