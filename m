Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA79F8FA88
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F47A84198;
	Tue, 21 Apr 2026 17:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tkv6Ifhb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD91780433; Tue, 21 Apr 2026 17:03:47 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC4DC83E76
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dcdaf06498so415223a34.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776783824; x=1777388624; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gDt3wDEI4QRrAqu0/LiUc4ECjOKs19oPCPBsz1Ou8qw=;
 b=tkv6IfhbD6zPM5Y5DF2iRaplQYwiyVatjSJ4fkKeNWSK7/edMVjrjj/zxAwois4Tb0
 T9JrHtNjjB+Muwd28iutjFT2ugvkz0ofAFbxGehzKk5fd9VtbkH2NfiOTqND3wy+axiM
 bMLK6npG5eXB/SQJ+YP7ZuSkpucSATpmn/zSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776783824; x=1777388624;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDt3wDEI4QRrAqu0/LiUc4ECjOKs19oPCPBsz1Ou8qw=;
 b=cAQeAkSTB2X011nZNfTFegB7hMvE9YG9mev1tMDrprvdebTZgmLl7en+nclRNV3N4V
 6Jmla1tEOCXtg2vqbbbkZtwFxwFynRawST8HRCRBSeGfkbwxFZmHTuGrWIwHGQ5bj3TR
 XmvOARgW9Kd9SSVxBI9F/X+TjZ1V5tVvWKEVeKECBRJZ5YpsNevf0ByZV6T5ToHav7vY
 q9yI4fnczzMPq1ekJck95rZM+3ZQk+hzhQRviqT3rY98MaEDHaDpqWvF900PWuhtiJ58
 9pi+1VOlWeMfnsKyEyPRJyzwQy8ev76DqPeYCEdqUdgsq0qrxLmyYVN52dhnFVpbQZKB
 tafQ==
X-Gm-Message-State: AOJu0Yz3Tgay/FWinm14OWGfnMvYVrZUZACU3ry9/Z0O/1PmSrNqdkh6
 a2u63MowT6Uwf1B0c3zBH9buVhb0fGQ84S+5LrqNBa3QBlxUmigKvx94kbhOBcE5lzA=
X-Gm-Gg: AeBDieu75kBE/tR0zIwcQZqQg96keW7dU7xVlQsF9nXHn5fGO8MkJeSmYLs/+9tFUm0
 WO3Uygiq138k2TBsggmIWEKgYyQ6OT30tX/KXyp2wIS0DnFjTW7NwNSyPl3YHhY+KWIFOBhUoRf
 5sy4jOyFztnRAJ/z8VdCaFlna7f8G7JRp2BMwvydvVRVZmg54jG/CYJHH9gyXa6Z8/LIeHaOKlc
 KXGUkZReahZPl3wdmUG9QlPGD/369hhGINLjwWeMbxk0hPbMi+bed9cuoEV2qx/ESo1mgkOdif3
 TDzRE/K7kp7aVgNPQWWwUeAwpPfQLFiWpBN5OimbOu9+CSANKLwBDb37fkYad11JRgALyGqBEBP
 d9Yix4hqXeGY4njoyl6PEqh0QZ9OGqxOcqRbYgKKV3pm9rpF827iPYhp1sJDlL3D569mzGVmtjA
 flMpMmB3z+0GzHqEWwkIJPQD2tmu1zuMrGExbAM8NXQOOrrlPecdpfTdzK8fUhEI4chL/dCFXlj
 fIAMaXaCSI8J88B0aouQNPpkY7Y4RJ2alvcUZHwUQ92LhFum8UBHorpcEqJQg==
X-Received: by 2002:a05:6830:6ad3:b0:7dc:dbe4:3f20 with SMTP id
 46e09a7af769-7dcdbe44013mr1215216a34.11.1776783818006; 
 Tue, 21 Apr 2026 08:03:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42fb269f69bsm790237fac.12.2026.04.21.08.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:03:36 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:03:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 2/6] bloblist: add helper functions
Message-ID: <20260421150333.GC3036003@bill-the-cat>
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
 <20250718141621.3147633-3-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oqAal4sxuPbF2lX6"
Content-Disposition: inline
In-Reply-To: <20250718141621.3147633-3-raymond.mao@linaro.org>
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


--oqAal4sxuPbF2lX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 07:16:15AM -0700, Raymond Mao wrote:

> Add two helper functions for:
> 1. marking a blob void
> 2. getting blob record from a given blob data pointer.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--oqAal4sxuPbF2lX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeeRxAAKCRAr4qD1Cr/k
CswPAP9chRPzRvdzW8y5WYfkE7b305L9uN9ReeJsIVSdNgnh6QD/QTa0mjfUO2mw
x+NhybFkHyi22k2tAdGHC/Z8Yxx7HgQ=
=TLDy
-----END PGP SIGNATURE-----

--oqAal4sxuPbF2lX6--
