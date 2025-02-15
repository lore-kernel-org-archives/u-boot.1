Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4DFC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 15:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0BD680C6F;
	Sat, 15 Feb 2025 16:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DB8C80C77; Sat, 15 Feb 2025 16:14:14 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9376B80756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 16:14:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 (Exim 4.98) (envelope-from <daniel@makrotopia.org>)
 id 1tjJro-000000008Fc-2u9L; Sat, 15 Feb 2025 15:14:04 +0000
Date: Sat, 15 Feb 2025 15:13:57 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>
CC: Quentin Schulz <foss+dt@0leil.net>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Heiko Stuebner <heiko@sntech.de>, devicetree-spec@vger.kernel.org
Subject: Re: [PATCH] Add 'bootsource' /chosen property
User-Agent: K-9 Mail for Android
In-Reply-To: <fc2c6f06-98d9-49d3-9ce5-46dd675e8846@cherry.de>
References: <20250205-bootsource-v1-1-95f4ba69ac27@cherry.de>
 <CAFLszThr_vLbhU7A0_0VTLCGW03k6NmtxLVoW7OzrtxGFertZg@mail.gmail.com>
 <fb6792e8-97c5-4d0e-8ded-e73ea3a7513c@cherry.de>
 <CAFLszTg9-jMk0PBBSEVT=FonzRUNJOQ5NBMdDYUihWS8NkMhbQ@mail.gmail.com>
 <fc2c6f06-98d9-49d3-9ce5-46dd675e8846@cherry.de>
Message-ID: <5E98D444-A005-42CD-8A6A-381791237A6E@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

Hi Quentin,

On 10 February 2025 16:25:23 UTC, Quentin Schulz <quentin=2Eschulz@cherry=
=2Ede> wrote:
> [=2E=2E=2E]
>What I can say from glancing at the code is that for Rockchip they do the=
 following:
>
>Register a bootsource type (e=2Eg=2E MMC, SPI, I2C, USB, etc=2E=2E=2E), a=
 bootsource instance of that type (e=2Eg=2E MMC0, SPI3, I2C7, =2E=2E=2E)=2E=
 The mapping between what the ROM says the device is vs what it is in the D=
T is done in their Barebox-specific DT via this custom prop in /chosen:
>
>barebox,bootsource-<bootsourcetype><bootsourceinstance> =3D &label;  # =
=C3=A0-la /aliases
>
>This gets read and resolved and then inserted as
>
>/chosen/bootsource =3D "/some/path"
>
>into the kernel DT=2E

We are doing something quite similar downsream at openwrt=2Eorg for MediaT=
ek router SoCs, see for example:

https://github=2Ecom/openwrt/openwrt/blob/main/package/boot/uboot-mediatek=
/patches/310-mt7988-select-rootdisk=2Epatch

https://github=2Ecom/openwrt/openwrt/blob/main/target/linux/mediatek/files=
-6=2E6/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edtsi#L32

https://github=2Ecom/openwrt/openwrt/blob/main/target/linux/mediatek/files=
-6=2E6/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-emmc=2Edtso#L60


Of course we could use the standard "bootsource" property instead, but hav=
ing a way to reference the volume or partition used as rootfs instead of ju=
st passing a referencd to a physical device is advantagous=2E=2E=2E





