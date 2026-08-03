Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAE8C55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:25:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD1FE605E9;
	Mon,  3 Aug 2026 19:25:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V9tNvGtd2XMV; Mon,  3 Aug 2026 19:25:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01EDD6069D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785785153;
	bh=7jd0mymYtjQOybBbDX30IIL8kWcq2CA6im/1xXyP7FI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l0fBpw2573dvDxI+srr41/SvSLtRKPbOtRY06pI5gNdsF7oG6C8ReXAfGd6YQ+7wA
	 1itf+0Z+aqH/ZZ7mCDVpKxio1Dt/wV9hQFwKtTJ7aw3IgOLj2vUXuUxPT6T3kWIQjB
	 /LrHkKp8cwdTCR6SbuL0/aDDl6oPlKcD0ggj+v1Aau305H8IAE6i5zf20nuRILp73j
	 2l0YoVIBth+5T4VMtyaef7Wj3X7CTBo/6MXojPn42qEp8BgyDWef7xEituH/aLTPDH
	 r0xp+hZRneHB4vxpBX7P3MZONrN/bOW16VoyR9Ajdoc90hzNrqI6BSsQqkddwOfq/8
	 ttQs86OeHll5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01EDD6069D;
	Mon,  3 Aug 2026 19:25:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CDCA9296
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C039E405DE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:25:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 79v9PnJhDqN8 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:25:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CF477405FA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF477405FA
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF477405FA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:25:50 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso4444298a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785785149; cv=none;
 d=google.com; s=arc-20260327;
 b=F/k7ciB5JMKWMjK1QSrkHxEO3nMmNNi3FBrNJ7y6hUVnG6rO8exEnNvORL0nfZShXr
 Vr7DVbd48069Jw5qX/0hw6iEGfRFtn71BD+Lk2VQ+PtsQOASy4QDzugjB8iAasi8uMyA
 rpjoErooUVAPH7Vb7wLGEjDII9aKy7GcNnboH1PBM6AyEfwm2C7f3vnYKddeuZHVwu0I
 EDGntmYT38VrdNVrNLe9TmdsC+T7ISw/HAB9BSGxbv9SriSsCcXBd1ailN34ySFyD3Rh
 VzZZ9eqc6RxZAKsf2oYgWlYVNIRxYgCJztmhUJN1dlNEZfmhvlRqcm873+M/s3f8cV4m
 /qAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7jd0mymYtjQOybBbDX30IIL8kWcq2CA6im/1xXyP7FI=;
 fh=MXS5MdkrD9JKR4kOEHYO03OAp4sZuMbTbNoh4piCW84=;
 b=WE/o5gk5hrSchZtckoaNiw9+HnjTwlkT4d5Ka40Bvyh5Gn4BGvkM77p1/pFfa5YRH0
 /M61R7lm1ET60D7soWxelrasi0nrGZFUcKE+q2DX6jubN9PprlCE6H6+swmlXd+Jp8kj
 b8xEw8RzhtwH8gHflqstF0BMJgszfWm7j3/Bxcf5keFhbbQRiK0xesB0uy94ChG1DNzP
 GpbIbid+J+sMEsRAGyD3cw069BEiqdzEJZvfpfKFlA+6wBGwbuDSFSDUOmwf/P6z0bxT
 NEg/B/EDXScuG44f+ZOfaBhDkojwq7MmdRFhHyXAjTENdk39xMrclpK5USvlvocF4KDN
 RYzQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785785149; x=1786389949;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7jd0mymYtjQOybBbDX30IIL8kWcq2CA6im/1xXyP7FI=;
 b=F6zYyOJNyemqqNzyNLFXTAM/nfhzQyq7YXf47O9JIAtC+VIjw7gje6FD8Da9hMtnxS
 KO1vTdZf+R8/NY22GhYNBeSIQixXHK6bDA66JG38GhRjef4lMtT/ypyDLZ0E+NztwLTr
 /IboXIGgGUOux1BdyR0HjEQdFwWxfbL35/Or8PxSefS4Ib+98b2yoZ3/XBqyTbX4+wAn
 k3M4JVe+rmLu4kOBEv/8M9+f3LOKUEtU/+o3NJfYK5Qoz3qmsgGtHKKva3MTUnYABUpA
 twQTh//ey3hHHHUGmfMXklasLoFg1UXH9fvqV1lrmHL6HdklnOraT0+O9ngrRNoEOxOi
 ArYA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roznw7ALoFj8gjtcOO27CBX6W9gtMvu64tpLb35ixxke2+9/qrFeGmP96phr2B0/TkvCFjugQ0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YziHI7sHh+VyxFSl3w9p5CtU4whMFfQlvi/3o5V30whOPd/luFE
 mBYCwFE+ZCZ6uCvU5MZ/6Qkj61OaffzOQZfUaPIvRlbi/ILK0KEvGht0bZSJ7PzhtY2B/2C/qpJ
 T9jpZHAc9IJBsbobzSjtfe47enYGYCiJMRJMUlwto
