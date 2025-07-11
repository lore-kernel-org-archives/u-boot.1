Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F275C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 19:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A3C68277D;
	Fri, 11 Jul 2025 21:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="E2y/NytM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41B0B82998; Fri, 11 Jul 2025 21:35:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3B58826AA
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 21:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1752262524; x=1752867324; i=xypron.glpk@gmx.de;
 bh=kDgOGO52GNesO06MuC0z0eEBfKz9VzhGpqgU+rgt0Zk=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=E2y/NytMk85tg9Fz8+BH5a9li13ecBMXulWmXOcuyZvuUu0Gwd/ouCcho9zmyUr/
 tjP3xxhuCJLzoob8tOhmnSCnMIcZ+8PhKEX6LkMw/pLuiwfYihe+KeylLKX4jJmJa
 ldUwMGQdAbqJ3SYY7CKnTcFRFSweXyMmhMdwm6bgqurwvQd+AzEafxztqD/I3eSbu
 lfduM46/hl5m0XG9EHZD8SoieOQWIkKotoaLfrCMqOQCz8R6RQSn1aVOKulp62B+N
 ShSbULo9IsY5VMztvOgtBE4GlBc0c+OTNi5GJ0/T87gRwn+2DJjv9W1m3xTyBYS4Q
 CQrkTvrHcxARnb0HoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNNo-1u5yen2V06-00X0gU; Fri, 11
 Jul 2025 21:35:23 +0200
Date: Fri, 11 Jul 2025 21:35:21 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
CC: Josef Holzmayr <josef.holzmayr@northern.tech>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] vexpress_ca9x4: Disable EFI_LOADER on this platform
User-Agent: Thunderbird for Android
In-Reply-To: <20250711185512.2250368-1-trini@konsulko.com>
References: <20250711185512.2250368-1-trini@konsulko.com>
Message-ID: <ECA70B87-D474-4408-B523-86F4A2D02D09@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:imOudKUqefRS5P72v3811mloQywelbO5ihb+iysWIjE7T9S3edQ
 A6Y6yWs/WDSBSptzCR97qX1/ZqVpkRePgHkcaI2V5f15rwbT7kmPvlLh0JeVUkYlTFuU+/w
 ikyyERVu2VeNAjHZl7MXDhPINFv7Zojhc3x2DXU1GOQzNFX9G3U1Pisqw049cmXndR9CkPX
 bGiruGqLJRaWNlMk4zL8Q==
UI-OutboundReport: notjunk:1;M01:P0:Mv50ZfgmSKE=;iMmyg2dt3Vklz6gpaBc8+HFHD0G
 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
 3k9Kh6UKaFDXH0=
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

Am 11=2E Juli 2025 20:55:12 MESZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>As part of upgrading to QEMU 10=2E0=2E0 we discovered that the EFI loader
>tests would no longer pass CI, on this specific platform, while still
>passing on real hardware=2E Upon further investigation it turns out that
>on ARMv7 we rely on some undefined behavior with respect to enabling
>unaligned access=2E And while this is seemingly fine on real hardware,
>QEMU is now correct enough in implementation to no longer allow this=2E I=
n
>order to not rely on this undefined behavior we would need to implement
>some MMU configuration (and then ensure proper tear-down possibly)=2E
>
>At the moment, the most reasonable path forward seems to be to document
>this and disable the support here=2E

Where will we document the issue? Does it imply that we should discourage =
EFI use on all ARMv7 systems? It would be good if somebody at ARM could fin=
d out if they ever delivered designs that match QEMU's behavior=2E=20

Best regards=20

Heinrich


>
>Link: https://gitlab=2Ecom/qemu-project/qemu/-/issues/2944
>Signed-off-by: Tom Rini <trini@konsulko=2Ecom>
>---
>I believe at one point Norther was using this platform, in QEMU, for a
>reference platform via EFI for using Mender=2E As such, this would likely
>make this platform not useful anymore=2E I believe Ilias can better
>explain what needs to be done to fix this properly but there's no one
>with the available time to take care of this in the community at large,
>and this is part of what's blocking updating QEMU to a newer version
>that provides other platform and feature support we do want to use=2E
>Alternatively, we could just let this platform go and remove it, if that
>path makes more sense=2E
>
>Cc: Josef Holzmayr <josef=2Eholzmayr@northern=2Etech>
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>---
> configs/vexpress_ca9x4_defconfig | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/configs/vexpress_ca9x4_defconfig b/configs/vexpress_ca9x4_de=
fconfig
>index 67adba437bfc=2E=2E6ebb37fcf2ec 100644
>--- a/configs/vexpress_ca9x4_defconfig
>+++ b/configs/vexpress_ca9x4_defconfig
>@@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"vexpress-v2p-ca9"
> CONFIG_SYS_LOAD_ADDR=3D0x90000000
> CONFIG_ENV_ADDR=3D0x47F80000
> CONFIG_SYS_MONITOR_BASE=3D0x40000000
>+# CONFIG_EFI_LOADER is not set
> CONFIG_DISTRO_DEFAULTS=3Dy
> CONFIG_BOOTCOMMAND=3D"run distro_bootcmd; run bootflash"
> CONFIG_DEFAULT_FDT_FILE=3D"vexpress-v2p-ca9=2Edtb"
>@@ -20,6 +21,7 @@ CONFIG_SYS_CBSIZE=3D512
> CONFIG_SYS_PBSIZE=3D532
> # CONFIG_DISPLAY_CPUINFO is not set
> # CONFIG_DISPLAY_BOARDINFO is not set
>+CONFIG_LAST_STAGE_INIT=3Dy
> # CONFIG_CMD_CONSOLE is not set
> # CONFIG_CMD_BOOTD is not set
> # CONFIG_CMD_XIMG is not set
>@@ -55,4 +57,6 @@ CONFIG_SMC911X=3Dy
> CONFIG_SMC911X_32_BIT=3Dy
> CONFIG_BAUDRATE=3D38400
> CONFIG_DM_SERIAL=3Dy
>+CONFIG_FAT_WRITE=3Dy
>+CONFIG_FAT_RENAME=3Dy
> CONFIG_SYS_TIMER_COUNTS_DOWN=3Dy

