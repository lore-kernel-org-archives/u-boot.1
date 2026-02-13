Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F34DEDF16E
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 14:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 814AE83015;
	Fri, 13 Feb 2026 15:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NtJDAuGf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC54E83AA9; Fri, 13 Feb 2026 15:39:13 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F64780B98
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 15:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-45f053b7b90so645898b6e.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 06:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770993550; x=1771598350; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6IFaqew4gXZBSRp1I8JsqS6xzYQfiRpEU9L3nOmI9hE=;
 b=NtJDAuGf0M3SQ97RfCnIKAkjKtgw5qVwnZg4QIu74uUq+mVvtCFd+d5+vafnVA6JP6
 eHhgh2P5VMO7JqC3vdOcLUadhDhxdWq7zrNz90BZR5OviySIrEMMzfx2GMdK2tTATgUw
 aKOk0U9X5Knd6j4vx+vt/gTWyLfBvxu+iByLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770993550; x=1771598350;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6IFaqew4gXZBSRp1I8JsqS6xzYQfiRpEU9L3nOmI9hE=;
 b=bDzQheXqx9w/5cW2PiM7opXlOuZtGLulhTZPDPcL5coZzwYZz7gMa6Mco5vrtO67u/
 CYdA4XuCbu8y6lcSqya2jyKJLfBgcEaJs4mcS6OsqYy1xmhSG14qUdASsH5WCumASSd9
 0LwzcVC9XOc5zZM3iIy90ok/FRpaYvOv0kP3S/JbrtYU6y8Y/8JG3NqFdslRYr3DoIXa
 sxThQTL1UGTGjR3vGnxQpSbD+oVJ8yhPOHTFVYQG2lKdWxl96QOMJhcMMpRXBTK4g8Kk
 mOxlLvnq7Nrf8pW9uG19n/qIhdDzjxorspZj0Yb/bwmaLAPu0q+d2lFxyINvmdSzmxRW
 ceoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfKoLOCg57teuS92WutcqmKDHBHU5POWG0tdipsnefJUx1qvfLS3HbEXhBX8ayLwNdQQxxM6g=@lists.denx.de
X-Gm-Message-State: AOJu0YwMSE/U9yFdVba7ZbxkWLfnm/hBExnXWzGbuDv6OXAnwL6hRfJw
 J0vmcB5XDu1MW6yMG8uXEcCJVDmtK4FuUSAQpUoWZxBDRAtsxA/DyhozIUub0GzhmHI=
X-Gm-Gg: AZuq6aKFArkuoe/mgDCOFz0wBVzOvkoMG4wQl/zKpPCbcXm3sfiMCluczbkN/3vHYDd
 QvWIYrqz+/aVDEGARm60yESi+medIx7m0PmM8qFAX7zIldx72vX/HH+DOBLoPGxSmp/4Aq2DJoW
 DmFRW8/E7neJkxg+iBFA/ACtCrj/vyoHqRHj2On3N5/d496i6yTX1KeP/JUKiXCSNkqY9mI8kev
 D6dCytjYbT5jk/YxP6Faq6qnxODqk3t5vO+vco7V9Mn1a+f0y1Fr+UqpFUE5h74VsAvsKR/cHfj
 rMtWYyr+78RZiSj4XPNcqAnO2H2xLdw9Qu4rLyB2Bjg+AegGVl5DGQEtiu+fW9WaEL2msHmhwFr
 WDdMAS5pQhlN/xl8Im1L2DJ1BGI+c7QFNDiqspYqmYVSjQQjxCy5SUQ82j3b9oLYdBu67LAW9Wm
 vALJhzzeyL/Qa+H7N8Kj1ywwe0/PHQFackdWpoxON44qPkXhVCJwaZrC9XhbkeYXheQJONqFox9
 ule4AEMi6wCPynCIqN821YMspXnO9gM5C1DnhKdMnqypqF6biw=
X-Received: by 2002:a05:6808:15a8:b0:44f:e61d:18ae with SMTP id
 5614622812f47-4639eb68090mr1221652b6e.0.1770993549912; 
 Fri, 13 Feb 2026 06:39:09 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40ee06756easm3382450fac.13.2026.02.13.06.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 06:39:09 -0800 (PST)
Date: Fri, 13 Feb 2026 08:39:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 gabriel.dalimonte@gmail.com, u-boot@lists.denx.de,
 caleb.connolly@linaro.org
Subject: Re: [PATCH v3] fs: fat: Handle 'FAT sector size mismatch'
Message-ID: <20260213143907.GE2747538@bill-the-cat>
References: <20260122063442.2622684-1-balaji.selvanathan@oss.qualcomm.com>
 <20260128204102.GA1740001@bill-the-cat>
 <0d815ef4-0a9d-4aa9-95bd-580320357531@oss.qualcomm.com>
 <aY67Z87tM28Dtw76@hu-varada-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GW9SB3sJSZ/fUYAj"
Content-Disposition: inline
In-Reply-To: <aY67Z87tM28Dtw76@hu-varada-blr.qualcomm.com>
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


--GW9SB3sJSZ/fUYAj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 11:19:27AM +0530, Varadarajan Narayanan wrote:
> Balaji,
>=20
> > On 1/29/2026 2:11 AM, Tom Rini wrote:
> > > On Thu, Jan 22, 2026 at 12:04:42PM +0530, Balaji Selvanathan wrote:
> > >
> > > > From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > > >
> > > > Do FAT read and write based on the device sector size
> > > > instead of the size recorded in the FAT meta data.
> > > >
> > > > FAT code issues i/o in terms of the sector size. Convert that to
> > > > device sector size before doing the actual i/o. Additionally,
> > > > handle leading/trailing blocks when the meta data based block
> > > > no and i/o size is not an exact multiple of the device sector
> > > > size or vice versa.
> > > >
> > > > Tested on UFS device with sector size 4096 and meta data recorded
> > > > sector size 512.
> > > >
> > > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qua=
lcomm.com>
> > > First thing, clang shows a lot of warnings from this:
> > > https://source.denx.de/u-boot/u-boot/-/jobs/1365316
> > > Second thing, filesystem tests do pass:
> > > https://source.denx.de/u-boot/u-boot/-/jobs/1365314
> > > Please make sure v4 is put through CI:
> > > https://docs.u-boot.org/en/latest/develop/ci_testing.html
> >
> > Sure, will address the warnings and will put v4 through CI.
>=20
> Have posted v4. Please see [1].
>=20
> Tom,
>=20
> The CI failed while building am33xx kirkwood. When I locally reverted
> the v4 change and tried to build amxx related platforms, I was getting
> similar errors. It doesn't appear to be related to this change. I might
> be wrong. Please let me know if that issue has to be resolved.

This is presumably:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D12821&view=3Dl=
ogs&j=3Da007cd84-3be0-5a02-8a7a-a34fb3052485&t=3D216c79d4-eaff-5600-0b8f-3a=
63c01a45d6

And yes, you need to fix that. Your changes lead to am335x_evm
am335x_hs_evm am335x_hs_evm_spi failing to link due ot overflowing SRAM
size.

--=20
Tom

--GW9SB3sJSZ/fUYAj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY83hwAKCRAr4qD1Cr/k
CnW2AQCn/1oE1kMz4nZPfr9qrxhDdATJXRqnXnZYwywcRTiFxQD7BM6W2nIyA7IR
ddLs88xJ3b0JaGbF2JBxyZ0S9y1N5Qw=
=ZAx9
-----END PGP SIGNATURE-----

--GW9SB3sJSZ/fUYAj--
