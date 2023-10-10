Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D58CD80CE
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 13:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 705B286E05;
	Tue, 10 Oct 2023 14:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dMVpG2S1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06E1586DF6; Tue, 10 Oct 2023 14:59:07 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DFB886BB3
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a2379a8b69so68767167b3.2
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942743; x=1697547543; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gO0I99AwqIIN61d8j66AXe7naAhEvGOeJqU9B2oj5D0=;
 b=dMVpG2S1xF6qiDnuHEykABUmURNBS0MKeJSCDaoM7S+vibsNCIT1lGb+jZFVS0oAw8
 SFNTA0rMFGugo44rPfikr9YPaNakRYCC9SlnOirq5+vJaN9oBxtesoVwysnm+6bjjyxn
 LIkeGbo79WDnkKtZ6OHfFibkdkj152HmZpL7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942743; x=1697547543;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gO0I99AwqIIN61d8j66AXe7naAhEvGOeJqU9B2oj5D0=;
 b=EvSS18RGl6zFLVdREflvKWfmEWNXWA/AK/tcp3G+95XeAU2pI+jIki2kW7MPsOoSBF
 xy1uiTh6PFeSdVS0aEUVzeyDbsqR77nfrZOtnrVzw6DH3YHdFtd4F3d8AU+e/Qe2RmbW
 fx0uvky8lxOvXUqWUsspix0v4VQizNHvKsacTAD+wFtK7hYvzFltrZjayhTV16K/6b2S
 uvIHmYt8ENsazO9NcwhQX35dun8meErYoWV+rR10Wa0h2aBs/BXYAOfUn6cUJn/8fkR6
 /nMGO5cw1D1qJgFHBFtRVBQvyOKz4EphJncRxddOkKoM5QPRlNipYhKVGQAQal9oPpln
 i9bg==
X-Gm-Message-State: AOJu0YyVucDgr0rje3FciXlNbN5AZzt45c3x1O+kugZAHv8k716y87xR
 5J1RJHjrzCq6j2+NLtQfb/YHuDRjwZbTPBgJiyxfdg==
X-Google-Smtp-Source: AGHT+IF+vZjnfsHH7tGRip0pQu9/aT2lE+ssqpfK5vW8AY6oTuKH4H0JY5hY+mUbxvpYJdlttDGIdg==
X-Received: by 2002:a05:690c:dd2:b0:5a4:f7d3:394e with SMTP id
 db18-20020a05690c0dd200b005a4f7d3394emr24473776ywb.14.1696942742954; 
 Tue, 10 Oct 2023 05:59:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 t184-20020a8183c1000000b005a247c18403sm4470038ywf.37.2023.10.10.05.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:59:02 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:59:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de, lusus@denx.de
Subject: Re: [PATCH] board/km/cent2: Fix buffer overflow when fixing MAC
 address
Message-ID: <20231010125900.GG2227687@bill-the-cat>
References: <AM0P191MB06891CA6155F4B995969E9E7DAC0A@AM0P191MB0689.EURP191.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O2aO8QbroOVlbnTj"
Content-Disposition: inline
In-Reply-To: <AM0P191MB06891CA6155F4B995969E9E7DAC0A@AM0P191MB0689.EURP191.PROD.OUTLOOK.COM>
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


--O2aO8QbroOVlbnTj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 04:11:00PM +0200, Francois Berder wrote:

> String "/soc/fman/ethernet@e8000" is 25 bytes long
> and not 24 due to extra byte for null character at
> the end.
>=20
> Signed-off-by: Francois Berder <fberder@outlook.fr>

Applied to u-boot/master, thanks!

--=20
Tom

--O2aO8QbroOVlbnTj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSpQACgkQFHw5/5Y0
tyylGAv9Eaj7ndDNg9W90OxzR2rqv7kD/MoXZJkTa2C88y2ST/GUGhvnDJDSwRpg
EWLY1C85nWnBw9iCWDUdIISpGyZQi/MvGuE3oKnlwmL6lRCMGewxxpaYSNphFMp1
ODyjVQuiLGKfAa+zoXVF1mTiEztrFspDGNJkgTUc5czKr0P6yML6k2Obaww22rex
MClKYBxQDLme3OoyC1424oT8YuIIpMpgtdGl0znuDrtsW5E4YozM5GUbXOBq1yN+
/txBwVWA1EljMCBeQNAycfl9rxz1prrJZv7uECZc+Azwa+5sC2gmci2YB2UawbLy
aanX83cr4Kbv0Rb0WC7SlOSz4G91tHMnmVhxa+HNGH9hOWsEGvMFBtQbRXr/J4sF
tIeaDgfK3O2iZEpxbpqwnY4/NM+07qf/QQkuboONqdRSS1qrTCjjbHX+hvzQwjxK
JOueaocL7dbr8aPK9iNx2TDAOTcTWoNeUfXIJH363S+LWUzpS72b7xDk5W8d2jGg
aAR0GLqV
=LE+b
-----END PGP SIGNATURE-----

--O2aO8QbroOVlbnTj--
