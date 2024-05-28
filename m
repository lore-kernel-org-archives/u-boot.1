Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332F4C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 16:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8570C884D1;
	Tue, 28 May 2024 18:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GgZ9hI0V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA4B18851A; Tue, 28 May 2024 18:15:56 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 503D9884B4
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 18:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f47db642c2so8178785ad.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912953; x=1717517753; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6XxT+uoaM6p8hRSDsjA7yU/y8P0gug9N5TjRWuzt6WM=;
 b=GgZ9hI0VEni0bWz49jfInVUPw/dYKcsGyRVRy0UczgNj/WvuaDuRYj3KjXwB2MF9nn
 V+UWFnyoMlHrqnPceauTToQMA4tLRx42twvVCjh3gWNtmtHe5vD4nrN/YKl0KbxR9IMG
 wvDD0O8N5t4iPm9uR5b3Ksv6SkBV8cWH9gyORbBfflfn4LxCs4myDcHHjngsvx8ri/ms
 T+p/noCHrvXcSXnLAt7OfewqCNj+PRIhnco611mSSSxhZupY7LAP4uwz77KHRjtFQtQO
 UZLukapVEtj/mjuIUIIkbQgvZjwEJVmyzwU7PGeyypjunx2M91r/i8ccFqHl5iJA04MG
 BVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912953; x=1717517753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6XxT+uoaM6p8hRSDsjA7yU/y8P0gug9N5TjRWuzt6WM=;
 b=d3cQHlbQfQU9ZYwXURtJw5BdGRn0ZBTqkEzf4fcSj58uGNPyYPIzD3I+aZA7dFXv2H
 uqI7ENLszfYYzKf4CGWzwLyZPb/mrsv8RqdOb+haXIHa52EG7N3QSarliRgjeKXZ8Enx
 t+PCGtKG3oauywmbLnhJN3DQ5Gr3evmYPrEErXXBv29AKKs9nHwz3CxfISW6bHyLo0Rs
 64tH5hYAKp3/YQPWd99akJH71wmCdnhxTWOV+mwlp65IOqRl8c2Z/ydTWAJx9Fr569y4
 g3LV9uSoIdAbPxLcrYkpLjj0WI90OkCz6EiVTVDNL96O2hkp+uSfSE+rZS0SPdb800fr
 kxaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpCpn+UOE/xuPxJZdjCEn9iL/cOVwJ30mbHh3Qs9MrozicJVA+iPqYv5sNZAOO27hxi2hKO9ZFnMww3vl8PM4GipZFeQ==
X-Gm-Message-State: AOJu0YzPgo4/PIp47kLQe4j167kdd8iYjlChFfh2sopUwNKtgZYTdOfS
 /FspMOTnNHt+Rbgn0B0nvrJqH8mHlyfC9OQejIh2hjSf8tieSfDGSiJ/sYUZOv7HQJhfp4kz46k
 /HRyWZwfsrD8tc2P4IUs3br/EKvnYs2kUFxKYwg==
X-Google-Smtp-Source: AGHT+IHCXev3rNVFhEE/JiCry/IohqUVMQ+Fh7o76BXvSfQMwqhX3gcuDDImlXjbRhA2A/NqrNv3mII9TrS63Lx1qNY=
X-Received: by 2002:a17:903:234e:b0:1f4:56c2:a233 with SMTP id
 d9443c01a7336-1f456c2a747mr126442365ad.27.1716912952773; Tue, 28 May 2024
 09:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <20240528144252.179247-3-heinrich.schuchardt@canonical.com>
 <CAC_iWjKGNRiJcJtoYM81XO2kYxpFyekZN6VE3K64-Ba3pz7xQw@mail.gmail.com>
 <1639e3fa-4515-49c1-9364-f06acad03fd2@canonical.com>
