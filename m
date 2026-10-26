Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E42606A329
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DxAsITC9;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lJqJX9SI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87A9C40757;
	Mon, 26 Oct 2026 17:23:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UlyU0LILf81c; Mon, 26 Oct 2026 17:23:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C2E8040744
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793035419;
	b=K8FuMcNR8ioAnRi7hO6sOhk2uvodjA+dr0+ZW/s0tZy368txu+DrhAdKOURKyy3H4R3e
	 WY6c5LIB2TqWk29qu26XPzWJSC40Rjb+7mKE+vbAtbhiydOXXnfQVnH/s12zImdFeQl1j
	 2/aE+sfaGyLGqMRDhY7vJnuj+p21YUv4/SNzxa4pfFnSuN5lGmOdf8bgpUjaw3oZaYnIJ
	 NNzhAM3yI384GCGRKM2Xc6ON5By2Tc9huziUZEFnhPijleWJzjKJtUhw6zT4694EOB7tJ
	 BVBsyf7KROv3uPetMGZzWzJHdCB3RCgS0Y2XzE7kqi84DDeJq7H/OQHfOjlEWYLkpeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793035419;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+uuQ2VD9nzEPwrIq9PRPkGBeTrBjkEthJ0a7/hPAfkA=;
	b=oKxnFINQ+3aVeemALdo3I4mwDNCC7hVqdgzcAVm227VJGQnET04V5DqW3NHf6JxycAdG
	 l9yYM+G0pCnPbNJz2HXS8AvYqFuMR4yAPPq33unjabkgczb5/lwf+tQNgcHsqXgatgfD8
	 8972FYHaX/Hf0EmNSid5TuGcfNGzilysgTOHzx2dBfgBKtIXp5YM/8M49tADUZU5bG1sv
	 iN7q7Rct3rw+KCS6cMYqoiSVUFUWkP2/BYf1oMo+pXX7xsZGWCDQNSETsjf6cnCEW6mEq
	 Fn9KmD1zIX1qUr6ZqQJ6hhvAJ5AoRU7prkWV0S/GPlCvNI2HRbYD5pyHWeYhTzC15aA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lJqJX9SI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793035419;
	bh=+uuQ2VD9nzEPwrIq9PRPkGBeTrBjkEthJ0a7/hPAfkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DxAsITC9yvBDlbldEk2MiYNzr1Zr6bf0BLR8bs4JwUI3rKbSpcMyEP6RQLHjyQUHZ
	 TgvmaooKJrmy9g+3+NZIIr3w0cA6LhsyxesjXV/aOO5n5DpIJciI8fB49qNkPKkJIG
	 oO1dj4yJe6htZFekMpY29TXWwTagge9Tcm3gUCyo9EMcb7Tix+aCRr3eYWCjnZWVqG
	 k8SXUepC4PWC2Du5Cf2yq7f4cX9mAo4U1Ypx4hAlwjFLMnfLPAjHFOYxhltzCDPTFq
	 T8h9T/I1HHxO5ag9d06HU+zZIrp5LeKNip2xmdwkIRSGdcEebBYK+QgSykI2uy03sr
	 KxQfNlXSDcTYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2E8040744;
	Mon, 26 Oct 2026 17:23:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 69723120
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F19740744
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:23:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TJpR0ukVhRP4 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 17:23:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D2DC4064F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793035417;
 b=EGL0R6c8ECB1Xs6NNkEwe2tb7fNH50gkaCLfEYuNM2VEbjXxCK1zYNeOAHoHxww20h0b
 kx//QaHTvMgmrINNgNNYEqqNC+3IrLpHVFjMj26IaKT3praRRq5h7fPlzd5bHQKvRu0AR
 Q2d4GuikQ7wpOscuo420NIwS+F9s+POLvmAGkSgV5BlZZGnPP37Ty1/pI/GBAadAVGU8s
 3noexwauI5Uyoxp7qE2pN8srJL+GFZ6tGTtMphLRmYOK8utC25cYfeNOI0vy70yVPoaKf
 jC4Xu9OG4BSrFkFIrLOdbqYncinnf5X4V0wayVOgLT0APoEmU2OHQIudxArKZJHnJ3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793035417;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=+uuQ2VD9nzEPwrIq9PRPkGBeTrBjkEthJ0a7/hPAfkA=;
 b=AHe7A3fxW3tt1f5sxfEMkoOHsHdYTRL2bPDQzaiBiueGXyHhW41N9aykuMBFL+UHVN/M
 TLlc1JQGwcOt1ZEn8IrPJ1jmq3ZiuVfqlk4ZVdgColztFuIZxA7CrIL1ZKXDDtEMp6z4L
 RWqRYvbwA1Fgd4xKsnWLO/gGqPzbPNKZk+ygHBzf3Xc0DDXMIMOTGWwyMPcun09LM+a+y
 pcaM7P6wEmqALfHpdszKmOdixU+oHeN8tKnwh0gQJyB1ZLXfNs5M0D61WNRjBBqNZukRm
 qB7s3iCw12yEt+WDl+DBVnuOMj8OSV0WYLy3AcaBDtmeumULiS50M3ylel+6Y/VhXGQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lJqJX9SI; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lJqJX9SI
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D2DC4064F
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:23:37 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6b8e2d8df4fso2221720eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 10:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793035416; x=1793640216;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+uuQ2VD9nzEPwrIq9PRPkGBeTrBjkEthJ0a7/hPAfkA=;
 b=lJqJX9SIqI8FwC2kVkK1m9RymgzGbw01jwP+6AgX6ku11PZKsI/wfR3mtN0WGSfe/l
 6Nq6d4V5hp4pQAftKlUnGwy8C0WjEI7K+GLaz1K7ranZdKh2toJ3QaN1KzdifY8hoRH3
 T/jY/14SJ5MQK5cj9j7M5KMcL+2MQ6tT3zkFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793035416; x=1793640216;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+uuQ2VD9nzEPwrIq9PRPkGBeTrBjkEthJ0a7/hPAfkA=;
 b=UpEQ9g/qeqnjzrJzGBWzsGan/LTfL1TNPWNptHgcVmaQnxpc+SQJhepT7kOpW3uLtG
 UmSTWpulWp/2FSMIDaShtseIHggxnofVlDoocTlfAHUjSGsEhI1jTTBanAODeapNN43H
 7mMYeo5ph3I/cm2V+SDupHeyiMTsWBPJqCzYVvBcX+M1BSIcfMrvk7i3YasWGbXAy1Jx
 JjsUZxGrAmaluIw23CwqOg6BxHr5UwvpfBe8C1WiJuNSCUrN/o2xnDyNSA98/r2qKbs7
 hjXNcPv1lvRJwNkDdYfrC4xK4jJuX7pbP/1PbEVzCr6vCUcaHtzkvbClT68URMZHabrz
 R/8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBw21KXNbiB9paXwIkzaO2pY6cpHn+7LAJUN4YAFY0R6SqAOiFc8pVF1yBGzSYJGl8iFjZZUQww=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIUpvte/ChJPklMexWvOHSdb8iNXscCfpSUrxVYeOiPz1nvARNz
 h6IxZcPZJKByyPDhZhtyjiIN+ssUgWi80/k7nsRyv3ffMslp/4uhBTqGjg6MMTHK8g0=
