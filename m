Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF2CC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 21:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DBA87A02;
	Mon, 30 Oct 2023 22:37:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bszRQTM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 819B1879FD; Mon, 30 Oct 2023 22:35:52 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BB5B87A02
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 22:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6d261cb07dcso3271762a34.3
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698701749; x=1699306549; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uuL8zJtkzeP8eaSCl8I1cfJNgeIdJ2bpt21Ixa26rLc=;
 b=bszRQTM6zxpRkHPIIO39nXPSyc5AcTbehTscP7x2do5OZszOQVpjsxIFUyHKB3aJFX
 lVXYsbK6Cyxr/An70tRtcJIr8g9Vxh3JdsPl1VqykHdnla+KqLrbQ+ShovjPRdtx9DYp
 BRRos5gS80jP0qYxkoGEIHoh3ZbiJS6npd3oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698701749; x=1699306549;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuL8zJtkzeP8eaSCl8I1cfJNgeIdJ2bpt21Ixa26rLc=;
 b=UF9FbcMBujcSvI4LKa8qCbRlMwLYkZemZ8l9mWKVNzryN+fNktYWzg4/KeGSdlMZ8f
 R1qQ3xV3T8t8SNxG6b7PcLUdDrujwXjDgrLVgmgdlNB+1F3b3h5qaH49zmOaueEAtQjK
 fVWCXkEPkkeLmn0Svqt5Bdd19Z2kSbDO+dSrnKUJRjCzjy/sY6fKnIALHkogIdRQqYBf
 hRyVQK89rQ6dZfNvvYYI9vPmCIV5nWfJZZzKJgp9u8naZ6ZZNvYkmRtYaxI5jhQPdwKF
 ZOEpTut+bn4OpdDndFjqqcMKNqX4aSuKKUWfAswJpKnQ69M2ocWVvrnegQv0a+wKZrL3
 Bhhw==
X-Gm-Message-State: AOJu0YyODIIfX9ERod++zp448tyxbJmGYGZeukrDf5NT8jX9R5sk5GA/
 R+YZWl2B2qCEE5XGd1vO5xQMVw==
X-Google-Smtp-Source: AGHT+IGnq1/OF2xBFg3p18nAme47Ru8AuL9mZKBFVLtfluPIbe4VptkPmgr1NliyUD7iUCtJsjOtZg==
X-Received: by 2002:a05:6830:22f7:b0:6c6:3ea5:cdbe with SMTP id
 t23-20020a05683022f700b006c63ea5cdbemr10316984otc.18.1698701749105; 
 Mon, 30 Oct 2023 14:35:49 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 js25-20020a05622a809900b0041b7f89ad19sm3753849qtb.53.2023.10.30.14.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:35:48 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:35:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, takahiro.akashi@linaro.org,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chris Packham <judge.packham@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Huan Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>,
 Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Qu Wenruo <wqu@suse.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rick Chen <rick@andestech.com>, Roger Knecht <rknecht@pm.me>,
 Roger Quadros <rogerq@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Tom Warren <twarren@nvidia.com>, Vignesh R <vigneshr@ti.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: Re: [PATCH] Kconfig: Remove all default n/no options
Message-ID: <20231030213544.GA496310@bill-the-cat>
References: <e3bb5522913c8a917feb7d6309a693f7ee5dbe25.1698218728.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2UM+0h7cja2gNJuT"
Content-Disposition: inline
In-Reply-To: <e3bb5522913c8a917feb7d6309a693f7ee5dbe25.1698218728.git.michal.simek@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 30 Oct 2023 22:37:32 +0100
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


--2UM+0h7cja2gNJuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 09:25:37AM +0200, Michal Simek wrote:

> Similar change was done by commit b4c2c151b14b ("Kconfig: Remove all
> default n/no options") and again sync is required.
>=20
> default n/no doesn't need to be specified. It is default option anyway.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com> # tegra
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>

Applied to u-boot/master, thanks!

--=20
Tom

--2UM+0h7cja2gNJuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVAIbAACgkQFHw5/5Y0
tyyUHgv9EJZM2dAALVUXDuuq4MrdNMmeTvQJbUg5kzns5g8s4cgJAfgocrmckROT
ewwzz/R0H/xo+3j46eKWaSiPBRFHXS6VsTKj8Z9MZnwip8CcbHObK4+TZ9JP85s7
tlAgPBK4/JUzkJxsYDXAhAcbySY80/O3MwPE99XjOoUhqRpUU/3pwDEeFU0ZvRem
tT77KJ43yiu7C5tDPYo1ynGDU2egrsUVkT27/MwGWJQFQzV9sMbl7yaJD8BPNGoD
wW9LEIRsz05qcOT8Oa6/tZ+erjnKrLuDW/IuwGvJyXHIMf/1B5O8jFKEXe3UyPBr
VxGP9+HiFjdOUzC5FwxpJP7rTGSLSt37t+fxxAtfgJwbcb/irchPh8kLSTzSZaHs
Hq57fl2hYitMUSSj8yoN3GQSvNiSqaIqSq1TbaXpmXPDzuqZd4VCUTnYKOL/3xdV
s3z2QhfFQSHbZY7LsobMn5aLzxp3EkKf9oxLNTITd5AwQqG33hq5C7tZKV+Qxf6p
PW44rEJF
=sdw0
-----END PGP SIGNATURE-----

--2UM+0h7cja2gNJuT--
