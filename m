Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A94C7114A
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 06:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6672880C83;
	Tue, 17 Jun 2025 08:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TdGG02Rx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAC1382B0F; Tue, 17 Jun 2025 08:16:06 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FD458070C
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 08:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7d09b0a5050so328935485a.3
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 23:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750140960; x=1750745760; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wd81WGU2OVXzIp76qFATAHLKo7Jw1CV6f7fJeJAanfc=;
 b=TdGG02RxTFJKbLIE16i6vUJYvdAydlxiBFlOEsZuzTp/9cGxqPn5xlPX322ZzGHnil
 NxSir0zEJaxAtqBz/b0z2EOOQvikgmhxmBucM94fHcrvK7QxBG1iuV9Y1YO5i3G0cI2U
 j7aemQfjoiOSwzB8tLPEGSrbQPo+VqHO9PmWEAg5N0kFlz0GnslIRhGkcSPl0wOwyagY
 ZTVboZtmLtvZvxMysVKCKzi/ipTj3g9v0tCJt94ANurp0WJa639fDBZEMU0eLfU4JSGe
 w4bhSZqgDRxTNr5+KS+ob4L1D/uip75NzqOC67qpc9uNVrS2Sc2zci4SR25zUwY8DYhs
 S2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750140960; x=1750745760;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wd81WGU2OVXzIp76qFATAHLKo7Jw1CV6f7fJeJAanfc=;
 b=T5zdyezVq8Of+tosD3cVWfIoQ+NwJU0Vtyh1XpGfR/O0a11nwKtBLmsvB3bpswC9m7
 qnH8m96s8I5n0ypnJEiWyrI6XTYUC3SdHAg3bwPFSOLNL1TGQEXc7wikTwLf+s8nSJdZ
 og1603a2cqrS4f4+ogxgICxmZlsOAclCvKP9X+7wpeT8Fp6mXpTmT5+ebcfjAS/PgmQr
 UY1kH4Scb8F7MMtOvUmYZCcDDC/yzo0OkQ3ctY16o1rO5H98fnWwsZ9w+HAXw4ks7gVU
 9VPrgbJIdgP15OOB33EQSZbtMkCjihxqZbnRc86tt3C44qBFqW6tjOzUmOrigtYJerMl
 zlFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs9l/iVkGmtzBlmUqekA6nlB8xodmWcXTAhZ13P40VWzpl5jrZaVJ0l0OD5NnGWWvxiMYQB5g=@lists.denx.de
X-Gm-Message-State: AOJu0YxrzsbwbGfrJbR8eadQwZ5wXFvULE/LUg1gaQa3bCSmtVK0aR3p
 NuXJyftGunROD64tUqyHG6egoIyUsbCkBnIWbL/dWFR/r1MJ09uqQcSTdngtdRkwiE3O5AYY6kp
 3HS3c+ow5jZP1s554nGyWNAYvZZSY9UigFszgq57thQ==
X-Gm-Gg: ASbGncvVUyogsTq6M6TssgiLGm60IrVieOddZft4fEPaxulAVVYeV8AHGErCbF49smB
 SqnXQsiYZ8PEvHXDi2YaQIaoypmQeXV3VJxQcYNztHxWlIouJHFoWjXyjnqOdDjOpPNS+g5iFVl
 uy68vVSI1PfIdSvvvDnNr8SLz5hzquas9ztLCJ+EIIIbvz
X-Google-Smtp-Source: AGHT+IEGPoCaz2ubSJMZE1x5mle5oFR76yENpj1N8VN63ahKWnJDNDWNydlW60k8yU2a/jd7d/HSZ6n7Oahgd3TiFhI=
X-Received: by 2002:a05:620a:4384:b0:7d3:8f51:e80c with SMTP id
 af79cd13be357-7d3c6c1eea9mr1970839285a.22.1750140960069; Mon, 16 Jun 2025
 23:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250616102338.1269541-1-sughosh.ganu@linaro.org>
 <f126efa4-8d21-4358-bf69-45714142daa8@gmx.de>