In-Reply-To: <1639e3fa-4515-49c1-9364-f06acad03fd2@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 May 2024 19:15:16 +0300
Message-ID: <CAC_iWjJEBGLnNqvTi61OOhUr2dCj_4r27jJ=qCwuiroZBBDvCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] cmd: eficonfig: add support for setting fdt
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Tue, 28 May 2024 at 19:08, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 28.05.24 17:16, Ilias Apalodimas wrote:
> > Hi Heinrich,
> >
> > [...]
> >
> >>
> >> -       const struct efi_initrd_dp id_dp = {
> >> +       const struct efi_initrd_dp initrd_prefix = {
> >>                  .vendor = {
> >>                          {
> >>                          DEVICE_PATH_TYPE_MEDIA_DEVICE,
> >>                          DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
> >> -                       sizeof(id_dp.vendor),
> >> +                       sizeof(initrd_prefix.vendor),
> >>                          },
> >>                          EFI_INITRD_MEDIA_GUID,
> >>                  },
> >>                  .end = {
> >>                          DEVICE_PATH_TYPE_END,
> >>                          DEVICE_PATH_SUB_TYPE_END,
> >> -                       sizeof(id_dp.end),
> >> +                       sizeof(initrd_prefix.end),
> >> +               }
> >> +       };
> >> +
> >> +       const struct efi_initrd_dp fdt_prefix = {
> >
> > We need to rename efi_initrd_dp to something more generic in the future
> >
> >> +               .vendor = {
> >> +                       {
> >> +                       DEVICE_PATH_TYPE_MEDIA_DEVICE,
> >> +                       DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
> >> +                       sizeof(fdt_prefix.vendor),
> >> +                       },
> >> +                       EFI_FDT_GUID,
> >> +               },
> >> +               .end = {
> >> +                       DEVICE_PATH_TYPE_END,
> >> +                       DEVICE_PATH_SUB_TYPE_END,
> >> +                       sizeof(initrd_prefix.end),
> >>                  }
> >>          };
> >>
> >
> > [...]
> >
> >> +/**
> >> + * efi_load_option_dp_join() - join device-paths for load option
> >> + *
> >> + * @dp:                in: binary device-path, out: joined device-path
> >> + * @dp_size:   size of joined device-path
> >> + * @initrd_dp: initrd device-path or NULL
> >> + * @fdt_dp:    device-tree device-path or NULL
> >> + * Return:     status_code
> >> + */
> >> +efi_status_t efi_load_option_dp_join(struct efi_device_path **dp,
> >> +                                    size_t *dp_size,
> >> +                                    struct efi_device_path *initrd_dp,
> >> +                                    struct efi_device_path *fdt_dp)
> >> +{
> >> +       if (!dp)
> >
> > Should we add && !*dp here?
>
> efi_dp_concat() handles the case of one or both device-paths being NULL.

Fair enough

>
> >
> >> +               return EFI_INVALID_PARAMETER;
> >> +
> >> +       *dp_size = efi_dp_size(*dp);
> >> +
> >> +       if (initrd_dp) {
> >> +               struct efi_device_path *tmp_dp = *dp;
> >> +
> >> +               *dp = efi_dp_concat(tmp_dp, initrd_dp, *dp_size);
> >> +               efi_free_pool(tmp_dp);
> >> +               if (!*dp)
> >> +                       return EFI_OUT_OF_RESOURCES;
> >> +               *dp_size += efi_dp_size(initrd_dp) + sizeof(END);
> >> +       }
> >> +
> >> +       if (fdt_dp) {
> >> +               struct efi_device_path *tmp_dp = *dp;
> >> +
> >> +               *dp = efi_dp_concat(tmp_dp, fdt_dp, *dp_size);
> >> +               efi_free_pool(tmp_dp);
> >> +               if (!dp)
> >> +                       return EFI_OUT_OF_RESOURCES;
> >> +               *dp_size += efi_dp_size(fdt_dp) + sizeof(END);
> >> +       }
> >> +
> >> +       *dp_size += sizeof(END);
> >
> > Why do we have to account for the end node twice if either fdt_dp or
> > initrd_dp are found?
>
> This is the length of the END node of the binary.

ah yes correct.

Feel free to add
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
but we need to fix the naming at some point

>
> Best regards
>
> Heinrich
>
> >
> > Thanks
> > /Ilias
> >> +
> >> +       return EFI_SUCCESS;
> >> +}
> >> +
> >>   const struct guid_to_hash_map {
> >>          efi_guid_t guid;
> >>          const char algo[32];
> >> --
> >> 2.43.0
> >>
>
