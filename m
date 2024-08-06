Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C39C52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C16488A6D;
	Tue,  6 Aug 2024 23:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bGOu1sDz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3BB388AB3; Tue,  6 Aug 2024 23:19:12 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E0D688A10
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-704466b19c4so589057a34.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722979147; x=1723583947; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G9xv7K1stP9j0yGei0hf+yDVlUQQazkt3VSPCIEg5QU=;
 b=bGOu1sDzmXaZoGT04/3ff0GDCV3KltMLTgrtrFrItmTFEQVxmBdiniSu7y61pywmiU
 93bsohXbV7Ed1qGIXw3ACUbNOhtqypIu0FAerGdwxCnbdayZG5s+Tb+XVFOJ9lNf//C4
 W/H7SGVo4IalUJ/l3JxchDnAdvtVvMlbv7W50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722979147; x=1723583947;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9xv7K1stP9j0yGei0hf+yDVlUQQazkt3VSPCIEg5QU=;
 b=TwuGnDZtEGPbNru9XFXjLS4yrV17OlEa5DQhehhjEuDs8m4CYCx0hJOnmy75Ns+NGo
 h2C0TLaYhNrel9owWIVjqKg8WAUBEsnV4iNd7TwMWPWO1RUuSdZIi6LQ9REJb+bFtOvi
 fm/EYbYFzTBoQLMTgqqN3Pw0VXlIFYDYngtPKSgtiBlwSL9okcVfQ3W7icaf0oC9Oboa
 mMxQagGwrh1e7l6/EjhiOqWuqDC+3YIvfnD4NKZkcFEy7hbABMwZG5PJDxlnQVuOo1a2
 XpSq0sYOr8qZGpFaNXIdeV1c9jn5clo8Ez/sFbQssXxp9F1t7Dvp7VbrrRuRXVd/F14p
 XIAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDMPIrwu9ClbXpqOafr/SmLUBglDU77RD9PY2YPj+4c6NQTXPQeT24mJ8BylVtEllreKrXI03doAWfg1OUmri0eRLa9A==
X-Gm-Message-State: AOJu0Yzsz+SmwXaaLTFkiK10/aYav6uo+w9uYwCSmGaKt+1ZpJGCvg4M
 rUqMIOuoV+UzFR//5130LzNaQOqQchl7BxFh78q67AEqJWjECmSpmhUlccsC19E=
X-Google-Smtp-Source: AGHT+IEoNUUAiPOaTAFufYwQp74dGxjwBr1QkJS0TncreFS7dIO9gzzCWip4sAcrldbFbsm5qAXqIw==
X-Received: by 2002:a05:6830:dc1:b0:704:2748:5ab6 with SMTP id
 46e09a7af769-709b323c090mr19609946a34.20.1722979146879; 
 Tue, 06 Aug 2024 14:19:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31eafaf5sm4101027a34.31.2024.08.06.14.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 14:19:05 -0700 (PDT)
Date: Tue, 6 Aug 2024 15:19:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v7 00/20] Introduce the lwIP network stack
Message-ID: <20240806211902.GC1626301@bill-the-cat>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
 <20240802183249.GO3794063@bill-the-cat>
 <CAFLszThqMXGifQakKdWDwOYv0WXymk1C_3YVDvkKMgEsgS3Eyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0ufBC4yG/2OqzH6y"
Content-Disposition: inline
In-Reply-To: <CAFLszThqMXGifQakKdWDwOYv0WXymk1C_3YVDvkKMgEsgS3Eyg@mail.gmail.com>
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


--0ufBC4yG/2OqzH6y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 03:12:47PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 2 Aug 2024 at 12:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Aug 02, 2024 at 06:26:27PM +0200, Jerome Forissier wrote:
> >
> > > This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lw=
ip
> > > library for the network stack" [1]. The goal is to introduce the lwIP=
 TCP/IP
