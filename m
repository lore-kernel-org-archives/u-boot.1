Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189DC6084423
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LXY26kxQ;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZGEqRcvU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEAE6607C0;
	Mon,  2 Nov 2026 15:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WDkNvy9icrkR; Mon,  2 Nov 2026 15:04:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E78BD60673
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793631899;
	b=DSIJAeYwOQgylR1XY+TT4z1vV6lhJdA6BYaTR5j0+lULCgn1o4+GxNdrAalP1rUCzuvt
	 uFvtzH0fJ7nSdh/0QbobouQxrW6yDtuRsl+CiCVvJgw3td4lhF2tgircW09rv4U23t9wJ
	 H+YAGmFzhIsHJIwBsQWstf0Akq43rCU9oGoOYh0rSDaWEnJkpzK3VHXb1cW7tnNkXSuf4
	 9qUjEwxLfF3ZBGDstKtGZMY3fF1Vsf3j21p3uu9LGanxjhPFshK9GuKUagqMst+W2DU5m
	 LYCiIaaWiTmFiQ6CuThwv7/MqrRjvhLNqA7StUHXgbNnR7uOz2tcnjvO2TT6KlaaBHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793631899;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TPHHC+FDzeSZpjX1KRbMjHfkRgvrJt73wuV3K1uZEwc=;
	b=mOWw/gmXd5lIqwZOf0mZk8blpvYycohEDPlVyXYg7le80RwulcmxWFlExiAl90DT3LQJ
	 dxL3gzw5KTAzY1L5m0djbHXq5+5CIC0kJpsC1+TcNQjrMM4QQxcfDTcB/L1gxQILlIfJF
	 HnRKRWf7QLfTh5/FLNY3B5jup7HMpUAZ9ZChMTSns3+kfCOl3tHqmsLIbeiU3UKOygMD4
	 PonlruaqBAQQwX/mzScNYjLw8wHCic4NjNiubJJRfZzDcJivCDYHaBsX8Aq4uGSC4TmrV
	 ZtHPG0RXNjbT/Pxr0XGg1LktI0N5mMLDS5IQ73PvHRR7H2jEw6TTkUbEwfQbsRkR1GA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZGEqRcvU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793631899;
	bh=TPHHC+FDzeSZpjX1KRbMjHfkRgvrJt73wuV3K1uZEwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LXY26kxQFxLd/a64ig75Z7lfdfanqsldBreL55UqFqgoVoQLzk3yE5yNKp/7R6DeH
	 tC22pP2S8YYKYDrQ6M6ov4KmUXbjFyP0G8+1Toov5C1ZMFduSgtHvcX33MZ+FtKQYQ
	 eSVx3HEpgRt1FWSlX9DSbLQ0CPEOCNEjIgv2PLR7gqx+KEW6qK/HcwDa4OyqNm4Hxo
	 ZxpntPU9bpqsJO1JRDe+v6FgFpmtht/4GNz1gLL8AfW4PDpWYdlG8gRcZz3MUwthwe
	 FnfTWF7WxotpgWRfPTvE3nnSdfuKDAsLk1FzpeWLH8aOyDhQMRjafQOjMO1ox1G2Fk
	 7AjNurZwkrEyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E78BD60673;
	Mon,  2 Nov 2026 15:04:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 04152411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDFF960673
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RILC-F5plAMW for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 15:04:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DE70360600
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793631896;
 b=iJ/ufLY0AdB9rYjk4BjyUbB/btUH7F7PE0P9tNGQXUj9/Mc7mRr1RHUxyYmbfMyrbKYP
 5w7DxD14mwC/uhTGagaY75pWTeSqffzzEHnTxtvzChUFTyEjHOFAz4+8OmaRLn1XziGeL
 crirGMdqBABzlog85ScRLVlkDn2Xj2dPWl+8WJMlrlIlJ3KiEYRzbkeXfjnb97VpeA90K
 A4csboPh7p8FZg5AKxWbc0SwlYWkD7RSGnkQaaEowSDVKjVjHPbT5iJ0Pu56FJN3vwhMz
 bSMZj+tBSS4omTcL5/VHF+8B6rNaoFY3wuLctxcr6yd1f+SyhPztrXmzqWXHj9TVYfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793631896;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=TPHHC+FDzeSZpjX1KRbMjHfkRgvrJt73wuV3K1uZEwc=;
 b=MZmmbN9uXQFDANf4Il3sOTnfJR5pRPJYTuhMzrGN31ouT3FgdK5mjzpITFW7VkwxN/7u
 nwKvOqMkdUCt9fR9UqXn4+s0TwLHaDNs7HLO+j+HZ1BcT/JIW5950pKMKdXOlYD3CdcYp
 vjj1ARB+6JFcYsYsOi6D6yu8Sr+d3zjtWODmXNg4ckTcWC/eMehYhilfLqVlwj4h8TZ72
 bxApC/wP51OWam1vf/Th/Upe3lQh5+1TV0Msu1bAY8KT4t6xgcgboPqL5RHIuKq4Oy0ne
 uvDT02xC0ej3W6c268j90ZiOnxuZm7LGyFeNt0Yx1/D1Gh1jdMz3UqU9kwm5RLEB+Cg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZGEqRcvU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::1;
 helo=mail-oa2-x01.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZGEqRcvU
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE70360600
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:04:55 +0000 (UTC)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-456b57c99e2so72657fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 07:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793631894; x=1794236694;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TPHHC+FDzeSZpjX1KRbMjHfkRgvrJt73wuV3K1uZEwc=;
 b=ZGEqRcvUvuJOoD/OJ6NzfFUO0xFPyyeUMebSaSzJIpdjWOiTUwoUeffR2yoqtp4LH0
 OT7mwuXOf6wYz1OymegTSSR3o8xUOjRBvMydICSkg3xTPVyxZ4brEU+gNdNvYdn/28sh
 mwE7mHNoQe3SaWOVP0oQ1dmnXdswiBoB7dXE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793631894; x=1794236694;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TPHHC+FDzeSZpjX1KRbMjHfkRgvrJt73wuV3K1uZEwc=;
 b=eUs6XsB6qs8W88tJ//G6yyMlCFyXV20uVB+5n+8xA0uCFrP1N6FTu0aohiHkQKaEcY
 2v0cqGIHc2MHsDn2rgWoQPGsWQYRVZ6w5NPZfpOpF+g58wdmsDBUKxCAhza1DPvmKg4t
 lS2Zfquc+gmszQzC7+znXHTU0M0oygmJvW0P7Jk08M+A23AkWhvDK85eYkalNRRwd9as
 VEtKerhzZQf60ntPHXyHno7WJvkaVj8+tWCL9kvVobuyYXUUbsk6wPhrY4MJMfas4QNj
 0IBoSA7KKL0QuPKn573j7ygQ2Ffk81XIy9U1CyFD56ALuHtZbnmeOYUu9qsBOHYpeyjI
 4slA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtv/j40G9BxLx2X46Xy/mK14lqvU0cSrG4v9r8QO2M3mEswOgJwxJkXbBIkcUzAM86vet5Mo0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9XQHRnPEQBZJW261QIb45hSxcGdCsWBwGMsJd+TrPNNDwQ7m1d
 x/rUF8+nzV5KHjP0qmR/n/tTg58Z1aAkB45/NmKT3hRLkmxrU1RvO7mDHsyedF3WfCw=
