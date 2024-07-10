Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404AAC3DA45
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 11:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D2D886B6;
	Wed, 10 Jul 2024 13:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hIMmLU3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B833F886B6; Wed, 10 Jul 2024 13:33:25 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E106886B5
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 13:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-48fea9d06ceso425483137.0
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 04:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720611202; x=1721216002; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+sjZB4MyQsBHQdaCAwRcwaYsS1V6AlcLrab0k5jsj/4=;
 b=hIMmLU3gEA/6w/byCFIeJH3YzmlRB5Wrtmj3YslA8vUE9O8U7LGtiEKzvkwWU5iERD
 P3P58hl47n+da85+CyOKkY5enNlXTgBVFsceaD+cpnhZAGTAnNohmeiYl5oSyd55LSXz
 S8g2nHHyVQ1Y7yNPQEf6dgyYYmCH9PONlSy7iQr92tFtgKYCQnKMwOQILGXqdXzhOVyI
 s3K2B1Y3wMuw9YoFToXmy+O86iNldsluiQpRhc4KZpckTxBYA339LQA86z5kLWjaPTyH
 esLA/0TSuzDy6muFtUr0Bs6MfDVAgBp3rPS4fYQqnAX9pxKT+8XkX+9BHs2opkR9E0jc
 FGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720611202; x=1721216002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+sjZB4MyQsBHQdaCAwRcwaYsS1V6AlcLrab0k5jsj/4=;
 b=padG/dj/KLZi9V63jHqRVAhdJfGNWIvb31P6NENQzCKCv5tWg9Wu7akzyzD2imhK8V
 /pVg1+lzTvoe9tHOWG4d3HbAf6Xh8Db7BKp5KZWTtjrakv/3HjMAYK388o1q9mfs0J5S
 hZR7LkhJy3VU5UwkrT4DbO8EJ4vyzhni0s4zCr1j+bbHmx84Rt9VEhOBxqyUkt06bc4T
 PVgzzYeVN0lJ234tkvdaE60erI+7yDmbGDR4w143TE5Gr7FijtNbFvae3yRvfId3iCq8
 qVWGemixXk/d/GaftgvRb0zcGujRCh1fMIvF87/UToS2rEd4ehf1lE+n2lZinSbmIb3K
 mH3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD3z3BHQeav/mJ4FwDlhDOM4Sb2pXjVL45PbJ29Hq5Bnl2wL6rXh8ZzfWejEXy3onvJskhWIZxeT2HkXVDFsA9IJuJ3Q==
X-Gm-Message-State: AOJu0YywzSGvIr6c4cFraRkefrGwhluyK2tskcNuCxJ+lTMWU6pLkDrI
 iCVo4BUELP7RoW5fd4l3ng/63pala1k4FkHGmuyZP6eI1iiJPDpt1gnUmr9lDO9SIoU16wfbC9x
 DI+JGMqU/08yWN/YhTin8ZUIaYAQ8zxLeQxbVKQ==
X-Google-Smtp-Source: AGHT+IGkNRD00hA1FPqQOz/oUvhOTH8F4mxz0L3omeXmTBI5ibs65AKOAH6DZlj46YGQPiiWpXWKya92B/kJQl0dq94=
X-Received: by 2002:a67:f309:0:b0:48c:45e3:16e0 with SMTP id
 ada2fe7eead31-490332d8484mr2732721137.9.1720611201315; Wed, 10 Jul 2024
 04:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 10 Jul 2024 17:03:08 +0530
Message-ID: <CAFA6WYM+GEBF3oUa+tk_Ss5mP_rVjavDE1chdpMkGSU1OsHehA@mail.gmail.com>
Subject: Re: [PATCH v4 00/21] qcom: rpmh core and regulator support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
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

On Tue, 9 Jul 2024 at 15:04, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This series introduces support for the RPMh (Resource Power Manager
> (hardened)) co-processor and associated regulator driver found on most
> modern Qualcomm platforms (since ~2017).
>
> Even though most regulators are controlled via SPMI, the specific
> regions on the PMICs for controlling the regulators are restricted and
> can't be accessed by the Applications Processor (AP/HLOS). Instead,
> these resources are proxied via the RPMh where they can be voted on by
> multiple subsystems (Linux, the modem, and the other DSPs). This is done
> for security (to protect clocks, power domains, and regulators that are
> specifically relevant for the trustzone) as well as to simplify the
> management of shared peripherals and to allow for handover of
> peripherals like the USB controller.
>
> For U-Boot, our main concern is the regulators. Since all regulators on
> the system are controlled via the RPMh, it is necessary to support it to
> enable USB VBUS on some platforms, and may be needed for other
> peripherals in the future.
>
> Communicating with the RPMh additional requires accessing the cmd-db
> shared memory region, this contains key/value maps to determine the
> address of specific resources on the RPMh.
>
> Introduce support for the cmd-db, the RPMh framework, and some of the
> regulators that are necessary to enable USB VBUS on the RB5 development
> board.
>
> These drivers are taken from Linux, then modified and simplified for
> U-Boot. The original Linux drivers contain heavy optimisations related
> to multithreading and asynchronous probing, as well as support for idle
> and suspend states which we don't need to deal with here. This unused
> code is removed before finally adjusting the drivers to properly build
> for U-Boot and use its device model.
>
> The U-Boot version of the driver supports a single ACTIVE_ONLY TCS and
> waits for it to be cleared after use. We don't support programming
> low power states.
>
> ---
> Changes in v4:
> - Denote original Linux version in bitmap.h patch
> - Rebased on Linux 6.10-rc6 and re-apply U-Boot changes preserving git
>   history. Allowing for future changes to the Linux drivers to be ported
>   over more easily.
> - Add missing check to wait for the TCS to be cleared after use (seems
>   we were just racing the RPMh before, oops!).
> - Fix missing n_modes in pmic5_pldo regulator.
> - Link to v3: https://lore.kernel.org/r/20240708-b4-qcom-rpmh-v3-0-846cc6c5b728@linaro.org

