Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7E4C61DF7
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 14:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91D8987617;
	Thu, 23 Nov 2023 15:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF9687655; Thu, 23 Nov 2023 15:16:07 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9873587600
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 15:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BAD11063;
 Thu, 23 Nov 2023 06:16:48 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71AB83F6C4;
 Thu, 23 Nov 2023 06:16:01 -0800 (PST)
Date: Thu, 23 Nov 2023 14:15:51 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Stephen Graf <s_graf@telus.net>
Cc: u-boot@lists.denx.de
Subject: Re: orangepi zero3
Message-ID: <20231123141551.799dc14f@donnerap.manchester.arm.com>
In-Reply-To: <28efed32-ee19-4a89-9c84-defa95c3a963@telus.net>
References: <28efed32-ee19-4a89-9c84-defa95c3a963@telus.net>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Tue, 21 Nov 2023 21:52:12 -0800
Stephen Graf <s_graf@telus.net> wrote:

Hi Stephen,

> I have been able to build a working (on my orangepi zero3 1G) u-boot for=
=20
> the orangepi zero3 with the following defconfig. Would it be possible to=
=20

thanks for your interest in contributing and for reaching out!
As Peter already mentioned, you would need to send a patch, as generated
by "git format-patch". "git send-email" would help you with sending this
out.

But actually I sent a small series already last week:
https://lore.kernel.org/u-boot/20231114013106.31336-1-andre.przywara@arm.co=
m/

If you could apply these patches and test it on your board, I'd be
grateful. If it works for you and you are happy, please reply to patch 3/3
and add a "Tested-by: Your Name <your@email.com>" line.
For instructions how to reply, check "Reply instructions" at the end of
that mailing list archive web page above.

I was just waiting for confirmations by other people before merging it.

Cheers,
Andre


> add this config to the working boards.=C2=A0 I would test it again with a=
n=20
> official build. The dtb/dts is in linux and in u-boot.
>=20
> The H618 processor is software compatible with the H616 and the zero3=20
> board is very similar to the zero2 with the exception of DDR3 replaced=20
> with LPDDR4 and the Realtek phy with Motorcomm.
>=20
> CONFIG_ARM=3Dy
> CONFIG_ARCH_SUNXI=3Dy
> CONFIG_DEFAULT_DEVICE_TREE=3D"sun50i-h618-orangepi-zero3"
> CONFIG_SPL=3Dy
> CONFIG_DRAM_SUN50I_H616_DX_ODT=3D0x07070707
> CONFIG_DRAM_SUN50I_H616_DX_DRI=3D0x0e0e0e0e
> CONFIG_DRAM_SUN50I_H616_CA_DRI=3D0x0e0e
> CONFIG_DRAM_SUN50I_H616_ODT_EN=3D0xaaaaeeee
> CONFIG_DRAM_SUN50I_H616_TPR0=3D0x0
> CONFIG_DRAM_SUN50I_H616_TPR6=3D0x44000000
> CONFIG_DRAM_SUN50I_H616_TPR10=3D0x402f0663
> CONFIG_DRAM_SUN50I_H616_TPR11=3D0x24242323
> CONFIG_DRAM_SUN50I_H616_TPR12=3D0x0e0e0e0e
> CONFIG_MACH_SUN50I_H616=3Dy
> CONFIG_SUNXI_DRAM_H616_LPDDR4=3Dy
> CONFIG_DRAM_CLK=3D792
> CONFIG_R_I2C_ENABLE=3Dy
> CONFIG_SPL_SPI_SUNXI=3Dy
> # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> CONFIG_SPL_I2C=3Dy
> CONFIG_SPL_SYS_I2C_LEGACY=3Dy
> CONFIG_SYS_I2C_MVTWSI=3Dy
> CONFIG_SYS_I2C_SLAVE=3D0x7f
> CONFIG_SYS_I2C_SPEED=3D400000
> CONFIG_SPI_FLASH_MACRONIX=3Dy
> CONFIG_PHY_MOTORCOMM=3Dy
> CONFIG_SUN8I_EMAC=3Dy
> CONFIG_SPI=3Dy
> CONFIG_USB_EHCI_HCD=3Dy
> CONFIG_USB_OHCI_HCD=3Dy
> CONFIG_USB_MUSB_GADGET=3Dy
> CONFIG_AXP313_POWER=3Dy
> CONFIG_AXP_DCDC3_VOLT=3D1100
> CONFIG_CMD_BOOTZ=3Dy
>=20

