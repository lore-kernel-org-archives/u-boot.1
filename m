Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D45C83F0A
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 11:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 595278304D;
	Tue,  8 Jul 2025 13:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UV6lfp3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 881738305C; Tue,  8 Jul 2025 13:56:47 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D1EF83015
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 13:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7111d02c777so33784097b3.3
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 04:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751975804; x=1752580604; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tbKTvXf6qMUzV1hdUVlIuawNlbtw+FoBBxOS367Txrg=;
 b=UV6lfp3UrF3xuha6eDCsa/jfIWFxGljwSNoBUAuaoAUHoKj/6VH3zdemYJ5ETdkjIB
 gV2ljgk61GM6ngG9jFiBPD/neVooeKWrwqT+kdVKRyeS3DZ9gVke91BgGBXHokjxp80W
 mWALxaZwyuchEHuNGm9KLWwFy+tfetQaeQ4qiLiFTRK2cblrJhtAT1DZ+gnd5d2Y28CZ
 dNmeENw7V5PdwSI5IFct3URaaW276zaqftpGqVJRx82b7mwzr9gCjpK/fgiEy7x2fO/J
 /P5HC4zi0W66YxuTVOOIbg9pknqm6ezXEBIxuqGzDuzhxhjQVjH2UDO5vdDgGHveSz9J
 qeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751975804; x=1752580604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tbKTvXf6qMUzV1hdUVlIuawNlbtw+FoBBxOS367Txrg=;
 b=lm2apXufYu3ZYOGoi8mBBE6v6K7RZ+wWUUneRy18IijtfjB+Vxr03GLapqEEeE39ao
 vscGh6SC260d0aZbihi2yk7FRb15TSilwxTnA1z1qVMjQN0HwUKBDz3FifwhxANZ6QLw
 bvFdd0V40I7JOMlFiM/JwD3t9usUdQxM8AY1iRZCoJ8sFKFvTK3eNxjUzXd9plXsXP8N
 9a8l8BHPOGxUfBp5jlW4E8NNCaQQ6kAkMUtyR4wAFsCaUdWkzBthbVDPQKqNHSmVOW4q
 muRnZsONn7d+H3kDlIGcxT0lZcIVhcsWCnyeZGoSBystrzide0M8iJDT57M4731lw5X3
 vdkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPb0vggNi7+Vl8cYQxmCsjT6vaIuP3dy8VTaIIlpm3tJb7E3y/8b97on1nWQqSbQ5jPwCRVHE=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu++08nAmlXkSJKHVQH5NbEF1UFBucv+FHKxMA+9Yya0hrey5w
 8t5qbWSwBKNk6Rx5514fkZBXPCY4hICadeC/fxRqgYVJp/MK48Ur424R+ZS7VkXEGxW66Q1FbGE
 IEf0WaFJnEQVZCIZ+23E55Jk8nt8fJJkgHMAIj7fGIg==
X-Gm-Gg: ASbGnctjV2BnMxzNWhmfMHzhYN/oWVlT28kCDjMRBnXM5qzukdc8L+eo59a3STVffyd
 kywHZeAAzJeS331Az6VCfdU30C6RXxnCbBJcid0EVmIkbcjGOxo4Bn+GYWrTOM8RJVBa4hSY/9I
 ypb21pNj05qwz7s7BZzsngPKEfM/Fj6RJ67/LwaJEBxEM=
X-Google-Smtp-Source: AGHT+IEq7pVcCkvZqUu4bpbWYm5E23/diWJV/dzefRyNPlMJeWPmvKR1Bq2AyPq/3Kw3hZunlMDMR6q5dtVqEysQ29A=
X-Received: by 2002:a05:690c:b1b:b0:710:f39f:4d3f with SMTP id
 00721157ae682-7166b593dc9mr210512417b3.5.1751975804227; Tue, 08 Jul 2025
 04:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250708114851.78109-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250708114851.78109-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Jul 2025 14:56:08 +0300
X-Gm-Features: Ac12FXx4utOwHEbwMKyO-T4hzsjOdc8CexoIzqVanEO_qyRIbNPyDrCHHJVxNv0
Message-ID: <CAC_iWjKCtmN8Pn4VRNKRgH0OXymtp8=vc0J_q=MxTDLvTXgSxw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: add missing check in FMP.GetImageInfo()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Casey Connolly <casey.connolly@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich

On Tue, 8 Jul 2025 at 14:48, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The UEFI 2.11 specification, chapter 23.1.3 requires
> EFI_FIRMWARE_MANAGEMENT_PROTOCOL.GetImageInfo() to return
> EFI_INVALID_PARAMETER if *ImageInfoSize is not too small
> and ImageInfo is NULL.
>
> Fixes: f27c20148511 ("efi_loader: add firmware management protocol for FIT image")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

That being said, we need to double check the FIT capsule users. I
think we can probably remove it in the future.
Are you aware of use cases that FIT supports, which we don't support
from the RAW variant?

Thanks
/Ilias
>  lib/efi_loader/efi_firmware.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 75501e21557..216df83de67 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -332,6 +332,8 @@ static efi_status_t efi_fill_image_desc_array(
>
>                 return EFI_BUFFER_TOO_SMALL;
>         }
> +       if (!image_info)
> +               return EFI_INVALID_PARAMETER;
>         *image_info_size = total_size;
>
>         ret = efi_gen_capsule_guids();
> --
> 2.48.1
>