Thanks for doing this, this looks much better from a maintainability
perspective. Although I am seeing a lot of patches saying adjustments
and build fixes, I think you should have taken care of commits
bisect-ability such that individual commits don't cause any build
errors.

FWIW, for the series:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>
> Changes in v3:
> - Don't call dm_scan_fdt_dev(), since DM core will scan.
> - Link to v2: https://lore.kernel.org/r/20240708-b4-qcom-rpmh-v2-0-8bc765606e56@linaro.org
>
> Changes in v2:
> - Implement Neil's suggestions and fixes for SM8[56]50
> - Slightly refactor cmd_db_init() for better abstraction.
> - Improve logging (printf -> log_err/dev_err)
> - Add missing error check in rpmh_regulators_bind()
> - Link to v1: https://lore.kernel.org/r/20240617-b4-qcom-rpmh-v1-0-bd2336923e0a@linaro.org
>
> ---
> Caleb Connolly (21):
>       linux/bitmap.h: add bitmap_empty helper
>       soc: qcom: import rpmh and cmd-db drivers from Linux
>       soc: qcom: cmd-db: adjust headers for U-Boot
>       soc: qcom: cmd-db: drop unused functions
>       soc: qcom: cmd-db: replace cmd_db_ready() with cmd_db_init()
>       soc: qcom: cmd-db: adjust for U-Boot API
>       soc: qcom: rpmh-rsc: drop unused multi-threading and non-active TCS support
>       soc: qcom: rpmh-rsc: adjust headers for U-Boot
>       soc: qcom: rpmh-rsc: adjust probe for U-Boot
>       soc: qcom: rpmh-rsc: remaining U-Boot API changes
>       soc: qcom: rpmh: adjust headers for U-Boot
>       soc: qcom: rpmh: drop unused functions
>       soc: qcom: rpmh: U-Boot API changes
>       power: regulator: import qcom-rpmh-regulator from Linux
>       power: regulator: adjust headers for U-Boot
>       power: regulator: qcom-rpmh-regulator: port over lineage_range helpers
>       power: regulator: adjust structs for U-Boot
>       power: regulator: qcom-rpmh-regulator: remove unused regulators
>       power: regulator: qcom-rpmh-regulator: port ops to U-Boot
>       power: regulator: qcom-rpmh-regulator: adjust probe for U-Boot
>       qcom_defconfig: enable rpmh regulators
>
>  configs/qcom_defconfig                        |   5 +
>  drivers/power/regulator/Kconfig               |   8 +
>  drivers/power/regulator/Makefile              |   1 +
>  drivers/power/regulator/qcom-rpmh-regulator.c | 544 ++++++++++++++++++++++++++
>  drivers/soc/Kconfig                           |   1 +
>  drivers/soc/Makefile                          |   1 +
>  drivers/soc/qcom/Kconfig                      |  27 ++
>  drivers/soc/qcom/Makefile                     |   4 +
>  drivers/soc/qcom/cmd-db.c                     | 213 ++++++++++
>  drivers/soc/qcom/rpmh-internal.h              | 138 +++++++
>  drivers/soc/qcom/rpmh-rsc.c                   | 518 ++++++++++++++++++++++++
>  drivers/soc/qcom/rpmh.c                       | 110 ++++++
>  include/linux/bitmap.h                        |   8 +
>  include/soc/qcom/cmd-db.h                     |  33 ++
>  include/soc/qcom/rpmh.h                       |  28 ++
>  include/soc/qcom/tcs.h                        |  81 ++++
>  16 files changed, 1720 insertions(+)
> ---
> change-id: 20240611-b4-qcom-rpmh-fcfd32ac2940
> base-commit: 50adc932e7aa34e6d9c738ec13ed09382a9d109a
>
> // Caleb (they/them)
>
