Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37BBCAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 15:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0413683390;
	Thu, 11 Sep 2025 17:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F7fz/kED";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D57B9833C6; Thu, 11 Sep 2025 17:32:01 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77ED58334F
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 17:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-30cceb3be82so661162fac.2
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757604718; x=1758209518; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yjeX03D8Y8/FR67eGTm0fWjpEngqoZngjhf/CXOZdRs=;
 b=F7fz/kED0paQR15AoO+BGt9H+aUF/LCzylc6LBWC5+HZscaUnOljY2Z7RkvXvim6wy
 Dxr1t3o8BM+J11VgscsHSk7TiR0DG7FtglreYI8P/hF7nWFA21eFDX6ehEPGTZON9uOc
 BStCnKuFig+vKrnRm9udA8rV7cOJl6OC/1R/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757604718; x=1758209518;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjeX03D8Y8/FR67eGTm0fWjpEngqoZngjhf/CXOZdRs=;
 b=nlpBD2Kj+Bub7XrAJUzcve3Qirq0GBHJ0oO66M/uSaIq0GTB3AeOCdtjp8nhjdGTCD
 UCgxjZWgtLnhX6q/QKT6DQFSSkLQ+VwUq91/4Cggl+GLc3248cU+7CkSkwoCw8M6IBIL
 pz3Gs/T6iCvu4YicTb8eQlDWZTgWtRU816YQ2hEmJ7f4FuE2AJRWPyhowgKN6ZWMTx9j
 vbitQrGELTy9SCx2S5FiPJjdNgZpVl8qNr99I5c1+kM+fLddFraGMHGawgDOrgkR1NJy
 d6FbmWrXK9zyq5faG3D63BNRYkjNJeCtBdvsTl8Xa4cJzR4oWwdEcPfSF9JbPVk66IBN
 AiGg==
X-Gm-Message-State: AOJu0YxgXraiyCkyAIXPiSPrXRn8yyXhkQAccwvcP0ip9q2/LDr54Rjo
 +doFtGTSeq4x0HXOoefn2SjFuoOCrQv1InUzLEeaSNgeBnfL0DUHJAQZFjNgPFky2j0=
X-Gm-Gg: ASbGnctQCRCAnBqgzpj/ZsSRREzFFEJxXivLmoEhPZUdx5qOao51tFJDgXdm6puBfWt
 /lEYQgNepGtLeskcZiGR18RPiy7pMylw7mQpD/H1szT+hl4sqlzLNXBddwjUhj4bgm1vmkEflF4
 Zlc0P7Um5HnCk/SGY3vC9YCtR443gSGhUA4R7hHP7AjnVGjB+FQ/c32YpvaDevmWe9YGLfcNtV+
 V6DJvbZJPRX/3vJvGUORgoFM5/uPUao10EzrD74DVqrpJ7kr952nhedwVY4yBrfEL0ewPa2DOti
 rEstf6EdERdjIN3EIs+aOOJc1gIbDdX6V49PhRCM3QET7MtJnL51nGtBQKgPB4iIN7IlDToP0J7
 Lg/rnIQepY1VnLvpvCGJtLj3+2W7pCaTXHYtqhdF8UTSXxXLeOEMYynvz
X-Google-Smtp-Source: AGHT+IHsmlE6ojSNjB5i/yitXcckbxPSkM6y02x9+M5knd11fzof1++WXjcHFzx63z/02IGPk6r0Dw==
X-Received: by 2002:a05:6871:878c:b0:31d:6bbe:5a1b with SMTP id
 586e51a60fabf-3226533832fmr9017160fac.48.1757604718102; 
 Thu, 11 Sep 2025 08:31:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d3345266fsm475993fac.13.2025.09.11.08.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 08:31:57 -0700 (PDT)
Date: Thu, 11 Sep 2025 09:31:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Thiery <heiko.thiery@gmail.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Michael Walle <mwalle@kernel.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH] env: fix config dependency for
 ENV_OFFSET_REDUND_RELATIVE_END
Message-ID: <20250911153154.GO124814@bill-the-cat>
References: <20250911093223.65323-1-heiko.thiery@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XjhKcfbTSBlIP+zo"
Content-Disposition: inline
In-Reply-To: <20250911093223.65323-1-heiko.thiery@gmail.com>
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


--XjhKcfbTSBlIP+zo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 11:32:24AM +0200, Heiko Thiery wrote:

> Since commit 5fb88fa725 "env: Rename SYS_REDUNDAND_ENVIRONMENT to ENV_RED=
UNDANT"
> the option SYS_REDUNDAND_ENVIRONMENT is no longer available and should be
> renamed to ENV_REDUNDANT.
>=20
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>

Fixes: 5fb88fa725d6 ("env: Rename SYS_REDUNDAND_ENVIRONMENT to ENV_REDUNDAN=
T")
Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--XjhKcfbTSBlIP+zo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMLrZwAKCRAr4qD1Cr/k
Cq8FAQDEyYZ5ZfRGvQWX3bj8RYaE0H4kMBsRHdSkmGPYh3j6WwD9H8A017unuQkA
VRiy89inyTwqPC/npL8KsUqR/zSTYQQ=
=+WKy
-----END PGP SIGNATURE-----

--XjhKcfbTSBlIP+zo--
