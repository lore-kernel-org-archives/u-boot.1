Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91960C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 17:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2280B84CD7;
	Wed, 15 Jul 2026 19:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fyDpE2U/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA14784C7E; Wed, 15 Jul 2026 19:31:27 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1090584C83
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 19:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-448b69cfc6dso1354577fac.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784136683; x=1784741483; darn=lists.denx.de;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p3AwCtxFV4MhEpjgkp6hw8eZwmatlrNH+RnwEqSWfXk=;
 b=fyDpE2U/qI9Kzk8BcJZKzXKwNJNSfCQjmsHY1CbRca6OlhStqCcY1u3ereJpe9AT5k
 bUQJyYMn8am74Kf24/TYs8+GHT0F/XDKwZERWMLYhQq16tjW0goYh0ql+3KimJ3F9UWi
 eFCIO4arGb9EB1dMHhC2+E37bm9Fn1cmvCie8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784136683; x=1784741483;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p3AwCtxFV4MhEpjgkp6hw8eZwmatlrNH+RnwEqSWfXk=;
 b=VqWKDNJ+QAA02yPn5wsZb9VP/6ca1w8jvaBRPUBEL8j/7gkcJ0Nn5pGPIpJmBRuLyK
 QNGph2oYfhOsAf28C8/6ShVb5aJ9+55fXY7kO7LT2+bcrWq3oIA2KZRygbCIbL33hXu/
 NlKJF5KRcX+J6ibzWwjj4z4KWpAjFTeeaeZRpkpSL5ZTpnnAXcBLvjiaFSBrJ74xc3uU
 AcY8Eq0ev2vLYbx/cUbcK8TB90uMhPkR7ws1H7LbdJ6T1VIc8+pYqV9k2ap4SCx3oVBE
 lOPdOhVqewI5RRJOdTauzEsJf58INj47HB8fpXxsYi4TM4kwzBNMmS8tbMO1n8M3j9KI
 Vugw==
X-Gm-Message-State: AOJu0Yz73rV69HDO+rd/SCKdli+FuoAgKSDH/el3SavEUz5CEvReDFJj
 HdM/Z/u+cD7BMuq9R2SasndNHyMAJ0l+Mrxu19XTbPfB4BUVAi45I6pJ4Vb24z4t3WXsTq8dRzq
 XqXqglxg=
X-Gm-Gg: AfdE7cmYGUpe9nXX4p8qsprhktjuATDbsY/Tag+t7llKSPz9IL67eeeGC0vpiv4glTf
 Km1nA7DpacBEoH03xxO5TH0OSHRGYDp6pqTLdEq0EbNWrD+2iyo/0bOaH0YJKZDaGXCGlKQAFA1
 BkJJIzVePTlsp6NN9/c2g8J3wTsZhGREWcMA9pCBEwOrDqN7/X45jnCkM/cT51Eafjr2QmRR/CP
 kF9c7oyD5sZM9nWrSkECzzt3w5KmClDLf0Cug2+4Wx/deUI7AkNZwLjdTZGqNposfYYa91iolbP
 DYwaAjEIjae2+bTyoP51ObfIBTsunOHLt6XhM2ai+U59DckWJeOf201Iq5oimqwz+H5OQlCWxb9
 xm3kUG4SWsuIJPwO07SYqmk5y/qq62bzFj/CGfd9tJiw+Tk334/JuaaFEfWtIKC8yIqRer2XNs5
 jrmrbu0tSxUyb+J3ofHpY19dqNVF4xsLMl5IyK26BuRBeC3hi0maTlz+k6piu+Le9WZnTtsdD1T
 fB5t/iN2znxDgZueDOysosst1R3Q+dB0dX7JA==
X-Received: by 2002:a05:6870:312a:b0:43d:7b24:96 with SMTP id
 586e51a60fabf-451f0a8e2famr10171456fac.0.1784136682766; 
 Wed, 15 Jul 2026 10:31:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45191643abdsm19839408fac.11.2026.07.15.10.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 10:31:21 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:31:19 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-board-maintainers@lists.denx.de, u-boot-custodians@lists.denx.de
Subject: [ANN] Mailing list migration to lists.u-boot-project.org
Message-ID: <20260715173119.GL749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lDAF+0aqjkVPfI31"
Content-Disposition: inline
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


--lDAF+0aqjkVPfI31
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

As I've mentioned in previous release emails, we'll be migrating our
lists over to lists.u-boot-project.org. The news now is that we have a
date. This coming Monday the 20th of July, we'll be turning off the
receiving side of lists.denx.de and then importing everything over to
lists.u-boot-project.org.

What do you need to do? Nothing much. All active subscribers and their
preferences will be moved. This includes how lore and patchwork are
linked, so all of that will work. We are going to try and ensure no new
emails get lost in the migration.

Based on feedback from the test migration, we believe we know what was
missing to ensure that the archive links are stable, and so that should
be the case when we go live again.

I'll send out a reminder about this Sunday.

Thanks all!

--=20
Tom

--lDAF+0aqjkVPfI31
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalfD5wAKCRAr4qD1Cr/k
CoS9AQCKIqm4X0NBaOjnaGIXIagQKDPLfehxdzIEcqk5uNg7pgD+LI/tKI+K040W
7OgldI3XM0jjf6+8Nwp/6NsbG443KgE=
=9ego
-----END PGP SIGNATURE-----

--lDAF+0aqjkVPfI31--
