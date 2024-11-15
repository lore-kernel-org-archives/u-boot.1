Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F8FD68BCD
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 19:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C2889247;
	Fri, 15 Nov 2024 20:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rpBVgNgl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40BA489326; Fri, 15 Nov 2024 20:53:32 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C71E8922D
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 20:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731700408; x=1732305208; i=xypron.glpk@gmx.de;
 bh=2Rv6QatBQvsFTVyYJgqcSrd2gzRuM+Klahlo2lnftiY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=rpBVgNglIMdk+fEbPvwReI0k2SbvoUYzV6YbTWap3C+QaUFh4YMwaWAA75DHZx3t
 hKCkDUZkjPCSOqPki1vJI3jZ/ngoPUrSb+sSe7BnCwItpI3YEvvQPvihGfES0utyZ
 MBFAMrBn4zJ5UiAjV0ery90aFRTZ+ds4lVvpcDEFg7q4Gm0mh5h1r3zZj+e4RyG1+
 ApTKv/lMblJ3X3bHoozTxzXdeBMppjvuKaxMGY1Q9XUKIXiZ/SlcKxURNa0/cOWaY
 LIRGPDUWegc0Y+Ib1pJ3FkHkMUkt4HkW/mlOwUrfBYAVoc1dlmHnQhNsHKU6uXnWw
 Vpp5igUgWy6xAW5qxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1tN50a1bei-00NihW; Fri, 15
 Nov 2024 20:53:28 +0100
Date: Fri, 15 Nov 2024 20:53:27 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 2/3] efi_loader: Fix Kconfig logic around OF_LIBFDT
User-Agent: Thunderbird for Android
In-Reply-To: <20241115165400.2486914-2-trini@konsulko.com>
References: <20241115165400.2486914-1-trini@konsulko.com>
 <20241115165400.2486914-2-trini@konsulko.com>
Message-ID: <A0E8680F-E204-4A50-BACD-897731EBB9DD@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hMKYDGHcI1w0fNVQO4D+PaIPM0vC0k9qUEmDpXQh2tRAh/auXAw
 4ul0bH+KEAmOfRGiLt5cMesz6wkOvalxSORgIH1eRVnhMyvNzuPcA8r/LFsalhu6I41NZAe
 vWeERhd3CVrGRQx+8bU8RdmGRfxPIlynUaeTNrIH3eA7fRipVCpRtoHdsZ/FgTFaNOH3i4z
 0EjPhpEyX69YbCOp13FjA==
UI-OutboundReport: notjunk:1;M01:P0:gbZtFu9VHds=;hTwwpCn7/XPd+GbYPilZVWmn6OQ
 E21ZoQTBOdfdNI2tXA4l3R5+d2F8dKDSEW1Xf9zwFxaCkCOb3juDm8+XNPLKwmNBBpFqu7RxL
 bDaJAdVmRUg5gQhQkLvs+Le81p5mzvvHb11aqnQdS2dAijOPKEjcIYsDJ5oiyMn5oR9sB/OxH
 gLqz6hHXmdq72fvjvlUvV0cgGuYBW4frcrEiNvKKIP5oyJ/pZlKEz73V0y1L3dqTCDRfvNrJC
 PSAHe6Sat30kCXSNm7r1U2rsEx+z/xKs6eN7UXbg/ABFS8aPPs1ezmgf1MW3xqIcQuiyb7uXa
 9qNv4NFpJ0AY50RjMYTUyoLR2Rzc4Hc+g32kgxS50ju5hdKMAUmwvuj6SXJiBSeHTLOEfeWH+
 BLjO5uapqIpNeRfw888k4MSmpOC0ilkrlYmHj/MEU8KLlUvVm7m0Q7le7n2QBS3MiRrRgSHR+
 jjfBXJQV3FK9oM8gUgQwEgvAwwyRlmUUWSlx7xGwJW4wNkClJ6ZCp72u4UuXj6b23h8vgBTv6
 7pMbQ0wBmDw+x1P+4qRM/iLKf5/ndX41UBJuxS+5rMyipx0UjbOAG/fhINxCh18bC8xp8YHAr
 c8EhXcULmWsfRIK4KuAjarNMKx11V+a8D4lvciAJP6tpUM2A9/UMCYqNgq/IBL1D3imujhvQs
 e/hzwV5nJey06pV9qqS+Bey5a6+2u7iDOTl2EDpena+AB3Qta9Y0uhWqnydf4xQoG/CfxqvpX
 ZMiyPgCzfY78wd5FaZdBwh1lVHrZ0yBOOJ7DEEXfZ5cvjc2NlZYLyZ5uvojwBaAf39iUXPZv/
 j9a0AAFGnC6UMzqmeQO70IlUufrOikJQ0e9ITXr0e+heoEAdQH0FA3kTYVS098mw4Mx2vG5Rf
 yowzJb/BZA/xwMW2CnEq7glJNZaAX/JoARX0ivi9Pwpjs6UEi9p3C5Qlh
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

Am 15=2E November 2024 17:53:58 MEZ schrieb Tom Rini <trini@konsulko=2Ecom>=
:
>Given that OF_LIBFDT is library functionality, the feature of EFI_LOADER
>needs to select OF_LIBFDT rather than depend on it being already
>enabled=2E
>
>Signed-off-by: Tom Rini <trini@konsulko=2Ecom>

Acked-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>---
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>---
> lib/efi_loader/Kconfig | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>index 58d49789f12c=2E=2Ef41447f2b45c 100644
>--- a/lib/efi_loader/Kconfig
>+++ b/lib/efi_loader/Kconfig
>@@ -2,7 +2,7 @@ menu "UEFI Support"
>=20
> config EFI_LOADER
> 	bool "Support running UEFI applications"
>-	depends on OF_LIBFDT && ( \
>+	depends on ( \
> 		ARM && (SYS_CPU =3D arm1136 || \
> 			SYS_CPU =3D arm1176 || \
> 			SYS_CPU =3D armv7   || \
>@@ -21,6 +21,7 @@ config EFI_LOADER
> 	select EVENT_DYNAMIC
> 	select LIB_UUID
> 	select LMB
>+	select OF_LIBFDT
> 	imply PARTITION_UUIDS
> 	select REGEX
> 	imply FAT

