Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636CECF65FF
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 12:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E9B183B27;
	Mon, 26 Jan 2026 13:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="khaOH3oO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EAB383B32; Mon, 26 Jan 2026 13:45:13 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E2FA83B0B
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 13:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-59b77f2e43aso6468406e87.1
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 04:45:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769431505; cv=none;
 d=google.com; s=arc-20240605;
 b=kC/gGe5Jyd7OUmsf0cRh3oEeYGY8wKK+2lCZLhRs11AdaQ7SSmpKpfHhrD1RiONe1h
 eqHlV+B4AqG6s0/jKoCJASH9Njglo7xA7uNrjAkcQWAVqtBZEuHT8YjLdHE0w8pJYVab
 D8yzwWXlofjnhjuaWEZL4NT29jc5NgBkay4VPxcRSfW86dsCTmrSMLBW/mnB6MOHx+UU
 AbB6joC7y70lKlkHkXwozDrebj85dDbHo1jbMOBjEXePKbkVoxIbPIQFAzrI+0yabCT1
 KDYOxBWXEQ08y9068xwuFxsgXN3Ypyd/jRP87xfT1lA3f/feIiCKb4VZVuYxGfWnXpBX
 /WoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ma9tRSWeypmCaam4B62CwRG5sdQ4KE0LVu5T5BiDwu0=;
 fh=HMeFAPOAZn567QxgTRSRn/DL4wRSz8n7dI7Ne5jaVa4=;
 b=UBs/PJ8S+l1Drdh7RGFgRpfavxYlfNP6XBoOF4Q4APF5cmugCkUxmZzTxNhXqTQbZi
 gNQ3l8YUJ2z262fiIE48L2F1s+Ui2QsS1JhZdsqHk8S6NMJ1Txjzs0rosgivCpGEtPhZ
 s5isH87vbCucIIW+GkuQ0pJCPe6LakuPSHir/RJ8ANnofgHOv2Ha603KPGzpEMMnqnWx
 vumuTN+ofQzA00BXbGdfTAL/TGQ+EA/o2CcGFTEssKtvP/zsQ3mm6P0q5WR9NdmrUpDG
 L7AuB4HjiMM92//qwVz4/kcuVkOAVeSOrPglF4BW2UPLNZ683vdErGIxWO4wL6JCJuOf
 RG5Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769431505; x=1770036305; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ma9tRSWeypmCaam4B62CwRG5sdQ4KE0LVu5T5BiDwu0=;
 b=khaOH3oO38m5hTCsVAG914a8vd1wULp1Yu723xUl22ZPMtf9VMWWXJmxe2/kZ+HCFN
 whpNwvTVhN9+YmLoiCix6vcB/f5ULm5kJiNQ5EHOoLPtSFqMDhFL56C4dvk4siL6PyKK
 0oK44OaD3Ez6Zgv2MmfpBDym5Fp6iUrUxxwvs/VrWTSSs6ZYHEiEu3GlqrSKt2RVfFOM
 UXZjw9dSHUuQ+54iGapNPf1N2t2M4bdUdif9DKYiJlR/YhIk7DCF5vxGCph8bN+Hl+FA
 FbG+gM/INQFjZspQvC2pmR34DJk2icuyl5m3bQ7fzr/aDozjOy47WDzdQFjlXy34Mcu4
 xpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769431505; x=1770036305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ma9tRSWeypmCaam4B62CwRG5sdQ4KE0LVu5T5BiDwu0=;
 b=C0LZXyjWa0AaWj5KtVXvHpyeaJfS3IyzJ4rX39Xtn1vw/iXUzGRAwFKEIXPrZ+Ao7L
 AnwZeqi8kFYD0DZUayxbmyefNbQhU9N2K4PkGZetH2e7keiI2y4VlIHzDu1aUHRK6mil
 W51U5RI2geAhAKaF1IFD5kAG2dvWT1pMGGZJRDiNl6/nzP+CACjLLvvehE/8pv3pNgEg
 ybP/0IJ+5YTjpi3ptefK82wpfLGYSCRVW6wctAqnB2P2l1wkGmOZ4iaBFDEEcg9X/nIx
 8nX/DEp29KmQvFEzqyv4LeRPRkbSaFLDA/YjkAaDqTmhXdqvUjkjl80mjunnunhx197P
 phLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU75Oe1BeFCTYivoCUjwnoJmZM6LwYfh1O1ebP+vL/+GEpNRBrRT1N/ur3ISUHu30RBDFsUcd8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxbm/h0OLLt1Mfhq1ltzzUYgLpe8vaLppqbLWXiJn9IWjobHmo4
 poMpFGLPVPu4M9JzZbitgz2gj3EO2xILW/L1juVkCTWcDaadiz5EVfTrsVrBhqPYUoSwQKvOgi7
 SzZgcdA3H2tBYjFcz6+4rHxkTYFMB3UZprJwC
