Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B657EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 15:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B1F86451;
	Wed, 23 Aug 2023 17:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="pfbEj7d+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1D0486451; Wed, 23 Aug 2023 17:30:52 +0200 (CEST)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 787228645F
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 17:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-79d8edd6d99so2066196241.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692804649; x=1693409449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=21j1V9CT+xvtOU8/m/QmtxcI0WLSrM9X+ACbDHilIOQ=;
 b=pfbEj7d+WsaNzsQPgwhl3VYi3Nr4y6sIFxJZHzkl/ONbjnpUnhPnV9Mvzr5H9WH1EI
 u5VO+8EfHi46Sgnun/ekdT6vpWGXf8WLfjne9BMLgt9rVsbr/cz7xLg2+Vh3NuY+6yEb
 ymQXo+60VOa4Gp/Q7XFfMywkq1f5OP0g4muu7thaewhErQR+7h/KQT+gt4tP5jk4Xrhd
 Q/V++JGuCrmOkU46dMGcTmNf6Yy8sXFWjbYllVjb9tzcIY7ZzjO+OXZNY1Dj887cihAq
 MW0nrM2KJe0j8dbVlbvbr0hCyThWwY0JPlAfY2fdc9ZMyocIRHTaYCyv6B38Tr4wY2NK
 1BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692804649; x=1693409449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=21j1V9CT+xvtOU8/m/QmtxcI0WLSrM9X+ACbDHilIOQ=;
 b=CNMlQJkIBFps1B2aVjFeXpZGIj4tqxvpBzBupUIIENQnSjQDBuLvaOI5D95BaQaWSx
 c3pvGvXKAtoX6seGzg/0GnKa9a3Ngc7azElgJ7gA5LOr91UsSs3cXjZ8HTr1K1DstCWg
 rNVAtXrgovC7K5M2gLEJwHZUAx9fESjv4jpNszJZBsz4Ga3ueSVcvvw/dn+1EQEVTypC
 V8Pwa5QB/QqH/4UXhkCRsdT9HOnPMtPu32IAjwEwVuNpRbSO6QtGDLcFzoqA8+AHkV3Q
 lRD+6G6KKeU0YC5ksgy0kVWaaeUU7EaylVIYUjEWhbwbk2nvJllW3yqunXg/anD7PSD9
 LbwA==
X-Gm-Message-State: AOJu0YwVtipzBcqYLlTZzf0kAIzBuoRV73h4rCIvaCQTTZBTPYFA6q4L
 iOv2ZHRkqBj+NjQ+SQ3zvUwtTGlsW147VyCV9JdwmQ==
X-Google-Smtp-Source: AGHT+IEsnIGluwpitLZ5ZAJuXILY9fEWXL7d/lRQYtoNEuWHri2q+oHLOIHTsE1EyuwJ6pmH5h0N20A5qYFjaiBuSeY=
X-Received: by 2002:a05:6102:3bc4:b0:44d:4aa1:9d3e with SMTP id
 a4-20020a0561023bc400b0044d4aa19d3emr8732573vsv.0.1692804648785; Wed, 23 Aug
 2023 08:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
In-Reply-To: <20230822184135.2328409-9-nm@ti.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 23 Aug 2023 09:30:31 -0600
Message-ID: <CAPnjgZ1wGkq66ZEXHUVzLpc47fYgV0+Kk9WNwqDWcO0R7jEYVA@mail.gmail.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

Hi Nishanth,

On Tue, 22 Aug 2023 at 12:43, Nishanth Menon <nm@ti.com> wrote:
>
> Add base documentation for BeaglePlay
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Changes Since V3:
> * Updated documentation to give a more clear overview of MMC partitions
>   and flashing information.
> * Added OpenOCD debug documentation
> * Added LED status information and indication of various boot stages
>
> V3: https://lore.kernel.org/all/20230815164440.2713726-5-nm@ti.com/
> V2: https://lore.kernel.org/u-boot/20230727234446.3651836-5-nm@ti.com/
> V1: https://lore.kernel.org/all/20230725185253.2123433-7-nm@ti.com/
>
>  doc/board/ti/am62x_beagleplay.rst    | 256 ++++++++++
>  doc/board/ti/img/beagleplay_emmc.svg | 697 +++++++++++++++++++++++++++
>  doc/board/ti/k3.rst                  |   1 +
>  3 files changed, 954 insertions(+)
>  create mode 100644 doc/board/ti/am62x_beagleplay.rst
>  create mode 100644 doc/board/ti/img/beagleplay_emmc.svg
>

Great docs, an example to others.

Some nits below.

The bigger problem is that we cannot build this with buildman since it
needs config fragments and we don't have a way to describe them. In
fact none of my existing flows can build this board and it breaks all
my scripts, etc.

I don't think anyone else sees this as a problem?

Anyway, I'll send a separate email on the topic.

