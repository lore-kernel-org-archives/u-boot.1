Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A5CEDF148
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E295D80FA1;
	Fri, 13 Feb 2026 12:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N1hGptZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 164F183015; Fri, 13 Feb 2026 12:26:31 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC77380B98
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-79088484065so8378707b3.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:26:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770981987; cv=none;
 d=google.com; s=arc-20240605;
 b=FEN+beiPpCUvuZBCh1kH8FwLrvN3JezKVfF9mtyBEkiHstzvTCYWi9++3Jl5YyHpwP
 rP3/SBwwgi95UxRUnoMZX0oXVdwtJ0Bkm0a9+o81EOkja2hfokeQTiP9h/st3l6L5eJv
 CGtoSwp04/e4IbktlEleljNf3ruZo8kE2g5Ig2LsVd0N/KIo/mZIz/2pciPEhr+LgGBj
 NCRO7PiY4YKDkZbjmsEdvagassdOcL0lbiygWMkGWSQx77hMELI153ttyn3nmb1okhY3
 WCFU5R4SOqBurHZxLlnrSI6MbkYAae2PLG46BPMZ8V8ZgzFz4YVAbCvnk8DflM50Mjhn
 A3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0r3/iP1HV1cZ64fplVlvfqfAlOH1LZ5tmmepRu7iyW0=;
 fh=DhEiqiGIkoJvFaHFSgdtXxl4bDyiAcW9Hu4vuZPB8SY=;
 b=F+ZkQj4zjm0YsrIaeaamH5WrXZTvFbxwXa9sxUpdFgREta/49qm3OsxmJXIqxwbJga
 O3itoinNy7PIGg9BGjuWfiD3xo1Sv7pF/x2pQrP4+rMH+kqbMYGL8GGxzmmIOU9ot9xI
 cAvFbv3gbA/guVkPsRNE770xaf8eTFLhPF4lfNeh9AbkALT8UrM0u9FGxFbXBWpH7BMO
 vNRvKXaK8HM7PvkFzRfr9TnMWsS/+sOancGg7EG0bjc0pzqI35Iyj9FDd+0EZ7owWrm2
 eYgk3cM1QKPQkIrYo+FoZ+Awvxyg/x5+pIa20k7yR4xmMUQhKSeLL6RvNWj7zBxBTjAc
 PJSg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770981987; x=1771586787; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0r3/iP1HV1cZ64fplVlvfqfAlOH1LZ5tmmepRu7iyW0=;
 b=N1hGptZJcXArkLmW8cvs4jK9JbD+iHzSe8rJ+QDq1erup02KQ3hWfWe+3m2aPdXmWh
 h6s/kFtpM93rWhnAA0kHBkK1zUC5ga7zhifqcfsXHSFxPBN9DT5lXIxmX+CaJ3ZWFlpR
 pMmmcadRwG5y7XKarkdopCdBmm2fbENPtT8ltiRyrSSCGfKFvO92sgnX2O1z2wuEqVTa
 ShtxZeMMTmYni2fZk1yqt9Qtz1CV7bv2+531X/pVZ+a64jrl4hk0Qa9hGFnPlLIHI3Ie
 P+S8c2OD+wq3NDiX61kjK7TjcEHQXM70275xjIxRMQC13SquZuV8GdHpeLUn2rbVJYQO
 N/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770981987; x=1771586787;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0r3/iP1HV1cZ64fplVlvfqfAlOH1LZ5tmmepRu7iyW0=;
 b=pK3QE62C8L6BDkB4lGJO3pkZuD6yL9DSZSG350jJkGvaTO8FJznv+H/UO7+rlJhlKR
 uaFpuOcBQ1Yw66rS7qw0EcLNqZqwsFABWH6sov57lTDieRErN11Uq0p7Hl74hGVwGueN
 xOLs6fFq/IyYacqdnfNQLXRB4Mn6EygboyO9bz9Scg6BO9s9r0n2whr9cemggozUTKD8
 R10HjL4AHBWlipFKS78uGQ7KMF6zmsT0H8nKL4tn8kLwLJ7xSJtHY6+OFEaEVRkTXdAN
 IW2O3tSUtt7CT8BOZcuOD42liGzbqlgLaGN1+AkSKEIVSI0kZoQzbRSsIUNQDAqIkgQB
 8sYA==
X-Gm-Message-State: AOJu0YwvYYo5bntHcG5+TLic3gV6cGlS4qfG+t4FkygsyKFOuKAwf48n
 4ODw6N+e8mLuTKe/MBloHXVeadueZh6D87uEEV+oFu06Ig/4D2XMmB70hDOCOh8bKuBFy/jpJei
 80TaeHCM6LI1gr2OawPjoWckS2AoYtdimKw8VFy77Hw==
