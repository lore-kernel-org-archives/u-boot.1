Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D29EA719F
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 04:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D5A83FF5;
	Mon, 20 Apr 2026 06:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CYAYhCTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6B168419E; Mon, 20 Apr 2026 06:32:25 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4DA283B99
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so472659266b.3
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 21:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776659543; cv=none;
 d=google.com; s=arc-20240605;
 b=JitRbPiCERGASnyEQO1B+6bRWZiIN+QDP7VRzUdEigK5xL6aLbrehT0VOzF9SeeixT
 kwHGPKybLu9jP5+7/7tMhd29C2qyWma+5q04QC6GXJg5pwuTgulwQbGPIND/xZeHNQGS
 SHnShMSBue3WDrlMkvjMZT8iD8kCiwDvdYfqghrGCyT+NDePzBApX9Gaq2w0qh83Rocb
 zwyMvA1IUmmoigdyJ7kamSit+8r50Lmn7bEGlS292gmGhGW/+2uQ8Ag/w7OT4YVjBKRI
 eVF51z+QMPocssgkcK34WLQm51F+PPgs9pl5Mq3G3kceVy08HZwdYOB22iZHwf0dNh6P
 DaSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ksfLnAvlQE3IafLgHzn9DaWAQpft/Zi0vinjfcscrMM=;
 fh=23XXZvS0T0zHDBT90uSA9CIN0i4lw5UrnU6YbHHSbsc=;
 b=RqxES4eWPBXNad3JGsHQ5l6RzYz+u0S7l0amioZLy4UT+jzn+Qv7FkWcWsIvB5m9+d
 UMhblgiZtHEasNbBu+12DX04S432Ao164/3ajVhanoO7oZYVghsQ0Fb7ZWwfiW+Jcsgh
 xT/KzNQeJR6beci1JyrLk+vUUFx+IUIEmMb1NDjs86ksbniHzFFy8CAEhe4YAkODgcUF
 HDaMb0DRmFDilFx1+Zvi4D5GuSymJEKO5407ptjknZL6tB03ygrgsqTJ1paMZftgcBA3
 eI8yd4PdU+4a3rihO62iDdjn6yztShQF266K3lkJ6tW0FXkVsWYh5Y4uhAD4N41EMCf4
 ZO+w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776659543; x=1777264343; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ksfLnAvlQE3IafLgHzn9DaWAQpft/Zi0vinjfcscrMM=;
 b=CYAYhCTtGXtExv7RlcfxKucEHWHPZphwgbmn1R0Af+um/IQrSkZHzIQju3NF7CVG84
 S4ihGnH1SkDFz/TSBk75Qgc6MLQ9tvmhSMGzaVzNESXNDW5zaKSFjvL7jfkG/pdOOEdu
 Idsjerei7tX/3l6GcJwU3EadShDWQLB9zRGvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776659543; x=1777264343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksfLnAvlQE3IafLgHzn9DaWAQpft/Zi0vinjfcscrMM=;
 b=QqNqLDWxeSa0knSFmM78qcroPiigvchR91UR4AECjAcPTTmlhHHgVCeYqByceQJEOt
 rS6KmOHKHSF+uEYbn0fnRhcZc6jnCbNiRd8Ck6oLDAtfEohP3+Rtb1BQijnW6bigjVoR
 SJ6t4vkfaWTum43GuLDh4uKycP1MniHx41i5sD3XHrTqa7MUC/6YCC/yg4ADl8yh6q1W
 z0dVga8pzV8do1aZ4tYXLNXWcbg0u/o6dRISKR9VXEPerqGA/Vp+s6dR6R7OYa/Fkkmb
 h6ihdQS+6qXUSj15bp4l0MzRDk5MUgN1FeKM6B08bu6ZFxX06aYk+S6+cRA2SXiv/7pT
 ljOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VxzOgdUDDLCWLKi5nwyHqWT+OCs1KOY5KGMQt351DsHsu2HodgktBacHiNwHaqLAzVRmZkYg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxvc8kNsrC+yu4K60grZxyd85/ZW2CvybDhOAUtQzTc4gKo7AvP
 RCY3sFSGgDLzaCSqPOpMFr+k0E1auup3ZM/LRjC9NEEhWIFWHdZOjgHsqdIdn0VN9WoPoX3SXw9
 LwvLQSQ9M6NCyVlmd9PlBOt0KTOZaF7bReQl8FFcjJGDZ30zrMQRvHg==
X-Gm-Gg: AeBDieuztT0b2VqLE85VH+hZnTRkV85NKYMx2Y3DJvC7bUbsf3uvF8R55/KJr91aXu1
 z6S0KYbbgcH17NOc4EzHmhWUQEwGGWGEKHr/S5kD1mEBWHTj1QwSWdM73prNu3iY6t3VJzOdZKO
 OUI2rqUe/wUWf8U1rPNyg1i38hndF8siRxYfYsjU9J86Jn3OCYIJ+qRXDSgcfmUtsbXvXm0sYg/
 C9hiSRRX+Vi11EfWyZYyJ6G1Wvmq2c1mdinJRnUvgUAT+4CesUklBxb3hlK6r7bmy1M8oLzDsQf
 e0vzbV3dV6k2wAP/Cn4w
