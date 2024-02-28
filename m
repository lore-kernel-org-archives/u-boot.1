Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539FBC54E41
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 11:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F20B88073;
	Wed, 28 Feb 2024 12:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qRfiNn/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDB6A8800D; Wed, 28 Feb 2024 12:08:12 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A69D8800D
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 12:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-512be9194b7so5533970e87.1
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 03:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709118486; x=1709723286; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VWNeZ9M+Z33LaWsDLK8FSJo6x/sBDvNy5QaWEVERxXU=;
 b=qRfiNn/oCzCdV/ubY04b4Rc9GInr81iKdzxp8P2pplvYiIyNqsAoc7iCXLR50mMtAO
 /+l4w/cAQ34RLVnKQSanQiZ6L8mPTwYgJe8Zp8RQXp+xKgM3k8/LNz1nkIqO4A4seriJ
 SlpUMyh3Vl33gZEjV11HwJdIyNj/aUg2wcG/Ev4cC7fMz/PKFD2rUvtJyulm1GGQQs8M
 Q+NHw8riM0ValG2UiXGQSDMuOFtoAF7yAdoP53iyLnw8U/lDX/jAr0e9hBfzoUHHWGDF
 tEQRopRPCyiaa/pUwj1ilVC5kM1AoqZ5iZYj4xi3QhBzqJIzXeptgpPATzx7+SoHSort
 t8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709118486; x=1709723286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VWNeZ9M+Z33LaWsDLK8FSJo6x/sBDvNy5QaWEVERxXU=;
 b=pBYwH9B5+2PMeIGoCocOkVouNHSCqZPM0DRVEVmVpbvX+NdXy6SBZyBrM0HLhyMvlo
 RpVND6TkEqs1LFaOWH2MQeaTmdzuE6cLUf9Hqdo3SLEDjCtvuEqdObJ/G3RB1qxr0T87
 onI95FNaGBL1Sy/lFeRJLs3JMyLdo4PI+VXz5D8+1GreQOdspFExIWE/P6NRh3Cr73vH
 2ytzjvlwMK5U0xc9ahxbPvr6b3+bmXRVfi8JFUlP1RH0rGso39/xOcUEjuUfvDn2C1rD
 daK1C4l0CJ503Jqa0wDTNIGCgpJH4A9/ean4oocTiixqTe6YI07vtAMPuatLp1i5QIuu
 FxoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdVi//AmGHsB19xkvNdRgjfW5C/o0EHImNTtOofXc4QKxMMG36Kij+pfmsAnuOnnKFr8UHRiNE7BEmQPSHxgGnRzAvGQ==
X-Gm-Message-State: AOJu0Yydzi98T4SGLyopzHoYof+KX6DXA7UozMWW1O8b11axQlA3iXxI
 2ofsnJOqstRsBYj4LVvZpejAUcNJOVOa9GWDfVtCNsXsGDHdnGqf6td5oYlCiO13fq2pKqXe4lW
 OHXsPFX8CTIxZaoStUer7fcDnkfbeVQ8K6n/RxA==
X-Google-Smtp-Source: AGHT+IHfzmuPG+5LxDjMUPZlVAZbzJfuPyF/Kh5/SYUrN7ZHHJtsDrcpX6O4DHSjCr+lWCKwlfGnlNk3VqPQm4k9pp4=
X-Received: by 2002:a05:6512:360b:b0:512:cda1:9bab with SMTP id
 f11-20020a056512360b00b00512cda19babmr7490194lfs.13.1709118485716; Wed, 28
 Feb 2024 03:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20240226212408.7535-1-heinrich.schuchardt@canonical.com>
 <20240226212408.7535-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240226212408.7535-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 Feb 2024 13:07:29 +0200
Message-ID: <CAC_iWjL8MU4=q0PyEghUGQCfdxVYWygyVViM7rZTaao53-h+Dw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm: page align EFI binary section
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Mon, 26 Feb 2024 at 23:24, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Change the alignment of the relocation code in EFI binaries to match page
> boundaries.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  arch/arm/lib/crt0_arm_efi.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
> index 75ee37b7d3..7a4e5dff75 100644
> --- a/arch/arm/lib/crt0_arm_efi.S
> +++ b/arch/arm/lib/crt0_arm_efi.S
> @@ -115,14 +115,14 @@ section_table:
>         .short  0               /* NumberOfLineNumbers  (0 for executables) */
>         .long   0xe0500020      /* Characteristics (section flags) */
>
> -       .align          9
> +       .align          12
>  _start:
>         stmfd           sp!, {r0-r2, lr}
>
>         adr             r1, .L_DYNAMIC
>         ldr             r0, [r1]
>         add             r1, r0, r1
> -       adr             r0, image_base
> +       adrl            r0, image_base
>         bl              _relocate
>         teq             r0, #0
>         bne             0f
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
