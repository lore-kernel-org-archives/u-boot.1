Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F85C25B4F
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 00:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9811788124;
	Mon, 13 May 2024 02:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KSswtusw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB99087F68; Mon, 13 May 2024 02:02:12 +0200 (CEST)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3952F87D5F
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 02:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4df32efa5baso1146735e0c.2
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715558529; x=1716163329; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0EwvjRCgfz1jcNHqysEiBylSm3qeuUxw/X97wNxAGE=;
 b=KSswtuswLQX8lD72EkSFtLVOvvxqCXnraDhO9qXVtezRA2Pd498FnE5DFZQ803AMVC
 1uG4B/Diqg4h94E9KzwhwzviNf+Yvyn+SBhy8IDMFfikXXZgG+cPLSN+qBKd4LTr4T/l
 IJp41LEfEbsN3xvRDYmN/qYrIhuWM0cEJbpoF7PGHGqgvd5tDVhmtHRmejMUQFM9qj8h
 /fffpwOrkfArQpD60vGk7cOpCi9Btxzb+i0pQHTTWrxuvg5j/xlPOorfwJBEEJuK6ep7
 g5DKSGoH1pfXvHi4D2IyFx54fxEY+Fe3AWu+noPmmXmIq65jILHSkoxx18kwaL9cXAXb
 vcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715558529; x=1716163329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n0EwvjRCgfz1jcNHqysEiBylSm3qeuUxw/X97wNxAGE=;
 b=DsfmgoHI7GOhInnjtXb6VdhrK7Qd8oQM1LM8OrMd5iEJTISiyf05+jSLNyJIctkAEV
 K7FaQEJGYS1doeGVhUFigWMd8QygahPQUcZc1LGXVgTCDXI8QyDlVFskkgqo9x8dPk6b
 9q5BU81I17kMhSf+f/kK/gQuCL069IhnWULuelZfq0hDH9HK/jyI0rw7b5VmEeDY1e09
 oPCO6l35DhWuruZhTMC0dlGUXTAK3ToRZzLlbpA4iIrzwjDWv7EoPdDka26tmG7jtzJe
 oKDGI0rmZBe4MzDnOjs7iE8RIC66nBHu4aFXEGPK2G6p4s2IHuZ5wFNDy4nBip5yYzDH
 DGZw==
X-Gm-Message-State: AOJu0YxQKulr9YXqRW9DE11eZJhRtpu8QMCawinRNKA10qS2wqvhIyq4
 MZcAln8WWskC9wDQhahwxeU9cjgPK1cdVRUUBAcoZnEnVVuPEAYMrQYTuV91UbSKrF5yD+BOKsf
 RhXUMhxAD5jMqbelgxalxnOCMMhDAFLVj
X-Google-Smtp-Source: AGHT+IEy6UAPzKQnfuev6tNFgqgLD5t1LvTWgM2Nubl1+aUYdL7rAZtAEhs9NvGK1Biu6GeOzSgO1/8BitmjDZxqqCA=
X-Received: by 2002:a05:6122:2a51:b0:4d8:75ca:8cbe with SMTP id
 71dfb90a1353d-4df8839a7cemr5433076e0c.16.1715558529043; Sun, 12 May 2024
 17:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <2Wf_X25fjiTRU7BZzFK3Mxj8Bgte4ggnq0BjYcxn2AR0FFfZi0jwedw-hokUad4ow2wxy6lhNW5gC0CEVbeCNo_qq1CM74FBrwlopiFYcp0=@protonmail.com>
 <CANV2PTO7vx-PvvC60uRDKKkAMM0_wWwy69go9KghkHNWpPhqUA@mail.gmail.com>
In-Reply-To: <CANV2PTO7vx-PvvC60uRDKKkAMM0_wWwy69go9KghkHNWpPhqUA@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Sun, 12 May 2024 17:01:58 -0700
Message-ID: <CANV2PTMmPyhF3H+Rr878siBvVko8gAvptDFYXSKnaccRXVOejg@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] board: starfive: support Pine64 Star64 board
To: H Bell <dmoo_dv@protonmail.com>
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

P.S. some typo in my last message.

