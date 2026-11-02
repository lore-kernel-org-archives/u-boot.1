Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56F4606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bb28IUwQ;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=dz+2ICiE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A43CA4057D;
	Mon,  2 Nov 2026 04:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aAoYSe2vmeLG; Mon,  2 Nov 2026 04:35:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD74440581
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793594109;
	b=qk7jTwmm/+9tFiznh3CR8/ZEgt/HiNqe8mt7rUU3EUaUZfuSyGM6PUrnbofvr8rmYvOi
	 +rA1s3W7uGZRFubu20SR8Kt2F88QgA5dfeG60QmiGiI89fGU1txGETahEWTr2FzFuEhAi
	 wZ2mouS5aGNbj1vSgyR/q5AUIrblhylpPkvxFr3JU/Me2e43XvTm4S+BLQatgG+fZ/YC/
	 +Rc4T9wG2Pmu+0rEO90Wpd5Ec3rVWRz9sl9KLJsCmopzbsOVVYl/rloJlJEDgTrs2Btar
	 Iy2lFxCf+Qwb6+UQ0ZqdVZ2M0/p4RJTl56fsSpWfRXsJGiG9HWV6uzEVDWNinhwwAew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793594109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JfLTQQqHnak03R9EKvGPNZu20jf7AiAFhc0eQbGqNtU=;
	b=lpexMcTfu+9nSDqRN7OLtfB7ceBop2V8Q8jsI+cyU6tt1kNlvuhyxqqSorwByDyPQUjy
	 JC0BmEMsVIFFVhuz9OR3I4A+EHKLAMAhny0sjgPNb2a2ec5XZsli0pqxVVwCvb+dcmP9T
	 DNSD9GDjSjDLyffVd5XrE0ItAMVH8MDipm8THHEOeUTsM796BwCj56+P+oFO86zVzR6qu
	 NFbzBw6cqsd9pxUtz1AEydXdMyFHx40xFWeM77x0l5BgC0fpqA7o6cE/omncnrsWGxGC2
	 +N81pY+HLl97gfkthnEF2g66cP6EOhY1fv2lShqZstiDZtBQ0R5tdSIUqJG90llPc6A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793594109;
	bh=JfLTQQqHnak03R9EKvGPNZu20jf7AiAFhc0eQbGqNtU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bb28IUwQ+1xQvtBCqPhntoO7bsnnhPvjwk29hVQZpSKBF45QngYan2a/P3xpNSNeX
	 Xfk7Vh4jRjwR0wuxAKRcoLUKzasN7bUl8jyv9QNsrr2MLRbRxGtNvGChIy0AUXJKjP
	 X4ur+YQUgc7zWBVAt9/lqFh4mHsI8ovczpuhAK/VWuXH0x1EMmXrBcJ3gt4EzrJnmK
	 A+AcKdGMUSctHvAtgbjedWitZmNPj8bFbOEHzL5EHBpY5H9rPPhi1IRdD3ZvVTJ1Yg
	 pgOBMWkurPGQ57oIsSnFY0cD8QyjnYapD8zGjrZP/47HobNYROhjqvAt0/Q39cC8kK
	 7TomH8v/F62xQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD74440581;
	Mon,  2 Nov 2026 04:35:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CBEC5156
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 04:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD8EE4005F
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 04:35:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yZfFctr-GeZ6 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 04:35:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9B97C40042
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793594108;
 b=R0MyTdvYOWjYY7p7rTiUMU0CTMjyfu9ZnLfbtw9EX1w0C4lJrFqMNSFNlbg0GxC6wkVP
 vuZJRaVyhUpEYUmSIKb5rXbml001p7aTk2V/1GYymfQhWsTA1gDgOy5AmXkq71wKFTqDV
 EAra91jx3fDmSGOzY3Nfa7gCOfp79okgYtaTIGTyz9OP/r9eiWXYBKIQkJaNKgidjOPYC
 sRZxd5h2jcfprxei9Kb64p6oWQ9P/7RJtZdqRnohbkYEDaRs14JkByW9hUe+tE42eBO7x
 lHH2NsLv2cdqzf44JsFO23EXt0gitbo+qUEvSzuWW/YJ183t8qQy67f9elt5Vfwe0dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793594108;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=JfLTQQqHnak03R9EKvGPNZu20jf7AiAFhc0eQbGqNtU=;
 b=CUr8BZINMojQlP292VslLWNJWHzyvSrr46S7ZL2ohN0mKNTQGqj8ycHeM//WEymld7nV
 2jqcA4pAJ1xnYm9GKQH5vk0UHVzuTAOJqGr7F+pmB+bJlTHMh6Fbm1Ark8qPnOK1RRPi7
 XqJZIwsEssgo3h6w1HX3qu7knIkD9WCX6pGyyF9Gz21Nz6uzmvw+G/iwTKOLgpmxwgzur
 Ftp3Hd/YpZIvt9NhJLgjxxqKGTTU0FpHlPS9fJ3C9kPcCl+D3UiQtUc6gZkIlLLyHylyh
 NcyHQOW1gNmoprkogXfCn3URmydxruwyzLw63Mfgg6KXkuac3RRUU+4GXWyLXXXFuEA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=dz+2ICiE; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=dz+2ICiE
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9B97C40042
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 04:35:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0E8B010C2AC; Mon, 02 Nov 2026 05:34:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793594101;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=JfLTQQqHnak03R9EKvGPNZu20jf7AiAFhc0eQbGqNtU=;
 b=dz+2ICiEjjj29szNVEWwBASb/Z5BKacfCCTMV5msApM6HqXAIGv2KA95IlnnDd/qYgPOI1
 dUx9oVQ5QvMDZYO0z/Y/QaRcGrnuhHDkHgo++0/RHwiak9c+fuCqmhFojC2or7kwPsyZTc
 rzslentPz7ryF4hPjwPrZpHQTdmR7KgRMopxQrScAN5IWoqJPmu2gRNhBGYR38RYKjiFYE
 /mfzvCbGBI/Vc3Yf7NERCzglQkH4MzdwOnJ7s86F7k/L/VX+ZMR05Tk+DHKoCEhUhA7a76
 +KsIvsgX4sTVdFmk+Fa0kTcJtDeBgGrSY0eZSqRTuUuPDz+yAtRIIr1OXMV1cw==
