Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434BBC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 15:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E23F9870BC;
	Tue, 14 Nov 2023 16:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CrBpWpnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A20B5870DF; Tue, 14 Nov 2023 16:46:19 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30BD886C31
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 16:46:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41cd8bd5727so33367391cf.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 07:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699976775; x=1700581575; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Sp9EEckgxrYVsMnV5Kvp1XpF2AH0j9gcx6negVNDJyw=;
 b=CrBpWpnbmz5V8vMZkpSGkvSEO0GUn3Yp6A/wBpfASjBtggZIRg5jzHqIk5Yu9DMyEg
 yJf6qn8mxJVQS/7q3I3ermMYvHBVClwTKhu6VA10i+WArT+YkLUFMvR0nI7/5XFYNp1k
 1vMQmn1BxS5ZRT7Sv1c4A4u8/8hpEF+GXHzHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699976775; x=1700581575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sp9EEckgxrYVsMnV5Kvp1XpF2AH0j9gcx6negVNDJyw=;
 b=X9hUI/XHzERPo95Pq2CDCW9vHIgFNUgH7tbtp0EsBhbqRSOtvwCHP21CfTUgYdFRCj
 jlHe5F7/m+3KCHKlkOhWFpY/NIibrkz+b7i//d4k19r6EVGdfeyobyD1FIhRmkPvmQPQ
 Nv/PdSBFH7Up9Ncy1UstrfKsfhSg3TPHKd0LMzsrgviCJHIREXem2zzWqr/7LiFQdYKQ
 ztzsFX7PVjcUTCJpfCrQcD/yAEVavCdLhIQbpB8GD/nYoIv5iSVvusEySyIgxZVH/eba
 uZbLlerLPhH8kfSbLH1tEB6srmFjn8rskp39cVY9qINTlcnewr2v+4mgP7Se2xDUBk5H
 Npcw==
X-Gm-Message-State: AOJu0YzLNakA4iT7N3P24RPEL2TtJNB7eNJT9/wBHldqXQAKJWIiAIxj
 7nLBaIHnwoX0nGvWSxT7mdPKAA==
X-Google-Smtp-Source: AGHT+IGz8NQDdqSMXVQyX7aSdoVN7adb0yF04SVl+DNjJrxL3xa7e7qWAKq2gwcxqSlADM/e2WGQuw==
X-Received: by 2002:a05:622a:58f:b0:41e:3c03:a7da with SMTP id
 c15-20020a05622a058f00b0041e3c03a7damr2509575qtb.1.1699976774739; 
 Tue, 14 Nov 2023 07:46:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2a5c-a31a-8ead-8e73.res6.spectrum.com.
 [2603:6081:7b00:6400:2a5c:a31a:8ead:8e73])
 by smtp.gmail.com with ESMTPSA id
 h15-20020ac8514f000000b00410a9dd3d88sm2784098qtn.68.2023.11.14.07.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 07:46:14 -0800 (PST)
Date: Tue, 14 Nov 2023 10:46:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH] doc: avoid using deprecated sphinx function
Message-ID: <20231114154612.GR6601@bill-the-cat>
References: <20231114-b4-sphinx-deprecation-v1-1-41687254ad8e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yzuTpC/kAsbV3EvC"
Content-Disposition: inline
In-Reply-To: <20231114-b4-sphinx-deprecation-v1-1-41687254ad8e@linaro.org>
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


--yzuTpC/kAsbV3EvC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 03:18:02PM +0000, Caleb Connolly wrote:

> The execfile_() function in sphinx has been removed after being
> deprecated for some time. Follow what sphinx upstream does in [1] to
> avoid using this function. This fixes "make htmldocs" on at least Arch
> Linux but likely other distros too.
>=20
> [1]: https://github.com/sphinx-doc/sphinx/commit/9ced1e355ad6baecd4e755a5=
98a54877dc0aad44
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> base-commit: 92b27528d777ce85362af45e7d2974a6c856219b

I think we should cherry-pick:
commit 0283189e8f3d0917e2ac399688df85211f48447b
Author: Jonathan Corbet <corbet@lwn.net>
Date:   Wed Jan 4 10:47:39 2023 -0700

    docs: Fix the docs build with Sphinx 6.0

=66rom the kernel, to keep the file in-sync. That's the only commit to
load_config.py since I believe we synced last, but there might be other
changes in Documentation/sphinx/ to grab as well.

--=20
Tom

--yzuTpC/kAsbV3EvC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVTlkEACgkQFHw5/5Y0
tyzr9Qv/beJvfu4itXN7c+6C2AUELTC5TmgM736RG8wf+5uSJlgWE2C1iQEhhNsZ
wM9UdY1Ic3sXsyuxiMWYkr3OgdyJlPlImO+RNHVuPbtT2Ymn1iUR63bE6X6XpMlk
i3gG0GEshSjkH8xC0sBLFK1vfNmNMGyQm+isDnj/eMhS4djzjSAL5ysecwna/ebS
dOLqnQpf/b9o0JgO80mYt7h8PkyYTA1gv+ZzQeWWeFDqRJ8T449RwrD0zgkpnITn
jp2ZuQ30mJDpH2kUCTyrv5mhpbiD5uYbwzJmdpHvUpga6ei3jQjrRsqLbh+/C5rx
ruEZcyk6xN9JzXJuNBSXC1kuIkqMn06UjXswwutfxQ6xTl+W9d6gSREUINxeQOSB
4fgc56K9p6gLcm+TrWi03wFVVH7lqePdrO52tNNSnaUc1p6GtSVO4N9X3vj7dglh
zUWVm1bUyutCv6DadAK7LCE98FowpCtPVm1IGU4Vg0mEo4H5kjrpkeVsMCoyqSng
dGMNEGy9
=Pe1r
-----END PGP SIGNATURE-----

--yzuTpC/kAsbV3EvC--
