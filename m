Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52FDC3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 21:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0DB687FC7;
	Sun, 21 Jul 2024 23:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PwPGMe3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0A2B87EB4; Sun, 21 Jul 2024 23:27:22 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9146387F82
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 23:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ef2d7d8854so5435401fa.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721597240; x=1722202040; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ICEtV5gK0eZ0LuPJc3O76jItFa5nZgVcR/2kogruH0=;
 b=PwPGMe3NyrGmrxjsCcrpFksGGtKlX6Iv4W2/Bfc5EG2gyP0hBTwPtgLkza1Ty3LIEH
 JvNVA+1fXpiD+hLD6S9bubkBDgGmeY60qa0PNJbsgH1e5dnWOkj88kU08Eb6Xv7BY3Uu
 tGyAFEbD9E9cKf3+68cMcbxjm+dTDjenkwmLpkmm6KCRIBBVTrSwBb7yvQBNCiEOX/v3
 GvXW++IK/Ni7C9LJ+J35VJD67UFRpvJk6pjR4DZzvCt5dYMBhqpltLMmKxCsYNasUW/2
 B1qGpC5myxcyJ3uY+tqFPWwN4AW8AalErLUvrWDQlbCznH1CMPON0I07usWJSxQk4NNV
 PTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721597240; x=1722202040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ICEtV5gK0eZ0LuPJc3O76jItFa5nZgVcR/2kogruH0=;
 b=C0N7Rnf927IVslmEpBB8boQAoSQAMIzYfDJvAoq5AbvG58pNj155MIqcaEQyGhxrn8
 yNYHTWETF3JOBAf4gZ6vVGxgP9iUqI7yYNwsEQSgAH4wZakokmQCScL2B5KD+Rs1xog/
 zBTj3b3QSUOZLgoQ2fQXHSWJjYxxk8TeY3wCAVG4hv4kG2AwHThwBrD86LDwLA1DVYeO
 Gv1Dp4MQGKQ86EImRlKNveaYpR3An6j3vnArrQ4SY/JbijEjyyLzGmpjNQE28VvsdZp6
 e2Kd3dJ9sJvA+6SP1JU59XKmXLeybNqebX7dMkkJLqrn1mhVNHmWF+/kjMgIz5aGawBo
 89jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWoXbTx3iG1iUICuEMD4VwagRCtf7AmbuH4Plpcrl6ugHaZWfv/lP4Qkv/Ztac2au/H7LEaXao5JivBIXk7S1xQq1p6w==
X-Gm-Message-State: AOJu0YxTVba9w08gM0thXWa32J/1noJeAKY8+19hEwIi/Bek8xZUZ45d
 wk5WWJmEX+/0qMdT/RaJZQjyJGOlWvAI6TLDN16ja0+bUM3W0jW0qtbyf9FISx7jaP2K97ArGRL
 XvbHWRQcQkEq8cF3btRNlVHD4B621DuKav24=
X-Google-Smtp-Source: AGHT+IE0NH1KmVJC3DCmTjDm6wH5PnLu3mS4z0Ocs9qs0hToB84sjJYwbyt33EyFQlKA2UBHQGanldHWdYJsxM1e0Mc=
X-Received: by 2002:a05:651c:19a9:b0:2ef:3250:d0d4 with SMTP id
 38308e7fff4ca-2ef3250d296mr4719601fa.48.1721597239497; Sun, 21 Jul 2024
 14:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240719231158.50416-1-heinrich.schuchardt@canonical.com>
 <CANV2PTPOesJWcbYhVeiQWonccy3rWdQmN5qfuJtFN+JpnYNzbA@mail.gmail.com>
In-Reply-To: <CANV2PTPOesJWcbYhVeiQWonccy3rWdQmN5qfuJtFN+JpnYNzbA@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Sun, 21 Jul 2024 14:27:08 -0700
Message-ID: <CANV2PTOWVCTWiyQoA4vEro61WwFSPBaGbrsBN-zXVwm2daHvJg@mail.gmail.com>
Subject: Re: [PATCH 1/1] board: fix compatible property Milk-V Mars CM
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Rick Chen <rick@andestech.com>, Hal Feng <hal.feng@starfivetech.com>, 
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, u-boot@lists.denx.de
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

P.S. my suggestion below

