Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FF1C7EE33
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 09:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0697682977;
	Thu, 26 Jun 2025 11:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kI373a3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D8E682D83; Thu, 26 Jun 2025 11:29:10 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C1580E9A
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7d3efcb9bd6so77477685a.1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 02:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750930144; x=1751534944; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O0+8htkDO9HnS4yn7aYJnp2erCSK3yZiLaUYekmoWPY=;
 b=kI373a3fATAowxsUjCk4um1qA/ulM/8oWQufcXJwlS663+svR6cwkI4Hy0k4HuLBdR
 nA/PycekdorxNxS1f5dqK0BjNRCS6c1wIvuwE0Dwtu2UZm3hWBxUYudFKqU9EXPHDC06
 75ReunSZc9f4BKofdWWQriZdir5DosMncQuc4IepwoyNrNEkuJtftjbS77gFjlRmlO57
 VluWsofx3MYAmhOB2uqFbbaSflxXg+1OGY7l1eiX5oCt/6vQka195QFbniydvCcHwbIw
 92I0a6sG85QiXsbpiV7Ec+9s/ysUHLn6Nv5/xWzav9889VlbbFFtkXnfeqDCeaG/aHGf
 tFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750930144; x=1751534944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O0+8htkDO9HnS4yn7aYJnp2erCSK3yZiLaUYekmoWPY=;
 b=lcRKAdGg1C0W08H70VMxAuz9GugNAXSN3RXSGPG81WVtPUTxcSQybAL2lgqf9uUls8
 OBdxceGNDpgFD5fqCuxWG0IKGZ5CJX5fez6SDebJbIZzoFsUcUPA3BLk0tjXBAIaHbPe
 PUUdOkFubogJDd9zMxpFRuLCa8aNgpMod9bg3/3F6ehndgHywAR9MkcK9wXbZYnIfgQ/
 FJSpw9e0Z3mCuDbQxfeFEMYY1xF4aqMFyQoiRrPora/X1Htr7ahz9SItdZwFsqL2YdZI
 j/VfqNq31z29IYOhPK3aMxUKgHOqM1glkQFZU+Ruc+oczMGTl2YxCuMlvOklylPTmOaV
 eWOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2DwVsO2qX1Zd127pNKHy6KdtFRYJKwoEk8axwHictJTwOEKR6HZ2IwuQP6D1zF+F4BnU3JoM=@lists.denx.de
X-Gm-Message-State: AOJu0YyBptCf5+i0rvhbXsj45GrxBULb6nc2Qe57PcObifzxxMZ4r6uZ
 A79wQs4+p9Pxy2mkVGWPaUM+P5I28utFVgZT96sgeL7H/AGfsBMl6xwbzLd+OWt9c3MgAtlL0tA
 gu4Z0Nl/jLTrjKk31hc5sakX+ZgfAt7tElXfiLeAnRg==
X-Gm-Gg: ASbGncu95XxqLae717w5kvWFbCXRF4bSarN+SGMTOhEuujGZb9hTsiRPQa5ZfSmBcp0
 EfVUdwjBkSLPmiFl/6owiGqoGefW1KUI5r28JsUcmhGTdg81W/LX9pvGasKaM/jH5hdeSpZwKt3
 1dZIp2SJd1KmYwXdEyffo4vKP84Bf/tydnvgJ9JJPQ+P2d
X-Google-Smtp-Source: AGHT+IEjaTZ91w9o9Ac5O93wECF/CtWNo9U9VgSFtmWL9qbHssRGy58SM/92qWPJKWYVmExT9aV3J2RxrkefoBq5pvU=
X-Received: by 2002:a05:620a:1a81:b0:7d2:26f3:881a with SMTP id
 af79cd13be357-7d4297539d8mr853318385a.56.1750930144107; Thu, 26 Jun 2025
 02:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250624120730.2158194-1-sughosh.ganu@linaro.org>
 <20250624120730.2158194-2-sughosh.ganu@linaro.org>
 <713c7bf0-25d9-43fc-9e98-486947fd58fb@gmx.de>
