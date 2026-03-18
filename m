Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9289107760E
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 19:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEEC683642;
	Wed, 18 Mar 2026 20:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XamZ5rNb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E288F836D3; Wed, 18 Mar 2026 20:59:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E13648352B
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 20:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773863975; x=1774468775; i=xypron.glpk@gmx.de;
 bh=eOhU5wygcGAefEKRmnGvTFY2eRSQJFp8ZwFcj0O0AWc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=XamZ5rNb8Xto6cFl+QL38K5dGoVBA16FfxURliMDMYN8X8IguSrDxL/k74CXdIKK
 El/4fwBneBO6UWO7+eBR/SJdTCM8ABodFtxi7wQ4+6IrfCbqg+mRgxV3i1BQaWdEG
 S6z4L42v3HISPcBDn5hzpgwdebUpo18ITuEkciIhoBTHMVf5k+9xsDK/XVajdv0V0
 jnN+Ytv1t77CFjnuOHfziFgrRdpppbWYUmjJIUqza14Dl19GnSg+7N6cL3spuFcjZ
 2JAjCqe57+YDITccF8AkfeIFQoq9Zztwv1XaW/4dOQMl2L7Kr5O4REKXysu5kAd7j
 Tms8Uy1LwDmOmP8Txw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzyya-1vhj0b0DyQ-015k6d; Wed, 18
 Mar 2026 20:59:35 +0100
Date: Wed, 18 Mar 2026 20:59:33 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
CC: John Toomey <john.toomey@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shantur Rathore <i@shantur.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] efi_loader: efi_var_sf: Do not fail on blank SPI Flash
User-Agent: Thunderbird for Android
In-Reply-To: <5309d3fda1bd6b8151358c3889525795f9e3aecd.1773852472.git.michal.simek@amd.com>
References: <5309d3fda1bd6b8151358c3889525795f9e3aecd.1773852472.git.michal.simek@amd.com>
Message-ID: <6A18CBEF-84A1-4021-91E2-B9BCE5AF13D6@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jnKBqwONRxi3Edl81rtjmSw24rB/icuGiPw3LKTInAOeswCy3ub
 dDytvZ9RdqAXYFpuEYn5hYacB0w3eO+J4LK3SoMgNnfLq4/GZgViq4JUGdF8xOJmwj0VWTf
 1Up6Jm7dTvpEW6RTsL94JBw/beQgk/ct16Z/puxfxLADuYU2/hP/wq70JX3h77vrXcL1YqJ
 GOSaNCCIDhz1fEKSEMoBQ==
UI-OutboundReport: notjunk:1;M01:P0:MpnejavsbwY=;9vUxLhW6neYTJQjJ0fJeYwyU3iq
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

Am 18=2E M=C3=A4rz 2026 17:47:54 MEZ schrieb Michal Simek <michal=2Esimek@a=
md=2Ecom>:
>When SPI Flash is blank (first boot or erased), efi_var_from_storage()
>returns EFI_DEVICE_ERROR because efi_var_restore() fails on invalid
>magic/CRC=2E This prevents the EFI subsystem from initializing=2E
>
>Check the magic value before attempting to restore variables=2E If
>the magic does not match EFI_VAR_FILE_MAGIC, treat it as an empty
>store and return EFI_SUCCESS, matching the behavior of the file-based
>efi_var_file=2Ec which deliberately returns EFI_SUCCESS on missing or
>corrupted variable files to avoid blocking the boot process=2E
>
>Similarly, if the magic matches but efi_var_restore() fails (e=2Eg=2E
>corrupted CRC), log the error but still return EFI_SUCCESS=2E
>
>Suggested-by: John Toomey <john=2Etoomey@amd=2Ecom>
>Signed-off-by: Michal Simek <michal=2Esimek@amd=2Ecom>
>---
>
> lib/efi_loader/efi_var_sf=2Ec | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/lib/efi_loader/efi_var_sf=2Ec b/lib/efi_loader/efi_var_sf=2E=
c
>index 6eae8d464645=2E=2Ea1dc81e17434 100644
>--- a/lib/efi_loader/efi_var_sf=2Ec
>+++ b/lib/efi_loader/efi_var_sf=2Ec
>@@ -98,12 +98,15 @@ efi_status_t efi_var_from_storage(void)
> 		goto error;
> 	}
>=20
>-	if (efi_var_restore(buf, false) !=3D EFI_SUCCESS) {
>-		log_err("No valid EFI variables in SPI Flash\n");
>-		ret =3D EFI_DEVICE_ERROR;
>+	if (buf->magic !=3D EFI_VAR_FILE_MAGIC) {
>+		log_info("No EFI variables in SPI Flash\n")

If the SPI flash is erased, I would expect magic =3D=3D 0=2E A incorrect n=
on-zero magic is similar to an incorrect crc32=2E

If magic =3D=3D 0 is an expected state, why write a non-debug message?

>+		ret =3D EFI_SUCCESS;
> 		goto error;
> 	}
>=20
>+	if (efi_var_restore(buf, false) !=3D EFI_SUCCESS)

Yes, we must always return EFI_SUCESS=2E

Best regards

Heinrich

>+		log_err("Invalid EFI variables in SPI Flash\n");
>+
> 	ret =3D EFI_SUCCESS;
> error:
> 	free(buf);

