Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DE9C5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 21:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B14C40874;
	Thu,  6 Aug 2026 21:07:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RCALu0ptc4sB; Thu,  6 Aug 2026 21:07:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFA9840820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786050455;
	bh=BugSYxVm33Br8ClAM3AUmHTlBN0Wo4DDsUuIlbTKmEk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DCjL1kOMfFcnC3gqPOltTkD5uWuAga6mE2eYwDtzCPWHNYhVKgehzez38s34AbnYb
	 Kv28X6GpF9wB7SW6qMV7YnJ3blj0jqCPazllledcOTxa+IwnEbCsF+Meab5QbBt4GM
	 AwrNpPlMxE2pXHIAEbwuMB9MY0aDx6HHGxKWExoL7oq4e7evIfdu0AcehMGsB9fa/3
	 +XGUPVfu+PmDMCSchZtlOLsusObvIhgrMh1OjJ04a0bb8M1C9DBunNv/+VJIo/7Hxj
	 8zVFoggA/cYVVGaedv4+FKS+Gr8cG8a6c0y9FEFrgx+FBzBcc7yDnGX8zPtsfTqpvz
	 ntBw0CaynT4LQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFA9840820;
	Thu,  6 Aug 2026 21:07:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E04A218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F08F7400BC
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:07:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tn4sgyNxitl1 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:07:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D56B840231
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D56B840231
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D56B840231
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:07:32 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso4010661a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050451; cv=none;
 d=google.com; s=arc-20260327;
 b=PJnwIJszf4csF4p4JwLC0it8qoFjZjah/3scYlq58a2XRmXqVsvl7DhwUFya9ZC1JE
 jFcnr6JWFmqGSIzqpzhmvoTKojFYjQ2stFnXAXAe7LYwWMvcWbxoi6UEoDhjZLWHq6w8
 NpmcgSrpLWxFntL06ubkSCO9vl2N1roJ+QcX6xMP0pPwlbZTeLNN8VKbGKvqRoh9PPWQ
 wxm4Rv1GEb9aku+wN1t4fJ1kVAxNqqmfArLRotLfRkwktRroa6pNzDM2NS/4V+Fd3EDg
 lBRU+1gfNsLu64FlkIiURNI2ba86HzIMguzGnMedZrgkT15LgjHBqvY1igDA+XlB20fN
 2YXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BugSYxVm33Br8ClAM3AUmHTlBN0Wo4DDsUuIlbTKmEk=;
 fh=Ye9d8c9UuIgjdEYE5AmpFdHtipkFyQbZju95WIBagdg=;
 b=DhiMFaKT1N+Kp6aht96abUI5fu4pCtOmmAIh5LrwUj3cmMchcaDvPJLVotwvIlsGiS
 iI/nSMXgyUcrIHSujwQKXBwSHeAGzQPSCpwhFuWA8uQvuyhb1TakAb9ttbMNAjysbWhT
 EngnGINo0EndytVIlaelfpEEnx1Vx7Nm0ubyiplWWTFGVy71SZca2yUgKSSlsnBeOXP/
 7s55r6cuUmRdZrwF4pHFTXwyA4SjntiMCLg1YQAHDZFR72SfuclETPv1bHwu93zayOY+
 xUA7nAdse0YYINFUEZjq/LM2CWJJe27BzRA2k9bidP/perz5J4b3X5fIIZYvucyDdhIm
 SVHQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050451; x=1786655251;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BugSYxVm33Br8ClAM3AUmHTlBN0Wo4DDsUuIlbTKmEk=;
 b=JK0AHeMTtin13ukAQYdVXUoOFikFyd1vPvNfA/VQrWm1qPbCWSg74eNVuhCXZc4IlZ
 4ZXRQLMNaQR2NEBYZMaXd2SK2jyntITQf7FOvRpvgxjo2vQHa+Niv9Vfrb2o882b0MjK
 jAhWmLHx7QaAgRusENTave0vlmFTCARSZ07OwEN8dM04igYBSVce3/rgkLaph2SCa0ag
 wl0yXGXsCrgbBAmNAg1M2s17+NOQpWtqHWh0HubK32wpUVUxVGAAOaxHyrW4pbZu0K4H
 Nw6iCGydCFG0SYWkoFcvWMmD+yTGdwS5UW7XfbTClqV8CPvH0PQIJEbTicn5iplIp2iG
 NhJA==
