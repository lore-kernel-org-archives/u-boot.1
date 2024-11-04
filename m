Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F979D111BC
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 08:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E1C58914F;
	Mon,  4 Nov 2024 09:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730708061;
	bh=1hZXgaUO9uQa8E3dkt7rOk3x5KL2Kq/eAFF5wJuua90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DXSGCh19OhXz9Z6UQToFPNVQAf/Ia47cXpYNv6L1+6DCuN1ZzkcSaLdVJ8omV3moD
	 69JDcvtl5aV38MN/rEksqFgPwBADWk7Cj9oZLB5zk7ONfHuQ1dv0TXSbkjw4DdeQbH
	 g9mzxuaaVW/21gR0h0xrR33xsL/hrWuoVD+srQCgytCggUr9t3D8+eHPWSJqs13ea+
	 g71BTdl3ZC0wRrSCrbaqnHePCv+1NzwJdiqv3Kb2Fy+xBgTdRpH+L6zjk5pbGqxtjt
	 bpCMzTwaabbSUb0qP1udoXQqQx//ZbQeap+8Rd/RqIM+UClATCpJ67EEXfK6Ncv4ON
	 S2N+/zWCw+xYw==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 24A6C8914D;
 Mon,  4 Nov 2024 09:14:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730708060;
 bh=1hZXgaUO9uQa8E3dkt7rOk3x5KL2Kq/eAFF5wJuua90=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VGc/uK2dcQP2GlK3sdJZ57QZrRhDr7BRTcsdfGEkLQTqCu4ho+d6IpQtrtf9RHzh0
 x7rT8d+bUK0C5FZj7+DCVVXjw+lmmt9BQ8WT2F+2wxmUY6mwxov9xP184kkrB60jZA
 XbwrTpzvB+8eKREgRzQ1js28MvQW1+Qi0/E5/DB8vD2OdBaku49438SHd1VX79q3NE
 gCQ1i+zdLXugKEHw9HW8CUvnLxc9LVVSVk1rYH+r+kJPAzhLdwiwEX1XFw1/KZPSL1
 T24dcqooFGt7tvO17fZDC7NFILoXiH00bepyNua+TDdWWYWIs4HnIjTT3+jWHCOXOA
 7XGcW82TsNyXA==
Date: Mon, 4 Nov 2024 09:14:18 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Adam Ford <aford173@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>
Subject: Re: [Binman] Question regarding SPL symbol offsets generation
Message-ID: <20241104091418.74acd1f1@wsk>
In-Reply-To: <CAHCN7xK3-iUUGf20-JxAWfK05-te=sskbdpU4kU8ahy8sfROFg@mail.gmail.com>
References: <20240808110654.4215b129@wsk>
 <CAOMZO5A74MigLO0qkeXi04=7M70jaiEgk9zdFBjUV74vuZDP0g@mail.gmail.com>
 <20240815221421.61f64a17@wsk>
 <CAOMZO5B-fkLQsQx205mxXQdmk3ij6Hxx4ErM84DtEtBg3mYa7Q@mail.gmail.com>
 <CAFLszTggpR9aaDAH_Mx_zDNnKAb7r_O+sdyyVVG_xULqkrWnzg@mail.gmail.com>
 <20240828100452.2143873d@wsk>
 <CAHCN7xLY4FxB4HZLcE0pEZsx7V=dhVokh2Wcrn2Jjf+B+SLCJg@mail.gmail.com>
 <20240905155402.486a7110@wsk>
 <CAHCN7x+jLfzMGFUcbAfHr9u_2s3Z=LxN-TNCtbzUUop66p4Rpw@mail.gmail.com>
 <CAHCN7xK3-iUUGf20-JxAWfK05-te=sskbdpU4kU8ahy8sfROFg@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Am80uuNOvIoEO3kXiSD0e_R";
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

--Sig_/Am80uuNOvIoEO3kXiSD0e_R
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Adam,

