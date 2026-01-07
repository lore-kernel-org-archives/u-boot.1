Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4927DCF6BE2
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 03:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6DE83C6E;
	Wed,  7 Jan 2026 04:46:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="D2W4GHts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7C2183CDC; Wed,  7 Jan 2026 04:46:14 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDDBC83C4B
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 04:46:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767757567; x=1768362367; i=xypron.glpk@gmx.de;
 bh=tYXXPscFXGTL1SE5w6fbAfuTa2sSIAOBBHW14SN4fpI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=D2W4GHtsfqUuPbQATyOWK968GD/2Cdb9Fo0BKKOTmONNXzK/n6OsVm6AMKxjDfo8
 /njvo0ozx3iPYA/6VphcaNU/hs1/Ch+p46ES6699T8VjRynpAmNuGk4AzWMO0OeRL
 8qFfNbDYQj+Bl3ZTtaFecb/ElynTqIIBw3uKfb6gsaVNsxNy2erL0SL6g4+srcikU
 Lul6vMANQxzxrRlsT1duY0928dfWQ+rWVVcw9lC6YXZhx+rdjkt9oyI5bfQF0cMSv
 CdSF0Wi4xbRKPP1UHvyWH9GEbjdS8cvR5QwBAujgPaJW1u3xkD2/PRy4J2ibyzsmJ
 GCJJXCSqfjxwwYkEDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXd2-1vHnCP0eZu-00JEGp; Wed, 07
 Jan 2026 04:46:07 +0100
Date: Wed, 07 Jan 2026 04:46:04 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Raymond Mao <raymondmaoca@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: Re: [PATCH 09/10] efi: Drop EFI_GRUB_ARM32_WORKAROUND
User-Agent: Thunderbird for Android
In-Reply-To: <20260107003131.3064800-10-simon.glass@canonical.com>
References: <20260107003131.3064800-1-simon.glass@canonical.com>
 <20260107003131.3064800-10-simon.glass@canonical.com>
Message-ID: <57EAA792-D01D-4D72-BA46-259C8E0A7D32@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q0FnaM/hKyfksF9506KcjlsfcN5gdQch6ralRbWB48JunzHM+Az
 DyppnRDQuaWVpAQgfP/2QyDw6SZO5/Xo2iu/4tmQuq/jJcHKoAcwIpagEc7J1LWutn+/BZz
 5cFFpB7ckqcgOVbPE9pmOiMKwlmKa9p+2xtsSHsJiL2np+24eWghPSB0i65uAL5tl1yOq6J
 z+Y3BOk0Dsy4/0BZJHQ6w==
UI-OutboundReport: notjunk:1;M01:P0:Mq+GBFKtOcA=;+CByeK027BDJwzafJUwXfgmyv3L
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

Am 7=2E Januar 2026 01:31:26 MEZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>From: Simon Glass <sjg@chromium=2Eorg>
>
>This work-around dates from 2019 and grub 2=2E04 which is quite old=2E Ne=
w
>builds of grub don't have the problem and old boards presumably use an
>older U-Boot, so don't need this=2E

Where do you disable caches that are not managed by CP15?

Best regards

Heinrich


>
>Drop it=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>Signed-off-by: Simon Glass <simon=2Eglass@canonical=2Ecom>
>---
>
> configs/mt7623n_bpir2_defconfig |  1 -
> lib/efi_loader/Kconfig          | 10 ----------
> lib/efi_loader/efi_boottime=2Ec   | 26 --------------------------
> 3 files changed, 37 deletions(-)
>
>diff --git a/configs/mt7623n_bpir2_defconfig b/configs/mt7623n_bpir2_defc=
onfig
>index 404380558f2=2E=2Ed75168a72ed 100644
>--- a/configs/mt7623n_bpir2_defconfig
>+++ b/configs/mt7623n_bpir2_defconfig
>@@ -13,7 +13,6 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"mt7623n-bananapi-bpi-r2"
> CONFIG_TARGET_MT7623=3Dy
> CONFIG_SYS_BOOTM_LEN=3D0x4000000
> CONFIG_SYS_LOAD_ADDR=3D0x84000000
>-# CONFIG_EFI_GRUB_ARM32_WORKAROUND is not set
> CONFIG_FIT=3Dy
> CONFIG_FIT_VERBOSE=3Dy
> CONFIG_DISTRO_DEFAULTS=3Dy
>diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>index 13e44be1d06=2E=2E5585c841c27 100644
>--- a/lib/efi_loader/Kconfig
>+++ b/lib/efi_loader/Kconfig
>@@ -505,16 +505,6 @@ config EFI_LOADER_BOUNCE_BUFFER
> 	  hardware we can create a bounce buffer so that payloads don't have to
> 	  worry about platform details=2E
>=20
>-config EFI_GRUB_ARM32_WORKAROUND
>-	bool "Workaround for GRUB on 32bit ARM"
>-	default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
>-	default y
>-	depends on ARM && !ARM64
>-	help
>-	  GRUB prior to version 2=2E04 requires U-Boot to disable caches=2E Thi=
s
>-	  workaround currently is also needed on systems with caches that
>-	  cannot be managed via CP15=2E
>-
> config EFI_ESRT
> 	bool "Enable the UEFI ESRT generation"
> 	depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT
>diff --git a/lib/efi_loader/efi_boottime=2Ec b/lib/efi_loader/efi_boottim=
e=2Ec
>index 0bc66ee61a8=2E=2Ec31ee53cde6 100644
>--- a/lib/efi_loader/efi_boottime=2Ec
>+++ b/lib/efi_loader/efi_boottime=2Ec
>@@ -2139,29 +2139,6 @@ error:
> 	return EFI_EXIT(ret);
> }
>=20
>-/**
>- * efi_exit_caches() - fix up caches for EFI payloads if necessary
>- */
>-static void efi_exit_caches(void)
>-{
>-#if defined(CONFIG_EFI_GRUB_ARM32_WORKAROUND)
>-	/*
>-	 * Boooting Linux via GRUB prior to version 2=2E04 fails on 32bit ARM i=
f
>-	 * caches are enabled=2E
>-	 *
>-	 * TODO:
>-	 * According to the UEFI spec caches that can be managed via CP15
>-	 * operations should be enabled=2E Caches requiring platform informatio=
n
>-	 * to manage should be disabled=2E This should not happen in
>-	 * ExitBootServices() but before invoking any UEFI binary is invoked=2E
>-	 *
>-	 * We want to keep the current workaround while GRUB prior to version
>-	 * 2=2E04 is still in use=2E
>-	 */
>-	cleanup_before_linux();
>-#endif
>-}
>-
> /**
>  * efi_exit_boot_services() - stop all boot services
>  * @image_handle: handle of the loaded image
>@@ -2245,9 +2222,6 @@ static efi_status_t EFIAPI efi_exit_boot_services(e=
fi_handle_t image_handle,
> 	/* Patch out unsupported runtime function */
> 	efi_runtime_detach();
>=20
>-	/* Fix up caches for EFI payloads if necessary */
>-	efi_exit_caches();
>-
> 	/* Disable boot time services */
> 	systab=2Econ_in_handle =3D NULL;
> 	systab=2Econ_in =3D NULL;