X-Gm-Gg: AZuq6aJ3ST+srjCWNubZ8/NS46IdsM5wXkHxUqhJkwZq/xCitEivjI9W/69ASGHtJzu
 nl+QSnEQWKokFPI6zWXyxqkP7RhFxhq5EQVpD50ud+5sK0DaIR0t536T3yw6CNS19kwIHz19syj
 bNi1WiOigRzsFlXzJN/GXK70uY8LGvvkyrBZGMKpyItHfsnfLdCkt8rldNqtmlpL6P1+opeePEs
 ivtX5Dognf66EgU740j/hiBYGT7iHa4w2jrdt8WN47P7/q2X36x23aF0QY7Nkx04SRmQfBCeWb/
 wQbpzxu3qp2gsgc+i+ObQPz66W7VviP6tTtPidvFkd+qssRgXWePG5KvRKVKb5h8IaZtdNpowm9
 vUpCVL14hxb18hiEinjus4JWb2/MvPUGlwqtI1F+BYh3BziQCyuBAmjBLoPEWHopv3+JVKT9ADM
 qGRVSwKIi3F/3TBwpHIMhSMFRrY6JLrj+Dvmcbi+ICoVtSUXWEKM5470Yq1pLp/9x86c1RLSxkw
 AuYf1VabN5FyOmd+JJk18tIq/JE4or/+Ot3HGUK3vOEOtdwEj+/OlW+ulebrvLAyH6G9llwF9ce
 cAlg5ev8fn8ThQMVA/py+N+C52FoaI2cjZCexp4WOv8ZvFwQQLeM1GzU
X-Received: by 2002:a05:690c:6813:b0:796:6df5:4840 with SMTP id
 00721157ae682-797a0cdfab8mr21627617b3.59.1770981986536; Fri, 13 Feb 2026
 03:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20260213110527.1254098-1-aswin.murugan@oss.qualcomm.com>
 <20260213110527.1254098-2-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260213110527.1254098-2-aswin.murugan@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Feb 2026 13:25:50 +0200
X-Gm-Features: AZwV_QijjfyqlFtwc1yXxS2NHKwsgW4lifg6m51i86jI-TqI_T5M1C-5xAQpbFQ
Message-ID: <CAC_iWjKzr_nYSJft_HbkHB+F5UKiPBr3sdEZ5vc=gTT-p+WFMA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] firmware: psci: Refactor EFI runtime PSCI reset
 handling
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org, 
 u-boot-qcom@groups.io, trini@konsulko.com, xypron.glpk@gmx.de, 
 sjg@chromium.org, michal.simek@amd.com, gabriel.dalimonte@gmail.com, 
 jan.kiszka@siemens.com, paul.liu@linaro.org, j-humphreys@ti.com, 
 neil.armstrong@linaro.org, me@samcday.com, marek.vasut+renesas@mailbox.org
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

Hi Ashwin

On Fri, 13 Feb 2026 at 13:06, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> The current PSCI-based EFI runtime reset implementation is always enabled
> when CONFIG_PSCI_RESET is set, but it does not support the extra arguments
> required for specialized reset modes. As a result, reboot requests such as
> bootloader mode or EDL mode are ignored and fall back to a normal reboot.
>
> Add CONFIG_EFI_PSCI_RESET_RUNTIME to give platforms explicit control over

Is there anything missing and you can't use EFI_HAVE_RUNTIME_RESET?

> the PSCI-specific EFI runtime reset path. This allows a platform to disable
> U-Boot's PSCI reset handler when needed so that the kernel can perform the
> reset with the correct arguments for special reboot modes.
>
> The option defaults to enabled to maintain backward compatibility with the
> existing behavior.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v3:
> - Commit message has been updated, no change in code
>
> Changes in v2:
> - As per review comments made default y for EFI_PSCI_RESET_RUNTIME config
> ---
>  drivers/firmware/psci.c | 4 ++--
>  lib/efi_loader/Kconfig  | 8 ++++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 2e3223e1c32..009c6153d0c 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -244,7 +244,7 @@ static void __maybe_unused do_psci_probe(void)
>         uclass_get_device_by_name(UCLASS_FIRMWARE, DRIVER_NAME, &dev);
>  }
>
> -#if IS_ENABLED(CONFIG_EFI_LOADER) && IS_ENABLED(CONFIG_PSCI_RESET)
> +#if IS_ENABLED(CONFIG_EFI_PSCI_RESET_RUNTIME)
>  efi_status_t efi_reset_system_init(void)
>  {
>         do_psci_probe();
> @@ -266,7 +266,7 @@ void __efi_runtime EFIAPI efi_reset_system(enum efi_reset_type reset_type,
>         while (1)
>                 ;
>  }
> -#endif /* IS_ENABLED(CONFIG_EFI_LOADER) && IS_ENABLED(CONFIG_PSCI_RESET) */
> +#endif /* IS_ENABLED(CONFIG_EFI_PSCI_RESET_RUNTIME) */

You also have to adjust the RT config table in
lib/efi_loader/efi_runtime.c, but I really think we should reuse
EFI_HAVE_RUNTIME_RESET


Cheers
/Ilias
>
>  #ifdef CONFIG_PSCI_RESET
>  void reset_misc(void)
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 13e44be1d06..3882de273bb 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -106,6 +106,14 @@ config EFI_HAVE_RUNTIME_RESET
>         depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
>                    SANDBOX || SYSRESET_SBI || SYSRESET_X86
>
> +config EFI_PSCI_RESET_RUNTIME
> +       bool "EFI Runtime PSCI Reset Support"
> +       default y if EFI_LOADER && PSCI_RESET
> +       depends on ARM_PSCI_FW
> +       help
> +         Enable PSCI-based reset implementation for EFI runtime services.
> +         This allows the OS to reset the system through EFI runtime calls.
> +
>  endmenu
>
>  menu "UEFI Variables"
> --
> 2.34.1
>
