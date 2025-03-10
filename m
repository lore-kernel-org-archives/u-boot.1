Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E94C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 15:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC37F8168B;
	Mon, 10 Mar 2025 16:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hgCic0c9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF37816AB; Mon, 10 Mar 2025 16:19:17 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BC1D81760
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 16:19:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2239aa5da08so69368635ad.3
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741619952; x=1742224752; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kyHR93p/lY/+nJFG/+ZLtYs5H8JbnM2Adave+xcKBwA=;
 b=hgCic0c9zljuTEvbxkW2j4zdGbqSz2Gn0TyObW1oc8FACc50XGqd0t1MUmqaEYAZzM
 M3r+KjZdj4aMujhspsm6RV0pMwH22KBbueu+kJ55HZE/R+p/SGaU1/9ofjpFzSQsoQjt
 iV9OLa5oN8kFaWjnX9Us60YUeUE0JRXFxR34w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741619952; x=1742224752;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyHR93p/lY/+nJFG/+ZLtYs5H8JbnM2Adave+xcKBwA=;
 b=mLE5fCPHGuI7jdGdt66qYo+FyBLCJtUjP3efCQ6EpeGgtrK9eRKezB2w7LwkJZb1uP
 B9KM47qrqT/nhQVtg1tTkaZnmYz37RAPGbCltOE6PIaI0Mm82mt+mGPUo6zlw1qyIAQ6
 dnF4S/U2dWXLQ4IULoQ6Bb44w45rRYEcYQ0B0ee1aOkr/GnZnwhlqXmnT4aGFpVew87Q
 0WOe8S4pZVk4aX6GI4cysp5zhsNeh82ck4We1UZQDlO9bKAlTNACe0Ozi+G/tj02YHF8
 aPyUCletrmTSNiiePPLKwWwSW9cnXJqGLvTsdWCa558GDucXw/u8TqT2/DvgED+RGUSq
 0D7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCURPu4cM/fW1vC+XMJ8S1zDwkPnU36tr/7tyn1pcasAJtO/FEDR6UppO0ZnQCUVkU/QVB9kSI4=@lists.denx.de
X-Gm-Message-State: AOJu0YwhetceK493nyVbOD/Ejw7hGd7gNFTXr2/PKoHXhAAkY8aq383u
 QKqBG41CTULEQFTBeZKbcc6AuZuLfHo8Do1A8lvJP4Xe+167Eyaq1beelLihVHg=
X-Gm-Gg: ASbGnctDcUILc+5MWJKYGytTo5K2U9LWE1Mk13AbKmMEn0sanzNR4jPClhAiPv8VAma
 myHEFMd/Pg9InNa4nJNEpqjYIj6hTVX+kGFxSo2ERBUjVOOqX6/qgr6K6qzsaOhM+V2dMd5dvoL
 n6UVVgIlzsOOueBPg6vHwsJ1fHPeORgP1zGCN5Sm2Z/vVTt/hM9rwJwB0xbdIAE47UWNe9Z+KWG
 ZhZoWZnjZx+zSPQZiX+zgJ47MVVveewKf6GRzKKRNm8juFWVUwWyTN5JtMglxshJUPEwofSgk6a
 CXMp739Uh7UykcEgrRw89MChLl9zQm7KPbH/d/pp7Qq7LA==
X-Google-Smtp-Source: AGHT+IHyInBYYx3KmKUTrsR4d038ATDweVhIZRHHDducXQ3kUlScTdSxDXepUTXdxqTYKXbuAUNtFw==
X-Received: by 2002:a17:902:fc4e:b0:216:53fa:634f with SMTP id
 d9443c01a7336-22428c0d14bmr242686805ad.48.1741619951695; 
 Mon, 10 Mar 2025 08:19:11 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109df225sm79748075ad.47.2025.03.10.08.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 08:19:11 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:19:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/4] airoha: Add initial support AN7581
Message-ID: <20250310151908.GG2640854@bill-the-cat>
References: <20250309140652.23543-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mXdVrl0RswT5uVOU"
Content-Disposition: inline
In-Reply-To: <20250309140652.23543-1-ansuelsmth@gmail.com>
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


--mXdVrl0RswT5uVOU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 09, 2025 at 03:06:42PM +0100, Christian Marangi wrote:
> This little series adds initial support for Airoha AN7581 SoC.
>=20
> All driver are created with OF_UPSTREAM support in mind and
> the very same binding and include are used as reference.

Please re-work the driver patches so that they use the bindings /
includes from OF_UPSTREAM then, thanks.

--=20
Tom

--mXdVrl0RswT5uVOU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfPAuwACgkQFHw5/5Y0
tywaowv6AsgrlUAyO4csCAVxGwIV38vQJKW5amEXGWzO+L5DtKGipfT5ZC9HLxMC
MEBw6CYiV62SJFzYWpYo/zcg7SBmEskTB65HDTFUoPe4lZ0dbbUkswSVLDRhhIZc
FUs4wurYBAznb5dTo/KjbAhqDrHp3IXlxMCDHQHuBtYKvIbyGNJ6JftWuWo7EgO4
j8c9Ucf8Si9TM8oZ+9suqETjAc4C6QdJ27HjwVpxyObS51kZZSQVkZ6Nk6Phg6GJ
qKWCD6xGz8TH4UzP+vcmGc83nLvUT5YiTydBze55VJ8R5jYF1f1uCKv+W8l3SJ34
6KsrP9DIKKF3MY/twt0d+VThLR9rHGCVSTcazFOMX3yW/EvPG3xsSqsvXADzfy+Q
5Jb+2AyEAocJhAHInQVUJXYz6VJifqs5+4w7Lw+Jdi4dBnc6h6AgHY0R/ll4u033
2DwBXABkW00kiFpvOXE530jdqNMS2xjsoG+RukkERgfLFD1RUDWhQfkL1xmoL1ee
cxptt2bn
=f4az
-----END PGP SIGNATURE-----

--mXdVrl0RswT5uVOU--
