Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE496C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 22:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1239B887A7;
	Wed, 12 Jun 2024 00:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MGXXfQnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 813D18877B; Wed, 12 Jun 2024 00:22:42 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F5CB8870E
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 00:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b06bedc5d1so22610556d6.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718144559; x=1718749359; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wrfBnucrKDhgt2plJUutGTXwQCTGGCCodd0FTQctLBk=;
 b=MGXXfQnIwfLL9LX7R9pDGP+C5almJchy58Oihi0sE96T/ivNKCTtB+jJidIYkO+ay1
 ElAPZQERLbrFlEKjNVEdDnkuvGtMOePfwaf3B1a0OdwZqa+jijP8lFGQO/jfG+qwtIYB
 A1IANo5XYpluvtitAIhcdcb9vK0snu4pGZKfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718144559; x=1718749359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wrfBnucrKDhgt2plJUutGTXwQCTGGCCodd0FTQctLBk=;
 b=Qtdxtwjgv3IqommG9f6Ne8FDCWE28OwBUP6rPF0LXD2ZJZBCZspSP2XIqGesWIFhmr
 jKgsyVT7DjTIobQw42WYt6DMYoTRLNNTOB8EQM2glK0mCAlERjV3Vsp6u/BVSzpmDVFX
 KDp0r7P3Z6H3gUVVMUovCk1oXZv8qPan+bg9wtwSu/m8phquM0dAT6l10qd3lF5/4NgS
 QR4NCz4sVjzFWS078NYu3ucqEHKWp3SB5DgrgB7dfX80217IqwsiG2+KqTjDoShuJq4m
 psxyvC4N9LvuzhCvSAraTw4zA1ZVnzyr/X1VS7hhklIw/QItQFykW/U4AtcJzclipME6
 zacw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ3UpfX+ncSTIGwfEE2dOgVM0Cd0k9fOgFs/gM/Lq2EbYLYniDaaLukPMyl0CTHKu9AIuIlZAEkK2mVH+MvB+dK50Tvg==
X-Gm-Message-State: AOJu0YwwL5vymXmRB2HfsCeasP+YrJToTQDBY9jhALjU3mLMnefQACsx
 cVTPqUrMmTvwGZpK/FqZ3Rg5TpS5Vhi/6CEHV5i3LEGi79Y34VhGSpapeh7V+dla02AlTn5TnE7
 N07cCfeqhW1R5PhKWQ9YuLc6kpFr0L3cA6KgyG76HUYzgSiY=
X-Google-Smtp-Source: AGHT+IE1FV4Yhan1Iq9eUbj5kBtqH2uIpfqi7yf0ZPjS2ZrY7qRrSQT/Bx0EB26WajqdP/0J15d+Dt+BVjpZayy3qww=
X-Received: by 2002:a05:6214:3983:b0:6b0:86bd:dc70 with SMTP id
 6a1803df08f44-6b1a69674c1mr71966d6.35.1718144559179; Tue, 11 Jun 2024
 15:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240611210025.798978-1-jiaxun.yang@flygoat.com>
 <20240611210025.798978-4-jiaxun.yang@flygoat.com>
In-Reply-To: <20240611210025.798978-4-jiaxun.yang@flygoat.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 16:22:28 -0600
Message-ID: <CAFLszTjNcZXx76v2PFHbFu2y6o7eVssonyAUi5zhj_kFuGBanw@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH 3/4] qemu-xtensa-dc233c: New board
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de
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

On Tue, 11 Jun 2024 at 15:01, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  bin/travis-ci/conf.qemu-xtensa-dc233c_na             | 12 ++++++++++++
>  .../u_boot_boardenv_qemu_xtensa_dc233c_na.py         |  6 ++++++
>  2 files changed, 18 insertions(+)
>  create mode 100644 bin/travis-ci/conf.qemu-xtensa-dc233c_na
>  create mode 100644 py/travis-ci/u_boot_boardenv_qemu_xtensa_dc233c_na.py
>

Reviewed-by: Simon Glass <sjg@chromium.org>

It is nice to always add a commit message.


> diff --git a/bin/travis-ci/conf.qemu-xtensa-dc233c_na b/bin/travis-ci/conf.qemu-xtensa-dc233c_na
> new file mode 100644
> index 000000000000..fc3b5880e5c1
> --- /dev/null
> +++ b/bin/travis-ci/conf.qemu-xtensa-dc233c_na
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: MIT
> +#
> +# Copyright (c) 2024 Jiaxun Yang
> +#
> +
> +console_impl=qemu
> +qemu_machine="virt"
> +qemu_binary="qemu-system-xtensa"
> +qemu_extra_args="-cpu dc233c -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-pci,netdev=net0 -device virtio-rng-pci -semihosting"
> +qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot.elf"
> +reset_impl=none
> +flash_impl=none
> diff --git a/py/travis-ci/u_boot_boardenv_qemu_xtensa_dc233c_na.py b/py/travis-ci/u_boot_boardenv_qemu_xtensa_dc233c_na.py
> new file mode 100644
> index 000000000000..8fdb24b284c7
> --- /dev/null
> +++ b/py/travis-ci/u_boot_boardenv_qemu_xtensa_dc233c_na.py
> @@ -0,0 +1,6 @@
> +import os
> +import travis_tftp
> +
> +env__net_uses_pci = True
> +env__net_dhcp_server = True
> +env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
> --
> 2.43.0
>
