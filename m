Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6606D15DBC
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 16:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DFCF88F19;
	Mon, 21 Oct 2024 18:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WFz/20RI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A76088D54; Mon, 21 Oct 2024 18:41:53 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF50A88F19
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 18:41:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cc250bbc9eso34185566d6.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729528909; x=1730133709; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5uQ1gL6zilIgjjhUQJPg2iMfocVB56H8oHtASbQ6pBU=;
 b=WFz/20RIjCXxYDmfxvtJ5ZioI3TTKZQxeCRt45IvfJUfZmQs5wfKkrSpPIxTwFb4zk
 M+AcI+F3Th5+uCFnA1ygUv55KB79lniFFbraBscApf6+0tQNFz4rD1E1I4McsjtsoWc1
 AuBw63D1W6ZBQuEpMXzBj9CqoO28Xo7VqQ+Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528909; x=1730133709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5uQ1gL6zilIgjjhUQJPg2iMfocVB56H8oHtASbQ6pBU=;
 b=wlJdcuEUb/HFpMSRV//3AMAG3oxYt0uX1zV240snhmM6Y53oUcFESAUplBYFO2mUed
 91iyx1VnKkFvxlEnCe7zuXjWuaKj435ByUK6VAGkhI5HCVHaci0cy4xY4e9j2vOXoS6S
 QOM6vw5y0L0eGfvARDl9peTpKwxc6vLxYBaOTFHOQk7sM4zHZRinAzk5gZZ0gpoCFFkA
 +n/dwzw0nIo2UX6U1OwL8FjmzzHeJxxzsbpjdbtPZeI0lnCQACrzBXvKVkkBgjR0mdM/
 eo5SYWrXSC6u4eRB38RIlNXjNmxwQOMTWU8TSzns9U083+fga//IN9mkthXMk6Aln5Ta
 M7Tg==
X-Gm-Message-State: AOJu0Yxz5lQAu1V+U7yoy1l25R+q0GZ9tBWJabBkaFZWf+3JlQKPdxgf
 NtvJFBWne+ExvUkDsPgWZmAZOhxRhZZdCAlfPjyFhSpzbxulF34ZLupZDKuqAoY=
X-Google-Smtp-Source: AGHT+IHEtW00tzfG6gcxtCywHTW+du6MJW3JN3uFeqRmaAvwxzIvBg8v/ylYZFRZMP4ZMiP3hJ061w==
X-Received: by 2002:a05:6214:3bc6:b0:6cb:ee73:6932 with SMTP id
 6a1803df08f44-6cde1531837mr189381026d6.28.1729528908055; 
 Mon, 21 Oct 2024 09:41:48 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009ddaffsm19146246d6.113.2024.10.21.09.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:41:47 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:41:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, u-boot@dh-electronics.com
Subject: Re: [PATCH v2 2/2] ARM: imx: soc: Move default TEXT_BASE for i.MX7
Message-ID: <20241021164143.GJ4959@bill-the-cat>
References: <20241020210113.1248062-1-marex@denx.de>
 <20241020210113.1248062-2-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vdHZ26E6jeSbl/RG"
Content-Disposition: inline
In-Reply-To: <20241020210113.1248062-2-marex@denx.de>
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


--vdHZ26E6jeSbl/RG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 11:00:39PM +0200, Marek Vasut wrote:

> Move i.MX7 TEXT_BASE/SPL_TEXT_BASE to Kconfig and common/spl/Kconfig
> which is the best practice.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--vdHZ26E6jeSbl/RG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcWhEcACgkQFHw5/5Y0
tywE2Av7BjKl3h8ueFylah0bPjBg8xoaZfEEnYsW2eD+U2/HxaJclUiiRVCToQDL
sjqa9Pn9V8w8hs6VnAvL+VNOO4BjosnMKFv/qzcs7SBDKVND6vQArf6DTLN5a9Gy
mb3H51HhKqOjtBL4XW7lg2EoaFwF6mW4/KSTUB23lNUuejDoljuAmI98zMlGJQPe
7usF37M50om5PfkBo7qf3bj6OWJhf50BgESOsyzgIOlh5x3zFBB/Kok7dxOHyL1P
9eWwRbAW0CbCLmVna5QWzfCj0eldmOutTUV91n9LSAdChykzHrM1F8fAzQtSm1bL
BVqgCBQpv97+muRlvvgBRl2k+1a53RM3OkQGGYZSuoR+uZ017veKzfKkggy7GZJb
tJdEBSjq+K4NW/+sdiRION5sqCMdw1UoDjCiQTOqq2l8/q7lZJfX5Y2Mic6eSx44
bz6UzlO84GHarhDN+EPlY7JtLw8PVb3IVuiARcXXVDq4i6WU+uOVaoHA1yGAeYk0
BUo8GTtS
=15+V
-----END PGP SIGNATURE-----

--vdHZ26E6jeSbl/RG--
