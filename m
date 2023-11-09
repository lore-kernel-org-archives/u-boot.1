Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DFCC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 00:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B6DB86FBC;
	Thu,  9 Nov 2023 01:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MUwdkE/C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 676A986FBC; Thu,  9 Nov 2023 01:17:55 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B0BE86B18
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 01:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-42033328ad0so2085771cf.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 16:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699489070; x=1700093870; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZuVX2yWlxxRvNbMPkY8IlzJOq1a6ZEy+3+m1jhgUhfw=;
 b=MUwdkE/C/gK9ms5aBUIN+Rci4K30WuWfCENg0umAznBDmJDgwyFFjReDU/5YMiXhb3
 U2mcwQP+uYqkXmNpuYNTsLUm/0GU3O6pZ9BXysXFyM6e+e+GZAzzCC/yys9Ze+IeTUIZ
 Fa0kqnRnF+76bh0nPSEd7+aFcr/6BF9OlOB70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699489070; x=1700093870;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZuVX2yWlxxRvNbMPkY8IlzJOq1a6ZEy+3+m1jhgUhfw=;
 b=IU9cGcOv36xbOucXRDHRYY/uFiGxfVZ3j8SLZszre7MuCucz2BFE+sh9DhAibdIhX3
 lQx+ZX33ThjMmgFyJJdNrNiy01rBn3qyImHpMT3fK+rr7DQ8pLknfq8WCrO0NftHQCVu
 Uu6qvbSpvpK5W0H9PNfoii0fJl3tyfGY0z+eXpU+ICR9YzUEYR+VTykdHtq48QdM0Jhw
 o9BBcUQJEi43qz8aQ4GxWVGqfeetMBjaa5uG0L2QhN5f+F85viKOgtKVKg50+BAP244n
 mtDlivSDOMEld5MC95G70S1oMhq8kPEhbTaRVbfBpYRhP0dCxpquzR4WKweVNbwWg/7T
 m+5Q==
X-Gm-Message-State: AOJu0YwYL8lnjygeQkkSvZ03wRWRu6zVKjdZd8cDVNx8qz5HYTG7dl9H
 6K7NH1bzRFRUJpe0SUgZyljrHg==
X-Google-Smtp-Source: AGHT+IGTpcSuJsBuQ2U7Z1qqN+HnpcHW7GJ5uxo8OldSoG2xT5r4wAfpKy0eIj/O5RRbv4rJJNM77Q==
X-Received: by 2002:a05:622a:606:b0:41c:c34a:84af with SMTP id
 z6-20020a05622a060600b0041cc34a84afmr3870644qta.6.1699489069764; 
 Wed, 08 Nov 2023 16:17:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 jr23-20020a05622a801700b0041aff9339a2sm1417561qtb.22.2023.11.08.16.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 16:17:49 -0800 (PST)
Date: Wed, 8 Nov 2023 19:17:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>,
 u-boot <u-boot@lists.denx.de>, Duncan Hare <DuncanCHare@yahoo.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: Re: inconsistent wget behavior
Message-ID: <20231109001746.GX6601@bill-the-cat>
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l6EQubW/kOZN/HL0"
Content-Disposition: inline
In-Reply-To: <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
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


--l6EQubW/kOZN/HL0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 09:00:23PM -0300, Fabio Estevam wrote:

> [Adding Tom and Marek]
>=20
> On Wed, Nov 8, 2023 at 7:22=E2=80=AFPM Tim Harvey <tharvey@gateworks.com>=
 wrote:
> >
> > Greetings,
> >
> > I've recently given wget/tcp a try and find the results inconsistent.
> >
> > Transferring the same file 15 times in a row will eventually give me
> > an incomplete transfer with packet/byte count wrong but showing
> > 'Transfer Successful'.
> >
> > Here is current master on an imx8mp-venice-gw74xx board using IMX8MP
> > EQOS enet dev:
> >
>=20
> > u-boot=3D> time wget $loadaddr
> > /tftpboot/venice/core-image-minimal.ext4.gz && md5sum $loadaddr
> > $filesize
> > HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | |
> >  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | |
> >  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | |
> >  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | |
> >  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | |
> > Packets received 64368, Transfer Successful
> > Bytes transferred =3D 93198937 (58e1a59 hex)
> >
> > time: 3.103 seconds
> > md5 for 48200000 ... 4dae1a58 =3D=3D> 69bedfe899148c43c09a98ac950dd0ed
>=20
> ....
> > u-boot=3D> time wget $loadaddr
> > /tftpboot/venice/core-image-minimal.ext4.gz && md5sum $loadaddr
> > $filesize
> > HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | |
> >  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | |
> >  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | |
> >  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | | | | | | | | | | | | | | | | | | | |
> >  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
> > | | | | | |
> > Packets received 64368, Transfer Successful
> > Bytes transferred =3D 26984682 (19bc0ea hex)
> >
> > time: 3.011 seconds
> > md5 for 48200000 ... 49bbc0e9 =3D=3D> c9978ff116605a7729a1cb14ef51fc20
> >
> > Anyone else seeing this?
>=20
> Yes, I am seeing the same behavior on an imx8mn board using the FEC drive=
r.
>=20
> I am transferring a 412MB file. Doing the wget transfers several times
> in a row, I also see the incorrect number of bytes transferred:

Interesting.  What if you take wget out of the equation and use "tftp"
to grab a large file with a known checksum, repeatedly (note that "rhash
-C" will give a crc32 in Linux so you can confirm the correct value and
loop a get, crc32, compare, repeat loop with a little work) ? I ask
because I was reminded today that for me at least, the RPi ethernet
isn't reliable in U-Boot for me if you stress it too hard. So I'd like
to try see if this is "wget bug" or "network driver/related bug".

--=20
Tom

--l6EQubW/kOZN/HL0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVMJScACgkQFHw5/5Y0
tyyFpwv/X1Dp4AMxlXj31DI57RuobVg22MfhXm4qTVmRl3lxaklrhupnac4SGJJF
Gx6QoCtJTxTPDn+TRbzVbRwbFkwyDMruv/yV9AgX/wGfDY1M21V7tDyfaQgdwdrh
DUkw3PVT26zBtLhbUsp9ObmSgCzyB+/I1AAn5quxG28WVu1Z//ZW8oUNVvs+/2Wn
PKJJTo2zYzMHG0A9ikqAfO5yspzQO9XqiwrfzE91/TLL2JnQV8/lKQaHdAUUrPY+
9bze4drWGgKnWkAgzezCEVzfWU6YryINlFlNqEtUng3G/En9nyG3NLSb5IPApzxs
RmSD06uB4/4J8rv65XpAlIQj3O8G/ogk/DB1/z/0EOEj//cO+rC5FkP3tRJoPbWE
A2kM1TrSbilpS7+xk/UnRuVmNdwNrvJnmVvEiN9Vfm06/82tvsjEPx5FQf+1aXG1
bLSiwIXMcyyVidPMxdHp+N8YH4CGelQEiQV0+V5eDlHbXRFT6Wud8bxJdWZC7tXG
P7Dts7GZ
=/xcv
-----END PGP SIGNATURE-----

--l6EQubW/kOZN/HL0--
