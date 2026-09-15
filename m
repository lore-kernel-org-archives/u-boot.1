Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7112C88E7F
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 15:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD1A780AC5;
	Tue, 15 Sep 2026 15:57:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tBpjKk3Ju_Mc; Tue, 15 Sep 2026 15:57:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1FB3B80897
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789487859;
	b=Y7qWqyXsWJryC5xKoD4Ebj2FfgxejGKO6v33qI3a1zZQUbu4t3nnXAdiuvaxvl0mYyOj
	 MUZhVifhe7WokZsMtGX+42oKHVSzs//E/GdXjDx/Z5tZgqs8s4lwA0i3o2Y9pAkpacQsg
	 w6TVm5pZv4LQ3LEoJHVZAZ63qO7yZpwN/FVM8T7fD3W+vYzR9e9mor42zwLooMfXF54Iq
	 DK7AtvCGgWF6tmfyZradtGtQ/meua0I3YryQmQLT0Xqyjwf7zkVVpzAT7mtjRqB2eqQaL
	 1GPYfZzkOKscnOisIPehLqZ0OnNtW/9We/7hmDuxER5RSD73Ard0Etlrwz1s26KocTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789487859;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=82etVqbXq0ZBYCoOoq73bUeTp7BH5/uwS/QN1EJzB7U=;
	b=dz4ND2QeyjK/ZFzoeePgOwldsQsHAP7Mk5CpZhyUco5bbtRianLsCjEGvHNn7HY56RKt
	 TshDdcvH/D6uvhXWmDy0JQDBeO/yoAgu9vRXpvnxF3XIGy5GK2XE4INygjSJ9O70FYe79
	 j553m8Fwbo9hPesYr2p30qEH84mN0y0KOlY9mh2w3k9IgyzGMwspM6Pyp8oSBaiHSWNCh
	 E5mwX+48AdkRya40IR8Gv3tl34r+8iW67Ho706V/we1mf+8H/VijLlCBKsmyMBiyH6Amz
	 tjIdknw0GygjvPwJ0ddPSAvvmxPTgNF0znkk8t63cVqIwRzC/sEg7b0xRqnXtoUN+Ng==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789487859;
	bh=82etVqbXq0ZBYCoOoq73bUeTp7BH5/uwS/QN1EJzB7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UdmkXnFmzud12YIgvOPPomgNch2EU4Rm39zHerWLvJLqWEC9MX6XJaeEF9UcKjJZS
	 casojRHzkhJA02DuAaT2RmvZ0FwfXaU60s7Pz3U1nQ6WADHOeFUhG1XhOtv9WqQlJd
	 3ebPg4Td/Si4mlC73qXPcE8dt2fZ2OlwQtr0crd97HtvdGUPC6OCCRmmaShsV0IvjS
	 8fyH7fMjLD7WSx4KFpAdU71Z3TwJ3zkKMtGtV44xxcN8/fDFSJ5cUCydXI8LWecWAK
	 1u+oEtuZrXA7qSMA/HGgDeSBPDvJgSCmvhYiZIsZKTAiXYYde3owWMzFmAdywIqLCw
	 acKhK4YMB8LLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FB3B80897;
	Tue, 15 Sep 2026 15:57:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 99F3F23F
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:57:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7FB684021F
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:57:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zcoEnrFsn-xX for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 15:57:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C6FD44021C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789487857;
 b=M9+uHcuSwNEXmYpvCXWnKuZaafzbWl0vPgl8SdnQlaOatIRQ5BhXhfPiN+wUeQ3T95Zo
 WEZVdCQuWBk1vTCmL/RLjS15Qi1//LeUE9ffuLTSOyS1P4sqfcZJDvvKGYd95CZPa17T9
 gBwiw7J6Q3Ktfm8b0eWJlSM85xxI6LQIvykF3vf3H4TIALuRsfKMYz1rPXWcoODXnMgr6
 55NjIF6d7UmnbC5Ss0lnJMbNPBFLdUBq5AHWDNS9i7FNdzDBilPJNZvrPOPGNvGi8o2qW
 pY2+8EGyI2I3o4hXqkWVY9Hhp+Md0J4/JqyQ0M5P0otT6c1MfjJkXbQ5Fe6yrcoMTyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789487857;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=82etVqbXq0ZBYCoOoq73bUeTp7BH5/uwS/QN1EJzB7U=;
 b=WNtv8S77MdhiSkZoaPeC8h72Tat3DcN6/1/DgjmbIHwBq9Jnqo7B0JlT70o9xkidTpU0
 zg4YENT7IRMdBrM9cXXzeSylKnX0ZAWnekxHAu8Hnz5V0saPk7Ww094MsBXI+qo2ary6V
 DwV4QHg8INDWTJnAxpRqBOP4r3c/g9OTmIwtxrCdwTU0iet/8ZwGWNJEjA1gtuRplUSUd
 rIahg2bje8V26B1uC85v/LgwHu3UBwukv4fE57neXuGcq4Hbu9dgdO8wsOHHwLbvu5gef
 M2drYXc3PaXbYyAUd6FiuvK1JptaJeE2H5PARtb9H1VGKEnx6sZb5XPDdD6ZqbpqMgw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UGOgkLvU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::c;
 helo=mail-oo2-x0c.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UGOgkLvU