In-Reply-To: <713c7bf0-25d9-43fc-9e98-486947fd58fb@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 26 Jun 2025 14:58:52 +0530
X-Gm-Features: Ac12FXxnf-3fDqFXX9frETFp4u0JbQUFd1q3974rWZNBDsvp2XFRjmUtR7tu7dc
Message-ID: <CADg8p94THmBduwEDZK7SSeAgtN8JcAd8cv+aWDiL_MrsK4=vNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cmd: eficonfig: add support for URI device path
 based boot options
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

On Thu, 26 Jun 2025 at 13:52, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 24.06.25 14:07, Sughosh Ganu wrote:
> > The eficonfig command provides a menu based interface for maintenance
> > of the EFI boot options. Add support for adding a URI based boot
> > option. This boot option can then be used for HTTP boot.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1:
> > * Move the option for entering the URI under the boot file.
> > * All corresponding changes needed for the above change.
> >
> >   cmd/eficonfig.c      | 113 ++++++++++++++++++++++++++++++++++++++++---
> >   include/efi_config.h |   4 ++
> >   2 files changed, 109 insertions(+), 8 deletions(-)
> >
> > diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> > index 6e14d34a6bd..917d79b8023 100644
> > --- a/cmd/eficonfig.c
> > +++ b/cmd/eficonfig.c
> > @@ -35,6 +35,7 @@ static int avail_row;
> >
> >   #define EFICONFIG_DESCRIPTION_MAX 32
> >   #define EFICONFIG_OPTIONAL_DATA_MAX 64
> > +#define EFICONFIG_URI_MAX 512
>
> I am not aware of as standard setting a limit on URI sizes.
>
> https://www.rfc-editor.org/rfc/rfc9110#section-4.1-5 has this
> recommendation:
>
> It is RECOMMENDED that all senders and recipients support, at a minimum,
> URIs with lengths of 8000 octets in protocol elements.
>
> We should determine the length of the URI when the user makes his input.

I had checked the corresponding RFC to check if there was a mention of
size limit on the URI, and there is none. There is a mention about
some applications using 2K as a limit for the URI length. But in
U-Boot's context, I think that 512 bytes is a good enough limit, given
that we are using the URI primarily for specifying distro installation
image's path.

Also, the handle_user_input() function in the eficonfig tool expects a
size limit to be provided for all the user input, and I think this is
a sane thing to do rather than allowing the user to input random
strings. Do you see a realistic use-case where a URI of more than 512
characters might be expected for a boot option?

