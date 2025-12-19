Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9A6E668A2
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 23:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12CBF803F5;
	Sat, 20 Dec 2025 00:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="C1v3a1O3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 055CB80FA1; Sat, 20 Dec 2025 00:10:53 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B1680050
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 00:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1766185849; x=1766790649; i=xypron.glpk@gmx.de;
 bh=gJXevLtZ4Vxvb+362rzIPr7ZIXiVa1390FwAscGgaTc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=C1v3a1O3lQKQEPKJupl8XzAPbYdt4IdsCF3068nWMJYRzkBB40HdvrYpb5S9Uq74
 YZnudzNIbEmWT+tF9Ck0NUfRnOG7ULZD6WKPl1tMJQEYjpiGHk9BiUrOqgCRnXWpU
 cSh07tmY/JDIG7lB6UbS8rthuujsnFpuK5EctV/tnAiykbKo87UirB5IsVa7SmI8B
 wX2Kgm6SzzqsjN3CffuHoOUU/2BNo9Ir+0npnzMaLdSvZn056JXxb7HSG3dAq1sfu
 VPkALXfd45j5/TjKKJBvjMYYgz+UjcyTlaiYZXfoYCuc9gdGFcvaQz4ugHkEw4CzC
 riA6/u6JzraYebtP+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQTF-1vmkw80DMz-00vv7k; Sat, 20
 Dec 2025 00:10:49 +0100
Message-ID: <0b319cf5-35b3-4b5c-ae12-8a1a8cb7f2d0@gmx.de>
Date: Sat, 20 Dec 2025 00:10:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] doc: cmd: bdinfo: specify required dependency for
 some info
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20251218-b4-bdinfo-doc-v2-0-2fb328750026@cherry.de>
 <20251218-b4-bdinfo-doc-v2-2-2fb328750026@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251218-b4-bdinfo-doc-v2-2-2fb328750026@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3n9IWEOcWLfWHD5P8VwkBOnreyooqORM1I8Jxml+uYYcZyHR5x+
 siz9b0srf1oDcVTw6ElT6TIL9YmthGiAPm3B1EkEsRfNf1ttyZNm39vOlnOScTLckL0GWk6
 UEKZXSF1x1n6nz5z8Gzeq3S5Jo3aoX4VHwAMxhMOvbsOJTAeqbWgTEvNq3nGdw7MmlsvKYO
 0lRWr31g3IeLvjxZY7uww==
UI-OutboundReport: notjunk:1;M01:P0:zwmcD0JJqrE=;7gWcgaTkMGTu2ThrfKDRB6r0fbt
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

On 12/18/25 12:44, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> The devicetree, current eth and IP addr info are only available when
> certain symbols are defined, so let's make the dependencies explicit.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/usage/cmd/bdinfo.rst | 6 ++++++
>   1 file changed, 6 insertions(+)
>=20
> diff --git a/doc/usage/cmd/bdinfo.rst b/doc/usage/cmd/bdinfo.rst
> index a139c9d855c..2a5873a400a 100644
> --- a/doc/usage/cmd/bdinfo.rst
> +++ b/doc/usage/cmd/bdinfo.rst
> @@ -77,9 +77,13 @@ Build
>   current eth
>       name of the active network device
>  =20
> +    Only shown if CONFIG_NET=3Dy or CONFIG_NET_LWIP=3Dy.

Thank you for updating the documentation.

I think we should get rid of all of this CONFIG_NET || CONFIG_NET_LWIP=20
stuff and have a single symbol identifying network support in future.

For maintainability and readability I would prefer

"Only shown if network support is enabled."



> +
>   IP addr
>       network address, value of the environment variable *ipaddr*
>  =20
> +    Only shown if CONFIG_NET=3Dy or CONFIG_NET_LWIP=3Dy.

ditto

> +
>   fdt_blob
>       address of U-Boot's own device tree, NULL if none
>  =20
> @@ -95,6 +99,8 @@ lmb_dump_all

The LMB information of course depends on CONFIG_LMB=3Dy.

>   devicetree
>       source of the device-tree
>  =20
> +    Only shown if CONFIG_LMB=3Dy and CONFIG_OF_REAL=3Dy.

The dependency of the devicetree output on LMB is a bug in cmd/bdinfo.c=20
and should be fixed.

Best regards

Heinrich

> +
>   arch_number
>       unique id for the board
>  =20
>=20

