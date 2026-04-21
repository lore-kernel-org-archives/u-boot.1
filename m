Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C42FF94CA7
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2047283FFA;
	Tue, 21 Apr 2026 23:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GCnVPIwy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C05FF83E36; Tue, 21 Apr 2026 22:47:03 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF47880433
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 22:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d7ebe11bffso4404903a34.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776804416; x=1777409216; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BqyRXnzn9CNw099weYHW4aExhYuAhKilTwDAzGfLP74=;
 b=GCnVPIwyX91Jd04X75Hc3Cl/MI1L75mjq9v1IcpCE+VAUlo06NqxOE4mzYjvhKXNtN
 bUNOFdHo2rRXOb9RMOPWVt2QJbe8+rY6gtz2nvMKwSR+yl5SbOdPrg4+8uVyiPQhf1Xo
 +l26dS96isWae/vIletqKu1PmRqELIBuIo6mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776804416; x=1777409216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BqyRXnzn9CNw099weYHW4aExhYuAhKilTwDAzGfLP74=;
 b=SXqgm/o5+L5zcmx1nnOy5hjpABabWD8d7zc+1XiiQp3hSrnZANbykFCUcjG4j3QAsd
 3F+EuL6VAhOgSU21WDFUBg5LuFguJc7K18voBJbUQyv/95zz0sq+W5jLCvRSlNnCO8qC
 k6kijzhGS18RKtiGBvvzru2q1IZnFYOFfHLQ4v2cboMNmlCgoZQzGG4sfe/nWYbuVGhv
 PziJnPf5JB9p4+xLJhe5E526ojAs6Q4lquA2D8DGGft99gqbvFS+1T7KEyt9wXyTeuxl
 pTf72XirYCfs+G+/JDU9EzMUMWLgMeOi6xNS5pEsW1Ns5VXwKLcsoIMrBG77DPzgvZqh
 wPig==
X-Gm-Message-State: AOJu0YwpGfy3n9TRzaL5cwiK79XAzeJasZaw2NWXaq43m9+DzXP9nv59
 zOOtoBaNjbruMvoBUbhCRc+3zxSN1jNlBTo+HOXi24+I2V8ijFBxAZhfRa35sPThUZc=
X-Gm-Gg: AeBDies30qsQQ7ccBcfAAUpc5UqdwC89cTMcotPOcM6FIc/z+XUPOlNFv+RhlixDqdE
 fPOpX8DraCyjLh8f4F7nb/a1wqqa5tItwku4Y9FA706I3pWe+RQ1+Plc3Sq6vdaHqaL8YHZRy27
 f3NmY+Rm3e2ZoUCGl8lav+J+WIj+UHeTDwRx9Np8sP1uJnHfWiK32RMIsKn6CL1FvuckYVLwD6L
 EnFvj3fGB3lolcpKwUwlWVrMQuD5o9vCPYz9Zom7zsa20VPoEUuRkUclQnNEn38cs6docYbz1uC
 C0Fsxd9lHZwf8Y0Pvb9dTNRVb879lGJLReSm2aym0+z0yM357wstZryBWAv4otPQj8jyiWCbGtP
 4FyqiMSGjIlu7eLAfGkrengDZUIxNjnoWDwAzqzj4EibxsRYYwZxPt+R/WGOH9b/qab45dYUfWp
 HPGYYrFvMv5Ws/vYiXlYB36XqY6Ckbs75lR0T28YOWUu3cQqFu1ms40bYciC6BmdWKXK0hTvjbZ
 8c5taoNIoUcEq8NhhLeH8jLUZXuYq7W+jHnZCH0lihKSuky3UQKcLVtdK7SNA==
X-Received: by 2002:a05:6830:6603:b0:7d7:d198:3586 with SMTP id
 46e09a7af769-7dc9518cbf1mr13276014a34.13.1776804416477; 
 Tue, 21 Apr 2026 13:46:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dcce5feb25sm4336222a34.26.2026.04.21.13.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:46:55 -0700 (PDT)
Date: Tue, 21 Apr 2026 14:46:51 -0600
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
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v3 03/11] drivers: allow clk_stub and spmi in SPL
Message-ID: <20260421204651.GB41863@bill-the-cat>
References: <20260421-qcom_spl-v3-0-efee3f76754d@seznam.cz>
 <20260421-qcom_spl-v3-3-efee3f76754d@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xN17qSHA7b0g5sdB"
Content-Disposition: inline
In-Reply-To: <20260421-qcom_spl-v3-3-efee3f76754d@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 21 Apr 2026 23:01:13 +0200
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


--xN17qSHA7b0g5sdB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 09:43:46PM +0200, michael.srba@seznam.cz wrote:

> From: Michael Srba <Michael.Srba@seznam.cz>
>=20
> Only Makefile and Kconfig changes necessary.
>=20
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> ---
>  drivers/Makefile      |  2 +-
>  drivers/clk/Kconfig   |  7 +++++++
>  drivers/spmi/Kconfig  | 13 +++++++++++++
>  drivers/spmi/Makefile |  4 ++--
>  4 files changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 43d0ba33281..477718ce89a 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)RAM) +=3D ram/
>  obj-$(CONFIG_$(PHASE_)RTC) +=3D rtc/
>  obj-$(CONFIG_$(PHASE_)SERIAL) +=3D serial/
>  obj-$(CONFIG_$(PHASE_)SPI) +=3D spi/
> +obj-$(CONFIG_$(PHASE_)SPMI) +=3D spmi/
>  obj-$(CONFIG_$(PHASE_)TIMER) +=3D timer/
>  obj-$(CONFIG_$(PHASE_)VIRTIO) +=3D virtio/
>  obj-$(CONFIG_$(PHASE_)DM_MAILBOX) +=3D mailbox/
> @@ -106,7 +107,6 @@ obj-$(CONFIG_DM_REBOOT_MODE) +=3D reboot-mode/
>  obj-y +=3D rtc/
>  obj-y +=3D scsi/
>  obj-y +=3D sound/
> -obj-y +=3D spmi/
>  obj-y +=3D watchdog/
>  obj-$(CONFIG_QE) +=3D qe/
>  obj-$(CONFIG_U_QE) +=3D qe/

Code-wise this is fine. But this reminds me, did you run this whole
series through CI? Thanks.

--=20
Tom

--xN17qSHA7b0g5sdB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaefiOwAKCRAr4qD1Cr/k
CiN0AQCk+MGiXHBjMJFTedX3g/QIuMJVJ7Di86O4aUppglY1cwD/eYiDr0Xcx3b3
G/eTd7hZL5Afni5Zdm4gLI/WbjchlAo=
=wWtS
-----END PGP SIGNATURE-----

--xN17qSHA7b0g5sdB--
