Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B346CFD314
	for <u-boot@archiver.kernel.org>; Sun, 14 Dec 2025 07:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0742780433;
	Sun, 14 Dec 2025 08:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bSvUlg8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9059F803F5; Sun, 14 Dec 2025 08:37:28 +0100 (CET)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9081D808AF
 for <u-boot@lists.denx.de>; Sun, 14 Dec 2025 08:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6455a60c12bso1340681d50.3
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 23:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765697844; x=1766302644; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eKuiaRjEy05drHTghIN7ZTVvMf318qKr1C6rssY98ck=;
 b=bSvUlg8LUMogjZAUXAUjqCqEeu6gTRs4iJS8hibtBoYwSkYMmOw9z0hmOYuzg5ASSw
 Q+8IVmgz5SaMiCuJRdFkwkkbnLWs+u0oV6EKEXN1Oz/ZTYWEdNsQnU2Kpk8pDue6TRJe
 DA17aZn2bGit+Ksm8sebfbX/UuCXjXc5fQ2qeTW19nfdoHZJA67dTelep21YQJqhBTyB
 lDh/4cNvXVU4I2m9C3o21VyRcILvNDgHHguvKckDDrg7M26OZDOhoVEjmw6md9RYKkIO
 2gxvUr3wsNOBIgz+7RuS8eujmT/fkH03lgXide7VgTlDwfT5Fzcx4UIQ+bqBjejmsImB
 TEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765697844; x=1766302644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKuiaRjEy05drHTghIN7ZTVvMf318qKr1C6rssY98ck=;
 b=op3KZBp9p9Chq2StJyQ543LzOP2OwI3jbWy+2Ei3BqcPmfuWkDnRcwPPF3AudkAejy
 bKUGGxS1XObuTq5laQelCIHFC6oKMDm8Zftb9XjqXt3ES6m9EwWHKIPnj5uXXjNgBTT9
 FLm2Cj26SqiJBubeUEN3e2lIasAvbjuaFhNzG7xGlt0kNP8VPqUoAF2k8aRzLJth0MJp
 fA+j7bydE26T3WsMJG9aFDiNwKwL8DbVZew6ki+TLZOLLAHihi8tUZkL1AYJobEAjJS3
 e/wcSGoHu6ddqdURTtBQCM39a5s4tH/+nodm3PFVbd6QLaiFz97nCSENt7KVKZC9R3+M
 7QoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZIi9t3ONMRAkBdoHUAyt/BolIPPmYFUZOXAw0u1PvUWqfPaVoJ9ekp2jDLjspeO5U7442oKg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxg8nzRMg3ecswTyhf0keU7X17dQWzp4nduuAWQ09ph2ObrvFYB
 1GnpNEvV3lNYo6WJ1fPzg/rdNkwIyFpi5XfflABabkdt41VYSCn4pTnksIsZQy9WgXGEKpdcnFg
 WtW7lsQN1bgMFaTcR+z/9jJFdbCUXiDs+zyAdJtWEZw==
X-Gm-Gg: AY/fxX6jYDQ8gG+0kj62eryux+fU06qe+ND89EaJS2aCdq914kIWR3SIGJ282OgHrZQ
 Uahuw6rcCMRvCEg5HQ3xi+LNRTf/gOPSxkKD85M5lhn0/dN6iM9oOBGhsuJ+p+8URkMj4XAfz8t
 l/i+0SxaJ7YWeaInMEgFBOlwmN20AXL9ut+EIOzhHgFYJenXXkQ90AO2l4wHdcGQb6VbTKB6d32
 PVXOKBIwLlXbCqo6YVLIjV4Rzd9oIfPuZSdK0SWDe4zqg0j2b+D+xmZcck+7UOZn1wUf7rg6/70
 hjt3ybWj4IwI+kz4FrTK3j9ggR4CZWPhNJ4emwxwKLLhPdl8b/iFP/bnB4skrxKd4cKXVmNB38+
 zHSKCVH6IJ/i96wuOPnOkenNLIEQbLI+dXm48Q5lCuiTVorpdkrSjOaaYUQGnh2Uyw8DqSC2bZ2
 JYVaTqGbiV5GLw4jOh/KAGDV5/0a+jwFSM5xl422h9dRT1V/e6fFZYHBv223Y9FrAkrrdcsFEAN
 8rGzzDRWfX7GqE5T/MQP3DXNBwkJcSaQooGOcjl4D2gE1wJiB2TtcwBGPYK5E7zvmv+RSKOP+6h
 1Y8UN1D2ihn8QkUPYT+oRIyA56wx/WpG
