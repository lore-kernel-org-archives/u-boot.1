Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D10E7E369
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 10:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE0F38382A;
	Fri,  3 Apr 2026 12:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AXkewkFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0936483CF5; Fri,  3 Apr 2026 12:30:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE5F68341A
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 12:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775212213; x=1775817013; i=xypron.glpk@gmx.de;
 bh=N6P+bjVJ7Ugp9mjtoqJ8jOla6MOr0NsCwvk+TCOPoo4=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=AXkewkFMfB82h20t5kbElRRwUzMFLHkEudDFCxY0dw/zXtMhrUdp09nJxWzNaUCb
 9GsM9AI/oYiIFJoe/EWyxzCp0hllfaZrXPEOSxZqfUu2KLy9e0veclKqTeEJK0pqQ
 LXbNBl+E7YRNOLA5dbHw7lytZk1gFPcbkXVFR/ya2iJRWp2zmM4JDd0pKgLQY2bqZ
 s1Q1Ev7d76pXORYdUQxOQA7LZSEankowgiUIHVfxvdLsnG0d+yDueSlRf28UiqXKF
 Oi0ivPVJY8PvHcg+0lfVHILDkC70A35vln4s6vfykEX7JNVP7K8OXH4Zfslu/jkOQ
 Zjed3XS2gF4FFglUZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bSj-1vPkb00ySh-012CZF; Fri, 03
 Apr 2026 12:30:13 +0200
Date: Fri, 03 Apr 2026 12:30:08 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Gary Guo <gary@garyguo.net>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 David Zang <davidzangcs@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Simon Glass <sjg@chromium.org>,
 Javier Tia <javier.tia@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH] efi_loader: support EFI_OS_INDICATIONS_BOOT_TO_FW_UI
User-Agent: Thunderbird for Android
In-Reply-To: <20260331191853.44549-1-gary@garyguo.net>
References: <20260331191853.44549-1-gary@garyguo.net>
Message-ID: <4C76330D-3EE4-4505-AB3B-9E89A3A4B18C@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qMAX0jccsgOpOYte1JuN+57av2EBUTISggmLE4ozJYgemOEN5Cf
 h/Bf9+OWCWi16Bca7bpVQC9ZtYcOuAmGcsFu7qL1CF5RF3372bQ1TSO9CKV42EhiwRnFmoJ
 1lkUR8mE2yeeHYKONoFwJFuT7Q2VT88L3qnHjbblyK8JW61YzHYNHmUOiprm78QhKZT5jNb
 7TP/ot+eEe4WlXAvTl0dw==
UI-OutboundReport: notjunk:1;M01:P0:73+thcpcAaI=;+L1VhJNW1mh4ZRKmjbo81HpnxWY
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

Am 31=2E M=C3=A4rz 2026 21:18:51 MESZ schrieb Gary Guo <gary@garyguo=2Enet>=
:
>EFI variable OsIndications have a bit EFI_OS_INDICATIONS_BOOT_TO_FW_UI
>indicating that the OS (or next stage bootloader) requests booting into
>firmware UI instead of continuing autoboot process=2E
>
>Support it by having autoboot=2Ec asking EFI bootmgr if boot should conti=
nue,
>which checks and clear the bit (so the next boot continue as normal)=2E
>
>With this change, systemd-boot will show a "Reboot Into Firmware Interfac=
e"
>option which will be able to drop back to u-boot=2E This can be useful if
>bootdelay is configured to be -2=2E
>
>Signed-off-by: Gary Guo <gary@garyguo=2Enet>

Thank you Gary for the patch=2E I am currently on travel and will have to =
look at it once I have returned=2E

@Ilias
Should we preferably integrate the detection of this bit into efi_init_ear=
ly()?

Best regards

Heinrich



