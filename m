Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2131C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 12:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18B8E88676;
	Fri, 24 May 2024 14:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xDqHNyIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 584C688653; Fri, 24 May 2024 14:20:53 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2651A88552
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 14:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-681bee6bb13so539948a12.1
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716553249; x=1717158049; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QPEqAyyCBKRw79f2lAbX8TjBJioKsSIU7xEvGoWFY0A=;
 b=xDqHNyIT+MFNOTUy0qC2wIskk5tHtAwCzk3n2s6y4IkW9IGo/2xUfAaYpK3JXngKpE
 wvudJVDJPyTbP4Oz7AwJgq13UtZ53+Hsr6KGduvIkNyOwiL/pTfOXD/j2/vLLNSR2vAj
 tw2DaA6z5RpqQmWy7bH/ZdJZXHtj3votWZfNKL/Sdwx5pH3BaJB0O7lRzz8Z3BCgcorj
 4yxSY+aPuK+D3qnBIbM5KSGgnnyoAajAHG0V+QaQ82RrMmw5YzfwBOIgYgKiDkWedUiv
 SZS27IuYew0UApvQjSk+S+f0VEU8cjTk5Z1LMWP+kLFYNXfJFTpMxb+H0KyiJwIdSD9I
 Sg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716553249; x=1717158049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QPEqAyyCBKRw79f2lAbX8TjBJioKsSIU7xEvGoWFY0A=;
 b=O+i6pnLOnh20LqNPxB3Ad3j8VTYdOO+PWWHQZpajr2PaT0o8KP66YshjP5UborwWYP
 NfgC0UdkvXvIVCtRPhdPnrDwHswsoqHTam/fWuQjKOT1Ev2ucpQohEZ7w6Mjlewdqhos
 lCU0z29OdWaeRktwSTab8yD/Rg7EMrfUg30h7KigYeV+rV2f8NU8DWUGd6bPHfiOxA0Y
 uhYkXqZZ8F9tPkDpU7sKbJL+T196uSeM/KAcA6lwWO/eX2vPOVqod48X+qIRH1rVp/3T
 9OaukELy+LazTNtBkj+kmMigU3jrmP5FDmtB7yGlZSJTL8d/ksI965bCT6lVK3NJ0he6
 8zbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFc5hHAQCL2DXl6qtGB18Eam/zr9K32HOWvvrs/06cFk2lfqc8TGSemhkYiV/uyAiIi17jc6EBIV+JtC0PFcxXrh/ELw==
X-Gm-Message-State: AOJu0YzmuLIWHoVZnrvIW+nvHzRsds/Bf418smRAyk86Oi3nSXEy76Ax
 0npTS+mq7yrAYZNW24Kzgc5jGGobHb5sjspehszTWV4sv2H30Kqn8wMxiZReqqnle9XzJqg6yzG
 vq8VqHQ7UlNKKJvFgcIrcN9msQBmq9K7N1FlY3HxUOKGLR7ZxDmE=
X-Google-Smtp-Source: AGHT+IHYvrATguHGwUMoN4fHY8sCivrxf6f2G7OOqfPH45K5KhREynHQ1Skt2H5x2uADCVTfEZJNjdxhRXOP3xqriWM=
X-Received: by 2002:a17:90a:f109:b0:2bd:d67b:6bf3 with SMTP id
 98e67ed59e1d1-2bddcf226famr6918349a91.20.1716553249545; Fri, 24 May 2024
 05:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
 <20240426-b4-dynamic-uuid-v1-2-e8154e00ec44@linaro.org>
 <CAC_iWjKZe+0EMC76TxdtBZju99QAApodqEZHdaKJt1E-mMw6ow@mail.gmail.com>
 <c5c79a74-19ad-459e-8c42-c7a9fc31614a@linaro.org>
In-Reply-To: <c5c79a74-19ad-459e-8c42-c7a9fc31614a@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 24 May 2024 15:20:13 +0300
Message-ID: <CAC_iWjJPfB4G5uc_Xm1Tod2gBgd4M7TiOgn-Rf7zChDKSqV=tQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] efi: add a helper to generate dynamic UUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

On Fri, 24 May 2024 at 15:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 24/05/2024 08:37, Ilias Apalodimas wrote:
> > [...]
> >
> >
> >>   config EFI_CAPSULE_FIRMWARE_MANAGEMENT
> >> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> >> index de0d49ebebda..9ef67d1b4405 100644
> >> --- a/lib/efi_loader/efi_capsule.c
> >> +++ b/lib/efi_loader/efi_capsule.c
> >> @@ -19,8 +19,9 @@
> >>   #include <mapmem.h>
> >>   #include <sort.h>
> >>   #include <sysreset.h>
> >>   #include <asm/global_data.h>
> >> +#include <uuid.h>
> >>
> >>   #include <crypto/pkcs7.h>
> >>   #include <crypto/pkcs7_parser.h>
> >>   #include <linux/err.h>
> >> @@ -403,8 +404,40 @@ out:
> >>          return status;
> >>   }
> >>   #endif /* CONFIG_EFI_CAPSULE_AUTHENTICATE */
> >>
> >> +#if CONFIG_IS_ENABLED(EFI_CAPSULE_DYNAMIC_UUIDS)
> >> +int efi_capsule_update_info_gen_ids(efi_guid_t *namespace, const char *soc, const char *model, const char *compatible)
> >> +{
> >> +       int i;
> >
> > Perhaps irrelevant to this patch, but do we need to define the name
> > space in platform code?
> > Can't we just put it on a Kconfig and do the dynamic UUIID generation
> > in efi_capsule.c?
>
> Having the namespace be a kconfig option probably makes sense, then it
> could be the thing vendors have to populate for their production boards
> (and they could just have one for all of their products across many
> architectures). So by setting one option they'd have totally unique
> GUIDs for everything.

Exactly and you would be able to reuse the entire machinery without
having to add platform code, since the GUID population would live in
the the efi firmware parts

Cheers
/Ilias
>
> >
> > Thanks
> > /Ilias
> >> +
> >> +       if (!soc || !model || !compatible) {
> >> +               log_err("%s: soc, model, or compatible not defined\n", __func__);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       if (!update_info.num_images) {
> >> +               log_err("%s: no fw_images, make sure update_info.num_images is set\n", __func__);
> >> +               return -ENODATA;
> >> +       }
> >> +
> >> +       for (i = 0; i < update_info.num_images; i++) {
> >> +               gen_uuid_v5((struct uuid*)namespace,
> >> +                           (struct uuid *)&update_info.images[i].image_type_id,
> >> +                           soc, strlen(soc),
> >> +                           model, strlen(model),
> >> +                           compatible, strlen(compatible),
> >> +                           update_info.images[i].fw_name, u16_strlen(update_info.images[i].fw_name),
> >> +                           NULL);
> >> +
> >> +               log_debug("Image %ls generated UUID %pUs\n", update_info.images[i].fw_name,
> >> +                         &update_info.images[i].image_type_id);
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +#endif
> >> +
> >>   static __maybe_unused bool fwu_empty_capsule(struct efi_capsule_header *capsule)
> >>   {
> >>          return !guidcmp(&capsule->capsule_guid,
> >>                          &fwu_guid_os_request_fw_revert) ||
> >>
> >> --
> >> 2.44.0
> >>
>
> --
> // Caleb (they/them)
