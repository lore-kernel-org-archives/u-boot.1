Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF58EFCD9D
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 11:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7600839DF;
	Mon,  9 Mar 2026 12:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BXzwIDdm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F4283BC7; Mon,  9 Mar 2026 12:53:33 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 028A8839D5
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 12:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1773057210; x=1773662010; i=xypron.glpk@gmx.de;
 bh=L6DUC+gghmrH9lukdAXxouN34GxEqs1APb/abRO5i8k=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BXzwIDdm3xgln99pX2L2tGQP/repda95XkDmTF0Nk5N6Bf47s5Q2hbf6OgJ3mPJh
 6TQ1muJUCR6w3/5l+k+6POWa9ddu1Wi7pS7oGlcqAy29zTn/Eouue8BfExbgYj5bq
 q5r22P7qYhmEHN/Cye0sBIOn8lqEvxkk0AAq5bMrpA5VRPLey16+UBuh1zZaBOohK
 ZPN1fmV8ir0yjiDw1BvEThRHYBfSlL19QQdvzYEhZIsBJ+sNgpDvKk1nBhOz7Z5Hi
 Gjr6glgK1+VVN7zGPaEX8VFMC4403/KQDc8RiOy9p6WFOy9NSBTlctv3aSP/dpxjl
 UD2uHCjNKtUdWDIyGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1wCVkA3mmh-00Jttv; Mon, 09
 Mar 2026 12:53:29 +0100
Message-ID: <426cf3de-d2a1-4b21-89d0-269343d8d98e@gmx.de>
Date: Mon, 9 Mar 2026 12:53:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] doc: board: starfive: Add Xunlong OrangePi RV
To: E Shattow <e@freeshell.de>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260305164328.33789-1-e@freeshell.de>
 <20260305164328.33789-4-e@freeshell.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260305164328.33789-4-e@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WFThi256DxFsKQHbi3tMKmWJzhJk3tSbVEyMUR3D0/b2ojWXIHU
 neSCSu/FwS+Lt0dNjSco7L9JYrUujWsIHuSLR+L6/nws2JjeLrbMSVvXs+n7ArGEkZ7h6sU
 mBfWTgcZrM5BLmMYJwGNGCrNyg3pT4vrhOSAjhYQkLUCLOAbz3ZDb/8mmi6zoEUnR5E5RiS
 ZZ2M881jRd8kC+NqXNxew==
UI-OutboundReport: notjunk:1;M01:P0:EG1i9+AlEh0=;VCIAcC2I1vym5x7gIqWbyrw9Ukp
 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
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

On 3/5/26 17:43, E Shattow wrote:
> OrangePi RV is a board that uses the same EEPROM product serial identifi=
er
> as the StarFive VisionFive 2 1.3b.
>=20
> In fact it is not completely compatible with the StarFive VisionFive 2
> 1.3b for use with Linux Kernel however it is good enough for use with
> U-Boot SPL and U-Boot Main. Describe how to set the devicetree search pa=
th
> and, for advanced users, suggest that it is possible to update the EEPRO=
M
> data with an invented "XOPIRV" identifier for automatic board detection.
>=20
> Signed-off-by: E Shattow <e@freeshell.de>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   doc/board/starfive/index.rst       |  1 +
>   doc/board/starfive/orangepi_rv.rst | 35 ++++++++++++++++++++++++++++++
>   2 files changed, 36 insertions(+)
>   create mode 100644 doc/board/starfive/orangepi_rv.rst
>=20
> diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
> index f85d7376b44..0996e0a68aa 100644
> --- a/doc/board/starfive/index.rst
> +++ b/doc/board/starfive/index.rst
> @@ -10,5 +10,6 @@ StarFive
>      milk-v_mars
>      milkv_marscm_emmc
>      milkv_marscm_lite
> +   orangepi_rv
>      pine64_star64
>      visionfive2
> diff --git a/doc/board/starfive/orangepi_rv.rst b/doc/board/starfive/ora=
ngepi_rv.rst
> new file mode 100644
> index 00000000000..29cc58a1e2b
> --- /dev/null
> +++ b/doc/board/starfive/orangepi_rv.rst
> @@ -0,0 +1,35 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Xunlong OrangePi RV
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +U-Boot for the OrangePi RV uses the same U-Boot binaries as the VisionF=
ive 2
> +board. In U-Boot SPL the actual board is detected as a VisionFive2 1.3b=
 due to
> +a manufacturer problem and having the same EEPROM data as VisionFive2 1=
.3b.
> +
> +Device-tree selection
> +---------------------
> +
> +U-Boot will set variable $fdtfile to starfive/jh7110-starfive-visionfiv=
e-2-v1.3b.dtb
> +
> +This is sufficient for U-Boot however fails to work correctly with the =
Linux Kernel.
> +
> +To overrule this selection the variable can be set manually and saved i=
n the
> +environment
> +
> +::
> +
> +    env set fdtfile starfive/jh7110-orangepi-rv.dtb
> +    env save
> +
> +EEPROM modification
> +-------------------
> +
> +For advanced users and developers an EEPROM identifier product serial n=
umber
> +beginning with "XOPIRV" will match the OrangePi RV and automatically se=
t the
> +correct device-tree at U-Boot SPL phase. The procedure for writing EEPR=
OM data
> +is not detailed here however is similar to that of the Pine64 Star64 an=
d Milk-V
> +Mars CM. The write-protect disable pads on the Orange Pi RV circuit boa=
rd
> +bottom are labeled WP and GND near the M.2 connector.
> +
> +.. include:: jh7110_common.rst

