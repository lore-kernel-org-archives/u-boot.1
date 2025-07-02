Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBCDC7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB26081FEE;
	Wed,  2 Jul 2025 09:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1751441150;
	bh=Wb356A/aJdHYyHxg2r2Isxa3Ad4YzX6UsnMaQ0S5P9M=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pOwvPJBMHmTRrnARLcBpopAEQSzbIgQvYdr9yv25E+sL+17mvALu7sC+zatDuGvPE
	 DMx9PrKjaq76+GDQobGHRcLzCjNDvR433vmmSzKljXnZ6sCe1MubkFw5MUVNNYpn3d
	 LoZfeCO5bonkxyYcCJGFiPnd9mgGmKd6G8Xu9sPwrH3qNPRlIMTlzr6Cqh93xKK/Ps
	 RteLssajLiNv8vXJud1vag5tUu7wK1nOojcxyAkjPSl6LCdk3xCjgfxhd4EHe1W+NY
	 WIIqdd9zzxGWkNyTWtrCjPF9HnfHmt0QnJkng854hG3HPtPn/DvG4lyXcAqByDzMkp
	 /CZQrNbsbnsbw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8DC082103; Wed,  2 Jul 2025 09:25:47 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2B8981E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4bXBJR4Ynsz9swv;
 Wed,  2 Jul 2025 09:25:43 +0200 (CEST)
Message-ID: <ad005660-27f4-4246-b521-39a90ae98190@denx.de>
Date: Wed, 2 Jul 2025 09:25:42 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] spi: mvebu: Correct dependencies on MVEBU_A3700_SPI
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250702010405.18791-1-trini@konsulko.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250702010405.18791-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bXBJR4Ynsz9swv
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

On 02.07.25 03:04, Tom Rini wrote:
> A dependency exposed by "make allyesconfig" is that the logic around
> this symbol was not quite correct. It needs to depend on ARCH_MVEBU and
> ARM64 and then select CLK_MVEBU.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> Cc: Stefan Roese <sr@denx.de>
> ---
>   drivers/spi/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index a3513f0a3ef8..1ae36b5a348b 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -351,6 +351,8 @@ config MTK_SPIM
>   
>   config MVEBU_A3700_SPI
>   	bool "Marvell Armada 3700 SPI driver"
> +	depends on ARCH_MVEBU && ARM64
> +	select CLK_MVEBU
>   	select CLK_ARMADA_3720
>   	help
>   	  Enable the Marvell Armada 3700 SPI driver. This driver can be

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

