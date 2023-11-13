Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F45C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 20:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 199A9870E6;
	Mon, 13 Nov 2023 21:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MrIOrZAi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 039C2870FF; Mon, 13 Nov 2023 21:32:19 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2FD086940
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 21:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50943ccbbaeso6981471e87.2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 12:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699907536; x=1700512336; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2heGXP43p3AarIvoIekUNxHmB4xYq2eeCrs6lN52yhQ=;
 b=MrIOrZAi5MK4++ssMWhOL+541TwIcrOfAwa7ufjRDtFV7ygi4+v1wQzrWC+ZaJfcZG
 nreHV+S24BjOVEEaPHLhuZod5gwQmwxDETfuXvXV9PkfqIua1zvjYDtO3MByNFGGNM6A
 LB+kURiekfity0DoUFl8u1WNMsRfOtKobxze09S+hMuIHHlQuXbEjRkw7r42Q5/6DjDF
 FwvDnhdHZJn8XDhrH9/wOA9dck+Pld9zqCguaRTjjbw9ZYe2oFRN+dwxG1EEMP+Ay4cc
 x8XXj/FBlZs48tsc9clxWnmubXk5US/lksG5w5Qrjf+WG1T1aWdqkw56C8uDvT70d2di
 Cs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699907536; x=1700512336;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2heGXP43p3AarIvoIekUNxHmB4xYq2eeCrs6lN52yhQ=;
 b=XJ8hGpbJlOg/xTs/e6Yl8sDasCb+cpwDrB2nBk0fE/ThM2knoZMYvTeocZHl7FCEsQ
 hXy0B29sgUajsBpUnb57lblcMMMpa208GqHSi3//pb/juVk2baaN5mbQGTdl5QKN7fGe
 kJy5qFoBEfYOQnxGTuL3SxlSoBNY/m82z8WeikoT8i+t6gQ3W+QJozeCKIztwSbvFjwN
 i2mdfahlhz5Le3EZO8uX7aBc9lM38jIgVpy58h0VCSeodvqJ4x+jSzII/XcMroISpfv0
 U0/Ky8R7G0DofoWuG26bXKKD5S46EA0En4d5/2T6WHfYheKle8ZhYXLOE+xFuQQD5FRW
 j1RQ==
X-Gm-Message-State: AOJu0YzwZn6p+pn/NOqL0m53MfFzhJeVtS7tZJh158bWWpxLWjtPWZNf
 EQ5v+nHq1B8Mej0NC+g3kY3T92eaeuIWlaep4y37dw==
X-Google-Smtp-Source: AGHT+IFOmxiqPUOXM/k75AysJPd75xXJdcBnwYNu7bjTzi20VCIxLOx7MlIve0ibKjH+KiKFNDBG9/sjNGSIxjjJCaw=
X-Received: by 2002:ac2:54a8:0:b0:503:5cd:998b with SMTP id
 w8-20020ac254a8000000b0050305cd998bmr4595885lfk.28.1699907535528; Mon, 13 Nov
 2023 12:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20231107173636.114705-1-ilias.apalodimas@linaro.org>
 <f1fb200b-8aef-4cb8-b988-cb6f9a076132@gmx.de>
In-Reply-To: <f1fb200b-8aef-4cb8-b988-cb6f9a076132@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 13 Nov 2023 15:31:38 -0500
Message-ID: <CAC_iWjLq-VHB7ar-BaWi5o3SPZEnCk0pBWixPTEYxLmkgmHTrg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Clean up efi_dp_append and efi_dp_concat
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: masahisa.kojima@linaro.org, u-boot@lists.denx.de
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

Hi Heinrich

On Mon, 13 Nov 2023 at 09:37, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/7/23 18:36, Ilias Apalodimas wrote:
> > Looking back at the initrd storing functionality, we introduced three
> > functions, efi_dp_append_or_concatenate(), efi_dp_append/concat(). In
> > hindsight we could have simplified that by a lot. First of all none of
> > the functions append anything. They all allocate a new device path and
> > concatenate the contents of two device paths in one. A boolean parameter
> > controls the final device path -- if that's true an end node is injected
> > between the two device paths.
> >
> > So let's rewrite this and make it a bit easier to read. Get rid of
> > efi_dp_append(), efi_dp_concat() and rename
> > efi_dp_append_or_concatenate() to efi_dp_concat(). This is far more
> > intuitive and the only adjustment that is needed is an extra boolean
> > argument on all callsites.
>
> After this patch we still have efi_dp_append_instance(). The only
> difference to efi_dp_concat(,,true) seems only to be the type of end
> node used as separator.
>
> Hence the last argument of efi_dp_contat() should be be either of:
>
> * 0
> * DEVICE_PATH_SUB_TYPE_INSTANCE_END
> * DEVICE_PATH_SUB_TYPE_END

ah fair enough, I'll clean that up as well. Add an enum as a 3rd argument then?

