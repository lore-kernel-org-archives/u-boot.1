Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27FEE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 22:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D92E28036E;
	Fri, 20 Dec 2024 23:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AZSVizwK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEB73803CB; Fri, 20 Dec 2024 23:50:26 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A31738035E
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 23:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734735024; x=1735339824; i=xypron.glpk@gmx.de;
 bh=VVCkdZ/DMPOIdFJfgJEEvKLBJqwal++sMtOiavR7olQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=AZSVizwKoGoe5jl22oPGROn2z5hvzB5Wz4/k1MfNm9AGAdgOGP57P0BpSYEzYn5I
 Pp91XjOXeNiWDN9dQDBX8ekJa8Fv5kK1jG1nw/R0RK1pR5AlfDwWDDw6k1xZvIiWf
 O0KX4L1hiLVrpKXL92S6L5jEYRJcLrg/M6TeGcI2IepY2BNBvAcOH59N2Ie7IX+nF
 goY3e+wlVsteG6c3cfAtDJgmvLGnqu6h6Ya+oJS2umK8224vc+rhgEp/4BfrW9BIv
 39D5+NlExys9cPO8z4btT7DbTQzPRSCTHtrrMLHYF4/Zn7IciZxl5RPM1A45IO4Vd
 FupMOlK4NcNvx7XUvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1tyf0E2tW1-00a0K3; Fri, 20
 Dec 2024 23:50:24 +0100
Date: Fri, 20 Dec 2024 23:50:20 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 3/6] efi_loader: Depend on BLK
User-Agent: Thunderbird for Android
In-Reply-To: <20241220222612.1757884-4-trini@konsulko.com>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-4-trini@konsulko.com>
Message-ID: <FA4AB722-29A4-4B4F-930E-EA22C2420900@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Ivz4UTa59u1Jb6ZI0dXCI7Qh7vWwk0Ku+w107JLbNNEyKv4X5D
 HrwtjNksUA+7D21sMngZulX2mFIBa7mH2Yopj2AISasR93cGoUqwXnEgAbBgsDtV50fKtkE
 TTtxCfxQPrvuwlFBoxhyIsa0JpRbpiv3Rr5BP9eqlzQJcBEBQZRSEaQ36HIsl+lq9lG2vK5
 QvDKFZ1tHgU6rgc42NdeA==
UI-OutboundReport: notjunk:1;M01:P0:51UuHcDDxTE=;cGJvdUCHg6Y3b+ROxeRi7FUkKSy
 pFMcjhB0DOBDveGnO9Wcf673P1COXKMLphPMbscEoOattQmXpe8Tqc1jsPm6T6Ku+gNIaNcXv
 FQyMci79Jw5rwGqsguufT2CsNJ5a9ijRnXPOnHpDZp1AJQpJc0F2OPAijZynIigP+m/E65XGy
 CxestqhpgFU1CI8AxVjramziCeLCxUapVjx1WXeiujjquWaysyZUXF03g1kKVpR4Y2Aj/AU+S
 70TaHonvU/vY2u/hEv1HOq5hLNRCvEt3O3bm5vno4aysJvuOq98vpvpcdh6/kDsfAwz2DFRSa
 hCTggBxZbnmNmMXbkGIVd1Xl3PuPz9SZHLDPNgpIfIn9BDMVBDSblrSI3E3PDCZO+NimKd40n
 /aijlsyVWYmDS3ek3P5GsExLDgHDD+m1iLvTEcDGuAioAPQvui3QjbvjVuBBlMtGT2OVhn8XP
 2K8zKjilmDYR/sr5KkVeq0luJc/EHF6roYrCO50uDMI2B0/MpIlqUZBsd1VJItGjtK2i7uGyb
 pURNGz/jks1rut5dHsSaga8YXBiF9pb11zTtDoczZXElYDGXCkUaE3KlmkJdOejyRNKLPoJXx
 uWk37mhLULS/aJx+TwCq/JyXeuHj3ARNeLw5Im20bMRpLjwZ4hrUbrOeUd/MaL+9S2VKKEOzc
 fWapnlHQIeP6bqeqmuesSVuZCRnpjeAKohcEpDBWSwH+zKKh/nMK7TYHkwXn3WgI7wavlex+c
 ALMTNJHuR0+KyoYvOim8s/aKwbav2ycyr0zTjuTPNihzYkWtQYT/VkIgvWA2RqYueoc3w3lr6
 NyGulT9O0FPsF+3X6GyVnxpT29IfrglMKOuOmeX4e/Rb1n60yQyiEr4Of5fFfzC4biM983JN5
 uHCzcjsdBrlgw5FR4a/yDqgixOmKQwGfdSU3+Av4TWdIoFa1q8s9a+rI6VdkvDEiapPrKCAkS
 Ps6+zgbq6Na1uUHJlgVnCec0q6avWCBwyuSXHDWZEECstTJTj3ugHD9Z+WZFp81kquCYuk3BX
 aP1WTG77+wdBhMbb7ceosXsKCY79jTQrQg+gDx2LhntDT/4v7MpdLMR4WW8rZvjcgqiKeRlpn
 gi1Gwjz3YjisYPHv7TY1LhyAUbuiA3
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

Am 20=2E Dezember 2024 23:22:19 MEZ schrieb Tom Rini <trini@konsulko=2Ecom>=
:
>In reworking the BLK usage in Kconfig, I found there's a few issues with
>EFI_LOADER=3Dy and BLK=3Dn=2E In general, we can easily say that
>lib/efi_loader/efi_file=2Ec also should only be built with CONFIG_BLK=2E
>That however leaves the bootmgr code, eficonfig code and then parts of
>efi_device_path=2Ec, efi_boottime=2Ec and efi_setup=2Ec which functionall=
y
>depend on BLK=2E While these calls can be if'd out, I'm unsure if the
>result is usable=2E So rather than leave that buildable and imply that it
>is, I'm leaving that combination non-buildable and commenting that
>EFI_LOADER depends on BLK in the Kconfig currently=2E

EFI booting using only PXE or HTTP should be possible=2E But I admit we di=
d not work on support for diskless devices, yet=2E


>
>Signed-off-by: Tom Rini <trini@konsulko=2Ecom>

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>


>---
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>---
> lib/efi_loader/Kconfig | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>index c46ffe3a9d89=2E=2E798dced475e0 100644
>--- a/lib/efi_loader/Kconfig
>+++ b/lib/efi_loader/Kconfig
>@@ -8,13 +8,14 @@ config EFI_LOADER
> 			SYS_CPU =3D armv7   || \
> 			SYS_CPU =3D armv8)  || \
> 		X86 || RISCV || SANDBOX)
>+	# We have not fully removed the requirement for some block device
>+	depends on BLK
> 	# We need EFI_STUB_64BIT to be set on x86_64 with EFI_STUB
> 	depends on !EFI_STUB || !X86_64 || EFI_STUB_64BIT
> 	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> 	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> 	depends on !EFI_APP
> 	default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D armv8
>-	select BLK
> 	select CHARSET
> 	# We need to send DM events, dynamically, in the EFI block driver
> 	select DM_EVENT

