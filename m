Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FA1C25B74
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 18:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E701488011;
	Fri, 10 May 2024 20:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V0FiTwxt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC6A288025; Fri, 10 May 2024 20:17:35 +0200 (CEST)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FCE28800D
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 20:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7f944fd870dso784341241.0
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715365052; x=1715969852; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DyirDTC7sLB5e+ON2kI8NEZMhOIhClnPVY2bYvG9EdU=;
 b=V0FiTwxtEWlNBBlo4mmLHulAAxXo65eydfext9fom1ypmkoquzM3XYGv8FC6iTV21E
 6PpinhCjp9tkzyjmaSnf4dJBNJRIHTKv5Uhvymo1ZEeNW1h6XStVNcMctvIXOCI+gPu4
 2+NmIyd2UbQQqbk8i+Zhp43RJXmqgLLoP83ANxVNQFNmp7CVgS+/qXPrqPooL+JVIDo9
 9f+7ozekSQdLKXyUl2l3ff8HWhFopmhiEQtvbLPMALmU/Pxapvr9P20QVZ7qduaY49FZ
 8RNbpAiy+ABwib3sErqHrC6yB+vCtjqg+68i0NEdwbJrqYSF2OVhR2h0vFSJMcDOSCsP
 zy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715365052; x=1715969852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DyirDTC7sLB5e+ON2kI8NEZMhOIhClnPVY2bYvG9EdU=;
 b=jlNx/4zPNmr50jWJglv7vOle1nmmqm+O24iQSX3BUG8OilrwbHdhv7IF7PcPtIvmIQ
 QvZI3ux8S205dhyFZ78F8mY/op9PU+dJTCMXYNNUEsezGF55ggv9ladG7BaFqf01ka5f
 P5US/relw2m0jp1XyAyKZsQwmEJChu5OethOYF3SGAMcJFGThhhwG4TgvogxgJja/V2m
 K3txd3cnQUfohEyd4b2PHWR4eM3mCWL/krAvU5T5oIwfSw9jN4cngXxLyPXLbSitVCfp
 0JhFwW+B0FCXK7lyX33PIlcJkPGm+9J+mRKmw1wRmYk5K9LEOHM1OYCr6dgw6pJjnH8q
 FRqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkhjfXNiF9lpaXrILIMsJV85i50xGRj15UgVar17poFzWxGsxm4/CU4BpU/PEfe4Aq2Xb6x+vgRoZuWXIhEWq71Hg1tw==
X-Gm-Message-State: AOJu0YwMhp+UcShkOLmoOyZQT5mqEM4dAlautF00HIPIaZfmhJrKHjQa
 BYsjBzjfW0TwIkW/Ye8gx8C7YRyfwpJ7KhECOH85Euo+JdWnzj55tzHUiqVygaLV4/cwEcoDK72
 ak5RIqfwyorDy1iVc5emwliupBKA=
X-Google-Smtp-Source: AGHT+IESRtPtPJwyKMHFERzGWl5EPT++ylI9HsD9AUYyn/uBMQLcfk8Z7e+12bqP0QQaMXN9WlNrPpfW5DNplRvqGic=
X-Received: by 2002:a1f:f802:0:b0:4d5:f28b:2c2c with SMTP id
 71dfb90a1353d-4df790952f4mr5553462e0c.3.1715365052268; Fri, 10 May 2024
 11:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240510055223.11617-1-heinrich.schuchardt@canonical.com>
 <20240510055223.11617-3-heinrich.schuchardt@canonical.com>
 <TY3P286MB2611F8A85713E2ADEF0F918998E72@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <TY3P286MB26110C989B2D8ED02042E9D798E72@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TY3P286MB26110C989B2D8ED02042E9D798E72@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
From: E Shattow <lucent@gmail.com>
Date: Fri, 10 May 2024 11:17:20 -0700
Message-ID: <CANV2PTN_-_Hh64X4RZO6yLuYCK5Korpt50CE0BzGfJfOWQb_NA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] board: add support for Milk-V Mars CM
To: Shengyu Qu <wiagn233@outlook.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, Hal Feng <hal.feng@starfivetech.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Shiji Yang <yangshiji66@outlook.com>,
 Michal Simek <michal.simek@amd.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Mason Huo <mason.huo@starfivetech.com>, u-boot@lists.denx.de
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

Hi Shengyu,

On Fri, May 10, 2024 at 8:39=E2=80=AFAM Shengyu Qu <wiagn233@outlook.com> w=
rote:
>
> Sorry, seems this is a false warning as fdt_fixup_ethernet() would do thi=
s.
>
> Best regards
>

If you need to set a network mac address in U-Boot for an extra
network port (i.e. PCIe attached) this may be:

env set eth2addr aa:bb:cc:dd:ee:ff
env save

In this example ethaddr is gmac0 from JH7110 CPU via the RPi CM4
connector, and eth1addr is gmac1 from JH7110 CPU but is not accessible
on the RPi CM4 connector so disabled by the fdt fixup. The second
network port on DFRobot mini router is a realtek rtl8168 on the PCIe
bus, so it does not have any mac address. This is how I set its mac
address from U-Boot.

I'm not sure if this needs to be said in the documentation. It is
extra information that may be helpful but we are not documenting here
all the possible carrier boards that can be attached.

-E

