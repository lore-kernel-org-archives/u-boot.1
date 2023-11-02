Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8368AC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 10:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96495875E7;
	Thu,  2 Nov 2023 11:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OIuoiSHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14AEA875C5; Thu,  2 Nov 2023 11:45:22 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E0EC875C5
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 11:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d9a3d737d66so754408276.2
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 03:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1698921916; x=1699526716;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzUo0f7wlx9e+RndXHgOpHQM4k8MjOB2A7pkniKQNJA=;
 b=OIuoiSHsQQTId2ePFiu0BlwEHr+hctFIJHs9SyagZODQWAQLFVdf3+ehVtrr5/yeWX
 sfd1Qg5ZUrcJd0mUEAGOCaFiPRpnQCe5TDk4gOLwjQvoIC8kDtq9HMlZcQAzBIUMR5xd
 YFMD57LwPPF5l4OnXYjBAkmycUR3bCSbwMEZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698921916; x=1699526716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzUo0f7wlx9e+RndXHgOpHQM4k8MjOB2A7pkniKQNJA=;
 b=wW6LZCBETT+XxER+5gsmVjG4lsgriNJk7+RWMgDvrPvSAMaZvg1IHKNaeFoXZ/Z8XY
 bvW15GuMWpB+z72VpcScN7T07EhsfTMlcbybtqojcsD7X1Bl/tP1uhmTj5T8QD0Ikq8T
 HIpcVskILF3YZRKV6YhStEZomKqZvoSc/mkOIF0r582r9iZJUdNdbodZin3Vc1JrFMWI
 IF93cODPJvcOMedUuF4JI5Q4ce338hZUr/4AoNRBxMWZIwtonxpetm6jWZV5qxvaCRmn
 s8tFP1A9JjUnhpymMkG8CruvzwHUBoYNAAVGorfDj/YxOu4OdN496fuHyTTlcsG6kabo
 b30A==
X-Gm-Message-State: AOJu0YwWx71l3TdZeUSRSDrF9i1Qwu0jJDvYjxKQ1QpONa6KOPpzn0aM
 vXhK1+iSkv5eI6Jzymh5t1DkgPEmcQ22tOKefXo94Q==
X-Google-Smtp-Source: AGHT+IEvoJ2J3EhShWnF9bj4tpLDqA6pnMcn4n/tOKImTBRce4ZwxbaEs4A7ez4pAQVp8vPiI3ZhlHECLptwAikOG3o=
X-Received: by 2002:a05:6902:100e:b0:da3:b603:8314 with SMTP id
 w14-20020a056902100e00b00da3b6038314mr5282595ybt.0.1698921915938; Thu, 02 Nov
 2023 03:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231029034845.1169614-1-seanga2@gmail.com>
 <20231029034845.1169614-11-seanga2@gmail.com>
In-Reply-To: <20231029034845.1169614-11-seanga2@gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 2 Nov 2023 11:45:05 +0100
Message-ID: <CABGWkvoZO+PThfzTtfPhu=hp-d7gcLAVxsLa9brE+z8zdv9D5A@mail.gmail.com>
Subject: Re: [PATCH 10/15] mtd: Add some fallbacks for add/del_mtd_device
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

Sean, All

On Sun, Oct 29, 2023 at 4:49=E2=80=AFAM Sean Anderson <seanga2@gmail.com> w=
rote:
>
> This allows using these functions without ifdefs. OneNAND depends on MTD,
> so this ifdef was redundant in the first place.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  drivers/mtd/nand/raw/nand.c         |  2 --
>  drivers/mtd/onenand/onenand_uboot.c |  2 --
>  include/linux/mtd/mtd.h             | 12 ++++++++++++
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/nand.c b/drivers/mtd/nand/raw/nand.c
> index 4da41438790..3abd82068fb 100644
> --- a/drivers/mtd/nand/raw/nand.c
> +++ b/drivers/mtd/nand/raw/nand.c
> @@ -60,13 +60,11 @@ int nand_register(int devnum, struct mtd_info *mtd)
>         sprintf(dev_name[devnum], "nand%d", devnum);
>         mtd->name =3D dev_name[devnum];
>
> -#ifdef CONFIG_MTD
>         /*
>          * Add MTD device so that we can reference it later
>          * via the mtdcore infrastructure (e.g. ubi).
>          */
>         add_mtd_device(mtd);
> -#endif
>
>         total_nand_size +=3D mtd->size / 1024;
>
> diff --git a/drivers/mtd/onenand/onenand_uboot.c b/drivers/mtd/onenand/on=
enand_uboot.c
> index 04791df69bb..ecacabefadc 100644
> --- a/drivers/mtd/onenand/onenand_uboot.c
> +++ b/drivers/mtd/onenand/onenand_uboot.c
> @@ -44,14 +44,12 @@ void onenand_init(void)
>                         puts("Flex-");
>                 puts("OneNAND: ");
>
> -#ifdef CONFIG_MTD
>                 /*
>                  * Add MTD device so that we can reference it later
>                  * via the mtdcore infrastructure (e.g. ubi).
>                  */
>                 onenand_mtd.name =3D dev_name;
>                 add_mtd_device(&onenand_mtd);
> -#endif
>         }
>         print_size(onenand_chip.chipsize, "\n");
>  }
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index 09f52698877..7a66c7af749 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -552,8 +552,20 @@ unsigned mtd_mmap_capabilities(struct mtd_info *mtd)=
;
>
>  #ifdef __UBOOT__
>  /* drivers/mtd/mtdcore.h */
> +#if CONFIG_IS_ENABLED(MTD)
>  int add_mtd_device(struct mtd_info *mtd);
>  int del_mtd_device(struct mtd_info *mtd);
> +#else
> +static inline int add_mtd_device(struct mtd_info *mtd)
> +{
> +       return -ENOSYS;
> +}
> +
> +static inline int del_mtd_device(struct mtd_info *mtd)
> +{
> +       return -ENOSYS;
> +}
> +#endif
>
>  #ifdef CONFIG_MTD_PARTITIONS
>  int add_mtd_partitions(struct mtd_info *, const struct mtd_partition *, =
int);
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
