Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A43C43602
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 16:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A7C284BE0;
	Wed,  1 Jul 2026 18:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E1izPicp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B1CB84BE0; Wed,  1 Jul 2026 18:18:45 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 306CE84BC8
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 18:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so684663a34.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782922722; x=1783527522; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yx84Y6wFrIA6/1ki2ru6UVB4EbbhlymVmshLvjlkE9U=;
 b=E1izPicp8YvqP4uaj2P9LH4RT/8lh1NPEobRYavSnaBQG7jFhKqcDO/fgF2kzkkoE7
 D0mR/khvEZA6hI+yc9fRs3vu4PAhbxbMWEFptLwAMHH6/E2f5RoTA8PGoyafTZkNo0vZ
 jB/1Gbbihw6zuKGyHQah9LWROfi35H7mzDlcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922722; x=1783527522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yx84Y6wFrIA6/1ki2ru6UVB4EbbhlymVmshLvjlkE9U=;
 b=iSKGLicBpFznmRPA+29Ach/KusvoY+Q8IONjC34jAJy73q6Ty4J+dGng7+MpbAviXs
 +C6sFcy1ZK5JTJnlUDoaoBfl/+3DuM1X8QI72tYgFTZUFmvLd/7BnAjF+AI5fAoI+WTi
 WUCiy14idLkOsr9e05fOi5SFaYCDi2QQM3Q7L0fr77wl+ogYiDLvnKS9wwjRfaP5rFI4
 WIcueV76gex3zMP5ixTJB48XtAs8RRt2UJqg+zEpWs9WYh21nXxolK1LeKGWiSCw9unk
 IpPorLFWzc1YiQGN+7G2UeexYqAI3l9RQnT0cJ/MbLpzNUTN/PZHHOxWxN6GL+EBsXG/
 V7hw==
X-Gm-Message-State: AOJu0Yxljjlh2mwkmGql1KA6xf+tIIXHbb/DWXGRCbQER37opvTpGr8w
 vNCm9YI3uniHBOjzjhj77gcPWar4FF1sfgvowrdijEaTp0pYBTtiZHVyFV0yBd5PkFc=
X-Gm-Gg: AfdE7cnU0zFCVPuYGvXdGywacAOF1zd/VSVGSiDPupv7EjMY53WTAC3VZbYjspm1W4M
 yn5kGi0Xp0rMmR/voqk5TdqMqzWL9hYSiUsbi1H+HhLItugCgNJTk5DKjOK+tWeI0f6K2ELUTvF
 JtgsUII0U8hiwbKmDdUOSMGrlnfbe1xD+YDOuvMmHkOQx19n5rJ8NRaMsS8ijBAHUd7ouXuQF22
 q3ocUoqYRZsfvHSaCNZl+SE+U5BmsLdP9HENup/5rPrKylg/nxjn/GHImJJtvpoi1DCOzBoRjER
 vqicRf3xBS7naQsb2VMyLNslek59/lR2I+d2fnGUI9H+SHIY8UvbjfYCWZdIRvpLBNiP75N7u/q
 PQ6sBpG+1G2Hj6slmyKlKmHVBvdyHPIXPEq3zX4t3ign/uJs/pE6su0Rq4OSeSbbfxAgc5DBYE0
 Ag+oA7nSNrbXIBFtIpcSEbWoJ+xCmjTcBF+8h1l4ngcFy3YzGIaqz7jxferYzqz+xLYYnpoyGap
 k+hpp1nnSZ67Xk1gxzgNsKqPYe/FC5A6ZGv9Q==
X-Received: by 2002:a05:6808:309b:b0:489:f199:42bb with SMTP id
 5614622812f47-4960ee0f200mr1710024b6e.8.1782922721762; 
 Wed, 01 Jul 2026 09:18:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-496068abe62sm1774998b6e.5.2026.07.01.09.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:18:41 -0700 (PDT)
Date: Wed, 1 Jul 2026 10:18:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH] cmd: kconfig: i2c: add DM_I2C dependency
Message-ID: <20260701161838.GJ749385@bill-the-cat>
References: <20260701-cmd-i2-add-dm-i2c-dependency-v1-1-19ebda3a80f8@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l2ES0skmTv1vPSt1"
Content-Disposition: inline
In-Reply-To: <20260701-cmd-i2-add-dm-i2c-dependency-v1-1-19ebda3a80f8@baylibre.com>
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


--l2ES0skmTv1vPSt1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 05:55:14PM +0200, Julien Stephan wrote:

> CMD_I2C depends on the DM I2C API but currently does not enforce
> DM_I2C in Kconfig.
>=20
> This can lead to link errors caused by unresolved i2c_* symbols when
> CMD_I2C is enabled without DM_I2C.
>=20
> Add the missing dependency to prevent unsupported configurations.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  cmd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 032e55e8127..636891ed493 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1392,6 +1392,7 @@ config CMD_IOTRACE
> =20
>  config CMD_I2C
>  	bool "i2c"
> +	depends on DM_I2C
>  	help
>  	  I2C support.
> =20

This removes the command from the handful of still legacy I2C boards:
$ ./tools/qconfig.py -f CMD_I2C ~DM_I2C
15 matches
MPC837XERDB cl-som-imx7 d2net_v2 db-88f6720 db-88f6820-gp inetspace_v2 ls20=
80aqds_nand ls2080aqds_qspi ls2080ardb_nand net2big_v2 netspace_lite_v2 net=
space_max_v2 netspace_mini_v2 netspace_v2 work_92105

So the depends on needs an "|| ..." in there, for the I2C but not DM_I2C
case. Thanks.

--=20
Tom

--l2ES0skmTv1vPSt1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakU92wAKCRAr4qD1Cr/k
CvQdAQCtJf9sMnnkGO+MWdnOcTcYoodSZARsh110XyiCtlksEAD+PhWgYfaKW3mq
lXzDtoDky+CYL4BWL9ovUsjGOVa6/Aw=
=902R
-----END PGP SIGNATURE-----

--l2ES0skmTv1vPSt1--
