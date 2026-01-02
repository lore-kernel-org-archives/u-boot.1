Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D312FA3726
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 10:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B627584209;
	Fri,  2 Jan 2026 11:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UjKuX+3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD1FA8420C; Fri,  2 Jan 2026 11:27:12 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D20984207
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 11:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1767349629; x=1767954429; i=xypron.glpk@gmx.de;
 bh=xUw7hqj6HBJCvehBgCVpXgpu1CCwfeY1jS9b/td8i84=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UjKuX+3z+y5WJefyw5xMc5N5U9SEKAoS9ev/CZDlQjX4QtcVNLhAFTUVZKUSU/o+
 EJkGNwdKqGAztKU+JlZ27JDAtzOFERBsf1IVsCWrkjesJCh6JxE875/V49HMkwv0h
 cpSzMDIAoCpuWCzlukFV2yfJkAoBTLXOVqulGoTLt214VhJ8Nezn123u6xzGN2nt/
 KH6rSuOPtvkgrGg9BOKYI5EQ83PzOxLwQo+6RgI8e/Zrvxc6xJXDp3KSvzQYF8348
 RDxj4Lq65eAMiJZfD5eQoeEF9ye9hUzuc4sVSf38Vzp71psqdbs8R4X+CfwzDsd0u
 rwxnp89zzzSh3rOncg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.126] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1vvdYB32jX-013T2t; Fri, 02
 Jan 2026 11:27:08 +0100
Message-ID: <5aa51678-0928-4b59-80c8-579e5a28e982@gmx.de>
Date: Fri, 2 Jan 2026 11:26:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Update links to doc/develop/falcon.rst
To: j.ne@posteo.net
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sidharth Seela <sidharthseela@gmail.com>, u-boot@lists.denx.de
References: <20260101-falcon-v2-1-75896535ad0f@posteo.net>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260101-falcon-v2-1-75896535ad0f@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xfx5wFlICNsFzayj/PtK4WcZgXLXTEgyTjC4FuIS+Q1X2JeBt5k
 yzfsZnpzyFCD2XD5s/QGkxiy2w1O4rPmpaKoaCc6+wa0g3RGHsiqqdUTa0n6oVRJay3w93/
 j0Zbj6HjEAUQp/TKdElxgpnT2gZsZPy7Z3SZEImjXUkGjIUb5/IU2cOYZaawBJQp6fi2BnP
 HTl71l6OKjSJAAjtCPZtQ==
