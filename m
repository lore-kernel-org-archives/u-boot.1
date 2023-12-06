Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF2BC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 12:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 474E78708B;
	Wed,  6 Dec 2023 13:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bbjnuM59";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80D29870F4; Wed,  6 Dec 2023 13:11:55 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 301ED87015
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 13:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-548ce39b101so8424475a12.2
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 04:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701864712; x=1702469512; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IwKbX/6PqCeeqtxwBdP2MjfEbDeEYMcAAp37y1KygX0=;
 b=bbjnuM59K+zQ4mtEJId3Iq6ZzzIOVFjW+/6Dkq+VQotIxtLoH2RY0Y9n93W0ceZqiz
 QyOEgArQ0ymn6YOjpOY6agc0dWNZ2QFQXn83QfXTkHbU87o929qLmTpJRSiptBLMq9nD
 hdk3+QKvguI756G1h6t9fAXISOw4805eTm/ycmJza7TAveGrZmiaMKedsznVsu0/HZ6X
 GabyoPT10J53cC7RDrxDStl4owGfFICJRvk78wRJecdxr9v81FZVcQtdCN1eiSz/2U0T
 EqfZm6qCAqs8pfPXw+DJj/pqChgdoN1JE/qv3JD2CTPjhkA3//QWf37+q2Rn3moZxp7R
 fZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701864712; x=1702469512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IwKbX/6PqCeeqtxwBdP2MjfEbDeEYMcAAp37y1KygX0=;
 b=tYbOs6FLuU/sUf7MtFI7JnWLm8+flUR84zzy4MOF3XX5I2jue7bp7+6GZ35JMafN0j
 hjqAc//9kPQM894aRsh/vIZPPyQ+HABd0BZUuybGZfS5TgH73eDhJpVB9lXGIPwoTVfX
 jno5Ll1qh6C/354Vj5afiUxcWH34ja1p6UOzKDwRJr2VHJJGT/pkFUTkc5HsSJCwMy0J
 JTY05WWqgWxPJhL8ChEp/ea4CopI4CfIcLyS6NPxsgmAHdddKJDaBidQy9MCP5ASfJCw
 uYV7D0uEeJ/UrDTNlc+W1LB3C0ymsfYhigj0aZaHp6bVhBanW1cnLIG24nYwMXnqxdC/
 pvxA==
X-Gm-Message-State: AOJu0YxxJPL0L94MmZLA/IuNmri6GUhwl2I2s205ORE2dZSARnZ80h4q
 K8RRb4oBS6xNc4xc9PH82q23npmbetdHjLkcO7I=
X-Google-Smtp-Source: AGHT+IHMjqvJVmIowc4dlQ7XRFY5DEfYhS0kFPGiWnxiMJzP0/6q6GjZGus6K7jBXvjmVzFoSYm6pT7kF4cMMk7r0QU=
X-Received: by 2002:a50:d7d9:0:b0:54a:cf5d:8b0f with SMTP id
 m25-20020a50d7d9000000b0054acf5d8b0fmr430522edj.19.1701864712536; Wed, 06 Dec
 2023 04:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2PtQQ81x-SqMs6NKSjMKFGShT65Rrtfc-CDOsdBxgJDQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ2PtQQ81x-SqMs6NKSjMKFGShT65Rrtfc-CDOsdBxgJDQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 6 Dec 2023 12:11:41 +0000
Message-ID: <CALeDE9MPrTaa0F03JgZJzJOoFk072Fz5bxN669m1PfAzVWKiYw@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com,
 sean.anderson@seco.com, 
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com, 
 mark.kettenis@xs4all.nl, u-boot@lists.denx.de
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

