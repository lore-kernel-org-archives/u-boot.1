Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080B2CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 19:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 967F984911;
	Tue,  9 Jun 2026 21:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tB6GqB3p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FEDF84911; Tue,  9 Jun 2026 21:02:11 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E9C4848E2
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 21:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e71198e0adso1650319a34.2
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 12:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781031728; x=1781636528; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5+a9UA5oH2OMn25z0f2ANPyohkP6yB6IAcBsfP8IBwE=;
 b=tB6GqB3psChB6hcehGNFdUcmmXizEndh42a0uJY8Co8sNdxmOuHM3aJ9yzPdR0NSHP
 4Bk2ewIkpsgqJsLj+4gVf2jNGYvuMjNEcad8AaQmYSPUMwYLFdnUYe7BznIEqvz8C4j5
 mX2rL6mFuGEXBMz7MQsdx8KN1WFDexS1YDY8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781031728; x=1781636528;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5+a9UA5oH2OMn25z0f2ANPyohkP6yB6IAcBsfP8IBwE=;
 b=rzS74fxUSPA8aDmRth4pDKfHKYA43CvovfZW8Q17UMDAMNL9RUfTumq99it515Ixoy
 0iQLk+LYp8qCWZ0JoSlfIC4cFtRUs+uCNVjm8T+x+GHZXc3twE9GcFlgMyz3cIoylI/Z
 VP3/KQDv6rOdGjsNJCmY+R2zlYOx3+HJJLFcM5fBNK4hl2OG4aV5t721V8Zv2mxa8nJ7
 jOlNyctA2gs3WEJIVLhZDWkQNqlGn4IqFSIlDoExmgNaepGipCpwkcO/YyC7GA7cP7Ft
 XHf7jWfsuSWGQKNRT+4LswrKjItE3uxxsMksR5t3/hGB+AdmFyxauiaUR/cJKzB/d8pz
 Jq7A==
X-Gm-Message-State: AOJu0YzXPzI/Rn6xA7Yvw/2yr9AISif1aJSGb/igWl0wcxOJ9Ki1YKbb
 GHeydBDw26O6Vp9GJZMJs8gM6YrtwXpLGcbzzxFyDDmukGiaUMrkC9X8Z/0olzrg8RY=
X-Gm-Gg: Acq92OGmjibRUBWB8qdrMNDrySAJ+ETJtWfKeldsFRPWcoqwqKNtqJcc38fp6MisfsX
 dolj37pF5PpSJdYGUncI19dG06RPEkW87dcpTRpcGWYEGHLJHoIzXl3xGO6M06QK3FIBOtfyvMq
 1Nj54rK3BjcjqOHlVuZTRFAnlERcjArGfRUx+sDsAJ1qDmokXZU+V3VhYCWI2I07OZ77Xfqh/TL
 4XhS26UIG/9BTmucJ9anSD6DI87GILvyC0iuCgT9ZsQMLP+zqTVhswC/w4Nq4JfgOUvYXOsVn+E
 rIh2RidEub2DBbhox5RqeRiWHbeiPYTvWYdJTSw31mAOPVKDa4SbSzt1ZfUreF/k7PsqRXPju0P
 8lUXN+wD1rjcfrlAO1MQGANb3F4hCJzZXfy82TIc3fhqBbCZ6SQsaJ/nvUWsPG4R1gfqsnO7rwG
 HrDvjLoyJfWGHIm0Av4CLxpnLuTsQxoZi9U5L9EdhUBb0vcOmRuZpNs/7bUGerXNsGw+GEsfZ+C
 3Evqd77L7tBatEzE/+kbzo6Z6DG41vbHC3TiZPl9c9A2H98pIyPoYA8E4PzRQ==
X-Received: by 2002:a05:6830:4acb:b0:7e6:c9eb:535a with SMTP id
 46e09a7af769-7e70c64fc5cmr15201737a34.6.1781031728050; 
 Tue, 09 Jun 2026 12:02:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e71fe69esm15541120a34.0.2026.06.09.12.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:02:07 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:02:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 7/8] Kconfig: arch: restyle
Message-ID: <20260609190205.GA382693@bill-the-cat>
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
 <33cb3c5e-785f-46da-8378-bb562d71b312@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wag+63zr9LNrlOzB"
Content-Disposition: inline
In-Reply-To: <33cb3c5e-785f-46da-8378-bb562d71b312@gmail.com>
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


--wag+63zr9LNrlOzB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 03:26:19AM +0200, Johan Jonker wrote:

> Restyle all Kconfigs other then "arm":
> Menu entries   : no space left
> Menu attributes: 1 TAB
> Help text      : 1 TAB + 2 spaces
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--wag+63zr9LNrlOzB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaihjLQAKCRAr4qD1Cr/k
CsdcAP9guS9QzK2AFpvEZHShMx+Ep2J4g0kf04D9ju4kSX2jtgD5ATklEETOr1Y+
gTPsdttfyftZq18HhV2fK6G/uylNqAg=
=CTvc
-----END PGP SIGNATURE-----

--wag+63zr9LNrlOzB--