UI-OutboundReport: notjunk:1;M01:P0:29sBHYekK40=;rBsGF5AEXuarOIPgh3Qp3sIEdAq
 zc+xirwZ2J01XBV/fiyxeMG4j9yMGT1ZBRZME5ZpWkQPVkJNBRhew1Gb/MZ6xyHIsQ+ugwDYK
 OyiTQTBUaLFGql6TYF7pVyChOMPBXLChioYw3H2gl6gIlQpvkTdITCPxIBosC1JBnGGMWDJR6
 NodCvjyz7WRu/Ksl5e9b2eM8O5u/6lU2lM4FR/3PN4ms/G68lH8QrBRq/fHZjxmQRV8aLYIW2
 5VG1fET2JndFq4xCq32kx0kueimC2rwB9U7WmoN4xUfA7P6nQ0voIoSJXLK6zZMESUOoXafxD
 IrrJzAxBtq2nF0qYIXcmkl16BPyTZTF50livgozuhnRshHSYn+uvsU7K0WI+nAb986sPYq+Dd
 vS8mBtvCdGIow1fF1PqIqujPZRRTed8Kpw1lmh+uPpSr6yMD+bHyiUbPuy+lA22Xu7FvF9dab
 voKyZPM6Vd6b7lZiHQRML7M0j4Nt9XWXi8bsVNssBz4Ocp28avb2cz9uNnQcmcA9iLWaPehlO
 IKqDWApA4vABiQRANXXcnkWWMY+yotFVRKF4MV6jTMrN9u38UlDOAwNAIZom70eyIDe3OI2Ad
 vIfs89TU96rViRoFZStZM7HwbVlelYWYvacO5TfJ5Yq/mUrgEYWDb7t3MUXc8fhcQnKPPZzyh
 OFO2HcIfgAMSK9b+JHR3+xrE0liJgH8NvDhBvs5Sm9cP3UInV0OA/BDQ+sGLtT/Ja8wIx2yCF
 fEQkLhqPylBzpFHbW0hyn39i0DThJ8RXYQlGUV6l/T5mFvFwvCfyZ9B/srXJJDHmuK03h3woi
 +4dTfaI3zDdqd6cCsuN+G3NKit6ZQVxuyUsDsltfJlNovUtah4jyzMCm5lRWdJxBVrhOS26Rl
 VzK8RZ5xVr512zyqA89Fy0RkDUyshBziXrx9lOeq57/c1TWIuanHOAr5D/1GYaUbYNyRriOxW
 6MaZA8FA12SryCEDjIZJC+i9WyeZ1zMWVqcgHPRoMl3TcmFNk/W7wKv6DiS5+zgDPb6zqM/pn
 G1tIY4Ggdr1gsbO/Y7t/2BuNEAEmSSSsN2ddxljzHteWiGGTINRZxaQhPJAIRLbjXDrvLa+Th
 zggYsKXOlXHpdBkCup10tpNBcvd09lFBNAPP3GMfPJX4SQ4Ku8yvn9D/d0HH2WqVvEIUUaYcX
 Me+ItG6Cc/5DkNhfhtVbVqrmrtH7MRxagHpT9uHRBY3fne3D8UN/cdhEEWCvsD6bse389gwYK
 xd68QI51OW9fF2dwBwTnoZsFRkuQGD3sv8W7L/cXLUSrMLN3LnJgp+mjkCFAiWkfMNnbpezm2
 wzYg4qMFYu+hgqtgcU9Y6B+0KbyxCbtDx7ppk8hFd1+BChwXzU6mm8NQiklXsH9IokUVXbz4K
 Y5x4Uy3om+hhUQXxpyrNfdX/quVbUBbHpLdn4zyD5Xkd+vDbcORl7ba+yUqGeRWc20re0VfQo
 BR0vtJt/OFGTxYVeoaT771/U3OLRJt5LkeNFnTCHFY4v5NMQ2CRXrdKqc9XVN0Jy7pyCm/xx9
 PoVtqvCxsb7/lhjWjydSTOVDylHumWZEX+0kkWJm2xzmIHPpt8vYBMpEwi8PDR+aJH39hcFnx
 mVJhxaYAWNfSU8SzLGovDCwk+riwMicgmgqmptkBLTebqRn2+3vGAHa+c+tp7ZPq/SFzSguWw
 l+fdu/FVlXHRyuR/6Rtkli87b2HkPW9J9xRGGWOZrYaR/K5VaEh8QTmnOfM1uUDrlSWn42wO3
 OlLtRfkR9PozRqj1dxEA13cUJ1vYsY0bEIgkg/NAeTr9kgWnbidtppiw9AsCjLAxQhTqoXO0D
 zbL1GEu2nbHWr3Ooew2D/L1uoo1iC0HnChQNh2Co5nDH7V+68boBV9WmGX8Jdhv2Yc6AnG7YT
 /TJdPpk7jOA09qU+wGAhPMDUasNbM2wT4l/WGz6gkswr72kbxwdAo1tMr9PLb9W7wUvo/5fr5
 ELbGVqB+ArN/Fl0NrJa1cUdcsaq1IpC2UCz3rpKt+W79i3tjGdrtXiaHdaLoT0kBFi0ey67TB
 aeW/owJtBku4EVPFfiQlCskpTiM8OnOOYVn0mDnwelGDZNuO3tklfUVG4Fq2y5hnL4VH9XyIw
 aYDEq0IWDCMO/tmg6yFXIcjqYm+zJdf34hcITugaZjAkn3/qLj+COKk1wFBch04cx6b+/19GI
 j1VQUHCFpYn5xOvBD/HvBDxbVA+CDEY8lCUGwbTF5Xx8RlPu2Hd0rwm35m518zK9wS3uNe/vi
 0+k5i1mtV7d0n8aHlu0l+CtE+L/rR3EI4uJAAEqIDH1MTz382g1WNiZ7Cs62YuJtmyFcVMLR2
 KDqfIEnEoc1i22Xy+9c9HzRCCz2RPl83mNYMCHQVbn57w0v1BjWTscxY1GoEXc/+F4x/23vGC
 RUhJDeQj7gLnhnL/rOFuhNOzj1FfwkIp1//51QDT1GtDMepITxmuM8M81JBN7oycw5daCFRUW
 tD+7lj2nfNMbBnImIKpMpVThJnMBf6Fsx/sLkMFpzSA0zwYaQgZx6z+Z6Yid5Vl8E8CMBPw7s
 B4eIKwJ8LqcuGW9DuhSINCqtuFER6nogfhoHrGsE+u231bk/4J8/7mBYygTMAJYsvmqUdclKK
 wkQHE0KQIDATbMa1OIe8YU015y8i/qBsnkrOuQBpAgbPexpZhti6kvsDcm/HFLLVSdetvFryt
 ctpaPYvBQKNbHzX864B1A7QPmBiZCTYW8h8XCySLS1nByF7XPDgVuZ+1/K59dKBi06jOw8AbN
 hw34Yzp+HIIvky8R+JHNWuoxjqlrvwv+QHbqz3txHeIk485QgST++EDZdGhiO/29iij8WJu6q
 wGyq3RUf6PQ5M6QXRwWR0MIzB9Ekc1MzCis4OF6ss99fPPzF9ODNsWUNoRvNb9ru8FW5EeJ7i
 z1hjfhWYdx+rtVTASOlowptk6UX5kHdNj/nbgANXJKevqmPJlo/uisRI91zR2lHxVYzSW4ISM
 3Qe3GJnhcBfSFmQFbnbWGYTFNna9ycTiV1PYBpgA4N5GlDmc+eR3LzwOt1o10sEBdq5nRyd4B
 paEvIVMQVWG6MTnmjcOKJwrRxiUBwMpRZrC8l//6+JFL/GoVjjynKquGy9VyfV5j7VrQlXVLT
 nuOr8Oxa13N17aCVLp/JGYA94sey5ky0w1gIMAmA3tmw8sLxl+89BkwQwGRet3+GBV7XfcgaP
 xAGulcwppqlgn5yxpE01Kfxvxpg3w2mALR2Nd9yEuD9ZN4mK9hyB7qhZAP6kqVbMofk6d3o97
 WhLL3BIWYh1aEOIMdbXg3a7dq3aS7h/92PdJAXKnc/PPtvMKz4vO7l2y79jbYsPdKmG2+6oiJ
 E3fLWNQA0/mY52RZHNHlhvmlSpMTVczJqUgBtzgFfDZuwTS5EMoZeJzMYkFRRdcgUDz+AiEwJ
 UV/GLEHFcD4jYKBygPi1iQBxfWktH9RvbkwcjBz/VEo7+k9kjTiim3LAkiEkqRQ/1NWSSAVPT
 3m9ghzGiWkH6e4Rga5W1EoH+OBdsr5kOf31AUysG0pWinX+8KBDjjmrXz3oMdpRSCsqT++Qoi
 w/JEObN9ntLZEdLKiVcLQ9sg7Q1Qhs0mwjkes99XNqnFFOndN2/Urdkubmy7OyVNsfgnQ+wCg
 9pdQfwAq0z89eXxUH7MNQV+WHs3EoAX8NBntoF9dJ1U0D10qtVV1CwVdz8V4els2Atz/g2OPP
 1Np5iZmPTZ5uDdOoofBxUaq8Cd6QHIoD7eHLdUxc3XYFO6Phah0EUoZFkJej47vls0mwjV3dE
 RSiUgglwCj2A7TXP/kXL4EF25ztolCYQKk9Z7Z8Yi65NAsBzSmIMOPafn1N5btrsz5l2bG5ma
 G8uV7sdKlM5kUYLhxM4KfeU4r32a9EVyOYOtjY9xMZt7CkziDM2kSmL03mkCp537P6IzGG6wW
 lJ1eRq+X0FfezoYGRadTyxpypd6NFpCVldb9WVRvgjDivES9xf44IgH62B6WW/eVjB2MaUoN7
 mLm4HmQfaqO0dL/SQxcXX8tG89ZI9+5MlOQKLc8LYD10EgUq7h/d6yHPsl0WpRh2bclf4Olmp
 gQT+U3RYTCh0o34LWCJCT7Q+rY8V5NNJuUNqg02oXwmEoEBBYZZ8OM8ZzGsG7N/kcBln664Ag
 nMJAvBbbfSw4gMOSui1sqRWjVRAfe8+joAmQhk5TAP8sRJNy7iUABNanH68LFSJG6KQ5PyWx5
 a6P3j2PiBp5j7slRLbseFo+9aDJh2MrbNeTOV/LR4czit011cwVNUXOlPqB5gGbktAHO5iGy6
 J2QMyhOUmj4IcecVRDavrApK8yZnoQp+7TQ2MMfNIcPg/TeOFt5ERA6cCFh32IQZg6GEtGgee
 TjqZFKN3D6smDn8sOqphFvoO8MKspuF7vzE8J/ynCXsxqYzE97DWoP7lJRTBJVU9IYVYoXNvH
 q8Rjit5YJCQglmMsvf9LkXRQWYw6Ek6CtTXuBwOnW6xAuS6YLcOgqaIOYF7d7rAVXndxTljSr
 UVrsD3AvYcCXcvRTlZQChEiBnyNmSXx81rvf9CPuV4+0r00/UYnPjOeiSsEogYmcqX4oos7cq
 SMpAcaON96iF95en/eJjBL9EYM1d9UK5xM0nc2IdFwESsmVoepnCVuApdJmbWS7GaBACUip1x
 cGcMHjgwgqFSpKLo6gPi/A6/BIr4Z1+sQZxU6TyH98YUVBCeVs+tdqlS5fU8EVaozZ1FcnjHj
 S02aVScBBh78U7kh0ZAIcX4fYBqImOtzLXdAZ9W+PjqRKFMqAYIZTI6xSVA8N54ba5MMbwxIL
 x3aUGDL379ZEBUDOD+556ZE3MkQQyvx0dAntRxFWX3K2E2eXP3CC+K5PwfP4me9R4zV/N+Ixb
 gJHRR0xnwlEowP3gzodQjIsLZraHXZn3fcGfejegt3eWhrLra5Og17GjXUJcZ6mjVvrsMsV/L
 aziZI0ME/vssTtJfe1TEOJjUi8XBVZlDy8R3M1NsOJfoRvRswQGFF4xl1y9vNS41pPWlugLzQ
 G5Vh15hoxbmBeNbdSasxh30E3nT6O1hj7RKT57wYNf3Toc4uRyJWbD0ewT+pyXkTLFEEAltIB
 Agi8coy3CR/b0UvEhEhB/0AXqy0XUwnPqx/syVArr2/LOSZSuyH6/JQeLGd9mTvP2VaPWjW4S
 PnT4zO36/NarBr8oML28QADUowymQRTj6PpX6FygStpy5Qfqt3QKIvlb1U9uWI6pjkSA3JYOw
 LbJZYGBFQ9+H9byDV7ancmwCAWjM5ZYN8aiLTE76g42+66hddrWoSbJSkkxbNlOvJGfikhco=
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

