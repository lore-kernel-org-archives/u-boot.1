Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD1DC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 21:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BF668823A;
	Fri,  3 May 2024 23:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kjbLW5pm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAD8F88250; Fri,  3 May 2024 23:50:20 +0200 (CEST)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94DEA88047
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 23:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4dcd913311eso84648e0c.2
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 14:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714773017; x=1715377817; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/w/EDFoNGqrT1RAQHmpEkOXrtbmJcb/0a1hTpls5Q8=;
 b=kjbLW5pmTyp7YjJgL0i0xzEd5JkGW9D62qqsxuMhNX+ebGWg+o7NF+G5UuKaF+Rw2q
 lQpxAqqShv3RCr4FQnDrFNR9Y1UdhILtcRkvzHNJEFE2ZGVDLAo19sgIgoE/mp50pxz7
 9sjFzm1ABYzqDU9HU80O3O6bghQIzxhx0KWVdPdZKSuMtKCgvZDnewvAgk7BztsOPYA1
 QB8HyMT25hEuUCOgtznlfdHwazZQsmxCapemxs7yeLGwh7lOmWIb/1gJY3xrs1qvZVrz
 oN1+4uhceIY2SISNVScRE8XK5Iwqk5e7agnAYL5LvBFbA6uirkk1wfUOCFbGaZWA9ko5
 mb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714773017; x=1715377817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/w/EDFoNGqrT1RAQHmpEkOXrtbmJcb/0a1hTpls5Q8=;
 b=YfhT2LIIXY3PZCiezMhXxQZ7K2z3HFAbvWMB0p1VyG6EtDkfWVXpmnFHi7BprS6bno
 Q6F2vhlcjW6T1E6uOJ1ZUpj5alyauQGWA6z97V/xo0kcVpu9lCNtVGVt+KYEt0OnxDi0
 rqAFj76hMsN0mUJe2tNFSZKDPj4LIj0/SCYpp6TyAZz/vrPE7M775gd99p2dGAA03sPo
 QP/TeiOrbMt5zu+wFMOL84kivadTjEbC19TXJlAZ0am0HRHbNrKG6D9nSyLDsfxvGasD
 4zuchNOpzpLR2CkQgXar3XZERKwYKCxyWYa9Fm/XlSbEfsPt4mAOm/ZtGSefcqbzaC1+
 UE6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM6y3HMNh2w8OA2fHqsm7Oxyb1pMyrdOFLuCMXkURR9BYpvu1CyK/BcuUCqhQKpLguysl+fKqGKGZcfSkgX8Qu0rPGGA==
X-Gm-Message-State: AOJu0Yw2GASnuYD3tWkMgNupiNolUJEIScW+ObiJHbbhaqAzmlapbGDj
 NQYiFjWxxcB+Mw+4k8pG/AMVHEhWSkvSQ21BxqdkYSiDemRCKbUexeEeu6qFiMQQ9GAB55WR9Wj
 Xt03tOUPb5/s9Glad8ltvw5KvIy4=
X-Google-Smtp-Source: AGHT+IFH+Hos/bvmeA03YgGxeUcBmlFPfKi+HncIk8NyXzwf4hREyUo2rCeeziq52K/gVmWJlFvsG4pQLueg2vPKE8Y=
X-Received: by 2002:a05:6122:32cc:b0:4d4:1cb7:f57a with SMTP id
 ck12-20020a05612232cc00b004d41cb7f57amr4268861vkb.9.1714773017380; Fri, 03
 May 2024 14:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240503090011.37849-1-heinrich.schuchardt@canonical.com>
 <20240503090011.37849-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240503090011.37849-3-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Fri, 3 May 2024 14:50:06 -0700
Message-ID: <CANV2PTOU=LtOK2_R=VMVbDoVc5i6fJvyrEN54ZrwGa-QEiwDYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] board: add support for Milk-V Mars CM
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Shiji Yang <yangshiji66@outlook.com>,
 Shengyu Qu <wiagn233@outlook.com>, Michal Simek <michal.simek@amd.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, Mason Huo <mason.huo@starfivetech.com>,
 u-boot@lists.denx.de
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

