Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C77CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE0FD83FF5;
	Wed, 13 May 2026 16:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L0ZK4V+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E053B83EF9; Wed, 13 May 2026 16:34:29 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86925845E3
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso3925720a34.1
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778682866; x=1779287666; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gUG064NhbhJtTNvwecVxn2ZSIl2WIYFrqJv8HMRQtHg=;
 b=L0ZK4V+MFjE3EJ21jVvXWzWzYcQifEoNl/hx6iKTTaATK12L4oYQkWCxb82PEPCMRU
 1f08+VrVgrM0BrszMVDgw2srTVXUNNIlU0I/KUoCKtQb8nDhBw9SNjWM9A5kihz/5Grz
 Awu7lIVhBwE1glSgC39bOLjYUR4CG6n9ZXPpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778682866; x=1779287666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUG064NhbhJtTNvwecVxn2ZSIl2WIYFrqJv8HMRQtHg=;
 b=KE1bmrryRjsFO56HQyuSy8CpA3EjQezcIQwA40snuVTk/bOpNTAWrHDjXlTf6gmUtC
 nb51bbmESIHHD5ZCJleJM0BfqYVGpahsCZeGf33afk/kBxkly0+CX4EInVdc/LllcZTP
 qeM1qm7QYkbA/6y5zcWhrk1NFuxYGBkWCAHpQKnZIFjxxCRA/XC7MKfnF8GakhLSYnpg
 lRk2Vnj0/qz5LfctjgvNug+0ARUDr7viVCnwMApQDt9oXVpCv4fr6nIx8RlZVb0DWtQn
 asaTil5MFnZP7VM9USQ80sdCI9eywIUq06dmGSnXovRNB4pHUM5TfoS9JoY4Mv81yRt4
 jacQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wovZgHQFE1lac5XiJ6KL25F/Q6P4vTkO5p/Hm7NAT0gDSwXMH7l9htM9pLNbFhdOCnoOztQk=@lists.denx.de
X-Gm-Message-State: AOJu0YxbxmNWSaoM/04ahC1Wg/Ao65MJReGOmD6N8qW44PzpZfKWxZIK
 4yq4Lj91QUL+vkaqusLduLX9Iq8u3Pf7CzYgajQYhua6c8130EkonM1qFjohMQ/MAgUDGAnwXwV
 zMunV/5/9brxy
X-Gm-Gg: Acq92OF27u0ENHHjaVEe7TS23pqU7sk2Y4/qdg7nXEi4Bvhy0xdXvvT+6CIE7uf1O8h
 Jnk5UnlIPOxAzdYy1Dm3xwHUKKBPdpAvz2jhRsmA51yl8LYqU8IuvpSKLzABvA2Bb8v7EdYGAWW
 nDeHz9IYbolYiphfDH+w+P0AvExRwDZbkumVzyp5UZjjF7N6gPo2YqRSpwYWtdwIXxTupSOeXSA
 sxURkVbgzcxcIZ59JSz/zV4xjM4pgNVWFDi6kJdWrappfcNsfccubM7i1abWSD94fpuauYvLnSF
 eqzuW83RKMgkFL3SiZP3c723qdRflBmRGO4n9+DdaE76Odcu8vpeT0wZRA1vt/0RImW/mx3GXul
 ri7+4WcGsOgGQwjXgylCWc/2r6Me9BhFWcmipWEJ1XKT6cRpdIzTMCypogtm9BbnJt92dEVrx/a
 tXKrmQIO6aKd5OJrB1GQLq5fGp/JgU/LsIhNK/fLD5FRX0n8/ZcRnrZUJjU8bsYhO0h/UtG4GSO
 AoC8niPVV/Ka1pgS1gYRwJq7eM/1nhl/lCZx2YHGPEfPj53qJo=
X-Received: by 2002:a05:6820:c85:b0:69b:5fcb:1d7f with SMTP id
 006d021491bc7-69b78d0200cmr2049791eaf.12.1778682866191; 
 Wed, 13 May 2026 07:34:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25e0e79asm9334961eaf.14.2026.05.13.07.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 07:34:25 -0700 (PDT)
Date: Wed, 13 May 2026 08:34:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Aidan Garske <aidan@wolfssl.com>, u-boot@lists.denx.de,
 Peter Robinson <pbrobinson@gmail.com>, David Garske <david@wolfssl.com>
Subject: Re: [PATCH v4 00/14] tpm: Add wolfTPM library support for TPM 2.0
Message-ID: <20260513143423.GU1858239@bill-the-cat>
References: <cover.1778619453.git.aidan@wolfssl.com>
 <CAC_iWjKGzwsb88AEx=Q5nibTnqpMf0j-tFxaPsjKrpmGfUCpiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yBGKjflnmhqkoMNW"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKGzwsb88AEx=Q5nibTnqpMf0j-tFxaPsjKrpmGfUCpiA@mail.gmail.com>
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


--yBGKjflnmhqkoMNW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 09:35:44AM +0300, Ilias Apalodimas wrote:
> Hi Aidan
>=20
> On Wed, 13 May 2026 at 03:26, Aidan Garske <aidan@wolfssl.com> wrote:
> >
> > Hi all,
>=20
> Thanks for all the efforts. Unfortunaltely I don't think we can pick
> any of these up. WolfTPM is listed as GPLv3, which is incompatible
> with U-Boot [0]. Tom am I misunderstanding any of this?

Yes, as I understand it as well (and Peter raised this question on v3
yesterday too), this is GPLv3 and not GPLv2 (older wolfSSL used to be
v2) and so no, isn't compatible.

--=20
Tom

--yBGKjflnmhqkoMNW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagSL7wAKCRAr4qD1Cr/k
Cj69AQDKMPQq5eVGkCgE3iBoShMc4mjp43VBmYxkfOFLUYugsgEAgx+fCigcZpDh
7Rrmt74UynmWZLPWAUMAN0cR3SriVw0=
=AH/e
-----END PGP SIGNATURE-----

--yBGKjflnmhqkoMNW--
