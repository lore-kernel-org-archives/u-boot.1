Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E140CA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 16:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 682008084B;
	Tue, 29 Sep 2026 16:27:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bmmn0lHhmGAP; Tue, 29 Sep 2026 16:27:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 715E080724
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790699249;
	b=gSBaPMKyedXi7aFzKxVC/toArv157PMmF0Zy6ZsVY/tVZ5RLTnSMZJPzJ4QKb1fY3bsO
	 pwJHZT0n3Ou9sQTOfshFA+Mns5Auc08/XVZ2hRogojqqkLeSE344Da9jmrkPzaRhrgSo7
	 1FtG8DlRtx2iqIHeeMi2kHMYVyZKgcWwHw3ieFFliXSL+Vof3Ejwc0a0youXvfYpigrsm
	 uIZ+3iA+ksOp/Sx+6gI1P1qgpIRmtIjByfWsIlsgwdayCdbqbwyGr1/HS9kNdzXLnOsRL
	 OGPmrLcWDPVFS+QhuRf3VnMJQoDxqPj/EDErKO2Jccd9k6QQxjbRcUVQJ7eZUFX57Jg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790699249;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vwZlqPncFZy/CGqXSyLe3XZG4pu28STqkmfFXNaKYs4=;
	b=X6CQkROe3fLU+82kpsdIY8hs+HlzF+EElOBlqRFrvU/0s7Q0CX6+Fx3TCgv4qF6GfaN0
	 LiWrolUJfPXP1cNrnYuZDJC3WxKsnM5DKufwpb4yiw0bLaNS7CTMxDnxfHAoDpeBCD2NZ
	 3BKSjjRmMSwGEz6WbKYKd7muYYAb5UNeTEH/NfU2WNoJ6hYZp5GOgBAU0I88BZoDdBKOH
	 MGEPz9hf7zuIg565zdWNLP+5wmW1+5jXzpxNOxhqLAsCJXSGx1hiRQ5GqiQTN/C8Bczvw
	 Pv2DOY2UVmiSth9JD3vc9vKjkrzHTOUgvVXwQP2XkyUkHfbN27q9DfAtRJYy/SGLJow==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=fBrSr0NH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790699249;
	bh=vwZlqPncFZy/CGqXSyLe3XZG4pu28STqkmfFXNaKYs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eP/4aNQ6qCMhKybxqUomgfolyRWg3O7dw38h86gKWIlUOU70eEp1pkmNjU1C/AgOy
	 2/a5u/bAd0RYm44LryjrNOC9Tr+jglIyF6FmFdQETygP3IDwgW61nyMXjwyRWke7x9
	 gjO6XQdXnCeNWMyqgRtD4Slllr7yjNRo1go5rkmGmbEuOaW/bgu47HjCJR7brWYsT3
	 WrpOhcR4KSiYX0w9023Y7VFWPd8h44tj1A2tHA0OPAOZGrDo8iG1Me8HbVD0rRK9nQ
	 ipuLWpceo3/zFVMvliUyV7jhuWzAIlNw5QGkxgUUFD2zRbWA+nFZkTwgBXEWYraMef
	 1LQUG2rk5bPQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 715E080724;
	Tue, 29 Sep 2026 16:27:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 125D572
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 16:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EBE2F80724
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 16:27:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9OJwqwHaU25k for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 16:27:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EE6C08071B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790699247;
 b=eCH6DVd4/q3q2XQbPtqeZkrRp3GJtmBFLNnw1dGV43wQUMHtDXxswwBIz5Rkcjd9VnAc
 jFwWwhjFyi88v+tUngng7jTFT7L3QZYJ95qpdhO4a1+/stV30gIM0Yfkj5R1c+YksGCS6
 eDhWZ4f3ZUtOcXLVVM+hR9WT9TkIwPmE/JfGSytXo6yXaQdt53VWhJDm2+ANj1VrLY4RX
 sXrUGYSdbwZVkHWM2L8KIMNomECK3VqA7SuC2sEVFeJrIwfRylzecPuw93eTLKhGmyPRR
 40sRkZiPzAj0TnHIYhtCOWyfDGqVLfCp3KdANt+Q81SS3PenkyLAUvTorZKxZLQROsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790699247;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=vwZlqPncFZy/CGqXSyLe3XZG4pu28STqkmfFXNaKYs4=;
 b=Y8rLu8+2MlSuG4tbKKkBxEXH6IrlabEg8ypXdJgTm2/vYdFVSWJmUvIvCs3Zas5EWBPS
 UX4hYtVPV60fsNaOCvSvL133xE0C//57G8fm0HeLvT6fs0mze3bGPbxofmeiaGQRl/tF5
 0N8qGpB98UfgKUvRBvXU/7bMUarWDq+pvcquWE10dzfLGLZLq5sRt7llmMXGN8rryaLcH
 rsnhVbejun7QD3c9JNLsW5ziOU1ebJEtOm7LClqj6sIPNKORE5bYYxfVJk+8EjmRsRwV5
 JGuMEUL78myleOeGUWVozCBF6Og3PWocr0Pdg2RkpBvd3jHJ7ZbEQuThnuMGIGewdcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fBrSr0NH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::a;
 helo=mail-oo2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=fBrSr0NH
