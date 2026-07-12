Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D111C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 06:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87F3C8467B;
	Sun, 12 Jul 2026 08:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="r81Uu3xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 141A08497A; Sun, 12 Jul 2026 08:33:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F6BA844F6
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 08:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1783837981; x=1784442781; i=xypron.glpk@gmx.de;
 bh=Zr9FBP4w9P+1quEI4XWXp+8TAQTHF+wDMEiffISuJDY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=r81Uu3xc9AM4+WRbGgr4atkSDWK7AxpV/GpYe9sfCsG67cdOHAlgLlatEdrtUsWU
 6SNIPNbxbnnz6xi4yBfyaaE340xwdgj4/eVy+JHJTK5hOqm50aaaVdTXlXQ0wuDD8
 cYESwkwIUTQKWBFTMCttfcikPQH7y6s3w7BDTbNmsoiFHNUr9JeeunsQ8FzIKbX9t
 Xd2/fY1F6B6SXQjOjSbBJteLQJhB8Qe6ZEdFLFulMTFGd2tNtWbj2TFSau3zSXjpU
 5hzWDjq/u+y4TNp7Lyq37t1eEviK7PNYBzFLu3sK1IJ694uInjh94XSEJI5aUzIku
 S580YJk9B9sGOMKrfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTAFb-1wcW6k16MB-00XoG4; Sun, 12
 Jul 2026 08:33:01 +0200
Message-ID: <94efd7bf-e5b9-434b-8e26-e2f9c0c3b579@gmx.de>
Date: Sun, 12 Jul 2026 08:33:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] arm64: FF-A runtime transport for EFI variables
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EVqe3V087GfsbBdqllm5++nPA3X7cJu7YEt4cjNTm8ubMl5O4iF
 rq6pJGmx7g7b2MoDY/IkFBg69i1sEAnFNpICn0T0/SyA62BeQjXRtBsdWTWuu+ASrVQCYZx
 e1abGIBDlg5+Inv4aVPSnzvy+sbvqGv9TFq8fgSKzGgcMWVMfTvBV4svzmDXlPTzCK9yp7I
 YndfGIyJAuuHSF9d/NmMw==
UI-OutboundReport: notjunk:1;M01:P0:B3kz+7iS2mc=;tjFeVo76U3OKVXRgIR2Tr5hZmzu
 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
 9K0/YMxExmxWe8FoCMA1tImG9oXnJ1
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

On 6/27/26 16:44, Harsimran Singh Tungal wrote:
> Hi all,
>=20
> This series adds FF-A runtime transport support so EFI variable runtime
> services can communicate with the secure world after ExitBootServices().
> It also extends tests, docs, and board configs to validate the runtime
> path and keep boot-time behavior aligned with the runtime flow.

Hello Harsiman,

Unfortunately this cover-letter lacks some background information needed=
=20
for reviewing the patch series.

Why is this new transport needed? We already have a transport for EFI=20
variables to the secure world via OP-TEE (see CONFIG_EFI_MM_COMM_TEE).

Where is the EFI variables specific FF-A message protocol specified?

Is there a Linux driver that can communicate via this message protocol?

How can the transport be tested with QEMU and Linux?

Best regards

Heinrich

>=20
> Changes in this series:
> - Add EFI runtime-safe memset helper and FF-A runtime transport support.
> - Implement FF-A runtime communication in the EFI variable TEE backend.
> - Enable EFI runtime variable operations over the FF-A transport.
> - Add sandbox runtime transport tests.
> - Extend EFI selftests for runtime variables and bootefi selftest config=
.
> - Document the FF-A runtime transport and selftest behavior.
>=20
> Changes in v3:
>=20
> Address Simon Glass's review comments:
> - Move FF-A ExitBootServices event registration to the end of probe and
>    clean up RX/TX buffer handling on failure.
> - Rename FF-A runtime-context helpers to the ffa_runtime_context_* form.
> - Rework FF-A/MM cache maintenance to cover only rounded request and
>    response ranges.
> - Add SetVirtualAddressMap handling for the FF-A shared buffer.
> - Document FF-A shared-buffer ownership and alignment assumptions.
> - Add EFIAPI to the TEE runtime GetVariable and GetNextVariableName
>    entry points.
> - Tighten sandbox FF-A runtime tests and reset runtime state between
>    test cases.
> - Update FF-A and bootefi documentation for the runtime transport and
>    split runtime-variable selftests.
> - Rework commit messages to drop redundant information.
>=20
> Address Ilias Apalodimas's review comments:
> - Keep efi_var_common.c unchanged and drop commit 6 from v2 patchset.
> - Rename the TEE/FF-A runtime handlers to the *_int_runtime form.
> - Remove log_*() calls from __efi_runtime FF-A/MM communication paths.
>=20
> Other:
> - Fix FF-A memory-share sender_id to use the runtime private endpoint
>    ID after rebasing.
> - Fix the expected QueryVariableInfo() return status for the
>    TEE-backed runtime selftest path.
>=20
>=20
> Changes in v2:
>=20
> Address Simon Glass's review comments:
> - Fix efi_memset_runtime() style, declaration, and byte cast
> - Tighten the FF-A runtime context failure path, clean up arm-ffa-runtim=
e.c
>    style issues, and move ExitBootServices event registration earlier in=
 probe
