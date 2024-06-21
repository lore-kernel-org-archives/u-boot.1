Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CCDC2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 15:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B3678853B;
	Fri, 21 Jun 2024 17:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="haCDuXVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A108853F; Fri, 21 Jun 2024 17:22:46 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 732CE880F1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 17:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d23a0a32afso1051156b6e.3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718983363; x=1719588163; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SecO/F4k59ZUOJ7RWmPt6Qndepo72qCXSJdmNfOkb4I=;
 b=haCDuXViAyXSLDCt8jlmskD9N3RP0dthzjuX87VVbixxWewRLPZYbnJPATN7b/6OZ1
 lmORnPUYBDy8CKSvKLRC6O6Cw9UXp/zFLT5RqNJYEt2WK332aGF3qgAglt8/Yq+84zIj
 GhSObOh1S8yCGFh1teY5PePfTzWWYR/sFoJVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718983363; x=1719588163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SecO/F4k59ZUOJ7RWmPt6Qndepo72qCXSJdmNfOkb4I=;
 b=RcE316/un6ESsTZYWZHKKVcW3V5FUvHw7jw6GOussNkmpUIZb1XZKyZ8NpkH8yoPTR
 IiBMstvC1jPsiszB843WJoJjBt0QkMyiPxW32dpVasdj8a/6sJBRRDqHWLmOO6YN+hKf
 /XP2V1AzlBnpL16CJWxhj6DO/oWhYrTg90Y03X5ocKB8cGYofd4ZmwbKpd25k9v8ICi+
 5D9En+eZXjMbaVPGA9i3Oby8ApZUSkc4xk5h1AcKdehzRCQ1GfDksChI0WORdYWhNZ6P
 IgAo+Dk5TvMCp+VzyqpytuTpFXyN0HMbzdvuX8zVRa75IOUBQb62NqjZ7YOE/JmgO1Cp
 5opw==
X-Gm-Message-State: AOJu0YyESoXvL0SpegDDlD0IxmZRIP9VAf5DJ6AZsw+hP7hjKNfFQi+9
 4u2f/BN9d0rjvTDu+yUT1Y3wf1cOezirfxuTTkBTDwGDfOmt3QtxrVOPXTuDdk4=
X-Google-Smtp-Source: AGHT+IHFOB1b5iRDqWSadOHGADmVGfPFG3ZcwxAiTn6ODUH8GssumsSxrSEGcCn7rwQk1ctZjeulwQ==
X-Received: by 2002:a05:6808:1994:b0:3d5:2744:d0f3 with SMTP id
 5614622812f47-3d52744d32emr6421371b6e.27.1718983363174; 
 Fri, 21 Jun 2024 08:22:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d53886a628sm147031b6e.13.2024.06.21.08.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 08:22:42 -0700 (PDT)
Date: Fri, 21 Jun 2024 09:22:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH v2 2/6] buildman: Add python3-pycryptodome
Message-ID: <20240621152240.GX68077@bill-the-cat>
References: <20240621131423.2363294-1-sjg@chromium.org>
 <20240621131423.2363294-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7nP+147CwhANIxDB"
Content-Disposition: inline
In-Reply-To: <20240621131423.2363294-3-sjg@chromium.org>
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


--7nP+147CwhANIxDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 07:14:18AM -0600, Simon Glass wrote:

> This is used by some Binman entry types, so add it to allow more tests
> to pass.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--7nP+147CwhANIxDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ1msAACgkQFHw5/5Y0
tywKiwwAsVjLH+3jOJdenjHKookm+blI2L3CP2Eyb5V1Af68p1n46ACSI3D8pC1l
l/OEgJASfs+aau9Hh8xGMZ2k2+IsJ9cdb8MwCYGs6nd1x2x+DN8EU4YrViQCEsfd
llG9t1mcKhcgYXuaH40h72B1hoXE0+MCIPcF1/jVooTBM+gwHgeru9x8qHyEXqaz
kriOwb/eWddnFXLCQBCwbPvahN2OhJgV+E0E2fZJhfPQuZyKJsJtx3cunID02Y7D
Nnngo5lt5eK02qV5QUCAVPvVNReActyf4AF4ieUBQ0Ae+1DQjvSCeff5zCwp9VUY
1FaMLPGS4EdJU0Bwcau6SYPKhtMErZZyMluTJL2GvJ6MCLUvfR0LZXY9ZlA580Ug
AiT8jlPWgLQe8njNyzoItjnyg1laM6SwsmGEhmui2POkal8ZbObmO3F84Ywp8SmZ
+wQpQgmrvzsK85s6ImmaQ84foPrlsityXEQdPC92Gt3eK/EnZ05IOZtfGN8+OOD7
lHldMtFM
=ygMI
-----END PGP SIGNATURE-----

--7nP+147CwhANIxDB--
