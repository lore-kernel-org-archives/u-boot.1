Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A16CD98C6
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 05:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1AEC80087;
	Thu, 11 Jun 2026 07:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KYxAqbGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0F9480433; Thu, 11 Jun 2026 07:58:55 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DAA680086
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781157530; x=1781762330; i=xypron.glpk@gmx.de;
 bh=ArN+QBW/R+q9ESAIG7l0XeAl3rM7TF/Nkvf5xEVa2CQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KYxAqbGzib67CgMmVp++ad8alOlc/fVjJnQsQnWJ5KFmHzfpvb5V6B5WmQ+zWPES
 voMPMzG71ip7fDSMqTUJ8R24zNKk1+f6vkCSrk/W1Ziz9XcteWDg8JU4XUO+BEoNL
 X7sRE0J6BzrIzYGHsq9DU6UgRPyJtG3CzJlHqzuCyWZB/0VuoUOnJDH+R1zm1ESaR
 LNl8VomooC9gZfDbz8Yjbq0PxlaWWtqg3hykm02OB/+ksNtTcPsjJbg5j1fbVASft
 Rti9FBmNlTWShdqIMl9UFpN3cnxu3GaWFiXQhBZUqhOknMJjVdPijo8cKf5lWe6WG
 3cB4k96oYU49J65P9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUnK-1xNrqK2zFy-011qE4; Thu, 11
 Jun 2026 07:58:50 +0200
Message-ID: <d1c2ada1-ac7b-424d-8e66-17d8eacb3320@gmx.de>
Date: Thu, 11 Jun 2026 07:58:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] arm64: FF-A runtime transport for EFI variables
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: abdellatif.elkhlifi@arm.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, hugues.kambampiana@arm.com, sjg@chromium.org,
 u-boot@lists.denx.de
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1riNKtrwv0oThBRAAFp4JPzXJF3m2Athrhb8ldgZ8CHY4mV6qLu
 YPU6ueLRc6+CDEajbNmKviYKWmvyfN1kdx3P+58t394rpAxRGnc4U32EcxSfmRRXJCmy8R8
 JEQlJjs6ojYmYB7DBe8deaZ6/Yd3fYwNe5z3WJl0ozCHQPSU1xJyNWSHmGJ+wJBx50QjOYs
 CCKMNE1mUUWnJAcBpdt6g==
UI-OutboundReport: notjunk:1;M01:P0:OmaWwVhA+yM=;uti5LAF/23rjxi2tu80ojAotjhP
 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
 Rk65I08kL9x5iwbduemZa4TFXXc=
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

On 5/14/26 14:49, Harsimran Singh Tungal wrote:
> Hi all,
>=20
> This series adds FF-A runtime transport support so EFI variable runtime
> services can communicate with the secure world after ExitBootServices().
> It also extends tests, docs, and board configs to validate the runtime
> path and keep boot=E2=80=91time behavior aligned with the runtime flow.
>=20
> Changes in this series:
> - Add EFI runtime-safe memset helper and FF-A runtime transport support.
> - Implement FF-A runtime communication in the EFI variable TEE backend.
> - Enable runtime variable operations and move helpers to avoid conflicts=
.
> - Add sandbox runtime transport tests and metadata reuse.
> - Extend EFI selftests for runtime variables and bootefi selftest config=
.
> - Document the FF-A runtime transport and selftest behavior.
>=20
> Changes in v2:
>=20
> Address Simon Glass's review comments:
> - Fix `efi_memset_runtime()` style, declaration, and byte cast
> - Tighten the FF-A runtime context failure path, clean up `arm-ffa-runti=
me.c`
>    style issues, and move ExitBootServices event registration earlier in=
 probe
> - Add shared-buffer bounds/alignment checks, and tightening comments/ker=
nel-doc
> - Document the FF-A shared buffer cacheline-alignment requirement and ad=
d
>    BUILD_BUG_ON() checks for the address
> - Cache attributes before the shared buffer is reused, moving the read-o=
nly
>    check earlier, and split the `u16_strsize()` related change in separa=
te patch
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
> - Keep the arm64 cache-maintenance path runtime-safe.
> - Move FF-A shared-buffer runtime memory-map registration to the end of
>    variable-service initialization
>=20
> Link to v1: https://lore.kernel.org/u-boot/20260424173151.371134-1-harsi=
mransingh.tungal@arm.com/
>=20
> Harsimran Singh Tungal (11):
>    efi_loader: add runtime memset helper
>    arm-ffa: add FF-A bus runtime support
>    efi_loader: add FF-A runtime support in EFI variable TEE driver
>    efi_loader: enable EFI runtime SetVariable()/GetVariable() using FF-A
>      transport
>    charset: mark u16_strsize() as __efi_runtime
>    efi_loader: move runtime variable read helpers to efi_variable.c
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
>   doc/arch/arm64.ffa.rst                        |  86 ++-
>   doc/usage/cmd/armffa.rst                      |  11 +
>   doc/usage/cmd/bootefi.rst                     |  27 +
>   drivers/firmware/arm-ffa/Kconfig              |  11 +
>   drivers/firmware/arm-ffa/Makefile             |   4 +-
>   drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 295 ++++++++
>   drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 113 +--
>   drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
>   drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  48 +-
>   include/arm_ffa.h                             |  16 +-
>   include/arm_ffa_priv.h                        |  22 +-
>   include/arm_ffa_runtime.h                     | 191 +++++
>   include/efi_loader.h                          |   3 +
>   lib/charset.c                                 |   2 +-
>   lib/efi_loader/Kconfig                        |   4 +
>   lib/efi_loader/efi_runtime.c                  |  20 +
>   lib/efi_loader/efi_var_common.c               |  24 -
>   lib/efi_loader/efi_variable.c                 |  24 +
>   lib/efi_loader/efi_variable_tee.c             | 650 +++++++++++++---
>   .../efi_selftest_variables_runtime.c          | 713 ++++++++++++------
>   test/dm/Makefile                              |   3 +-
>   test/dm/ffa.c                                 |   6 +-
>   test/dm/ffa_runtime.c                         | 129 ++++
>   27 files changed, 1962 insertions(+), 496 deletions(-)
>   create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
>   create mode 100644 include/arm_ffa_runtime.h
>   create mode 100644 test/dm/ffa_runtime.c
>=20


Hello Harsimram,

Due to the open questions I guess this series should not be merged=20
before a v3 has been sent to address these.

Best regards

Heinrich
