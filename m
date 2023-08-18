Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9FEEE498D
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 18:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9CB886EEA;
	Fri, 18 Aug 2023 20:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pgjk7ZdF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C0D86EEC; Fri, 18 Aug 2023 20:47:07 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39A8A86EE9
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 20:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-58c92a2c52dso13029187b3.2
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 11:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692384423; x=1692989223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Mjy32YbMRyHKJxGUVl9V3EYpVzbFKUnVykcX+XsDXK0=;
 b=Pgjk7ZdFv7D8xiJ9MEr3oS3cPpgaZ1N2/o9K7FqOxR2ZSIKy10QuZy436FlgfwJ1lV
 +IjXOyNK311WcHaZRrEJvLP0LzPFNlSqouz7OPc/H3+YWgpexAps1WxBFh+w4bkK46ZC
 xfonmaqBxplReXwhA2x4TUuGHg0VZSLQRzIPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692384423; x=1692989223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mjy32YbMRyHKJxGUVl9V3EYpVzbFKUnVykcX+XsDXK0=;
 b=J/fJzt7vbgt1pdND66OixmELPtpbmtomrxhaXKMLQsM4RoNqYnepbWqnJ1BejYMl53
 8k92Dz8UEKVLGWgNz8ArSBBs9wcnEdGcG4ITkzETX95wm+yAiWOKFhwN6bvOO6Qwl/+U
 D/GyP6xw44dXqfo4PuK+otnR4ZjO8qI9OyzUKRaN/sWDqrQF6NKNkCIebTkWHr4N/VCT
 nioPbpg0gEgunYC3WIa/41FIODU8v2hhhLjYyDqlr37u4VoO9SmtbprG+aYkFQ8RZFCm
 m7z9C5NzOWKzhsGdmSJ5uEhyukYCF1NVsV3XYJuKNUWBO329ndSHLIFRJ0xJc19RS7J7
 Tj+Q==
X-Gm-Message-State: AOJu0YyQpG/PXX4uX4F2RpfvG59nXS6tJt7yzmIaDZ5L0FTPHjG1S/ax
 HWnxl7m7sIHlKnMbYEm2iJbnGw==
X-Google-Smtp-Source: AGHT+IHqUlOMqIZsLi6j4tYdpxYa2oYN4mhba5LnYTzEyqGaiyfa77YWHQsmQFOgto38NTzwvQLq5g==
X-Received: by 2002:a0d:e903:0:b0:56c:f32d:1753 with SMTP id
 s3-20020a0de903000000b0056cf32d1753mr1636ywe.44.1692384422949; 
 Fri, 18 Aug 2023 11:47:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a81830d000000b005869e1d8c41sm666048ywf.29.2023.08.18.11.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 11:47:02 -0700 (PDT)
Date: Fri, 18 Aug 2023 14:47:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Frank Wunderlich <linux@fw-web.de>
Cc: u-boot@lists.denx.de, Frank Wunderlich <frank-w@public-files.de>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] arm: dts: mediatek: convert gmac link mode to 2500base-x
 for r3
Message-ID: <20230818184700.GN1515023@bill-the-cat>
References: <20230803165258.14744-1-linux@fw-web.de>
 <20230818174945.GF1515023@bill-the-cat>
 <7791C49C-F782-4802-B396-B1A5F922EAC0@fw-web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BbkZ7qWEo1LUYFaO"
Content-Disposition: inline
In-Reply-To: <7791C49C-F782-4802-B396-B1A5F922EAC0@fw-web.de>
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


--BbkZ7qWEo1LUYFaO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 08:45:33PM +0200, Frank Wunderlich wrote:
> Am 18. August 2023 19:49:45 MESZ schrieb Tom Rini <trini@konsulko.com>:
> >On Thu, Aug 03, 2023 at 06:52:58PM +0200, Frank Wunderlich wrote:
> >
> >> From: Frank Wunderlich <frank-w@public-files.de>
> >>=20
> >> Ethernet on Bananapi-r3 is broken after
> >>=20
> >> commit bd70f3cea353 ("net: mediatek: add support for SGMII 1Gbps auto-=
negotiation mode")
> >>=20
> >> because changes from this commit were not applied to bpi-r3 devicetree=
 too:
> >>=20
> >> commit aef54ea16cac ("arm: dts: medaitek: convert gmac link mode to 25=
00base-x")
> >>=20
> >> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> >> Reviewed-by: Weijie Gao <weijie.gao@mediatek.com>
> >
> >Applied to u-boot/next, thanks!
> >
> >--=20
> >Tom
>=20
> Thx,but this leaves ethernet broken on 2023.10 for r3...could this be add=
ed to this release too?

Ah, OK, I'll grab it for master too then, thanks.  FWIW, some Fixes tags
would have made it more clear as those stand out in patchwork.

--=20
Tom

--BbkZ7qWEo1LUYFaO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTfvKEACgkQFHw5/5Y0
tyxYpgv/f3NCcLqeoApuW12gnD0wxaOCkvHwDo4D/Ro5AMksNQSXdQ37tjzedvlF
9MWfP9W9bJp+1oky3ZUYhbl+tf1sc2BPX5GssHhMLrkEj8v7aJ6Gde1+sgZSwUfe
dI/QZnVS43lFyF9XenoLctKiin6cSThj3Avp3fiaP5697dsyriWotfBXBdiVgGjk
LTimBEYIuYODI632xYSgWpEvKP3M5FCBr3VnafE2mnmdT+6G+vVH3jXPL7aeJ4Et
th0Dg1V/DcYtTRFEO+DS/3OxPs5zM2b5XfbTybQQ4tEQYHVVgrQPXI1I3RBbNYyT
0WiJWw4CEo17X6kamyLVXdXRl8ulKihGD7MUNBn6mTWcuSvWvniatoxCzxKRQxAl
QPTZltTJFqUnXiEuVdWtmr9KMlcl9Gl4WTcLurhJCgUJ8j/KK/ayZnOF6WcooKFZ
POBcpjvZVnAKX4M4EEZ8I4PuQ8nRmbvCi+UN+VdAY62XfLnSEWVYE5Dtuf3UdMP7
XBlcID6d
=NrOh
-----END PGP SIGNATURE-----

--BbkZ7qWEo1LUYFaO--
