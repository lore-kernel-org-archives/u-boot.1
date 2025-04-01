Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F078C36017
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 21:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E050581703;
	Tue,  1 Apr 2025 23:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZSm3F2ap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2972B8171B; Tue,  1 Apr 2025 23:41:20 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5FE780F6B
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 23:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72bc3987a05so138926a34.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743543676; x=1744148476; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xLe4hwxc2KpIMG9Mjum24K5EdFl+cJyCj4wfPW3zyO0=;
 b=ZSm3F2ap8DJC3Tg3LHyteP/rL4m2a0QaPMSn9S4unctvYrN4v5yHkKHMhaDJ+PsaSe
 iNzIalVUBVrBMsLlO8oijQrUa3t7oU9JviW76iVoEX5VEGwbb3oyINE8OyJt/+r/F25R
 uvsHjZP07vpyQKYqtltXAvlBqAKyvXCDD/hzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743543676; x=1744148476;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xLe4hwxc2KpIMG9Mjum24K5EdFl+cJyCj4wfPW3zyO0=;
 b=iPB9LMLxJUXdmzXflYIuWbmYG53OFRSLtHt5Do/wfofdUr5WMjiDc2GxpAXKWwI5Sx
 c8AoHXDxsYKgVPVUizJbMxWpDko6VX+jP4IVCKtSrKVCTBc8GKPHAwB4JjNNeXB2xGE2
 DxvMszESyCjz0qeY/1rEUG2PnaHoI+6/e/kVfz9mw+uJhc0Exo3kNqgKzfR8K+ZY9nme
 ZxLbMRWRAfGSmUdqM0h0mFEpH34WnulVTMVIUAh84KK313TOJle9bOAjK+MBuANDh9EA
 j/wNAXs7fQpKcU1mpvehBEgMtsJsabtAT9D3n1pPe5UngALx5oXtK20acrcotwyqaGHW
 9Muw==
X-Gm-Message-State: AOJu0YwaJRhUdb7H+muwCaYVxd+VXcaqmt2oFhiLcEfX8LRHul6TloBV
 yXsEP9Zxriw2TgndQ0VblkidxWanhJOb8FhPvyBxbVUdE8/ORAkXn6qP+vUzMTs=
X-Gm-Gg: ASbGncv8E+Yt5fmGxFIDCRw1zetooid0M0EvIPg2H7DhLVdhFHddDOcQONZTnoudu9n
 sYoa7MMm8PbeQ8JSIW+1gPQ0b3wuEydItdWLRrLe+NxOpNzm4O7gbu19IKO15ncYCOou9gfIKD9
 hvsopkaaRkxVJM4odjCmM7y+we8erROoFeVW0pzJwVoXs74NwXR6CNBDrboTsQdJ4K4LYiypOxj
 KuZu4I5wAYd0WH7XDXPG/XJxiKX0Y0WJvPj/N7/Ph5MBmGbg0qOFOJ/wZE7WfQ1wyhr3q6bSWI9
 Yh8+nCQAdzff9nvzrr7k5Nj2u6YkGZJZGlfpJCnN7qoPJTq3CwRj1TknRoBZzOym+4uyqptVUmL
 LSYqYpg==
X-Google-Smtp-Source: AGHT+IHDCZtaBK+LkvjEyfGwK7Y+GRsB0/7mA/RD4ECl+538tzYTBfqfJKYpcVPGMLT9TVrildOQcQ==
X-Received: by 2002:a05:6830:1c62:b0:72b:7dbb:e39d with SMTP id
 46e09a7af769-72e2257ce0cmr866964a34.1.1743543676604; 
 Tue, 01 Apr 2025 14:41:16 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5828ae93sm2013561a34.63.2025.04.01.14.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 14:41:15 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:41:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 00/13] video: Enhancements related to truetype and console
Message-ID: <20250401214113.GP5495@bill-the-cat>
References: <20250401172948.1236000-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rk13/MrT3b6HGzVC"
Content-Disposition: inline
In-Reply-To: <20250401172948.1236000-1-sjg@chromium.org>
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


--rk13/MrT3b6HGzVC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 06:29:31AM +1300, Simon Glass wrote:

> This series includes some precursor patches needed for forthcoming expo
> enhancements.
>=20
> - truetype support for multiple lines
> - make white-on-black a runtime option
> - support drawing a rectangle
>=20
> This series was split out from schd2
[snip]
> base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
> branch: schg

I get as far as patch 4 before it doesn't apply to -next.

--=20
Tom

--rk13/MrT3b6HGzVC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfsXXIACgkQFHw5/5Y0
tyyU7wv/dS7YOhXgnzcaHMFKkbU3zAsoJZHWAAlAKFRdjDdEQKpGM00w2DsZ88RX
jl6zO4K+dY3o+Ph6CrmVPHcMTdWgQeeT3knqp5jx5Y0kL2lWyoVQv06f5UqgNPeN
FCUl3JdhlPNbwdjYHjNQMhtQDqxkHz8+sr3j/tjdl+ss4Opm4nswOzeV3cFBwE+o
xJMVMW7lcS3yqVzIFF1a9U+1YTL67+fy947kYC5xDa2ECO+Qg4/SlrQvx6MCNMA1
U5UgqJ0pjQ6QOK7G4slNA6XCN1coO1/Rf5m40kQtfa6iOG6Dap55UXgMOemg24oE
Kp37DJeLDydbCSZgxTe4oSHCTOXhyDvFoQoQ/fFAeWq5rItUKdnH3jRJyOjCgYl4
fRgaiWEWydBnwDa9NbnBch5Wpepyka0bFYSiAQ/e2i6cnFFb4DFkuAo8HmH+PAVc
YAOEuMk7Bq1gYqn4MsYdedjtZuP1fchm4+/8SUlMoYniVPif3cS8AQdUVx3K5NTi
vyjFm7M8
=jWZ+
-----END PGP SIGNATURE-----

--rk13/MrT3b6HGzVC--
