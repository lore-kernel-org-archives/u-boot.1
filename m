Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719B0C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 09:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A20EE88043;
	Tue,  5 Mar 2024 10:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ZNfTyCvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AD0588075; Tue,  5 Mar 2024 10:37:11 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8670E88041
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 10:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1709631424;
 bh=IXmJwGX0RdOMSfbzZ2ZwOPAesX2aR2u+cQ79TXSfigI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=ZNfTyCviapBSC8Oi/VMVNpSZAMD5aLWM1Yp4anGRRvByYyd9jzhSQWoIN7uRQo5pQ
 9MqwRg9WoDUZjEfKMX3Bd421f1ZV4y+WkS2OKIoVxWfL51m3/ZjmK5irQUP06N1qOE
 xTZsxu2xc+9SdqKod+uy8vKMhAFdHiFpd4sDyxa2jDV6p4/zCOkQsn/HmBVA/r4YuV
 0oaIMYmDZDltlQbhSD4O4w7xFQeVWUVlnL7lszZc012YqY1aXCZk0xwqQhYfhzS5tm
 APjamimTPVoTGOxU/vTOgxbuGL3GA4g81QN6yrPpc02YE2Qi96NSrsm/XWSH+qeS8W
 3QwEjmzJnfDiQ==
Received: from [100.77.12.232] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id AFC86378045F;
 Tue,  5 Mar 2024 09:37:03 +0000 (UTC)
Message-ID: <c0785fe90bc1128140480f7812cf6facbf6e637c.camel@collabora.com>
Subject: Re: [PATCH] configs: rockchip: rock5b: enable environment
From: Christopher Obbard <chris.obbard@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>, Trevor Woerner <twoerner@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Eugen Hristev
 <eugen.hristev@collabora.com>, Tom Rini <trini@konsulko.com>, Kever Yang
 <kever.yang@rock-chips.com>
Date: Tue, 05 Mar 2024 09:36:48 +0000
In-Reply-To: <48a3680a-2e33-4c2f-b564-68fd13a4e064@kwiboo.se>
References: <20240305021051.22405-1-twoerner@gmail.com>
 <20240305021051.22405-4-twoerner@gmail.com>
 <48a3680a-2e33-4c2f-b564-68fd13a4e064@kwiboo.se>
Autocrypt: addr=chris.obbard@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
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

Hi Jonas & Trevor,

On Tue, 2024-03-05 at 10:31 +0100, Jonas Karlman wrote:
> Hi Trevor,
>=20
> On 2024-03-05 03:10, Trevor Woerner wrote:
> > Following the pattern of other Rockchip devices, enable the U-Boot
> > environment to be stored in MMC. This patch specifically assumes the
> > environment will be stored on the SDcard.
>=20
> This board has SPI flash, so storing env in SPI flash is probably a
> better default.

I agree with that.

> However, preferably the env should be stored/loaded from
> the same device that TPL/SPL was loaded from.

Do you know if there is some mechanism in U-Boot to do this already ?

It could be useful to enable autodetection on many boards which can boot U-
Boot from either SPI flash / eMMC / SD card.


Cheers!

Chris

>=20
> Regards,
> Jonas
>=20
> >=20
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> > =C2=A0configs/rock5b-rk3588_defconfig | 2 ++
> > =C2=A01 file changed, 2 insertions(+)
> >=20
> > diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-
> > rk3588_defconfig
> > index 0595325e8107..64a242003aa1 100644
> > --- a/configs/rock5b-rk3588_defconfig
> > +++ b/configs/rock5b-rk3588_defconfig
> > @@ -60,6 +60,8 @@ CONFIG_CMD_REGULATOR=3Dy
> > =C2=A0CONFIG_SPL_OF_CONTROL=3Dy
> > =C2=A0CONFIG_OF_LIVE=3Dy
> > =C2=A0CONFIG_OF_SPL_REMOVE_PROPS=3D"clock-names interrupt-parent assign=
ed-clocks
> > assigned-clock-rates assigned-clock-parents"
> > +CONFIG_ENV_IS_IN_MMC=3Dy
> > +CONFIG_SYS_MMC_ENV_DEV=3D1
> > =C2=A0CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> > =C2=A0CONFIG_SPL_REGMAP=3Dy
> > =C2=A0CONFIG_SPL_SYSCON=3Dy
>=20
