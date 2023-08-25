Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AE7C88CB2
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 01:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD438694A;
	Fri, 25 Aug 2023 03:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="2rBZxNmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1871A869B9; Fri, 25 Aug 2023 03:05:09 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E11B186497
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 03:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so1027303a12.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692925505; x=1693530305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NULSXYf3GECJMTMafSnspeOfkzDtNbVkuak95iozLKo=;
 b=2rBZxNmD/CT38vISKs1sFj68yhXTzgU+UE4qWisJ6aTPMtPuT0I1DmZL92JctLbTqm
 kHbRobQ6C9Pjf98uisnAKVswckY0ceOUkoFcSrqZP5kXbBzHPbfAzfMrRirX+5cmp2Wr
 y8sreyHbDNlny3+Wt7T1rZHNcae/m8QoMhnGhGQH79ULLlUKsfxNI1zlAir7caHgM6IP
 0/TtAt1QFzFwWg+OuqFdlh3pwjtlLkncdKvp6FeJO+VES3YLdIhDV+CszYx9Un0U9Oiw
 +Tw1zA7WIf1aRqF8c9eUHl4np3aXbHHR752b1iov6ObDGCMD32XIHPShPNtP+UStjyEk
 E1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692925505; x=1693530305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NULSXYf3GECJMTMafSnspeOfkzDtNbVkuak95iozLKo=;
 b=hx0JKiNAWZRmpzFXh7zH5RqYJsioY7SKt9vygpm/1qzXb2DgosDtsZhCQpp8l/x6XP
 lJPUVM5cX0bSyNKXVEkrvAHGkML6EawUBcvj9/wLXI5ouCAE4RVF1PNbp2E8ESn2dYCW
 uJ7W61rQsHRQsVtGWn9acVlYY2V15rNWtG22Z4osC/GxjN5k3r8GzY8UPWtxh6m1VjjU
 rsECCd8TIHQGLCcDLy/i9gOPHtQbFgVHnrSfTVJMCmhrdSG5XqWjkTYEhBuniIMjzHQv
 NvT6q82iS7MINsT8inpnvD0bPiYaUsLQVpfFLUcLgXpsxYtZkz4NZRKb3PV1i/JU0VZO
 0K8Q==
X-Gm-Message-State: AOJu0YwymnuOpW111hlouEn326Y+DB3zwLNed6R2/pIdvgDy7j3U886G
 Bf/yZgLlqtpLeejqJVbTB+S7fHsgwC1SKqeM80uVmA==
X-Google-Smtp-Source: AGHT+IGQJX05qPw75QB+2UHBGdBA1Ui+BMGuhFf6oKADnBn8BzP56QD3B87tdvG+MDdVULs+2KTDpzVYZqzxDJCQgVM=
X-Received: by 2002:aa7:c384:0:b0:522:4764:8baa with SMTP id
 k4-20020aa7c384000000b0052247648baamr18163132edq.12.1692925505157; Thu, 24
 Aug 2023 18:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
In-Reply-To: <20230822184135.2328409-9-nm@ti.com>
From: Simon Glass <sjg@google.com>
Date: Thu, 24 Aug 2023 19:04:53 -0600
Message-ID: <CAPnjgZ2vDyWcpsK8rXFkCZ1EpsFsDta6vN5_dkhrrmU_vfoVUQ@mail.gmail.com>
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

I just noticed - I think this should be u-boot.img

Also I tried the mmc instructions and managed to brick the board. Is
there a recovery procedure?

I suppose I should have tries it on an SD card first. I thought that
was what I was doing, but I didn't know about the internal mmc...

Regards,
Simon
