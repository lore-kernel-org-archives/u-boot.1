Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1FDCEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 17:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F1683BE1;
	Mon, 17 Nov 2025 18:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nDxMRsOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABD2383BFE; Mon, 17 Nov 2025 18:14:11 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0CB183B9D
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 18:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-5dfa9c01c54so2884203137.0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 09:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763399647; x=1764004447; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jP8zI5d2alqqI328rVW97GUkjlMaaQotj8zRLhO+9n0=;
 b=nDxMRsOptizfJlnDWic7Szm+XhnLuWZ3AeGDJWWsbx+4SK+donG5mnmt2OusaNgsZ+
 umTfCqI53L9abUECchqJoY6s5cnS/A8CDf49E7WlwyePIbjPtiDVS4hNZPBQeiiDAuml
 ZxwTtD3vY1w4A2VEIwwD9oAXn90YQ/jWBSFe9Jmp4W7SyFtFN/rRTj3RTVD5vpY5kUDX
 VH/h7VKBiMl6NF3D2LqqbAIOdYOrpytyeAw0susxsiTHUQNrTCVQywUz4dIekRzEdcWI
 w1KCRKb2msBXhiCS5IOAnPEiTqcH7OerKFEoP1J1wKMCMoJ3cZ1i2kzjz+6egDCeLMKV
 2V0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763399647; x=1764004447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jP8zI5d2alqqI328rVW97GUkjlMaaQotj8zRLhO+9n0=;
 b=YofiKRkGJg6rP9Jnx+yzTd++LZVHxv0iEKnWRvaxl1UVizOR8k4rlFPAs0VuMymuHm
 HPcK6Ad4Yn0eROMGWxQNOZ3M9/KnNz4VEzXXGPvaW6TpWX3NxorT/w27M2McoyDajEVn
 qrFH005TW8hOk94R3Og96D6SfbSxBgnT1axbNtxDdCardqIuQI6DFk7mS9WIvTFCD13g
 7VyFMTQ3ZMJbcG1511JPzGcwgrwXhhDEFYPAQ2R11H85y7wbw5/MMNNBqqmwgpOOB1Ry
 uzG0ZVgM5Ep02nd7RpIyIp3n8RwCgQ85NWRUEo9yiQujFCtewpHjNMV/FLFjYXkVvIb8
 1jSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6pOf3+R46X/aJi1J/BSNdx5XRLIJVWGk8Tlb18kV3YHciQmFk7U56Q5VNto7X2+bIJowaMgM=@lists.denx.de
X-Gm-Message-State: AOJu0YzsKz9Fn12YsXBh05GIEmLlsijmKMofNqQvTLgFpOFV08hAGYvG
 wz2W98H4rlfKWAb1EkYUdXtmVVDGYhomk5wZHPqTGbq8D9jUAqXZx3vPeVe9RNIpcTg4OXVU/p9
 08QlRgWYGcX5crqmsqM0g5kfUuniBQlSwV0dMAPxCOw==
X-Gm-Gg: ASbGncsiWbr3Mjt85bFRn91coFSlFC7sMargYhWRg3+Z30Sld4IbhqA/pHL0gNRapkZ
 qcARfR7FtPO7kz+7NUrRNdm0zAg2vZpxpLojmtwqNo36v3xK9vqbuZq4oRYJ23j6plbv+Rw78JV
 qbbheJEk1OovmKlUrqWFvMo4XiyYJefFzFx3v5VToOUpY4AcukWhJoZ/EuqaT+uj8TfJ5ludbe7
 cExq6rEsXA6rm4G7YiIzNIDXjDJUas02xP2fnPDyvuhviUvuaAjx1cjJnluEZ/Fvp+lwVPRWaib
 Yd1WsefvrfrQcpI=
