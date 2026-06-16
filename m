Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED2CCD98E3
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 15:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D31D848A2;
	Tue, 16 Jun 2026 17:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qB2O/r55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0635A848A2; Tue, 16 Jun 2026 17:00:47 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF3FF84869
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 17:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-69e8d815c3dso1958919eaf.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781622043; x=1782226843; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GRP/r5rv5K3jBzVxQ5seXi1zvv8J+JlGqfutCmg5CTk=;
 b=qB2O/r55IChNZYNa2X9A1qZghe/S9Y6tmx5XyemS/CaA77yjEsQ+bN+BJ/81jQB2nh
 YBhb4VvmkmMoS5O3deuAQtLNl72fS6ObSSMhV/lnM05Iq7clGFeFP/elJhrdIORUm2PW
 tam9BvqTclnMnEhm9eiSiRZ4axU5Cgb7hs0mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781622043; x=1782226843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRP/r5rv5K3jBzVxQ5seXi1zvv8J+JlGqfutCmg5CTk=;
 b=hKe8vvT49ZwFvPgaoxLg1Q5eYZEN9yZpii53zGtkX9oKtCP3AuTYhsd9FhDHCija/J
 aQfShhJJhEVWQ1gI/f3PnNNO/gugltxSBHOcsoSKimRvhgnM+kFJHt3F4h3mjoAerlHK
 H1bINhsIBcU/ydo8zjNrEVRy8UO78psj682QqH532P4DKq5gHIOhlSSpj6fHnrgHrwR2
 QaYqMA/8L0hCdjUoZdm/QQdbK6CY29fk/j4hC2RvmnRyBfhiKpzDZUBowlrc8dGr3kGJ
 DclqJlwhci4JO2nda9yFOTkj1ueSsAymL/PgdxjpA0FTvFqEXCWOwcDP/ao/As0tuEZg
 liLA==
X-Gm-Message-State: AOJu0Ywqsbfgocj3krc/o24zSeFr0uFHdQFVtiPNCLV616ZQwhh/LMMk
 7yg5g31O/6Tz5LJvm20TD+WMnDmomlkscSbecxoGrjJDCeAlqeHeLCkj+Jx4hft82Eg=
X-Gm-Gg: Acq92OEE11j7bo/ukNdPGDJiLv+xA9GAFYIu9IZ9TImhNnKuubKwp9VammikoMQmRIx
 ilEcoLH8RqTgf4Dr3UGU2ZPqRmxdNH1pgwX6CRS0vb0L8m2FKEvcHvvV5S+zpR0/h4mxc4f6O6i
 /pA1nEJ2ixu/h6fjjwc3PLdgabdzNdva6/FFZiqnq8uI66c/uJmmCvz9/tdc1PnrQuu4s25MBwX
 xRmsNZg9qd94IRtAwEq6Qi1IeWwKAA3+Q4QgSsz7BbWlUsAhn78zzdMZ8ozxM0pk6dCsS/atZk2
 9CZS8QVxYwFxCowsc8LOoxOti8Jp2duAGyVzqLmKoVwR3RKLbDWiw50OzVM40N6KJLBp+9UpRAX
 etiCSP1xyb0uvhx3Bb+BHpS0OeMUz75H4kDvf4VghPCDKOeCNSnSBBQMGsNfLdM5BlsglTkBeNU
 21PAh9FARTPgzz1rR3hdFWRQ+7iTx9vPQtD3ysz6BbwGqjz2rWL65vKHDfks4VuyAeJv9nGDlIT
 hfXD5bSzVQgu/hmTJ+WGa9Rfbwkr1edkaoTQvWmBrKYBE+80/4H5n6WJR+fiA==
X-Received: by 2002:a05:6820:2217:b0:69e:b7f4:2a14 with SMTP id
 006d021491bc7-6a0a4043348mr2774162eaf.26.1781622043493; 
 Tue, 16 Jun 2026 08:00:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69f00d609e9sm4770314eaf.7.2026.06.16.08.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 08:00:42 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:00:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/9] patman: Replace the tool with a stub for patch-manager
Message-ID: <20260616150040.GJ382693@bill-the-cat>
References: <20260616142859.54136-1-sjg@chromium.org>
 <20260616142859.54136-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D/t63jXzSQaMPk93"
Content-Disposition: inline
In-Reply-To: <20260616142859.54136-2-sjg@chromium.org>
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


--D/t63jXzSQaMPk93
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 08:28:41AM -0600, Simon Glass wrote:

> patman is now maintained as a standalone 'patch-manager' package, rather
> than in the U-Boot tree. Replace the command with a small stub which
> tells people how to install it.
>=20
> buildman still uses the shared modules commit and patchstream (and their
> dependencies), so leave those in place; the patches that follow remove
> the patch-management code itself.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

We shouldn't keep a stub here, we will tell people in the announcement
where it's going and give existing users time to migrate.

--=20
Tom

--D/t63jXzSQaMPk93
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajFlFwAKCRAr4qD1Cr/k
CrjuAP0Wfe6sBAjjwAO2mNFiHBJt2eckyrOqZdbG0LAQifvAjAEAvbqIQ5zdoSgH
n8IVIvdJry51z4itV4nnw34yC8IPRAQ=
=iZXA
-----END PGP SIGNATURE-----

--D/t63jXzSQaMPk93--
