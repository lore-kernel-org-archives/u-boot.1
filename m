Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BC3FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 307E084897;
	Wed, 29 Apr 2026 16:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CQbhAuJL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF84E848A1; Wed, 29 Apr 2026 16:29:41 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA4D68487C
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so11241552a34.2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777472978; x=1778077778; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c5xkPYahUqMpQ5h+XhdSewPI8GDEzSweJuBu6lO5BGs=;
 b=CQbhAuJLnYS9SAANNCmpN65Da2vuEo9XhT8YqbjfL5Q9x6uhJi+8c8EsgreANlpHAH
 L9IkVvkTxrOwHSa8D9FwOZ77+9OVihTXygxfb13br8a+QQYMWb2lZt1LFFztxfXe0RZk
 b6gmw9hn/4ZbRTtC+8CPy2ddYaX4Ar2ROg/Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472978; x=1778077778;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c5xkPYahUqMpQ5h+XhdSewPI8GDEzSweJuBu6lO5BGs=;
 b=h+3ou5YOGBmaa4Xxt2oZ6c7a4iqbOLdDSfVOFq5dIrjMAT2hOy6sqU3YyMJnyTBuov
 bJ8oxyEvOi1TSFBCEt0wyIyhuE87+jx8K6jzDC/e5LW2VizSvrqelTmx3Xj+EKXHYSqK
 8rT4hG5I2RgEjQJMtTJavaLCpyw7uQw1eyKfhhmH7U0KEcGGithrog+sf/McURJuSLEX
 z5gvje4gIhXm6bv4EE19OitzQGsLJMdGkrZ3CghTkgJjeqwlZePA1QyCTBWVpy0mAlKU
 aro9fruz3rJCvfUbzaJYJOoZsuC0uImC6BNxNXIndASBZXyeCbP6+dNTuQPBclSzzSjz
 dD8w==
X-Gm-Message-State: AOJu0Yy3HXMOv1PCOHqnnWjU+lBgzIGmjd5tUBk5l+oM3DhVWLVlj242
 60ljMs+nFofkXuls4M/s+qK/sX3mn2p4BY7X214lNiRePeMXDZz8LRNbMlRb7KHqyz4=
X-Gm-Gg: AeBDievyvw2dmUTIUnwGNVxAeHNSpH8x3r3GuuMvXlxdzhVVsOiWjlKjv6hMTTOs0ac
 oTPWfZRvbZefvLiJTJ5fYIcHE7yDqiBakAM0Ms1aux33zOtsMWpWlvLACDMkDi4y79lRkfgknY8
 O1mk8GILZzXPM0PN0dApVh9/tdWyMqq/iza3ltE0WGgZjQ6jvCzz4HwSUXVHX1aRX7e9ysmf1Og
 ksCXnIH3mDkwE0AIFgZdn4mNxTb8sfeBG7Zlut7Rp9dnKz4xF4X2bqW5S9mpq0DPC8ozU+9orzm
 /ZInluY+jPkZBKugIwa2vpa/ZyyxoMqeumlaOtQgfokb68ssrKIDx3rJtrzW8A/uwkE7ffpR9N7
 LOVvwMAreLCc5nAfhAQARIRmtxPdnjiLKu3r/e/3gjVJXq8j9TjPpc/wL+bI0SW41qVlG2qPiLr
 0vaPpInehZP/fKFLV/C9s1F1N+3VEJ0X3qs+HwR/9OM6/pSabMnKzCe4L4KUaq0g96B5oXMYfmb
 GmZQp2okt0yLlExIqVPpRrmq1Nr46jQrhMbjRO2GYCQr2wWoydZYgJesLxLLA==
X-Received: by 2002:a05:6830:6483:b0:7dc:3e5a:64db with SMTP id
 46e09a7af769-7de9a1665d0mr4853357a34.26.1777472978455; 
 Wed, 29 Apr 2026 07:29:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deab7cfd13sm1536401a34.3.2026.04.29.07.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:29:37 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:29:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Karthikeyan Mitran <kmitran@axiado.com>
Cc: u-boot@lists.denx.de, Siu Ming Tong <smtong@axiado.com>,
 Prasad Bolisetty <pbolisetty@axiado.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Tzu-Hao Wei <twei@axiado.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: axiado: Add AX3005 SCM3005 device tree
Message-ID: <20260429142935.GU41863@bill-the-cat>
References: <20260428-ax3005_scm3005-v1-0-7fed19ee6fe0@axiado.com>
 <20260428-ax3005_scm3005-v1-1-7fed19ee6fe0@axiado.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8suiM/BcEzppaQvg"
Content-Disposition: inline
In-Reply-To: <20260428-ax3005_scm3005-v1-1-7fed19ee6fe0@axiado.com>
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


--8suiM/BcEzppaQvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 07:32:36PM -0700, Karthikeyan Mitran wrote:
> From: Siu Ming Tong <smtong@axiado.com>
>=20
> Add device tree source files for the Axiado AX3005 SCM3005 board.
> The AX3005 is a quad-core 64-bit ARMv8 Cortex-A53 SoC.
>=20
> The DTSI describes the SoC-level nodes: GIC-v3 interrupt controller,
> Cadence/Zynq UART, fixed reference clock, and spin-table secondary
> CPU boot.  A /memreserve/ directive protects the spin-table release
> address at 0x80002fa0 from being overwritten during boot.
>=20
> The SCM3005 DTS sets the console to uart3 at 115200 baud and declares
> 2 GB of DRAM starting at 0x80000000.
>=20
> Tested-by: Siu Ming Tong <smtong@axiado.com>
> Signed-off-by: Siu Ming Tong <smtong@axiado.com>
> Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
> Signed-off-by: Karthikeyan Mitran <kmitran@axiado.com>
> ---
>  arch/arm/dts/Makefile           |   1 +
>  arch/arm/dts/ax3005-scm3005.dts |  28 +++++++++++
>  arch/arm/dts/ax3005.dtsi        | 100 ++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 129 insertions(+)

What's the status of upstreaming these files? As of v7.0-dts I see:
dts/upstream/src/arm64/axiado/ax3000.dtsi
dts/upstream/src/arm64/axiado/ax3000-evk.dts

Thanks.

--=20
Tom

--8suiM/BcEzppaQvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafIVzwAKCRAr4qD1Cr/k
CtxkAQCMlpiUn4fVqMPlwkOXFwGZq2S+UMMbho9vlJQ5sCOJ6wD+OaE2xNgn/pX9
Mc5zynYTe5NoSWZNNzTwQwZet+vdywY=
=B+Dq
-----END PGP SIGNATURE-----

--8suiM/BcEzppaQvg--
