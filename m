Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263F7CFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 07:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 468B483E13;
	Tue,  2 Dec 2025 08:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="aMYs0trM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 115F383E16; Tue,  2 Dec 2025 08:03:41 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F55483E0F
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 08:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1764659013; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jYaVOoQcwXZ4hPM9ahaKkY5yBkuChJejUy0Tq20CBXE6Obi7ovxLx2Yo5sj4494Iu8Y9ZC0mZfqgFLEsGEf/Ig+TiN+SbX7tGiyObhEN7zNVHWJlqiU9eI4QeO4MdsIVoMdCm4rxN4sCGEUcyxJ0mSe9dOIJxn/UpSCIaLnrd1I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1764659013;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6RbW+AwoVKUTOjAHtqb9Xx3G2Nq7g+CGbbKMVRQxy14=; 
 b=D4dN/r2oyLDfiRyhljnjdQ6vds2mecUUwMxU0/4tRfBzXG6YBFajs/+NQaiRZapNFEi0Tz5o5xaU2SkGuEvv35OaFcJREEXnSmoQQlzqElIoicBZOpC/4uLAYO/jnMy2bzFc1qJ7LWZ25kPOSsAmNDDxrnEYicGHQHfYkGbFbpQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764659013; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=6RbW+AwoVKUTOjAHtqb9Xx3G2Nq7g+CGbbKMVRQxy14=;
 b=aMYs0trMF94DkQXIMvuKnbhlNSi23kyjMsZPq0ZZzVp0v3VLm5jOZ4K8qvbtDiTe
 BeH4YZuHQIBmYb1VomhLspcxIhKc4AerVDYcICXccTojCA9qJefou3NyYQSylpi4Nut
 pJPYXyq/ihbbwr/nSBm2DilriwtzDzk224qqtZlVE2+c34t/M2DbSOKaUb9NhIqvaOG
 Uu1A2roCDzz/X0F5OaE13+ZrZsaY/lqIHR8QmKnsdkqNKbCjkUuw6Cs1Uv89zNwzKya
 qbtz7Jruq80+Lzp58wZkcu8Jg5jFA1ap3nvzxA3YcQ8Fan0kD9jhUay5EY5bfOqYFCf
 i7StLLvP1A==
Received: by mx.zohomail.com with SMTPS id 1764659010069788.0144757490406;
 Mon, 1 Dec 2025 23:03:30 -0800 (PST)
Message-ID: <ae7181d47cdec3deca43d19b899ba27acddfa982.camel@icenowy.me>
Subject: Re: [PATCH 1/2] RISC-V: implement private GCC library
From: Icenowy Zheng <uwu@icenowy.me>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: E Shattow <e@freeshell.de>, Hal Feng <hal.feng@starfivetech.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Minda Chen
 <minda.chen@starfivetech.com>, u-boot@lists.denx.de, Yao Zi
 <ziyao@disroot.org>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>
Date: Tue, 02 Dec 2025 15:03:24 +0800
In-Reply-To: <0fb06358-cbed-4613-b9fd-b21962b2c0be@canonical.com>
References: <20251201174904.652954-1-heinrich.schuchardt@canonical.com>
 <20251201174904.652954-2-heinrich.schuchardt@canonical.com>
 <aS5jmyp_VanBqY6h@pie>
 <33d528eff4e6453fdd8d442866e6af2544c7c9ad.camel@icenowy.me>
 <0fb06358-cbed-4613-b9fd-b21962b2c0be@canonical.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
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

