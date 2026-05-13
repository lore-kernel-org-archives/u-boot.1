Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BCFCD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2CF1845E3;
	Wed, 13 May 2026 16:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PaQ2OCQS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB2DC84674; Wed, 13 May 2026 16:29:31 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E21B28341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-439c00ed7e0so1239331fac.0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778682568; x=1779287368; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q7ByGeCNTml4ITZAOseQE1KKaVbL6ifXhp3I4QlzLaM=;
 b=PaQ2OCQS7gKqyhmeU14h6LNxbDxzNlgqaY/oqWEvUgwbr8GX8Mp8TeZW6OQvfmh1zY
 xDFBo4yw3I9FO6DJtjyB/4F03+Ngx/InXagXhW95j9SoY4lSw1a2hDRp/ILIQQFpm2Zg
 qUwboUllwJ9moZufbwqnVhRgYTEwzrzVhC6SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778682568; x=1779287368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7ByGeCNTml4ITZAOseQE1KKaVbL6ifXhp3I4QlzLaM=;
 b=KxDTM7CZdCGZUYVa0yVicAtp6+DQAFspTTn8z1ZLYzgo8a5CQD3Hf3SFx5xHENPmGM
 KWD08QbR2o9mgzyZ52KaVt+jt9ig1/MGko5FKFnehdoHZwNDBfmtNgIT6Zi2r42a2wdj
 Am+cZC3htSoDcbViFPPlyymyVHwJEc8WKqvZIJQ/NrvcyHT0A8RoDTWYZYNo7fC3lU0q
 X1pWAdnM6V6ya9wZ2R1Y1+JwMZJFCYUg+VyTnstATas4E4Agau5WLZg9/dIv14Mwabtd
 dl+SAn5Fh3P0d8w2bQd9W9haBsZ+FL8SgFuBgyZ4X6Tmv5TjRnmS07YblZ3ALt0nqI7c
 e2OA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fSc4P1jUlXU8SmQkEE80jITVU+GfQUGJm2eIJ4Qad6easp5EmQhrOHwyK2xY1BHgK8uPqm9M=@lists.denx.de
X-Gm-Message-State: AOJu0YxD4LGI8nleLsvJG1rX1CckZ5mPtapO8CW4fEad+7ArQaYFh7Vg
 G2r4jRg86q907tPj/AyDt0fhsA4+5iVVou9KHe28omqwlKVPfpRDsiwZY301Spara48=
X-Gm-Gg: Acq92OES3yWmL8LB8LajsO+3T8GKFcaSEe2bQ/cOvjRbONqbDptZOAsHwWS4ha0qFNp
 4eBQN6qBG8Sdf81HT5PGaaJ3WGXOXz12Fzgzb3tyZTCkl37nsM8snVNBpiATC8y4hjMSWl28xXk
 +KxWiPYI034jpbrDVIwdhXbMzEIx2T9ObR6EyE0QP45t7yT1y6/fmLswbVhNpOzZSL1nNnPkmuE
 PHD4hUcAu9iUWac0ZB2YP7eGt03fEbeKMRy2Yk3zjERzulWIdKYWGqpfteFCdpJnm/2G+mSkyeh
 IkHwpg59vfa7m1RX1t5Xg8D22PX80rRAKGMZXfyJ5Rk8mowVxV+AuM/wzfsnlikJ/K34bfhVGnD
 c7uolTdQdmCeuZi9Cf5zEygkOiBXEeSVd8Ss/jtG9A8PLzVafCzwmKcfeeAza0ifGaQLWitXpKG
 ywfpkYxYTeHSrakWr9DrfjdL1O5/VWFKuF5PjlSjVzKCDeGH3NwBQ6DajTbphMjZJSlThIAMSHd
 ZDa4DXAbPaQirMmScglxreLLnU9VlyuNMIXFx0irittvXzTbKxMRD5Q0hGr5A==
X-Received: by 2002:a05:6870:8a20:b0:439:ca41:d517 with SMTP id
 586e51a60fabf-439d2ff8f2fmr1499768fac.27.1778682568585; 
 Wed, 13 May 2026 07:29:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435aec16e0dsm9702852fac.10.2026.05.13.07.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 07:29:27 -0700 (PDT)
Date: Wed, 13 May 2026 08:29:25 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH] phy: Kconfig: use bool instead of tristate
Message-ID: <20260513142925.GT1858239@bill-the-cat>
References: <20260513-phy-kconfig-no-tristate-v1-1-c4cbee0c1831@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B3twRpxTGofncPZi"
Content-Disposition: inline
In-Reply-To: <20260513-phy-kconfig-no-tristate-v1-1-c4cbee0c1831@baylibre.com>
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


--B3twRpxTGofncPZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 09:11:52AM -0500, David Lechner wrote:

> Change all uses of tristate in the PHY Kconfigs to bool. U-Boot does
> not support modules, so tristate does not make sense here.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Thanks for the cleanup.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--B3twRpxTGofncPZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagSKuAAKCRAr4qD1Cr/k
CkwcAQDrJuXUZauGz9loWSNkcax76qZaG85m/k2xs7i8eak6fQEApYB+g2q7Vn4t
1cqB7PiBPDArTfiA9OUXf1lI8YBkhg0=
=KgVm
-----END PGP SIGNATURE-----

--B3twRpxTGofncPZi--
