Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8D0C83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 09:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D6238318E;
	Tue,  8 Jul 2025 11:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LilXTq/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4868319F; Tue,  8 Jul 2025 11:58:16 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73073830B4
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 11:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-70e767ce72eso37738697b3.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751968693; x=1752573493; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A97eTBnRVWsV3OY6Ylnqce4MwsYMqilCDXZv4zBvndg=;
 b=LilXTq/sMvTCB747oseQiXU8xCpwcUUr/a9j8nGB5aRjQCZ8fq5VZVt0PsNiQSmpjE
 D0GF76ugOUodgpePxl0ACf/CY2oXiEkKpgN1vH27SV6TGmrEzqu3ekEvTviFalVrPvmD
 ZDypTObjTbtLRWWMxfOi1z5A2+THppxhC6Gs+5J+KE58jSKDV4acZAAIOs0PuEZfnzsB
 23mGkb5O+Kj9iK5ZUqf7bFGEYYbt0VBSdiV4Fg8h5nS4iBCEKe4tlzEd5Sd1HCl2KaVc
 6d+45o2l+ODQ3AS6DaEV9nh4tR398kEwRhil4J8D8XdGoE+0FmsJ/CkllvnNPkngedMI
 gOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751968693; x=1752573493;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A97eTBnRVWsV3OY6Ylnqce4MwsYMqilCDXZv4zBvndg=;
 b=ZtpHPvnXT50V6HTGQsw0oXRuLxZYTLgWpXqmVk96JAvQfc2IBBVaRWKMujwA3h0k6i
 q7MsyIbT/fDqixgJ7Ah+pPJzZNIyJ/hKv/KJSf/B64qTUmYHtgUc+5nFgqXAqyjGUoUd
 qaZKgPEaHpbfAgU3KZLc/VY+tRYkeVlSBCdWvPkCF1VGalL39C6bbZ8rMyNBI7/n0Z23
 Eus+znRLfdKPmPD9/tUz3Pxtubdhplp1VwYUGn4JAtD02nUpXDzV+2nkT8G2evVEwbLi
 CteN6vy0+NqwzRpRAyCE/Pc+Y1E7mFbFiQcsIVLe2K5vbg+xKQt1QeJUY7GAa2hnA8pz
 U9jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoLvRYkiwJJCF86H6EFgzRd3+Qfu8UT68BYD0lHGjPsysfhbhdlRHbMf7sWDTng2UVvcsPvMM=@lists.denx.de
X-Gm-Message-State: AOJu0YwyjVAIaFcWi9CvFtZbKIkSQVaZtK+HbObtuDX6/7E4cSzciCda
 NXPtGcKuLNz6m8gWbtCAyljjS7VlY+GbQ+bzPeuQb24qHc5lq+hqGHKKI/L0BOkuJfr6AKW/bMk
 ttOX/v6BQUpttSALw+VHILkVs/lgnwcUxgjj2ki3Anw==
X-Gm-Gg: ASbGncteBPL7WFKKgw3WknJVeMj5qmcLlaVyf9jkr1RChfa813LzMuf5Ar3cEgJv4d/
 RSarfpmpOJAEle4SSC0RcTS7VQIfQg05rs4dWZ8lNlPRKy6RpGQFPvyS3rJcGnbI/U+RccU8d/H
 L+C8WClIkVpaY6AbD/ubjeb40DSF31ORA0LN6957XpEVw=
X-Google-Smtp-Source: AGHT+IGMHJkf+a1YduAEdblTMtKcRKRA8CUWb16ju6VSj8AnfLaNrcSfffnWAKrCDuql++ZKr87kfXrDPCTTU+6dqJ0=
X-Received: by 2002:a05:690c:6105:b0:70e:2cfb:1848 with SMTP id
 00721157ae682-71668e382b1mr222944117b3.31.1751968693264; Tue, 08 Jul 2025
 02:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250707095322.30222-1-paulliu@debian.org>
 <20250707095322.30222-2-paulliu@debian.org>
 <8AF80705-BB09-4AAD-8604-3D967295AB30@gmx.de>
 <CAC_iWjLL2jZ6m6FWFSyiWdr+BExuj7rEJ7CMLQ5CDbDgpJKYew@mail.gmail.com>
 <7649c35e-255b-4e9f-b859-a84d55d0b30c@gmx.de>
