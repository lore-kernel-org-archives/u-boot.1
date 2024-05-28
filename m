Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E092C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 15:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8006C8850A;
	Tue, 28 May 2024 17:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W1pAqt9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EC4388511; Tue, 28 May 2024 17:17:13 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF972884E9
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 17:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f44b42e9a6so7861225ad.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 08:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716909429; x=1717514229; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pOh/YgAhyjsYxsoA0JZx8iXYiAoYTQDVo9R3f66U/LE=;
 b=W1pAqt9WscKUYAfElqTFFJVzFI38UusO6QLraTFxERfdRWOctgalxebVv/7tn+b4DI
 3uJyAuIxwWnZDWbJlihW8UWZk9KrzIPSEwi7CVuHt1139cOfg+fhvjo+dssDmZZvaSEt
 6aH33C9WvTEltQqN9hVEdksOAN7woMueREQobj0lT2bQivtwhbclTOMfQRRDoi5JplAY
 bxKBgF/73PVLUycqfdvqDU4r0qI3aGeI7pzDzIyDUs1vnvVFMl4O43YS5v9y7A8EF8ak
 k30N/FuVEn3iNIY+YoULzGFRw0AAfeY4kyErZU9tNTAvHCTqRdvPyEy/ml867zuEtKX1
 weoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716909429; x=1717514229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pOh/YgAhyjsYxsoA0JZx8iXYiAoYTQDVo9R3f66U/LE=;
 b=g5WtV4R4Icqp69WQ+9eqybky9dPQMO6kQ3T0JXia/kJxim5Ra0kM5Ux5oX/VGlJGnw
 K17Fu8L7O6pWKZaRsl5wHiXqbr2hMAE4Vo5n/WXyfYbTa0ejktcbkSj3MyVbTosIK8/q
 e+hgpTvu1eXk2Vq6efM24GXnC0UAZcMFW+PdnYILgP1Dv21Sys6GfM276AtI1ZgKGB8l
 5IRFKyCCTXzBNtDx5Q+lv1dDMzgEm+YePu0JXmZcSHaHzkbLzm6XjV5dn6VSMvUHYWA5
 E/QlIpanITfJXccq4XAEvcyKfBh50Fpgrk/nc+8XjdHKhOz0Uyy6MoJKgRTbvzwiJVA9
 PORQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7tqLsyoE5jM0MG2o8R/fNHpwlnO6fRENd2dDCMGmSgXF173J3m8VuwzMkNadi4r3xmAFn0mjmkLhcuse1X4JpWMzzvg==
X-Gm-Message-State: AOJu0YzngmepJ5M+fHhGbMCjLzWEm72D3U5/hR2jIksRAGVW2PB1Ml8b
 Go66LxA5Pgb9M0IzAuGu01MKbOJxRlxpqTtX+ODT2PWFtu/voHclFqztj4BGV/2+bGIPtVwE0zx
 uP1WuIFmT5PBFLy6mZMIZOLUHJdrUj5udmNnJ0g==
X-Google-Smtp-Source: AGHT+IEPH/Btn13shrshi//OQSysZ+dcpI8nABY4TrmdCRo86A2UtobB748ET1796ORsYaWPiBzUz80DLwalJjjp2Hc=
X-Received: by 2002:a17:903:246:b0:1ea:5ac0:ce46 with SMTP id
 d9443c01a7336-1f4498ef90bmr128646875ad.66.1716909429151; Tue, 28 May 2024
 08:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <20240528144252.179247-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240528144252.179247-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 May 2024 18:16:32 +0300
Message-ID: <CAC_iWjKGNRiJcJtoYM81XO2kYxpFyekZN6VE3K64-Ba3pz7xQw@mail.gmail.com>
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

Hi Heinrich,

[...]

>
> -       const struct efi_initrd_dp id_dp = {
> +       const struct efi_initrd_dp initrd_prefix = {
>                 .vendor = {
>                         {
>                         DEVICE_PATH_TYPE_MEDIA_DEVICE,
>                         DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
> -                       sizeof(id_dp.vendor),
> +                       sizeof(initrd_prefix.vendor),
>                         },
>                         EFI_INITRD_MEDIA_GUID,
>                 },
>                 .end = {
>                         DEVICE_PATH_TYPE_END,
>                         DEVICE_PATH_SUB_TYPE_END,
> -                       sizeof(id_dp.end),
> +                       sizeof(initrd_prefix.end),
> +               }
> +       };
> +
> +       const struct efi_initrd_dp fdt_prefix = {

We need to rename efi_initrd_dp to something more generic in the future

> +               .vendor = {
> +                       {
> +                       DEVICE_PATH_TYPE_MEDIA_DEVICE,
> +                       DEVICE_PATH_SUB_TYPE_VENDOR_PATH,
> +                       sizeof(fdt_prefix.vendor),
> +                       },
> +                       EFI_FDT_GUID,
> +               },
> +               .end = {
> +                       DEVICE_PATH_TYPE_END,
> +                       DEVICE_PATH_SUB_TYPE_END,
> +                       sizeof(initrd_prefix.end),
>                 }
>         };
>

[...]

> +/**
> + * efi_load_option_dp_join() - join device-paths for load option
> + *
> + * @dp:                in: binary device-path, out: joined device-path
> + * @dp_size:   size of joined device-path
> + * @initrd_dp: initrd device-path or NULL
> + * @fdt_dp:    device-tree device-path or NULL
> + * Return:     status_code
> + */
> +efi_status_t efi_load_option_dp_join(struct efi_device_path **dp,
> +                                    size_t *dp_size,
> +                                    struct efi_device_path *initrd_dp,
> +                                    struct efi_device_path *fdt_dp)
> +{
> +       if (!dp)

Should we add && !*dp here?

> +               return EFI_INVALID_PARAMETER;
> +
> +       *dp_size = efi_dp_size(*dp);
> +
> +       if (initrd_dp) {
> +               struct efi_device_path *tmp_dp = *dp;
> +
> +               *dp = efi_dp_concat(tmp_dp, initrd_dp, *dp_size);
> +               efi_free_pool(tmp_dp);
> +               if (!*dp)
> +                       return EFI_OUT_OF_RESOURCES;
> +               *dp_size += efi_dp_size(initrd_dp) + sizeof(END);
> +       }
> +
> +       if (fdt_dp) {
> +               struct efi_device_path *tmp_dp = *dp;
> +
> +               *dp = efi_dp_concat(tmp_dp, fdt_dp, *dp_size);
> +               efi_free_pool(tmp_dp);
> +               if (!dp)
> +                       return EFI_OUT_OF_RESOURCES;
> +               *dp_size += efi_dp_size(fdt_dp) + sizeof(END);
> +       }
> +
> +       *dp_size += sizeof(END);

Why do we have to account for the end node twice if either fdt_dp or
initrd_dp are found?

Thanks
/Ilias
> +
> +       return EFI_SUCCESS;
> +}
> +
>  const struct guid_to_hash_map {
>         efi_guid_t guid;
>         const char algo[32];
> --
> 2.43.0
>
