Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51643CAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 20:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 856D0828A2;
	Thu,  2 Oct 2025 22:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o4r7MKi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56FD3834D4; Thu,  2 Oct 2025 22:15:33 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC5A81D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 22:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-91fbba9a8f5so117944039f.0
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759436130; x=1760040930; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/SGVrMicls/aUHUVuZbjU7o8woW04DsUZUTWUH7WD7I=;
 b=o4r7MKi4cIEUqshNLYuArZHxz/kg5ceLbKAiHAazdM4cIJHW5LB9DkmS5UBrejs9vg
 YcEA0uxZqSlSua8eI17LN6ik5FrWFluscoRofz07xHUdVnkYYn5UmuegH538MdUQW6nN
 UWRh3TL0iZxoJhELQ1G0vL3R0WOXDUlpRqy/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759436130; x=1760040930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SGVrMicls/aUHUVuZbjU7o8woW04DsUZUTWUH7WD7I=;
 b=Y32g9kyIZZ7mODjegV2VikRN1X/0cyjiMknkuC3RKAukfT0EYKGjO9XjWg2J5tABeA
 NZaN4Bn479IgcPBugTj8GXpV9MweKvlD+qapCAy7ZkwD4YZIqk0nLsGNH7rHFTv31XWk
 8iPUbHkK1WwBtnt3UCbvWQyPJNjPcd1oMQpLNKLO7IydNJbgr4VN2EzrVPEKxAEbokQV
 h77vLTiuUc7RE126jWvYVt8YyQ0ixP7wqQZj0vF07Ia01Cxv2enLMCzaC4mmzaS7IRvD
 PN/mOda+k37ZX7QEJLPOhYFl+WhMMxpr+5DcZ7FsCPyAe/dUodn+gmodLoJzlXX3cYwr
 CkwA==
X-Gm-Message-State: AOJu0YwbfweGlBpb4M17a5VkfZDYBf6YQE6NqPdEKl6CExhhb6J+aVFM
 TlkMOtVUHh3/4ICge6+NW9Mz9d9H1j+QZ2VEeE8gBSqIH2St2eiXamkBZYDghH+09pk=
X-Gm-Gg: ASbGnctLWDw4YTOVPSJYJQVwN3QzkzfJqDWqh4kYRnnrlBB/62Wl8LWnzKiETnh1HJb
 YR/cm4aXxPkwvkSkQiAT9ZryDBjdreq7uYu5Wtgkm3HGWpWa86PfEWVOEK0YMnXlPI4LU83UxeU
 mpoNsco7mp7rCuis7gKHndxeEnkvzRkw5LkWlbEVPrRmeb9xM6LF3XaKnhoqLIAqFHRHkU8nXvN
 Jg+ux7CSZpXpVAnD09MGTmbGlJcIGWzc9VcVV/njDqKdbF+wyvSBlog0fqP2QrgupUTkHyl6yAx
 p9C9kWf7gUTkKxjSHlu2JcemL7MyK7NIBc0ofGghhEsb6X1w//Ntjtq9+HNeCR5kQBg/ksVEr6X
 +Wf/oyF+aaqSIysMGxWc/7lWGJuwyy7G1tNNzHk0JmCvRfe2eMuml3X8tBY6Wu+JHWmOx51I/Rs
 9dcNJZSiEtyA==
X-Google-Smtp-Source: AGHT+IH0ytAWhL3mhEpb+Pfd1apau4fQhdpSLNWw2HBv1ECPzZ7UuO7TSBFKIkgHKj1fbAoHhzJJPA==
X-Received: by 2002:a05:6e02:178b:b0:42d:84ea:b370 with SMTP id
 e9e14a558f8ab-42e7ad88298mr8202085ab.16.1759436129844; 
 Thu, 02 Oct 2025 13:15:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec5d131sm1140284173.73.2025.10.02.13.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 13:15:29 -0700 (PDT)
Date: Thu, 2 Oct 2025 14:15:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v2 01/17] boot: Improve comments related to global
 bootmeths
Message-ID: <20251002201526.GN6093@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TJFrwImXo8FX3ZGy"
Content-Disposition: inline
In-Reply-To: <20251001212649.3263574-2-sjg@chromium.org>
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


--TJFrwImXo8FX3ZGy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 03:26:26PM -0600, Simon Glass wrote:

> Add a few comments about global bootmeths and first_glob_method
>=20
> Fix a broken line in bootmeth_setup_iter_order() while we are here.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

I'm not a fan of fixing up little spacing issues. Even more so when we
aren't changing anything within the function, it just makes the git
history slightly harder to read. That's not a NAK either, to be clear.

--=20
Tom

--TJFrwImXo8FX3ZGy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaN7dWgAKCRAr4qD1Cr/k
CtGMAQC1M4r5Mj5XdZAl07wh28KYkxi5xdrzKDb/v+UDez/0dAD6A/vgnTGFj4sn
iotR1SVOz/z2wKOLRI2AKT1GSv3nzQE=
=49Z5
-----END PGP SIGNATURE-----

--TJFrwImXo8FX3ZGy--
