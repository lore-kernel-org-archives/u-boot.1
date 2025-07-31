Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F99C87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 16:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE817838F8;
	Thu, 31 Jul 2025 18:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kKvdbVbI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66BD58383A; Thu, 31 Jul 2025 18:05:20 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECC688309D
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 18:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-41b6561d3c5so180064b6e.1
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753977916; x=1754582716; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7/Jsqqz5wvgzyLzZAuQmqA6YPevrFdhJjqijH+njt5o=;
 b=kKvdbVbII8NuCoh2dQwH+wbYbRg2C71sctFUmff1E1d3vlj6L0Q3sHA9g8g4tSs89p
 yCkvLPsODSzRznc1xXe19z/GFcS+MRn8Jn4co0Xg1p6+TJ9pKKJJ1gui72wYLsJeLHDU
 rMTMyg4yYkwlC+n6MkBEuEHIrnlWDbgCw8/wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753977916; x=1754582716;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/Jsqqz5wvgzyLzZAuQmqA6YPevrFdhJjqijH+njt5o=;
 b=Jx03prcGIkwXu58HNIgNw+wh69Gl8YxVQubzI41Y+2mBr5TVc4Rl+viz6F07s9tWer
 82Iwywd1ZL2jM+2ujVXObLQUFAEe3KooEBm3VpZuu9jtNeqElMvEt4pMMammt/bgr8jr
 Wf+IwdkZ3WXWNj0RBYildwJwETBEvYh2BWCBVN8OZB9mbdL2wkTrQ8CyLfHpMdYXmEVq
 L67dMWdOZ5TH0zcGXEZV4ITefHZTsr/MiIOXgMYHNHbnJ7AXXXE1ZI/57DrVLVQc0XpS
 ffFt6Q1KogTcAGknXgHxAGUb4zBCAx/bpgCE1dScrmqeSy6l7jlzeb/6Vk6QqsdMYN8G
 37kg==
X-Gm-Message-State: AOJu0Ywcgn3gIh26gErT/sDuWYGyZrFjXX1M7Z7w1fzMLbIFkfOlN2zy
 LDQyUZdG0DSX/wTJcRLGpkO4CA4OfaMomYe5NbjJMGrO4UOPUM0k5w2QlCzCd/21ilk=
X-Gm-Gg: ASbGncuNsBq9zCRpTcmuz8mlPLFgUQ5+17JIM3jDlwRhEXB347LOgjeJ1YJ7IMeJyHO
 AaAeqZ5Oz/DfQ+xsfFUaa1KVOeQnRJZ3OAN0c4bnPh2ZSLtC15wv4oLf5frkza/kl7/SJ5xO3jq
 qwMkXExND82o5MXTEn21X6f96qhlSxgI1uf3TG1HpMPp6Lg7z3rKeJrbap1jmc3TcpHcNvP5v4Q
 QPCrWIZXpOtyhyOQUJG/U3tjsVJfe6KEAEoCz2a2Deqv8uh42eKLG+MT3kDa6D9VcOSZvCW+rP9
 9uyhesJhNi76FqJIfQw/1XW0smcEOP80kUkOXqyEvgM0eB4dFpOqtxJ+iEzaPNPnC0rIG0Os2Xd
 MaIl5i8CbFlfsY/Cn5lrDeCCCJBrkowcmv+lcqeUWx6u2l3uveoBheKtM
X-Google-Smtp-Source: AGHT+IHavXF8Hn5lVnisglVXgvignnzrrI42zOKRsKn+r7wo8yAEfJtjN15LXx/lIRD0stbPfMc8Og==
X-Received: by 2002:a05:6808:509f:b0:401:e69a:8af2 with SMTP id
 5614622812f47-431996b278fmr5074867b6e.5.1753977914605; 
 Thu, 31 Jul 2025 09:05:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43356de753fsm316838b6e.15.2025.07.31.09.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 09:05:13 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:05:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v5 1/4] Makefile: Simplify size check
Message-ID: <20250731160511.GX1807455@bill-the-cat>
References: <20250730123833.249923-1-pro@denx.de>
 <20250730123833.249923-2-pro@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Dzya9eLVQEKFRUp0"
Content-Disposition: inline
In-Reply-To: <20250730123833.249923-2-pro@denx.de>
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


--Dzya9eLVQEKFRUp0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 02:38:30PM +0200, Philip Oberfichtner wrote:

> Deduplicate some redundancies within the SIZE_CHECK code in the toplevel
> Makefile. No functional changes.
>=20
> Signed-off-by: Philip Oberfichtner <pro@denx.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Dzya9eLVQEKFRUp0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIuUMwAKCRAr4qD1Cr/k
Ci4mAP9V9bEvznNd1Wt44utuB5gN6hrc6mG/ciLbCxHmdn2d/QEA/mNYR2xM3mms
wJ0ggi0AiKGDwguvMphGwsxY3rKgdwQ=
=X6/8
-----END PGP SIGNATURE-----

--Dzya9eLVQEKFRUp0--
