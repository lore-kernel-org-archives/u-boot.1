Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40B9ECD983
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB11D83CD3;
	Thu,  5 Feb 2026 16:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="POant0/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CC7A83D0B; Thu,  5 Feb 2026 16:38:58 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED2CF83B95
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-408199852c5so1003223fac.0
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 07:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770305934; x=1770910734; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KBrovOuTrEmm7c4vtji5Ent/MRktYbBYlNONTERHaY8=;
 b=POant0/8Z5vMn2bybmaviBS2IRcjEnRSAhDEMDpZE4cAd3u4qGU3Z2w2xbDGf5/A1h
 A/5yrL6XymnlzoziNSvNazUgAQYrqP60WoTbHJkW9gmpAb3IVxQ3v1hQzJmz3fAoRLzW
 soYZVv1KZsUOt2KwI0AjXvL879ucHxroOi59M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770305934; x=1770910734;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBrovOuTrEmm7c4vtji5Ent/MRktYbBYlNONTERHaY8=;
 b=fcr+2qgF7zyrLbP7/AvsuoDMzBVhh6nczVchX/9ehrbaqwW6dQ77Q2bFlO0hD5ZcuV
 ROBJRg40gNh/EWnxZuWNBO3E2R2a8mkBk7DqyHfBMcCtfwhPNsCtSpL3D7A90h8M8ssP
 xvoZGPHRujjfZxMc0sH4/Ex0aUe93QsdiNyvaZL1FCExSamqdRUzrzq/3W//aVh0qSbE
 ZK2d9fwQdoHwUbbzwqvLI9IZhC1MciiLFumuqtz48129Iz2UVDcjBR1CkYQYTRbjIr1w
 D1KY/9eQVc5fxDGUVZMB/ayW6y2DoPG60/AvfhOcAp/cQnyNjvlFlmmP0Hs5mTo79Ihc
 M4AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFel18n/Xpg6HH4OHzmZk4FSnDADIQKVODZifDy45nR/sXpJLbrhZTEfYD/oFD99LtEqrXe9g=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9KuBpDKMshpKa3eb3wb1nPsw16+aoWB24dtGA+pP0LkdL2j/X
 5/qtnNoZJB8ZRAXkRgOB0icNwNJwfjsaNOmQRv4xHnLyzONKwW/3wNqw2iH730Rm0Pw=
X-Gm-Gg: AZuq6aJ2n1K/JPmBv8SYUin0aKux9TRnAph6EbUK18a0H9yRKJDe4V6LANz655UKcHj
 UhhxdesqRU/GrqMdpUBXIv1V9S3DhFFGsE9TIQrlQdYIJGKABHWL6MYcm5RTHuSZcH8QTtnRJOz
 r52UG6MXusFh7Cqpjl19yvjGWL5ZN2dKr3kJenIpsXzuJ8W++d0kLNI4j4o3F2N0WihNGFNif3n
 DfS59ZibQZOwlTbhwTOf8NLvo59GO9CyX6JUH+fm8BtH7z+YfgwgaYj2FBvel6KAW+iqiB0/EpA
 2g19EPgxukRlvdxxFUlIfpxw8iwFJN7yKggPms9joUqdkmiBd2Vghtjz/W7ds+2nrfrj8NOsZMn
 YWp/Djebxjq/lRVpjnJeQDSOboPtkrw2uZn0TM7pb+SDcbCIDtsT3qyWmE52bN+OAxBlWUjkpfb
 oZPyYu0BWnKpbabAIxCvmymwUZlw1EntCuIHMsabRsTk7azJGbcVcbPqwBQzfgIWu95BwJqRIZ3
 /QJGHxJx9Qm5phoRWXM7DmfssPhdswKWDS5qWg=
X-Received: by 2002:a05:6870:90d6:b0:409:4c35:a3ca with SMTP id
 586e51a60fabf-40a53d5dfb5mr3814126fac.15.1770305934567; 
 Thu, 05 Feb 2026 07:38:54 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a54489544sm4001122fac.16.2026.02.05.07.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 07:38:53 -0800 (PST)
Date: Thu, 5 Feb 2026 09:38:50 -0600
From: Tom Rini <trini@konsulko.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 10/12] dts: upstream: arm64: freescale: Sync i.MX952
 device tree from Linux
Message-ID: <20260205153850.GK2603314@bill-the-cat>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-10-2103d0222a0b@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="URR66cggZsxI5Yq4"
Content-Disposition: inline
In-Reply-To: <20260205-imx952-v1-10-2103d0222a0b@nxp.com>
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


--URR66cggZsxI5Yq4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 09:55:16PM +0800, alice.guo@oss.nxp.com wrote:

> From: Alice Guo <alice.guo@nxp.com>
>=20
> Sync i.MX952 device tree files from linux-next next-20260202:
> - Add imx952.dtsi for SoC
> - Add imx952-evk.dts for i.MX952 EVK board
> - Add imx952-*.h headers for clock, pinctrl and power
>=20
> Imported from linux-next commit 193579fe0138 ("Add linux-next specific
> ifiles for 20260202")
>=20
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  dts/upstream/src/arm64/freescale/imx952-clock.h   |  215 ++++
>  dts/upstream/src/arm64/freescale/imx952-evk.dts   |  596 ++++++++++
>  dts/upstream/src/arm64/freescale/imx952-pinfunc.h |  867 ++++++++++++++
>  dts/upstream/src/arm64/freescale/imx952-power.h   |   44 +
>  dts/upstream/src/arm64/freescale/imx952.dtsi      | 1266 +++++++++++++++=
++++++
>  5 files changed, 2988 insertions(+)

This needs to be done (as a series of, if needed)
tools/update-subtree.sh cherry-pick operations. That gives the right
commit message format that shows these are changes from upstream.

--=20
Tom

--URR66cggZsxI5Yq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYS5hgAKCRAr4qD1Cr/k
CudpAQCu6w7EVH8lW7kAsbKrYgquedLGDKJ4X+/motQl0T9wegEAzVBJTE1pA9IF
4ih9ICOMbPFlMXZoHz5MEf5qDopP+AE=
=YDte
-----END PGP SIGNATURE-----

--URR66cggZsxI5Yq4--
