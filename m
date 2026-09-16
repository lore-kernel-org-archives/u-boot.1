Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33635C88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 05:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F390180CA6;
	Wed, 16 Sep 2026 05:03:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HjcdCKkbATR2; Wed, 16 Sep 2026 05:03:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 327F380D96
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789535035;
	b=jiKMOSJ6aPb2XSSXPloV1geN0tf7nVrnHxXRwT674OMPUBwRl6hSD2LDA5IsHzdsA5Hm
	 1vcWlFL7qoGxNfH8kaK6gFr8LOCWd/xlPrn0Gz/TCV79GWH0bUAm/vIwF7eFq6fIYCTzc
	 9IxciEzuJekCKjUvq70j1sDcPHMeaLzElJvJMoKYkA1UfHhluoPM7DhzReevfbAIBO8rr
	 wTtMpVbMotAuNYRK124c4Na9z76/y6YP6y9qOxy92MZ7kVhBtXphUBCyd6C7k+mpga3hC
	 zPzIZkL+YqPNY4h5hePeXXIZ8Na8XK8bLmSxS9tdQeHGFQ/69hU98ozBInb8oZaeGTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789535035;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+P3Iqc03uldw7o7PmOM/Qe6PcODh8WyKve8uPH6BiAE=;
	b=Qc44NVERb2HRi8Tb4PYJUzua3K749/qqbUc1kahDypnW/KEHNCc3Fcz9x8XrDJ+aqGrw
	 zBPp9b9NFkkxxbpLFgizqLWPOWBozcB61g+qWxDSiz+G0FWdA8kz05BrHO85pFPJ5M1Zh
	 CvtCst/3l4/BXIcdG6WcA5H8iOBr854ut+VjzBtSpXhvCKcnx8Ag/pxY2ZgZF3TgJVg1H
	 wVyU24tk+qoOjYDFRFFukS9YMr454TSyjO8aCF0R2lAtgHv1HsT/qRdqm7mdkkiBwTANH
	 6/EPEVpRGWBPI3n8IE80D9Le9NiLLxDGT2aOADodMabDdqLmeytY1frHVbsMbBZi5HA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789535035;
	bh=+P3Iqc03uldw7o7PmOM/Qe6PcODh8WyKve8uPH6BiAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fiDz55R3NHJ47ewrhWPhYPZmrqPCYBNWHM3++tb2BIAc4sk2byJV0/j3moJ10hOVy
	 HScjc+dVd/vnkjJ3t6lFg0R0xwwTnyYdoGC2P2KUNXha9oZVNlL0DDOL+gvECfz/NH
	 JGf3NAmoJDahX9vEa2UQr9wkgc6sJEPkO/t1Br1i0CTJjGfxOmeu1RMiwKhBQW6Ikl
	 CleHdtChYRUZq8KeETXEOXBtadXFcF00sHaKgXBJdLB15UBxOukvos93j6jNOr0vpU
	 psdvO8+bt9lLCaevs+CxdjeymY/nVbkYV5Zi6wTA4YEI18CGH355XvLPguLVoNLtFH
	 eNZjcVcMY78Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 327F380D96;
	Wed, 16 Sep 2026 05:03:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C40E259
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02C8A40688
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:03:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kh84IeM7xa8R for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 05:03:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E558B40680
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789535033;
 b=oaO+PoxAUC4lSRA9BZAcy2aDMnlvvLQ54QwTgLlAeKIbMYM6NlbOJRh9a4bZNVYW0fcB
 JUfxbTJ2XuTs25M6ynHH4FJP6DX4IrAfsV6jo2XEGuMLhdtL6xsHLXHEopAbQg2gBA8jx
 AETbZNEoIOj7B9Y991/kUXPRLFHB3gYcFnypLCdeirr3H4b/1BfgCY+uBbb9Jr9mivmFo
 VrNYxzLAawdYvroqCEwv0aEFqwQKgdafWcIDzg8LIcHbo3fTEQqNSaW/h28qb+5aJJ0NU
 LytBI+FXitw9ggSnyhBmBofIVi6ssRyhNHeYbqSFjjQ+p3QngXCZOMfNCrQ2TeZI0+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789535033;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=+P3Iqc03uldw7o7PmOM/Qe6PcODh8WyKve8uPH6BiAE=;
 b=CGElud6HQKSViaBuvJwitv5Oh+VP3S+4ALwkR/CpcAv3aT1LpnNvQzMLxlT1pocVQSTq
 Lkugq8PBaRXNHsUCFeH7iZbd7I88vNmQpPCuI8qcLywNjzREDncSOdJttsNmna2d/IlTu
 V0MP4R/N244pWvOAqvBdMjxffJBZww79EDhUHxf2S9eTsoS9/buTTFk0qhAi+0afF1ilb
 wepY3Z97vnNwwlpZJvfKfzLGYtKF0uqlhsPmlPUreT8K3PommzAeDFINmI9Y5spxvJeIY
 UzCpdEfKXqIGAfSMqpfitJ6weH6hXX4L5k657hcEm66MtDhSG5eaY9UopWy8YeVnL8g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=RjefE60M; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=RjefE60M
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E558B40680
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:03:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F3377103E03; Wed, 16 Sep 2026 07:03:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1789535029;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=+P3Iqc03uldw7o7PmOM/Qe6PcODh8WyKve8uPH6BiAE=;
 b=RjefE60MLArP0Bzt79hgo074zp18pvLcKxvkEnN3OayULv/HbZG6I9YIg2aghVSweTvY8h
 ySwJ4Gl/nlnEEu8xC/kGD5Pp5Gl7jGM9HI1DX5mgvDmahpPXuJ26b+8plC2NdzrTLNGkia
 HcJJwPJB7w5ZgGXC8CqoeSXYxk6yrY4wwgJOsg+TMer+RedM9Z3myjc/JgK2Nrig9LvRkF
 Lb+Cw6V8a6Yrw/jg4UgT7ewPKtI839qTdlaPTOrLNHk/Ju1fNzvz5hlRIgyuGOIrOj0Nj6
 JQPnS1X/Yp25y3B3YoYjP2OSk0m+hpn5ZloG7zniAc+N/zPJ90S0HVCLsix00w==
