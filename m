Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4357FFEA813
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 07:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8599183AAB;
	Wed, 25 Mar 2026 08:00:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h/osidCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4199281E18; Wed, 25 Mar 2026 08:00:36 +0100 (CET)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2200D83AAB
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 08:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64edf260b49so964184d50.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 00:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774422032; cv=none;
 d=google.com; s=arc-20240605;
 b=OhqDMOXCu9lMG13BIT2vIBzObH74qxZluyB4LO7NXJFx/ML/e6Lbxxzhu44xv7YS1V
 onhDkyqzXarX5bYdWgZReeyqXlnyiZjRx1wzasgmpmuKi49e83O5uzjNqwdwxxM2jgfZ
 ufv6zUJ8/yOF78M34MaA5Y5KdObmsscTTHKRwCKjoDuUlDzJgcKFUo1QR+xoqgaRjBSi
 Qvbcb+uO6H/dVnxviN4MwhCobVE0QINjIPrYXl5EQa1Unltt635IWktyf5wVnKHOskd2
 FIObB1DpuEv6iouqqqBJhOajDcGDwWy9ggtR1FuVgKNbyNXLRstWfRIN4aX6luG2RAAA
 UxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=87f32ShnSKgwCzTXdKD/z2Xa4muj4QhrtE2wNIIo7ZU=;
 fh=Bs3bnp6Z3KPQsGemnocq7AI7U8tXCSj4Rr/xfsuStJM=;
 b=gn++nlE6/0QpVr6GRmOJV5euG2UIDi18fqIMYGJ9wdiMXuQ9sdclhEADw7EStYonpm
 dRRKtq44Qr7L8uB/rE456oE94fqVDf1wZcqBSz5QSKyD6/WRW043UdHmUStmePpPbBEx
 lIyMTgiqRl75CWZZaEwY/JGvJrbf6kOoEeNImaJlxMtdX5sAfxAGQgU9RE+zS9XKbO+8
 H0p8EWdI00MzJkYepuPAzMgpnggFIePIQFBMMiUh8VjRYd5KoL+0YOvl1NBaNtgeXyBG
 l8fHAaOoeMLg/eZ5sOazgEmwFFCfij8czEl5cv3BDwpphMl2gyk6to1ThC5kVJfNQrLF
 lAWQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774422032; x=1775026832; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=87f32ShnSKgwCzTXdKD/z2Xa4muj4QhrtE2wNIIo7ZU=;
 b=h/osidClqUFshxnUaU9tJ+uX0H8BrWmZnMLKDeHFqUGUR5KfcFkd8UWPKZWHmrfyfy
 wpmRuglyV5jGST/oTihW4xXuYD2KsRBRhA0w4ssAv7WlCNxIOdWLK7larWEkEOjVFlJj
 tSRtbQ4hRlJziHWCUGHZN/9tXyuFblOaMeoMYR1eP61Kvr32o+U957S97wXx77pL7el/
 48VZKC7igOcesaPCFN0nD0EXGGP/hFoBRf4fRXAt2ffZCRRZ/pl+vvS15bmott2ONOJD
 DbWtXSbhep2NdV+qi1YjuESoOfsgYXnWW7uophM7/xvKAnio7ETnYoP3B5Rtyw9s0lDC
 /E0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774422032; x=1775026832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87f32ShnSKgwCzTXdKD/z2Xa4muj4QhrtE2wNIIo7ZU=;
 b=qT94qpc5/LR+jLaN9HAXcmqZUwzBnvTOp1zJW2ZOh+FzSTWpFAFcqse2i4/s1YDR/P
 SBcOHng+fbymayGNHCbHMUuiKVC4yGSLnWsfcDUA5+zffSAaNLF+L2sjN8JdP9FW9IpJ
 n1+7xwtD+0j8lJHNaa8lKBHnW8fPjmFJHo9PAuuUR2h5yweOEEOvAi8SkEx5j1CEkJ6j
 JnuuVDaXK/Q159/uC1W0ejbLm4/0OtrSIuBaerYmTTMx3KrO4XV/bbnxxv7nnlbklbt0
 bFSfVB9004+mlj7hcwuyEFzJRIJoxJb7Bsm5eyXF3bfqPPqIIrKb2+7U23qIUF4FwUWy
 AanA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh6C1CqgAaaccWL+zJPniXMCkogY6qrdkuEb6wbOL3V5NZEAjZWkl8iEklYIjChVU97qBoFuU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxvw0d+BabuHrjWXNtptyJzB9gEHeEYYJzBAXV1xWkGOeUiW9Jw
 GVie+ooKYL6MJxCHIJHyW0NvbSyahJ10JEGSMFb2AcfyCnKttd+35CLNaLTeFV4xSw4ibZWKLaJ
 YcNEpRZDNsg3Acr91kQR6H2rRyahfMoR4jhrlL3aypQ==