> > > stack [2] [3] as an alternative to the current implementation in net/,
> > > selectable with Kconfig, and ultimately keep only lwIP if possible. S=
ome
> > > reasons for doing so are:
> > > - Make the support of HTTPS in the wget command easier. Javier T. and
> > > Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> > > so. With that it becomes possible to fetch and launch a distro instal=
ler
> > > such as Debian etc. using a secure, authenticated connection directly
> > > from the U-Boot shell. Several use cases:
> > >   * Authentication: prevent MITM attack (third party replacing the
> > > binary with a different one)
> > >   * Confidentiality: prevent third parties from grabbing a copy of the
> > > image as it is being downloaded
> > >   * Allow connection to servers that do not support plain HTTP anymore
> > > (this is becoming more and more common on the Internet these days)
> > > - Possibly benefit from additional features implemented in lwIP
> > > - Less code to maintain in U-Boot
> > >
> > > Prior to applying this series, the lwIP stack needs to be added as a
> > > Git subtree with the following command:
> > >
> > >  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savan=
nah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
> >
> > On Pi 3 I'm again / still seeing:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > ___________________________________ test_efi_helloworld_net ___________=
________________________
> > test/py/tests/test_efi_loader.py:163: in test_efi_helloworld_net
> >     assert expected_text in output
> > E   AssertionError: assert 'Hello, world' in 'No UEFI binary known at 2=
00000'
> > ------------------------------------ Captured stdout call -------------=
------------------------
> > U-Boot> tftpboot 200000 EFI/arm64/helloworld.efi
> > Using smsc95xx_eth device
> > TFTP from server 192.168.1.10; our IP address is 192.168.1.100
> > Filename 'EFI/arm64/helloworld.efi'.
> > Load address: 0x200000
> > Loading: #
> >          883.8 KiB/s
> > done
> > Bytes transferred =3D 4528 (11b0 hex)
> > U-Boot> U-Boot> crc32 200000 $filesize
> > crc32 for 00200000 ... 002011af =3D=3D> 2b466005
> > U-Boot> U-Boot> bootefi 200000
> > No UEFI binary known at 200000
> > U-Boot>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >
> > On a configuration that works fine with the legacy network stack.
>=20
> BTW the "No UEFI binary known at 200000" is that hack that I would
> really like to improve on, by updating bootstd to keep track of which
> images are loaded.

I don't know, if I think about this I get worried that "bootFOO
$address" needs to know something more than "look at $address and check
if it's valid".

--=20
Tom

--0ufBC4yG/2OqzH6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmayk0MACgkQFHw5/5Y0
tyxBSQwAhrnRcCvGORVQ/YS0mp2xyenzE1untzzh0eo5XdHKlsO/F8sLs1RmtZq3
8HafUnKZMWe41AC9HpMmXsivkBcfkTyqlhZ2D0Obv/AeTASTYP0RAA1KHKt4vAIe
3WfAkQFAMPd+JCNaOM7ZLRy7U7b0SZod1HKist6u85KGMSi0qEU4G0V20k4Iv7De
8Wo82McyN6IN+bEzP48Qh6HTYzywxNCEXzJ/2iL4vrt9slNMaBUz6eSxa0ViQOMn
5wVSQ1pE49Zq+NKOS+KuWptFBORSQbTvmqDyYDZxT+9t8XdE1no2t3ON2rz9dvTi
w9G4X1VncuHuxozVPdJVh3cv6HJJalbDqYny/avul/OSp6Csq9iK6VHzuH+VRvTz
eO2Ywf3HR4DtM0RsNYmB+iMz5buJeNOwb1nUctfI/rhYbf7h2fR6XN0oLJiDgzNC
TKk4q6O2F8nOMqbXjoE6xnvfktUPB3UqsYjBi3y2dwq2Wjlyl/kgsGdOZGj/vEP4
K6SjBX6d
=akle
-----END PGP SIGNATURE-----

--0ufBC4yG/2OqzH6y--
