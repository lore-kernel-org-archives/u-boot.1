Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE883E7717F
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 02:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 242468919C;
	Mon,  9 Dec 2024 03:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IUaDOQP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5513895BE; Mon,  9 Dec 2024 03:29:05 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC4B88E51
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 03:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa51bf95ce1so389345266b.3
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 18:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733711343; x=1734316143; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BGNGKq3d8LBSPXV0Mv7JLP97vwHiZ61n0AYN7A11sH4=;
 b=IUaDOQP++plsf+HltN4D+EITxPgyCgoQKnVgS5RR5r5FyX1mF5pq4c2ZabHcRnsCDE
 6dL3C0K/Vhj1XzRIbkLC+zyHhBnHessrr6XzN53jt6dfn3zYF2CgJnJLSaRQOvHYMiTP
 ULqFAvTJ9B0zbxiUkv+YFYKt5x1nTI6yForiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733711343; x=1734316143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BGNGKq3d8LBSPXV0Mv7JLP97vwHiZ61n0AYN7A11sH4=;
 b=heP20Og3jVU8CzVfbQaGRVhbEBRoyTZYI6t/pPIKz1zUycVk7xWpY2zsZWPKwBYjwX
 bf4CyxXpJkhpk0RDWecsgWjFhumGoZSbTtbg8mhtq1ihDP2ywdQwNwW0yJ9DEMZiHDzv
 DNlmCMQmVq58W4N1UtMmd4PvkKiN+WPVbndEztgQU0bJ9De0VuQLfayONTcoMtovkP3W
 RyOxwhXcd38jBOjZ1d3MoV9yr9oqBgemIjzXYNiw78b6yXSp+YPeR/467wQToIgBuv/w
 mw1k2urBNVYUr3WkkPgh+v7cgwkhPNy6xuOutGMMgZsDD1XNBsDF/wWuGe0BldU9uEHz
 kx8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/RSnNpxT4OjZZoLGsJAbVUkS6NodiU97o2t0but68fR9nExDa/j76EY9nsjIG3Cq103n39qE=@lists.denx.de
X-Gm-Message-State: AOJu0Yyp/LS+Eie6k/HsKhyspjApsYp7tZZlhqlRTF6MzpgoANipj+O/
 IXWQW9t8+T1hiP6pGoOBUXdPbtUtcRz03m7AipaygZNYu9K9XVIBDUCqdgolmCV85X+NeuGtGsl
 6HqnWKbtDtm61sI5jo6arYwJr+lLmzNE0RMNG
X-Gm-Gg: ASbGncsgHIYc6mUpc2qIKPyjtDGzdU/617Lrry8XWis50lFmuIlOHzSF2TCefKeEY9W
 +SR0fQTbEkjPXenXWvwjyI40+OwxcH+77
X-Google-Smtp-Source: AGHT+IHUvGVKuUM8N5qm28LjipUylZyr26H+3mpCFjwaEdH/U1lKr9wK6Fc0wrxSSXSy5FzenwyZYaXDGj4gUWIEmUg=
X-Received: by 2002:a17:906:4ca:b0:a9a:646e:d2f7 with SMTP id
 a640c23a62f3a-aa63a33b676mr1028835266b.61.1733711343156; Sun, 08 Dec 2024
 18:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-11-mjg59@srcf.ucam.org>
 <b79cd88a-4346-444d-979c-8eb2ed913d5e@gmx.de>
In-Reply-To: <b79cd88a-4346-444d-979c-8eb2ed913d5e@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 8 Dec 2024 19:28:51 -0700
Message-ID: <CAFLszThbmrCcx-mQLmvJjWttBrM3ZH+t2wThPP0ND6QteyincA@mail.gmail.com>
Subject: Re: [PATCH 10/10] Add command to set an environment variable to an
 EFI variable
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, u-boot@lists.denx.de, 
 Matthew Garrett <mgarrett@aurora.tech>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>
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

Hi Heinrich,

