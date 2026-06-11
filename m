Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5670ECD98D2
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C228D839A8;
	Thu, 11 Jun 2026 14:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ryqnw2YQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E64D783FEC; Thu, 11 Jun 2026 14:24:12 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 667AB838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 14:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6626b5ace23so370281d50.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 05:24:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781180648; cv=none;
 d=google.com; s=arc-20240605;
 b=jtIrm+vzfvL5KGH3U2ZwYihYfO3IfJMmn4WieXyS3fzBbeLYK82knCFXFjZgY7hnNZ
 bZoEQxYn1LiQ0r4OnlMqySeR9+IpRgtUe6cppKdEpPvqVJhlGpdiIbwXpQxF0OtybjSZ
 goU3tvP+lI99qQlcEiF9ZUT2taXm8+Dxn62fa7c3dEzq9yA6JkAc7Ratdwy18USpAEL8
 6zIek1kv0y3R8xqlmG8IXAfMbVnh/SoUkFfC21x7ULSj/enNaWNmne2RG89Y32DuiPlC
 F+Pk02ZEilJ3aK+6sG/vN0UqAcIXCppGm0bRixbYuVp/T1hNUo0mBYnMt5CaJC6XlCoz
 zE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d2uVbHwwZo2JC/Gl3PUvqPjRL2l/4pWljs8aMQfSJ2U=;
 fh=qVPXZENsT8HTjc1yhpZmugGERdHloY1MZQ2O3ZL3iu8=;
 b=CV77XK2ENyxI/U/WdlOSr+T5Sz/vb3iXpRGJczpL4Pdlgeu/ja2QiZO6jaRLysvhz8
 U6rD0wqQ2OR5s3B8zEvgDohiJDMb/+wVJ1ub4yrmSGFxIRDHQZiQdi8MXpqfDY+SVH1I
 RxULyio/SV6uDWjh8BJJEfK7/EYfOgR0TG3K+yha2KGm+M21LmHiR0ikmdKBfJSQqpCo
 fyypFQmGcM0S7f8Q0VGV8xayM4aUtfxu66bpt27VaZ/7BBmLRfUi0J1Uadc0b+jeL1OZ
 uWam1VyCXX5GV7jGfoxSoFQRQuU+cVSHOnEU37XVMt0rj5tZ1PCPbLNb8q0x2MsgsY0Y
 ND2Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781180648; x=1781785448; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d2uVbHwwZo2JC/Gl3PUvqPjRL2l/4pWljs8aMQfSJ2U=;
 b=Ryqnw2YQTVS4Tz+PtsCQCtNa3nZvsw5sttRisP2QkFY+gMZaPOTlqHwl0+zBAI10y+
 M+lj6L6XwZ3Qw/BXYxh4WaZkdTtHk3wPdzYBdH2/ufXC/cEBIIKJvr6AJ67s65fnO/AF
 yEs49pPYJFAvWRP7mHU/3puV7UDRqacNm4SXUGIgktV9+0wjsDrpOHMXqs7HPCowLGsz
 UuTuKAGI7Z4cDjCa7b3r03+wu49ur6Tik17SxGOzRN2Wv2IL6wRFbe5P5wQYUR3c4LXo
 gV6x47Ri2ZSHVTc7lNW8g9rOsX7tOkKPRUDNB6mHpd+hSArBoTTogQHMSP1S5/acywpv
 2rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781180648; x=1781785448;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d2uVbHwwZo2JC/Gl3PUvqPjRL2l/4pWljs8aMQfSJ2U=;
 b=FcuKompADvvWH0iD4Wps1NTUPeH75qX1NYoWa+CxCCecKbrFLGEx+V3nopyLFawk6H
 djfPfyf6YcHjvtDBCEHYlpO+LKbcM87HYDI/fXuYVmtQSz4LTfWNCLY7tgkXQKw1xXKe
 qiXZZCw6yUofSLckht4mA/GIg4RZD9Fk0WWBu3kequMumxsDwTdbs9F3iCaKLrlNfSQx
 z8+b3ntbw1Bh0pr9CEE5Rp/x40yPdugXWG9WrugRxfWeGbnh+yjKGoyIclNWwMOvuHmx
 uMzBWLb4c+rqNQQq6jFGv4tjuOBPM8l82FbPYrRkC8lkkEGS24tEpOc2kcgHu1j3WSZ1
 N3pA==
X-Gm-Message-State: AOJu0YxYFqi2390XRCQ3h3cdk+snx5u4YjTHZHx1FHJI23Bsmbh9KTnY
 n9QAlKJFlQbzBS4UOgI4/UCk3y+I+KIAsbquw8Mx6uUFdjeKnMMXFmVXy9pxFAoUCn7h3ZWDEdV
 mabq4ftAQQCyNQC5V3fLChPVqoDgsOFo1NSy5Hk7O+Q==
