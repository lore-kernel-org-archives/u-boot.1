Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4011C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 12:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7563C883FA;
	Tue, 16 Apr 2024 14:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KypEmKmG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08ACD88403; Tue, 16 Apr 2024 14:58:37 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D88F5883F0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 14:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-47a0f54fb13so1364531137.1
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713272312; x=1713877112; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brbLgQweijN2j9YWzvBAFalPyGBdbchrsfvdLn2b7Rs=;
 b=KypEmKmGRvZdAZlyjRPQ0W65z9erq/FgfL4iOM29/R9rUhUJVTgV9mwBEDpSOm3/SR
 rojTbeo8oJXOTwZfKLD44zseg/Mac4KToRu9wFIg/jWwJBp4NBq290f1nJ86Ed7ps2W+
 cTc56dtGELWGKl/wslnlJSAmoTxQgHRqCpPrEN4QNuRRx+JwKvd74Dhmr0meF6vHhGEO
 kQTU0wLcFk0vavfZFDg7EVo492qlBNQzh/pNeLbaJKDH1F3K5/OeHP5tO59+I0lT1QGL
 oGVRGfkjjXUzZ3L7RfiUdmrIeNLQbEWZ3fLOQptFWufOpNQc8e3KH9DyH/vrlpGDuZGs
 IrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713272312; x=1713877112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=brbLgQweijN2j9YWzvBAFalPyGBdbchrsfvdLn2b7Rs=;
 b=Zhe6BDBCk0jE/RiiRh41rwG89tHXBtWuObF649Q7e1pLR2GaP8bRScdcXFMRNZ/BGm
 F+OeGABSF2EvHuPNVaxxLn1A9pEs9ryfkQ5g5buwxcqb/58KIoJ265O5frW35/4ZAIcz
 xZq06Rf6e0fEi3z/l81rotx5arWn0ZqmhVBMhejCmov96t5zwuz4CybJwnUkQlt6bDIH
 IKcy31H01fYltBw1iCp1xh/43j7ORi1dGxTf3QFBUtrN/XRgvVEvKM7UinLtdDkfhHGN
 Jc93W1aqKUZ3gIaM4XAXqzrMWTaN1zNNVH40uq/e9ccnOazDe3aGaZRqK7VaIWW2U5MJ
 y+Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7AshwS0O2dtwdNmCanZjqm2OSVVbgpyvk1AVen6THqjg0InWIGrka2HVmSYQS+7BsV/QBPvtb/zfdqCcb871+VjAf9A==
X-Gm-Message-State: AOJu0YxQMFZ9ROFfSSuvrBzm0ooUXt+5wAQM70XUI9z8iwtV/O+R9B97
 AmueojtsE+F8WyctKbZWwxVBTyYE7kvTAwcJShFdjpFLf0Tc7/4gzmxBYpx3TpL9DRPY1oBLONj
 2bzi03TbtLDtTAjkOviq69QafBhQ=
X-Google-Smtp-Source: AGHT+IEJ6ahR7pBf/D8pzP8/7o1X4K33v2qxeZaDJ2ukFeQcnxwH83+JasHnf0nApltrIil8xsisf7VLEN7k8nbWROQ=
X-Received: by 2002:a05:6102:1589:b0:473:1582:ee9f with SMTP id
 g9-20020a056102158900b004731582ee9fmr16312041vsv.33.1713272311717; Tue, 16
 Apr 2024 05:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
 <20240415115035.46199-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240415115035.46199-3-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Tue, 16 Apr 2024 05:58:20 -0700
Message-ID: <CANV2PTN4hfM7YhJUF=Tqp32-DQK-Lxm5HGi8PEZqUTumUe5h=w@mail.gmail.com>
Subject: Re: [PATCH 2/4] board: add support for Milk-V Mars CM
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Shengyu Qu <wiagn233@outlook.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, u-boot@lists.denx.de
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

