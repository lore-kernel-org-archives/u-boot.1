Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2535AC61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 13:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDD1C405C4;
	Tue, 25 Aug 2026 13:50:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DXDjkleJoshz; Tue, 25 Aug 2026 13:50:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787665845;
	bh=SUu2Rh4IBljJMlI65RlMFKwnJJ+X2VGIRTvbmeTjh9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vw1vey8slLfY2r0nsUwmbLgx8hvy5VurzEJ2HqUIJfSLGVDYVR9185l05hWUOdpKP
	 dCWZGyVTLUFl7cOD1sc3aSGKaP7hvF0phw8gtHlefLj7ncLdToM9/QNr5OQRqxltti
	 7B9bNsTJWaSO7Fql+HVkSa/syvHVMoCpGcO4r11orpbV/jXpJcYsJe0pnuwq/rblD+
	 UGxsizEaqYgNgdhyyxWIJqMmICHdPQjT5knftA/IexOWA2biEtn4Y/UcY2htL7vjsT
	 nkzUkZ/7pvnbqe/pkPaCvReeyiBkfoSnuNfdz1Nfs6SFULWhYtLmRR3doRHjnw9AbH
	 A7oqY4Bx2MJ/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 557584055B;
	Tue, 25 Aug 2026 13:50:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 86ADA118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6CD21606B3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:50:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g7lrKJDE0D7U for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 13:50:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=c2NeBbWj
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F87260603
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:50:42 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-9371bcf1f8fso212151785a.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 06:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787665841; x=1788270641;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SUu2Rh4IBljJMlI65RlMFKwnJJ+X2VGIRTvbmeTjh9c=;
 b=c2NeBbWjQe3wxFMp9viaJmA365tAwRNyAMkv6m4spsoyTw4L2FpHcbtK1luptYZWpo
 pTV5s/tG+OeZNr2YgDiYo2unUSRQNVJO+iLMUo7uGMUSRby4+XEEQZhJPGPjlzAZiZlp
 mZRb0d+xvyubYg/g/if69g6chpapmFkkqyeCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787665841; x=1788270641;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SUu2Rh4IBljJMlI65RlMFKwnJJ+X2VGIRTvbmeTjh9c=;
 b=l2VRtJLN0yTUPoQ6Wr+3UU/nKTTJ4FO8L09pXaKGe9o8DvMQX95nvSS2gJcT2End8t
 pKkhuO6sNNcmuO/EyZ1YvKK6NLY+CVbu9Luc15vuoHaME0Ysa9ciASh1D4mk7X4FauRI
 KrWYP2ImoPyluyQm1JqRP1+6mpcFdW1Vn8KRpI3iBqRhkfMGLtTpEwhceWT10go7KDzi
 gmFyFzJkPc2L7A3hcZcBEqFpAIlcTqotTJxp9Kt4IHwE/cacQrkpOpNmnLECzKAUCDr7
 TPe8DoaUSP7QwBWtG2p5diuqj9ys0xUhCNrrd2wRsIRlFiB1kUdzKjmAbaADfcN0K2FD
 oQwQ==
X-Gm-Message-State: AFuF++km2nl0b+uodTp+biNlQCP1/QxbMBwEemuo8M51YGOZWerjnrvT
 D7bT+A3nTmPbqV84U5lcAzmRnBtCgAkVEi3k8PwMBmAdKv+HNwOvoVA15blI9920tts=
X-Gm-Gg: AR+sD12Zut9gXYxQQx9tP4lDRta1in+UB3KdHnBOj+IpRrEfKLqvc8GH9rWLPmwl4UM
 jpiNPHTG4BZZPhU0skjtcvRt/z+9pGUB3k56Ln7ZkAKUfux6JdwLs3pbc7o/sf3HD+LjasVHZOO
 2b0ORUx5ZJPQTicSSy+ZPximVlI0AGZaJ8W1WJv3rXjDxFOsxFvXXYi1Wcb87+2ZNZONr69VRqq
 ZlamsoDc/Z1CHS69r/QHNZkrNhQRCFXF3wcUtR20PigLHCcU68yyDRYMjZVRq/7sjJKXOTa7HLO
 u+p86HTmjZlMQeVn0cMqH2PIMDjhZl6IPwEFfOq3hJFmboK5Ye1jfl45y+GFQvW9yWSC6N/VRcs
 MPeYUF2bF2wT/Ie+JrPJthwKyDQU5y7c3fqnNDbViKkAwMmHZFCuhqw2tOjk1CFjNVpDeVSxS+d
 5ns1SCSD2rX7V+MVRLPrOA97E4oclSWWOyhZec3ulCn3xVJnbkvPX+jfqVzG3VSWBjqizU8tHHF
 /U5W1PVIlSDpedjJF7ufwYexTQ5te92BePcidxhWqCVAhnRH9M45Wm78/+cfReruDPAd+A2hGd1
 jFW3N8BOYA==
