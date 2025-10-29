Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F90ECCF9EA
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 00:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB43B8382E;
	Wed, 29 Oct 2025 01:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NFn6Vle6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B9183826; Wed, 29 Oct 2025 01:00:34 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D741D80422
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 01:00:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3c972dec6easo4440551fac.3
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761696030; x=1762300830; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GtHsGAvSLWJn4UAA2ClKllv7SHmLUK4uRP/aNrdBcm8=;
 b=NFn6Vle6mT2g+h7mba2xd187OCib5EcFHPtzyDt1thBhtUJiKFVd6iTxpLs6/fIXKj
 h51lxM81XnsCBDkhK6VbqivkDMIbmR+DRbnZRcK6DoYDGystQYDyGs9gkg3D8Fv/ajQc
 UwI67oTrZmWKviaWSSWcktlg6G63sTZrCKCFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761696030; x=1762300830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtHsGAvSLWJn4UAA2ClKllv7SHmLUK4uRP/aNrdBcm8=;
 b=KALiXluNDFjnrPZ1pp0pq5wU7kigigmca+4fS7sEak3IH3Va8qEeoAGLFuvaO0uOw3
 9sbO+0g/BbXTHX0lGM7kqfIpZpdnfZU1DIS1Z10EuNbN8vhCf+GIGzaP3lU9kiUhD+qe
 ttP+tdjItrDR5iK80rTHoUuHyG1+2boZbIbPpU8ooO0PMzkJgbkLPvis3dAkeWU0v1Xy
 AW+QFCAc8O44qqYiKAriL7FKRqUMddxZbe40Wt3tP2voY+CVK1eGsWx/BPWp3ltlsZGP
 7dZl7DunfewqlOpYSewoa3DNkF7vzq3p6OTzVLnYKTM573JeE8o5F7QFpPY3LcovAm4O
 kKKg==
X-Gm-Message-State: AOJu0YwtFhFWPRjPUP+ikTF98Rx8CVKYpyK+WijtW86vQKSzFrg1ASAD
 zx3SSTU13X6pD7WRW6eQ4c1X1558EyDDwM1t0JQFC5SgbkvjyIRFUyjpgbI5IDUwkUFoobKSFdy
 sSziTy18Q5Q==
X-Gm-Gg: ASbGncukFHo0pjztJAOwH0WfXP+XvWF9z4obDNbN36UBQXHWSMe6Hte6oMIPOYU47X+
 V6CtUNmKOcueRHrCypqo4QZTjmVyYZjXFa7r8H+q54i2AWyCwN6+rDEfj4ezHYqxxRmP1VjgWDm
 Z/8YKxBtaJYg5MKVGbRe7qJrUPI/+ZhlSiky7gFgysxK872hAJPmMKd84A2y4Nc/GQFL7BdYdbY
 B2nLMzKhq6QTF843olD6JGBicAvJpbwVyhIh5LDzhOkrGvIqYsKklTu7tzU9F9K+1PliKDhMM70
 +3CdRcOMXK/VCe0i4VxrcVxveZhiSK0wSK1lhv4AWcE7OW1Ay0z485l0sD6Box7olnqkLl8hOos
 L6nmvR1wYp258ykjHDSyAmAIVqGYInboiKyHnkvBzCTf+0ZjtwT1azDMeXpBj567kyN0H/uBjMK
 83ABuDKskKxaTahdRINxRHDg07C5CUJmSWNyJCJez5bcR5yRG4rA==
X-Google-Smtp-Source: AGHT+IEolw1oizo3Hc3YO0A9L9oS0wTYoPDjZBFSijw1apBvcOEToAGbhSrEbKuwOIAvNnvPho2R6Q==
X-Received: by 2002:a05:6870:8132:b0:3d4:4c81:df37 with SMTP id
 586e51a60fabf-3d7432e3bbdmr756519fac.0.1761696030565; 
 Tue, 28 Oct 2025 17:00:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e2816dfasm4087887fac.8.2025.10.28.17.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 17:00:29 -0700 (PDT)
Date: Tue, 28 Oct 2025 18:00:28 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 2/2] spi: altera_spi: Add missing <time.h> to altera_spi.c
Message-ID: <20251029000028.GJ6688@bill-the-cat>
References: <20250804215719.1413106-1-trini@konsulko.com>
 <20250804215719.1413106-9-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="weQ3jb7EOg5UPFdf"
Content-Disposition: inline
In-Reply-To: <20250804215719.1413106-9-trini@konsulko.com>
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


--weQ3jb7EOg5UPFdf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2025 at 03:57:18PM -0600, Tom Rini wrote:

> This driver references the get_timer macro while relying on an
> indirection inclusion of <time.h>. Add the missing include directly.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--weQ3jb7EOg5UPFdf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQFZGwAKCRAr4qD1Cr/k
Ch5KAP9orZG9Fx48D1p7m9rS7okjOqFxfeisd4e/g6ucGs5GhgD+K/oR6H9UYJO2
j+SCSUJu0nwVZs9vMAX7mTC+9B4wVA4=
=t1y3
-----END PGP SIGNATURE-----

--weQ3jb7EOg5UPFdf--
