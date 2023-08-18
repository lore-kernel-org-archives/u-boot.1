Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FD8C71132
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 01:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79ACA86C26;
	Fri, 18 Aug 2023 03:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rHwjcLv5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 992B286C27; Fri, 18 Aug 2023 03:35:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 062C286C23
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 03:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692322515; x=1692927315; i=xypron.glpk@gmx.de;
 bh=PMCAq0hGumekhwcw/Wp1ITDlC5nPGqBDoTNAr9uZy2c=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=rHwjcLv5Flylryga0c0olVdRi7hYa3mwRGyV2P5BLX5FeGgJR0/zrJtWhEczgaX1rNHyXtt
 QFpebcQ5HH0WEebkD2/kmzcA23KJkELaEaWyYgkjJDLzUNScy9i4G7ylnRKt/9tCCB5pNZCAR
 zWGGgYlBscnD3+JiW5wvZtA3vbcuzklvyK7F2/HWb265zdROu9xqJJq9EW+ghxA++dRrJVW1r
 rHCfxxbiEO/T5hNP/DBluLdZuFyT79WpHMbNzFACOdPEgI5Jamef796XsPi6AGrCTg9wvpdMS
 E3v+XccUP/kTMaEOM22wAX/XRN0XDjuvVgBmZRqQ3ngnyA96qHaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([62.143.244.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK4Z-1pg5HW2bDN-00rH8i; Fri, 18
 Aug 2023 03:35:15 +0200
Date: Fri, 18 Aug 2023 03:35:18 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_11/20=5D_efi=3A_x86=3A_Correct_?=
 =?US-ASCII?Q?the_condition_for_installing_ACPI_tables?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230818002706.853550-12-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
 <20230818002706.853550-12-sjg@chromium.org>
Message-ID: <66F95452-EFB7-4A8B-AE7A-9533CE12C0CA@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pDJskm0gwvUVJjMMMw56CYw4G5NmfHx+mOgtdu1R5UrB67AKT9W
 KtnDz1MUxe/Mf6tlpJnrIYjcT2gEg2jhEUG0F0KOzlpOB8P/JhsseACHVr5Texhdo+PeNu5
 OrU+VzN/undaEyGI4o2ECE8ByD9gIMx2L15krMQC/QBRqZXk+d0eGHQ/gnqSgENTKY4/gS+
 mVa/rlDO6sU3a6SY4cPHg==
UI-OutboundReport: notjunk:1;M01:P0:1O6Xigvns5o=;c7pGeN68KNPh2dN7G2tP8jjZdT+
 1XGGHNr3otxUb6PbE1w/CVLIJELyuZd27x7BWeOhQVAePEl/4i32tUYylxyY2BsrutCMQVpVu
 ts4Y7VomAtWYZwOy0gFfgI6M7rOC8RTOSHLXHDMJ/R2X60MA97q4r1Eq4wpuMjbKbNqEMiixg
 BQgPa0nnlxRVdLCyl7xXlhUJ+jS/XkyIkOeGT/Pyx3iykAFOzU7zKUQuT+stkYOCuFdIjBNlk
 G4qk3JPukcafmsegUB7KR7QZz4yX1byX3pYUdnq486+KtZzmOKPA65GlHjr7XwLQNzxwkq+Ni
 6f+Dd/jL1r6Phu2zUfUglfprJSKOWJn59aPTYmZ00wu/VK1ZGXPpZDFaveEGB68yLM9h2zP8M
 XGfEvuriK7LRyra1Us3c6B5z794jAvSzd/THSBlCzVrvOLrjkwYQi2ApTuY+h4mXlNFleLfpR
 3x7WAs1nxrXJJzDA7nYOOQhwgRfRMmDaGB2prGQM9dBbeCnhi8cj+Z4/Myss3k9KnaBXeubKd
 DcJgQ+Yt/2b+tUtj9YNHsu+6I2Q2LK8v1+4PsO7HkNV+0w5jPDIL8LyMtjHFE3i1WIcsxPfuu
 4ERUEZaxnuE35PCPy2VpaCqhU4DjVmKi9Eo7nNppRP61bVuLqIDxQZteU+ubfLfQzurMIE4dz
 S3ZeRmzkqYYA//FfzKOQwa0DaG2IgGh/VU+FijCBRCpKLDmlRVDpk4o0R01AFoArnwZmZ7OPn
 PK8CkiQNqEpqrUSrYm86NYiz6edHJWZqGJg411q/W2vt9pgVK28Ugi4yWajLx5pMzKL1DUbsd
 ybYwGobsXg+kkLe0U5nGKdni2S/5Sm3GifxkQJg8eW9J8bHmK/L3FX/gXo52E+8KTkIamZeB7
 dAEvs6PLaVbnD9st18qjawZ0PHRlTju74YHzzuiabQCe2jVdNN2CR2gV9dDXpgvrf5R9aZ0rl
 JEamZXzSsB8HXBzqlL1w+3On8Js=
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



Am 18=2E August 2023 02:26:50 MESZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>It is not always the case that U-Boot builds the ACPI tables itself=2E Fo=
r
>example, when booting from coreboot, the ACPI tables are built by
>coreboot=2E
>
>Correct the Makefile condition so that U-Boot can pass on tables built
>by a previous firmware stage=2E
>
>Tidy up the installation-condition code while we are here=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>Changes in v2:
>- Add new patch
>
> lib/efi_loader/Makefile    |  2 +-
> lib/efi_loader/efi_setup=2Ec | 10 +++++-----
> 2 files changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>index 1a8c8d7cab5c=2E=2E0eb748ff1a59 100644
>--- a/lib/efi_loader/Makefile
>+++ b/lib/efi_loader/Makefile
>@@ -78,7 +78,7 @@ obj-$(CONFIG_EFI_ESRT) +=3D efi_esrt=2Eo
> obj-$(CONFIG_VIDEO) +=3D efi_gop=2Eo
> obj-$(CONFIG_BLK) +=3D efi_disk=2Eo
> obj-$(CONFIG_NETDEVICES) +=3D efi_net=2Eo
>-obj-$(CONFIG_GENERATE_ACPI_TABLE) +=3D efi_acpi=2Eo
>+obj-$(CONFIG_ACPI) +=3D efi_acpi=2Eo
> obj-$(CONFIG_GENERATE_SMBIOS_TABLE) +=3D efi_smbios=2Eo
> obj-$(CONFIG_EFI_RNG_PROTOCOL) +=3D efi_rng=2Eo
> obj-$(CONFIG_EFI_TCG2_PROTOCOL) +=3D efi_tcg2=2Eo
>diff --git a/lib/efi_loader/efi_setup=2Ec b/lib/efi_loader/efi_setup=2Ec
>index 58d4e1340233=2E=2Ead719afd6328 100644
>--- a/lib/efi_loader/efi_setup=2Ec
>+++ b/lib/efi_loader/efi_setup=2Ec
>@@ -321,11 +321,11 @@ efi_status_t efi_init_obj_list(void)
> 	if (ret !=3D EFI_SUCCESS)
> 		goto out;
> #endif
>-#ifdef CONFIG_GENERATE_ACPI_TABLE
>-	ret =3D efi_acpi_register();
>-	if (ret !=3D EFI_SUCCESS)
>-		goto out;
>-#endif
>+	if (IS_ENABLED(CONFIG_ACPI)) {
>+		ret =3D efi_acpi_register();
>+		if (ret !=3D EFI_SUCCESS)
>+			goto out;
>+	}
> #ifdef CONFIG_GENERATE_SMBIOS_TABLE

Shouldn't this become CONFIG_SMBIOS?

It would help my review work if you would stop suppressing half of your pa=
tch series when sending mails=2E

Best regards

Heinrich=20

> 	ret =3D efi_smbios_register();
> 	if (ret !=3D EFI_SUCCESS)
