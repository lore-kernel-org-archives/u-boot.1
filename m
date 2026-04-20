Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39ADEEA719F
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 04:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC8680433;
	Mon, 20 Apr 2026 06:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KpzBfWQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D706983693; Mon, 20 Apr 2026 06:06:53 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED7880087
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ba8472c1613so33179566b.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 21:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776658011; cv=none;
 d=google.com; s=arc-20240605;
 b=eQ7qmZ11O6iMeqwBuUgBLIxw2lfIMJzOfolY9jKr9im6Mrbh1t8Wqyztr2MshGmvld
 jDd9SRBmbi1yG0xvUldqi98oQaRe/7+Mh4e9VfP8jMweETwEpSKk8kFhEMzBpMnbI6gs
 ouyJg0iIDu5coE1vSLUtocT5kr+j5Wt2nLKQ5qrXiHbuXRUH3O+34ZFfI+gd+fqNuFFy
 6MFn1tLALXXcPis6fkXE+qYfFm06kDp+Sg7+pE19XfS1uhKSWw+WY5c8OdsPhWWw/cA1
 zt1msuaTRqX+zazIkaFOIkrBMeKuORC/RteaRGB4VxlDTYWwQjsh23m9FD95L3zPiBjH
 NhAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MQyD3OcJb77qFTYgVnQpQDoJcHeMYMXISq4rAStoDoY=;
 fh=BXL3Ebep6U/SPcdT8S12cNLOXJzhmXLerCkJOhu/iKU=;
 b=PmhPM/xDd8CnbkvHR7leTLeVjNoX/kkiwGfeyQbM5amGSZHLUXUxJnzwScV3XKZHrk
 Ys3MoGsG0nEquvpyRUZI7oC+kLEMMzsyK1knIj6B2eNS9ITsDr14xakgLL2LVWLEB3A9
 EJpQ7bnoC0M/wxSzOFjZEJFW9AUMeiVX2UV+PyyNn+5lJU4TOoE8AyKg091r0BMENooe
 AEuXlB1sPKYGhC6ztUYXePnfms3Q5di7miXZjHD0zO/GVsKQaiQTvCfYgdOUrS90ovc9
 +Gc8YDtg0wpynYfoISFQBqkV0iYruYBrX3TDK6qAiUP5w7nLVotL3CqlkH3Nzg7AyH0c
 yTqg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776658011; x=1777262811; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MQyD3OcJb77qFTYgVnQpQDoJcHeMYMXISq4rAStoDoY=;
 b=KpzBfWQ9Uk7NDRXsmkyVsfUd3acbGYJg3JaV8O3XIrM7IsV16iIfPmC16jtum+px5s
 T5JSRUyRtdMer0DDe4QjH5SLBz3IL6ppzy9jz9ZI4w1pjy2/5jQD5y8+66BxtNY2E/w0
 pfi8ZtXGibtB1l7vipZhBkwFQuezdUVQzBubI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776658011; x=1777262811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQyD3OcJb77qFTYgVnQpQDoJcHeMYMXISq4rAStoDoY=;
 b=IQrdAtfIHPlhJDsBt0NrlghCnhYQof+nj8ekKbZEWDUz8n7SVyP4UxmblsD0OhZnah
 Q2rp/OcI69ihCThEA44ymm0Nvtdj7vwOn/328/cWfdf9nzQMS/XiaCVJyA0A1RxSm9tJ
 LlQ/w23MzinESxKLcb7UB/nUfEng3fHFlX5BI19R2QDfFn3t7DiwKiCc0gJyI62Jn4xa
 45EeWFbeUgykzycks41t0GK/CHiCGIITT/lW6TgC8dDOaYTxiA5IZ+/CUHBRGDOoNGak
 Cr3f6JGV3s8RO1WJn6asbq7Q8xRZf5gBGgSulP8rsEzqrnTqzLL5gUYlpR6ZtVYog2nf
 C53w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/R5rEHFfiDV2wnwBEuY+lryqZQl3Y6sDxg+rrJiXBf0n4ElE20ORMRLxF/opjS1vcj3cvKoJw=@lists.denx.de
X-Gm-Message-State: AOJu0YyGxVv8vjOwa34kmVHheqUZdjINt5LQ4houmydeZlyYK0y9xbWK
 Sy174q0lwCKe75Nc2C9Y5gzsEGAWtLYSiLvg4irX+JIhSze71x01ooD958OWSHBleMflzNH8zpv
 VJ2pMWLepS+8+ZqEeiA5FeUEzBhSKMKjTW8JyCbQL
