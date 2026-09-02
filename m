Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFF8C624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 16:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E65506079F;
	Wed,  2 Sep 2026 16:31:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nlDD9VSGOpw6; Wed,  2 Sep 2026 16:31:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788366714;
	bh=enOaT3B2KKAu0x4cPtlpMFel6uMlke6SWQZ/czpMP7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QM7VbCb99/5WshfiSnB1wgxcFUbov135wJZe2sHj++EziSlL1r3KDzZT4LPGCl7Af
	 TmFzRE+6L9qheGVw/G/R22B59aLeAxCivNo1qi1WzBK6j5C+62QCCFqW28iZnz8Q/W
	 kd9/89vs4EVPonh447/cD+jI6nXSuJn4FVYcRn86doNGi21Ww+YNicJiqrdMzVO1Qz
	 JPJxkMrU+2sdLtJMsflt/MS0hlq+KZoxxZPn1n8k/FpqCqWV0UJMhSXhzcDz6s6Fca
	 6koOQOyVozPKVBAdNlxKS9ARaCuXO60Xbds5P5O80nE5MZe1MDOQQmmhrXMSufK3G9
	 v08frIwp93lpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32A5D606E0;
	Wed,  2 Sep 2026 16:31:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EA782FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 310E840096
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:31:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TpXbCtzzAqB1 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 16:31:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::a;
 helo=mail-oa2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=kcAsTeT6
