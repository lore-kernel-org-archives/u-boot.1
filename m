Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE75C83F14
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 10:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C53A083276;
	Tue,  8 Jul 2025 12:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cpvl9IEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6F8583281; Tue,  8 Jul 2025 12:03:52 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61C0B80194
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 12:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso35358595e9.0
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 03:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751969029; x=1752573829; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H1Ko3V0g+gzvWtF853gXtFTfycYPkPiDmpBerWRWv3E=;
 b=cpvl9IEZ0HqSJY3UMMm4gwrXG/TrxGzj8OLLmAihmYE0+I928sdHaJlm9Aij77TTUM
 gq4BSnUEne0eU9BE9XN72CVgE2sRI4z1xvpq58MAVflnuiDv16CRzW1FdhyIlK+AfaWs
 b6phcxk7xsiHEQbTB8XAK1L95LuxdrnVOgoTiDQVZX3cbq9b9EejdqaaV5AWWv/Kj4zZ
 b6O+qegAd4ASJ2r+oFZsu7I1gaqpkRa7rLht6oFhtS+Vak0R1YV2DKWMk6Qbtyy2pVWx
 pC3cCa/ASgwFyIutGmxylQL/UQybHj67vP5P4poAZZkH7EFSwDjvewXAfDlIMKc+Cugh
 XOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751969029; x=1752573829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H1Ko3V0g+gzvWtF853gXtFTfycYPkPiDmpBerWRWv3E=;
 b=wD7t+6+wTXInpPsvcJvccFkgnZAn2btapYJtQU6c6pdUwYLKv1xRRy4AZ3sa8kKYif
 AIgxFiyTY9nROzP6nI2yVgJkiTh7lxPyNp/RUppAjdg7RrNxrupgi/Vk6wY7mY5fMNWI
 PPNYJ3ltiVf+mCNIE1JkfmMxPXHGAf/Z0qFkF8CgJtBwlVb1jIwb3MX7Z7X+69lKPF73
 q+GvMZPCEOsDsP2m0jNx51FANFNzS8P7yNuTCZ3PZZb5yPH7Hbs71avAMxAZ+1alW6Y/
 CFYasw2MiV9Ioh+VJgr0z2pOYNZnHY0HBvYA6GTlviUqbQChnsQk7xV+VWoTf8K++rcM
 vrfQ==
X-Gm-Message-State: AOJu0YwDDRGvRHayoYJBYyw1cL2aqre1l1FXw2xbjuiycFfp5+Kb3CKY
 2iKrrPHItXPFmSUfNvJRT5sKvzZyONd1Zve0ISkpUMKJiurcC/AsPnxUF7nZQlzObGAk/ncJJGX
 W1GvJcpJMFQ==
X-Gm-Gg: ASbGncu5/xPMKKDn55HqTmvOsl16gxKe3OEmTTT1bVOcYucfsprIufPSSjD8bQZD2OA
 OgsncjKWgRG/rG+juH++IjArN96qRgLU35eOw0AorQoHyy5L2uVhIPELa8l+/k6xhzeO6EKqmx2
 m99Z+XqOTDoFuUAoOd4SrVjH2RlmG+lbMjwM9h3qnTLHTS2PR67sk9E8i2zLm1GwHkrIm497fPu
 PANWjGs2sa6uv45RIR7VIPuzmE2ykAdZmLVY1wmOqW84/GoLwmx3TZPx3kPfFDoyQWJd70Qz4JR
 dgwkO+rLVc8/qM4CmENW8mzRuzXpZko0tDaVuWed5V+o5iCZdrGlj6CoQz0gCzdvvv85hw==
X-Google-Smtp-Source: AGHT+IFGfbCISL57iAbfepUyOY1q4CbaKxby7BoD1wJY+PAn7jDUl47kdszUV1JsUT7hQZRJfVpyEg==
X-Received: by 2002:a05:6000:4205:b0:3a4:f7e3:c63c with SMTP id
 ffacd0b85a97d-3b496f97855mr11897105f8f.0.1751969029333; 
 Tue, 08 Jul 2025 03:03:49 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:fc4b:50ea:edb:b51a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225afd4sm12302261f8f.83.2025.07.08.03.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 03:03:48 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo <ycliang@andestech.com>, Liya Huang <1425075683@qq.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rick Chen <rick@andestech.com>, Sam Edwards <cfsworks@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@nabladev.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>, Yang Xiwen <forbidden405@outlook.com>
