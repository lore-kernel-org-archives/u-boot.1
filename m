Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393B5CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 18:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8038830F6;
	Tue, 12 Aug 2025 20:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Dnbr9LVC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76D4983102; Tue, 12 Aug 2025 20:08:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82E75830A0
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 20:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1755022130; x=1755626930; i=xypron.glpk@gmx.de;
 bh=jPd4875VrRwtjrLzzrtFHM5WRINM6JKyaEbCrNdQiO4=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Dnbr9LVCDis6err/0JaoRmvwBO5ho9BPHH1Rg6JI1fXawdA6QcheiFiHHak69bWQ
 6dRMXsMwTioRZZodJwyL/lQMVSVFM4Jl4bZ/2Dms/q52o8c2TCc9lrRqj7wYLBcVR
 ZzUeioy+saKSZ00CYqMpeUuvQYyeeOj2kUddENrwa2HDMSJhgtVlIU/EFwfd6nBPU
 uYs0KOBdLm3Rzvt4LyhXYLsYaucq8Ix+7cyGNUUjeELs4lEGdt34iqPW0JkJCCg7O
 u6FaOHLdsIUoK5EiqE3h0nyEn7l6j3x4rqs1fNM9IVl4l4CUM9RBEqnzit63rRT/V
 ZiUVB36y1xFIrvT3mQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.105.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1uuj7B2Ve4-00Azvl; Tue, 12
 Aug 2025 20:08:50 +0200
Date: Tue, 12 Aug 2025 20:08:44 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_efi=5Floader=3A_Make_EFI=5FVARI?=
 =?US-ASCII?Q?ABLES=5FPRESEED_depend_on_!COMPILE=5FTEST?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250812180132.3057893-1-trini@konsulko.com>
References: <20250812180132.3057893-1-trini@konsulko.com>
Message-ID: <D6F70FDA-51F2-406F-B3EF-ED83292CF9F0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gD19xNrm340NdPRgOMQJqi2nEoKlePJzSqICdQ3MrSbXFs0ESC8
 dxTFaBU3eo9E3ZR+laB4C76jz6QCKuh1tor/3mcxQjqLVGVmAnTdEZ7YKBgcal5Rj28AxxB
 s8Xh9DZrHWQpsdAJW7y66VRNlAYXfgB9C8LXsjtNk5nndNPVfOHN8AzWob0LkV495KGpbwW
 YM4jJJo9UXXtSqQW23/lg==
UI-OutboundReport: notjunk:1;M01:P0:NyAgQLFREtM=;U+tgLRbLjhaktoR89kxHPOaucrZ
 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
 t9/Qs5VMIOw==
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

Am 12=2E August 2025 20:01:32 MESZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>When doing compile testing build we cannot rely on having a valid file
>for EFI_VAR_SEED_FILE to exist, so disable this option when doing
>compile tests=2E
>
>Signed-off-by: Tom Rini <trini@konsulko=2Ecom>

Acked-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>


>---
>This was found when working on "allyesconfig" and the issue is that the
>file in EFI_VAR_SEED_FILE will not exist=2E
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>---
> lib/efi_loader/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>index c2aa88f59fbb=2E=2Ea7092c2e8a8a 100644
>--- a/lib/efi_loader/Kconfig
>+++ b/lib/efi_loader/Kconfig
>@@ -195,6 +195,7 @@ endchoice
>=20
> config EFI_VARIABLES_PRESEED
> 	bool "Initial values for UEFI variables"
>+	depends on !COMPILE_TEST
> 	depends on !EFI_MM_COMM_TEE
> 	help
> 	  Include a file with the initial values for non-volatile UEFI variable=
s

