Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B301CAC597
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 00:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F9D9829E7;
	Fri, 19 Sep 2025 02:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MEEVmvQq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A2858323A; Fri, 19 Sep 2025 02:12:18 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C95C81E13
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 02:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-74c7d98935eso824465a34.1
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 17:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758240734; x=1758845534; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DP6ScbkxyKIYsmRRweVCP9ZhdnhodpklXurusVDPhdw=;
 b=MEEVmvQqpnlPA265+RTNH8V4pvj59bePw+1Uo1XvGPfWozT44f5eltPnKVBdQciZj/
 78NJjzLMxiWRaxsaJISyd+4nJuyhTh4JPO0zv9caSYsnL1/8f9p8AnNtCGspUovYk8BO
 u5SMAZIS1yDHVX6py7Rnc9GYCCnCHLoNkbbyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758240734; x=1758845534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DP6ScbkxyKIYsmRRweVCP9ZhdnhodpklXurusVDPhdw=;
 b=mCbfWxM8z4dAg97fsAeKX7yTbr0ukaa9HXhe1H4v56VxL/zhTr9rnPrqppFgl5pdQg
 mfq/ScMQsE5dnBWl8ycrXYhX7QZCuqL9EZWMTa/ZRJ5acZvpb0GxRH8zC4LPhwmscn88
 h4fgoaYi/YIwog7YvIxAtmfq78/3a2oe5QKLxnOq9f8AVr7PzN5XEZLTVge6QzoKLzwD
 isGjBqww6D06QWhgiPBPgYTHpRoxAIgOOGlKaSSj+cQx6qVj9/LlslcSglCZpiNlZhH3
 NX58RiIAgiYZngHdHcsV76Sgt66TEHJkkfcwUHY3aQqzVwdRA4OLd6AhEnj6wBijzkUa
 gWIQ==
X-Gm-Message-State: AOJu0YyK4Z9J75J6JFFqghByPGHLYks+5aQ8FKxlQUj7BaCtWxIRJTu0
 /k4XMJQZAMfc/WA3oBgYcyk8dYDN1ocYnNM932YrpkWhjHB6kEdcfVHbynbHLZ7wIzk=
X-Gm-Gg: ASbGncs+xQPIX8PxBPksanYUTRZZMOFVqPC7LSWc75mJTHGnDeB9PUN0Jw/M4Rtzuzo
 PDuAay3fn2YiTcidfUpLSdR6gAoxUOFoGSB8odX+3UiHXyyRYKaHTvYJqb8Cn34f1CFNRMEx1BP
 PJcFXzNpZa8veUwVB7zFuZ/+rQQ9vGGHG/a++aLscgo8qbZcyoIMkhhS5J3eDb4sYYSfYnwcq9H
 cCf2ZddjesCTAzv8F2TJed8jhFJfK4b9hirIeFH5bfxqhh82yyK0o5ZAoqyk8XjRZNvAQr/mKla
 8/ho0XEf3Up8z2uiOkHFYXaOkvcmAL26nacv6U6p0bbPbagpo5o4geg2xpgoqy5UMJahsg688f6
 YYeCkRHOoK8hTOCYXwJOy1dn9/02LOmsSr80FxQ2XeGu5RA/IihvJe2m8
X-Google-Smtp-Source: AGHT+IFgZQneBmIex26bMELX+q3Y08CL24yaku8PbDmktxmN+iC/ZZeF7Du65brqeHGsLtOg9iiVPw==
X-Received: by 2002:a05:6808:2186:b0:42c:5291:8ec with SMTP id
 5614622812f47-43d6c199752mr541732b6e.18.1758240734359; 
 Thu, 18 Sep 2025 17:12:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-625dbbaee3bsm1227869eaf.24.2025.09.18.17.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 17:12:13 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:12:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sky Huang <SkyLake.Huang@mediatek.com>
Subject: Re: [PATCH v4 4/5] net: phy: Add MediaTek built-in 2.5Gb ethernet
 PHY driver
Message-ID: <20250919001211.GS124814@bill-the-cat>
References: <cover.1757315849.git.weijie.gao@mediatek.com>
 <6ee539edf71577a0cf5d39dad495bb7121629993.1757315849.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d/YpKRbYI7b41pZp"
Content-Disposition: inline
In-Reply-To: <6ee539edf71577a0cf5d39dad495bb7121629993.1757315849.git.weijie.gao@mediatek.com>
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


--d/YpKRbYI7b41pZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2025 at 04:34:18PM +0800, Weijie Gao wrote:

> The MediaTek MT7987/MT7988 SoCs features a built-in 2.5Gb PHY
> connected to GMAC1. The PHY supports 10/100/1000/2500 Mbps
> full-duplex only.
>=20
> The PHY requires one or two firmware files. Firmware for MT7988 has
> already been added to upstream: mediatek/mt7988/i2p5ge-phy-pmb.bin.
> MT7987 has two firmware files which will be add to upstream later:
> i2p5ge-phy-pmb.bin and i2p5ge-phy-DSPBitTb.bin.
>=20
> Environment variable can be set for firmware data loading:
> mt7987_i2p5ge_load_pmb_firmware for i2p5ge-phy-pmb.bin
> mt7987_i2p5ge_load_dspbit_firmware for i2p5ge-phy-DSPBitTb.bin
> mt7988_i2p5ge_load_pmb_firmware for i2p5ge-phy-pmb.bin
>=20
> This driver allows dedicated weak functions to be overridden by
> board to provide the firmware data:
> mt7987_i2p5ge_get_fw() for MT7987
> mt7988_i2p5ge_get_fw() for MT7988
>=20
> To enable the PHY, add the following not to device tree:
> &eth1 {
> 	status =3D "okay";
> 	phy-mode =3D "xgmii";
> 	phy-handle =3D <&phy15>;
>=20
> 	phy15: ethernet-phy@15 {
> 		compatible =3D "ethernet-phy-ieee802.3-c45";
> 		reg =3D <15>;
> 		phy-mode =3D "xgmii";
> 	};
> };
>=20
> Signed-off-by: Sky Huang <SkyLake.Huang@mediatek.com>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>

Sorry for the late review:

> diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/=
Kconfig
> new file mode 100644
> index 00000000000..7de7b65b4e6
> --- /dev/null
> +++ b/drivers/net/phy/mediatek/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config MTK_NET_PHYLIB
> +	tristate

A tristate makes no sense in U-Boot, it needs to be bool. I'll fix this
in the merge commit while applying.

--=20
Tom

--d/YpKRbYI7b41pZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMyf2wAKCRAr4qD1Cr/k
CoCGAP9U2stxxsPJGBI+593y6PKwUfh2FpdrOZSh15tpBSjatgD9HPNri3+pPr52
yYWz+dPi3az9cBC36ClJhTXliTXieA8=
=gqNT
-----END PGP SIGNATURE-----

--d/YpKRbYI7b41pZp--
