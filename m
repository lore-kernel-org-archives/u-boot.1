Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BBFC197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C93D86F27;
	Fri, 17 Nov 2023 14:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tzX7zFVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 011E386EB8; Fri, 17 Nov 2023 14:30:43 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A32B86F27
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a90d6ab962so21965137b3.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700227833; x=1700832633; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OAG+ZLLQww6uEhigOIKN6lUXZM/HY8BUG/kGAZ1/pAY=;
 b=tzX7zFVsco5CjKvYzyWz/W0xkYTRgEsmQJ3HFAlMlUSohiJzeyyCdfciucjAiKtLIe
 BxQLxAP5kDOB4R/JZDVW+MbS0NoZW4CUA0YMaxNmTK2jZS5p8dpisZ3SZiHGo3s4ziPe
 roM1ek31f6pQPFUmCNWoH310gokVCyhpjdJjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700227833; x=1700832633;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OAG+ZLLQww6uEhigOIKN6lUXZM/HY8BUG/kGAZ1/pAY=;
 b=FtxKBeoGWBd3MKlkOqO+t7mAppbHGewocPPvPeI04O+s2gSJHRAiBysHswq4O/7s/J
 IK2AuhP0iAkrr58D0vxC8nxW/Eup0gVu529CwjlmmRgGg1TvRcW2kqtuaLLoVraKLvv6
 H2uwupHF/1sYGPhgydaeIEqK4Ms51EIJMtFKrH1X9On9UT8zEZrGEUK/DNk/Ckrn3a8E
 FkpYvbjC/lOzMJIdUb6khNf+za6s04stl5MxRauDu9FmFE8DwL5lqLzx3wQO6/fz72ry
 SiY26wsvDnWVrOqeofg93DNKiDIEyyWmjHGpdVZVc2N8wY0bZk+vVTqrb8Z2WYP2qe7f
 qwkQ==
X-Gm-Message-State: AOJu0Yy/LBX684z1WP9KnDdkMNPGzg9IdXwdT5ZrkUcAOnusxI0QDMEH
 9Fu3UGptWQ01brZ0yBsbWUOCDg==
X-Google-Smtp-Source: AGHT+IHCI6yIfQPcqBZ3RfJtW5x9Qo94aQc6LrGPJf3+koHAZq3T2qnOLPczT4zuauuQ//FG8iFm6g==
X-Received: by 2002:a0d:f383:0:b0:589:c065:b419 with SMTP id
 c125-20020a0df383000000b00589c065b419mr19171851ywf.34.1700227832822; 
 Fri, 17 Nov 2023 05:30:32 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 x83-20020a814a56000000b005bf57ef572dsm475416ywa.140.2023.11.17.05.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:30:32 -0800 (PST)
Date: Fri, 17 Nov 2023 08:30:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Mihai.Sain@microchip.com, seanga2@gmail.com, u-boot@lists.denx.de,
 Nicolas.Ferre@microchip.com, Aubin.Constans@microchip.com,
 Cristian.Birsan@microchip.com
Subject: Re: [PATCH] arm: Enable SYS_THUMB_BUILD on AT91
Message-ID: <20231117133030.GI170968@bill-the-cat>
References: <20231105022742.632175-1-seanga2@gmail.com>
 <20231116184702.GA344953@bill-the-cat>
 <4906942a-8140-4264-afaa-3072f2eaed98@collabora.com>
 <PH8PR11MB68049E01B9388C294E9DD10582B7A@PH8PR11MB6804.namprd11.prod.outlook.com>
 <6133d5a4-9baf-486f-a595-59ce922964f9@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v6RB6ZjvAXykGFRZ"
Content-Disposition: inline
In-Reply-To: <6133d5a4-9baf-486f-a595-59ce922964f9@collabora.com>
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


--v6RB6ZjvAXykGFRZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 01:58:35PM +0200, Eugen Hristev wrote:
> On 11/17/23 11:15, Mihai.Sain@microchip.com wrote:
> > Hi Eugen,
> >=20
> > I built new binaries with CONFIG_SYS_THUMB_BUILD=3Dy for sam9x60_curios=
ity, sama5d29_curiosity, sama7g5ek and new sam9x75_curiosity board.
> > I used the latest u-boot/master branch for this test.
> > I noticed that the file size of the binaries have beed reduced with apr=
ox 150KiB due to CONFIG_SYS_THUMB_BUILD=3Dy.
> > After flashing the new binaries on these boards I can confirm that on a=
ll boards the linux kernel was booted properly from mmc, qspi-flash, nand-f=
lash and usb.
> > I tested using bootm and bootz commands.
>=20
> Thank you Mihai,
>=20
> Tom, Sean, are you okay with this going in the next merge window ?
> It is definitely not a fix, so that would be the best.

Thanks. I was looking at this for a series to go in to -next at this
point, so v2024.04 release.

--=20
Tom

--v6RB6ZjvAXykGFRZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXavMACgkQFHw5/5Y0
tyzoLwwAhlDCiRPk/YBJn/9YQw2vmBT8C6bmuVoa5NbS8wgScA7CnUf7tZFfNSp8
C+11qy3wdufhdljSOpNy2WrTUhzytTLPEgNuGiRJkxsnwee6Fj01RmsH129xkYyY
3QdJpYNL4ByZfnd4j7vizVBE+9H8+X8dbBAhqMxQMny9Unc952g7hIHkCO1mkaw4
b7/LLVCu1ATK4sqq23CQjT9l7hizyuboRdELt405irfMGyqZ5EKbGjphnrWv7Yea
lTGMiqLGO8mspPahhc0dqNp0/sffOQdMURaWSMVOR+MDI+r7xGEXUqGDubl2yOZH
EEQ+KlOYflh4wYyuZr/y477q3g2Djv06UwuPzLEd37MV058JjwjxdkW7bxLhj6vY
IlZ1J2pEDzUWwYI6/CE+t8O5QyaeeCf0npp1HpCxybMS2fUt63GQAYaT6Jjy7swM
ZlIcrBsdpdmoXPzbCkBTe/keFcsy8B7+rGVyhobolgwoYQqDDzCxEb5pLTUq/6uM
lC4OTOaO
=hHPT
-----END PGP SIGNATURE-----

--v6RB6ZjvAXykGFRZ--
