Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED4CCA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 05:21:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D94680BE6;
	Tue, 29 Sep 2026 05:21:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1UM9ctMb2Rvd; Tue, 29 Sep 2026 05:21:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F173480BEA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790659261;
	b=oltQbecVVq5gfnbgHobA04yAVS4z7Fl8RvivBDl1fklemGtVHJPh262lxfX9B6lNLjIE
	 vrRI1RYKf00Jw6ZbK2DjB7RKOblPSS1P2w+fCeVwmO7d1g1IV70jLksDJheIAbqAm/t5a
	 mgrsmD300Zbvw88uuSi6V3tyQH0HPRycLgZrqwnVMlnttcDV939WqQRCF4eYh6a46HPjK
	 WoUdnbiw/+UEFgRQWegj5+4Q115bpUiXGIV1cm4g+PLF6StDUbObi2gmvHu2UwfidO6pa
	 rb4ZXkMEkmtMIMPFsjbKEH+Q/4MGGP6GojuTsC+zPhDJd/memE0ogbiiw6ODpmO1/eA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790659261;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=glbb0oBvdhqtduWaRkvMNUoF8K7D0uqtoRPBKx7UBqE=;
	b=NCrNnheLB0hbWUjCRjeTn5t7NrDqoLRD64m6xERev3L4XKzfNfbHiILxGOifZpS3Xh+m
	 K4yliue/8qhu2QTzNMs3vsREpN4YZLO6mRadob/Nb9Thuuy0s88R7gsZGTAHa1NkYPIhG
	 kGBecYPE36YnCExPrYLA1Xs8u/8Tv7N0FEuPS15Zly1SvH9fdHWPA1S5nGslAZUVd8pEX
	 jCsenlKPa2dv7bFfdUcQgcjBP1scXZsc23tPn/oepcE9G4qrTAnho99uBvx/AFIy8OFKi
	 Zr76Rh2bDa9y77gNV675PsLiqRwfqr4GRvZ9wt0Zl14qVMcf5NyChqTkLwqQDDgHjSw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b="XJfUdqv/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790659261;
	bh=glbb0oBvdhqtduWaRkvMNUoF8K7D0uqtoRPBKx7UBqE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MinMx8IT+7IiV/frbeiMvFeQjLi661dgd2eBQRyk5g6JE4BKrZPRU0u6eJJiTmpGQ
	 0bsubEPSj5k/k8l+nj4czfMFq5WX+kMAcLe978RRt70jJyHvFLzVNZSnLH2/DbdSti
	 lh12NhPN1b86wrrpabbpJArpAJFIRajVhx5nFwASLtXZlCa41LGehn0i4BmZ1NgTiB
	 0nt5Sdb5rQ+2h+zty1HrZDu0ToWgZXVdWPaISSCMYOrSEJ/5o40uLBhLR7pCP8nUvZ
	 hQucgArMfT0KwoE0ZgAxX7XEgHIVrLLBMkXNkn60l574Yb8yWNRSIG0RPQ7+Rk4y7u
	 LSsp4y6tLh7cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F173480BEA;
	Tue, 29 Sep 2026 05:21:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 800BC3D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65CC780BEA
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:20:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id glzfEiMgaxUz for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 05:20:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 86F5380BE6
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790659258;
 b=c+dCud2m5Bc9xrk42tGgem1jJAn13Ii401Uhxxjebs7g4VE5LzTVVQ1BONWNUiOWYc39
 9BRM63bJRXkEgCHb/Q20rL2EDBsz5KS6H+FbIOABIFj9Q765LLb5Oheirwn/ZelKiqbV7
 DS/zoqtxEmkJT4OMr1dlAIQTOobmLmosU9h3g1T1fmmqej2uIZNA3nKx4uHSBXPKme6kd
 LfKb+FtxX2Z1fwkHmdX0oi7eIGtAZ0hFR9mIe3wTdZzdlrnj8GX2RyqiZULrD38UE7UUW
 x/9cDmfOl8Poe3Ho2PTPeehgGoeA+d8MIFgtOYzfW71SRSrIyiuSJ1j7MRzHxFhnCww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790659258;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=glbb0oBvdhqtduWaRkvMNUoF8K7D0uqtoRPBKx7UBqE=;
 b=nzi3DUhqar7vJfJgnFzdhI36gIwX82ph/rSbtd4h2bh0ZgbaQ1TIaZQ+BRVgYl1pVhKM
 6P7lKaPo2N6TbSFfV7Oy8EV4FfAwG/m9nq6eIlYKsupIAHMWA0toXOWOlF3HtBlnXwir+
 ldbmNl9oTvwUhq40BMOmfmtozUTePCKwPEOjOLcNgn7FzuEPBTa2hifcAcwaiIc/3Y2kS
 oQeEmKofXPmXRWiQLNJ1aOHrvCChmt3ML/748XN9AEcSnreNmj1PFdCU+dgBCTXWkbQWD
 MSzm33wn3uyMFMqvptppnZkTnc1j9SVkp+F8dvSr5eUAC3ge8dVU4f3m0FSu4TqLa+Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b="XJfUdqv/"; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=XJfUdqv/
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86F5380BE6
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:20:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0DA66105038; Tue, 29 Sep 2026 07:20:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790659252;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=glbb0oBvdhqtduWaRkvMNUoF8K7D0uqtoRPBKx7UBqE=;
 b=XJfUdqv/h+ee3+g8MBjxLhSKcwGnbZsLrfpMJKR7rJU3UnhJaRN0KJbIjGemKjfHkgsZw2
 BeZKbxjfx1fiM4J0kuRdPsw8HyCTRyIFwjAUjA/VvfGQwLUqmTnfvKdlp6O1L6fQXBQD3w
 8/qog8QlbCg8JKUc0q4+7bmavWUDjI+lJJ9xPPrHzjyOGp+XJoHkDo9QeOEL53f0HYbA5S
 emq6lGhu6Rq49ib+AQ98Mzc79o9J59LIM/Q1wdrESmgAXs2Bv5tJC0AHJzbrV/QsDCDz3a
 BcO68/pdv1NqBXOSxsUrGegx4JdNzjc9G+LbgeZ57I7boWG67GFdGiGvGTXCJw==
