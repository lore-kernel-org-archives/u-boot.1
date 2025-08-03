Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6920CC87FCB
	for <u-boot@archiver.kernel.org>; Sun,  3 Aug 2025 08:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA5FA83D03;
	Sun,  3 Aug 2025 10:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AJkAiSFH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92BE083D07; Sun,  3 Aug 2025 10:13:44 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07E3783CEE
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 10:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3190fbe8536so1969752a91.3
 for <u-boot@lists.denx.de>; Sun, 03 Aug 2025 01:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1754208820; x=1754813620;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A+jF85xF5uG0R/bnp3IyrmJMPA5L/eEGsaK4FvYxeW0=;
 b=AJkAiSFH21WsyZ2a3WThnmnkMDlSWCngrdHP30TFOHb4oviQrZQDJaB08sfUFX0RdF
 yCvLtijiJpf6dR0gETvAryXWIvVPnv8gIp8CAqD85TLjBXivjBjx9eEwBb/O7V6Kzsw9
 r8rimcD0IkOJjoSfYQlnLntRMVBYJIKKlx6m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754208820; x=1754813620;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A+jF85xF5uG0R/bnp3IyrmJMPA5L/eEGsaK4FvYxeW0=;
 b=AUT5RQWWXJZYoLrpwllIHjWbp/oHepdCxaAPHRXEfQWRuRcSC5v7mmBSBMBFgzrfR9
 JmzkmvZzTwl46eEywI8oevKsZO/Gm4GKt3frTyug4omxZ8qHvFzgZQEKisLL8HwwBbaI
 uCV1OESgAVpQACw0mr4BTEBXJ5BClbKaBeF1/jehV9ZSj3fk+UpV7mkSe24v5m6tsLPs
 Ed+ZwPiHUBMkMgnR3Q+O5RCg1hWhmfwKE5AseA0J3sn9I1cQjAfo5BrxhzgSaPC6domM
 DizKSXJ1a2/KyPi4t35dSNEcQrDifNeSZ5W4TNefk/4jviv1UI+CFixYS3nGgL/tGfGw
 5Wyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1cQbcuWOUayyL+oa2VDxyNxzr8ytMuXAxyf5wjEl3baijXGAztAyNnQQjTHLEnf4o348Vor8=@lists.denx.de
X-Gm-Message-State: AOJu0YzaLnrewFaJBXr9BUUV71CgP96eMssLabXen74GITJ6prVjGA+C
 rPSNIMIhPMSZLcabqTMHhORdUMiF+AWZiQvR0AvFNab8PqwMGnDjpHT/A0xr1yrxut92w9dA0Y7
 QbB1kSwsYSkj1QIsYKuIqoiaK5y/SuVoDgZAL1toaxg==
X-Gm-Gg: ASbGncuCoyTcb/i5IF6n61ZfyHDn+JUuc0h6vha8QN/vGSaF9BwVmYUhuZo5MfUXwhn
 Mo9vUyrzlZ61avVy4QpJhVIwH3BJSjzIUrecdtYoz7AgpeHKNeBsfmmTMzsdc38RElxJbDLpokl
 6DZDEycFxYorsaM46w8hGsAuN9fzwUSFoIjfQUKpa+Y+xFMKn0byPWKWzssWaQipSGXRR1BJiHc
 z1vzighdVIdLO0WSUjFnNEWyoE=
X-Google-Smtp-Source: AGHT+IH+1deZ5UvLdkV/h4nA6sbxV1VWPUtYDgUPLuiDemUHuu2FlHNvuYJYkl8rAw66QYio0Sx5m+moSWnd2Av8aB0=
X-Received: by 2002:a17:90b:38cb:b0:31f:2bd7:a4d2 with SMTP id
 98e67ed59e1d1-321162e1181mr8254051a91.35.1754208820382; Sun, 03 Aug 2025
 01:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250801-mtd_nand_raw-v1-0-80c316f5bb99@linaro.org>
 <20250801-mtd_nand_raw-v1-1-80c316f5bb99@linaro.org>
In-Reply-To: <20250801-mtd_nand_raw-v1-1-80c316f5bb99@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 3 Aug 2025 10:13:28 +0200
X-Gm-Features: Ac12FXy68-0QGDlthYuCiltqifJg2BVBN6XuxP4iKO8IQenFX-CkbDsQmlFw_ow
Message-ID: <CAOf5uwmzWXOa-UhS2_+22Jw2GFD7N61nyDdP9VRRFAjG8A+MHA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mtd: rawnand: cortina_nand: Fix -ENOMEM detection
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi

On Fri, Aug 1, 2025 at 11:54=E2=80=AFAM Andrew Goodbody <andrew.goodbody@li=
naro.org>
wrote:

> In init_nand_dma there was code to detect failure to allocate memory but
> it had two problems. Firstly the 2nd clause when info->tx_desc was NULL
> attempted to free info->tx_desc when it should be freeing info->rx_desc.
> Secondly there was no detection of both allocations failing, arguably
> the more likely scenario. Refactor the code to simplify it and just fail
> as soon as either allocation fails.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/mtd/nand/raw/cortina_nand.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/cortina_nand.c
> b/drivers/mtd/nand/raw/cortina_nand.c
> index 06918a46e93..a27a6994f56 100644
> --- a/drivers/mtd/nand/raw/cortina_nand.c
> +++ b/drivers/mtd/nand/raw/cortina_nand.c
> @@ -186,14 +186,13 @@ int init_nand_dma(struct nand_chip *nand)
>
>         info->tx_desc =3D malloc_cache_aligned((sizeof(struct
> tx_descriptor_t) *
>                                               CA_DMA_DESC_NUM));
> -       info->rx_desc =3D malloc_cache_aligned((sizeof(struct
> rx_descriptor_t) *
> -                                             CA_DMA_DESC_NUM));
> -
> -       if (!info->rx_desc && info->tx_desc) {
> +       if (!info->tx_desc) {
>                 printf("Fail to alloc DMA descript!\n");
> -               kfree(info->tx_desc);
>                 return -ENOMEM;
> -       } else if (info->rx_desc && !info->tx_desc) {
> +       }
> +       info->rx_desc =3D malloc_cache_aligned((sizeof(struct
> rx_descriptor_t) *
> +                                             CA_DMA_DESC_NUM));
> +       if (!info->rx_desc) {
>                 printf("Fail to alloc DMA descript!\n");
>                 kfree(info->tx_desc);
>                 return -ENOMEM;
>
>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


> --
> 2.39.5
>
>

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