X-Gm-Gg: Acq92OGXnGyTI0OdBALvBicRQyAAPoyOH3sAsoIgfFI546fPA/0V9zNV9kHxc/jYtaE
 6G7CypnM0OMxipX4mQQhTUDrDIcQ+Y9U5bV0plszpZrcOrcLBMAscPq83qfrP1oPpyIJ1B0vp7e
 7ZVgOUFDgDB9HeOOflB3Pmulep3ZCwBb++41/zyiDl59OlL46pn9PHvAKiYeX4vskN8QqjbC5gz
 ASw5Z7Ve16GnpiG4DBywpyJkYJDEI4OVTHkiSS7nl1oC9OF8Bo8pXDV0gtEACkHnm/kFOGy3VNG
 OB0r3XEkOvEdVtm1o45fcqfmIc5hL0FGhABUllrjOWsWuuGNnofxrcbrhMheYeAdMhAqUsk0EtU
 hmPtH/PuIPhqD+LWiTlkrAtGIs2HYWMse7bKLsSgvPeuM1vXM9I+naV8w9laQEZG+y9bN8gdIyg
 QD0iYDO4NSEgawzUfmA8ihditp+JT+BsJqm9RXoOYYzPQEsta7NwMuZcxQRy7LTAl3CtZ/fWzjW
 mEC9bO9rlGoJgpII0tUgK0Urj97cPoHcU3yuR3JYTVnLj0p4QX8P7zXfVi5gn+VxakFdDBZfLhs
 TQPW0Ox1rDIt8hr4hWH3EgelM6lHBpHuwEGM9wTVw8Mf9WW4v566xcFl5h5gKURbXqrRJ3Mpthb
 RNfWGEXwDhR6plyDCSw==
X-Received: by 2002:a05:690e:1c07:b0:660:6635:24d4 with SMTP id
 956f58d0204a3-6626997647emr1577101d50.46.1781180648164; Thu, 11 Jun 2026
 05:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260611065950.522179-1-vincent.stehle@arm.com>
In-Reply-To: <20260611065950.522179-1-vincent.stehle@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 11 Jun 2026 15:23:29 +0300
X-Gm-Features: AVVi8CfE7r6EQpeUWgIWiHvrgedPGUad5_pnQpkE17xAL_d_4WM5dVvmkPRnYsE
Message-ID: <CAC_iWjLDChYOHsfogjzXAx6rW_7nQSPcAr+v2gXzQU_283TuwA@mail.gmail.com>
Subject: Re: [PATCH] efi_selftest: fix use-after-free
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 11 Jun 2026 at 09:59, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:
>
> When the `memory' efi selftest verifies the Devicetree memory reservation=
,
> it accesses the memory_map buffer after it has been freed with free_pool(=
).
> Move the verification earlier to fix this.
>
> Fixes: 34c96659ed57 ("efi_selftest: check fdt is marked as runtime data")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_selftest/efi_selftest_memory.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_memory.c b/lib/efi_selftest/ef=
i_selftest_memory.c
> index 7320964c129..450470ceedd 100644
> --- a/lib/efi_selftest/efi_selftest_memory.c
> +++ b/lib/efi_selftest/efi_selftest_memory.c
> @@ -155,6 +155,15 @@ static int execute(void)
>                                EFI_RUNTIME_SERVICES_DATA) !=3D EFI_ST_SUC=
CESS)
>                 return EFI_ST_FAILURE;
>
> +       /* Check memory reservation for the device tree */
> +       if (fdt_addr &&
> +           find_in_memory_map(map_size, memory_map, desc_size, fdt_addr,
> +                              EFI_ACPI_RECLAIM_MEMORY) !=3D EFI_ST_SUCCE=
SS) {
> +               efi_st_error
> +                       ("Device tree not marked as ACPI reclaim memory\n=
");
> +               return EFI_ST_FAILURE;
> +       }
> +
>         /* Free memory */
>         ret =3D boottime->free_pages(p1, EFI_ST_NUM_PAGES);
>         if (ret !=3D EFI_SUCCESS) {
> @@ -172,14 +181,6 @@ static int execute(void)
>                 return EFI_ST_FAILURE;
>         }
>
> -       /* Check memory reservation for the device tree */
> -       if (fdt_addr &&
> -           find_in_memory_map(map_size, memory_map, desc_size, fdt_addr,
> -                              EFI_ACPI_RECLAIM_MEMORY) !=3D EFI_ST_SUCCE=
SS) {
> -               efi_st_error
> -                       ("Device tree not marked as ACPI reclaim memory\n=
");
> -               return EFI_ST_FAILURE;
> -       }
>         return EFI_ST_SUCCESS;
>  }
>
> --
> 2.53.0
>
