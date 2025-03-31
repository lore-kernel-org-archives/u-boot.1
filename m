Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681C7C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 14:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5535181F0D;
	Mon, 31 Mar 2025 16:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sNPpTtbk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4B8A81F7E; Mon, 31 Mar 2025 16:11:33 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8803781FC8
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 16:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72c7336ed99so316009a34.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743430290; x=1744035090; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zpeTb0NRt4RRD9+MyX04f5PONoUsHRqguKpLZOT/XU4=;
 b=sNPpTtbkIhIiq5F4Lcbo0FnXRlXVL4vOxLlXNyy4LooDWgk8YSggDK75iTXU4ay3em
 reZ1JPQmbb/v342ZQxQb6E2WQ2bbd6ktrhOY+jZGOiU5DXyBmUmxDEdfg+q/w8YDSFlq
 XtE2YEwoIYLVRGYP6ryVEKoyTEoew4aBrw6S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743430290; x=1744035090;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zpeTb0NRt4RRD9+MyX04f5PONoUsHRqguKpLZOT/XU4=;
 b=tdqU4sTwqWSs2N/uJpuEEl0Dm7AdH/zHI8HGFJP0YKLL9WDV7D97y2pOtcJ6bogFSV
 K8MNgAOG9MuPdhISQn5ZiGiy/0JpSkC/SlkDAFB5jz3iy1znifsezi7MolRYw+zmOLmU
 GF+BtixyzHqk3Ifir5QhDE4U60joiqo1jNaPwEFdbfWOXPYOLmIRqtOEY2ddgRr7blCP
 9OpbG1EeFiOP5OZqFOqDM4gt43ADBmecZt5ojGeyAMjjjMWICKe46kOEnaVZDIyed4MO
 QdBJRT6Bqzs4RJ3Fr5o8UfeomO/4do6+ozm+qYF7zvND3nqg4rONw1a1ZTBTHrOM7uQz
 162g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG5pBcia29avvkF95QZdxe08CNBSd7lQCRhR6NG2B5qgsaGty3dQi7+gYt7c5ofdjRjt6hz7o=@lists.denx.de
X-Gm-Message-State: AOJu0YwYbMlBuHMRHK1T25o/kMVrFCMLRQtsZjkH2tpVgJ7sTIf9u/JP
 BNKAH1ACpE6uY+N4jDjWaW7IMCaTwSV6BkNNvjUDdsqqiEOIy8LJR5F+gcLLkLHgKBbqWPKbJmd
 x
X-Gm-Gg: ASbGncsNSUGYCj/6o90yO+t8URzUvrexBmtYaFjZm8RKiWnXW+8ibJyp7wxVF5BLOdL
 gz+ZoiiCdZDEeH1ByP8CFMQRzWTdyOkWTIm9cTSwAaJ+BYaGD2H2p3RNyaEXbtUnDLrgcKk6/NW
 gSXkRbOrjkK/wAJ7UAIE/LF/Ti9cHhyk5lFbSftOGXCvpJPzqbNJSN1HSSOmWgp5NUguS0mWSYM
 wfeTtmc1zcTQCS+bYARkaocmcqJY/5KbqVWdTvw/VHc8i9v2PWf7bPaz+FkdsmALi7lVXsCwazm
 OZw+dN+7D8aqduAOdC5yuaVdiAw16Zu821SFQwLOFEYv0BnotYSrbYITbn3SySUYF4sDAA/tZJ7
 XSO9iSg==
X-Google-Smtp-Source: AGHT+IFj1BahQwc5GqkT6AJ0Jwe5i4dhruTmMkXVk5Ih4ofHNY2oSKB2SKeESe/EI+JUAqG2vy5eEw==
X-Received: by 2002:a05:6830:44ac:b0:727:423c:95d5 with SMTP id
 46e09a7af769-72c6377db9cmr5892592a34.3.1743430290207; 
 Mon, 31 Mar 2025 07:11:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580bb530sm1485569a34.19.2025.03.31.07.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 07:11:29 -0700 (PDT)
Date: Mon, 31 Mar 2025 08:11:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 13/18] arm: mach-k3: am62p: annotate switch/case
 fallthrough
Message-ID: <20250331141127.GW93000@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-14-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="arrtrk1WxT8KoLvz"
Content-Disposition: inline
In-Reply-To: <20250327153313.2105227-14-andre.przywara@arm.com>
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


--arrtrk1WxT8KoLvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 03:33:08PM +0000, Andre Przywara wrote:

> The MMC boot mode selection for the TI AM62P series of SoCs uses an
> implicit switch/case fallthrough for falling back to some default
> boot mode.
>=20
> Add our "fallthrough;" statement-like macro before the default branch in
> the code, to avoid a warning when GCC's -Wimplicit-fallthrough warning
> option is enabled.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--arrtrk1WxT8KoLvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfqoo8ACgkQFHw5/5Y0
tywJUQv+PjQnWUM5980FIRIkBUzlLeKavoXkWhN/6nGfrM7EoFszqEfPRWDXk6yS
TBW7wMF8s25y5J37+ibRKno0/6INmUJ05I3APcYPWqemqIeAvwATlP8mSjIcjqZQ
9hwwBkLQGlN+9noGgYwXZJRN0ctsPK1baEWnWGDuoYHZoZVqoJl/hzizUJRHGHW9
H7f8eVsQRhjbT3vTtWflyzC7d7QPqYwBivcNryFRLTDHTKCtBBF5NMp/9vjTH16h
vBVkMPdEa03IqNLFwxS+6uBqifNraDh5BVUPJSxvQ28JB/IZA9J4FFKI8GCUdqMH
79KWwDUsGxTwcxH/G+VXB4HCiOOxwaDGhk89DDLomY2m6Qsp1RHtFbSynfNrqdfq
RZlLao8D6xugcHNvXx7eWTX33Niuk9CWdPGetnK/rArjfXnwc632ogYOg0rMHVbo
4yRpLZsbdWh+U3POSaZu2sAJ4GXawKzbJ73t+JOnidgp/a03GWL9HIAdHwOeOeLv
JDexh/fr
=I7gc
-----END PGP SIGNATURE-----

--arrtrk1WxT8KoLvz--
