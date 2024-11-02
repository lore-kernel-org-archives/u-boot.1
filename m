Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834CFE67815
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 21:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0528E89117;
	Sat,  2 Nov 2024 22:40:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FS5K05oy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4725689100; Sat,  2 Nov 2024 22:40:16 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3940C89080
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 22:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbceb48613so20691196d6.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 14:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730583613; x=1731188413; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BwVhTCyvyWw+nlwrxliXbkGzglTw70fZ0ojoUArWMMs=;
 b=FS5K05oy/foFN/pFezLE3dAilWUrekO4jmhkEnwvhzy9Vl31S+aVn76Tu6f+C6ePCK
 UHgm7p7bZ8k6iHkvjr5EPWtCtTvo+9aEg3eDUhXJA1dirmCFFEI4wl8DMc/Q4GqhAmjj
 EC2Q8W8cyNfidPlA23v0DmF2D3KRKAQARYUyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730583613; x=1731188413;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwVhTCyvyWw+nlwrxliXbkGzglTw70fZ0ojoUArWMMs=;
 b=YEdaC5njqd6TUehYyzUb1IWFsXB7tOQZMflApvp02krFckghi7JUXtmUTZKST4kRb1
 TXV0O+kRxwLkNGi7uULaaB1zk2V2uEA02BcXT8k5d89xxFM01yZjgk3D2SdNAGXztX+K
 05S/k5br8cAPxRP8Tx5BIamxIy1oRh9yAMU4rPGBhTL3tfk2h69mycNTgXyayuulIcOk
 P40/xy8D0nwv899GVgsjhEF7wZ5m46apcHQptcl9sC+YOhrwCTMJBiNoYCzCQ6ANVA70
 g7b5BJg2NGIeXYq9Ebzpj+aUI583tAS4XYv1VSXuSn2tMwGgzYT/SE/QCJv/3QO2hUcl
 cO8Q==
X-Gm-Message-State: AOJu0Yxapz9EOKuQjNx939+grwHbPc9wpNo+OLfOq/7ARZiIZ4x3yvpO
 zU96yT2JGWaxp4NPr2uikBSzLkJtrLvMe55cqbiCYbzr5fFrJUrqv8avcUHhXL6rHcEZRYbqo+Q
 y
X-Google-Smtp-Source: AGHT+IEsVpzV0fP84a8heVXzXGMMwd9RRkI/Hj6mEkMqtcnpj8ma0sK9ZaQGfBZkmBmRl3MNIFQjHQ==
X-Received: by 2002:a05:6214:4b12:b0:6cb:f561:2a83 with SMTP id
 6a1803df08f44-6d3460b6b2cmr197612916d6.43.1730583613053; 
 Sat, 02 Nov 2024 14:40:13 -0700 (PDT)
Received: from bill-the-cat ([189.177.125.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fa5569sm33129976d6.19.2024.11.02.14.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 14:40:12 -0700 (PDT)
Date: Sat, 2 Nov 2024 15:40:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v3] sandbox: Add a build without CMDLINE
Message-ID: <20241102214008.GV3600562@bill-the-cat>
References: <20241102193615.431681-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N/+3Xep/FmGS7kMy"
Content-Disposition: inline
In-Reply-To: <20241102193615.431681-1-sjg@chromium.org>
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


--N/+3Xep/FmGS7kMy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 02, 2024 at 01:36:11PM -0600, Simon Glass wrote:

> Sometimes this breaks, so add a build to keep it working. Since sandbox
> enables a lot of options, it is a good board to use. The new config is
> created simply by copying the existing sandbox and turning off CMDLINE
>=20
> Once we have tests for non-CMDLINE operation, this can be adjusted to
> run those tests.
>=20
> Create a new build which will be picked up by CI. Update the maintainer
> entry as well.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

Note that a handy follow-up would be to use the "N" syntax that
MAINTAINERS supports and just glob all sandbox stuff that way.

--=20
Tom

--N/+3Xep/FmGS7kMy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcmnDgACgkQFHw5/5Y0
tyyrvwwAsmgejuPd/N4A9KsuTrRl5ff3tLubU1/jZ/FjpfRcJNLSOdbPeUCKBvtZ
0/p+KDDyDrQ1fXU7453zhXzjaS7sWCd+sm+PBSpXxpHEpKIe2meJ1uEvMdS9R6Vq
0KnOtmAqNgR9Jy17zOjiwdydlmbsG1IoEHZ2GH3xlwgEmsxcauYdWvAGoutlFYrT
htcJO+ShPXSHp546ZpAhAbKGwlHYgdVseBXdIGwDKZtpfMUfwzbnRHJdfWb3HnYb
DxXlYMG1Ts39rNksxBF+552+WTyocHmoZNbb5B4SQ1q3A+VrEi5udQ7+P1BSqN1f
0U5YO7KFct4q8AMphEsbOEzjX5hooH8ncTYHfz6wpOrvNXVJszuB1h36SSQgFJXZ
cMTSYgeIUAOvkLdELPLT3DJ8JzyUanR1R/pxAlboupWN7Zyn4kCAI3M4PM++tEn8
I2jOd4Paxxwahsahlstgnu6hkR6M1JNyg5yXmpdasRjeatbt50uD9OOvLA7lgowF
664WcIVB
=tdvc
-----END PGP SIGNATURE-----

--N/+3Xep/FmGS7kMy--