In-Reply-To: <f126efa4-8d21-4358-bf69-45714142daa8@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 17 Jun 2025 11:45:48 +0530
X-Gm-Features: AX0GCFtoy8Eizjrx6l4ZaGx_mAGdNycjtrYHTcXGUsxA0fGpZjVDx2ReY40fcm8
Message-ID: <CADg8p94M_pwzifhgeR33kWNcL6_Vs4ueiQGHm2j7q2G=GppSww@mail.gmail.com>
Subject: Re: [PATCH] cmd: eficonfig: add support for URI device path based
 boot options
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

On Tue, 17 Jun 2025 at 03:23, Heinrich Schuchardt <xypron.glpk@gmx.de> wrot=
e:
>
> On 6/16/25 12:23, Sughosh Ganu wrote:
> > The eficonfig command provides a menu based interface for maintenance
> > of the EFI boot options. Add support for adding a URI based boot
> > option. This boot option can then be used for HTTP boot.
>
> With your patch when I try to add a boot option I was surprised to see
> this menu:
>
>    ** Add Boot Option **
>
>        Description:
>        File:
>        Initrd File:
>        Fdt File:
>        Optional Data:
>        Uri:
>        Save
>        Quit
>
> My expectation is that I can define a URL each for
>
> * binary
> * initrd
> * fdt
>
> It should be possible to choose a network device in this menu instead:
>
>    ** Select Volume **
>
>        nvme 0:1
>        nvme 0:2
>        mmc 0:1
>        mmc 0:2
>        Quit

This is an interesting suggestion. But this patch is bringing the
eficonfig command in line with the other command that is being used
for setting the boot options, namely efidebug. Moreover, if there is a
plan and interest to support getting the initrd and fdt files over the
network through an URI based device-path, we first need to add support
for the same in the EFI bootmgr. Then it would make sense to change
both the commands (eficonfig and efidebug) accordingly.

