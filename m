Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0427DCD6E7C
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 18:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 636D9849A1;
	Fri,  5 Jun 2026 20:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aLcA640w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA93C849AA; Fri,  5 Jun 2026 20:36:46 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DF1584997
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 20:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-6efdb57db0cso677934137.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 11:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780684603; cv=none;
 d=google.com; s=arc-20240605;
 b=LIbzV6zT+KRV697lycVw96/uwcVqy3xdjfne64yhm3YjDYIlJHA2cI3dp7a+C5Kgmi
 yA+TXq1MMmcLgtbU+ugd3gPEZkP8QgFRcxYl/s/MrgLLgIE7TE1v0gAuXmuWLsH0y+Xp
 N+4cjP2zdUzbRdgri1a+JLlSAo45Z1hoYJnQ26cK90sX40oF6XYXIXuyfDuDHj0MVYJ8
 V8pVqKHfMYnFItt0fRd6xw5uzuRbEcqjD2AcMlj7NS2AnR+OZfvWOr249RHtnIBy8QeD
 gUpYtjz9DWZ2dsIHkdeT7Koz8CDg/hecVpNKWjTt2mB913Zh3wMKcOIRlYEjS/Kx5Qd+
 DR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pb9APFyRIvQpQwdAO0RSTQ2BE8G7+laBdehIi17+xQk=;
 fh=apY4MY30vWXiNOUGPfhQDHy7E6AEWWgEkZPXd7f0PvA=;
 b=fR7p6Xzph3U3IxRHYlAxyKS8HywjVAHCRCGqikAVSATKbVl/neeh7eIo+/fXJKtbG3
 RiqDNsu5zJAH3MS63PNqrFICyoy5UjM8fo06G/vEAYldqW8E0uqPqCV/GjE6/pMKe2EA
 HRwyPZR+XHXZ0cw3hLESO1x7A9TWcZaF4ZuUlNWM4zInQm7JQMhCJqX7xrQSD+Ew0cz9
 e7lIeJosx1vsbl2rD3roOOy8CUR3hjdCiYKBiLN+TuiwpI2tO63dxYs3DO3dtNNtGfnV
 5hnZA1uk6POf/0jxqZSJ+PzDPhX9FIvXqIK8GbtYEFe4W5w72gLep7Jpk05EKH6SWymc
 L+sw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780684603; x=1781289403; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pb9APFyRIvQpQwdAO0RSTQ2BE8G7+laBdehIi17+xQk=;
 b=aLcA640w19pN9E+K5wrmuxS95ZRJSU2YmfXIIx9cn6FNhn20+LAMEseC2utjJeuh3L
 yQBbNQDAi661vjf/iSL6lM9Ve89Esxoxgy6834os8GkwEldG8/o1f3ubqvWIBPJleVXf
 0c8TplO/xz6IAiv9IRAPYr0E6TrWkeDBRM+X6C3jEs63t2QqK7QgsXUCFojn1XaERZkr
 OcZ7RjQIoqz7Ke61E8gFAjVxKMZTQDOyoLTWAPPVram2eoqZn/oJICHqWnxFJT6z4U7b
 pHfdCo6u/JOQF4pHybpHy1HcghxzCtPcAtCzXuSmQlb9t2qOwezrJv6QHXOg3qH3gc2c
 pkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780684603; x=1781289403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pb9APFyRIvQpQwdAO0RSTQ2BE8G7+laBdehIi17+xQk=;
 b=mVx5CIApKYRtFanO1Bu9nTmWtL4+wyXRX5Zf8SAOJa8jtrT6oteCCP9kKS/UNgYLrX
 tbVxnRsNtvBaMSRSuAwDl27H0Wc2pg3OscNnJZy7E3y+e5+NUapp+s8VNpQ9Rw0x4Lax
 ycbTJf0oG5QzBHSWm0g2DN6lfSowESXPtEULAAVcnQXiM03IxPJSkLNaPzZLpU5sw6wl
 8pLCKGPSXVBm0ut2hssHPoMSp4NpqYKVFtEfhhnLdCe2is2Bl2c5pKkCrleU7hrBaXIq
 xWEL1JIiVOoQdKsPR5wUjj+EbUmetu9FjDeSbeui3AxZ+c5qK0iz8KWbfDTbbaRBb21F
 5ZDg==