On 1/1/26 15:17, J. Neusch=C3=A4fer via B4 Relay wrote:
> From: "J. Neusch=C3=A4fer" <j.ne@posteo.net>
>=20
> README.falcon was converted to ReST/HTML in 2023.
>=20
> Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
> Changes in v2:
> - Use a proper link within ReST (thanks to Heinrich Schuchardt's review)
> - Link to v1: https://lore.kernel.org/r/20251231-falcon-v1-1-19c85b9660e=
6@posteo.net
> ---
>   cmd/Kconfig                 | 4 ++--
>   common/spl/Kconfig          | 2 +-
>   doc/board/ti/am335x_evm.rst | 2 +-
>   doc/develop/falcon.rst      | 1 +
>   4 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index b71ac554c0b..fca2a0b0e39 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -620,7 +620,7 @@ config CMD_SPL
>   	help
>   	  Falcon mode allows booting directly from SPL into an Operating
>   	  System such as Linux, thus skipping U-Boot proper. See
> -	  doc/README.falcon for full information about how to use this
> +	  doc/develop/falcon.rst for full information about how to use this
>   	  command.
>  =20
>   config CMD_SPL_NAND_OFS
> @@ -629,7 +629,7 @@ config CMD_SPL_NAND_OFS
>   	default 0x0
>   	help
>   	  This provides the offset of the command line arguments for Linux
> -	  when booting from NAND in Falcon mode.  See doc/README.falcon
> +	  when booting from NAND in Falcon mode.  See doc/develop/falcon.rst
>   	  for full information about how to use this option (and also see
>   	  board/gateworks/gw_ventana/README for an example).
>  =20
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 4b10e9c3880..f0612acf0c2 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1209,7 +1209,7 @@ config SPL_OS_BOOT
>   	depends on ARM || MICROBLAZE || PPC
>   	help
>   	  Enable booting directly to an OS from SPL.
> -	  for more info read doc/README.falcon
> +	  for more info read doc/develop/falcon.rst
>  =20
>   config SPL_OS_BOOT_SECURE
>   	bool "Allow Falcon Mode on secure devices"
> diff --git a/doc/board/ti/am335x_evm.rst b/doc/board/ti/am335x_evm.rst
> index 40e144948a3..b14ba41917e 100644
> --- a/doc/board/ti/am335x_evm.rst
> +++ b/doc/board/ti/am335x_evm.rst
> @@ -274,7 +274,7 @@ into memory, then written to NAND.
>   Falcon Mode
>   -----------
>  =20
> -The default build includes "Falcon Mode" (see doc/README.falcon) via NA=
ND,
> +The default build includes :ref:`falcon-mode` via NAND,
>   eMMC (or raw SD cards) and FAT SD cards.  Our default behavior current=
ly is
>   to read a 'c' on the console while in SPL at any point prior to loadin=
g the
>   OS payload (so as soon as possible) to opt to booting full U-Boot.  Al=
so
> diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
> index 528a9c389bf..3fc23f65c45 100644
> --- a/doc/develop/falcon.rst
> +++ b/doc/develop/falcon.rst
> @@ -1,4 +1,5 @@
>   .. SPDX-License-Identifier: GPL-2.0-or-later
> +.. _falcon-mode:
>  =20
>   Falcon Mode
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> ---
> base-commit: 4933a0e67578789a57f540a378ce0698435b7b17
> change-id: 20251231-falcon-7a97211ecbbe
>=20
> Best regards,

