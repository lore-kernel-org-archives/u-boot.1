Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD5CD3E2BB
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 19:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80276890F6;
	Mon, 28 Oct 2024 20:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cX6nCRpD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E5B3890E7; Mon, 28 Oct 2024 20:33:17 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 127268904E
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 20:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3e5fcf464ecso3161253b6e.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 12:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730143994; x=1730748794; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I05Kv937y+1Vq+3BvZkCONHHJcdQQ++sE3zByupu0ig=;
 b=cX6nCRpDlT4Mhg9fETMSU5vUecWg7JG76ACysEos+VeonhGCUsQ5wPvgyHLpfw6C2U
 O4XAVNiCQ7G84Uwq5On+4yQSMGjIkI+UResKE2ymiFkJM5xKgPRr+GsFDKJ4ZOoNbUIO
 RDjMTdNgmjjLqEF4PMmpYYvlqoO0e6jROTnN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730143994; x=1730748794;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I05Kv937y+1Vq+3BvZkCONHHJcdQQ++sE3zByupu0ig=;
 b=G8RNBD7hHLYRsatnV31sytPsLSGoU1wB+juoMAU5/ZnYWNxXqA5jYcWkghpB7GwQNM
 a6BrydLzO4EOqI1av4FQPwDh0rM5dhqbPbsFujLu7+JUDQoqFvIpMTrLt0rOS2/QLM0d
 Pyp4IKO+OjQ36BW4pCdyIQ843LliYLGTPPgXxDvy4uT78841DxlqE1vZvhkMqko3Y/oE
 c78poQ7TufwzlQ4zCeEafKR+nMZkbjOR/MYEQlBl3h3cM5MaWbjBbjJvJggN6QrAS69d
 Vw0bUn7TRnHPFGAkerJrUCrICaTZQy8dmnKCyinAHnKe7hEA9qSbyuejUBivfVAuA96F
 8Ynw==
X-Gm-Message-State: AOJu0Yx0ejKZ2Gl1SLCWf2cm6w8L9S3bOd069ukKOx+Jo0Znw8ndkggE
 x45AKAYzAqi21ucmF/9u6hR7zkYWjnTsIYOBiDXNlPZx8fe/L89I7svY583WnRI=
X-Google-Smtp-Source: AGHT+IHtynK4LcSQHp63mwNlelTXKVHkDHDavDXtyUkqkB+w9s7vpAUIQaEjbbuHB/hoG2pMS3HOfA==
X-Received: by 2002:a05:6808:14cb:b0:3e4:d6a6:546 with SMTP id
 5614622812f47-3e6382488fbmr7677298b6e.15.1730143993831; 
 Mon, 28 Oct 2024 12:33:13 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17984fd62sm35508526d6.5.2024.10.28.12.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 12:33:13 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:33:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH 03/21] bloblist: test: doc: Move into the common suite
Message-ID: <20241028193310.GS4959@bill-the-cat>
References: <20241028124130.32072-1-sjg@chromium.org>
 <20241028124130.32072-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WXMJjUZLr8/FlzNV"
Content-Disposition: inline
In-Reply-To: <20241028124130.32072-4-sjg@chromium.org>
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


--WXMJjUZLr8/FlzNV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 01:41:08PM +0100, Simon Glass wrote:

> There is no particular need for bloblist to have its own test suite.
> Move it into the common suite instead.
>=20
> Add the missing help for 'common' and update the docs.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This feels both like churn and weird. I would think "common" tests are
for things that are kinda legacy and too catch-all to have their own
subgroup.

--=20
Tom

--WXMJjUZLr8/FlzNV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcf5vYACgkQFHw5/5Y0
tyx4NQv/QCw6NRjeJaanVQrYtrytpYfppZHi4ze/0vDnVr13TWFuJHoWYmmxCHhy
i4kfenrUQudcIIvt2lZFYso7u1PZRutGMtZGTdX+jiFbBXmanKVxOMJQj0TLLA3W
Q8lQBTHj8N/NxaGJypb9eV/jV/7h98dkZIf0dwlMXygfFqLU38yMiKVB/L0T5z2x
5ppXQIs9GJEY0Eq+nlwXSWjCkmaHLo31HttGTQ9/dRn/OdXaP5ICuoh/HJ7F4Ryk
xuSB0rth+vqJx5mkP2ySnC92QX12zvxiZ26uSun3YzwS+dSoDiCySmWVoMjxse9E
D1OVKqo2BF7XLiViMm6lp1A7amL04l2TPPkz5aub/Hj6ntGoQcSEqvb7aX4eAvdt
idMVAr5Q4u/i7iLWhR6Btp67ELm7R3IyxlVnXQQtrdSur1ihDW1qlyWwdqrT+MG3
60la8bBjQbQ91bIy1QjGbcID0gJoHJQKS3z/jvcCN5+eI945VJAuRm8bFeoakcuO
AxkA8CJx
=9Ubi
-----END PGP SIGNATURE-----

--WXMJjUZLr8/FlzNV--
