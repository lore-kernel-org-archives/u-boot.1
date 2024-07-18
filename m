Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDA6C3DA61
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 20:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB87A885F1;
	Thu, 18 Jul 2024 22:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S8Rq3N8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5673C885AE; Thu, 18 Jul 2024 22:38:26 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50A3688481
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 22:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52ed9b802ceso895131e87.3
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 13:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721335103; x=1721939903; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=grKwAfVIdVaAktWTMGpxeXoUxOY/5riJ4pFZ2AzhV+0=;
 b=S8Rq3N8Y0UAn0UzQikR0FT3Q08g2jczvQGG87EQXxNEv23w+UtwuUhpgI+bK94d49b
 74ZddrWrDH/PdqvfSjPUrHYoIvd+qibbGCf7WSZREGdU1dqsBCAb85k3IrzBqdbLSWr3
 xL9vaARF3IP1r0IeN3vxsp2taQLozhF8N6NTK3Q2TlLX+GSeyoLq62Y3Ae3tLz98HhMC
 waKWtaYYE89/Ff0ZxcYTNWcA3OgYbcCruXedDPs/KoUUU+eApHcduIJLDeiuuu60Z4Ig
 N1WPAxgBsIh29cYRcma7bNfW166EN+i/EUqQdDDiJ20nYYBUg+t3/5hS/lVqefw5K9eN
 61qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721335103; x=1721939903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=grKwAfVIdVaAktWTMGpxeXoUxOY/5riJ4pFZ2AzhV+0=;
 b=K1X+MDqvpBdyWics7P0qitdoCwSHieT3miNMbqgyomO7QpOB/A2j6LaCjWxYIr9tkL
 6VgK+dmVSilAIYzqcwDPxwkiGEX7qc9qMmtF83EPDWTxwOrTLs2YqtuQZ43uq9b0mb6b
 cYaeCjX8fRrP13LUsGfOP5qfsjZcdG3p30dZCGJ9+nd5Bpo1LuzG2vWk3CnaY96A/NQa
 MpEGYiWo2QGDs6F0kpmVI9mSDulV/NvJ8YPQwZpHPMV95Eornroyp1Ifoi+gZTzR5R9U
 DkwniVhHdeMc9F/v0AdS/bZXBOk6pj4WHNp799otFlvJb7bJU4TfV0zNQYQBVxnINky+
 CrJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXdyA6p27JaUeweeN/Sqr6u95jod961ieY/KCKhWKAJIwxHdXPK+cMbLi3AoSvCJA5D95eFGA66CkNRNXw4Re3DDD/WA==
X-Gm-Message-State: AOJu0YwEP3D3sEXL4jwF6NQYKfoVsg8WPSgKwyXLh0gB5bLjC9gARb3m
 n1A1DJ5fXUBFE9zH8ag9Doixh7YRTZmHn4uXGTcMr8BJnlWJFVOlI5NN2wFkaYxO+xq64V3i5vO
 8+lqw7pehr6FD2Ob5RFBdAe3AOK8=
X-Google-Smtp-Source: AGHT+IFgLK0dIj5dOlBCaec3nQfutjLndSePUizCI8gif9L0yVI1u7rKJ74oK10B+1Aan9JWCusJjN/LunzRgBJ/cMM=
X-Received: by 2002:a05:6512:33c5:b0:52c:ec68:6165 with SMTP id
 2adb3069b0e04-52ee53cc00bmr4812117e87.33.1721335103272; Thu, 18 Jul 2024
 13:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240713113029.78262-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240713113029.78262-1-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Thu, 18 Jul 2024 13:38:11 -0700
