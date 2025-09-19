Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB859CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 20:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0D0F8309A;
	Fri, 19 Sep 2025 22:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d4NmettB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2EC0832AD; Fri, 19 Sep 2025 22:25:40 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF43081D6A
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 22:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-261682fdfceso40026005ad.1
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 13:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758313536; x=1758918336; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gEN1o8lKv48+wyiYoPTD46cOfrwwGb5WaSX9xfGDYzY=;
 b=d4NmettBOz57NM9rXhSZY/XTaxOd/c8pMwCBos4rsd7MBxJs6QOPhwU20fq/KOngyr
 7BnUSYwLWfkwn3ngQK4eNH0xE1jhmHTBdcYWvqz1EcM++LaA7OAA43318J3sjgpms4/5
 me30kdVB5YONF9uHur4XoFzlp9ONhFeQeU0zZYS9KJHBbpB1rqROTyuJDWg5JWDlJr85
 2o8YGaoZ3+vfb23FsegMBtG36oJn7Y/EgBirLrhkw40qNzOIcpCFsQ/MHv46QKUdTAcY
 FGhtR6erxj4tmDOcUxV94FMiKOr0HexJIbhxdP4fLLOE46AoiKuTuog1YSXHnaAojiyX
 qvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758313536; x=1758918336;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gEN1o8lKv48+wyiYoPTD46cOfrwwGb5WaSX9xfGDYzY=;
 b=fd4M9mzk4/mmd1l1OoYcZMMufzHKFcwbj+ZQ759LMETcUhuc6lAVVSafJufB3aAiAE
 ocFBFOCgQGXOrrlb66cZ2ze9lYdYRzut8iBFu5D7bfpY0OW00b9oWOD1kihFzqY6XCN+
 Fz4wPXEAsgap0Y/+9r3tYq9x5I1hZ4Q5MJjDl6TU7W9wsvc8jK+OHlKvqUla6YyEzJ/8
 MGejJyR2niHtxJknYOfxYpT53cHcQ1SGJg63onfNMrXz86huEPGy4Kgp3tMKxKfrdtMN
 4meR/A+2p8RD/AYqS6/4DPr+n0ZFkrNDOAFKi5OtrWSSuc5HD9oIG8PRyBEWMt/6bQet
 l1UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdP1ya4/CZLxum4dEQHvNFx0m1tBL66Xt6sFjl8zj0d/YxNJGyvqbhaGdBe95wtyWhKVfT6ZE=@lists.denx.de
X-Gm-Message-State: AOJu0YwbtEQFodCqvNEWJRi7GWyxjPIr0B6y5SrvqYGa4yiDS5KPsTaj
 NprexDubbWMV2KmrooO6LpoBso2eyC45Ml8aXz5B5dUaa6NEptCqqlKuYLeKMnJiasDu8SD2kYm
 4rVG0VxJm6H8rXrubQsOwlSkxHrWCpTm8L3a7Bg3QSg==
X-Gm-Gg: ASbGncuZua2rg9XQQI3uesF3TkkyykBmYve63N/IbEwOzQAus8LkOjN7eaD+F1kT1Al
 Ymgs9yGv8PYJnNcT4kimXjqQCWk8AlGuhNjFgiGbPSmWxBpfYwddFkJVrAD00uy1qIf7KgwIkEU
 jfQEn2tQwYEzPfoPwwOny6l5bDGbPIN4TmzFIjApgUIK0oG8/l1BTb8yP79EpJo1Z9UrBrdqbYe
 8Zjsy+Cig==
X-Google-Smtp-Source: AGHT+IHckENcPYLLn1IJVAG2xhZPWPYPR4ZH8TsK+fzS4wNnfPCzOzkJMoXeNjjq/t+lmL6WWPTtiIshhKneLiZ+LMM=
X-Received: by 2002:a17:902:ea12:b0:246:cf6a:f010 with SMTP id
 d9443c01a7336-2697c83c18emr126320355ad.13.1758313536204; Fri, 19 Sep 2025
 13:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250910054012.2055983-1-chalianis1@gmail.com>
In-Reply-To: <20250910054012.2055983-1-chalianis1@gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 19 Sep 2025 16:25:25 -0400
X-Gm-Features: AS18NWAOQh3c8s8T2B8ItlomerIoCNknkB-cdAGIiasWSq2I6BgQ7zCdIkNu7NY
Message-ID: <CAEfUkULT==tq8LVRYf-uS2o-SaVDmwpd3XXC_uKCOeOjof1rsA@mail.gmail.com>
Subject: Re: [PATCH] arm: mach-qemu: add support for boot from TF-A.
To: chalianis1@gmail.com
Cc: trini@konsulko.com, patrick.rudolph@9elements.com, u-boot@lists.denx.de
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

Hi,

On Wed, 10 Sept 2025 at 04:19, <chalianis1@gmail.com> wrote:
>
> From: Chali Anis <chalianis1@gmail.com>
>
> add support for boot from Arm Trusted Firmware for qemu aarch64
> permits to exprement TF-A boot, Tested on qemu-system-aarch64.
>
> Signed-off-by: Chali Anis <chalianis1@gmail.com>
> ---
>  arch/arm/mach-qemu/Kconfig             | 1 +
>  board/emulation/common/qemu_mtdparts.c | 2 ++
>  2 files changed, 3 insertions(+)
>
The change to skip NOR flash partition setup under TFABOOT looks
reasonable, since in TF-A boot flow the storage layout should be
handled via FIP/TF-A.
But the commit message is a bit too vague, is it the final change and
qemu_arm64 is now sufficient to declare ARCH_SUPPORT_TFABOOT?
If yes, please state it in the commit message.
And please also explicitly describe what the patch did, like "skip NOR
flash partition setup for boot from TF-A".

Regards,
Raymond

> diff --git a/arch/arm/mach-qemu/Kconfig b/arch/arm/mach-qemu/Kconfig
> index 9c06c6a3a5ce..316dde5145c0 100644
> --- a/arch/arm/mach-qemu/Kconfig
> +++ b/arch/arm/mach-qemu/Kconfig
> @@ -18,6 +18,7 @@ config TARGET_QEMU_ARM_64BIT
>         bool "ARMv8, 64bit"
>         select ARM64
>         select BOARD_LATE_INIT
> +       select ARCH_SUPPORT_TFABOOT
>
>  config TARGET_QEMU_ARM_SBSA
>         bool "SBSA Reference"
> diff --git a/board/emulation/common/qemu_mtdparts.c b/board/emulation/common/qemu_mtdparts.c
> index c1501276789c..c3863d3b0479 100644
> --- a/board/emulation/common/qemu_mtdparts.c
> +++ b/board/emulation/common/qemu_mtdparts.c
> @@ -59,6 +59,7 @@ void board_mtdparts_default(const char **mtdids, const char **mtdparts)
>                         debug("mtd device = %s\n", dev->name);
>                 }
>
> +#ifndef CONFIG_TFABOOT
>                 mtd = get_mtd_device_nm("nor0");
>                 if (!IS_ERR_OR_NULL(mtd)) {
>                         mtd_partition = CONFIG_MTDPARTS_NOR0;
> @@ -72,6 +73,7 @@ void board_mtdparts_default(const char **mtdids, const char **mtdparts)
>                         board_get_mtdparts("nor1", mtd_partition, ids, parts);
>                         put_mtd_device(mtd);
>                 }
> +#endif
>         }
>
>         mtd_initialized = true;
> --
> 2.34.1
>
