Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDEFC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 12:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCDE681578;
	Tue,  4 Mar 2025 13:42:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="ZkS85QwT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29FD581578; Tue,  4 Mar 2025 13:42:23 +0100 (CET)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F96C81335
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 13:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741092137; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=K4D6HmURfrvbcBr3pnGlzqNAzl2kuusGhH1V4Su0ue73Z755T9uSBricjxYEf+VNzBN1R6FepuMeoYDUkfO66qXF8CVe9Su/SLP2rzxGHxy7yB83ChCTGkC+Xq6UhardTlJub21lKSMv/bvRD+zaWzyUeuQGsUBFgFjZTwqoCR8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1741092137;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=b5HnFW3Gxv7wW+yu4MVwZf7lt6owip3/pTFk04nh0Es=; 
 b=eQPm0euPpwkQnHkvOrEmJ7hVKnut6FvIJBmOfKeJSzt3Cj9kDPbtobyzU1epSQQsnKCk64aFGo1GCHp/WJGjkihGu+gqPzIXCaN7PqNMMhE9uhmSH/682WjyoqBhw3Vxlxzqm0e7nuPP3ITt0dxWusIHQkKMzN2bwr7lJePmdQY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741092136; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=b5HnFW3Gxv7wW+yu4MVwZf7lt6owip3/pTFk04nh0Es=;
 b=ZkS85QwTpUr1nwatGfLW81JK5NljVBMKXTuTJT8bx2DEZArNqXG5R+uw7yZRsmP/
 +peQ1pJID9Ypfy57ZhM6MVzmZISTTzV51T1Zeke0wr5LL1bzVwSmdaadFMPgdCvo6JX
 OjFs1W59Mg61D28Z34eHFbfZ6/Sv5SqNmC5xHwIc=
Received: by mx.zohomail.com with SMTPS id 1741092134330540.672431400211;
 Tue, 4 Mar 2025 04:42:14 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
 id 89C7E180C9F; Tue, 04 Mar 2025 13:42:10 +0100 (CET)
Date: Tue, 4 Mar 2025 13:42:10 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Marek Vasut <marex@denx.de>, 
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Soeren Moch <smoch@web.de>, 
 Tim Harvey <tharvey@gateworks.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Maxim Kiselev <bigunclemax@gmail.com>
Subject: Re: [PATCH v2 0/4] USB-PD TCPM improvements
Message-ID: <oxb7v5iwqjgyhsk2tc76oybmnmfvvnen67g32vpht3fgnagvif@t4enpaooabmv>
References: <20250226184506.64114-1-sebastian.reichel@collabora.com>
 <CANAwSgSur2VawHniSEZBD3AO63YnvUGf9m1_8p-XMNxQF+yziQ@mail.gmail.com>
 <CALeDE9Nq_xbOc3W8hefPQuVBi_Xc_2r18cw6+jeEHeGKyHEa-g@mail.gmail.com>
 <CANAwSgTu3ixjQRLZRqx_+nHNinDJSdphHHELtiHLANs+LF9YCw@mail.gmail.com>
 <fbzod24w4kjhntzcnt36znqtyfykoao7u6g37wvzejtxxyljm4@w44tbipyhfkr>
 <CANAwSgTcDL8o_t90+aL0g0FnvoiJE-risKCJBFrYrp9DukmtVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5n623jjj3tq2tdzt"
Content-Disposition: inline
In-Reply-To: <CANAwSgTcDL8o_t90+aL0g0FnvoiJE-risKCJBFrYrp9DukmtVg@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/241.78.79
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


--5n623jjj3tq2tdzt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/4] USB-PD TCPM improvements
MIME-Version: 1.0

Hi,

On Tue, Mar 04, 2025 at 10:35:03AM +0530, Anand Moon wrote:
> However, I have a question regarding the Type-C controller's
> connection to the PMIC via I2C. I didn't see a corresponding
> controller node in the device tree source (dts) file that would
> support this function.
>=20
> I feel this might be causing issues in maintaining the power state?
>=20
> [1] https://github.com/u-boot/u-boot/blob/master/drivers/usb/tcpm/fusb302=
=2Ec#L1285-L1316

There is no direct connection between the PMIC and the fusb302. Not
in the driver, not in DT and not on the hardware. The fusb302_get_connector=
_node()
function you are referencing is for the USB-C connector devicetree node.
You can find it here:

https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/rk3588-rock-5b-u-=
boot.dtsi#L35

Greetings,

-- Sebastian

--5n623jjj3tq2tdzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfG9R4ACgkQ2O7X88g7
+poj+w/9HheY3UDsPgQW5bG+pYVGP5xCs4/r9FtgYlevxwX23vQbDx/W6OWKzaiJ
ewB8+KoA0fLHtBCb6+bQLYIIkkkqxM95UyfGADFzvr4Q9WvU3kMi2PWlfMlwHeVG
f0XPrlVfzjDwYE8QyRygOK0IFJ/Y6b1bgcOG2/HaWiXYpyh28DdYF3g7n0N+mgsu
UylU0eGiRktBOY/5lkoioiLyaIOkaVIEx0157UgE8ioGJVO/syE8qLIX+2QzUo6h
gBggR5Pk/G1iHWzGNcjHDp6avHsjUmYcYEmfpHPHTz7sckIv3yw/PxUokG8Admll
WXbf71f8MlLHbUk2ZzNeCaLm8t5cBbXCP22JmdAmVsuzCS79cND1b1MuCTrjgIIM
aTKSbwHzy6j8FEwQZCeilw+Ed3awRFRMFVWJ93OsBeqaFzZ7ntAqBpu6q56qXLFz
6uzB6vnvZgAieG7dr32SDLQUockenJ//1bHsTnHz590zmv/vamda5WZxak/fOE2k
dg2THTdz+HonM08P/PutjHVEfhi+2hl0hXqy9uroy6UAsi4jYFCFzomJ5UNg+6E2
gKq94XvL182vekyZm+xcUGAsBj6+G7cynESntYSzU5A1R5+bljjulM9VCTT1gujk
I4mAZhb76Wa50HwpaASqxe9ANwzg5vcUOAFCRU5rQ7QIYkIEEXM=
=1J9L
-----END PGP SIGNATURE-----

--5n623jjj3tq2tdzt--
