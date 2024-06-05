Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7A8C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 05:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 172BC8833B;
	Wed,  5 Jun 2024 07:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lCxHUHCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703BE88096; Wed,  5 Jun 2024 07:59:08 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F808751B
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 07:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717567143; x=1718171943; i=xypron.glpk@gmx.de;
 bh=t6K4QNTDvi7pAcNr3+zcJBzIot6choqjotVXo07ad+Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lCxHUHCc5ciWeeYMF2aK0x9tx+UR5tzGpy70QotWw/UE47TGOjZK4OqtA4P9DgRw
 oDLEU7PwD/rUxBbn73I/GH+oboNzqR9C7Swjej17EbHq+5h5UkR2mSHB650QEX3iL
 hFw2H0F+G0K6ggBugL/46xwnRX9sBIRj2NtVUPLzx2VzKyoDCD/EWcPQl1zf6vJDX
 a18zuQJdA5xiTeo86P00Ix9LzXH7AccC8W8e9JI24+micrfY6tqbplyLNLbfJcG1S
 LDe7oSl4Ig85V6IoVCw/D5WirSRJDws6yhywp022ZnrATWQX4Y/eEjLyaUWIXQDD/
 zOOuBAvnAZyz9orsJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.42.178.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ycr-1sBhXR4Bb9-0034KM; Wed, 05
 Jun 2024 07:59:03 +0200
Message-ID: <effa1116-0ad6-4cdc-a9d4-cf3cb1e309ef@gmx.de>
Date: Wed, 5 Jun 2024 07:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XFMKscn6hDI/sgt1UYimXLAZzV8pWemaP8ChwqmxuimmvxRNhfi
 7sN2HnttiLu2sXHiw8kcdkbaWvOaX6z4x5GvWQJRsaBosEmb2RhadAGsGirCRfjJVcV5ASJ
 8XuG2eq4b0nblYgX88iOOlNm3/f7CLWHgxQnVaJqzJVQT7MV3KzNVLvgLeMCJyQ1J9m42mB
 d9LK+prcZ5LPZMJKYdamg==
UI-OutboundReport: notjunk:1;M01:P0:ebGeDVRE7Zg=;jeyjEVsSeGV/nr962zm/pR13rUN
 8wR8p/sp+hZ2xPnhl8WvkdPuVLIOb2zrUcZb8xC41AzdLZaNGQtgQhJ5DsvgXxjbWVbqMygI2
 0v7ZsCUiiz6oyZahZD5krQsLpip+aJwAgOen27vecfyxcYTNgWgH2eDnuqLPNCPunvqLN3yvQ
 J9c9o3XAn2mqocrPKKHTH/koefxyMp11iHPBgHvyZnmqsWYoGZS4v0flbaws1d+q6On9LoOAE
 ril2z0gO7QommijR8AfqtI3uRnD/keLFIsXUoIj47DboBYweafiLbW9NXYHyTuNMvMKS9b9Y6
 GjtkP7Vclt+IEY2OFb+WQbrVspPY8Y9eoz4cg8R6nWyVSeC3FGVgn8YJiPUw4Bjl0psxE4ute
 ppn9//6gYI5+WnjjKdUW3POTrxupkyO5gzcMB1AkLWUIgde9b1VkQysemOGJGfEkuuIPW0g6Z
 nHiooNZcb2GYq19dQnzW3KNeVecvb/NF7rdR0OF9oRX/lM/+8sN72If0Rg64Ii6fNTAkA3bmB
 6PUX7kLduCUWgAqfuv9kD4Z1Va6e2uecyjPoYZTbRJ93RWy35EbYcUAUV0kA4UIbkVjY9kuDP
 6IO/FYvYCDiXAq1T4+wH8Pw5VDWNjTPvUwN1c7PRAbyhpv6iv6yRfwp0L8xOiHWrt3pWiK5t7
 PJMQyHbJxgawIsrFbYJ9fzSyvRhow+RFSOMTVolptl80AMgMi3dOcFMJg5yK8xNSKUIJR/Fdd
 LcuseUjjkLzcPRWvH7v2j2ZMsneKCoK+vzGNeYTGui1jyjRq7js0OUvFpPUxA8I80tIpqnLJU
 k1nPHEms5Fdv2Bm9I1u8C8iLwpGY95VaEY8V7XJQ5q/Hk=
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

