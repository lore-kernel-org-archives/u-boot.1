Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C23C0018A
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 11:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32683876F5;
	Thu,  2 Nov 2023 12:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n90sKUl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1541887605; Thu,  2 Nov 2023 12:08:27 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE588772F
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 12:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d9a58f5f33dso814085276.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 04:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1698923301; x=1699528101;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55emeRPt82uH39JhTL6zd274yI3OR2IWxU5TvMTlPs8=;
 b=n90sKUl4292SOWPaxelI4wdeNFth5UZV16F97Og0e/NVJfH3slTacXUjGDmpbCpdCX
 DT0idjwv2sg4T6mgHN61RWQkSHNPCLJ/ALfQ7EPK/kz3BvojvoHgTbj+2+FxUmVuSRdp
 f1Ayg/bHyKIp7lsw3I5opO5uIylmJwdpmC0kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698923302; x=1699528102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55emeRPt82uH39JhTL6zd274yI3OR2IWxU5TvMTlPs8=;
 b=CeEPcV97ivJQbbZpELW9y94s88yybmxl4ljoZM++tykqk8WZx/xjYUX7GiehZn+vWH
 UER9l6EydrlMFJLbIUZp4KkfjC7WXzv15+TXg5zIYyQBj7it2PUoZiox4Z/YZBUbAYj0
 T/ur3VN0NlwnJu/kOwQzgrrF5Li3jCBOynKv1gPXjZ+j0ibCAOljIme2lWvAUJlsAC5W
 1FtiChFX00oGUqiVgUUbdZkg1gsTwgk6ifC1RKp0AjAWlDKhNL7FqcJwrG2fsOg4tCzB
 ioZdtKvbiAFINULlq3YOnY83hXtCPvJbxPCAeprovXEbN7ae8Kcf5OlhMqRfZ/vVF2ap
 BqsQ==
X-Gm-Message-State: AOJu0YwcfqcLoKkge+Z9kBpXKA7jGPhK8XXRbYgLmX3u3AaUUrGJF3EC
 qJMFyS0EQ7/fabVu2nW7xcTB+cO7nyjAuZbjLA0wSg==
X-Google-Smtp-Source: AGHT+IE/ieUIWcqHIOaKeHkOkpcN8H0AHoigHN6138+WfpriAZ9Rdsp+4v2EVk5VKc1gsGydA/s4eygxnt8ova95Rd4=
X-Received: by 2002:a25:2d14:0:b0:da0:68a0:7cc6 with SMTP id
 t20-20020a252d14000000b00da068a07cc6mr16035310ybt.17.1698923301694; Thu, 02
 Nov 2023 04:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231029034845.1169614-1-seanga2@gmail.com>
 <20231029034845.1169614-13-seanga2@gmail.com>
In-Reply-To: <20231029034845.1169614-13-seanga2@gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 2 Nov 2023 12:08:10 +0100
Message-ID: <CABGWkvpJNvUKSJBcXaxAztPgDObQsF5TPuyHkM9wFOyJZRxJ0A@mail.gmail.com>
Subject: Re: [PATCH 12/15] nand: Allow reinitialization
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
> NAND devices are destroyed in between unit tests. Provide a function to
> reinitialize the subsystem at the beginning of each test.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  drivers/mtd/nand/raw/nand.c | 40 ++++++++++++++++++++++++++++++-------
>  include/nand.h              |  1 +
>  2 files changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/nand.c b/drivers/mtd/nand/raw/nand.c
> index 80017b3dddd..4c18861aa25 100644
> --- a/drivers/mtd/nand/raw/nand.c
> +++ b/drivers/mtd/nand/raw/nand.c
> @@ -115,6 +115,8 @@ static void nand_init_chip(int i)
>  #endif
>
>  #ifdef CONFIG_MTD_CONCAT
> +struct mtd_info *concat_mtd;
> +
>  static void create_mtd_concat(void)
>  {
>         struct mtd_info *nand_info_list[CONFIG_SYS_MAX_NAND_DEVICE];
> @@ -129,28 +131,40 @@ static void create_mtd_concat(void)
>                 }
>         }
>         if (nand_devices_found > 1) {
> -               struct mtd_info *mtd;
>                 char c_mtd_name[16];
>
>                 /*
>                  * We detected multiple devices. Concatenate them togethe=
r.
>                  */
>                 sprintf(c_mtd_name, "nand%d", nand_devices_found);
> -               mtd =3D mtd_concat_create(nand_info_list, nand_devices_fo=
und,
> -                                       c_mtd_name);
> +               concat_mtd =3D mtd_concat_create(nand_info_list,
> +                                              nand_devices_found, c_mtd_=
name);
>
> -               if (mtd =3D=3D NULL)
> +               if (!concat_mtd)
>                         return;
>
> -               nand_register(nand_devices_found, mtd);
> +               nand_register(nand_devices_found, concat_mtd);
>         }
>
>         return;
>  }
> +
> +static void destroy_mtd_concat(void)
> +{
> +       if (!concat_mtd)
> +               return;
> +
> +       mtd_concat_destroy(concat_mtd);
> +       concat_mtd =3D NULL;
> +}
>  #else
>  static void create_mtd_concat(void)
>  {
>  }
> +
> +static void destroy_mtd_concat(void)
> +{
> +}
>  #endif
>
>  unsigned long nand_size(void)
> @@ -158,10 +172,10 @@ unsigned long nand_size(void)
>         return total_nand_size;
>  }
>
> +static int initialized;
> +
>  void nand_init(void)
>  {
> -       static int initialized;
> -
>         /*
>          * Avoid initializing NAND Flash multiple times,
>          * otherwise it will calculate a wrong total size.
> @@ -190,6 +204,18 @@ void nand_init(void)
>         create_mtd_concat();
>  }
>
> +void nand_reinit(void)
> +{
> +       int i;
> +
> +       destroy_mtd_concat();
> +       for (i =3D 0; i < CONFIG_SYS_MAX_NAND_DEVICE; i++)
> +               assert(!nand_info[i]);
> +
> +       initialized =3D 0;
> +       nand_init();
> +}
> +
>  unsigned int nand_page_size(void)
>  {
>         struct mtd_info *mtd =3D get_nand_dev_by_index(nand_curr_device);
> diff --git a/include/nand.h b/include/nand.h
> index fc584f5ef7a..220ffa202ef 100644
> --- a/include/nand.h
> +++ b/include/nand.h
> @@ -11,6 +11,7 @@
>  #include <config.h>
>
>  extern void nand_init(void);
> +void nand_reinit(void);
>  unsigned long nand_size(void);
>  unsigned int nand_page_size(void);
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