X-Google-Smtp-Source: AGHT+IGmTEZt6WdWydjBev6ZJyMTjuUpy+1ITvW1ffYPmpMb9urF4F3CeY98bej+9+ttd0JUqj+6ujRX68ISwooY+lg=
X-Received: by 2002:a05:6102:41a2:b0:5db:fce3:af72 with SMTP id
 ada2fe7eead31-5dfc54fe9b1mr5304272137.11.1763399647344; Mon, 17 Nov 2025
 09:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20251116103934.63668-1-heinrich.schuchardt@canonical.com>
 <CAMDkj5wQ=pRGFrf_S-HPUs9Zd-uWGFyLFDk3S2TRGCCuvJCMgA@mail.gmail.com>
 <15d4a8ae-5fd2-45df-af9d-e879faf6be1f@canonical.com>
In-Reply-To: <15d4a8ae-5fd2-45df-af9d-e879faf6be1f@canonical.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 17 Nov 2025 12:13:53 -0500
X-Gm-Features: AWmQ_bmD5tlZM6jBba6IB60NTHa6CdnHGc9CxIZ31hf1AB2Cu_cY99_gaZIyq0I
Message-ID: <CAMDkj5ya41Ea8_VU_VrmRHfMgYJ2q2qLexv14AT1CGYW7vYtwA@mail.gmail.com>
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