>
> >   #define EFICONFIG_MENU_HEADER_ROW_NUM 3
> >   #define EFICONFIG_MENU_DESC_ROW_NUM 5
> >
> > @@ -538,6 +539,31 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
> >       return dp;
> >   }
> >
> > +static struct efi_device_path *eficonfig_create_uri_device_path(u16 *uri_str)
> > +{
> > +     char *pos, *p;
> > +     u32 len = 0;
> > +     efi_uintn_t uridp_len;
> > +     struct efi_device_path_uri *uridp;
> > +
> > +     len = utf16_utf8_strlen(uri_str);
> > +
> > +     uridp_len = sizeof(struct efi_device_path) + len + 1;
> > +     uridp = efi_alloc(uridp_len + sizeof(EFI_DP_END));
> > +     if (!uridp)
> > +             return NULL;
> > +
> > +     uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> > +     uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
> > +     uridp->dp.length = uridp_len;
> > +     p = (char *)&uridp->uri;
> > +     utf16_utf8_strcpy(&p, uri_str);
> > +     pos = (char *)uridp + uridp_len;
> > +     memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
> > +
> > +     return &uridp->dp;
> > +}
> > +
> >   /**
> >    * eficonfig_file_selected() - handler of file selection
> >    *
> > @@ -983,6 +1009,22 @@ static efi_status_t eficonfig_boot_add_optional_data(void *data)
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
> > +     struct eficonfig_select_file_info *file_info = data;
> > +
> > +     return handle_user_input(file_info->uri, EFICONFIG_URI_MAX, 24,
> > +                              "\n  ** Edit URI **\n"
> > +                              "\n"
> > +                              "  enter HTTP Boot URI:");
> > +}
> > +
> >   /**
> >    * eficonfig_boot_edit_save() - handler to save the boot option
> >    *
> > @@ -998,7 +1040,8 @@ static efi_status_t eficonfig_boot_edit_save(void *data)
> >               bo->edit_completed = false;
> >               return EFI_NOT_READY;
> >       }
> > -     if (u16_strlen(bo->file_info.current_path) == 0) {
> > +     if (u16_strlen(bo->file_info.current_path) == 0 &&
> > +         u16_strlen(bo->file_info.uri) == 0) {
> >               eficonfig_print_msg("File is not selected!");
> >               bo->edit_completed = false;
> >               return EFI_NOT_READY;
> > @@ -1027,6 +1070,13 @@ efi_status_t eficonfig_process_clear_file_selection(void *data)
> >       return EFI_ABORTED;
> >   }
> >
> > +static struct eficonfig_item select_boot_file_menu_items[] = {
> > +     {"Select File", eficonfig_process_select_file},
> > +     {"Enter URI", eficonfig_boot_add_uri},
> > +     {"Clear", eficonfig_process_clear_file_selection},
> > +     {"Quit", eficonfig_process_quit},
> > +};
> > +
> >   static struct eficonfig_item select_file_menu_items[] = {
> >       {"Select File", eficonfig_process_select_file},
> >       {"Clear", eficonfig_process_clear_file_selection},
> > @@ -1042,20 +1092,35 @@ static struct eficonfig_item select_file_menu_items[] = {
> >   efi_status_t eficonfig_process_show_file_option(void *data)
> >   {
> >       efi_status_t ret;
> > +     unsigned int menu_count;
> >       struct efimenu *efi_menu;
> > +     struct eficonfig_item *menu_items;
> > +     struct eficonfig_select_file_info *file_info = data;
> > +
> > +     menu_items = file_info->boot_file_option ? select_boot_file_menu_items :
> > +             select_file_menu_items;
> > +
> > +     menu_count = file_info->boot_file_option ?
> > +             ARRAY_SIZE(select_boot_file_menu_items) :
> > +             ARRAY_SIZE(select_file_menu_items);
> >
> > -     select_file_menu_items[0].data = data;
> > -     select_file_menu_items[1].data = data;
> > -     efi_menu = eficonfig_create_fixed_menu(select_file_menu_items,
> > -                                            ARRAY_SIZE(select_file_menu_items));
> > +     menu_items[0].data = data;
> > +     menu_items[1].data = data;
> > +     menu_items[2].data = data;
> > +
> > +     efi_menu = eficonfig_create_fixed_menu(menu_items, menu_count);
> >       if (!efi_menu)
> >               return EFI_OUT_OF_RESOURCES;
> >
> > -     ret = eficonfig_process_common(efi_menu, "  ** Update File **",
> > +     ret = eficonfig_process_common(efi_menu,
> > +                                    file_info->boot_file_option ?
> > +                                    "  ** Update File/URI **" :
> > +                                    "  ** Update File **",
> >                                      eficonfig_menu_desc,
> >                                      eficonfig_display_statusline,
> >                                      eficonfig_print_entry,
> >                                      eficonfig_choice_entry);
> > +
> >       if (ret != EFI_SUCCESS) /* User selects "Clear" or "Quit" */
> >               ret = EFI_NOT_READY;
> >
> > @@ -1268,6 +1333,7 @@ static efi_status_t prepare_file_selection_entry(struct efimenu *efi_menu, char
> >       u16_strlcat(file_name, file_info->current_path, len);
> >       ret = create_boot_option_entry(efi_menu, title, file_name,
> >                                      eficonfig_process_show_file_option, file_info);
> > +
> >   out:
> >       free(devname);
> >       free(file_name);
> > @@ -1340,6 +1406,16 @@ out:
> >       return ret;
> >   }
> >
>
> Please, document all functions according to
> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation

So I have had this comment from you on my other patches as well. I am
not adding any API in my patch. What exactly is the rule for adding
function documentation? I can understand if some static function
happens to be doing a lot of work, and then it would be easier to
understand its functionality through comments. But I don't think any
function being added in this patch qualifies for such documentation
being needed.