Message-ID: <6f4c3dc3-9a75-d1e5-5a7b-63be7e2967fc@nabladev.com>
Date: Tue, 29 Sep 2026 07:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] spi: fsl_espi: check user's LSB_FIRST
Content-Language: en-US
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: mwalle@kernel.org, peng.fan@nxp.com, trini@konsulko.com
References: <20260928135451.3497577-1-tomas.alvarez-vanoli@hitachienergy.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260928135451.3497577-1-tomas.alvarez-vanoli@hitachienergy.com>
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

Hello Tomas,

please use the new U-Boot mailinglist:

u-boot@lists.u-boot-project.org

The denx one is obsolete.

Thanks!

On 28.09.26 15:54, Tomas Alvarez Vanoli wrote:
> This flag was ignored and always set to msb first.
> Ran into this when trying to download an altera rbf from a T1040.
> 
> Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
> ---
>   drivers/spi/fsl_espi.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/fsl_espi.c b/drivers/spi/fsl_espi.c
> index c5bc603b5c0..80ed734e556 100644
> --- a/drivers/spi/fsl_espi.c
> +++ b/drivers/spi/fsl_espi.c
> @@ -325,9 +325,10 @@ void espi_claim_bus(struct fsl_spi_slave *fsl, unsigned int cs)
>   		out_be32(&espi->csmode[cs], in_be32(&espi->csmode[cs])
>   			| ESPI_CSMODE_CI_INACTIVEHIGH);
>   
> -	/* Character bit order: msb first */
> -	out_be32(&espi->csmode[cs], in_be32(&espi->csmode[cs])
> -		| ESPI_CSMODE_REV_MSB_FIRST);
> +	/* Character bit order: msb first, unless the caller asked for lsb first */
> +	if (!(mode & SPI_LSB_FIRST))
> +		out_be32(&espi->csmode[cs], in_be32(&espi->csmode[cs])
> +			| ESPI_CSMODE_REV_MSB_FIRST);
>   
>   	/* Character length in bits, between 0x3~0xf, i.e. 4bits~16bits */
>   	out_be32(&espi->csmode[cs], in_be32(&espi->csmode[cs])
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