On Mon, Nov 17, 2025 at 11:43=E2=80=AFAM Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> On 11/17/25 16:48, Raymond Mao wrote:
> > Hi Heinrich,
> >
> > On Sun, Nov 16, 2025 at 5:39=E2=80=AFAM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com
> > <mailto:heinrich.schuchardt@canonical.com>> wrote:
> >
> >     In the QFW case the SMBIOS specification version is controlled by
> QEMU.
> >     Field 'Thread Enable' is not available before SMBIOS v3.6.
> >
> >     We should not print the core, core enabled, and thread counts twice=
.
> >     Use the appropriate based on the SMBIOS version.
> >     Use decimal output which is easier to read for humans.
> >
> >     Signed-off-by: Heinrich Schuchardt
> >     <heinrich.schuchardt@canonical.com
> >     <mailto:heinrich.schuchardt@canonical.com>>
> >     ---
> >       cmd/smbios.c | 21 +++++++++++++++------
> >       1 file changed, 15 insertions(+), 6 deletions(-)
> >
> >     diff --git a/cmd/smbios.c b/cmd/smbios.c
> >     index 671c14e05b5..f9a352c107d 100644
> >     --- a/cmd/smbios.c
> >     +++ b/cmd/smbios.c
> >     @@ -262,6 +262,8 @@ static const struct str_lookup_table
> >     md_tech_strings[] =3D {
> >              { SMBIOS_MD_TECH_OPTANE,        "Intel Optane persistent
> >     memory" },
> >       };
> >
> >     +static u16 smbios_version;
> >     +
> >       /**
> >        * smbios_get_string() - get SMBIOS string from table
> >        *
> >     @@ -504,18 +506,23 @@ static void smbios_print_type4(struct
> >     smbios_type4 *table)
> >              smbios_print_str("Serial Number", table,
> table->serial_number);
> >              smbios_print_str("Asset Tag", table, table->asset_tag);
> >              smbios_print_str("Part Number", table, table->part_number)=
;
> >     -       printf("\tCore Count: 0x%02x\n", table->core_count);
> >     -       printf("\tCore Enabled: 0x%02x\n", table->core_enabled);
> >     -       printf("\tThread Count: 0x%02x\n", table->thread_count);
> >     +       if (smbios_version < 0x0300) {
> >     +               printf("\tCore Count: %d\n", table->core_count);
> >     +               printf("\tCore Enabled: %d\n", table->core_enabled)=
;
> >     +               printf("\tThread Count: %d\n", table->thread_count)=
;
> >     +       } else {
> >     +               printf("\tCore Count: %d\n", table->core_count2);
> >     +               printf("\tCore Enabled: %d\n", table->core_enabled2=
);
> >     +               printf("\tThread Count: %d\n", table->thread_count2=
);
> >     +       }
> >
> >
> > I think for ">=3D 0x0300", both parts are needed.
> >
> > Below is the description of " Core Count 2" in spec: https://
> > www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.8.0.pdf
> > <https://www.dmtf.org/sites/default/files/standards/documents/
> > DSP0134_3.8.0.pdf>
> > Number of Cores per processor socket. Supports core counts >255. If thi=
s
> > field is present, it holds the core count for the processor socket. Cor=
e
> > Count will also hold the core count, except for core counts that are 25=
6
> > or greater. In that case, Core Count shall be set to FFh and Core Count
> > 2 will hold the count. See 7.5.6. Legal values: 0000h =3D unknown
> > 0001h-00FFh =3D core counts 1 to 255. Matches Core Count value. 0100h-
> > FFFEh =3D Core counts 256 to 65534, respectively. FFFFh =3D reserved.
> >
> > Similar for core_enabled2 and thread_count2, they are all extensions
> > when values above 255.
>
> The descriptions of fields "Core Count 2", "Core Enabled 2", "Thread
> Count 2" all say: "If this field is present, it holds the ... for the
> processor socket."
>
> So there is no need to look into the old fields "Core Count", "Core
> Enabled", "Thread Count" for SMBIOS version >=3D 3.0 and test for 0xff.
>
>
But it also says: " Core Count will also hold the core count, except for
core counts that are 256 or greater. In that case, Core Count shall be set
to FFh and Core Count 2 will hold the count."
So the "old" fields might be with the same values as the "new" ones, or
they might be "FFh".
That is the reason I believe it is still valuable to print and show whether
it is aligned to the spec.

But anyway, it is not really a big deal to print them or not in cmd - it is
just for demo/debug purposes, what I wanted to highlight is the logic to
exclude fields for old versions < 0x0300 should be needed in lib/smbios.

Regards,
Raymond



> We should avoid printing duplicate information.
>
> Best regards
>
> Heinrich
>
> >
> > So, if for the consideration of the old versions of spec, the change
> > should be:
> > ```
> > -       printf("\tCore Count 2: 0x%04x\n", table->core_count2);
> > -       printf("\tCore Enabled 2: 0x%04x\n", table->core_enabled2);
> > -       printf("\tThread Count 2: 0x%04x\n", table->thread_count2);
> > +      if (smbios_version >=3D 0x0300) {
> > +               printf("\tCore Count 2: %d\n", table->core_count2);
> > +               printf("\tCore Enabled 2: %d\n", table->core_enabled2);
> > +               printf("\tThread Count 2: %d\n", table->thread_count2);
> > +       }
> > ```
> > Moreover, I think the same logic should be done when the table is being
> > constructed in lib/smbios.c, where the real content of tables is locate=
d.
> >
> > Regards,
> > Raymond
> >
> >              printf("\tProcessor Characteristics: 0x%04x\n",
> >                     table->processor_characteristics);
> >              smbios_print_lookup_str(processor_family_strings,
> >                                      table->processor_family2,
> >
> ARRAY_SIZE(processor_family_strings),
> >                                      "Processor Family 2");
> >     -       printf("\tCore Count 2: 0x%04x\n", table->core_count2);
> >     -       printf("\tCore Enabled 2: 0x%04x\n", table->core_enabled2);
> >     -       printf("\tThread Count 2: 0x%04x\n", table->thread_count2);
> >     +       if (smbios_version < 0x0306)
> >     +               return;
> >              printf("\tThread Enabled: 0x%04x\n", table->thread_enabled=
);
> >       }
> >
> >     @@ -719,6 +726,8 @@ static int do_smbios(struct cmd_tbl *cmdtp, int
> >     flag, int argc,
> >                      struct smbios3_entry *entry3 =3D entry;
> >
> >                      table =3D (void *)(uintptr_t)entry3-
> >      >struct_table_address;
> >     +               smbios_version =3D ((u16)entry3->major_ver << 16) +
> >     +                                (u16)entry3->minor_ver;
> >                      snprintf(version, sizeof(version), "%d.%d.%d",
> >                               entry3->major_ver, entry3->minor_ver,
> >     entry3->doc_rev);
> >                      table =3D (void *)(uintptr_t)entry3-
> >      >struct_table_address;
> >     --
> >     2.51.0
> >
>
>
