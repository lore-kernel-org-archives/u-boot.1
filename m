Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B476CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 19:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D11886BA4;
	Mon, 16 Oct 2023 21:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NfejucaU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FAD786555; Mon, 16 Oct 2023 21:31:00 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6206F86C91
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 21:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a2536adaf3so66683707b3.2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 12:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697484655; x=1698089455; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WdsArn6W2RkyLViAaC5VFwVJojEAV3gfSba2I1IMLf0=;
 b=NfejucaUY6Y9Bz55B9QyhnxxFBfzZHFUSHRSw+BgnS9eTM+9SiPqAyeR1pOHVJdnAb
 xqr8Mx9sUR8QDZR5nVvDOmIKFNscQHC1MPijAdMSwWY/mSVfzJpDlsbwLbmHC4Fph2E5
 ToPn4qotwNuAB1Tib1mI42tgl4ncyKE0g9wNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697484655; x=1698089455;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WdsArn6W2RkyLViAaC5VFwVJojEAV3gfSba2I1IMLf0=;
 b=xGZuD/whDDFrR9zIsSKZ07N7XZy07GsZSFfeQHuCyvPd7aTJgCQ03lEJMn8hBfF2AJ
 gI5NeF+Bl+q5wWRG0LgIhH2ei4A83daUZy/X71zeQK6ro3nHCCsbB1rHOdcZmmSB94ai
 V+7k3xtHsUrll32vZYs5isM2vcR+9YAVeGYWx7ajOk3id9vUx/2j+Yg9y9eA6P+AD27F
 Yt66+yAZUKDREKL6fHws8t3P5k+FC8LiDia4/0n/Di5DeAKrkPhWZz0jGuy63WYOcPFg
 Djr+mF8wDq+fc50hFAbH+VXtFW2l+sp8THPDBCTs8XL5x3zrGwRwKsf0V3jGeY+E7cJw
 zm3w==
X-Gm-Message-State: AOJu0YxQeNANqiS8OUQeZrtYX7kuI7AnMBYa+zypEWOsHWI18NGS3Ok+
 mkxY4OMo9zdvJH+NdRTc9zLjR1o6EP4gZdHFCW2qlQ==
X-Google-Smtp-Source: AGHT+IFwGRy+jGPgC3PzOw6e+mNRwBhUYoUjw4WHeqf9W87A7Ytamdv5dZklhjj81BWIRa3PvOhfig==
X-Received: by 2002:a81:5241:0:b0:5a7:d73d:42cd with SMTP id
 g62-20020a815241000000b005a7d73d42cdmr110081ywb.20.1697484654858; 
 Mon, 16 Oct 2023 12:30:54 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 u11-20020a81840b000000b005a7c969137csm2451453ywf.19.2023.10.16.12.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 12:30:54 -0700 (PDT)
Date: Mon, 16 Oct 2023 15:30:52 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>,
 Eugen Hristev <eugen.hristev@collabora.com>
Cc: Da Xue <da@lessconfused.com>, Marek Vasut <marex@denx.de>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH v2] usb: xhci: Workaround to fix the USB halted endpoint
 issues
Message-ID: <20231016193052.GF3119521@bill-the-cat>
References: <20231013045356.25789-1-venkatesh.abbarapu@amd.com>
 <2016c1bc-dfe0-416e-a910-75e6cf25036c@denx.de>
 <CACdvmAju3wDL0yCJtVdEf47u+L5R3AvRpcuJ+ruKFXDTcQ-TBw@mail.gmail.com>
 <20231013151540.GJ3119521@bill-the-cat>
 <041b37d4-777a-4c02-b8fd-9985c2cfa938@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ijgQX348/aGhOQm1"
Content-Disposition: inline
In-Reply-To: <041b37d4-777a-4c02-b8fd-9985c2cfa938@amd.com>
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


