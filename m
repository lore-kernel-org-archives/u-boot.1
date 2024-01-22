Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884A4C47DDB
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 15:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB6B487956;
	Mon, 22 Jan 2024 16:06:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wzhsqu6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D9CC8743A; Mon, 22 Jan 2024 16:06:39 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44AB280090
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 16:06:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-dc22ae44595so2726004276.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 07:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705935996; x=1706540796; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VDgZZVOeElGuEkKUWPjuBxnxPSbsgtScE/jLZUnJi+k=;
 b=Wzhsqu6X+nY/J9tBG1jEG0EhteFmnuP+fs1CB0egty5rq9CEYyFpNduKD6xKvC+Vds
 of/o3ImhethRHyPUn1WHuiyR4oIzlyIJ5jJeLrBPwXibuO8eIi2IjHCiHn+Jf/89TCoT
 velV/RzsbD3B0gn8yee4JNDHM8UDXtcQ6ezYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705935996; x=1706540796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDgZZVOeElGuEkKUWPjuBxnxPSbsgtScE/jLZUnJi+k=;
 b=UpDFxsQcJUHd9IocUeKywI3419p4034Kh4XKHrF6+YxKDZJSTE4BSFFvYoLeYhjeE8
 yHN0y0WAty0D5z+7B5bfVrPpHRRtV8DbE/Icx7em3RW76fbG/+GTeEemZG9srkvLVI9d
 CUiQSm2pqoxYYU0vC8XGO8Jv6scBXb8sV6B246VNCnjdGt2wJr3WvuynW7l2EpBP3t29
 MnK2BbPmkbmZWBFk4aP10wJ0160rj08nphnggSyhSE4SkrfHaJXj8G+VldkCKuaX6h0M
 +j5HsUsF3HprtBlav1vr963K8ZMADFh1mMyiKnd93hSwFDHyaKbH2PWcW90PTsZFeFGj
 vwDA==
X-Gm-Message-State: AOJu0YwVDqgSfXBqxhCaIdFgaWvuH1mZCdQ/vNu+EBnsQG+eRwpUodWr
 WsFF9uKnLVcdbQn0AcOHrabEBOVO+zgLKMik5tDxkXCZCPJ/YMx5b1aoQdvcyxc=
X-Google-Smtp-Source: AGHT+IG1W6NCqCZ4xXo/ToganWPxjW5o9i3v5xylMnuKKRwMWU5dIRFr4wfQpE5bHkDRZ/7jY8MPbA==
X-Received: by 2002:a25:b116:0:b0:dc2:546f:bb68 with SMTP id
 g22-20020a25b116000000b00dc2546fbb68mr2084442ybj.117.1705935995935; 
 Mon, 22 Jan 2024 07:06:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5b0891000000b00dc2224542desm1573998ybq.58.2024.01.22.07.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 07:06:35 -0800 (PST)
Date: Mon, 22 Jan 2024 10:06:33 -0500
From: Tom Rini <trini@konsulko.com>
To: "Leto, Enrico" <enrico.leto@siemens.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v4 0/6] board: siemens: clean up subfolders
Message-ID: <20240122150633.GH3652023@bill-the-cat>
References: <20240103133154.152886-1-enrico.leto@siemens.com>
 <20240118151533.GA2523070@bill-the-cat>
 <DB8PR10MB37376E05A348DE5E1AECA1BBFF752@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yfgIL23FyYu0rY4f"
Content-Disposition: inline
In-Reply-To: <DB8PR10MB37376E05A348DE5E1AECA1BBFF752@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
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


--yfgIL23FyYu0rY4f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 08:33:14AM +0000, Leto, Enrico wrote:
>=20
>=20
> > -----Original Message-----
> > From: Tom Rini <trini@konsulko.com>
> > Sent: Thursday, January 18, 2024 4:16 PM
> > To: Leto, Enrico (SI BP R&D ZG FW CCP) <enrico.leto@siemens.com>
> > Cc: u-boot@lists.denx.de; Sverdlin, Alexander (SI BP R&D ZG FW CCP)
> > <alexander.sverdlin@siemens.com>
> > Subject: Re: [PATCH v4 0/6] board: siemens: clean up subfolders
> >=20
> > On Wed, Jan 03, 2024 at 02:31:48PM +0100, Enrico Leto wrote:
> >=20
> > > This serie depends on the serie:
> > >     [PATCH 0/6] siemens,am335x: clean up the draco board family
> >=20
> > Is this not applied already? If not, where is it? Can you please repost=
 it?
> >=20
>=20
> Yes, it's applied. I'll remove these lines.

OK.

> > >     The common folder was initialially created for the common parts of
> > >     the products based on draco-am355x board family. We have the
> > >     product lines 'pxm2', 'rut' and the base line unfortunately named
> > >     'draco'! Adding the new capricorn-imx8 board family, the files
> > >     were enhanced without cleanup.
> > >
> > >     Simplify first EEPROM probe and access that implements both i2c
> > >     with & without driver model. Use abstraction functions for this.
> > >
> > >     Move all am355x specifics to a new file 'board_am335x'.
> > >
> > >     Clean-up includes, config checks, maintainer.
> > >
> > > Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
> >=20
> > The problem is that I see:
> >=20
> >=20
> > > ---
> > >rm:  +   draco-etamin
> > +(draco-etamin) board/siemens/draco/../common/board.c: In function
> > 'board_init':
> > +(draco-etamin) board/siemens/draco/../common/board.c:88:9: error:
> > implicit declaration of function 'board_nand_cs_init' [-Werror=3Dimplic=
it-
> > function-declaration]
> > +(draco-etamin)    88 |         board_nand_cs_init();
> > +(draco-etamin)       |         ^~~~~~~~~~~~~~~~~~
> > +(draco-etamin) cc1: all warnings being treated as errors
> > +(draco-etamin) make[2]: *** [scripts/Makefile.build:257:
> > +board/siemens/draco/../common/board.o] Error 1
> > +(draco-etamin) make[1]: *** [Makefile:1859: board/siemens/draco] Error
> > +2
> > +(draco-etamin) make: *** [Makefile:177: sub-make] Error 2
>=20
> I'll check why I have not seen this problem by me and fix it.

