Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5817ED4977B
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D477088E00;
	Sun,  1 Dec 2024 17:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X/iySBYs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BECF89137; Sun,  1 Dec 2024 17:40:29 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 538E088DED
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 17:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4668486dec2so25355221cf.3
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 08:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733071222; x=1733676022; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wdy/LVWy/z2hafsaahrpjdMEqYuzu3f96I7LluCipL8=;
 b=X/iySBYsP3eMg6o2YLqt74kOKdade+NXpKHnOgdzAbWDL+ncWpOIS2r6V54q6oqoHs
 AXt0RFlsDHU3H0AATIwr0yWfo/2vWdz9U4p3isJr/hYKRd2IBuzoxhQm+VtxBYC3pWfJ
 U3kqXA1oWcn4ZD38xzlIm2sRKpMCrUgoaCkHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733071222; x=1733676022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wdy/LVWy/z2hafsaahrpjdMEqYuzu3f96I7LluCipL8=;
 b=iGRFX1+lStzKT3HJ9FwwgRjRsJmAKepUnb2iS3aa8zTVlM+0OrJYaUGdMRVl0MDA0T
 w54KIm8eI+Ow/lWr1cSEProKJes/RmEB6oSKQy37rr6WK7wiJ+/b/3RUY6Jd0DdcoTpy
 5befD7/ZGbYr3TmleMnd+exvBDgnTg0OL5VMmSNJFz+3/S3o11OjMISNfkWTbDWwfYL1
 d8ETgOp3X9m8P0qklHwAaw9EY2nfqtPC7PbgnyyhqcVSz2NVh2+L+Ak4IB2j5JCwikRI
 RkjeFdre23q3zhMKk05fIrX7ubf5LguGTMLtr5MpuloHYBaYCh3xLdNuNVKvhpA/EU2g
 YPYg==
X-Gm-Message-State: AOJu0Yycg8aAoov8fg9FMBqfniCAfdVqhkiKEWRvRzD8AEMp6zReBZ3N
 OT+Q4yVPEFkieDeElhkkJOvUrElIkJyf6PJAr/gveSQTSpQPl2K5tG+hftehwak=
X-Gm-Gg: ASbGncvWbSQwlkaGObs8LGhrJaYZ2hnkrnWuyWd8XbrihJbKuwmiKRRjEVkzbSFD8KD
 MUdaspIt9grFwMUjB9A4EsDvOzVKwGqM5mHms8T4Ao0tk4xuATJWHDoiygxM/ThN2aR38vpoOf6
 Rm75pvMitvfTA5Yr1Dz3nyBEDMAd+teOyoJOAqjFkPLPbbGnnP1Fc5EshfgVu3CdWPoh+RbHVvB
 xmHb4RDrWI4MQWMWWXreVjn7kHMiIhcycvZkIsvb7RXyn0cKA==
X-Google-Smtp-Source: AGHT+IHeD6xWWgbqY0SXQ/XYjyMkXd+4Oqp5OrCvoHn5LETBrVFZjvht6N9v1FTFgENKCc8DlHLnmA==
X-Received: by 2002:a05:622a:5d0:b0:466:9a2d:7c20 with SMTP id
 d75a77b69052e-466b34df56cmr278891831cf.20.1733071222038; 
 Sun, 01 Dec 2024 08:40:22 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c421e42fsm38933911cf.70.2024.12.01.08.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 08:40:20 -0800 (PST)
Date: Sun, 1 Dec 2024 10:40:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 1/8] CI: Drop extra condition for sjg lab
Message-ID: <20241201164017.GS3600562@bill-the-cat>
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="khcUZUpX3dsMCNOM"
Content-Disposition: inline
In-Reply-To: <20241201144240.1664398-2-sjg@chromium.org>
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


--khcUZUpX3dsMCNOM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 01, 2024 at 07:42:29AM -0700, Simon Glass wrote:

> The rules part of the template makes sure that this doesn't run until
> specifically requested. Drop the check in the script itself, so it is
> possible to trigger a run manually without re-pushing the tree.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

You don't need to re-push, you can just manually re-run the pipeline and
set the variable to 1 on the webpage.

--=20
Tom

--khcUZUpX3dsMCNOM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdMkW0ACgkQFHw5/5Y0
tywzJgv/dgQ65fumiWEkDYSWaHmpGold6YbXpaMH8LZPhkFF4pYhdEpGW5TUjaG3
0LrDIx/s7Y3q4x4HyWYgFWndZwmZHGCTrkm1YBdioc/jjLcJ3LxXV4dX953IS83Z
yJmGlgInMMcI5Tsu3t14WDZFni0jGfd6s4GN5tydhZ4A4MEHqznaEE+YI3CeqpV5
4bNgHxCE9pV/dnSYXeaJ0o91jH0Mofm3A/WAK1FZmtwRLscSKamUR31B0ujDU5WJ
L+lTNkvLbmFTMkcpJ3g08QBktns6mDApHyv6LQ24m++xzUZ+jf0L7UTfqm+jldsO
grTsdnZIQp7vWjotwae4IYlKwcne+8vYl6G1eFHda4wbQI4C46Vry+0hjUQ08gvk
bXF+MLSAbgPxWGDqlxWZl4JF2n96rfHHHcgGohVzGOdKxPd6UTAZyA8N0RVbEJen
+N5ibN36Dk9VVQ1RuD6A60uednpwZIP+RTM1JF6XziJHiFrLUuKVOjbCXUVnaZfO
gb3D+gYQ
=GXy3
-----END PGP SIGNATURE-----

--khcUZUpX3dsMCNOM--