>
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >
> > Note: I had explored adding a corresponding test for this change. But
> > looks like the eficonfig command itself is not being tested since
> > commit 952018117ab4 ("dm: sandbox: Switch over to using the new host
> > uclass"). This needs to be taken up separately as to why the eficonfig
> > test has been bypassed, before adding stuff to the test.
> >
> >
> >   cmd/eficonfig.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++-=
-
> >   1 file changed, 87 insertions(+), 3 deletions(-)
> >
> > diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> > index 6e14d34a6bd..f69902b76f7 100644
> > --- a/cmd/eficonfig.c
> > +++ b/cmd/eficonfig.c
> > @@ -35,6 +35,7 @@ static int avail_row;
> >
> >   #define EFICONFIG_DESCRIPTION_MAX 32
> >   #define EFICONFIG_OPTIONAL_DATA_MAX 64
> > +#define EFICONFIG_URI_MAX 512
> >   #define EFICONFIG_MENU_HEADER_ROW_NUM 3
> >   #define EFICONFIG_MENU_DESC_ROW_NUM 5
> >
> > @@ -57,6 +58,7 @@ struct eficonfig_filepath_info {
> >    * @boot_index:             index of the boot option
> >    * @description:    pointer to the description string
> >    * @optional_data:  pointer to the optional_data
> > + * @uri:             URI for HTTP Boot
> >    * @edit_completed: flag indicates edit complete
> >    */
> >   struct eficonfig_boot_option {
> > @@ -66,6 +68,7 @@ struct eficonfig_boot_option {
> >       unsigned int boot_index;
> >       u16 *description;
> >       u16 *optional_data;
> > +     u16 *uri;
> >       bool edit_completed;
> >   };
> >
> > @@ -538,6 +541,31 @@ struct efi_device_path *eficonfig_create_device_pa=
th(struct efi_device_path *dp_
> >       return dp;
> >   }
> >
> > +static struct efi_device_path *eficonfig_create_uri_device_path(u16 *u=
ri_str)
> > +{
> > +     char *pos, *p;
> > +     u32 len =3D 0;
> > +     efi_uintn_t uridp_len;
> > +     struct efi_device_path_uri *uridp;
> > +
> > +     len =3D utf16_utf8_strlen(uri_str);
>
> The code in this function seems not to guarantee valid URLs. E.g. you
> don't check that the schema is http:// or https://.
>
> Please, provide unit tests for the URL validation.
>
> The UEFI spec refers to RFC 3986 for the allowable content of a Uri()
> device-path.
>
> See also https://url.spec.whatwg.org/#valid-url-string
>
> The Chinese URL https://www.hk01.com/zone/1/=E6=B8=AF=E8=81=9E should be =
encoded as
> https://www.hk01.com/zone/1/%E6%B8%AF%E8%81%9E.
>
> The following steps are required:
>
> 1) convert to UTF-8
> 2) encode bytes in URL fragements using hex encoding as needed.

Fwiw, I did consider adding a check for the URI, but then I saw that
the lwip stack does this in parse_url() through a call to
wget_validate_uri().

>
> See https://url.spec.whatwg.org/#url-fragment-string
>
> Please, implement unit tests for URL encoding.

Okay, but as I mentioned in the patch note, the entire eficonfig test
has been bypassed for some unknown reason. This too needs
investigation.

-sughosh

>
> Best regards
>
> Heinrich
>
> > +
> > +     uridp_len =3D sizeof(struct efi_device_path) + len + 1;
> > +     uridp =3D efi_alloc(uridp_len + sizeof(EFI_DP_END));
> > +     if (!uridp)
> > +             return NULL;
> > +
> > +     uridp->dp.type =3D DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> > +     uridp->dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MSG_URI;
> > +     uridp->dp.length =3D uridp_len;
> > +     p =3D (char *)&uridp->uri;
> > +     utf16_utf8_strcpy(&p, uri_str);
> > +     pos =3D (char *)uridp + uridp_len;
> > +     memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
> > +
> > +     return &uridp->dp;
> > +}
> > +
> >   /**
> >    * eficonfig_file_selected() - handler of file selection
> >    *
> > @@ -983,6 +1011,22 @@ static efi_status_t eficonfig_boot_add_optional_d=
ata(void *data)
> >                                "  enter optional data:");
> >   }
> >
> > +/**
> > + * eficonfig_boot_add_uri() - handle user input for HTTP Boot URI
> > + *
> > + * @data:    pointer to the internal boot option structure
> > + * Return:   status code
> > + */
> > +static efi_status_t eficonfig_boot_add_uri(void *data)
> > +{
> > +     struct eficonfig_boot_option *bo =3D data;
> > +
> > +     return handle_user_input(bo->uri, EFICONFIG_URI_MAX, 24,
> > +                              "\n  ** Edit URI **\n"
> > +                              "\n"
> > +                              "  enter HTTP Boot URI:");
> > +}
> > +
> >   /**
> >    * eficonfig_boot_edit_save() - handler to save the boot option
> >    *
> > @@ -998,7 +1042,8 @@ static efi_status_t eficonfig_boot_edit_save(void =
*data)
> >               bo->edit_completed =3D false;
> >               return EFI_NOT_READY;
> >       }
> > -     if (u16_strlen(bo->file_info.current_path) =3D=3D 0) {
> > +     if (u16_strlen(bo->file_info.current_path) =3D=3D 0 &&
> > +         u16_strlen(bo->uri) =3D=3D 0) {
> >               eficonfig_print_msg("File is not selected!");
> >               bo->edit_completed =3D false;
> >               return EFI_NOT_READY;
> > @@ -1318,6 +1363,11 @@ static efi_status_t eficonfig_show_boot_option(s=
truct eficonfig_boot_option *bo,
> >       if (ret !=3D EFI_SUCCESS)
> >               goto out;
> >
> > +     ret =3D create_boot_option_entry(efi_menu, "Uri: ", bo->uri,
> > +                                    eficonfig_boot_add_uri, bo);
> > +     if (ret !=3D EFI_SUCCESS)
> > +             goto out;
> > +
> >       ret =3D create_boot_option_entry(efi_menu, "Save", NULL,
> >                                      eficonfig_boot_edit_save, bo);
> >       if (ret !=3D EFI_SUCCESS)
> > @@ -1340,6 +1390,22 @@ out:
> >       return ret;
> >   }
> >
> > +static bool eficonfig_fp_uri(struct efi_device_path *dp)
> > +{
> > +     return dp->type =3D=3D DEVICE_PATH_TYPE_MESSAGING_DEVICE &&
> > +             dp->sub_type =3D=3D DEVICE_PATH_SUB_TYPE_MSG_URI;
> > +}
> > +
> > +static void fill_dp_uri(struct efi_device_path *dp, u16 **uri_str)
> > +{
> > +     u16 *p =3D *uri_str;
> > +     struct efi_device_path_uri *uridp;
> > +
> > +     uridp =3D (struct efi_device_path_uri *)dp;
> > +
> > +     utf8_utf16_strcpy(&p, uridp->uri);
> > +}
> > +
> >   /**
> >    * fill_file_info() - fill the file info from efi_device_path structu=
re
> >    *
> > @@ -1392,10 +1458,13 @@ static efi_status_t eficonfig_edit_boot_option(=
u16 *varname, struct eficonfig_bo
> >       size_t len;
> >       efi_status_t ret;
> >       char *tmp =3D NULL, *p;
> > +     u16 *current_path =3D NULL;
> >       struct efi_load_option lo =3D {0};
> >       efi_uintn_t dp_size;
> >       struct efi_device_path *dp =3D NULL;
> >       efi_uintn_t size =3D load_option_size;
> > +     struct efi_device_path *dp_volume =3D NULL;
> > +     struct efi_device_path *uri_dp =3D NULL;
> >       struct efi_device_path *device_dp =3D NULL;
> >       struct efi_device_path *initrd_dp =3D NULL;
> >       struct efi_device_path *fdt_dp =3D NULL;
> > @@ -1464,6 +1533,12 @@ static efi_status_t eficonfig_edit_boot_option(u=
16 *varname, struct eficonfig_bo
> >               goto out;
> >       }
> >
> > +     bo->uri =3D calloc(1, EFICONFIG_URI_MAX * sizeof(u16));
> > +     if (!bo->uri) {
> > +             ret =3D  EFI_OUT_OF_RESOURCES;
> > +             goto out;
> > +     }
> > +
> >       /* copy the preset value */
> >       if (load_option) {
> >               ret =3D efi_deserialize_load_option(&lo, load_option, &si=
ze);
> > @@ -1481,7 +1556,9 @@ static efi_status_t eficonfig_edit_boot_option(u1=
6 *varname, struct eficonfig_bo
> >               u16_strcpy(bo->description, lo.label);
> >
> >               /* EFI image file path is a first instance */
> > -             if (lo.file_path)
> > +             if (lo.file_path && eficonfig_fp_uri(lo.file_path))
> > +                     fill_dp_uri(lo.file_path, &bo->uri);
> > +             else
> >                       fill_file_info(lo.file_path, &bo->file_info, devi=
ce_dp);
> >
> >               /* Initrd file path (optional) is placed at second instan=
ce. */
> > @@ -1512,6 +1589,9 @@ static efi_status_t eficonfig_edit_boot_option(u1=
6 *varname, struct eficonfig_bo
> >                       goto out;
> >       }
> >
> > +     if (utf16_utf8_strlen(bo->uri))
> > +             uri_dp =3D eficonfig_create_uri_device_path(bo->uri);
> > +
> >       if (bo->initrd_info.dp_volume) {
> >               dp =3D eficonfig_create_device_path(bo->initrd_info.dp_vo=
lume,
> >                                                bo->initrd_info.current_=
path);
> > @@ -1536,7 +1616,10 @@ static efi_status_t eficonfig_edit_boot_option(u=
16 *varname, struct eficonfig_bo
> >               efi_free_pool(dp);
> >       }
> >
> > -     dp =3D eficonfig_create_device_path(bo->file_info.dp_volume, bo->=
file_info.current_path);
> > +     dp_volume =3D bo->file_info.dp_volume;
> > +     current_path =3D bo->file_info.current_path;
> > +     dp =3D uri_dp ?
> > +             uri_dp : eficonfig_create_device_path(dp_volume, current_=
path);
> >       if (!dp) {
> >               ret =3D EFI_OUT_OF_RESOURCES;
> >               goto out;
> > @@ -1558,6 +1641,7 @@ static efi_status_t eficonfig_edit_boot_option(u1=
6 *varname, struct eficonfig_bo
> >       ret =3D eficonfig_set_boot_option(varname, dp, dp_size, bo->descr=
iption, tmp);
> >   out:
> >       free(tmp);
> > +     free(bo->uri);
> >       free(bo->optional_data);
> >       free(bo->description);
> >       free(bo->file_info.current_path);
>
