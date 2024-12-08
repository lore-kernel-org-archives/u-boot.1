Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72307E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 15:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72C2A89348;
	Sun,  8 Dec 2024 16:29:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UELZ6NMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D0989305; Sun,  8 Dec 2024 16:29:25 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 053FF895E0
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 16:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa642e45241so396041266b.1
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 07:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733671760; x=1734276560; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3bGfpczyFvrAjrz0iJqwo04sfrtkxE3XaovgqBxulS8=;
 b=UELZ6NMYpc7pqX2+qacwhiMIMpGxMkGauRxCn1feeRS1+kzwpeqI/z71GsmZ4AHt6d
 GtPiBWrNSpGoFSr3RjGrp4WN+wpChmI9Me7dlewrmiJzX2FQegtUlFFaIzGBAj1ghdZU
 tvAgDtb3n2YfeUVGeBxfN3toYbjveBQQlEJeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733671760; x=1734276560;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3bGfpczyFvrAjrz0iJqwo04sfrtkxE3XaovgqBxulS8=;
 b=UgTZT+dEkhvl+EZJ0i2c1nDexq212JYrx0ZcrqpjvHX/gqzzX/9n92zrWRrzULdrbs
 ox4tUBS3ONzYZgM7MnXLw/Rv8YskEzSyypvYVUILtqTte48kYOf3PxzhOoBw5FfIysGR
 5e6cv7O5f327W+DzMD2k1T8yrpZV38A/zy7jc8ZaRwvdBPddfgmK/+Z0n6MAcD4p+R9A
 FeicBSleS3K09ubNuHr3+kcfOIL9b4ky/TBFgRaBoKKP9TsJW6P1y7NtuNdTTZN1yhvU
 NA9mxfj8Py7pVSJM/cXi904tl7y+XRcukiebmWlposuoR2wkotg2EanS95zr7tuPFSjV
 wu3Q==
X-Gm-Message-State: AOJu0YwJoibcR/69XB7c/ivPBlDRITuzoD/uwxaerUPyRXYVAX9TXgLV
 6kbl3HhRCcQoqmbYzpjYUtxZ3Yv1jTIL7iettovX4CMsrmUXsSNbGZP5PZGt9h+iBbOIjVo8JvI
 0fRpqP8XakC1Irhiy1WXxyVqF96YAoe6C5W+Qfsq+sIsQqY0=
X-Gm-Gg: ASbGncs/f/xaN4dC7cs5KVl65hVwIjj0eZGnZTrPKI4WEd/oYMQiPPOztr1RkSMe5/z
 S5MdrXt2u00ij106HnSfLGTFrTPcFZx4Q
X-Google-Smtp-Source: AGHT+IFRRkQKswOjuGp0pKyjtUjelKCqW28rIqCM02xZ0G3tx/TgQuw+hKNYdx1qxP9SQxVzpjK3zov13hp7mKb8/3k=
X-Received: by 2002:a17:907:2918:b0:aa6:873b:ed8a with SMTP id
 a640c23a62f3a-aa6873bef1dmr69498166b.47.1733671760426; Sun, 08 Dec 2024
 07:29:20 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Dec 2024 15:29:19 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTjYd-8LueZSaivTeZH0H2==LJLD_DbRuqzNwqR_MphSCA@mail.gmail.com>
References: <CAFLszTjYd-8LueZSaivTeZH0H2==LJLD_DbRuqzNwqR_MphSCA@mail.gmail.com>
 <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-8-mjg59@srcf.ucam.org>
Date: Sun, 8 Dec 2024 15:29:19 +0000
X-Google-Sender-Auth: XMlIp-7jkqAInMSHw-omGXRSVJo
Message-ID: <CAFLszTh4KbU3+Z6xdJ3xsCzcXb-h1SSUO89qA+NnVzOx2EO1Xw@mail.gmail.com>
Subject: Re: [PATCH 07/10] Support separate DTB files with the UEFI app
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 Bin Meng <bmeng.cn@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Matthew Garrett <mjg59@srcf.ucam.org>
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

On Sat, 23 Nov 2024 at 12:57, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> The UEFI app is an actual executable with things like section headers,
> so just gluing the DTB onto the end of it won't work. Add an additional
> section to contain this and allocate some space, and then during build
> copy the DTB into that section.
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  Makefile                        | 7 ++++++-
>  arch/x86/config.mk              | 2 +-
>  arch/x86/lib/elf_x86_64_efi.lds | 4 ++++
>  include/asm-generic/sections.h  | 1 +
>  lib/efi/Makefile                | 2 +-
>  lib/efi/efi_dtb.S               | 6 ++++++
>  lib/fdtdec.c                    | 3 +++
>  7 files changed, 22 insertions(+), 3 deletions(-)
>  create mode 100644 lib/efi/efi_dtb.S

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to ci/master, thanks!
