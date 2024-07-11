Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE45C3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 14:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4E0B88009;
	Thu, 11 Jul 2024 16:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GUqBb8WF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD9688049; Thu, 11 Jul 2024 16:46:16 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ACDA87F7D
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 16:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-65465878c1fso11683467b3.2
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 07:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720709173; x=1721313973; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4ldkCdSJpw36XuWLOnSq+b356SbTkaZdtslN4fKNPwM=;
 b=GUqBb8WFSSElxt/k13Y7NOrYkcqhtGI32hubNvTETB8km+XqRZbBtN4EcXDw45aI8n
 9dGeCq4Git87kQULgGxiucqeofEOOdGBJ+PWYNGK2WF29S44+Z6/bRKaD7UuRZIz2R8o
 YXDGAejs5wbV1jkJvJVJV0iM+A3o6nRqSMYW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720709173; x=1721313973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ldkCdSJpw36XuWLOnSq+b356SbTkaZdtslN4fKNPwM=;
 b=JMoIJwEOlrQ92mRZp+4weS+MAz+h1Qmf4Sstv55vj8EIyo8fzsTa9skCP+D3ZGVD6L
 V58ITaVJBtMuCqgUF0sWZp8XRp8tmHSIwKBCyidRY6Xw+0n7aHdJPMzt99B0EJEVdoQM
 ayoRiqir7bxYEwUCypXkICZGugLQa1D768GTLic+/UPAIijvmXoZR7aO4Fqu2/rRgMZu
 G5AKdzGYtRoj0hkCVEaeu2j0qBB92Em+xwnyln8jxGd3NKzk/l3COiE3bDKa5rbHPNkA
 LjUvlqT3ANJQZluQUr20CRfGTYt+DCsl54CY7JBBFKvdPI4p5xu8Jg4bGNjzbF7l8tDO
 w45A==
X-Gm-Message-State: AOJu0YxMQhWe5ZG8GUrwIZvR7IH/6RL+gbkt0Aj3ISWnEGmfkbCvQ45x
 nuhmuf7AdZkEsl5y++szwjKIn3WC7imRAJ0r6m5g0ZeLDKLjui1NDpWYdZSPgGRDvcSbN6TQ5wH
 gpRTieg==
X-Google-Smtp-Source: AGHT+IHHchkRgcP6+C6S+ogxNI4s18E0gfADeBXZxRTeQXqWOIXBQWPd4iqhLEzhXLv+eGmcX+4VIg==
X-Received: by 2002:a05:690c:dc6:b0:632:e098:a9e0 with SMTP id
 00721157ae682-658ee7911e7mr122372647b3.9.1720709173032; 
 Thu, 11 Jul 2024 07:46:13 -0700 (PDT)
Received: from oliver.lan ([172.58.30.202]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-658e483ed45sm11291867b3.19.2024.07.11.07.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:46:12 -0700 (PDT)
Date: Thu, 11 Jul 2024 08:46:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] buildman: Show board list with -x
Message-ID: <20240711144608.GA1149069@oliver.lan>
References: <20240711081004.304917-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HxXCDuCqMk9U0fCb"
Content-Disposition: inline
In-Reply-To: <20240711081004.304917-1-sjg@chromium.org>
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


--HxXCDuCqMk9U0fCb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 09:10:04AM +0100, Simon Glass wrote:

> When -x is used, buildman does not show the list of boards that will be
> built, since there are no terms which cause boards to be added, only
> terms which cause them to be removed.
>=20
> Add a special case to fix this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Tested-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--HxXCDuCqMk9U0fCb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaP8C0ACgkQFHw5/5Y0
tyxtrwv+ORxDwU/PP+3WmuIXFGX9jBg/FhGKgf/Xee4BWZj7f0uUR5KgJpXZD9w+
1i+dbyPsbiVmxmfz2TpnosbYEea/QIBc2CUfRuKskWJsPv3KSdyRscwMOLUaErqO
kZvNVlWUZAOTlIo0FXINbuiV9Vk+FOl2x6+iq4ZubNw9WVk9/F/kEpADkOHPdtu3
v73+JqonSftMaAnw9fEoYBpcBbVEYfb751nVQB2nPSoRjpt/MtDEP4fVHC//mVtd
CpJG0obBbk6h+1MRKXEp5ASPhPOucumzB3IsmdKMB5BvWnyh9/GP6OifihvlSTeH
PKTZ/ATtcUAPy9YUeGO9xlhw9HXihausZ2vdPPPc64lBp+RDU3b5ytnrtNTZA6Ww
gvy/c+5wGL1jMiZxFuJwchvllr03pcocd82hTI/rOqy84Toya1KgoGbbj5kWU5cb
/KTwrIsFSkQAGa1qakc9Rr6MRNIWEhFsdSQ80qhoViBm/fXZAO9Fbpg98gpGUApO
eatk3k1o
=O9Sj
-----END PGP SIGNATURE-----

--HxXCDuCqMk9U0fCb--
