Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2038DD4977C
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2AC089720;
	Sun,  1 Dec 2024 17:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S1fIGIMJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 845988971F; Sun,  1 Dec 2024 17:15:22 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F7D789748
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 17:15:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-724f41d550cso1949868b3a.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 08:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733069715; x=1733674515; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Iaw6siymtTyvi3tG4KsmaPaSng5o1AoXYFtFQOIFtg=;
 b=S1fIGIMJA3gC6Riawd9boNllGQuMfE1Dwil+6UgRHbbwUrOzA528yfZn2981JlOqZk
 8u7Q7u2ZdC31M8oDD2UW6RiUHGmCm9Mma69xJb95s9ACJR3s0S8NeMDV1H1f4O/M8F8g
 VVqyRBgeAv7BOaOrv+x9XEZ8U8iAhUzbUqBuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069715; x=1733674515;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Iaw6siymtTyvi3tG4KsmaPaSng5o1AoXYFtFQOIFtg=;
 b=WVs3NVauqGBueURSrt8z/9OVv4D09onqFv50DFcF+O1IKBiQa6w6Hfb+3iQCgd8QmY
 sZaJrY+e3Ik8gs6xeo8gCOmJRSBGRpRxD9g9Oxp38LHZM7Xb8dZ3pLWK6MZtkWG8eoKP
 jvqElMT71LoRGL9WysvuF12SugxtISkl3KgtZDOJSINdSKeS/sMC+0PzFHnVMhJjkp5m
 L72DB9NuTKA1mqIgGRlorIHCs/d/qrVHy5uB7D23hA0ZmyAWh3k0AQi20M/wb6R1ncq1
 5oQSpdMXQMhiqqyQct9S6gMM2KGolNgcuUANtd1wdQpB0PUiowIkmBzmZ+BOKdZaqED6
 LBCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqVvv73RVdgUU9N9uOyFOSi42/ClOb8kpy2whXvBsbTB/7bkkpn1a1ppAPWj+JdMqdMHFybHk=@lists.denx.de
X-Gm-Message-State: AOJu0YzaleEMcztmDhvhpSbzquX0r+swAxttNRyYLjs9DLhS4tgx/TjS
 7t6a8jrRKsmQwQ7vfweabXBXde7GThOdU5STUHeIhZdatFwmPMLWrt/wLc3++vNGa128cRYbg5M
 FqL0TD50X4G5Wre1Nwb7716JKAqGqRVqJQ11kr1/HDUPW8Cw=
X-Gm-Gg: ASbGncscojiW8cF6NuxWVnf5IOoAZKW1j3k1psQH18ULcLRc/IbpkGlqei6O2VylWag
 hJgUYB8km1ei07nvSCoPhGmoiugC1Mw==
X-Google-Smtp-Source: AGHT+IGLZL9yvuRgt37MDkWzVu4Vzlhcvk8wbMA9HsEk6DPNUVFUbVfd5Sy4C3G3bsqqv9Iea71ycqBpCqgpJWGYIQU=
X-Received: by 2002:a17:902:f650:b0:215:3e1a:11c8 with SMTP id
 d9443c01a7336-2153e1a1684mr155073735ad.14.1733069715128; Sun, 01 Dec 2024
 08:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-11-mjg59@srcf.ucam.org>
 <b79cd88a-4346-444d-979c-8eb2ed913d5e@gmx.de>
In-Reply-To: <b79cd88a-4346-444d-979c-8eb2ed913d5e@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Dec 2024 09:14:23 -0700
Message-ID: <CAFLszTgZKx_rT5K9Y5WSy31buXJV_c9g0fA40f76Dnnjp_ix+Q@mail.gmail.com>
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

That can come later. In general there are EFI_LOADER functions which
could be useful in lib/efi/

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
