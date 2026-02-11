Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905DFE9E311
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 15:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B878583A47;
	Wed, 11 Feb 2026 16:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BQRVVuy9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65E9683B64; Wed, 11 Feb 2026 16:04:42 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2628883015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 16:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-79627af6349so23801547b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 07:04:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770822277; cv=none;
 d=google.com; s=arc-20240605;
 b=gA0BWUQ8jgPMH/fhj9/tEzs9ZqTV7bQaYwAqyYb/SvjfUmzAm2IV/4aSjF3QLN/d7I
 /a2xmMoC1cuw7QW3lFvBCc4aTBX/q1qdDVX5J+qQmFLUNgPw8pYOwSQFxsmznH13bF2/
 6nwcmjD4EnP3s37+ugG+O7SRjJ4qeXuzlwlGJh8pS98dbSk7fCgrgRQ9526tXUjuBcZC
 eJ4F4//wmv+FVadNn5JIFtLGMRBdPfLcAh6qcHpom2JpywBpw1jFcOhBK29wPmtVUBh6
 tZu9W1dqPu2a2z3ZIKtw9E+Bs2wD0yoDTKJmTD60AH+D72Rs0sLHG4quguhkWS3BH4gc
 IRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K36bUboZh5/L45ESp0Q6eQKda129VjQirL9TP1XBGd4=;
 fh=scYkI2pdHmhnl5JNcajeOeRDElDDCijDpN9lSr2JUsY=;
 b=Plr2tU0g4z/h+dVRNR95f26uGR7mOVPoU4pnwSqEzS4e6UTWUK7azuqzR4OtAv+6NA
 0NPF9yqmNe15d1+BBxpDqP2cCKbQku3x7QiiQFUWUpxkB3TOqwdQeLHvNSfIOJQ74+/a
 kWWpSiWF8c1+CfmbZRUDCaEfo2cqpaPqA+eTcU6iebqJDz20NeMaMMVzA1eNsgRapmUh
 6+1AVMWGX85fp9B1naSqiZeBhWpLszHxrHNHOv7CvrChv/dLcjOu1Por8LKbagUAI6Z/
 XQXIKmv+3PDr5qmrrvtCeO4wlqXZ34wtGBcujeO3c4CjXygI6kZ2cG4P/Scv/VQILG/P
 B8gA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770822277; x=1771427077; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K36bUboZh5/L45ESp0Q6eQKda129VjQirL9TP1XBGd4=;
 b=BQRVVuy91hUg+ypgxNLhXkmw/Hhc7OhC8pM/85p2Kf0JSY9I3mlmLGi5g8NTqs2O+g
 ccs+GW+xkdqSqlxqLUVFpyzEJHCwv1u02gnNaEOCfkqRweRtVtnCxifasNyvU/lcCWaI
 esk284o0zaup2RLMnW6rR/+k7cT3B2BSCQ6KsfINbWkroKP5gjJxUDByHUrKKJbnD+Od
 hrY5gZi7IPWraMPxELT24aG3jupXUhKJ0wSJHTbJ/sbTfjAZBwK6cxk7ezBz5ivjeqOa
 Ae/uWd/MfBsp3lg2/aVV9TDA0tHpLlN/AB9kb6YyaI5OyoEDz6gPjRxA0UjBCzCF1Ijg
 vcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770822277; x=1771427077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K36bUboZh5/L45ESp0Q6eQKda129VjQirL9TP1XBGd4=;
 b=akGEcPFu1lIHCIULn/sK908sz+/7vsvFe+PqddyEK7by5Y/aAdlj1fR/ypQO42Y69p
 2GrGqI778N2SgzpQtF6NzvvvWkSLxsPzYURi+HebTWJCA6tnDQ0voF8pyzH3o4lhfCPL
 oCvF0cKgPyWAy+tFmM688eb7trchQVlUqOYfp8tXW15E18Rzd183wyabRDSAbHWMPs6I
 A0ix/xzhzh5F8zetiyo+45uzeDtFW5y7DJRgG72UP/wxK0gbSaLlQPMiOPuBW7QC8Qz9
 C/OxOLqT5f73id3uXm81rA+HyQiH6V8Z5p5cdsglzGO8HeKmzKMOctvW/Om//MxmlzaJ
 DQYg==
X-Gm-Message-State: AOJu0YwNvdUEEBWTXmU3HG6HYdB+bJrF8qf8mKjh3363b2CsBm85laE7
 LWOwlOlk4eTIko4YVNZ3vR+dAeyM+txzWQ9GujiO2BJKUkWmz1e75ajXk1dUyyiBsjSmjTOVxg+
 3FmfX3go/iVkGwgpCq08WwOxI6VfNeqN98tL2p9nzmg==
