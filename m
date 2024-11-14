Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC38D6A25D
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 23:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8696B8969D;
	Fri, 15 Nov 2024 00:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bixcis+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF4389695; Fri, 15 Nov 2024 00:30:15 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 910CE89323
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 00:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-460c2418e37so1292101cf.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 15:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731627011; x=1732231811; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pGl/sdg2zK3o+zL11+cd+2YCRdsj6zkaBT440rZNITQ=;
 b=bixcis+2giayMLcds7T9l6ppt+8FASuPfmT3B+cY48A0nQpJJ/No79wY85x0IFgllW
 VRKus/MTeL7bM/fEswlQQyPsrxs33nIP1zUSZeZskfjvAVOIRFmZR91Wepsc45MkNYrn
 G05BSHGv/BFAGoW9UR+KIbje/725uHTOwOYTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731627011; x=1732231811;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pGl/sdg2zK3o+zL11+cd+2YCRdsj6zkaBT440rZNITQ=;
 b=eB6tFBQ3DhoEH5vBzJmDpzPIwgZp8MaoJlfupEalA079BeSqyZ2BcZE7nTygv/YD2s
 aX+r8PwWSP0CC0S4X5XxCLEZtSIibipg1KT9e0JNK4I1scWsX274vOQgySCU/+xSWTVn
 LKpP5rbREy5AonZAAso/jB4PhiSFnTjcLqSDOVI68LLEBftGz7PIhTA2macWE2geqptA
 rjlicRxRymZNgiSm8XkCBOny2f2otaY2NSNygzWiKd3CtfZ1JrU2i1kdCEgvJNnLrvXa
 OZyrGehbqqyFdXGnKq369m2WzkYeqXb4/Iab8x5Zuu/S3k1vDyiyieRPAY8aKJWkY9We
 V36g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIvY+JkA6WwON2XHZqNwasUGJsPuPyXVy0e+zsEIbaeZPKLPH7JreKpnF3mKV7hoy/QHd5Cv0=@lists.denx.de
X-Gm-Message-State: AOJu0YxZvBbayl8TaNdf3YG8+sv24jU6PR2a7t81E1VI/lVSywJV7PHJ
 LDQwncJq/HT3Qys0S1FIjbUvkPjHBtYXvCNL088X9Q4IwIOBLGCXfeRny0dtQYI=
X-Google-Smtp-Source: AGHT+IFQKXDFJsiESla+kUWyhxb2hsRDHUXAvVACKWPP69uCQby1gEhMx/s/hNLMMIIpvmqG9IGR8Q==
X-Received: by 2002:a05:622a:5b9b:b0:462:af30:47d with SMTP id
 d75a77b69052e-46363b6b7b2mr8002541cf.0.1731627011394; 
 Thu, 14 Nov 2024 15:30:11 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635aa3a2ebsm11834621cf.51.2024.11.14.15.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 15:30:10 -0800 (PST)
Date: Thu, 14 Nov 2024 17:30:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Stefan Roese <sr@denx.de>, Michal Simek <michal.simek@amd.com>,
 Thomas Weber <weber@corscience.de>,
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
 Phil Sutter <phil@nwl.cc>, Siddarth Gore <gores@marvell.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Heiko Schocher <hs@denx.de>, Evgeni Dobrev <evgeni@studio-punkt.com>,
 Ilko Iliev <iliev@ronetix.at>, Dave Purdy <david.c.purdy@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: ZDI-CAN-24679: New Vulnerability Report
Message-ID: <20241114233005.GN3600562@bill-the-cat>
References: <DM5PR0102MB3477A6AC67623306D970177980AC2@DM5PR0102MB3477.prod.exchangelabs.com>
 <BYAPR01MB38307E0A0D8A480B35F122F6805B2@BYAPR01MB3830.prod.exchangelabs.com>
 <20241114145636.GF3600562@bill-the-cat>
 <868d9f51-0d84-4c22-abdc-95cd60184465@amd.com>
 <20241114163354.GH3600562@bill-the-cat>
 <CAJaLiFyw5jba5g=8h6R_aB26wqJvdN9eLvu3T6FJBBpm4LkzhA@mail.gmail.com>
 <20241114203349.GM3600562@bill-the-cat>
 <CAJaLiFz+ja_qChEYg-KPh5uydp6Y_nXGv_9FF61W15pzPcpNMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ksRTnF4FwkEx+Orb"
Content-Disposition: inline
In-Reply-To: <CAJaLiFz+ja_qChEYg-KPh5uydp6Y_nXGv_9FF61W15pzPcpNMQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--ksRTnF4FwkEx+Orb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 03:27:48PM -0800, Tony Dinh wrote:
> Hi Tom,
> Hi Stefan,
>=20
> I've trimmed down the CC list a bit.
>=20
> On Thu, Nov 14, 2024 at 12:33=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Thu, Nov 14, 2024 at 12:18:49PM -0800, Tony Dinh wrote:
> > > Hi Tom,
> > > Hi Stefan,
> > >
> > > On Thu, Nov 14, 2024 at 8:33=E2=80=AFAM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Thu, Nov 14, 2024 at 04:07:15PM +0100, Michal Simek wrote:
> > > >
> > > > > Hi,
> > > > >
> > > > > On 11/14/24 15:56, Tom Rini wrote:
> > > > > > On Thu, Nov 14, 2024 at 04:02:29AM +0000, zdi-disclosures@trend=
micro.com wrote:
> > > > > >
> > > > > > > Hi,
> > > > > > > Do you have any updates to share regarding this vulnerability=
 report?
