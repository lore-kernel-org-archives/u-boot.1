Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEC1105A58D
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 12:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 032A584167;
	Thu, 12 Mar 2026 13:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xwh7YP84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A68BE8418C; Thu, 12 Mar 2026 13:08:27 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A360984121
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 13:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b96d784828bso130958666b.3
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 05:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773317305; cv=none;
 d=google.com; s=arc-20240605;
 b=X7CbdzgQIHu4FJZ4/SIpmszkg9DbwznSmsdcLvPiQWyZgYRQpT0ZZv8Ds7fRnw8bC5
 KSz6PdFl3+LYjKXDnklBiFjP9Eoo6mc/r5klXRnsi6zMq11HGufmLHRr8D7/ikHdCoNy
 JAvKMuzXqIeSmbSF63D26pojf7nLEwXq4lrvY5ukQ+8l5exNiCdZdkdz3jgm/S3UI2JE
 MSp1Tqe8fUZtLbU3N6KVa3J3TnbCE1zcQLAaZE6QC7di6UsaAE5CwmanK5ei81T1Ksmb
 /DbWK2poJR+13IM5e45L+TduyuLgI//Qzsa6N34926OlbqF80Dw7BBoksJ38VHB6xrh9
 0i0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/1mSCtU1nRWxQYTwNb/vJP8hI0YexbN0AQ9I7tvveZ8=;
 fh=lEnt6i2qrjwBbaSCkrdTcOSYGh/b1tw639piUMO096Y=;
 b=LXBAiejv9Gnk2p9w/ks931m9QkkCdo3vv9D1eiJz+7cAUH/KKphRlFjpYnUdfenHr8
 r3GDQazzdw/D4newnx4q4UoaZ6xvIOu78zm4YpmBM/YU0pgyuD3ZW9wCdKn22lVExhRh
 xSSAxSId6DYtYxzgDA5ox1gu7z26SnJUGOY5ikYdi5SVffWWaSqXEHYG4t/t8/Qi7IoB
 ytoUEP5SQv3ELiISEx7e1nv+p4TSo96H7tC26gNrRFzeGuU4vts3CdwSgMlgiSLbv1m3
 szVicmLlj6iAai3wVF5Rp9Xf2yY3A5FPL+YwXroZbyvoan9ibsibMQHT3femrB3s4ZIM
 fIMQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773317305; x=1773922105; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/1mSCtU1nRWxQYTwNb/vJP8hI0YexbN0AQ9I7tvveZ8=;
 b=Xwh7YP84vsJozGaegrqsrDJkpYOnUgooZPrx5svXnmEZduN9mN/+pK7N3eBzZgKIh5
 Uu4PywFMq61RBq2sG6A3eg1hRbmWBPISOLVVmClPN5LWbeMHcoKAWpLZvPFeAPeWT0g4
 98NpNPjzv55nec8afLrEq1GW+w9DDwqR0DIIkRryuQhzCoVBBu2T4FYlXTwugdmWFcRP
 aCPE6Xin7bVFirnM+bAwdz9bhphi/iiD/0+QpCbGnLCiPjjOrrnHFBpazRnT3hev+YcV
 jVJJJBKJcan4VVs4O43ORHU7r60iy+kk9tQKp7t/2F8TaUGZZB43jR/6QbU90flKEz4T
 KuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773317305; x=1773922105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/1mSCtU1nRWxQYTwNb/vJP8hI0YexbN0AQ9I7tvveZ8=;
 b=Xwdgao714qU3r5dbJgMxuqukDtrRR9MzMSx1pvYyxWglKuytXNL16UqCbWqGhHhOZF
 oTp/xpCdPqEUxbxU2YHxvhIiCBXuzqHiVUmlfVv2rVQ54CbhX7UggxzyDVB4MSfIfIg/
 qnzoFcCW7jw3XkA2Y+ncvbExAIUw+nQIbXjgdVM86ADW1zLjB3ocTUAU12WcRmur/Et9
 VE6AZ+qC2m9Z+77qJzG6yL/cZl0VJHIwKwnpmPnYvBVZM0o9B0akazrU4qTRhnHhtXZU
 2NRwE2sJwLB/GTm4QRUhsZfvjhY5YOh1NILvHsDQ1ol88VGn5ND5rjVIDPWPUxCoynLq
 ZtiA==
