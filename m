Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CA7C48260
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 03:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B70B787C45;
	Sat, 17 Feb 2024 04:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kZ2m5MyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F45D87C48; Sat, 17 Feb 2024 04:11:56 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065778765B
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 04:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412345cca4eso12928275e9.2
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 19:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708139504; x=1708744304; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qcaXtL2aF9B7L3CoPBlLIo0JpIjl+zR4Ag91mEIioWA=;
 b=kZ2m5MyKKE1uLWQl/BAUcfLIutLslWgB93hnHwjWpB4aZ1yxUUpikuVCQRupsY2+Sa
 +5VFdj7c5gsVs+Cz/ZsGmbHD9T0TR+IvVGWGN7IlxM5Y2r2wLwrMZdTu0FfQ+NA+cgRC
 Z0KpekTWrlaeeFWZz369cR6PXM51hAW4vIrdWHWmFnle/hVWeE0ih7Wfij+8WwzCHIqJ
 4BBHscwWPgNsfYyjHUKnBiV0Gw1e7L9ynpATRTHClE21NHgBdckZEhjtpjkNxOhzt4+I
 Tq+q2ZRRY0a2bzMdX7n63BkR1I8MWtJBq0soNK1eqd9C4Aty5R2Tr19+pSnKtutSljaZ
 b3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708139504; x=1708744304;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qcaXtL2aF9B7L3CoPBlLIo0JpIjl+zR4Ag91mEIioWA=;
 b=Pfzq50+OP2oQ+PJymJ3A90sOLPqRY0NPLaOIM6gmMeTdqlZS9bsh56JrzOL1+vuk5+
 C2ngdIZPvcx2J0QtChjT2ktqIVI2hpsSGiF8k0H2SRYxGaKhCt4z3+6XLsKrKkHc373J
 +qpfjG4gei6snSurHW7bbdvIWUGJ7R5U/2zaVcBr4LI6rWlwn72nKLLCo/aUi+AjjFRC
 EfkMdstV5PK9EFVneMwE/FmbWjuczcHGBhoM9C+ZxTjfF3kW1j+BCRf+bfjHaRc31Rfl
 XIY96FFfRRDSI9k6gmwAo3fHmpaKDHqWlCpzeeJYurXZbpMDV/IoQ2/66Iyt9CiT5IMD
 yG/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvKJ0eyddzjH2PfSMCv6AltqzWbxfzgc5f8CFXKy5ve9S4N20lBRspoCbWS5eFtPZpwBigUBiADysrKt3mrD1DHw1aHA==
X-Gm-Message-State: AOJu0YyR+RBVcShAgxbIRgHBBsalDgt/WnuJmv7DLbx4lKwIp0io7uSO
 aEKs0cgtE6oIlacnxJrlnFe23s3HabsPU0CK8d9pjvuFLskWPdO8
X-Google-Smtp-Source: AGHT+IGKKC3n2BnIHcQxdMHqoSQdt35jexKMJuBr62mWfWptIEHn2srgOs809Qa4WgyVGO49EnlKgQ==
X-Received: by 2002:a05:600c:5189:b0:412:488a:5922 with SMTP id
 fa9-20020a05600c518900b00412488a5922mr2643782wmb.21.1708139503967; 
 Fri, 16 Feb 2024 19:11:43 -0800 (PST)
Received: from giga-mm-1.home ([2a02:1210:8690:9300:82ee:73ff:feb8:99e3])
 by smtp.gmail.com with ESMTPSA id
 dn23-20020a05600c655700b0040fafd84095sm3819290wmb.41.2024.02.16.19.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 19:11:43 -0800 (PST)
Message-ID: <87f154591fee4979570e78cbc8c73eb0a56469eb.camel@gmail.com>
Subject: Re: [PATCH V6 07/20] configs: am62x_evm_a53_defconfig: Switch to
 bootstd
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Jan
 Kiszka <jan.kiszka@siemens.com>, Simon Glass <sjg@chromium.org>,  Andreas
 Dannenberg <dannenberg@ti.com>, Romain Naour <romain.naour@smile.fr>
Date: Sat, 17 Feb 2024 04:11:47 +0100
In-Reply-To: <20230825180305.69515-8-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-8-nm@ti.com>
Autocrypt: addr=alexander.sverdlin@gmail.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
MIME-Version: 1.0
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

Hello Nishanth,

On Fri, 2023-08-25 at 13:02 -0500, Nishanth Menon wrote:
> Switch to using bootstd. Note with this change, we will stop using
> distro_bootcmd and instead depend entirely on bootflow method of
> starting the system up.
>=20
> Suggested-by: Tom Rini <trini@konsulko.com>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> No change other than picking up reviews, tested tags along the way.
> V5: https://lore.kernel.org/r/20230824031101.3460411-6-nm@ti.com
> =C2=A0configs/am62x_evm_a53_defconfig | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defc=
onfig
> index d55caabe22c9..1807df8bbee9 100644
> --- a/configs/am62x_evm_a53_defconfig
> +++ b/configs/am62x_evm_a53_defconfig
> @@ -28,8 +28,9 @@ CONFIG_SPL_SPI=3Dy
> =C2=A0# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> =C2=A0CONFIG_SPL_LOAD_FIT=3Dy
> =C2=A0CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x81000000
> -CONFIG_DISTRO_DEFAULTS=3Dy
> -CONFIG_BOOTCOMMAND=3D"run envboot; run distro_bootcmd;"
> +CONFIG_BOOTSTD_FULL=3Dy
> +CONFIG_BOOTSTD_DEFAULTS=3Dy
> +CONFIG_BOOTCOMMAND=3D"run envboot; bootflow scan -lb"
> =C2=A0CONFIG_SPL_MAX_SIZE=3D0x58000
> =C2=A0CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> =C2=A0CONFIG_SPL_BSS_START_ADDR=3D0x80c80000

could you please suggest which distro have you used for testing?

After U-Boot update to v2024.01 Buildroot is not booting any more:

---
U-Boot 2024.01 (Feb 15 2024 - 01:43:17 +0100)

SoC:   AM62X SR1.0 HS-FS
Model: Texas Instruments AM625 SK
DRAM:  2 GiB
Core:  56 devices, 23 uclasses, devicetree: separate
MMC:   mmc@fa10000: 0, mmc@fa00000: 1
Loading Environment from nowhere... OK
In:    serial@2800000
Out:   serial@2800000
Err:   serial@2800000
Net:   eth0: ethernet@8000000port@1
Hit any key to stop autoboot:  0=20
switch to partitions #0, OK
mmc1 is current device
SD/MMC found on device 1
Failed to load 'uEnv.txt'
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filenam=
e
---  -----------  ------  --------  ----  ------------------------  -------=
---------
Scanning global bootmeth 'efi_mgr':
No EFI system partition
No EFI system partition
Failed to persist EFI variables
Scanning bootdev 'mmc@fa00000.bootdev':
Scanning bootdev 'mmc@fa10000.bootdev':
Unknown uclass 'usb' in label
link up on port 1, speed 100, full duplex
BOOTP broadcast 1
BOOTP broadcast 2
BOOTP broadcast 3
...
---

I suppose TI's BSP has older U-Boot... So it's not providing necessary
script for BOOTSTD, I suppose?

--=20
Alexander Sverdlin.

