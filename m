Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB33CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 16:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0649283DCA;
	Fri,  7 Nov 2025 17:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="mPfAfXVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C4B283DA9; Fri,  7 Nov 2025 15:35:16 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2948D83D8B
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 15:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-378ccb8f84aso8406061fa.3
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 06:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1762526113; x=1763130913;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dUhSwVnYZckDZ7Z1J3iFqScd8VUV1/4xSpv8YlOdqTA=;
 b=mPfAfXVkT3s3Xgw2dgEqH2jQQRs7bF7gQTPP1Ad03/B1Y87La04oCUnbtMg1tDZ1H2
 iMss/F7JAk6ugwXpfNQUD80wBvGQLS5xLcqT5UWoqOZSp9DXKgP/HE7408xD8kgLnKNq
 2b4dt9Cg3i+Kx24AlY/2bvamueeXaXLeOLuFhEmqRdT5q9+XXIJb26VS2Kd/9iloeFj4
 oWFv6SY6wW0BVBeHujINnsTD84sluf9k/hsCLb97jM8uqSUuQQaDLmK/RgT+USuXg77j
 K5Dw/dLEjIDpOAoVa8TE4KvTvTf4q3nZHSGqFWxzRdEbOFT7HScZEQS4gZlOJoIM5Axe
 l2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762526113; x=1763130913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dUhSwVnYZckDZ7Z1J3iFqScd8VUV1/4xSpv8YlOdqTA=;
 b=e12bOK/hc7jNIU+WXvTa/tuJtgwZUMtUauRABdnbNRJuUn+OiQSA4qM1lApJ584kst
 ygS40gLXUdZHsz+1E6t+sxzE+MyP+/BC5HEhG26z8NRkGzKOxjCENDy1eYMECg1gbxr7
 mv6P6wrY+Eo6AItI7yp0ilG3R4DvkDkOxfHBEPcIkgYfFUeBsNIMosoMwdv7/8htCCAi
 sX/+cWwoQ2Kvqjpivag6ZLcT4s0/vHlhyxK7T0B7tlGCdyKm1WGPj4gPQSyKKYniGZOd
 n71l69t8rzQ0f9SUDFt004qcHswdeUrm3DmIpsi0gttM9HcBjNbazTGQzRTQYGuXmu07
 61VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUahzixBoa7vjoWQksfBKH1VHakDC1wTo2TYt5FNSvCMuVFE/9KQ2BjuBd8asI1fhEiQoE7tgg=@lists.denx.de
X-Gm-Message-State: AOJu0YwvcW75+x3aC+a4nsYXbnVT+2ymx5OlHe/L2HdwBk8KGg3/r229
 NHgkW9+u5K0RG/bLjcrX7vv2uk6yJXtbSUgwMPoU18wufy3yQt+2ESlOyzx6Nxz2ja47oX3En3Q
 rVdapWCkQB+iQVevWrU0kdP6yaHeUiOiazOYbnBfKVw==
X-Gm-Gg: ASbGnctLurxPzPIZIzDbqHPu5lbeWEE5kpyoOKkgj1ng307SxDu7+eUFeq0YlIBSB3L
 9XQPrBG1V5N3XrppFh3Jdh6+Xbeegf3JhoMe6tCaWR9D5OPIeh0zBCCkE2uAU+kP8bguDb5Yibh
 Hre6kc+BoaQ0pXI6hEaLQJwb7YBnbC6NLtXwYwl5Cj+DTae9DVY7jsIIcWzvzxhuJWHvWyh7e3y
 8CcdZsIMkhfgzivbryo5FhFK2q76h1PJ7zSqR4DzEkpsR0b3DSf0A/lzg==
X-Google-Smtp-Source: AGHT+IHTDeHDvqGU7HR2T8vdp/NF9E37kt+zwlrNclrSlYfZ+f26uaFmtfvGJjRHmiSJo2TwTqRT0WnoH8b4eMA7Z6c=
X-Received: by 2002:a05:651c:441a:10b0:37a:584c:2406 with SMTP id
 38308e7fff4ca-37a73112225mr7832861fa.3.1762526113173; Fri, 07 Nov 2025
 06:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20251106170124.3992080-1-admin@hifiphile.com>
 <1116a46b-6261-487b-8418-1c638df56e15@linaro.org>
 <CAOf5uwnO_VtG5sajp-_fq4KvK+V3O8V-PnZmQz0d0MNDPEnn8A@mail.gmail.com>
 <CA+GyqeY6MEV68yXACCs_8oAbD66TeRN292u2CsFUr_m=kRuYHw@mail.gmail.com>
In-Reply-To: <CA+GyqeY6MEV68yXACCs_8oAbD66TeRN292u2CsFUr_m=kRuYHw@mail.gmail.com>
From: Zixun LI <admin@hifiphile.com>
Date: Fri, 7 Nov 2025 15:35:01 +0100
X-Gm-Features: AWmQ_bkE7Drg9Bcs1iXFMDpYb7KrMw4QjG7amUCaetyHX6vJjhNsln31EYP7HWA
Message-ID: <CA+GyqebZz=w1LsB16EWm6A1Z+vS+dKYQmMxBDPVE65fE_womMg@mail.gmail.com>
Subject: Re: [RFC PATCH] mtd: nand: raw: Add ONFI NAND unique id read support.
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 07 Nov 2025 17:57:52 +0100
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

Hi again,

I've managed to put this code inside BSP, this patch is no more needed as
there is no consumer.

Zixun

On Fri, Nov 7, 2025 at 1:35=E2=80=AFPM Zixun LI <admin@hifiphile.com> wrote=
:
>
> Hi,
>
> The intended use is to allow BSP to have a unique serial number,
> in our case it's something like this:
>
> int ft_board_setup(void *blob, struct bd_info *bd)
> {
> char strtemp[34];
> uint8_t unique_id[16];
> struct mtd_info *mtd;
> struct nand_chip *chip;
>
> mtd =3D get_nand_dev_by_index(0);
> if (!mtd)
> return -EINVAL;
>
> chip =3D mtd_to_nand(mtd);
>
> if (nand_onfi_read_unique_id(chip, unique_id, sizeof(unique_id)))
> memset(unique_id, 0, sizeof(unique_id));
>
> bin2hex(strtemp, unique_id, sizeof(unique_id));
> strtemp[sizeof(unique_id) * 2] =3D '\0';
>
> fdt_find_and_setprop(blob, "/board", "nand-unique-id",
>                          strtemp, strlen(strtemp), 1);
> }
>
> Zixun
