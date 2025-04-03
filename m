Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D480C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 20:40:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E8F8215B;
	Thu,  3 Apr 2025 22:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XdrDQ2nu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 638C78215D; Thu,  3 Apr 2025 22:40:35 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8F2B82140
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 22:40:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so218186466b.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743712832; x=1744317632; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7wu5KMdgM30kS5Qnl3XuhWyQnQQq7PCQsJCf+yzQXCU=;
 b=XdrDQ2nu48JI8B4G0vmxLokC/rKFwR6yEk8N+aJrUa9f1rOrlkPiKcySrXFg4ecOT7
 357vx8Z07dtyEAV9naw3ZViwoa+LPY8lYArAHLhYgdumt50AhIjel/wAP4+hcN0ZgR4U
 azCdKS9MisOioNZI7sFMKDO/dZ0eI3fy9qqnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712832; x=1744317632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7wu5KMdgM30kS5Qnl3XuhWyQnQQq7PCQsJCf+yzQXCU=;
 b=C1MMVXABBhR4D3DyvZlxwZKO1o9hW8kEG1kLUzVu5wCanVrh3MH708jZ9VuDn66jem
 IV9bNRuz6jceDp0tNcyb84lMbAu30QovNFn3HxHVEzynxAuDT8oqLOFInKjAJxeShIF4
 kbjKUr5addZt31EdpxF7j23ZDo540u4Vuy0XIxRkQUWLAnkSoBQqY8UTov5dqSjBNRwL
 1SeJFPWeTCaKmdaSzUylshikQ9d5fAnH0Nv1Y9gbsdsu8jgDemrEJLNp6/m/WzQ1atW6
 agBLrvk9HjsvsICzKK6DeVbTh9ZCUsFHZwsRxU0poqxp9TB/nxlFKGkfazTli1+QnHBc
 pWEQ==
X-Gm-Message-State: AOJu0Yz2aipxH3ZRfoXb9VOEL7EZOPHDKkE/MHB+daohUGhpy+M64gnS
 MClcoAgg5zqD6MBRvq8s5oxJTdXjSOvSourgkUAPSuVn17wmL5AmckbmKdUCwMTOiWPBLlRPuLF
 MztEbhQhg3oXWwZT5IOFC4zL5fC3cCMfaAXAT
X-Gm-Gg: ASbGnct3AoUBia1aKwzQTpegqaO5vDuho06gNBJ/+9N5d0JtVj804bOEzgU0y8Ay1YU
 C1sPNbCptzuJLCgiOFmhg97S8JZ3UR3xa0EHKUNjtZIE6kbxCnckGLM9uutDmlGRh7oizbJHCtP
 afJ7Pu3msManevqtx7G18TNsinbC8x
X-Google-Smtp-Source: AGHT+IF8RRLlrLfnffxn6NLzRMXig4JxEgUCsdxxccOJzHuj0YycO9Lv+wcg504T287l2+WKRRCCN6JCNDT5a3dPoRY=
X-Received: by 2002:a17:907:7e98:b0:ac2:622f:39c1 with SMTP id
 a640c23a62f3a-ac7d6d06cd9mr7966966b.22.1743712831971; Thu, 03 Apr 2025
 13:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250403175408.2211779-1-sjg@chromium.org>
 <20250403190240.GM5495@bill-the-cat>
In-Reply-To: <20250403190240.GM5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 4 Apr 2025 09:40:18 +1300
X-Gm-Features: AQ5f1JqD28D1IYdRP9eR899bmrIsaPL_fdcmJW3YPXJkjNMIs9mPrt3lFHB6dY4
Message-ID: <CAFLszTg-B7cx73O=TrtUTN2_862mf9Wd2MefqL0cB0PBrtrnjw@mail.gmail.com>
Subject: Re: [PATCH] fdt: Allow OF_HAS_PRIOR_STAGE to be disabled in defconfig
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 =?UTF-8?B?TWFyZWsgTW9qw61r?= <marek.mojik@nic.cz>, 
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>
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

Hi Tom,

On Fri, 4 Apr 2025 at 08:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Apr 04, 2025 at 06:53:49AM +1300, Simon Glass wrote:
>
> > At present it is impossible to change the qemu_arm64 defconfig to
> > obtain a devicetree from the U-Boot build.
> >
> > This is necessary for FIT validation, for example, where the signature
> > node must be compiled into U-Boot.
> >
> > A proposed change to QEMU has been blocked for several years. As a
> > workaround, the only option is to use QEMU's dumpdtb option, merge in
> > the signature node manually and then disable OF_HAS_PRIOR_STAGE
> >
> > Unfortunately the only way to disable OF_HAS_PRIOR_STAGE at present is
> > to hack the Kconfig. So update it to allow use from defconfig. This
> > avoids needing to patch U-Boot to get this working.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Link: https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
>
> How about instead we do something like:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index b7311d3b754b..44e45a304cd0 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1080,7 +1080,7 @@ config ARCH_QEMU
>         imply DM_RNG
>         imply DM_RTC
>         imply RTC_PL031
> -       imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA
> +       imply OF_HAS_PRIOR_STAGE if !QEMU_MANUAL_DTB
>         imply VIDEO
>         imply VIDEO_BOCHS
>         imply SYS_WHITE_ON_BLACK
> diff --git a/board/emulation/common/Kconfig b/board/emulation/common/Kconfig
> index 4c15c8bcb891..9053f2ff2f55 100644
> --- a/board/emulation/common/Kconfig
> +++ b/board/emulation/common/Kconfig
> @@ -13,3 +13,10 @@ config MTDPARTS_NOR1
>         help
>           This define the partition of nor1 used to build mtparts dynamically
>           for the u-boot env stored on nor1.
> +
> +config QEMU_MANUAL_DTB
> +       bool "Manually provide a device tree to QEMU"
> +       depends on ARCH_QEMU # Expand more if needed
> +       help
> +         For some use cases, such as FIT validation of U-Boot itself we need
> +         to override the device tree that QEMU would normally provide to us.
>
> This way we don't start opening asking OF_HAS_PRIOR_STAGE.

Yes that seems fine, thanks. If it ends up becoming a more general
problem we can worry about it then.

Regards,
Simon