X-Gm-Gg: AYBFou3xhd02oRcIoHTH0LvoiQ+khFEv9QonioEBDDRseglvR4aVdRis7qVLqwlLxmy
 9WIaeJzXrE+MHekJOOSovvCA/93E8mU7/wdjXotu6RhN+SromG1zWHm9JLGMds+bTcCpwn5QQ+Q
 0nmig6jdGMGmub6hiBkXKHmibpGMikKp6LZLUqjzSCWRw+a1r6leB2hYcSSwpbgk/VjMhZDuykO
 JL6yiKviu5j2w/rRcDEiVlD7LxMmd5Gory+tjEVp1Th+8uGA1phOfDHi3jXyrQEabYYhRdvcH/4
 x4vZuJoPiqhXGu06gDJZEd8oCZAIJpfmz61I1Qs1wDB7V96r18nnOWPABTKEjG1Q0r5EqcPN64Z
 AH7L4I1Jg+dBC0P1fQm3St2bd8WpjaWa8qKb0jHqcimU34snpXojqibRu0HrS42pavnbezpkMG2
 Ry28BMYwbp72zTDMMGqy9A0wRfu8guY78B6dM2nrrHzXPoB1PIh8PeaO/jU88TqTiF30tuFyZa4
 nDXVdnk+1YMwKIQGjGBdX+ODQsGb5kNn7By6bHo9xEZ/6Dt+9Z890OIDeBWIw6XIt8DAaeJZ28B
 9QI8xmnQr3KYF4iuTTCQnFg/NHLdkqNE2XIiYoxMjp1iz++UyVbG/oeG45BWqRYPBPAu8dOkhgI
 Cww16FvjSkbkjF7wAMgTwgIXCM59rq69vc/7Ww9FvoJzh0QW6Fys2Pj2vXc+K4IYIwIjudmWha/
 cIsmqEdN4/2sFOEJr7oAkvn7oJV+DYaw==
