Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DE8606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nNyz59P3;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=XySZp4eA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09DA940B20;
	Fri, 30 Oct 2026 18:41:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Czeo1y0HUNI7; Fri, 30 Oct 2026 18:41:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 26A6540AA0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793385714;
	b=RAq6p5s/LHoFP1SmfXLL70dsChekeeksPf4pyMr74XYZuuAx/UhKqdpNa7yBUbNWhxpb
	 9mK3B5SmUJ1Lyg31vLVGuzpZr+KRrmsOojLv8iiNMHh5DTw1jJ1VD+LsYgdXaKC4f6xpe
	 DuILE/Na44j/WG85sXEgIgXsnFhyUriF4qUBN6mGBvEAXhr5wjN9YW0nPLGhH7AB1JSU4
	 f0I1yTnMrZju4F7VZRm9VG7ziobAFeiS3bA7o1QW0VOXT62KixompJL5wVTS7xePMA0Z3
	 9j38exjF6c6dSxqw2bBS0rmJAvS/qLDihZzadTuY2F/DeLSGEQcvblt+EGBj/9u/esw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793385714;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=FyC+Xdp1rrQ8j+s4v9xD32ixsh4T0ekK31omHYC9Z70=;
	b=Aa46jMewyZNNiP3K6y6DT7b1gLkNhoJ92/jhSh1MBYg8j3DRvKuGcvW1c//rolqFO1Bu
	 ZwYwK/P05e8dBaXX04+Us2UdxlNRor3k6M3+cYU69X6yFQGvCOTB3/TOyozD0uM37vvcv
	 oczpcv3gV6mySUeWmEuz9i3I+m6FM7cQk4lqrffeCUmjmPhBcPywcyp3LYC6KeYRPUXgJ
	 QFx1EoheroDps9bPzIxO/AktOKwb9HDL9swoV3LVnxLUYNuC8Em+r/nXriKAS/Q3DmbaF
	 YMAQ6TDv18ePVco64hgmj1OmR7eQrml5v+4jTHfYQCO0O5RdzAU/LRjlzck9bTwulCQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793385714;
	bh=FyC+Xdp1rrQ8j+s4v9xD32ixsh4T0ekK31omHYC9Z70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nNyz59P31ZXczTDKS7UQwrIWM1/3y15Jfibwnsdr8HE+h5uV5/rrNz0QqqYQtEJkE
	 iFv4xNtpe1oaiKwysvhFAxwlyYbgd2zg9Nd4kykuntoNAc4O0rM7y1MX75+so2AHkG
	 IfB8vHHf7OcMWLT6qND8/oDwox1azlxaqT6wuayjJDgiTeT4CZOCLOdk4ni0yvNo3Z
	 W+HsRKan6AGKDb/TVLu2TBffjXXyOA5wZiVitlhbiDu52UsDb1Bv3f755WnHNk/D23
	 RUG+RtLj33sMIWP4ZGQBjJwFQBnfOCBNz/WJrt/Nwzf2ShjYyzOw9iLgUOTu4AKmwT
	 v2uzVS/GEV4sA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26A6540AA0;
	Fri, 30 Oct 2026 18:41:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A1852AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C96860A66
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:41:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DwhfFpp8Ws7W for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 18:41:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9115C6079D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793385711;
 b=PCWaZdIqFWgZdrCIdnLFuzychDaaADNkWEWAphpxvSAEl2+3ftLgWaiRKoFXT+014mgH
 s3fIaglfY2CumAQnSJkJUMGl0dzk35+HqBZtFpZBqRP+vBLP4yvhZywyFJxm8OqFtD2PB
 aEvw1a/EUbo3B8kZGkAaHqJBqwx5VnRhVfeZq9bODJChyt+F8YmZfABlrR+LX2YXrn1OU
 NngrvSUp0Gn8QIVVZ0QGhu526BqbSLeKXdyjy+/0RB+wowa/u+m/z4WyhzNulT+BgNLXY
 e85idth+LmTUfRs8ak3f0vpfeY1q60b+Fmel2apMuUjBm5YPZagNQPmnQz5t//CtISw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793385711;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=FyC+Xdp1rrQ8j+s4v9xD32ixsh4T0ekK31omHYC9Z70=;
 b=cjXWxnKDCm5nA5WvLw+Hzsl0WOd8RbtqdH82h/5bjJXPPepGTGPVgWDNGPJB9qSHuyoW
 LwAwYGTxaI+AS3rWeKTBxLrwk/Y8jHdVHZFL5GoyjeBQbCtjnx4nC6M3XUYaQqXsfwTfd
 IYYs1cLwLuJqgndu2w9JIeBFFIG0q2zQ4+pALvwkpQ0fYWXZ7CV+CQAOQ/cJtv8SnqqbY
 0C6JnLrcf7MGAKJSAC0U0kipJif/wPUXIrcRXtu4Sr2MxkC/LE3l7MqW2B5mXaLAf0U/y
 /JlP3o52gRaeBPgz0aYxZPCm8HT1OTs6CkcyDYpVi1szWNJ5H+Iho3R2BO0J/jxL0XQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XySZp4eA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XySZp4eA
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9115C6079D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:41:50 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-845f3fa7f38so476700a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793385710; x=1793990510;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FyC+Xdp1rrQ8j+s4v9xD32ixsh4T0ekK31omHYC9Z70=;
 b=XySZp4eAmMUKMkznGQBswOpxNHfv8QrIm1u8GxUM2PSO8iFlNIWs9IU66gEhWviUVv
 Li2A0X55/Vuuy3iJ2iQPADdGtNQ9I+1gpGyWiZOCAr0ZrRKvSvMzMdcpe+1zXGfIf1ut
 iRSv5InQuyhwA29FQVI/94YxVVwTKJM7rf59U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793385710; x=1793990510;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FyC+Xdp1rrQ8j+s4v9xD32ixsh4T0ekK31omHYC9Z70=;
 b=2T8wRh3Wv5I8Q8QEWvo/3Nd/V5MreLSd8H+5Ur43RMvbuprUEPFkwyNkCGuPSmyiFo
 Bhm21R7Ch6XrkBRn5h3JjZy404vSv14k5bX8hvz533y7YfZhrJrrgluMG+07VXzCzl9n
 V0Xd20RqW+4IOO7YJ2bWvbQP/15rYn1Y4GsH5KTYO3KhJ47NjKBBJRKq2ZwQMofhZ5r2
 YRjbKwMqku4oWXVd0nvLJ9s5GUgLzlgURZVWm2n/XTAjAD6qf1tkmGpCQmMU+BS68em3
 tTXc20gsoV807RXhSd92MiVfJwQYPQ8daYrhBLVi7yhI3A7ohb//PRDgbiN0GyxBqnqR
 s2yQ==
