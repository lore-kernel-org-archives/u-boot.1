Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6FBC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D62088609;
	Mon, 10 Jun 2024 17:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N9KPBmgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC053885EE; Mon, 10 Jun 2024 17:54:15 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF5F8858E
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 17:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6ad8243dba8so22940686d6.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718034852; x=1718639652; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dluuJXV1lOjMfrCyqXzJ4+X0wtdsPdRrtpCx1qdU3KE=;
 b=N9KPBmgdqy4AGwo00t4o0PL1KID6gBZm2UBLQ/LT7w5b2zxKU8QKm+UiT9tsNZCPXJ
 SNl8WemhrxZYpSapqtrpq4OtDw0bn0+9JibnEW6FoyHdZBcksuocP9Te6u9nWxyfYT9N
 9rw1XmAEEg4S+7aUDsla44Cpk6gR5eX3qt1bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718034852; x=1718639652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dluuJXV1lOjMfrCyqXzJ4+X0wtdsPdRrtpCx1qdU3KE=;
 b=NEq4Z1erNvzG2fNWxoJ8RbmlClQmfw07rVU9MAKXPnWc9KhJ9vCjthMziH8i4XV3Wd
 pZ2GP7HVsPtq884aHAh9rsAxJ1NpjLQnhjKgivdXSK3t2yO7SGjqjLj0sNiVbwbM135y
 aYJI76Yc51+w1VI6tKV79e0IRYyGZEHfZZDP7rEs2diOxF3GSjQA7DRC3888REjWDAzb
 t0tOgrc333zM4hJkGWcuiInf6ZiIbSqlTTKQv/u1Z6qUoVZdEDoBm+Qf2LwAJRt6Ohho
 RKQxdGtBLClmdmNTlFzjRFJe7sCeWoBQdjT+G5ak5nO4QcOvRBs6d3V5mpCYqwL0CpMB
 WDjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS4KbRpAqUgVsBiYcEEex24vpmXAOMBvfdLUPF/rCZusTmnCyt7DM4lfv0PO3PkjrkWLO+lx2oKFKvz+HpOeOd2M2xmA==
X-Gm-Message-State: AOJu0YzJbnVcys7v+rwAQTMXGCkeieAH5gplxMSx+PLZqRA/0NkRdggs
 ZpKyPHRasN8kK/OifW/T22AyAIeN3S/mOOsEHifxf0/n4snUH6hM+mn5uQvanIZ+VC9zSZ1zax7
 tbrH/6ITjJRkRJaYeimtPfcR4CDdTF+Q721lm
X-Google-Smtp-Source: AGHT+IFIMZ0uebyAl53GafIWg4i8ffE2r0/s4+CWhCARMtHoGKhfLnnDY/cB23+3C96yFBwPifQPobjhHID9OEyPVlE=
X-Received: by 2002:a0c:9a44:0:b0:6b0:7db4:42b9 with SMTP id
 6a1803df08f44-6b07db453cemr29618546d6.65.1718034852173; Mon, 10 Jun 2024
 08:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgcnftK=GqZ0LGue2Y8-YkRhOKzPuc4Yf1CvhzAGO+MTg@mail.gmail.com>
 <a9462414-c8f7-4a2a-9dd0-f39ee24876f8@canonical.com>
In-Reply-To: <a9462414-c8f7-4a2a-9dd0-f39ee24876f8@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Jun 2024 09:54:01 -0600
Message-ID: <CAFLszThgyRrWnjDa9iXB14Lcm1LPeh+5M7p_YKDg9ZjFmr0JXA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] efi_loader: improve device-tree loading
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
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

On Mon, 10 Jun 2024 at 08:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 10.06.24 15:53, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, 10 Jun 2024 at 03:11, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> In U-Boot EFI boot options can already specify both an EFI binary and
> >> an initrd. With this series we can additionally define the matching
> >> device-tree to be loaded in the boot option.
> >>
> >> With the last patch the boot manager will fall back the device-tree
> >> specified by $fdtfile in directories '/dtb/', '/', or '/dtb/current/'
> >> on the boot device if no device-tree is specified in the boot
> >> option or via a bootefi command parameter.
> >>
> >> v3:
> >>          Add missing '@' in EFI_LP_DP_PART_FDT description.
> >>          Use calloc() instead of malloc() in load_fdt_from_load_option().
> >>          Add missing '@' in load_fdt_from_load_option function description
> >>          Rename struct efi_initrd_dp to efi_lo_dp_prefix.
> >>
> >> v2:
> >>          Update efi_dp_concat() instead of new function efi_dp_merge().
> >>          Carve out a function efi_load_option_dp_join() which we can
> >>          use both for the eficonfig and the efidebug command.
> >>          Rename variables id_dp, final_dp_size.
> >>          Rename create_initrd_dp() to create_lo_dp_part().
> >>          Use enum as parameter for create_lo_dp_part().
> >>          Put all related changes into one patch.
> >>
> >> Heinrich Schuchardt (8):
> >>    efi_loader: allow concatenation with contained end node
> >>    cmd: eficonfig: add support for setting fdt
> >>    cmd: efidebug: add support for setting fdt
> >>    efi_loader: load device-tree specified in boot option
> >>    efi_loader: move distro_efi_get_fdt_name()
> >>    efi_loader: return binary from efi_dp_from_lo()
> >>    efi_loader: export efi_load_image_from_path
> >>    efi_loader: load distro dtb in bootmgr
> >>
> >>   boot/bootmeth_efi.c                        |  60 +---------
> >>   cmd/eficonfig.c                            |  83 +++++++++----
> >>   cmd/efidebug.c                             | 130 +++++++++++++++------
> >>   include/efi_loader.h                       |  24 +++-
> >>   lib/efi_loader/Makefile                    |   1 +
> >>   lib/efi_loader/efi_bootbin.c               |   2 +-
> >>   lib/efi_loader/efi_bootmgr.c               |  75 +++++++++++-
> >>   lib/efi_loader/efi_boottime.c              |   3 +-
> >>   lib/efi_loader/efi_device_path.c           |  40 ++++---
> >>   lib/efi_loader/efi_device_path_utilities.c |   2 +-
> >>   lib/efi_loader/efi_fdt.c                   | 117 +++++++++++++++++++
> >>   lib/efi_loader/efi_helper.c                |  44 +++++++
> >>   12 files changed, 445 insertions(+), 136 deletions(-)
> >>   create mode 100644 lib/efi_loader/efi_fdt.c
> >>
> >
> > Somewhat related, what work has been done to support FIT, or to locate
> > a DT using the compatible string?
>
> CONFIG_BOOTM_EFI allows booting a FIT image containing an EFI binary and
> optionally a device-tree. You can manually select a configuration when
> invoking the bootm command. I am not aware of any automation for this
> selection.

Thanks for the info.

Can we perhaps require FIT_BEST_MATCH and then provide a way? All this
filename stuff is missing the point, really. It isn't going to get any
easier, either.

Regards,
Simon
