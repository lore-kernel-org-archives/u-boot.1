Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEC9D609D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 16:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1105883106;
	Tue, 16 Dec 2025 17:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jL3MDalq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB09D8334F; Tue, 16 Dec 2025 17:49:21 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E9908309A
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 17:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-78c33f74b72so44491837b3.2
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 08:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765903758; x=1766508558; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RyHhoKREbGeGVGlqfgl1hhMR3BgwVuLONnjNP+zoEMY=;
 b=jL3MDalqGMNGNUO+B451yZ94kaNv1AuLyy8YCNVze+2mBer0fh5loTxn1Jx41RLAjT
 AwuKxfEOqCMVObZcbbONm3IfzqiyNjfwnchu4Ss/fJkD9cCafzbO02hRItdT73ttwAXv
 Kbg8BEQ+hcWqR+JhLr+lFzUeAMXjAot6bOKbesZlfOQVHwMzMJjrdqnJj8wwNJI955CE
 3oTTDWIGRyMtyjrbUOVxHK3Dp56PgcBApQKgYQjo1RXLqY52JhwBVw6AJmtQ2FK825iL
 Z+jMguTkFmVpSYcm8hVOii0RNpDdPckNvs68YID542RRA8FNv7wsIMH2mOp+SvwEI6Th
 39aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765903758; x=1766508558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyHhoKREbGeGVGlqfgl1hhMR3BgwVuLONnjNP+zoEMY=;
 b=vGixUkVMqr4iaOUZpkrHh5cs/axgJ/Ddxs8GelimjhLd/24XTAYRwHp3TGc5UQOAbh
 f2EJr5KSbQboV1SJXW+4Fx5/ys9v7w+IqpHb6Ygwm8LSzb4O0ZGlTCuZcWnK7hWx/hxU
 RmmnVo81Sxrl0ybIcLs8PXI9zGxejAP3/Rne/XjvsxfkdTbakYmSYq0Ul45nLJQVaC0b
 t9B6yFS4tH81mS8zsj4SaoibvZORQf+NopXOc1HpD0Ug/s8GWIWYPbNUpKlMu7tlraB7
 4GPyq01kRXwTR81rv7/leEatqQp93dxRZZbx0+95+puRcPFo2Z7n2kzogFXoychFLms0
 dXag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnJ0JcOyb23CupJ9s0ezR702xaylKrYiHnYntgURHFV/OaSzat7+oPTUCBio8dle8eO+EP98g=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/GslRgj/8H1eWI5Y4rqeMwH0Z70ZTLKUpmo08nbW5PFQ/gJ/b
 jY/WWR8hXds6/XDyqXMoioyCEtN3i9rDxuofYdlfXgyzzSWxFscU9vMLmvlA/qGu+JdrGCOYE1Y
 egoDOMFsm7rlQb1bAqrPIvO/fckrXZCdLZk/bnocykQ==
X-Gm-Gg: AY/fxX5CMfjRUyJmfl6CFN0iLOP+ZBuecQ2JWcqEx1N9ofcO+2zewF2ysLy8YQ0nJW6
 3co15d9lzF5zrKFz8daRpv6LEgH5EMwiy9s3F00q26vSuVU1Jspi2HKh2gDPRrMMaOBvtzH/MYu
 vo+fsM/eOL/Tb51Fzz1uDj4vw3QbZm9E1QHXNIjxvVEFdswbkcVgL4b5YOAvtM5uGkmE2vd4PAm
 EZ3LizBcTdH6W1wJ6coRhD3+3wKJyFMGUb9Z8FV+ZmdfHVF6oisj8Za2ArdQh58aJdpe4dIXBwX
 Ax8NQqevcLv415J8dMSAQpZGcBn9NnqJulMo9nDCRZp3fJ5dihAOxsCjxuhZx/Il0qysr8+RrQk
 Kc+KS1z5n1coLIq2xCGM+946t2jIPcojshSJqamPat+V7FNlTdmb+VeZhujwnj+2UzwUMDXBWnB
 /mSv9pAa4Y2Gid5CuYQIPGnBQO1lrh1JZeHE2pp8tLGwQw9Kt4o+ibCnoTCYp57r+P7yCGAmmMN
 B3n2M7Cj307JB+AvHTHrbB8TCIf+2xmNxmMZR9T1x5MwWWs3A7j6yackr8G84qNoOHxOFjBtWnQ
 ALWd6OMtLMnp5tXC87p7vAPM589UF4Vg0/Ah8DxNKJKu
