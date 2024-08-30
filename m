Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8947CA0ED0
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 01:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD4488D08;
	Fri, 30 Aug 2024 03:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eEubcm1d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46AE788D0C; Fri, 30 Aug 2024 03:49:50 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D245881A9
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6bf99fee82aso7244646d6.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 18:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724982587; x=1725587387; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S5rA9eY5rUz09Y04dLJRIwewoFble8gFp0yNd/PjoTQ=;
 b=eEubcm1dGpnGU6X3vPx956rvaZRCxx1Q+Ea7yTX2b+ik73wtitr3AnlQk7XCfclZnP
 xQCFZpvTxo9faX2QuFAvdFeAY89donEkkJwGZwgTwP3/QvMQz1ZQTeuHC3tRfkOAmkLo
 tSseaxJmtrCRJYJBdcHduGEZqCjLmMIrG5jiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724982587; x=1725587387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5rA9eY5rUz09Y04dLJRIwewoFble8gFp0yNd/PjoTQ=;
 b=RXpVnJUUgNmBRsBwxUbRlNOPOmQRe8gSHEflO8G9iXqnT9n8cdFTJAxrjgBVpkp5IZ
 FU+C+5UM69lvcB0jf3zElTJ6frPts8pSi4yTW6FhAEZXF1dV7A3Qo2uiEaoz93MkC35I
 LWpzyE/Q9JQtGnFPtxJRnaVphbH9dJSJTwQY1pbsPpYA9i8bctgMLQMevduIPpoehqoY
 k1IvWxvTOT5iMsybC35UJnbKUD8XNu49Iw59i+rf6g4XP8j3mmvItL0HamZqy6TyvqPW
 peZj+Voq3dNkyvxaToGsjOa3HrgbCWYHpdhYIjDibFwkCyexiezHgFpdK563j5Edsk6+
 QAyg==
X-Gm-Message-State: AOJu0Yy64YSucVmKa2xAMBuWQUrnkvljLcJAFcJr8mUFUfLTaq11RUbO
 jHuv3u2bDJCE/wA3b5zhYsES4EaLJRbEG98JBWUARqLsE47k8lQF7yQBxwab8CI=
X-Google-Smtp-Source: AGHT+IHGTMnO2haoq8GUfBb/F5mTIvfH/yihSX/nExwd9Zoyvlz6i96atKPWG4ou95iRuOc/tKbVdw==
X-Received: by 2002:a05:6214:3b8a:b0:6bf:6f1a:f679 with SMTP id
 6a1803df08f44-6c33e685cd8mr54105126d6.44.1724982586874; 
 Thu, 29 Aug 2024 18:49:46 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340db3f7dsm10363376d6.145.2024.08.29.18.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 18:49:46 -0700 (PDT)
Date: Thu, 29 Aug 2024 19:49:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [u-boot-test-hooks][PATCH 1/2] bin/writer.rpi_mount: Use kernel=
 and simplify logic
Message-ID: <20240830014943.GR2479150@bill-the-cat>
References: <20240829185602.3179812-1-trini@konsulko.com>
 <CAFLszThtfWK7pm-JV35Z083G43TL3ySfcuX9a83-rcMHmh=OnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/SjpAJ3U2/DkhCuB"
Content-Disposition: inline
In-Reply-To: <CAFLszThtfWK7pm-JV35Z083G43TL3ySfcuX9a83-rcMHmh=OnA@mail.gmail.com>
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


--/SjpAJ3U2/DkhCuB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 07:06:06PM -0600, Simon Glass wrote:
> On Thu, 29 Aug 2024 at 12:56, Tom Rini <trini@konsulko.com> wrote:
> >
> > Rather than guess what we need to name our u-boot.bin file as for it to
> > boot make use of the kernel=3D option to always call it u-boot.bin and
> > then on 64bit platforms (and since future platforms use rpi_arm64 this
> > list should not grow) also pass in arm_64bit=3D1.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  bin/writer.rpi_mount | 25 ++++++-------------------
> >  1 file changed, 6 insertions(+), 19 deletions(-)
> >
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> > diff --git a/bin/writer.rpi_mount b/bin/writer.rpi_mount
> > index 73fb8bf6af04..ab7c3b5a2430 100755
> > --- a/bin/writer.rpi_mount
> > +++ b/bin/writer.rpi_mount
> > @@ -25,30 +25,17 @@ build=3D${U_BOOT_BUILD_DIR}
> >
> >  echo "Writing to ${mount_dir} from build at ${build}"
> >
> > +sudo cp -v ${build}/u-boot.bin ${mount_dir}/u-boot.bin
> > +
> > +echo "enable_uart=3D1" | sudo tee ${mount_dir}/config.txt
> > +echo "kernel=3Du-boot.bin" | sudo tee -a ${mount_dir}/config.txt
>=20
> Does this keep appending more and more lines?

No, the first tee will zero the file and subsequent -a's append.

--=20
Tom

--/SjpAJ3U2/DkhCuB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbRJTcACgkQFHw5/5Y0
tyzJPQv/QmDG0Oro57GfHHpVAwi/0OScLr/cwlHf6RhZkqohI+ZV65CImilx57/H
bdBJbkRhFTawrQCEMxzWY6NInZTssrCS8PU99VeCmzM6LkZacaj+5kK9N+UlWYbb
/SeuSaMyUMEEN42m5KiVIeXjK6sKgjyQvvicejPZrMqegIC8YVQqCltC0XOrFo9M
Lf57+nyQoAvMef44uGBrN3tUPygRRo/pHVBTeG+4rnFVWuDV2DiuIJvfTMmggFAl
O5LaoK4hXWUdayc+J7xfXJgh7dmGWQBNMoismhCyuyTC4ZsN9cA3KAe6xW8JphUu
+Y/9LBZ/lKd5nOfCUUY9jeeS8kEomO8DHwrZtVQsbTZanibRCrWjl5wSOU/Mo/2U
bb3Q9ijg+u8ZegDbJkVdPBbtP2ghi/viIFXBSbIXX5OPgMxKhWxJpIP5b4LHhQfB
pZpxgiTOb/hM4jEf0og9OgztYE9fgR6zk644BDugUkz/fCaoOJQ/9Gm2T3+FZSyS
ZOjoDVqM
=O+Cy
-----END PGP SIGNATURE-----

--/SjpAJ3U2/DkhCuB--