X-Gm-Gg: AZuq6aKd7YCIXWOgSGNG1+i5ziejxhw/buUj14jMKT4ZFzLK9oXlSQPXlhvFyAx5659
 j04RohpYVEn3xnF7RLi/k+uNMnGMVHg+pphDNju0UIvw5Y2HnoQG3DcqXwS+AEasziyVyoDF45a
 SWTHOZUuuU2zkwoSkXISeJrHpwPPX8ldHZOBz8Dg/YsKroW1sLFjdwRPOT6IDYHtZOmr3ntS+Oa
 St0TjQq7ZJnPZ0yeXGxLp0ZpcaRLrMUFsRvMWxO/FTi149ayXuWFMnFdHX5E36fAIL0geMDaVFH
 YhtanTi1hIniiHNdj7qKDDewVMo=
X-Received: by 2002:a05:6512:800b:20b0:59d:f5a6:bea9 with SMTP id
 2adb3069b0e04-59df5a6bf79mr960014e87.1.1769431505065; Mon, 26 Jan 2026
 04:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20260123161907.392211-1-festevam@gmail.com>
 <20260123201202.GO3416603@bill-the-cat>
 <CAOMZO5DVFO=A6g1CWOrRbqy4VNgL+VcUw0Q5pgELXm30puGz4w@mail.gmail.com>
 <CAC_iWjJ5gVzOP_6cgxEbUJn8a=KRj=-wEFy=Do7Dp8oqH3V+Dg@mail.gmail.com>
In-Reply-To: <CAC_iWjJ5gVzOP_6cgxEbUJn8a=KRj=-wEFy=Do7Dp8oqH3V+Dg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 26 Jan 2026 09:44:53 -0300
X-Gm-Features: AZwV_QjlcUKmanahgjTjO3JuP8Up3F0fKvp366-YKVP57au5BsgbyBNuN3ZnxmE
Message-ID: <CAOMZO5D5awN11z8Hxwr4+tunqvhH8fYbUJvU6McES=edi2OR4Q@mail.gmail.com>
Subject: Re: [PATCH] arm: spl: Fix DTB offset after binman symbol table
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, marek.vasut@mailbox.org,
 u-boot@lists.denx.de, 
 sjg@chromium.org, Fabio Estevam <festevam@nabladev.com>
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

Hi Ilias,

On Mon, Jan 26, 2026 at 3:29=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:

> Fabio can you please try this
> diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> index d780a5060774..af9f3a3c39c0 100644
> --- a/arch/arm/cpu/u-boot-spl.lds
> +++ b/arch/arm/cpu/u-boot-spl.lds
> @@ -51,8 +51,8 @@ SECTIONS
>                 __rel_dyn_start =3D .;
>                 *(.rel*)
>                 __rel_dyn_end =3D .;
> -               . =3D ALIGN(8);
>         }
> +       . =3D ALIGN(8);
>
>         _image_binary_end =3D .;
>         _end =3D .;

Yes, this works. This is a partial revert of 8b0ebe054bb3.

Thanks
