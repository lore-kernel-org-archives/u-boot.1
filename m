Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA81D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 166E5839E8;
	Fri, 28 Nov 2025 17:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bvZB9ON1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05AC083A28; Fri, 28 Nov 2025 17:49:09 +0100 (CET)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F90A83966
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-5dfcfbcbcc0so633222137.2
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 08:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764348543; x=1764953343; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gGADX9wC/te5+ywOrahLVKiQ78ITfCXa4wwWhdNUB4I=;
 b=bvZB9ON1378vm2w0aJ4+5vzZimAZtp+xzC67D6enee14EyFoSkZwLuKEYC620cGo/T
 w1LVpnjYsPrQeWUhU5OAZP6xlnK1djdjLZkW3h7q050tKd1/rJtAKuXNtEERwKbao25O
 E6KDjgcJeqKy9J8Qkt6pgSAaL2B7QDiJg21JSxyUku1t1FEHrx0XHKNDo+l7wYy7Ydt6
 jU+56RuRKi2l5WqwM6FMF/XgtC6YdiJRM67XwIbNxKLVdHttg903x5edm1AI0wTuGelL
 6KSbzfjxYnW4vgneGN8/3UoZ8jcHk7cimNldeXRD+L0zN2W6cYrrChaselLiOprPNGzN
 8mnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764348543; x=1764953343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGADX9wC/te5+ywOrahLVKiQ78ITfCXa4wwWhdNUB4I=;
 b=IvTC1S99w371cM7mnwVYmtd/CJxcCI10c0KYssCTZQreNwGhQhbT4Sy1spUVFGzhQz
 B/n40zVEqF9mqn3hLz7d/L/Pbzd+HCoixsYrbVtiK26RJaOy1yRHi4X2wYeSo1QGOnuh
 yM3753x45oyjCVDl1CSSW/5TWLodyU1O8krrT0qh44kS66kndkBfQNgFyO64CNoYAv4t
 GwvhKT7drKXxlF4HjMXEewPARg8a6ZmtcFAiB2IRnllnBFCGP1PRpNDxs20HQ+lEebMI
 5U+L8LjpJDLkNopYTOFd9HSdzxRxn8KsKgNz52RgF5OYLs4nN5+7aMX2huCC3j0jyNZE
 EOXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8ACriwsIExBNhiBwOLUtJxmzBYOb8g0tFb9Pjn5nEe9/0D2rClJGg7WriQIz2544mDAxIink=@lists.denx.de
X-Gm-Message-State: AOJu0YyCL+Qruc+AEb3wdUQDYtq4SfDR9W2irpBLYoltm3Llx4rGXjAB
 JLPTjvjUWSHCjonWHXZRxoV+VbJkhO2ODNrhY4oKFHRKabVUAZycxbbatQVe2J3kGA4Ok7f4sC1
 Hk/KgElQfQ02WwZkl6hgYtwDNZJAD2AN4c7vvnBhH8Q==
X-Gm-Gg: ASbGnctC1vNml2DRETdLSgWK0K24v6UTz35fRojFkYreEL259NdbsTMsoLv+vgv/Wlt
 Z5odwmFpFyeAIk0cO5J0FXNI/IlHH3FCmkrPBNDSZv0WFBghG8xAg7Raf6R6W2XZC8celXxLZAS
 98qczWg5mIdGvnj3lUtJ48tsHzodUA8fSX8Bx1UNOnqmiOKVmkJDYKY7bjNpORy8hkfhaIAxK10
 hFFfl5qNdO3kGtOeDw0y8yEJOqosUprEbK2dKFDXvwje0nE9oOi/MvTAYjnVIb7CtEitdwL0Pxi
 cYEc
X-Google-Smtp-Source: AGHT+IG9mCnmYOJZBP6zwES9J5dS0TJUt7QWrhQoJ2JCEL/4xrMUcXIGHA4UFrndMvJfB5o1uzF+pe4fdXBXkvCouxE=
X-Received: by 2002:a05:6102:3f14:b0:5db:2b4d:f1ee with SMTP id
 ada2fe7eead31-5e1de137573mr10144384137.17.1764348542689; Fri, 28 Nov 2025
 08:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20251116103934.63668-1-heinrich.schuchardt@canonical.com>
 <CAMDkj5wQ=pRGFrf_S-HPUs9Zd-uWGFyLFDk3S2TRGCCuvJCMgA@mail.gmail.com>
 <15d4a8ae-5fd2-45df-af9d-e879faf6be1f@canonical.com>
 <CAMDkj5ya41Ea8_VU_VrmRHfMgYJ2q2qLexv14AT1CGYW7vYtwA@mail.gmail.com>
 <c7727c37-c4a0-4399-82fe-ce421dad7c57@canonical.com>