X-Gm-Gg: AYBFou1x3xQpdBSKnHM1wizQwKq/wXBGWDxIbVlxWgZC4M2evZEpWF3IHWh1h7nxScy
 aAMhbG5BysiP57GGSvGpBs97qVQRWO1/P41CSRLznjXPuw7j9W42Gq5Qy9QfljfJEiQL8ErWZPt
 MDDjh9AFeV+7CMKpmC0MGhVlTMG+ywpWmDX6o9F/37a3B4dLxjKbOYE+shP2ed1HT/Xbs9CTVM8
 XV0TyvqHCEoc4o6kkaP6zJaGmbHIFPzrG8UB3rFYRsASBlSO+/h2defVHTMcch350tHLY17V8Cc
 8dynr7CUBHP3MLJshRwxCc5xHJOYJoiMu/vr/Z7PwJVwBwjTz6mingohjsRQyyPefhpdPMruugi
 4df9poEWGBnqHEhmc1IlVeo7dzrVHV++HGQy8JxUjjs0UuESOsZz+gjaeI61z55KJgPehgW/HiM
 6R6ATL18urHC7GAYMRX28dbHl7ZZQQZqWr/JFDPgXf3E+7RYrpMEdmG6rHIE2+hbkhboowZhNy2
 6WFfmBUKHzagGedVBgsFoZTFO4A7g/mbq5xALukExdLEbsCISl6ccXpov0zygmYxrkn5ZLsgxm4
 MQPnBy7F4UwHUm0NaWk6kQFfKSg1bPFWOwsw8CXQ7ISZjWueD06i1l5QbFFDL9ut+6aJHSVZVM0
 ASDN79X87dLrqgEKrcZ4fbvMilpqE/Qh5c3C8xMlWUAdIrucSxK9IgYMg7g==
