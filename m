Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211F2C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 17:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E3D828F8;
	Thu,  5 Jun 2025 19:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cicFoqW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F2081E25; Thu,  5 Jun 2025 19:29:21 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE3EF828F8
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 19:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-acb39c45b4eso195585066b.1
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1749144558; x=1749749358; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HOaUUI4boP1aFyEEAOcy9BkYa4RwA6sl4y5ElzpHLZM=;
 b=cicFoqW8/ozEsvyt3kpGyABfveRGF1DthzzODlLoaqt0VUzf6/tnPlVan5OWLaIPR+
 0iKKyud70Dh/ulFEnVMqcgBPFAi/K1GLJNj52envSpmrRJ2eHqy0z0+p0Trp/g6qYSud
 cU9C/+/qxZfR6PJnZQfRl4P263Ch15kB/KIHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749144558; x=1749749358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HOaUUI4boP1aFyEEAOcy9BkYa4RwA6sl4y5ElzpHLZM=;
 b=Af+JjJfFAWYJz1WRj0DrlTo5WUz3J2BOY+0nzQ/XOFKk/pz2UK6WdPy7s3WtrKj2sT
 MuA87oSQmt+M4yDSKV7RfjcyEZK3FNknWLlmGeN0BO8NAGC5t9XguSmjbYkoilzEd8sf
 9SXV0f/In/Q+3Xn4ACCG0MSmZ5+bzAl6krGdG/5iFJSDP/qXhpH6xnLI0LaV3l3QLg3I
 6uSPRroZSN0JHOgrxE2pKvUopOSSmk3IXVs0yy4rUuyupBgGmR3FLdnMUmunX6EZyCRF
 C3Oz/EW7CtDBA4845VheHOJtNn34zqieMcJ1JRV2HRLEaP87Yoj+qiE2MJEbbiszM2hX
 kXHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwIPhlIOvbT8kHWvZpS6xZrKGnEQD5HFUvzDk6mFzX1Eo7Ll2A769Dcf1gpXAx7zf0Qc0U5RQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwzeCgYEkDyyayvfOFK77sgd1qeT75hKke9VaSAPB43sjIs5eRh
 QGEKs6Hkn3YZ0qB09pmAQpNi3emlr6JT6/j/PGOPtPIFdPPM4apla37hS8e7g3PkwQsiUfnLljZ
 uXhrjikJzY4z7WUMAcKwmSDVyuDpTQ046l41Ccx/i
X-Gm-Gg: ASbGncu3ZtILVY0Lim+rO5aYYY5mc0+f7tLC11FcE39uP4tu5bXFxDzDb919QtUduox
 Qkry+UHBdUEYYoOnzPzIbpzeFJKXxq5rAa8e7jD3+oiQgdzHHYV5DrmodQtU9beOr5s2mfrW3/o
 DBzOm458U3k6oV3jOYxyife96iYUx1dNp4hw==
X-Google-Smtp-Source: AGHT+IFi4PjHyQmNfOtvnffTRFe9Glg3kAUvxxvT3OFpLPl+G1PVaQlcLBhQQEjGZ6ievD0+kB+qACYp26OQBcuJHJs=
X-Received: by 2002:a17:907:1c0a:b0:acb:abff:a5b6 with SMTP id
 a640c23a62f3a-ade1aa4d0c6mr3189666b.13.1749144558113; Thu, 05 Jun 2025
 10:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
In-Reply-To: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Jun 2025 11:29:04 -0600
X-Gm-Features: AX0GCFvArnM2_qhzpwmb1CmefcDx2KdlCCA5nyeCVGPTlFU9OxnfAE3U95eskvs
Message-ID: <CAFLszTjWqhg1baNSF5rLqjYdoDNyjmy=5hXXq5AzwNF_QSfAQg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] bootstd: New bootmeth for RAUC A/B systems
To: Martin Schwan <m.schwan@phytec.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Wadim Egorov <w.egorov@phytec.de>
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

Hi Martin,

