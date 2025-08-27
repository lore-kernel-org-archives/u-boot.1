Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D947CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 18:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B11DA831B4;
	Wed, 27 Aug 2025 20:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cGjfGbeD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D1EA831B4; Wed, 27 Aug 2025 20:28:30 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 352CE83106
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 20:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-61c13125417so35697eaf.2
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 11:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756319306; x=1756924106; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6igjtYF7G3/XEluEZ/ABRAwgOXvddv16ziwViwB+vR4=;
 b=cGjfGbeDoQTqLUk7tCH8XySsIi9bi6GQ0Ob/R0MBarBAsJ6YCRQotD/Fpao53foCX9
 6xH6m7rqNKDkRK71xVt7X4tRznP0tRCoE3mX3D5BLTtHhK80q7hHl4h+hNPjRkVtDx5S
 UFH3awBcMAQv8RWJUhm8s79LEP6lwU0mfJfvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319306; x=1756924106;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6igjtYF7G3/XEluEZ/ABRAwgOXvddv16ziwViwB+vR4=;
 b=WP6Wh290uK0Y9s/GjMIJfzQ9ym8KFf6dg/0t8eAg3hkQbn0dxpNJS8dgqZhlSPMzLx
 oTMjPpe6GKNbLhounLnd8k7b3sKJaeNNXWcSLfttdn7cvFiLpboXK179AXVoyRug2bXe
 JKL5o45MoY9iru337xlG+IsCkB6lm9DQIg3t2TC7qkCvhMJsOr51gR13jlRL8BGwVZ5t
 nhK5m9dsnHHPaNzFMefm7/AcCkiKJcCgQyd3MdMMe618Yu76NL3NICheKKckbVSXRvHI
 IFbe61663zjT+AWvpgYOwq/el1Fh+BEYLHUXbj39wK4CccD4PYq9gNuoetDrsBvJfRps
 jcBw==
X-Gm-Message-State: AOJu0YwtVFlEdP2dc6E/+rAGTkcLe8TtiLNf+w64TEd4/81PxLTFDPYC
 SqsXvQVh2ObcnsMFOID/ABur6zFOrI9bQNFUpJjvLBTVZ/AKDdyS8/l8IAjukssv+OY=
X-Gm-Gg: ASbGnctMOHF5tPmj17revFSgi2pOgHq6SZ0i6Cw4U+/D1yKo8/6T6wTkGgqbnt6cXYS
 T6ODMOdIofS5ew/K8QbwfQD4xzzQOsvHbkPrRYUfmg+wcF3Rs+feWCpfigB9RhfcubmwA1EJGcV
 +2VpfrscRfIoHSZDvZM4nAdx4ufJrtfRqxzRpCN6MQGjUQiA9SiHRWOdg+KCgucyakSE7JWC0gx
 91gG01cAaqYzuv7M9hRjy6Fw+GEGqX5FfHskHXlorXDPjG2ae8LRHNJzIE/xIUFkuE9ZpQfgy5p
 owAq8Yo9Rq5F1iiTyOyNJk+MF7j+RE6kr5eAB2iDocIHIdr0FdI4GYO6BjW4oxcKWAqdL6ZikEf
 /pqJQqCAW6Al6tgCAXlgVxqc1MPq0RNNCT57fouux12yzlGdqUgI/IAG+
X-Google-Smtp-Source: AGHT+IGUr/M+HXJ4aZSbrNzcjp3ECEqwH9V8H2IrG7cYKS9qj11jWXJz3pbD3bxXUH60DkxHjlNI4A==
X-Received: by 2002:a05:6808:818f:20b0:437:b396:b931 with SMTP id
 5614622812f47-437b396cd45mr4035938b6e.20.1756319306230; 
 Wed, 27 Aug 2025 11:28:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-314f7a24047sm3495656fac.9.2025.08.27.11.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:28:25 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:28:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sky Huang <SkyLake.Huang@mediatek.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mediatek: add doc for MediaTek
 MT7987/MT7988 2.5Gb ethernrt PHY
Message-ID: <20250827182822.GJ124814@bill-the-cat>
References: <cover.1756283872.git.weijie.gao@mediatek.com>
 <8c0d6997255a2bbc2e761ed457c51de653cc96c5.1756283872.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BCznb8lXcIrkDi0x"
Content-Disposition: inline
In-Reply-To: <8c0d6997255a2bbc2e761ed457c51de653cc96c5.1756283872.git.weijie.gao@mediatek.com>
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


--BCznb8lXcIrkDi0x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 04:55:54PM +0800, Weijie Gao wrote:
> The MediaTek MT7987 and MT7988 platforms supports one built-in 2.5Gb
> ethernet PHY through eth1 interface.
>=20
> This patch add documentation for configuring these PHYs.
>=20
> Signed-off-by: Sky Huang <SkyLake.Huang@mediatek.com>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
> Changes in v2:
> 1. rename "pd-disable" property to "half-en"
> 2. rename "gbe-min-ipg-11-bytes" property to "gbe-min-ipg-11-bytes-en"
> 3. rename "auto-downshift-disable" property to "auto-downshift-dis"
> 4. add note for "retrain-dis" property
> ---
>  .../net/phy/mediatek,mt798x-i2p5ge-phy.txt    | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 doc/device-tree-bindings/net/phy/mediatek,mt798x-i2p5=
ge-phy.txt

What is the status of this binding in Linux? Thanks.

--=20
Tom

--BCznb8lXcIrkDi0x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaK9OQwAKCRAr4qD1Cr/k
ClQ5APsF6yAsT065sHCoGS/rKFKm+pRdOOqMgPvUNzB/Mr9sigD+KqYzWuRwVujq
2tgys6t2URYuCAkvBez1VkgmFY6cYwE=
=qGPw
-----END PGP SIGNATURE-----

--BCznb8lXcIrkDi0x--