X-Received: by 2002:a05:6820:1693:b0:6b7:46fa:169a with SMTP id
 006d021491bc7-70ba0e8ff73mr3948683eaf.47.1793035415621; 
 Mon, 26 Oct 2026 10:23:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8431c1f89sm4963943fac.13.2026.10.26.10.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:23:35 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:23:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Vincent Jardin <vjardin@free.fr>, Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Sinan Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
Message-ID: <20261026172332.GE646438@bill-the-cat>
References: <6C364E68-4927-470F-BEEE-1F9AFF3FDCD0@mainlining.org>
 <20261026142023.GA624796@bill-the-cat>
 <50F741B3-1E13-4B3F-BF87-9DD7C45E1216@mainlining.org>
 <at99iCtY7_bTF85U@l3017728.home>
 <8961F479-747C-46A1-A6AD-DC55A25379B6@mainlining.org>
 <DB9PR06MB78490540DD8519B943F1B688C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <9A4733E5-6C6F-41B3-B181-18531264976E@mainlining.org>
 <DB9PR06MB78493ACFF21592386826CA93C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <0CEEE153-769E-4B60-9CAA-3FEF80E4A659@mainlining.org>
 <DC081BDC-A313-4635-B013-88FCABE9C4FE@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aOgC98aPz4Ddhmks"
Content-Disposition: inline
In-Reply-To: <DC081BDC-A313-4635-B013-88FCABE9C4FE@mainlining.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--aOgC98aPz4Ddhmks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 05:00:19PM +0000, Bradley Morgan wrote:
> On 26 October 2026 16:58:47 GMT, Bradley Morgan <brads@mainlining.org>
> wrote:
> >On 26 October 2026 16:55:09 GMT, Tomas Alvarez Vanoli
> ><tomas.alvarez-vanoli@hitachienergy.com> wrote:
> >>>>
> >>>>Hi all,
> >>>>
> >>>>Just a data point from a user: we are using U-Boot on a T1040 (QorIQ /
> >>>>mpc85xx) in a product, and we intend to keep up with mainline as much
> >as
> >>>>we can. We'd appreciate PowerPC support staying in tree, and we're
> >happy
> >>>>to test patches on T1040 hardware and report back.
> >>>>We run u-boot in 32-bit mode (not sure if it is possible to use 64-bi=
t)
> >>>>and
> >>>>linux in 64-bit.
> >>>>I am in the process of bringing it up to our 2025.07 branch and
> >>>>potentially
> >>>>mainlining as much as possible. We have some remnants of it under
> >>>>`board/keymile/kmcent2`.
> >>>
> >>>Would T1042D4RDB affect you?
> >>
> >>Not directly from what I see in the code, as long as the shared code wi=
th
> >>ARCH_T1040 is kept. Sorry for the false alarm, just wanted to report th=
at
> >>there are dozens of us using powerpc :)
> >
> >What you could do if you would like is to test the whole series to see if
> >it unaffected you.
> >
> >
> >Btw tom I had a idea: you merge Vincent's bug fix and my maintainers
> >patch,you make a PowerPC custodian tree, and I handle the series and the
> >naks and stuff and the comments.
>=20
> and btw yes I'll make the pr with the finished patches so you can merge
> them cleanly

Trees are relatively cheap, but I'm not sure we need another one either
for the subset of formerly-Freescale and not-QorIQ PowerPC parts. Since
I added you to the fsl-qoriq tree, you can also just pick up the
outstanding fixes and your maintainer patches (and leave dropping stuff
for now, as this series shows today we're just getting people having a
chance to see and reply to this stuff) and send me a PR. Thanks.

--=20
Tom

--aOgC98aPz4Ddhmks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat+MlAAKCRAr4qD1Cr/k
CiE2AQCdO6Pxo9C0F190Hc11E0xrgSG6v7qgZzK5DFP/VDH6JwD/QEdfBBeI6NKo
+d4GkK9DfYcA39YvpftYNwPxPzPZfwk=
=v4Ev
-----END PGP SIGNATURE-----

--aOgC98aPz4Ddhmks--
