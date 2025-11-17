Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED34CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 15:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC1C483AEF;
	Mon, 17 Nov 2025 16:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EbSXfq10";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E6383B99; Mon, 17 Nov 2025 16:49:09 +0100 (CET)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 519BF8399B
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 16:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6420c0cf4abso609050d50.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 07:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763394545; x=1763999345; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kn3DetozdHiOljgkiHVbk3lyUeWftWbIJ3IXE5n+v3g=;
 b=EbSXfq10KK9m8O7RsbEIHnJIc55D95/mmhkZyPfunnCvZDm6k4F/TfUnSCZBKiyesb
 KC9Ja/rvup+8hkqCs+1pUmI/mpLsWPNTLQqt9tF2Z1iEVzEPr7WgtidnDYdqWa8/BMwf
 rIhr2bzNfLaU3ftn7y5D2P9sG3EvTqBdD03EgSXj8tA3SDHJIA5mnBVVeabyxm5ddPV4
 2xgI2mbHMBo5XviX1rxxBwND0Kv/EbXQwImInFXerg5nOiaRyjJ4CFuD/mGraCG44ejy
 XyBxC1nkHqWV2DUASG5iyP7HjKlgzNYpsYKErKfsOf+0xtthXCHxNBaXJWPdG/3YOsC5
 Eu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394545; x=1763999345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kn3DetozdHiOljgkiHVbk3lyUeWftWbIJ3IXE5n+v3g=;
 b=ozngiNtmo4covBV1BG8a21H9BVTUPltJmtzmWuSDFoJFosrIfU76uJ42RK/QQ6hMyp
 MgcjSL3tw4mrJKlp7KKi2LyV3BDwoZKxT01TlocyqtA4aDF2+UYQ+E25SHmtBWOPRgbq
 elVkEkTC2FFy8REQ5/a/rZhhG6wnkGza5xa1s+i3AF6HIc8rjsrFvnSJi/z+5PRzu6Hi
 jdBPH84Kxl53wKKFE0Bgyj7r2dLW7g8T3/sL5LvFOtEnmGBgBUSy2LNkvHeEVSl30x0+
 tj0ufx/k0rOUUiRJ+h4BhUUEDTcBnI7tdN+tEbPAWdjJPk2vazEQafz1ZSIoV+RiVopW
 30JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGEu8KPbvlzPtz0FdyZoirfVvz262qf1N7DKSHLNs1vRvFJjINIXC+ksz7uZU2kPHYX9tWozA=@lists.denx.de
X-Gm-Message-State: AOJu0YytVpMkMCpTWzur39bZr+oNUnxzYF/Rcm0ZgXJLbRI48RkSVX/C
 bVTVNAO5j7EEnK+9wx/q3hnyaKMc/9KsOZJ9+hEmBsrC4AQZ/tbnxlWjo7vTLDFpJq6g4k28ev8
 uxmDmXNrW7dLDU9KdjFRAGBb9q5cx+FA8n86hwxo=
X-Gm-Gg: ASbGnct8V3bcJNbHoRxO/24aOZEL3Gj7R2J5vOM3bG37st8mlH0VWxxLFJn1WpfqTLM
 qBz28PYtpQsJ40ryLxQJj3y4Df1i6ZiGIj/k0nxKy1ANyE5DGfwjPhoMbyqLw9j1486cCUeAs0r
 Teck2LuNI6wW+b3n/zYetIgpY2WMPUJQu4w4zPoYVW+5V8oIRH9zQwBER2PEjBhSuPt496ZNbkq
 xAipWpt8udMJ5Usq17iy2Su2pk2hQH9hQg1Os0dyMWgxWzFDs6L1z2HRCTqyTb/yQeAtSFZAKPQ
 4SZP
X-Google-Smtp-Source: AGHT+IEsaoXyqxtQvUT6aDmOLH2B9i7p6vAtj5bTMQZSyGHiI0j3IYQEq3g7j0aqqrSVAmU/DLd1klo6RCcwFQHWIO8=
X-Received: by 2002:a05:690e:4101:b0:642:84a:7bdc with SMTP id
 956f58d0204a3-642084a7ee2mr2277933d50.83.1763394544953; Mon, 17 Nov 2025
 07:49:04 -0800 (PST)
MIME-Version: 1.0
References: <20251116103934.63668-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251116103934.63668-1-heinrich.schuchardt@canonical.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 17 Nov 2025 10:48:50 -0500
X-Gm-Features: AWmQ_bk3IfW9n5K5b8PEVF2co9UGN0cSbjO1CqNzYsb0h2ztZdV9638M9_pGHt8
Message-ID: <CAMDkj5wQ=pRGFrf_S-HPUs9Zd-uWGFyLFDk3S2TRGCCuvJCMgA@mail.gmail.com>
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

