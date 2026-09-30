Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25FBCA5FC5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 14:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C363809BD;
	Wed, 30 Sep 2026 14:43:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aYnDF2GMUcM6; Wed, 30 Sep 2026 14:43:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ACC3F80872
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790779400;
	b=f+y384KJSK1Fe1aSnSRfGMyrX94AuisGYL7JyOe6cv5tZmpf+iC//4DVwP+6JU8blsLJ
	 oeOyLsn+Reia7ylqwCBqxMSTTrk+jdjV6bz8Lt9O7Zla2tM22f0Ov1zupA8Y5Inbwomgg
	 51tjL4Ur9hIEexVrFaP0Ctbx7hrYhpNfuM5no5sLJZz7fqH3Hll8z9tKEfMPEbjlFY6kF
	 Wr2+tiMTudatbYFEcGrGIxj2ne8AWpsMuYIZphdf8LbNAzGFgpmAp/O2rOW/SoZjtMP6F
	 KXqBLb3+8f3psQBKEP5WZyRj4R5pmSJQFy/zZsbCJrbnqzBGU2ZOkzEMESbIhOD9wBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790779400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ExM1e1aw0+81ZOrItXuRqbk/rlxR5lR4Hm1CzXGqE80=;
	b=m6WO1F//LhxYB/pgZ7im87QPXokeFZDsceX/ajIDLfZuJhONH3D4wn1LWJg0M5luA8QB
	 6fpckRuSoS3OaiGurkDejdPJgKV34Ita8DjAxvOC49SFK9vEQtfvOTUAQLZiMGWQ73C87
	 rf9/syG2QcRft0FMzau3H8LSYLLuxWjGmrvfMc7V0SHRphyNvQ5/XN3zqjKSlsmu+Dd+a
	 kfaHG4vK8B9IcXo/g6eXqUDEA2h0DUeBxYSDDbwbYNGzXB59QODuj+lr51AZHiAFXVaCO
	 0NPNVPqbgRJH0jJV3U/GM1NB6Wto5EkpI6IaYL7a9FMnAeSaT0W98Uv5bI5zxtdNyeA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790779400;
	bh=ExM1e1aw0+81ZOrItXuRqbk/rlxR5lR4Hm1CzXGqE80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rPGh7sD2l4B1vJA2BeyOl2V7m7Det7OEOZ/mdxp0TMrCk9d8cP5bm1rfoSlwVx1Tt
	 L7s8xspM9VsAbUPnlXl1nkdY18EcXUiPzcuz/cdQ8Gvg8dlAQz/bTvUaiaNmvCoQzq
	 a63gwl5Lii+5gkuJyluZQ+VbDmfQzafVn3CsNTxf+xluCZm8LeQZO91ZZNL5E/hU05
	 0DhUJ+s4lUgohQ2VOrOYompaDUsmGJ+mTez/Dr9Mmhv61EwNlrCBw5mjZ0ArUS6+xe
	 m6WFrrvkE1QgN1zbmJHF5fX6l803KOE85HBDd7WZ2xWF9f/0umhyz/FT7RNkJohO5s
	 50K7KIxclBz1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACC3F80872;
	Wed, 30 Sep 2026 14:43:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 694D924E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 14:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5AC7660B20
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 14:43:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zL-Y-8VUbjjQ for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 14:43:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A0A74608E7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790779398;
 b=NRtn9lFGse8IBf5naxlH4VCi3WgGcSVrcqWQcqAxe8WNtqm6NxV1q4nNG8gmJr83ph6B
 aKdsV7hVmh+k5oeJq+/mYRhlqKsX9h5QoGwZ3xfaHYAD3TtGMDNvCHzaBj9SHX9oVRBRX
 G8rcOjFSVlj/GlX/MTPKK3HlCkJ2Zqeq9+k+dAeBfPPDpFyEtzeTbjwysoynXYV8E4mxU
 1GiS0DEHC73sT67/h0pVxx5bMEF1xQfX6LUC5qWPVm6uIcrU1Fgpx/hwHRT9ml4ZZ+WYt
 fMUxn1m6wbtTfWmhVfijJeTqIlP045ilwAOKlBFzfzhaypCydRdIdf+3fYQegNsiPyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790779398;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=ExM1e1aw0+81ZOrItXuRqbk/rlxR5lR4Hm1CzXGqE80=;
 b=EZotwZRnH8FMcsR52OpsWQkSJetm1wK4/MBofdroahiBa7mSMLoLNLdFICQRJC4/oz1J
 BJFfZ6Dm4gZce1RD/Yy1MSneuDHxEfJYHKelUAXKt+UfmBV9bzNjoawvxMDzyWoYXedhx
 0g0YSAMEZdF5hjZQhU5AZBRql7h/LalPvDb4YX/CxQrxqQzZnrm9IhTOTF2cSk56t3niz
 2LFpnWRHZq53d//CMmHmwFkB/EwdXCXVFaudItMy7skAtnzcWoS708iyS4x0lrfmMOIm4
 cV7Txn/BtQDPTrUFQs978CkuwLg7ASTKgd4AovER5Y8UAlOnqBotzynI6KslrHrm1qw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=alVmbskC; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=alVmbskC
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0A74608E7
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 14:43:18 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 46e09a7af769-81b15bca7dfso2940047a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 07:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790779397; x=1791384197;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ExM1e1aw0+81ZOrItXuRqbk/rlxR5lR4Hm1CzXGqE80=;
 b=alVmbskCLa2naGIaq/tsoF9X5z/wMw7RBG4OJXCKvkfMIjWw56qLVnB+kfzaj869Hw
 Q6tm6ysl5Ir+atD6Z17scoyPK9CNOWrsGJHQe1/a2rj095cSiE3NRhIdzxz812od8oc0
 PmzBz79C67LXpkelUDO+PIOmVPFpI+hrqSRp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790779397; x=1791384197;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ExM1e1aw0+81ZOrItXuRqbk/rlxR5lR4Hm1CzXGqE80=;
 b=vFTyrYZ8Y1UAzZ1TIJgsdd/M78EiiHlpIXad3zxSxvNykIchLxpZdqc4mMl9UOGN2e
 bMxwII4vhGRfBWYius63KhRbf1wsDCkbvufH+te6V0NY6vX4YoIxvIwn3vx78mKk9b1F
 0jgBlK3M/qaTl/529VAxdxGB4RAZDvD3+eC0ldPw4WcERCVLKmH37JpZTV8tl4JgIMLj
 PgL32+yTE03gbP3RO3voLhvPwSrRlzFjUK5VEQpgBuB0LH1ZHqw3TokoGahLeNbRGspe
 TeNOqUqux95sa2BboL0Mpwamj7K9bU17jkF2/ahSehD7vJZNrslDOxQ9vBNyngnEInzM
 mjSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIymILBfG8swsj1imqfARa5NzEjoeiRcQ31SwWooP/v+hpgYOiet8/MEavkwkf9jOFfxL8zNc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kXmmYsCEfX+YreOPv61ERo5Gl55ptGdhqIZnug/+cpmiIQYOUU
 TyZGrqZzla98M7IHhDAi0hBqYlUgiJuRJCgMkCw/nUQfuEVjGsqshk/7K3iNHhLzFC14iedPTfF
 O3rSILHjvB+9I