> On Sun, Nov 3, 2024 at 7:41=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
> >
> > On Thu, Sep 5, 2024 at 8:54=E2=80=AFAM Lukasz Majewski <lukma@denx.de>
> > wrote: =20
> > >
> > > Hi Adam,
> > > =20
> > > > On Wed, Aug 28, 2024 at 3:04=E2=80=AFAM Lukasz Majewski <lukma@denx=
.de>
> > > > wrote: =20
> > > > >
> > > > > Hi Simon,
> > > > > =20
> > > > > > Hi,
> > > > > >
> > > > > > On Tue, 27 Aug 2024 at 12:47, Fabio Estevam
> > > > > > <festevam@gmail.com> wrote: =20
> > > > > > >
> > > > > > > Hi Lukasz,
> > > > > > >
> > > > > > > On Thu, Aug 15, 2024 at 5:14=E2=80=AFPM Lukasz Majewski
> > > > > > > <lukma@denx.de> wrote: =20
> > > > > > > > Unfortunately not - this change is only for properly
> > > > > > > > setting start address of the u-boot.
> > > > > > > >
> > > > > > > > The _real_ problem here is the symbol placement
> > > > > > > > generated by binman when we try to define the image as
> > > > > > > > a single one.
> > > > > > > >
> > > > > > > > Moreover, this change follows other boards with imx8mm
> > > > > > > > processor - ./configs/imx8mm_beacon_fspi_defconfig to be
> > > > > > > > specific.
> > > > > > > >
> > > > > > > > The "fix" (for which I'd been now probably opt) for
> > > > > > > > this issue would be to generate two images with binman
> > > > > > > > - one for u-boot-spl-ddr.bin and the final flash.bin
> > > > > > > > with the former one included (as it was before SHA1:
> > > > > > > > 37e50627efacd8dae18b564e9d8886a033e181bc) =20
> > > > > > >
> > > > > > > Is QSPI boot broken on i.MX8MM?
> > > > > > >
> > > > > > > I am adding Adam and Mamta who have tested QSPI booting on
> > > > > > > imx8mm_beacon and imx8mm_evk, respectively. =20
> > > > > >
> > > > > > Note also that I sent a series[1] which allows the
> > > > > > symbols-base to be adjusted, if that helps. =20
> > > > >
> > > > > I've seen them - but not yet tested.
> > > > >
> > > > > Thanks Simon for the patch series. =20
> > > >
> > > > Is it still broken with this patch series?  I have been
> > > > traveling and haven't had much time to test. =20
> > >
> > > Yes, I can confirm that it is still broken. =20
> >
> > Sorry for the delay.  I had to return my 8MM to Beacon, and I was
> > waiting for a replacement.
> >
> > To not prolong it anymore, I decided to try it with an 8M Nano, and
> > I got a boot failure on master. I was able to successfully boot
> > 2024.01-rc5, but I haven't had time to bisect it yet.  I'll try to
> > do that this week.  I think once we can bisect the error, it might
> > become more apparent. =20
>=20
> Git bisect narrowed down the git which broke the build:
>=20
> commit 37e50627efacd8dae18b564e9d8886a033e181bc (HEAD)
> Author: Marek Vasut <marex@denx.de>
> Date:   Fri Apr 26 01:00:37 2024 +0200
>=20
>     ARM: dts: imx: Convert i.MX8M flash.bin image generation to binman
>=20
> I am guessing the binman isn't prepending the header stuff.  I'll try
> to investigate it this week.

This is the problem with adjustments.

I've prepared following fixes for it (but are not upstreamable):
https://github.com/lmajewski/u-boot/commits/phycore-imx8mm-qspi-nvme

(problem is with wrong offsets assigned -> 0x1000 switch)

Unfortunately, I don't have the HW any more at hand.

>=20
> adam
>=20
> >
> > adam
> > =20
> > >
> > > I've applied:
> > > https://patchwork.ozlabs.org/project/uboot/cover/20240826191143.42638=
7-1-sjg@chromium.org/
> > >
> > > on top of mainline:
> > > SHA1: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
> > >
> > > Adding symbols-base =3D <0>; to imx8mm-u-boot.dtsi did not help.
> > > =20
> > > >
> > > > adam =20
> > > > > =20
> > > > > >
> > > > > > Regards,
> > > > > > Simon
> > > > > >
> > > > > > [1]
> > > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D421010
> > > > > > =20
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > Best regards,
> > > > >
> > > > > Lukasz Majewski
> > > > >
> > > > > --
> > > > >
> > > > > DENX Software Engineering GmbH,      Managing Director: Erika
> > > > > Unter HRB 165235 Munich, Office: Kirchenstr.5, D-82194
> > > > > Groebenzell, Germany Phone: (+49)-8142-66989-59 Fax:
> > > > > (+49)-8142-66989-80 Email: lukma@denx.de =20
> > >
> > >
> > >
> > >
> > > Best regards,
> > >
> > > Lukasz Majewski
> > >
> > > --
> > >
> > > DENX Software Engineering GmbH,      Managing Director: Erika
> > > Unter HRB 165235 Munich, Office: Kirchenstr.5, D-82194
> > > Groebenzell, Germany Phone: (+49)-8142-66989-59 Fax:
> > > (+49)-8142-66989-80 Email: lukma@denx.de =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Am80uuNOvIoEO3kXiSD0e_R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmcogloACgkQAR8vZIA0
zr0qXgf+L0GuINJNAVTDKT1q0wevh9S3eT2g/IUTDHkzTZpNzC0P9fWvIS0GYI+m
adouuDXjoQzQsqeYYNSbBvIkbba8s/lNcVG91NIms8qe496vcQ0B81iV+cuM1yjv
/1WMTYgfTV12hNn1C0zEqu60PFZz98UW0M3Jlqiza/k4cqorAj0gfULKU7uDoZ06
s6JxJ3uHVs+aGzuSQQT9VdbfLgMBdkqVwRZ3EsNYM1mej6xouf8Shbyaba0isp6l
P8WVxgMnpvc83sw5c7k1uuvVfYVyn9WvSYs24lJIrl7kzca/o1r0/dauEgY00cva
q8o9OoghfTPfu/rImWea4b81d/+1hg==
=mzsh
-----END PGP SIGNATURE-----

--Sig_/Am80uuNOvIoEO3kXiSD0e_R--
