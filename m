Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3F606A32F
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qIKcQ5zl;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=UVg/uqUj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA3FD606D5;
	Tue,  3 Nov 2026 17:24:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qhIPjkXxfIR8; Tue,  3 Nov 2026 17:24:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 02822606C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793726644;
	b=LCNRrKpv9Xl91Bp0BQuKQ2zeinwuq+V8qYnsmz9OTK9P073Z3FArwCv6jDIQ9wvtdPM2
	 Zm3yvCyWj35zCkWhesdelRmIG5mu+5ioxG/frCrTBJpEoZW1d5RkholqV46ENZvkKQ0LQ
	 Jdr6qhQVoZeNgn+IcaHLoP70bX0iIQtpwa3cE6XHGfnYd2pOLM5z3fjqjhuirbFr/EoHN
	 b0cyRB3vjYJqhuzp93rANLCwhWt1joXMBAVbm4AVGcAb+vOhfSC4kY9B8B3ItYNmG438D
	 WGcGRqijpFnHNASGTk2uNSV80O36elfZejZ5j+DFG07B/ivaJoEbkng318O+VLvusHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793726644;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=s14JiIrCaWtAgfoRP/V/yFYrjFvdhKzF4hbd8rNXXSQ=;
	b=DDLdofOVdKJC8t0RoAkdMSs+Fl+gHHPeK44RP12WTsvAPPsBx4KH/XOszYmQeR9GngUb
	 +FJ02Gy2dN7A3IapKfXisZa4khQre3nfKhrZ5rJ0I9CBu+Kh1kEtESDza9Q4hlUR0JiRy
	 nVJDYBTO6njEUN4vBBPvryXdGv6VZUTEPvx+jQmb4sAHDhQIB2WWa1uKVcAt4Xdk6/YKG
	 ftEfp9vLLGYgMBRj809Ischb62xpXo49fE5tO9gxn3QRz14ZVCRrH90Qvnj5L+Gab2Dlq
	 RZayh8jWPKDiCesor+GMCHd8E0GrZKoPiVr8pKCMXygl+1OAKxoe2PZrNM1JWnGSknQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="UVg/uqUj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793726644;
	bh=s14JiIrCaWtAgfoRP/V/yFYrjFvdhKzF4hbd8rNXXSQ=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qIKcQ5zlI0p8gY/Zi5dwTDwbvdT/J5C/QOyQUsNxYGKgRxAtA8Vq1VXAkcsICy3+D
	 0VDrYkbjkc1bqUvOHHDzCT8yLxlKkJttxHj3olYfuVD1KBWJsWRXHwQOWnVVEeGW7P
	 9iT6DTmUlC72YSThEN3F48+2fCxi2KtpRI1IE85omZpH7Reb9bcSK4Sh4NjyrvQn7k
	 pFImz8OYmp8K7eCL2baY7KlkFU53Jnk5BxDwpni9CfXs6jIlMtZTO0bRyiNYMZOe8V
	 ZolMIOwjgxq9aBL49vJ7DdVN/zerrVFEnlRj1zlXOXjxo5pM2a2RwTrN31mk7VS20/
	 CE4au+cn2LVyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02822606C2;
	Tue,  3 Nov 2026 17:24:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3D4BA15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 17:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B965F606C2
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 17:24:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pCn6WEb6c55h for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 17:24:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D1C1960611
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::7"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793726642;
 b=VBsMxBAoPhjI5okYfCB+iLgN5UGyZy9KwWRFNxXUtY3c6yCbKVgePupM0KM0LnQaM6JH
 z3z8flK5vq/V7p0dvDBdUCXwad7LPDfkhClI7/SOjPqP1wXgbRIZUnK53BvdFfpBbSEPg
 8WI+61dn1EICoMEAMxiA6nYuDQwT+W4CTpw5aJ1oa0IK3fURsT0bwqNJG704TX0x7526I
 Mr+kw6bb5ZN9O3wBXUsTOVZGe5prl4EUVAeNo2x2GDIFhnKYVaeBGxTiw36VjtQHJo0G/
 ukAt4Z4M2FOUrBppuBCPibCx97deY82bC0Hzf6vVSHkDD0h7jFj1sqSZqnK7Mx5XluQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793726642;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Clacks-Overhead;
 bh=s14JiIrCaWtAgfoRP/V/yFYrjFvdhKzF4hbd8rNXXSQ=;
 b=HjtG5A1VbW1TZHMBKpAiJPQfYF5Nr2NX3Z0j6oG/7glpWPQG28D3dfzipnuMTY/0pOVK
 lucmBiTU1hw3belCFQDFqNYgI0DAKOaLnYr4HTO68+/xFuoadZ8B4coug4J0MZy12E6+C
 6utJHj3McKxbsTuFpm484HETdI6GfzZ3LBXcIcAbDTN/cSdqMqNyZlpOjcocHy9DQbfW5
 5QsQ48QVbFifAujon8OYe+EPCef9Na44mFm23MMUbCIFiPE4agQxVYZZ1kXZwmc2+U+Qm
 vEOT5SDVDvbernABACrhEHpbFtG2tVKCnW2lEghJJRPsbFyoUzxv3l+wx7ry4v6z8Yg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="UVg/uqUj"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::7"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::7;
 helo=mail-oo2-x07.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UVg/uqUj