X-Received: by 2002:a05:6870:5b94:b0:494:8edc:477d with SMTP id
 586e51a60fabf-4a906c6fd40mr4865484fac.0.1793631894378; 
 Mon, 02 Nov 2026 07:04:54 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a95d970b9bsm2480562fac.8.2026.11.02.07.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 07:04:53 -0800 (PST)
Date: Mon, 2 Nov 2026 09:04:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.u-boot-project.org, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Christian Ratzenhofer <christian.ratzenhofer@cdnm.at>
Subject: Re: Pull request: u-boot-sunxi/master for 2027.01
Message-ID: <20261102150450.GU3309461@bill-the-cat>
References: <20261102114733.3468703-1-andre.przywara@arm.com>
 <20261102144240.GS3309461@bill-the-cat>
 <a4934306-eb4d-4a0b-b693-82b8f8d831b8@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z/Wi+ZShRVJ4wuxF"
Content-Disposition: inline
In-Reply-To: <a4934306-eb4d-4a0b-b693-82b8f8d831b8@cherry.de>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Z/Wi+ZShRVJ4wuxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 03:53:01PM +0100, Quentin Schulz wrote:
> Hi Andre,
>=20
> On 11/2/26 3:42 PM, Tom Rini wrote:
> > On Mon, Nov 02, 2026 at 12:47:33PM +0100, Andre Przywara wrote:
> >=20
> > > Hi Tom,
> > >=20
> > > please pull these sunxi changes into main. Please note that's the mas=
ter
> > > branch on the remote side, the main branch is immutable, so I couldn't
> > > push a fix there again.
> >=20
> > Ah. On that note, I think the answer is you should start using a branch
> > name (for-tom, whatever) or tag, rather than just pushing to "main" or
> > "next".
> >=20
>=20
> Maybe check in https://git.u-boot-project.org/u-boot/custodians/u-boot-su=
nxi/-/settings/repository#js-protected-branches-settings
> if main is protected, then you can unprotect if you really want to (or ad=
apt
> it to match what you want). Just telling you how to make it modifiable
> again, but maybe Tom would really prefer a different branch name as
> requested in his previous mail.

Yes, it's also a best practice. A thing I'd really like, and maybe I
need to write a best practices email, is a tag with a "here's what
changed" as the contents. Then the merge commit is automatically
populated for me :)

> > > Not much to report here, some cleanup for some older V3 SoCs, also a =
PMIC
> > > fix for some Olimex A20 board.
> > > H6 boards with 3GB of DRAM now work again, and the A133 build process=
 gets
> > > adjusted to the now mainlined TF-A support.
> > >=20
> > > There are bigger changes lined up, but they depend on DT bindings whi=
ch
> > > have not been merged to the kernel repo yet.
> > >=20
> > > Gitlab CI timed out, but worked fine until then.
> >=20
> > Ah, I thought I had adjusted everyones projects to have 2h be the
> > timeout, but I see I missed at least u-boot-sunxi, I've fixed that now.
> >=20
>=20
> FYI, I had to bump mine to 3h a few months back, but maybe the infra is m=
ore
> stable/faster than it used to and we don't need that anymore?

There's still some pending improvements on the OSU OSL side, but what
had happened was that after we switched over they implemented some
cgroup limitations, and we really only have 46 threads or whatever, out
of 120. But buildman (and nproc) saw 120 and forkbombed ourselves to
very slow builds. Now it reads the cgroup and limits us correctly and
it's down to 90min or less.

--=20
Tom

--Z/Wi+ZShRVJ4wuxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauimjwAKCRAr4qD1Cr/k
Cj9zAQC6jb6UdDp2odzEgttyZS2n2J/GmpH1nOHER1yac58Y5QEAymqMrxXU+n7B
ACiInapr7ikN2+WehkhCwmsdIP4w0wk=
=CGQ6
-----END PGP SIGNATURE-----

--Z/Wi+ZShRVJ4wuxF--
