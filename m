Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11DB60A2609
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xm0JJl37;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=l8tPqVe1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70FBF6071D;
	Fri, 20 Nov 2026 16:24:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wKZ-WX62iaBL; Fri, 20 Nov 2026 16:24:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9BB87605F9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795191886;
	b=W+U+gCgg5c2cqUZWdnbcYDPrR7g5fQn1WTL4ZWDmVhLGCc/6w2pREWlS5x/Anhm+AfWe
	 q5yVIVdqUT2GmpbypqIYSsGCOwt60H2gJKEfd5wk125r6Rl8y6Bw1jJHrZHHv25HJ6Fh+
	 zLMYSn42kO98N65SjEnRoxiLPafUYyDyzLhIXMvt7QdiPqJ2d1GFH6cGy3gn3ar4fBDn1
	 gi5tNC+/pGOTJ+OvPr1OebDrb1s1JaDmz9eUWWVRPd6l84S1vkXBZcZVsmi1ThbysD+xN
	 zKGJVENnkIVhVCWaQILpENfqAce7rf7C7nuETQi/czMvLI8Ryq2sC/KYlJxNRGHIKVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795191886;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5nUuKnHRccSHB7/PIMKRK42oxNVLw+Ptu0Mj45NNVi8=;
	b=l2Sz18yz9l/HbhZm+0B7YYWLOsf6/xPrKl0mVcgIxPelKyo4RUPLvWmMhpmannbnxHOn
	 AdF4t1RHgGp8ghNPmieiqAUxc3vsazb/xO5K5QEZpV6jBLR0ammIy6Q/K4sINnLBo+m3p
	 QrQM4hdqu5kowDSV37hb5K+gi4X0d6+80xSmiChTsk2Lk5gaP5i+vCmFfFfLWXTJQ9X8u
	 ++AbGJCpRBFVmWlRnstA2Mni/PgtulTDhNV4WGPTz4q6szR4ul0c20k+RVcVtWhHZYjVd
	 STsfJmxJsjjkDBHkI0ZHKSA9oAr6EMu42+jFuzc2XKEg0NPLq88KYNZWegYfES8uceA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795191886;
	bh=5nUuKnHRccSHB7/PIMKRK42oxNVLw+Ptu0Mj45NNVi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xm0JJl37bXtmU1qU7IFqMh9TG7yaHOEvr5JqAZlOSmvavWXYpaKHQhIaOpQ9mwUlL
	 uH3GZMZrOF4Khf7P2guetRe3NYKnN7RaZ+QGxqjWTh+HpknlgE1wGwoLi3DyLU64ul
	 vzkQHVI8o6LoPJirbfOzAR2iVdisis8QyD6aMAMNmyBRAjioD46uoqzPgE7oha3YB1
	 D2K3RSklPlY8HvM+XTgRvapN3RUNVuL9SOD78hEMsMdZY8H46Rd9b3Uv/YkoYvpc5x
	 hm3I2oHc06QLS6tfJinyKbrVrZTGh1Kb9B5MkAMe4sG+POrczNfDUOJHSVSPi5EOgI
	 orl1TlI4FTF0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BB87605F9;
	Fri, 20 Nov 2026 16:24:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A0E39E22
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92BE140098
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:24:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k8yNCDcvdiKU for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 16:24:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A7FEE4004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=l8tPqVe1
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7FEE4004D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:24:44 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4ad60ec5eaaso949494fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 08:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795191883; x=1795796683;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5nUuKnHRccSHB7/PIMKRK42oxNVLw+Ptu0Mj45NNVi8=;
 b=l8tPqVe1zs3yP8+JA2Hwbs+RbtuMZL12OGSvCJABdfi1I2QFugon80pH2GoHjmUTfX
 g0wbfWB8mVU4ugqSS28SFChT3HbC1nrjve6VwveZuqRqwEMWL70AD8x1xt+eVlxVIuco
 jgH7XQ9RVHYvyBtEi9yUk0pD35V8Cr+69V5hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795191883; x=1795796683;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5nUuKnHRccSHB7/PIMKRK42oxNVLw+Ptu0Mj45NNVi8=;
 b=0enrzzHzuq+Z+mtdV82NxtXIyAH0iOuZjjBSRBwTHzQg0clm4GA+38x5AhkkO3Kzz3
 FvlG99Jy5FUmXxUQaMOPM6HNlKic8xT1qzIGouR2jyGsuH6vl9SbsbYaAQUobiDYFzHp
 KdPlTEuwj9Zeaxt7LT+plCHI1YR0EqVj7v4VQxa7U8XiH6t+kNtIkydjG+BWCTt/20pA
 w/Uywd2i4j873pLqS2fKjmokudqlvmpyZCshwzvZbyLFRyScNGNHXdJRc2BWOUwunvoB
 5gzn4XHGQr0B0NGHnll43S0PMKoi11hG7QAD7Z+ed2uejduuaGPeYNBWDWG3kLFob9cp
 YumQ==
