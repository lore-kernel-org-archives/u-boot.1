Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBF2C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E1C871BE;
	Mon,  6 Nov 2023 17:33:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UoPTxNWj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E12F87163; Mon,  6 Nov 2023 17:33:55 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BF7B86823
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7788db95652so327917485a.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288426; x=1699893226; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PL141gKZsz9Wy/k9X+WTOuCM5ZZmiyQRzRUusc2levA=;
 b=UoPTxNWjkrlTOjjWYUV5spUCwmiKgGGoiOG7I7L6AfZGNn0DQKgZ1G7QAHtLXPA6jy
 Bejizhv2tP7nLLFx/yjtLoF+2BoEHUqJ3MLSAct94Q5uu2cuEQXi53FsFfHcsxvJcOII
 8R+v13D8A2VW7xD99OlYrAAIBXJGZqxO9fiGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288426; x=1699893226;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PL141gKZsz9Wy/k9X+WTOuCM5ZZmiyQRzRUusc2levA=;
 b=ECf95l0d7inzY/0YBzH6dOHVpKXrzlpAy/k71C51xIg+hxQTAi45UtenIqIqtrz/sm
 k+YeRiOBgOCdxWCNrfW2Np8Q9aMyee8Jnhqrt5B/QZR3nSgfe+2xEnuR9aBlzHTkpbQF
 AqU72IcXp73S4hhJkTFxjJ8liQNME8qRETK3ZmUEoweQMTpYV3c18ybxPot49uK1YlvW
 8TEW6FM+IBU7rPgV59NeQzlHHkiYKE+vQsGXelvXIxzPdC7+S6PqLmSL9k8ikL8dVxUG
 Q2UMf5K6KwcXN9LFgPaZo54i1y2ma2NYU9Dg4+IWAoy8GpxXhXsdJd/56E+IIvVBpAaJ
 MuMA==
X-Gm-Message-State: AOJu0Yz0r5Vc/IBwK/X956Dse5/+fMuL5VeJDHrzO8gUcpuyJ+nlQi1B
 wwVX7gDZbS2PfSX01ia3NMaFi8pUTTAI2o13Gfa8sQ==
X-Google-Smtp-Source: AGHT+IF3CgNOcStBlWnqROFVvIANefRbGiAsfCnwwNXKL+AjrVd9W2GoyLBgZYCNrRsnxtlG7R1tbA==
X-Received: by 2002:a05:620a:3954:b0:775:7996:3431 with SMTP id
 qs20-20020a05620a395400b0077579963431mr37084919qkn.52.1699288426326; 
 Mon, 06 Nov 2023 08:33:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 t10-20020a05620a450a00b007742bc74184sm3415703qkp.110.2023.11.06.08.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:33:45 -0800 (PST)
Date: Mon, 6 Nov 2023 11:33:43 -0500
From: Tom Rini <trini@konsulko.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] net: designware: add DMA offset awareness
Message-ID: <20231106163343.GY496310@bill-the-cat>
References: <da63602bf3f102a3c997362842a959832c97dca6.1698221324.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7LM5bg+fatNrC3Hq"
Content-Disposition: inline
In-Reply-To: <da63602bf3f102a3c997362842a959832c97dca6.1698221324.git.baruch@tkos.co.il>
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


--7LM5bg+fatNrC3Hq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 11:08:44AM +0300, Baruch Siach wrote:

> Older DesignWare Ethernet MAC versions that this driver supports can
> only work with 32-bit DMA source/destination addresses. Some platforms
> have no physical RAM at the lowest 4GB address space. For these
> platforms the driver must translate DMA addresses to/from physical
> memory addresses.
>=20
> Call translation routines so that properly configured platforms can use
> the DesignWare Ethernet MAC. For platforms using device-tree this
> usually means adding dma-ranges property to the bus the device node is
> in.
>=20
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Applied to u-boot/master, thanks!

--=20
Tom

--7LM5bg+fatNrC3Hq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFWcACgkQFHw5/5Y0
tyyrMgv7BSESl2fE47cEqSjhvL4IEzqKmhV9NOHeZMMH1epsIN7rYjC11ygYUc1Y
t1MLRubSv+YbXR1kREigPnRxr8Uz4Mmtt5MBeloBzoCW1Kt25BgUqy2zmZBso2My
+EzntdUq8B8A4BQrPFZoi2ntdF2RLVdfZV1q0J1/N4kH8U2E7qazqRBRoIm//M9t
8zYQa4lWJh+Me/nCqvfrhqG4+2aAs06hGKy9AF2tyU8WplyTN3gUdqm07I1QkzEe
EDhH9+9hbRGGZWAGqcPhYWwgVEuJpiZ8vsHEQevNDrB3GVAk+k0as5iCtOVxjwFA
+LWpbSEwzoOddT6adl/HYnXTEXT9s5tAprmvlmcOI6QcWyFndxQ+lqAy5pTns1j9
YYeUhBfMqfF8kmz7kQM9PtL3N37S1PXAs0/XIJ5Eo6z7S7k+lQm5WA3LUxLYeYy8
k2o7GN3UzZxT5kJzsVuizjPNyVjgxXF3YAVX2lFm4t2ASg/fphb2mR+g+L02dPlt
QTQ/u6l9
=wd3y
-----END PGP SIGNATURE-----

--7LM5bg+fatNrC3Hq--
