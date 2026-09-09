Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F97EC79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 14:48:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02A2740775;
	Wed,  9 Sep 2026 14:48:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 56mmF1b-t2aY; Wed,  9 Sep 2026 14:48:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4F91C40761
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788965311;
	b=lWx13MmAd83ABhY0vNDAj65kb6Ef4Fppf1/4yiJtjWpStxtqwOhqSGNc6DWB8yafKfz/
	 QpOCrj21Qtj2avXunrozVj3QxOMl/vmzP2oE2W0uHWwtp5myxsz81/N7QSwJAT191nFgb
	 dxKLywZe1DjYBAXpTTcDHmw7VyEuUllXHMWYqxkG64oV1oH1p2pIhGD3krQ+8zmcNcMBl
	 X4CadfvlBPktKEIj3YLVj+r4xJWSmvy90P04RwMjBQznrGh2AN1LKC26ge+Rd670mlydv
	 w+GRDkQZOzB4tRPNR2THAyiOOPBiJQCmJbuJI/S8EN039E+KJUMOecIM3Hu8CPdz3ZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788965311;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XuS9ZPw6Wrs5w2VPLB47R3qFlTGOoD+csZzrbjLiKAM=;
	b=JZFHvAfH4ruOCsH1cxG2bO1Nv6ejgWVECqxNkeA+uvAxd2VgDy4ruyK8rr6ed2R1gUvx
	 St1HD9eZA847yEIYHy0/bLXKWpSTKy6NU7gNtJpEgugAyhTBkDxZNycbFQ7yBr2F/s58r
	 3QInZM0fTT8562GjfooB60FTMO052Zw5pzLzvBdR4kpvb68vVxG/rQvWmp2uA87cWTi7p
	 OVCNdjqF0VJdsVignc14hQF85zvtYagN1usc2c4HkrGNxtHhlukrSqsp483wwriOpnIqn
	 MeLbXIXuCra/DJ0nkBOVEAzdpBJ+9px3Ia52BshNJmSkANUnVasFyHeDshO74d3BMww==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=f7Y1ZyVR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788965311;
	bh=XuS9ZPw6Wrs5w2VPLB47R3qFlTGOoD+csZzrbjLiKAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uReLXiRgR/bywPRLgAT5RsEDNq8A1nKJXq+V2312QkGj9eZLK2QIIVsnB2SMvf30q
	 2tVM+PSNYSP4T7aPmLn8TqlJgxdZRvO0tM5dZdcjJjJ3y8J269rcP/uZaHvEJOjufE
	 a78N0K/aRTuotVtKrFuQycT4lWAQ3IA3eNrCJ6FRZNo+Uf5LrhbDws5ZMAYatPXFjP
	 5RrNHxzhkPfAQHapi7HqEVZmFajUHLaO1rgpyT/ON3LqKZl+YF1V0MeIKtXp4v6FKq
	 R/mzGBstR/w1MJi0qw2aE+JKuTxNOFSibjFQwI/9BhzNhVkGLli6910IlNx5tYz8l0
	 WSmQkYV73sVEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F91C40761;
	Wed,  9 Sep 2026 14:48:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D436432
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 14:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E59140775
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 14:48:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G5XnmAtEU_Qh for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 14:48:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C3E8740761
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788965310;
 b=J9848LiTXpIKHrc3RKTurfMAuJQaO5ZKTauyXJkTA2Z1lBu+VCYzmsGrjG2LoOAKuOR9
 lXrjkhaTbvlpIrAJmj29axIo9sWzAdm+KYNE8lJyiX9lJF9VO45shEtwtJVKbopuBYgml
 DLQS+45iDpe71ORItjFAiR74/bIk6UwIVW6YY6bY/nK4Syoby67eUrlYZmloA4ouGZLzm
 3V/73cyxtOtbA6+TKMI6lQ009jECzrvfvozF9VKNJgK5DwoBuVeLjlfe5zk2NqVikV1G/
 7R3I2B7fCzsUkaK4whQ1Wp+Pqu8kiAhmv2KsKy6DZOnntbQgcnHpwuXnKoVVnIXuTNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788965310;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=XuS9ZPw6Wrs5w2VPLB47R3qFlTGOoD+csZzrbjLiKAM=;
 b=G9j4TUOym4ewELqpNTIvyk5TcPcsBwclCb6+STX+90ukI6U2NlNHNo+4rfJIr1PPGeYS
 8uQloZJhwU43Owh4pL1mmXy5vO3hKA+eXS9nkjq0gHIffOfo8gp9e+/5PzFa2Lsm8smtQ
 /21+2PeAdme+91UbG9TSP3lYeKNInkncHT88bgsx/NKUS3bR5rx5Xjxl/Pw4/Xt8YxkMp
 DCCf4/xLc0o6CukA+ie+2I2nYVoe3EwuvSM7KLOl/NtgKfjvI+p1ac6+hRb9mZqRzFm/q
 JKa8fLnYMw9LXjDsaNvZNPeHefRR+8mUOrSDQEVw/G1gyVHepRT6jbydlBbkrz6rgdQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=f7Y1ZyVR; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::1;
 helo=mail-oa2-x01.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=f7Y1ZyVR
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C3E8740761
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 14:48:29 +0000 (UTC)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-451e1066971so1819957fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788965308; x=1789570108;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XuS9ZPw6Wrs5w2VPLB47R3qFlTGOoD+csZzrbjLiKAM=;
 b=f7Y1ZyVRXQyFfOQ7XDlkXzY6w/Zl/yxa4qcJyTxxb27f37kGk3xRdR9pZMMcYGUKIc
 Y+7NRfVDgVejDnbi2Tad/CEZ07qLa1Iu12aMgaR1pq8CX2cZm+qAFvk2ZjTEkbLZABeZ
 fxiToDWDqjNSEdLnvxGt08oT5ov/kTMNN7SGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788965308; x=1789570108;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XuS9ZPw6Wrs5w2VPLB47R3qFlTGOoD+csZzrbjLiKAM=;
 b=FX+BtB3512CovRcsmnB2S/34rzYtg0w2L8bmXhBFDjCU+RS97qCT7twWxDq3NyOleB
 7vysfThYB7z53z/01U856eAfaZsx7PVGurn9ubwBpgtS62JSj0Eb1z6Vm7RKPGJnmmgo
 s4Eemzs6+jwK/V0YHAifbSjdog49c7lHfNrISPRzyM/hTy6bR1DWB1yE28ufcQAfcxKD
 va/z+hWETRzKi4miQ4T6BdHqUPq2za67vgr3VEf9UMB0shc47BQz+szV/Ky5GUbmrY3B
 2V9aporZwz2LGb3eQx6eKJlataOR5s7ZJOjSEmEKy2fiHUiPAMzWDWJzQgnMqMavaFsT
 iq6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9Lkx7v3SC3yj2xIXMHJRs/j7pI2cAZFylYIReid7bjFDmHfB/n0Gr8TgF74uolSLSwasZVps=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k+H0Triv540+gBWGEyVWe5dTKogCYNWWlxn/kw9Cw4LXNEjYk3
 IzCxIUj0LYrkLv35eqrptFVgvAj1JHJf5oHSmCBVAfhi1IjoA+HX0aw9R/Z0q5X+Z/o=
