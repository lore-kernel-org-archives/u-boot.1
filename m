Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A5CCF64BB
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 06:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF4C583FD3;
	Thu, 20 Nov 2025 07:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P5g1vAKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B4B583FF8; Thu, 20 Nov 2025 07:09:11 +0100 (CET)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 452B883E0E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 07:09:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-63fc6115d65so400528d50.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 22:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763618948; x=1764223748; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okps1//HAGZ03XUx/6vOCzkUfGBjwbVRgb0RF3eKwHY=;
 b=P5g1vAKyQ9/CfhpPdt2Fl94UdjD2LFqEfcarkyua8Bl8ZY4KB2UUW+4vnF6FRlzktC
 TUdEH5YiSuFYpWmtqNIOP0e7cVjj18pbWqVJepT20vzBtzvZMAMfjG11BU2NrpQU93OR
 4hEaOKGvqjD1+efI+ls16pcu0ilC1EDsWL+dNefXdC7HvoqCDgnssdopw+Mq3yNdHi3a
 aRYv80KXALr7wmk/jQoQtEtdTUomF5xI2czpFKqdX3aE0K4bkPoX2DIC+6BHGZ1SsyWK
 ODICsNEAjS8d2uPIKq891SjR4RnrmEv+DKAUlf/mS/hsK45RCUwbh5YakhmUIVZhzCnM
 rdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763618948; x=1764223748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=okps1//HAGZ03XUx/6vOCzkUfGBjwbVRgb0RF3eKwHY=;
 b=P6TqGTbkiP4KSgUZm8OGOhXG2h+IDc1PUicpOYqJME1P+JdiZkf29pduOvnPL5VXQ7
 MqEtADqaX7je/RoLY+ydQluYU4LJ8+Qr3gn7gGVQ5Uk6aNUIPKjItowAGuu6ALmrbLET
 iq5LS+I/wArcEy+q/FH3bZas1RTciuWyJB5VIUA4wcRJamv7u+quIrLwVV82sRWra733
 G9xwf4nH/qCYBDSSItZ+KLpvXieooUrr2c486s9KpTIFLEOQSXkHW1LuG8jnMNiGrZUI
 KyOp7d6nX3V4CKuzXI921ArxLYRido7Rr/3UqqVYW/FagQjHF/hBJeH7vX4gTF6B6kmz
 kAKg==
X-Gm-Message-State: AOJu0YySQP1Cucnlqy09bmIpTx0Kax99PR5Ru4mHST9TWCh8uTNHv/gH
 r354FS10+5dkTWnnOkijIgHVviD2AyW8FWzTDvsSY+2YZhgCIfNELDl6u+d8a+G3tl+M2QIEZNA
 bRK4B2xvlx2AQQRFoSrAA7k/Y8QvxeDU++ZUiUq/BLnUNu0t7V2ymnI/2rA==
X-Gm-Gg: ASbGncuQzgKojqzt/uHr3XEHccIg4eRqEBKJwWI+HW/U+JpaMdOVOjLaHagAA1qFTfs
 iBmW9Do7GepXRtuH8zK8rx7Mm5Xw4JfCaW7XRajCDXJC+iCMv97VXBgVIl7iMzDSjQXXp0v8Htc
 a4FTOkWsOuXwQBJYUwUV1BDKc1dU45hmv1UXQXePi8QXtZXcdPw4FiJzo32C5r2AVkt1U+ruqE0
 AnsHHKWef/DPDSRmgiF6nOe1cDZ9b7loXqb2KU3TBqTyKPaguHdWLegzc5jq3pMrLLdm6bMNzN3
 xQJMgv2APMYAIs5CKRqbPGQdK1Xy297B/Q99RX3BKuEKx9gUww==
X-Google-Smtp-Source: AGHT+IHvtvSFZSzsj0QmI08Za1y8HZTPWLGrsCe3/QuJhn8OMVn8XPzoBDOg2JtX9d+waGr65lYLPXQOARaBnzwLLI8=
X-Received: by 2002:a53:acdc:0:10b0:640:caa5:57bd with SMTP id
 956f58d0204a3-642f786a437mr1207333d50.37.1763618948041; Wed, 19 Nov 2025
 22:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20251119174425.58535-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251119174425.58535-1-marek.vasut+renesas@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Nov 2025 08:08:32 +0200
X-Gm-Features: AWmQ_bkR-aCZ5hABvyQol8e8RiMIG4Lgbyabq9yDgzg7G0jVh827YTD-wBWAtAE
Message-ID: <CAC_iWjKCmuTLG2RYzqexTFdrcxcvnGu1Jrw8RAx=bM0Jxry7Ag@mail.gmail.com>
Subject: Re: [PATCH v2] boot: Warn users about fdt_high=~0 usage
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Wed, 19 Nov 2025 at 19:44, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> In case the 'fdt_high' environment variable is set to ~0, warn users
> about the dangers of the fdt_high usage. This will hopefully lead to
> removal of most of the fdt_high ~0 usage over time.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> Cc: "Jo=C3=A3o Paulo Gon=C3=A7alves" <joao.goncalves@toradex.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: Warn unconditionally
> ---
>  boot/image-fdt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 3f0ac54f76f..a3a4fb8b558 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -189,6 +189,12 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of=
_size)
>                         /* All ones means use fdt in place */
>                         of_start =3D fdt_blob;
>                         addr =3D map_to_sysmem(fdt_blob);
> +                       printf("WARNING:\n"
> +                              "The 'fdt_high' environment variable is se=
t to ~0. This is known to cause\n"
> +                              "boot failures due to placement of DT at n=
on-8-byte-aligned addresses.\n"
> +                              "This system will likely fail to boot. Uns=
et the 'fdt_high' environment\n"
> +                              "variable and submit a fix upstream.\n");
> +
>                         err =3D lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &add=
r,
>                                             of_len, LMB_NONE);
>                         if (err) {
> --
> 2.51.0
>
