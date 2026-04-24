Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7562AFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 19:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F35C28447F;
	Sat, 25 Apr 2026 21:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="H7tfD9yr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CA04844A5; Sat, 25 Apr 2026 21:49:13 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 363CB84378
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777146550; x=1777751350; i=xypron.glpk@gmx.de;
 bh=l1lNBXzywXgNeUvoJxRgszfEZ/Z/gC8NtevggpFCCUw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=H7tfD9yrkFZR5/u1zN6NCMH5sfqLA1G7gx8dIk9RbOXqplwKrxtXBBhAe9OVBK4M
 SItsMJTJ6OXUt0RRJTzSn8I/Vi8/u/i6x4dCMU6Bt2wG2ADisVTjQjVKwGI7GU3jt
 wafird9hUkwn8uUaJQASeu7tkiVduDipnz9+JfMN0nApDjQuoNVy5Z3qRqXolw18A
 SY10s63o1VoUPJDVVjtYKgMISeQYCUOmOWPe5wBMNSQmoAnYfPOJw5/yqJSrnW0zk
 Ys1RCunXarwByFbshwDMd53/Ygcbp8GQwEMyiiyU6mr/3AELg/6nDiQOuCidlASVh
 eK0DlznzjEHmugRWBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ob6-1vLWp10BiY-00vsd5; Sat, 25
 Apr 2026 00:19:01 +0200
Date: Sat, 25 Apr 2026 00:18:58 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>,
 u-boot@lists.denx.de
CC: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 00/12] arm64: FF-A runtime transport for EFI variables
User-Agent: Thunderbird for Android
In-Reply-To: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
Message-ID: <B8AF2367-CB21-4DAE-A4FF-3CCDB26E0322@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:esLfDvW+YEZ9NKKVJHHPvmIfQ46YTOnKBG2DCS4AjPEYyWiN1Jh
 M6N91yt4IteLA3cRQLQvyvV433YeJtovBsV1BFGxpuuhCIr1zYdvxM+XiC9rV28U6ru58kE
 F/B0uxMASPbmaQxOkRJa/vt9zPgJ9QjR02sSrVEUPPzxlTOPiuk7NgzdUi08X5fgS08lDQg
 TL5+GYiKKiVvXb4IsVQiA==
UI-OutboundReport: notjunk:1;M01:P0:deaKN19104s=;4sLUmiikglyy4oD+6Em4MOKoADE
 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
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

Am 24=2E April 2026 19:31:39 MESZ schrieb Harsimran Singh Tungal <harsimran=
singh=2Etungal@arm=2Ecom>:
>Hi all,
>
>This series adds FF-A runtime transport support so EFI variable runtime
>services can communicate with the secure world after ExitBootServices()=
=2E
>It also extends tests, docs, and board configs to validate the runtime
>path and keep boot=E2=80=91time behavior aligned with the runtime flow=2E

Hello Harsiman,

Could you, please, explain the motivation for the series=2E

What is the overall architecture?

Please, describe how to set up a system on QEMU to test your development i=
ncluding the instructions for the secure world=2E

We would need a test in the CI using QEMU=2E

Best regards

Heinrich


>
>Changes in this series:
>- Add EFI runtime-safe memset helper and FF-A runtime transport support=
=2E
>- Implement FF-A runtime communication in the EFI variable TEE backend=2E
>- Enable runtime variable operations and move helpers to avoid conflicts=
=2E
>- Add sandbox runtime transport tests and metadata reuse=2E
>- Extend EFI selftests for runtime variables and bootefi selftest config=
=2E
>- Document the FF-A runtime transport and selftest behavior=2E
>- Align boot=E2=80=91time cache maintenance with the runtime path=2E
>
>Harsimran Singh Tungal (12):
>  efi_loader: add runtime memset helper
>  arm-ffa: add FF-A bus runtime support
>  efi_loader: add FF-A runtime support in EFI variable TEE driver
>  efi_loader: enable EFI runtime SetVariable()/GetVariable() using FF-A
>    transport
>  efi_loader: move runtime GetVariable() helpers to efi_variable=2Ec
>  corstone1000: enable bootefi selftest
>  efi: selftest: add runtime variable tests with non-volatile storage
>  test: dm: add sandbox FF-A runtime transport tests
>  sandbox: ffa: share synthetic partition metadata via macros
>  doc: arm64: document FF-A runtime path for EFI variables
>  doc: bootefi: note two-phase runtime variables selftest
>  efi_loader: align FF-A cache maintenance with runtime path
>
> arch/sandbox/include/asm/sandbox_arm_ffa=2Eh    |  16 +-
> configs/corstone1000_defconfig                |   3 +
> doc/arch/arm64=2Effa=2Erst                        |  92 ++-
> doc/usage/cmd/armffa=2Erst                      |  11 +
> doc/usage/cmd/bootefi=2Erst                     |  12 +
> drivers/firmware/arm-ffa/Kconfig              |  11 +
> drivers/firmware/arm-ffa/Makefile             |   4 +-
> drivers/firmware/arm-ffa/arm-ffa-runtime=2Ec    | 287 ++++++++
> drivers/firmware/arm-ffa/arm-ffa-uclass=2Ec     | 111 +--
> drivers/firmware/arm-ffa/arm-ffa=2Ec            |  16 +-
> drivers/firmware/arm-ffa/ffa-emul-uclass=2Ec    |  48 +-
> include/arm_ffa=2Eh                             |  16 +-
> include/arm_ffa_priv=2Eh                        |  24 +-
> include/arm_ffa_runtime=2Eh                     | 183 +++++
> include/efi_loader=2Eh                          |   3 +
> lib/charset=2Ec                                 |   2 +-
> lib/efi_loader/efi_runtime=2Ec                  |  21 +
> lib/efi_loader/efi_var_common=2Ec               |  24 -
> lib/efi_loader/efi_variable=2Ec                 |  24 +
> lib/efi_loader/efi_variable_tee=2Ec             | 686 +++++++++++++++++-
> =2E=2E=2E/efi_selftest_variables_runtime=2Ec          | 106 ++-
> test/dm/Makefile                              |   3 +-
> test/dm/ffa=2Ec                                 |   6 +-
> test/dm/ffa_runtime=2Ec                         |  82 +++
> 24 files changed, 1602 insertions(+), 189 deletions(-)
> create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime=2Ec
> create mode 100644 include/arm_ffa_runtime=2Eh
> create mode 100644 test/dm/ffa_runtime=2Ec
>