X-Gm-Message-State: AOJu0Yx0ArCANJphV9Yl+UtSJsK3XkxV065NT5pCfNwUgPIbc8u/0ST1
 iJ79+bxm42LLsNTBunwGcq6Vp87m+RI3y7ShK6brhmyX7dWoc2rmENQJqEXnYV0+WQxYia34qx7
 A40mvXXVmiZHq1vWPaKTwaccaYxpmK8ilQ/HE
X-Gm-Gg: Acq92OFXK+wTqhSLv9Cam8Dq3LUx+BMO/A8Bx8MiSWRl8yyntU6tR9xte6iBFgWJO7S
 kkD3QJyoG6jgjMunvibNlSEQbUrtFJRr22R6O1nYcYECKmdv+NwKlY+KonVM5aMafVV/xlW+nCB
 Lc+4yglRkdr7Dr1882OI6zIqsotKlNN6SVmqbVMEx9ucKbqDDqhh399XApCfcmwv7bRHKkPoWXi
 eTp9+YbvDZ8sqemGWdNOu2+okbaIUUmVnLOJujf6ieLX4utTNamzIQkb7LDkkK7cyPfL80HJ7YQ
 I41hsE3KpejXJCtzew==
X-Received: by 2002:a05:6102:e0d:b0:6c8:aed:ca95 with SMTP id
 ada2fe7eead31-6fef3bf72dcmr3019002137.13.1780684602724; Fri, 05 Jun 2026
 11:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260605073331.19749-1-f.boewingloh@beckhoff.com>
In-Reply-To: <20260605073331.19749-1-f.boewingloh@beckhoff.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 5 Jun 2026 14:36:31 -0400
X-Gm-Features: AVVi8Cd53XaKKhf-v9JA_WgAilfONFVwzg4SGHpCj4qVGY167lmkDHP-u5p2Gpc
Message-ID: <CAMDkj5yAeCRUjL+E24Qf81U7ei9B=V5Typ2Dv9rUb793vZX+3Q@mail.gmail.com>
Subject: Re: [PATCH] smbios: Fix wrong sysinfo ID for Type 3 enclosure asset
 tag
To: boewingloh.linux@gmail.com
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

Hi Frank,

On Fri, Jun 5, 2026 at 4:05=E2=80=AFAM <boewingloh.linux@gmail.com> wrote:
>
> From: Frank B=C3=B6wingloh <f.boewingloh@beckhoff.com>
>
> smbios_write_type3() uses SYSID_SM_BASEBOARD_ASSET_TAG (Type 2) instead
> of SYSID_SM_ENCLOSURE_ASSET_TAG (Type 3) for the enclosure asset tag.
> This causes the enclosure's asset tag to be read from the baseboard
> sysinfo field rather than the enclosure-specific one.
>
> Fixes: bcf456dd ("smbios: add detailed smbios information")
>
> Signed-off-by: Frank B=C3=B6wingloh <f.boewingloh@beckhoff.com>
> Cc: Raymond Mao <raymondmaoca@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/smbios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks!
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Raymond


> diff --git a/lib/smbios.c b/lib/smbios.c
> index 906d2753517..afde6401ae5 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -679,7 +679,7 @@ static int smbios_write_type3(ulong *current, int *ha=
ndle,
>         t->serial_number =3D smbios_add_prop_si(ctx, "serial",
>                                               SYSID_SM_ENCLOSURE_SERIAL, =
NULL);
>         t->asset_tag_number =3D smbios_add_prop_si(ctx, "asset-tag",
> -                                                SYSID_SM_BASEBOARD_ASSET=
_TAG,
> +                                                SYSID_SM_ENCLOSURE_ASSET=
_TAG,
>                                                  NULL);
>         t->oem_defined =3D smbios_get_val_si(ctx, "oem-defined",
>                                            SYSID_SM_ENCLOSURE_OEM, 0);
> --
> 2.47.3
>
