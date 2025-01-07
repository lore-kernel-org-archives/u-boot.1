Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A66E77188
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 00:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3586805F7;
	Tue,  7 Jan 2025 01:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bNAPWzWE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A8480600; Tue,  7 Jan 2025 01:55:51 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 661B4805F5
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 01:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b6e8fe401eso1248425685a.2
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 16:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736211348; x=1736816148; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iRiDkwqbQTV+nPOMDQ4AkRECDkU7d1lUlMgXQUvekkw=;
 b=bNAPWzWEVsxWfgm+wGkSGOuQ6aEnNT/Lr9DJbU0CtfX8rQqSbXHKNZpnfsl9ozXpEn
 SnpgNy7rXmTT/jFlMyHxnX4IBRHhNWLwEXSxKkdL+AcDdR4BRL0I5+2GOtXfuloZCMfp
 xLPbmTKHSjC28U93xgkANiIkON2uGkuZN35S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736211348; x=1736816148;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iRiDkwqbQTV+nPOMDQ4AkRECDkU7d1lUlMgXQUvekkw=;
 b=vvotJx2qthzwMgu5OvxeAKDcoeCciiG65VorBzNsCl8pLgY7EYzq0fXjXLkG0GNvTQ
 1yNaSa+NFtLgh2uv4CbKUIyvLp3DdDR98KvGYaJoUUHV2lH6wshhUfq4XKbvRKxeJRgG
 1Sk5KoYKAjbN5LxcytuGGqrp684Bi1QCevJWqkVgSC5r0G2nvsNyUnIUNIojGELhtB0f
 8AabiyN0nrwOXuYWE/RG19sxUHxiUgpZnTNWXl1TXzCrjKEd3MQ2zunTz0l5YWaR/wyz
 pQ2w7Rj5qCe8xnThlsfVWhRsQSq7rPrbc7DLz0o+mg90g/DF645pzZSegrM3z+vGg+wd
 4xjQ==
X-Gm-Message-State: AOJu0YwAMtA8XmYLCCrpE9Qam8JHId9QQFfLTYuDJMghUV51rp2SGBzz
 bqn56+tN4etLM5XpgoAAdx7JEsORH1XMdR4aYJwn57sbklQK8Eh5KUi+Uhp5zeTNKieVLdiXadN
 +
X-Gm-Gg: ASbGncvduL36aRI49h8eVq1Dd128bkyCBEkDPD+vpsO3YiBRGmcKhm4QYjsDTA0mYPw
 c2ZlsDdfuko6GgqRiVMoAup48BBN01hvA7E5SMXhgjD1kjx5U/OFFhhRMIjEIgcDVMMkuWbSnMD
 2Om3uUv8fL1w7VM1UkW/cUVwkh5CZ+9wgYghcfU06Qov9b88mCmUqGEOq29N0o7CHXqNPaIU1oh
 ZKaBDEE+qzcWQtiGsLVHL1zucZDk28sgIQ/i/kCdsUzMXEWvLjsSAM=
X-Google-Smtp-Source: AGHT+IH2K0kshLvUbAKGkbxJRKaj2jlWWx/7yXwou5HErNJgEAuIvwHR1+gqYdGpnt+6J6GGJ5oUow==
X-Received: by 2002:a05:620a:29d0:b0:7b7:ab7:ef1b with SMTP id
 af79cd13be357-7b9ba7ec372mr10651420885a.44.1736211348222; 
 Mon, 06 Jan 2025 16:55:48 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e6a6d1dsm181076501cf.45.2025.01.06.16.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 16:55:47 -0800 (PST)
Date: Mon, 6 Jan 2025 18:55:44 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.01 released
Message-ID: <20250107005544.GG3476@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EZZ4S+f1gtU10cIT"
Content-Disposition: inline
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


--EZZ4S+f1gtU10cIT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's late in the day, but here's v2025.01. Note that this isn't late due
to any issues with the master branch but rather because I've been
bisect'ing a stubborn issue in -next. Our January release is always
tricky due to holidays, but the extra -rc may have helped. We won't
really know I suspect however until much later this month when even more
testing happens post release.  I want to thank everyone that's
contributed to this release, not just in terms of code, but
documentation, testing and otherwise ensuring things go as smoothly as
they can.

In terms of a changelog,=20
git log --merges v2024.01-rc6..v2025.01
contains what I've pulled since the last RC or:
git log --merges v2024.10..v2025.01
for changes since the last full release. As always, more details in
pull requests (or the tags referenced by them) will result in more
details here.

The merge window is formally open again. However, I'm going to hold off
on merging -next as I'm bisect'ing an issue there still and want to sort
that out before merging. I'll post about that on it's own soon.
The v2025.04 release is scheduled for Monday, April 7th, 2025 and the
merge window will close and -rc1 will be released on the 27th of
January, and then the next window will open with -rc2, two weeks later.

Thanks all!

--=20
Tom

--EZZ4S+f1gtU10cIT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd8e5AACgkQFHw5/5Y0
tyzIAAwAuI9vR+XZXKFjCxOrLuImOUOULiOEvvOAXJKocJdvhGxbPeJD+vsjX31z
5lCMFq8ClP44dPmbsr1BhtVMTfswDYKeoeTSE3JjePMC+4BGndDAB8qqyYY5xyuy
tQ0zvGOTGr81/XRZ6jcZMlEqiKwWa7isYKlp/Oo4vCs11NWg5Mo8qftHRYxgL6HG
PLkWOuSF8lrXRPNRdgCgJVbRsOyy2DRfxzfK2HeoJ6ZnQ8n5wZZyzqIR46+eBngm
68jXHbgYdE2bZj7DS/kerfk9XzQno6ODUVAE+iEO9bTauzTMS/w/H52twOL/tKBf
0dEjwzdMaqLeYT3RFA13/OLTyNQiqJj8mRzvvMdaJ8wphsZrhHTUqEvgOxDWtcqP
Sipx+HDwJIw5ctZB79RwkBlPe47UEsm8Rk/WTVI156arfE5X2f72kBdTRiOh/X91
oMzXlLJL/DEtweWADeAuiyhL+I/SvCLyr0uor7LtsViQgzcANWfEJTvuO547OKY1
7Rq64p69
=53Vg
-----END PGP SIGNATURE-----

--EZZ4S+f1gtU10cIT--
