Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5B1C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 06:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79F6887D5D;
	Mon, 18 Dec 2023 07:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U81ZixhJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD1E487D65; Mon, 18 Dec 2023 07:06:43 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8124E87D42
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a235eb41251so30466966b.3
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 22:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702879601; x=1703484401; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pshZQK34PM7YpZAvfmAYz5r1LtrHU0kTkjlPMXSkXpM=;
 b=U81ZixhJVpALSNKMjOE0CEMaG+UjVOK3FGDQuPbrFB4cuwe37vB7fmATF1MRysrAFU
 gWp18g/2jdpJwoUVO6ZnjCRw5owVIAqANvuuYg8HdrfCHtzthkqSazeOk17CsZ9+kVGT
 xnrYiJ/vN3VsmOnG1UyLWibnGeJu1sJ36bYaZv7XNuXUyFJP+hpARAsOSs6b3m4tMeeM
 WZ1umoKRCHiN4CCByHV4Cz2NGgMS1Q9TgUI8IpqMzqKqZXlf41fBbXZribSuOJs1uuSM
 oCCsm/Kfg4R3ItHu0Z/vzORq6bDY542ZnOpZT2owsNk7xlvd7TAWgPemmQXV0HsP4pv3
 7hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702879601; x=1703484401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pshZQK34PM7YpZAvfmAYz5r1LtrHU0kTkjlPMXSkXpM=;
 b=tPgQJXVogUSC13IeB/BHS57ARAOpiX16DfuilN23mcNChBt8ZNzr9ao/R5bqrrz7+W
 5+w7sbO+Ju8vsN9/fHWtJevuro5AOnlZ7he8T6//0AUzwKgU6hmHXHnx1rXZSc9iTGKH
 CxCmatBgMaWrVHsLz98Ip2Sg9M+cd3BQjXHTAAY7fdkS/Cu8IzbK0bR9H5bNgnLxPPa0
 ZlZraLicqOOhRvViQkk9tMJa7/5kcosjnN9/7SXAPBG675hNqGJ+BLe7cWjnLYlyxQtG
 rfIohmZXYgOo5PaiSzdHHqQ3YAZ7iuThm76fdSOwLI+hqaaId9J+8++xKWye0ZzL2Iss
 WaZg==
X-Gm-Message-State: AOJu0YyiLLKwMpWrWBcyl0cutseYO6KHa5E04M07YzI/NeiH9MiF8Zu9
 y4aQtRmZxysYyYr9Aa9iIHCR0spsAVJPP5yq2WghWg==
X-Google-Smtp-Source: AGHT+IFVI+gDmtV2SOWfvTIFtL363Zu8bA7k7UmdZfOW2z1dUWshJLklsYfVigBNpgoqbObepfG9AMt4MtlL2YO9vGk=
X-Received: by 2002:a17:906:e287:b0:a23:4abc:25d1 with SMTP id
 gg7-20020a170906e28700b00a234abc25d1mr436454ejb.24.1702879600965; Sun, 17 Dec
 2023 22:06:40 -0800 (PST)
MIME-Version: 1.0
References: <20231208053914.216413-1-masahisa.kojima@linaro.org>
 <CAC_iWj+RmYMBSd+xFm=dsBoC7zx49+WjAt6RQMnrZxovad=RAA@mail.gmail.com>
In-Reply-To: <CAC_iWj+RmYMBSd+xFm=dsBoC7zx49+WjAt6RQMnrZxovad=RAA@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Mon, 18 Dec 2023 15:06:29 +0900
Message-ID: <CADQ0-X9LwQ4hRqKNaa7afJSAkz7gS2XOCo5v+dkj1Cx-5MXVBA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: fix iteration of FMP protocols
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Fri, 15 Dec 2023 at 19:07, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Kojima-san
>
> On Fri, 8 Dec 2023 at 07:40, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
> >
> > If one of the FMP protocols fails when calling GetImageInfo(),
> > populating the ESRT ends up with failure and other FMP protocols
> > are not added to the ESRT. We should still add all other FMP
> > protocols to the ESRT.
> >
> > With this commit, iteration of all FMP protocols continues
> > even though one of the FMP protocols fails.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> > Note that this patch addresses the following issue.
> > https://source.denx.de/u-boot/custodians/u-boot-efi/-/issues/3
>
> [...]
>
> >
> > @@ -381,14 +381,14 @@ efi_status_t efi_esrt_populate(void)
> >                          */
> >                         EFI_PRINT("ESRT erroneous FMP implementation\n");
> >                         ret = EFI_INVALID_PARAMETER;
> > -                       goto out;
> > +                       continue;
>
> This doesn't look correct now.  We set ret but we never exit to do
> something with it, instead the result is overwritten on the next
> iteration. I think we should only get rid of the assignment, unless I
> am missing something

Yes, we need to remove "ret = EFI_INVALID_PARAMETER;" line.

Thanks,
Masahisa Kojima

>
> >                 }
> >
> >                 ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA, info_size,
>
> [...]
>
> Thanks
> /Ilias
