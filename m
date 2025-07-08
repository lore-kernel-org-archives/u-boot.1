Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FBCC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 07:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5359383189;
	Tue,  8 Jul 2025 09:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d6dQNRx9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD9A08319F; Tue,  8 Jul 2025 09:36:51 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAE5C83145
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 09:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-714078015edso34826637b3.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 00:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751960208; x=1752565008; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kMQRPEBGXhoLUruV+045q86yuTPtaEMg3cGupLBLcTs=;
 b=d6dQNRx9ET+qCBPqj1e/uMLD3VUv3lrVDaOe78FZKicV7xfFWL0j3U8EhPSVXpRDQ3
 KLKyqXUP70OILpjWWBspYyP+hNjfw0FHtEzjEvZwfVQMvJkTMaQToKvq9cWYx7hVp3Cm
 o3QNnIVM0NyOw4CQEaSoiTqqznN9g87qTm5qqvaucibybyxQEi046PnYfLxW2UV9bB/b
 i0//vl5s+bbpgvhtyow4fXUxaZyQ17XC1DX+BVD4v+vqhpI34Mx8cpvFnVeauWC0tUtC
 /PK2ec3UfJ6eQS0g5hw7i6nIy0LV1u1i1jlG0V+o6pFpN9qmZyjtpFBVOjTBurTeCqoy
 QFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751960208; x=1752565008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kMQRPEBGXhoLUruV+045q86yuTPtaEMg3cGupLBLcTs=;
 b=pVxngfJIL++93YtStT99OykBICE9hv2vfrgDr/hSkl01xy5PZ32GDs0sTDmQPdW8vU
 OcsEeriIBulLMjWqKFc4NXhhG+m6SYpwJt2i2XTvyFWHdkMh702XURweaps3rI1nrKGJ
 RTIWizwGu9JUzXFrfSG41m+gbpvz1SbJpg6mphgHYu2EiCqNU2t+aiAzaCyVwAAqzvWb
 FwVW7QV7Rx7n0qHx4EMRCRWPXTgvW5zX/9O3w+2u9IsegfWIyIFcQoJHkYNwqQ9hRTLS
 Q3LtwTpjH+oC68s5JHky8KZoNecnFD/ZPOU5fHp9u101ztGvBSD1gvc7dNwlaEleApOE
 VonA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIJ6N/vbcwD3Npj/YS2EZLTDOnKzIPovw7aAXe2SWWVpQERZXebT5l2jB1pJX5T1hAFP9s+eo=@lists.denx.de
X-Gm-Message-State: AOJu0YwU+xOTgdbzz4zZsMc6GM15GPsvP31dMbylsVP7czS2cH6SxIha
 q028X4VAT2tQtyudpZUdYP1QfhLEUUnrEvHqCvtCrbwM1ID13A0VxBt4IMV9UtLXh2G4b1TOOef
 es34fwPQtGPZoiTT/TaezMUEEGORf1Kpk/AgkoBPGCw==
X-Gm-Gg: ASbGncvjLaDkk/6s1IDM7NuiLwMt+16lBK8plQYfmoU9J7jCOtejRDMWPMEcftVIXfA
 Q/6yabYkg9MLjOyP1HjTQW6AD28nj8fZM6duf5PjAqXW0LFRBxjNAlTSM/cmRJzwRCKu3tYlIPu
 43ehJSMETOz2bZvVU9T/8cACwBc5LXrdfOb0qgRnMg8eA=
X-Google-Smtp-Source: AGHT+IFaX2tai5zzvJb3lk8D62kM9s+TtXAIj/V+xntrnkc8cbHevYDZ2RTzeHoJk39XjaM9ZNltxpMMAUQ59x+Wp/o=
X-Received: by 2002:a05:690c:6f82:b0:70d:ed5d:b4dd with SMTP id
 00721157ae682-7166b699231mr193340087b3.25.1751960208579; Tue, 08 Jul 2025
 00:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250707095322.30222-1-paulliu@debian.org>
 <20250707095322.30222-2-paulliu@debian.org>
 <8AF80705-BB09-4AAD-8604-3D967295AB30@gmx.de>
In-Reply-To: <8AF80705-BB09-4AAD-8604-3D967295AB30@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Jul 2025 10:36:12 +0300
X-Gm-Features: Ac12FXwJCo0_cJtB100Gq9U8rVOIrIV2ab7FzaU122GfyoAi53DfnrL2Hf4xv38
Message-ID: <CAC_iWjLL2jZ6m6FWFSyiWdr+BExuj7rEJ7CMLQ5CDbDgpJKYew@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi: turn on EFI_DEBUG_SUPPORT for qemu arm and arm64
 target
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
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

Hi Heinrich

On Tue, 8 Jul 2025 at 06:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 7. Juli 2025 11:53:22 MESZ schrieb "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>:
> >Previously, EFI_DEBUG_SUPPORT was enabled across all platforms for
> >CI build testing. With this commit, we are limiting its activation
> >to qemu_arm64_defconfig and qemu_arm_defconfig only, which is
> >sufficient for our current needs.
>
> Was there a request to turn it off on other platforms?

I asked Paul to send this, because it grows the binary size a bit.
Since it a debug protocol, I thought we could only enable it for QEMU
to test it.
If you want that on for risc-v we can turn it on for QEMU as well?

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
>
> >
> >Signed-off-by: Ying-Chun Liu (PaulLiu) <paulliu@debian.org>
> >Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >Cc: Tom Rini <trini@konsulko.com>
> >---
> > configs/qemu_arm64_defconfig | 1 +
> > configs/qemu_arm_defconfig   | 1 +
> > lib/efi_loader/Kconfig       | 1 -
> > 3 files changed, 2 insertions(+), 1 deletion(-)
> >
> >diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> >index 39afb837e41..54bf4646382 100644
> >--- a/configs/qemu_arm64_defconfig
> >+++ b/configs/qemu_arm64_defconfig
> >@@ -15,6 +15,7 @@ CONFIG_ENV_ADDR=0x4000000
> > CONFIG_PCI=y
> > CONFIG_DEBUG_UART=y
> > CONFIG_AHCI=y
> >+CONFIG_EFI_DEBUG_SUPPORT=y
> > CONFIG_EFI_HTTP_BOOT=y
> > CONFIG_FIT=y
> > CONFIG_FIT_SIGNATURE=y
> >diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
> >index 92ba48f6af9..b1c277a86c0 100644
> >--- a/configs/qemu_arm_defconfig
> >+++ b/configs/qemu_arm_defconfig
> >@@ -18,6 +18,7 @@ CONFIG_ENV_ADDR=0x4000000
> > CONFIG_PCI=y
> > CONFIG_DEBUG_UART=y
> > CONFIG_AHCI=y
> >+CONFIG_EFI_DEBUG_SUPPORT=y
> > CONFIG_FIT=y
> > CONFIG_FIT_SIGNATURE=y
> > CONFIG_FIT_VERBOSE=y
> >diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >index 077466f01f0..fdabe9cc278 100644
> >--- a/lib/efi_loader/Kconfig
> >+++ b/lib/efi_loader/Kconfig
> >@@ -73,7 +73,6 @@ config EFI_SIGNATURE_SUPPORT
> >
> > config EFI_DEBUG_SUPPORT
> >       bool "EFI Debug Support"
> >-      default y if !HAS_BOARD_SIZE_LIMIT
> >       help
> >         Select this option if you want to setup the EFI Debug Support
> >         Table and the EFI_SYSTEM_TABLE_POINTER which is used by the debug
>
