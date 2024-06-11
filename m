Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EA7C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 22:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A38578877B;
	Wed, 12 Jun 2024 00:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kmaQEQkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A04BC88732; Wed, 12 Jun 2024 00:22:41 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E79588617
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 00:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-dfb12c0b4ceso3478022276.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718144558; x=1718749358; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FygpJikLd9wg09qlkjXrq0hK8WZX4aSyHT9Slm3q5s=;
 b=kmaQEQkP10eR14N5g3Vow+cp22SrWD984RTVfg180NpNwy8Evs6gvMGSRmLIjHJAU0
 S849NmMcmNXeebu/DNx8X0dUTY0aWd7rtxW4KDICFUNlZ93EXkSQ2zeQNRMoZYyOdxgq
 /qLF36M0S3epROWUqho077y8CohZSlJqIoEfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718144558; x=1718749358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4FygpJikLd9wg09qlkjXrq0hK8WZX4aSyHT9Slm3q5s=;
 b=AWcZ/57M7FjKp5LIGfzYdSP7AKfIt8dOTijEcAGe6hZIGp3xtBh8EXoEQTGohrrq9Q
 704f7nvQ8HbFVoG86/Md9LU6/WHAcnP1i6VaI4f7AwVGkDgdPO6W+IMhikDCr2ni3Zhf
 Ds9eWf4W5H+Vzn39oClRQlWYEwMETiaKk9VhnqxpAJ7C8QiopmorO9hn94VaiTCJtnyE
 AXFy5qQeM17WafbMAeTZAdp4WmbFX3Mk0kKHfK4V5Vs5uvPebc/Uk0StIP56zrtgf378
 XrDpvDyMERAnxw6kF+ZqHV7ioaGH/b2v4y0HCT+K/DtJKYStmpw86XtyurIpcoRK/7Lo
 eD8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvGvz3wcrb8mUKkbNpri4lqclAxqFaLlTATyTCeivwY1ZgBBsXslcTgawLbDDhNU7QfwnmOa7x/3Y20nWO/MFTBmgklw==
X-Gm-Message-State: AOJu0YwvjwEBBN4jr1nhMxjSPskOrdoyBALIbnmZYuo1bpi07OdkfbLM
 hvQusd9waHADFDw6Xd8oRea82NkvrG4osY4UgsWV1kV7EezYXx3nAD7jh3ku7Si1g+f8LiDju6/
 oLIGgXbOv4S6LX3gORu3mbjnZstDaCR3EL8eT
X-Google-Smtp-Source: AGHT+IHPuevp2dlSSb06SNF43554eiWfahpEx16Tw74G1GimJXeAg+0JLl+UTUQK1KB3SgbrEz7yqgoQv4iU3OrbRpk=
X-Received: by 2002:a5b:f41:0:b0:dfb:56e:a867 with SMTP id
 3f1490d57ef6-dfe66462685mr53035276.12.1718144558314; 
 Tue, 11 Jun 2024 15:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240611210025.798978-1-jiaxun.yang@flygoat.com>
 <20240611210025.798978-3-jiaxun.yang@flygoat.com>
In-Reply-To: <20240611210025.798978-3-jiaxun.yang@flygoat.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 16:22:27 -0600
Message-ID: <CAFLszTiNzO95DabF82WkYrVgnexwPprrEdHHOoWV0+CKW5j7tg@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH 2/4] qemu-arm64be: New board
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
>  bin/travis-ci/conf.qemu_arm64be_na              | 13 +++++++++++++
>  py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py | 10 ++++++++++
>  2 files changed, 23 insertions(+)
>  create mode 100644 bin/travis-ci/conf.qemu_arm64be_na
>  create mode 100644 py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/bin/travis-ci/conf.qemu_arm64be_na b/bin/travis-ci/conf.qemu=
_arm64be_na
> new file mode 100644
> index 000000000000..3929636932e6
> --- /dev/null
> +++ b/bin/travis-ci/conf.qemu_arm64be_na
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: MIT
> +#
> +# Copyright (c) 2024 Jiaxun Yang
> +#
> +
> +console_impl=3Dqemu
> +qemu_machine=3D"virt"
> +qemu_helper_script=3D"swtpm"
> +qemu_binary=3D"qemu-system-aarch64"
> +qemu_extra_args=3D"-cpu cortex-a57 -nographic -netdev user,id=3Dnet0,tft=
p=3D${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=3Dnet0 -device virtio-rn=
g-pci -semihosting -chardev socket,id=3Dchrtpm,path=3D/tmp/tpm/swtpm-sock -=
tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-tis-device,tpmdev=3D=
tpm0"
> +qemu_kernel_args=3D"-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
> +reset_impl=3Dnone
> +flash_impl=3Dnone
> diff --git a/py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py b/py/travis-=
ci/u_boot_boardenv_qemu_arm64be_na.py
> new file mode 100644
> index 000000000000..5746b37dbcf5
> --- /dev/null
> +++ b/py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py
> @@ -0,0 +1,10 @@
> +import os
> +import travis_tftp
> +
> +env__net_uses_pci =3D True
> +env__net_dhcp_server =3D True
> +env__net_tftp_readable_file =3D travis_tftp.file2env('u-boot.bin', 0x404=
00000)
> +env__efi_fit_tftp_file =3D {
> +    'addr' : 0x40400000,
> +    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
> +}
> --
> 2.43.0
>