X-Gm-Gg: ATEYQzyKCsXDhtE0+8i//WhtGmyL+jRgXP4gvzqS3+Wls1ibbKjqdVJh73YiyAEEXHo
 3+SEX6kPlSQnGsVvnFWSkijDdZrwVO6ipDglRM0Si3GZ6qrBtGXD7Vy3SPyPl9rEhDNzbJ5dCF1
 Y8LltJkIbhddPkpVVEMBrZNXbBlhCuXpnbssJUA181Q0qEAU7DIJAgVeZyecipJcW1Ig+ZE7ye7
 kGpRvaBWsPnmJ+qP/dpzqOoNPXssX6k0vU9efIanfC24hHz+COS2dGN4cpbJKYnFFKuzPxEDGe6
 qv0Ces7XdGOrIYPoikhVl/lS7g7G3DQfXtA5sjMOQvwjZ94Gvtp/hU+JGgc9BW4h3v47c4YZKR0
 F3ciAmIeptOe5AkX6w+Qnh6U9MKt/fJbaDWlLfOTt/KCjbjv2WoqQuRYuXlN2A+Si83nyjuXcjc
 H80pOXcehLxMTClT66aPHZzIvA5fbcwsQ0CGU5BoRsGJSei8McmXCDT0bPvW0V5OKFmdBeyhFOV
 Cg7Btz9wu230pHJCj5Pv/FjXmlL0nSLGh87supzQkGm0IAaP6MKuqWgntb4qOC5/N7WGPXsYtmS
 aDKhnzSRsua56D14znSYO0Nk6lIWuPMyWd9xxQj7e8Nx
X-Received: by 2002:a05:690e:24d4:b0:64e:dc28:c752 with SMTP id
 956f58d0204a3-64ee5492a04mr1689927d50.23.1774422032196; Wed, 25 Mar 2026
 00:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260324175913.92858-1-aswinm@qti.qualcomm.com>
 <20260324175913.92858-2-aswinm@qti.qualcomm.com>
In-Reply-To: <20260324175913.92858-2-aswinm@qti.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 25 Mar 2026 08:59:55 +0200
X-Gm-Features: AaiRm53bMjGWLadKUC2F1P4AL9BL55orZPNOAtSMJH7NsuI8KBQHjdjC_4o9jkk
Message-ID: <CAC_iWjKvA15bfk-V-LdcigkYwQuEe6LMt1ax0FFFYYVeKs4Ghg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] efi_loader: make EFI_HAVE_RUNTIME_RESET a
 user-selectable option
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, xypron.glpk@gmx.de, 
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com, sjg@chromium.org, 
 mkorpershoek@kernel.org, jan.kiszka@siemens.com, paul.liu@linaro.org, 
 j-humphreys@ti.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

Thanks Ashwin

On Tue, 24 Mar 2026 at 19:59, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>
> Expose EFI_HAVE_RUNTIME_RESET as a proper Kconfig boolean with a prompt
> so platforms can explicitly enable or disable advertising the EFI reset
> runtime service.
>
> The current PSCI-based EFI runtime reset implementation is always
> enabled whenever CONFIG_PSCI_RESET is selected, but it does not support
> passing the additional arguments required for specialized reset modes.
> As a result, reboot requests such as bootloader mode or EDL mode cannot
> be propagated correctly and instead fall back to a normal reboot.
>
> By making EFI_HAVE_RUNTIME_RESET user-configurable, platforms that
> depend on extended PSCI reset can now explicitly disable EFI runtime
> reset handling even when CONFIG_PSCI_RESET is enabled, ensuring
> that the kernel retains full control of advanced reboot paths.
>
> Default behavior for existing platforms remains unchanged.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> ---
>  lib/efi_loader/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 13e44be1d06..31d1c4fc257 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -100,8 +100,7 @@ config EFI_SET_TIME
>           can be used by an EFI application to adjust the real time clock.
>
>  config EFI_HAVE_RUNTIME_RESET
> -       # bool "Reset runtime service is available"
> -       bool
> +       bool "Reset runtime service"
>         default y
>         depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
>                    SANDBOX || SYSRESET_SBI || SYSRESET_X86
> --
> 2.34.1
>
