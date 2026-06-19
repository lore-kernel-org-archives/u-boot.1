Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B82CD98F8
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 08:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B54D6847C3;
	Fri, 19 Jun 2026 10:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e6d/TeBO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5760084873; Fri, 19 Jun 2026 10:23:04 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C391846E1
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 10:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-662bf1dab83so2265900d50.3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 01:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781857380; cv=none;
 d=google.com; s=arc-20240605;
 b=VxyxXJsFgoKW8PuIrDZP23fXe6c+penCTKejyrWLq5FY4WmBXI7bDoUl4IArTpu0om
 7yGIcaBdzXzJ+sjx+1XQF+y6odcGZ03ORYBwy8cpTHSqgi3UHvGM65xklkRS72Fsb0qG
 Q/WmE9w4OW7+zXfzR51dUkyCt2ocmuQgA/1yaXqArLerrktLu1EoW2Ar27od9ndZw6H/
 m0LHmFG6+2NdR00abnaKHxEmyVyTnwv+DVrAuVQsJZjNm3f4GHi03iTkAT9aeMNlKiR/
 FlMzTBJvKKncr+pQVOvSyHdewCWas22vLCt7xx97z9HmP1tYdw9czfaoJC5b/wqoQIho
 WUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U/xq+2Qy+2fchVHSycSPvxes7qqp+HLipLsgzkkX9Ls=;
 fh=VNmCuRcGDjHTLrVEkuf1oTdfR67NRyKQxqIjTdwBBq4=;
 b=YAkKkLWO04y8YgTuILHrOskBzxufTtR3zZzESGMGJQR75STTKKLkV0XPyZFWl2Qy5M
 C6gHEECPPmmeeBkKBhV3JaciV6JRm6h76hTECloqMilyuAVluQm5o/wxMSyX+vBUA1if
 ZEF96rJ72HjqNF4T/udLaVS4PIQvI4x8y4BC53iXbpLlehT7k7bsQwdj68p80ISLE7J+
 Z+KKcvjNrQEH4iMvjeYVefdUQAoDa5sjXKLn4l4ePfdNNUhJjKFATB7zxh7KgYF6AOWH
 KML+y2ShNM+enYgem+rHE+JXoFUQUtZg/EOVn3hkErKPtWBMEfyrr0VSgiWKfJeJ5U2Q
 QBKg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781857380; x=1782462180; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U/xq+2Qy+2fchVHSycSPvxes7qqp+HLipLsgzkkX9Ls=;
 b=e6d/TeBOaLmQruWr+H0P55vmc3dYG5p7QN/3isjTj+huVOXkqOE412E5dolDnToWys
 EHTY0nPkWTIF1QB7Fn0GDdZjARn48WJ/ZipODh1oZE5TSN9A8bhAMtdL9fWAnehH4XKd
 kbFBpg6KvjQcwoc5FKM7ipmFbCr15PZbc5TdWlllmj+SXh82G5nxmFhB6XRGhtSnnacp
 51074ZaoVmRUsA5rkFjFemVrag8RQjSbwct88s7Gm7TGWBlAbzDC4+H+yVTL8foXpsMC
 XPrvgGyVrr3SPW0R4vFPPMX+yBDXlz2TLcDVJ//VqijAsQF+wPFj58fJvWqAxFqhBsdk
 Ct5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781857380; x=1782462180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/xq+2Qy+2fchVHSycSPvxes7qqp+HLipLsgzkkX9Ls=;
 b=kFiC8WNOhdYq+i/kg5s+YM/quYZOC3ZC/51Dyu5WseMCF9T+zqnIbpJsCka5TfDXY1
 UqJ62WONjOJh9dy/cuuFyS/NkYxBUFM4eubtVn9vd37OuItUPfVdp3tONKtO01mSmtze
 ZgGLcfDgs+VsMh/8tLSpNUvxc7zyEG5yUyqdv/CHAMZWfaYaJNapnTy94QMtJO7ZCBLu
 nCfA1DT9BT3aBKcBhXHx1om5GzscBpwH6Vssg5QfyETeECLIV4PTPbcyRF8HUo4V4W47
 7hXhL9mf1Tf45wIonQ2jnII1+80Wq9MU2mN5SmaMb2c4ThVTUa4nRBsEV82p7DU2IrPd
 Zdyw==
