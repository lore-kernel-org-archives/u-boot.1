Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67624EE0AE8
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 21:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1B99839A5;
	Sat,  7 Feb 2026 22:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nH1Wuuh+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F8A783A64; Sat,  7 Feb 2026 22:53:08 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4AF838FA
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 22:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d1890f5cafso634134a34.1
 for <u-boot@lists.denx.de>; Sat, 07 Feb 2026 13:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770501184; x=1771105984; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YwI/D1am+WiS1i9x2uUFxwQO6g6+HW9IorrrVnhTeKI=;
 b=nH1Wuuh+Rd3GWN4+NjQzrlAda6Oam4M9MUp4+aRLwEbBTZSUZEtPVQHTvY12ngisfK
 R99tmHOMKE9Wzhuqjef55Hd5Td3nqVjm4F8WI0lqacsaRH5TMg2ZpeUgMbjeTF9ookFL
 d0p6k4xpqbYJXjE2eyIKKPMQFO8nzYAmnS7dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770501184; x=1771105984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwI/D1am+WiS1i9x2uUFxwQO6g6+HW9IorrrVnhTeKI=;
 b=g6B6b10WFIo/KNfvZiIqSD/klolAGnvmxxnaTkswEjyKEYOLNt9bs5anUCEncV+BKH
 cW7OJPimEMaOqu+rV2CJD+zANR83OlCRvemjqnLl09QuX0cTBYAKs4S6Yh94P0oIRoIh
 MrREY0fKPJMp2gyvajxUp1xZCpe/9EJjnlCwN5+3AjCHmw4UHw/Jpw4sllDLIvy57dKt
 W1zPtwRqWYuBIuCzn2x66Vl1SRU8ILCTCHX2UrJ7sQX9V3yz2zkBxaOw6qw6rhNt4I8E
 BrKWq7ch9jeuOqjIUeLqFCKuNJQ5LY8fFlOKEQ2DQzVqYID42PHA15+cAytVneIaa+oH
 pqDw==
X-Gm-Message-State: AOJu0Yy3NnrPxrdHeaG1oQfYIjG1nFqcK/MK5mUmeDfeeYcgHUWGcWPL
 VNc3+qe55rDG6h1trMsP5hEbGeCMD3Gs1m/RyVoFslo/+1PUe1zHgvkha+iNvknl6mKPSgX41ad
 BIogQm3U=
X-Gm-Gg: AZuq6aKkUwihoL3ZWcygFbQBlYCLTVnw0KtWBA4EHxoaZQvlLgEqug3jce4EXFX9bNq
 edqIwdjOP/VRfpZ+eAEFi8pzbxK2lNSIxtA7ILdPLcNslAwpZYu3vupwVEbRNHXaPKhaiDsAyDc
 ufB41mg0B5K1ZLjkUVIdVU6EMdHE0eUUPx9thh6h8WRJYst1L8hV3Yfek8sO+eGLtoQVWoxJmKs
 EB+TjL07/NV+CWNQoBKtcLEauoGhqNUo71ShxbV58Ze2vRsDfdzTcyW0Ukui3NQVBynmoBhcKdI
 Ep7upvEoED1dDvraddJErXq3lUHGvA2dDIVX77oXHhdhLKfvo2AFnSyB+3M+hwDAnn9LYyvXYBY
 wV8eQxyZEKlrBY58NXuMOiFIVqgFHy1RRcwDtCHGuxgg3hD7bJo6ff0m1cj54g5LvEmSAZEB7o5
 IunsoeXiyFbmQQifFUqbUJcalDK0QHb1kKPK/OhQgawqyupKdMGYiLgFs4vOvqPv73bWuL81Kc6
 smA7LuApLZSkCWYllpqbfJypH2SzhC54hDXoWA=
X-Received: by 2002:a05:6830:2b0e:b0:7cf:ddee:687c with SMTP id
 46e09a7af769-7d4643e7ee8mr4035163a34.3.1770501184537; 
 Sat, 07 Feb 2026 13:53:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4646fb636sm4404333a34.5.2026.02.07.13.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 13:53:03 -0800 (PST)
Date: Sat, 7 Feb 2026 15:53:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Phil Sutter <phil@nwl.cc>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] board: Synology: common: Fix typo in Makefile
Message-ID: <20260207215301.GA259488@bill-the-cat>
References: <20260204202936.21585-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xPpIk9BERS/CQcwQ"
Content-Disposition: inline
In-Reply-To: <20260204202936.21585-1-phil@nwl.cc>
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


--xPpIk9BERS/CQcwQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 09:29:36PM +0100, Phil Sutter wrote:

> Due to this, legacy.c was neither compiled nor linked into the binary
> and thus booting legacy DS414 firmware failed. Missing atag setup led to
> no console output (and probably stalled boot) after:
>=20
> | Uncompressing Linux... done, booting the kernel.
>=20
> Fixes: 9774462e34faa ("arm: Disable ATAGs support")
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  board/Synology/common/Makefile | 2 +-
>  lib/fdtdec.c                   | 5 +++++

OK, whoops. The lib/fdtec.c change was just a debug thing to drop.
However, the Makefile portion leads to failure to build on ds109 and
ds116.

--=20
Tom

--xPpIk9BERS/CQcwQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYe0OgAKCRAr4qD1Cr/k
CvLLAP98TuL8jRWXiTc48K5zflhMzGU+LWqXasMvKsIV9zx4JAEArPkAFH9dFkLx
aW39YdKMxotUBgEYDA65wO/7D2FuAA0=
=FKhL
-----END PGP SIGNATURE-----

--xPpIk9BERS/CQcwQ--