=E5=9C=A8 2025-12-02=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 07:15 +0100=EF=BC=
=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
> On 12/2/25 06:28, Icenowy Zheng wrote:
> > =E5=9C=A8 2025-12-02=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 03:57 +0000=EF=
=BC=8CYao Zi=E5=86=99=E9=81=93=EF=BC=9A
> > > On Mon, Dec 01, 2025 at 06:49:03PM +0100, Heinrich Schuchardt
> > > wrote:
> > > > The following functions are provided:
> > > >=20
> > > > Count leading zero bits
> > > >=20
> > > > * int __clzsi2 (unsigned int a)
> > > > * int __clzdi2 (unsigned long a)
> > > > * int __clzti2 (unsigned long long a)
> > > >=20
> > > > Count trailing zero bits
> > > >=20
> > > > * int __ctzsi2 (unsigned int a)
> > > > * int __ctzdi2 (unsigned long a)
> > > > * int __ctzti2 (unsigned long long a)
> > > >=20
> > > > Signed-off-by: Heinrich Schuchardt
> > > > <heinrich.schuchardt@canonical.com>
> > > > ---
> > >=20
> > > I noted there's another series with the same subject[1] sent
> > > almost
> > > at
> > > the same time, and I couldn't tell the difference at the first
> > > glance.
> > > Is this an incident?
> > >=20
> > > > =C2=A0=C2=A0arch/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > =C2=A0=C2=A0arch/riscv/lib/Makefile |=C2=A0=C2=A0 2 +
> > > > =C2=A0=C2=A0arch/riscv/lib/clz.c=C2=A0=C2=A0=C2=A0 | 105
> > > > ++++++++++++++++++++++++++++++++++++++++
> > > > =C2=A0=C2=A0arch/riscv/lib/ctz.c=C2=A0=C2=A0=C2=A0 |=C2=A0 95
> > > > ++++++++++++++++++++++++++++++++++++
> > > > =C2=A0=C2=A0lib/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> > > > =C2=A0=C2=A05 files changed, 204 insertions(+), 1 deletion(-)
> > > > =C2=A0=C2=A0create mode 100644 arch/riscv/lib/clz.c
> > > > =C2=A0=C2=A0create mode 100644 arch/riscv/lib/ctz.c
> > > >=20
> > > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > > index 3133f892f94..4af0da2485f 100644
> > > > --- a/arch/Kconfig
> > > > +++ b/arch/Kconfig
> > > > @@ -159,6 +159,7 @@ config PPC
> > > > =C2=A0=C2=A0config RISCV
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "RISC-V =
architecture"
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select CREATE=
_ARCH_SYMLINK
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select HAVE_PRIVATE_LIBG=
CC if 64BIT
> > >=20
> > > Are 32-bit platforms excluded for lacking of enough library
> > > functions?
>=20
> Yes. See=20
> https://lore.kernel.org/u-boot/20251201174904.652954-1-heinrich.schuchard=
t@canonical.com/T/#mbf44c9f5073649bbf2e1368ffbeaec82680a268d
>=20
> > > Should we exclude !RISCV_ISA_F || !RISCV_ISA_D platforms as well?
> > > Though
>=20
> libgcc.a as provided by distros assumes that you have the D and F=20
> extensions. Either a specific libgcc.a will be needed or we will have
> to=20
> implement the missing functions in the private lib if such platforms.
>=20
> It would make more sense to set CONFIG_USE_PRIVATE_LIBGCC=3Dn for such=
=20
> platforms than setting CONFIG_HAVE_PRIVATE_LIBGCC=3Dn.
>=20
> Which way we want to go can be decided when such platforms arrive.
>=20
> > > there's no in-tree 64-bit port without F/D extension.
> >=20
> > The S7 core in U74-MC complex seems to have only IMAC, no F/D.
> The S7 core is not supported by U-Boot.

Well at least SPL is run on the S7 cores, although the SBI should keep
the S7 core from being running main U-Boot.

>=20
> Best regards
>=20
> Heinrich
>=20
> >=20
> > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select HAVE_S=
ETJMP
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select HAVE_I=
NITJMP
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select SUPPOR=
T_ACPI
> > >=20
> > > Regards,
> > > Yao Zi
> > >=20
> > > [1]:
> > > https://lore.kernel.org/u-boot/20251201174705.652626-1-zfsdt@canonica=
l.com/
> >=20
>=20

