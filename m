Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB54E68953
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 04:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C38689241;
	Thu, 31 Oct 2024 05:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="MS47JroZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 024C589265; Thu, 31 Oct 2024 05:12:05 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC53589212
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 05:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=moritzf@google.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20c8ac50b79so13315ad.0
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 21:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730347921; x=1730952721; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQJz1UpD9oyBX1DyAekiGuowxNKyOpfx0h+wb45iIuk=;
 b=MS47JroZrDcREBHplp1Ga7eJIsUtb6zHKOBe0Jw0+gagsq1971n4lH0bE5s6VJ3Hbh
 GwShgwPNd3xy6g1hap+ZhwDF5nnrRax9KR4lqWIGJ/IxLHZgN8Xuw8ghmKmj+ZrRYF40
 jBm10/b8vwsSNKrhYilCrl7Tl4A/82s/ezYSXT9j45LqhyLCrdzhv1iS6+neg2yBBR0k
 2NCcHpSd7o2kMVweZl3bRsTnAUcCyVFMqDBEcgbCIK57KEOw2LJblSnQWBzdQdRhyhzO
 vOslOnkW+rtVf7DQdVL2kKHhIYw6J1dFVA545N1aCgca/1xkmKy/aZdZ2gD57yJ3utV6
 xWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347921; x=1730952721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQJz1UpD9oyBX1DyAekiGuowxNKyOpfx0h+wb45iIuk=;
 b=Mhm9SEv3lXeoEDV622UThzKUdUNtW7pYHwHSUOboZfh/zmwHN3gyX4munw5Y7ou/Gp
 DxzH1e+zlBqj/jjFPLIq1QtKsXRlR9XUTLB762b4r9Ta1qVdBUeToXGqyMag5BiMjicY
 8nbsGNY9MDkRIV+YuZv9KVLkWkTM0wa9zxg1oJFotIl1tz5m00glFT8bojvSC0s2PoMC
 4ovJeUxj+croGrmh2hFsvuGwt8sAfhkAThrA/CdSHkuyGaHcFpY9C/qF/1i0Vm2B86lq
 dZqo7vAPjqBVtEaEWMtaNqcC69cXKvbW3Nb0AGSxqTRkUX7OzBae6+Omd3VRLo51E7O8
 oPWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAJg5EpUmlc2tWt3lv9jWA/Y6WUsg9R5F4UGpl6ngXkYWwVUUfettlS9Y+0tsNZEPerY5MlnY=@lists.denx.de
X-Gm-Message-State: AOJu0YzKva7DzCvwYEFsh/5/1j2Hfp77jfoUVJamYiRcpwibOxBEQd2C
 8raYtXk87w1Y1PVu8iv8ilCWJhpByxz0/GrrBMfhzhaxFD+smo4wRYpuv8va4NVjBSUTpljJ22Z
 uGl5gx+D3LvCBVvrvKL+/053T+VoSOcSmvDDG
X-Gm-Gg: ASbGncv9SuhTluSGIkLkaRx+/QFrfmzvqTTrJ4kGHJRx215xy4k+wwc/M52txYdijfr
 Ut8ufy8SeNgUiE14n4H+7JZUoUFuOKRA=
X-Google-Smtp-Source: AGHT+IG96UmMxMgXRw9iaRAZ77X9vPr7KPJvhYdGcpreiTIqW9F1d9V8cFJ4MjRxQj3yVblAlqyDZoIwP1h19moQtRU=
X-Received: by 2002:a17:902:ec86:b0:206:ae0b:bfcb with SMTP id
 d9443c01a7336-2110442e8f2mr1599175ad.28.1730347921060; Wed, 30 Oct 2024
 21:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241030210227.55952-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241030210227.55952-1-heinrich.schuchardt@canonical.com>
From: Moritz Fischer <moritzf@google.com>
Date: Wed, 30 Oct 2024 21:11:48 -0700
Message-ID: <CAFyOScrZRR8vZK3pVyXOUWwtNKB5dZYzAxVqk4wcP=XL2fXjCQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: pass end address to efi_dp_from_mem in
 efi_dp_from_name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Wed, Oct 30, 2024 at 2:02=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> efi_dp_from_mem() expects the last parameter to be the end address and no=
t
> the size.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Moritz Fischer <moritzf@google.com>

> ---
>  lib/efi_loader/efi_device_path.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device=
_path.c
> index 9de3b95d073..d7444588aa0 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -1073,7 +1073,8 @@ efi_status_t efi_dp_from_name(const char *dev, cons=
t char *devnr,
>                 efi_get_image_parameters(&image_addr, &image_size);
>
>                 dp =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> -                                    (uintptr_t)image_addr, image_size);
> +                                    (uintptr_t)image_addr,
> +                                    (uintptr_t)image_addr + image_size);
>         } else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) =
{
>                 dp =3D efi_dp_from_eth();
>         } else if (!strcmp(dev, "Uart")) {
> --
> 2.45.2
>