Received: from mail-oa2-x0a.google.com (mail-oa2-x0a.google.com
 [IPv6:2607:f8b0:4864:30::a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 522F440070
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 16:31:50 +0000 (UTC)
Received: by mail-oa2-x0a.google.com with SMTP id
 586e51a60fabf-46aed7aea47so417668fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788366709; x=1788971509;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=enOaT3B2KKAu0x4cPtlpMFel6uMlke6SWQZ/czpMP7o=;
 b=kcAsTeT60Lvg+okSSuL+p5GGuhUcfkcZBhsZCqXcZfNWzAd7PHhcmJSGbRo0muKv5e
 UGIr9rdA07y0sA8AnIemHTKAu74dwh+zkZ7g+U40xB8dumi7WQL77AUaM3ImXCQKIhgU
 Y8cgSVw5qW9JAt+Hg22kz0Hyoz9a4hCw3fk60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788366709; x=1788971509;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=enOaT3B2KKAu0x4cPtlpMFel6uMlke6SWQZ/czpMP7o=;
 b=IGCnY+0uBwtqXmq9eN1xVPMvPhbRWA6a99Z2f6yg5p2GRe9m9aQr5dYLms15iBxC8h
 8ZOT1mO8TT9Ko6ws7mdq5DV06kUNKVLh4CuWOhD4pcaIF1C3Nb/BOi5bd0r5QPI8N85y
 vzZOw6MIudYSjWGFu4nPZ+Ulb+8lu0t7uElsxCy93C1Be/eTXrRp+LxWZiLitqBV5PAk
 yWWH49DVzj+MXBD2FojDpLQfGSRwiznEwv5t2VtDiRHnP69NkEPjoBbygntH4Fj5OGSU
 tzhda2BMzeOtH6KPggBu8+GH+rpGSQ3RcMXgtROLECCWjzQ3RhmM/5f5MDCjU9w8aX5D
 hy8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBXz0OZ7M0/r0mlVz97wnYnu4YsPFcZWypgnqMI5A/Z4CL9DY0xOni0EzToR9JlGQWk9Q55gI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++napIKIIKQsc4fUhWf2TAf67OlNM8XCmEuVupI6XJ3MVquRMdMX
 cF3y37dE64BuIB6rCkUxeJsMQny5ZJs4h3FXIiwVGiQCNou3D8aPkxhGljLvp1HBRe8=
X-Gm-Gg: AR+sD13Jz3qgsQop+Io5/kkEFsnv4EKapehSWCXyzDN5AbPBFYuwiW3Kj2FsytQmteh
 teLl6Uq32f+GkLU3+TW6dzYtQDdp56b3xA9u3aukzd9klklWmDwMuSX7sZl1FASLISvt7Kj33ec
 H4qXe4xbvs64TtHoJYCbkLBBMHhw0v1nKdHKIRtrN611Xx3DytQvQQNApb7mpAF7fDirLLymiYA
 5GzzT8eMqeOoS+5TTnktBDCPajSsQOfy1hl2GbAbU/Y8NncmtezlG+H9OAGYhxMsPtK8HeYNTzm
 y3tEBBZN04ogDneLfJDfmzF05QnLqGId2Jrv2+Hpqit5psM0/59Ey+HCq4rat4o9Mqjmo/36jz5
 YPxqlC91Dcx+HzkWGb94rbnWV0BUV9C7b0KmmWmQ7n7fNrKGqUB153lKhQf2vLL6WYPbAyuPG8U
 XcJIzMfnm+FLeZJPRENqEGEbzu5c+BSlgf3wqL+Ovw+Jki12Gb8ErDyzWP3xhARM0VDSQZvNVQk
 4TW2vtRA9P4CkukHAiLhK/csa0s79ip7FbGvcFPuCf+ZxzXkvRYIfiUX2qUJruHW96RTsS+Fxw+
 XGecfLAt4A==
X-Received: by 2002:a05:6808:c18a:b0:496:892:c58f with SMTP id
 5614622812f47-4b6bc235d65mr5581683b6e.2.1788366709487; 
 Wed, 02 Sep 2026 09:31:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b698a34576sm2549203b6e.5.2026.09.02.09.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 09:31:48 -0700 (PDT)
Date: Wed, 2 Sep 2026 10:31:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: naveen.osdev@gmail.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] bootstage: fix unchecked malloc and undersized buffer in
 bootstage_mark_code()
Message-ID: <20260902163146.GD1764417@bill-the-cat>
References: <nsbob67calfo3hn6y23psz2ornx7clha4pvozyify7a2sicqve@gchdniswepfp>
 <CAFLszTi+xSGKG7pmjJ+z0KKRPRXht9h81AUx9tX10SwvhNS=gQ@mail.gmail.com>
 <20260901140325.GD1145425@bill-the-cat>
 <CAFLszTi62jXxPw0zecRUu1jdGt5L1gM3SRtiLsov5TDvT2wtOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JLblhxb/P3fpBYkr"
Content-Disposition: inline
In-Reply-To: <CAFLszTi62jXxPw0zecRUu1jdGt5L1gM3SRtiLsov5TDvT2wtOw@mail.gmail.com>
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


--JLblhxb/P3fpBYkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026 at 06:29:48AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 1 Sept 2026 at 08:03, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Sep 01, 2026 at 07:47:36AM -0600, Simon Glass wrote:
> > > Hi Naveen,
> > >
> > > On 2026-09-01T10:23:25, Naveen Kumar Chaudhary <naveen.osdev@gmail.co=
m> wrote:
> > > > bootstage: fix unchecked malloc and undersized buffer in bootstage_=
mark_code()
> > > >
> > > > bootstage_mark_code() allocated the label buffer without checking t=
he
> > > > result and then dereferenced it, risking a NULL pointer crash on
> > > > allocation failure. The length calculation also failed to account f=
or
> > > > the "," and ": " separators emitted by the snprintf() calls, so the
> > > > assembled string could be silently truncated. Additionally, when fi=
le
> > > > and func are NULL and linenum is -1, the buffer was passed on
> > > > uninitialized.
> > >
> > > Please rewrite in present tense per U-Boot / Linux convention, e.g.
> > > 'allocates the label buffer without checking the result', 'fails to
> > > account for', 'is passed on uninitialised'. This patch aims to change
> > > the current code.
> >
> > Hi Simon,
> >
> > As I said the other day, please stop telling people to rewrite their
> > commit messages when it's already clear and understandable. This simply
> > leads to confusion and frustration among our contributors.
>=20
> Then do we need to change this?
>=20
> https://docs.u-boot-project.org/en/latest/develop/sending_patches.html#co=
mmit-message-conventions

No, it's conventions and guidelines. One should do that. And if there's
no commit message, or there's barely anything in a commit message,
that's useful. But if someone wrote something, and what they wrote
matches what they did, that's what's important.

> Also, we could perhaps introduce an AGENTS.md file, so at least the AI
> assistants follow the guidelines?

AI assistants are a bad at writing commit messages to start with.

--=20
Tom

--JLblhxb/P3fpBYkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaphPcQAKCRAr4qD1Cr/k
CvvmAQCu2mBg3nEetJlpmnuSwd1r5N0+BURRfb6ackmujpSs0wD/ewl+rE6UKK+x
yl7BnPfLiSJZVqO2nBlNKg1t6MmX+wE=
=4+34
-----END PGP SIGNATURE-----

--JLblhxb/P3fpBYkr--