X-Received: by 2002:a17:906:f58e:b0:b9e:8e4:8765 with SMTP id
 a640c23a62f3a-ba41bacfcefmr521982366b.10.1776659543039; Sun, 19 Apr 2026
 21:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260419173829.1074404-1-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260419173829.1074404-1-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 16:32:10 +1200
X-Gm-Features: AQROBzDY59pCEWUrP8PCT3Pxm1C34OT88gwFPvGdhL8gX7-nbBgkXru1TrxM41E
Message-ID: <CAFLszTiX4nRi_5LFMNmUem_Yo1HiJxD6btU_43JnfjhOvNMx8A@mail.gmail.com>
Subject: Re: [PATCH v1] mach-snapdragon: Add KVM hypervisor support
To: aswin.murugan@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, sughosh.ganu@arm.com, gchan9527@gmail.com, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On 2026-04-19T17:38:29, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:
> mach-snapdragon: Add KVM hypervisor support
>
> Enable Linux KVM virtualization on Snapdragon SoCs.
>
> Introduce CONFIG_QCOM_KVM_SUPPORT to select KVM or Gunyah
> hypervisor modes at build time.
>
> qcom-priv.h:
>  - Add TrustZone SMC interface definitions and parameter IDs
>  - Define hypervisor boot types (GUNYAH=0, KVM=1)
>  - Add TCR_EL2 bit field definitions for memory config
>
> board.c:
>  - Add qcom_configure_kvm_hypervisor() with EL-aware logic
>  - EL2: Perform direct SMC call for hypervisor setup
>  - EL1: Save context, disable caches, run SMC, restore state,
>    reconfigure TCR_EL2, re-enable caches
>  - Add qcom_configure_gunyah_hypervisor() for standard flow
>  - Add SCM service availability checks
>
> [...]
>
> arch/arm/mach-snapdragon/Kconfig     |   7 ++
>  arch/arm/mach-snapdragon/board.c     | 154 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-snapdragon/qcom-priv.h |  31 +++++++
>  3 files changed, 192 insertions(+)

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> @@ -510,6 +510,154 @@ void __weak qcom_late_init(void)
> +     log_debug("At EL1, saving register context\n");
> +
> +     u64 ttbr0_el1, tcr_el1, tcr_el2, mair_el1;
> +     u64 t0sz, phys_addr_size;

Please can you move these declarations to the top of the function
alongside res and current_el.

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> @@ -510,6 +510,154 @@ void __weak qcom_late_init(void)
> +     if (current_el != 2) {
> +             log_debug("No EL2 transition, skipping TCR_EL2 config\n");
> +             icache_enable();
> +             dcache_enable();
> +             log_warning("KVM hypervisor configuration failed\n");
> +             return 0;
> +     }

This logs a warning saying configuration failed but returns 0
(success). If the EL2 transition truly failed, shouldn't it an error?
If it is intentionally a soft failure, the log message should clarify
why.

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> @@ -510,6 +510,154 @@ void __weak qcom_late_init(void)
> +     arm_smccc_smc(TZ_INFO_IS_SVC_AVAILABLE_ID,
> +                   TZ_INFO_IS_SVC_AVAILABLE_ID_PARAM_ID,
> +                   TZ_CONFIGURE_MILESTONE_SERVICE_ID,
> +                   0, 0, 0, 0, 0, &res);
> +
> +     if (res.a0 != 0)
> +             log_debug("KVM milestone service not available (0x%lx)\n", res.a0);

Just to check: if the service is not available, should the function
continue anyway? In qcom_configure_gunyah_hypervisor() you return
early when the service check fails, but here you continue regardless.
A brief comment explaining why would help.

> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -17,6 +17,37 @@ extern enum qcom_boot_source qcom_boot_source;
> +/* TCR_EL2 bit field definitions */
> +#define TCR_T0SZ_MASK                                0x1FUL
> +#define TCR_PS_MASK                          (0x7UL << 32)
> +#define TCR_PS_SHIFT                         16
> +#define TCR_SH_ORGN_IRGN_MASK                        0x3F00UL
> +#define TCR_SH_INNER_SHAREABLE                       (3UL << 12)
> +#define TCR_ORGN_WRITE_BACK_ALLOC            BIT(10)
> +#define TCR_IRGN_WRITE_BACK_ALLOC            BIT(8)

arch/arm/include/asm/armv8/mmu.h already defines TCR_IRGN_WBWA,
TCR_ORGN_WBWA, and TCR_SHARED_INNER with the same values. Please can
you reuse those existing definitions rather than duplicating them
here.

Regards,
Simon