>---
> common/autoboot=2Ec            |  4 +++-
> include/efi_loader=2Eh         |  2 ++
> lib/efi_loader/efi_bootmgr=2Ec | 45 ++++++++++++++++++++++++++++++++++++
> lib/efi_loader/efi_setup=2Ec   |  4 ++++
> 4 files changed, 54 insertions(+), 1 deletion(-)
>
>diff --git a/common/autoboot=2Ec b/common/autoboot=2Ec
>index 1783ef92c94c=2E=2Eb889407612dc 100644
>--- a/common/autoboot=2Ec
>+++ b/common/autoboot=2Ec
>@@ -11,6 +11,7 @@
> #include <cli=2Eh>
> #include <command=2Eh>
> #include <console=2Eh>
>+#include <efi_loader=2Eh>
> #include <env=2Eh>
> #include <errno=2Eh>
> #include <fdtdec=2Eh>
>@@ -503,7 +504,8 @@ void autoboot_command(const char *s)
> {
> 	debug("### main_loop: bootcmd=3D\"%s\"\n", s ? s : "<UNDEFINED>");
>=20
>-	if (s && (stored_bootdelay =3D=3D -2 ||
>+	if (s && !(IS_ENABLED(CONFIG_EFI_BOOTMGR) && efi_should_abort_autoboot(=
)) &&
>+	    (stored_bootdelay =3D=3D -2 ||
> 		 (stored_bootdelay !=3D -1 && !abortboot(stored_bootdelay)))) {
> 		bool lock;
> 		int prev;
>diff --git a/include/efi_loader=2Eh b/include/efi_loader=2Eh
>index 3e70ac070550=2E=2E449697ad13b3 100644
>--- a/include/efi_loader=2Eh
>+++ b/include/efi_loader=2Eh
>@@ -583,6 +583,8 @@ efi_status_t efi_bootmgr_get_unused_bootoption(u16 *b=
uf,
> efi_status_t efi_bootmgr_update_media_device_boot_option(void);
> /* Delete selected boot option */
> efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
>+/* Check if autoboot should be aborted based on EFI vars */
>+bool efi_should_abort_autoboot(void);
> /* Invoke EFI boot manager */
> efi_status_t efi_bootmgr_run(void *fdt);
> /* search the boot option index in BootOrder */
>diff --git a/lib/efi_loader/efi_bootmgr=2Ec b/lib/efi_loader/efi_bootmgr=
=2Ec
>index a687f4d8e85c=2E=2E39f255ac9de4 100644
>--- a/lib/efi_loader/efi_bootmgr=2Ec
>+++ b/lib/efi_loader/efi_bootmgr=2Ec
>@@ -1290,6 +1290,51 @@ out:
> 	return ret;
> }
>=20
>+/**
>+ * efi_should_abort_autoboot() - check if autoboot should be aborted per=
 EFI vars
>+ *
>+ * Return:	true if autoboot should abort
>+ */
>+bool efi_should_abort_autoboot(void)
>+{
>+	efi_status_t ret;
>+	u64 os_indications =3D 0x0;
>+	efi_uintn_t size;
>+	efi_status_t r;
>+
>+	/* Initialize EFI drivers */
>+	ret =3D efi_init_obj_list();
>+	if (ret !=3D EFI_SUCCESS) {
>+		log_err("Error: Cannot initialize UEFI sub-system, r =3D %lu\n",
>+			ret & ~EFI_ERROR_MASK);
>+		return false;
>+	}
>+
>+	size =3D sizeof(os_indications);
>+	r =3D efi_get_variable_int(u"OsIndications", &efi_global_variable_guid,
>+				 NULL, &size, &os_indications, NULL);
>+	if (r !=3D EFI_SUCCESS || size !=3D sizeof(os_indications))
>+		return false;
>+
>+	if (!(os_indications & EFI_OS_INDICATIONS_BOOT_TO_FW_UI))
>+		return false;
>+
>+	/* Clear the BOOT_TO_FW_UI so next boot returns to normal */
>+	os_indications &=3D ~EFI_OS_INDICATIONS_BOOT_TO_FW_UI;
>+	r =3D efi_set_variable_int(u"OsIndications",
>+				 &efi_global_variable_guid,
>+				 EFI_VARIABLE_NON_VOLATILE |
>+				 EFI_VARIABLE_BOOTSERVICE_ACCESS |
>+				 EFI_VARIABLE_RUNTIME_ACCESS,
>+				 sizeof(os_indications),
>+				 &os_indications, false);
>+
>+	if (r !=3D EFI_SUCCESS)
>+		log_err("Setting %ls failed\n", L"OsIndications");
>+
>+	return true;
>+}
>+
> /**
>  * efi_bootmgr_run() - execute EFI boot manager
>  * @fdt:	Flat device tree
>diff --git a/lib/efi_loader/efi_setup=2Ec b/lib/efi_loader/efi_setup=2Ec
>index f06cf49e4435=2E=2E0ad02e9fe0dd 100644
>--- a/lib/efi_loader/efi_setup=2Ec
>+++ b/lib/efi_loader/efi_setup=2Ec
>@@ -156,6 +156,10 @@ static efi_status_t efi_init_os_indications(void)
> {
> 	u64 os_indications_supported =3D 0;
>=20
>+	if (IS_ENABLED(CONFIG_EFI_BOOTMGR))
>+		os_indications_supported |=3D
>+			EFI_OS_INDICATIONS_BOOT_TO_FW_UI;
>+
> 	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> 		os_indications_supported |=3D
> 			EFI_OS_INDICATIONS_CAPSULE_RESULT_VAR_SUPPORTED;