X-Gm-Message-State: AOJu0Yxe59ERYxLcfG74uV6XhxQLC+5Y0QxDpCNgXxS90zcOH7JNRKQb
 A81yvAG66TyAV8W9i/OGq1vs4P0WMnA7SqP3liVX4xFaAHbkMEW5tOL31q5PA4TeYIUEf+EjQeK
 /B//grmMqlh0b6cnKn+CA1JDmv+1SIbgd7Up4QOuSgRL1p2bfLR0=
X-Gm-Gg: AR+sD11Q7ZZ0vessaL86PMc08wF5urD0k0Lj/+3u0tPLvBjZ5J64LpKsjDJhUI48b8g
 tkOpxSjtbEPedsBD0npgbl8pB+Gnlbpnl6tTKWH9Qr1Gx0ivdGdZ+ThMjPSr/ISBbwByVLx63kR
 SU5OqL7fBv1drD9JbrpwSarVN+tNnTTOtSqYy6ZViA2zNhT43idbOPCDOyDNIgWWite5/eCMITd
 If557odHqfEUL9xnE+9MqTlpy570DS++0etp3xhFCw2qxNrzA7Gsnyb49DKHb8dbRfIO+Yg7ELk
 360SYihmjEnK8RWfUO0mtYpXPezz8NhV5vh8OIcBiNfVpBORDTUW1A==
X-Received: by 2002:a05:6402:11d0:b0:6a1:b515:c3c1 with SMTP id
 4fb4d7f45d1cf-6a1b515c6a2mr1871703a12.4.1786050450686; Thu, 06 Aug 2026
 14:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-5-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-5-01746157643d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 15:07:18 -0600
X-Gm-Features: AUfX_mxSqmu5WyI1HK0W_sI2RD101JFSsw0TtxXgPAe-wwf-OqGUqcWdG4dde1Q
Message-ID: <CAFLszThOVukHQnE26EWUmwr9kw00s6U6-+g99JfciCeQa1bjrA@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] arm: mach-k3: Add initial am62lx SoC support
To: bb@ti.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786050451; x=1786655251;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BugSYxVm33Br8ClAM3AUmHTlBN0Wo4DDsUuIlbTKmEk=;
 b=hA08S/nC1iLHolFqsMstIak3JJZbEzRvY4SawhE7fxKuc/sVpxXIijeRh3DwomdGUF
 LN1tnkCZ7pBzpdqUnWRqTFeujqP6yXtrCAWoMf80u44exkI1521wJQGZDevXMvHr1AIn
 26bNdOl/vfM6Rr4bbBN8PKrlpXExJNl2bslk0=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hA08S/nC
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Bryan,

On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> arm: mach-k3: Add initial am62lx SoC support
>
> Add initial mach-k3 files needed to support boards based on the AM62L
> family of SoCs

The commit message is very thin for a patch that adds a new SoC
family. Please expand it to describe what the AM62L is (ARM64
Cortex-A53), the boot flow being wired up (SCMI/PSCI selects, SPL
entry, boot-device decoding, ATF reserved region sizing), and why this
SoC gets its own subdirectory rather than reusing am62x. That gives
future readers the context to make sense of the sizeable Kconfig
re-shuffle in the same patch.

