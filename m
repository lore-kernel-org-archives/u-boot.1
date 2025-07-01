Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74030C8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 07:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B0181FEE;
	Tue,  1 Jul 2025 09:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TJxZFjDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CF2382ADA; Tue,  1 Jul 2025 09:32:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B220A8006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 09:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751355125; x=1751959925; i=xypron.glpk@gmx.de;
 bh=WGB1Ar1TQaAcrxNtF8d9pCEdtvAh216Ty+5ox/7Qi68=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=TJxZFjDgFqDJJiA9Mj7kcIe/dHpdlcVOh3twcMa4NrO0abiOM9ZvZ/EVCuE6pIqM
 xZaGXPkgXSR6olK7zd33E8eluvMRxNyZfqgZu1gbJTY/UbeRIJ6aVExzbAI+Osfsm
 ilQqA+kE6Qzeh2SU+pg/ZHi/cTzw38Dvx4t+pkXIopfGCq6LHwEiTATmxWBW0kcKD
 +zQ3FjD66lTN/ohGNby2CkTgpMI4cZ7q6630cbqfu4mUKk0oFpOD4qP6AX3idr+A6
 5kJZR9EXjiifMhqtwIRxazYrufmVyaFD1ISzkVWXZY3r1pibFb6jqAY6ovwvdBT/q
 8wzP38t92arcfyy2VQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8obG-1ukEOB10Ok-00vqen; Tue, 01
 Jul 2025 09:32:05 +0200
Message-ID: <0ae877bb-c168-4533-bd35-b3d5cc55eaf3@gmx.de>
Date: Tue, 1 Jul 2025 09:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] configs: sandbox_defconfig: enable
 CONFIG_EFI_DEBUG_SUPPORT
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250701034926.83536-1-paulliu@debian.org>
 <20250701034926.83536-7-paulliu@debian.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250701034926.83536-7-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3iKiQ0/69t+W0YE1fMX0x76oa+JXCRXUMSGzd4JdHAJCaca3agp
 T7tQpxb9uRAcAUw0te9xgPnK0rTB1wJKUOThfgcN548VBpQyF+117+vwnZe02M/qwBibvol
 2qkR2+ziF43MGp6cteOYajNSidiu7QwnISGHYtL3uv/beRTrsuaWTX2CiYP5kSJ6WbPCsfK
 5Wp5rj9naIhbSi1EfAFrQ==
UI-OutboundReport: notjunk:1;M01:P0:Gb4BZ2pesvU=;1CgqHlLKMV+A3lkUImPIBqFs6/J
 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
 ek8St7ohrl1Ez1khykcXmtU=
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

On 01.07.25 05:49, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>=20
> Enable CONFIG_EFI_DEBUG_SUPPORT so that we can run a build test for
> this config.

It is not enough to build only on 64bit. qemu_arm_defconfig showed this=20
problem:

lib/efi_loader/efi_debug_support.c: In function=20
=E2=80=98efi_initialize_system_table_pointer=E2=80=99:
lib/efi_loader/efi_debug_support.c:48:49: warning: cast from pointer to=20
integer of different size [-Wpointer-to-int-cast]
    48 |         systab_pointer->efi_system_table_base =3D=20
(efi_physical_addr_t)&systab;
       |

Either enable in multiple defconfigs or maybe use

     default y if !HAS_BOARD_SIZE_LIMIT

in the Kconfig file.

Best regards

Heinrich

>=20
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> V7: enable CONFIG_EFI_DEBUG_SUPPORT for sandbox_defconfig
> ---
>   configs/sandbox_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 4f6943d1a4b..c50746d3dbc 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -10,6 +10,7 @@ CONFIG_PCI=3Dy
>   CONFIG_DEBUG_UART=3Dy
>   CONFIG_SYS_MEMTEST_START=3D0x00100000
>   CONFIG_SYS_MEMTEST_END=3D0x00101000
> +CONFIG_EFI_DEBUG_SUPPORT=3Dy
>   CONFIG_EFI_SECURE_BOOT=3Dy
>   CONFIG_EFI_RT_VOLATILE_STORE=3Dy
>   CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=3Dy