> - Add shared-buffer bounds/alignment checks, and tightening comments/ker=
nel-doc
> - Document the FF-A shared buffer cacheline-alignment requirement and ad=
d
>    BUILD_BUG_ON() checks for the address
> - Cache attributes before the shared buffer is reused, moving the read-o=
nly
>    check earlier, and split the u16_strsize() related change in separate=
 patch
> - Reword commit messages for the runtime helper relocation
> - Rework the non-volatile runtime variable selftest into setup/verify ph=
ases
> - Extend the sandbox FF-A runtime tests with no-context coverage,
>    runtime-context reset, and separate errno-mapping coverage
> - Refresh the FF-A runtime transport and bootefi documentation
> - Drop patch 12 in v1, as ffa_mm_communicate handles both runtime and
>    boottime capabilities in v2
> - Squash patch 8 and patch 9 from v1
>=20
> Address Ilias Apalodimas's review comments:
> - Reuse common MM SP error mapping for boot and runtime paths
> - Rename runtime-phase tracking to reflect the ExitBootServices transiti=
on
> - Collapse duplicated boot-time and runtime MM communication helpers int=
o common
>    implementations
> - Keep the arm64 cache-maintenance path runtime-safe
> - Move FF-A shared-buffer runtime memory-map registration to the end of
>    variable-service initialization
>=20
> Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-hars=
imransingh.tungal@arm.com/
> Link to v1: https://lore.kernel.org/u-boot/20260424173151.371134-1-harsi=
mransingh.tungal@arm.com/
>=20
> Harsimran Singh Tungal (10):
>    efi_loader: add runtime memset helper
>    arm-ffa: add FF-A bus runtime support
>    efi_loader: add FF-A runtime support in EFI variable TEE driver
>    efi_loader: enable EFI runtime SetVariable()/GetVariable() using FF-A
>      transport
>    charset: mark u16_strsize() as __efi_runtime
>    corstone1000: enable bootefi selftest
>    efi: selftest: add runtime variable tests with non-volatile storage
>    test: dm: add sandbox FF-A runtime transport tests
>    doc: arm64: document FF-A runtime path for EFI variables
>    doc: bootefi: note two-phase runtime variables selftest
>=20
>   arch/arm/cpu/armv8/cache.S                    |   8 +
>   arch/arm/cpu/armv8/cache_v8.c                 |  13 +-
>   arch/sandbox/include/asm/sandbox_arm_ffa.h    |  16 +-
>   configs/corstone1000_defconfig                |   3 +
>   doc/arch/arm64.ffa.rst                        |  88 ++-
>   doc/usage/cmd/armffa.rst                      |  11 +
>   doc/usage/cmd/bootefi.rst                     |  31 +
>   drivers/firmware/arm-ffa/Kconfig              |  11 +
>   drivers/firmware/arm-ffa/Makefile             |   4 +-
>   drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 294 +++++++
>   drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 114 +--
>   drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
>   drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  49 +-
>   include/arm_ffa.h                             |  16 +-
>   include/arm_ffa_priv.h                        |  22 +-
>   include/arm_ffa_runtime.h                     | 191 +++++
>   include/efi_loader.h                          |   3 +
>   lib/charset.c                                 |   2 +-
>   lib/efi_loader/Kconfig                        |   4 +
>   lib/efi_loader/efi_runtime.c                  |  20 +
>   lib/efi_loader/efi_variable_tee.c             | 726 +++++++++++++++---
>   .../efi_selftest_variables_runtime.c          | 715 +++++++++++------
>   test/dm/Makefile                              |   3 +-
>   test/dm/ffa.c                                 |   6 +-
>   test/dm/ffa_runtime.c                         | 123 +++
>   25 files changed, 1997 insertions(+), 492 deletions(-)
>   create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
>   create mode 100644 include/arm_ffa_runtime.h
>   create mode 100644 test/dm/ffa_runtime.c
>=20