On Wed, 4 Jun 2025 at 06:16, Martin Schwan <m.schwan@phytec.de> wrote:
>
> This series implements a new bootmeth for RAUC A/B systems. RAUC (Robust
> Auto Update Controller) is a lightweight update client, providing "Safe
> and Secure OTA Updates for Embedded Linux". See the following links for
> more information about RAUC:
>
>   https://rauc.io/
>   https://rauc.readthedocs.io/en/latest/
>
> PHYTEC uses RAUC in its Yocto based distribution "Ampliphy" as the
> default way of updating embedded devices based on PHYTEC hardware. So
> far, the logic selecting the correct partitions and files to boot was
> being implemented in the U-Boot environment. While this is a
> straightforward way to do it, adding and supporting new platforms became
> somewhat tedious and is platform-specific. The introduction of U-Boot's
> "Standard Boot" provided a convincing alternative, promising a simpler
> and more portable way of booting, even for RAUC systems. This led me to
> implement a new bootmeth supporting RAUC A/B systems. Note, that this
> new bootmeth is not proprietary to PHYTEC products and is designed to
> work on other hardware with a RAUC A/B system, too.
>
> The bootmeth currently only supports symmetric A/B partitioning layouts.
> E.g. A/rescue is not (yet) supported. The partition indexes and default
> slot tries can be specified via configuration options.
>
> For now, the bootmeth_rauc uses a similar approach for loading the
> Kernel and device tree as the bootmeth_script, in that it requires a FIT
> containing a U-Boot script loading the desired distro. It could be
> possible to support booting without a script and load the Kernel and DT
> directly with this bootmeth, but I found the script method to be very
> flexible for now, in letting the distro decide what to load.
>
> The bootmeth_rauc was tested on a phyBOARD-Pollux i.MX8M Plus [1] with
> BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.2 [2].
>
> Supported boot devices are currently only MMC devices, but it should be
> possible to add SPI flashes in the future.
>
> To test this patch stack with PHYTEC's phyBOARD-Pollux i.MX8M Plus
> board, you need to adjust the boot files to include the boot.scr.uimg
> containing the distro's boot script and set "optargs" to "${raucargs}"
> in it. Also disable any legacyboot in the U-Boot environment and simply
> boot with Standard Boot:
>
>   bootmeth order rauc
>   bootflow scan -lb
>
> Regards,
> Martin
>
> [1]: https://www.phytec.eu/en/produkte/single-board-computer/phyboard-pollux/
> [2]: https://download.phytec.de/Software/Linux/BSP-Yocto-i.MX8MP/BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.2/
>
> ---
> Changes in v3:
> - Invert if-statement check for setting default value of BOOT_*_LEFT env
>   variables. This would falsely trigger an error message before.
> - Link to v2: https://lore.kernel.org/r/20250602-wip-bootmeth-rauc-v2-0-9d2384131486@phytec.de
>
> Changes in v2:
> - Remove LOG_DEBUG from boot/bootmeth_rauc.c
> - Reorder asm/cache.h include to be last
> - Do not check for RAUC-specific files in the rootfs anymore. This does
>   not work on encrypted root filesystems and is not a stable indicator
>   for a functioning RAUC system.
> - Add a description of the term "slot" in the corresponding private
>   struct.
> - Remove boot tries left from struct distro_rauc_slot. The boot tries
>   are read directly from the environment, as that's the only correct
>   source RAUC is relying on.
> - Remove the current boot_order from struct distro_rauc_priv, for the
>   same reason as above (env is correct source).
> - Add function for retrieving a slot struct, to ease finding the right
>   one when e.g. iterating or getting by name.
> - Fix multiline comments.
> - Fix various if-statements which were explicitly comparing to 0 or
>   NULL.
> - Free various, temporary instances of allocated string lists.
> - Set default env values for BOOT_ORDER and associated BOOT_*_LEFT
>   variables. These variables are mandatory for RAUC to work.
> - Use calloc() instead of malloc() for allocating the private slots.
> - Use config options for configuring the partitions and default boot
>   order, instead of setting them via the U-Boot env.
> - Use bootstd_get_prefixes()'s return value and check all available
>   prefixes for the boot script.
> - Add a proper boot order selection logic for the rauc bootmeth, similar
>   to the previous environment scripting, with fallbacks and slot try
>   checks.
> - Introduce config option for resetting all slot tries in case they are
>   all zero. This may prevent a system from locking up in the bootloader.
> - Rename env variable "mmcroot" to "distro_rootpart", to be in line with
>   "distro_bootpart".
> - Change the bootmeth flag to "global", as the rauc bootmeth does not
>   work for individual partitions.
> - Update documentation accordingly.
> - Link to v1: https://lore.kernel.org/r/20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de
>
> ---
> Martin Schwan (2):
>       bootstd: Add implementation for bootmeth rauc
>       doc: Add description for bootmeth rauc
>
>  boot/Kconfig                     |  51 +++++
>  boot/Makefile                    |   1 +
>  boot/bootmeth_rauc.c             | 432 +++++++++++++++++++++++++++++++++++++++
>  doc/develop/bootstd/index.rst    |   1 +
>  doc/develop/bootstd/overview.rst |   1 +
>  doc/develop/bootstd/rauc.rst     |  56 +++++
>  6 files changed, 542 insertions(+)
> ---
> base-commit: b22a276f039f818d5564bec6637071cfc8a7e432
> change-id: 20250129-wip-bootmeth-rauc-03b5e2dd88f4
>
> Best regards,
> --
> Martin Schwan <m.schwan@phytec.de>
>

Great to see this. Could you please add a test, e.g. to
test/boot/bootflow.c ? Let me know if you need help.

Regards,
Simon
