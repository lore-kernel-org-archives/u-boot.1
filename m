Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB8CC3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 15:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23FA381F32;
	Wed,  7 May 2025 17:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=arnaud.patard@collabora.com header.b="cH4h7x+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C97DA820EB; Wed,  7 May 2025 17:32:05 +0200 (CEST)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 428D48059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 17:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arnaud.patard@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746631918; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dhA1sJJRsCsTG2Zf3stYB0AdNQfz2yZffNaK1ZqpuqgoZAhI1RBMM3plwCqH9dwMvLS6b7+97ICiSFGoYKfUBCsLmMObgUAsxUnuqxBOmhIWL2Nn8/k0GakuBOJ3kVHPa0QJWuQ3j1vugC6X8FXJO9+k5Zr5Yd3niOHgSepjJgA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1746631918;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=+60gl/wLUA/xd7sRumyXhytpPH60KylZCADJccoWd6w=; 
 b=fP8pffIxlMVAM/wg2L0UCApri+r/yyRwNw9KwDNLqvthh0AwC3mXl03MUrEfA/p2EVitfo9rz8mpvsj9837D1wr9IYXcPizW2JMSuncy3m/JDn+HeoDroqplR0obu1mEO+462YOeT4XdmoscatYcJGsp3m4uHt+L8bizqOBatJE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=arnaud.patard@collabora.com;
 dmarc=pass header.from=<arnaud.patard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746631918; 
 s=zohomail; d=collabora.com; i=arnaud.patard@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=+60gl/wLUA/xd7sRumyXhytpPH60KylZCADJccoWd6w=;
 b=cH4h7x+2Yr8aQsz1/VvTfptfDAH/Cd6G44gKmokiXj9F70cLXFRvPkUbUBHI5FqD
 biy3aaI7k6v1CiDNPVHM0nYO5xD9iWCYmFVmUvYjZywz5AxLgp32/dHsMfYlsUrnTNa
 V+aIPbl6tLwPl50COB+5YIQrZ3L4/W5j9d7saFJY=
Received: by mx.zohomail.com with SMTPS id 1746631915450945.4381253762693;
 Wed, 7 May 2025 08:31:55 -0700 (PDT)
Message-ID: <f7d10c18af03f3879a765f190614dbb17d4b300a.camel@collabora.com>
Subject: Re: [PATCH 0/7] rockchip: Add boot from USB OTG port
From: Arnaud Patard <arnaud.patard@collabora.com>
To: Kever Yang <kever.yang@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, jonas@kwiboo.se, 
 quentin.schulz@cherry.de, jagan@amarulasolutions.com, dsimic@manjaro.org, 
 pbrobinson@gmail.com, liujianfeng1994@gmail.com, macromorgan@hotmail.com, 
 michal.simek@amd.com
Date: Wed, 07 May 2025 17:31:50 +0200
In-Reply-To: <40162793-5cf1-4e29-8621-b5863e8cdeae@rock-chips.com>
References: <20250211053340.92919-1-naoki@radxa.com>
 <40162793-5cf1-4e29-8621-b5863e8cdeae@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-ZohoMailClient: External
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

Hi,

On Tue, 2025-05-06 at 15:53 +0800, Kever Yang wrote:
> Hi Naoki,
>=20
> On 2025/2/11 13:33, FUKAUMI Naoki wrote:
> > This patch series adds the ability to boot from the USB OTG port to
> > the RK3588, RK3568, RK3566, RK3399, RK3328, and RK3308.
> >=20
> > Use rkflashtool[1] or rkusbboot[2]
>=20
> Does these two tool have the same functionality? I don't know the
> second=20
> one :(
>=20
> And I know there is another tool named rkdeveloptool from rockchip.
>=20
> > =C2=A0 to download TPL and SPL from
> > MASKROM mode, and dfu-util to download U-Boot from DFU mode.
>=20
> What's the main target for this patchset, boot from usb with ramboot=20
> support and without any eMMC/SD/SPI driver?
>=20

I can't talk for Naoki, but my use case is to test easily u-boot on my
rockchip platforms without having to flash u-boot or to have some
storage.

> I would prefer to keep using one tool instead of two or more tools,
> so I=20
> don't think
>=20
> enable DFU in SPL is a good idea, using rockusb in SPL is better
> here.

To test u-boot, I'd like to use snagflash/snagboot as it's not rockchip
specific. So, this means adding support for maskrom (which I've already
written) and rockusb protocols to it. With DFU in SPL support in u-
boot, this would mean nothing to do as the support for DFU is already
in snagboot/snagflash.

Arnaud