rd_dp) + sizeof(END);
> >       } else {
> >               final_dp = efi_dp_dup(dp);
> > diff --git a/cmd/efidebug.c b/cmd/efidebug.c
>
> >
> > -     final_fp = efi_dp_concat(file_path, initrd_dp);
> > +     final_fp = efi_dp_concat(file_path, initrd_dp, true);
> >       if (!final_fp) {
> >               printf("Cannot create final device path\n");
> >               r = CMD_RET_FAILURE;
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index e24410505f40..398cd20c7ae6 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -808,8 +808,6 @@ efi_uintn_t efi_dp_instance_size(const struct efi_device_path *dp);
> >   /* size of multi-instance device path excluding end node */
> >   efi_uintn_t efi_dp_size(const struct efi_device_path *dp);
> >   struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp);
> > -struct efi_device_path *efi_dp_append(const struct efi_device_path *dp1,
> > -                                   const struct efi_device_path *dp2);
> >   struct efi_device_path *efi_dp_append_node(const struct efi_device_path *dp,
> >                                          const struct efi_device_path *node);
> >   /* Create a device path node of given type, sub-type, length */
> > @@ -928,7 +926,8 @@ struct efi_load_option {
> >   struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
> >                                      const efi_guid_t *guid);
> >   struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
> > -                                   const struct efi_device_path *dp2);
> > +                                   const struct efi_device_path *dp2,
> > +                                   bool split_end_node);
> >   struct efi_device_path *search_gpt_dp_node(struct efi_device_path *device_path);
> >   efi_status_t efi_deserialize_load_option(struct efi_load_option *lo, u8 *data,
> >                                        efi_uintn_t *size);
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index a40762c74c83..646c7c7faaad 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -110,7 +110,7 @@ static efi_status_t try_load_from_file_path(efi_handle_t *fs_handles,
> >               if (!dp)
> >                       continue;
> >
> > -             dp = efi_dp_append(dp, fp);
> > +             dp = efi_dp_concat(dp, fp, false);
> >               if (!dp)
> >                       continue;
> >
> > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> > index 0b7579cb5af1..709ea07655c2 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -1821,7 +1821,7 @@ efi_status_t efi_setup_loaded_image(struct efi_device_path *device_path,
> >       if (device_path) {
> >               info->device_handle = efi_dp_find_obj(device_path, NULL, NULL);
> >
> > -             dp = efi_dp_append(device_path, file_path);
> > +             dp = efi_dp_concat(device_path, file_path, false);
> >               if (!dp) {
> >                       ret = EFI_OUT_OF_RESOURCES;
> >                       goto failure;
> > diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> > index ed7214f3a347..ad79b65843e9 100644
> > --- a/lib/efi_loader/efi_device_path.c
> > +++ b/lib/efi_loader/efi_device_path.c
> > @@ -272,30 +272,27 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
> >   }
> >
> >   /**
> > - * efi_dp_append_or_concatenate() - Append or concatenate two device paths.
> > - *                               Concatenated device path will be separated
> > - *                               by a sub-type 0xff end node
> > + * efi_dp_concat() - Concatenate two device paths and add and terminate them
> > + *                   with an end node.
> >    *
> > - * @dp1:     First device path
> > - * @dp2:     Second device path
> > - * @concat:  If true the two device paths will be concatenated and separated
> > - *           by an end of entrire device path sub-type 0xff end node.
> > - *           If true the second device path will be appended to the first and
> > - *           terminated by an end node
> > + * @dp1:         First device path
> > + * @dp2:         Second device path
> > + * @split_end_node: If true the two device paths will be concatenated and
> > + *                  separated by an end node.
>
> This description is unclear. Do you mean DEVICE_PATH_SUB_TYPE_END or
> DEVICE_PATH_SUB_TYPE_INSTANCE_END?

I think it's  DEVICE_PATH_SUB_TYPE_END, I'll double check

>
> We would better make the parameter a three-state value:
>
> * 0
> * DEVICE_PATH_SUB_TYPE_INSTANCE_END
> * DEVICE_PATH_SUB_TYPE_END

Ok i'll add an enum

>
> > + *               If false the second device path will be concatenated to the
> > + *               first one as-is.
> >    *
> >    * Return:
> >    * concatenated device path or NULL. Caller must free the returned value
> >    */
> > -static struct
> > -efi_device_path *efi_dp_append_or_concatenate(const struct efi_device_path *dp1,
> > -                                           const struct efi_device_path *dp2,
> > -                                           bool concat)
> > +struct
> > +efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
> > +                            const struct efi_device_path *dp2,
> > +                            bool split_end_node)
> >   {
> >       struct efi_device_path *ret;
> >       size_t end_size = sizeof(END);
>
> This assignment is not needed if (!dp1 || !dp2).
>
> >
> > -     if (concat)
> > -             end_size = 2 * sizeof(END);
> >       if (!dp1 && !dp2) {
> >               /* return an end node */
> >               ret = efi_dp_dup(&END);
> > @@ -307,14 +304,18 @@ efi_device_path *efi_dp_append_or_concatenate(const struct efi_device_path *dp1,
> >               /* both dp1 and dp2 are non-null */
> >               unsigned sz1 = efi_dp_size(dp1);
> >               unsigned sz2 = efi_dp_size(dp2);
> > -             void *p = efi_alloc(sz1 + sz2 + end_size);
> > +             void *p;
> > +
> > +             if (split_end_node)
> > +                     end_size = 2 * sizeof(END);
>
> We assign end_size twice in this case. We should instead move the first
> assignment to the if:
>
>                 if (!split_end_node)
>                         end_size = sizeof(END);
>                 else
>                         end_size = 2 * sizeof(END);
>
[...]

Thanks
/Ilias