X-Received: by 2002:a05:620a:44c8:b0:92e:6a33:7118 with SMTP id
 af79cd13be357-93746949565mr2402793785a.30.1787665840881; 
 Tue, 25 Aug 2026 06:50:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93749e9f940sm731420285a.38.2026.08.25.06.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 06:50:40 -0700 (PDT)
Date: Tue, 25 Aug 2026 07:50:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 "moderated list:ARM STM STM32MP" <uboot-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 2/2] Clean up emails from non-existing domains
Message-ID: <20260825135036.GS523975@bill-the-cat>
References: <08f68cd8c514140071090a846839632f8cae071c.1787560364.git.michal.simek@amd.com>
 <1b9532296bffb1918b90cfe61fb7692ea355d02f.1787560364.git.michal.simek@amd.com>
 <20260824163956.GH523975@bill-the-cat>
 <c012177e-274e-4c88-bc32-1ec647fad643@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6d5+2rkPm2JZts9G"
Content-Disposition: inline
In-Reply-To: <c012177e-274e-4c88-bc32-1ec647fad643@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--6d5+2rkPm2JZts9G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 07:17:36AM +0200, Michal Simek wrote:
>=20
>=20
> On 8/24/26 18:39, Tom Rini wrote:
> > On Mon, Aug 24, 2026 at 10:32:52AM +0200, Michal Simek wrote:
> >=20
> > > There are 5 domains which no longer exist. Remove all email addresses=
 that
> > > reference them. Where such an address was the board's only maintainer=
, mark
> > > the board as Orphan.
> > >=20
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> >=20
> > This is generally good idea, however:
> > > diff --git a/arch/arm/dts/sun9i-a80-cx-a99.dts b/arch/arm/dts/sun9i-a=
80-cx-a99.dts
> > > index cf126bbd2c57..0642161ec969 100644
> > > --- a/arch/arm/dts/sun9i-a80-cx-a99.dts
> > > +++ b/arch/arm/dts/sun9i-a80-cx-a99.dts
> > > @@ -1,7 +1,7 @@
> > >   /*
> > >    * sun9i-a80-cx-a99.dts - Device Tree file for the Sunchip CX-A99 b=
oard.
> > >    *
> > > - * Copyright (C) 2017 Rask Ingemann Lambertsen <rask@formelder.dk>
> > > + * Copyright (C) 2017 Rask Ingemann Lambertsen
> > >    *
> > >    * This file is dual-licensed: you can use it either under the terms
> > >    * of the GPL or the X11 license, at your option. Note that this du=
al
> >=20
> > I don't think we should be taking email addresses out of headers. This
> > kind of information is useful in looking in to history and trying to
> > track people down.
>=20
> That's why I kept there name. Emails are saved in history anyway.
> I don't think having emails in headers will help with anything. They don't
> work and they are not going to work.
> It means if people ping that author and get nothing back it is IMHO just
> driving them in wrong direction with unreasonable delay and hope.

Having the old email at least used to make it easier to search up for a
new one, but I see that's not so much the case anymore. So yeah, OK.

--=20
Tom

--6d5+2rkPm2JZts9G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao2drAAKCRAr4qD1Cr/k
Cq2iAPwPzJsIHlKqHgJBFL+6CGRZvivgGFdPbPFfnHy5dBQAxQEA3im6xJ7Jgwoo
Fhsc8vTJioKvjTYQT1YSE8qXqqb77Q8=
=cVRv
-----END PGP SIGNATURE-----

--6d5+2rkPm2JZts9G--
