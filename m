Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6634AFC72D4
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 18:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B94FD840F1;
	Sun, 22 Mar 2026 19:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Y00Ywt/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36375840F5; Sun, 22 Mar 2026 19:46:55 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19C13840AE
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 19:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-79ab3e26cceso1789437b3.3
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 11:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774205212; cv=none;
 d=google.com; s=arc-20240605;
 b=IwNrXiMJMT9CP7tfffO9I/iK43SoLz7pEX5m1pPa78vqgYk2cX+VOnD/ZJK8M2Ex7j
 4vLhSSan1CoThKU3fdPRZEAypsib2Lm6oE7WsGja6noaOmYy+dy6GhvRTKBfg5IYtK1U
 RVExs/lm4q33pZTlpqr2s+1qEosuW6MNDphsiF3dH5RYrEn9yw8h3BT9D3v/rHXDs0h0
 qw4QbFYLA83NKddaxQUsNL/xXP6hfoSqrevzMaO8FScaOCQnNH3RN8vG9sHlOFXBr4Vq
 dUOEv2uvpDlkzGBr/bOjF+grsvHQ8fbzIz5hD2XKISGs5pIOH2JHvIjrOtkqXiq30Ree
 0o6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bHRL4p/2Kn0P4qmtnGp1tKnjXQPPewogO2+GresLTdw=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=EfLzJFDpM3xKfgWVH+iD09Tob+j/nbQGCYzf2QTzKBMdN+0YhZWOCmDA4q8jksEMUo
 B0cRSbXATfZ8GsfnEeR60JYd1Ev53V+nWLAVchj87VSUdSW9OXh7kh0F4+zh5hVpZ0q8
 2F3zFpQMZTRcKHDciltPajp7mOfHqrGgzPOV4VqiVWpl0ZnqcCMu3z9X6xUCC6bXC4Sa
 MkdD9i859i6Q8OIh8XuoDU9BU010sqlkfN7HOgyQe7FXe0ngh6yP/Cuzt/kVUR9LYV/L
 CbmIAvqAQKmUP695r9CQQ7OyfMEV+0f6cdFDHfh71ERKc7oEuo1yf2gDPvlRLmd1/B4t
 9GCA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1774205212; x=1774810012;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHRL4p/2Kn0P4qmtnGp1tKnjXQPPewogO2+GresLTdw=;
 b=Y00Ywt/dB9i+1q5plcmAEyUJagl/PUXzELm7q8zerggZPU70aQK+v0Bhxv30BRCuLZ
 GauK14o6q408dZ3KIET2I3XoTRZXIF/DPWOn1eDXXV5Z08y4tHc6D/FfuCv4bv6UztSm
 kdw279KpnLYd/lSLj3XnJb7dYUrK/78BzDY/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774205212; x=1774810012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bHRL4p/2Kn0P4qmtnGp1tKnjXQPPewogO2+GresLTdw=;
 b=L77onWq6FPsdWCHlo6ctBjhIjUViaSnXE9TD2wBeSvPSal00dKCrhbDLTDXMI2ea2h
 W121tIdoMK+QoUqFl7vy8FseoScEbnAcHlIUi0gxilBcqqiXh1HdG7puI/1yAa8e1zbP
 n73XVgFZv8gDlhVuMolLXA0pup0LgaV8rHBOoqzpJFqUEE1/gBQZM75uGvebftXmS+DL
 aQHu97w0fyFhFezmBAJjGflcrzBJmxItRqHCWrHaoIlNcAK20+aOKB8D4UyM63V5sX9X
 ntgeacTykMaazVmD65L2Fnysx0ouCbZZu6hjWWzm9hUEkD2ejpCeGON/se8p47BEt0a8
 M+Vg==
X-Gm-Message-State: AOJu0YxEgocqmR2uPfnZZgL4CxtUreSkAo0VsvhI1TFgP836J7G+TQQA
 ZhGWhSi4GoHBBSubGdwgXuqGkOGttyUS/v2ouqzT2iA/A7CpyG1PjnTnz1445gBwEo89ngQzKCe
 E2btuAxt2O3JDXPEJpbFqsDH/VNiKwvNIPJY8irDuITLGPg8y3BzjVsxw0Q==
X-Gm-Gg: ATEYQzzXToLgbIJE6NqbajzsnJmIsrK+HjGUt46MYFQCIPymbNGmbLpguo1m8XZg00B
 l4sw8E9PYKpetgRadEKa8oqrAufz5+hpnbkBY/V8tEAwC+angEa1YgpTQyc8ZD2IOoN26L1wTbh
 /colPKuNLXQBECvADS779UcSEjUsviHjOAiiT1ZtPUC0nNZ/Nf+IM7/CMLNd1km2pKreiI+3HXg
 WNEjArjKuBYZjm5L149AvNX0GJYwtYnj4BaZMBvyz0bUmuoB+4EEXsfrjROq0cmreshXx2Q8KIC
 H5IghzRp4OdFzsUZ389BfKAMcR1W6HQepB/DNME=
X-Received: by 2002:a05:690c:3181:b0:79a:b03a:a2ad with SMTP id
 00721157ae682-79ab03aa8damr19750167b3.19.1774205211818; Sun, 22 Mar 2026
 11:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260320205326.3788614-1-trini@konsulko.com>
In-Reply-To: <20260320205326.3788614-1-trini@konsulko.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 22 Mar 2026 19:46:40 +0100
X-Gm-Features: AaiRm53StdQyxAO6XUt7tqKlOooZqDcp8h20QZbG7tGxIMZu2jamOIakKZLabZg
Message-ID: <CAOf5uw=VXUuPu+AOW1RVg6dTch47T2WSjmD6Tj-CJUmOqv2W8Q@mail.gmail.com>
Subject: Re: [PATCH] bootcount: Give i2c-eeprom a unique identifier
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi

On Fri, Mar 20, 2026 at 9:53=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Every U_BOOT_DRIVER entry must be unique and this driver was re-using
> the name of the bootcount_spi_flash driver. Change to
> bootcount_i2c_eeprom.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  drivers/bootcount/i2c-eeprom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bootcount/i2c-eeprom.c b/drivers/bootcount/i2c-eepro=
m.c
> index 12c430465c98..f54515f451ec 100644
> --- a/drivers/bootcount/i2c-eeprom.c
> +++ b/drivers/bootcount/i2c-eeprom.c
> @@ -85,7 +85,7 @@ static const struct udevice_id bootcount_i2c_eeprom_ids=
[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(bootcount_spi_flash) =3D {
> +U_BOOT_DRIVER(bootcount_i2c_eeprom) =3D {
>         .name   =3D "bootcount-i2c-eeprom",
>         .id     =3D UCLASS_BOOTCOUNT,
>         .priv_auto      =3D sizeof(struct bootcount_i2c_eeprom_priv),
> --
> 2.43.0
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