On Thu, Nov 30, 2023 at 2:45=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Ilias,
>
> On Mon, 27 Nov 2023 at 10:11, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > In order to fill in the SMBIOS tables U-Boot currently relies on a
> > "u-boot,sysinfo-smbios" compatible node.  This is fine for the boards
> > that already include such nodes.  However with some recent EFI changes,
> > the majority of boards can boot up distros, which usually rely on
> > things like dmidecode etc for their reporting.  For boards that
> > lack this special node the SMBIOS output looks like:
> >
> > System Information
> >         Manufacturer: Unknown
> >         Product Name: Unknown
> >         Version: Unknown
> >         Serial Number: Unknown
> >         UUID: Not Settable
> >         Wake-up Type: Reserved
> >         SKU Number: Unknown
> >         Family: Unknown
> >
> > This looks problematic since most of the info are "Unknown".  The DT sp=
ec
> > specifies standard properties containing relevant information like
> > 'model' and 'compatible' for which the suggested format is
> > <manufacturer,model>. Unfortunately the 'model' string found in DTs is
> > usually lacking the manufacturer so we can't use it for both
> > 'Manufacturer' and 'Product Name' SMBIOS entries reliably.
> >
> > So let's add a last resort to our current smbios parsing.  If none of
> > the sysinfo properties are found, scan for those information in the
> > root node of the device tree. Use the 'model' to fill the 'Product
> > Name' and the first value of 'compatible' for the 'Manufacturer', since
> > that always contains one.
> >
> > pre-patch:
> > Handle 0x0001, DMI type 1, 27 bytes
> > System Information
> >         Manufacturer: Unknown
> >         Product Name: Unknown
> >         Version: Unknown
> >         Serial Number: 100000000bb24ceb
> >         UUID: 30303031-3030-3030-3061-613234636435
> >         Wake-up Type: Reserved
> >         SKU Number: Unknown
> >         Family: Unknown
> > [...]
> >
> > and post patch:
> > Handle 0x0001, DMI type 1, 27 bytes
> > System Information
> >         Manufacturer: raspberrypi
> >         Product Name: Raspberry Pi 4 Model B Rev 1.1
> >         Version: Unknown
> >         Serial Number: 100000000bb24ceb
> >         UUID: 30303031-3030-3030-3061-613234636435
> >         Wake-up Type: Reserved
> >         SKU Number: Unknown
> >         Family: Unknown
> > [...]
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > Changes since v1:
> > - Tokenize the DT node entry and use the appropriate value instead of
> >   the entire string
> > - Removed Peters tested/reviewed-by tags due to the above
> >  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 90 insertions(+), 4 deletions(-)
> >
>
> Can this be put behind a Kconfig? It adds quite a bit of code which
> punishes those boards which do the right thing.

What's the size difference? By putting it behind a Kconfig you're
assuming the boards that don't do the right thing are going to enable
this at which point we punish users by not having some level of
usability. By "right thing" do you mean the smbios entries in the
-u-boot.dtsi?

