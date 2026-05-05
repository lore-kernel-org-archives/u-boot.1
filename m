Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD67CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 15:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C32A0849BE;
	Tue,  5 May 2026 17:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="NrepMk3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 221FC84948; Tue,  5 May 2026 16:37:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6ED3F848DA
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 16:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58525293B;
 Tue,  5 May 2026 07:37:04 -0700 (PDT)
Received: from e132995.arm.com (e132995.arm.com [10.1.29.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1734C3F763;
 Tue,  5 May 2026 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777991829; bh=ZHFg4p48qg8IK/XgyMAJBJWOMFEq6C7OGN9y/YgYV4o=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=NrepMk3XB6785Prr1ARaB8nK3lFyyzzSkseWZFnusE9tYkSKhhFW/IPCXv604DwzX
 oGD0E4Xre0avKCb1h9I3KDmYnD6GUYs4if//dKroKopai1c7zzPAMOHwquw5dpl36Q
 UW0tw1+a6BUu7pcscwx6a8bGpa5yJKJ9RIX6Htvc=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/12] arm64: FF-A runtime transport for EFI variables
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>, 
 u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <B8AF2367-CB21-4DAE-A4FF-3CCDB26E0322@gmx.de>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <B8AF2367-CB21-4DAE-A4FF-3CCDB26E0322@gmx.de>
Date: Tue, 05 May 2026 15:37:01 +0100
Message-Id: <177799182178.374111.7134327651902895504.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 05 May 2026 17:49:54 +0200
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

On 2026-04-25 00:18 +0200, Heinrich Schuchardt wrote:
> Am 24. April 2026 19:31:39 MESZ schrieb Harsimran Singh Tungal <harsimransingh.tungal@arm.com>:
> >Hi all,
> >
> >This series adds FF-A runtime transport support so EFI variable runtime
> >services can communicate with the secure world after ExitBootServices().
> >It also extends tests, docs, and board configs to validate the runtime
> >path and keep boot‑time behavior aligned with the runtime flow.
> 
> Hello Harsiman,
> 
> Could you, please, explain the motivation for the series.
> 
> What is the overall architecture?
> 
> Please, describe how to set up a system on QEMU to test your development including the instructions for the secure world.
> 
> We would need a test in the CI using QEMU.
> 
> Best regards
> 
> Heinrich
> 
>
Hi Heinrich,

The motivation for the series is that, when EFI variables are backed by an
MM Secure Partition reached over FF-A, U-Boot can use that path during boot,
but after ExitBootServices() the normal FF-A/DM path is no longer suitable.
As a result, EFI runtime variable services can no longer reach the secure
partition. The goal of this series is to keep only the minimal FF-A transport
needed for EFI runtime variable services available after ExitBootServices().

The overall architecture is:

- During boot, the FF-A bus probes normally, discovers the U-Boot endpoint ID
  and the MM SP partition ID, and registers an ExitBootServices() callback.
- At ExitBootServices(), U-Boot copies the minimal FF-A state needed at
  runtime into resident runtime data and enables the runtime context.
- After that, EFI runtime variable operations
  (SetVariable/GetVariable/GetNextVariableName/QueryVariableInfo) use the
  runtime-safe path in efi_variable_tee.c, reuse the fixed FF-A shared buffer,
  perform range-based cache maintenance on that buffer only, and notify the
  MM SP using FF-A direct messaging.

So the runtime side is intentionally narrow: it keeps just enough FF-A support
for EFI runtime variables, rather than trying to preserve the full FF-A bus
or driver-model stack after ExitBootServices().

On testing, the current series adds sandbox DM tests for the FF-A runtime
helpers and EFI selftests for the runtime variable path, and my end-to-end
validation so far has been on Corstone-1000. I do not have a proper QEMU
setup with the corresponding secure-world/MM SP side packaged as part of this
series, so I cannot provide good QEMU instructions.

More details on building and running Corstone-1000 FVP can be found here:
https://corstone1000.docs.arm.com/en/latest/user-guide.html

Please let me know if this overall direction makes sense to you.

Regards
Harsimran Singh Tungal

> >
> >Changes in this series:
> >- Add EFI runtime-safe memset helper and FF-A runtime transport support.
> >- Implement FF-A runtime communication in the EFI variable TEE backend.
> >- Enable runtime variable operations and move helpers to avoid conflicts.
> >- Add sandbox runtime transport tests and metadata reuse.
> >- Extend EFI selftests for runtime variables and bootefi selftest config.
> >- Document the FF-A runtime transport and selftest behavior.
> >- Align boot‑time cache maintenance with the runtime path.
> >
> >Harsimran Singh Tungal (12):
> >  efi_loader: add runtime memset helper
> >  arm-ffa: add FF-A bus runtime support
> >  efi_loader: add FF-A runtime support in EFI variable TEE driver
> >  efi_loader: enable EFI runtime SetVariable()/GetVariable() using FF-A
> >    transport
> >  efi_loader: move runtime GetVariable() helpers to efi_variable.c
> >  corstone1000: enable bootefi selftest
> >  efi: selftest: add runtime variable tests with non-volatile storage
> >  test: dm: add sandbox FF-A runtime transport tests
> >  sandbox: ffa: share synthetic partition metadata via macros
> >  doc: arm64: document FF-A runtime path for EFI variables
> >  doc: bootefi: note two-phase runtime variables selftest
> >  efi_loader: align FF-A cache maintenance with runtime path
> >
> > arch/sandbox/include/asm/sandbox_arm_ffa.h    |  16 +-
> > configs/corstone1000_defconfig                |   3 +
> > doc/arch/arm64.ffa.rst                        |  92 ++-
> > doc/usage/cmd/armffa.rst                      |  11 +
> > doc/usage/cmd/bootefi.rst                     |  12 +
> > drivers/firmware/arm-ffa/Kconfig              |  11 +
> > drivers/firmware/arm-ffa/Makefile             |   4 +-
> > drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 287 ++++++++
> > drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 111 +--
> > drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
> > drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  48 +-
> > include/arm_ffa.h                             |  16 +-
> > include/arm_ffa_priv.h                        |  24 +-
> > include/arm_ffa_runtime.h                     | 183 +++++
> > include/efi_loader.h                          |   3 +
> > lib/charset.c                                 |   2 +-
> > lib/efi_loader/efi_runtime.c                  |  21 +
> > lib/efi_loader/efi_var_common.c               |  24 -
> > lib/efi_loader/efi_variable.c                 |  24 +
> > lib/efi_loader/efi_variable_tee.c             | 686 +++++++++++++++++-
> > .../efi_selftest_variables_runtime.c          | 106 ++-
> > test/dm/Makefile                              |   3 +-
> > test/dm/ffa.c                                 |   6 +-
> > test/dm/ffa_runtime.c                         |  82 +++
> > 24 files changed, 1602 insertions(+), 189 deletions(-)
> > create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
> > create mode 100644 include/arm_ffa_runtime.h
> > create mode 100644 test/dm/ffa_runtime.c
> >
> 
> 