--ijgQX348/aGhOQm1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 08:34:16AM +0200, Michal Simek wrote:
>=20
>=20
> On 10/13/23 17:15, Tom Rini wrote:
> > On Fri, Oct 13, 2023 at 11:11:04AM -0400, Da Xue wrote:
> > > On Fri, Oct 13, 2023 at 7:47=E2=80=AFAM Marek Vasut <marex@denx.de> w=
rote:
> > > >=20
> > > > On 10/13/23 06:53, Venkatesh Yadav Abbarapu wrote:
> > > > > The xhci host controller driver trying to queue the URB's and it =
is
> > > > > getting halted at the endpoint, thereby hitting the BUG_ON's.
> > > > > Mostly these kind of random issues are seen on faulty boards.
> > > > > Removing these BUG_ON's from the U-Boot xhci code, as in Linux ke=
rnel
> > > > > xhci code BUG_ON/BUG's are removed entirely.
> > > > > Please also note, that BUG_ON() is not recommended any more in th=
e Linux
> > > > > kernel.
> > > > > Similar issue has been observed on TI AM437x board and they creat=
ed a patch
> > > > > in Linux kernel as below
> > > > > https://patches.linaro.org/project/linux-usb/patch/1390250711-258=
40-1-git-send-email-balbi@ti.com/
> > > > >=20
> > > > > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.c=
om>
> > > >=20
> > > > I already explained to Xilinx how to sync the driver with Linux and=
 why
> > > > this is needed to move forward, multiple times, and even provided a
> > > > script which does most of the work automatically, since it is basic=
ally
> > > > automated process. Xilinx did not even bother to test the script and
> > > > provide any feedback.
> > > >=20
> > > > Until that happens, this patch is rejected.
> > >=20
> > > This patch also causes all of the USB devices on certain platforms to
> > > not be detected:
> > >=20
> > > scanning bus usb@c9000000 for devices... Device not responding to set=
 address.
> > >=20
> > >        USB device not accepting new address (error=3D80000000)
> >=20
> > Yes, we are stuck at the impasse where the custodian is asking for
> > someone to try and do the re-sync, and everyone else will assist with
> > testing on other platforms, but the re-sync hasn't happened.  Can we
> > please get someone from AMD to attempt the re-sync?
>=20
> I would like to say that we have someone to do it. But I simply don't have
> that person.

That is the big problem we face, yes.  Eugen, I think you said you were
going to try and find time to do a re-sync, did you end up getting any?

--=20
Tom

--ijgQX348/aGhOQm1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUtj2gACgkQFHw5/5Y0
tyzLHAv/XJCY6hqXy4HyedS5NE1KTPfUCWc4OCWe5mrCZhsBGhBStrWdbJSsMAnp
/jHB5LSDZiWeKDaITdheBfp+MlATLvX2niqQ1Tpv9Qf+mGSCUHdDcj1QK44ENkzx
67Lg1TXLD+s9fsplJBb7owxSn5aGAO9R1bk+NZQXdcbThFM2aiAa3m2Stj7V6mx1
VmVfs0bMAmaknT9GAOLvWFKUGFSw6S3OEUiw/xIXLdKnGqSreAi6i1GY3yfrvrnN
eqDb+apMRG2Yw65Fx2HxPc72pt0LYQCU4p29DtfR1DBLZzBupSr+7IIx3N6IC2CV
TmgGVfDLs7GY/IW9mYItz3+qjJ3vsXmBeYUWeO0B7p7Wi3JuyR9evnLp3yMvU15n
bX2sQ1CU2e+N+Mq0y3hMQKzey766q1JpljI04WN8KToHNcRM8gYjnHSIkULDYEgF
hblzKsdbp/EQfrJvv3eg4UJtgT6X/UjxtHwmUoqDITBkmoeMxqf9+vo7SXKY7e9x
hHKswESY
=+1qH
-----END PGP SIGNATURE-----

--ijgQX348/aGhOQm1--
