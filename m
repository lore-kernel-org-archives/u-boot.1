Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15711E6C5E3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 00:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96E3A895CF;
	Tue,  3 Dec 2024 01:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rHnN2Ogy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00D398957F; Tue,  3 Dec 2024 01:34:29 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7415E89588
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 01:34:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d3e9e854b8so53500496d6.1
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 16:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733186065; x=1733790865; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NfZYsxWlWlmcTqJUqXW4Eo8/vCkVtNE2gbtU4uVWMQg=;
 b=rHnN2OgyPLVyJsE7ZxeC7IAx3ubYaYp1UBG+6uMKe1OhS1UF6tJvMLuE7GvgS1wDRA
 y3TA/t2hGJX1qnqwc63S70v6IKsZ6HjqtiVtj7LxQCcUNbOvpPouZJoaCmciUY3DuSsN
 fGapb51LQgTRNQlytaKsnROon9SAmGOVM21xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733186065; x=1733790865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfZYsxWlWlmcTqJUqXW4Eo8/vCkVtNE2gbtU4uVWMQg=;
 b=GjhLr018xkDsQhcgY3PIC05kfVIswSFTrVhvHU8Qgd5oGlG0aSHp9PGrqpaY85LpDu
 uMaWu7D2QhZ0OmTPph06Y3l4LDtEIDi2egnE+kg4ipxj70JpB5GarP7MA4pX+8NFT2Jq
 moM24IPXkRsy7N2XR84Xvyje4O0RQE3YYpQgswWOcM973/9BpoGHJZmJyVjdC+YOb9my
 4zT3oVRwq5cII7lUvfL/J/MaK58s4ck//ewfFf5Km5Rbx27aogpb/7BzyvAHRrb4coYA
 Yli1zPKwKcffu2eunjpdtVcXLTG8AQgzL+Gqy45HTvgWqYMJEAAWFDMx31hCi2saUdrY
 7Zaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzIZ1kJ/C37I83F5Z5RrJM+LSSC9UI9yxlDhW3l9nZuV+cu+zyLJJLaes+J5crLtI9yW1XxgQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxgVjnzSZGBeCXopjubBShipBgnWHjab3YBFgwl6B5l84J1fCXG
 xyqWX+7tOFnfyZgKsb1ITxLg09taZ/TObu13kWOVTHiRvsU8YtAjxdbHBpOnvjc=
X-Gm-Gg: ASbGncsEoIFMcFX2GlWZDJqouJ037fssUdoEWgHlh/gxpcU6Gr+GD0JlkimzINuCyIX
 xpNnVCv1AZgfs3an1qG5HU5rLRdrMU3yL0UPV++Xph+CCvUT396REaT5bdPvCML+wG0xPdeT6wA
 cGwfD44HXz5itkugwqUOAr6XMuyHbDIRCM76k290oonYUlbnuhdRiZDy8zgl4jHVAUspbe9KKec
 oZ9nNufuBHFV82ly8kvTZCfEsJr4CGqD1BHkS0ewgWv0iB/7Q==
X-Google-Smtp-Source: AGHT+IGm7Otr3rRzzwEaDsPgnW4Z1gL2LZ4hY+hGebuvTdwCiJ9JTTmNdRXKK+mNiF5ao+1U0l/BjQ==
X-Received: by 2002:a05:6214:c84:b0:6d8:b81c:ecc1 with SMTP id
 6a1803df08f44-6d8b927a529mr6279056d6.13.1733186065324; 
 Mon, 02 Dec 2024 16:34:25 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b684921605sm461344985a.25.2024.12.02.16.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 16:34:24 -0800 (PST)
Date: Mon, 2 Dec 2024 18:34:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Guillaume LA ROQUE <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] boot: android: Add bootconfig support
Message-ID: <20241203003421.GK2457179@bill-the-cat>
References: <20241128-bootconfig-v1-0-0e63a5dae82c@baylibre.com>
 <20241128-bootconfig-v1-2-0e63a5dae82c@baylibre.com>
 <CAFLszTgFBtQBiC_Hd9gjUJa26aFFXLGuuvJ5gVDLEaKH-SV-dg@mail.gmail.com>
 <991937a4-9bcb-43f8-99d9-013d0c9d2dff@baylibre.com>
 <CAFLszTjY8YUhY5ZowWN0BgCK4tis8TJKJhX-n=d=MwFynq0E7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ep4pbrPTHi9f+mbh"
