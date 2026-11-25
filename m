Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703F606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OVEBPAv3;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=AL8KHM7o
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E929C606A0;
	Wed, 25 Nov 2026 21:35:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DEmyev90iDM8; Wed, 25 Nov 2026 21:35:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1F98E606D9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795642519;
	b=LVur4F6z6KfxjLxh7SHSzdsPe5JYdndEurCBHitSIy5xyfzzmNDMk6YFYckGMtQfvK1n
	 4ogcxxqQAnGKj5oH3O+V2HtusvI83FoMYyF9r+rMJm+5UIXGE07Gy4M36U29D1oWhzGHs
	 o8xz6RZApmgz/5o+vo0zXV7v+4hWh2RkSLTiWV2YCQb5w+MzjIBJgehYQdP4FSQE/ksW5
	 HnkvuQORyThgX5hHl49/QtL4Zt9HIhwdAZxicU22nJGDrdgfEVpWNv/sjCGPun+hY0dq+
	 /iXsHMS3ZFjyV1pY8llIT0THLpwEgYpKmtBubf2HvkmsP5jZXu9Czq0LpQj68l9iC6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795642519;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KHi17JaJjW1gFLw959TkRkQ7oUy6mR7iPFHjvdWu/SA=;
	b=gE0wBhgnHWj3Os2jczr1wEphywmf8UekYl1D/FdyUGsPCIwQZGGxQKj/HuAdKiRX5WpC
	 oe6159/r7JNo3oQPcMRRvuNNv8IFRPqlHW9JWZ42BNavMDXb279TYyGzgTjrOlXzJL6de
	 zitqxOdB5ZxYhQem6KfZDEkPIaMMiF+mPNtQB4OXNiRkLhExrC+E6QUejx2xoBK7vAX70
	 cEe6hYVIA/rrpZufXzKpFbo8sOn7gOQ/gxDSgcCDurXey9I6YrzYNcvGlUjBdDVqxQcXD
	 GjebO88I5SmNL/ScM7FHinfUs+J28GZcx/TOP6eyEa1GBfAwavVkc428vHOCT5DWaNA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795642519;
	bh=KHi17JaJjW1gFLw959TkRkQ7oUy6mR7iPFHjvdWu/SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OVEBPAv3B9SXOGUI1267EHEiBaoHh7IxXcvw7iEFkTFvD7m9GIphEsZesTMAbI6CM
	 3/dqrkaw6unF3zLBzF9zt0CI4JArf1X/IdqblFPqMfbUF9z2SXZHw1uAJsF6sEecOZ
	 WX6065DQD/C2XzLs0VpqROyZY+h1aUkEGPh2vwyRwxAnbUOZgu/AZAUNq1fZe1p7P4
	 WhrGhS973p+OUKJnoFunUVMS/KXWJwKxZn22dQHWEpEoX9UKY9AcywQ8g3rHE8AdpK
	 +Xu1inbAUz0EwO5mSfqhZP+wa3CR0JCLtwU/RD2izap8sR2hrsI7na6pzFBtEGYDhu
	 cDTqs5joCwKeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F98E606D9;
	Wed, 25 Nov 2026 21:35:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A8BBD26D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 21:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A3E980BD6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 21:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XTcgNVhMG5C3 for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 21:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A83F780BD4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=AL8KHM7o
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A83F780BD4
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 21:35:16 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-563a0462094so3067953b6e.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 13:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795642515; x=1796247315;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KHi17JaJjW1gFLw959TkRkQ7oUy6mR7iPFHjvdWu/SA=;
 b=AL8KHM7okjPfmKQG50T2lB0kL7viklgjfPzPxVTz+V+isjSs/w192H2XfYgC9GH6zH
 +MiZgW+rYewkBjHTp1eqbjxPmkdxAA4MSHJ4T/fbp7CAW2Wq95Srqev5PSgldf/RbFx1
 p+0y+i+7B2/M8tSWLVlpvd8nEcN92RA5Stcgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795642515; x=1796247315;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KHi17JaJjW1gFLw959TkRkQ7oUy6mR7iPFHjvdWu/SA=;
 b=IMrDJx2uqEGM+rfanOwTifrkr76pRHbGzAM4K/QtXc8rUQWVERBgeS960dCStUvzAD
 Y3KVGoljO47gm2ZJxX0DKtAb0nzM8rb0JzSO1Pdqa6Hv2VerRqgyA+6x69FCtCxys8KN
 jv0VoCPU/KIrT9rn7mLmX3QB1FMpuo8lhl5LRjmEhgNpMyfr0GsThXrflA8+FkZXehUA
 XGAObOZ2K0kugHLB02YZshN1xwBKExpMVfBUeZuX9jWAAAD8U8GFyW4sdsqThkKIYrkZ
 ygu+iXeNVf7+60zyoDl9fKdNQ/Z8KhqR1hBVqA/LOgG+c4wuR0IIq06nX0D2rmt9lAY4
 jWFg==
X-Gm-Message-State: APuU4Z9ThCFCrVBxHci3y0+1XFy9FcmeEOiWXBgd+k1GT6rPoVkj3MvT
 EGvR5q0bJivrs0GRpRmVMEe1elUpjf7YFmv5LY6nkHe2woktJsdtWOuNbNm0ZKclvebQTKDlX8w
 qjHCDEVyRN60p
