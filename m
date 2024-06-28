Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E29CC2BBCA
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 06:30:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A881C8859F;
	Fri, 28 Jun 2024 08:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="EwF85Xjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9697885A0; Fri, 28 Jun 2024 08:30:07 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3603588590
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 08:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=902a16d01=Conor.Dooley@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1719556205; x=1751092205;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DGz1IG+890VUu+dkPxOzza9f8pHGIX8zfc7b06KnCwM=;
 b=EwF85XjdYgjaGGvlaGngam9Z7HdlUOL0Drb9YkziCHCTm8jww8pkhJFr
 HYKMHYiGR5CvbKsYfHjMFeR+DroUQNZva7hNVoUsBQg/nYleI869GFOse
 eYqFbBpxXZ/u1pVhZVvyeMkrLH+pLD7TjuCUleu/vkQemFLQTc9eW70C+
 Icqpwe4cUlQUvbAHp2iF080EHM2Z2U2m+vF8dSlq0ZY86RbEEeOcJFzmv
 P9ia+iAxdWEJ/53v9QZXWSArLY4JwyvJEtkUv5IynKLuFk8ot7h254DX6
 o+zaCYo+22nfbIgvKeydpfbAFBujYtNGrUuoZhUy26ZSZ4CYgvCMDkP1s g==;
X-CSE-ConnectionGUID: 0DBFXfNRSZuRXtguGWMzow==
X-CSE-MsgGUID: DvBlQ9tIQCqHhLRBUBoWfw==
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
 d="asc'?scan'208";a="31189636"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Jun 2024 23:30:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Jun 2024 23:29:30 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 27 Jun 2024 23:29:29 -0700
Date: Fri, 28 Jun 2024 07:29:11 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Simon Glass <sjg@chromium.org>
CC: Conor Dooley <conor@kernel.org>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>, "Ivan
 Griffin" <ivan.griffin@microchip.com>, Padmarao Begari
 <padmarao.begari@microchip.com>, Cyril Jean <cyril.jean@microchip.com>
Subject: Re: [PATCH v1] board: mpfs_icicle: implement board_fdt_blob_setup()
Message-ID: <20240628-hertz-spectacle-177ce3186e21@wendy>
References: <20240625090806.1787287-2-conor.dooley@microchip.com>
 <20240625143421.GR38804@bill-the-cat>
 <CAFLszTipm2MB9L8tubRxh_cF-BOXciBo5ypnjomm5rTj_F4fAQ@mail.gmail.com>
 <20240627-endnote-cacti-5c8ae6251234@wendy>
 <CAFLszTj3uSd8UOvmg5M2x1EOnidocRYxiBg0SeG8-eCfm1huRQ@mail.gmail.com>
 <20240627-prowess-train-e37fe71c1310@spud>
 <CAFLszTjoKPT68X7kBHELgCAbgXe_X-5Zs4-UJUaCVxSXeM3Wow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9cZBDJFZ3eeju1wh"
Content-Disposition: inline
In-Reply-To: <CAFLszTjoKPT68X7kBHELgCAbgXe_X-5Zs4-UJUaCVxSXeM3Wow@mail.gmail.com>
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

--9cZBDJFZ3eeju1wh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 07:22:35AM +0100, Simon Glass wrote:
> On Thu, 27 Jun 2024 at 21:27, Conor Dooley <conor@kernel.org> wrote:
>=20
> OK, thanks for all the details. I suppose, to me, 128KB does not sound
> that constrained :-) But I can see that messing with a bloblist can
> add code. A static tool would help with that.

It's all relative - when libsbi.a is > 3 MiB 128KiB is a problem!

--9cZBDJFZ3eeju1wh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn5YNwAKCRB4tDGHoIJi
0ql3AP935ByPrTIrZ4edXO8c3KkgzKho6uXoNiMSEzASPbQJwwD9HzeV5XjwSAOy
eMUC6C2wVCZHO2VUIRy3rlChZsM0Dww=
=qyIk
-----END PGP SIGNATURE-----

--9cZBDJFZ3eeju1wh--