X-Gm-Message-State: AFq9FYKuTwRZ9QShu/t/bnQmpGAOkrkWNlgJHa1S6zfoFrjbCvw8Oos7
 KyEaPH8Pllg8lEiiSv7f8PijEdFJqvLdA+jmq32ZBDhF9+tGS27UOCLKjPCeq2DjzKU=
X-Gm-Gg: AYBFou12F72LM4WGUh2jYGKS5WsVNs/W0AH9EJye0v0YEBmPXFkLIXYt0HuCL9rxfUW
 KW5wm1P7Tuap27fW4JZ0OBoNWCojkfq99Eu93bWou+f8W+kenxqv24r4+D9b+sBmUw89leaIOsS
 7CIVRZ8GA47Vu/euXC8MVBAnIMq5inXeBI8DGpeN9Iv8lVPfReDFe+qvjJUeeskxf/iHAKwzyr0
 cugo/q9iYUPW1ORN2C9jPw6IbN3Yz8eAHJawgZi0Bu8IcjQs7l4RQokvfMU4PP9bVe+539s9C68
 jDwgumrIy1ymzmzc/qvUGcacoSDK4/8ZlYn7pGoz+8pn++sXQnQ1IDg4G8RH5kzqfSYjYnmSWqV
 FnRZUL4NMbud8TYS4mreHzUBAG+Ayxoq1O0C4Pxs9DI+EOUdiwOd2TxW+JEW+dfvE1MeVnZj42u
 JtdcezdXnZ1XtClPJnIrPvKBCwwAav0wuq93Ojk3Xq2RCoXJoMQmHi9VWKiGtrCAEY8hV2oHYze
 19Y19oG2WWiMPV9WRfUyEkNb7JBT+W5xzvsckX7kSaSEQuY0T/6i0aoC9zD/so03VcZFeTSZPZV
 5VQ3jdS410TI5CRlAwsdQ9Im4Nv0I551dhfQ3uzv9Ah5DL4xszxKQd8eGTP0S7XlbXz85tLwu7K
 C8kuqCQ/NaHkrP0ukPv4SyiwnTKrmxdaYMvUaC56qPmwNdaGpWSdKkBd2hTtmmoDH6df88gOnmf
 35+xzrcaXGzYertTt/nhjo1LQyZziLmAk=