On 5/31/24 15:50, Caleb Connolly wrote:
> As more boards adopt support for the EFI CapsuleUpdate mechanism, there
> is a growing issue of being able to target updates to them properly. The
> current mechanism of hardcoding UUIDs for each board at compile time is
> unsustainable, and maintaining lists of GUIDs is similarly cumbersome.
>
> In this series, I propose that we adopt v5 GUIDs, these are generated
> by using a well-known salt GUID as well as board specific information
> (like the model/revision), these are hashed together and the result is
> truncated to form a new UUID.
>
> The well-known salt GUID can be specific to the architecture (SoC
> vendor), or OEM. It is defined in the board defconfig so that vendors
> can easily bring their own.
>
> Specifically, the following fields are used to generate a GUID for a
> particular fw_image:
>
> * namespace salt
> * board compatible (usually the first entry in the dt root compatible
>    array).
> * fw_image name (the string identifying the specific image, especially
>    relevant for board that can update multiple images).
>
> =3D=3D Usage =3D=3D
>
> Boards can integrate dynamic UUID support as follows:
>
> 1. Adjust Kconfig to depend on EFI_CAPSULE_DYNAMIC_UUIDS if
>     EFI_HAVE_CAPSULE_SUPPORT.
> 2. Skip setting the fw_images image_type_id property.
> 3. Generate a UUID and set CONFIG_EFI_CAPSULE_NAMESPACE_UUID in your
>     defconfig.

Why should we have two alternatives?

If we have the dynamic UUIDs, please, get rid of static ones.

>
> =3D=3D Limitations =3D=3D
>
> * Changing GUIDs
>
> The primary limitation with this approach is that if any of the source
> fields change, so will the GUID for the board. It is therefore pretty
> important to ensure that GUID changes are caught during development.
>
> * Supporting multiple boards with a single image
>
> This now requires having an entry with the GUID for every board which
> might lead to larger UpdateCapsule images.

Do we have a test case were a capsule contains images that shall not be
installed?

>
> =3D=3D Tooling =3D=3D
>
> This series introduces a new tool: genguid. This can be used to generate
> the same GUIDs that the board would at runtime.

     the GUIDs that the board requires at runtime.

Best regards

Heinrich

>
> This series follows a related discussion started by Ilias:
> https://lore.kernel.org/u-boot/CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy=
72WkYLizrw@mail.gmail.com/
>
> ---
> Changes in v3:
> - Add manpage for genguid
> - Add dedicated CONFIG_TOOLS_GENGUID option
> - Minor code fixes addressing v2 feedback
> - Link to v2: https://lore.kernel.org/r/20240529-b4-dynamic-uuid-v2-0-c2=
6f31057bbe@linaro.org
>
> Changes in v2:
> - Move namespace UUID to be defined in defconfig
> - Add tests and tooling
> - Only use the first board compatible to generate UUID.
> - Link to v1: https://lore.kernel.org/r/20240426-b4-dynamic-uuid-v1-0-e8=
154e00ec44@linaro.org
>
> ---
> Caleb Connolly (7):
>        lib: uuid: add UUID v5 support
>        efi: add a helper to generate dynamic UUIDs
>        doc: uefi: document dynamic UUID generation
>        sandbox: switch to dynamic UUIDs
>        lib: uuid: supporting building as part of host tools
>        tools: add genguid tool
>        test: lib/uuid: add unit tests for dynamic UUIDs
>
>   arch/Kconfig                                       |   1 +
>   board/sandbox/sandbox.c                            |  16 ---
>   configs/sandbox_defconfig                          |   1 +
>   configs/sandbox_flattree_defconfig                 |   1 +
>   doc/develop/uefi/uefi.rst                          |  31 +++++
>   doc/genguid.1                                      |  52 +++++++
>   include/sandbox_efi_capsule.h                      |   6 +-
>   include/uuid.h                                     |  21 ++-
>   lib/Kconfig                                        |   8 ++
>   lib/efi_loader/Kconfig                             |  23 +++
>   lib/efi_loader/efi_capsule.c                       |   1 +
>   lib/efi_loader/efi_firmware.c                      |  66 +++++++++
>   lib/uuid.c                                         |  81 +++++++++--
>   test/lib/uuid.c                                    |  88 ++++++++++++
>   .../test_efi_capsule/test_capsule_firmware_fit.py  |   2 +-
>   .../test_efi_capsule/test_capsule_firmware_raw.py  |   8 +-
>   .../test_capsule_firmware_signed_fit.py            |   2 +-
>   .../test_capsule_firmware_signed_raw.py            |   4 +-
>   test/py/tests/test_efi_capsule/version.dts         |   6 +-
>   tools/Kconfig                                      |   7 +
>   tools/Makefile                                     |   3 +
>   tools/binman/etype/efi_capsule.py                  |   2 +-
>   tools/binman/ftest.py                              |   2 +-
>   tools/genguid.c                                    | 154 +++++++++++++=
++++++++
>   24 files changed, 538 insertions(+), 48 deletions(-)
> ---
> change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
> base-commit: 2e682a4a406fc81ef32e05c28542cc8067f1e15f
>
> // Caleb (they/them)
>

