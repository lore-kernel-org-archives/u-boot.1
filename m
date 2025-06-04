Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AD9C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 13:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34B488070C;
	Wed,  4 Jun 2025 15:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ak8GLTQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0034807B1; Wed,  4 Jun 2025 15:25:53 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 510D380584
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 15:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-450d668c2a1so6725005e9.0
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749043551; x=1749648351; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mlRFHBb+e/3DnBVy0XIyZPwU9Irof9pCoNXZ4bUfTLc=;
 b=Ak8GLTQ+B4yNVVgmzuBhJOyRE2ASFa/cVJ2L6ou8GI2GFU3xOYjGz/8gsIeY4IAf23
 oZ85PQsPBsjhJ5nnsC57EVSNGsyhsSJhZzWcH8z6nXNwFK7YX/I+aiK06dPmtKfo49ce
 aS01P8mZBvV5kZ2k/nJLavm9SqDDJrfXZcPgHYNjCCe7D1Gan+amP9zW/82VWyn6mgnh
 cwz2AKJYSAO8y4iGd/8J+5sUC9UIYqInLXV+kuFfazXpJjjHjqxPf5vICfRaV4Sd9Uzf
 SCwl3evj6tzQvvJoB/MR5/bR5DYXmo3KCLe8C+VOHqKsFMawy8IF3DCpYtlg1Ni9lL1T
 DuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043551; x=1749648351;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mlRFHBb+e/3DnBVy0XIyZPwU9Irof9pCoNXZ4bUfTLc=;
 b=cYon39dXjx49jWdSGLOyRlJwp7HXVoRIyTDUeCUmLonZVzefy9HH9hpYEtvWQjzP/A
 TDsM43pVhyshed0WLISS6umLFwiLslnZn/07dOusHU+SyUaF/2J4DKsnEINQ5SaNJ6sb
 +d8WV/BXdEtKzT+3GqHaP/TR45AuI9tzLPNw+nmdCT9pmgKNAQ6RAHwbfK6j/KMBIiRq
 Shr3Hvcn+LJOtazsg5JGcyxjBKoHRQDlmQroImDN1AdF2GsrIx8re/E9TLOpFLvc2yUF
 2bi4HMyHrhfQxjzF6P1fVo3ZgjD7bhU5updBxlBF/WL1jxB1QmfOhV6KnGcyNP5dPPGc
 1vrg==
X-Gm-Message-State: AOJu0YyrvukONoe36Nf6m/hjHI2ZfS4e/CrUmHHQHXnpSXeOp64a2J8i
 RexsoY3yuxaiEj9H+bsbU775IayiTfuDoKNYUK0NJWnRNI+KdSUVlP66jOiDBsNYNrQ=
X-Gm-Gg: ASbGnct7RdIMVwMDavDUpBdzakOI0s+i0OiYI3an34jWyOl9PdJYB/woAF9duKORErE
 TUKaKRLZlgJy0H1Awx9x7P62U8c/2bnGziu/LTfWtNxXsHyThgUW3BIfwNzzh2Fy4p6UkzWh8T/
 fSLZYE0ptvgd1kjZujSdXZKsZN/C1F9yvMA4kk/jiNkd8bRwN+3PEXauvjSHG4PI8fa8oMGWtvA
 2nrr6hFKXjT3pa2x3Kbvzq75HXPq3R/SB6qQArQnpbxbuk2/Hac6dl3TppglQ/3sM10ZDhR0tKr
 LpKv2JpSNYysfpsngejz2hNQz3L+X8AyZkUZ7c1WdlnUbq6fcqzijhv2gt1LyrTJQoEjtiUye9U
 tvs+P+gKnTRYgQBS/amGR4bKPFEjmA1iHKbuM