X-Gm-Gg: AZuq6aJAKX/x5UVZt14Q+Ufs6+A9Dqge9WtjVHg+YYSXaphqwAlZJFOGMknBmWnzSBv
 JmK3zBbI0K8WDOOo50NDmAobSCtIhR/DADw1SMp06I7i6mP/T9YbTjscNZvz++4KWShp5bvbUdi
 n5nIP2iHHuXg8k4Ulj1+sWGzM2oC7Xi53X/TSs4dSKIhgLSRuLQYqktTkS2rgcWaNjEFDdccQ3b
 eeXj3wKjwlrHABmE+44NwHngvhUzAbYKntOfT1nlO/LCped2z7aoYW3hT6ZmE0+KRuu1dVdDkVj
 s1HgYJmtZBVsBt5BXYPTwPxCKmls+zxCKoc+Uoe2PMQU3gemZ0SNFO1F6AfxVsJIRKPxGK+05EF
 IdkO14cXqpEAmcsJmyMPfCNZ3NXwyjATg6Ps9IirZF+KW7eYnvTOXbVxvTStQZdI8Imk5SbNi+0
 HN5YD2NyfJ5psyPf85odktsAFra281rJlsBQBAuVEHaRyF6Igkd9twnFQxqOnWod8LdtGkVhbc1
 K6QWiqSExLzVXFmvAB7FgBVG9vZKy/4Aw2HNct6bB9NXJ38usmhA9a+0CO+QL59/JJ4NtluzZAL
 XNMZO2enford98Y9+M3VOOirhG6SGjY5L3iaNOv3daX4
X-Received: by 2002:a05:690c:9a0c:b0:796:3c99:1833 with SMTP id
 00721157ae682-7963c992586mr220059407b3.60.1770822276202; Wed, 11 Feb 2026
 07:04:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770119483.git.michal.simek@amd.com>
 <1f50d76c2370b9b032e73c35c05246cc70255b28.1770119483.git.michal.simek@amd.com>
 <CAC_iWjKxshi4fEtUvvrwGrd8quSUNeeuqjTV=gFrW4x6uXi55A@mail.gmail.com>
In-Reply-To: <CAC_iWjKxshi4fEtUvvrwGrd8quSUNeeuqjTV=gFrW4x6uXi55A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Feb 2026 17:04:00 +0200
X-Gm-Features: AZwV_QgMzWOHjAAh2Na5oCMGPidgHyNEsPfNlLj9DiitwHcdYF935NoUiS-pOpA
Message-ID: <CAC_iWjKyuoFAVVTv=+tajWJoYtEv4bxebWMAxqUehSEk2YMQaQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi_var_file: refactor to move buffer functions
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, Shantur Rathore <i@shantur.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

So this fails for a weird reason

Some boards don't have FAT_WRTE. It seems that the Kconfig order
matters and those boards pick the new option if SPI is enabled.

This fixes it

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index c13cb8952caa..0f6f927ddaf1 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -112,7 +112,8 @@ menu "UEFI Variables"

 choice
        prompt "Store for non-volatile UEFI variables"
-       default EFI_VARIABLE_FILE_STORE
+       default EFI_VARIABLE_FILE_STORE if FAT_WRITE
+       default EFI_VARIABLE_NO_STORE
        help
          Select where non-volatile UEFI variables shall be stored.