> > > > > >
> > > > > > Michal, microblaze-generic is the most active platform that ena=
bles
> > > > > > FS_JFFS2 by default and so vulnerable here. Can you find some r=
esources
> > > > > > to look in to fixing this please? Thanks.
> > > > >
> > > > > We have actually discussed this recently and we have other issues=
 with jffs2
> > > > > and not going to fix it or recommend to use it.
> > > > > JFFS2 should be removed from our configs and it is also not under=
 our regression.
> > > >
> > > > Ah OK, thanks. Adding a few more maintainers now then.
> > >
> > > Does this affect only boards that explicitly use CMD_JFFS2? how about
> > > boards that have not been converted to bootstd and still use "nand
> > > read" like this:
> > >
> > > include/configs/openrd.h
> > >
> > > #define CFG_EXTRA_ENV_SETTINGS  "x_bootargs=3Dconsole=3DttyS0,115200 =
" \
> > >         CONFIG_MTDPARTS_DEFAULT " rw ubi.mtd=3D2,2048\0" \
> > >         "x_bootcmd_kernel=3Dnand read 0x6400000 0x100000 0x300000\0" =
     \
> >
> > It's a problem for boards which read from JFFS2 in U-Boot, yes. So in
> > the case of the kernel / etc being read from a raw location (or ubi or
> > what-have-you), if FS_JFFS2 (or CMD_JFFS2, same list of platforms) is
> > disabled the problem goes away. And if we're down to just a few lightly
> > used platforms, we can just drop JFFS2 support. Thanks!
> >
> > --
> > Tom
>=20
> I did a survey. Currently, we have 27 boards that use JFFS2. In that,
> I can take care of 15 boards (1 Armada XP and 14 Kirkwood).
>=20
> - 10 boards with trivial changes (just remove JFFS2 from defconfigs)
>=20
> configs/dns325_defconfig:CONFIG_CMD_JFFS2=3Dy
> configs/dockstar_defconfig:CONFIG_CMD_JFFS2=3Dy
> configs/goflexhome_defconfig:CONFIG_CMD_JFFS2=3Dy
> configs/guruplug_defconfig:CONFIG_CMD_JFFS2=3Dy
> configs/iconnect_defconfig:CONFIG_CMD_JFFS2=3Dy
> configs/nas220_defconfig:CONFIG_CMD_JFFS2=3Dy
> configs/nsa310s_defconfig:CONFIG_CMD_JFFS2=3Dy
> configs/nsa325_defconfig:CONFIG_CMD_JFFS2=3Dy
> configs/pogo_v4_defconfig:CONFIG_CMD_JFFS2=3Dy
> configs/pogo_e02_defconfig:CONFIG_CMD_JFFS2=3Dy
>=20
> - Four boards (actually 2 boards, openrd has 3 variations) need
> convert to bootstd and remove JFFS2
>=20
> configs/openrd_base_defconfig:CONFIG_CMD_JFFS2=3Dy
> configs/openrd_client_defconfig:CONFIG_CMD_JFFS2=3Dy
> configs/openrd_ultimate_defconfig:CONFIG_CMD_JFFS2=3Dy
> configs/sheevaplug_defconfig:CONFIG_CMD_JFFS2=3Dy
>=20
> - One board needs to remove legacy boot sequence and remove JFFS2
> (bootstd already done)
>=20
> configs/ds414_defconfig:CONFIG_CMD_JFFS2=3Dy
>=20
> Hopefully someone will take care of the 12 remaining boards.

Great, thanks!

>=20
> All the best,
> Tony

--=20
Tom

--ksRTnF4FwkEx+Orb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc2h/kACgkQFHw5/5Y0
tyxzRAv/dumQR/y2HPnFHIIyDTyZGFFHNyU9KlhdAvDn0Vsax2qA2oTFFqw7BQi1
A22xb+BbwsxLcqvC3z2ZNzcj6TH5BNMwSxRtAu9TLjuczf5IlaVKmZPYk6rwo44f
UbUgn9jMlXPaWsdbyPKT2pF95/ZBHDTiwC0LMUNTYYwV9xrd/2G266xmAbcr8zIJ
Ru9mdlqZum3u/EV6nZ/6Fy2PqeWTrAX7P7RYR/eVc5pnaH7uZGUoeHnyXr8ucttk
qf5jddpA/1jPKNa87ehwq4idY9+D2Ad9DnH/Oi+oTf3XarxuvcwbiVF4mTmUku8p
l/NV+5gviYnosIX+PNuArjUYMt7zSXwUtQo7Lj3JIHyB61WY2U+JzOe4XNO9aBqo
8CYePAEXyyo3VP4X5bMKCxGCaS31yloOf5MwUW+kqB+RQlmnw0XibaTYeueqinsl
lb+wHN0kDuSAtUlhmLLXBqHd7ves3FVGvuV/yudo8KJ7Lap+RxT5pB4TKc9tV86z
sWnsfd2p
=Lr88
-----END PGP SIGNATURE-----

--ksRTnF4FwkEx+Orb--
