Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFDFCFC279
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 14:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D3208394E;
	Fri, 21 Nov 2025 15:27:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IFy492qa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 087418394E; Fri, 21 Nov 2025 15:27:03 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D00CA8388D
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 15:27:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3ec4d494383so1217596fac.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 06:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763735219; x=1764340019; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DlCVTwoDRh0DDPJo9IlIejkSy5bNgHMQ71L286wgUxw=;
 b=IFy492qa3ltxOUjs2NqXaVHgY4LrDpA85oKsiNNUNksDvDd9IC83VM0WFkK3PtP3fL
 JhfKtOpz8N9jOFK7FrlrIRi6QRtt52iryeQcmmDzOiB+8od1G0XdOikDiQ/QGAqnZxO4
 +ObiGq3jrblWHF4eEQRKvdd7hQdPKyoflYO0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763735219; x=1764340019;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DlCVTwoDRh0DDPJo9IlIejkSy5bNgHMQ71L286wgUxw=;
 b=ha4cxxleKvFFA1TfaTKEGhmXCGLmQhW3G8wlUiKTmOoD0Wu3gl1ymuhcYcW54x6paX
 RxgSL+uZjfpUDBxdR+XIzGuKMQDs0sUbVv2E2Gdug6f7toWnTJ/K1x/xGqHkSmrpaNWn
 mfi9uFFOvpnXuhlJmQnNNTN4nfmyJUw2S4OWua2RZPvxYgDsiixTNvyEobOj6E0CWdN8
 S6sV8yDNQ2y5sFxfMieZeKszdA/8aWFCO/YMvyW6Vj+5dESOUZjLFGPuhAGrdAfv06of
 Aq/ngjj51SRwW6ywaUUU1Wprj3VF6TR89KNVhx4W5lIc1CKSYVkZgkj0FivNevw/ma45
 CD1A==
X-Gm-Message-State: AOJu0YzQeCRrBDsHN2pochzz6GyjZKlpa6OWN3x/QM1AAYeI87GKo1kE
 c9VBKT7yOhhV8A6qYkDldJXMQ2YOgiPKbXacjJF4HQri5uJOOJKvBMkWo7y1Umzm5AM=
X-Gm-Gg: ASbGncvq4wn28cedbdDwSelxOCLU2v9bUbaEigttxgj4yt8bvBbF8T/RagXEojMPh/H
 dgdmOmaeqCai3iUCyOvztafDtYZmH3edJxyqy/FnXBi5kOpqwHJVwxi141kQaDbRktMt/HK4coA
 W1jjyVunVgawLSIU27VDlJk9wLMIeCYe+YKOvVXUmty3J4H47DDBsUWonC8+RrXTjzyb5sWiSPI
 nOU6Ox6TwwPrwftDNM5BGq28LSYh8T6zrq7WaOnwEcVN3PnfsS18nK77cIdfY9rKCjqbbTzJqI4
 K1Prk/5huI44im0pUM2Qdl91UUK8/onPopeJzZGY+eOg1T7/6F6QN808K7IDw+v65gvwaiklrIS
 FxgN38Fw4WnmC9Od42Ijrnyslh/IOJ3HOofWHJMyZxO3Ci/CYTdsanM4g9HF+aHqCBiVauuGKEn
 Gb+zC2p0Wnv025NUYuKdLuqvznz71LHTQU15Dwsdpmt08FZBVSvg==
X-Google-Smtp-Source: AGHT+IHRF4StruJpfFxfk3ySdgZt1JZ4AF9xOjwJ1odbyQbN9rQvwhF/IZDwq7uFSmzXuMFnVV6dcQ==
X-Received: by 2002:a05:6808:3c46:b0:450:3823:b603 with SMTP id
 5614622812f47-45112a6b6d8mr967166b6e.18.1763735219610; 
 Fri, 21 Nov 2025 06:26:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9dc8e0e1sm2726969fac.18.2025.11.21.06.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 06:26:59 -0800 (PST)
Date: Fri, 21 Nov 2025 08:26:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next 3/3] CI: use coreboot mirror for GNU dependencies of
 coreboot
Message-ID: <20251121142656.GU2125796@bill-the-cat>
References: <20251121-gnu-mirror-v1-0-548e6cd2665e@cherry.de>
 <20251121-gnu-mirror-v1-3-548e6cd2665e@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pzJeSJyECpLK3IG0"
Content-Disposition: inline
In-Reply-To: <20251121-gnu-mirror-v1-3-548e6cd2665e@cherry.de>
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


--pzJeSJyECpLK3IG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 02:22:16PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> coreboot buildgcc script downloads GNU dependencies from GNU FTP server.
> For some reason, this is also as unreliable as their git main server.
> There's no option to use a GNU mirror (and I'm not even sure if there's
> one for FTP), so we simply pass --mirror to the buildgcc script via the
> BUILDGCC_OPTIONS variable so that it makes use of coreboot's mirror.
> Hopefully, this proves more reliable than GNU original FTP server.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--pzJeSJyECpLK3IG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSB2sAAKCRAr4qD1Cr/k
Cj4QAP0QA5dSPh4Nb9RmAoFB6DYC3B50iFCgeAmlTqiHPKO1wAEA7tH5by+vRwcC
RDAsI2+/rw7gp1NuZQxYZy2LV0RMDwg=
=FCPq
-----END PGP SIGNATURE-----

--pzJeSJyECpLK3IG0--
