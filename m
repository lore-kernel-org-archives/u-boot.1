Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C82C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 14:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03A9B80F4C;
	Tue, 18 Mar 2025 15:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ps5b5ViF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8EC9810E8; Tue, 18 Mar 2025 15:04:08 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97AC1800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 15:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso4546466a91.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742306645; x=1742911445; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cnja7rsGYpPj7isaVo1cnjlHI4EY3kgmemysq416KcY=;
 b=Ps5b5ViFAM1Pidb8Hg8tRlxdXAAomHvQhh2o9fAu4+UkJjbZXNos2IsiZrQkoQNWXq
 bjcxf1sRVFNkgVhew40XoK+MyxmJ476iHp+I7YkBJAc+0Yche+qxakA/jrwSyeypTOrQ
 BNC1do7gCi5fMJuckD3tP/INRigdU9Ui1iE2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742306645; x=1742911445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cnja7rsGYpPj7isaVo1cnjlHI4EY3kgmemysq416KcY=;
 b=WP1ey+z8INrlGFsxZduptajHMYyvXpmaME+SJJPVyaU5A/y2b4HasPPdgqDWZ14wkk
 Cbw7tMrL3qqFlYsMN56TavsdrVBd2JQR0WNCnnvNFEaHxtJrABIJQyhgomOmIxYBuOak
 AkgGv84JaDcMSZEQtXgGVxEV/iJcapVR1uGLibVa3UWKIYStkrPDz0thx6/hk6i1xS4a
 EUPTupMVKqB/xfEybMVpqYMk9qhhBV6G5jNM8RZk1O6Gv2P+HmEB9J2zdwUTIuoKX+8z
 2sNN2DpZ6ZXFxXwj48tY0pdw9BkkxvgHWxDvhiK8ytdnFtOUSOLWIM3hJFdyMeELE/eW
 lUOA==
X-Gm-Message-State: AOJu0Yz8NbEJ0N3ANqG5P2bBR4H2XT2494DRz5f6azRh79Ti2d8SbDY+
 BSTwiHVYwlAXraY+af803Cb7hOJq/yQm3SW2TUwP757062nmToWAepV675z86VA=
X-Gm-Gg: ASbGncvC8kEqrW6wn5BcjfHn7GfiGcrGFWFYciGUsdeYEv78DrORpHgveiK1ZJBuQvR
 Sy+mac7PY2kiFfAsdU3T5ETSBO46we7d0Wj+ix1iJFwkwbJJGeDhqJVBeKONATSmGsdUaFw/YEH
 HxD6K7RXo15/2prcUWTQPNNejlV/5NiyqUnqt4CfkKh7siWNVDj/IjkcbGsGHas/MVtAP1hPAIu
 BK0U45LH124OZDCIXdUO8JkVwG1PVEn/a7IAgHBi3mYppSyxwMvGOFTmf2iazQSX7O0iHnIJdaj
 f4qF/9CYh8QTLzh1cL+ieI48EatjSwfLFGU29RAzr1q/leRZ9aDgMLiA
X-Google-Smtp-Source: AGHT+IHL6l3jMQylXP75nG7bTESKeQcytrdTBrJOgOpJ6+9jvwwdOBUpGQA1L8mtC+WR2/qH/5HsTw==
X-Received: by 2002:a05:6a20:7f97:b0:1ee:5f21:6720 with SMTP id
 adf61e73a8af0-1fa513b8f20mr4821371637.16.1742306645012; 
 Tue, 18 Mar 2025 07:04:05 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea0428fsm8987390a12.38.2025.03.18.07.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 07:04:04 -0700 (PDT)
Date: Tue, 18 Mar 2025 08:04:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v5 38/46] boot: Consider non-bootable partitions
Message-ID: <20250318140400.GX2640854@bill-the-cat>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-39-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0g/83C4/l2cO9qYj"
Content-Disposition: inline
In-Reply-To: <20250315142643.2600605-39-sjg@chromium.org>
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


--0g/83C4/l2cO9qYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 02:25:58PM +0000, Simon Glass wrote:

> Any 'bootable' flag in a DOS partition causes boostd to only scan
> bootable partitions for that media. This can mean that extlinux.conf
> files on the root disk are missed.
>=20
> Put this logic behind a flag and update the documentation.
>=20
> For now, the flag is enabled, to preserve existing behaviour. Future
> work may provide a command (or some other mechanism) to control this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Isn't this backwards as the existing behavior (prior to bootstd) was to
scan and use these files, and so that's the behavior we need to preserve
by default.

--=20
Tom

--0g/83C4/l2cO9qYj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfZfVAACgkQFHw5/5Y0
tywAsQwAko5JRy4jF+heUG8ECk3Q3lRUj4x+HGXbxxVV6lWKJVAtZ+BUxPe9k916
ojz+CEgH7zvsvOnhJKBCS2/Q9XL/t/yY2sTfiflXg4a6u1cShA5Yzhy6s2HFMuXN
pMarT0GtfFbarlknggqKRUhNi7PGYVXsyHFgobJi/9LqGwqsTajr9d2njknvIDFE
B1a8GFcnL0W7fGnjwdFlix3EAPzXafbI1KHhkshljvsl1ms8coPTo2pc4Xj1uwvM
2OnPPr/MHc5q1Db8zo7EXw/TircrdGh1npaOuYxzAIDiApVTnLPOBbTnEkFo8v2Z
XCU7ocG0rDike3DE+YkbUCpkHqncDypSrmvHjjcR39UQrw8vWkPUsDyPldcYXWyd
iZTDKtNFdEhWBQq3HDYm0ihiDj4suZOSXZFVIUZNrXLoz2EMfDkQko9diLe5ybfv
9U17bcWgwxfijQXLzZUTilP0hPlEgEz7Yuzoym4Ej41FlghHIr7GCDlEhd6FFS/U
hc9LZ9Ud
=UJmc
-----END PGP SIGNATURE-----

--0g/83C4/l2cO9qYj--
