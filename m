Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC54C47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 14:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F41F87718;
	Mon,  1 Jan 2024 15:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DDY7ewBj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74CFB87721; Mon,  1 Jan 2024 15:43:37 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34DFF871CC
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 15:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5553f251e3cso3423548a12.2
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 06:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704120214; x=1704725014; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REuD/SkG8xk3l720G8FLSHYmJJxIEMEqlAQotCVzUqc=;
 b=DDY7ewBjKR9bdP0SnQhUBm+eJsbOZlFjNpQBYikvP0zV+giWGRYHXFJkPXH9pEigaJ
 mfaEW8WJmi24NkEy6J82dLMyQktWmFrweifL56iCs2l5k8OsUkZ0/l2c7ighUXmjuRV/
 UHWk6Qgb2/2FUjthIFCfTwO6zRAaAeNOlfRS8V8oJOo1kM/lYJy76IN0ds59Qt7eOXdw
 MYPkTGgs2hrF9QDUp/1tske1UoEzXy1EjzyKyWQx7K2xYs1I3n3azLPxODr29Opp1D/a
 9UY4jTQk65E/7tCAbSPQM0q3M+lwtDAIYM/D6Omhq8MsVAphCmS6uRF7Zq/4lHzziIG1
 Ycmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704120214; x=1704725014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REuD/SkG8xk3l720G8FLSHYmJJxIEMEqlAQotCVzUqc=;
 b=Ms/mOEq3qrRDbWzHZ3S7sl8RYiO25jsLhIi6mikpaVc3JwDOxlfoQfylLSyuD0m4s1
 ZKr5YsgCKWdJrc7GK2TozZiFAfFqwZHTue3acnhRR1PluPiS4vMCCkNi6aeKeHVhmvvG
 8HpjVjUaiucp5v6NkATDGkCFMb7y0edEYE6vt3wvhMdZJ+JzPFtlSB+ws+PchKEfjSAF
 ERgFklX0zBTQxbjkuRMzskJBPg1zNbOOoefv3evWvV6tHRTH5N2EUjIMSoTwlwoY9Knd
 7ia0QJ+bJy9E85hgnZcE0IpUJyIKiPweMBtrm2qyjyNkNbqVLGcoOX/9mP1nrG2NA0mc
 CaWQ==
X-Gm-Message-State: AOJu0YysdZgcjxBBk0eWMI1erXFdWTLK+LvEl9UXw0Cn4O1UL2laXEBp
 /aH3/yUyKqKzY9zIqnOhSmfU7ds1FLjeU/UtCHA=
X-Google-Smtp-Source: AGHT+IH09xmN3IY9qkns+2bXrHLQLmh852ME7A04jmA7TbJ2fXmSf1ckVEHHRLtvNpxcgXmklhBXH7mYCkzoY68XL2Y=
X-Received: by 2002:a50:8d5a:0:b0:555:b361:4791 with SMTP id
 t26-20020a508d5a000000b00555b3614791mr3064207edt.60.1704120214417; Mon, 01
 Jan 2024 06:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-9-sjg@chromium.org>
In-Reply-To: <20231231152555.464874-9-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 1 Jan 2024 14:43:23 +0000
Message-ID: <CALeDE9NxUh1rK9TFQEXLd41hdEs0p3e-kpJdY4ZFyJb_asKHzA@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] smbios: Drop support for SMBIOS2 tables
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Sun, Dec 31, 2023 at 3:26=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> These tables are a pain since there is no way to handle memory above
> 4GB. Use SMBIOS3 always.
>
> This should hopefully not create problems on x86 devices, since SMBIOS3
> was released seven years ago (2015).
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

It's also worth noting here the aarch64 Server Base Boot Requirements
(SBBR) has required SMBIOS v3 since version 1.0 of the spec [1].

[1] https://documentation-service.arm.com/static/5fb7e5adca04df4095c1d64d