X-Gm-Gg: AYBFou1Zrro3FPDPJIat2B+j6KXpJjTBYe3oVRlWkge9dpi2FNsXMTLs+FRvtovUdwG
 7talpnzsciMRtTUwMQNT0WnyrvMAYf5xuTlJt9zvO+JExr/bEpLPolLiCVMgnQYtVe92+7Zy1qK
 NuKZQSDADkDqDk6wwG05hdNYVxixI6eo0eus9fL2QDsY6U/KVeGuVQZwbnYDKPZ5+/SUIL6zN9q
 gOLl8Wzt/26ob9/l7MORqm9OLFCN/5BTNVROEgRzl8qbhiz1IV9A/oO/mIBD5C4gGJjty5ijTCl
 rvh17Zd6nMzSTHNQs9oMB+haW+BFYNA8DJo8TOXpYR6kUBoADvMibwhH1gjPmgbkuPfcnw404ry
 Acqgch3wla/hy3NzR2bxpBc0Rvqy+DeeMqzWrHvFpyx2bWuU3ejyfgZt+sLXEtFM1cot863mBZG
 ANVUNapIhWLCUeqjswmSBOctthJWU8Pyw6A+OWgF7JrU1kTZCLx9L1CRPTTAS4NG8FF1BuRQvSp
 +CxmKL/yLT0vtUJn5kmbbz+NdB3nmLawnLx3wMcOntIHMR66KOLAxv5m9ZhgDMxV9iObyKv9KrN
 NLBgJFa9yZofA/fCc73L
X-Received: by 2002:a05:6820:3401:10b0:6b1:51fa:3562 with SMTP id
 006d021491bc7-6bdcddff004mr5086662eaf.34.1788965308297; 
 Wed, 09 Sep 2026 07:48:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6dce7b751sm19546852eaf.9.2026.09.09.07.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 07:48:27 -0700 (PDT)
Date: Wed, 9 Sep 2026 08:48:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Janne Grunau <j@jannau.net>,
 Mark Kettenis <kettenis@openbsd.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Replace Apple with N:
Message-ID: <20260909144825.GG1764417@bill-the-cat>
References: <20260521201712.43955-1-marek.vasut+renesas@mailbox.org>
 <c1fa8d82-8ca7-41bb-b90c-8bed4cebb967@cherry.de>
 <de6a4064-c17e-4b8f-96db-50013f694936@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mjwYgrud2imu1/5n"
Content-Disposition: inline
In-Reply-To: <de6a4064-c17e-4b8f-96db-50013f694936@mailbox.org>
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


--mjwYgrud2imu1/5n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 09:10:34PM +0200, Marek Vasut wrote:
> On 5/22/26 11:37 AM, Quentin Schulz wrote:
>=20
> Hello Quentin,
>=20
> > Note:
> >=20
> > """
> >  =A0=A0=A0=A0=A0=A0=A0 N: Files and directories with regex patterns.
> > [...]
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 scripts/get_maintainer.pl has different=
 behavior for files that
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 match F: pattern and matches of N: patt=
erns.=A0 By default,
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 get_maintainer will not look at git log=
 history when an F:
> > pattern
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 match occurs.=A0 When an N: match occur=
s, git log history is used
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 to also notify the people that have git=
 commit signatures.
> > """
> >=20
> > So more people may be added in Cc by get_maintainer.pl? I'm not sure
> > it's a bad thing, but it may surprise people.
>=20
> TIL, I did not know that either.
>=20
> I think it is up to Janne/Mark to decide whether they want this patch or
> not.

Yes, Janne and Mark, do you want this? Thanks!

--=20
Tom

--mjwYgrud2imu1/5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqFxuQAKCRAr4qD1Cr/k
CiYkAP9cWmgDM2HSh8hlUOx1W/AYxM9mx2QwK/uWxQ1HTv7wlAD9GNwoGFdFOIK7
3Boo6Gh6l3211aXWSj6KBM/AqqGlDAk=
=j3+Z
-----END PGP SIGNATURE-----

--mjwYgrud2imu1/5n--
