Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874B1C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 14:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3A6B809D4;
	Thu,  1 May 2025 16:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CM1JSJDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF4D80BAD; Thu,  1 May 2025 16:06:23 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35563809A5
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 16:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-606648c3f9eso260719eaf.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746108380; x=1746713180; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b7E+jajHP4oYeMb2zPVY+OFGPNVpw+IG4fwiKapZ5eE=;
 b=CM1JSJDelCnirnWV9BoEBI01iVzBfBgy8joiI86QomsCnAg5uRWgAd33vkxtcW4J0c
 c0j7l1Y//AEJhsOLFKI/czlUX7WS2ezEsaB8tGS31og2wBDAaBfMNp+hAwDFBCtGwHvs
 9+92QuhUa8CyfLf/QbOIXIz3IEbEcEnfBxJQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746108380; x=1746713180;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7E+jajHP4oYeMb2zPVY+OFGPNVpw+IG4fwiKapZ5eE=;
 b=pmCm8C5C3Au/qTGG1MypyQQK7quBruA5hzAaTyXFj6m8tlinE8jK6HrAukrVk2aaWz
 wccs2IsGXA0PNrimlmD4IymO4rskdCbY5x2gchfX8zXPbZ3Wp7tYu+HSgLkqFMnCd+DP
 /y6ghCpT7ygBMTnnBrS8+Dd1eXxDzqwH3fVXYe2xuii+Ps040JSswcCkhKqXuG6dDt65
 oIAP7ThR/sN9V/BZVmF7+unEPGnuLMVq8ee2ajEEJnnKQiYdsIvD0aSD4OSMgSWYAGy0
 JXIYOI3iWDa+aMy22T2wKRke+ExTt03aQ8xORLUiVGY0VYoTldWW+L4ocV7Tm8z9a4HK
 Yj3Q==
X-Gm-Message-State: AOJu0YxYpkQ9m/b6W6Kt9UcHsbX8RxyNjm7OgHW3UsjqSFs7P+QNJRBB
 lyW3r7O+5MloGA65ohc6Iai6PJE8UsnM4FuD5pi7nGDWyyeOQQa9YvIbBMExr5Y=
X-Gm-Gg: ASbGncvUa62cfl6SC/yC7s31bR5a/f8gjagz3/nWeopWvrXlBZhdqoFfF59Tmt+cz/S
 VE6V5dLAZbULb//PV9VaWx8Zmhp/zXvZmhNn9cr48iJpGVwG993WJQ4/xvtGCxR6yL6rbn6SqeM
 zvYu6ho92wjzp2VC9hCEM6CD29ZHdIIUXQOWiIgiQRC1vBp8I/s5ISp7fpcKAj8uGmSiN9wTWq1
 l/s0YzcnWavgHAGKzaKw3hj90gTIaeIdF1/A3Y9px1Emsj+6RBpXsupCb4ccEdkqvMihZbW5wkL
 PXjWi8KqxI4kso5zzLRK4Qv8HiIJQXN5H+D4M71An7v5ClzZJk+9hJFA73F+fjD0Ueiv/ue6TXR
 wPQ==
X-Google-Smtp-Source: AGHT+IEFATmECkFQLaJuVGNlopSOzy2DuqyllVRjwSWQZ3uVNZKGPiP72n/x1LO09Z/0JoS6cU0nQA==
X-Received: by 2002:a05:6820:c95:b0:603:f1b5:ca0e with SMTP id
 006d021491bc7-607e0d25129mr1628479eaf.3.1746108379961; 
 Thu, 01 May 2025 07:06:19 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fb6fbbsm120995eaf.32.2025.05.01.07.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:06:19 -0700 (PDT)
Date: Thu, 1 May 2025 08:06:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oliver Graute <oliver.graute@kococonnector.com>
Subject: Re: [PATCH v2 02/22] congatec: Include env.h to permit reading the
 environment
Message-ID: <20250501140617.GD1261075@bill-the-cat>
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zoUb/DLzSN2HLYAr"
Content-Disposition: inline
In-Reply-To: <20250501010456.3930701-3-sjg@chromium.org>
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


--zoUb/DLzSN2HLYAr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 07:04:27PM -0600, Simon Glass wrote:
> This file reads from the environment but does not include the correct
> header. Update it.
>=20
> Drop the unnecessary config.h while we are here.

Are you sure about that? It was explicitly added in commit
ab61cc7d98f6 ("board: congatec: Remove <common.h> and add needed
includes") probably because of CFG_SYS_... usage.

--=20
Tom

--zoUb/DLzSN2HLYAr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgTf9kACgkQFHw5/5Y0
tywnUgv/cgZCaYg7nrELh7i0poZRSqvWxTeFTmwPfSqqn4G/IzyoWJJYffzuRKy5
YgoUo2K2BlNBTombUCfiBt9tpb6/k54xJGAI+W/Mo2sMLyf5cofaZzV7KUphXUjZ
Gsz7udQfHOfH8n8f89puGTXACLjIjI2YaiL5FVyUuSRVsxpIhTbzV4x6nojY8THw
Sz2NPZ4gLbWwWxass8tZfOfFiEzNyH9ih2tc4aB6vgiH9o14/eB8SvS3HqCus2LU
46vUrcZd0kUwzoCx3GhByQULAOc0rslkFFvqMdLKz8vTilUOBYbJLtvLjIhLrh1X
etfpg993mZOxG+hy9W01U/8PVQKVtP1VzrYDyi2S3TPlco5uqYMlP1iz5LxymB5g
/reZjJjHfkBBIruBqJc3jFvRiwihs3+0r1xdQnlb+l3qwDOn3sGRjV29RYf+sSQE
srs5GKGwyuZiStOGSZkKs/PjeRKn9kO6vpUQpBbBlKuafLP6iPn42sOzpPcpk79C
1/w2KiHs
=z5Ad
-----END PGP SIGNATURE-----

--zoUb/DLzSN2HLYAr--