On Sun, Nov 16, 2025 at 5:39=E2=80=AFAM Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> In the QFW case the SMBIOS specification version is controlled by QEMU.
> Field 'Thread Enable' is not available before SMBIOS v3.6.
>
> We should not print the core, core enabled, and thread counts twice.
> Use the appropriate based on the SMBIOS version.
> Use decimal output which is easier to read for humans.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/smbios.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/cmd/smbios.c b/cmd/smbios.c
> index 671c14e05b5..f9a352c107d 100644
> --- a/cmd/smbios.c
> +++ b/cmd/smbios.c
> @@ -262,6 +262,8 @@ static const struct str_lookup_table md_tech_strings[=
]
> =3D {
>         { SMBIOS_MD_TECH_OPTANE,        "Intel Optane persistent memory" =
},
>  };
>
> +static u16 smbios_version;
> +
>  /**
>   * smbios_get_string() - get SMBIOS string from table
>   *
> @@ -504,18 +506,23 @@ static void smbios_print_type4(struct smbios_type4
> *table)
>         smbios_print_str("Serial Number", table, table->serial_number);
>         smbios_print_str("Asset Tag", table, table->asset_tag);
>         smbios_print_str("Part Number", table, table->part_number);
> -       printf("\tCore Count: 0x%02x\n", table->core_count);
> -       printf("\tCore Enabled: 0x%02x\n", table->core_enabled);
> -       printf("\tThread Count: 0x%02x\n", table->thread_count);
> +       if (smbios_version < 0x0300) {
> +               printf("\tCore Count: %d\n", table->core_count);
> +               printf("\tCore Enabled: %d\n", table->core_enabled);
> +               printf("\tThread Count: %d\n", table->thread_count);
> +       } else {
> +               printf("\tCore Count: %d\n", table->core_count2);
> +               printf("\tCore Enabled: %d\n", table->core_enabled2);
> +               printf("\tThread Count: %d\n", table->thread_count2);
> +       }
>

I think for ">=3D 0x0300", both parts are needed.

Below is the description of " Core Count 2" in spec:
https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.8.0.=
pdf
Number of Cores per processor socket. Supports core counts >255. If this
field is present, it holds the core count for the processor socket. Core
Count will also hold the core count, except for core counts that are 256 or
greater. In that case, Core Count shall be set to FFh and Core Count 2 will
hold the count. See 7.5.6. Legal values: 0000h =3D unknown 0001h-00FFh =3D =
core
counts 1 to 255. Matches Core Count value. 0100h-FFFEh =3D Core counts 256 =
to
65534, respectively. FFFFh =3D reserved.

Similar for core_enabled2 and thread_count2, they are all extensions when
values above 255.

So, if for the consideration of the old versions of spec, the change should
be:
```
-       printf("\tCore Count 2: 0x%04x\n", table->core_count2);
-       printf("\tCore Enabled 2: 0x%04x\n", table->core_enabled2);
-       printf("\tThread Count 2: 0x%04x\n", table->thread_count2);
+      if (smbios_version >=3D 0x0300) {
+               printf("\tCore Count 2: %d\n", table->core_count2);
+               printf("\tCore Enabled 2: %d\n", table->core_enabled2);
+               printf("\tThread Count 2: %d\n", table->thread_count2);
+       }
```
Moreover, I think the same logic should be done when the table is being
constructed in lib/smbios.c, where the real content of tables is located.

Regards,
Raymond


>         printf("\tProcessor Characteristics: 0x%04x\n",
>                table->processor_characteristics);
>         smbios_print_lookup_str(processor_family_strings,
>                                 table->processor_family2,
>                                 ARRAY_SIZE(processor_family_strings),
>                                 "Processor Family 2");
> -       printf("\tCore Count 2: 0x%04x\n", table->core_count2);
> -       printf("\tCore Enabled 2: 0x%04x\n", table->core_enabled2);
> -       printf("\tThread Count 2: 0x%04x\n", table->thread_count2);
> +       if (smbios_version < 0x0306)
> +               return;
>         printf("\tThread Enabled: 0x%04x\n", table->thread_enabled);
>  }
>
> @@ -719,6 +726,8 @@ static int do_smbios(struct cmd_tbl *cmdtp, int flag,
> int argc,
>                 struct smbios3_entry *entry3 =3D entry;
>
>                 table =3D (void *)(uintptr_t)entry3->struct_table_address=
;
> +               smbios_version =3D ((u16)entry3->major_ver << 16) +
> +                                (u16)entry3->minor_ver;
>                 snprintf(version, sizeof(version), "%d.%d.%d",
>                          entry3->major_ver, entry3->minor_ver,
> entry3->doc_rev);
>                 table =3D (void *)(uintptr_t)entry3->struct_table_address=
;
> --
> 2.51.0
>
>
