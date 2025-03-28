Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C78C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 913F48129B;
	Fri, 28 Mar 2025 13:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QEY7xSdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE86D81951; Fri, 28 Mar 2025 13:47:25 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DDC98070C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso1791213276.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 05:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743166040; x=1743770840; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mOQJpjhs8PHxnscfIh+xFlZ+TqlSGt4wWK17TInPyM8=;
 b=QEY7xSdgy3OpBMQRFRTtePFJs5RMo8vIe390EeLIGQPJzkSQHcdSDhS28q1PYypDV9
 VCtKRNUAtNtas1hllcsowunQSx/TSnidkJtI0sqG0ovd1Df3wjVzjJ7LV7ZljX6AUs78
 LxDw6qsspecaqgSCHYg5i5b5t6U9bZWGNRTynsZcA23ZVs31rlo8zLdeQCNbh2Pf6yhz
 6DZ6LU0Vl30OJTUV777+LCHkbtNJOWrQ733clmest5Zd5GmjslP4HaefWz277NyqJw4+
 AB7Pnq9hfqijBnJJklS7B4cugz9P1euqc0hU/13UnqW0regGLWssQNFIKKPFsLthJET0
 NkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743166040; x=1743770840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mOQJpjhs8PHxnscfIh+xFlZ+TqlSGt4wWK17TInPyM8=;
 b=lFtEQVw7KbomoaBwvfLRntq4cU3jGllQjWAzKRVgqIIgWJPQhKk3PlW0RL6ogtstYM
 wYJFe4dcw0yV8yZbbLlSfVHOybN+fj42AfMdP1bbpWa2u1TgECYp9AP1vACKtnuoR41s
 J9+AeRgceEdU2lt6KPF8fxWSghfcSbxoDAy3v90eJKduv6zMKKGo4cVQ1AZxuiCvdafF
 9qjR56NygLv5Ai5Xv14U37/HByy+2IBj6yBfwo53zu62nq5U7diHma8ELqQjyEoJNJyq
 ktXPwLSVea8D5dadxHJmUCCrUh/enQucFTrVHcOuNDS9ktdKQZHB1v4s99iRojxKlvDQ
 zJbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpPhxLtX6+WunuZn5l8dIC1NKFC+CzoidzzOumWgYZIjDlhjwKnh0aZPD+EHaAbuk9hPGAT/s=@lists.denx.de
X-Gm-Message-State: AOJu0Yyh+DFHvrxHBwbV74ANx8HOrMHIA/OGTW3eG3hOA6w2iey1WeX5
 y4GHgTOWJGpiBKz3rzlZwtNt0ilYmmovR2/AiTAJIVj7CPAFNogHsoOubbO7dCSIJ12waeT51Bh
 gIbifi+6hgvEgpaJBGmY4IVvIro95l4T4kDmoLw==
X-Gm-Gg: ASbGncsdLn4fJTuIXpAEFksrVm5vy/gn5UFAj6A2NmRKUaTk1RMGgkm+Sy6zAiZ5Mwp
 TpS0nkYmMcKjcWvf3aMfGbAfzy6sL3/rGWW5KEGIvtZhO0Yt94kuDfW93iwHFV+SZCuriWX6aMF
 3Cl7OmBfwdyNdRA1LXAZJWM57l
X-Google-Smtp-Source: AGHT+IEnygNHIi4vjfvqu9nVtLR3Q1fziW5jL5zEX4/4iXHF53Kyt6iPVzUpfbNk/lTdC3utLqLlypW8tE2eL/A0HRY=
X-Received: by 2002:a25:3ac1:0:b0:e6b:7c8f:5cbd with SMTP id
 3f1490d57ef6-e6b7c8f60e3mr866677276.16.1743166039975; Fri, 28 Mar 2025
 05:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250318115850.464140-2-caleb.connolly@linaro.org>
In-Reply-To: <20250318115850.464140-2-caleb.connolly@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Mar 2025 14:46:43 +0200
X-Gm-Features: AQ5f1JpfyJnPldGemtpbNdkjzcMVs6SDab99HVs0JQ6CuMNb9p36qbHsPt1bR40
Message-ID: <CAC_iWjJuyLonMTNgKV4AswyqBxob-0tThdiXPf2ejQ0JfzYh9g@mail.gmail.com>
Subject: Re: [PATCH] mach-snapdragon: always select SYSRESET_PSCI for
 ARCH_SNAPDRAGON
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Day <me@samcday.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
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

On Tue, 18 Mar 2025 at 14:00, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Since removing reset_cpu() in mach-snapdragon, all Qualcomm platforms
> now depend on CONFIG_SYSRESET and will fail to build without it.
>
> Move the dependency from qcom_defconfig to kconfig so that we use
> SYSRESET for all platforms.
>
> This fixes compilation on the dragonboard410c, 820c, and hmibsc boards.
>
> Fixes: 61a1a1b8ca73 ("mach-snapdragon: use PSCI sysreset driver")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/Kconfig       | 2 ++
>  configs/qcom_defconfig | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index cf08fe63f1e7..32b80da9869a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1116,8 +1116,10 @@ config ARCH_SNAPDRAGON
>         select BOARD_LATE_INIT
>         select OF_BOARD
>         select SAVE_PREV_BL_FDT_ADDR
>         select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
> +       select SYSRESET
> +       select SYSRESET_PSCI
>         imply OF_UPSTREAM
>         imply CMD_DM
>
>  config ARCH_SOCFPGA
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 82bbdc996675..ba4d38d100e0 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -120,10 +120,8 @@ CONFIG_QCOM_COMMAND_DB=y
>  CONFIG_QCOM_RPMH=y
>  CONFIG_SPMI_MSM=y
>  CONFIG_SYSINFO=y
>  CONFIG_SYSINFO_SMBIOS=y
> -CONFIG_SYSRESET=y
> -CONFIG_SYSRESET_PSCI=y
>  CONFIG_SYSRESET_QCOM_PSHOLD=y
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
> --
> 2.48.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
