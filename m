Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F920C25B48
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 013C2879E8;
	Wed, 25 Oct 2023 01:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dFhWqVOf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74DC486FB9; Wed, 25 Oct 2023 01:16:30 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB23A87994
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a7c7262d5eso51748667b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189378; x=1698794178; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=12Crsn2clBEa71ryNQEd/4KM8D1EqX7FuPhQrAdZKmI=;
 b=dFhWqVOf6/89cxlgeeeU17qn7kceBP3mV4Ru/Kq/w1XRLyPqdNeonvCNAXc7vdIUsm
 h1S8Eovb9m5vowk/GS4u0DZIg2V0WZ+OA8moe7S2etvXFa0USLMac0OetQO+20G6LbOn
 hcw28phK8I3995s/XBSMRa4FHGaSTnBTJZ1Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189378; x=1698794178;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=12Crsn2clBEa71ryNQEd/4KM8D1EqX7FuPhQrAdZKmI=;
 b=dl24q65D5G6zKzrFOYulyTywDXuJ0z9cTNAP4bmhAoBrtDAI8O+vj5PdJJhW1wDeer
 iarn5yNzasMnGadFoqxLBYHXOaSAtI0ugf/zqbA/5lN8lw4Waf8Ze1PNpb2f/p00tUOc
 h8ZRgoib576QlWIR8aFE+wTBmoB0ax6IZcA8rG+jMJqAPkbezMWU+hNTMTST+F9pNXVS
 QUIjlZpJsOgp0pdjVWPncAppOoMQ/3EnAKQ3m+o7MuIZPEnH3wm/By11EASrlhMTiBfF
 BKQDsE3n7t6MchHAGeC4ANwYCHdJ2+fE+IGtO4j4DRWm15NHHeYZ4m4aaJp3UxdcWH7/
 xpmA==
X-Gm-Message-State: AOJu0Ywy0+ET6XHclZBRtZligDQ1OvHtGVkPzLHPUeYbp5sKvyrwhICT
 IJ94ye0zEEwBIThoo6t4eO7NOuTTpUJMh+NcUUYpRg==
X-Google-Smtp-Source: AGHT+IGIn9586J7zeTRpQNr8QGpphHag9cRgYiQoGeSZ102oJ4NOMKquWrxrSNOffLwyDDpdTeWbJQ==
X-Received: by 2002:a0d:f3c7:0:b0:5a8:205e:1f1f with SMTP id
 c190-20020a0df3c7000000b005a8205e1f1fmr13310819ywf.17.1698189378220; 
 Tue, 24 Oct 2023 16:16:18 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a0ddc05000000b005a7bf2aff15sm4510462ywe.95.2023.10.24.16.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:16:17 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:16:15 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Subject: Re: [PATCH 7/7] riscv: Remove common.h usage
Message-ID: <20231024231615.GU496310@bill-the-cat>
References: <20231012230359.2005249-1-trini@konsulko.com>
 <20231012230359.2005249-7-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GgkmK380dvOVB+0b"
Content-Disposition: inline
In-Reply-To: <20231012230359.2005249-7-trini@konsulko.com>
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


--GgkmK380dvOVB+0b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 07:03:59PM -0400, Tom Rini wrote:

> We can remove common.h from most cases of the code here, and only a few
> places need an additional header instead.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Rick Chen <rick@andestech.com>

Applied to u-boot/master, thanks!

--=20
Tom

--GgkmK380dvOVB+0b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UD8ACgkQFHw5/5Y0
tyzFEAv/dBV07r1PDPlchJHzlNhU2B8vO3pgAfX03D28c55SdJAa9Xy7YYZebKrR
C0XzypC/5drHGfk/D0TULpw1JsAn5cqLCRrNmhDIyWHMgWMrHIu6vhYgWVoFnQvY
2CF5WtRFZibvOABoaoPB5ER70XmK5tMzF58kvHat2g32ZUTR3mkxa9XVz+rScWqM
yK1aVYuhwKnJZO6ENoP8MnqydFq29SgMrdcbPYhJh80CtvhwpfSy0aQIBwqjDC3F
FQjMu0s/1KDpydrg1shNC3H61dC/+gOMW/DUew7FHRzVB2Cvo+bAODe5x+eHuBEI
pGRvu43tduNjXBx85yQQm3LPi9hu/aEAJ+tBD3B+aCXyvn8sD/ktjc/vPgC6YXJV
Nqrb/PYNVP9bBX1JL9OmBq7Dy9yIAFU6Dsfkwi4uxKmEpCwO/sDgB/4aolcp1esv
OvdINbShBTlpJBP6A28C+qGCZli9RROD55/xS7bwOWxTr+Gj/amo9NoKs2cUSlaG
nDP9JFGt
=X/Cz
-----END PGP SIGNATURE-----

--GgkmK380dvOVB+0b--
