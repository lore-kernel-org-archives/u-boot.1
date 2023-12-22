Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86066C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAE48877B2;
	Fri, 22 Dec 2023 16:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C9wHY81V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC4EC877CD; Fri, 22 Dec 2023 16:06:17 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069D28771E
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 16:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2cca5e7b390so15655441fa.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703257575; x=1703862375; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OS9v/mVi/F0w6JvuJcS1koCbDce6MA6+zyDOPCUMvp8=;
 b=C9wHY81VTjt7MN10NRIKhi7J8rpB/BxyM2SoD11uvveAb7Cl2/D85vXWKmcqUppJJP
 NK/FrLnbWRBEeC25S9ZdFOtHY3Tyvkx7MEIQLJ8NQ3kL6CDVuy3OuGonC79btuW+hC8m
 s2G4SMTrqfjX/oNL2Ip3Jin66e3bA9qPbrnoq7hcFkrYKZ1e/g/njdO5k+dxlkNJ3Loa
 UpvChXFmMUEbgPMiiPv4NZbhdG/l9dnHJBtzjp2XuEZbuS3EGNif6aDK31UDrtguotyq
 2R5WinN49ZRpIdTTT2KC6BS13kOJdxZbhIHQHkhJ6lmmcEd9DQGun9oX3MKNGMK+m4mb
 ADJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703257575; x=1703862375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OS9v/mVi/F0w6JvuJcS1koCbDce6MA6+zyDOPCUMvp8=;
 b=GjhcttJatI7zb2m63mgy0q5ZPG1mgayuQiwqVU5meirG8PeJ371XibuyeXXBPCf7cR
 SLmTLDvH+kuew3EKwOZiA8IzXCflpHtcMVtY58VaPXlD5aKPxGrY08ri59E6iR8e6EAA
 rV0fA1Eaf6/L9Ux4d23htZdONlj6sjfzTHX9BuS8M1cOyNWAot97+u6GQ/K/uAIzJCyi
 cLZ/dO0+8XO85XbDHDnFUrH15FTHg6XjqAUNjtOKjvBdHdHUo7eUNVcYbpmVcdzehtKj
 +Vnl3bXGvOv7e3tDbyjUNgCktQY+IebQMHwD1b0asybMDA9H3NYq1BfxUXsOxEIkDVND
 E2Hg==
X-Gm-Message-State: AOJu0YylsviOyNdOR8Xwe4jVk1K7KS3oo2l3dedg1qSPLuJ3Fa6dHpVe
 v/vasVB6pJr1Mx+x0r+dIxCzuKuv1rEF1elfStZ48EudRHLC6MUC5sB/tl3RaEg=
X-Google-Smtp-Source: AGHT+IH8947NqTUiO8orXb2RTPtK3QmJQeiw4yTQxNjslB8o3vHkejq8yTeNcnJJv3xUfuH+cdVSmK1v6vwc2Gx8dKU=
X-Received: by 2002:a05:6512:5cb:b0:50e:acd:123 with SMTP id
 o11-20020a05651205cb00b0050e0acd0123mr697558lfo.46.1703257575145; Fri, 22 Dec
 2023 07:06:15 -0800 (PST)
MIME-Version: 1.0
References: <20231222150156.39783-1-xypron.glpk@gmx.de>
In-Reply-To: <20231222150156.39783-1-xypron.glpk@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Dec 2023 17:05:38 +0200
Message-ID: <CAC_iWjK+rAnZK8w2svoMextfUm8iX+EhXmWRt4XM7hCTzPKn+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] bootmeth: pass size to efi_binary_run()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
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

On Fri, 22 Dec 2023 at 17:02, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> If we call efi_binary_run() with size parameter set to zero, we get an error
>
>      Not a PE-COFF file
>
> Fill the missing value.
>
> Fixes: 1373ffde52e1 ("Merge tag 'v2024.01-rc5' into next")
> Fixes: 7017fc54a5bc ("bootmeth: use efi_loader interfaces instead of bootefi command")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  boot/bootmeth_efi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 00060f7d25..c4eb331d69 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -454,12 +454,12 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
>
>         if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
>                 log_debug("Booting with built-in fdt\n");
> -               if (efi_binary_run(map_sysmem(kernel, 0), 0,
> +               if (efi_binary_run(map_sysmem(kernel, 0), bflow->size,
>                                    EFI_FDT_USE_INTERNAL))
>                         return log_msg_ret("run", -EINVAL);
>         } else {
>                 log_debug("Booting with external fdt\n");
> -               if (efi_binary_run(map_sysmem(kernel, 0), 0,
> +               if (efi_binary_run(map_sysmem(kernel, 0), bflow->size,
>                                    map_sysmem(fdt, 0)))
>                         return log_msg_ret("run", -EINVAL);
>         }
> --
> 2.43.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
