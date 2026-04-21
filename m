Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ED0F8FA90
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B01842D7;
	Tue, 21 Apr 2026 17:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M3zY36/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73527842C7; Tue, 21 Apr 2026 17:03:56 +0200 (CEST)
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com
 [IPv6:2001:4860:4864:20::43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E9B78426E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-40974bf7781so4158930fac.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776783833; x=1777388633; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IMk81LFlf7FQjw6CT8/14s96Gie58P4uvxCE/fHWaqQ=;
 b=M3zY36/lLEWNNilWZrktdzuqj+c6a+kJdiXG82YqN0CZaENM+jKaAWxJEKpTXrp7MA
 KJnZ03kdS54ejgMDTLk8TNtzFqqa8oU9oSjCyGsXksOj4jOVFTO0ITGHrKKZ5JbWZ4qX
 pIXRHH3t09DWJ0d8nvte+oHadASUkWHFREm7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776783833; x=1777388633;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IMk81LFlf7FQjw6CT8/14s96Gie58P4uvxCE/fHWaqQ=;
 b=dH983OA7udGC3BxHa5mBMTf+LvWeh8pzFjEfh6RSmQruec8ByAoUnqp5CazMbNP2CT
 4NS5/d8OMCcr4X7wJtkt4nnNq6XsqREGjuX1XwFZEKt+OVieTrviOVlfw6O+4RcDEaWX
 P/D8Q/TKhqrAbixGI8QlLVxW0rJMbEK2Q6jEZbr1oyDIu1he0mJ2+9Q9sFH5axp51ce3
 5L8xw4IUMflricnN60UHo7njG+oovL4xWmW5ouQmvoHxyJtMO8K5jKoEZ7zfO3SyVuUD
 s7GloVy9Y+Nrb8qI8Cvy7S+F3UxAzhqkk4H+xOS05DVxdhYNdqjQXLXYWICR/AJoTl0B
 g5yQ==
X-Gm-Message-State: AOJu0YwdWjHPP6/7FBmYd4NVH/QfuR56IYY7M05gKDZjJFWkxsZU+NcW
 H9jcz6B8SYE+KoLICSDqcHnmf/UoYEa3IhkBruIygQB5kIqYsacyOajl1QBouzs6BfU=
X-Gm-Gg: AeBDievkCoyE0amiokwOoH5uDj+rqzb5wd96YKx1ey4imBGfphY0ZebW1icjRkEPCTz
 2gvwKlFMPlmnmguIiBncA7DCdgHvTijSXIIBBmGiwob7SY1afzBiz7FNwHgIObESHjBeBP1W5Dz
 z2pJCmpVPGZJuV90VkAkfWSGSJCFAVyUHrcqjFJ32wRG1Y2dI7WO9iNIRZQSzemRtIcik0r56U4
 JXUIfv7efdELWYZfaYlkgOcwOLA32GgPud7gxczyZ2+MazypcaFzxGTrJ2eei5F1jLGDlH4PTCL
 q2kZ0qph5VW0FlunsHtBapXkpDW+h3PBs/Ds8MX7H8Ij74NrNTqkByTzWdtPb5RDQ+By6VaZT8e
 zfy2KPyWBjI6OuCYlFZPtDTMHvxmbYdOWL38YDvwQdsIlwcVzf7MtiPLhkDNfP8hEa0pQDk1lqo
 x4MR3FkVK4m+pfWBvyjc9gJkip1koQmRdwzp8Tx/Ky8SF9D+rcOrxMDmpEyce4z7yJ5HPjZ4JRA
 TY/0pqZWJYqIKxv8kwgZltX2ZObiXXXcITr+mfSzR8+ycASvH8Sf0BEnoFqMA==
X-Received: by 2002:a05:6871:68a:b0:404:2e44:18b6 with SMTP id
 586e51a60fabf-42a99adb2cemr9570556fac.16.1776783832360; 
 Tue, 21 Apr 2026 08:03:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9304b7f6sm12161579fac.1.2026.04.21.08.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:03:51 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:03:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 4/6] bloblist: add API for applying blobs with
 specified tag
Message-ID: <20260421150348.GE3036003@bill-the-cat>
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
 <20250718141621.3147633-5-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Red5/wZGPR3Q5wYX"
Content-Disposition: inline
In-Reply-To: <20250718141621.3147633-5-raymond.mao@linaro.org>
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


--Red5/wZGPR3Q5wYX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 07:16:17AM -0700, Raymond Mao wrote:

> Add an API to search for the blobs with specified tag and use the
> hook function to apply the blob data.
> Add a helper function to return the inline header size as according
> to recent spec[1] updates, the actual data can be following an inline
> header instead of following the TE header immediately.
>=20
> [1] Firmware Handoff spec:
> https://github.com/FirmwareHandoff/firmware_handoff
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Red5/wZGPR3Q5wYX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeeR1AAKCRAr4qD1Cr/k
ChGHAQCqPGXDIVVIu5DFpXSQNcpWxoELcee4ToMRMm/wIQA7QQEA52L8ozW5Rr4k
M8T9ZwuF8H8+6jQGKFpdpht7n83JsQQ=
=zb6Y
-----END PGP SIGNATURE-----

--Red5/wZGPR3Q5wYX--