In-Reply-To: <7649c35e-255b-4e9f-b859-a84d55d0b30c@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Jul 2025 12:57:36 +0300
X-Gm-Features: Ac12FXwTw5A1HkuX6h4mj289s3PDVIDKrsJ-NPZZHroBcVPMLDS-GVqx0FUiTZo
Message-ID: <CAC_iWjLzDaHaYc+w4BMV9+BLhUVEYwT=mr6D9rGyRS-1fSZs3w@mail.gmail.com>
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

On Tue, 8 Jul 2025 at 12:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 08.07.25 09:36, Ilias Apalodimas wrote:
> > Hi Heinrich
> >
> > On Tue, 8 Jul 2025 at 06:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> Am 7. Juli 2025 11:53:22 MESZ schrieb "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>:
> >>> Previously, EFI_DEBUG_SUPPORT was enabled across all platforms for
> >>> CI build testing. With this commit, we are limiting its activation
> >>> to qemu_arm64_defconfig and qemu_arm_defconfig only, which is
> >>> sufficient for our current needs.
> >>
> >> Was there a request to turn it off on other platforms?
> >
> > I asked Paul to send this, because it grows the binary size a bit.
> > Since it a debug protocol, I thought we could only enable it for QEMU
> > to test it.
> > If you want that on for risc-v we can turn it on for QEMU as well?
>
> The protocol is typically needed when things fail on real hardware.
> Having to reflash U-Boot may not be desired especially if the U-Boot
> binary is signed. Isn't !HAS_BOARD_SIZE_LIMIT is enough of a safeguard
> for now?

Well I assume that people use it for debugging and not production, so
refreshing shouldn't be a big deal.
I don't mind if you prefer it as is. I just assumed we wanted it off
by default, since it's a debug protocol

Regards
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> > Thanks
> > /Ilias
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >>
> >>>
> >>> Signed-off-by: Ying-Chun Liu (PaulLiu) <paulliu@debian.org>
> >>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>> Cc: Tom Rini <trini@konsulko.com>
> >>> ---
> >>> configs/qemu_arm64_defconfig | 1 +
> >>> configs/qemu_arm_defconfig   | 1 +
> >>> lib/efi_loader/Kconfig       | 1 -
> >>> 3 files changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> >>> index 39afb837e41..54bf4646382 100644
> >>> --- a/configs/qemu_arm64_defconfig
> >>> +++ b/configs/qemu_arm64_defconfig
> >>> @@ -15,6 +15,7 @@ CONFIG_ENV_ADDR=0x4000000
> >>> CONFIG_PCI=y
> >>> CONFIG_DEBUG_UART=y
> >>> CONFIG_AHCI=y
> >>> +CONFIG_EFI_DEBUG_SUPPORT=y
> >>> CONFIG_EFI_HTTP_BOOT=y
> >>> CONFIG_FIT=y
> >>> CONFIG_FIT_SIGNATURE=y
> >>> diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
> >>> index 92ba48f6af9..b1c277a86c0 100644
> >>> --- a/configs/qemu_arm_defconfig
> >>> +++ b/configs/qemu_arm_defconfig
> >>> @@ -18,6 +18,7 @@ CONFIG_ENV_ADDR=0x4000000
> >>> CONFIG_PCI=y
> >>> CONFIG_DEBUG_UART=y
> >>> CONFIG_AHCI=y
> >>> +CONFIG_EFI_DEBUG_SUPPORT=y
> >>> CONFIG_FIT=y
> >>> CONFIG_FIT_SIGNATURE=y
> >>> CONFIG_FIT_VERBOSE=y
> >>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >>> index 077466f01f0..fdabe9cc278 100644
> >>> --- a/lib/efi_loader/Kconfig
> >>> +++ b/lib/efi_loader/Kconfig
> >>> @@ -73,7 +73,6 @@ config EFI_SIGNATURE_SUPPORT
> >>>
> >>> config EFI_DEBUG_SUPPORT
> >>>        bool "EFI Debug Support"
> >>> -      default y if !HAS_BOARD_SIZE_LIMIT
> >>>        help
> >>>          Select this option if you want to setup the EFI Debug Support
> >>>          Table and the EFI_SYSTEM_TABLE_POINTER which is used by the debug
> >>
>