On Fri, May 3, 2024 at 2:00=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We already support the VisionFive 2 and the Milk-V Mars board by
> patching the VisionFive 2 device tree. With this patch the same
> is done for the Milk-V Mars CM.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         rename spl_fdt_fixup_marc() to spl_fdt_fixup_mars_cm()
>         rename device-trees for Mars CM and Mars CM Lite
>         change model and compatible properties
> ---
>  board/starfive/visionfive2/spl.c              | 28 ++++++++++++++++++-
>  .../visionfive2/starfive_visionfive2.c        | 11 +++++++-
>  2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive=
2/spl.c
> index ca61b5be227..b555189556a 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -129,6 +129,30 @@ void spl_fdt_fixup_mars(void *fdt)
>         }
>  }
>
> +void spl_fdt_fixup_mars_cm(void *fdt)
> +{
> +       const char *compat;
> +       const char *model;
> +
> +       spl_fdt_fixup_mars(fdt);
> +
> +       if (!get_mmc_size_from_eeprom()) {
> +               int offset;
> +
> +               model =3D "Milk-V Mars CM Lite";
> +               compat =3D "milkv,mars-cm-lite\0starfive,jh7110";
> +
> +               offset =3D fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins/m=
mc0-pins-rest");
> +               /* GPIOMUX(22, GPOUT_SYS_SDIO0_RST, GPOEN_ENABLE, GPI_NON=
E) */
> +               fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
> +       } else {
> +               model =3D "Milk-V Mars CM";
> +               compat =3D "milkv,mars-cm\0starfive,jh7110";
> +       }
> +       fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat,=
 sizeof(compat));
> +       fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model=
);
> +}
> +
>  void spl_fdt_fixup_version_a(void *fdt)
>  {
>         static const char compat[] =3D "starfive,visionfive-2-v1.2a\0star=
five,jh7110";
> @@ -236,7 +260,9 @@ void spl_perform_fixups(struct spl_image_info *spl_im=
age)
>                 pr_err("Can't read EEPROM\n");
>                 return;
>         }
> -       if (!strncmp(product_id, "MARS", 4)) {
> +       if (!strncmp(product_id, "MARC", 4)) {
> +               spl_fdt_fixup_mars_cm(spl_image->fdt_addr);
> +       } else if (!strncmp(product_id, "MARS", 4)) {
>                 spl_fdt_fixup_mars(spl_image->fdt_addr);
>         } else if (!strncmp(product_id, "VF7110", 6)) {
>                 version =3D get_pcb_revision_from_eeprom();
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/st=
arfive/visionfive2/starfive_visionfive2.c
> index a86bca533b2..6be53489626 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -19,6 +19,10 @@ DECLARE_GLOBAL_DATA_PTR;
>  #define JH7110_L2_PREFETCHER_HART_OFFSET       0x2000
>  #define FDTFILE_MILK_V_MARS \
>         "starfive/jh7110-milkv-mars.dtb"
> +#define FDTFILE_MILK_V_MARS_CM \
> +       "starfive/jh7110-milkv-mars-cm.dtb"
> +#define FDTFILE_MILK_V_MARS_CM_LITE \
> +       "starfive/jh7110-milkv-mars-cm-lite.dtb"
>  #define FDTFILE_VISIONFIVE2_1_2A \
>         "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
>  #define FDTFILE_VISIONFIVE2_1_3B \
> @@ -61,7 +65,12 @@ static void set_fdtfile(void)
>                 log_err("Can't read EEPROM\n");
>                 return;
>         }
> -       if (!strncmp(product_id, "MARS", 4)) {
> +       if (!strncmp(product_id, "MARC", 4)) {
> +               if (get_mmc_size_from_eeprom())
> +                       fdtfile =3D FDTFILE_MILK_V_MARS_CM;
> +               else
> +                       fdtfile =3D FDTFILE_MILK_V_MARS_CM_LITE;
> +       } else if (!strncmp(product_id, "MARS", 4)) {
>                 fdtfile =3D FDTFILE_MILK_V_MARS;
>         } else if (!strncmp(product_id, "VF7110", 6)) {
>                 version =3D get_pcb_revision_from_eeprom();
> --
> 2.43.0
>

on Mars CM Lite and DFRobot mini router carrier

Tested-by: E. Shattow <lucent@gmail.com>
Reviewed-by: E. Shattow <lucent@gmail.com>