> ---
>
> Changes in v5:
> - Add new patch to drop support for SMBIOS2 tables
>
>  lib/smbios.c | 76 ++++++++++++----------------------------------------
>  1 file changed, 17 insertions(+), 59 deletions(-)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index cfd451e4088..d9d52bd58d7 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -545,13 +545,12 @@ ulong write_smbios_table(ulong addr)
>  {
>         ofnode parent_node =3D ofnode_null();
>         ulong table_addr, start_addr;
> +       struct smbios3_entry *se;
>         struct smbios_ctx ctx;
>         ulong tables;
>         int len =3D 0;
>         int max_struct_size =3D 0;
>         int handle =3D 0;
> -       char *istart;
> -       int isize;
>         int i;
>
>         ctx.node =3D ofnode_null();
> @@ -565,12 +564,8 @@ ulong write_smbios_table(ulong addr)
>
>         start_addr =3D addr;
>
> -       /*
> -        * So far we don't know which struct will be used, but they both =
end
> -        * up using the same amount of 16-bit-aligned space
> -        */
> -       addr +=3D max(sizeof(struct smbios_entry), sizeof(struct smbios3_=
entry));
> -       addr =3D ALIGN(addr, 16);
> +       /* move past the (so-far-unwritten) header to start writing struc=
ts */
> +       addr =3D ALIGN(addr + sizeof(struct smbios3_entry), 16);
>         tables =3D addr;
>
>         /* populate minimum required tables */
> @@ -592,59 +587,22 @@ ulong write_smbios_table(ulong addr)
>          * We must use a pointer here so things work correctly on sandbox=
. The
>          * user of this table is not aware of the mapping of addresses to
>          * sandbox's DRAM buffer.
> -        *
> -        * Check the address of the end of the tables. If it is above 4GB=
 then
> -        * it is sensible to use SMBIOS3 even if the start of the table i=
s below
> -        * 4GB (this case is very unlikely to happen in practice)
>          */
>         table_addr =3D (ulong)map_sysmem(tables, 0);
> -       if (sizeof(table_addr) > sizeof(u32) && addr >=3D (ulong)UINT_MAX=
) {
> -               struct smbios3_entry *se;
> -               /*
> -                * We need to put this >32-bit pointer into the table but=
 the
> -                * field is only 32 bits wide.
> -                */
> -               log_debug("WARNING: Using SMBIOS3.0 due to table-address =
overflow %lx\n",
> -                         table_addr);
> -               se =3D map_sysmem(start_addr, sizeof(struct smbios_entry)=
);
> -               memset(se, '\0', sizeof(struct smbios_entry));
> -               memcpy(se->anchor, "_SM3_", 5);
> -               se->length =3D sizeof(struct smbios3_entry);
> -               se->major_ver =3D SMBIOS_MAJOR_VER;
> -               se->minor_ver =3D SMBIOS_MINOR_VER;
> -               se->doc_rev =3D 0;
> -               se->entry_point_rev =3D 1;
> -               se->max_struct_size =3D len;
> -               se->struct_table_address =3D table_addr;
> -               se->checksum =3D table_compute_checksum(se,
> -                                               sizeof(struct smbios3_ent=
ry));
> -       } else {
> -               struct smbios_entry *se;
> -
> -               se =3D map_sysmem(start_addr, sizeof(struct smbios_entry)=
);
> -               memset(se, '\0', sizeof(struct smbios_entry));
> -               memcpy(se->anchor, "_SM_", 4);
> -               se->length =3D sizeof(struct smbios_entry);
> -               se->major_ver =3D SMBIOS_MAJOR_VER;
> -               se->minor_ver =3D SMBIOS_MINOR_VER;
> -               se->max_struct_size =3D max_struct_size;
> -               memcpy(se->intermediate_anchor, "_DMI_", 5);
> -               se->struct_table_length =3D len;
> -
> -               se->struct_table_address =3D table_addr;
> -
> -               se->struct_count =3D handle;
> -
> -               /* calculate checksums */
> -               istart =3D (char *)se + SMBIOS_INTERMEDIATE_OFFSET;
> -               isize =3D sizeof(struct smbios_entry) -
> -                       SMBIOS_INTERMEDIATE_OFFSET;
> -               se->intermediate_checksum =3D table_compute_checksum(ista=
rt,
> -                                                                  isize)=
;
> -               se->checksum =3D table_compute_checksum(se,
> -                                             sizeof(struct smbios_entry)=
);
> -               unmap_sysmem(se);
> -       }
> +
> +       /* now go back and write the SMBIOS3 header */
> +       se =3D map_sysmem(start_addr, sizeof(struct smbios_entry));
> +       memset(se, '\0', sizeof(struct smbios_entry));
> +       memcpy(se->anchor, "_SM3_", 5);
> +       se->length =3D sizeof(struct smbios3_entry);
> +       se->major_ver =3D SMBIOS_MAJOR_VER;
> +       se->minor_ver =3D SMBIOS_MINOR_VER;
> +       se->doc_rev =3D 0;
> +       se->entry_point_rev =3D 1;
> +       se->max_struct_size =3D len;
> +       se->struct_table_address =3D table_addr;
> +       se->checksum =3D table_compute_checksum(se, sizeof(struct smbios3=
_entry));
> +       unmap_sysmem(se);
>
>         return addr;
>  }
> --
> 2.34.1
>