X-Gm-Message-State: AOJu0YwnW0I6jpN4/31hk43D6KZkIGzVh4OJs/flk3JH/KULj/QBRf5n
 66T7vItjWE/VD7dgEAyviediNLO5HJt75F+h1jUsX4jXrkEp9/DwjD63OiVRnjZJID5c75mw+Nf
 BYSMNI8dUgw92qvEH+uTSXNKTRfDdv2r4uAAW
X-Gm-Gg: ATEYQzxCWas32qAcnPs56x7gN57xs9SEDqqS4/ud37QHvjqRIjIC7+x/FR12w6joz1O
 /GDtipVCawUAHja6Jnd5Edf3ZbkGqpa2QKta9ohMcIUbhXrxX5FTKbBQF7sUsTs2KFPav0EJqwv
 5DWCYYA/Ty7VKbpwRgvREW1OJczK3Rnkw2F3+yYRERj1f22jzDbBWHtnb7POXYUyhOwbfBGA9v3
 dZ2IAX3tep3SgppNeCwi90tfFfhGqjdlae4T4RPKtj85YAAeAIc4E8tRuEd4Ukl5tcmg00kpM3B
 Gu13kdlqiO7Q5m29H64OdDGBOvrMST3A0QuZHjQdYE7xWE9AEwp2N7mCWOctsAIjzSvYU+Mzoue
 AxQgw8EiqGyalM1Nldr4lRKHl64Pvwl17rgad7b7OB6FRhm5vAEt31CJQNGQ6nBuxq6cE38S9eu
 YjrkOc02LZeX0=
X-Received: by 2002:a17:907:701:b0:b94:2913:2d12 with SMTP id
 a640c23a62f3a-b972e1fb8a1mr348370466b.17.1773317304606; Thu, 12 Mar 2026
 05:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260216184452.18732-1-filip.kokosinski@gmail.com>
 <20260216184452.18732-2-filip.kokosinski@gmail.com>
In-Reply-To: <20260216184452.18732-2-filip.kokosinski@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 12 Mar 2026 12:08:13 +0000
X-Gm-Features: AaiRm50J_bNNm_Jzp4vkfAHTkwFhVtU8C0ao7BqEYIUtfrLPtumBkIbrRB5MnLQ
Message-ID: <CALeDE9NaHE3cWNP993TiVUVb6DgeJ7nRNawtepc-E_4qcgnvGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] board/raspberrypi: add multi-FDT support
To: =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com
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

On Mon, 16 Feb 2026 at 18:45, Filip Kokosi=C5=84ski
<filip.kokosinski@gmail.com> wrote:
>
> This patch adds support for multiple FDT files per board model. This is
> done by adding the FDTFILES macro, which initializes two rpi_model
> struct members: fdtfiles and fdtcount.
>
> The new-style revision codes designate LSB bits as board revision; this
> value is used to choose between provided FDTs. The first element of the
> fdtfiles list is used should no revision match.
>
> Signed-off-by: Filip Kokosi=C5=84ski <filip.kokosinski@gmail.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