Content-Disposition: inline
In-Reply-To: <CAFLszTjY8YUhY5ZowWN0BgCK4tis8TJKJhX-n=d=MwFynq0E7g@mail.gmail.com>
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


--ep4pbrPTHi9f+mbh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2024 at 05:20:20PM -0700, Simon Glass wrote:
> Hi Guillaume,
>=20
> On Mon, 2 Dec 2024 at 01:03, Guillaume LA ROQUE <glaroque@baylibre.com> w=
rote:
> >
> > Hi,
> >
> > Le 30/11/2024 =E0 21:24, Simon Glass a =E9crit :
> > > Hi Guillaume,
> > >
> > > On Thu, 28 Nov 2024 at 03:15, Guillaume La Roque <glaroque@baylibre.c=
om> wrote:
> > >> For android vendor boot image version 4 bootconfig is mandatory.[1]
> > >>
> > >> In the android_image_get_ramdisk function, after copying both vendor=
 and
> > >> boot ramdisks, we extract all androidboot.* entries from the kernel
> > >> command line. These entries are added to the bootconfig section.
> > >> We then update the sizes of the ramdisk and bootconfig.
> > >> Finally, all androidboot.* entries are removed from the kernel comma=
nd
> > >> line.
> > >>
> > >> [1] https://source.android.com/docs/core/architecture/partitions/ven=
dor-boot-partitions#vendor-boot-partition-v4
> > >> Co-developed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > >> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > >> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> > >> ---
> > >>   boot/image-android.c | 29 +++++++++++++++++++++++++++++
> > >>   1 file changed, 29 insertions(+)
> > >>
> > > I am not seeing any tests for this code. Can you please update the
> > > test to cover this?
> > i don't know if it's possible with test framework in uboot, to validate
> > bootconfig raw partition is reading by android kernel. i don't really
> > know how i can do this , if you can say me if it's something possible or
> > not .
>=20
> We don't have a way to boot a kernel (yet), but we do have tests that
> check things are correct - e.g. bootflow_android() - and after a
> 'fake' boot - e.g. bootflow_scan_boot()

We already have a test that boots the kernel, test/py/tests/test_net_boot.py

--=20
Tom

--ep4pbrPTHi9f+mbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdOUgoACgkQFHw5/5Y0
tyxSQwwAlYAV1SL2WfoJBHLdxVhPywHmYuam2/VX+d9T9lN8ULJiUxtafwtguAuo
YRiddvvPACyUxjV8V+ncxUTGAdHO8y3VUe9i33F+tT5kW0Z3AUKLCDM4d0cqlYwV
GBbdJA71qW1/TBRR5uru8KhYlVVY7y3DUHEmqv0jdg4W2Lpq5hDXuAo6loWubNXm
uy9AcB9o21Wdm0g9cJKHZ0sFqD/ykfNOxjT/7asL0HspgbYkKL+lUMnGflKiXGbg
+Cl56sb/8F+DO0Dydp6iAAeCwHSUckKt8ZkgGyO8pWSmVq1Pvxxv1RFgUvS7kgle
bcVBq/7h7VrVhkW0JQqeOwUTuJcBqCFP0itIQTr7GCxUzIUA/qdwJ9nu7/RCufyP
fuHZZAoG9SAkBMytktjcjt8KbyxyhFLw4qzD6AyMcWxH0jagFfeVDTOBtZZ9nK0j
JCagERwyGG0YyURpyhekhKO/M0oI1g6WIzx6bImQKRLDgRZylxA+02ndOJlBrxvu
DAN24g+p
=WLcS
-----END PGP SIGNATURE-----

--ep4pbrPTHi9f+mbh--