> > diff --git a/lib/smbios.c b/lib/smbios.c
> > index fcc8686993ef..423893639ff0 100644
> > --- a/lib/smbios.c
> > +++ b/lib/smbios.c
> > @@ -9,11 +9,14 @@
> >  #include <dm.h>
> >  #include <env.h>
> >  #include <linux/stringify.h>
> > +#include <linux/string.h>
> >  #include <mapmem.h>
> >  #include <smbios.h>
> >  #include <sysinfo.h>
> >  #include <tables_csum.h>
> >  #include <version.h>
> > +#include <malloc.h>
> > +#include <dm/ofnode.h>
> >  #ifdef CONFIG_CPU
> >  #include <cpu.h>
> >  #include <dm/uclass-internal.h>
> > @@ -43,6 +46,25 @@
> >
> >  DECLARE_GLOBAL_DATA_PTR;
> >
> > +/**
> > + * struct map_sysinfo - Mapping of sysinfo strings to DT
> > + *
> > + * @sysinfo_str: sysinfo string
> > + * @dt_str: DT string
> > + * @max: Max index of the tokenized string to pick. Counting starts fr=
om 0
> > + *
> > + */
> > +struct map_sysinfo {
> > +       const char *sysinfo_str;
> > +       const char *dt_str;
> > +       int max;
> > +};
> > +
> > +static const struct map_sysinfo sysinfo_to_dt[] =3D {
> > +       { .sysinfo_str =3D "product", .dt_str =3D "model", 2 },
> > +       { .sysinfo_str =3D "manufacturer", .dt_str =3D "compatible", 1 =
},
> > +};
> > +
> >  /**
> >   * struct smbios_ctx - context for writing SMBIOS tables
> >   *
> > @@ -87,6 +109,18 @@ struct smbios_write_method {
> >         const char *subnode_name;
> >  };
> >
> > +static const struct map_sysinfo *convert_sysinfo_to_dt(const char *sys=
info_str)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(sysinfo_to_dt); i++) {
> > +               if (!strcmp(sysinfo_str, sysinfo_to_dt[i].sysinfo_str))
> > +                       return &sysinfo_to_dt[i];
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> >  /**
> >   * smbios_add_string() - add a string to the string area
> >   *
> > @@ -127,6 +161,42 @@ static int smbios_add_string(struct smbios_ctx *ct=
x, const char *str)
> >         }
> >  }
> >
> > +/**
> > + * get_str_from_dt - Get a substring from a DT property.
> > + *                   After finding the property in the DT, the functio=
n
> > + *                   will parse comma separted values and return the v=
alue.
>
> spelling
>
> > + *                   If nprop->max exceeds the number of comma separat=
ed
>
> comma-separated
>
> > + *                   elements the last non NULL value will be returned=
.
>
> elements, the
>
> > + *                   Counting starts from zero.
> > + *
> > + * @nprop: sysinfo property to use
> > + * @str: pointer to fill with data
> > + * @size: str buffer length
> > + */
> > +static
> > +void get_str_from_dt(const struct map_sysinfo *nprop, char *str, size_=
t size)
> > +{
> > +       const char *dt_str;
> > +       int cnt =3D 0;
> > +       char *token;
> > +
> > +       memset(str, 0, size);
> > +       if (!nprop || !nprop->max)
> > +               return;
> > +
> > +       dt_str =3D ofnode_read_string(ofnode_root(), nprop->dt_str);
>
> Could this use ofnode_read_string_index() ?
>
> > +       if (!dt_str)
> > +               return;
> > +
> > +       memcpy(str, dt_str, size);
> > +       token =3D strtok(str, ",");
> > +       while (token && cnt < nprop->max) {
> > +               strlcpy(str, token, strlen(token) + 1);
> > +               token =3D strtok(NULL, ",");
> > +               cnt++;
> > +       }
> > +}
> > +
> >  /**
> >   * smbios_add_prop_si() - Add a property from the devicetree or sysinf=
o
> >   *
> > @@ -139,19 +209,35 @@ static int smbios_add_string(struct smbios_ctx *c=
tx, const char *str)
> >  static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop=
,
> >                               int sysinfo_id)
> >  {
> > +       int ret =3D 0;
> > +
> >         if (sysinfo_id && ctx->dev) {
> >                 char val[SMBIOS_STR_MAX];
> > -               int ret;
> >
> >                 ret =3D sysinfo_get_str(ctx->dev, sysinfo_id, sizeof(va=
l), val);
> >                 if (!ret)
> >                         return smbios_add_string(ctx, val);
> >         }
> > +
> >         if (IS_ENABLED(CONFIG_OF_CONTROL)) {
> > -               const char *str;
> > +               const char *str =3D NULL;
> > +               char str_dt[128] =3D { 0 };
> > +               /*
> > +                * If the node is not valid fallback and try the entire=
 DT
> > +                * so we can at least fill in maufacturer and board typ=
e
>
> spelling
>
> > +                */
> > +               if (ofnode_valid(ctx->node)) {
> > +                       str =3D ofnode_read_string(ctx->node, prop);
> > +               } else {
> > +                       const struct map_sysinfo *nprop;
> > +
> > +                       nprop =3D convert_sysinfo_to_dt(prop);
> > +                       get_str_from_dt(nprop, str_dt, sizeof(str_dt));
> > +               }
> >
> > -               str =3D ofnode_read_string(ctx->node, prop);
> > -               return smbios_add_string(ctx, str);
> > +               ret =3D smbios_add_string(ctx, ofnode_valid(ctx->node) =
?
> > +                                       str : (const char *)str_dt);
> > +               return ret;
> >         }
> >
> >         return 0;
> > --
> > 2.40.1
> >
>
> Any chance of a test for this code?
>
> Regards,
> Simon
