Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A03EC54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 12:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F398787CFF;
	Thu, 14 Mar 2024 13:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="wPh3P0+E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GG67n4lC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0565487F04; Thu, 14 Mar 2024 13:04:40 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F19F2875FA
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 13:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
Date: Thu, 14 Mar 2024 13:04:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1710417877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nnJItsnzpKTp7lVw0NXtUrYpYJyhp2RGGh2w45ghFa0=;
 b=wPh3P0+E8o1uNH/0c6Avh7PWm5jYPRUd7aJfMEvVpb1DejfQVaV8rRtOrmFsFb98mmJgZr
 ugdOoAYq6ZD+Ys7ICDotzpxBgI8sFaeFjEicFRL4hhja6OwdqSmR5MpKM8Gf+8vduLw0w4
 vJ1EgrTWyMokztgV/xZbAdGUPN0alvznQOfLJ82QJp0LpM4C9EHL8HqxzWmWgbbj5GnFvA
 X2UdaoPcXS/bFOGgHc1lD3CcPg+fsWTHg15Pc+84HmWsFN6bwvJ8UF/jCPe09qjSMVjtDL
 AhJlFPhWCEFRu65x65LgbN1r7e6gE02sk1cxYKwb04CX8YST7GOfbnc54ieyWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1710417877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nnJItsnzpKTp7lVw0NXtUrYpYJyhp2RGGh2w45ghFa0=;
 b=GG67n4lChR0rfg3L4at5KFugEFMjWFwVVbFyQ9y9gj5Fvoryjf1mlpTM0+8aYX8l3ahSP7
 GDt8M+OXyVkc3LCw==
From: Nam Cao <namcao@linutronix.de>
To: "Milan P. =?UTF-8?B?U3RhbmnEhw==?=" <mps@arvanta.net>
Cc: ycliang@andestech.com, yanhong.wang@starfivetech.com,
 chanho61.park@samsung.com, wiagn233@outlook.com, sjg@chromium.org,
 inindev@gmail.com, rick@andestech.com, bmeng@tinylab.org,
 u-boot@lists.denx.de, minda.chen@starfivetech.com
Subject: Re: [PATCH] starfive: visionfive2: switch to standard boot
Message-ID: <20240314130436.76a2892a@namcao>
In-Reply-To: <20240313184206.GA20322@m1pro.arvanta.net>
References: <20240221120014.149193-1-namcao@linutronix.de>
 <20240313184206.GA20322@m1pro.arvanta.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On 13/Mar/2024 Milan P. Stani=C4=87 wrote:
> On Wed, 2024-02-21 at 13:00, Nam Cao wrote:
> > Distro boot scripts are deprecated. Use standard boot instead. =20
> I had to enable 'CONFIG_CMD_SYSBOOT=3Dy' in
> configs/starfive_visionfive2_defconfig because it doesn't boot without
> it. With this option it boots fine with this patch.

You should not have to do that for it to work, otherwise this patch
introduced a bug.

CONFIG_CMD_SYSBOOT adds the "sysboot" command, which is only used by
distroboot. So I suspect that you were actually still using distro boot,
because you didn't "update" your environment variable (that can be checked
with "printenv bootcmd"). For this patch to work, the environment variables
also need to be updated with:
    env default
    env save -a

This makes me realize that the patch breaks boards if the users forget to
update the environment variables. I am not sure if this is considered a
bug. What do maintainers think?

Best regards,
Nam

> Tested on u-boot version 2024.04-rc4-dirty
>=20
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com> =20
> Tested-by: Milan P. Stani=C4=87 <mps@arvanta.net>
>=20
> > ---
> >  configs/starfive_visionfive2_defconfig |  2 +-
> >  include/configs/starfive-visionfive2.h | 14 +-------------
> >  2 files changed, 2 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_=
visionfive2_defconfig
> > index b11be7ac86..aec751f871 100644
> > --- a/configs/starfive_visionfive2_defconfig
> > +++ b/configs/starfive_visionfive2_defconfig
> > @@ -31,8 +31,8 @@ CONFIG_RISCV_SMODE=3Dy
> >  # CONFIG_OF_BOARD_FIXUP is not set
> >  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> >  CONFIG_FIT=3Dy
> > +CONFIG_BOOTSTD_DEFAULTS=3Dy
> >  CONFIG_SYS_BOOTM_LEN=3D0x4000000
> > -CONFIG_DISTRO_DEFAULTS=3Dy
> >  CONFIG_BOOTSTAGE=3Dy
> >  CONFIG_QSPI_BOOT=3Dy
> >  CONFIG_SD_BOOT=3Dy
> > diff --git a/include/configs/starfive-visionfive2.h b/include/configs/s=
tarfive-visionfive2.h
> > index 29c74470c7..049b0a0630 100644
> > --- a/include/configs/starfive-visionfive2.h
> > +++ b/include/configs/starfive-visionfive2.h
> > @@ -15,17 +15,6 @@
> > =20
> >  #define __io
> > =20
> > -/* Environment options */
> > -
> > -#define BOOT_TARGET_DEVICES(func) \
> > -	func(NVME, nvme, 0) \
> > -	func(USB, usb, 0) \
> > -	func(MMC, mmc, 0) \
> > -	func(MMC, mmc, 1) \
> > -	func(DHCP, dhcp, na)
> > -
> > -#include <config_distro_bootcmd.h>
> > -
> >  #define TYPE_GUID_SPL		"2E54B353-1271-4842-806F-E436D6AF6985"
> >  #define TYPE_GUID_UBOOT	"BC13C2FF-59E6-4262-A352-B275FD6F7172"
> >  #define TYPE_GUID_SYSTEM	"EBD0A0A2-B9E5-4433-87C0-68B6B72699C7"
> > @@ -48,7 +37,6 @@
> >  	"type_guid_gpt_loader2=3D" TYPE_GUID_UBOOT "\0" \
> >  	"type_guid_gpt_system=3D" TYPE_GUID_SYSTEM "\0" \
> >  	"partitions=3D" PARTS_DEFAULT "\0" \
> > -	"fdtfile=3D" CONFIG_DEFAULT_FDT_FILE "\0" \
> > -	BOOTENV
> > +	"fdtfile=3D" CONFIG_DEFAULT_FDT_FILE "\0"
> > =20
> >  #endif /* _STARFIVE_VISIONFIVE2_H */ =20