>
> > +static void fill_dp_uri(struct efi_device_path *dp, u16 **uri_str)
> > +{
> > +     u16 *p = *uri_str;
> > +     struct efi_device_path_uri *uridp;
> > +
> > +     uridp = (struct efi_device_path_uri *)dp;
> > +
> > +     utf8_utf16_strcpy(&p, uridp->uri);
> > +}
> > +
> >   /**
> >    * fill_file_info() - fill the file info from efi_device_path structure
> >    *
> > @@ -1392,10 +1468,13 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
> >       size_t len;
> >       efi_status_t ret;
> >       char *tmp = NULL, *p;
> > +     u16 *current_path = NULL;
> >       struct efi_load_option lo = {0};
> >       efi_uintn_t dp_size;
> >       struct efi_device_path *dp = NULL;
> >       efi_uintn_t size = load_option_size;
> > +     struct efi_device_path *dp_volume = NULL;
> > +     struct efi_device_path *uri_dp = NULL;
> >       struct efi_device_path *device_dp = NULL;
> >       struct efi_device_path *initrd_dp = NULL;
> >       struct efi_device_path *fdt_dp = NULL;
> > @@ -1464,6 +1543,14 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
> >               goto out;
> >       }
> >
> > +     bo->file_info.uri = calloc(1, EFICONFIG_URI_MAX * sizeof(u16));
>
> Where is the matching free()?

There is one being added below.

>
> Best regards
>
> Heinrich
>
> > +     if (!bo->file_info.uri) {
> > +             ret =  EFI_OUT_OF_RESOURCES;
> > +             goto out;
> > +     }
> > +
> > +     bo->file_info.boot_file_option = true;
> > +
> >       /* copy the preset value */
> >       if (load_option) {
> >               ret = efi_deserialize_load_option(&lo, load_option, &size);
> > @@ -1481,7 +1568,10 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
> >               u16_strcpy(bo->description, lo.label);
> >
> >               /* EFI image file path is a first instance */
> > -             if (lo.file_path)
> > +             if (lo.file_path && EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE,
> > +                                             MSG_URI))
> > +                     fill_dp_uri(lo.file_path, &bo->file_info.uri);
> > +             else
> >                       fill_file_info(lo.file_path, &bo->file_info, device_dp);
> >
> >               /* Initrd file path (optional) is placed at second instance. */
> > @@ -1512,6 +1602,9 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
> >                       goto out;
> >       }
> >
> > +     if (utf16_utf8_strlen(bo->file_info.uri))
> > +             uri_dp = eficonfig_create_uri_device_path(bo->file_info.uri);
> > +
> >       if (bo->initrd_info.dp_volume) {
> >               dp = eficonfig_create_device_path(bo->initrd_info.dp_volume,
> >                                                bo->initrd_info.current_path);
> > @@ -1536,7 +1629,10 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
> >               efi_free_pool(dp);
> >       }
> >
> > -     dp = eficonfig_create_device_path(bo->file_info.dp_volume, bo->file_info.current_path);
> > +     dp_volume = bo->file_info.dp_volume;
> > +     current_path = bo->file_info.current_path;
> > +     dp = uri_dp ?
> > +             uri_dp : eficonfig_create_device_path(dp_volume, current_path);
> >       if (!dp) {
> >               ret = EFI_OUT_OF_RESOURCES;
> >               goto out;
> > @@ -1560,6 +1656,7 @@ out:
> >       free(tmp);
> >       free(bo->optional_data);
> >       free(bo->description);
> > +     free(bo->file_info.uri);

This is the matching free.

-sughosh

> >       free(bo->file_info.current_path);
> >       free(bo->initrd_info.current_path);
> >       free(bo->fdt_info.current_path);
> > diff --git a/include/efi_config.h b/include/efi_config.h
> > index d7c1601137e..4438933db6a 100644
> > --- a/include/efi_config.h
> > +++ b/include/efi_config.h
> > @@ -82,15 +82,19 @@ struct eficonfig_item {
> >    * @current_volume: pointer to the efi_simple_file_system_protocol
> >    * @dp_volume:              pointer to device path of the selected device
> >    * @current_path:   pointer to the selected file path string
> > + * @uri:             URI for HTTP Boot
> >    * @filepath_list:  list_head structure for file path list
> >    * @file_selectred: flag indicates file selecting status
> > + * @boot_file_option:        flag indicating if option is for boot file
> >    */
> >   struct eficonfig_select_file_info {
> >       struct efi_simple_file_system_protocol *current_volume;
> >       struct efi_device_path *dp_volume;
> >       u16 *current_path;
> > +     u16 *uri;
> >       struct list_head filepath_list;
> >       bool file_selected;
> > +     bool boot_file_option;
> >   };
> >
> >   void eficonfig_print_msg(char *msg);
>