On Sun, 24 Nov 2024 at 08:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/23/24 20:55, Matthew Garrett wrote:
> > From: Matthew Garrett <mgarrett@aurora.tech>
> >
> > We may want to make things conditional on EFI variable state
> >
> > Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> > ---
> >
> >   cmd/Kconfig     |   4 ++
> >   cmd/Makefile    |   1 +
> >   cmd/efigetenv.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 138 insertions(+)
> >   create mode 100644 cmd/efigetenv.c
> >
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 33bf3d1ad39..118fb721081 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -752,6 +752,10 @@ config CMD_NVEDIT_SELECT
> >       help
> >         Select the compiled-in persistent storage of environment variables.
> >
> > +config CMD_EFI_GET_ENV
> > +     bool "efi get env"
> > +     help
> > +       Set an environment variable to the contents of an EFI variable
> >   endmenu
> >
> >   menu "Memory commands"
> > diff --git a/cmd/Makefile b/cmd/Makefile
> > index 38cb7a4aea5..0507c204c0e 100644
> > --- a/cmd/Makefile
> > +++ b/cmd/Makefile
> > @@ -69,6 +69,7 @@ obj-$(CONFIG_CMD_EEPROM) += eeprom.o
> >   obj-$(CONFIG_EFI) += efi.o efi_common.o
> >   obj-$(CONFIG_CMD_EFIDEBUG) += efidebug.o efi_common.o
> >   obj-$(CONFIG_CMD_EFICONFIG) += eficonfig.o
> > +obj-$(CONFIG_CMD_EFI_GET_ENV) += efigetenv.o
> >   ifdef CONFIG_CMD_EFICONFIG
> >   ifdef CONFIG_EFI_MM_COMM_TEE
> >   obj-$(CONFIG_EFI_SECURE_BOOT) += eficonfig_sbkey.o
> > diff --git a/cmd/efigetenv.c b/cmd/efigetenv.c
> > new file mode 100644
> > index 00000000000..5284ee92d6c
> > --- /dev/null
> > +++ b/cmd/efigetenv.c
> > @@ -0,0 +1,133 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +#include <charset.h>
> > +#include <command.h>
> > +#include <efi_loader.h>
> > +#include <efi_variable.h>
> > +#include <env.h>
> > +#include <hexdump.h>
> > +#include <malloc.h>
> > +#include <uuid.h>
> > +
> > +/* Set a U-Boot environment variable to the contents of a UEFI variable */
> > +int do_efi_get_env(struct cmd_tbl *cmdtb, int flat, int argc, char *const argv[])
> > +{
> > +     u16 *var_name = NULL;
> > +     char *strdata = NULL;
> > +     efi_uintn_t size = 0;
> > +     bool var_content_is_utf16_string = false;
> > +     efi_status_t ret;
> > +     efi_guid_t guid;
> > +     u8 *data = NULL;
> > +     u32 attributes;
> > +     size_t len;
> > +     u64 time;
> > +     u16 *p;
> > +
> > +     ret = efi_init_obj_list();
> > +     if (ret != EFI_SUCCESS) {
> > +             printf("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> > +                    ret & ~EFI_ERROR_MASK);
> > +             return CMD_RET_FAILURE;
> > +     }
> > +
> > +     argv++;
> > +     argc--;
> > +
> > +     if (argc != 3 && argc != 4)
> > +             return CMD_RET_USAGE;
> > +
> > +     if (argc == 4) {
> > +             if (strcmp(argv[0], "-s"))
> > +                     return CMD_RET_USAGE;
> > +             var_content_is_utf16_string = true;
> > +             argv++;
> > +             argc--;
> > +     }
> > +
> > +     len = utf8_utf16_strnlen(argv[0], strlen(argv[0]));
> > +     var_name = malloc((len + 1) * 2);
> > +     if (!var_name) {
> > +             printf("## Out of memory\n");
> > +             return CMD_RET_FAILURE;
> > +     }
> > +     p = var_name;
> > +     utf8_utf16_strncpy(&p, argv[0], len + 1);
> > +
> > +     if (uuid_str_to_bin(argv[1], guid.b, UUID_STR_FORMAT_GUID)) {
> > +             ret = CMD_RET_USAGE;
> > +             goto out;
> > +     }
> > +
> > +     ret = efi_get_variable_int(var_name, &guid, &attributes, &size, data,
> > +                                &time);
> > +     if (ret == EFI_BUFFER_TOO_SMALL) {
> > +             data = malloc(size);
> > +             if (!data) {
> > +                     printf("## Out of memory\n");
> > +                     ret = CMD_RET_FAILURE;
> > +                     goto out;
> > +             }
> > +             ret = efi_get_variable_int(var_name, &guid, &attributes,
> > +                                        &size, data, &time);
>
> This duplicates code in efi_dump_single_var(), do_efi_capsule_res(),
> get_dp_device() and others.
>
> We should carve out a function.

Can you have a look at what to do here and send a patch? As in the
comment Ilias made, it seems like we may need some of the EFI-loader
code to move to lib/efi
>
> > +     }
> > +
> > +     if (ret == EFI_NOT_FOUND) {
> > +             printf("Error: \"%ls\" not defined\n", var_name);
> > +             ret = CMD_RET_FAILURE;
> > +             goto out;
> > +     }
> > +
> > +     if (ret != EFI_SUCCESS) {
> > +             printf("Error: Cannot read variable, r = %lu\n",
> > +                    ret & ~EFI_ERROR_MASK);
> > +             ret = CMD_RET_FAILURE;
> > +             goto out;
> > +     }
> > +
> > +     if (var_content_is_utf16_string) {
> > +             char *p;
> > +
> > +             len = utf16_utf8_strnlen((u16 *)data, size / 2);
> > +             strdata = malloc(len + 1);
> > +             if (!strdata) {
> > +                     printf("## Out of memory\n");
> > +                     ret = CMD_RET_FAILURE;
> > +                     goto out;
> > +             }
> > +             p = strdata;
> > +             utf16_utf8_strncpy(&p, (u16 *)data, size / 2);
> > +     } else {
> > +             len = size * 2;
> > +             strdata = malloc(len + 1);
> > +             if (!strdata) {
> > +                     printf("## Out of memory\n");
> > +                     ret = CMD_RET_FAILURE;
> > +                     goto out;
> > +             }
> > +             bin2hex(strdata, data, size);
> > +     }
> > +
> > +     strdata[len] = '\0';
> > +
> > +     ret = env_set(argv[2], strdata);
> > +     if (ret) {
> > +             ret = CMD_RET_FAILURE;
> > +             goto out;
> > +     }
> > +
> > +     ret = CMD_RET_SUCCESS;
> > +out:
> > +     free(strdata);
> > +     free(data);
> > +     free(var_name);
> > +
> > +     return ret;
> > +}
> > +
> > +U_BOOT_CMD(
> > +     efigetenv, 5, 4, do_efi_get_env,
> > +     "set environment variable to content of EFI variable",
> > +     "[-s] name guid envvar\n"
> > +     "    - set environment variable 'envvar' to the EFI variable 'name'-'guid'\n"
> > +     "      \"-s\": Interpret the EFI variable value as a UTF-16 string\n"
> > +);
>

Regards,
SImon
