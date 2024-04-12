Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B06C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB1D8820B;
	Fri, 12 Apr 2024 20:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="clUx4QGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163BB88204; Fri, 12 Apr 2024 20:52:14 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08AD9881FA
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 20:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dbed0710c74so1097010276.1
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712947930; x=1713552730; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IH6qQrtKnsMsn7h7Bulyr8aqNpLH3TOxmJvoYMDPD5Y=;
 b=clUx4QGN1I6PpHvifpCMEsqYk3NGRmu+DXTkzjXOnEG88Apj2r4wHTctTePoSEUNdy
 BGprmsJA/p3YHvqDQLibsdeW9Y8582brCDKbo+5n5chH6JkdKKazYJyz+LpCyDqeHc2J
 /0xK/GLU8WioZtLKgC6fHAB3k0wzwcb/tL6l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712947930; x=1713552730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IH6qQrtKnsMsn7h7Bulyr8aqNpLH3TOxmJvoYMDPD5Y=;
 b=mNP5ojCbRnzky683o8F/0e56C77iGn8+3PcSG/kfbGfmTuqnAi4yzwgqObRWEykC0u
 UIV2n7r3JP7eV82xxYNi9lN1Lg+00oEdnED982H76CqvNmc8s24MHyuI924l8n5VfbTX
 RGdEfpw6G5kpEqdIojRc6PwaPqvGioyckVTxUghEMFGBeLvQ/ZH0fA1NRjf1zxdNL1D9
 H0ZhBA00MAWLm57wCMHNWUjZABq2cVcJvZSHYyKh8MlovIz7bJYulTYDR1NmGPnB0yRy
 ngOihv55Ix5S7qtshEJughu98OjaXn7JBpWvOvQf584dLEEkGczw56gRkdhUokl1EHPP
 JtAQ==
X-Gm-Message-State: AOJu0YxeGmj6ju1MH2U8mwOf3BQtegCZW7G6807kLcd1BfzmMeS+Kg4H
 xxnwpptI7pJyYOV/GWF6qGVapvnLGUsD/chWDsnSWI9OZFlno+wVEjnTdjfYMBU=
X-Google-Smtp-Source: AGHT+IG0hSWdrrxa8GsMrGhixJ3EGUSkrFfezIBroDFlUZLbteeeANEp79NO1R9xYmD+dTnTQNH8Rg==
X-Received: by 2002:a25:8449:0:b0:dc6:b9d6:1542 with SMTP id
 r9-20020a258449000000b00dc6b9d61542mr3379925ybm.48.1712947930145; 
 Fri, 12 Apr 2024 11:52:10 -0700 (PDT)
Received: from bill-the-cat ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 ej6-20020ad45a46000000b00696b1050be8sm2669104qvb.133.2024.04.12.11.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 11:52:09 -0700 (PDT)
Date: Fri, 12 Apr 2024 12:52:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Hugo Cornelis <hugo.cornelis@essensium.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>
Subject: Re: [PATCH] image-host: Fix error value paths and emit error
 messages to stderr.
Message-ID: <20240412185207.GR2493117@bill-the-cat>
References: <dac04f9a-6657-4727-ac9f-c94793b2c07a@gmx.de>
 <20240321112222.237341-1-hugo.cornelis@essensium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0R/eDC0LjDoy0ijY"
Content-Disposition: inline
In-Reply-To: <20240321112222.237341-1-hugo.cornelis@essensium.com>
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


--0R/eDC0LjDoy0ijY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 12:22:22PM +0100, Hugo Cornelis wrote:

> A recent refactoring in image-host.c messed up the return values of
> the function that reads the encryptiong keys.  This patch fixes this
> and also makes sure that error output goes to stderr instead of to
> stdout.
>=20
> Signed-off-by: Hugo Cornelis <hugo.cornelis@essensium.com>

Applied to u-boot/master, thanks!

--=20
Tom

--0R/eDC0LjDoy0ijY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYZgtcACgkQFHw5/5Y0
tywadAv9EhE8VodJ+eV9T5JF5HEJ9Z/mPizSGHhW3xlmlNe1f1w19zb1smb/twUb
RT7o/laUoYO9do5LLzOOf5kGgUtwbz8fsl4W/hjp6ZMwgqlyMcRYHQlnIjQ0vUxg
IW64EHi+hbFTsx/SbHUd6i3+m31lk9VUfv59ucJohIYVw5JpjpVSs3DlE7kE4lNf
jdNu8phoJ0lWJhDfM0VSSjd8tYqI+2VE+GlmW/FcBZX0RR1DHFFYl+cz7HbXCUu6
LpPqKtL0tg+MIQgTwVggIm1PFrjWHZxG092z9vZW1xUuPA6pHxHi06H9lbirODW9
SM3RrJ1muv8xskYqNPwpQmZfTKyvr2BBumzMDPkRcdf61My2Ra+/gAIcAkTnIxTQ
dH9U21PL9808o1/mZ9e63Rt3tuiVftVpXRVeeTV/cZJOhdT1Q3HE7WhCUpiWTnQh
5+sAn1wZi+2jMM6lnbGV6pRPQrv76qXBJfMCel4dQ8wF9bpg2otAN/vX/nv1Wk3X
n+Z0j03E
=QL+s
-----END PGP SIGNATURE-----

--0R/eDC0LjDoy0ijY--
