Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE65C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 13:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0476480B9E;
	Thu,  6 Feb 2025 14:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XQzzQYFx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A418091A; Thu,  6 Feb 2025 13:33:52 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E4A807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso158520566b.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738845230; x=1739450030; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UaXSA6Np5ba7Dh+Nz9BQvgadbpM5BvklaNhl0BicgZs=;
 b=XQzzQYFxuqZY1tEhV1LjYAkvwcex9QRQXNKSY2aFqbuATVNx57XfzHxDaxw7c6FYKH
 tGqYVMoPmS+F/kdzUzVPdFCEwxJv3p0u2w9DDeIhMVwxrdTU693c2JdKsTT3wB0dC4aJ
 PSYKiCblid80EdwrleEUnys7rVz8n5JY2tdIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845230; x=1739450030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UaXSA6Np5ba7Dh+Nz9BQvgadbpM5BvklaNhl0BicgZs=;
 b=TpDAUdCWED5OGFhnrgt4j18e7P836BsocYV2VEFSBqL4IAVixVpuOw9Bs7D/54ZHEq
 NcXWjRz4dds9VXO0iKsc6ZQg244+z/K1aRDrNJxDyJ9X2XfbsRgTKd541RnP29TbsFhN
 kPb3pyE/EDAc96pPDzvRQbzEN7K/OG9DEZID5yZXTY8u1ohzl+lxJKyE/Eiyitp8e7pF
 FEPrp4PV6++ZJ2272MvsD8iHdxOg4k+Uth+JewCQpBF4e2LRA33jKgkyNot4X1IP3rrJ
 XEvVZRRg5Z0SCYuOw/p/rSDU3Y+dpcyE1f7szn5dH1CH5pPfaT2XKZ8JZQn6UUeipgrc
 d0bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhrF/KMUTxghz0AwoDjWjZNjUNoVN5tKG3R5lywai89znTmWy/yVWSLknDBoucsPmZXlr/qZE=@lists.denx.de
X-Gm-Message-State: AOJu0YzHGqZeXpy0RWPxKOYf4xeb5M6RvhR0IiWpdv/MidyVeUyzIVxf
 rL3tcE2F2nRmtN15MrDm6oKOq/89WkYPo5Um9KIO6zGJ9gvYO+N+hPETgrDZpt/hOz/5lz4gCQU
 RNaC+TZSbgZjyskr+fXcbBFJEsb7hbJY6RF2j
X-Gm-Gg: ASbGncs9Tf4lCUGHuYQh3KHgZfQz+AUXiW9gNVEUKQAeZpfsUVTqLUYOLhucIr0s8yv
 LAhw++QEdLkH9UsEY1p1/STIIJue20vz2HQksff3irPLU7Mj//qYvHJHmgmekz529FfedspXedA
 ==
X-Google-Smtp-Source: AGHT+IGMp7LpsVhRqhsffXvwnXxQeI34PlT06RG8YLcSU6xM//48psRwObfrDQgTxsO/OHSs4oydENRnCLTBNdIfvBw=
X-Received: by 2002:a17:907:944b:b0:ab3:83c2:755a with SMTP id
 a640c23a62f3a-ab75e33da55mr683127866b.49.1738845229536; Thu, 06 Feb 2025
 04:33:49 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:33:36 -0700
X-Gm-Features: AWEUYZmaIqKBS4k_BaauUSY3Q_6qQv7qJxKFGIi7fD7byTywSy6q_spXvGhNxmw
Message-ID: <CAFLszTijvgciHdJppt9hxNkGth_pYEk_By8jRcyqj1iyqiUEUA@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Fix page permission on arm64 architectures
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Peng Fan <peng.fan@nxp.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Stefan Roese <sr@denx.de>, Joshua Watt <jpewhacker@gmail.com>,
 Alex Shumsky <alexthreed@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Jonas Jelonek <jelonek.jonas@gmail.com>, 
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 06 Feb 2025 14:07:31 +0100
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

