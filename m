Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B52EC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD748773A;
	Wed, 29 Nov 2023 19:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="TC10YG7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55B508773A; Wed, 29 Nov 2023 19:34:42 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB9B186940
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a00b056ca38so9500866b.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701282879; x=1701887679;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BcfaHusf62H4DvHlZa4K3zO3ps7G18G/aLv5w7EO6Nw=;
 b=TC10YG7AfXeWrCF0VoGFeYKCHIDY9hun71Ns9QEn2fGAD0J1nJHxY3payGue6E5UfL
 5qk5QTYJjnCkyQKuUEvO/CQypAc26/6doENSpOm+F2gwANjue9eNfYAn/QQnnEkjVVxA
 Zd1i39Sp7RWo2zU7nzZJ7ozwmMRW/bnGSZJn29DJ33t6nEQU0kZWXcMfKJEgFSTSHTMF
 LDm8VomfzGngVUiKKN3U9H0lFm58Jl5H4y1qwNqvDzveYXs+3VRJA+6565c+kC6a+N3S
 8oAfIpy6EqqA2M+ZQqNYlM2fFFX9JF28F4/LZmA2SkjyDrCmFXo2Q7+sq0Gj4Jq1vkUn
 vGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701282879; x=1701887679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BcfaHusf62H4DvHlZa4K3zO3ps7G18G/aLv5w7EO6Nw=;
 b=tOdxn8L+FabI6vK8L9rsVBkN5NMvGIDsQqbr06uG4Cl1GH1aztvkZsPBuTHwMrQdDQ
 t3pQELv5zoVZfdEucXkqUm/Lzv/IfwK4O/rKMSEEX6+D+pAJdzfHY94ZPovmm2DK0Oa+
 ioamladd2XQRFRnbPtAl/CsgBoPG04Pzs+KRgMjmyrAHp8O9tXEzsdWKijALrNpmSOhr
 OzNxiQ97QIaFcJJvjrT8kgJ3SzhKajb+y0HbnWlyKIjNVFdib/dJOCD66FFRqwgpJF6D
 DQ/as1+1czpHc2gkUA+gls2Vhyy2l1zoiU0zAJHunhXfG/48oXDkFH1/7NtWLMtb4ny0
 9YrA==
X-Gm-Message-State: AOJu0YzMpQBnsKZU1+eG4Ne7TaDXzsQNPNsvT2LKLz+zwbWlRAt71+g/
 /6W00w8R3LGONwKH6eccNFw/UFWcpR0ZqneTVS3aZg==
X-Google-Smtp-Source: AGHT+IGxItedECbTid5LksyWbSWd3KhbKtqsXzisfzlP1fOG17cVoytlCy7VrqHteJKzrIG3/BP4Og==
X-Received: by 2002:a17:907:6023:b0:a00:163f:4b98 with SMTP id
 fs35-20020a170907602300b00a00163f4b98mr12034929ejc.44.1701282878710; 
 Wed, 29 Nov 2023 10:34:38 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 gr19-20020a170906e2d300b009de11bcbbcasm8241373ejb.175.2023.11.29.10.34.38
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 10:34:38 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-54bb5ebbb35so162692a12.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:34:38 -0800 (PST)
X-Received: by 2002:aa7:cc94:0:b0:54b:8483:7d2e with SMTP id
 p20-20020aa7cc94000000b0054b84837d2emr5853189edt.33.1701282877788; Wed, 29
 Nov 2023 10:34:37 -0800 (PST)
MIME-Version: 1.0
References: <20231124113552.112243-1-i@shantur.com>
 <20231124113552.112243-2-i@shantur.com>
 <ded6b874-48bc-408a-97b9-c43a6a59098b@gmx.de>
In-Reply-To: <ded6b874-48bc-408a-97b9-c43a6a59098b@gmx.de>
From: Shantur Rathore <i@shantur.com>
Date: Wed, 29 Nov 2023 18:34:26 +0000
X-Gmail-Original-Message-ID: <CAHc5_t0G0MC7QrwxA148=jVycJQ_djzNGQSSnHyz8F-SuzvxJw@mail.gmail.com>
Message-ID: <CAHc5_t0G0MC7QrwxA148=jVycJQ_djzNGQSSnHyz8F-SuzvxJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] efi_var_file: refactor to move buffer functions
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, Nov 29, 2023 at 5:41=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 24.11.23 12:35, Shantur Rathore wrote:
> > Currently efi_var_file.c has functions to store/read
> > EFI variables to/from memory buffer. These functions
> > can be used with other EFI variable stores so move
> > them out to efi_var_common.c
>
> The moved functions relate to filling the memory buffer of variables.
> Wouldn't lib/efi_loader/efi_var_mem.c be more appropriate as target file?
>