On Sun, May 12, 2024 at 4:57=E2=80=AFPM E Shattow <lucent@gmail.com> wrote:
>
> Off-list we reasoned further about the correct PHY values.
>
> As our reference was the pre-loaded SPI NOR content containing dtb data:
>
> ethernet@16030000 {
> ...
>     ethernet-phy@0 {
>         rxc_dly_en =3D <0x01>;
>         tx_delay_sel_fe =3D <0x05>;
>         tx_delay_sel =3D <0x0a>;
>         tx_inverted_10 =3D <0x01>;
>         tx_inverted_100 =3D <0x01>;
>         tx_inverted_1000 =3D <0x01>;
>         phandle =3D <0x54>;
>     };
> ...
> ethernet@16040000 {
> ...
>     ethernet-phy@1 {
>         tx_delay_sel_fe =3D <0x05>;
>         tx_delay_sel =3D <0x00>;
>         rxc_dly_en =3D <0x00>;
>         tx_inverted_10 =3D <0x01>;
>         tx_inverted_100 =3D <0x01>;
>         tx_inverted_1000 =3D <0x00>;
>         phandle =3D <0x56>;
>     };
>
>
> This is identical to ethernet-phy@0 and ethernet-phy@1 sections in
> Linux-riscv series 705018 "Add Ethernet driver for StarFive JH7110 SoC":
>
> https://patchwork.kernel.org/project/linux-riscv/patch/20221216070632.114=
44-10-yanhong.wang@starfivetech.com/
>
> Defaults are assumed to be from that version of the motorcomm driver.
> More recent versions
> of the driver deprecate setting the Fast Ethernet TX delay
> tx_delay_sel_fe and instead is this
> comment in the source code:
> "Generally, it is not necessary to adjust YT8531_RC1R_FE_TX_DELAY"
>
> On Wed, May 8, 2024 at 9:59=E2=80=AFPM H Bell <dmoo_dv@protonmail.com> wr=
ote:
> >
> > Similar to the Milk-V Mars, The Star64 board contains few differences t=
o the
> > VisionFive 2 boards, so can be part of the same U-boot build.
> >
> > Signed-off-by: Henry Bell <dmoo_dv@protonmail.com>
> > Cc: ycliang@andestech.com
> > Cc: heinrich.schuchardt@canonical.com
> > ---
> >
> > Changes since v1
> >
> > - Fix typos on naming
> > - Create pine64_star64 struct to be populated with PHY values once conf=
irmed
> > ---
> >  board/starfive/visionfive2/spl.c              | 85 +++++++++++++++++++
> >  .../visionfive2/starfive_visionfive2.c        |  4 +
> >  2 files changed, 89 insertions(+)
> >
> > diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfi=
ve2/spl.c
> > index ca61b5be22..248c6ba01d 100644
> > --- a/board/starfive/visionfive2/spl.c
> > +++ b/board/starfive/visionfive2/spl.c
> > @@ -86,6 +86,39 @@ static const struct starfive_vf2_pro starfive_verb[]=
 =3D {
> >                 "tx-internal-delay-ps", "0"},
> >  };
> >
> > +static const struct starfive_vf2_pro star64_pine64[] =3D {
> > +       {"/soc/ethernet@16030000", "starfive,tx-use-rgmii-clk", NULL},
> > +       {"/soc/ethernet@16040000", "starfive,tx-use-rgmii-clk", NULL},
> > +
> > +       {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
> > +               "motorcomm,tx-clk-adj-enabled", NULL},
>
> Add:
>        {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
>                "motorcomm,tx-clk-10-inverted", NULL},
>
>
> > +       {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
> > +               "motorcomm,tx-clk-100-inverted", NULL},
> > +       {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
> > +               "motorcomm,tx-clk-1000-inverted", NULL},
> > +       {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
> > +               "motorcomm,rx-clk-drv-microamp", "3970"},
>
> This rx-clk-drv-microamp value 3970 is suspect. Delete
> rx-clk-drv-microamp property or set default value 2910.
>
> From drivers/net/phy/motorcomm.c:
> YT8531_RGMII_RX_DS_DEFAULT 0x3
>
> Presumably this default is the same as in the version of the
> motorcomm driver that is included on pre-loaded SPI NOR content.
>
> > +       {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
> > +               "motorcomm,rx-data-drv-microamp", "2910"},
> > +       {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
> > +               "rx-internal-delay-ps", "1900"},
> > +       {"/soc/ethernet@16030000/mdio/ethernet-phy@0",
> > +               "tx-internal-delay-ps", "1500"},
>
> N.b. tx-internal-delay-ps corresponds to tx_delay_sel (1000Mbit GE)
> and there is not
> any property corresponding to tx_delay_sel_fe (10/100Mbit FE). The
> driver does not
> implement tx_delay_sel_fe so no corresponding property on @0, else it wou=
ld be
> included here.
>
> > +
> > +       {"/soc/ethernet@16040000/mdio/ethernet-phy@1",
> > +               "motorcomm,tx-clk-adj-enabled", NULL},
>
> Add:
>                "motorcomm,tx-clk-10-inverted", NULL},
>        {"/soc/ethernet@16040000/mdio/ethernet-phy@1",
>
> > +       { "/soc/ethernet@16040000/mdio/ethernet-phy@1",
>
> Nit: delete space between curly bracket and open-quote to match other lin=
es.
>
> > +               "motorcomm,tx-clk-100-inverted", NULL},
> > +       {"/soc/ethernet@16040000/mdio/ethernet-phy@1",
> > +               "motorcomm,rx-clk-drv-microamp", "3970"},
>
> Again suspect 3970 value. Delete or set default 2910.
>
> > +       {"/soc/ethernet@16040000/mdio/ethernet-phy@1",
> > +               "motorcomm,rx-data-drv-microamp", "2910"},
> > +       {"/soc/ethernet@16040000/mdio/ethernet-phy@1",
> > +               "rx-internal-delay-ps", "0"},
> > +       {"/soc/ethernet@16040000/mdio/ethernet-phy@1",
> > +               "tx-internal-delay-ps", "0"},
>
> N.b. driver does not implement tx_delay_sel_fe so no corresponding
> property on @1, else it would be included here.
>
> > +};
> > +
> >  void spl_fdt_fixup_mars(void *fdt)
> >  {
> >         static const char compat[] =3D "milkv,mars\0starfive,jh7110";
> > @@ -226,6 +259,56 @@ void spl_fdt_fixup_version_b(void *fdt)
> >         }
> >  }
> >
> > +void spl_fdt_fixup_star64(void *fdt)
> > +{
> > +       static const char compat[] =3D "pine64,star64\0starfive,jh7110"=
;
> > +       u32 phandle;
> > +       u8 i;
> > +       int offset;
> > +       int ret;
> > +
> > +       fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compa=
t, sizeof(compat));
> > +       fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
> > +                          "Pine64 Star64");
> > +
> > +       /* gmac0 */
> > +       offset =3D fdt_path_offset(fdt, "/soc/clock-controller@17000000=
");
> > +       phandle =3D fdt_get_phandle(fdt, offset);
> > +       offset =3D fdt_path_offset(fdt, "/soc/ethernet@16030000");
> > +
> > +       fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
> > +       fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCL=
K_GMAC0_TX);
> > +       fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle=
);
> > +       fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
> > +                          JH7110_AONCLK_GMAC0_RMII_RTX);
> > +
> > +       /* gmac1 */
> > +       offset =3D fdt_path_offset(fdt, "/soc/clock-controller@13020000=
");
> > +       phandle =3D fdt_get_phandle(fdt, offset);
> > +       offset =3D fdt_path_offset(fdt, "/soc/ethernet@16040000");
> > +
> > +       fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
> > +       fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCL=
K_GMAC1_TX);
> > +       fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle=
);
> > +       fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
> > +                          JH7110_SYSCLK_GMAC1_RMII_RTX);
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(star64_pine64); i++) {
> > +               offset =3D fdt_path_offset(fdt, star64_pine64[i].path);
> > +
> > +               if (star64_pine64[i].value)
> > +                       ret =3D fdt_setprop_u32(fdt, offset,  star64_pi=
ne64[i].name,
> > +                                             dectoul(star64_pine64[i].=
value, NULL));
> > +               else
> > +                       ret =3D fdt_setprop_empty(fdt, offset, star64_p=
ine64[i].name);
> > +
> > +               if (ret) {
> > +                       pr_err("%s set prop %s fail.\n", __func__, star=
64_pine64[i].name);
> > +                               break;
> > +               }
> > +       }
> > +}
> > +
> >  void spl_perform_fixups(struct spl_image_info *spl_image)
> >  {
> >         u8 version;
> > @@ -252,6 +335,8 @@ void spl_perform_fixups(struct spl_image_info *spl_=
image)
> >                         spl_fdt_fixup_version_b(spl_image->fdt_addr);
> >                 break;
> >                 };
> > +       } else if (!strncmp(product_id, "STAR64", 6)) {
> > +               spl_fdt_fixup_star64(spl_image->fdt_addr);
> >         } else {
> >                 pr_err("Unknown product %s\n", product_id);
> >         };
> > diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/=
starfive/visionfive2/starfive_visionfive2.c
> > index a86bca533b..1e7c41f01b 100644
> > --- a/board/starfive/visionfive2/starfive_visionfive2.c
> > +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> > @@ -23,6 +23,8 @@ DECLARE_GLOBAL_DATA_PTR;
> >         "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
> >  #define FDTFILE_VISIONFIVE2_1_3B \
> >         "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
> > +#define FDTFILE_PINE64_STAR64 \
> > +       "starfive/jh7110-pine64-star64.dtb"
> >
> >  /* enable U74-mc hart1~hart4 prefetcher */
> >  static void enable_prefetcher(void)
> > @@ -78,6 +80,8 @@ static void set_fdtfile(void)
> >                         fdtfile =3D FDTFILE_VISIONFIVE2_1_3B;
> >                         break;
> >                 }
> > +       } else if (!strncmp(product_id, "STAR64", 6)) {
> > +               fdtfile =3D FDTFILE_PINE64_STAR64;
> >         } else {
> >                 log_err("Unknown product\n");
> >                 return;
> > --
> > 2.44.0
> >
> >
>
> I've posted builds to people interested in testing where I add a
> tx-internal-delay-ps property and register setting in motorcomm.c
> which would be some later patch if it has a useful result.

Fixing my typo: The future testing is tx-internal-delay-fe-ps
corresponding to tx_delay_sel_fe.

- E
