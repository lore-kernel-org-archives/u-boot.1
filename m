Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95953C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 10:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 871508772F;
	Thu,  2 Nov 2023 11:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RYqYbqKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F85687746; Thu,  2 Nov 2023 11:59:12 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1888E8771C
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 11:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d84c24a810dso797106276.2
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 03:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1698922746; x=1699527546;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWH5hkTX7aB8y+wfMyvfs9waeP5sLe0aownKN5QnjDo=;
 b=RYqYbqKqcgztKn9w5LLf/o3tThdc+nyDNxMj5OVvVKLz5FCoW36cjuCKXBxB7H6xH7
 dmm/fNmw/Mtzyk+fWxmkghSpISceCSnS15PLTIttti2AGYwLvpYfTdDDSHslzJfgmU4W
 FpWwqQ63TyPZAkhG1UPKeWWi49UL4aoOom3OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698922746; x=1699527546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWH5hkTX7aB8y+wfMyvfs9waeP5sLe0aownKN5QnjDo=;
 b=o8TKgPcIc2ewrwu7+Tq3eUcWTIgj92pCp8cGf3SzNGX4nKgxeGFiPcSYbZwFushBQx
 49ZZyPhDM1MQ1nvqBLPZzN6QQvVVa+gO9FeG+PaoXkHevaHPu4UvAiAndsQa75ULqfTd
 2sYvvfyOTEBUWxpqdUcpf8rKTlGB6znh13ga5+12MLMlADaJRLuHmsduyErn9zqNoOR2
 T9tGzkJiaWU3m2TTgNOBg22jlm1mhwVg8vz6tf+b+rGgtHN0b/ExB59lKBfXC/9W0PSe
 7DNV5MJMFye6W2EWAZkrJCUXuoRBja4qeRbnRnsgo3mdJdQfL5CzoYd306ZY196ehdl+
 fSsA==
X-Gm-Message-State: AOJu0YxU55PxrjnTV5GzGpK0taQyp3TjymK369BNylpmUFaRMZKgVA5X
 1n8Y8hv1pfjyR6WtzolvLOXol9/rqI7DouGV/JC0Lg==
X-Google-Smtp-Source: AGHT+IEQochCG9LMjQwa0os31aVZ9poNbibPIpAObyWb7Q9bFswvWqYGoANRUFkrGKXfYWiwj1XfGrP11na67fGBPhE=
X-Received: by 2002:a25:3752:0:b0:da0:52e6:a867 with SMTP id
 e79-20020a253752000000b00da052e6a867mr15622669yba.1.1698922746214; Thu, 02
 Nov 2023 03:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231029034845.1169614-1-seanga2@gmail.com>
 <20231029034845.1169614-12-seanga2@gmail.com>
In-Reply-To: <20231029034845.1169614-12-seanga2@gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 2 Nov 2023 11:58:54 +0100
Message-ID: <CABGWkvormOkuyHMFJJ11mCXx53gDVg5yZmk1H3mH1+AhZza88g@mail.gmail.com>
Subject: Re: [PATCH 11/15] nand: Add function to unregister NAND devices
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Michael Trimarchi <michael@amarulasolutions.com>, 
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

Sean, All,

On Sun, Oct 29, 2023 at 4:49=E2=80=AFAM Sean Anderson <seanga2@gmail.com> w=
rote:
>
> This performs the opposite of nand_register, allowing drivers to unregist=
er
> nand devices. This is probably unnecessary for most regular drivers, but =
we
> expect sandbox drivers to get repeatedly bound/unbound, so this will help
> avoid dangling pointers.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  drivers/mtd/nand/raw/nand.c | 17 +++++++++++++++++
>  include/nand.h              |  1 +
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/nand.c b/drivers/mtd/nand/raw/nand.c
> index 3abd82068fb..80017b3dddd 100644
> --- a/drivers/mtd/nand/raw/nand.c
> +++ b/drivers/mtd/nand/raw/nand.c
> @@ -74,6 +74,23 @@ int nand_register(int devnum, struct mtd_info *mtd)
>         return 0;
>  }
>
> +void nand_unregister(struct mtd_info *mtd)
> +{
> +       int devnum =3D nand_mtd_to_devnum(mtd);
> +
> +       if (devnum < 0)
> +               return;
> +
> +       if (nand_curr_device =3D=3D devnum)
> +               nand_curr_device =3D -1;
> +
> +       total_nand_size -=3D mtd->size / 1024;
> +
> +       del_mtd_device(nand_info[devnum]);
> +
> +       nand_info[devnum] =3D NULL;
> +}
> +
>  #if !CONFIG_IS_ENABLED(SYS_NAND_SELF_INIT)
>  static void nand_init_chip(int i)
>  {
> diff --git a/include/nand.h b/include/nand.h
> index c1d7533aaac..fc584f5ef7a 100644
> --- a/include/nand.h
> +++ b/include/nand.h
> @@ -22,6 +22,7 @@ int nand_mtd_to_devnum(struct mtd_info *mtd);
>  #if CONFIG_IS_ENABLED(SYS_NAND_SELF_INIT)
>  void board_nand_init(void);
>  int nand_register(int devnum, struct mtd_info *mtd);
> +void nand_unregister(struct mtd_info *mtd);
>  #else
>  struct nand_chip;
>
> --
> 2.37.1
>

Reviewed-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Thanks and regards,

Dario
--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
