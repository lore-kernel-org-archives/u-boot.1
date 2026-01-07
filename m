Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23F9D0D16A
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 18:45:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BB4A83A91;
	Wed,  7 Jan 2026 19:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RXswTKps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 761E283B21; Wed,  7 Jan 2026 19:45:11 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61C7583A47
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 19:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767811499; x=1768416299; i=xypron.glpk@gmx.de;
 bh=RADeZwX6k/zzSPQW8GqdOHxFWFjhKXqHtxtpbDzleLY=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=RXswTKpsl2bfS1uJq2u5SrkyKm5jcxpoN7hfZ0JWh8WVlfanQYImE5gEWzZyuHmV
 aLKUbAfe2pQo3DKYATLH6Y8kXD0I9zzlIQL2IGAYLlDqtDwUGZx0Z2MN9qEQxe/F9
 /B5FWyU1DmKMA0I+9xW3APBfpvTbC9YXi6Km/7jGHku9ZJQ67/EC6+/1Q079dJMop
 fV/dFZGQPR/rRus7VvyiuBMoYuZ9qnB3bWTvfraSsYfw+oqhyF+knEQ3QwW3itkks
 8Z2n69jhxqCcyAR+IfVvfXenz4NlaBLW993NSPEWWTiLfqvU1myDkM3Zu9LHQLbIy
 SO9v9aUOr0qhDOjiOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRMs-1vRUFL19ki-00Y0b8; Wed, 07
 Jan 2026 19:44:59 +0100
Date: Wed, 07 Jan 2026 19:44:56 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, adrianox@gmail.com, paul.liu@linaro.org,
 sjg@chromium.org, wolfgang.wallner@at.abb.com, javier.tia@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/3] efi_loader: Add platform hook for FDT loading
User-Agent: Thunderbird for Android
In-Reply-To: <20260106122134.2047864-2-aswin.murugan@oss.qualcomm.com>
References: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
 <20260106122134.2047864-2-aswin.murugan@oss.qualcomm.com>
Message-ID: <E06F19F1-EB24-4463-B728-C4685ADEB943@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8of1gJlTmnFP/hhJ85iYS29Rgg6a7BwEukiMuCWcApXYJKBN6tF
 K435ftTVkXF7Vriz+y/J4kY6cd1+LYTSOYhiQ8F4Vr6fOs5Ro5CJ/jk9Z0BVbJOdfZUOjyZ
 kG5KRxQdJhu96Cf/ah6eSiToEGDLQscWYbrhTd65XbRMuq7eyFKvXaWeELYe5BbSXZ2H7yb
 Q2cuVn4OZOEmnjqexqv0Q==
UI-OutboundReport: notjunk:1;M01:P0:MrcJTEprvXQ=;zUn0IYM3TK2VUAhw/3yi1HKXBf4
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

Am 6=2E Januar 2026 13:21:32 MEZ schrieb Aswin Murugan <aswin=2Emurugan@oss=
=2Equalcomm=2Ecom>:
>Introduce a weak function efi_load_platform_fdt() to allow platforms
>to provide custom device tree selection logic=2E This enables platforms
>with special requirements (such as multi-DTB selection based on
>hardware detection) to load fdt=2E
>
>The default weak implementation does nothing, Platforms can provide
>a strong implementation to load platform-specific device trees=2E
>
>Signed-off-by: Aswin Murugan <aswin=2Emurugan@oss=2Equalcomm=2Ecom>
>---
> include/efi_loader=2Eh         |  2 ++
> lib/efi_loader/efi_bootmgr=2Ec |  4 ++++
> lib/efi_loader/efi_fdt=2Ec     | 23 +++++++++++++++++++++++
> 3 files changed, 29 insertions(+)
>
>diff --git a/include/efi_loader=2Eh b/include/efi_loader=2Eh
>index 3e70ac07055=2E=2E62c3df48f71 100644
>--- a/include/efi_loader=2Eh
>+++ b/include/efi_loader=2Eh
>@@ -1303,4 +1303,6 @@ int efi_get_distro_fdt_name(char *fname, int size, =
int seq);
>=20
> void efi_load_distro_fdt(efi_handle_t handle, void **fdt, efi_uintn_t *f=
dt_size);
>=20
>+void efi_load_platform_fdt(efi_handle_t handle, void **fdt, efi_uintn_t =
*fdt_size);
>+
> #endif /* _EFI_LOADER_H */
>diff --git a/lib/efi_loader/efi_bootmgr=2Ec b/lib/efi_loader/efi_bootmgr=
=2Ec
>index a687f4d8e85=2E=2Eed06a65feb7 100644
>--- a/lib/efi_loader/efi_bootmgr=2Ec
>+++ b/lib/efi_loader/efi_bootmgr=2Ec
>@@ -1332,6 +1332,10 @@ efi_status_t efi_bootmgr_run(void *fdt)
> 			efi_load_distro_fdt(handle, &fdt_distro, &fdt_size);
> 			fdt =3D fdt_distro;
> 		}
>+		if (!fdt) {
>+			efi_load_platform_fdt(handle, &fdt_distro, &fdt_size);
>+			fdt =3D fdt_distro;
>+		}
> 	}
>=20
> 	/*
>diff --git a/lib/efi_loader/efi_fdt=2Ec b/lib/efi_loader/efi_fdt=2Ec
>index bfaa9cfc207=2E=2Ebfcfd933adf 100644
>--- a/lib/efi_loader/efi_fdt=2Ec
>+++ b/lib/efi_loader/efi_fdt=2Ec
>@@ -78,6 +78,29 @@ int efi_get_distro_fdt_name(char *fname, int size, int=
 seq)
> 	return 0;
> }
>=20
>+/**
>+ * efi_load_platform_fdt() - Platform-specific FDT loading hook (weak)
>+ *
>+ * @handle:	handle of loaded image
>+ * @fdt:	on return device-tree, must be freed via efi_free_pages()
>+ * @fdt_size:	buffer size
>+ *
>+ * This weak function allows platforms to provide custom DTB selection l=
ogic=2E
>+ * The default implementation does nothing, allowing the standard distro=
 boot
>+ * path to handle FDT loading=2E Platforms can override this function to
>+ * implement custom multi-DTB selection or other platform-specific logic=
=2E
>+ *
>+ * If this function successfully loads a DTB, it should set *fdt to poin=
t to
>+ * the loaded DTB and return=2E If it cannot load a DTB, it should set *=
fdt to
>+ * NULL, and the standard distro boot logic will be used as fallback=2E
>+ */
>+__weak void efi_load_platform_fdt(efi_handle_t handle, void **fdt,
>+				  efi_uintn_t *fdt_size)
>+{
>+	/* Default: do nothing, let standard distro boot handle it */
>+	*fdt =3D NULL;
>+}
>+
> /**
>  * efi_load_distro_fdt() - load distro device-tree
>  *

Have a look at starfive_visionfive2_defconfig  which supports several boar=
ds and chooses the right devicetree based on a value in an EEPROM in SPL=2E=
 In main U-Boot it sets a board specific value in $fdtfile which allows loa=
ding a device-tree from directory dtb/ on the ESP to override the U-Boot de=
vice-tree=2E=20

Best regards

Heinrich

