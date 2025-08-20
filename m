Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C16CA0EED
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 06:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89F0080FA1;
	Wed, 20 Aug 2025 08:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eUGiyQQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C9E98211F; Wed, 20 Aug 2025 08:04:25 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2E6E809A5
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 08:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e94fc015d77so137031276.0
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 23:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755669860; x=1756274660; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hahmycRfuF7vCdg+2jMLyfdITJQ5sEQdT757eWim0Zg=;
 b=eUGiyQQ9et2yEt9QIZFEZEP42+Ztx/V3GJerUipXRZFUmo5NUgcKy8ISzvhlpIfAm9
 gQU/5OEznZIjmcB7RBvYN9t+NwL6YtUQ7yg1+Ef44ps48SjiyJ8d66zn87wVqX5d0rxl
 LtEL1s1k24uRGtU5OVQKxQOV2joZVCvcES7HVRifFRx+FC+FFwYAiTWUPRX4ox1k+jhI
 j2zD0+1LFd50GtMlS8uJSbAcnqwhqKPd3h9jPnJJTXKDGnre7x+hYV8cbDpboxOsh00m
 41MnaJ/RhR0c9fMkHb+OELcZd85hF/bOPKtASP9bOFJOyBHZVX0Hbhj0g6zIHFEcfBgd
 Qa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755669860; x=1756274660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hahmycRfuF7vCdg+2jMLyfdITJQ5sEQdT757eWim0Zg=;
 b=BuIuLNU0Ynwk7nsZObm/grtSZTg4Tpb4EwSr+KfYLN/JFqg+tfUI2q7g9yMjPXI6Rq
 4cSMnYuQTKrDcsFbdbGdBFi/JZ4GVy2KW3CM9HdILxKlWQ6N9xPC6lw8W5AC0mBkdswC
 Mcfi1LIndGKJYbhsh1S4IrQE7bpwSFHOn9WsErQZ2en/R460dMwUO3grfOuOv018IXUO
 zflVnmo2emT0PMz5uX7r5NxIkGVdjFQCk/vvhaw9ttJJEBClB4HBeuEqEsMepnDGoauQ
 Xb7KziY+GkdTGsGW9QjBcyrYi3r4ImKxYyMEpWqAVQo61LpQLNCYcJ+i2debVwEj+7T+
 m30A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI+aGqPZe3VpjX9xP+R7M+O7XabaUZno36RDkjGtX8LcpySGff25jwrlvoTxdwommYW/Dfxgc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/uaB+XTTwsTUCxAIj+6WU92yo1SMgM6YbFJen3hjAMmVmn4CY
 7R4i//6iyLkrM0V1CJNWMrFZ0FVPDm0Esy3sHJh+6FPBofN2RFbBhAZrn26bvQUoWFywSfTvKV+
 TXkvpUGO+cjqgYTU27bLWS44TkV7oZ5jj+T9WsG3Mgw==
X-Gm-Gg: ASbGnctF7DLCVvFEg2I0SsJa3oqeQ4oVZbdNBPioidIV2r+tk1NkvQ1NZ+XLbbnRlbK
 BN7e/NpCLv62jEAGvnUv6BRhhe00JRJf//6wb+xEVN5g14RfjD1cxDPNY4RuV0frqWy+I4Lu9ku
 elfx0BOJEDKR763z6FGR2MmpvbPwV3e2TVTWTtj1ZUWwrJJymRphB3cQffVXqnFD0Pv4ZBIlCAG
 kJDKEDoIQS/b0XT5TBpYF91pPv2X1Tit5ItduXx
X-Google-Smtp-Source: AGHT+IH4ZY/afo5ChwgIWqCVTS27dExKlejl/9cmJclkJ09mNGT9583yi0NDxrr9hsekJgMszxjAXJ8nPz1SRfcunl8=
X-Received: by 2002:a05:6902:430c:b0:e94:e1e3:efc8 with SMTP id
 3f1490d57ef6-e94f66b91f8mr1429082276.53.1755669860411; Tue, 19 Aug 2025
 23:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <fffc4713-4f89-4a04-acc6-8b295e453226@siemens.com>
 <b89b50af-e37a-4d7f-b08b-918a1a6839fb@gmx.de>
 <b8dc3f05-8e1b-4c14-b71f-a59f3e8333c5@siemens.com>
 <3988e819-beeb-4269-b798-8f25da437e26@siemens.com>
In-Reply-To: <3988e819-beeb-4269-b798-8f25da437e26@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Aug 2025 09:03:43 +0300
X-Gm-Features: Ac12FXwrbiogNtQxGCqQ_LFtymraSA6Y1uf-JSYTVpNIYKYaGBe5nvgqFTAncTU
Message-ID: <CAC_iWj+a5AA++wyzQCZhXiEAm4fBjLuTo0o6-=bU4-LYr+R0uA@mail.gmail.com>
Subject: Re: [PATCH] efi: Select also CMD_DHCP from EFI_HTTP_BOOT
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Jan, Heinrich

On Wed, 20 Aug 2025 at 08:13, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 20.08.25 07:04, Jan Kiszka wrote:
> > On 19.08.25 16:45, Heinrich Schuchardt wrote:
> >> On 19.08.25 16:33, Jan Kiszka wrote:
> >>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>
> >>> This is needed because distro_efi_read_bootflow_net will then need
> >>> dhcp_run which is not already enabled by CMD_NET.
> >>>
> >>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>> ---
> >>>   lib/efi_loader/Kconfig | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >>> index c2aa88f59fb..a4055e1cb43 100644
> >>> --- a/lib/efi_loader/Kconfig
> >>> +++ b/lib/efi_loader/Kconfig
> >>> @@ -564,6 +564,7 @@ config EFI_HTTP_BOOT
> >>>       bool "EFI HTTP Boot support"
> >>>       depends on NET || NET_LWIP
> >>>       select CMD_NET
> >>> +    select CMD_DHCP
> >>
> >> It would be preferable to get rid of all CMD_* symbols here. They are
> >> just the result of missing separation of CLI and library.
> >>
> >> DHCP is not needed to boot via HTTP. You can manually set up a network
> >> interface.
> >
> > As I wrote, we need it in order to even compile U-Boot.

Was this introduced in commit f8949b1d1d0d4?
The question is should we unconditionally enable dhcp, or just add an
ifdef around the dhcp request.
Unless we have boards with code size issues, I prefer just enabling
DHCP support.

Thanks
/Ilias
> >
> > Should we rather wrap some bits with #if defined(CONFIG_CMD_DHCP)? Then
> > tell me, which ones.
> >
> >>
> >> Please, change your patch to use "implies".
> >
> > That would allow to disable CMD_DHCP again, resulting in a
> > non-compilable configuration.
> >
> > Jan
> >
>
> If we should agree on "select", though, this might be more accurate:
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 54ef7052c5c..2813a39b102 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -605,7 +605,8 @@ config BOOTMETH_EXTLINUX_PXE
>  config BOOTMETH_EFILOADER
>         bool "Bootdev support for EFI boot"
>         depends on EFI_BINARY_EXEC
> -       imply CMD_TFTPBOOT if CMD_NET
> +       select CMD_TFTPBOOT if CMD_NET
> +       select CMD_DHCP if CMD_NET
>         default y
>         help
>           Enables support for EFI boot using bootdevs. This makes the
>
>
> Turned out that CMD_TFTPBOOT has a similar hard dependency and was only
> using imply so far. If you turn it off, the build is broken as well.
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