Message-ID: <8aeda4e4-3852-41d2-e0f2-3d007234ca57@nabladev.com>
Date: Mon, 2 Nov 2026 05:34:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mtd: spi: spi-nor-ids: Add support for XMC XM25QU01D
Content-Language: en-US
To: Ssunk <ssunkkan@gmail.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: vigneshr@ti.com, takahiro.kuwano@infineon.com, Jacky_guo@xmcwh.com
References: <20261101131239.1566-1-ssunkkan@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20261101131239.1566-1-ssunkkan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Ssunk,

please use the new mailinglist:

U-Boot Mailing List <u-boot@lists.u-boot-project.org>

droped the old denx one from To.

On 01.11.26 14:12, Ssunk wrote:
> Add support for XMC XM25QU01D SPI NOR flash.
> 
> Datasheet: https://www.xmcwh.com/uploads/974/XM25QU01D_Ver1.0.pdf
> 
> Signed-off-by: Ssunk <ssunkkan@gmail.com>
> ---
>   drivers/mtd/spi/spi-nor-ids.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index b370e78262..b42d7af967 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -677,6 +677,7 @@ const struct flash_info spi_nor_ids[] = {
>   	{ INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>   	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>   	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ INFO("XM25QU01D", 0x204121, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>   #endif
>   #ifdef CONFIG_SPI_FLASH_XTX
>   	/* XTX Technology Limited */
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
