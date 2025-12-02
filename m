Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87AACFD376
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 05:28:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CBAF83DDD;
	Tue,  2 Dec 2025 06:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="AFaGfJe4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0814D83DE0; Tue,  2 Dec 2025 06:28:18 +0100 (CET)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED10983D9F
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 06:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1764653291; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HXxQwjnGBihE+sHSKNtApVpTT+mDLVHZ4MMhr7LOOD4z5HW7mMBsUv5X0M5Q6N0DPUNbQFl+RwJc81u+4wk0xeC5wFU9GIOD2Cis/AMHdROqvAaowkdHbBwH+JA96JDWaKWxJgudniRx1CRpImVDz//3nDvxGZQfARdVZQJR+j4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1764653291;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SY0YfMuB3TN0OmKywiIzotPgbKKwATzbEzSH98WO+dI=; 
 b=BLQbn4ZE0D0fkS8LBaL264Uwv/C9vVLv0FNLxST8rFFk7xDVXloTHyjcbYgxckLmHo2PKW6HSYq9FbDOTU00y0H6F+g6he3NhZAafAINJXkbv4+4qbMqA9HyqUbARkWVu9QiFS4/HVphDAixIrIKd5zIUsGHyt2GjSHk8xGWErk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764653291; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=SY0YfMuB3TN0OmKywiIzotPgbKKwATzbEzSH98WO+dI=;
 b=AFaGfJe4HPYOKzAvim8DGgRGTSb4olHJyrlEHPYzsyqU1nOa7/B7e9GkTbGqnY8K
 zgveM+hykwIimefBgD898FoxPUc/hgTyc8dqDVXeve6sQCCmuO4fmi/L0BM+6aWUW/q
 YkZHB/rHAKMo03V+zfQi7+pThoqrYBNS9X2pk3vm8ajPxa+/T/lFafsVJFJu6Uv6rIz
 dJpuw61DZ+hgpUbNXgaJZe5CWLuivBuOuRanfzX/VoL2hu69cbWnd7BaG+tnscxP1jU
 QL1kvRnvJDCp3/3RNGuDhYSKq5LNp+JPTmL0wi0/jeTWHuS0HvUsbdv3qshJpD7NNda
 6CpXSutaKQ==
Received: by mx.zohomail.com with SMTPS id 1764653289370124.61090313805562;
 Mon, 1 Dec 2025 21:28:09 -0800 (PST)
Message-ID: <33d528eff4e6453fdd8d442866e6af2544c7c9ad.camel@icenowy.me>
Subject: Re: [PATCH 1/2] RISC-V: implement private GCC library
From: Icenowy Zheng <uwu@icenowy.me>
To: Yao Zi <ziyao@disroot.org>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>
Cc: E Shattow <e@freeshell.de>, Hal Feng <hal.feng@starfivetech.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Minda Chen
 <minda.chen@starfivetech.com>, u-boot@lists.denx.de
Date: Tue, 02 Dec 2025 13:28:03 +0800
In-Reply-To: <aS5jmyp_VanBqY6h@pie>
References: <20251201174904.652954-1-heinrich.schuchardt@canonical.com>
 <20251201174904.652954-2-heinrich.schuchardt@canonical.com>
 <aS5jmyp_VanBqY6h@pie>
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

=E5=9C=A8 2025-12-02=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 03:57 +0000=EF=BC=
=8CYao Zi=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, Dec 01, 2025 at 06:49:03PM +0100, Heinrich Schuchardt wrote:
> > The following functions are provided:
> >=20
> > Count leading zero bits
> >=20
> > * int __clzsi2 (unsigned int a)
> > * int __clzdi2 (unsigned long a)
> > * int __clzti2 (unsigned long long a)
> >=20
> > Count trailing zero bits
> >=20
> > * int __ctzsi2 (unsigned int a)
> > * int __ctzdi2 (unsigned long a)
> > * int __ctzti2 (unsigned long long a)
> >=20
> > Signed-off-by: Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com>
> > ---
>=20
> I noted there's another series with the same subject[1] sent almost
> at
> the same time, and I couldn't tell the difference at the first
> glance.
> Is this an incident?
>=20
> > =C2=A0arch/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0arch/riscv/lib/Makefile |=C2=A0=C2=A0 2 +
> > =C2=A0arch/riscv/lib/clz.c=C2=A0=C2=A0=C2=A0 | 105
> > ++++++++++++++++++++++++++++++++++++++++
> > =C2=A0arch/riscv/lib/ctz.c=C2=A0=C2=A0=C2=A0 |=C2=A0 95 +++++++++++++++=
+++++++++++++++++++++
> > =C2=A0lib/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> > =C2=A05 files changed, 204 insertions(+), 1 deletion(-)
> > =C2=A0create mode 100644 arch/riscv/lib/clz.c
> > =C2=A0create mode 100644 arch/riscv/lib/ctz.c
> >=20
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 3133f892f94..4af0da2485f 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -159,6 +159,7 @@ config PPC
> > =C2=A0config RISCV
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "RISC-V architectu=
re"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select CREATE_ARCH_SYML=
INK
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select HAVE_PRIVATE_LIBGCC i=
f 64BIT
>=20
> Are 32-bit platforms excluded for lacking of enough library
> functions?
> Should we exclude !RISCV_ISA_F || !RISCV_ISA_D platforms as well?
> Though
> there's no in-tree 64-bit port without F/D extension.

The S7 core in U74-MC complex seems to have only IMAC, no F/D.

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select HAVE_SETJMP
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select HAVE_INITJMP
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select SUPPORT_ACPI
>=20
> Regards,
> Yao Zi
>=20
> [1]:
> https://lore.kernel.org/u-boot/20251201174705.652626-1-zfsdt@canonical.co=
m/

