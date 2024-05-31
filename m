Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01876C25B74
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 02:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C34288875A;
	Fri, 31 May 2024 04:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UKJ56g76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC3BF8831F; Fri, 31 May 2024 04:48:06 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA52D8874B
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 04:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6ad8243dba8so7602026d6.3
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 19:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717123683; x=1717728483; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gBKshB+WTLbYn4p98T3fSbAqlC5IB0CQrCEXJYw/zis=;
 b=UKJ56g76///F2HLPfBA+S4AiAdwf0lQOpU3Win0HUAz3PQvg4/lCYJ6yeluEdYrzPp
 0EM8ksH83OCcy14+zenBaIy3P2PAOR/xHg7IjOQ0LtpflCTd+bXHhrgZHap/U4HqcSpA
 Aij3IWoPJO5ET2rNi5En6xKQQK6WexsZ6bCcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717123683; x=1717728483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gBKshB+WTLbYn4p98T3fSbAqlC5IB0CQrCEXJYw/zis=;
 b=XenXDTgIVZEKc0qwqd54INqVeWnPlpDuAAU46eSLTQtTzD3BDX72MEIDoZWHCgWa72
 L8UTFBVcew7ehMe1h4RdbAr/Qggp42RGXGC9Ahsd/f4j/JzSymSKP+ZLvHtERNrUtrpm
 WGTyTI1NWN2nGyydE/2zY1F2aj50Cok9Ybvnl+iBqA7nLHz87dZmfOZ1V5GicfJl4GOt
 wcpexSsONM4DQvDm8L4u++EfpDUWXmJEQh0aCWLRjN1rfYhZgk40rymAWQg0q2IpU60t
 1pnkuPdYZxiQnK6LcUY15tph2h5yytwXLX7iU1C2KEebfIZs9r2KMpsE4MSPNgP619Vd
 t6Ew==
X-Gm-Message-State: AOJu0YwGkbBtylvpxhaKDr4BfHEQ3rsxOjIg0/Q8ti58ztdN4ro1aYcU
 Zm4+V2Edp5fuE7uG2NV/1IjS/kXch7haABfzg6DHYeBK8KQLifu7flIqFV3kTQO/XRl/ecRz4/8
 h9B1Lk+/ag+iqSl93HCs+ijVAMOcWSow1BSAW
X-Google-Smtp-Source: AGHT+IEPsblRkdyiQmf8TpJmKZumEacT/nkZlaV9z4fYUpqJkMXu5SxqzPkEU+WdjeMBXyTntsIPFmvPzvxDYTb254I=
X-Received: by 2002:a05:6214:3a03:b0:6a8:d2cd:5456 with SMTP id
 6a1803df08f44-6aecd576577mr7968336d6.10.1717123682665; Thu, 30 May 2024
 19:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240530220634.155951-1-tharvey@gateworks.com>
 <20240530220634.155951-3-tharvey@gateworks.com>
In-Reply-To: <20240530220634.155951-3-tharvey@gateworks.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 May 2024 20:47:52 -0600
Message-ID: <CAFLszTiV67_+7rq9MAGpK0zV9kgqdwtE8SmJ-cxSwou4Ko=PLQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fdt: automatically add /chosen/kaslr-seed if
 DM_RNG is enabled
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 31 May 2024 04:58:26 +0200
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

On Thu, 30 May 2024 at 16:06, Tim Harvey <tharvey@gateworks.com> wrote:
>
> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> randomize the virtual address at which the kernel image is loaded, it
> expects entropy to be provided by the bootloader by populating
> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
>
> If we have DM_RNG enabled populate this value automatically when
> fdt_chosen is called. We skip this if ARMV8_SEC_FIRMWARE_SUPPORT
> is enabled as its implementation uses a different source of entropy
> that is not yet implemented as DM_RNG. We also skip this if
> MEASURED_BOOT is enabled as in that case any modifications to the
> dt will cause measured boot to fail (although there are many other
> places the dt is altered).
>
> Note that the Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for
> randomization and completely ignores the kaslr-seed for its own
> randomness needs (i.e the randomization of the physical placement of
> the kernel). It gets weeded out from the DTB that gets handed over via
> efi_install_fdt() as it would also mess up the measured boot DTB TPM
> measurements as well.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Cc: Akash Gajjar <gajjar04akash@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Devarsh Thakkar <devarsht@ti.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Chris Morgan <macromorgan@hotmail.com>
> ---
> v5:
>  - fixed typo in commit message s/it's/its/
>  - split patch into 3 parts
> v4:
>  - add missing /n to notice in kaslrseed cmd
>  - combine ints in declaration
>  - remove unused vars from board/xilinx/common/board.c ft_board_setup
> v3:
>  - skip if CONFIG_MEASURED_BOOT
>  - fix skip for CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
>  - pass in rng index and bool to specify overwrite
>  - remove duplicate error strings printed outside of fdt_kaslrseed
>  - added note to commit log about how EFI STUB weeds out kalsr-seed
> v2:
>  - fix typo in commit msg
>  - use stack for seed to avoid unecessary malloc/free
>  - move to a library function and deduplicate code by using it
>    elsewhere
> ---
>  boot/fdt_support.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

My only question is whether there should be error checking here?

> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index b1b2679dea0c..4559adcd5e2e 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -345,6 +345,15 @@ int fdt_chosen(void *fdt)
>         if (nodeoffset < 0)
>                 return nodeoffset;
>
> +       /* if DM_RNG enabled automatically inject kaslr-seed node unless:
> +        * CONFIG_MEASURED_BOOT enabled: as dt modifications break measured boot
> +        * CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT enabled: as that implementation does not use dm yet
> +        */
> +       if (IS_ENABLED(CONFIG_DM_RNG) &&
> +           !IS_ENABLED(CONFIG_MEASURED_BOOT) &&
> +           !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
> +               fdt_kaslrseed(fdt, false);
> +
>         if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf)) {
>                 err = fdt_setprop(fdt, nodeoffset, "rng-seed",
>                                   abuf_data(&buf), abuf_size(&buf));
> --
> 2.25.1
>

Regards,
Simon
