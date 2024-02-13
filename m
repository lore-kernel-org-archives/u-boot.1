Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A63C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 22:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4ED687DAE;
	Tue, 13 Feb 2024 23:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W+E+h3hr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5582687DAE; Tue, 13 Feb 2024 23:33:14 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA6A87DAB
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 23:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dc742543119so4205013276.0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 14:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707863591; x=1708468391; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P8p9ZmhclcMGL6+Koxq0vKbRYof8lpC0BieT6TCuEnA=;
 b=W+E+h3hrUYkmxDJC2AS5gZJ5fM3eln/1Fb3o0l5fUX+vNCqbWJNkroOHMhsbuXXrNk
 O44AZDSUkXdQeCJTSX47H7Y2VP1K6KEtKBaPKb/Q0D6nmtE+4VKjMGxHdQGJp5/goF0d
 7SYFQL1XCS445YDT91MvzqnTfxnHjtZfBsaQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707863591; x=1708468391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8p9ZmhclcMGL6+Koxq0vKbRYof8lpC0BieT6TCuEnA=;
 b=eP6TXs2E7JN4xpj33lhx01rC5lPHsoBnq+I6kTuTbYaZChoBl6kZujLDCTMP1t9re6
 30e/Xcz2Y6rShyg22yi3YlUTpvcEwTiwsYcK9t7fSrcD+GdmiCK8nhx6kvkqaSuThQ9S
 1/5MphvzPh8MnOO4OFtKfqGhFWY00wcOx365VQPYE/uqhpWGiFHVKa2Om3VOQltCJZJr
 hn+z4yE4nybmQSetnEggaUixFK5QHeOaQICHJKBci4RucpW/C1tyGljL1Wig66jkdiWj
 MRUnGAjbNyEXXK+c6cCpQl0rZalnb2KfBlXxEy9aJL4FMk6DpOpkfPSMl/fAaJv9liXO
 YSDw==
X-Gm-Message-State: AOJu0Yzi2LlsW8hHHmmTO+JdcschgGYhrp7g/plQ4t0mL4SUQ+NkaJSk
 sPzYFEr81uOw237Fzo536tezvoxYoLYp6TpC1htm1D618tWdO8iqmrbVCznNqnM=
X-Google-Smtp-Source: AGHT+IFCWAqXX1ekMCv3KB1DRVvXQ1zLEfBI6OKsUtKj7cEfsyAsZw2pXEolYz25q1vB341N8Rynbw==
X-Received: by 2002:a25:2e42:0:b0:dcd:3575:db79 with SMTP id
 b2-20020a252e42000000b00dcd3575db79mr475328ybn.6.1707863590974; 
 Tue, 13 Feb 2024 14:33:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWnczzrteU7F/zGqNYFpMi1n4l2mOPq08djSQ0KYF1O6w9cZoCDTKtyn4nWqRbhhq691kH5y63FkHZnLhMlqXDCQymaClbV
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 x37-20020a25aca5000000b00dcc620f4139sm564120ybi.14.2024.02.13.14.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 14:33:10 -0800 (PST)
Date: Tue, 13 Feb 2024 17:33:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: Re: [PATCH v1] cmd: hash: fix param count check
Message-ID: <20240213223308.GW3040305@bill-the-cat>
References: <20240207000132.3116094-1-igor.opaniuk@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nfdGj58vD3NkDn5a"
Content-Disposition: inline
In-Reply-To: <20240207000132.3116094-1-igor.opaniuk@foundries.io>
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


--nfdGj58vD3NkDn5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 01:01:32AM +0100, Igor Opaniuk wrote:

> From: Igor Opaniuk <igor.opaniuk@gmail.com>
>=20
> Add correct check for parameter count.
>=20
> This fixes this issue when `hash` cmd is invoked without params:
>=20
> =3D> hash
> data abort
> pc : [<bf739204>]	   lr : [<ba6effa8>]
> reloc pc : [<60019204>]	   lr : [<5afcffa8>]
> sp : ba6dd9c8  ip : bf7391f0	 fp : bf74ec14
> r10: 00000001  r9 : ba6dfea0	 r8 : bf7ea030
> r7 : 00000000  r6 : ba6effa8	 r5 : 00000000  r4 : ffffffff
> r3 : bf7c257c  r2 : 00000001	 r1 : 00000000  r0 : bf7e6e34
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32
> Code: e5934004 e1a0e003 e59f3050 e2444001 (e5f4c001)
> Resetting CPU ...
>=20
> resetting ...
>=20
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--nfdGj58vD3NkDn5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXL7iQACgkQFHw5/5Y0
tyx9AAv/ZBitDYh4usui1E+PgTxXTqTscL0ggqTrPXRNY2824/MwtwAVXwN4963s
Y5CWUdCBVplcJjXjgqmuyPtxAvHObr39qcfaA79RIQ3uaG8KR2x4XvQeHaIgaACq
cuQ5JfMIS0a1OwHBaMFCvxSEBQLMoxbWezSJQOGW9nq0S32Li+kdVcVxctgIRGmP
+0RvN1rYW59H+HLRfT/x2S1HPyoam2jLa85ozm2JnicoSFixJ5EhLhfG/lVEYxTT
4QBlVVY1ysiBfR9Ill6db2KbnNH+qezRSLPt+7GOfi9/oKDhGuC3JD7dmG5t7P/r
C2LejFjayCcyZsybnDNeddi3RCXed7cJNG1S7HIdFHb/j+g84BxDahgvUJQwhKxN
0vIGwePTXH+Z3s1Vi7qd3O/c9jaMcIvPB+2lWhaQc00JwgdkbewVBEPzFEoj3f0l
ljwB81nt//xdWKVxNqPvSzxMTZnujrWWxVE0k8aciDv0962BzPKZ90OkWuiAqprB
2TyrAnzj
=WkKZ
-----END PGP SIGNATURE-----

--nfdGj58vD3NkDn5a--