X-Received: by 2002:a05:6808:6503:b0:4d6:9232:b3bc with SMTP id
 5614622812f47-5640ddc12d7mr2545192b6e.51.1793385709761; 
 Fri, 30 Oct 2026 11:41:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a9218e97b0sm588528fac.4.2026.10.30.11.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:41:49 -0700 (PDT)
Date: Fri, 30 Oct 2026 12:41:47 -0600
From: Tom Rini <trini@konsulko.com>
To: "Hanumant Kakade, Suraj" <Suraj.HanumantKakade@amd.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "Simek, Michal" <michal.simek@amd.com>, "git (AMD-Xilinx)" <git@amd.com>,
 "Begari, Padmarao" <Padmarao.Begari@amd.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v3 2/2] scripts: pass dtc cpp flags via a GCC response file
Message-ID: <20261030184147.GK3309461@bill-the-cat>
References: <20261015044923.206217-1-suraj.hanumantkakade@amd.com>
 <20261015044923.206217-3-suraj.hanumantkakade@amd.com>
 <20261021182343.GA3287961@bill-the-cat>
 <IA1PR12MB952911E4FEC654FDA3B52AA089602@IA1PR12MB9529.namprd12.prod.outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fdMGQE7YZtl0c3jR"
Content-Disposition: inline
In-Reply-To: <IA1PR12MB952911E4FEC654FDA3B52AA089602@IA1PR12MB9529.namprd12.prod.outlook.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--fdMGQE7YZtl0c3jR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 05:17:58AM +0000, Hanumant Kakade, Suraj wrote:
> AMD General
>=20
> Hi Tom,
>=20
> Regards,
> Suraj Kakade
> > -----Original Message-----
> > From: Tom Rini <trini@konsulko.com>
> > Sent: Wednesday, October 21, 2026 11:54 PM
> > To: Hanumant Kakade, Suraj <Suraj.HanumantKakade@amd.com>
> > Cc: u-boot@lists.u-boot-project.org; Simek, Michal
> > <michal.simek@amd.com>; git (AMD-Xilinx) <git@amd.com>; Begari,
> > Padmarao <Padmarao.Begari@amd.com>; Simon Glass
> > <sjg@chromium.org>; Rasmus Villemoes <rv@rasmusvillemoes.dk>; Sumit
> > Garg <sumit.garg@kernel.org>
> > Subject: Re: [PATCH v3 2/2] scripts: pass dtc cpp flags via a GCC respo=
nse file
> >
> > On Thu, Oct 15, 2026 at 10:19:08AM +0530, Suraj Kakade wrote:
> >
> > > cmd_dtc inlines dtc_cpp_flags (including every upstream dtsi -I
> > > path) in the HOSTCC command. With a long $(srctree) that command is
> > > too large for /bin/sh -c and Make fails with "Argument list too long"
> > > while building a .dtb.
> > >
> > > Write the flags to a per-target .dtc.flags.tmp file and pass @file to
> > > HOSTCC/CPP for dtb and dtbo generation and the DEVICE_TREE_DEBUG diff,
> > > so the shell command stays short. The flags are still compared and
> > > saved with the command, so a change to them rebuilds the output, and
> > > the file is only written when a rebuild is needed.
> > > dts/upstream/Makefile uses short relative include paths and is left
> > > unchanged.
> > >
> > > GNU Make 4.0 is now the enforced minimum, so using $(file ...) is saf=
e.
> > >
> > > Fixes: 3a4e5944c96c ("Makefile: Allow upstream DT subtree to provide
> > > DT includes")
> > > Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> >
> > This seem similar to, but not exactly, what's in the linux kernel curre=
ntly. Is
> > this based on a change there, and if so please update the commit message
> > similar to part 1. Thanks.
>=20
> No, this is not based on a Linux change. I compared the Kbuild.include an=
d dtc rule changes with current Linux and found nothing equivalent.
>=20
> The Kbuild.include lines this patch touches (cmd-check, cmd_and_savecmd, =
cmd_and_fixdep) are U-Boot's older copies of the Linux kbuild macros, so th=
e hunk looks similar to Linux, but the cmd_extra handling that this patch a=
dds does not exist there. Linux's dtc rule also passes a single -I (scripts=
/dtc/include-prefixes) inline and does not use a response file, so it does =
not hit the limit.

OK, thanks for explaining further.

--=20
Tom

--fdMGQE7YZtl0c3jR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauTk6gAKCRAr4qD1Cr/k
CtKsAPwI/plDjBhTgFUYJT4NpPOm3hKKakQ4vW5yG4D6teEp1gD8D/JctqunBU8z
SVCXowT9pV70fOntvwvq2Xh8ohndIAU=
=Yv0h
-----END PGP SIGNATURE-----

--fdMGQE7YZtl0c3jR--
