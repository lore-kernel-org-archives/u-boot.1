Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C590C7115C
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 14:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD8880E9A;
	Fri, 20 Jun 2025 16:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oIti4e+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB8F182CBC; Fri, 20 Jun 2025 16:21:05 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0566480C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 16:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2eacb421554so492835fac.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 07:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750429262; x=1751034062; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G3l+MVAqfMjWx/zbtNQeqdrvI7UyYIZgntipe00XPtA=;
 b=oIti4e+DWlUF7VrWnWGWo1x32moaLgPEClLOgCgqWrCxOfMVEnJAgNvRWXbE7SebVk
 jI6OEEXT4Jtr5pgPVpWKYgVxs9r7KAVU2FRFsWfn5hyqa6c79CWVrIV6BN9uuOFgr99v
 2VlRYDOVwgKyWT+6b2oLn/0a9yk8Bc8hOHLLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750429262; x=1751034062;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3l+MVAqfMjWx/zbtNQeqdrvI7UyYIZgntipe00XPtA=;
 b=DVsYRxl9k9/oHzqe1HdCNjpLndtQiRauBBof5Qlo6h85RiELjtc1DSzJlqUZ9Ny1Pi
 +qkB2Mp2ga6ZnY8bU7cyE3/GX24IhwJgHM586IDKTXzD3pMl75cY4VB8piHauO7W3Sy1
 GTn3565UhG8DPWYnlldGtqOPWjhxxjSePOjCsizZL7EsGJB4EbFdIiFdCKKnhts+SAUm
 8+PUllrCWidC09EpEmrcgUu44M8EG/dqbV0OBsqid1Oh0VeJADMQGE+kaDZxeuLVOKpc
 MC8oGgTuA7roYo8z6dXmnwVnf0d/BjsqTqJALdF0VCtJVefnFsU/sxR8Nb9UI2rdw21E
 jRrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL36e02x37siutvJeyA0ttO7RtJUgoHGd5JregK8T+bEvC7CsCjNsLs0uY9D3f1AuE4nt/sY4=@lists.denx.de
X-Gm-Message-State: AOJu0YzzGCZ4aAkNk/CwANoi0kOy15a6neaoxDbUTS5Q66sjAUiwcvO1
 KXp7rIHrzHlE8vUvno4QuzRN323AzvV/LkAn9P8g7+LbAi/0M1EM4byoJtqcwAfvNQyfwiS+X6g
 AZFd0F+0=
X-Gm-Gg: ASbGncsHhL0TmQZ2/4yS7qFkSLigleq+zqbIEuwLaWCxE8yC0JtuZtiGkolc54txndG
 Mzd7I79VPmdTkKcZthrYCwaGciumwviB2Vismd2itfBI+zEnXqvooLc0vzTUZPzIV46wcGF1JjG
 zusxLc4P+gMC3FIGp7NboSMH4Ek8d8PjmDMzFzqLtbgYX41k7AZKbGmtKbQljpfnePCxNrFDGe1
 gTFC52XvjEfFYbgtGkztTFJtWcuj0JWHdN6TTA8kdTRxPecAT2+Z+V0D10x7HnmZNK3SMifbQKL
 chyZ/eKLeoLRGj98N32FxAFhiG3SlXNeQ1LcvxmvFDIsEb3sTV4Ue6ONPDS3znWhYKMBO3oJin5
 nDJCgt2mCd+iuNMQp25k1V1A=
X-Google-Smtp-Source: AGHT+IE9AfEmtv+N1c5x1Kwsq5I8w0kjcVevuU3uu56fwNe2cT++JRj9Z4ycQHsWMy9bxu7r/5I3Bg==
X-Received: by 2002:a05:6870:ac27:b0:2c2:4e19:1cdf with SMTP id
 586e51a60fabf-2eeee4d9ac8mr2203671fac.25.1750429261593; 
 Fri, 20 Jun 2025 07:21:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee664c464bsm403845fac.1.2025.06.20.07.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 07:21:00 -0700 (PDT)
Date: Fri, 20 Jun 2025 08:20:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] board: samsung: e850-96: Fix MMC devices in EFI
Message-ID: <20250620142058.GJ216500@bill-the-cat>
References: <20250620022556.10363-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nrgu9IuU4+XYmzwg"
Content-Disposition: inline
In-Reply-To: <20250620022556.10363-1-semen.protsenko@linaro.org>
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


--nrgu9IuU4+XYmzwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 09:25:54PM -0500, Sam Protsenko wrote:

> Avoid using MMC in board_init() to make sure disk objects are created in
> EFI subsystem later.
>=20
> If it's still possible, please take this series for 2025.07, as it makes
> EFI functional on E850-96 board.
>=20
> Sam Protsenko (2):
>   configs: e850-96: Enable BOARD_LATE_INIT
>   board: samsung: e850-96: Load LDFW in board_late_init()
>=20
>  board/samsung/e850-96/e850-96.c | 9 +++++++++
>  configs/e850-96_defconfig       | 1 +
>  2 files changed, 10 insertions(+)

These should be one patch and also I think you want to disable
CONFIG_BOARD_INIT ?

--=20
Tom

--nrgu9IuU4+XYmzwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhVbkoACgkQFHw5/5Y0
tywDXwv9HwtRhQHMNq8+3173xsJ3fTlXPtzKymo48xDhRtvrCNz35EKmr5wjjkV0
gHtZyZQ0zln9veIl7RY8rXn8hi9pWsVHqDsV1sLmYNEsAb70PUqGBwH/t5wmGTkB
77+Kl8wdlxguXdEUG7+XGQ/yKojSJCSQhvdDQad62kO5ZT8Lp/pPXpbkXWX1RJ+n
2hM6nloP14RqSIy21QGTFO+UsnWrMIUCpvsWHP0GwTSYzaAHZMSc7MiLwce1NnON
ajjsI4Yamy4Zu2Y+o0k1O6v18Z9NqoYK56rb+5cowh6AQZlc3auYaSdT9CGnFq1V
4NXk9ffl9wD6kZGxYRiF8seZ75XtSqgZKY0jUXCarVZBOSYKWpss+e51PB5lHaws
r51l1ErXCkoZPseN++kMu7YUJ608Mdj9zgjg6xrVPdu6dLvF+p0jdWRw5WJn/5Ki
2O2AWe3uNVRWnBtUOZDxTcuNU6qXHm/ELylY2J3Fgja1HegA6KoruMSmbRo2QAZ+
NDGqq55A
=/Gzh
-----END PGP SIGNATURE-----

--nrgu9IuU4+XYmzwg--