Message-ID: <4a940336-900f-64f4-e199-6a71bd4cd25b@nabladev.com>
Date: Wed, 16 Sep 2026 07:03:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mtd: spinand: consume an mtd index only on successful
 probe
Content-Language: en-US
To: Tim Kuo <Tim.Kuo@mediatek.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 u-boot@lists.u-boot-project.org
Cc: Steven Liu <Steven.Liu@mediatek.com>,
 Sky Huang <Skylake.Huang@mediatek.com>
References: <20260914033237.51994-1-Tim.Kuo@mediatek.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260914033237.51994-1-Tim.Kuo@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello Tim,

dropped u-boot@lists.denx.de and added u-boot@lists.u-boot-project.org

Please ust the new list for further patches, thanks!

On 14.09.26 05:32, Tim Kuo wrote:
> From: Tim Kuo <Tim.kuo@mediatek.com>
> 
> spi_nand_idx numbers the "spi-nandN" MTD names and was incremented inside
> the sprintf() before chip had been initialized and registered.
> If spinand_init() or add_mtd_device() subsequently fails, the index is
> consumed anyway and the numbering gets a hole: on a board where the first
> SPI NAND fails to probe, the second one comes up as "spi-nand1" and no
> "spi-nand0" exists at all.
> 
> This patch will pass the current value to sprintf() and increment only
> after add_mtd_device() has succeeded, so spi_nand_idx counts the SPI
> NAND devices actually registered and the names stay contiguous starting
> at spi-nand0.
> 
> Signed-off-by: Tim Kuo <Tim.kuo@mediatek.com>
> ---
>   drivers/mtd/nand/spi/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 14af4264612..1fa669f3def 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1691,7 +1691,7 @@ static int spinand_probe(struct udevice *dev)
>   	mtd->name = malloc(20);
>   	if (!mtd->name)
>   		return -ENOMEM;
> -	sprintf(mtd->name, "spi-nand%d", spi_nand_idx++);
> +	sprintf(mtd->name, "spi-nand%d", spi_nand_idx);
>   	spinand->slave = slave;
>   	spinand_set_ofnode(spinand, dev_ofnode(dev));
>   #endif
> @@ -1709,6 +1709,7 @@ static int spinand_probe(struct udevice *dev)
>   		goto err_spinand_cleanup;
>   
>   	plat->mtd = mtd;
> +	spi_nand_idx++;
>   
>   	return 0;
>   
> 

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
