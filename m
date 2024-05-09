Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C2CC25B74
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 22:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56710884B0;
	Fri, 10 May 2024 00:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RCxC9CyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3CF588572; Fri, 10 May 2024 00:24:00 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63D1B887DF
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 00:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-23e94f0788aso690163fac.2
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 15:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715293437; x=1715898237; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OcJOg1CMkS27tDylUHcbfLWWq8+DzQ9CYbhD7LOx9X0=;
 b=RCxC9CyRw8X8s5CwisQoKnnqOSD/fEeuh+LOwXFsox5+42/4bejFQAgduOXyZ4Ao9H
 e1ecv3h14hqfrr5xOfke64FFf6D6kfoxnerqVu6745K7Kj8dERmSRNJdGcSrohVP93O7
 HFXBkUvCrlCaQwrZJEc1trFg7VQzt0kWw1VXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715293437; x=1715898237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OcJOg1CMkS27tDylUHcbfLWWq8+DzQ9CYbhD7LOx9X0=;
 b=MvcJaD/wztKTA/TLQ2WelJHPBFzmZ5DFcDQPx+MGIriEmRAXRkylmiQq2Na4lMTfja
 nU+iQmTjl97yyl83rN/Wg6YIx1G+Yu8iHecTxJBXqbMM0w+fdbrbJEXBLMxqKxu+WCIB
 2ohMllBmcMg1ktJTNcympoD7CG7PHVnP+hsADwwbGgwOnnKd7vGJjcq4JzAajoq11mcQ
 ywhDB1lvHYG7Wx3f+yUJSSw9I6GaD/Cw/bZinq8epxLRdS5Og3tSxcTgoDzcizMbx9bU
 KvCgRB+W+mBO2Z9kFK7YWhAl9G1bsc1smfEFCfROEvmc68vBIzpOvT7s6op1kXz54657
 5V4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRWNPGsQQZ6Aye3DzslM3diGdZNP0KnEkcWDF4fTvixo2uLsTHwqHuWnD6xq7AtBI85Ripn4KTooNuLfqteitGzX+bAA==
X-Gm-Message-State: AOJu0Yzi9HsYXwbU4SKD/U913rzcxeiCuZwppIL7ynPskAC6Pamtt1fb
 AQMJQevpRg7t1jLfPbtSlhcPNGNVdpZeEBJ6fg9EcS6DlDyNjfT+jq7KiIkKG1I=
X-Google-Smtp-Source: AGHT+IGGT2TJoovSCeXJTJxb4vmrJFK8YHn3tq1gP8MV5fyb1IYxQSAkOk73q6EYHaer9usZvCWWDg==
X-Received: by 2002:a05:6871:5b13:b0:22e:cd9f:4e55 with SMTP id
 586e51a60fabf-24172f83cddmr1219689fac.50.1715293437119; 
 Thu, 09 May 2024 15:23:57 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf31179csm111658385a.105.2024.05.09.15.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 15:23:56 -0700 (PDT)
Date: Thu, 9 May 2024 16:23:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 17/19] doc: board: ti: am62px: document OSPI layout
Message-ID: <20240509222352.GP2568172@bill-the-cat>
References: <20240509164123.1753050-1-j-humphreys@ti.com>
 <20240509164123.1753050-18-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gYRiOAOk7UDMDhu2"
Content-Disposition: inline
In-Reply-To: <20240509164123.1753050-18-j-humphreys@ti.com>
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


--gYRiOAOk7UDMDhu2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 11:41:21AM -0500, Jonathan Humphreys wrote:

> Added OSPI flash layout diagram, as well as example commands to flash
> firmware to it.
>=20
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--gYRiOAOk7UDMDhu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY9TPgACgkQFHw5/5Y0
tyzMKAwAgacQex2ZUO1mu7MLHuw24wfSdmscdJ2GPsaxiqBxEEJxesG65NENh7He
UDw1TUih9L0BVRvLkZFwILGAYmAEHU9ukN6sDmSto677I3ynxbXZu6JhDuXDfTfG
TABoHIJg6BeD6Cd2HxR558NiOPTdB3jBacPUoBil6YkXPMMurd43DvHqr63fr+bF
ht2nvHB2so/EOxrjKnUHGMDL5vWtv3Zop9ZyQtMIGbbWVajdr7DvG82cNyA3tx98
cNggy6aiswVG8Cbmgqv5+ev9n3oc+qYdgtxONwh5X/LwravKzAgvEn75YWQsyTYL
93CUCmDBak0wl9eDg1MkGGsGmfq14uKByESVQB2yGezULD7f/hunJSyBCceWH/7V
MsvcVbi89YCdBf5bNi9TatTjE+xNFm1G0cXJEan7+nlheMBczW5L/JFiiK13RnfY
bfiKbiOE9yUDGwT6rEcYJEy6xmgMM++PKATXvS0PP9+M2CKb/Z1zCUIaHhGp3VTD
nxlXDkFA
=qp3i
-----END PGP SIGNATURE-----

--gYRiOAOk7UDMDhu2--