> ---
>  board/raspberrypi/rpi/rpi.c | 93 +++++++++++++++++++++----------------
>  1 file changed, 52 insertions(+), 41 deletions(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index f9b643555dd..1b404b448f3 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -94,120 +94,125 @@ struct efi_capsule_update_info update_info =3D {
>   */
>  struct rpi_model {
>         const char *name;
> -       const char *fdtfile;
> +       const char * const *fdtfiles;
> +       size_t fdtcount;
>         bool has_onboard_eth;
>  };
>
> +#define FDTFILES(...) \
> +       (const char *[]){ __VA_ARGS__ }, \
> +       sizeof((const char *[]){ __VA_ARGS__ }) / sizeof(const char *)
> +
>  static const struct rpi_model rpi_model_unknown =3D {
>         "Unknown model",
> -       DTB_DIR "bcm283x-rpi-other.dtb",
> +       FDTFILES(DTB_DIR "bcm283x-rpi-other.dtb"),
>         false,
>  };
>
>  static const struct rpi_model rpi_models_new_scheme[] =3D {
>         [0x0] =3D {
>                 "Model A",
> -               DTB_DIR "bcm2835-rpi-a.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-a.dtb"),
>                 false,
>         },
>         [0x1] =3D {
>                 "Model B",
> -               DTB_DIR "bcm2835-rpi-b.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-b.dtb"),
>                 true,
>         },
>         [0x2] =3D {
>                 "Model A+",
> -               DTB_DIR "bcm2835-rpi-a-plus.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-a-plus.dtb"),
>                 false,
>         },
>         [0x3] =3D {
>                 "Model B+",
> -               DTB_DIR "bcm2835-rpi-b-plus.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-b-plus.dtb"),
>                 true,
>         },
>         [0x4] =3D {
>                 "2 Model B",
> -               DTB_DIR "bcm2836-rpi-2-b.dtb",
> +               FDTFILES(DTB_DIR "bcm2836-rpi-2-b.dtb"),
>                 true,
>         },
>         [0x6] =3D {
>                 "Compute Module",
> -               DTB_DIR "bcm2835-rpi-cm.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-cm.dtb"),
>                 false,
>         },
>         [0x8] =3D {
>                 "3 Model B",
> -               DTB_DIR "bcm2837-rpi-3-b.dtb",
> +               FDTFILES(DTB_DIR "bcm2837-rpi-3-b.dtb"),
>                 true,
>         },
>         [0x9] =3D {
>                 "Zero",
> -               DTB_DIR "bcm2835-rpi-zero.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-zero.dtb"),
>                 false,
>         },
>         [0xA] =3D {
>                 "Compute Module 3",
> -               DTB_DIR "bcm2837-rpi-cm3.dtb",
> +               FDTFILES(DTB_DIR "bcm2837-rpi-cm3.dtb"),
>                 false,
>         },
>         [0xC] =3D {
>                 "Zero W",
> -               DTB_DIR "bcm2835-rpi-zero-w.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-zero-w.dtb"),
>                 false,
>         },
>         [0xD] =3D {
>                 "3 Model B+",
> -               DTB_DIR "bcm2837-rpi-3-b-plus.dtb",
> +               FDTFILES(DTB_DIR "bcm2837-rpi-3-b-plus.dtb"),
>                 true,
>         },
>         [0xE] =3D {
>                 "3 Model A+",
> -               DTB_DIR "bcm2837-rpi-3-a-plus.dtb",
> +               FDTFILES(DTB_DIR "bcm2837-rpi-3-a-plus.dtb"),
>                 false,
>         },
>         [0x10] =3D {
>                 "Compute Module 3+",
> -               DTB_DIR "bcm2837-rpi-cm3.dtb",
> +               FDTFILES(DTB_DIR "bcm2837-rpi-cm3.dtb"),
>                 false,
>         },
>         [0x11] =3D {
>                 "4 Model B",
> -               DTB_DIR "bcm2711-rpi-4-b.dtb",
> +               FDTFILES(DTB_DIR "bcm2711-rpi-4-b.dtb"),
>                 true,
>         },
>         [0x12] =3D {
>                 "Zero 2 W",
> -               DTB_DIR "bcm2837-rpi-zero-2-w.dtb",
> +               FDTFILES(DTB_DIR "bcm2837-rpi-zero-2-w.dtb"),
>                 false,
>         },
>         [0x13] =3D {
>                 "400",
> -               DTB_DIR "bcm2711-rpi-400.dtb",
> +               FDTFILES(DTB_DIR "bcm2711-rpi-400.dtb"),
>                 true,
>         },
>         [0x14] =3D {
>                 "Compute Module 4",
> -               DTB_DIR "bcm2711-rpi-cm4.dtb",
> +               FDTFILES(DTB_DIR "bcm2711-rpi-cm4.dtb"),
>                 true,
>         },
>         [0x17] =3D {
>                 "5 Model B",
> -               DTB_DIR "bcm2712-rpi-5-b.dtb",
> +               FDTFILES(DTB_DIR "bcm2712-rpi-5-b.dtb"),
>                 true,
>         },
>         [0x18] =3D {
>                 "Compute Module 5",
> -               DTB_DIR "bcm2712-rpi-cm5-cm5io.dtb",
> +               FDTFILES(DTB_DIR "bcm2712-rpi-cm5-cm5io.dtb"),
>                 true,
>         },
>         [0x19] =3D {
>                 "500",
> -               DTB_DIR "bcm2712-rpi-500.dtb",
> +               FDTFILES(DTB_DIR "bcm2712-rpi-500.dtb"),
>                 true,
>         },
>         [0x1A] =3D {
>                 "Compute Module 5 Lite",
> -               DTB_DIR "bcm2712-rpi-cm5l-cm5io.dtb",
> +               FDTFILES(DTB_DIR "bcm2712-rpi-cm5l-cm5io.dtb"),
>                 true,
>         },
>  };
> @@ -215,87 +220,87 @@ static const struct rpi_model rpi_models_new_scheme=
[] =3D {
>  static const struct rpi_model rpi_models_old_scheme[] =3D {
>         [0x2] =3D {
>                 "Model B",
> -               DTB_DIR "bcm2835-rpi-b.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-b.dtb"),
>                 true,
>         },
>         [0x3] =3D {
>                 "Model B",
> -               DTB_DIR "bcm2835-rpi-b.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-b.dtb"),
>                 true,
>         },
>         [0x4] =3D {
>                 "Model B rev2",
> -               DTB_DIR "bcm2835-rpi-b-rev2.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-b-rev2.dtb"),
>                 true,
>         },
>         [0x5] =3D {
>                 "Model B rev2",
> -               DTB_DIR "bcm2835-rpi-b-rev2.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-b-rev2.dtb"),
>                 true,
>         },
>         [0x6] =3D {
>                 "Model B rev2",
> -               DTB_DIR "bcm2835-rpi-b-rev2.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-b-rev2.dtb"),
>                 true,
>         },
>         [0x7] =3D {
>                 "Model A",
> -               DTB_DIR "bcm2835-rpi-a.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-a.dtb"),
>                 false,
>         },
>         [0x8] =3D {
>                 "Model A",
> -               DTB_DIR "bcm2835-rpi-a.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-a.dtb"),
>                 false,
>         },
>         [0x9] =3D {
>                 "Model A",
> -               DTB_DIR "bcm2835-rpi-a.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-a.dtb"),
>                 false,
>         },
>         [0xd] =3D {
>                 "Model B rev2",
> -               DTB_DIR "bcm2835-rpi-b-rev2.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-b-rev2.dtb"),
>                 true,
>         },
>         [0xe] =3D {
>                 "Model B rev2",
> -               DTB_DIR "bcm2835-rpi-b-rev2.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-b-rev2.dtb"),
>                 true,
>         },
>         [0xf] =3D {
>                 "Model B rev2",
> -               DTB_DIR "bcm2835-rpi-b-rev2.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-b-rev2.dtb"),
>                 true,
>         },
>         [0x10] =3D {
>                 "Model B+",
> -               DTB_DIR "bcm2835-rpi-b-plus.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-b-plus.dtb"),
>                 true,
>         },
>         [0x11] =3D {
>                 "Compute Module",
> -               DTB_DIR "bcm2835-rpi-cm.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-cm.dtb"),
>                 false,
>         },
>         [0x12] =3D {
>                 "Model A+",
> -               DTB_DIR "bcm2835-rpi-a-plus.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-a-plus.dtb"),
>                 false,
>         },
>         [0x13] =3D {
>                 "Model B+",
> -               DTB_DIR "bcm2835-rpi-b-plus.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-b-plus.dtb"),
>                 true,
>         },
>         [0x14] =3D {
>                 "Compute Module",
> -               DTB_DIR "bcm2835-rpi-cm.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-cm.dtb"),
>                 false,
>         },
>         [0x15] =3D {
>                 "Model A+",
> -               DTB_DIR "bcm2835-rpi-a-plus.dtb",
> +               FDTFILES(DTB_DIR "bcm2835-rpi-a-plus.dtb"),
>                 false,
>         },
>  };
> @@ -361,11 +366,17 @@ int dram_init_banksize(void)
>  static void set_fdtfile(void)
>  {
>         const char *fdtfile;
> +       int rev =3D revision & 0x0f;
>
>         if (env_get("fdtfile"))
>                 return;
>
> -       fdtfile =3D model->fdtfile;
> +       /* set the first entry as default */
> +       fdtfile =3D model->fdtfiles[0];
> +
> +       if (rev < model->fdtcount)
> +               fdtfile =3D model->fdtfiles[rev];
> +
>         env_set("fdtfile", fdtfile);
>  }
>
> --
> 2.51.2
>
