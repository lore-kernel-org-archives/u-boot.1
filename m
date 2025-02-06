Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D559C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 12:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 228958083E;
	Thu,  6 Feb 2025 13:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="koCpEZC8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11E2C808AF; Thu,  6 Feb 2025 13:33:15 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99FC0807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5dccaaca646so1698072a12.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738845192; x=1739449992; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=99Y9EJSlkTwv+yj/zQkI6KA4Rz9Edl4y752FVa79HX8=;
 b=koCpEZC82GBJ3F4fGj6BbCfhFb5S0RxYP8ZK5HVi7FWCNvPvZnEbClNsr727r2L4ds
 nuW4P8zKl10qfjrgoLssD3FSZS5mG0f4y2UqgMjhVQd6ZLZmU6P+YsMXv2npXirhrfI6
 u59qUh7GPW2SHP9PokiqfNLOq5worg//FgLZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845192; x=1739449992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=99Y9EJSlkTwv+yj/zQkI6KA4Rz9Edl4y752FVa79HX8=;
 b=AlveEQAoaCuEulGloZCAaVAFK8851CjCyHt2fsy433tz06BJSWMFPRc38h7nn/qbl+
 LBOFlTS8DIK2vcL6+HL9DaRXynMdsy3bV4YKSr7NI67o0aE/N8Juq/QE8Ea6ePu28NcO
 BDOgPZmGkhkSLQ5+8PO3QIzLWz33WxcVsNqFcM2e6PLu65RyfCrBKeV6hnLnvSn2ktC4
 i6cRFVVU+unyZL2mDaEoW3rNntDx7f+bdvF6eofFadag3FnhGzhXfLWuSjQ8uYoNhpb4
 Q2POS4N5Owglo4lGo1H4uKPX2l6ri9V2OHIt4teqVOwGm0awt4mXFK7O5jBmBDk8s2Mf
 wuCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2uk0AFS7W/dg+WUN9QiV5WnyUpwAyHq0Yd6dyVxOUh9779hADEf9f3+05iSRI/C6kTuH2umI=@lists.denx.de
X-Gm-Message-State: AOJu0YzVw8B7M+kd3OjeD6R6FhrhMboBd1xzNWqYeiNcqkoYSp1vugCy
 BzOFD8dckyKDzpsYNvsIr5fu7I2niQHeh+0Ujq9aDaSECvgmlBdtg52H8m2VddkCQJ/BH2f13kY
 kdFGrShaTojzdNMCHAqQG3vGmebroxMfwZnp4
X-Gm-Gg: ASbGncutORD5STdplZixfZPaYmG5o3wWwp6673OTj6OBzGxrOAKga5yCA9wnv+9fScW
 VX2/SMRVT2zomtQFIiFu0dHpVjEL9Cn+bWnucQ1z2wkLH111csSjOzjRTIUieloOomYsjMmtZWQ
 ==
X-Google-Smtp-Source: AGHT+IF/En0uFzxA5HZ8ChBUYv7wTYbk9j9DjEoBaGpqNqgMn/DtPebwjzkgeYxj6rChu0yYp0owXUstLr50iSPcFP0=
X-Received: by 2002:a05:6402:5251:b0:5db:e88c:914f with SMTP id
 4fb4d7f45d1cf-5dcecc86fc3mr3514493a12.4.1738845192002; Thu, 06 Feb 2025
 04:33:12 -0800 (PST)
MIME-Version: 1.0
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:33:00 -0700
X-Gm-Features: AWEUYZn-_p97HSinW5mWZcD9LBku98tdUKaEj4nlm1OE-_8P4GvOCglxqZgO6Ks
Message-ID: <CAFLszThdr-HFauinZASNLT8if67ntJpPMfc6mrRJgCFy+UwsSA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Fix page permission on arm64 architectures
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Ilias,

On Thu, 30 Jan 2025 at 00:21, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> U-Boot maps all pages as RWX. Sadly it's not not 1990 anymore and we are
> better off mapping binaries with proper permissions.
>
> This is an attempt to map the U-Boot binary properly, but leave the
> area we load binaries unaffected and RWX.
>
> patch #1 adds printing capabilities for page permissions in meminfo
> patch #2 prepares our linker scripts, aligns sections in page boundaries etc
> patch #3 is adding a function to change page tables
> patch #4 sets the permissions for .rodata, .text and .data
>
> There's a few problems problem in this RFC ...
> - U-Boot has no MMU APIs in place. As a result I just wired up the function
>   changing the page permissions in board_r.c but only for arm64. In the long
>   term we should add an API that other archs can use if they wish/can

But this creates more work for others. It would be better to do the
job properly at the start. You don't need to support other archs, but
you should create a plausible API and some structs which others can
use. See cpu.h for some ideas. Of course you can't predict the future,
but others will build on it if you make an effort. Otherwise, I doubt
anyone else will (later) clean it up.

