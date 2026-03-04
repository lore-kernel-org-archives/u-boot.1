Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E41BEFCE21
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 17:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95972838BB;
	Wed,  4 Mar 2026 18:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BiXiQMWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C00A7839A8; Wed,  4 Mar 2026 18:28:45 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A136A83642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 18:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-66f747175d8so4113058eaf.0
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 09:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772645322; x=1773250122; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A/FP0hkPgcP8yp9bn9bSVclDBs2Lx6VlQw6takx8Tv8=;
 b=BiXiQMWXzna22Deg550XLh6z7noLNsOAezniy/wBYca9PbLB3qYQvJF1uD4Vb08RZ6
 x7kZN5RJ2zcCVRebsRMkosP/ZvLTp7s7Ue6upWX8JN0uJH+Z3N6aV4D+AL6sxL5U01G8
 hCqMpmll8OSIIDi5kgbQWpw09eThfN53WwoVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772645322; x=1773250122;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A/FP0hkPgcP8yp9bn9bSVclDBs2Lx6VlQw6takx8Tv8=;
 b=Q66KvaVZH61wWWWUdqVQWLLNxnfVmP56G4vfCo6w5JBK01oS0Wlps+hE55lE3p3GJ0
 oieX4LG2PhIZB4aGZh4bYy4uzYN9H36bHQCDoMl2BmukYEn6LIe6wC6qJ9bAF1CsqUOI
 xblhDRQJQi4ZPviqyh1kHWfDNN6qndTXMLNR5X5i7WjDebwyIEdmdBJoc8NiAP6E/sei
 S0N7riPzdrlHw+msP+JICg/sAV++NE0dKGEASKl/yd56IpzR+IQ96VgSf8jscI6sK03x
 Nf+rk//1PexyuOOwucTjiQymCkR3svoK8nfLxRxHlfek8qQ4buyU1DMaz4gML4Y6o8Op
 0gKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0tk1sNLUx6Ej4cNE9moEU1bvNgNfSDqbt8zUOj7AGVmg8a76WlUVc5MA+qyCO/qo8vOx6Q/0=@lists.denx.de
X-Gm-Message-State: AOJu0YxAmsN2CrkqLmDfy8GGnmT0H8TMocJUNQ2CD4few5Kwfp2ReL2g
 CcT2sCFId9eC9zAGO7J6XSOhyx89Ipo3/6LzBxn6l4oCnxVwThlAGeY5FgYVHgtN4S8=
X-Gm-Gg: ATEYQzxOHqIEOvJRMmadUC/xTW2rOFl7He4kWSZYha8hQMWTpTAqZmIBol+uEoTcMQ/
 huvWVmS3tFsaLScXKTCoNru9dohj8oJ6Y6IamDFc/mj2QZnS2U35S7YRCqJSQwpt8UA6Mih6xdY
 6dEvZePqhnybgefIaFEmBzevicRjLealU3e/bnO3A7zMZIgTAAu0DnJQngt+4Fn9oPdIeEG1UlP
 UGHIc4OeXTRV1cCxeCKy3leCpmSwFZPSceN0YfGqd3dbrXjg5+37pUwVytMn8X0o83fDZxo6NKM
 tM4XMMuEFoU5b+lzYhYAHJctSch0+J3yKU/HDj+gqLAXdT9gAVVAdN7zfgiSBFLpv/MGT/9ydGu
 amztx+2+2Ug56FVlvM7IzSXt9ElOd1KgAyBxRRgCLDl71CMXDuXhRly+IbC81iHrfAbML2s4s5A
 wnazMnBOjom1RUyFBBdVFpPucipe8F73/kXvUKZSEZob/DHdbHsmDXxWBIfybIQkx/0UMVZ//uH
 LmQYQeG/j49Em2vN+VPp1vU15IYcVBGvfmUX5h5vpWZPdu1zJ4=
X-Received: by 2002:a05:6820:2103:b0:659:9a49:9042 with SMTP id
 006d021491bc7-67b0ffa6002mr1771273eaf.13.1772645322315; 
 Wed, 04 Mar 2026 09:28:42 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679f2bec8a1sm14599590eaf.6.2026.03.04.09.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 09:28:41 -0800 (PST)
Date: Wed, 4 Mar 2026 11:28:39 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] clk: mediatek: mt8188: fix CLK_TOP_CLK26M rate
Message-ID: <20260304172839.GA1388590@bill-the-cat>
References: <20260304-clk-mtk-fix-mt8188-rates-v1-1-c71fb26179b3@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vhn3Kd1OFhboGSS3"
Content-Disposition: inline
In-Reply-To: <20260304-clk-mtk-fix-mt8188-rates-v1-1-c71fb26179b3@baylibre.com>
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


--vhn3Kd1OFhboGSS3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 11:04:03AM -0600, David Lechner wrote:

> Change CLK_TOP_CLK26M rate from 260_000_000 to 26_000_000. As the name
> implies, this clocks is 26 MHz, not 260 MHz.
>=20
> Fixes: 11f3cc46322a ("clk: mediatek: add MT8188 clock driver")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> This fixes a bug in master, the intention is for this to go through
> master. I have some other changes prepared (not sent yet) for the next
> branch that will conflict with this. I assume the thing to do there is
> wait for the next rc release when master gets merged back into next?

Doing it this way will make it easier on you in the end, yeah.

--=20
Tom

--vhn3Kd1OFhboGSS3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaahrwwAKCRAr4qD1Cr/k
CrvxAP46GnIMgpEXU9mnHjtjyKY7JeG1SqBJWAzII/6sXEnoXgD+KElvaxvF9JL7
pSmlGY9Ss0K5KCO+vVShZ8okul6/zAY=
=lisz
-----END PGP SIGNATURE-----

--vhn3Kd1OFhboGSS3--