>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
>
> arch/arm/mach-k3/Kconfig                       |  17 +-
>  arch/arm/mach-k3/Makefile                      |   2 +
>  arch/arm/mach-k3/am62lx/Kconfig                |  23 ++
>  arch/arm/mach-k3/am62lx/Makefile               |   7 +
>  arch/arm/mach-k3/am62lx/am62l3_fdt.c           |  12 +
>  arch/arm/mach-k3/am62lx/am62l3_init.c          |  58 ++++
>  arch/arm/mach-k3/am62lx/boot.c                 |  83 +++++
>  arch/arm/mach-k3/am62lx/schema.yaml            | 427 +++++++++++++++++++++++++
>  arch/arm/mach-k3/include/mach/am62l_hardware.h |  48 +++
>  arch/arm/mach-k3/include/mach/am62l_spl.h      |  41 +++
>  arch/arm/mach-k3/include/mach/hardware.h       |   4 +
>  arch/arm/mach-k3/include/mach/spl.h            |   4 +
>  include/configs/am62l3_evm.h                   |  14 +
>  13 files changed, 736 insertions(+), 4 deletions(-)

> diff --git a/arch/arm/mach-k3/am62lx/Kconfig b/arch/arm/mach-k3/am62lx/Kconfig
> @@ -0,0 +1,23 @@
> +config TARGET_AM62L3_EVM
> +     bool "TI K3 based AM62L5 EVM"

Typo - AM62L5 should be AM62L3 to match the symbol name and the rest
of the series.

> diff --git a/arch/arm/mach-k3/am62lx/am62l3_init.c b/arch/arm/mach-k3/am62lx/am62l3_init.c
> @@ -0,0 +1,58 @@
> +     case BOOT_DEVICE_MMC:
> +             if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
> +                     return MMCSD_MODE_RAW;
> +     default:
> +             return MMCSD_MODE_FS;
> +     }
> +}
> +

I would expect the fall-through from BOOT_DEVICE_MMC into default to
warn - can you add an explicit fallthrough; ?

Also please drop the trailing blank line at end-of-file.

> diff --git a/arch/arm/mach-k3/am62lx/Makefile b/arch/arm/mach-k3/am62lx/Makefile
> @@ -0,0 +1,7 @@
> +obj-$(CONFIG_OF_SYSTEM_SETUP) += am62l3_fdt.o
> +obj-$(CONFIG_SPL_BUILD) += am62l3_init.o
> +obj-y += boot.o

boot.c only exports get_boot_device(), which is called from
spl_boot_device() in am62l3_init.c - i.e. SPL only. Shouldn't this be
gated on CONFIG_SPL_BUILD as well, rather than obj-y?

> diff --git a/arch/arm/mach-k3/include/mach/am62l_spl.h b/arch/arm/mach-k3/include/mach/am62l_spl.h
> @@ -0,0 +1,41 @@
> +#define BOOT_DEVICE_USB                      0x0A
> +#define BOOT_DEVICE_DFU                      0x0A

Lower-case hex. But just to check - on am62p and am62a these are
distinct values (USB=0x2a, DFU=0x0a). Is the collapse to a single
value correct for the AM62L ROM, or a copy-paste from the aliasing
block below? If it really is one value on this SoC, please add a short
comment saying so, otherwise nothing stops someone adding a 'case
BOOT_DEVICE_USB:' later and hitting a duplicate-case-label build
error.

> +/* Invalid Choices for the AM62Lx */
> +#define BOOT_DEVICE_MMC2_2           0x1F
> +#define BOOT_DEVICE_ETHERNET         0x1F

Same concern for these two - please note explicitly that they exist
only to satisfy references in common code and are not real boot modes
on AM62L.

> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> @@ -81,11 +90,9 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
> -     default 0x43c3f290 if SOC_K3_AM625
> +     default 0x43c3f290 if SOC_K3_AM625 || SOC_K3_AM62L3 || SOC_K3_AM62P5 || SOC_K3_J722S
>       default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
>       default 0x7000f290 if SOC_K3_AM62A7 && ARM64
> -     default 0x43c4f290 if SOC_K3_AM62P5
> -     default 0x43c7f290 if SOC_K3_J722S

This coalescing changes the boot-param table index for AM62P5 (was
0x43c4f290) and J722S (was 0x43c7f290) to 0x43c3f290. That is a
behavioural change for those SoCs, not just an AM62L addition, and it
ideally belongs in a separate, clearly-justified patch - the commit
message should at minimum explain why the old per-SoC addresses were
wrong.

Regards,
Simon