Received: from mail-oo2-x0a.google.com (mail-oo2-x0a.google.com
 [IPv6:2607:f8b0:4864:31::a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE6C08071B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 16:27:26 +0000 (UTC)
Received: by mail-oo2-x0a.google.com with SMTP id
 46e09a7af769-81a7ff792f6so1518777a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 09:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790699245; x=1791304045;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vwZlqPncFZy/CGqXSyLe3XZG4pu28STqkmfFXNaKYs4=;
 b=fBrSr0NHN2AnUb/E6hPV1bG8hh0BsvMnGCErt5OU/E+EK8r8O5kkKGMJycIZ5iESmR
 z/m51GsBbMwjUqu4Hc2Y2x26Vcrl/4KCStiS8v4ba2zWS9gLzfVoSXowtgXflZE3nxfa
 af1fuB80vrR8iafjnTmo04Jz9eufkFjhn1Fqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699245; x=1791304045;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vwZlqPncFZy/CGqXSyLe3XZG4pu28STqkmfFXNaKYs4=;
 b=2vpTfnUEyS6N6k8XS/HLt5I64Gd/cYBuQpXps2uyOwcrwTX7KEMD1b9HJQni6WsasG
 KYoAYgtO+QvacaphBCdt2c6rE8m2DU0TY46hSg2Fy2k53yNvmqx8NzA2juUT7E1e0uTg
 ysoiiHhz52U2yRdBOwL2Hy1bf844XX4/7A4UjWKs294ga6RyjyTVlYkiY0VUBU5gUGB4
 gwhN52EQ3A2cZMe5crEfeH1osZLtREypKVgO0OyPKOdt1e2KfU7DndCgpA21d/3xclhF
 PAfNkusiLPN8GsdUtkJfeFFDmRZBNVqkuYmcmW0Sudjnk9NxagTwEb/2ZG/rN2uAfESG
 qSQQ==
X-Gm-Message-State: AFuF++nGYKvROV2Bmp2uBVLo5REyZ/wZ8R37R3waBBkd/w4I4A+RFolY
 mPI4a4FiG26KOhmJcnH6U/9ulodc3sSoTt/HelSTW0t4NOAMfq0racvXnhHdmNwkVM8=
X-Gm-Gg: AYBFou0HJJA0jdcP53+V7lk3ZAUG50UzBmMdvuS5+cWtg/6+W8asZIsbztIN1A4O+7y
 YDqJWVo/QtEdVXqZVuc4g7CXAboRVOimwSshjuP5UmTIjq/IPh3TLCMnL3BhnVR0l4rQMjM0j/9
 iXTDGz20G979lG1+TQRbKFHNEruhIglo309J5A4GQWP25gSe1lcl8SqRz9KGaCt5KbsfkyQnkYI
 XVZnJJMsm66N9fABJqELU126mJ2QcC0CSGkufVBxvOPXTjJ4iLcoRvAmtklA795X7FNk55V0Aax
 xDsT8tY2jOqvJMhSHunoPq4Pcs5BdraNUo8gXarBayE7TUea/En21rYE1K4qw2DMdBlG++ZFJ3K
 Wcjm4eyzZLTFcLRF1TX7zRrQf7Aa0JYNBWNft4cnt201nBmhFc1XhKftiklkfDsnH9UYjFnLp3I
 ivfPrErv+5U2E3OYBZe/HvjpcU5P0xS4PI+ooeZx/LNVE+XmZGR8kYYNQAVOABRchUYXkJTsNB3
 O0wuvHusIsumCXUdGBherHUO5se+dX852TXdJtJwCgPDZ7RjjT2Pq6u97tFgBVtWzhkWPJODJY4
 FqhPR8lJAgi/GPoSHuU=
X-Received: by 2002:a05:6830:4492:b0:803:a631:1658 with SMTP id
 46e09a7af769-81784c9e8f0mr17615199a34.24.1790699244670; 
 Tue, 29 Sep 2026 09:27:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81fac9fc959sm275204a34.3.2026.09.29.09.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:27:24 -0700 (PDT)
Date: Tue, 29 Sep 2026 10:27:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [RFC PATCH 1/4] net: lwip: add an httpd stop operation
Message-ID: <20260929162721.GC858934@bill-the-cat>
References: <20260928223532.482192-1-sochnev.v.74@gmail.com>
 <20260928223532.482192-2-sochnev.v.74@gmail.com>
 <20260928230004.GY858934@bill-the-cat>
 <20260929162535.56966-1-sochnev.v.74@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rWHtKOVkA7iAHtbs"
Content-Disposition: inline
In-Reply-To: <20260929162535.56966-1-sochnev.v.74@gmail.com>
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


--rWHtKOVkA7iAHtbs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 07:25:34PM +0300, Vitaliy Sochnev wrote:
> On Mon, Sep 28, 2026 at 05:00:04PM -0600, Tom Rini wrote:
> > I'm a little wary of adding code to upstream lwIP here. Have you
> > submitted this there as well?
>=20
> Not before sending this series. I have now submitted it to the lwIP
> patch tracker:
>=20
> https://savannah.nongnu.org/patch/?10636
>=20
> It applies to lwIP master as is and builds there with the example_app
> warning flags, with and without SO_REUSE and LWIP_ALTCP.

OK, please wait for v2'ing this work here until it's merged with lwIP
upstream. I think the comments on the U-Boot side will be fairly minor,
and it's about making sure this part is upstreamed and not something we
worry about long term. Thanks!

--=20
Tom

--rWHtKOVkA7iAHtbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarvm5gAKCRAr4qD1Cr/k
Coq8AQCPR8Sv07+Az3ruCFnxIqLk62ZcgEU8h2Ks/D8RUYFSgAD/SxQsxlIKpx0V
Wp0zxoab7gi9pGhMZsG38/RKZr2CGws=
=aTFl
-----END PGP SIGNATURE-----

--rWHtKOVkA7iAHtbs--