Received: from mail-oo2-x07.google.com (mail-oo2-x07.google.com
 [IPv6:2607:f8b0:4864:31::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1C1960611
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 17:24:01 +0000 (UTC)
Received: by mail-oo2-x07.google.com with SMTP id
 46e09a7af769-8210db80578so1399849a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 09:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793726640; x=1794331440;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:to:from:date:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s14JiIrCaWtAgfoRP/V/yFYrjFvdhKzF4hbd8rNXXSQ=;
 b=UVg/uqUjyy2Hke7kSD1doSLTEAkK9kcDzPH9HtMOuy6CUzxkyKdm0NyJU3dU/5fbKN
 go8RhXu6p8c3GKsC5oICw1UIFZgnM4BeXkWDBHDfDoLL5LT1ktzw1Q6S4d9+kZJ0ulzk
 nki4eyz6H67gET0uEn0mqIxRWf+6ghTwwGeUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726640; x=1794331440;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s14JiIrCaWtAgfoRP/V/yFYrjFvdhKzF4hbd8rNXXSQ=;
 b=q9zocrrcg3XfVf+TAuX/hnpUJYFs6d04YQIAY6oATjmUqSm6e9LzQqE88HfhAzntPa
 CVuqN5dr2sqb+XQzwGi2f/jvEQDOvi28S0GVWjKRPw4SKAJTlPmAZ9rlh2oTNKYSxe3D
 45qW7e542DFUOB1gkjwd5oEdD15RyZNeIXn6D++K+FwhOa4KY79AB2+QLWkWWaD8ptNB
 QDly7iioFTE5ZHRQr5lffnBhtNAgOhcJ69Q/vlTE5bU91pJtE5t2BhaAtvPu/g4sytQL
 kG2yLQOVUWlRvJkfTAahll3/KeZ3ObY2XDd5HwOSXipREwBNod8h9ZApnOdVfMkBMmcU
 9nww==
X-Gm-Message-State: APuU4Z9lUuUzY1n8vHWOvTSdra4i4lOy2oMMxNDDR8TEX5pahj7uuPTV
 MP7xEVyS5DUMoTFxdpQ1lOFDMQRjV7m+kO24zfbCZkDYkZrPD4oPf+S7vBqWDERBhdH9VijjII1
 jQUiddU6ZeWzm+m4=
X-Gm-Gg: AYBFou0meSJumqmvI3mItPcZVXxbHoICU/94YriEb8n+D9yis+jSHf7X02WLO/AlGyp
 SrmIn9kLIIIl8TCBjn0rwiqc9mxRR20Zp3cOHPFDXwAdOtW8JyW0prUImLODX4+PlYF/0aRUv6i
 CX6tHJkSUMcoM9Vht8qtl9kDzeY+wjhMMrrAQkW6/j9RM89jJBrW+//dUSeBygz/YyO1kPynoQE
 3pAzFMCoxy4++rIeAKlPoW4iahqrdgnENLZx0CqPgiHrmOqbv2PYTYVfsM+UsTaD1EhliNWdf5a
 qOjWXzmOQ2rLFHHHfyBnehjR8HkIPQvFJ2eXw33n4O+UFp7ckuGYrKFQr6i8y86IjAKQDlgdnfv
 xmbTo8KbOq2EnGLW1pZQ3enHtzes1hmOgaBlzcCW2CBlHrljjrNyknTQxsCddVsa4FlzolZUMSo
 nEBjK+aAca9P9bWgY+huM4AF6q2z1xvqWPK1PIw5svsgh7HhFeQa9B4uL/xcpU8TJW/7Xw3Sy34
 2BwdFD0jbsEExhN6OiUYzXB8UkfLeJFX02Nte96XxP6RTfRwdrciB5k85otfXHxeViIBb9dQex+
 htG86cKIHJKbJ6wYMLx2hE7z1WXheJ0dRd65QGXJyRzzqTV9Dg2ZsKX16dMm/c9TZbU1V2yM/39
 mMa1t1Hs9kb9L96Mx8FLpz6g9tKV3ZOREiIJf5eUptIbiWkgBWbG2JO6cWD2CRxVGZqI8WWQUIt
 Q5cuIbuvn56KliM+hgKGzoGhgNicmfcw==
X-Received: by 2002:a05:6830:a1dc:20b0:85e:e777:5f89 with SMTP id
 46e09a7af769-85ee77765f6mr902414a34.23.1793726640453; 
 Tue, 03 Nov 2026 09:24:00 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354985b2sm12104812a34.11.2026.11.03.09.23.59
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:23:59 -0800 (PST)
Date: Tue, 3 Nov 2026 11:23:57 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: Re: [RFH] Adopting a Technical Steering Committee (TSC) structure
Message-ID: <20261103172357.GU3309461@bill-the-cat>
References: <20261103172044.GT3309461@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Dp/CvKSOCvByjBQO"
Content-Disposition: inline
In-Reply-To: <20261103172044.GT3309461@bill-the-cat>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Dp/CvKSOCvByjBQO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 11:20:44AM -0600, Tom Rini wrote:

> Hey all,
>=20
> Getting back on track with project administrative tasks, another thing I
> have talked about the project needing for some time is adopting a
> Technical Steering Committee (TSC) model so that for contentious issues
> there is a way for the community to have a group of trusted members make
> a decision for the project as a whole. So, I'm looking for examples of
> this structure in other open source projects that people feel would be a
> good example for us to look at. Thanks!

On this topic I want to point to the OpenEmbedded TSC:
https://www.openembedded.org/wiki/TSCCharter
https://www.openembedded.org/wiki/TSC

As it's community run and has regular elections for part of the
committee so that there's both opportunity for change and continuity.

--=20
Tom

--Dp/CvKSOCvByjBQO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauoYrQAKCRAr4qD1Cr/k
Cu2JAP9r0FtnD+fdOsBTfr87oxM6K+/JzwPYivOGcRiN2b7LRwD9Evme6NxBBN1N
BWIROaAaTErGyntr6XmeyQKItl9Qdg8=
=f4Gt
-----END PGP SIGNATURE-----

--Dp/CvKSOCvByjBQO--
