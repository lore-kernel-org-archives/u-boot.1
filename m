Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65D0C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 01:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07779807C4;
	Wed, 29 Jan 2025 02:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDB78811CA; Wed, 29 Jan 2025 02:35:57 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4CF0A807A7
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 02:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C831D497;
 Tue, 28 Jan 2025 17:36:20 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F4F73F5A1;
 Tue, 28 Jan 2025 17:35:52 -0800 (PST)
Date: Wed, 29 Jan 2025 01:34:15 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: "=?UTF-8?B?6buE5Yip5Lqa?=" <1425075683@qq.com>
Cc: "Chris Morgan" <macromorgan@hotmail.com>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Maksim Kiselev" <bigunclemax@gmail.com>, "Michael Walle"
 <mwalle@kernel.org>, "Samuel Holland" <samuel@sholland.org>, "Simon Glass"
 <sjg@chromium.org>, "SumitGarg" <sumit.garg@linaro.org>, "Tom Rini"
 <trini@konsulko.com>, "u-boot" <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: The CHIP DIP SCAN option should not be displayed
 in other mach
Message-ID: <20250129013415.5be2bbae@minigeek.lan>
In-Reply-To: <tencent_2626B0B5076700D962EA4E8EFBDCF5880C0A@qq.com>
References: <tencent_1A2035CCAD490A9F919EF0412BB6E3E02407@qq.com>
 <20250128155542.426d3d8a@donnerap.manchester.arm.com>
 <tencent_2626B0B5076700D962EA4E8EFBDCF5880C0A@qq.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Wed, 29 Jan 2025 09:28:56 +0800
"=E9=BB=84=E5=88=A9=E4=BA=9A" <1425075683@qq.com> wrote:

Hi LiYa,

Happy New Year!

> That's the first question.Now I see this option in menuconfig, it should =
not be available on other models.I used the following command:
> &nbsp;&nbsp;&nbsp; export CROSS_COMPILE=3Darm-none-eabi- ARCH=3Darm
> &nbsp;&nbsp;&nbsp; make stm32h750-art-pi_defconfig
> &nbsp;&nbsp;&nbsp; make menuconfig
> &nbsp; &nbsp; ARM architecture&nbsp; ---&gt;Enable DIPs detection for CHI=
P board (NEW)
>=20
> So I implemented this patch to fix it.
> But I find that the root cause is that this&nbsp;
> config is not included in if ARCH_SUNXI.&nbsp;

Yes, as I mentioned, you are right, it shouldn't be there, that's a bug
when this option was introduced.

> This is the second problem.I tried to include it,&nbsp;
> but got a compiler error.
>=20
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index ba1b1541437..b467ab098c0 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -1133,8 +1133,6 @@ config BLUETOOTH_DT_DEVICE_FIXUP
> &nbsp;
> &nbsp;source "board/sunxi/Kconfig"
> &nbsp;
> -endif
> -

Ah, you just need to move that "source" line above together with the
endif, so that it ends up as:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
config CHIP_DIP_SCAN
....
source "board/sunxi/Kconfig"
endif
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

That worked for me. If you can confirm this, please send a v2 with that
change, and I am happy to take it.

Cheers,
Andre


> &nbsp;config CHIP_DIP_SCAN
> &nbsp;	bool "Enable DIPs detection for CHIP board"
> &nbsp;	select SUPPORT_EXTENSION_SCAN
> @@ -1143,3 +1141,6 @@ config CHIP_DIP_SCAN
> &nbsp;	select W1_EEPROM
> &nbsp;	select W1_EEPROM_DS24XXX
> &nbsp;	select CMD_EXTENSION
> +
> +
> +endif
>=20
>=20
>=20
> The error message for running make menuconfig is as follows:
> arch/arm/mach-sunxi/Kconfig:1146: 'endif' in different file than 'if'
> arch/arm/mach-sunxi/Kconfig:1: location of the 'if'
> arch/arm/Kconfig:2417: 'endmenu' in different file than 'menu'
> arch/arm/mach-sunxi/Kconfig:1: location of the 'menu
>=20
>=20
> Cheers,
> LiYa
>=20
>=20
> ------------------&nbsp;Original&nbsp;------------------
> From:                                                                    =
                                                    "Andre Przywara"       =
                                                                           =
  <andre.przywara@arm.com&gt;;
> Date:&nbsp;Tue, Jan 28, 2025 11:55 PM
> To:&nbsp;"=E9=BB=84=E5=88=A9=E4=BA=9A"<1425075683@qq.com&gt;;
> Cc:&nbsp;"Chris Morgan"<macromorgan@hotmail.com&gt;;"Jagan Teki"<jagan@am=
arulasolutions.com&gt;;"Jernej Skrabec"<jernej.skrabec@gmail.com&gt;;"Maksi=
m Kiselev"<bigunclemax@gmail.com&gt;;"Michael Walle"<mwalle@kernel.org&gt;;=
"Samuel Holland"<samuel@sholland.org&gt;;"Simon Glass"<sjg@chromium.org&gt;=
;"SumitGarg"<sumit.garg@linaro.org&gt;;"Tom Rini"<trini@konsulko.com&gt;;"u=
-boot"<u-boot@lists.denx.de&gt;;
> Subject:&nbsp;Re: [PATCH] arm: The CHIP DIP SCAN option should not be dis=
played in other mach
>=20
>=20
>=20
> On Tue, 28 Jan 2025 21:37:37 +0800
> 1425075683@qq.com wrote:
>=20
> Hi,
>=20
> &gt; From: Liya Huang <1425075683@qq.com&gt;
> &gt;=20
> &gt; When I use mach STM32,
> &gt; menuconfig sees this option; It bothers me.
> &gt; I observed that the root cause was that the
> &gt; option was not included in the endif,
> &gt; but when I tried to fix it, an error occurred.
>=20
> Can you say what the error is, exactly?
> Because you are right, it should be before the endif.
> I moved that, and compiled it for all Allwinner boards, which worked.
> So what is the problem there, exactly?
>=20
> Cheers,
> Andre
>=20
> &gt; I didn't find a solution. Only deponds can be used for hiding.
> &gt;=20
> &gt; Signed-off-by: Liya Huang <1425075683@qq.com&gt;
> &gt; ---
> &gt;=20
> &gt;&nbsp; arch/arm/mach-sunxi/Kconfig | 1 +
> &gt;&nbsp; 1 file changed, 1 insertion(+)
> &gt;=20
> &gt; diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconf=
ig
> &gt; index ba1b1541437..48dd1e68363 100644
> &gt; --- a/arch/arm/mach-sunxi/Kconfig
> &gt; +++ b/arch/arm/mach-sunxi/Kconfig
> &gt; @@ -1137,6 +1137,7 @@ endif
> &gt;&nbsp;=20
> &gt;&nbsp; config CHIP_DIP_SCAN
> &gt;&nbsp; 	bool "Enable DIPs detection for CHIP board"
> &gt; +	depends on ARCH_SUNXI
> &gt;&nbsp; 	select SUPPORT_EXTENSION_SCAN
> &gt;&nbsp; 	select W1
> &gt;&nbsp; 	select W1_GPIO