Subject: [RFC PATCH 0/4] arm: move inline assembly MRC/MCR P15 to separate .S
 files
Date: Tue,  8 Jul 2025 12:02:46 +0200
Message-ID: <20250708100322.2153533-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is an attempt at cleaning up some ARM inline assembly, namely: the
MRC/MCR P15 instructions, with two objectives:

1. Getting rid of some changes that are suboptimal, including a recent
workaround for kirkwood. I am referring to commits forcing -marm (arm32
instructions) on whole C files just because they use the MCR/MRC
instruction in inline assembly and those instructions are not supported
in Thumb-1, as well as patches disabling LTO on select files for pretty
much the same reason. Those commits are the following:

62e92077a893 ("arm: support Thumb-1 with CONFIG_SYS_THUMB_BUILD")
8f9696510afc ("ARM: make LTO available")
e5fc9037dd33 ("ARM: fix LTO build for some thumb-interwork cases")
410d59095a9f ("arm: kirkwood: fix freeze on boot")

2. Hopefully get smaller binaries for Arm platforms that use Thumb and/
or LTO, at the cost of marginal increases (say a few dozens of bytes at
most) for the other aArm boards due to not inlining a few functions. And
of course no change for non-arm architectures.

There are four patches in this series:

- The first one reverts a change which does solve a linker error but
does not work as [1] has shown.
- The second patch moves inline assembly into separate .S files
- With that in place, it is possible to remove the -marm overrides as
well as the C flags overrides selectively disabling LTO. This is what
the third patch does.
- The fourth patch is not directly related, but is trying to reduce the
binary size further for platforms that compile C with
-ffunction-sections -fdata-sections so that the linker can eliminate
unreferenced code and data with --gc-sections. I noticed that .S files
do not follow the same convention. By modifying the ENTRY, WEAK and
ENDPROC macros, each assembly function is emitted in its own section
(.text.<name>) like the C compiler would do if it were C code compiled
with -ffunction-sections, thus allowing dead code elimination for .S
too. The savings are not much though (100 or 200 bytes most of the
time), and it makes a couple of boards significantly bigger
(imx8mn_beacon_fspi: all +16196 data +16304; stm32* as well as
imxrt1170-evk: all +2K text +2K). This needs further investigation.
See [6] for details.

Now for the results:

- CI status can be seen at [2]. All good.
- buildman output showing size differences before and after the series:
  $ unbuffer tools/buildman/buildman -b lto-fixes-squashed -c 2 -sS \
    | ansi2html >buildman-series-squashed-1e2c64f1537-size-summary.html
  See [3] (arch averages)
  $ unbuffer tools/buildman/buildman -b lto-fixes-squashed -c 2 -sSd \
    | ansi2html >buildman-series-squashed-1e2c64f1537-size-details.html
  See [4] (per board)
- buildman output showing size differences for each patch:
  $ unbuffer tools/buildman/buildman -b lto-fixes -c 4 -sS \
    | ansi2html >buildman-series-1e2c64f1537-size-summary.html
  See [5] (arch averages)
  $ unbuffer tools/buildman/buildman -b lto-fixes -c 4 -sSd \
    | ansi2html >buildman-series-1e2c64f1537-size-details.html
  See [6] (per board)

[1] https://lists.denx.de/pipermail/u-boot/2025-June/592682.html
[2] https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/26972
[3] https://people.linaro.org/~jerome.forissier/u-boot-07-Jul-2025/buildman-series-squashed-1e2c64f1537-size-summary.html
[4] https://people.linaro.org/~jerome.forissier/u-boot-07-Jul-2025/buildman-series-squashed-1e2c64f1537-size-details.html
[5] https://people.linaro.org/~jerome.forissier/u-boot-07-Jul-2025/buildman-series-1e2c64f1537-size-summary.html
[6] https://people.linaro.org/~jerome.forissier/u-boot-07-Jul-2025/buildman-series-1e2c64f1537-size-details.html


