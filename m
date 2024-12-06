Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8D4E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 17:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B53B89373;
	Fri,  6 Dec 2024 18:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DR0W9KQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57AB589620; Fri,  6 Dec 2024 18:16:47 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D899489021
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 18:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-724f0f6300aso2882298b3a.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 09:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733505403; x=1734110203; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tprATNoMLY9aMGkKU0/ZNN1qO7TWILTAkrdkF/aVupg=;
 b=DR0W9KQWBVF4x3UUH+4maAGxVER0kmcpvLRlO+TZidwc1mmAsESTGSSNRZZTJ2hIox
 8DiGJ+J5FX9PddF/joU66/Q7wj/YFGPYNaCoyhBvUgqZzpm41NyDYDS1BciEfpDKDPK+
 Ry7A5c+UJackZS5jwO/Lpsf01RNQ9f7r86xwjsQ/nA7L+fkKQMQJHbUM+oRFTPw1GG9D
 lxQcMbjd33AqqqXRxApnud4MZb9q9G0D10V92J5Vn2brq9C2hsQcgy/cqQeV4uwQVnpo
 fev5PGK2KrD+6+sIcMdyti6WunnYyxfrdL3YSnNypqIh6ZIiR6zL+qArzy1as1N708uc
 sG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733505403; x=1734110203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tprATNoMLY9aMGkKU0/ZNN1qO7TWILTAkrdkF/aVupg=;
 b=gtiN01Qm/Ckxqqq0zGpNLFCfVQ1l4bxG8NlvSdru4o3qxNntD0itjEl33VMLuFDeRz
 4eozO6G/a+pjDW/POOU906+hOEVAFoOpI0jd9N9bR9LtdihIXoCGT8GQWr1UhJMH8t72
 Cj8HaRNXzJ4UwAgXqepNaVjfN1b4mk4iZ9bFuDyyxg6EzWPPcIjQoFkjiyLqR1bGwVp4
 wHwNO+zWeLFfr6xVHLnUSkB9Y2vtMhx+HL71sGyTveUBtEwlUAzoDd5o3BjqwOnkW5ZJ
 Aw7OhJYGWsUGehivMHwUH6q6+1f9+pTi/mlifcWQN+h5x3nSV7bRGB2nV9x0EA1viDRV
 tPYQ==
X-Gm-Message-State: AOJu0YzenUlBtjThUQqeP3cqja8TCDuqu4T8TL1HKJEjjHB5Qs/HkOsQ
 M6kr9mL+toyUX5QlAyhFUAfYv6b68RnDTHN7Gq82zXxOAyZbIqik+/r5I4iieYWX168xpk0KEgl
 cachbnzmAqhQHL4MXahuGOKQbZ0Y=
X-Gm-Gg: ASbGnctfF6EMsMwP7xI6o956yamRU+d31a7UEKqdjTX2ZbQVqp66izrwfPBdv3CFOkB
 xW7FwcWmMt8siEB44mvgGGD1I0Of6yA==
X-Google-Smtp-Source: AGHT+IF5ig86vbuEVVdfS1PGV3RFQq0mD3kKTO58xgm3J1x09IrNba8Fg1ifscHJiLMV2Oex4OwyUySnEwEVztgbjZc=
X-Received: by 2002:a17:90a:ec8b:b0:2ee:ab11:fab2 with SMTP id
 98e67ed59e1d1-2ef6a6bd818mr5558352a91.22.1733505403149; Fri, 06 Dec 2024
 09:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20241206122714.2365114-1-adriano.cordova@canonical.com>
 <20241206122714.2365114-3-adriano.cordova@canonical.com>
 <2d449f38-9e3b-4b09-82d3-4c9457290564@gmx.de>
In-Reply-To: <2d449f38-9e3b-4b09-82d3-4c9457290564@gmx.de>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Fri, 6 Dec 2024 14:16:32 -0300
Message-ID: <CAMGU2hXX5Ch9Hgn_2_jHXkXLwd4jVnxKYV2rCOSN2zgCacU8YQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi_loader: efi_net: let efi_net_set_dp properly
 update the device path
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org, trini@konsulko.com, 
 Adriano Cordova <adriano.cordova@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

El vie, 6 dic 2024 a las 11:59, Heinrich Schuchardt (<xypron.glpk@gmx.de>)
escribi=C3=B3:

> On 12/6/24 13:27, Adriano Cordova wrote:
> > This commit fixes an use after free introduced in Commit e55a4acb54
> > (" efi_loader: net: set EFI bootdevice device path to HTTP when loaded
> > from wget"). The logic in efi_net_set_dp is reworked so that when the
> > function is invoked it not only changes the value of the static variabl=
e
> > net_dp (this is how the function was implemented in e55a4acb54) but als=
o
> > updates the protocol interface of the device path protocol in case efi
> > has started.
> >
> > Fixes: e55a4acb54e8 ("efi_loader: net: set EFI bootdevice device path t=
o
> HTTP when loaded from wget")
> > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> > ---
> >   lib/efi_loader/efi_net.c | 53 +++++++++++++++++++++++++++++++++++----=
-
> >   1 file changed, 47 insertions(+), 6 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> > index 67593ef50c..1e87cd7be6 100644
> > --- a/lib/efi_loader/efi_net.c
> > +++ b/lib/efi_loader/efi_net.c
> > @@ -925,12 +925,15 @@ efi_status_t efi_net_register(void)
> >                            &netobj->net);
> >       if (r !=3D EFI_SUCCESS)
> >               goto failure_to_add_protocol;
> > -     if (!net_dp)
> > -             efi_net_set_dp("Net", NULL);
> > -     r =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
> > -                          net_dp);
> > +
> > +     if (net_dp)
> > +             r =3D efi_add_protocol(&netobj->header,
> &efi_guid_device_path,
> > +                            net_dp);
> > +     else
> > +             r =3D efi_net_set_dp("Net", NULL);
> >       if (r !=3D EFI_SUCCESS)
> >               goto failure_to_add_protocol;
> > +
> >       r =3D efi_add_protocol(&netobj->header,
> &efi_pxe_base_code_protocol_guid,
> >                            &netobj->pxe);
> >       if (r !=3D EFI_SUCCESS)
> > @@ -1055,18 +1058,56 @@ out_of_resources:
> >    */
> >   efi_status_t efi_net_set_dp(const char *dev, const char *server)
> >   {
> > -     efi_free_pool(net_dp);
> > +     efi_status_t ret;
> > +     struct efi_handler *phandler;
> > +     struct efi_device_path *old_net_dp;
> >
> > +     old_net_dp =3D net_dp;
> >       net_dp =3D NULL;
> >       if (!strcmp(dev, "Net"))
> >               net_dp =3D efi_dp_from_eth();
> >       else if (!strcmp(dev, "Http"))
> >               net_dp =3D efi_dp_from_http(server);
> >
> > -     if (!net_dp)
> > +     if (!net_dp) {
> > +             net_dp =3D old_net_dp;
> >               return EFI_OUT_OF_RESOURCES;
> > +     }
> > +
> > +     if (!netobj)
> > +             return EFI_SUCCESS;
> > +
> > +     phandler =3D NULL;
> > +     efi_search_protocol(&netobj->header, &efi_guid_device_path,
> &phandler);
> > +
> > +     if (!phandler)
> > +             goto add;
> > +
> > +     if (phandler->protocol_interface !=3D old_net_dp) {
> > +             ret =3D EFI_DEVICE_ERROR;
> > +             goto error;
> > +     }
>
> This is not an error condition. Some other code may have changed the
> device-path. We must not free what we haven't allocated. But we should
> still try to replace it.
>

Will remove the condition.


> So can we have a logic like:
>
> old_dp =3D net_dp;
>
> new_dp =3D ...
>
> OpenProtocol(handle, GUID, &old_dp, NULL, NULL,
> EFI_OPEN_PROTOCOL_GET_PROTOCOL);
>
> if (!efi_dp_match(old_dp, new_dp) {
>         FreePool(new_dp);
>         return EFI_SUCCESS;
> }
>
> ret =3D ReinstallProtocolInterface(handle, GUID, old_dp, new_dp);
>
> if (ret =3D=3D EFI_SUCCESS) {
>         FreePool(net_dp)
> } else {
>       FreePool(new_dp);
> }
>
> return ret;
>
> Best regards
>
> Heinrich
>
>
> > +
> > +     ret =3D efi_reinstall_protocol_interface(&netobj->header,
> &efi_guid_device_path,
> > +                                            old_net_dp, net_dp);
> > +     if (ret !=3D EFI_SUCCESS)
>
> Can net_dp be freed if an error occurred?
>

No, because  the error could have been on uninstalling what net_dp points
to, but new_net_dp could.

>
> > +             return ret;
> > +
> > +     efi_free_pool(old_net_dp);
> >
> >       return EFI_SUCCESS;
> > +add:
> > +     ret =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
> > +                            net_dp);
> > +     if (ret =3D=3D EFI_SUCCESS) {
> > +             efi_free_pool(old_net_dp);
> > +             return ret;
> > +     }
> > +error:
> > +     // Failed, restore
> > +     efi_free_pool(net_dp);
> > +     net_dp =3D old_net_dp;
> > +     return ret;
> >   }
> >
> >   /**
>
>