On Wed, 11 Feb 2026 at 11:53, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Michael
>
> The CI seems to fail on this one for some reason.
> https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/29248
>
> Can you take a look ?
>
> Thanks
> /Ilias
>
>
>
>
> On Tue, 3 Feb 2026 at 13:51, Michal Simek <michal.simek@amd.com> wrote:
> >
> > From: Shantur Rathore <i@shantur.com>
> >
> > Currently efi_var_file.c has functions to store/read
> > EFI variables to/from memory buffer. These functions
> > can be used with other EFI variable stores so move
> > them out to efi_var_common.c
> >
> > Signed-off-by: Shantur Rathore <i@shantur.com>
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > ---
> >
> > (no changes since v6)
> >
> > Changes in v6:
> > - Return EFI_SUCCESS in efi_set_variable_int() when
> >   CONFIG_EFI_VARIABLE_NO_STORE is enabled
> >
> > Changes in v5:
> > - Invert logic in efi_variable.c and avoid #if
> >
> >  include/efi_variable.h          |  5 +++
> >  lib/efi_loader/Makefile         |  2 +-
> >  lib/efi_loader/efi_var_common.c | 42 ++++++++++++++++++++++++
> >  lib/efi_loader/efi_var_file.c   | 57 ---------------------------------
> >  lib/efi_loader/efi_variable.c   | 17 +++++++---
> >  5 files changed, 60 insertions(+), 63 deletions(-)
> >
> > diff --git a/include/efi_variable.h b/include/efi_variable.h
> > index 4065cf45ecaf..ee68fa4a885f 100644
> > --- a/include/efi_variable.h
> > +++ b/include/efi_variable.h
> > @@ -161,6 +161,11 @@ efi_status_t efi_var_to_file(void);
> >  efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *lenp,
> >                                             u32 check_attr_mask);
> >
> > +/* GUID used by Shim to store the MOK database */
> > +#define SHIM_LOCK_GUID \
> > +       EFI_GUID(0x605dab50, 0xe046, 0x4300, \
> > +                0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
> > +
> >  /**
> >   * efi_var_restore() - restore EFI variables from buffer
> >   *
> > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > index f490081f6542..ca1775eb03be 100644
> > --- a/lib/efi_loader/Makefile
> > +++ b/lib/efi_loader/Makefile
> > @@ -53,7 +53,7 @@ ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
> >  obj-y += efi_variable_tee.o
> >  else
> >  obj-y += efi_variable.o
> > -obj-y += efi_var_file.o
> > +obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o
> >  obj-$(CONFIG_EFI_VARIABLES_PRESEED) += efi_var_seed.o
> >  endif
> >  obj-y += efi_watchdog.o
> > diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
> > index 4b34a58b4cf7..5ea1688dca3d 100644
> > --- a/lib/efi_loader/efi_var_common.c
> > +++ b/lib/efi_loader/efi_var_common.c
> > @@ -41,6 +41,7 @@ static const struct efi_auth_var_name_type name_type[] = {
> >
> >  static bool efi_secure_boot;
> >  static enum efi_secure_mode efi_secure_mode;
> > +static const efi_guid_t shim_lock_guid = SHIM_LOCK_GUID;
> >
> >  /**
> >   * efi_efi_get_variable() - retrieve value of a UEFI variable
> > @@ -488,3 +489,44 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
> >
> >         return EFI_SUCCESS;
> >  }
> > +
> > +efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
> > +{
> > +       struct efi_var_entry *var, *last_var;
> > +       u16 *data;
> > +       efi_status_t ret;
> > +
> > +       if (buf->reserved || buf->magic != EFI_VAR_FILE_MAGIC ||
> > +           buf->crc32 != crc32(0, (u8 *)buf->var,
> > +                               buf->length - sizeof(struct efi_var_file))) {
> > +               log_err("Invalid EFI variables file\n");
> > +               return EFI_INVALID_PARAMETER;
> > +       }
> > +
> > +       last_var = (struct efi_var_entry *)((u8 *)buf + buf->length);
> > +       for (var = buf->var; var < last_var;
> > +            var = (struct efi_var_entry *)ALIGN((uintptr_t)data + var->length, 8)) {
> > +               data = var->name + u16_strlen(var->name) + 1;
> > +
> > +               /*
> > +                * Secure boot related and volatile variables shall only be
> > +                * restored from U-Boot's preseed.
> > +                */
> > +               if (!safe &&
> > +                   (efi_auth_var_get_type(var->name, &var->guid) !=
> > +                    EFI_AUTH_VAR_NONE ||
> > +                    !guidcmp(&var->guid, &shim_lock_guid) ||
> > +                    !(var->attr & EFI_VARIABLE_NON_VOLATILE)))
> > +                       continue;
> > +               if (!var->length)
> > +                       continue;
> > +               if (efi_var_mem_find(&var->guid, var->name, NULL))
> > +                       continue;
> > +               ret = efi_var_mem_ins(var->name, &var->guid, var->attr,
> > +                                     var->length, data, 0, NULL,
> > +                                     var->time);
> > +               if (ret != EFI_SUCCESS)
> > +                       log_err("Failed to set EFI variable %ls\n", var->name);
> > +       }
> > +       return EFI_SUCCESS;
> > +}
> > diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
> > index ba0bf33ffbd1..d32edaac277d 100644
> > --- a/lib/efi_loader/efi_var_file.c
> > +++ b/lib/efi_loader/efi_var_file.c
> > @@ -14,17 +14,9 @@
> >  #include <mapmem.h>
> >  #include <efi_loader.h>
> >  #include <efi_variable.h>
> > -#include <u-boot/crc.h>
> >
> >  #define PART_STR_LEN 10
> >
> > -/* GUID used by Shim to store the MOK database */
> > -#define SHIM_LOCK_GUID \
> > -       EFI_GUID(0x605dab50, 0xe046, 0x4300, \
> > -                0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
> > -
> > -static const efi_guid_t shim_lock_guid = SHIM_LOCK_GUID;
> > -
> >  /**
> >   * efi_set_blk_dev_to_system_partition() - select EFI system partition
> >   *
> > @@ -59,7 +51,6 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to_system_partition(void)
> >   */
> >  efi_status_t efi_var_to_file(void)
> >  {
> > -#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
> >         efi_status_t ret;
> >         struct efi_var_file *buf;
> >         loff_t len;
> > @@ -91,52 +82,6 @@ error:
> >  out:
> >         free(buf);
> >         return ret;
> > -#else
> > -       return EFI_SUCCESS;
> > -#endif
> > -}
> > -
> > -efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
> > -{
> > -       struct efi_var_entry *var, *last_var;
> > -       u16 *data;
> > -       efi_status_t ret;
> > -
> > -       if (buf->reserved || buf->magic != EFI_VAR_FILE_MAGIC ||
> > -           buf->crc32 != crc32(0, (u8 *)buf->var,
> > -                               buf->length - sizeof(struct efi_var_file))) {
> > -               log_err("Invalid EFI variables file\n");
> > -               return EFI_INVALID_PARAMETER;
> > -       }
> > -
> > -       last_var = (struct efi_var_entry *)((u8 *)buf + buf->length);
> > -       for (var = buf->var; var < last_var;
> > -            var = (struct efi_var_entry *)
> > -                  ALIGN((uintptr_t)data + var->length, 8)) {
> > -
> > -               data = var->name + u16_strlen(var->name) + 1;
> > -
> > -               /*
> > -                * Secure boot related and volatile variables shall only be
> > -                * restored from U-Boot's preseed.
> > -                */
> > -               if (!safe &&
> > -                   (efi_auth_var_get_type(var->name, &var->guid) !=
> > -                    EFI_AUTH_VAR_NONE ||
> > -                    !guidcmp(&var->guid, &shim_lock_guid) ||
> > -                    !(var->attr & EFI_VARIABLE_NON_VOLATILE)))
> > -                       continue;
> > -               if (!var->length)
> > -                       continue;
> > -               if (efi_var_mem_find(&var->guid, var->name, NULL))
> > -                       continue;
> > -               ret = efi_var_mem_ins(var->name, &var->guid, var->attr,
> > -                                     var->length, data, 0, NULL,
> > -                                     var->time);
> > -               if (ret != EFI_SUCCESS)
> > -                       log_err("Failed to set EFI variable %ls\n", var->name);
> > -       }
> > -       return EFI_SUCCESS;
> >  }
> >
> >  /**
> > @@ -155,7 +100,6 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
> >   */
> >  efi_status_t efi_var_from_file(void)
> >  {
> > -#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
> >         struct efi_var_file *buf;
> >         loff_t len;
> >         efi_status_t ret;
> > @@ -180,6 +124,5 @@ efi_status_t efi_var_from_file(void)
> >                 log_err("Invalid EFI variables file\n");
> >  error:
> >         free(buf);
> > -#endif
> >         return EFI_SUCCESS;
> >  }
> > diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> > index f3533f4def3a..6e45134c61bf 100644
> > --- a/lib/efi_loader/efi_variable.c
> > +++ b/lib/efi_loader/efi_variable.c
> > @@ -397,11 +397,15 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> >                 ret = EFI_SUCCESS;
> >
> >         /*
> > -        * Write non-volatile EFI variables to file
> > +        * Write non-volatile EFI variables
> >          * TODO: check if a value change has occured to avoid superfluous writes
> >          */
> > -       if (attributes & EFI_VARIABLE_NON_VOLATILE)
> > +       if (attributes & EFI_VARIABLE_NON_VOLATILE) {
> > +               if (IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE))
> > +                       return EFI_SUCCESS;
> > +
> >                 efi_var_to_file();
> > +       }
> >
> >         return EFI_SUCCESS;
> >  }
> > @@ -594,9 +598,12 @@ efi_status_t efi_init_variables(void)
> >         if (ret != EFI_SUCCESS)
> >                 return ret;
> >
> > -       ret = efi_var_from_file();
> > -       if (ret != EFI_SUCCESS)
> > -               return ret;
> > +       if (!IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE)) {
> > +               ret = efi_var_from_file();
> > +               if (ret != EFI_SUCCESS)
> > +                       return ret;
> > +       }
> > +
> >         if (IS_ENABLED(CONFIG_EFI_VARIABLES_PRESEED)) {
> >                 ret = efi_var_restore((struct efi_var_file *)
> >                                       __efi_var_file_begin, true);
> > --
> > 2.43.0
> >
