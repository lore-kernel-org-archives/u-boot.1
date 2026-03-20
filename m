Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029111099B40
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 21:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CFC983CF5;
	Fri, 20 Mar 2026 22:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qn+Vydlq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F16C883D71; Fri, 20 Mar 2026 22:45:24 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DCE83CF3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 22:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d7fdb922a5so55513a34.3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 14:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774043121; x=1774647921; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s+NxE41JA/C3lQkMg6aVSFGGGZ87BjSn+YVQlxDStmo=;
 b=qn+VydlqO9ZyhaNCMwhhxfd6RW2kfHAfRqX2jBWPlkwzBo5oCzGyLO8zjvZtq6FYay
 W9Ex4P87DeqnzILPXmR80Fc6b1uWRSBeADhBTv30JOGv9M1XY6ODl74sp3GgQj3Ij6wD
 /5xtx+HaUDjXEIVE8lhRkgZ+ebpi5AGfghNag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774043121; x=1774647921;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s+NxE41JA/C3lQkMg6aVSFGGGZ87BjSn+YVQlxDStmo=;
 b=aiuO0u3uhipih1+cJBDBd3hRFC/XXQ5au3A/iC117FMKo7+SUOFRJtDrXqBOuQY/EQ
 U47EaUqmQEbPJFECrqFfl3reFUBBcy0hW/ipDbaTFasuukZ6o8OmiYzTa5HcArZVVZGi
 R2ygKW9jKPS6PjgSkyEvX8QCuFpQIXWedlbcKQGOUcolLqMcZgO/4UytHrj04cCfCmly
 xJ/HBC2PwZcW4TCpzbx32b0CWp1oaq8sT4XtI0AMRS8q75kaOHtp1hUkh/WBBxoBwHCb
 uTH7bVhnbxMRqOHeyyBJNbtDoEtZ3b/6Sh7gAmr3enHqvyJLYgdAKSi8Cq88D72fYmj5
 ncyg==
X-Gm-Message-State: AOJu0YxXTBPsgKAanIv33cExr4VZ4J7iLhpm/90ljdhDs+19L7flSpE9
 SA8O9Aj6vYwr0OnRXERetFFEd53klWQbU5/z9YGd6VBZe5dMTNn8rEO8pv4s9/caqnE3FMzicMH
 WP4hIj6I=
X-Gm-Gg: ATEYQzx2mVC13W0i7A7tiGoptDf2CBm1ktTyjyJnLemaO0hfYyfjsSy4335Mig9oMOX
 MM9em0vBR/iqQFDr9R7BWV0oKcDgqO3OZEtQqr9SxBDyqE/gDQxqQYRvUBoy/EYob5vZJqbnpit
 z47jy5zdjilyJJnacTPHJtBaki8nqf5P+fYD44fkvK4chHJt3Is8VpAF1jEkohikVMjOECRJva6
 YqglvWgJPC5N29D5nb9FtCyt+7EAh7SP7j7E9AW5t+KebA08W7G/7+EuVk6AvNa0ny+dxoT1Jmf
 pgI684i1rY6M9EQvjbNhLrAcrN+c2ZVJjha4GJih7iVol8pU90FSRealqV5yUbjSJQfhiWmgrjz
 FvD6NP3Oey64X3bM7nZ8Pd7a43eTwproBKK4GPcHN8FFImQFIOs3z9THEWqz3Lc9htjOFMIERJ0
 zEqL+R4SU0Bvq43ae4Mcp2JJsbCS9TIN5Ok5HCuGidzl0VqzyFQdgLPp/F15m5uQ7diX397Q6Bi
 gCJfAEH5DQZnvCCt3KV+tW/WMnE1oxkcw3fmstuOzX+XaeE
X-Received: by 2002:a05:6830:7301:b0:7d7:ccd6:3cd4 with SMTP id
 46e09a7af769-7d7eaff4107mr3329282a34.23.1774043121532; 
 Fri, 20 Mar 2026 14:45:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eae27691sm3224256a34.24.2026.03.20.14.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 14:45:20 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:45:18 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Teresa Remmet <t.remmet@phytec.de>, Peng Fan <peng.fan@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Marco Franchi <marcofrk@gmail.com>,
 Alifer Moraes <alifer.wsdm@gmail.com>,
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>,
 Heiko Thiery <heiko.thiery@gmail.com>, Marek Vasut <marex@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, upstream@lists.phytec.de
Subject: U-Boot and legacy SPL power control on modern platforms
Message-ID: <20260320214518.GD502704@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9EhSqD4xRQKc1/5n"
Content-Disposition: inline
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


--9EhSqD4xRQKc1/5n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

As part of the work I've been doing on clarifying Kconfig dependencies
I've stumbled on to a number of modern boards[1] that are using the
SPL_POWER_LEGACY symbol. Can the maintainers please update these to use
DM_PMIC, DM_REGULATOR (and SPL variants) as needed so that they use the
modern architecture, or let me know what's missing here? Thanks!

--=20
Tom

[1]: imx8mp-icore-mx8mp-edimm2.2 imx8mp-libra-fpsc imx8mq_evk
     imx8mq_phanbell imx8mq_reform2 kontron_pitx_imx8m phycore-imx8mp
     pico-imx8mq verdin-imx8mp
--9EhSqD4xRQKc1/5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCab2/6wAKCRAr4qD1Cr/k
CjxpAPoD63PqPTbhSh8VnhfH5Sl7DItrTUIbVtC1TRO5gczCUQEAlD6sul3uWE7H
DPTmgETwP96TFobStPEQNzJRiRPicAU=
=FcPv
-----END PGP SIGNATURE-----

--9EhSqD4xRQKc1/5n--