X-Gm-Gg: AZFdTZfNj0gLxTZUh3opWzQM1nIHPyex0+fPfgQCUaoLmm7p9XzcvgNT5iaUoOVaioM
 5Dnj698veUQDDKUQDHWPqS1sQvDHLCh2x5bUCAxFK4jMsQh1ru0TzNeUABW6i3HrDnEVUBsEWrL
 7yXFW7Ts+l4LK0uVBhdsZAsBNOr1fkxZb6tk9hfs/SrajQtcHCRi2RwXS17ViWekA4jBUqIcIl7
 4c/Vp/Leo1rNqEXok5i+18mSoV+u56Xy/vejY8VysvYN8wUdoajLRyJ/aJBzHi0EFR2Jpu4gCt+
 Y0hxEakBRs5e92lpoht91lW2eU1cuPbB+2niXdodvumIyqH6CQiZHvQQOQUO+fuCDrXAkazfn2U
 hDPwBiSs9AsLRsRe+jnhzoZTFMPszhYa3KCbAtnl50xDn5G3WtS2HISVsKMcB23/pOzvBQTrMB3
 HZIawSPb7M+RIkW70t4CokX+LURXGZRhpnlFhJVgeNs60bP3rGAKjFROV332awdiCskhrpSbBJp
 lR1R9u49SOBMLNH59VNzEvljOkXiNVTVZiU1VinQ+ZEPsDRVglzDMxhyv0FQefWZ6U6mcXl2U6N
 CvghlZp9mbEKiFs8uP2eUVBok2J2oHTdFykn43CtdhDmMS9FcAFpq8L6tBffXVbhYXXOAGTBWMe
 a0YohmBwe1pnOqvQ1QzRIGW2F6eQQfm7ED6DdsjDIi9X99rsJ28qXFVDNqCMWB4MUAQE1k0vZmv
 D25qKdWQ8bpEym5df6IxlVEtdkDCqmdfI=
X-Received: by 2002:a05:6808:6902:b0:4d6:308d:4ca7 with SMTP id
 5614622812f47-57a09e0aa4fmr22370380b6e.24.1795642515165; 
 Wed, 25 Nov 2026 13:35:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34763004sm14188782b6e.8.2026.11.25.13.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 13:35:14 -0800 (PST)
Date: Wed, 25 Nov 2026 15:35:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH RFC] test: Add more tools tests to CI
Message-ID: <20261125213512.GH3176972@bill-the-cat>
References: <20261123-ci_more_tests-v1-1-52e9984f42cb@linaro.org>
 <20261124190931.GA3176972@bill-the-cat>
 <176aef67-030d-4ba8-84f0-da7dcab3b091@linaro.org>
 <20261125144235.GD3176972@bill-the-cat>
 <2a31beff-c1c6-42d8-9697-acd4cd3b57d4@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9CixXqHcbuVlP//0"
Content-Disposition: inline
In-Reply-To: <2a31beff-c1c6-42d8-9697-acd4cd3b57d4@linaro.org>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--9CixXqHcbuVlP//0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 06:20:28PM +0000, Andrew Goodbody wrote:
> On 25/11/2026 14:42, Tom Rini wrote:
> > On Wed, Nov 25, 2026 at 09:47:19AM +0000, Andrew Goodbody wrote:
> > > On 24/11/2026 19:09, Tom Rini wrote:
> > > > On Mon, Nov 23, 2026 at 03:19:18PM +0000, Andrew Goodbody wrote:
> > > >=20
> > > > > 'make check' runs various tools tests that were not being run by =
the CI
> > > > > scripts. Add the missing tests to the CI scripts so that CI will =
be a
> > > > > complete super set of the local test runs such as by 'make check'.
> > > > >=20
> > > > > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > > > > ---
> > > > > This patch is in response to Tom asking what is tested by 'make c=
heck'
> > > > > that is not tested by CI. This is the simple answer that shows wh=
at
> > > > > tests are not being run by CI. This does not claim to say whether=
 these
> > > > > tests are actually useful or not.
> > > >=20
> > > > Thanks for doing this. Were you able to push this through one of th=
e CI
> > > > pipelines as well?
> > > Yes, although it failed on a world build due to lack of disk space I =
do not
> > > think that is related to my changes. For the purposes of this PR, to =
run
> > > Azure CI, I based it on top of the series for the 'make check' fixes.
> > >=20
> > > https://github.com/u-boot/u-boot/pull/1087
> >=20
> > Thanks for confirming. And yes, I had missed it was disk space causing
> > that part of the build to fail.
> Would you like this resent without the RFC prefix?

Thanks but I'll just grab the RFC version.

--=20
Tom

--9CixXqHcbuVlP//0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawdUjAAKCRAr4qD1Cr/k
CnvNAQD8XTlwvJmYL3A9pFHadRTJIFhpALXkCnbsLof1rpCkwAD9F5goU7urEywb
CVr7n+r3Ov/UDNiluS5h+Up+5sb6mAA=
=XPwf
-----END PGP SIGNATURE-----

--9CixXqHcbuVlP//0--