In-Reply-To: <c7727c37-c4a0-4399-82fe-ce421dad7c57@canonical.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 28 Nov 2025 11:48:52 -0500
X-Gm-Features: AWmQ_bllRDBHI3mYp2m7XVpkk3O3DJcCiQPvLURi8jBvY11y6RwDRxHhcVM1F4I
Message-ID: <CAMDkj5yoC_Qsbj7JV-+1kjw7=BkwO2cytRsXQ=kbcTESVs8+NA@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: smbios: correct output for table type 4
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Heinrich,

Sorry for the late reply.

On Mon, Nov 17, 2025 at 12:27=E2=80=AFPM Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> On 11/17/25 18:13, Raymond Mao wrote:
> > Hi Heinrich,
> >
> > On Mon, Nov 17, 2025 at 11:43=E2=80=AFAM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com
> > <mailto:heinrich.schuchardt@canonical.com>> wrote:
> >
> >     On 11/17/25 16:48, Raymond Mao wrote:
> >      > Hi Heinrich,
> >      >
> >      > On Sun, Nov 16, 2025 at 5:39=E2=80=AFAM Heinrich Schuchardt
> >      > <heinrich.schuchardt@canonical.com
> >     <mailto:heinrich.schuchardt@canonical.com>
> >      > <mailto:heinrich.schuchardt@canonical.com
> >     <mailto:heinrich.schuchardt@canonical.com>>> wrote:
> >      >
> >      >     In the QFW case the SMBIOS specification version is
> >     controlled by QEMU.
> >      >     Field 'Thread Enable' is not available before SMBIOS v3.6.
> >      >
> >      >     We should not print the core, core enabled, and thread count=
s
> >     twice.
> >      >     Use the appropriate based on the SMBIOS version.
> >      >     Use decimal output which is easier to read for humans.
> >      >
> >      >     Signed-off-by: Heinrich Schuchardt
> >      >     <heinrich.schuchardt@canonical.com
> >     <mailto:heinrich.schuchardt@canonical.com>
> >      >     <mailto:heinrich.schuchardt@canonical.com
> >     <mailto:heinrich.schuchardt@canonical.com>>>
> >      >     ---
> >      >       cmd/smbios.c | 21 +++++++++++++++------
> >      >       1 file changed, 15 insertions(+), 6 deletions(-)
> >      >
> >      >     diff --git a/cmd/smbios.c b/cmd/smbios.c
> >      >     index 671c14e05b5..f9a352c107d 100644
> >      >     --- a/cmd/smbios.c
> >      >     +++ b/cmd/smbios.c
> >      >     @@ -262,6 +262,8 @@ static const struct str_lookup_table
> >      >     md_tech_strings[] =3D {
> >      >              { SMBIOS_MD_TECH_OPTANE,        "Intel Optane
> persistent
> >      >     memory" },
> >      >       };
> >      >
> >      >     +static u16 smbios_version;
> >      >     +
> >      >       /**
> >      >        * smbios_get_string() - get SMBIOS string from table
> >      >        *
> >      >     @@ -504,18 +506,23 @@ static void smbios_print_type4(struct
> >      >     smbios_type4 *table)
> >      >              smbios_print_str("Serial Number", table, table-
> >      >serial_number);
> >      >              smbios_print_str("Asset Tag", table,
> table->asset_tag);
> >      >              smbios_print_str("Part Number", table, table-
> >      >part_number);
> >      >     -       printf("\tCore Count: 0x%02x\n", table->core_count);
> >      >     -       printf("\tCore Enabled: 0x%02x\n",
> table->core_enabled);
> >      >     -       printf("\tThread Count: 0x%02x\n",
> table->thread_count);
> >      >     +       if (smbios_version < 0x0300) {
> >      >     +               printf("\tCore Count: %d\n",
> table->core_count);
> >      >     +               printf("\tCore Enabled: %d\n", table-
> >      >core_enabled);
> >      >     +               printf("\tThread Count: %d\n", table-
> >      >thread_count);
> >      >     +       } else {
> >      >     +               printf("\tCore Count: %d\n",
> table->core_count2);
> >      >     +               printf("\tCore Enabled: %d\n", table-
> >      >core_enabled2);
> >      >     +               printf("\tThread Count: %d\n", table-
> >      >thread_count2);
> >      >     +       }
> >      >
> >      >
> >      > I think for ">=3D 0x0300", both parts are needed.
> >      >
> >      > Below is the description of " Core Count 2" in spec: https://
> >      > www.dmtf.org/sites/default/files/standards/documents/
> >     DSP0134_3.8.0.pdf <http://www.dmtf.org/sites/default/files/
> >     standards/documents/DSP0134_3.8.0.pdf>
> >      > <https://www.dmtf.org/sites/default/files/standards/documents/
> >     <https://www.dmtf.org/sites/default/files/standards/documents/>
> >      > DSP0134_3.8.0.pdf>
> >      > Number of Cores per processor socket. Supports core counts >255.
> >     If this
> >      > field is present, it holds the core count for the processor
> >     socket. Core
> >      > Count will also hold the core count, except for core counts that
> >     are 256
> >      > or greater. In that case, Core Count shall be set to FFh and Cor=
e
> >     Count
> >      > 2 will hold the count. See 7.5.6. Legal values: 0000h =3D unknow=
n
> >      > 0001h-00FFh =3D core counts 1 to 255. Matches Core Count value.
> 0100h-
> >      > FFFEh =3D Core counts 256 to 65534, respectively. FFFFh =3D rese=
rved.
> >      >
> >      > Similar for core_enabled2 and thread_count2, they are all
> extensions
> >      > when values above 255.
> >
> >     The descriptions of fields "Core Count 2", "Core Enabled 2", "Threa=
d
> >     Count 2" all say: "If this field is present, it holds the ... for t=
he
> >     processor socket."
> >
> >     So there is no need to look into the old fields "Core Count", "Core
> >     Enabled", "Thread Count" for SMBIOS version >=3D 3.0 and test for 0=
xff.
> >
> >
> > But it also says: " Core Count will also hold the core count, except fo=
r
> > core counts that are 256 or greater. In that case, Core Count shall be
> > set to FFh and Core Count 2 will hold the count."
> > So the "old" fields might be with the same values as the "new" ones, or
> > they might be "FFh".
> > That is the reason I believe it is still valuable to print and show
> > whether it is aligned to the spec.
>
> For values below 256 the values will be equal. Why do you want to print
> redundant information?
>
>
Actually, I have a better idea to use 'table->hdr.length' for version
control instead of introducing the version explicitly.
The 'table->hdr.length' is tied to the version and it is already being used
for type 1.
I sent a patch [1] to extend the usage of 'table->hdr.length' to all types
we have and it covers all logics from 2.0 to 3.7+,
and it looks neat.
Please see if that matches your cases.

[1]
https://lore.kernel.org/u-boot/20251128163535.2301653-7-raymondmaoca@gmail.=
com/T/#u

Regards,
Raymond



> Best regards
>
> Heinrich
>
> >
> > But anyway, it is not really a big deal to print them or not in cmd - i=
t
> > is just for demo/debug purposes, what I wanted to highlight is the logi=
c
> > to exclude fields for old versions < 0x0300 should be needed in
> lib/smbios.
> >
> > Regards,
> > Raymond
> >
> >     We should avoid printing duplicate information.
> >
> >     Best regards
> >
> >     Heinrich
> >
> >      >
> >      > So, if for the consideration of the old versions of spec, the
> change
> >      > should be:
> >      > ```
> >      > -       printf("\tCore Count 2: 0x%04x\n", table->core_count2);
> >      > -       printf("\tCore Enabled 2: 0x%04x\n",
> table->core_enabled2);
> >      > -       printf("\tThread Count 2: 0x%04x\n",
> table->thread_count2);
> >      > +      if (smbios_version >=3D 0x0300) {
> >      > +               printf("\tCore Count 2: %d\n",
> table->core_count2);
> >      > +               printf("\tCore Enabled 2: %d\n", table-
> >      >core_enabled2);
> >      > +               printf("\tThread Count 2: %d\n", table-
> >      >thread_count2);
> >      > +       }
> >      > ```
> >      > Moreover, I think the same logic should be done when the table i=
s
> >     being
> >      > constructed in lib/smbios.c, where the real content of tables is
> >     located.
> >      >
> >      > Regards,
> >      > Raymond
> >      >
> >      >              printf("\tProcessor Characteristics: 0x%04x\n",
> >      >                     table->processor_characteristics);
> >      >              smbios_print_lookup_str(processor_family_strings,
> >      >                                      table->processor_family2,
> >      >
> >     ARRAY_SIZE(processor_family_strings),
> >      >                                      "Processor Family 2");
> >      >     -       printf("\tCore Count 2: 0x%04x\n",
> table->core_count2);
> >      >     -       printf("\tCore Enabled 2: 0x%04x\n", table-
> >      >core_enabled2);
> >      >     -       printf("\tThread Count 2: 0x%04x\n", table-
> >      >thread_count2);
> >      >     +       if (smbios_version < 0x0306)
> >      >     +               return;
> >      >              printf("\tThread Enabled: 0x%04x\n", table-
> >      >thread_enabled);
> >      >       }
> >      >
> >      >     @@ -719,6 +726,8 @@ static int do_smbios(struct cmd_tbl
> >     *cmdtp, int
> >      >     flag, int argc,
> >      >                      struct smbios3_entry *entry3 =3D entry;
> >      >
> >      >                      table =3D (void *)(uintptr_t)entry3-
> >      >      >struct_table_address;
> >      >     +               smbios_version =3D ((u16)entry3->major_ver <=
<
> 16) +
>

A typo of '<< 8' ? - smbios_version is a u16.


> >      >     +                                (u16)entry3->minor_ver;
> >      >                      snprintf(version, sizeof(version),
> "%d.%d.%d",
> >      >                               entry3->major_ver,
> entry3->minor_ver,
> >      >     entry3->doc_rev);
> >      >                      table =3D (void *)(uintptr_t)entry3-
> >      >      >struct_table_address;
> >      >     --
> >      >     2.51.0
> >      >
> >
>
>