> diff --git a/doc/board/ti/am62x_beagleplay.rst b/doc/board/ti/am62x_beagleplay.rst
> new file mode 100644
> index 000000000000..5adb7b4c9ace
> --- /dev/null
> +++ b/doc/board/ti/am62x_beagleplay.rst
> @@ -0,0 +1,256 @@
> +.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +.. sectionauthor:: Nishanth Menon <nm@ti.com>
> +
> +AM62x Beagleboard.org Beagleplay
> +================================
> +
> +Introduction:
> +-------------
> +
> +BeagleBoard.org BeaglePlay is an easy to use, affordable open source
> +hardware single board computer based on the Texas Instruments AM625
> +SoC that allows you to create connected devices that work even at long
> +distances using IEEE 802.15.4g LR-WPAN and IEEE 802.3cg 10Base-T1L.
> +Expansion is provided over open standards based mikroBUS, Grove and
> +QWIIC headers among other interfaces.
> +
> +Further information can be found at:
> +
> +* Product Page: https://beagleplay.org/
> +* Hardware documentation: https://git.beagleboard.org/beagleplay/beagleplay
> +
> +Boot Flow:
> +----------
> +Below is the pictorial representation of boot flow:
> +
> +.. image:: img/boot_diagram_k3_current.svg
> +  :alt: Boot flow diagram
> +
> +- On this platform, 'TI Foundational Security' (TIFS) functions as the
> +  security enclave master while 'Device Manager' (DM), also known as the
> +  'TISCI server' in "TI terminology", offers all the essential services.
> +  The A53/M4F (Aux core) sends requests to TIFS/DM to accomplish these
> +  services, as illustrated in the diagram above.
> +
> +Sources:
> +--------
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_boot_sources
> +    :end-before: .. k3_rst_include_end_boot_sources
> +
> +Build procedure:
> +----------------
> +0. Setup the environment variables:
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_common_env_vars_desc
> +    :end-before: .. k3_rst_include_end_common_env_vars_desc
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_board_env_vars_desc
> +    :end-before: .. k3_rst_include_end_board_env_vars_desc
> +
> +Set the variables corresponding to this platform:
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_common_env_vars_defn
> +    :end-before: .. k3_rst_include_end_common_env_vars_defn
> +.. code-block:: bash
> +
> + $ export UBOOT_CFG_CORTEXR="am62x_evm_r5_defconfig beagleplay_r5.config"
> + $ export UBOOT_CFG_CORTEXA="am62x_evm_a53_defconfig beagleplay_a53.config"

Can you drop those two variables? It seems to just confuse the matter.
They are only used once. We are used to seeing a 'defconfig' target
when configuring, and this just obfuscates things.


> + $ export TFA_BOARD=lite
> + $ # we dont use any extra TFA parameters
> + $ unset TFA_EXTRA_ARGS
> + $ export OPTEE_PLATFORM=k3-am62x
> + $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
> +
> +.. include::  am62x_sk.rst
> +    :start-after: .. am62x_evm_rst_include_start_build_steps
> +    :end-before: .. am62x_evm_rst_include_end_build_steps
> +
> +Target Images
> +--------------
> +Copy the below images to an SD card and boot:
> +
> +* tiboot3-am62x-gp-evm.bin from R5 build as tiboot3.bin
> +* tispl.bin_unsigned from Cortex-A build as tispl.bin
> +* u-boot.img_unsigned from Cortex-A build as uboot.img
> +
> +Image formats:
> +--------------
> +
> +- tiboot3.bin
> +
> +.. image:: img/multi_cert_tiboot3.bin.svg
> +  :alt: tiboot3.bin image format
> +
> +- tispl.bin
> +
> +.. image:: img/dm_tispl.bin.svg
> +  :alt: tispl.bin image format
> +
> +Flash to eMMC
> +-------------
> +
> +The eMMC layout selected is user-friendly for developers. The
> +boot hardware partition of the eMMC only contains the fixed-size
> +tiboot3.bin image. This is because the contents of the boot partitions
> +need to run from the SoC's internal SRAM, which remains a fixed size
> +constant. The other components of the boot sequence, such as tispl.bin
> +and u-boot.img, are located in the /BOOT partition in the User Defined
> +Area (UDA) hardware partition of the eMMC. These components can vary
> +significantly in size, so readjusting the boot partition offsets is
> +not practical.
> +
> +.. image:: img/beagleplay_emmc.svg
> +  :alt: eMMC partitions and boot file organization for BeaglePlay
> +
> +The following are the steps from Linux shell to program eMMC:
> +
> +.. code-block:: bash
> +
> +  # # Enable Boot0 boot
> +  # mmc bootpart enable 1 2 /dev/mmcblk0
> +  # mmc bootbus set single_backward x1 x8 /dev/mmcblk0
> +  # mmc hwreset enable /dev/mmcblk0
> +
> +  # # Clear eMMC boot0
> +  # echo '0' >> /sys/class/block/mmcblk0boot0/force_ro
> +  # dd if=/dev/zero of=/dev/mmcblk0boot0 count=32 bs=128k
> +  # # Write tiboot3.bin
> +  # dd if=tiboot3.bin of=/dev/mmcblk0boot0 bs=128k
> +
> +  # # Copy the rest of the boot binaries
> +  # mount /dev/mmcblk0p1 /boot/firmware
> +  # cp tispl.bin /boot/firmware
> +  # cp u-boot.img /boot/firmware
> +  # sync
> +
> +.. warning ::
> +
> +  The U-Boot is configured to prioritize booting from an SD card if

U-Boot is configured

> +  it detects a valid boot partition and boot files on it, even if the
> +  system initially booted from eMMC. The boot order is set as follows:
> +
> +  * SD/MMC
> +  * eMMC
> +  * USB
> +  * PXE
> +
[..]

Regards,
Simon