X-Google-Smtp-Source: AGHT+IE0VRYVfRwyBuVtIDPr18YY4TEcG4EBsrZ8Gis67NcxvBabFgg4pzZD3JjYuLqsh2/KSqHvYCNV65quYgI3Vy4=
X-Received: by 2002:a05:690e:1890:b0:645:527b:bc06 with SMTP id
 956f58d0204a3-645555cdabdmr5462324d50.4.1765697844286; Sat, 13 Dec 2025
 23:37:24 -0800 (PST)
MIME-Version: 1.0
References: <20251208151503.1681988-1-ilias.apalodimas@linaro.org>
 <1623f49d-708e-4e23-a92e-54636d92d239@gmx.de>
In-Reply-To: <1623f49d-708e-4e23-a92e-54636d92d239@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 14 Dec 2025 09:36:48 +0200
X-Gm-Features: AQt7F2qjXSGq5t4hsBFp51_aFZcFUO8QuG17DAUAjYzBg5WsuIo4Sc-VHXgdaZs
Message-ID: <CAC_iWjKzi-eM6YkXG2xBTxBVKyrjUtqz=NnBw0ZLcF0y2W3vFA@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: Trigger capsule updates with automatically
 generated boot options
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 John Toomey <john.toomey@amd.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Javier Tia <javier.tia@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Yao Zi <ziyao@disroot.org>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Maks Mishin <maks.mishinfz@gmail.com>, u-boot@lists.denx.de
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

[...]