X-Gm-Message-State: AOJu0Ywdg4neAO3efq4A5PkTuDZs6VPKRZih87SK4U/0JFC23lK0y47v
 VBxRHMepOR1mLs4VqIyrMXpLg8dYeFdevcnbM4Up1nadMy0Ma4sz/2HSEIK0NGuSyzckAGD4TXf
 GdKKgsA6oQZT8cWfE57ey4QJX88PMSNwMZSlo3EJ7Yw==
X-Gm-Gg: AfdE7clXJbvnKx09fqNfpPebA3iyR1W9JxefsSWwbpSu+/21sGODIS7ScsUJud672kT
 294etc8yJDYQsol/iWus9ixQnVMfCD0RLTD15Ltt/7j+cF18mWm/SwXv6ir7HCKU1B2ZuxSWHhU
 myyTuehl9j/uMBngL5r4MlxVziNsmoF5xjyhkv6c3kI0iZgi4WRMl/M1gTdpJ5iZlu81poyJNcY
 3DZliPKkGpsX2QqdsBpx6v2ybMlvNvQs2PJ07xzmGmgXIFWSWMAGHTILSg+OQPvvkGq1stuaUML
 sE2GzndMSoS8+k7Uq7GJ3U3r2iRFupBjgAOYorYfDDkITTRr0IIELdiRBMTppw8Lfy359AasKCb
 INF5lpkQAuJw8Ys/OVGvLFY1suYDDqe5qi6/4KTS+2sucmx2Z2obdtpOkYlQeIyvGwz3zME3aD8
 g7S3Qwacf5YwiRYl9pNDG9zY2GN5QmX1C+2EeG4wMJSZEzU/qKQZhaJskBxaXm37sIQuNa/MdZZ
 s9TexySVOxTNjo3DPDMojQvETauZxblFuvWcbHb5zz6RQ91nKA3Rzuz1Baq6uYt7QhN4FRRPHu/
 ixaIcDnEUb2zScz5SxKVxlKQQHRJILX2rR8TKmIIx/QH8aCK/wKJGWcX1DmQrjyoLMhfxvs=
X-Received: by 2002:a53:df45:0:b0:662:d600:8f82 with SMTP id
 956f58d0204a3-662fcb7d4c0mr2292039d50.50.1781857379800; Fri, 19 Jun 2026
 01:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260618150913.314507-1-vincent.stehle@arm.com>
 <20260618160930.345040-1-vincent.stehle@arm.com>
In-Reply-To: <20260618160930.345040-1-vincent.stehle@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 19 Jun 2026 11:22:22 +0300
X-Gm-Features: AVVi8Cdq0sj5yHeJYs5kMHi8bLczM90GaVHSt7qClmVK39Gd5V6MYBjyQARvvIE
Message-ID: <CAC_iWjL+A5qcrJPEiR-f3__P_3z5DQApJWVANS+DNUga-vB2Fw@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: fix missing EFI_EXIT in
 efi_disconnect_controller
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Thanks Vincent,

On Thu, 18 Jun 2026 at 19:09, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:

> We are missing a call to EFI_EXIT() when returning from
> efi_disconnect_controller(), which we need after having called EFI_ENTRY(=
).
>
> Fix this by jumping to the common error path, which does call EFI_EXIT().
>
> Even though the common error path may try to free child_handle_buffer, th=
is
> cannot harm in our case as it always NULL.
>
> This is inspired by a barebox fix. [1]
>

There's more in that link and some of them are still valid. Do you plan to
send more?



> Link:
> https://git.pengutronix.de/cgit/barebox/commit/?id=3D080db65e39a877b000ba=
af843c997a69821dfe69
> [1]
> Fixes: 314bed6c854e ("efi_loader: fix DisconnectController() for sole
> child")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>
>
> Changes for v2:
> - Drop the return and jump to the common error path with a goto instead
>
>
>  lib/efi_loader/efi_boottime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.=
c
> index de57823bd44..bcb01c92cf4 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -3895,7 +3895,7 @@ efi_status_t EFIAPI efi_disconnect_controller(
>                                       &number_of_children,
>                                       &child_handle_buffer);
>         if (r !=3D EFI_SUCCESS)
> -               return r;
> +               goto out;
>         sole_child =3D (number_of_children =3D=3D 1);
>
>         if (child_handle) {
> --
> 2.53.0
>
>
