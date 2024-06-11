Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E627C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 22:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7322D8875E;
	Wed, 12 Jun 2024 00:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P4VSn7o9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22C8088791; Wed, 12 Jun 2024 00:22:43 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACD2088744
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 00:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6b07e641535so8343056d6.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718144559; x=1718749359; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cecREgKDZiCAT1nG/l0r+0btGjndyoRlDX3jAlxsBBY=;
 b=P4VSn7o9pO9eof/+f1McWdPoQZ/YPF73A6+ogL9Oe8PAlTeCDy+l/MfxEnTHZL69Vn
 mTtxZlVh503xPqZfFyBFiaS7yPLWlX8UZI0YRD1qnTHTHhQjj8R50dxsA5Xqo76BdJjQ
 YJEI1XsdQPK6djZNqi9PCGNaGNvS2ryBMJnfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718144559; x=1718749359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cecREgKDZiCAT1nG/l0r+0btGjndyoRlDX3jAlxsBBY=;
 b=SiJHxTmpK/hJOwXawRytrzGTH3GfZQyp23JHY1I5ahsLPfL4YMf/EUl+CzBbaZnpnE
 Jt9xxVPNP74rTj04tdHvPchHNLm88ky2PdhQYYYlMIhTkiRT6YRSgVckm7oUYe9tlLBN
 ikQMOGeureCimltbP6ySflzCYp7CC2/0nbHiXpm2INzykfhv1HeV3TLDWax7ygPfxsQE
 KPRdRTrmFtOjYT/oGFOBfu6GYoQnshpkFt32NdzXCbOzQK1vX3cbhgAZ5RcWJVyI3yzv
 b4lRCDr2ohjEmYhwN4qsmG6/DVYxfETVriG7bF4VKuiLoxdDZA8+XpSvE0k347BrcKpe
 ZlGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGYzyIA+zQ8zxsRt+kCBqGHNdbk3k80+EMSKfizE4+STB6/N0BSXO6bvgSZkLfFkW61FKrzh5XedP6vPxzFC424OWkMQ==
X-Gm-Message-State: AOJu0YxCYhEPNpSjMP8rks3YXoSnLMXx1BSuzddZrnOfuq7FmgdOZ9HD
 kaAbpwdEMGo/yG1QLUmrLHHRuP7Y41gZ9WZfrpjXYXU6GacRotPm47TfdG8XNXofdi/lU/XzDrB
 au1jAnfDHyliuXoyH5eaaH+thePyke9d4izPd
X-Google-Smtp-Source: AGHT+IHEGHb+0IWLy7Uupv6VboVI7xmZe0A0nwAtD7f0/y4WgHSJ/kMK05b8Va0zH27vg+jjpPdvAQ2YwQQOXYz7nAw=
X-Received: by 2002:a05:6214:469a:b0:6b0:76b5:d750 with SMTP id
 6a1803df08f44-6b191778c17mr221226d6.3.1718144559460; Tue, 11 Jun 2024
 15:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240611210025.798978-1-jiaxun.yang@flygoat.com>
 <20240611210025.798978-5-jiaxun.yang@flygoat.com>
In-Reply-To: <20240611210025.798978-5-jiaxun.yang@flygoat.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 16:22:28 -0600
Message-ID: <CAFLszTjFusspDTm8aO+4hSHVCB2Q8jR84V0u_P8wkvNDnhvJLQ@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH 4/4] qemu-loongarch64: New board
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
>  bin/travis-ci/conf.qemu-loongarch64_na              | 12 ++++++++++++
>  py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py | 11 +++++++++++
>  2 files changed, 23 insertions(+)
>  create mode 100644 bin/travis-ci/conf.qemu-loongarch64_na
>  create mode 100644 py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/bin/travis-ci/conf.qemu-loongarch64_na b/bin/travis-ci/conf.qemu-loongarch64_na
> new file mode 100644
> index 000000000000..e8860bb40326
> --- /dev/null
> +++ b/bin/travis-ci/conf.qemu-loongarch64_na
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: MIT
> +#
> +# Copyright (c) 2024 Jiaxun Yang
> +#
> +
> +console_impl=qemu
> +qemu_machine="virt"
> +qemu_binary="qemu-system-loongarch64"
> +qemu_extra_args="-m 1G -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-pci,netdev=net0 -device virtio-rng-pci"
> +qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
> +reset_impl=none
> +flash_impl=none
> diff --git a/py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py b/py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py
> new file mode 100644
> index 000000000000..8a9f747f0457
> --- /dev/null
> +++ b/py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py
> @@ -0,0 +1,11 @@
> +import os
> +import travis_tftp
> +
> +env__net_uses_pci = True
> +env__net_dhcp_server = True
> +env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
> +env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
> +env__efi_loader_grub_file = travis_tftp.file2env('grub_loongarch64.efi')
> +env__efi_fit_tftp_file = {
> +    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
> +}
> --
> 2.43.0
>