Message-ID: <CANV2PTMHVYh6=32hL5hOuWOHgLhFfcGid=2eUokzvZQ10R5QxQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: find distro device-path for media devices
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Sat, Jul 13, 2024 at 4:30=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The auto-generated load options for media device do not contain a partiti=
on
> node. We cannot expect the simple file protocol here.
>
> Get the partition device-path via the loaded image protocol.
>
> Fixes: e91b68fd6b83 ("efi_loader: load distro dtb in bootmgr")
> Reported-by: E Shattow <lucent@gmail.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi_loader.h         |  2 +-
>  lib/efi_loader/efi_bootmgr.c |  2 +-
>  lib/efi_loader/efi_fdt.c     | 33 +++++++++++++++++++--------------
>  3 files changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 6c993e1a694..2a06fbe4704 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1205,6 +1205,6 @@ efi_status_t efi_load_option_dp_join(struct efi_dev=
ice_path **dp,
>
>  int efi_get_distro_fdt_name(char *fname, int size, int seq);
>
> -void efi_load_distro_fdt(void **fdt, efi_uintn_t *fdt_size);
> +void efi_load_distro_fdt(efi_handle_t handle, void **fdt, efi_uintn_t *f=
dt_size);
>
>  #endif /* _EFI_LOADER_H */
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 304ed43595c..589d3996b68 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1277,7 +1277,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
>                 if (fdt_lo)
>                         fdt =3D fdt_lo;
>                 if (!fdt) {
> -                       efi_load_distro_fdt(&fdt_distro, &fdt_size);
> +                       efi_load_distro_fdt(handle, &fdt_distro, &fdt_siz=
e);
>                         fdt =3D fdt_distro;
>                 }
>         }
> diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
> index 86ba00c2bdd..4ccf2055be3 100644
> --- a/lib/efi_loader/efi_fdt.c
> +++ b/lib/efi_loader/efi_fdt.c
> @@ -75,28 +75,34 @@ int efi_get_distro_fdt_name(char *fname, int size, in=
t seq)
>  /**
>   * efi_load_distro_fdt() - load distro device-tree
>   *
> + * @handle:    handle of loaded image
>   * @fdt:       on return device-tree, must be freed via efi_free_pages()
>   * @fdt_size:  buffer size
>   */
> -void efi_load_distro_fdt(void **fdt, efi_uintn_t *fdt_size)
> +void efi_load_distro_fdt(efi_handle_t handle, void **fdt, efi_uintn_t *f=
dt_size)
>  {
> -       struct efi_device_path *rem, *dp;
> +       struct efi_device_path *dp;
>         efi_status_t  ret;
> +       struct efi_handler *handler;
> +       struct efi_loaded_image *loaded_image;
>         efi_handle_t device;
>
>         *fdt =3D NULL;
>
> -       dp =3D efi_get_dp_from_boot(NULL);
> -       if (!dp)
> +       /* Get boot device from loaded image protocol */
> +       ret =3D efi_search_protocol(handle, &efi_guid_loaded_image, &hand=
ler);
> +       if (ret !=3D EFI_SUCCESS)
>                 return;
> -       device =3D efi_dp_find_obj(dp, NULL, &rem);
> -       ret =3D efi_search_protocol(device, &efi_simple_file_system_proto=
col_guid,
> -                                 NULL);
> +       loaded_image =3D handler->protocol_interface;
> +       device =3D loaded_image->device_handle;
> +
> +       /* Get device path of boot device */
> +       ret =3D efi_search_protocol(device, &efi_guid_device_path, &handl=
er);
>         if (ret !=3D EFI_SUCCESS)
> -               goto err;
> -       memcpy(rem, &END, sizeof(END));
> +               return;
> +       dp =3D handler->protocol_interface;
>
> -       /* try the various available names */
> +       /* Try the various available names */
>         for (int seq =3D 0; ; ++seq) {
>                 struct efi_device_path *file;
>                 char buf[255];
> @@ -108,10 +114,9 @@ void efi_load_distro_fdt(void **fdt, efi_uintn_t *fd=
t_size)
>                         break;
>                 ret =3D efi_load_image_from_path(true, file, fdt, fdt_siz=
e);
>                 efi_free_pool(file);
> -               if (ret =3D=3D EFI_SUCCESS)
> +               if (ret =3D=3D EFI_SUCCESS) {
> +                       log_debug("Fdt %pD loaded\n", file);
>                         break;
> +               }
>         }
> -
> -err:
> -       efi_free_pool(dp);
>  }
> --
> 2.45.2
>

Tested-by: E Shattow <lucent@gmail.com>