> - meminfo doesn't align all results properly (Caleb?)
> - I am not setting the permissions of EFI runtime services section on purpose.
>   Since the OS is allowed to call SetVirtualAddressMap, we need to reset the
>   pages to RWX just before ExitBootServices, so the OS can relocate that code.
>   In arm64 this isn't a huge problem, because we explicitly disable SVAM if
>   if VA_BITS > 39, but other OSes/archs will have a problem.
>
> # TODO:
> - Long term. Add an MMU API and use that instead of exporting arch specific
>   functions
> - Add an enum in mmu_set_attrs() instead of 1,2,3 arguments
> - Set the permissions of EFI runtime services anbd reset them before EBS()
> - Fix alignment when printing pages & information
> - Add a Kconfig option so the feature can be turned off.
>   The reason is that QEMU CI and some boards, fail because they are trying to
>   write RO pages. This usually happens due to variables being wrongly defined as
>   const, but with the updated page permissions this leads to a crash [0] [1].
>   In both cases the reported ESR is 0x9600004f which translates to
>   "Abort caused by writing to memory" "Permission fault, level 3.". On top of
>   that not setting pages as RO (and only setting .data and .text sections) works
>   fine. So until we find and fix the bugs above we can't turn this on
>   unconditionally.
>
> # Open questions
> - Is initr_reloc_global_data() the right place to change permissions? Or is there
>   a better/safer place to do that?
>
> # How to test patches
> - Aplly them an enable
>   CONFIG_CMD_MEMINFO=y
>   CONFIG_CMD_MEMINFO_MAP=y
>   'meminfo' should print something along the lines of
> => meminfo
> DRAM:  8 GiB
> Walking pagetable at 000000023ffe0000, va_bits: 40. Using 4 levels
> [0x23ffe1000]                     |  Table |               |
>   [0x23ffe2000]                   |  Table |               |
>     [0x000000000 - 0x008000000]   |  Block | RWX | Normal        | Inner-shareable
>     [0x008000000 - 0x040000000]   |  Block | RW | Device-nGnRnE | Non-shareable
>   [0x040000000 - 0x200000000]     |  Block | RWX | Normal        | Inner-shareable
>   [0x23ffea000]                   |  Table |               |
>     [0x200000000 - 0x23f600000]   |  Block | RWX | Normal        | Inner-shareable
>     [0x23ffeb000]                 |  Table |               |
>       [0x23f600000 - 0x23f68b000] |  Pages | RWX | Normal        | Inner-shareable
>       [0x23f68b000 - 0x23f74e000] |  Pages | RX | Normal        | Inner-shareable
>       [0x23f74e000 - 0x23f793000] |  Pages | RO | Normal        | Inner-shareable
>       [0x23f793000 - 0x23f794000] |  Pages | RWX | Normal        | Inner-shareable
>       [0x23f794000 - 0x23f79d000] |  Pages | RW | Normal        | Inner-shareable
>       [0x23f79d000 - 0x23f800000] |  Pages | RWX | Normal        | Inner-shareable
>     [0x23f800000 - 0x240000000]   |  Block | RWX | Normal        | Inner-shareable
>   [0x240000000 - 0x4000000000]     |  Block | RWX | Normal        | Inner-shareable
>   [0x23ffe3000]                   |  Table |               |
>     [0x4010000000 - 0x4020000000]   |  Block | RW | Device-nGnRnE | Non-shareable
> [0x23ffe4000]                     |  Table |               |
>   [0x8000000000 - 0x10000000000]     |  Block | RW | Device-nGnRnE | Non-shareable

No, this is not a memory map. Please make all that stuff an option.
Try to use generic structs to print it, not ARM-specific code.

>
> [0] https://lore.kernel.org/u-boot/20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de/
> [1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/jobs/1008714
>
> Ilias Apalodimas (4):
>   meminfo: add memory details for armv8
>   arm: Prepare linker scripts for memory permissions
>   arm64: mmu_change_region_attr() add an option not to break PTEs
>   arm64: Change mapping for data/rodata/text
>
>  Makefile                                | 15 +++++----
>  arch/arm/cpu/armv8/cache_v8.c           | 45 +++++++++++++++++++++++--
>  arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 +++---
>  arch/arm/cpu/armv8/u-boot.lds           | 32 +++++++++++-------
>  arch/arm/include/asm/armv8/mmu.h        |  2 ++
>  arch/arm/include/asm/system.h           |  3 +-
>  arch/arm/mach-snapdragon/board.c        |  2 +-
>  cmd/meminfo.c                           |  5 +++
>  common/board_r.c                        |  7 ++++
>  include/asm-generic/sections.h          |  2 ++
>  lib/efi_loader/efi_runtime.c            |  2 ++
>  11 files changed, 97 insertions(+), 28 deletions(-)
>
> --
> 2.43.0
>

Regards,
Simon
