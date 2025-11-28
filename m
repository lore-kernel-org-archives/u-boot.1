Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61741D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 15:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2BF883A94;
	Fri, 28 Nov 2025 16:42:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XmUFk1ih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC98283A9A; Fri, 28 Nov 2025 16:42:55 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A4983A84
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 16:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7458B423D2;
 Fri, 28 Nov 2025 15:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F9DC4CEF1;
 Fri, 28 Nov 2025 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764344571;
 bh=Jw32sk4sMStcYCdcDftOQSULMhvg5H2/O3M502lGcCo=;
 h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
 b=XmUFk1ihjOBIYiC7RxPofdPxHWzHdUURthNaDWfVgep4zNkH5CJcRqvfuC0L7lHrD
 lXnLbU7DHtpEBkdwm+7wRjy58DKZm/oe/0pgPsHG20eCVgiWrnruR7nwbHrXv6UvWb
 FF9eoFwQZPsJK63lcUVk47E8KPngmitx3q7rICcG/O/J2RqqDSY56prQ0c/dtd4nv9
 mnK921c1Kgu8x2oOfrXQorx21n5oJJhdYHMVi6OZPXErRSAzxC7wdAfGreoHKFstPU
 JVHUcGgNVYqTMNZI7asFVSDIVA5NKPWCYz0m9p8izqLKI9LqA2AkTIzg5tokrHbmJU
 m8WGBSTYawIvw==
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=103f938a2ca98f5479e64b84a5d8f716e96b122133522135ccb107dbec1d;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 28 Nov 2025 16:42:46 +0100
Message-Id: <DEKFY8IBC6HY.3RQ24ATKNPJDU@kernel.org>
Subject: Re: [PATCH] arm: mach-k3: j722s: Update SoC auto-gen data
Cc: <u-kumar1@ti.com>, <vigneshr@ti.com>, <u-boot@lists.denx.de>
From: "Michael Walle" <mwalle@kernel.org>
To: "Chintan Vankar" <c-vankar@ti.com>, "Tom Rini" <trini@konsulko.com>
X-Mailer: aerc 0.20.0
References: <20251125094639.1754402-1-c-vankar@ti.com>
 <DEHU1N85F4DN.3W3VX01XHQTCH@kernel.org>
 <4c468d40-4d4c-4acf-a758-5b9b88963b90@ti.com>
 <f23f1568-fc01-4a39-acc9-5e99ccab9876@ti.com>
In-Reply-To: <f23f1568-fc01-4a39-acc9-5e99ccab9876@ti.com>
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

--103f938a2ca98f5479e64b84a5d8f716e96b122133522135ccb107dbec1d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

>>>> This patch is based on commit "4a4871e3dc38" of origin/next branch of
>>>> u-boot.
>>>
>>> This shall go into origin/master, no? The issue is present in the
>>> v2026.01-rcN.
>>>
>>=20
>
> I saw that the patch is already on top of the origin/master branch with
> tag "v2026.01-rc3". Can you please add "Acked-By" to unblock it for a
> maintainer to get it merged?

Not sure what you mean. I don't it's up to me to ack this patch.
FWIW, you already have my tested-tag.

-michael

--103f938a2ca98f5479e64b84a5d8f716e96b122133522135ccb107dbec1d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaSnC9xIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/i5BwGAnuJ6aRYgjziu1HWK0o8iReRI5bRm1ZJG
eqyOkHMFfsJcmMSg32rBpyX9IPZbw4Y8AX0aWr/WT8IrrpJ4PNHv6MaIt80ihwqX
Bw/r4om9OIcFd/gOgw0MVFp+/nGBsrhOB0M=
=Qjtc
-----END PGP SIGNATURE-----

--103f938a2ca98f5479e64b84a5d8f716e96b122133522135ccb107dbec1d--
