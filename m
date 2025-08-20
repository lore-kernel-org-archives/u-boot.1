Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AF2CA0EF8
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 21:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A456181E13;
	Wed, 20 Aug 2025 23:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="J5UdaSZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C7381FEE; Wed, 20 Aug 2025 23:54:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D13A7801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 23:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1755726895; x=1756331695; i=xypron.glpk@gmx.de;
 bh=SsMgsausfFnY4I7spSfINZgHDAnGZc8m9NRXMxHWBXs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=J5UdaSZ83WKOF3yCMoyZTV7IF00rmtBwuh9FXdm0PFq5Ys2gbIMA8VCXECfuw5dr
 rzRapt4qMeggWhKBRblLYDtwPnXFiBHFR2o8bGVQGwSty1LeSt6MH7z4HD9Wa7oVa
 s/8q3BVsA4KHVCcoNxbudUxxsRB2zh9PZZnMganmkE8h9AH5Zz5bot3pv2RkdTQiq
 Jr2pgMN0ojnSz7eUhcixDCvbKZBZ82Ezj/jWS6anm2HgdJ+MyruRGnjAv3NGLnEen
 QVye7oLj/H/xDiZWBGylSZcVe5wVNnV4NI6S5jibNgoEGJX4oEL0nU+QJgOib7GF4
 OUNQFQ4pRcQ3MAqR1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.108.215]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XTv-1uTFTa1NRJ-015h9o; Wed, 20
 Aug 2025 23:54:55 +0200
Message-ID: <9a62ccd2-1b25-4d69-b392-50936dfd8217@gmx.de>
Date: Wed, 20 Aug 2025 23:54:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] doc: Fix typo in doc/build/clang.rst
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-2-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250810233742.51902-2-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V/GyJL6IWeSDXQCG22l/pBQ6cMV76W6pLO+fKWPd1SOcrvsNHon
 yNEeDPmiYKymSWjNojo/AVBNztHVU2lTFJSKgCMY8iXEtVvX0liuAcPInZ7NBx+OobSeMF3
 XBEhPJ7sgE4BGZNVxZe6uaRAmvSoF5Iklm9Wh1ZmPyLFTtvNMBS/XytyQG87WZ69SZp9nrz
 +cNeF/B8ydAmM69ysFH2g==
UI-OutboundReport: notjunk:1;M01:P0:uCXRvW645Vs=;ubrWsU3qoinAVVj2+Y2RyEJbcoQ
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

On 11.08.25 01:37, Adriano Carvalho wrote:
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> ---
>   doc/build/clang.rst | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/doc/build/clang.rst b/doc/build/clang.rst
> index 09bb988e923..7f9b7c266d9 100644
> --- a/doc/build/clang.rst
> +++ b/doc/build/clang.rst
> @@ -46,9 +46,9 @@ It can also be used to compile sandbox:
>   FreeBSD 11

Thank you for reviewing the documentation.

FreeBSD 11 reached end of live 30 Nov 2017. The content of this section=20
needs updating.

>   ----------
>  =20
> -Since llvm 3.4 is currently in the base system, the integrated assemble=
r as
> -is incapable of building U-Boot. Therefore gas from devel/arm-gnueabi-b=
inutils
> -is used instead. It needs a symlink to be picked up correctly though:
> +Since llvm 3.4 is currently in the base system, the integrated assemble=
r is

The proper name is LLVM.

Does the issue occur with current FreeBSD?

> +incapable of building U-Boot. Therefore gas from devel/arm-gnueabi-binu=
tils is
> +used instead. It needs a symlink to be picked up correctly though:

%s/symlink/symbolic link/

Best regards

Heinrich

>  =20
>   .. code-block:: bash
>  =20
> @@ -64,7 +64,7 @@ The following commands compile U-Boot using the Clang =
xdev toolchain.
>       gmake rpi_2_defconfig
>       gmake CC=3D"clang -target arm-freebsd-eabi --sysroot /usr/arm-free=
bsd" -j8
>  =20
> -Given that U-Boot will default to gcc, above commands can be
> +Given that U-Boot will default to gcc, the commands above can be
>   simplified with a simple wrapper script - saved as
>   /usr/local/bin/arm-gnueabi-freebsd-gcc - listed below:
>  =20

