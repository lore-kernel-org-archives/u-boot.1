Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A0DC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 05:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5FCB88297;
	Wed,  5 Jun 2024 07:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yEp1RNxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 468AA88300; Wed,  5 Jun 2024 07:32:12 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2C9A882E6
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 07:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-48bdcecf6efso942065137.3
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 22:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717565528; x=1718170328; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YLVkzM6zhXW3kvZVHEzalzYAWyku8nwG+1XOLJegrks=;
 b=yEp1RNxI0IpvNi58OrrTf1xyIbn++7yvrr1F8WH26lxvcAuimMgfJTwxaOfKTBoGS4
 EjV0EpSThD8P0kNi62hmkbn5zd1Y1aZH05Wf5DixoEHCbSTfhpfqcJ711X3uObZvMa4x
 yHcod0I1WLjaKjJwTPoIXyZWxNA+IZCVFFKnWv9nGdYRq1c+GKzKhGYdQpNHzH5+hJnW
 6yUkeu8Etxbbg1JOhdCyp+CZS3e/nDvX/JvnzUvje5ZAmJJGQDjMWKjn1lWPeuXHGPFz
 fYt7+5nASFDJgBbpAQS4y0K032Ah+LdAyfPK45vv6umv2kA5RC6+DhkIidoyNLenuBu4
 +0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717565528; x=1718170328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YLVkzM6zhXW3kvZVHEzalzYAWyku8nwG+1XOLJegrks=;
 b=f0+kc6YchjL3TUrFcSW0TJlQvRryo9vlPVXgDemhuoYmXuKwvJG1h59FYrAiK86idU
 8l12lFh/7hsaNDjtlNv0fQ4sYQP2Mu7b4IFU4AgS7QzamTHACcXJD17ntwzr8V67gs01
 0Ork/vNxWWBYVdC7TSGCg/PZ1USXR4Vbss4nUAnfZp4G2z+3REqDHl/lnNLCXRisdZAI
 AbmcLEc8L2oCEuOW4jcksc/b2/uClrFCmOj3+xP4r1+cYC91XB7pipVIPxhcR2o5ViyV
 VvcQXByKscqXiZNS5LLPOEQPMQE8V5kS+UgVeAO80S389gudD3n4EwHNlOk1nWKDNpB5
 dhaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeYjaTQcbXr2My5Vtvj64YWOrYf2MW+hivmu/Ba2b9O/i56gcbZpYoJfgOCk5KP4aVec2rbQhuQ/FU9e8N+45Fwm9R6w==
X-Gm-Message-State: AOJu0Yxc3ATwWN9J07yL107ogFvUXggcQU4/rbUXX3EvS86fSUuo2mqG
 T3pjsU4p4I32fGPvC8eClzlPEz078ZUvPJ71RSzeBrG2D4CshzeeIOOLwQ4++W+zakCqUkuBVSv
 o8FUdv6b2yhhWKFFpmv79b0OtS2HqCdhSBWjI7Q==
X-Google-Smtp-Source: AGHT+IF7XdFX8JynqV7/HrcUVcXHcYQoPDM0Zwf+qBdV5ZCKSEvf57ssxDXDNVabZpTZVY+vKP7uKiFoSoBcQUSyGq0=
X-Received: by 2002:a05:6102:58c5:b0:48b:ba90:792e with SMTP id
 ada2fe7eead31-48c047f5024mr1704880137.5.1717565527689; Tue, 04 Jun 2024
 22:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
In-Reply-To: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 5 Jun 2024 11:01:55 +0530
Message-ID: <CAFA6WYP-1tuELgthx=Ky9JYAkgP0mRNEsnHdw2ZmnjHXMAm8Rw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] qcom: implement capsule updates
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Mon, 3 Jun 2024 at 18:19, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hook up support for capsule updates loaded from disk on Qualcomm
> platforms.
>
> Most Qualcomm devices have an A/B partition layout, with most partitions
> duplicated. The metadata on which slot is active is stored in the GPT
> headers in the vendor-specific attribute bits of each partition.

It's good to see capsule updates support coming up for Qualcomm
platforms. AFAICS, with this series we only update U-Boot on the
current active partition. IOW, real A/B support is still not
supported. Do you think it is possible for U-Boot to update metadata
in GPT headers and for proprietary bootloaders to pick up the U-Boot
from the updated partition?

-Sumit

>
> Add support for reading this attributes via the disk_partition struct
> and using them to determine which boot partition U-Boot is flashed to
> and generate the appropriate DFU string.
>
> This logic is gated behind a check to ensure that U-Boot is actually
> being chainloaded and not run via some other mechanism.
>
> SCSI support for most Qualcomm platforms is not yet enabled upstream,
> but will follow in future patches.
>
> This series enables capsule updates on the RB2, however [1] is required
> for it to work properly (as otherwise MMC won't be available).
>
> [1]: https://lore.kernel.org/u-boot/20240527-b4-clk-stub-v2-0-29013855e343@linaro.org/
>
> To: Tom Rini <trini@konsulko.com>
> To: Simon Glass <sjg@chromium.org>
> To: Lukasz Majewski <lukma@denx.de>
> To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> To: Caleb Connolly <caleb.connolly@linaro.org>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Sumit Garg <sumit.garg@linaro.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: u-boot@lists.denx.de
> Cc: u-boot-qcom@groups.io
>
> Changes in v3:
> - Address comments in scsi dfu support
> - enable CONFIG_DFU_SCSI for qcom
> - Link to v2: https://lore.kernel.org/r/20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org
>
> Changes in v2:
> - Add qcom capsule update support patches
> - Link to v1: https://lore.kernel.org/r/20240409-b4-dfu-scsi-v1-0-3e1441a60376@linaro.org
>
> ---
> Caleb Connolly (8):
>       dfu: add scsi backend
>       disk: expose partition type flags
>       mmc: msm_sdhci: work around a bug when writing
>       mach-snapdragon: implement capsule update support
>       qcom_defconfig: savedefconfig
>       mach-snapdragon: use SYSRESET_PSCI
>       mach-snapdragon: bump up heap size
>       qcom_defconfig: enable capsule update support
>
>  arch/arm/Kconfig                          |   2 +
>  arch/arm/mach-snapdragon/Kconfig          |   3 +
>  arch/arm/mach-snapdragon/Makefile         |   1 +
>  arch/arm/mach-snapdragon/board.c          |   8 +-
>  arch/arm/mach-snapdragon/capsule_update.c | 147 ++++++++++
>  arch/arm/mach-snapdragon/qcom-priv.h      |   6 +
>  configs/qcom_defconfig                    |  19 +-
>  disk/part_efi.c                           |   1 +
>  doc/usage/dfu.rst                         |  32 +++
>  drivers/dfu/Kconfig                       |   7 +
>  drivers/dfu/Makefile                      |   1 +
>  drivers/dfu/dfu.c                         |   5 +-
>  drivers/dfu/dfu_scsi.c                    | 435 ++++++++++++++++++++++++++++++
>  drivers/mmc/msm_sdhci.c                   |   7 +
>  include/configs/qcom.h                    |   5 +
>  include/dfu.h                             |  26 ++
>  include/part.h                            |   1 +
>  17 files changed, 695 insertions(+), 11 deletions(-)
> ---
> change-id: 20240523-b4-qcom-capsule-updates-ea2e4f8f0ff0
> base-commit: 5d8881a0801241d68701e8644d495f1d535506f0
>
> // Caleb (they/them)
>