On Fri, Jul 19, 2024 at 5:06=E2=80=AFPM E Shattow <lucent@gmail.com> wrote:
>
> On Fri, Jul 19, 2024 at 4:12=E2=80=AFPM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > For the Milk-V Mars CM (lite) we have only been copying sizeof(void *)
> > bytes to the compatible property instead of the whole string list.
>
> This const char array must be so that we may get an accurate data
> length with sizeof() but it highlights there are helper functions for
> get of fdt stringlist and not for set of fdt stringlist.
>
> >
> > Fixes: de3229599d4f ("board: add support for Milk-V Mars CM")
> > Reported-by: E Shattow <lucent@gmail.com>
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  board/starfive/visionfive2/spl.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfi=
ve2/spl.c
> > index b794b73b6bd..f55c6b5d34c 100644
> > --- a/board/starfive/visionfive2/spl.c
> > +++ b/board/starfive/visionfive2/spl.c
> > @@ -170,23 +170,32 @@ void spl_fdt_fixup_mars_cm(void *fdt)
> >  {
> >         const char *compat;
> >         const char *model;
> > +       int compat_size;
> >
> >         spl_fdt_fixup_mars(fdt);
> >
> >         if (!get_mmc_size_from_eeprom()) {
> >                 int offset;
> > +               static const char
> > +               compat_cm_lite[] =3D "milkv,mars-cm-lite\0starfive,jh71=
10";
> >
> >                 model =3D "Milk-V Mars CM Lite";
> > -               compat =3D "milkv,mars-cm-lite\0starfive,jh7110";
> > +               compat =3D compat_cm_lite;
> > +               compat_size =3D sizeof(compat_cm_lite);
> >
> >                 offset =3D fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins=
/mmc0-pins-rest");
> >                 /* GPIOMUX(22, GPOUT_SYS_SDIO0_RST, GPOEN_ENABLE, GPI_N=
ONE) */
> >                 fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
> >         } else {
> > +               static const char
> > +               compat_cm[] =3D "milkv,mars-cm\0starfive,jh7110";
> > +
> >                 model =3D "Milk-V Mars CM";
> > -               compat =3D "milkv,mars-cm\0starfive,jh7110";
> > +               compat =3D compat_cm;
> > +               compat_size =3D sizeof(compat_cm);
> >         }
> > -       fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compa=
t, sizeof(compat));
> > +       fdt_setprop(fdt, fdt_path_offset(fdt, "/"),
> > +                   "compatible", compat, compat_size);
> >         fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", mod=
el);
> >  }
> >
> > --
> > 2.45.2
> >
>
> -E

What about something like as follows?

 void spl_fdt_fixup_mars(void *fdt)
 {
-       static const char compat[] =3D "milkv,mars\0starfive,jh7110";
        u32 phandle;
        u8 i;
        int offset;
        int ret;

-       fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible",
compat, sizeof(compat));
-       fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
-                          "Milk-V Mars");
+       offset =3D fdt_path_offset(fdt, "/");
+       fdt_setprop_string(fdt,    offset, "compatible", "milkv,mars");
+       fdt_appendprop_string(fdt, offset, "compatible", "starfive,jh7110")=
;
+       fdt_setprop_string(fdt,    offset, "model",      "Milk-V Mars");

        /* gmac0 */
        offset =3D fdt_path_offset(fdt, "/soc/clock-controller@17000000");
@@ -164,30 +226,31 @@ void spl_fdt_fixup_mars(void *fdt)
                                break;
                }
        }
 }

 void spl_fdt_fixup_mars_cm(void *fdt)
 {
-       const char *compat;
-       const char *model;
+       int offset;

        spl_fdt_fixup_mars(fdt);

        if (!get_mmc_size_from_eeprom()) {
-               int offset;
-
-               model =3D "Milk-V Mars CM Lite";
-               compat =3D "milkv,mars-cm-lite\0starfive,jh7110";
+               offset =3D fdt_path_offset(fdt, "/");
+               fdt_setprop_string(fdt, offset, "compatible",
"milkv,mars-cm-lite");
+               fdt_appendprop_string(fdt, offset, "compatible",
"starfive,jh7110");
+               fdt_setprop_string(fdt, offset, "model", "Milk-V Mars CM Li=
te");

                offset =3D fdt_path_offset(fdt,
"/soc/pinctrl/mmc0-pins/mmc0-pins-rest");
                /* GPIOMUX(22, GPOUT_SYS_SDIO0_RST, GPOEN_ENABLE, GPI_NONE)=
 */
                fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
        } else {
-               model =3D "Milk-V Mars CM";
-               compat =3D "milkv,mars-cm\0starfive,jh7110";
+               offset =3D fdt_path_offset(fdt, "/");
+               fdt_setprop_string(fdt, offset, "compatible", "milkv,mars-c=
m");
+               fdt_appendprop_string(fdt, offset, "compatible",
"starfive,jh7110");
+               fdt_setprop_string(fdt, offset, "model", "Milk-V Mars CM");
        }
-       fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible",
compat, sizeof(compat));
-       fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model);
 }

 void spl_fdt_fixup_version_a(void *fdt)
@@ -235,6 +298,7 @@ void spl_fdt_fixup_version_a(void *fdt)
                                break;
                }
        }
+
 }


And similar changes to the other "string1\0string2" settings in the
same source file.

-E
