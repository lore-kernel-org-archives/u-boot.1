Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09899E9A047
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 20:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 554F983AC5;
	Tue, 17 Feb 2026 21:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="isL6Qu9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53BBD83B99; Tue, 17 Feb 2026 21:14:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5234A83981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 21:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1771359250; x=1771964050; i=xypron.glpk@gmx.de;
 bh=pjh4aJAgitbvDwGuRdyHX++50MAa3avCtOOJALoN5ao=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=isL6Qu9lJWSCoJ7lpCBLaH/PU8ITptplkdWj/NSL16h3s+RtIWiWYDlxiwCGUrSc
 JvTDGqu5IFQofshAd9HtR3MTPjeuaqF8Kfwtf6mQZT+bQ3ea6ydh/Zfs9jAtKe0d3
 vLFa2WhCw5wjWYcOWvIYGz35ao+wikYGtwAIEefNPCzTS7ZX9WKPQXO3iKiPO6Ux+
 WHnwU8/1w2z7Xyskqiec1jzjRL+Bd/7blBCNqPcjvgjlAcy1/H3zEFuLnoVLrgkuQ
 NPC3B5z8x4xGFfRPjJ57Yb1UBCnsnCVJCSiUukWOfcuYqB7VEMnNg4iFUTIFyFMu+
 f6fJGhO05/QUDUIWdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeR1-1wFFfm1sdn-00VaE8; Tue, 17
 Feb 2026 21:14:10 +0100
Date: Tue, 17 Feb 2026 21:14:03 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, u-boot@lists.denx.de,
 sumit.garg@kernel.org, casey.connolly@linaro.org, u-boot-qcom@groups.io
CC: trini@konsulko.com, ilias.apalodimas@linaro.org, sjg@chromium.org,
 michal.simek@amd.com, gabriel.dalimonte@gmail.com, jan.kiszka@siemens.com,
 paul.liu@linaro.org, j-humphreys@ti.com, neil.armstrong@linaro.org,
 me@samcday.com, marek.vasut+renesas@mailbox.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/2=5D_firmware=3A_psci=3A_Re?=
 =?US-ASCII?Q?factor_EFI_runtime_PSCI_reset_handling?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260213110527.1254098-2-aswin.murugan@oss.qualcomm.com>
References: <20260213110527.1254098-1-aswin.murugan@oss.qualcomm.com>
 <20260213110527.1254098-2-aswin.murugan@oss.qualcomm.com>
Message-ID: <CC8AE9C0-F7DA-4EED-BCA0-F739BF75ADB5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jy61/ofG03HKT4aKzNjmoTi7F/FbkUvqJwVsqxRB8a1tITWl/H1
 14Xo5TA6NgzskNjzVpW2XOgDauv5Fhioas3hQBK0B7MyRNZlKrb7NhkzUAk9wi5+AhJQ8VQ
 O0880TiYhpWESVowIL14skbfEgGI73MlnPeZq6vt7C7sYPgz0OUKWMEUpWlDyoowwTtoZGH
 BmSth/eiqcn3BarAf/3KQ==
UI-OutboundReport: notjunk:1;M01:P0:NwcjxoGK2ME=;sYXugqKh5W5V+tWCSTjxw1aLp6o
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

Am 13=2E Februar 2026 12:05:26 MEZ schrieb Aswin Murugan <aswin=2Emurugan@o=
ss=2Equalcomm=2Ecom>:
>The current PSCI-based EFI runtime reset implementation is always enabled
>when CONFIG_PSCI_RESET is set, but it does not support the extra argument=
s
>required for specialized reset modes=2E As a result, reboot requests such=
 as
>bootloader mode or EDL mode are ignored and fall back to a normal reboot=
=2E

Are the "specialized" reset modes defined in the PSCI specification or at =
least compliant to it? Where can I find the description of these reset mode=
s=2E

If you don't want to use U-Boot's PSCI implementation, why don't you simpl=
y disable the PSCI driver?

>
>Add CONFIG_EFI_PSCI_RESET_RUNTIME to give platforms explicit control over
>the PSCI-specific EFI runtime reset path=2E This allows a platform to dis=
able
>U-Boot's PSCI reset handler when needed so that the kernel can perform th=
e
>reset with the correct arguments for special reboot modes=2E
>
>The option defaults to enabled to maintain backward compatibility with th=
e
>existing behavior=2E
>
>Signed-off-by: Aswin Murugan <aswin=2Emurugan@oss=2Equalcomm=2Ecom>
>---
>Changes in v3:
>- Commit message has been updated, no change in code
>
>Changes in v2:
>- As per review comments made default y for EFI_PSCI_RESET_RUNTIME config
>---
> drivers/firmware/psci=2Ec | 4 ++--
> lib/efi_loader/Kconfig  | 8 ++++++++
> 2 files changed, 10 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/firmware/psci=2Ec b/drivers/firmware/psci=2Ec
>index 2e3223e1c32=2E=2E009c6153d0c 100644
>--- a/drivers/firmware/psci=2Ec
>+++ b/drivers/firmware/psci=2Ec
>@@ -244,7 +244,7 @@ static void __maybe_unused do_psci_probe(void)
> 	uclass_get_device_by_name(UCLASS_FIRMWARE, DRIVER_NAME, &dev);
> }
>=20
>-#if IS_ENABLED(CONFIG_EFI_LOADER) && IS_ENABLED(CONFIG_PSCI_RESET)
>+#if IS_ENABLED(CONFIG_EFI_PSCI_RESET_RUNTIME)
> efi_status_t efi_reset_system_init(void)
> {
> 	do_psci_probe();
>@@ -266,7 +266,7 @@ void __efi_runtime EFIAPI efi_reset_system(enum efi_r=
eset_type reset_type,
> 	while (1)
> 		;
> }
>-#endif /* IS_ENABLED(CONFIG_EFI_LOADER) && IS_ENABLED(CONFIG_PSCI_RESET)=
 */
>+#endif /* IS_ENABLED(CONFIG_EFI_PSCI_RESET_RUNTIME) */
>=20
> #ifdef CONFIG_PSCI_RESET
> void reset_misc(void)
>diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>index 13e44be1d06=2E=2E3882de273bb 100644
>--- a/lib/efi_loader/Kconfig
>+++ b/lib/efi_loader/Kconfig
>@@ -106,6 +106,14 @@ config EFI_HAVE_RUNTIME_RESET
> 	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
> 		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
>=20
>+config EFI_PSCI_RESET_RUNTIME
>+	bool "EFI Runtime PSCI Reset Support"
>+	default y if EFI_LOADER && PSCI_RESET
>+	depends on ARM_PSCI_FW
>+	help
>+	  Enable PSCI-based reset implementation for EFI runtime services=2E
>+	  This allows the OS to reset the system through EFI runtime calls=2E
>+
> endmenu
>=20
> menu "UEFI Variables"

