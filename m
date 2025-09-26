Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AC1CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 06:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA8D8206E;
	Fri, 26 Sep 2025 08:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QYRJnEcJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A338206E; Fri, 26 Sep 2025 08:41:38 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E47C78144A
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cY1Fp0LyMz9sWh;
 Fri, 26 Sep 2025 08:41:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758868894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iit9GxQSWJPxbifmj0k8fxA0sgy+g8GgtOT+8W1efuc=;
 b=QYRJnEcJGIKbqqpKkT8HM6rbxwR6+LJT0kJzUzHhKajsAcpo0Gw/KniHM0+cyzLxzc7oFT
 idWxcd1PaP0LfmOi/soHz5PgcNOY18SGz7wQyHIKNbkvfOdyEvIwDoefJ3I5hhmVrJdY9g
 b2uAFkaE3v1POaj85f6E3A5pCoo4qI/zXoGsRcOjUvlSoIt8442LjZwmSuDWHuOToutR7k
 pnLRoE7LNv8ap8/9BF6JZs07RNcJPEKiVLcN77Se/sZwR36FJsYXobNT27MTgTaNBOF8zT
 x2aAmaV79WoxG+qmpg6uEfW4fbV0QfD2nxNs0yZ88MvSZOhBIzf/fPjfEeXOtA==
Message-ID: <4d5bc549-a033-4baa-80a8-21ae2496007d@mailbox.org>
Date: Fri, 26 Sep 2025 08:41:32 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] phy: marvell: Tighten MVEBU_COMPHY_SUPPORT dependencies
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250925205614.3562540-1-trini@konsulko.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20250925205614.3562540-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9hdaidgixdmb75k6yguzznf4hu3je8s3
X-MBO-RS-ID: 08099bd871c756b635a
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

On 9/25/25 22:56, Tom Rini wrote:
> This driver cannot link without access to functions that are defined in
> files that are only build on some platforms.  Express those requirements
> in Kconfig as well.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Stefan Roese <stefan.roese@mailbox.org>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/phy/marvell/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
> index b5f69c0a96d3..c66197de1433 100644
> --- a/drivers/phy/marvell/Kconfig
> +++ b/drivers/phy/marvell/Kconfig
> @@ -1,5 +1,6 @@
>   config MVEBU_COMPHY_SUPPORT
>   	bool "ComPhy SerDes driver"
> +	depends on ARMADA_3700 || ARMADA_8K
>   	help
>   	  Choose this option to add support
>   	  for Comphy driver.

