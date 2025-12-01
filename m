Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1D0D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED3B83B7F;
	Mon,  1 Dec 2025 17:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NG4QTGOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE1E683BA1; Mon,  1 Dec 2025 17:17:43 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB9983B7E
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-30cce892b7dso2101639fac.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 08:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764605860; x=1765210660; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7DtWnMGkNLIjgn9ztJEPSSyCJa3t+8SUuDrbeQ8ImPs=;
 b=NG4QTGOJ/CFrEJXQXvBNffbny9z3gPepRjBpNEjTdu+1BHQhND6GjsE5wKLPdMzgn9
 XZg1IpBxFImBpdbJxiMUyvWEfVKS6G2mY/+uwBNRkQKAZYURdBnJUD2E9d2a3OmrSeKj
 jkNj+UTsIbzIBPn5+L2ZfTSywDzo8w4eNLa4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764605860; x=1765210660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DtWnMGkNLIjgn9ztJEPSSyCJa3t+8SUuDrbeQ8ImPs=;
 b=dkpfwaVfdAX2Dnf/7+N0VExQu8ltIgkqI2wzn48eRW/OCl8ArQ3SveKZrFT2GwZbK4
 pwAc+iBx4UiTlwZ9SErATswKMCW61zKRfDqm6UyleYttXKAqZXNkFX0vzspoa1AHlzgg
 2FbfRyvFsDuXIQKm/gEIDeaL8ddf/qlixEQmlNt0hHLwMIZsunnRywBTdxeeWS8EB0Fe
 TsOcoza74d4+d+YkCxTrvcgtKA6zbsiAu6u+bqRiIju2RaEjCYIC3q0uXv4S7bdZIyWg
 Th2TozLfHBmGIOSHMfn5re/h8DoIMTbTrZzggBWZWBfw+HTARjeuaCquZl8y+lyyrtHh
 x73w==
X-Gm-Message-State: AOJu0YzzKqh5+RIWxbhINrUyCayOh/VbzBJAg43Xar1PSBv4YVtLls07
 f60QWXCQw2JRJq1DsaNsLxFTNks2sDgeT3ta4LxfkM5iSGSDlgr4Y13+wLR7Ndu2IpIb/zIDoCp
 pec2nq9s=
X-Gm-Gg: ASbGncvGrLy2hjbf0kArPUdKPvB4mPNa1ywGIe1qODwZTf+bjjBas2/5SJE4AE4k6Wh
 H/cWGjxpk4nvR/CjhxvXOBOhHrNREy6cspIQ4Jfe2ET81mQlc3UW+EP+l5wgVXe/3rPXNLWpXVX
 zWRJOZnJKjWsmzHVqlWHz7OEbw/Fjq85YJct1k9NQ9wbdUCtNSG3NQHN2/D0o53MndZIP+VlnlI
 UzrQqLAFCydpsW5wy6YjSPbvNwQT6l5MLV04aK53db8tAqzJ5ex/a0JfYqSeBSIyta92aEdSliP
 o63HLpJswIX4viN1lUBk/bYkzS2TJJKE/P7zF2dCODRush7uk5VF4eaQUKhUPZ+eQohU00CF//T
 +PLmDOOWc7e4pfU9kXQceRTF0B6sX/HWbpLe3YjuL92qlIppCzc3tbtSd+CfXIZHn8HHybHhvX8
 GEqZPtQGKClbtJjHYWyfYfE0Bt4+h/QdIrLf/rSCT+YPloYnBurA==
X-Google-Smtp-Source: AGHT+IEY/vi4d+MjGJZu0H7fjIZnGUxV9TaxnsUTTdGlbjXPyxgEml8vxzSIcdWbqunvXGf1/pGl5Q==
X-Received: by 2002:a05:6808:6d8e:b0:443:9fae:8c42 with SMTP id
 5614622812f47-451158656b8mr16207933b6e.1.1764605860179; 
 Mon, 01 Dec 2025 08:17:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dca0475esm5435612fac.1.2025.12.01.08.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:17:39 -0800 (PST)
Date: Mon, 1 Dec 2025 10:17:37 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>,
 Paul Barker <paul.barker@sancloud.com>
Subject: Re: [PATCH v2 7/7] configs: am335x_evm_defconfig: Switch to upstream
 devicetree
Message-ID: <20251201161737.GE303283@bill-the-cat>
References: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
 <20251128-topic-am33-evm-oftree-v2026-01-v2-7-42a863304498@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="naE9bgj0nG1F13N2"
Content-Disposition: inline
In-Reply-To: <20251128-topic-am33-evm-oftree-v2026-01-v2-7-42a863304498@baylibre.com>
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


--naE9bgj0nG1F13N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 09:46:37PM +0100, Markus Schneider-Pargmann (TI.com=
) wrote:

> The upstream devicetree uses simple-pm-bus, so CONFIG_POWER_DOMAIN is
> required now. CONFIG_POWER_DOMAIN enables probing power domains, the PRM
> power domain driver is requierd as well now.
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  configs/am335x_evm_defconfig | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

We probably need to, somewhere within this series, change
configs/am335x_*evm_* to make use of #include because am335x_evm_spiboot
isn't updated nor any of the hs_evm variants. Also, after this series
do all of the other am335x based platforms build still? And then are any
of them trivial conversions to OF_UPSTREAM ?

--=20
Tom

--naE9bgj0nG1F13N2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS2/nQAKCRAr4qD1Cr/k
CrYoAP9sQjSwoq2XSwBqOYYr8Ai9hw9jVURlccNkZjSYvlexVQD+JwwbgFLdklfG
Vaa+/joc1XsXcZc0FG65g8Fe4txMVQQ=
=1cJZ
-----END PGP SIGNATURE-----

--naE9bgj0nG1F13N2--
