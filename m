Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DAAE78480
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 19:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE31286D18;
	Sun,  1 Oct 2023 21:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ng+2dnlw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D0E4870BD; Sun,  1 Oct 2023 21:11:56 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC83786D14
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 21:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
Received: from mercury (unknown [185.254.75.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 1BFB266071DC;
 Sun,  1 Oct 2023 20:11:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1696187514;
 bh=gzyh7a6jQteLLeyK3NstcNtdeUFvOiFmGpnP2+QV5Hw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ng+2dnlwK3SpPos+o6Y4PXeyinzx2Bc8ZKVYTDE9NO+UQSAk4ibdwDGhVoAlFf2eq
 sHQCQzCb6temlDP+RZQAm4dtNmDpYGcQ3k1dmbujL06k3jMevX5YElEiq1xZqoMeeQ
 trv2yWh5dVR3AC35nOxBVKXGvSEHq1JnJQn8ZiKzhAfJG51Mp9nSdAFOO4kV0vdK80
 DgbRTdlRDHRoMd5sZBT5qGxE4q2rF7AxlDafqqeeTcBAIEz+JvFDst3ZnmMGZ+GQ57
 QIUv+Vnb7vunqwvSkTyYVc+ynxz+WnYfwSeaaxcpd1+oYw1CN+vlM+L9IFxrHFN9GI
 E2o36DU9MUMAg==
Received: by mercury (Postfix, from userid 1000)
 id B49DB10603F9; Sun,  1 Oct 2023 21:11:50 +0200 (CEST)
Date: Sun, 1 Oct 2023 21:11:50 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jon Lin <jon.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
 John Clark <inindev@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/7] rockchip: rk3568: Fix use of PCIe bifurcation
Message-ID: <20231001191150.pydmtyqg4wtbri5k@mercury.elektranox.org>
References: <20230802190424.2963185-1-jonas@kwiboo.se>
 <21678211-14b2-ce5c-820a-c69426725d65@kwiboo.se>
 <29f01214-04f4-8a38-96f3-75df13bda7fa@rock-chips.com>
 <2a605926-3d85-12fa-76db-2fa8d18b03dd@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lglhaq2xvckjll7b"
Content-Disposition: inline
In-Reply-To: <2a605926-3d85-12fa-76db-2fa8d18b03dd@kwiboo.se>
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


--lglhaq2xvckjll7b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 27, 2023 at 06:07:59PM +0000, Jonas Karlman wrote:
> Above works with this series in U-Boot and also in mainline linux. Not
> sure the RK3588 bifurcation part of driver have been verified on real HW,
> rk3588 boards available for testing have typicality not used bifurcation.

Upstream kernel bifurcation code looks ok to me. It's quite different
=66rom Rockchip vendor implementation, which might have confused Kever.
I also missed this when having a quick look initially. As you said
Rock 5A, Rock 5B and EVB1 do not use bifurcation, so no testing happened
on our side.

Greetings,

-- Sebastian

--lglhaq2xvckjll7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUZxGsACgkQ2O7X88g7
+ppREA//esC53hqO1OD4hxp/SHRVxQIJ4k5UHnp5PASqw9rLW/PTcIiyZs9Dtgpm
vKDEt6lKkxIKLMqz1XsJpIpP+jyljLsKogTCHAEb1mQhOja3l1RgaZvMZDaFJTG4
xtSCvN3dYaMgOvM2H7II4BO21o3fG8TqHI7NwpNvYijojmj3GNmSbLjrA0WdkX1E
KIZkfNasBOM+0eZYHJBPXjuKm9BMJRfa4+HGwIU/uPVw6K8fjlkxv3m2iUM57+we
/8tiKr4VqSRKRGAuvuPzG3nzDFyrTD7NGaeOkuyiCiRQTRMq7Ao8IuCZbgb91gYA
qxZ6YKESg5RWz8849yE+ldgGl4CBqhuFYZ2ZHZcgx4VRQaZzASvcPaCIyJ1fE4yV
serBpEFZZSqh8aYoDb9drgn0ptiVMjeNWJ1T+K0UMKDj4Gxy8X/tHJ0t4EJq1M3l
OWKJ/dUg9ijP1yQhUq2M8+ROLGBpXTX5nhpgbFkO6jWV4Y/gw5YIokEIiRkTclry
BfOoZH7b2dAr0JgCxG07TJIXi65VtqnJSFx09z+r9EEthegH7s+6bw4jTk0lQyie
uMX9Uqo6uqRgjSr8e+9HTn/aFpso1HYEklrOm0LaNb7fGapE0QrkZ90+HClH0FoM
V+b1FTtOfp5zAhcdWbTt74bFOwr2PanZSkRDuWZvwb3Bm6svbcM=
=B742
-----END PGP SIGNATURE-----

--lglhaq2xvckjll7b--