X-Gm-Gg: AR+sD10IcSZGOSEV7460Dlc3L2Ry5/MJ8pjJWr6rUMWJh4aAO9wNvYrIevxNtHGjg1U
 WEagAKG1j4IwQMFk++geZcBqpuWV1BSFe19P970CoLId+43qeEnmzKuo2nive1zxWMRGLE80PgI
 COmpgDZPwy4lHt+LhAgJ0oCAXJdtqZDNyZOMd1r5W7kQgkD97tKCgRCI6uzMYu/GO/Xq4vG68un
 3iGhdrhdnXAl6W7fkORW+IVltVveQ0o62dRtQQy7uef5nEKFGvPgacGwFd74vrJ9wXQygRaBvGo
 KSFS7F9mSdJSFw2UoeLRgmUARpWQ/am4U5vFvVt//h88RcYrWzlAgQ==
X-Received: by 2002:a05:6402:2b8c:b0:697:decc:7f9a with SMTP id
 4fb4d7f45d1cf-6a0a7c60eb2mr8480637a12.9.1785785148856; Mon, 03 Aug 2026
 12:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
 <20260730-qemu-x86-pflash-v1-2-fb403348e29b@elliotjb.com>
In-Reply-To: <20260730-qemu-x86-pflash-v1-2-fb403348e29b@elliotjb.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 3 Aug 2026 13:25:32 -0600
X-Gm-Features: AUfX_mw2Sjt4m6kPsDcPjn5OKThwpkPJHb9ul7Ikf9c4bAabBaZDYaDH8BzzzCs
Message-ID: <CAFLszTjo5j7w+qzrruYZMXELu_3AP_Gt3wbneDiFP5-imPgNCw@mail.gmail.com>
Subject: Re: [PATCH 2/3] qemu-x86: Wire support for applying capsule updates
 to pflash
To: elliotjb@elliotjb.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785785149; x=1786389949;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7jd0mymYtjQOybBbDX30IIL8kWcq2CA6im/1xXyP7FI=;
 b=LDbik9oGgLReFHGFpVhbjvI/c1RSEDGwvZHHfc/hVVQL78ld+GShSkRbZUtgL6UrGv
 sxpWjVSjQuMRASfXOelkXJ01ry7LWlrT0TI6EDf8FSlSUW35QTcVsc6Plczr1UrkaBdo
 MOCvqq2wzHttmup8mBL0NUycDqTMOP4+wgyHc=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=LDbik9oG
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Elliot,

On 2026-07-30T19:37:45, Elliot Berman <elliotjb@elliotjb.com> wrote:
> qemu-x86: Wire support for applying capsule updates to pflash

The other two patches use the 'x86: qemu:' / 'x86: emulation:' prefix
=E2=80=94 please make this one consistent (e.g., 'x86: qemu: Wire support f=
or
capsule updates to pflash').

>
> Following the flow used for qemu-arm64, probe the pflash MTD device
> and set dfu_alt_info/mtdparts for qemu-x86 and qemu-x86_64 so EFI
> capsule updates can target the u-boot pflash partition.
>
> Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
>
> board/emulation/common/Kconfig         |  2 ++
>  board/emulation/common/qemu_dfu.c      |  6 ++++--
>  board/emulation/common/qemu_mtdparts.c |  6 ++++--
>  board/emulation/qemu-x86/Kconfig       |  3 +++
>  board/emulation/qemu-x86/Makefile      |  3 +++
>  board/emulation/qemu-x86/qemu-x86.c    | 38 ++++++++++++++++++++++++++++=
++++++
>  6 files changed, 54 insertions(+), 4 deletions(-)

> diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-x86/=
Kconfig
> @@ -24,5 +24,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>       imply VIRTIO_NET
>       imply VIRTIO_BLK
>       imply CMD_SMBIOS
> +     imply SET_DFU_ALT_INFO
> +     imply SYS_MTDPARTS_RUNTIME

These are only useful when EFI capsule updates are wanted. qemu-arm
gates them by putting them in a separate 'if TARGET_QEMU_ARM_64BIT &&
!TFABOOT' block that also sources common/Kconfig - please follow the
same pattern here.

> diff --git a/board/emulation/qemu-x86/Makefile b/board/emulation/qemu-x86=
/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +obj-y        +=3D qemu-x86.o

The whole body of qemu-x86.c is wrapped in #if
IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT). Please gate the object
here instead and drop the outer #if:

    obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) +=3D qemu-x86.o

> diff --git a/board/emulation/qemu-x86/qemu-x86.c b/board/emulation/qemu-x=
86/qemu-x86.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <config.h>
> +#include <efi.h>
> +#include <efi_loader.h>

ARRAY_SIZE() is used below, so please add #include <linux/kernel.h>
explicitly (matches qemu-arm.c) rather than relying on transitive
includes.

> diff --git a/board/emulation/qemu-x86/qemu-x86.c b/board/emulation/qemu-x=
86/qemu-x86.c
> @@ -0,0 +1,38 @@
> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
> +struct efi_fw_image fw_images[] =3D {
> +#if defined(CONFIG_TARGET_QEMU_X86)
> +     {
> +             .image_type_id =3D QEMU_X86_UBOOT_IMAGE_GUID,
> +             .fw_name =3D u"Qemu-X86-UBOOT",
> +             .image_index =3D 1,
> +     },
> +#elif defined(CONFIG_TARGET_QEMU_X86_64)

Please use IS_ENABLED() consistently rather than mixing it with #if
defined(). qemu-arm.c does the same thing, but new code should prefer
the modern form.

Regards,
Simon
