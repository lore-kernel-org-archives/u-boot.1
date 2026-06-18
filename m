Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C36CD98F6
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56CCC847C3;
	Thu, 18 Jun 2026 17:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HkcaZCmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CEEC847EF; Thu, 18 Jun 2026 17:19:15 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C65E78063E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6956a8abe7aso1513511a12.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781795952; cv=none;
 d=google.com; s=arc-20240605;
 b=hPUDz2tTSxqDW06NrtreUfvC5Tkix13dvAY8ggCtBbemwvdUJ/moiW4wdo0OD2mmNt
 qX1jkaK2PLWeQVgeuyvMqEOcedWRgLsnjz7D6UNR5M3TAhty5Ip0aveNF4ns7zcE+FD6
 RiSQuVg8rvyyjZqFZliuSnruNbNw2WFiXJY8jGGz8FpNhzfO79r+HcUkm//OF7scL79Z
 uNnFwwHsAkHE5nOFXFQawJpD9siAwJQFzTanU4p8Qvy4F9TiRXw+bNTPR6ybKXfIu306
 1wBBdX/U6wKRtgQ325xT7yXrBed+oP0H/vRZdskvFrkXfy9qh5gQkE79qKI8W5JIuq5u
 yHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vaoum5FFnGwJ9nHsbUeefS81IGroY8m3rw+qJ1R/0C0=;
 fh=PLpFEHlVZYOnentfpY57U4X7O2wr2LlW+LHPXEYY5RY=;
 b=jA/VcNR3Y9IG7qwX+IffEJ92vNA8oRCjL0xyMBOrlfYXszRKBEsU2oLAuK8RyeTcWk
 /KZANLBGcVGpaIul2V041nvQWPEtFWKD1mEE1CxFpWU0qPXac8eLNg11L3qhVeqwuMXz
 RE8Sl2JiORvJlrG1H33jRsv3o0pkYwMRxj+rZwDjqfbXGY9eW1Yvk4zSlUcc4kemUyN8
 iCRF+QCcFc6RuExDzI0XeJjRXGeUBQqrcta92XfAHJBO/patz8feif+ve2U7sjHvKhkW
 ReMQwBXH6CF+C94IvO4WU3LdAy1lTDeiw9mS2lAxq3rs/B2UKRPaI6lvwXgH2u62q07P
 hZqw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781795952; x=1782400752; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vaoum5FFnGwJ9nHsbUeefS81IGroY8m3rw+qJ1R/0C0=;
 b=HkcaZCmFW/2D8at9GVkpfgAuTnY5+ChTGQCkk4To//+m7h3YoDLHAaWRCzwjs7QttT
 UpJWIxE96P5sjtb04xmr1rNxuXwXi8IJXUYiKnuhwOhdvARK/f+g1eplBLCOV7GLCNSl
 wzfswf92+UVCfSpeCuh+ZvuwkTcC9Cno3WR+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781795952; x=1782400752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vaoum5FFnGwJ9nHsbUeefS81IGroY8m3rw+qJ1R/0C0=;
 b=faHTMVG29fvEk0/9pvSoW3EQS+RsURT6WGqK4/OW3OnfhTq4asixZN62R9IVcoHGvz
 W7lJ8572PiXg70k8BCJqZsc8LgvK4M2LsURZEQnAv9iM3Er7FW8n44RiEGKNRS/1lv10
 ofHYZCYB22nZmPx9ompwy9eXKyC8/JU/938uchWkdtSO4++7nY/zNiiCR7lQP7yn63Yl
 KtVsphfqOE0LrCHn+RUeJDSi8h9QGLliLzeYo2O0sEHCs7pTCBrQPijt8HQlG03BO+jo
 n6hWHKjSd1hnG5K8CjPDSVAlQN5aNgwAKEJala4XcapXObMzF+eD5yHSjDAjjJf830KZ
 tRHQ==
X-Gm-Message-State: AOJu0YwbgNb4lCFl5lkjcwcvWGft7hXq5MVHIS/iVHXYm7AzDg3G24Uy
 ezf+TC/5bKUr8mgU/1LCBwpcSfYcfGBk/ZhJtQGwdNsG/7OIrBfwxHgYlbYVON2e7pruUP4Z+gp
 khHAB80mj+iKuLqFk4OtwE8VkAHINhltFlquzwBnw
X-Gm-Gg: AfdE7cm/tNBmmSUoaAq7XDKxET48qRSOkyl1Qx4IfAhCUAVTI0eJuv1IxuMrTeB6H3L
 AOmLcPxsFh6CQn7W71W6NqFrlPxgspFPz9TD4RqdfDFEKqlkIXoU/gQk3ErvBBJDcL60YaCM6HV
 m4EZ538j8r7JOI8JQHFmdSD8gdZQq1jTfh84XDfDOLE8qroBkiVHmuXfuy7+Ulu1ZiZrtcV6hYv
 VkOjL+GeoEI9RfbdJPtjVO4dAruG1EhHyXaZAYnfPcm2KO9MF8VijJus3sgqaDKCq7q+WyHVQ==
X-Received: by 2002:a05:6402:42d4:b0:696:2f6e:5e7c with SMTP id
 4fb4d7f45d1cf-6962f6e61a5mr773398a12.4.1781795952169; Thu, 18 Jun 2026
 08:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260618150913.314507-1-vincent.stehle@arm.com>
In-Reply-To: <20260618150913.314507-1-vincent.stehle@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:18:59 +0100
X-Gm-Features: AVVi8CdEHCssy-cWhR2rY3vgGu_0V4aHcDXeBSTGnrhRD6ulIlS8BS_G1kVaSyw
Message-ID: <CAFLszTh1p01CC8-1Or7AQhziLkNqzN4NKADJ+hKYSEVjM15t3A@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: add missing EFI_EXIT in
 efi_disconnect_controller
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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

Hi Vincent,

On Thu, 18 Jun 2026 at 16:09, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:
>
> Make sure to call EFI_EXIT() in efi_disconnect_controller(), when returni=
ng
> after having called EFI_ENTRY().
>
> This is inspired by a barebox fix. [1]

Hmm, does Barebox support EFI_LOADER now? I wish we could bring these
projects back together :-)

>
> Link: https://git.pengutronix.de/cgit/barebox/commit/?id=3D080db65e39a877=
b000baaf843c997a69821dfe69 [1]
> Fixes: 314bed6c854e ("efi_loader: fix DisconnectController() for sole chi=
ld")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  lib/efi_loader/efi_boottime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.=
c
> index de57823bd44..b6966652d97 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -3895,7 +3895,7 @@ efi_status_t EFIAPI efi_disconnect_controller(
>                                       &number_of_children,
>                                       &child_handle_buffer);
>         if (r !=3D EFI_SUCCESS)
> -               return r;
> +               return EFI_EXIT(r);
>         sole_child =3D (number_of_children =3D=3D 1);
>
>         if (child_handle) {
> --
> 2.53.0
>

Regards,
Simon
