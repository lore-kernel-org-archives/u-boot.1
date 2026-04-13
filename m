Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEEEF531CA
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 21:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F3584214;
	Mon, 13 Apr 2026 23:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CZ1DgUsH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B61E8839DF; Mon, 13 Apr 2026 19:21:15 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ED7A8352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 19:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso3278286fac.2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776100872; x=1776705672; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ScKfoSOzE9lZeiEWcxnRRbqkHqOqK/TReU5nIoscTfo=;
 b=CZ1DgUsHTYEAZvBXXt+lbbZIBU9v23syYOd1bS86oAYnAEs61Wth9at9JslH+XhTBT
 AMB/HipBUIGv3bUTGrlXqJdjySZCDDIGhS2XG47QPw4rY7KuTIGL7eJsJTShzjwdWRcb
 Q/u4wWCGdveh7rQ0wZ6iBqBBLdsp2xJPvZPWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776100872; x=1776705672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ScKfoSOzE9lZeiEWcxnRRbqkHqOqK/TReU5nIoscTfo=;
 b=OJOtMna8V0Hb8cm0iOJ/C805jbY1pCBsltZl6T24BeidOIq1elZ5JgACfLhhBUB1MU
 V6rLDJfNVeWOBF8UaorBztCjSzob0wH7KMZHe4j/B4lMMYIEhS5JswFeij2Nl8xuJOZ4
 wlunSSvpfjHQqH7K8nkHORkDcJTtk3mKQkwW5/Ngtia1Sc/kCPM0vDSUgjnpTuSdFjUM
 PoDhPTgOZJULYsE88Mmhm2FM3QI7SSWqAypebvAsN7q68YfFV81ORlXU5Z6XV4iEsmU5
 z7q60w0q/HKOKQHyxnxSkLWNN0iurWOYvtAj0nqNHvrOMDWenZtKGAj15xywqrlybz7/
 GVVg==
X-Gm-Message-State: AOJu0YzhvvXmTrdGkgwSvZKHVBjN7b7iM8L2W6RptaykAZvwsNaLRX5f
 QBjzEE624HwN9ePdWKZmm/zhUPdPwzg8eH4ThilZhREfHoD6uW+Zy7Oanmb4QwkkDqk=
X-Gm-Gg: AeBDiet45byy5UwG1mxZWzacVSPfVsf6MIzZ+qR2tWlTE0+fWsb4Gm7oOYt9/o60Yrn
 ob2hkrwrv3U4qA/9u3Y8sNlCxTtm5mlmsTtKeUEzh/bnjcf1Kn2UMlv8cLsviTJ9xAFVQCIuJw/
 VCzQBplSM2Sxmpib7Z3V9BtQy+sXjdN58GZOD5DqRA5W9pc33u2TjSUhc1AXoyCWqtjY4YK04hG
 ZjIgHzzWv+qXR+QWHyOWTRmDevhDd92m9yuix7PKP6TYrZp3F0PEenPijMwZIxUXDzvlTxwC208
 8vChs6ueNg3jFSpsAWTk2dJkN+TKl1ebnYCvENtnhnTtfKFuDBY3Hgim7WBrj1affIt5d4An6pt
 6B2E9tWFydlUIVoc+4lDQaFC+CCBU41klhNopG6YuNRKdhn5CHuLzCmP/Xnb2igO9hUZZ8qG5U2
 V1yo1ganPLReI7NAx6sorPrY4832lirJW6l7LASoyCcD78EW4hfXqy7x5wrcwu7gLqfyQ3iVGUH
 92s07HvRsLChr2nKq4yNjwc4O7M+83I/pgFWQsf5zpPlhPu1r8=
X-Received: by 2002:a05:6870:b01a:b0:417:51a0:23b1 with SMTP id
 586e51a60fabf-423e11f1abdmr7335389fac.41.1776100871698; 
 Mon, 13 Apr 2026 10:21:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd420bd2sm8798250fac.6.2026.04.13.10.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 10:21:11 -0700 (PDT)
Date: Mon, 13 Apr 2026 11:21:07 -0600
From: Tom Rini <trini@konsulko.com>
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alice Guo <alice.guo@nxp.com>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>
Subject: Re: [PATCH v2 09/10] qualcomm: add defconfig, env and docs for SPL
 on sdm845
Message-ID: <20260413172107.GB41863@bill-the-cat>
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
 <20260411-qcom_spl-v2-9-9609557cf562@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BB/dcpLBHfxR6eAK"
Content-Disposition: inline
In-Reply-To: <20260411-qcom_spl-v2-9-9609557cf562@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 13 Apr 2026 23:13:56 +0200
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


--BB/dcpLBHfxR6eAK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 02:00:14AM +0200, michael.srba@seznam.cz wrote:

> From: Michael Srba <Michael.Srba@seznam.cz>
>=20
> The defconfig should in principle be board-agnostic. Environment
> simply contains a dfu env specifying where to load u-boot proper
> (TEXT_BASE - 64).
>=20
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
[snip]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Booting U-Boot SPL on Qualcomm SoCs
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

That's a doc error (too many =3D), please put the next iteration through
CI: https://docs.u-boot.org/en/latest/develop/ci_testing.html
Thanks!

--=20
Tom

--BB/dcpLBHfxR6eAK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad0mAgAKCRAr4qD1Cr/k
CuVVAQCH1f7NaYECAOhs4EVr8XYBhqYD1jpeFKlww0SpSVpwzwD/XhBbCg/tTJ/M
AgzB4yPyX8V6ix44GbcnOrHn4vGEVQI=
=U+zl
-----END PGP SIGNATURE-----

--BB/dcpLBHfxR6eAK--
