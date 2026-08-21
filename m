Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43339C5DF8C
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 20:34:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 089D560ACE;
	Fri, 21 Aug 2026 20:34:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v4wN3x22tKcU; Fri, 21 Aug 2026 20:34:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787344447;
	bh=JHgvGuT0WmWjZjCeSOM7VERAJlT70+UAGY9jfdFtudw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tRX7Zlo968lZTt/SmZQrvvmoabQGVAM129fwa1IFcmqCJMIsdJqp7JySFFFgvDEYU
	 ZbLaksWsDbV4u6kFHHBaZCRFgbhxRaZIoY8G2fTReMwBXQOLKF/SiQn0BZN9Jx5pfg
	 HM8jrvKcNpspviCP7Z57nyywlLpHaiQij7kHHEG6PPxu5ltpeoVeGXSzE+dk9wg29G
	 8cAiBQUei4muYwg6x6xB7ZP2FYvN1N/XsxnpGU1J+IBX2OMRV3YPMVKJ2ksyQ3ytTk
	 zvx1gTuQgfd14FwMFa213ARKhlkOmPV2bjtXXYmo8RqH6M89EcaB5sKKmBUDAkhJM+
	 GTV9bWwQbko7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44B7C60ABD;
	Fri, 21 Aug 2026 20:34:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BE59F263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 20:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AFBBD60ABD
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 20:34:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d5eCcxrI5B6Y for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 20:34:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WpQXzBtk
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6272E60AB9
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 20:34:02 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7ee4399c423so1349636a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 13:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787344441; x=1787949241;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JHgvGuT0WmWjZjCeSOM7VERAJlT70+UAGY9jfdFtudw=;
 b=WpQXzBtk+4YUBjMHz+7sdWKt9gIYnUR8RpdDoDlUz1g1LnU4xAWf5NJdt0I2cBwWlw
 vto6yV4MSnD07o+x9JE0/F2Wpq5OGPH+fO3d5oeBwBO3SVSwZnY2GNVdcJDVhJ2eDudk
 4uApGky+Vu0MTdrGwWkP4CiWsvETaNiCqDIeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787344441; x=1787949241;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JHgvGuT0WmWjZjCeSOM7VERAJlT70+UAGY9jfdFtudw=;
 b=oWMcLcLhxKt1LiIiHi3xZp/q4g03eITXTrCyCiYxhyKEKJrl+/hHZFAjOym5Zf9YN9
 tqndD4rvR7vHXfyzWFhKYrGPtgWRc2/Mn9kV51BhctKU1t8csp9yU2TtWylU5q9ic7IU
 jtD64ZrtvB/EwTuc/sFIwaa/z8+dcEUdUsDCpz2LWCjC+SWkQalBWz8BmGzfLLudSEKN
 MPMv8J5Lt80U5HAGJ+Gd5OWH3zkNqX57R6M+RsgiVaq1jNy1koCTRGGaAAL665yLdL//
 712BWeoZ6Q9hmkVky1WxqhFzBqv37QQIZAgOKoG42GOJbQXlKE3R8lN/6XXnssjPovjs
 +aPA==
X-Gm-Message-State: AOJu0YyM+iiOztdZjVqieyqeZ43jm1/j673JD/YyuA8p6IhYLEjj6cim
 nZ8TG70GNYOJqsGjh3TfRXYGecQ63ue1/RL99BHkD9IeTv+8mYxzN3GoopoUndT6NXbocQsbJ2d
 cIInq41Rzrahv
X-Gm-Gg: AR+sD12/qOdX5J3RZ5ojeyXnqcee29i3uVYH9sUyIFMaTBLPhuwt1GE261Hy17Uj+IO
 N1UZgqfwSc/mlBWbLw1SolX4sVVdmt5kK6R01WFL2qn91d2RUElQNwuuFPjNXiAc6qc3Cd0KR3w
 uYAki1TTr9SIyfgbkJoxyo1h2U4XEDBh8pslIEUcfwomq8yktX3Nwzesc9kWAtb+G8TmHECzE/0
 moROuFhILF/Wh1SB6UJLaUASA59w4mn8sBSMf1VoHGhcdvrfZT9r9ul9F0YPKcA3Sqdi1d4c7Mf
 /0a98FUQOqR3CO28w5S2s3z+v0oBGtY+Y+Im7hKKxx1KeX8MjEKDwqvigKHWhAp+jBcM9aM11YF
 +2sC0Dq23BICrEi3ddF6o3NgNwQxoH9j3iAErx1QdOPT5JQab+ikN8Kl0iY9tjU+Yg0cHZxxOge
 I5x8Sj/EJ91IyiP+Itdmz7rEbaVsuYd8JNW9/zTPjBcxsN9p+0RgjfN9wgnCUJvS6IHo/NF8UCU
 6/ZYLukeZNOV0AbYWtCYWNyvGpsnZkS4Yma2Qwm7svGjAKunMMcz2eVqpfwATSGmFmco43mFbTI
 1rdSMw7s7A==
X-Received: by 2002:a05:6830:601a:b0:7d7:ef0a:1ce5 with SMTP id
 46e09a7af769-7f46149ba56mr11378758a34.9.1787344441447; 
 Fri, 21 Aug 2026 13:34:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f43fe70792sm8615005a34.5.2026.08.21.13.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 13:34:00 -0700 (PDT)
Date: Fri, 21 Aug 2026 14:33:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 0/2] MAINTAINERS: Cleanup non existing files
Message-ID: <20260821203357.GU523975@bill-the-cat>
References: <cover.1786605072.git.michal.simek@amd.com>
 <20260821200507.GA3894128@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rYsAmqOX27k5bTb8"
Content-Disposition: inline
In-Reply-To: <20260821200507.GA3894128@bill-the-cat>
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


--rYsAmqOX27k5bTb8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 02:05:07PM -0600, Tom Rini wrote:
> On Thu, Aug 13, 2026 at 09:11:15AM +0200, Michal Simek wrote:
>=20
> > Hi,
> >=20
> > I found in my Microblaze fragment that cmd_mfsl.c doesn't exist but sti=
ll
> > it is recorded. That's why I wanted to check all entries and found that
> > there are also other files which doesn't exist.
> >=20
> > Tom: maybe good to run it in a CI to make sure that we don't get out of
> > sync.
>=20
> Sounds like a good idea. I see between your posting and today another
> bad entry has been added, I'll go take care of it.

And, I'm going to take this series to start with, as it's a good place
to start. But it doesn't check all MAINTAINER files, just the top-level
one. Cleanly updating it for checking all files needs a small bit of
thinking. I Kludged it in and, whew, there's 252 bad listings. If you
update the script, I'll take care of the problems.

--=20
Tom

--rYsAmqOX27k5bTb8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoi2MgAKCRAr4qD1Cr/k
Ct5TAP9THB9FGQP3z/arjimeJD1fauGrvxBSgXq0BNOs10c5KwD+KoCZvJtzCfcx
+7RKjwcQR6MsOZmKN5I/zfjYeSgGeAU=
=UG9x
-----END PGP SIGNATURE-----

--rYsAmqOX27k5bTb8--
