Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19EFD1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 19:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F30842E0;
	Thu,  8 Jan 2026 20:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vsn4ypXP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4B8E842CD; Thu,  8 Jan 2026 20:59:36 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B92842C7
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 20:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64d0d41404cso5337622a12.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 11:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767902374; x=1768507174; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ps109TMXD3Xl2MipTR4vkPOsUDmDtYm3G4kLXnSQrHI=;
 b=Vsn4ypXPPyxQTnLKbG3uuiMcuztBERwqt5BF/2JyZPMHs7XeDcyGNATXTbG7mXVNTb
 V5yrDG/T5cACf2Q32IpXcyg3sXs32tM+0yrj7+W0NtXtRRe3rQpcApqkzFu6h+21riqF
 QaoXgavfUTFV2JSwxGic2NkvkDY8FSu2CSRzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767902374; x=1768507174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ps109TMXD3Xl2MipTR4vkPOsUDmDtYm3G4kLXnSQrHI=;
 b=m8Kl6M9eaPRZpp3dwIw/xaySZs7RaVjtuD/3Aqj3eDfC5ZaEFR4Xa0UyloF1BhlXRw
 h3r0gxwCGwj6Y22XBbOkYvDm7c6yY6FVJwgA7sDtYA5HRtCWxIZj4E7JSMHzA7AXKea9
 orszlI1g9pZTCTKhMEeLN8GKVLpzGKzFNw1CdHBeaHdlcAW2wW1KXu3UTc2Mjl6re+Tt
 44EYmaJe/xBNTim6ysx9s80ZYVZhF0Jkx9bWxrezI9h5yWz4rx//LKA09INI9k8NufKw
 HkxNdP3Hzjl93vuc9MjkPupzb/XPXJqjwVRlC1j633ywPWAMfS6GtTQfB3LRyrc77Mxu
 8NNw==
X-Gm-Message-State: AOJu0YyPprPXH5JPabdHn0Pm0W2q+qmETQmCz9l6rSj/LAHHEEKIb8ve
 z4p15z5k0YNGRfjnKCCNRxYAzRShakrwc2UJWxwteHMqc55X1Z+86if4E53qUwOGQ6oWJaeR/xF
 9J4XzpEvwVw3+fUBDH1PDDWiq4OjJRyCgRAIFPxK2
X-Gm-Gg: AY/fxX6h5pQStmJqVF47zcXaDWAFmlakSG0SiikxpNlNeYYbpqF6Pbc1p/z8wEPvuMP
 GKgjS/LxbFmqdcZrjnYsZVpHd7751KNptb7w1LfMd9BQ6Q0STRRyV0Urhl7uXIOPc/1NUsH08f1
 XvkfN+ghzMTIUgYqPmoQw1Zl8pAZokubFgxv3NyUWyXAl1JsdN3DA25m8F/68qAqqzxkMVBLae4
 eCej18f1CAUTZMyx3p813KM58zQic8nRoQK8ap+2Uh/XoZTwGtE7LidKxTuTN5yvYIYNA==
X-Google-Smtp-Source: AGHT+IGzrnFUBBBwVMDndGiCocqFUeNiZnwjpPz54ZZLB7Ntn+fqmPmGCwALbIiqUWYg9MYZKM5THNSbWJVwEL4Pbt0=
X-Received: by 2002:a17:907:2689:b0:b83:972a:6af6 with SMTP id
 a640c23a62f3a-b8444fa0b03mr668175466b.44.1767902374312; Thu, 08 Jan 2026
 11:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20251231100831.119142-1-t.preissl@proton.me>
 <20251231100831.119142-5-t.preissl@proton.me>
In-Reply-To: <20251231100831.119142-5-t.preissl@proton.me>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Jan 2026 12:59:16 -0700
X-Gm-Features: AQt7F2qkvz1PSho6aWTjFuqU0F4yZHou22Id6_133PRc6kMUcF4-kRfOFoaHrEw
Message-ID: <CAFLszTg8M_pUFdFTB4pptHsv92yvQ0GCaXjn55iFDYczzV=81A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] fs: prevent integer overflow in ext4fs_get_bgdtable
To: =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

Hi Timo,

On Wed, 31 Dec 2025 at 06:19, Timo tp Prei=C3=9Fl <t.preissl@proton.me> wro=
te:
>
> An integer overflow in gdsize_total calculation could lead
> to under-allocation and heap buffer overflow.
>
> Signed-off-by: Timo tp Prei=C3=9Fl <t.preissl@proton.me>
> ---
>  fs/ext4/ext4_write.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> index 5b290f0d80d..b826a8807c5 100644
> --- a/fs/ext4/ext4_write.c
> +++ b/fs/ext4/ext4_write.c
> @@ -108,7 +108,12 @@ int ext4fs_get_bgdtable(void)
>  {
>         int status;
>         struct ext_filesystem *fs =3D get_fs();
> -       int gdsize_total =3D ROUND(fs->no_blkgrp * fs->gdsize, fs->blksz)=
;
> +       size_t alloc;
> +
> +       if (__builtin_mul_overflow(fs->no_blkgrp, fs->gdsize, &alloc))
> +               return -1;
> +
> +       size_t gdsize_total =3D ROUND(alloc, fs->blksz);

We normally put declarations at the top of the block / function. Apart
from that:

Reviewed-by: Simon Glass <simon.glass@canonical.com>

>         fs->no_blk_pergdt =3D gdsize_total / fs->blksz;
>
>         /* allocate memory for gdtable */
> --
> 2.43.0
>
>

Regards,
Simon