X-Gm-Gg: AYBFou1+HGxCxXGVi++2GEyBLqXy2HFIjrWG18Yqf9CztWTBmtv4GeSsB3IzQgGUgm1
 +qLZtqlJMrAv2HZ7boWaS4NkFGqv0ENsfVh4tRPMXJt910BXfj1DMc8HA9bNT1S4pmxzniPrGDa
 pBNRYuDcOYgYuVfwz5mMqCSrJ7QpAT8tjyZWFvQcOHBU2Cot8qvb9hZsUllzV8baCKlJld66iNW
 p/HljRf9NjMz0fo8+dYRlp/IcRJ390uxJnRp0paAb3JPqe2iBYqFKA4STtfCXzXB90ySoCzwyy8
 cwQHD+OL6N5P5QFA0w92sLBmgjjxZhPt9AJEuYfkfs8xo8JCIfs3o82aMsgMu6svgobu+gJPJRA
 BJbqiHtTS5CV7ogp3KbPQGVrMi4x7zZs4uQPsrntqNZtIA/wdCTnB9PDaXOGhk85JOr2fm4yIh0
 J/HAGWsWJnv0xre+a+voC07ogsfu7tJwyw3I4b3A6jewJCF4eKg5IK71TXZO2ap9IMZ7OlOBLYz
 wFpOiEuw2eC4wVW1jfe0GAYGUu7OT5cnrsHm25tCbDEEAhUBF89JK+D8Qz1Phu89ZCt5glgaAQc
 NoUUrgpN1ekUscF2DcUY/dSADpIkzQ==
X-Received: by 2002:a05:6830:c0b:b0:81c:292f:97a3 with SMTP id
 46e09a7af769-8204a32c6b3mr1570491a34.5.1790779397258; 
 Wed, 30 Sep 2026 07:43:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-82060884b0esm998607a34.1.2026.09.30.07.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 07:43:16 -0700 (PDT)
Date: Wed, 30 Sep 2026 08:43:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 Michael.Srba@seznam.cz, aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 0/2] mach-snapdragon: Kconfig: fix duplicate
 SYS_MALLOC_LEN regression
Message-ID: <20260930144314.GG858934@bill-the-cat>
References: <20260930083339.351584-1-sumit.dhami@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ScAEl4oBIPKj7st3"
Content-Disposition: inline
In-Reply-To: <20260930083339.351584-1-sumit.dhami@oss.qualcomm.com>
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


--ScAEl4oBIPKj7st3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 02:03:37PM +0530, Sumit Singh Dhami wrote:

> A previous commit fixes a duplicate SYS_MALLOC_LEN Kconfig entry in
> "arch/arm/mach-snapdragon/Kconfig" but keeps the smaller default (0x80000=
0)
> instead of the larger one (0x10000000), and drops the larger value.
> This causes fastboot to fail on large image transfers with error:
> "Malloc failed for: CHUNK_TYPE_RAW"
>=20
> This series reverts that commit to restore the 0x10000000 default, then
> reapplies the duplicate-removal fix by removing the 0x800000 entry instea=
d.
>=20
> Sumit Singh Dhami (2):
>   Revert "mach-snapdragon: Kconfig: fix duplicate SYS_MALLOC_LEN"
>   mach-snapdragon: Kconfig: fix duplicate SYS_MALLOC_LEN
>=20
>  arch/arm/mach-snapdragon/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I know there's many examples of setting SYS_MALLOC_LEN (and others)
under arch/ or board/ but this is why I do prefer N lines of default X
if Y in the location a symbol actually lives. So can you move the right
value(s) for snapdragon to the toplevel Kconfig where SYS_MALLOC_LEN is
prompted? Thanks.

--=20
Tom

--ScAEl4oBIPKj7st3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar0f/gAKCRAr4qD1Cr/k
CsiKAP9zyHTLCUrfXC/ZlECiWXJByCdWDjA2VCbz93zC7zlS7gD/dxqklp7IDz7W
CtmmrO46XdG+JBgWxv+2bF1Tm2WNZgA=
=5nQD
-----END PGP SIGNATURE-----

--ScAEl4oBIPKj7st3--