On Wed, 5 Feb 2025 at 00:17, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi!
> This is v1 of [0].
>
> This is an attempt to map the U-Boot binary properly, but leave the
> area we load binaries unaffected and RWX.
>
> There's a few changes since the RFC
> - Fixed the alignment of meminfo command when printing regions
> - 'meminfo' now prints arch specific attributes e.g PXN, UXN etc for arm
>   instead of RW, RO, RX
> - Since we don't set the permissions of EFI runtime services yet and keep
>   them as RWX, I removed the linker alignment changes which makes patch #3
>   easier to review. It's worth noting that qemu-arm sbsa was crashing with
>   the efi services page aligned. This is probably due to a mismatch of
>   memory, since the crash is only reproducible with QEMU instances that
>   have < 2 GB of RAM. I'll fix that along with the efi runtime services
> - Defined memory attribute changes properly with an enum for RW, RO, RX
>   instead of the hardcoded '1,2,3' I had on the RFC
> - Enabling mappings is now under a Kconfig (CONFIG_MMU_PGPROT), since
>   peope reported crashes when testing this, which are orthogonal to this
>   patch. We still have places in U-Boot where we define and later write
>   const variables. This will lead to a crash now as const variables are
>   properly managed and places in RO memory
> - Split patches to be easier to review
> - Added a patch updating 'meminfo'
> - Picked up acked-by tags from Jerome
>
> patch #1 adds printing capabilities for page mappings in 'meminfo'
> patch #2 adds documention in 'meminfo' command
> patch #3 prepares linker scripts, aligns sections in page boundaries etc
> patch #4 prepares an internal function to change the PTEs
> patch #5 adds function definitions & stubs for all archs
> patch #6 wires up the changes in U-Boot after it relocates
>
> [0] https://lore.kernel.org/u-boot/20250130072100.27297-1-ilias.apalodimas@linaro.org/
>
> Ilias Apalodimas (6):
>   meminfo: add memory details for armv8
>   doc: update meminfo with arch specific information
>   arm: Prepare linker scripts for memory permissions
>   arm64: mmu_change_region_attr() add an option not to break PTEs
>   treewide: Add a function to change page permissions
>   arm64: Enable RW, RX and RO mappings for the relocated binary
>
>  arch/arc/lib/cache.c                    |  2 +
>  arch/arm/cpu/arm926ejs/cache.c          |  2 +
>  arch/arm/cpu/armv7/cache_v7.c           |  1 +
>  arch/arm/cpu/armv7m/cache.c             |  2 +
>  arch/arm/cpu/armv8/cache_v8.c           | 54 +++++++++++++++++--
>  arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 ++--
>  arch/arm/cpu/armv8/u-boot.lds           | 29 +++++-----
>  arch/arm/include/asm/armv8/mmu.h        |  2 +
>  arch/arm/include/asm/system.h           | 11 +++-
>  arch/arm/lib/cache.c                    |  2 +
>  arch/arm/mach-snapdragon/board.c        |  2 +-
>  arch/m68k/lib/cache.c                   |  2 +
>  arch/nios2/lib/cache.c                  |  2 +
>  arch/powerpc/lib/cache.c                |  2 +
>  arch/riscv/lib/cache.c                  |  2 +
>  arch/sh/cpu/sh4/cache.c                 |  2 +
>  arch/xtensa/lib/cache.c                 |  2 +
>  cmd/meminfo.c                           |  5 ++
>  common/Kconfig                          | 13 +++++
>  common/board_r.c                        | 20 +++++++
>  doc/usage/cmd/meminfo.rst               | 71 ++++++++++++++++++-------
>  include/asm-generic/sections.h          |  2 +
>  include/cpu_func.h                      | 16 ++++++
>  23 files changed, 215 insertions(+), 41 deletions(-)
>
> --
> 2.47.2
>

Can you please explain what problem this fixes, in your cover letter,
to match your series subject? I don't doubt there is a big problem,
but I'm not sure what it is?

Regards,
Simon
