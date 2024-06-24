Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC7BC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 15:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1910883BA;
	Mon, 24 Jun 2024 17:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="sVzie2X/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2B588387; Mon, 24 Jun 2024 17:50:58 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E32B882B8
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 17:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1719244256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4ntBgHFjm744efcDdjDVZYzqtfnUBSKiEBlz1vp0gM=;
 b=sVzie2X/50ELdOFQYkFsqXcHjxfdfEsQURLZ39Q7G9Vsp/mP1XnahfA4RnEGipaydF6rZ6
 6U/S3O29If9+sQXZRGbmddTrjLVgyoTMYmAGH4Qmkw9zfA2IvMOKE/vkqNN7YsCECugc+a
 DNd2DJdd/5F2gGkZUitbov6h90qjZS6ulDSY/fqxugWKXhE8Ke6nSepgartCRL26gCAeZ0
 nb+0cW+FkBsd5CbGxhK2kxTSh/jXEA8Jf+BPjAxGqWlnc/aUfJASpINZ6TFxSlih/g0D6+
 EGbCh0sPxVqXKI2UBRkoYxdib/EPEUIDPnSUWpXW/NL+EgrO62XrhrluIygOww==
Date: Mon, 24 Jun 2024 17:50:54 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 05/14] sunxi: Mark scp as optional
In-Reply-To: <20240623203033.1566505-6-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
 <20240623203033.1566505-6-sjg@chromium.org>
Message-ID: <71fa5c0e46328b6d7b35222df4dee860@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Simon,

On 2024-06-23 22:30, Simon Glass wrote:
> This binary does not prevent the system from booting. Mark it optional
> so that U-Boot can be built without it.

It should read "Lack of this binary..." instead, to properly describe
the background of this patch.

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/dts/sunxi-u-boot.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/dts/sunxi-u-boot.dtsi 
> b/arch/arm/dts/sunxi-u-boot.dtsi
> index 0909a67883e..e1a9a7f5d4c 100644
> --- a/arch/arm/dts/sunxi-u-boot.dtsi
> +++ b/arch/arm/dts/sunxi-u-boot.dtsi
> @@ -90,6 +90,7 @@
>  					scp {
>  						filename = "scp.bin";
>  						missing-msg = "scp-sunxi";
> +						optional;
>  					};
>  				};
>  #endif
