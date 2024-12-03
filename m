Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE1AE74AC1
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 15:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E83F893D9;
	Tue,  3 Dec 2024 16:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZYSavcHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53AB7893DB; Tue,  3 Dec 2024 16:53:31 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1CF2893D6
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 16:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cf9ef18ae9so11763750a12.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 07:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733241208; x=1733846008; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j0dW9kAlqqzDfUQL6MUfD7XN+NJkaK7f8u59kYOwrB8=;
 b=ZYSavcHVCBX2dxPi13E0+QrLUdV4FSU5La5F1xG8PJbUFGd2lG5dmQwrDJ3ma8kw9M
 +bl3MskrVhLYHZ3WyOD7xLZIpA7tzomjra7uzCD52cco3QfXfANlgewRre7CJS1ErfxU
 0lygNiLvYGW7HoRNdHUA+iaYWyKXV0ZLrRWFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733241208; x=1733846008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j0dW9kAlqqzDfUQL6MUfD7XN+NJkaK7f8u59kYOwrB8=;
 b=g1yvt+rUFf5tkpkMEFxeSwQhNxaRicE7gK/yppnDSzU+Fuw9PKxycbgZ5aeGGT+fk4
 JeiKQXHdG4aFSdCgI7POqQOhokvgKu6G66XLAnNdvXDv9VgwXZFc8zvBw74CDeMhy/Rz
 OxNCwJrF+7bSSaBV9FT1D+YO9r26tRT10Ee+gtZ76f/VpQb5k+nLX5NqxS9/5bDT19xc
 kET/IkURpHIpgQzFLS3e5cPttNLhIfS/J9ZzVKcw4xAvkvWWTmsGCRvi08oXQtpknlbX
 eRE7Kde336/64PWmMgQnvFZpNWlnxHVl5Z903tH5TyT2epXuCVvo9Bx3FvHLMspg1WfH
 h6Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBW52eUGBbuKSXmyINwhTFiFuwXpXrxiRtHb6bXlT2x4DKIG/ah6+A9IPjyImeaj19NOtaShA=@lists.denx.de
X-Gm-Message-State: AOJu0YxmpvGi7bJdeGXdWgboJXB63H0sLxhd3ShgETKGfDen4xEbODU1
 XFlKrTnp9dfJ1vOMKADjfdsMQ9UNmb6IFfkTPBQpUMjZAEEaO8eqh4mFordaDrDYG3gtmzKUyS4
 hGYD0fZZXV5xDgloRSS9Q92VjqSba8mVhEIYp
X-Gm-Gg: ASbGnctdoMXcDWM4p675QrjgrHhvvXt99dp6Nte2mloCBYHQ5Iv3gPdmapkh3c32meO
 V/PWKA8kJ4ufa4fgpY5IO6GvvqR+Y0W7V
X-Google-Smtp-Source: AGHT+IF9RRrkUZ3s6/nhfl8QMy66OEjqvC44FLJ+PHlj88A6b49PoALVYwR9J4gKnKpwRNOGZnh+RA/Yr5cptiGtpXg=
X-Received: by 2002:a17:907:3e83:b0:a9a:662f:ff4a with SMTP id
 a640c23a62f3a-aa59431fad7mr2920082966b.0.1733241207777; Tue, 03 Dec 2024
 07:53:27 -0800 (PST)
MIME-Version: 1.0
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-10-sjg@chromium.org>
 <20c4487c-f908-40ef-be05-1ac7eb7e8be6@gmx.de>
In-Reply-To: <20c4487c-f908-40ef-be05-1ac7eb7e8be6@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 08:53:16 -0700
Message-ID: <CAFLszTgs9i4yrL8=YZvh91urYisj0s_ukH+vVGyWWBSULe71Dw@mail.gmail.com>
Subject: Re: [PATCH v4 09/25] efi_loader: Use the enum for memory type
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>, 
 Moritz Fischer <moritzf@google.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 3 Dec 2024 at 07:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 01.12.24 16:24, Simon Glass wrote:
> > Rather than an integer, it is better to use the enum provided, when
> > referring to an EFI memory-type. Update existing uses.
> >
> > Call the value 'mem_type' consistently. Fix up one instance of
> > upper-case hex.
> >
> > Fix up the calls in struct efi_boot_services so that they use the same
> > enum, adding the missing parameter names and enum efi_allocate_type.
> >
> > While we are here, rename the 'memory' parameter to 'memoryp' so that it
> > is clear it is a return value.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Simon, I have no clue why you keep ignoring reviews.
> This is just annoying and won't lead to merging patches.

I got your feedback on [1] and incorporated it in v2 onwards. Did you notice?

>
> NAK

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20241125204456.1525752-7-sjg@chromium.org/