On Mon, Apr 15, 2024 at 4:50=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We already support the VisionFive 2 and the Milk-V Mars board by
> patching the VisionFive 2 device tree. With this patch the same
> is done for the Milk-V Mars CM.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  board/starfive/visionfive2/spl.c              | 27 ++++++++++++++++++-
>  .../visionfive2/starfive_visionfive2.c        | 11 +++++++-
>  2 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive=
2/spl.c
> index 45848db6d8b..bb0f28d7aad 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -129,6 +129,29 @@ void spl_fdt_fixup_mars(void *fdt)
>         }
>  }
>
> +void spl_fdt_fixup_marc(void *fdt)
> +{
> +       const char *compat;
> +       const char *model;
> +
> +       spl_fdt_fixup_mars(fdt);
> +
> +       if (!get_mmc_size_from_eeprom()) {
> +               int offset;
> +
> +               model =3D "Milk-V Mars CM SDCard";
> +               compat =3D "milkv,mars-cm-sdcard\0starfive,jh7110";
> +
> +               offset =3D fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins/m=
mc0-pins-rest");
> +               fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);

Note this is:

- pinmux =3D <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
+ pinmux =3D <GPIOMUX(22, GPOUT_SYS_SDIO0_RST,

As in the vendor code repo for Mars CM Lite branch:

https://github.com/milkv-mars/mars-buildroot-sdk/commit/880a249518f72ecf1e2=
947dfeb2c66e5035fce90

But the GPIOMUX macro here (for code readability) would bring in
another header to include. Add a comment of what the magic number is
for.

Does anyone have a better explanation of why this is needed than the
vendor "u-boot: configure sdio0 as mars-cm sdcard version" commit
message?

> +       } else {
> +               model =3D "Milk-V Mars CM eMMC";
> +               compat =3D "milkv,mars-cm-emmc\0starfive,jh7110";
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
> @@ -236,7 +259,9 @@ void spl_perform_fixups(struct spl_image_info *spl_im=
age)
>                 pr_err("Can't read EEPROM\n");
>                 return;
>         }
> -       if (!strncmp(product_id, "MARS", 4)) {
> +       if (!strncmp(product_id, "MARC", 4)) {
> +               spl_fdt_fixup_marc(spl_image->fdt_addr);
> +       } else if (!strncmp(product_id, "MARS", 4)) {
>                 spl_fdt_fixup_mars(spl_image->fdt_addr);
>         } else if (!strncmp(product_id, "VF7110", 6)) {
>                 version =3D get_pcb_revision_from_eeprom();
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/st=
arfive/visionfive2/starfive_visionfive2.c
> index a86bca533b2..be6ca85b030 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -17,6 +17,10 @@
>  DECLARE_GLOBAL_DATA_PTR;
>  #define JH7110_L2_PREFETCHER_BASE_ADDR         0x2030000
>  #define JH7110_L2_PREFETCHER_HART_OFFSET       0x2000
> +#define FDTFILE_MILK_V_MARC_SD \
> +       "starfive/jh7110-milkv-mars-cm-sdcard.dtb"
> +#define FDTFILE_MILK_V_MARC_MMC \
> +       "starfive/jh7110-milkv-mars-cm-emmc.dtb"
>  #define FDTFILE_MILK_V_MARS \
>         "starfive/jh7110-milkv-mars.dtb"
>  #define FDTFILE_VISIONFIVE2_1_2A \
> @@ -61,7 +65,12 @@ static void set_fdtfile(void)
>                 log_err("Can't read EEPROM\n");
>                 return;
>         }
> -       if (!strncmp(product_id, "MARS", 4)) {
> +       if (!strncmp(product_id, "MARC", 4)) {
> +               if (get_mmc_size_from_eeprom())
> +                       fdtfile =3D FDTFILE_MILK_V_MARC_MMC;
> +               else
> +                       fdtfile =3D FDTFILE_MILK_V_MARC_SD;
> +       } else if (!strncmp(product_id, "MARS", 4)) {
>                 fdtfile =3D FDTFILE_MILK_V_MARS;
>         } else if (!strncmp(product_id, "VF7110", 6)) {
>                 version =3D get_pcb_revision_from_eeprom();
> --
> 2.43.0
>
