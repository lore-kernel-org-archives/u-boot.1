Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF347C02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 17:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CEC880748;
	Fri, 17 Jan 2025 18:56:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AJCREmVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E63A80756; Fri, 17 Jan 2025 18:56:46 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E291080763
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 18:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-467838e75ffso31448731cf.3
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 09:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737136602; x=1737741402; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rp/mLVSQ7gZFlynnh1EovvS4BCqrarQ+aA1EvdMyXOo=;
 b=AJCREmVzqP+zgh4MoLLVBNWuIfZpyeEYGWjuH5vYRSMoteZh9L+qI3Z7zn6PjEFsxg
 ZZFI/RoqcaX1PQDnkB0LBnQHKvvtfP/lZ8sN1rLiqgaNI6ZWJlweuiAapIbcJZk7GvsK
 7hcg86Ja8TJmLdh6U/KU6M2lqgr8V8XZrS9eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737136602; x=1737741402;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rp/mLVSQ7gZFlynnh1EovvS4BCqrarQ+aA1EvdMyXOo=;
 b=hecYBSJBlW/jyJ1Y7EqNWaE6vbF1a/OnErpMWTLCTfK7eZM/JZ1j88qePulGBrysOM
 fyVQ0TpJuXwhsuPoIEdT/uBsePxJj/nPsa70o9EYV0a3U140VqEcgr/4k+iN/mTAZR+b
 D7TFmqXh1kcsGxKgY8HxmyYIEI/lhnU2D9X1+6dvSKO0fbJPuK55amx4T63cgtes7R9x
 nTH5JUpn1o3HjKaLrNdWXgxcU3RC6C8kEIc3MW+5JzeTXxv9VccEwbcUFxyNPftHVzKg
 VaVzH4We/6Tl8v91m7D7psXFVapuydEkahuQuPNEzTUVcWVsdU18S6/OHv8ip/RoJbsO
 U3cQ==
X-Gm-Message-State: AOJu0Yw25aGfNYvHQ3+4RdJDv5qlc564zPNJuYSP7V1nbH+buN6i7Kbt
 HhfwGeQZnHqep9DXz/GeJyYE6yRFTsKC40LzcRBuWsMTyNLmiyyhUdqbT+3wtTg=
X-Gm-Gg: ASbGncsx4J4+NaNk5sCBLpwxjjaUxVXqIaCOK44xYPMyt5B4erSb3nY3suHLz3UkT/1
 KpXXMQtFAsvUKnFDvWqhZkxn9NHorsCnNvCUMklvByMRdyj9F5k0fMOH9Yw3a6OjJLKK4ZDfOuB
 SMyp8xm5XsXMDgaQpL0KbFhyEOEehZxO7PZPcawLuvmfcQNSUUsJApaQSMpKRkAsrWBX+Dt1DMd
 TNgMkjHhCQYEny+ebPpg70JlGZlSvUMZwUc34nD07kTTqfCIptZ6w==
X-Google-Smtp-Source: AGHT+IGUGhLnsZG4wqKyqee6vXa4hYPANjHKvgEu+F/bSVm7C3khTDQ41CgZEimowzp+a7pfPczbfw==
X-Received: by 2002:a05:6214:2401:b0:6d8:a32e:8430 with SMTP id
 6a1803df08f44-6e1b216983emr72417286d6.8.1737136601834; 
 Fri, 17 Jan 2025 09:56:41 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afc0f877sm13587426d6.31.2025.01.17.09.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:56:41 -0800 (PST)
Date: Fri, 17 Jan 2025 11:56:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Boon Khai Ng <boon.khai.ng@intel.com>
Cc: Uboot Open List <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@intel.com>,
 Kok Kiang Hea <kok.kiang.hea@intel.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@intel.com>
Subject: Re: [XGMAC dt bindings v1 1/1] dt: net: add DWC XGMAC binding
Message-ID: <20250117175638.GV3476@bill-the-cat>
References: <20250117031535.19595-1-boon.khai.ng@intel.com>
 <20250117031535.19595-2-boon.khai.ng@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="imFrT1A68p4bpOB0"
Content-Disposition: inline
In-Reply-To: <20250117031535.19595-2-boon.khai.ng@intel.com>
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


--imFrT1A68p4bpOB0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 11:15:34AM +0800, Boon Khai Ng wrote:

> The Synopsys DWC XGMAC is a configurable Ethernet MAC/DMA IP block which
> supports multiple options for bus type, clocking and reset structure, and
> feature list.
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
> ---
>  .../net/snps,dwc-xgmac-ethernet.txt           | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 doc/device-tree-bindings/net/snps,dwc-xgmac-ethernet.=
txt

Same comments as the first binding patch.

--=20
Tom

--imFrT1A68p4bpOB0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeKmdYACgkQFHw5/5Y0
tyy2KgwAgUk53jjK4fePLw1C2GosggJZEVC8Fc7DceCZGjlsbEAI+UowzQKDZynE
jgl3ZOy0Ntu1t83L0/GNPMbNdRdAxQQg2yLBi2dykj+ADgBiWO8DwQ9O0M0fkT9O
tbpLma4PODfXH9hWVThRbuxIyC12IYxK4GvOeXd8NsBIYQ1IV9MYaolyofUeQ6Uu
VKWbxWYTtHvmXIhYIj9hoA+/kj/sCF84GbV9CLB/ZDRefo6zBsD7ASFeKw6GRa6r
/29rs1rKxyrww0Qfmw/cyqgDyOhvYpWetzmPoeG9nc+rIkXAr/ilfE6gHNzVnybX
ANpcaj2Ru0d75dUDXN4Id/9xFtIvrHN99MObieT2AHOJ5QhLUEOBS2Rtspb6qcps
czco9OceULl5I0Jvod9PAy43pX8OtPLWBysVjyTnq5AdkShgd/TI62GBgU3LUprA
bziaLs/2nGnsaqPvp5In598CfEVfThxPbgfgSF2J4jnfSRAprWxF/x+NwQxHTztm
XiGSi+Ba
=VJBf
-----END PGP SIGNATURE-----

--imFrT1A68p4bpOB0--
