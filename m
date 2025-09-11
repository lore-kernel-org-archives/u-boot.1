Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C876CAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 15:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAE4083390;
	Thu, 11 Sep 2025 17:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JlecgpwT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64BBC833EC; Thu, 11 Sep 2025 17:59:43 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 421878334F
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 17:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-74c1251df00so507655a34.0
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757606380; x=1758211180; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y8Skp186vqTjXyxgAD9TkNZQv5ND2CDjibXsFbq+CZo=;
 b=JlecgpwT7ft3ifgNdu8mHNyD1PT9yq91y5S8sxdnGLxhc1pvl8ekR7W38WoJsz/Jue
 YT4h7p6GOwukXMNmDEox9TCq0CquoHMirJMlTTFhAJKtVLn1CBL+CvyGXU91ZxPVutSh
 7Dnd37MUs3F87SJ8SZ7elt65i/ApELnY/5cLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757606380; x=1758211180;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8Skp186vqTjXyxgAD9TkNZQv5ND2CDjibXsFbq+CZo=;
 b=oZbwDuPTTUyKPqTC+y4C1aaW9Ob1+gVapLvVbLlMZkka28RCnM1tZsWemwgLGddmr1
 8K40iEKdjIeW8ZuCFypC5WUJotUWd27l+TAX1+SWHz9MjTCXXTv3KMRUbbt/1Y5gIMRg
 //YYb01RBk+OhBwJmXW06lQycuyMT0BHHjA59RhPO+4ErxOeYTl7IScy6DYVQFl9Sd+x
 XeQypItVCBgm+gI1S4fseFJq4PuwK8PV3kyGa1fILZ7SD3Xu6k0ldMuSshVOxXWJrRTE
 an1sC9I1W3UobKifPrsu3lZ8bRYqvr4YTP9XV2pbJy74ozQQ2x2Lv4lODWs0BR41oEYU
 CWsQ==
X-Gm-Message-State: AOJu0YwNI6YOKVikBxoDMiCdjKIq1eSSirVmjygvDbNELRFCzuWXTlBI
 kPBM0dxl206zXLYglcxPrDpGXTeQYzR5DxW2lzxCMvx5lD7iqtj+FVZAxQk25IR2I9w=
X-Gm-Gg: ASbGncvGZ4RnIzCNuPbusCWIBIAQKol2xukIzw6zuLnaNLXp7pLlOEPAmIfr+dyEGpV
 ZLOJVl5t+uaq5UK814kWXFr1Fyo3InpikZH7EQ/qQK1voV1BaXYdZvW1QhAwwi5Kz/SwqMAf7vW
 odZn/6tT5eA2BL76Bz5dwUN6eaLpS44oBMGuKQrFqQk3R3KVVciylAvdcJeLnlAiojKE/iJemV0
 iYd6V932SvegcYRyDzmKIoj8JMxo82V2Sm92ThHPx0pbh3PbTLFT6eWaigTxWwSR5dwtkOpHLvP
 LdO1+H1CgBX8q/jbMu7Z9YzfaVnN78jEft8yJMP1pAyp+afakRkeCeUhBlTkXDC8Vai79YMSCjE
 PZbIvis96/0fWBQDnP2I9+JJn97Q40mOimIPeYWuxMjxEjk9f79gS41MQuSbC85zamzk=
X-Google-Smtp-Source: AGHT+IFj+lKJFTobWFnqcOyJ7jW4vXt4Sd3Xotc074noLfKzJW43xdL4YSlPNaMyyHo1nk132eKGjA==
X-Received: by 2002:a05:6830:2a05:b0:745:a41d:22d3 with SMTP id
 46e09a7af769-74c6e47b21emr9922775a34.4.1757606379964; 
 Thu, 11 Sep 2025 08:59:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7524be7982esm413841a34.36.2025.09.11.08.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 08:59:38 -0700 (PDT)
Date: Thu, 11 Sep 2025 09:59:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Thiery <heiko.thiery@gmail.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Michael Walle <mwalle@kernel.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH] env: fix config dependency for
 ENV_OFFSET_REDUND_RELATIVE_END
Message-ID: <20250911155936.GP124814@bill-the-cat>
References: <20250911093223.65323-1-heiko.thiery@gmail.com>
 <20250911153154.GO124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9HGUBAwLGxTPbmvD"
Content-Disposition: inline
In-Reply-To: <20250911153154.GO124814@bill-the-cat>
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


--9HGUBAwLGxTPbmvD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 09:31:54AM -0600, Tom Rini wrote:
> On Thu, Sep 11, 2025 at 11:32:24AM +0200, Heiko Thiery wrote:
>=20
> > Since commit 5fb88fa725 "env: Rename SYS_REDUNDAND_ENVIRONMENT to ENV_R=
EDUNDANT"
> > the option SYS_REDUNDAND_ENVIRONMENT is no longer available and should =
be
> > renamed to ENV_REDUNDANT.
> >=20
> > Cc: Marek Vasut <marek.vasut@mailbox.org>
> > Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
>=20
> Fixes: 5fb88fa725d6 ("env: Rename SYS_REDUNDAND_ENVIRONMENT to ENV_REDUND=
ANT")
> Reviewed-by: Tom Rini <trini@konsulko.com>

This is the right change, but the wrong commit / fixes tag, I'll correct
when pushing shortly. Looking harder, when
ENV_OFFSET_REDUND_RELATIVE_END was applied by me, Marek's series to do
the rename was already applied, but it was developed before the series
as applied.

--=20
Tom

--9HGUBAwLGxTPbmvD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMLx4QAKCRAr4qD1Cr/k
CpNTAQDDUcIWkdrK7yxeN/tG2twXrhvhSdzc9qjXRDWXe9aSKAEApl+pD++LugqY
eGq7fGBS/0CyD5qWxpS+Y+tvNRRBNwI=
=D9R5
-----END PGP SIGNATURE-----

--9HGUBAwLGxTPbmvD--
