Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644E2D41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 10:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 874CA80050;
	Mon, 15 Dec 2025 11:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lRHt72Td";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CB2080077; Mon, 15 Dec 2025 11:29:38 +0100 (CET)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 282178003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 11:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-644795bf5feso2860783d50.2
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 02:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765794574; x=1766399374; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U9FXEZ8x2ailfxCnzgAub3fEavHKWruXpceNuoXUCbM=;
 b=lRHt72TdJNDhDKoMcPbYkwl20BES4HRoGNgww3HTYEJPpH9g0iXvSwEczvZwRTLncO
 sRfSljo2dyRNOtk83tSKSzkIrCe7aynAnv+KkYc67GKXqLdTTXHSVCRteeVoyqUbiM9b
 /Z/u+W03Y/jV6G43mb0NOy7O86wfavlrx1q/ecf/h7OGbNU+lyjTLld5aEXdggNZk4bB
 TxG312t/FTSeYmbss3VLDYpeULuav26FP+Go3SGits5uKgS8ioq44EGQXG7BAqQocCil
 1zgauwDMgabY62GULL0NMFXkzzk/Jz1Rq0nMu6N43R6YyeDUuID3bcGip7HHso4A4/V0
 B1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765794574; x=1766399374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9FXEZ8x2ailfxCnzgAub3fEavHKWruXpceNuoXUCbM=;
 b=gdeytSl4BO8QCkukMRZ7MfzKHPiJraPv3mPnpbxpWYtGzdgRoqyRZOXUcUtgsRb3zX
 T66AlrDN3S9lopR0dwVQ3aSzkwom78REvrQEo+k0KadNXGrBFHcbSPBhD7/wbU63voLn
 gRYC5g6nI/VnfDNJmCLYpQfUj9/GufV0LdgZ1a2Qxo++NFO2QMDTiEyFPtB3h9NI7ZYx
 eoTlqL7egBghSHiQO/VLQb9TucZPCcpVyMmiylgfEYZOMeMoly4enBbdFx0PHWiMFwOm
 mePknM/K/1XJGH/4+e+g9S3aT9CAG5DOjsPW2q8HLLsNGMEk+ScuKFfBMyoyipPSbMyb
 E49Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvEsWvNXwQHvZtmNkmnGkZ0pjrV+GFOp3L0I2cUrso2XuagHHVFpxSIwHbWzk0YXkyzwWanFU=@lists.denx.de
X-Gm-Message-State: AOJu0YzFQ8ddwQuiLTHmoKZESEGatIUQV1zb1D+Od13jsTKBlb9ePXj3
 YfaoQJUxAlpGX3UYyrWvHdJ1ekVg5G6apUu56d2HNEsCL77YS4oH7AvMmoe57OLGEdHozEFg5Zc
 bzCLBfaTiMmm0ht0ieJuDcvY4HwnKfSot+pc6D+82cw==
X-Gm-Gg: AY/fxX5u0N0ImG4An0wQjqRjtS6vbTwfiYDcofvUE7Q+jNpdSCr+iX+yjjMxTvehVyF
 iDqnf68Hv1S8cw/c4A4zYidsTpgHHa6mVkEmlBOG6Vx7TKfPotFdmEx8iB5D5EKnQflb3HKEpbx
 dxZfVktApq6wlBZmlMEOCfO9uUBPBOGB/kAn/GslikuZ/dZqNgoAghl2Tgu2M6B25rBWP5n/dP6
 aUjm6lv8iswibIe6ZxnBb73KmOM3A+c5n+lD9FtrCYcEq55FSRPk/4IRkVbAeFXKEWstKNOX6Tf
 DRa84wuf7YvPb6GmuabnnQR65T2E/VZrOR+IoB1HoUTUkZTDw5JeUdwUYpe8A23rXeuQy4gQxbu
 MPDpg7r6usDRtzmmKvI1Kh6MO8VK5p/BODJW4ma5Ovj2ZGi9KD5gOJqNyFidh71PhtG1GACBkqN
 KaG62KnJ4Fz91BKTWBb/Rx4DdvzGNztfCLMeHoxQGSxLlVEEjhcnBkxy5917WAVZwkgL7DtFvi1
 VG5IDZ0/M0Hwo5n+eO6DE78yPdg8wo8W+2oqW5YW2t8W6/2L73/0wR4gt4AttZAUJ0eCIwtnq+5
 mCsTfZom3qiy8pEcimVz4aSHYvue1dxk
X-Google-Smtp-Source: AGHT+IGd6qxIZB1Hk17ZItrRHPtxOChlQq9gOCHqKwir2660TmAdGHA3DlBeAcOcLgb2eF8zPWS09wGi6DmTv/h0YS0=
X-Received: by 2002:a53:d3c2:0:b0:641:718:8a08 with SMTP id
 956f58d0204a3-6455564e8e9mr5930993d50.52.1765794573810; Mon, 15 Dec 2025
 02:29:33 -0800 (PST)