X-Google-Smtp-Source: AGHT+IF5t3vtHBKkIfv8YIolbP8x7EMeHYFUREZw3ZA/lVyvfX+kSnjHuU8gteOyD0HxuYhzNFWuWw==
X-Received: by 2002:a05:600c:8b42:b0:43b:c592:7e16 with SMTP id
 5b1f17b1804b1-451e5fb3e57mr72961935e9.3.1749043550643; 
 Wed, 04 Jun 2025 06:25:50 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:968c:2df3:c75e:5a31?
 ([2a01:170:117e:fc:968c:2df3:c75e:5a31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8000f3esm202541665e9.23.2025.06.04.06.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 06:25:49 -0700 (PDT)
Message-ID: <5cb92519-b6c9-462b-8224-366398db5aaf@linaro.org>
Date: Wed, 4 Jun 2025 15:25:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] u-boot chain-loading LineageOS bootimg
To: gchan9527@gmail.com, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250518-android-boot-v3-0-02c8768e131f@gmail.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250518-android-boot-v3-0-02c8768e131f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 5/18/25 13:16, George Chan via B4 Relay wrote:
> This is a series of patches to enable chainloading LineageOS on qcom SOC.
> 
> Patch #1 introduce kconfig to ignore those default value and use loadaddr
> instead. That workaround some androidboot image have invalid kernel/ramdisk
> loadaddr.
> 
> Patch #2 enable #1 for snapdragon machine.
> 
> Patch #3 override qcom soc loadaddr with fastboot_addr_r as a band-aid.
> Casey confirmed loadaddr and kernel_addr_r are purposely set to same
> address for memory-constrain case. A proper fix is far from get ready so
> this patch can work as a band-aid for maintainer atm.
> 
> Remain as unchanged to make it conditional on CONFIG_FASTBOOT is because
> that also imply CONFIG_ANDROID_BOOT_IMAGE set y.
> 
> To: Tom Rini <trini@konsulko.com>
> To: Mattijs Korpershoek <mkorpershoek@kernel.org>
> To: Simon Glass <sjg@chromium.org>
> To: Casey Connolly <casey.connolly@linaro.org>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Sumit Garg <sumit.garg@kernel.org>
> To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Cc: u-boot@lists.denx.de
> Cc: u-boot-qcom@groups.io
> Signed-off-by: George Chan <gchan9527@gmail.com>

Thanks for sticking with us on this. It's really awesome to see you have 
LineageOS booting! If you'd be interested in documenting how you got 
this working (either in U-Boot docs or elsewhere) I think it would be 
super interesting to read about :)

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

Kind regards,>
> Changes in v3:
> - Rebase to origin/master
> - Drop optional patches, leaving those acked patches.
> - Gone through checkpatch.pl
> - Link to v2: https://lore.kernel.org/r/20250505-android-boot-v2-0-92dcb5bf59c8@gmail.com
> 
> Changes in v2:
> - Revised patch #1 to control by kconfig, suggested by Casey
> - Split old #1 into new #1 and #5 for maintainer to choose.
> - Revised Casey's approach for #2 and make it as band-aid atm.
> - Revised Casey's approach for #3 and leave user to bake their own param set.
> - Introduce example for #1
> - Introduce kconfig default for #1 with snapdragon soc, suggested by Casey
> - Link to v1: https://lore.kernel.org/r/20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com
> 
> ---
> George Chan (3):
>        boot/image-android: Workaround kernel/ramdisk invalid addr
>        mach-snapdragon: Enable workaround of ignoring androidboot addr
>        mach-snapdragon: Enhance android image handling memory footprint
> 
>   arch/arm/Kconfig                 |  1 +
>   arch/arm/mach-snapdragon/board.c |  8 ++++++--
>   boot/Kconfig                     | 11 +++++++++++
>   boot/image-android.c             |  9 ++++++---
>   4 files changed, 24 insertions(+), 5 deletions(-)
> ---
> base-commit: 126a88d49bcae04bbfc0d6723097cd6341355ade
> change-id: 20250427-android-boot-ecbb768cda72
> 
> Best regards,

-- 
Casey (she/they)

