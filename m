Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD696CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 17:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6514284898;
	Tue, 26 May 2026 19:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LVtu+ON5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF52D847B0; Tue, 26 May 2026 19:16:05 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D184A847B0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 19:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e634c4b74dso1969100a34.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 10:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779815761; x=1780420561; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4GPA7liD30Zvp+MYZTNmGyxLXuzk5LIS6w3KBGIfwR0=;
 b=LVtu+ON5P2q+kio7Ju0mPL/Zu6yp+Ntmt61IZRFNsQA4RY6q6ulkYQ+TCY0UQuDgpu
 UHTVgexK4mGG8XCnErYkdKpYk3Px5FYY5YuTiOpanyju8YL9QmUlweAeQp1EStiNu5tS
 p970RoPluAdJMYTFRMRk878y6AlkQs96fd3nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779815761; x=1780420561;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4GPA7liD30Zvp+MYZTNmGyxLXuzk5LIS6w3KBGIfwR0=;
 b=rWh395R7wssHfKYO4JKQUuB0UPtDeuaWbEIQxXxIs9NXCQMoeBGveytJrxKbuqLQ0K
 Sb6mc4bIv9TMdyJB+47ZQzzm64lXitLw7bzN4BmHioYjmvFmAa494QyJjVJHTpP0dCGa
 Skcr+sacFkMBh9L2XtM13EOulJ9ZK/KQ+oIGCVC6uV/ZflY2W2ykyeJqTHPhda/Ey+Uw
 O6tHLpkEQes5Jz2OGKKOMCEc2cwszbHt2c9sH7rfRlMl34a1/lss2e/iKEKC9addQCMz
 /A6lbus/zwTKvwh4GPd/BX41gKdzdnUhHyD/mleezv0Etkm79uvag4S6270zeNc27sQe
 r77Q==
X-Gm-Message-State: AOJu0YwNalc6A/jDMDugHyGMhIHHjIY1aIEbe5KABKZd98IU/aClPPRS
 Zd2SEdn/yO2G1Cx5+1+vbB7kfufaev0q7AOG3yUteBtLvUcFFm5mvAPaN2J8lMZjkC8lpXj2EJ2
 w9kh8VAs=
X-Gm-Gg: Acq92OHFPhm7CJSjr5QyeKtlrRteuoaXWlkQh+n0OJH8m8hwbZXt/llImK5yTEtm6Ip
 XEujtZW+o9iRQjaLDlw/jgRP0y9wF45ht6UiqZEsVMHMrc/zQ4s2MEZ+pb7J/lpjU0Irab20223
 k4qi7o2jtC2nyjx6TomiQ/P+l9XWHdDZdyIRdbaOOI1wQP/j1hWUV9UzfttefSQO8gP/15BOPo4
 XuxRIEuiP2Qc5I4K+i3Px+imR0rwl576Z79TQeGA+s9HzyrLurb3WJB2mTYucip/yGk7yCx/UQP
 STsxB02f/kYA6dWeDW+iJyon8m96fChZg5MSTDQ8HiYdoC2Vv09UaFnrJBY2LUVIsulVNdWGQ3H
 to9ay55XrJ0rMVezItEG3juGh5UZfi+lgZCrMfId6NzT0SryTnbOpd2Qs8EWDA3WstoWfM0YgTN
 Qqi+ptcI/SFeiaeubvJ3Zoodo2b4bFYYXE2dxaKc5Wm+pO9YN5QL5OyMkZHUa2jykrb9nLc24xV
 rzdaAWOarDKx9vvy0l6wviSHqGMbTf9JqyAZCS/HWuKuA==
X-Received: by 2002:a05:6820:c83:b0:688:2480:7fa8 with SMTP id
 006d021491bc7-69d7eb87ef8mr11599312eaf.21.1779815760921; 
 Tue, 26 May 2026 10:16:00 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83a4db17sm6920775eaf.9.2026.05.26.10.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:15:59 -0700 (PDT)
Date: Tue, 26 May 2026 11:15:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.denx.de, vr@binarly.io
Subject: Re: [PATCH] fdt: Check return value and len of fdt_get_name() calls
Message-ID: <20260526171557.GB1858239@bill-the-cat>
References: <20260522123024.6292-1-anton@binarly.io>
 <20260522183228.GZ1858239@bill-the-cat>
 <CAPWaX56D7qwmjpm97dpRM44BpWAnHEogoEBs-UAk7zDxR2HRoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g8GO0NGNrsU0SgB3"
Content-Disposition: inline
In-Reply-To: <CAPWaX56D7qwmjpm97dpRM44BpWAnHEogoEBs-UAk7zDxR2HRoA@mail.gmail.com>
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


--g8GO0NGNrsU0SgB3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 11:57:40AM +0100, Anton Ivanov wrote:
> > So scripts/dtc/libfdt/fdt_ro.c comes from https://github.com/dgibson/dtc
> > and should be sent upstream there too (and all of scripts/dtc/ is, for
> > reference for the other patches), so that we don't drop this part when
> > re-syncing later via the linux kernel.
>=20
> The patch for fdt_check_full() was added in the upstream dtc code back in
> 2022:
> https://github.com/dgibson/dtc/commit/fda71da26e7fa00966a58afeb2114269b55=
12e59
>=20
> It was never ported to U-Boot, most likely because the function was moved
> from fdt_ro.c to the fdt_check.c.
> Linux kernel does not use fdt_check_full(), and thus it is not affected.
>=20
> We also updated the BRLY-2026-037_BRLY-2026-038.patch to align with the
> current dtc logic:
> https://github.com/dgibson/dtc/commit/50454658f2b5c8968ccd7856d94020c893a=
4be46

Thanks for explaining. A bit more of a detailed rework needs to be done
then, I'll go look at that.

> > Next, please rewrite the commit message to be concise and follow best
> > practices and examples found throughout the codebase. This applies to
> > all of the patches you posted, thanks.
>=20
> We sent the new version of patches with the updated commit messages.

Thanks.

--=20
Tom

--g8GO0NGNrsU0SgB3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahXVSgAKCRAr4qD1Cr/k
Cn3NAQDMW0ij2puEpMzuNaAerGMDezyJrFHvgpQmnyFEcNY8OQD/dWtCg658j9sg
f4my+BMyXyTmceEoeAsDQKcg9LAa+As=
=AWeH
-----END PGP SIGNATURE-----

--g8GO0NGNrsU0SgB3--
