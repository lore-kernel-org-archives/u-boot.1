Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3740AC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 21:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52AF6806FD;
	Wed, 15 Jan 2025 22:36:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZSYEgc8u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EEB7806D4; Wed, 15 Jan 2025 14:56:01 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBF1680214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d414b8af7bso11826196a12.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736949357; x=1737554157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uCS5B6u27HrmtlAzFWorB6O+fDLqN92llMBNNh6z0dk=;
 b=ZSYEgc8u+MQ+ExpvM/5gnw7nt0bbN1hxOvSE5vQ0/sgGz4/iA+OWtv8w2g2n8RnDzj
 Ju9muHfuW5RmYBiUrHyd0qco8bvVVRV9sAtGZJd46YmZB/R0ocjOSRd45kZAXxwGYoNw
 KFgl3xj6SfHSyC6z0fvaBlbp8laKTmaFH+u/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736949357; x=1737554157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uCS5B6u27HrmtlAzFWorB6O+fDLqN92llMBNNh6z0dk=;
 b=lSZWelHctPs/YoBgZxDebxQe+9T7Grm7E2NaZ6FLdOMVOmw2QBMIYvx+K0+yw0mrSv
 gLETaHqpnhGOJQ33v++sYI4fsW9YURgnwcwmcB7PqgIuxQ0DX9w8ahTBhEeXjpxSaxFb
 aXIffO0dok8W+irFzIN5xJ91y78jCszl3G+OXjUCSGj0HiK0zOovBJvLUdwE256F3pCc
 MKIwFLNG+UQeLhrGN1Fe27b+WN2fliBj2S/TY+EZcH0vN+ZgeWWo+ieXYWwZNn4fbKVk
 BW6EVYXHLSGBKAY9gpNjSByFP1CaW/IVOzuUc1x93HFgiMZ9rofe+R2xIzQVwSTf9SSh
 24EQ==
X-Gm-Message-State: AOJu0YybepmUK2yj09n4rN8Nj8VvQZO5xMP7gsUUZr0xvRl5/jSMmopE
 4EHKsbuTDAvTNO6xaHYPq9voD6EpHD2wu1QhezRmb0wIGlgjlkt79hUwhMe9E63f9Ld6VpUIw65
 JhE0XEvMpErFWmC56xeVMDoZT8HpzH8XG3I1iB7maR5wyXyK6ig==
X-Gm-Gg: ASbGncutgHQZABz1oYQgFLC8QonWuBnEn6LVmDHau7vwtH4xI4U8K/huRhU+BqdzZ4r
 UIA99QngOcNN1WX5wG/IvgqthzwIBBYkBXSR9JfI=
X-Google-Smtp-Source: AGHT+IGiP3fFByl672TSlnm1zafyMa+SfuPV+PfUcfU/S3b4WBUu9Slgiz8PyVKpexOmLxuazF+hAgXhIW72AzvOb5U=
X-Received: by 2002:a17:906:f58a:b0:aa6:5e35:d72d with SMTP id
 a640c23a62f3a-ab2ab703f0dmr2716959866b.24.1736949356908; Wed, 15 Jan 2025
 05:55:56 -0800 (PST)
MIME-Version: 1.0
References: <20241104175110.1048449-1-sjg@chromium.org>
In-Reply-To: <20241104175110.1048449-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jan 2025 06:55:45 -0700
X-Gm-Features: AbW1kvaD0YRjSG5qj4Zfwk1MdhydwIS6SbGcpGYfnB6jv6lO2comb9uYIINVROw
Message-ID: <CAFLszTgFdNrRev+7n6j+NqCM+em_p-ONAc=+sztoYaP50HUivw@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] bootstd: Support recording images
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, 
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ion Agorria <ion@agorria.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, 
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Tim Harvey <tharvey@gateworks.com>, Tony Dinh <mibodhi@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 15 Jan 2025 22:36:25 +0100
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

Hi,