X-Gm-Gg: AeBDievtqvx7o+P/8CqzsK2KvYmuP3TmKFHxW6qNQ30YsY3wQ4yAqgVpOqlDP4ZEMd9
 toHf7gLXN8CXtALn4B9RLtyZ4XoNh5empKTXz0La9KeYFQudzsOezk/W2/sn4OaUrmyppM8YwYj
 V6weAEB+0DmtbSzYsG92DZNszTMIKEttF+Ne5IGN4Q9biUaX1vtTMNUMBcph3dyy8H2uyZ84doK
 /Nykp5Tq2Lm4y8WUZjumjheDkNsVaG2TEScvLuVohydKnqbDD3+8RV1VBrU8kcEuGNeUe4whJXI
 oE55sMZmLVfeiZ/5FfGogKVFa2zIH34=
X-Received: by 2002:a17:906:fe45:b0:ba5:7cce:979f with SMTP id
 a640c23a62f3a-ba57cce99dbmr296401766b.40.1776658010626; Sun, 19 Apr 2026
 21:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
 <20260417120951.3454249-2-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260417120951.3454249-2-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 16:06:37 +1200
X-Gm-Features: AQROBzCBDrRZAD21QgUwXdjbTqUTprEHzzogRTxyoZ9O244IbUTNhIdjKy-jOUw
Message-ID: <CAFLszTgxHu9zbR_Q8sw_gYETqf3YBvPtAyg6kDeyCm6DM8aeJw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] mach-snapdragon: Add generic SMEM cache
 infrastructure
To: aswin.murugan@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, 
 gchan9527@gmail.com, mchitale@ventanamicro.com, maximmosk4@gmail.com, 
 jonas@kwiboo.se, marek.vasut@mailbox.org, quentin.schulz@cherry.de, 
 peng.fan@nxp.com, sajattack@postmarketos.org, 
 balaji.selvanathan@oss.qualcomm.com, wolfgang.wallner@at.abb.com, 
 e@freeshell.de, yangshiji66@outlook.com, jan.kiszka@siemens.com, 
 funderscore@postmarketos.org, hs@nabladev.com, kory.maincent@bootlin.com, 
 jj251510319013@gmail.com, carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
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

Hi Aswin,

On 2026-04-17T12:09:44, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:
> mach-snapdragon: Add generic SMEM cache infrastructure
>
> Add cached access functions for commonly used SMEM data to reduce
> redundant SMEM lookups across the boot process.
>
> This patch introduces three generic caching functions:
> - qcom_get_smem_device(): Cached SMEM device access
> - qcom_get_socinfo(): Cached socinfo structure access
> - qcom_get_ram_partitions(): Cached RAM partition table access
>
> The implementation includes new header files for data structures:
> - include/soc/qcom/socinfo.h: Added socinfo header from Linux [1]
>   Provides socinfo structure definitions for SoC identification
>   and hardware parameters
> - arch/arm/mach-snapdragon/rampart.h: Provides RAM partition table
>   structures for memory layout information
>
> The caching mechanism initializes SMEM data on first access and
> returns cached pointers on subsequent calls, avoiding expensive
> SMEM lookups during boot. This infrastructure is designed to be
> [...]
>
> arch/arm/mach-snapdragon/board.c     |  95 +++++++++++++++
>  arch/arm/mach-snapdragon/qcom-priv.h |  24 ++++
>  arch/arm/mach-snapdragon/rampart.h   | 225 +++++++++++++++++++++++++++++++++++
>  include/soc/qcom/socinfo.h           | 114 ++++++++++++++++++
>  4 files changed, 458 insertions(+)

> diff --git a/arch/arm/mach-snapdragon/rampart.h b/arch/arm/mach-snapdragon/rampart.h
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RAM partition table definitions
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + */
> +
> +#define SMEM_USABLE_RAM_PARTITION_TABLE              402

This header should have an include guard.

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> @@ -749,3 +761,86 @@ void enable_caches(void)
> +/**
> + * qcom_get_smem_device() - Get cached SMEM device
> + *
> + * This function provides cached access to the SMEM device.
> + * On first call, it initializes the SMEM device.
> + * Subsequent calls return the cached pointer.
> + *
> + * Return: Pointer to SMEM device on success, NULL on failure
> + */
> +struct udevice *qcom_get_smem_device(void)
> +{
> +     struct udevice *dev;
> +
> +     if (uclass_first_device_err(UCLASS_SMEM, &dev)) {
> +             log_err("Failed to get SMEM device\n");
> +             return NULL;
> +     }
> +
> +     return dev;
> +}

Can you update the commit message and function documentation since
this does not cache anything.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