As I understand, efi_var_mem.c implements an in-memory store of all
EFI variables.
These functions build a / read from a buffer for writing to an
in-secure storage device ( file / SPI flash ).
The functions are only used by efi_var_sf and efi_var_file hence in
efi_var_common.

Happy to change if you want.

Kind regards,
Shantur

> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Shantur Rathore <i@shantur.com>
> > ---
> >
> > (no changes since v1)
> >
> >   include/efi_variable.h          |   5 ++
> >   lib/efi_loader/Makefile         |   2 +-
> >   lib/efi_loader/efi_var_common.c | 109 ++++++++++++++++++++++++++++
> >   lib/efi_loader/efi_var_file.c   | 121 -------------------------------=
-
> >   lib/efi_loader/efi_variable.c   |   8 ++-
> >   5 files changed, 122 insertions(+), 123 deletions(-)
> >
> > diff --git a/include/efi_variable.h b/include/efi_variable.h
> > index 805e6c5f1e..bd0a31fc3e 100644
> > --- a/include/efi_variable.h
> > +++ b/include/efi_variable.h
> > @@ -161,6 +161,11 @@ efi_status_t efi_var_to_file(void);
> >   efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **buf=
p, loff_t *lenp,
> >                                           u32 check_attr_mask);
> >
> > +/* GUID used by Shim to store the MOK database */
> > +#define SHIM_LOCK_GUID \
> > +     EFI_GUID(0x605dab50, 0xe046, 0x4300, \
> > +              0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
> > +
> >   /**
> >    * efi_var_restore() - restore EFI variables from buffer
> >    *
> > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > index 8d31fc61c6..33b1910249 100644
> > --- a/lib/efi_loader/Makefile
> > +++ b/lib/efi_loader/Makefile
> > @@ -66,7 +66,7 @@ obj-y +=3D efi_string.o
> >   obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) +=3D efi_unicode_collat=
ion.o
> >   obj-y +=3D efi_var_common.o
> >   obj-y +=3D efi_var_mem.o
> > -obj-y +=3D efi_var_file.o
> > +obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) +=3D efi_var_file.o
> >   ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
> >   obj-y +=3D efi_variable_tee.o
> >   else
> > diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_c=
ommon.c
> > index ad50bffd2b..7509c30b5a 100644
> > --- a/lib/efi_loader/efi_var_common.c
> > +++ b/lib/efi_loader/efi_var_common.c
> > @@ -10,6 +10,7 @@
> >   #include <efi_loader.h>
> >   #include <efi_variable.h>
> >   #include <stdlib.h>
> > +#include <u-boot/crc.h>
> >
> >   enum efi_secure_mode {
> >       EFI_MODE_SETUP,
> > @@ -40,6 +41,7 @@ static const struct efi_auth_var_name_type name_type[=
] =3D {
> >
> >   static bool efi_secure_boot;
> >   static enum efi_secure_mode efi_secure_mode;
> > +static const efi_guid_t shim_lock_guid =3D SHIM_LOCK_GUID;
> >
> >   /**
> >    * efi_efi_get_variable() - retrieve value of a UEFI variable
> > @@ -417,3 +419,110 @@ void *efi_get_var(const u16 *name, const efi_guid=
_t *vendor, efi_uintn_t *size)
> >
> >       return buf;
> >   }
> > +
> > +efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp=
, loff_t *lenp,
> > +                                         u32 check_attr_mask)
> > +{
> > +     size_t len =3D EFI_VAR_BUF_SIZE;
> > +     struct efi_var_file *buf;
> > +     struct efi_var_entry *var, *old_var;
> > +     size_t old_var_name_length =3D 2;
> > +
> > +     *bufp =3D NULL; /* Avoid double free() */
> > +     buf =3D calloc(1, len);
> > +     if (!buf)
> > +             return EFI_OUT_OF_RESOURCES;
> > +     var =3D buf->var;
> > +     old_var =3D var;
> > +     for (;;) {
> > +             efi_uintn_t data_length, var_name_length;
> > +             u8 *data;
> > +             efi_status_t ret;
> > +
> > +             if ((uintptr_t)buf + len <=3D
> > +                 (uintptr_t)var->name + old_var_name_length)
> > +                     return EFI_BUFFER_TOO_SMALL;
> > +
> > +             var_name_length =3D (uintptr_t)buf + len - (uintptr_t)var=
->name;
> > +             memcpy(var->name, old_var->name, old_var_name_length);
> > +             guidcpy(&var->guid, &old_var->guid);
> > +             ret =3D efi_get_next_variable_name_int(
> > +                             &var_name_length, var->name, &var->guid);
> > +             if (ret =3D=3D EFI_NOT_FOUND)
> > +                     break;
> > +             if (ret !=3D EFI_SUCCESS) {
> > +                     free(buf);
> > +                     return ret;
> > +             }
> > +             old_var_name_length =3D var_name_length;
> > +             old_var =3D var;
> > +
> > +             data =3D (u8 *)var->name + old_var_name_length;
> > +             data_length =3D (uintptr_t)buf + len - (uintptr_t)data;
> > +             ret =3D efi_get_variable_int(var->name, &var->guid,
> > +                                        &var->attr, &data_length, data=
,
> > +                                        &var->time);
> > +             if (ret !=3D EFI_SUCCESS) {
> > +                     free(buf);
> > +                     return ret;
> > +             }
> > +             if ((var->attr & check_attr_mask) =3D=3D check_attr_mask)=
 {
> > +                     var->length =3D data_length;
> > +                     var =3D (struct efi_var_entry *)ALIGN((uintptr_t)=
data + data_length, 8);
> > +             }
> > +     }
> > +
> > +     buf->reserved =3D 0;
> > +     buf->magic =3D EFI_VAR_FILE_MAGIC;
> > +     len =3D (uintptr_t)var - (uintptr_t)buf;
> > +     buf->crc32 =3D crc32(0, (u8 *)buf->var,
> > +                        len - sizeof(struct efi_var_file));
> > +     buf->length =3D len;
> > +     *bufp =3D buf;
> > +     *lenp =3D len;
> > +
> > +     return EFI_SUCCESS;
> > +}
> > +
> > +efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
> > +{
> > +     struct efi_var_entry *var, *last_var;
> > +     u16 *data;
> > +     efi_status_t ret;
> > +
> > +     if (buf->reserved || buf->magic !=3D EFI_VAR_FILE_MAGIC ||
> > +         buf->crc32 !=3D crc32(0, (u8 *)buf->var,
> > +                             buf->length - sizeof(struct efi_var_file)=
)) {
> > +             log_err("Invalid EFI variables file\n");
> > +             return EFI_INVALID_PARAMETER;
> > +     }
> > +
> > +     last_var =3D (struct efi_var_entry *)((u8 *)buf + buf->length);
> > +     for (var =3D buf->var; var < last_var;
> > +          var =3D (struct efi_var_entry *)
> > +                ALIGN((uintptr_t)data + var->length, 8)) {
> > +
> > +             data =3D var->name + u16_strlen(var->name) + 1;
> > +
> > +             /*
> > +              * Secure boot related and volatile variables shall only =
be
> > +              * restored from U-Boot's preseed.
> > +              */
> > +             if (!safe &&
> > +                 (efi_auth_var_get_type(var->name, &var->guid) !=3D
> > +                  EFI_AUTH_VAR_NONE ||
> > +                  !guidcmp(&var->guid, &shim_lock_guid) ||
> > +                  !(var->attr & EFI_VARIABLE_NON_VOLATILE)))
> > +                     continue;
> > +             if (!var->length)
> > +                     continue;
> > +             if (efi_var_mem_find(&var->guid, var->name, NULL))
> > +                     continue;
> > +             ret =3D efi_var_mem_ins(var->name, &var->guid, var->attr,
> > +                                   var->length, data, 0, NULL,
> > +                                   var->time);
> > +             if (ret !=3D EFI_SUCCESS)
> > +                     log_err("Failed to set EFI variable %ls\n", var->=
name);
> > +     }
> > +     return EFI_SUCCESS;
> > +}
> > diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_fil=
e.c
> > index d7dba05071..166501a355 100644
> > --- a/lib/efi_loader/efi_var_file.c
> > +++ b/lib/efi_loader/efi_var_file.c
> > @@ -15,17 +15,9 @@
> >   #include <mapmem.h>
> >   #include <efi_loader.h>
> >   #include <efi_variable.h>
> > -#include <u-boot/crc.h>
> >
> >   #define PART_STR_LEN 10
> >
> > -/* GUID used by Shim to store the MOK database */
> > -#define SHIM_LOCK_GUID \
> > -     EFI_GUID(0x605dab50, 0xe046, 0x4300, \
> > -              0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
> > -
> > -static const efi_guid_t shim_lock_guid =3D SHIM_LOCK_GUID;
> > -
> >   /**
> >    * efi_set_blk_dev_to_system_partition() - select EFI system partitio=
n
> >    *
> > @@ -53,70 +45,6 @@ static efi_status_t __maybe_unused efi_set_blk_dev_t=
o_system_partition(void)
> >       return EFI_SUCCESS;
> >   }
> >
> > -efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp=
, loff_t *lenp,
> > -                                         u32 check_attr_mask)
> > -{
> > -     size_t len =3D EFI_VAR_BUF_SIZE;
> > -     struct efi_var_file *buf;
> > -     struct efi_var_entry *var, *old_var;
> > -     size_t old_var_name_length =3D 2;
> > -
> > -     *bufp =3D NULL; /* Avoid double free() */
> > -     buf =3D calloc(1, len);
> > -     if (!buf)
> > -             return EFI_OUT_OF_RESOURCES;
> > -     var =3D buf->var;
> > -     old_var =3D var;
> > -     for (;;) {
> > -             efi_uintn_t data_length, var_name_length;
> > -             u8 *data;
> > -             efi_status_t ret;
> > -
> > -             if ((uintptr_t)buf + len <=3D
> > -                 (uintptr_t)var->name + old_var_name_length)
> > -                     return EFI_BUFFER_TOO_SMALL;
> > -
> > -             var_name_length =3D (uintptr_t)buf + len - (uintptr_t)var=
->name;
> > -             memcpy(var->name, old_var->name, old_var_name_length);
> > -             guidcpy(&var->guid, &old_var->guid);
> > -             ret =3D efi_get_next_variable_name_int(
> > -                             &var_name_length, var->name, &var->guid);
> > -             if (ret =3D=3D EFI_NOT_FOUND)
> > -                     break;
> > -             if (ret !=3D EFI_SUCCESS) {
> > -                     free(buf);
> > -                     return ret;
> > -             }
> > -             old_var_name_length =3D var_name_length;
> > -             old_var =3D var;
> > -
> > -             data =3D (u8 *)var->name + old_var_name_length;
> > -             data_length =3D (uintptr_t)buf + len - (uintptr_t)data;
> > -             ret =3D efi_get_variable_int(var->name, &var->guid,
> > -                                        &var->attr, &data_length, data=
,
> > -                                        &var->time);
> > -             if (ret !=3D EFI_SUCCESS) {
> > -                     free(buf);
> > -                     return ret;
> > -             }
> > -             if ((var->attr & check_attr_mask) =3D=3D check_attr_mask)=
 {
> > -                     var->length =3D data_length;
> > -                     var =3D (struct efi_var_entry *)ALIGN((uintptr_t)=
data + data_length, 8);
> > -             }
> > -     }
> > -
> > -     buf->reserved =3D 0;
> > -     buf->magic =3D EFI_VAR_FILE_MAGIC;
> > -     len =3D (uintptr_t)var - (uintptr_t)buf;
> > -     buf->crc32 =3D crc32(0, (u8 *)buf->var,
> > -                        len - sizeof(struct efi_var_file));
> > -     buf->length =3D len;
> > -     *bufp =3D buf;
> > -     *lenp =3D len;
> > -
> > -     return EFI_SUCCESS;
> > -}
> > -
> >   /**
> >    * efi_var_to_file() - save non-volatile variables as file
> >    *
> > @@ -126,7 +54,6 @@ efi_status_t __maybe_unused efi_var_collect(struct e=
fi_var_file **bufp, loff_t *
> >    */
> >   efi_status_t efi_var_to_file(void)
> >   {
> > -#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
> >       efi_status_t ret;
> >       struct efi_var_file *buf;
> >       loff_t len;
> > @@ -150,52 +77,6 @@ error:
> >               log_err("Failed to persist EFI variables\n");
> >       free(buf);
> >       return ret;
> > -#else
> > -     return EFI_SUCCESS;
> > -#endif
> > -}
> > -
> > -efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
> > -{
> > -     struct efi_var_entry *var, *last_var;
> > -     u16 *data;
> > -     efi_status_t ret;
> > -
> > -     if (buf->reserved || buf->magic !=3D EFI_VAR_FILE_MAGIC ||
> > -         buf->crc32 !=3D crc32(0, (u8 *)buf->var,
> > -                             buf->length - sizeof(struct efi_var_file)=
)) {
> > -             log_err("Invalid EFI variables file\n");
> > -             return EFI_INVALID_PARAMETER;
> > -     }
> > -
> > -     last_var =3D (struct efi_var_entry *)((u8 *)buf + buf->length);
> > -     for (var =3D buf->var; var < last_var;
> > -          var =3D (struct efi_var_entry *)
> > -                ALIGN((uintptr_t)data + var->length, 8)) {
> > -
> > -             data =3D var->name + u16_strlen(var->name) + 1;
> > -
> > -             /*
> > -              * Secure boot related and volatile variables shall only =
be
> > -              * restored from U-Boot's preseed.
> > -              */
> > -             if (!safe &&
> > -                 (efi_auth_var_get_type(var->name, &var->guid) !=3D
> > -                  EFI_AUTH_VAR_NONE ||
> > -                  !guidcmp(&var->guid, &shim_lock_guid) ||
> > -                  !(var->attr & EFI_VARIABLE_NON_VOLATILE)))
> > -                     continue;
> > -             if (!var->length)
> > -                     continue;
> > -             if (efi_var_mem_find(&var->guid, var->name, NULL))
> > -                     continue;
> > -             ret =3D efi_var_mem_ins(var->name, &var->guid, var->attr,
> > -                                   var->length, data, 0, NULL,
> > -                                   var->time);
> > -             if (ret !=3D EFI_SUCCESS)
> > -                     log_err("Failed to set EFI variable %ls\n", var->=
name);
> > -     }
> > -     return EFI_SUCCESS;
> >   }
> >
> >   /**
> > @@ -214,7 +95,6 @@ efi_status_t efi_var_restore(struct efi_var_file *bu=
f, bool safe)
> >    */
> >   efi_status_t efi_var_from_file(void)
> >   {
> > -#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
> >       struct efi_var_file *buf;
> >       loff_t len;
> >       efi_status_t ret;
> > @@ -239,6 +119,5 @@ efi_status_t efi_var_from_file(void)
> >               log_err("Invalid EFI variables file\n");
> >   error:
> >       free(buf);
> > -#endif
> >       return EFI_SUCCESS;
> >   }
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variabl=
e.c
> > index be95ed44e6..adc5ac6a80 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -357,8 +357,11 @@ efi_status_t efi_set_variable_int(const u16 *varia=
ble_name,
> >        * Write non-volatile EFI variables to file
> >        * TODO: check if a value change has occured to avoid superfluous=
 writes
> >        */
> > -     if (attributes & EFI_VARIABLE_NON_VOLATILE)
> > +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> > +     if (attributes & EFI_VARIABLE_NON_VOLATILE) {
> >               efi_var_to_file();
> > +     }
> > +#endif
> >
> >       return EFI_SUCCESS;
> >   }
> > @@ -466,9 +469,12 @@ efi_status_t efi_init_variables(void)
> >       if (ret !=3D EFI_SUCCESS)
> >               return ret;
> >
> > +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> >       ret =3D efi_var_from_file();
> >       if (ret !=3D EFI_SUCCESS)
> >               return ret;
> > +#endif
> > +
> >       if (IS_ENABLED(CONFIG_EFI_VARIABLES_PRESEED)) {
> >               ret =3D efi_var_restore((struct efi_var_file *)
> >                                     __efi_var_file_begin, true);
>