Received: from mail-oo2-x0c.google.com (mail-oo2-x0c.google.com
 [IPv6:2607:f8b0:4864:31::c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C6FD44021C
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:57:36 +0000 (UTC)
Received: by mail-oo2-x0c.google.com with SMTP id
 46e09a7af769-804ef461aedso304654a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789487855; x=1790092655;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=82etVqbXq0ZBYCoOoq73bUeTp7BH5/uwS/QN1EJzB7U=;
 b=UGOgkLvUUR+5YEg0fFuvmF90TtkUBH8vibmCPZ64Kye+zGx6tfmlFBUkNh+Zvhss5L
 3qOrZE1BgTcM2ExHHA14X/l73fANynVsaPeq6bSphQnHWwkX0OG4AeLDUeGXtdL92+Ig
 KMkfDjwjLdCDIghLFXd0GruseLNoq+1fwP8VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789487855; x=1790092655;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=82etVqbXq0ZBYCoOoq73bUeTp7BH5/uwS/QN1EJzB7U=;
 b=ZtNTJYEqBaloQttqrDpo/0BeLxlRmGwbHAmJSuZD13afhxxCuP2qAM23P4SpnHttOQ
 afmmn0Iq24XxllSnQk6FzsJ2lLM0L0fXDnJdsvZu88ghgDCg6pK9q3Pt4X7gbr8rlQxF
 F47zeBpk3eylYANJiIdWTtq0xCj+UheBH0615LtN2CuWYUNPs5SFpy3JjOq6y0ilBWvo
 2nPrhwpHAw28o1N+qxMOaLSYvWQy7aqxcK9ixvZfFAunVsQWXmcAb4n9Lt66CG+H4W3X
 LZ8zwtQrLjpiDNEb5X4If5MGZfNGtda3UpN2UhFQCo18DxvlHBWG6N/Rv95yuWT4HL5Q
 X7rQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxW57b+OMGVXX5bhlkSW3TCYHL8ZfjPHDAJ6y+8de3ktSNKQ04ccr8mjIvUpywhouW/ldvXJ8g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++liMZuiVz0h7GMgSRHVeZM4NLdG2AQxzW5I442nqBnUwEKjYsRD
 eIamWMM96kTKJRoD+V4rpUiZ1DaCp4N9wuss7VCX3H4ff9eDIDbax7dZg7eagMuPgLU=
X-Gm-Gg: AYBFou0grdy4IyS5uVYreWuRhM/QdrkfGrZyyQuIzFoMpzOoo/CkQfd/885wDu5SqoK
 Qsq5I2sAB9bggfi1NOAw3dFxcz6lhHPptr4t3CyeFFpL4vgerhBHzMUpqp0EDNU5U4TwY5OPNfR
 ADGA1/n8+1JZ+2KZH2dlWhpPVW0NL0axmB7FQ1q7MwKis3m2uaLOUiHGccWb4hwa0iVCYrplP09
 jxW+D0rYY+SiBbhu9h/9UzbjnH1jEDBVirMqV7y/LiQ3eZ4igzfYHIu94KBmG87H4rPGcTkXjOA
 M5MgZQU/eaO0c6VLd3jDUGjTaGsGMir7f/HrY43pOKcVQh6Hkuxn/TfiQibCeQ+w8dRL7eNheWf
 ZnO1UJwk1C/AQ9fpUPz2JDGaWDIZ7A9mwirgaxCwHTdpirA3fJNBuu3flqRQZwKkfLPQ1rzxdp/
 2RdLogQI4ymnW8iPWsZatprRglm0lk2DChYM/KDYXyeQNXYcyDRWjqnaRR3TRl146Kk9iQK8wyH
 jaIDSeoT4j37k8ByxL86TzxfD6Ea1cltPWk9s48iqm8s9jQGPZ18EQs/k56cLnRvIuBFs66KO/a
 FBWortBvriskaO8XCg2UGXXdpiXZV50=
X-Received: by 2002:a05:6830:6ae8:b0:7fa:ac4f:777 with SMTP id
 46e09a7af769-80a774bc6b3mr1616524a34.22.1789487854537; 
 Tue, 15 Sep 2026 08:57:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-803f5adf69csm14942013a34.7.2026.09.15.08.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:57:34 -0700 (PDT)
Date: Tue, 15 Sep 2026 09:57:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, sjg@chromium.org,
 jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 5/6] test: 9p: Add test for 9P filesystem
Message-ID: <20260915155732.GA872744@bill-the-cat>
References: <20260829192119.2658328-1-visitorckw@gmail.com>
 <20260829192119.2658328-6-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EcXhH5iGMy4cqa0p"
Content-Disposition: inline
In-Reply-To: <20260829192119.2658328-6-visitorckw@gmail.com>
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


--EcXhH5iGMy4cqa0p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 07:21:18PM +0000, Kuan-Wei Chiu wrote:

> Add automated pytest for the 9P filesystem testing directory listing
> (ls) and file loading (load) over virtio-9p in QEMU ARM64. Also enable
> the relevant configurations in qemu_arm64_defconfig.
>=20
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  configs/qemu_arm64_defconfig |  3 ++
>  test/py/tests/test_9p.py     | 82 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
>  create mode 100644 test/py/tests/test_9p.py

We should also update the docs by adding=20
doc/develop/pytest/test_9p.rst based on the other rst files there.
Thanks.

--=20
Tom

--EcXhH5iGMy4cqa0p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqlq6AAKCRAr4qD1Cr/k
CjNJAP9Dl/p84Lfd3lKwJqgp13/snA4rutTLuG5wmyJ8E8iSSQD9Fraa2ec2cN4W
nbzFxi4v8Y6j5+Gb8KLFRlkLlCLO8wk=
=6Nht
-----END PGP SIGNATURE-----

--EcXhH5iGMy4cqa0p--