Jerome Forissier (4):
  Revert "arm: asm/system.h: mrc and mcr need .arm if __thumb2__ is not
    set"
  arm: move inline assembly CP15 instructions to separate .S files
  arm: do not force -marm on some C files and allow LTO everywhere
  linkage: use per-function section in ENTRY, WEAK and ENDPROC

 arch/arm/cpu/arm926ejs/Makefile            |   7 +-
 arch/arm/cpu/arm926ejs/cache.c             |  32 ++----
 arch/arm/cpu/arm926ejs/cp15.S              |  46 ++++++++
 arch/arm/cpu/arm926ejs/cpu.c               |  13 +--
 arch/arm/cpu/armv7/lowlevel_init.S         |   4 -
 arch/arm/cpu/armv7/ls102xa/psci.S          |   2 +-
 arch/arm/cpu/armv7/nonsec_virt.S           |  16 +--
 arch/arm/cpu/armv7/psci.S                  | 118 ++++++++++-----------
 arch/arm/cpu/armv7/start.S                 |  20 ++--
 arch/arm/cpu/armv8/cache.S                 |  26 -----
 arch/arm/cpu/armv8/psci.S                  |  22 ++--
 arch/arm/cpu/armv8/tlb.S                   |   2 -
 arch/arm/cpu/armv8/transition.S            |   8 --
 arch/arm/include/asm/system.h              |  36 ++-----
 arch/arm/lib/Makefile                      |  17 ++-
 arch/arm/lib/ashldi3.S                     |   8 +-
 arch/arm/lib/ashrdi3.S                     |   8 +-
 arch/arm/lib/bitops.S                      |   8 --
 arch/arm/lib/cache-cp15.c                  |  62 ++++-------
 arch/arm/lib/cache.c                       |   7 +-
 arch/arm/lib/cp15.S                        |  92 ++++++++++++++++
 arch/arm/lib/crt0.S                        |   4 +-
 arch/arm/lib/div64.S                       |   2 -
 arch/arm/lib/lib1funcs.S                   |  36 ++-----
 arch/arm/lib/lshrdi3.S                     |   8 +-
 arch/arm/lib/muldi3.S                      |   8 +-
 arch/arm/lib/relocate.S                    |   6 +-
 arch/arm/lib/semihosting.S                 |   2 -
 arch/arm/lib/setjmp.S                      |   6 --
 arch/arm/lib/setjmp_aarch64.S              |   6 --
 arch/arm/lib/uldivmod.S                    |   2 -
 arch/arm/mach-imx/mx5/lowlevel_init.S      |   4 +-
 arch/arm/mach-kirkwood/Makefile            |   8 +-
 arch/arm/mach-kirkwood/cp15.S              |  13 +++
 arch/arm/mach-kirkwood/include/mach/cpu.h  |  13 +--
 arch/arm/mach-omap2/omap3/lowlevel_init.S  |  36 +++----
 arch/arm/mach-renesas/lowlevel_init_gen3.S |   6 +-
 arch/arm/mach-tegra/psci.S                 |  12 +--
 arch/riscv/lib/memcpy.S                    |   6 +-
 arch/riscv/lib/memmove.S                   |   7 +-
 arch/riscv/lib/memset.S                    |   6 +-
 arch/riscv/lib/semihosting.S               |   2 -
 arch/riscv/lib/setjmp.S                    |   6 --
 common/Makefile                            |   4 -
 include/linux/linkage.h                    |  20 +++-
 45 files changed, 387 insertions(+), 390 deletions(-)
 create mode 100644 arch/arm/cpu/arm926ejs/cp15.S
 create mode 100644 arch/arm/lib/cp15.S
 create mode 100644 arch/arm/mach-kirkwood/cp15.S

-- 
2.43.0

base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
branch: lto-fixes