X-Gm-Message-State: APuU4Z9EnYtZ/YYtUdKfGzPpkuHT0oFm5BjwPciQ8AEF4QAZiL3kkANy
 dHb7b/PTwUR5YiMIOv0qVSUzxRyzdEAPNI9mVetZFqMc3mhYRYJcsO4OBg38nhtG7W4=
X-Gm-Gg: AZFdTZcllkbk3kv0+ZnhxC/Hg7/FplTFSVV37tDOvNHfc3yuRjPPo1uUOdH0Q6HsW9T
 GwUWuY+2uNLDaO/s1OqysJc22L0+n4PxApaPs9IL/vAap02ooNpncwqP0aCXz7ENlJmM02QbqDg
 y+J6KjlBo4vt6myJEBeBXOj12sD8qWyiK/p+u4IhfI+OPyxQUDzWw6HakcXzxmHeTTew1Etaitb
 rU2rVLIdCKhIhaOssDQdZ2GcbAqcHYNYTblbNyoN6xEGF+q6LKM8jUka1lWzqxwhjUhXy7rKOYx
 bMO4pRN6rnRigo4BjyAq0s0kBiMpo73vUAQ1BxigbCLvnURWegtbKLmRbZgIbnVKU9aTbl7vv/2
 zovnV6gmGc6FJOSyVmVM21zIOf/5pomLYiuf489xH3mcHkYu/MoDLRQTjLm4exSy5vvU056EzAe
 g/+pX92x2K8ln3SMhJbgKeQ3Q9AsnyB6cRUQ98byZxl4xVmF91W0c3OZN2bUXtCsVXAtCOmBudx
 aoXEFMz/14fQKwmsw1SEBEuE/Qx0CQY9Vsk3qglB/jEYIGcAf6qPx6+QQynhVAYBETXcvaW96V6
 pfKqvvD1b2JGvtgXcJqTMA4Vj6IFgYslirg9h1R8YY/3T5HXGUomVHFlGMeeYzsh3yM7EhiNVK0
 dI8ZZiPLE/Bh5tJv5NnnMKj9RRbeJNC+zDMmiunsfq0oxpA9Swra7UyWSL35rXQc4rXKtNNjac4
 AxrXDErcu3Szq0CpbqtNz3/++TfBWraxk=
X-Received: by 2002:a05:6871:3409:b0:49e:45d6:4a99 with SMTP id
 586e51a60fabf-4bc8434519bmr2375222fac.19.1795191882939; 
 Fri, 20 Nov 2026 08:24:42 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5ebdc0bbsm3075730fac.6.2026.11.20.08.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 08:24:42 -0800 (PST)
Date: Fri, 20 Nov 2026 10:24:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.u-boot-project.org, alpernebiyasak@gmail.com,
 philippe.reynes@softathome.com
Subject: Re: [PATCH] binman: pre_load: add sign-size parameter for partial
 image signing
Message-ID: <20261120162440.GF3176972@bill-the-cat>
References: <20261120153626.51467-1-paul.henrys_ext@softathome.com>
 <20261120154058.GD3176972@bill-the-cat>
 <9a1f82e3-e4e0-49b3-a73c-62ce34ff7f9b@softathome.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oc4ktOYlZa0BEDlj"
