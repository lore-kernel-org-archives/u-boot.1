Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BA4C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 09:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC843888D7;
	Thu,  8 Aug 2024 11:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723108016;
	bh=80RVGdD+J6wroW6hfQJgvf8wag8zxhzibgmTSUO3UVs=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EvITMASQL8w4qz3GXPrbbiszixblZd8h3VjOgy8SEueFldiXftOg7Ort8h+XHxDrA
	 gtF6i+f+M4/0BZl8tJJa0iED0SiQfq6/cBQleRxfacuLk7bYJmGdVQpwSoQUhbyoYM
	 sOYQembw+7TLPJryzjtOoiHpYXZKG+HexmJFbaEPUknlpcyWolLWKXcfaGa5dNKcxK
	 uBLjoAbJ+pJk7S0hVCMaIzwzFcvlYc7gMBfQewZTA4DeytMb0zGDUjnvqnLghoBPHh
	 UOBgju7W+1jcsOCyZKD0n2pK7D6DqjNBWbYbE4UIrcgQYV74VbhYQH6tDqHwhkFVHe
	 bEidUbqDaur5Q==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 50A55887BB;
 Thu,  8 Aug 2024 11:06:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723108015;
 bh=80RVGdD+J6wroW6hfQJgvf8wag8zxhzibgmTSUO3UVs=;
 h=Date:From:To:Cc:Subject:From;
 b=LcHCGU2OQ78Us2kNEn6M+qvExQWbAsXQ/NzWCtX+XbAT6+g+PaXLspTx2KWclp4oS
 9/YsTPCZhke6EBjqZtNPm2/KHTK4YzawaUSPqvbL7MPczwNjVj3dGp/3McO9mdBZHo
 vLLjPfi23ocKatzjg3arGEdbswfB8iL3eJLXKC7LlpnXcjYF0FgcsicCSVjIQzn0wa
 aWJWdat87m64jLZVjY3TBfcCk8+1OIA5XCTcjuWa08OndnnbHdKsz8b22hp9KYQ4L6
 S/zB17VVySURlKfQGR3pvJIAIWRZATvZIg68Ryk/dZ5yPJIzPQ89F4x87aeLrkwdzD
 DzvOhjRrlGe/A==
Date: Thu, 8 Aug 2024 11:06:54 +0200
From: Lukasz Majewski <lukma@denx.de>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>
Subject: [Binman] Question regarding SPL symbol offsets generation
Message-ID: <20240808110654.4215b129@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2mDm5xf_l05z/QchLu7tQ5R";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/2mDm5xf_l05z/QchLu7tQ5R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Community

I'd like to ask about one issue with generation of symbol offsets in
binman [1].

In my case the CONFIG_FSPI_CONF_HEADER is defined.

Problem is with generated symbols [2] to point into=20
ddr-1d-imem-fw/ddr-1d-dmem-fw/ddr-2d-imem-fw/ddr-2d-dmem-fw.

It looks like only symbols have extra offset of 0x1000 (the same as the
first section introduces) - binaries for training memory are placed
without this extra offset.

On the other hand - before this change:
SHA1: 37e50627efacd8dae18b564e9d8886a033e181bc

The u-boot-spl-ddr.bin was a separate binman "entry" (i.e. not section)
- so e.g. ddr-1d-dmem-fw {} had proper offsets (as this binary was also
  mangled into spl.bin with mkimage invocation).


Now the question - how to properly fix this issue?

I've tried to add pad-before =3D <0x1000>; to ddr-1d-imem-fw property
hoping to "move" this binary itself by 0x1000. However with it the
symbol of ddr-1d-dmem-fw is moved up as well.

Another option was to try alignment 'align-size' set to 0x1000 - effect
is the same as described above.

In the documentation [3] - I've found that I could use
"ProcessEntryContents()" for tweaking, but this seems to be not
eligible (as all imx8mX boards, which are going to boot from fspi) are
affected.

Maybe falling-back to 'multiple-images' [4] and generate the
u-boot-spl-ddr.bin in that way is a proper solution?


Last but not least - this problem is not present when one boots from
SD/eMMC as in this case the "fspi_conf_block" property is not present
and everything starts with 0x0 offset.

Thanks in advance for your help.


Links:

[1] -
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/imx8mm-u-bo=
ot.dtsi?ref_type=3Dheads#L49

[2] -
https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/ddr/imx/phy/help=
er.c#L27

[3] -
https://github.com/ARM-software/u-boot/blob/master/tools/binman/README#L526

[4] -
https://github.com/ARM-software/u-boot/blob/master/tools/binman/README#L371


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/2mDm5xf_l05z/QchLu7tQ5R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAma0iq4ACgkQAR8vZIA0
zr0rwggAobTt5foT29ZgUdkcY9rtSDDfKu9gPBOuuBI2vzimgTFhzZXUnHLT/IAr
jF/+lV9nVTuiUUlk848LWfXzvZGX9xMNADgaSStSYP1moaMbPuBCsGlXtlFD94iL
40I1Hkf4LCGphRzXJ3ncWlJUSVMQuJhLW4e02IolE+GOFt6ZupJsvHwdkPuRYa4W
T3uFs8qqWtzMBYVoXC+fEISjrG1lnynjD2V5nnmOA19qBGv7cNmxauIzoq5Kr5Lm
X+8XLzLzm4cHIiqC7O2O6slYkR7Uk0DTab8y6sY+KHClXSWdUxCJPUw70JFal4QB
pmCbQUE5fpLCrRrq622xI6Rc6ChKtQ==
=cQeU
-----END PGP SIGNATURE-----

--Sig_/2mDm5xf_l05z/QchLu7tQ5R--
