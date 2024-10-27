Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3A0D1358B
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 23:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20F9D88EE4;
	Mon, 28 Oct 2024 00:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=khoahoang.com header.i=admin@khoahoang.com header.b="d94fytxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D281A88F0A; Mon, 28 Oct 2024 00:41:26 +0100 (CET)
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com
 [136.143.188.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 220AF88E99
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 00:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=admin@khoahoang.com
ARC-Seal: i=1; a=rsa-sha256; t=1730072475; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dyV9BsVSt6x/EE4x0NoZvRVsScRhxVcgYEc7YkScI4h7t+1BPGrxdGsNU7XdbYfqpU1Fheh5+wm9/9uc7HeDnj7GmYxJmyAJ5iXe/Zy+32dGam50utFmFo5IeZOLnN1D/7yVdM0XQg8KfttAqv+fowvHJ9nOOq2FLd/3A2Ecuws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730072475;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2EYkJeJ7CU8+O4mmbm2ILAETEEPdyoKqatL3rT0c0+I=; 
 b=hK7y1PXHEPIbs9nmdxKSGct6LlGD5ZzbYjZSNbTG5FXlZN1hZlfsKTpheSMFY620qEY7x0qFjLWTiPbSzCdA+77vXIKmvj6R2JXPNit/Fn4o7g1kTnGvzpVTx+JGxXfKrUCHm2GzG6Pm7oVhg6u2nlwLotwq5NuusircbnVqDtQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=khoahoang.com;
 spf=pass  smtp.mailfrom=admin@khoahoang.com;
 dmarc=pass header.from=<admin@khoahoang.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730072475; 
 s=zoho; d=khoahoang.com; i=admin@khoahoang.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=2EYkJeJ7CU8+O4mmbm2ILAETEEPdyoKqatL3rT0c0+I=;
 b=d94fytxfcDeoXqxI/LyQ3wS5KmHORyprjFSE+g0zEDR2t6hFz2GYyh5ayG07+LWZ
 6E1BoFiAWum5mxxtgA9bSZsWCWBCzPFGNBdDw+c5P1q30w+t91MayHSCyHwFvMj7E2f
 +HyR+urTh+KvV0cu9azIT2nOKibzvPo5bWUpCudc=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1730072474409117.47586118322181;
 Sun, 27 Oct 2024 16:41:14 -0700 (PDT)
Date: Sun, 27 Oct 2024 16:41:14 -0700
From: Khoa Hoang <admin@khoahoang.com>
To: "Marek Vasut" <marex@denx.de>
Cc: "u-boot" <u-boot@lists.denx.de>, "Tom Rini" <trini@konsulko.com>
Message-ID: <192d05af314.106edbab3154233.8510680526990626189@khoahoang.com>
In-Reply-To: <16f8f409-4329-47e3-98dc-f18dc64e15e2@denx.de>
References: <20241027051250.35627-1-admin@khoahoang.com>
 <20241027051250.35627-2-admin@khoahoang.com>
 <16f8f409-4329-47e3-98dc-f18dc64e15e2@denx.de>
Subject: Re: [PATCH 1/2] eth: asix88179: Fix ASIX AX88179A PHY hang
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Mailman-Approved-At: Mon, 28 Oct 2024 00:55:44 +0100
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

---- On Sun, 27 Oct 2024 07:44:59 -0700 Marek Vasut  wrote ---

 > On 10/27/24 6:12 AM, Khoa Hoang wrote:=20
 > > In the original code, the MII_ADVERTISE register is modified while=20
 > > auto-negotiation is still in progress, which causes the PHY to lock up=
=20
 > > with the ASIX AX88179A.=20
 > >=20
 > > This patch disables auto-negotiation and resets the PHY before=20
 > > modifying the MII_ADVERTISE register, then restarts auto-negotiation=
=20
 > > afterward. This prevents the PHY from locking up.=20
 > >=20
 > > Additionally, both AX88179 and AX88179A variants do not appear to=20
 > > support the ADVERTISE_LPACK (BIT(14)) in the MII_ADVERTISE register,=
=20
 > > as setting this bit does not seem to have any effect. While I do not=
=20
 > > have access to the AX88179{,A} datasheet, in most Ethernet PHYs, this=
=20
 > > bit is reserved as 0, so we should avoid setting it.=20
 > >=20
 > > Signed-off-by: Khoa Hoang admin@khoahoang.com>=20
 > > ---=20
 > >   drivers/usb/eth/asix88179.c | 10 +++++++++-=20
 > >   1 file changed, 9 insertions(+), 1 deletion(-)=20
 > >=20
 > > diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c=
=20
 > > index 4bd3b9d1..a856aa2d 100644=20
 > > --- a/drivers/usb/eth/asix88179.c=20
 > > +++ b/drivers/usb/eth/asix88179.c=20
 > > @@ -344,14 +344,22 @@ static int asix_basic_reset(struct ueth_data *de=
v,=20
 > >   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AX_MEDIUM_GIGAMODE =
| AX_MEDIUM_JUMBO_EN;=20
 > >   =C2=A0=C2=A0=C2=A0=C2=A0asix_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM=
_STATUS_MODE, 2, 2, tmp16);=20
 > >=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0/* Disable auto-negotiation and reset the PHY=
 */=20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0*tmp16 =3D BMCR_RESET;=20
 > =20
 > Why not use the same trick as u16 adv below here ?=20
 > =20
 > u16 reset =3D BMCR_RESET;=20
 > asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, &reset);=20
 > =20
 > > +=C2=A0=C2=A0=C2=A0=C2=A0asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_=
BMCR, 2, tmp16);=20
 > > +=20
 > >   =C2=A0=C2=A0=C2=A0=C2=A0u16 adv =3D 0;=20
 >=20
Sure, I can apply this change. I don=E2=80=99t have a strong preference for=
 one approach over the other.

I noticed a mistake in these lines:

+=09/* Restart auto-negotiation */
+=09*tmp16 =3D BMCR_ANENABLE | BMCR_ANRESTART | BMCR_RESET;
+=09asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, tmp16);

The issue is that I set BMCR_RESET, which would reset the PHY=E2=80=99s set=
tings. This should be changed to:

u16 bmcr =3D 0;
asix_read_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, &bmcr);
bmcr |=3D BMCR_ANENABLE | BMCR_ANRESTART;
asix_write_cmd(dev, AX_ACCESS_PHY, 0x03, MII_BMCR, 2, tmp16);

This avoids resetting the PHY settings while enabling and restarting auto-n=
egotiation correctly.
Will test this change and update in next version.

Thanks,
Khoa