Content-Disposition: inline
In-Reply-To: <9a1f82e3-e4e0-49b3-a73c-62ce34ff7f9b@softathome.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--oc4ktOYlZa0BEDlj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 05:00:12PM +0100, Paul HENRYS wrote:
> Dear Tom,
>=20
> On 20/11/2026 16:40, Tom Rini wrote:
> > On Fri, Nov 20, 2026 at 04:36:26PM +0100, Paul HENRYS wrote:
> > > Add an optional sign-size property to the pre-load entry type, allowi=
ng
> > > users to sign only a leading portion of the image rather than the who=
le
> > > thing. When set, only the first sign-size bytes are hashed and the
> > > image_size field in the pre-load header is set accordingly.
> > >=20
> > > This modification is particularly useful when signing FIT images whose
> > > data are stored externally to the FIT and hashes are already
> > > calculated and stored in the FIT header.
> > >=20
> > > Assisted-by: Claude Sonnet 4.6
> > Our AI policy is currently "Please don't", and I do owe and have been
> > half drafting a longer write-up on that.
> Does it mean, don't use AI or just don't add the prefix?
> I saw some other commits with AI assisted information so I just added it =
as
> well.
> I just pushed another patch after reading your message. I will also corre=
ct
> that there.

That's part of what makes it harder to write up. Yes, it's "please don't
use AI", and also yes, some people don't proactively disclose and of
those some content is clear enough that no one would know if it wasn't
disclosed.

> > > Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> > > ---
> > >   tools/binman/etype/pre_load.py                | 46 ++++++++++++++++=
---
> > >   tools/binman/ftest.py                         | 41 +++++++++++++++++
> > >   .../pre_load_ecdsa_sign_size_too_large.dts    | 23 ++++++++++
> > >   .../pre_load_rsa_sign_size_too_large.dts      | 23 ++++++++++
> > >   .../test/security/pre_load_sign_size.dts      | 23 ++++++++++
> > >   5 files changed, 150 insertions(+), 6 deletions(-)
> > >   create mode 100644 tools/binman/test/security/pre_load_ecdsa_sign_s=
ize_too_large.dts
> > >   create mode 100644 tools/binman/test/security/pre_load_rsa_sign_siz=
e_too_large.dts
> > >   create mode 100644 tools/binman/test/security/pre_load_sign_size.dts
> > >=20
> > > diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_=
load.py
> > > index 7890c1c62a8..3612307d4ab 100644
> > > --- a/tools/binman/etype/pre_load.py
> > > +++ b/tools/binman/etype/pre_load.py
> > > @@ -53,6 +53,11 @@ class Entry_pre_load(Entry_collection):
> > >           - key-name: Filename of the private key to sign
> > >           - header-size: Total size of the header
> > >           - version: Version of the header
> > > +        - sign-size: Number of bytes of the image to sign (default: =
sign the
> > > +          entire image). When set, only the first sign-size bytes ar=
e hashed
> > > +          and the header image_size field is set to this value. This=
 allows
> > > +          the runtime verifier to authenticate a leading portion of =
the image
> > > +          while ignoring any trailing data.
> > Why does this comment need to be almost 5x as long as all of the others
> > for this function? Thanks.
> Here, that is a typical abuse of the AI which is much better than me at
> writing English but more prolix...
> I missed that and will sum it up. Thx.

I figured as much. And I really hate the notion that AI is better at
writing, in part because I keep track of how often AI hallucinates
(rather than questionable translation) over on my social media, of the
few emails a day I throw at it, to see if my own understanding of them
is correct.

--=20
Tom

--oc4ktOYlZa0BEDlj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawB0SAAKCRAr4qD1Cr/k
CvxbAP9+vR+FbcwXXrN0uovrGwqZ028In7Ub9ly1cv8FAHkNYgEA6+MF5Cd5vkXo
N/AU1JQG58Pnz3+gYq16kpg+nF4gvws=
=CjXe
-----END PGP SIGNATURE-----

--oc4ktOYlZa0BEDlj--
