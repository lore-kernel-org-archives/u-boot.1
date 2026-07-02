Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C3CC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 14:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B121984A4D;
	Thu,  2 Jul 2026 16:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S8dxaTqd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 119C584A52; Thu,  2 Jul 2026 16:29:37 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E568C849D2
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 16:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e9f1f24cbcso487608a34.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 07:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783002573; x=1783607373; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7voHmCPQAkLp9pCdPFTdlRKKrcaCZmBM747htbIuO08=;
 b=S8dxaTqdIKlVMbMw19xdv24OQEW7IXpydK0VTOyv+eA0DGaCd/dWnsGQRlrR7D821k
 OkJ5EPO4QYuO8HDjacrqxigp+HpozVyPLEyeZAZ5/pn2TfkSv+PYuWPLxydo9TXplWk9
 5YKj9dvmNDHbtFLMuidr7Yxbyc57+JpwmL0ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783002573; x=1783607373;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7voHmCPQAkLp9pCdPFTdlRKKrcaCZmBM747htbIuO08=;
 b=WofEFOEvHoStcsNDPX3JQlCqYyUjU1M+kBGMdXfrWrTDq1cl0Fi0mitTVM3G6a2o63
 tnMCfFJwNdTJiHSUuy6Ck35hjTzbNMH9mge91V8mwjvUgCX7nGJeUVwx1w+vZBgZNXuE
 RGUHL2jX9vCulVJUqJjmC4BzYuoS7sLgKyS+fHlhtp4UD1epzb+FL05bjQKQmCJ+iiDj
 A4Gu2e1y8e9c84iM7fw2jdNIJ7fxlpx77E3UkYbLvafRmcyg8Od3T00OfSz68b7fHuxG
 fAq/QVNqMJDFhT6W8XD2TItLj2forbHmgWhry5Srwlj/c+/vGJmeJTClE4vy/kBLSL41
 x/2w==
X-Gm-Message-State: AOJu0YzcwanhRZANCxHv+zD9L++zf35pv+XgIN7HSXAtDbrsCNViURF8
 9Rmenl1STzimt/vrlHDowb/IcNPec9qlPKnLTaqEW4o2PYLEBRyKAud2BmL+H9aINmJczqyGGK2
 urj/vkDL0uw==
X-Gm-Gg: AfdE7ck3IZDfGb6XA55qJwy1PTpUnsGn17uX+ArW5/O6dFAmnc05TRENIRE9Ab1Lud1
 i/zO58skfE1B800rO3WXT9JpF5sWJ/Jlz414kmGT5jDOg8BRTXKW8eratI66hMoCf5x5n9c3GjH
 EDcabicMad5HBsrKPTMHU+XoZofbZ+LzrwxdeixxQq6VtjXB8MvS0H+H/RA1yPX2qIhbt5tQSj0
 5bAofLVpZUNl97+0K33LKgnYh6EJcrxRHFmgBhfv3YQNS2D4E98GpBjKbF/Pz56nknp7/GzQuBt
 t/o7l8BgF8uY2wCULVGgkeUyy+FWSGrFCtzrsyIlSxHjWoIyI4iifVLdLeugwde+sY5ohlOk/c1
 6kIQk8nH6T1j6jQ6ny6gZXt4u/uNPYX2SCSP9w68pwWEYBLfjRTvD+V1OxThlzPyHiQ7mSh1dTd
 Gd7tzHeGt9D9xSMXzkpDJd2wTrFizYDmUrX9iP/NcrmkKkyTmjrbmk2zvR39ch7o/RWIAhpRRNZ
 9Ky9VU1ELINJ6LvyDxHKUWcjK85TnwJt6TxOO5sMVkWHKw3
X-Received: by 2002:a05:6830:6f89:b0:7e6:50c4:e954 with SMTP id
 46e09a7af769-7eb68888a1fmr98864a34.11.1783002573697; 
 Thu, 02 Jul 2026 07:29:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb54292d77sm2548826a34.1.2026.07.02.07.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 07:29:33 -0700 (PDT)
Date: Thu, 2 Jul 2026 08:29:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH 1/2] tools: qconfig: print a proper error when database
 is missing
Message-ID: <20260702142931.GY749385@bill-the-cat>
References: <20260702-qconfig-check-for-db-v1-0-f0b96bf8fa44@baylibre.com>
 <20260702-qconfig-check-for-db-v1-1-f0b96bf8fa44@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q+r7XXm+9GQowM24"
Content-Disposition: inline
In-Reply-To: <20260702-qconfig-check-for-db-v1-1-f0b96bf8fa44@baylibre.com>
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


--q+r7XXm+9GQowM24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2026 at 04:04:41PM +0200, Julien Stephan wrote:

> When CONFIG_DATABASE does not exist, read_database() would fail with a
> Python traceback. Add a pre-check to print a clear message asking the
> user to generate the database first with the -b option.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--q+r7XXm+9GQowM24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakZ1xwAKCRAr4qD1Cr/k
Cr2GAP4gJreq/G0NSiqK9ML9E1KWV84gtBTG73OQu7bwbIFWIgEAomxoa3elEFj/
ha6twknBAk/LAgsDn/qrJWcpgNDBQwk=
=+35d
-----END PGP SIGNATURE-----

--q+r7XXm+9GQowM24--
