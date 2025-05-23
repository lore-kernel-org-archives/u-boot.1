Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2E5C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E871D83479;
	Fri, 23 May 2025 18:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dFvmA7RQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92EF6832FE; Fri, 23 May 2025 16:19:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86CFA832D8
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 16:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748009948; x=1748614748; i=xypron.glpk@gmx.de;
 bh=LAYtzbc9tslmVqFTn46m/h7DoGG9fgLKMxY0qd+79A8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dFvmA7RQn74hmnj9SfqyQayn2lD3bIcUFrKVfxECJ3OXN+oys65+RU8rYchu3pR4
 vRXljiZguC2tZ2kMDjnTvpSQH0hg9nw6CvFq3yr1LYjbcVp5MLTO+eKAMu0OORmRQ
 WfQCSFncMitGAQwOn3iEiJghDhbcr6cuTrYDS+cU/s15mfERe4mwt7s0xobezdjB9
 1jlAg85Vz1UQOjQnWLQfWhVJKeawaQQoaRWY/w30keqMYKwzccmjHj8sEuLBJdITw
 1jzMmdGwnHxu1ntkbEVFPen6c1k356/SAMnADnvHLaZTr2C4jIPofaST/iIsssZxg
 wfq5+gP7yZ+D8vurig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRRT-1uQ1Kq3Ekt-00MyKC; Fri, 23
 May 2025 16:19:07 +0200
Message-ID: <3b23fc9d-345f-4945-b89d-153a18f5828d@gmx.de>
Date: Fri, 23 May 2025 16:18:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
To: Simon Glass <sjg@chromium.org>
Cc: Adriano Cordova <adrianox@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?Q?Christian_Kohlschu=CC=88tter?= <christian@kohlschutter.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Eddie James <eajames@linux.ibm.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, Janne Grunau <j@jannau.net>,
 Jeremy Compostella <jeremy.compostella@intel.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Moritz Fischer <moritzf@google.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Pawel Kochanowski <pkochanowski@sii.pl>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Yao Zi <ziyao@disroot.org>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250523130651.1329593-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250523130651.1329593-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m7ax18x+0eJ9koj0LLpq0et67fE04hx2ubq+bnEe6qHosxfkkYP
 5r0b9+Tijpfkf9W1c63XFWVJkuzhrRnIn2eagbjpdbuV8vb45A9+Agl+oqcknWqUSzt58Fa
 qjYQTShqWuIAfDTzHklAlSuTFrDNOb51th0AniYYGTXsm08HPmehVW3uXb7Ds+iKM1sMkSn
 iM9mdRWlLFrPUPuQy5VQA==
UI-OutboundReport: notjunk:1;M01:P0:6AkKJAwOKjo=;ewGHozieW0ZOiNOAYEhAGp/tbD/
 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
X-Mailman-Approved-At: Fri, 23 May 2025 18:56:12 +0200
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

On 23.05.25 15:06, Simon Glass wrote:
> Some functions provided in lib/efi_loader are actually useful for the
> app as well. This series refactors the Kconfig and directories a little
> so that code is easier to share.
>=20
> As a starting point, it moves some filename and device-path functions to
> the new directory.
>=20
> The next step would be to move device-path code over, but this will need
> some discussion.

Hello Simon,

Overall the ideas in this series look fine to me. But this series does=20
not apply to origin/next.

Applying: efi_loader: Separate device path into its own header
Patch failed at 0001 efi_loader: Separate device path into its own header
error: patch failed: cmd/efidebug.c:8
error: cmd/efidebug.c: patch does not apply
error: patch failed: include/efi_loader.h:967
error: include/efi_loader.h: patch does not apply
error: patch failed: lib/efi_loader/efi_bootmgr.c:12
error: lib/efi_loader/efi_bootmgr.c: patch does not apply
error: patch failed: lib/efi_loader/efi_device_path.c:10
error: lib/efi_loader/efi_device_path.c: patch does not apply
error: patch failed: lib/efi_loader/efi_helper.c:6
error: lib/efi_loader/efi_helper.c: patch does not apply

Please, resend the series based on origin/next.

Patches that are not based on upstream U-Boot cannot be reviewed via=20
this mailing list.

Best regards

Heinrich

