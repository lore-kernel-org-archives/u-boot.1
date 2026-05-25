Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5425CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 20:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C9B846F2;
	Mon, 25 May 2026 22:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OPIdb0/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01BC684894; Mon, 25 May 2026 22:35:30 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3A58846AC
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 22:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-67179ed133dso11233800a12.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 13:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779741327; cv=none;
 d=google.com; s=arc-20240605;
 b=kdKZhal8frb93vUIde+vIWFn6t885u39nD4x5rUSCtyzOQHVj8cRW5ADQkdLK9ux7g
 7eNhsyXLBa/f1v1F39ZPV3iAZu0MgPzxxQvjD1JKccYvlJhnoj3KSKHcJ32rsUDIUO2q
 LVxQOyemfg6JgAyMYjO0EZzW9DhloIvCVfIxhfEftKVbkzp/73Smm2HXH1eM8Tnk/eGj
 a4Cr1R3nT0omgyNYQNz3IQnGq0ZaUWa3tULB0KQq/UZpIngUFMNJkGn2fdKNEza2Z6/s
 UmE73QRTbYfYTZgQ0RXFZuoFQrkASCLQ0K+VU9jNexsWTFqzIRKcvm+z6xe6CkeN8TE8
 4Qlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cyl27DXu4yOjkDpmDY2leYb0AZVmrnci8ivZlHOJygs=;
 fh=LrCGorXzS2ZkYAUdMbXzVynzgeOWDXb923GKU1I/ZgY=;
 b=Sgimv1nC0sYhIJtA19AMCzM2pMNZs/e2565RTh+QILRHSkA0XadojpduKOSoc/NbPD
 29/jm3AonMwOu+6IyYHARxOS5TMFaUXvxhZqE+fMpAtWVvK0UX72+ZFY7XgOI2htuAWZ
 T8HdfMQod5jbcRHwdPuXzGCPv5L8yAU/Wk4cSRwbLYrVdfCqNiRfE1c/kfTZ+3I0p4Yn
 HQBbPFBHVsSAEc7wXIeFVEpo/JNxkMt288UJ5pR0Hyf+EGXuEmW0xHP8GbkslqX2TtxU
 KTbheSd36t60v5S0UO3hOGS2pFnUYfzpgoBm3fMSxSNYA3cWTZsmBig2RyYVqUEGdnb4
 yJHQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779741327; x=1780346127; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cyl27DXu4yOjkDpmDY2leYb0AZVmrnci8ivZlHOJygs=;
 b=OPIdb0/gkf+qC9FmBZjCNel7tKJf2wjibN7MwKJoPlscPUbHmj+OSgAW7ca0abQbqV
 HAvzGRwUaNtSxIdIc0v3yQzH2dKO4U1vkeiUWvjJGNaPi3ffCxjqBVRxa/di5nPUVaxt
 vXDkQZ62eUIRiSVfnnCzbvxHaI68dQkQVb7zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779741327; x=1780346127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyl27DXu4yOjkDpmDY2leYb0AZVmrnci8ivZlHOJygs=;
 b=dYazsxiZUjamKUVEXHby06THV8L5jhm5NkZAvBHfVGWxOJfIbsLNzxM7+AHoCo/f+P
 NMxROgquxKbdY+yplVZ1RihzUWxvf60af5Ng+pk9KR0y3GZr7GxiH9vQ/cHpLLfbdcvl
 15vm8XgIA6bIebUCzVfpjQbB2FAOBZhIDKeAty2CXNsohPJRV08yyUlC+hzG0SyFQPI7
 0DSby282fKTcpf1h3QsSS/dVbByDMFmjAvA5hw+SbpqeAXPmMIjjBF/pl9naL3Gy8bxh
 3RnAtQrOXUcZrysHpw7SEWZAiH6p7WRLk/jIowWqRSXAxpksBntqPBYgMTLidIqT32X7
 htew==
X-Gm-Message-State: AOJu0YxY7OiYwZffhh+4kl4lAjFwSQ3aYxm1jSjlvZQa5OiY0tdXXb5n
 cyWWEgCKgRc4+WZB/inv/lpelkoqiE/VuJldrW9XDqPGBAemIBX63nOfGrJyYHys7k6Hox2Rbit
 eNAWTiepAaZpLbnQjwnQmMRe45yrk18bhko0fRTrsCzh23j82z/Q=
