Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFD3FD7076
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 10:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42811841E2;
	Tue, 17 Mar 2026 11:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="cXx6sTa0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CEDE841F2; Tue, 17 Mar 2026 11:40:14 +0100 (CET)
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C545B841DD
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 11:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pfJKKLESPRWDDU+mKsYBXpdxIm8xuVJCEmypMFoP+dQ=; b=cXx6sTa0mGHCElzIOgfcem9c7G
 YMZHEgODMOMb8hEx8ZSYf4vvonLLND6Q/qk/j/oU17BXInrQiO+MXBsh9ivBWNo104xhQWOYi47WS
 XEgjIynoJSgOQsxeWtdGcbGlhKp9QwCanPBx6fvYxEsjhqWy4ft6/PDwF4SF5+z5i/0CdCqMnmIWD
 c7/4QhULES4xYbTPf99rbt/lml0B84gP9VN8GxE1rTqEBJSpBZAlHnLxRInL3GunJ2VE4y0njdvRW
 SBjLxWJf5waAl2hj79wajicaIx8UXS14rXXbEY3x/nDTlCOjikK7AwN2VakwyT5jBPap90udtiiUg
 GUcvg8Jg==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:48878
 helo=[192.168.69.116])
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.1) (envelope-from <primoz.fiser@norik.com>)
 id 1w2RqP-0000000DQgy-3imM; Tue, 17 Mar 2026 11:40:11 +0100
Message-ID: <344380a7-8d01-4c99-9f7d-bf8ab5a8c619@norik.com>
Date: Tue, 17 Mar 2026 11:40:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configs: imx93-phycore_defconfig: Enable
 CMD_USB_MASS_STORAGE
To: Wadim Egorov <w.egorov@phytec.de>, m.othacehe@gmail.com,
 c.stoidner@phytec.de, trini@konsulko.com
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20260317100703.1933040-1-w.egorov@phytec.de>
 <20260317100703.1933040-2-w.egorov@phytec.de>
Content-Language: en-US
From: Primoz Fiser <primoz.fiser@norik.com>
Autocrypt: addr=primoz.fiser@norik.com; keydata=
 xjMEZrROOxYJKwYBBAHaRw8BAQdAADVOb5tiLVTUAC9nu/FUl4gj/+4fDLqbc3mk0Vz8riTN
 JVByaW1veiBGaXNlciA8cHJpbW96LmZpc2VyQG5vcmlrLmNvbT7CiQQTFggAMRYhBK2YFSAH
 ExsBZLCwJGoLbQEHbnBPBQJmtE47AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQagttAQducE+T
 gAD+K4fKlIuvH75fAFwGYG/HT3F9mN64majvqJqvp3gTB9YBAL12gu+cm11m9JMyOyN0l6Os
 jStsQFghPkzBSDWSDN0NzjgEZrROPBIKKwYBBAGXVQEFAQEHQP2xtEOhbgA+rfzvvcFkV1zK
 6ym3/c/OUQObCp50BocdAwEIB8J4BBgWCAAgFiEErZgVIAcTGwFksLAkagttAQducE8FAma0
 TjwCGwwACgkQagttAQducE8ucAD9F1sXtQD4iA7Qu+SwNUAp/9x7Cqr37CSb2p6hbRmPJP8B
 AMYR91JYlFmOJ+ScPhQ8/MgFO+V6pa7K2ebk5xYqsCgA
Organization: Norik systems d.o.o.
In-Reply-To: <20260317100703.1933040-2-w.egorov@phytec.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Reviewed-by: Primoz Fiser <primoz.fiser@norik.com>

On 3/17/26 11:07, Wadim Egorov wrote:
> This allows us to expose MMC devices to the host for easy
> flashing via USB.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  configs/imx93-phycore_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
> index ac719372b41..3fb6e7b5f1d 100644
> --- a/configs/imx93-phycore_defconfig
> +++ b/configs/imx93-phycore_defconfig
> @@ -76,6 +76,7 @@ CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_POWEROFF=y
>  CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>  CONFIG_CMD_SNTP=y
>  CONFIG_CMD_CACHE=y
>  CONFIG_CMD_EFIDEBUG=y


