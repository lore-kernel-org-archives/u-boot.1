Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F390CF6484
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 22:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C31BD83EF9;
	Wed, 19 Nov 2025 23:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J5aZby7M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CFDA83F26; Wed, 19 Nov 2025 23:13:12 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B114883E40
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 23:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b735ce67d1dso37488566b.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 14:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763590389; x=1764195189; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mCLNgYR8EkmUKKIz7QbsuxDCM9vgg6yBRHHSwUEyxZQ=;
 b=J5aZby7MmLkDWuCWEwel1jD4Mk6wE/NrKOFzIk99qgoFiE0SLaXN1RWEjvqfP+G058
 dMNDlt09+8Kvn4Ru/7vIrFUQg3wHVVbXoA+j1TYo6B2sLpg2kcCYuncvdqyYndY6uUs9
 6LqE+6GZelWGshqP5gTq5T+aBUJd/t1m+6dd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763590389; x=1764195189;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCLNgYR8EkmUKKIz7QbsuxDCM9vgg6yBRHHSwUEyxZQ=;
 b=lswePWifmKjv/jz0l7oWZ6tATFfa5GFuy8uM/cTbBAN0nz0FXGMWZnjDWgiGOrDuvP
 4YrNzrMXmpe/yOwy51w1yitHRHwEWDUsIBSXTGvyrqCQ6TdAUJ8ARYNBbaJolxrYp+Ls
 Zgq+D9ZneORjh41yTXDUrVQhi922Y1zAnP47/V5bJEK5MAlMqENOd0ajCWom9iy+XsFC
 x4YHd2vMzAZXRBKxZklhAshRtrwJlMai1NokljLbNV441KdRtQgo4QBk76EzmRmBQL3H
 iEzrAIG6s3vBcLz9QXl5Y4hriXOmDRy7sqf2RaQ3AYogOgsblYC8XEdlEozNKqXbQpaW
 z2nA==
X-Gm-Message-State: AOJu0Yy47eWozbfP+PFtwEyRuc9X2MApI9lWdi3leiF6YdJtfTfZV+69
 mSLkh0yyD9Jm2a5x4HdOVtr9gcFg0x0xmP9Mwdo06QxKygVYWxE3XTZmXzFdXsTG9X4w/rfk251
 fRuv7qaY38VHA/4hXZioenFSieW48eQCIKE9pV2UT
X-Gm-Gg: ASbGncv367xCliQlgV102SD4v+cHj/p4R+uij59vGhar3WtKxMspvJrWSUHUROTlphu
 u4k+jrkw3yQllwAsuyQUCmxeJrPZQGzhN01FLWrJmNoi4GanWJikUHWFNbxsUudJJsSSw8sJr0k
 IqAkAHd16Y8Sii7h7hawAv1qx6MycHuYjGq5RvRVMuylGWI7QcBeltqITvaU+xQCTQZ1/jryXw/
 n2pH6wgz9nE7pxgOk192hzu3zBZ+HLoOlm13R5+kFSxTx5RHsMioHKEUlxrtZd85o06Sg==
X-Google-Smtp-Source: AGHT+IHecxNLLoA7/7W5yyrjx9pxVPGTgBU8nJ/whJ2aE5YVKHtkaY6Yd0AgqtKJPC6ET8m0rotN6lzD5vcaxMP8iCk=
X-Received: by 2002:a17:907:9620:b0:b73:594e:1c47 with SMTP id
 a640c23a62f3a-b7654d61053mr79822266b.26.1763590388863; Wed, 19 Nov 2025
 14:13:08 -0800 (PST)
MIME-Version: 1.0
References: <20251119184640.543904-1-adriana@arista.com>
In-Reply-To: <20251119184640.543904-1-adriana@arista.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Nov 2025 15:12:55 -0700
X-Gm-Features: AWmQ_bmaRRzoZ8iPjI6VDojUdMR-YhxpnwppV-N-1DNCS_Eo6jxlecYX-j4FnpU
Message-ID: <CAFLszThwH8PHwDXRiTH=Z6w66to6Swu+DiBGPd6btsadB4L5cQ@mail.gmail.com>
Subject: Re: [PATCH v4] boot/bootfdt: Add smbios3-entrypoint to FDT for
 non-EFI boots
To: Adriana Nicolae <adriana@arista.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, ddrokosov@salutedevices.com, 
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, xypron.glpk@gmx.de, 
 kojima.masahisa@socionext.com, richard@nod.at, semen.protsenko@linaro.org, 
 joao.goncalves@toradex.com
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

On Wed, 19 Nov 2025 at 11:46, Adriana Nicolae <adriana@arista.com> wrote:
>
> From: adriana <adriana@arista.com>
>
> The Linux kernel can discover SMBIOS tables through two primary methods:
> 1. Via EFI tables, when using EFI boot;
> 2. Via the 'smbios3-entrypoint' property in the /chosen node of the
> device tree.
>
> When U-Boot boots a Linux kernel using a non-EFI command ("bootm",
> "bootz", or "booti"), the kernel relies on the device tree to detect
> the hardware. If SMBIOS tables are available in U-Boot, they should
> be passed to the kernel via this device tree property.
>
> This patch modifies boot_fdt_prepare(), to inject the SMBIOSv3 table
> address into the device tree if there is a table generated by U-boot.
> The "board_fdt_chosen_smbios" is weak in order to leave the possibilty
> for specific boards to select custom SMBIOS addresses.
>
> The changes in this patch are added in the context of supporting this
> device tree property in linux kernel:
> https://lkml.org/lkml/2025/10/24/1393
>
> Device tree schema was updated to include the "smbios3-entrypoint" node
> in pull request: https://github.com/devicetree-org/dt-schema/pull/177
>
> Signed-off-by: Adriana Nicolae <adriana@arista.com>
> ---
> Changes in v4:
>   - Remove weak function board_fdt_chosen_smbios(), replace with
>     gd_smbios_start();
>   - Return -EAGAIN in test if GENERATE_SMBIOS_TABLE is not enabled;
>   - Remove unnecessary fdt cleanup at the end of the test;
>   - Added missing newlines at the end of the modified files.
>
> Changes in v3:
>   - Moved "board_fdt_chosen_smbios" function to lib/smbios.c
>   - Return physical address of smbios entry and use map_sysmem to
>     access the entry point;
>   - Removed check for config enabled and added check for
>     GENERATE_SMBIOS_TABLE;
>   - Add test to check that smbios entry address is added into fdt;
>
> Changes in v2:
>   - Renamed device tree property to "smbios3-entrypoint".
>   - Removed redundant check for CONFIG_SMBIOS.
> ---
>  boot/fdt_support.c | 19 ++++++++++++++++++
>  test/dm/fdtdec.c   | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