X-Gm-Gg: Acq92OE09oQ7N4gB6ygfxdIrORG5WUlGGIWypu+91hmV2ogLfvsNoLiqG6a3l4GSN2C
 5THLH7FD2hI/cyNZ2uf2VPm9s7YoWTkYHwNA01RJ4uyJiiwaur33gIrh41dhhS7nWKhSg3wspGH
 1l2gKzusgf3jEyl+3YdNDzx4dd8/Ve1WfqpKL5SVa4nQeC+8xU+95KFaFGVFTcTUt7sc2fufiup
 eoaOMVPVQ8No5DcR8l2AQx6e7dJU50eo0yVnbn82TIolKjfWmW/sdwK+VotLH9eSTtYheBHECBE
 z+n4tzGtImRgYMo8
X-Received: by 2002:a17:907:b1a:b0:bce:804f:f199 with SMTP id
 a640c23a62f3a-bdd2aada3fcmr779474266b.40.1779741327229; Mon, 25 May 2026
 13:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250926160216.2157348-1-sjg@chromium.org>
In-Reply-To: <20250926160216.2157348-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 14:35:12 -0600
X-Gm-Features: AVHnY4LgzQjibi_T6k8HxgEg_9869QSdLafdX_h19YBuVXMqUwRBdwLypSZqZ9Q
Message-ID: <CAFLszTjXjXoL6+yUuATnPb0ABxnBib_SP1mXJn+cFpStDQFPig@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] bootstd: sunxi: Migrate to standard boot
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Hans de Goede <hdegoede@redhat.com>, Liya Huang <1425075683@qq.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>
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

Hi Andre,

On Fri, 26 Sept 2025 at 10:02, Simon Glass <sjg@chromium.org> wrote:
>
> This series attempts to migrate all sunxi boards to use standard boot,
> along with a text environment.
>
> According to Heinrich this should not affect bootmgr, since it is a
> global bootmeth. FEL should be OK since it is also a global bootmeth and
> is ordered before bootmgr.
>
> Heinrich has a pending series which moves the ordering of bootmgr to
> speed up the boot and we will talk that through in the coming days.
>
> Changes in v8:
> - Drop 'select' for USB
>
> Changes in v7:
> - Drop bootmgr-disable patch
>
> Changes in v6:
> - Drop patch to revert make efi_mgr bootmeth work for non-sandbox setups
>
> Changes in v4:
> - Reword Kconfig
> - Add a name for the bootflow
> - Drop UUID_GPT_SYSTEM and UUID_GPT_ESP definitions
> - Drop special case for ARM64's devicetree subdir
> - Drop unwanted quotations and indentation in KERNEL_COMPAT path
>
> Changes in v2:
> - Put the FEL bootmeth before all other global bootmeths
> - Convert the other DISTRO_DEFAULTS in the Kconfig too
> - Keep BOOTCMD_SUNXI_COMPAT
> - Keep bootcmd_sunxi_compat if OLD_SUNXI_KERNEL_COMPAT is enabled
>
> Simon Glass (4):
>   sunxi: Add a bootmeth for FEL
>   sunxi: Move to bootstd
>   sunxi: Drop old distro boot variables
>   sunxi: Move to text environment
>
>  arch/arm/Kconfig               |   6 +-
>  board/sunxi/sunxi.env          | 140 +++++++++++++++++++
>  boot/Kconfig                   |  14 ++
>  boot/Makefile                  |   1 +
>  boot/bootmeth_fel.c            |  85 ++++++++++++
>  include/configs/sunxi-common.h | 238 ---------------------------------
>  6 files changed, 244 insertions(+), 240 deletions(-)
>  create mode 100644 board/sunxi/sunxi.env
>  create mode 100644 boot/bootmeth_fel.c
>
> --
> 2.43.0
>
> base-commit: 44c4919e9dd6c162b237633ba689441eca9a149c
> branch: std8

Just checking if this series could be applied, please?

Regards,
Simon