MIME-Version: 1.0
References: <20251208151503.1681988-1-ilias.apalodimas@linaro.org>
 <1623f49d-708e-4e23-a92e-54636d92d239@gmx.de>
 <CAC_iWjKzi-eM6YkXG2xBTxBVKyrjUtqz=NnBw0ZLcF0y2W3vFA@mail.gmail.com>
 <257d0dca-ad77-483b-a91a-3c2d1c4f9b24@gmx.de>
In-Reply-To: <257d0dca-ad77-483b-a91a-3c2d1c4f9b24@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 15 Dec 2025 12:28:57 +0200
X-Gm-Features: AQt7F2qaP64BhCh5mlE4Vfr7esCd9AFO5GfV_W5fkQCSvfcoaEqWBJ206MiWaxI
Message-ID: <CAC_iWjK0hZNpBoWk88XUcJchF0fdNmxWbyk4D5fJpq21TmkV8g@mail.gmail.com>
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

On Sun, 14 Dec 2025 at 13:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/14/25 08:36, Ilias Apalodimas wrote:
> > Hi Heinrich
> >
> > [...]
> >
> >>>    /*
> >>>     * Determine if an MMC device is an SD card.
> >>> @@ -109,10 +122,11 @@ struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
> >>>     */
> >>>    static efi_handle_t find_handle(struct efi_device_path *dp,
> >>>                                const efi_guid_t *guid, bool short_path,
> >>> -                             struct efi_device_path **rem)
> >>> +                             struct efi_device_path **rem,
> >>> +                             enum match match)
> >>>    {
> >>>        efi_handle_t handle, best_handle = NULL;
> >>> -     efi_uintn_t len, best_len = 0;
> >>> +     efi_uintn_t len, match_len = 0, best_len = 0;
> >>>
> >>>        len = efi_dp_instance_size(dp);
> >>>
> >>
> >> Where is the documentation update for find_handle()?
> >
> > The description is in efi_dp_find_obj() which is the only place
> > find_handle() is called. You want to add something in find_handle() as
> > well?
>
> I would like the function find_handle() to be documented in a way that
> would allow to review its functionality irrespective of where it is used.

Fair enough, I'll update both functions in v3

>
> >
> >>
> >>> @@ -137,22 +151,35 @@ static efi_handle_t find_handle(struct efi_device_path *dp,
> >>>                        if (!dp_current)
> >>>                                continue;
> >>>                }
> >>> -             len_current = efi_dp_instance_size(dp_current);
> >>> -             if (rem) {
> >>
> >> Before this patch calling efi_dp_find_obj(rem == NULL) would only return
> >> exact matches.
> >>
> >> With the patch efi_dp_find_obj(rem == NULL) matches shorter paths.
> >>
> >> Your commit message does not describe that you want to change the logic
> >> of efi_fs_from_path().
> >
> > you mean efi_dp_find_obj()? I do mention the current functionality and
> > how it changes. There's a paragraph in the commit message that
> > explains that the function currently decides on the exact match based
> > on the validity of the 'rem ptr and that an an enum is added. If it's
> > unclear i'll reword it.
>
> I have created
>
> [PATCH 1/1] efi_selftest: enhance LoadImage test
> https://lore.kernel.org/u-boot/20251214110937.136425-1-heinrich.schuchardt@canonical.com/T/#u
>
> which demonstrates the unintended side effect which could not have been
> derived from the code comments or the commit message.

Ok thanks that helps.

The problem is not re-organizing efi_dp_find_obj() to search for
1. exact long path
2. exact short path
3. longest long path with dp as start
4. longest short path with dp as start

Instead of

1. exact long path
2. longest long path with dp as start
3. exact short path
4. longest short path with dp as start

In fact I think this change is correct and we should keep it. Exact
DPs should always take priority when searching for them.

The problem is that efi_dp_find_obj() will now do a best match even if
rem is NULL. IOW find_handle() is working correctly, but
efi_dp_find_obj() changes its behavior. Adding a rem check fixes the
issue

Something like this:
@@ -194,7 +194,7 @@ efi_handle_t efi_dp_find_obj(struct efi_device_path *dp,
        handle = find_handle(dp, guid, false, rem, EXACT);
        if (!handle)
                handle = find_handle(dp, guid, true, rem, EXACT);
-       if (handle)
+       if (handle || !rem)
                return handle;

        handle = find_handle(dp, guid, false, rem, SHORTER);


Earlier you proposed
#define LONGER ((void *)(uintptr_t) - 1)
#define SHORTER (NULL)
using *rem == LONGER for allowing longer DPs and *rem == SHORTER for
other cases to avoid the extra argument.

I can't make up my mind which is better.

Cheers
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> >>
> >>> +
> >>> +             match_len = len_current = efi_dp_instance_size(dp_current);
> >>> +             switch (match) {
> >>> +             case EXACT:
> >>> +                     if (len_current != len)
> >>> +                             continue;
> >>> +                     break;
> >>> +             case SHORTER:
> >>>                        if (len_current > len)
> >>>                                continue;
> >>> -             } else {
> >>> -                     if (len_current != len)
> >>> +                     break;
> >>> +             case LONGER:
> >>> +                     if (len_current < len)
> >>>                                continue;
> >>
> >> So here the logic is:
> >>
> >> When search for \a\b;
> >>
> >> \a\b\c\d is a better match than \a\b\c
> >>
> >> Is this intended?
> >> I can't find it in the function description of find_handle().
> >
> > Yes it is, the description is in the efi_dp_find_obj(). You want me to
> > move it around? Or expand find_handle() as well?
> >
> >>
> >>> +                     match_len = len;
> >>> +                     break;
> >>>                }
> >>> -             if (memcmp(dp_current, dp, len_current))
> >>> +
> >>> +             if (memcmp(dp_current, dp, match_len))
> >>>                        continue;
> >>>                if (!rem)
> >>>                        return handle;
> >>>                if (len_current > best_len) {
> >>>                        best_len = len_current;
> >>>                        best_handle = handle;
> >>> -                     *rem = (void*)((u8 *)dp + len_current);
> >>> +                     if (len_current <= len)
> >>> +                             *rem = (void *)((uintptr_t)dp + len_current);
> >>> +                     else
> >>> +                             *rem = (void *)((uintptr_t)dp_current + match_len);
> >>>                }
> >>>        }
> >>>        return best_handle;
> >>> @@ -160,14 +187,25 @@ static efi_handle_t find_handle(struct efi_device_path *dp,
> >>>
> >>>    efi_handle_t efi_dp_find_obj(struct efi_device_path *dp,
> >>>                             const efi_guid_t *guid,
> >>> -                          struct efi_device_path **rem)
> >>> +                          struct efi_device_path **rem, bool match_longer)
> >>>    {
> >>>        efi_handle_t handle;
> >>>
> >>> -     handle = find_handle(dp, guid, false, rem);
> >>> +     handle = find_handle(dp, guid, false, rem, EXACT);
> >>
> >> Here you are tweaking the logic a lot without really describing it:
> >>
> >> efi_dp_find(rem != NULL) used to match in sequence:
> >>
> >> 1) exact long path
> >> 2) longest long path with dp as start
> >> 3) exact short path
> >> 4) longest short path with dp as start
> >>
> >> now you have
> >>
> >> 1) exact long path
> >> 2) exact short path
> >> 3) longest long path with dp as start
> >> 4) longest short path with dp as start
> >>
> >> This might be intended. But it is neither described in the commit
> >> message nor in the function description.
> >
> > I'll reword the commit message.
> >
> >>
> >>>        if (!handle)
> >>> -             /* Match short form device path */
> >>> -             handle = find_handle(dp, guid, true, rem);
> >>> +             handle = find_handle(dp, guid, true, rem, EXACT);
> >>> +     if (handle)
> >>> +             return handle;
> >>> +
> >>
> >> Check the value of rem here (see comment above).
> >
> > Sure
> >
> >>
> >> Having both rem != NULL and match_longer == true wouldn't make much sense.
> >>
> >> Theorectically we could use *rem == LONGER for allowing longer DPs and
> >> *rem == SHORTER for other cases to avoid the extra argument.
> >>
> >> #define LONGER ((void *)(uintptr_t) - 1)
> >> #define SHORTER (NULL)
> >
> > Sure, but I think the enum is clearer. Unless you really want this
> > I'll keep the enum
> >
> > Thanks
> > /Ilias
> >
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >>> +     handle = find_handle(dp, guid, false, rem, SHORTER);
> >>> +     if (!handle)
> >>> +             handle = find_handle(dp, guid, true, rem, SHORTER);
> >>> +
> >>> +     if (match_longer && !handle) {
> >>> +             handle = find_handle(dp, guid, false, rem, LONGER);
> >>> +             if (!handle)
> >>> +                     handle = find_handle(dp, guid, true, rem, LONGER);
> >>> +     }
> >>>
> >>>        return handle;
> >>>    }
> >>> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> >>> index 130c4db9606f..0d3d7c187d72 100644
> >>> --- a/lib/efi_loader/efi_disk.c
> >>> +++ b/lib/efi_loader/efi_disk.c
> >>> @@ -339,7 +339,7 @@ efi_fs_from_path(struct efi_device_path *full_path)
> >>>        efi_free_pool(file_path);
> >>>
> >>>        /* Get the EFI object for the partition */
> >>> -     efiobj = efi_dp_find_obj(device_path, NULL, NULL);
> >>> +     efiobj = efi_dp_find_obj(device_path, NULL, NULL, false);
> >>>        efi_free_pool(device_path);
> >>>        if (!efiobj)
> >>>                return NULL;
> >>> --
> >>> 2.43.0
> >>>
> >>
>