> >   /*
> >    * Determine if an MMC device is an SD card.
> > @@ -109,10 +122,11 @@ struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
> >    */
> >   static efi_handle_t find_handle(struct efi_device_path *dp,
> >                               const efi_guid_t *guid, bool short_path,
> > -                             struct efi_device_path **rem)
> > +                             struct efi_device_path **rem,
> > +                             enum match match)
> >   {
> >       efi_handle_t handle, best_handle = NULL;
> > -     efi_uintn_t len, best_len = 0;
> > +     efi_uintn_t len, match_len = 0, best_len = 0;
> >
> >       len = efi_dp_instance_size(dp);
> >
>
> Where is the documentation update for find_handle()?

The description is in efi_dp_find_obj() which is the only place
find_handle() is called. You want to add something in find_handle() as
well?

>
> > @@ -137,22 +151,35 @@ static efi_handle_t find_handle(struct efi_device_path *dp,
> >                       if (!dp_current)
> >                               continue;
> >               }
> > -             len_current = efi_dp_instance_size(dp_current);
> > -             if (rem) {
>
> Before this patch calling efi_dp_find_obj(rem == NULL) would only return
> exact matches.
>
> With the patch efi_dp_find_obj(rem == NULL) matches shorter paths.
>
> Your commit message does not describe that you want to change the logic
> of efi_fs_from_path().

you mean efi_dp_find_obj()? I do mention the current functionality and
how it changes. There's a paragraph in the commit message that
explains that the function currently decides on the exact match based
on the validity of the 'rem ptr and that an an enum is added. If it's
unclear i'll reword it.

>
> > +
> > +             match_len = len_current = efi_dp_instance_size(dp_current);
> > +             switch (match) {
> > +             case EXACT:
> > +                     if (len_current != len)
> > +                             continue;
> > +                     break;
> > +             case SHORTER:
> >                       if (len_current > len)
> >                               continue;
> > -             } else {
> > -                     if (len_current != len)
> > +                     break;
> > +             case LONGER:
> > +                     if (len_current < len)
> >                               continue;
>
> So here the logic is:
>
> When search for \a\b;
>
> \a\b\c\d is a better match than \a\b\c
>
> Is this intended?
> I can't find it in the function description of find_handle().

Yes it is, the description is in the efi_dp_find_obj(). You want me to
move it around? Or expand find_handle() as well?

>
> > +                     match_len = len;
> > +                     break;
> >               }
> > -             if (memcmp(dp_current, dp, len_current))
> > +
> > +             if (memcmp(dp_current, dp, match_len))
> >                       continue;
> >               if (!rem)
> >                       return handle;
> >               if (len_current > best_len) {
> >                       best_len = len_current;
> >                       best_handle = handle;
> > -                     *rem = (void*)((u8 *)dp + len_current);
> > +                     if (len_current <= len)
> > +                             *rem = (void *)((uintptr_t)dp + len_current);
> > +                     else
> > +                             *rem = (void *)((uintptr_t)dp_current + match_len);
> >               }
> >       }
> >       return best_handle;
> > @@ -160,14 +187,25 @@ static efi_handle_t find_handle(struct efi_device_path *dp,
> >
> >   efi_handle_t efi_dp_find_obj(struct efi_device_path *dp,
> >                            const efi_guid_t *guid,
> > -                          struct efi_device_path **rem)
> > +                          struct efi_device_path **rem, bool match_longer)
> >   {
> >       efi_handle_t handle;
> >
> > -     handle = find_handle(dp, guid, false, rem);
> > +     handle = find_handle(dp, guid, false, rem, EXACT);
>
> Here you are tweaking the logic a lot without really describing it:
>
> efi_dp_find(rem != NULL) used to match in sequence:
>
> 1) exact long path
> 2) longest long path with dp as start
> 3) exact short path
> 4) longest short path with dp as start
>
> now you have
>
> 1) exact long path
> 2) exact short path
> 3) longest long path with dp as start
> 4) longest short path with dp as start
>
> This might be intended. But it is neither described in the commit
> message nor in the function description.

I'll reword the commit message.

>
> >       if (!handle)
> > -             /* Match short form device path */
> > -             handle = find_handle(dp, guid, true, rem);
> > +             handle = find_handle(dp, guid, true, rem, EXACT);
> > +     if (handle)
> > +             return handle;
> > +
>
> Check the value of rem here (see comment above).

Sure

>
> Having both rem != NULL and match_longer == true wouldn't make much sense.
>
> Theorectically we could use *rem == LONGER for allowing longer DPs and
> *rem == SHORTER for other cases to avoid the extra argument.
>
> #define LONGER ((void *)(uintptr_t) - 1)
> #define SHORTER (NULL)

Sure, but I think the enum is clearer. Unless you really want this
I'll keep the enum

Thanks
/Ilias

>
> Best regards
>
> Heinrich
>
> > +     handle = find_handle(dp, guid, false, rem, SHORTER);
> > +     if (!handle)
> > +             handle = find_handle(dp, guid, true, rem, SHORTER);
> > +
> > +     if (match_longer && !handle) {
> > +             handle = find_handle(dp, guid, false, rem, LONGER);
> > +             if (!handle)
> > +                     handle = find_handle(dp, guid, true, rem, LONGER);
> > +     }
> >
> >       return handle;
> >   }
> > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > index 130c4db9606f..0d3d7c187d72 100644
> > --- a/lib/efi_loader/efi_disk.c
> > +++ b/lib/efi_loader/efi_disk.c
> > @@ -339,7 +339,7 @@ efi_fs_from_path(struct efi_device_path *full_path)
> >       efi_free_pool(file_path);
> >
> >       /* Get the EFI object for the partition */
> > -     efiobj = efi_dp_find_obj(device_path, NULL, NULL);
> > +     efiobj = efi_dp_find_obj(device_path, NULL, NULL, false);
> >       efi_free_pool(device_path);
> >       if (!efiobj)
> >               return NULL;
> > --
> > 2.43.0
> >
>
