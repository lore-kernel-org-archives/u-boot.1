Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8424EC5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 14:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEF7982BAA;
	Fri, 30 May 2025 16:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RqxPbWNS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6747E82BAF; Fri, 30 May 2025 16:02:41 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAB5382B70
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 16:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3f6aa4b3a7fso663614b6e.3
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748613757; x=1749218557; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ORol+pP9GXOVD/FwcMVIgl+mvEjS4jYLUCxFQG/pZ9Q=;
 b=RqxPbWNS+egSq/4OJsEGBpFfT3qN3MOSxu05PfknIF9rxKCfrO5L6Y8MYthC0C2O+T
 +UDqYzj8NB56m0cwuF8wUCzRcExWpR3YWEevl5lDzegrs4MxjJp6sD2Rf0NIQpBybzRa
 M62dvalTwmscukq6Kx6mkRumnP5tiq3ERtEoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748613757; x=1749218557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORol+pP9GXOVD/FwcMVIgl+mvEjS4jYLUCxFQG/pZ9Q=;
 b=nghGLh4NcRBEsF8BbXmq8nVgDEK20Bgu4pEZhXD5fSRTHTIsoGuVBYF5T51LllnGNt
 aovTIJmgY+9OhpodYP6W1r7Qj6Ye43TNQXrmX+1fav+qqHW5M8TI9Og8NQq+4mZUderY
 6lEtlt6AF10ag1N1LFnncfCSRP9QYBpgNF7pFKCXa3bqAk87CGx6vPzKW2B8nJa318Az
 Io7xH7P2lVvvqzCDaRbhUeFlajJm5/V9qMJzUe6vRES53OdwkZfZzwzL9GslN+cy2Ym3
 1gvRrMFA5+BTdvyVMBaI4VtvAxopyaZPbVVEw90HIrt822C6h1rGYeIfofDNg3qTqFMA
 E9wg==
X-Gm-Message-State: AOJu0Yw2Hgtv5ZeRxj/ZWncRKG7ag5iupkAElLhyNnKsZoBs/alyEM4o
 F3mhKRgNff9EBqhQ2Rx0zC+CFyckSjRS1y7PJax9CZ3CXmIVAA09AF0NcJCZhcKSr4w=
X-Gm-Gg: ASbGncvnBFbwGSp3cmTe9CmiLdPtT+Lueug8/iGDvnOES18kgFBT408AaJoIcvwNqna
 dyAr3dduucnn/ounDB+nkjlYwLeAf1jUhW1jNcyarcK/L16+NfPBAMe/t0eehH9WwguKOU4QX3m
 Pg8t9XR8yjzefNkPZlTRI8jyU2UnfyzkW3a7VCYWteAzUkUa155TC3SSVIiTZw02DeqmN6j+KlS
 hJb531IKcjXPT/ZYmgHf5isBoWpTM+7ucGpS2MXGKY0RH4DUzGDeorH+xmyfOLKT7ynA5h7uYJJ
 HQGEF1ANK5UiTBCKAcnL4P9TG6ych2xiEzO54LgFDYPX5XdWNVDOPKm7m6K7jIff9esWqiNascs
 9AsQN+ro5f8/1
X-Google-Smtp-Source: AGHT+IGSSZhMin/LNm23fB5bRFinep/g3gF9u/8Lqbz99I7rd/lG1uEd9ar7x3PWZzQSLFu6nQ0WeQ==
X-Received: by 2002:a05:6808:640e:b0:3fe:b1fd:527f with SMTP id
 5614622812f47-406795f44f2mr1857167b6e.1.1748613757491; 
 Fri, 30 May 2025 07:02:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678ce8304sm397509b6e.32.2025.05.30.07.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 07:02:36 -0700 (PDT)
Date: Fri, 30 May 2025 08:02:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <ziyao@disroot.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] scripts: Remove "thead" as the misspell of "thread"
Message-ID: <20250530140234.GS100073@bill-the-cat>
References: <20250530100643.57666-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZUPTlOYoBgY6gdlw"
Content-Disposition: inline
In-Reply-To: <20250530100643.57666-1-ziyao@disroot.org>
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


--ZUPTlOYoBgY6gdlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 10:06:43AM +0000, Yao Zi wrote:

> "thead" is frequently used as abbreviation of T-Head, the IP and SoC
> designer in China. This misspell entry causes lots of false-positives
> when working with our T-Head SoC port.
>=20
> Let's remove the entry as what has been done in Linux upstream commit[2]
> 15571273db93 ("scripts/spelling.txt: remove 'thead' as a typo").
>=20
> Link: https://www.t-head.cn/ # [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D15571273db93ac2e4415e74280e04566c31d5eb0 # [2]
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Oh, this is a file we should keep in sync with upstream, and would be
easy to. Thanks for the report, I'm going to sync us up all the way with
v6.15 to get this and a number of other updates.

--=20
Tom

--ZUPTlOYoBgY6gdlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg5unYACgkQFHw5/5Y0
tyzoXgv5AftIILZClS/kefaw6Pf4r8dHDf4T6sN4sPc59dtnDHpBAD3ZCjJodDbz
/OP6BIA62sFT7rkcTg3G9jx5jFsi5f0WEeiaJAvkVWbdtZHiae2+VQ6WQvs93u3S
QQ+n4yvjaBeB/pD3KMMiABoXR/DE3QVJnIN9+GkDyQd7nfFtZEdk5V8MSXp8ylZv
XLaj8MBP8JG4tYz3YnmWOA8r7okVzmPrkWg4H4o6Es4zn5Tx9FyvO0Gn1FbBFirb
8gMhqMM/r4vEaJb1wGcGWc7dbyclSvQf3pd54OKA1BI9lS2huabSCzcaTlweC8rK
tpa0v+WX3tuo0kW9YSXR0NVy7+LBBuLNIaiEguw538ZTNKXPTNJu93Bu0qyGLBH5
F+CaVJFSkDUAUiR5RT9jKwkf0I35sN5urdas9zQPZ9dL36JZ92VWPFfU6aIaqvgH
0hIjusWw6dckh9xY0wWRUkBQVXKGSZFyPVogP4q2QBSONy3+jODoV6U43jnp8gsD
NICQQ/Cv
=si6n
-----END PGP SIGNATURE-----

--ZUPTlOYoBgY6gdlw--
