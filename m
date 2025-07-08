Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E80FC83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 03:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BC7783189;
	Tue,  8 Jul 2025 05:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bkzfWqeO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 059608319F; Tue,  8 Jul 2025 05:38:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F0FB83145
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 05:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751945892; x=1752550692; i=xypron.glpk@gmx.de;
 bh=V2+xDW8NyxpLv1/j5m4fZoepzfAXLX9t9LF2N+e2Hlc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=bkzfWqeO7E67WZL5EDV27EeOkPyAt55NWEuK6v9HyNdNAF5sG6t9nU4vvYBu3Umo
 OF2xbmSfTNwu4F0+P0vjBXulB9ef19/OGIzDpNy/ikuOyPQVCpWRg0z+JWEgloQ7v
 djr7+CAgUYtbukDDGEWsyrkgXhEpjT7aHPk8kslZRuZf0RYjIFZDfMCX+3PX/sAa7
 JIJVQdW2mR4x8Uj7R1hneDVKHGI87X/FSUwuduIji1pDUYmda50HyZ1pTS1H7z8PL
 Fs99uE72J/kIllbLWQGAOJYVKvgivJH4C03QAspnrM5Hh4fBHzEfHDqsicMORk2NY
 k451pmvZYvFoUlcAbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.111.61]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUmD-1uNl0e3L3v-00AMMX; Tue, 08
 Jul 2025 05:38:11 +0200
Date: Tue, 08 Jul 2025 05:38:10 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>, u-boot@lists.denx.de
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/1=5D_efi=3A_turn_on_EFI=5FDEBUG?=
 =?US-ASCII?Q?=5FSUPPORT_for_qemu_arm_and_arm64_target?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250707095322.30222-2-paulliu@debian.org>
References: <20250707095322.30222-1-paulliu@debian.org>
 <20250707095322.30222-2-paulliu@debian.org>
Message-ID: <8AF80705-BB09-4AAD-8604-3D967295AB30@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yx33xzG6HrabjUKTZTDvDtCgVyzLs2ezxgaONegA/npg7EvuwjM
 3xQ/pcE+HPhWr2FhVUuoHI9AtSoFiCaPsjX7oqoNxmL5QqYeRwmdlvUOpx0Ay7VKXPTiK65
 qMgJcXNRas4cOxVelTVj+PWrS/K6y2x7bc4lecsDzb/zMqJxoKw68tpZKnK0YDvSYHJY21G
 Mbp9DMSq+Yno7s4B8IYFA==
UI-OutboundReport: notjunk:1;M01:P0:bpM7yHlGpbs=;SPt6/nzd7BQ94VhnNNswqLbFavI
 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
 UrFuYuTnD6V7ytWLMp63EkVC/JdX591M=
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

Am 7=2E Juli 2025 11:53:22 MESZ schrieb "Ying-Chun Liu (PaulLiu)" <paulliu@=
debian=2Eorg>:
>Previously, EFI_DEBUG_SUPPORT was enabled across all platforms for
>CI build testing=2E With this commit, we are limiting its activation
>to qemu_arm64_defconfig and qemu_arm_defconfig only, which is
>sufficient for our current needs=2E

Was there a request to turn it off on other platforms?

Best regards=20

Heinrich


>
>Signed-off-by: Ying-Chun Liu (PaulLiu) <paulliu@debian=2Eorg>
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>Cc: Tom Rini <trini@konsulko=2Ecom>
>---
> configs/qemu_arm64_defconfig | 1 +
> configs/qemu_arm_defconfig   | 1 +
> lib/efi_loader/Kconfig       | 1 -
> 3 files changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
>index 39afb837e41=2E=2E54bf4646382 100644
>--- a/configs/qemu_arm64_defconfig
>+++ b/configs/qemu_arm64_defconfig
>@@ -15,6 +15,7 @@ CONFIG_ENV_ADDR=3D0x4000000
> CONFIG_PCI=3Dy
> CONFIG_DEBUG_UART=3Dy
> CONFIG_AHCI=3Dy
>+CONFIG_EFI_DEBUG_SUPPORT=3Dy
> CONFIG_EFI_HTTP_BOOT=3Dy
> CONFIG_FIT=3Dy
> CONFIG_FIT_SIGNATURE=3Dy
>diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
>index 92ba48f6af9=2E=2Eb1c277a86c0 100644
>--- a/configs/qemu_arm_defconfig
>+++ b/configs/qemu_arm_defconfig
>@@ -18,6 +18,7 @@ CONFIG_ENV_ADDR=3D0x4000000
> CONFIG_PCI=3Dy
> CONFIG_DEBUG_UART=3Dy
> CONFIG_AHCI=3Dy
>+CONFIG_EFI_DEBUG_SUPPORT=3Dy
> CONFIG_FIT=3Dy
> CONFIG_FIT_SIGNATURE=3Dy
> CONFIG_FIT_VERBOSE=3Dy
>diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>index 077466f01f0=2E=2Efdabe9cc278 100644
>--- a/lib/efi_loader/Kconfig
>+++ b/lib/efi_loader/Kconfig
>@@ -73,7 +73,6 @@ config EFI_SIGNATURE_SUPPORT
>=20
> config EFI_DEBUG_SUPPORT
> 	bool "EFI Debug Support"
>-	default y if !HAS_BOARD_SIZE_LIMIT
> 	help
> 	  Select this option if you want to setup the EFI Debug Support
> 	  Table and the EFI_SYSTEM_TABLE_POINTER which is used by the debug