On Mon, 4 Nov 2024 at 10:51, Simon Glass <sjg@chromium.org> wrote:
>
> This series provides a way to keep track of the images used in bootstd,
> including the type of each image.
>
> At present this is sort-of handled by struct bootflow but in quite an
> ad-hoc way. The structure has become quite large and is hard to query.
> Future work will be able to reduce its size.
>
> Ultimately the 'bootflow info' command may change to also show images as
> a list, but that is left for later, as this series is already fairly
> long. So for now, just introduce the concept and adjust bootstd to use
> it, with a simple command to list the images.
>
> This series includes various alist enhancements, to make use of this new
> data structure a little easier.
>
> Changes in v3:
> - Add a helper in bootflow
> - Add a new patch supporting ad-hoc bootflows
> - Add new patch to export bootdev_get_from_blk()
> - Add new patch to record loaded files in an ad-hoc bootflow
> - Update bootstd_add_bootflow() to return the element number
> - Use the helper function
>
> Changes in v2:
> - Add an image type extension in bootflow.h
> - Change the tag to bootmeth_efi
> - Drop patches already applied
> - Drop patches which add new image types
> - Update to use a new image-type enum in bootflow.h
> - Use the word 'feature' instead of 'hack'
>
> Simon Glass (19):
>   bootstd: Move bootflow-adding to bootstd
>   bootstd: Move bootflow-clearing to bootstd
>   bootstd: Add a function to get bootstd only if available
>   bootstd: Drop the bootdev-specific list of bootflows
>   bootstd: Move the bootflow list into an alist
>   bootstd: Maintain a list of images
>   bootstd: Update bootmeth_alloc_file() to record images
>   boot: pxe: Drop the duplicate comment on get_pxe_file()
>   bootmeth_efi: Simplify reading files by using the common function
>   bootmeth: Update the read_file() method to include a type
>   bootmeth_efi: Check the filename-allocation in the network path
>   boot: Update extlinux pxe_getfile_func() to include type
>   boot: Update pxe bootmeth to record images
>   Update bootmeth_alloc_other() to record images
>   bootstd: Update cros bootmeth to record images
>   bootstd: Add a simple command to list images
>   bootstd: Export bootdev_get_from_blk()
>   bootstd: Add the concept of an ad-hoc bootflow
>   fs: Record loaded files in an ad-hoc bootflow
>
>  boot/bootdev-uclass.c            |  78 ++++++-------------
>  boot/bootflow.c                  |  77 +++++++++++++++----
>  boot/bootmeth-uclass.c           |  29 +++++--
>  boot/bootmeth_android.c          |   3 +-
>  boot/bootmeth_cros.c             |  17 ++++-
>  boot/bootmeth_efi.c              |  16 ++--
>  boot/bootmeth_efi_mgr.c          |   3 +-
>  boot/bootmeth_extlinux.c         |   7 +-
>  boot/bootmeth_pxe.c              |  10 ++-
>  boot/bootmeth_qfw.c              |   3 +-
>  boot/bootmeth_sandbox.c          |   3 +-
>  boot/bootmeth_script.c           |   7 +-
>  boot/bootstd-uclass.c            | 104 +++++++++++++++++++++++--
>  boot/pxe_utils.c                 |  36 ++++-----
>  boot/vbe_simple.c                |   5 +-
>  cmd/Kconfig                      |   9 +++
>  cmd/Makefile                     |   1 +
>  cmd/bootdev.c                    |   2 +-
>  cmd/bootflow.c                   |  11 +--
>  cmd/bootstd.c                    |  65 ++++++++++++++++
>  cmd/pxe.c                        |   2 +-
>  cmd/sysboot.c                    |   6 +-
>  doc/develop/bootstd/overview.rst |  24 +++++-
>  doc/usage/cmd/bootstd.rst        |  79 +++++++++++++++++++
>  doc/usage/index.rst              |   1 +
>  fs/fs.c                          |  15 ++++
>  include/bootdev.h                |  36 +++------
>  include/bootflow.h               |  88 ++++++++++++++++++---
>  include/bootmeth.h               |  22 ++++--
>  include/bootstd.h                |  69 ++++++++++++++++-
>  include/pxe_utils.h              |  14 +++-
>  test/boot/bootflow.c             | 126 +++++++++++++++++++++++++++++++
>  test/py/tests/test_ut.py         |   3 +-
>  33 files changed, 788 insertions(+), 183 deletions(-)
>  create mode 100644 cmd/bootstd.c
>  create mode 100644 doc/usage/cmd/bootstd.rst
>
> --
> 2.34.1
>

patchwork link: https://patchwork.ozlabs.org/project/uboot/list/?series=433068

What is the status of this series please?

Regards,
Simon