X-Google-Smtp-Source: AGHT+IEJG2aO8aIRjgdoNxgKCJCw+60KSNkGhxfAybBBxMvdswgp2p1ghFbDyZ9REUz6u5FIiSi5hRrEI1v2CJZqB4g=
X-Received: by 2002:a53:cf10:0:b0:644:71e8:cce9 with SMTP id
 956f58d0204a3-645555d082amr8536636d50.5.1765903758168; Tue, 16 Dec 2025
 08:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20251216074710.270479-1-ilias.apalodimas@linaro.org>
 <d70c8dad-dc9e-461d-a0f8-afc27d818b50@gmx.de>
In-Reply-To: <d70c8dad-dc9e-461d-a0f8-afc27d818b50@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 16 Dec 2025 18:48:42 +0200
X-Gm-Features: AQt7F2q7m6NwCT1xcd_ZcgucDQlfUha1O2dQXKCWX9m38iOF75i6q7Tz2zKwamU
Message-ID: <CAC_iWjL696HDh5_p9BnoYBfwsHsEyBai2p26+Df5O5bKhSqHZA@mail.gmail.com>
Subject: Re: [PATCH v3] efi_loader: Trigger capsule updates with automatically
 generated boot options
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 John Toomey <john.toomey@amd.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, andrew.goodbody@linaro.org
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



> >
> >   /**
> > - * device_is_present_and_system_part - check if a device exists
> > + * get_esp_handle - check if a device exists and contains an ESP
>
> The logic looks ok. Yet, the descriptions need rework.
>
> "check if a device exists and contains an ESP":
> This is not what this function does. It checks if a device has an ESP as
> immediate child.

Not only. If the provided DP is a pointing to a file in the ESP in
will exit before trying to probe any of the disk children.

>
> >    *
> >    * Check if a device pointed to by the device path, @dp, exists and is
> > - * located in UEFI system partition.
> > + * either an ESP or a disk containing an ESP.
>
> Nowhere do you check if the device is a disk. The end node of @dp could
> be anything.
>
> An NVMe drive may have many namespaces, a SCSI drive many LUNs.
>
> The partition is not the child of the drive but of the namespace or the LUN.
>
> An NVMe(NSID,EUI) node in a device-path is for a namespace not for a
> drive. Similarly an Scsi(PUN,LUN) node is for the LUN and not for the
> drive (PUN).
>
> Please, provide an accurate function description.

I am not sure I understand what you are expecting here.
We treat disks and partitions as a 'udevice'. What the function does
is look at the provided DP and get the associated handle for the
device to look at the device children.
I haven't looked closely into SCSI or NVMe device paths. Do you have
any suggestions?

>
> >    *
> >    * @dp              device path
> > - * Return:   true - yes, false - no
> > + * Return:   ESP handle or NULL
> >    */
> > -static bool device_is_present_and_system_part(struct efi_device_path *dp)
> > +efi_handle_t get_esp_handle(struct efi_device_path *dp)
> >   {
> > -     efi_handle_t handle;
> > +     efi_handle_t handle, dev_handle;
> > +     struct udevice *child_dev;
> >       struct efi_device_path *rem;
> > +     efi_status_t ret;
> >
> >       /* Check device exists */
> > -     handle = efi_dp_find_obj(dp, NULL, NULL);
> > -     if (!handle)
> > -             return false;
> > +     dev_handle = efi_dp_find_obj(dp, NULL, NULL);
> > +     if (!dev_handle)
> > +             return NULL;
> >
> >       /* Check device is on system partition */
>
> Should this be
> "Check if the device path points to an EFI system partition"?

This checks if the DP is on a partition with the ESP installed.
'device' is the udevice u-boot defines.
I don't mind changing it.

>
> >       handle = efi_dp_find_obj(dp, &efi_system_partition_guid, &rem);
> > -     if (!handle)
> > -             return false;
> > +     if (handle)
> > +             return handle;
> > +
> > +     /* If it's a disk check its children */
>
> The object that you check may be anything, not necessarily a disk.

efi_disk_create_raw() and efi_disk_create_part() are used to create
the EFI tags. What else can it be?
Shall I just remove the comment?

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
