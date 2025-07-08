Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC31C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 12:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD1083123;
	Tue,  8 Jul 2025 14:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k7zqiHjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D9B483280; Tue,  8 Jul 2025 14:51:36 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E883E8305C
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 14:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e81cf6103a6so3927176276.3
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 05:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751979093; x=1752583893; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sR6C9zwwWWqQrYux2zl+TkcTgVXzBY5h3snezJpw5YA=;
 b=k7zqiHjFvhqy4anjE5BN6GV9gsCpCKoEr0sJvTKtbIYSlrn2aujTFQWXQbJ2I7Fyui
 dnwNLVyNCtJWw/KuPknKOWJxmhdmwoD4gq0mayV/rCmuszjnP8H5cYvJADzghGVjSDLs
 5zFKfyJ8e1xiZaC0uF7Omt/8O7XsgaxA7o0pA/zblY49og7UoNjIDDHGt4BkMOnfo+9d
 lXZ36kAiPFA2PKTbOMQu+90gsLvKmVw64vpxjN3SO89qp0T+fEhn5BE3GdN27/fFGWcc
 DknicvxLYcIlV64ZR9/gnEKwU0lFeJWqx0pKxUBeF+QJRkywATGPiGcH7QlloWtb1rpl
 kvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751979093; x=1752583893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sR6C9zwwWWqQrYux2zl+TkcTgVXzBY5h3snezJpw5YA=;
 b=q0B0mbiXyoATsBeGkbdns/k8IT2nvZ7HHByuwYBpzihcaB64A4iPEigdbHPAOz+zGh
 p6v14z6JJoKphqiICZgm5BUbc6iJTntIiEWCUEh0cq25utRTpflia0fQ5kmw1J8L3fwN
 /gqbj2q/4OYsLO5+7fNmm5ThTK2L15eaKVA8tBXhTYRm7bZjulZgEWYKVljiiqsfKDjn
 qkqLacf//aZiwTmVQ27CiiBeM53nQVA7PTsmIi6iQbbAvaz3+HmOn5KqB9hyT4rh6M2Z
 Zd3gi05ftt1uby3aGGYykkxR+0GqHOpDcQasbsXLu6gEyTqTtBU1YxVFfwDF6BYwVGI8
 aFDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsQ7M0+m3dS2/rNLxCHRmVQQzYcfh9Y93YwtX8SdKW0WRRu5UVVGul76nw5c+n4aqqITnIVfk=@lists.denx.de
X-Gm-Message-State: AOJu0YwO2L1e07XLv+uiEKUrgO3jPtL3O2auMiONyC1QW6BpTuTOYpUA
 j9R8x/a/ffPzo0BFLOHQw1+YiTE99k7XPzR1p6teD/xvkb0p1mPBFNUT0GAyaHa0m4a0VDh/2JL
 BgApXJHF/o4Ccw8MVvtLvLOI9qdRKCxX28nGZLHct9A==
X-Gm-Gg: ASbGncvrkvUdFEcBpgqquZkudBe3F5pTUTarTzZ2erqd/SHN2dT7ln/vT+SvrEJ5gmf
 jf4cYYN3saFMD5ZcDonxPke8N+9+TfQwa7OBjfNABEx789E37NRUWFXQMkgwhDr1ATyEVRVspkI
 fs3oNSFArda39oO/T2A9lcws8WjdjAZg9cdALAYqGamsQ=
X-Google-Smtp-Source: AGHT+IHw4Bc8jVNp+tHbNf4T9DlWEU7yIl36aR68cNSF6AhI+JmnaIoxOGlyZNdE2euelFbbP/6ta9X7HLXK5ybeUIk=
X-Received: by 2002:a05:690c:6c8c:b0:716:33dc:7ca8 with SMTP id
 00721157ae682-71668d14d44mr228249767b3.18.1751979092759; Tue, 08 Jul 2025
 05:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250708114851.78109-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjKCtmN8Pn4VRNKRgH0OXymtp8=vc0J_q=MxTDLvTXgSxw@mail.gmail.com>
 <c2b30b63-8920-4c74-a154-09d676de12e0@canonical.com>
In-Reply-To: <c2b30b63-8920-4c74-a154-09d676de12e0@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Jul 2025 15:50:56 +0300
X-Gm-Features: Ac12FXyXecN179lgDG5m8xS2xd6iQXheOzlWcXU9NOw4fWc5SA6p8KK1mfEbeKY
Message-ID: <CAC_iWjJ5Qt5M=1-zP3UV-y+roWskC4hjb9rc58F7KVcAmwma+A@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: add missing check in FMP.GetImageInfo()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Casey Connolly <casey.connolly@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Tue, 8 Jul 2025 at 15:20, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 08.07.25 13:56, Ilias Apalodimas wrote:
> > Hi Heinrich
> >
> > On Tue, 8 Jul 2025 at 14:48, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> The UEFI 2.11 specification, chapter 23.1.3 requires
> >> EFI_FIRMWARE_MANAGEMENT_PROTOCOL.GetImageInfo() to return
> >> EFI_INVALID_PARAMETER if *ImageInfoSize is not too small
> >> and ImageInfo is NULL.
> >>
> >> Fixes: f27c20148511 ("efi_loader: add firmware management protocol for FIT image")
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > That being said, we need to double check the FIT capsule users. I
> > think we can probably remove it in the future.
>
> It is not clear if you mean the check or the FIT version of the protocol.

I mean EFI_CAPSULE_FIRMWARE_FIT and the code that manages that

>
> efi_firmware_get_image_info() is a protocol implementation that may be
> called from anywhere outside of U-Boot. We should not remove checks
> required by the UEFI specification even if our internal usage of the
> protocol would not require them.
>
> > Are you aware of use cases that FIT supports, which we don't support
> > from the RAW variant?
>
> Maybe Takahiro remembers, why both RAW and FIT were implemented.

It's been a few years and maybe my memory fails me but....
I remember we added FIT for the authentication since we didn't have
authenticated capsule update support. But we do now

Cheers
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> > Thanks
> > /Ilias
> >>   lib/efi_loader/efi_firmware.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> >> index 75501e21557..216df83de67 100644
> >> --- a/lib/efi_loader/efi_firmware.c
> >> +++ b/lib/efi_loader/efi_firmware.c
> >> @@ -332,6 +332,8 @@ static efi_status_t efi_fill_image_desc_array(
> >>
> >>                  return EFI_BUFFER_TOO_SMALL;
> >>          }
> >> +       if (!image_info)
> >> +               return EFI_INVALID_PARAMETER;
> >>          *image_info_size = total_size;
> >>
> >>          ret = efi_gen_capsule_guids();
> >> --
> >> 2.48.1
> >>
>