Thanks.

> >    aarch64:  +   Deneb
> > +(deneb) WARNING 'ahab-container.img' not found, resulting binary is
> > +not-functional
> > +(deneb) aarch64-linux-ld.bfd:
> > board/siemens/capricorn/../common/factoryset.o: in function
> > `factoryset_read_eeprom':
> > +(deneb)
> > board/siemens/capricorn/../common/factoryset.c:149:(.text.factoryset_re=
ad
> > _eeprom+0x2c): undefined reference to `siemens_ee_read_data'
> > +(deneb) aarch64-linux-ld.bfd:
> > board/siemens/capricorn/../common/factoryset.c:177:(.text.factoryset_re=
ad
> > _eeprom+0xb4): undefined reference to `siemens_ee_read_data'
> > +(deneb) aarch64-linux-ld.bfd:
> > board/siemens/capricorn/../common/factoryset.c:172:(.text.factoryset_re=
ad
> > _eeprom+0x264): undefined reference to `siemens_ee_read_data'
> > +(deneb) make[1]: *** [Makefile:1766: u-boot] Error 139
> > +(deneb) make[1]: *** Deleting file 'u-boot'
> > +(deneb) make: *** [Makefile:177: sub-make] Error 2
> >    aarch64:  +   giedi
> > +(giedi) WARNING 'ahab-container.img' not found, resulting binary is
> > +not-functional
> > +(giedi) aarch64-linux-ld.bfd:
> > board/siemens/capricorn/../common/factoryset.o: in function
> > `factoryset_read_eeprom':
> > +(giedi)
> > board/siemens/capricorn/../common/factoryset.c:149:(.text.factoryset_re=
ad
> > _eeprom+0x2c): undefined reference to `siemens_ee_read_data'
> > +(giedi) aarch64-linux-ld.bfd:
> > board/siemens/capricorn/../common/factoryset.c:177:(.text.factoryset_re=
ad
> > _eeprom+0xb4): undefined reference to `siemens_ee_read_data'
> > +(giedi) aarch64-linux-ld.bfd:
> > board/siemens/capricorn/../common/factoryset.c:172:(.text.factoryset_re=
ad
> > _eeprom+0x264): undefined reference to `siemens_ee_read_data'
> > +(giedi) make[1]: *** [Makefile:1766: u-boot] Error 139
> > +(giedi) make[1]: *** Deleting file 'u-boot'
> > +(giedi) make: *** [Makefile:177: sub-make] Error 2
>=20
> 'giedi' & 'deneb' are based on imx8x board. This is another family that a=
re
> not affected from this patch serie.

Well, you're changing the common siemens code and that does change those
platforms as they use it too, which is why they fail now.

> This patch serie is not the cause of these warnings and will not resolve =
them.

The ahab messages are expected when we don't have all of the blobs, and
that's fine.

> Additional info.
> We also have everywhere this warning since u-boot version 2020 or 2021. T=
his
> doesn't affect the u-boot/SPL outputs. The complete boot container incl.
> 'ahab-container.img' is built separately with the mkimage tool of NXP.
> On first appearing of this warning we asked NXP. They didn't improve any
> solution. Maybe there is now a setting to remove this warning.
> A patch serie is planned for our imx8x boards.

OK.

--=20
Tom

--yfgIL23FyYu0rY4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWuhHYACgkQFHw5/5Y0
tyxB6wwAppqs8JrBV1xl7573f+OmrkBCwyfP6NM6Rrr6D3zQeJjJFQ3ZCvk7PmdI
TCX53wzDwhWixK9D8zfiJnU/G1qDRwrdObdYkqRWE3MQcmTeQCyE5U0vDav3yIS6
zra6HPCgITCz6xdNjFJfqOKveSw4skS6+hV32MPzx++ZnJ7po9LDe9OGU5z/SIWj
k/dHWqiPRVpqEqMyDwN78BVhhsUIDARrbvNGVc+vIRROApM0WWEU0Ul7Jqk+D+i5
3Mzft2lDKjOyVIHMqkx+Oe8FXWDPvJryedG4zNwBKzrz5wdwTWCrVi3QD8N3tuEC
6ysQ5GEW2D+9trDHLhYuFt5u8QdoTfQCFzRrpbTBePjL9M+WODcB3cLFeHf/gaFl
HWxLssphz0KDHhKHFNbxv47f3KSPx2Jh7lIB9e0ULRHPLjmvEoBY7A5V9kKUtZpj
WCOk8wKJtDfX2bna0WkmBDF4hDTjEfqOcamhiw6bz1O0UH8rB1HM9KcLR7nfh8yF
PBR6W3bd
=+WIM
-----END PGP SIGNATURE-----

--yfgIL23FyYu0rY4f--
