Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F8CC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 20:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46B5D607AF;
	Wed, 29 Jul 2026 20:33:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8JMQKWhbR046; Wed, 29 Jul 2026 20:33:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 723196076C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785357185;
	bh=JlU1wLJmcctxAaalhMbIdkcgr7ZD4j3NYbWzIedosqE=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=B+lCkG++0fhwCgQm3q34FVG3RliCS9FwyJ1oUqA2+PaI7FF+4NlLkGo7V1CbQJCQO
	 rAoT0ighsYJHDZLE3CDxg41eNuRf2fB962ZL6oEcZP/u1qO1HGV0ROYaeZtua3HXf6
	 WvcwS2gRHvkzZG7fEPq3VGZ9RLkbOrAwVrFgL44mnYIteVsp7ajlgq/Tv64IV7PSRd
	 ykMf6+8BbUo6sUOeM/946/GZh+YxgKo0sQJURvZEVw9ZXweZA4Qn1165zqywLUXKBv
	 rtU9H/IeNxZQJ08uWLEtKJBUdxCTu5okXq1KhdGqbyRj4LuowuI41eGXaQ323qzJhQ
	 5ipRox3OR4YzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 723196076C;
	Wed, 29 Jul 2026 20:33:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 086DF26E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE56F6077A
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:33:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kQsrb4ilMXG8 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 20:33:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 360D4605F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 360D4605F1
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 360D4605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:33:03 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-44cb057311bso839939fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785357182; x=1785961982;
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JlU1wLJmcctxAaalhMbIdkcgr7ZD4j3NYbWzIedosqE=;
 b=ZRN9MElmxxyrK5x4yP3PmND2CoW8BjyqggGs4Ha0/rvmbRuTdqyj9yn99EJB53Ev+i
 zfcR15m6VOHN91gn9jlYqhXdIfyibnUcRH1M0UmuPoYgAr0VCIJScNTMRfBGK/L3uvbQ
 ZsOAebvP9vTj2Q2JG3acH5HT9coIc/nhQ6bUvNmHtR/PHKUOOsOlmisye6vBlGxzFzOJ
 YKM6RU7UfuF0fbhN0IYUg9Tc+HZGUVft7uCUKcL1RwGgM/Ux19VoUouG+0x83PieCU9c
 8MG448GIOEEcUclgp5gXAW538YlvVYxPDTJhgzE1gOo6oVxQVjNDsxz2dxlV1Yryak/Q
 cUEA==
X-Gm-Message-State: AOJu0YxALnkxh3jPGtmDJ2+A0GMZBhwGX/fFA6J7deatcJ6RfVRhrzUl
 sM8NJGnwljzKW8sAigFYz4Yn2fxb8jEYDg0K9M/ZXppj2qRugRR6G4MIn8GqQwrYa9xOal2L0d6
 SQf2ZQgY=
X-Gm-Gg: AR+sD11d4gl5759s1QZ5z9ye8lmD01fugU12/zOa11h+LOCBlO1GgSWK8DklXIVS1Ii
 9BghuuwNtvxNdUssfllH/98tXThgiqtwlZhEEXph1VOJTxFi5MGu+Yx91PQcNaYPBphLuktypEw
 Y6Zw49zXhiTNXEqjn8MFcMgIo0x38LTbKqRkOumJObDEaIVn4KqqRoO/uTdzJ4AhudPKXyzzhBL
 BwOnG7a7O3oTFu5PjgS1Lgp3FDqSBGLOOb6rCWMLf5Z9PPQLtuNPyG241pwzs166TbU1GJYtaeR
 UtekHrSDVgn2+tBkDEtAO8LORl4QENt4rWNmWt3tU3i/z2+A+deXocV+ir+Ej3eb1UvEvWRmAkq
 KsgEv22DxQfHHL67MYUMMbZNVuKIg67j8orM1nd8nlgWnNsrBBKTVYodIsNIxHB2DwAbln3b70X
 /XltaaWzh+jwXSZ0JTnHbu+zjVpGoEF7kdFDfRmeLx7kWtfV5VH/JntpQW8a8mddIPIQRx782aZ
 re4H63nO52GW6ZsO71YPjeynfb7Go9UBffDISgjIF3TbJTElwJJS/vdR2jsvvJYkyF5fy0yOXbQ
 McvKr8pTEDM=
X-Received: by 2002:a05:6870:a08a:b0:44c:5d96:337 with SMTP id
 586e51a60fabf-458bc29c390mr160704fac.13.1785357182053; 
 Wed, 29 Jul 2026 13:33:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4588688e692sm3419905fac.14.2026.07.29.13.32.59
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 13:33:00 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:32:57 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: Update to v7.1-dts tag complete
Message-ID: <20260729203257.GE1773261@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kttdDG22N6mHRJ1H"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785357182; x=1785961982;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JlU1wLJmcctxAaalhMbIdkcgr7ZD4j3NYbWzIedosqE=;
 b=Ea+9NlO38FFUjzjnNINA+I+VOOMfTdPj90jyD1yKKPu817J9OnH1Ci3vuHau1Hs2v2
 PcJ6pSxFH7Ag1ehG+zflZLPcOd2KQUG+Gk7vJOArnJwuTlgoKzTudbb6NncEISlrPUyd
 Zau+SaAbKwSXvvXVr8+ianmaE1iaSkBBT/rtw=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Ea+9NlO3
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--kttdDG22N6mHRJ1H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

As I noted in the release email, I needed to move us up to v7.1-dts tag
for OF_UPSTREAM, even if it wasn't quite in time for -rc1. I've now
pushed that along with the few fixes that showed needing when I
initially tried the update.

--=20
Tom

--kttdDG22N6mHRJ1H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCampjdgAKCRAr4qD1Cr/k
CtXxAQDaHDb5Whp/YgP0sQtMxtoctilAl2XmNMR6IYqWblx7+wD9Haei86iJuQO4
oZL1qa9vYZFjmoDaDfa6LQLegQv9JAc=
=Af+v
-----END PGP SIGNATURE-----

--kttdDG22N6mHRJ1H--
