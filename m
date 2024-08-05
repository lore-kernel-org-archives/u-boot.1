Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33016C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 18:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 953C6882BE;
	Mon,  5 Aug 2024 20:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mPLFKoPS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D85B3884CC; Mon,  5 Aug 2024 20:20:29 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5304E87F5C
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 20:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3db504ab5f3so3133048b6e.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722882026; x=1723486826; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2fX7Txk5dxE4TTLsk+1Mg+eYHRt3JfjBIThW9Y3Qv/8=;
 b=mPLFKoPSFdiq9eI5SLcgt1hTMKqtV1BgnISrB4mGVFuMY4ItmFCsA1MA1WNEekldbV
 KG/bWKFufXExO/CYw5x53hiuQ1aSbWXz7+oIb/iQd+QHR8iZeIBGWuPfbkML2qYKNhCY
 yIIgKU1Daf63JOg1m69TIvSv2X7nZcCVFjrEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722882026; x=1723486826;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fX7Txk5dxE4TTLsk+1Mg+eYHRt3JfjBIThW9Y3Qv/8=;
 b=xTAHIlkn6mytVEduCtnkXe9Q+YZkhuSjKi1ntRYUskj0Dph98s0PyH/h6+IJ+XrTpW
 COn18VEndEPWbZcqqSTBx8wRYvd0Gmh7y+yH+AT/+MYLi8WKprTTMMCAKy3Fw5txvJhN
 MPqQ5jF0uD7uDIOzaq2b+GJth5oLggq/VDl1DAyhZpLHkYvX4hc1DCCZSUukWej0w7qz
 qvunM8mOFo8I7gs/pxUJB9cUcSTfGkvrCU0+SLC52ZBZWFJmgl0AnkUk17U26+TkRNo7
 WjACFfP9/S6WYl1lr7FQAJ5tahiOxeGkf59LKZaGCy4VGCwc0iiufOnV/YAVG+CW2gI/
 LPxg==
X-Gm-Message-State: AOJu0YyfEv9LPEOA7stX4bKwzeV0QFQYQrQDknwx8S8hd+uaWDW3q/jf
 eS4bVl7MY+Ugy8uX6HdVtPweucpqLYJnh/poMsssfi0yBiQKJ6S4BHCkQSKqYcM=
X-Google-Smtp-Source: AGHT+IGLucVQIMyD1ZyTSgHtBDWQeEGpZAvK563pTacq8NkwIIhDpI31IqTpFjgfnKt6D9Tof00xvQ==
X-Received: by 2002:a05:6808:2190:b0:3db:3303:8351 with SMTP id
 5614622812f47-3db5583ec76mr12473891b6e.49.1722882025964; 
 Mon, 05 Aug 2024 11:20:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db563c426fsm2786251b6e.48.2024.08.05.11.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 11:20:25 -0700 (PDT)
Date: Mon, 5 Aug 2024 12:20:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v7 00/20] Introduce the lwIP network stack
Message-ID: <20240805182022.GB267004@bill-the-cat>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
 <20240802183249.GO3794063@bill-the-cat>
 <adf03f1c-cdde-4d4f-8078-59a4bf58b10d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7ZsA3vnkXVEm9BeX"
Content-Disposition: inline
In-Reply-To: <adf03f1c-cdde-4d4f-8078-59a4bf58b10d@linaro.org>
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


--7ZsA3vnkXVEm9BeX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2024 at 08:18:09PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 8/2/24 20:32, Tom Rini wrote:
> > On Fri, Aug 02, 2024 at 06:26:27PM +0200, Jerome Forissier wrote:
> >=20
> >> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> >> library for the network stack" [1]. The goal is to introduce the lwIP =
TCP/IP
> >> stack [2] [3] as an alternative to the current implementation in net/,
> >> selectable with Kconfig, and ultimately keep only lwIP if possible. So=
me
> >> reasons for doing so are:
> >> - Make the support of HTTPS in the wget command easier. Javier T. and
> >> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> >> so. With that it becomes possible to fetch and launch a distro install=
er
> >> such as Debian etc. using a secure, authenticated connection directly
> >> from the U-Boot shell. Several use cases:
> >>   * Authentication: prevent MITM attack (third party replacing the
> >> binary with a different one)
> >>   * Confidentiality: prevent third parties from grabbing a copy of the
> >> image as it is being downloaded
> >>   * Allow connection to servers that do not support plain HTTP anymore
> >> (this is becoming more and more common on the Internet these days)
> >> - Possibly benefit from additional features implemented in lwIP
> >> - Less code to maintain in U-Boot
> >>
> >> Prior to applying this series, the lwIP stack needs to be added as a
> >> Git subtree with the following command:
> >>
> >>  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savann=
ah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
> >=20
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
> >=20
> > On a configuration that works fine with the legacy network stack.
> >=20
>=20
> That was caused by a missing call to efi_set_bootdev() in tftp_loop()
> (net/lwip/tftp.c). Fixed in v8.

Thanks.

> I also fixed a similar issue with wget (net/lwip/wget.c) but I
> noticed that the NET version of wget has the same issue:
>=20
> U-Boot> wget 200000 192.168.0.30:helloworld.efi
> Waiting for Ethernet connection... done.
> HTTP/1.0 200 OK
> Packets received 13, Transfer Successful
> Bytes transferred =3D 12720 (31b0 hex)
> U-Boot> bootefi 200000
> No UEFI binary known at 200000
> U-Boot>
>=20
> Should I also fix it in the same way? Or did I miss something? How
> are you supposed to boot an EFI image downloaded via wget?

A lack of tests for wget + EFI is how we got here, so thanks for finding
the bug. For the sake of cleaner tests, can you please fix the legacy
one as well, and add a test similar to the tftp one, but for wget?

--=20
Tom

--7ZsA3vnkXVEm9BeX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaxF+YACgkQFHw5/5Y0
tyw0rAwAhF82A2XVV2So0WqQv3IUAFoGen+ptVdggc2CZl22hy+IY0amX2fiPMeO
2fKN5EdhT9gGQWDP//+LkVOCfHzU5lHDf+KuGJc2ZByaeJKMwl6yIBHDpeypm29X
PVKR9W4cV0PUgwUWAI2kPjzIqhpfi5Xs+EYuqKDbjhFEa6gshQjo+pPt1CHTs95M
SjssfE4M7f7LJU/cy5WMveYiul5OxtO+KnffhOodlREjkTIGP1zoIDFEKnMc9Wky
YYP6jse2aGaBfkmrXa/ZNQPcYUw/RUF/cEtyHyVuB/0ysdgnAP82QG0Fm0JB2YLb
N2vvL+4iwPZQYwTCyqHdHYKrQxceysxpOKeh1J2YXGkntdlX7s196D5IIKaG72yT
kkMOiIzKS555+Ony3UrvSfhAAnX/br3tmS8j1BA/3PYiVGVFU4EZdhGbPEkSvybc
RpDEKIyjm3GKYOgwSRAoa/LHmCJEQJoGNkRdWZ6Sn9RZCYzqtPqzcNCdL3tq3E8p
25rcSWEZ
=we9u
-----END PGP SIGNATURE-----

--7ZsA3vnkXVEm9BeX--