> =E5=9C=A8 2024/5/10 23:01, Shengyu Qu =E5=86=99=E9=81=93:
> > Btw I didn't have a code path to pass the MAC address to kernel. So doe=
s
> > it actually exist?
> >
> > Best regards,
> > Shengyu
> >
> > =E5=9C=A8 2024/5/10 13:52, Heinrich Schuchardt =E5=86=99=E9=81=93:
> >> We already support the VisionFive 2 and the Milk-V Mars board by
> >> patching the VisionFive 2 device tree. With this patch the same
> >> is done for the Milk-V Mars CM.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> Tested-by: E. Shattow <lucent@gmail.com>
> >> Reviewed-by: E. Shattow <lucent@gmail.com>
> >> ---
> >> v4:
> >>     no change
> >> v3:
> >>     no change
> >> v2:
> >>     rename spl_fdt_fixup_marc() to spl_fdt_fixup_mars_cm()
> >>     rename device-trees for Mars CM and Mars CM Lite
> >>     change model and compatible properties
> >> ---
> >>   board/starfive/visionfive2/spl.c              | 28 +++++++++++++++++=
+-
> >>   .../visionfive2/starfive_visionfive2.c        | 11 +++++++-
> >>   2 files changed, 37 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/board/starfive/visionfive2/spl.c
> >> b/board/starfive/visionfive2/spl.c
> >> index ca61b5be227..b555189556a 100644
> >> --- a/board/starfive/visionfive2/spl.c
> >> +++ b/board/starfive/visionfive2/spl.c
> >> @@ -129,6 +129,30 @@ void spl_fdt_fixup_mars(void *fdt)
> >>       }
> >>   }
> >> +void spl_fdt_fixup_mars_cm(void *fdt)
> >> +{
> >> +    const char *compat;
> >> +    const char *model;
> >> +
> >> +    spl_fdt_fixup_mars(fdt);
> >> +
> >> +    if (!get_mmc_size_from_eeprom()) {
> >> +        int offset;
> >> +
> >> +        model =3D "Milk-V Mars CM Lite";
> >> +        compat =3D "milkv,mars-cm-lite\0starfive,jh7110";
> >> +
> >> +        offset =3D fdt_path_offset(fdt,
> >> "/soc/pinctrl/mmc0-pins/mmc0-pins-rest");
> >> +        /* GPIOMUX(22, GPOUT_SYS_SDIO0_RST, GPOEN_ENABLE, GPI_NONE) *=
/
> >> +        fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
> >> +    } else {
> >> +        model =3D "Milk-V Mars CM";
> >> +        compat =3D "milkv,mars-cm\0starfive,jh7110";
> >> +    }
> >> +    fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat,
> >> sizeof(compat));
> >> +    fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model=
);
> >> +}
> >> +
> >>   void spl_fdt_fixup_version_a(void *fdt)
> >>   {
> >>       static const char compat[] =3D
> >> "starfive,visionfive-2-v1.2a\0starfive,jh7110";
> >> @@ -236,7 +260,9 @@ void spl_perform_fixups(struct spl_image_info
> >> *spl_image)
> >>           pr_err("Can't read EEPROM\n");
> >>           return;
> >>       }
> >> -    if (!strncmp(product_id, "MARS", 4)) {
> >> +    if (!strncmp(product_id, "MARC", 4)) {
> >> +        spl_fdt_fixup_mars_cm(spl_image->fdt_addr);
> >> +    } else if (!strncmp(product_id, "MARS", 4)) {
> >>           spl_fdt_fixup_mars(spl_image->fdt_addr);
> >>       } else if (!strncmp(product_id, "VF7110", 6)) {
> >>           version =3D get_pcb_revision_from_eeprom();
> >> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c
> >> b/board/starfive/visionfive2/starfive_visionfive2.c
> >> index a86bca533b2..6be53489626 100644
> >> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> >> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> >> @@ -19,6 +19,10 @@ DECLARE_GLOBAL_DATA_PTR;
> >>   #define JH7110_L2_PREFETCHER_HART_OFFSET    0x2000
> >>   #define FDTFILE_MILK_V_MARS \
> >>       "starfive/jh7110-milkv-mars.dtb"
> >> +#define FDTFILE_MILK_V_MARS_CM \
> >> +    "starfive/jh7110-milkv-mars-cm.dtb"
> >> +#define FDTFILE_MILK_V_MARS_CM_LITE \
> >> +    "starfive/jh7110-milkv-mars-cm-lite.dtb"
> >>   #define FDTFILE_VISIONFIVE2_1_2A \
> >>       "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
> >>   #define FDTFILE_VISIONFIVE2_1_3B \
> >> @@ -61,7 +65,12 @@ static void set_fdtfile(void)
> >>           log_err("Can't read EEPROM\n");
> >>           return;
> >>       }
> >> -    if (!strncmp(product_id, "MARS", 4)) {
> >> +    if (!strncmp(product_id, "MARC", 4)) {
> >> +        if (get_mmc_size_from_eeprom())
> >> +            fdtfile =3D FDTFILE_MILK_V_MARS_CM;
> >> +        else
> >> +            fdtfile =3D FDTFILE_MILK_V_MARS_CM_LITE;
> >> +    } else if (!strncmp(product_id, "MARS", 4)) {
> >>           fdtfile =3D FDTFILE_MILK_V_MARS;
> >>       } else if (!strncmp(product_id, "VF7110", 6)) {
> >>           version =3D get_pcb_revision_from_eeprom();
