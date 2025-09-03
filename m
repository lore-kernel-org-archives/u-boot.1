Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F95CA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 12:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD446834EC;
	Wed,  3 Sep 2025 14:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MDXVyIhK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92F608350A; Wed,  3 Sep 2025 14:09:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 993F582FC7
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 14:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1756901348; x=1757506148; i=xypron.glpk@gmx.de;
 bh=N+rtsOpHJVUMPdF3CCbFwsFFtU8tOJ+3hwQaCmyqVtw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=MDXVyIhKBmNHTzEa9YElkq5MFFlWj2wZYzWwGSutpp0en3DRwggZBXJ6TmEU2w3j
 bKY91ehhn5FZZq4KWvf4DuxEFERuioYSQ63Zr/NLxa3ZsK9iVf2j0uGEKJtNoiMXg
 sHV19j7ySkdQmBApdxXkIrHJ4cnk0eUATSVlu9c54N5iT4u9njg0ZCZ0MoBowQpXN
 xsvHTHHKNnS1X50+H7uj7tKOisk4nwl2UyWqv4CF/RYf1HdPqN1x3wEHBrVsLc1rN
 K9w6aoF68SuGyRq911QOpoUVLikOngBQj6dBhHU6ijUx//gJRULfn8aaiVt6hlmUI
 F2zuvD5t5thB0MRGCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2DxE-1uSzAj3mog-00uyn1; Wed, 03
 Sep 2025 14:09:08 +0200
Message-ID: <5e50a244-be01-484e-a284-ac049afe999f@gmx.de>
Date: Wed, 3 Sep 2025 14:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] Image size checks: Simplify SPL_SIZE_LIMIT logic
To: Philip Oberfichtner <pro@denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>,
 u-boot@lists.denx.de
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-6-pro@denx.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250903105653.335417-6-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2iXXcYFy0vV3V7tzKTmDeI+dMFYqhiyO1TP+YFCcSulZDzdGNwt
 XUPDsGN5j2OurolOgII4d9hl1ME294W548dH/FFCViFJXozdCwrejpz/7F2on4vYViLATCn
 /dw4Ns3aixOJR9Imb5gY8qMkJqhcRZP6V0I2/Sf3Lzzqi8InBMqbjlZKyYNdBqAnSf0wlQj
 AzLpkkG/jo6MxDO4YlsoA==
UI-OutboundReport: notjunk:1;M01:P0:azorWSk2GiU=;EvBnNm2y6mTtq0jiU8YoXdfgtGj
 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
 Cv2/C7DFwaxkkkLN8HUcEsnzU74xWgPg==
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

On 9/3/25 12:56, Philip Oberfichtner wrote:
> Simplify the depends-on logic for SPL_SIZE_LIMIT. No functional change.
>=20
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
>   Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Kconfig b/Kconfig
> index aa00669ba20..343299eed50 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -588,8 +588,8 @@ config HAS_SPL_SIZE_LIMIT
>   config SPL_SIZE_LIMIT
>   	hex "Maximum size of SPL image in bytes"
>   	depends on HAS_SPL_SIZE_LIMIT
> -	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
>   	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
> +	default 0x11000 if ARCH_MX6
>   	default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
>   	help
>   	  Maximum size of the SPL image. When defined, the build system check=
s

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