>=20
>=20
> Simon Glass (10):
>    efi_loader: Separate device path into its own header
>    efi: Include device-path functions in the EFI API docs
>    efi: Rename END to EFI_DP_END
>    efi: Rename the lib/efi directory
>    efi: Rename CONFIG_EFI to CONFIG_EFI_CLIENT
>    efi: Create a new CONFIG_EFI
>    efi: Update maintainers for EFI_CLIENT
>    efi: Move the base name and PXE info into lib/efi
>    efi: Adjust copyright and mention constant source
>    efi: Move FDT-filename discovery into lib/efi
>=20
>   MAINTAINERS                                |   5 +-
>   Makefile                                   |   4 +-
>   arch/arm/include/asm/global_data.h         |   2 +-
>   arch/x86/Kconfig                           |   6 +-
>   arch/x86/cpu/Makefile                      |   2 +-
>   arch/x86/cpu/efi/Kconfig                   |   2 +-
>   arch/x86/cpu/x86_64/Makefile               |   2 +-
>   cmd/Makefile                               |   2 +-
>   cmd/bootefi.c                              |   1 +
>   cmd/eficonfig.c                            |   5 +-
>   cmd/efidebug.c                             |   7 +-
>   cmd/part_find.c                            |  10 +-
>   configs/efi-arm_app64_defconfig            |   2 +-
>   configs/efi-x86_app32_defconfig            |   2 +-
>   configs/efi-x86_app64_defconfig            |   2 +-
>   configs/efi-x86_payload32_defconfig        |   2 +-
>   configs/efi-x86_payload64_defconfig        |   2 +-
>   doc/api/efi.rst                            |   6 +
>   doc/develop/uefi/u-boot_on_efi.rst         |  18 +-
>   drivers/block/Kconfig                      |   2 +-
>   include/efi_device_path.h                  | 420 +++++++++++++++++++++
>   include/efi_loader.h                       |  57 +--
>   include/init.h                             |   2 +-
>   lib/Kconfig                                |   2 +-
>   lib/Makefile                               |   1 +
>   lib/efi/Kconfig                            |  86 +----
>   lib/efi/Makefile                           |  28 +-
>   lib/efi/basename.c                         | 153 ++++++++
>   lib/efi_client/Kconfig                     |  83 ++++
>   lib/efi_client/Makefile                    |  28 ++
>   lib/{efi =3D> efi_client}/efi.c              |   0
>   lib/{efi =3D> efi_client}/efi_app.c          |   0
>   lib/{efi =3D> efi_client}/efi_app_init.c     |   0
>   lib/{efi =3D> efi_client}/efi_dtb.S          |   0
>   lib/{efi =3D> efi_client}/efi_info.c         |   0
>   lib/{efi =3D> efi_client}/efi_stub_arm64.c   |   0
>   lib/{efi =3D> efi_client}/efi_stub_x86.c     |   0
>   lib/{efi =3D> efi_client}/efi_vars.c         |   0
>   lib/{efi =3D> efi_client}/sdram.c            |   0
>   lib/efi_driver/efi_uclass.c                |   1 +
>   lib/efi_loader/Kconfig                     |   3 +
>   lib/efi_loader/efi_bootbin.c               |   1 +
>   lib/efi_loader/efi_bootmgr.c               |   4 +-
>   lib/efi_loader/efi_boottime.c              |   1 +
>   lib/efi_loader/efi_capsule.c               |   1 +
>   lib/efi_loader/efi_console.c               |   1 +
>   lib/efi_loader/efi_device_path.c           | 175 +++------
>   lib/efi_loader/efi_device_path_utilities.c |   3 +-
>   lib/efi_loader/efi_disk.c                  |   1 +
>   lib/efi_loader/efi_fdt.c                   |  64 +---
>   lib/efi_loader/efi_helper.c                |  81 +---
>   lib/efi_loader/efi_net.c                   |   1 +
>   lib/efi_loader/efi_tcg2.c                  |   1 +
>   lib/uuid.c                                 |   4 +-
>   test/lib/efi_device_path.c                 |   1 +
>   55 files changed, 814 insertions(+), 473 deletions(-)
>   create mode 100644 include/efi_device_path.h
>   create mode 100644 lib/efi/basename.c
>   create mode 100644 lib/efi_client/Kconfig
>   create mode 100644 lib/efi_client/Makefile
>   rename lib/{efi =3D> efi_client}/efi.c (100%)
>   rename lib/{efi =3D> efi_client}/efi_app.c (100%)
>   rename lib/{efi =3D> efi_client}/efi_app_init.c (100%)
>   rename lib/{efi =3D> efi_client}/efi_dtb.S (100%)
>   rename lib/{efi =3D> efi_client}/efi_info.c (100%)
>   rename lib/{efi =3D> efi_client}/efi_stub_arm64.c (100%)
>   rename lib/{efi =3D> efi_client}/efi_stub_x86.c (100%)
>   rename lib/{efi =3D> efi_client}/efi_vars.c (100%)
>   rename lib/{efi =3D> efi_client}/sdram.c (100%)
>=20

