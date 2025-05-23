Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACEBC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D688B832D8;
	Fri, 23 May 2025 18:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SG1bo4Na";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AD458331C; Fri, 23 May 2025 18:42:02 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15128832C8
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 18:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-601ab204085so2032961a12.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 09:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748018519; x=1748623319; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/t+CWWlWazD4EHcX2Z+BzjO8IvBBP40FHUhVWolDWUg=;
 b=SG1bo4NarLNvNMV4GOKikkwxvUWkTJrNNFUYiRwtseqBoKAT9rnhr17OsptlCXPYxV
 lEO3/DqiX+mADC21IyYO+JitgrFYUSJE4/ZduwEPaHsNlk1BfWSy5JouWV1vR1yqPKee
 ejmIwGFKwvBf4/320zlFqMQX3q8mU+xF87b9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748018519; x=1748623319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/t+CWWlWazD4EHcX2Z+BzjO8IvBBP40FHUhVWolDWUg=;
 b=Ch9OE/s4p+FBgSitE6hKXP2pYrPpTHn50yZRS/7yi4SGuFji8kPYAlKs42l7Hfy6ju
 s4aYsulTOIPzvaUaaM64YMkHOE+Tqhety6thaBqz2S6KzwSbO+C9qQMgiTg5gH4snznI
 9nuZD9QRVChZ7cNL/Vap2QG0a7igSyMT9dlFBbgzcBUYz8rOOtAzH3cLDMWHO74ZS41/
 Anf/bb8bC3cSBuWitReOiqMwUFHayKHlzyPAlXlO8s3f4orb82AqqZT5FmaHMTEbV4Xv
 6n/Hj0J3uoJ5M/IyM2RLzIqbHMIeTRyOKU5zM5EVjI1Yj9xUwI2MtBkHAovqHsVb9FE8
 gilw==
X-Gm-Message-State: AOJu0YwIWXLKbqMWQ2xwFkNrgMnCHq5gv2OKoQ02VMdrZdR4oEkmhZxX
 fJSkDeX5HmHt7jMFoCwxmOAxxZoyRb/pPjQd70p3Kyb37ZStVU0Y3/h07huDKlEAn0wtYGOtBkd
 KzZ+PJstu+LdT3/YLkqbWJQ7jKAS2C3f80AC9tjVZNWDqB/4GZcE674sz
X-Gm-Gg: ASbGnctdU2oBZqF25XZnVOmz6FwYZTtpuySnMrzQmOu3xsOrOrgKN3YOXFtTG3mKhNp
 qaxVaoyZ5Hu4SMZqATLjg42Gcwbo2zmJpMVOneOEgmxUSGFDyyg7zZZMQBnuXTFXO8B0INqEYka
 C1yHlg43JlJ7Rmm6vTM02C4wMovayoCFTf9Cne53flJ37T
X-Google-Smtp-Source: AGHT+IGuuwsFDuvV8ZaS8+BY8Nnrzb5rqINH7O43IXAl4ShMR75SQiPLFQ79Hcmis2irFAw+09cgBVN1ZCJwQU57tWs=
X-Received: by 2002:a17:907:2d14:b0:ad5:fae:54c4 with SMTP id
 a640c23a62f3a-ad8596d9822mr18815766b.4.1748018519507; Fri, 23 May 2025
 09:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <ME0P300MB13096732AF44AC5409B9D0D49F96A@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <ME0P300MB13096732AF44AC5409B9D0D49F96A@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 May 2025 17:41:45 +0100
X-Gm-Features: AX0GCFvnt_j1br7YfGLuw0nJaUDPZvYCajxh__TK0YVDJS-qp73fyTomjUBu4pY
Message-ID: <CAFLszTgpYgVfrf4P189tcNM7xOvoiVjMu_sP1nrP+FGfAYHYSw@mail.gmail.com>
Subject: Re: [PATCH] bootm: Pass SMP core ID and DTB address for ELF-formatted
 kernels
To: =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

+Heinrich Schuchardt

Hi,

On Tue, 13 May 2025 at 13:28, =E7=89=9B =E5=BF=97=E5=AE=8F <Zone.Niuzh@hotm=
ail.com> wrote:
>
> When booting RISC-V ELF-formatted kernel images (IH_TYPE_KERNEL + IH_OS_E=
LF),
> explicitly pass SMP core/hart ID and DTB address to comply with modern
> SMP-enabled kernels' boot protocol requirements.
>
> Signed-off-by: Zone.N <zone.niuzh@hotmail.com>
> ---
>  boot/bootm_os.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index a3c7cb5332e..a0f310b1359 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -402,6 +402,11 @@ static int do_bootm_elf(int flag, struct bootm_info =
*bmi)
>         if (flag !=3D BOOTM_STATE_OS_GO)
>                 return 0;
>
> +#if defined(CONFIG_RISCV)
> +       bmi->argc =3D gd->arch.boot_hart;
> +       bmi->argv =3D (char **)bmi->images->ft_addr;
> +#endif

If this is a kernel, it should really be using a FIT.  The Elf entry
is for general ELF files, not Linux. Perhaps RISC-V is special in some
way?

> +
>         bootelf(bmi->images->ep, flags, bmi->argc, bmi->argv);
>
>         return 1;
> --
> 2.45.2

Regards,
Simon
