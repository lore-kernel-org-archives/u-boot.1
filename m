Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4653606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YUW3NNFS;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=C6uBGG8J
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D98F140B11;
	Fri, 27 Nov 2026 16:49:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oo4iNyo5izSU; Fri, 27 Nov 2026 16:49:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A149409D0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795798158;
	b=BR3PWdCuHQ/fCLG7EpOiVDEnaIgwjGLeUsrwvtUt8WeYqlnmCr6kDHLYGKvyIZuVKFre
	 IrFVZroPZfD2E4Afk08efeZPqn62SxZqesIoeIqmUPr+tbnjfbUWMR9De9nLFMBDraGql
	 04F9jpSjm/Kp3bmoWOmIk9MwW4yvBrMwC1R5Q57KkNKrDskt2UFozf3ZXOLfALKjRAP8P
	 SWVVVhqrIHg+3oKVtrqQFgYtjYQZPBvfprazdjswlK4XvbNG3qg/1RvLkOi+x0z4Jg+81
	 AgNAUOqVQdfbRxLjjzKKwdd8koWz+HMpwNZNE108yO3URlgEfCg767FjOP9pTBEuPmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795798158;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GOWeF3JOxW/Zqul/KUsm5EeYHCHatbQBEeeilDIbVRs=;
	b=AkK2eo2R0W8pI8YiUmhQueJxdygv/WQ6Lj3FtH4BCPpfbA3Wlqi64xOKzPHiYlg8+U/v
	 6F8vmvIkZiMA0IayLR7wetYT7yXMKrvjdPnYMhfOWILAPAV2QuDlkgziKIUniBC+2Nzmq
	 6yYeO/p8JV6dmY0u9zIy0gnLLPCcviSC8V4DDCu0O+gOMg5yJXDBFElO/F9NmGFeenLKO
	 OyRYYiSNaOGwjJ0tYvT6OSJRQ7bimJCOrkd1SfKkAlV1PHQBu3lmpvrP4lYKAKLJG8JmV
	 hfb2dMLHIS91qeDz03aU5675z7OKeSVsfIwnmUG3aheUkkKKLEvZl8z8s+dxZfbgO5Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795798158;
	bh=GOWeF3JOxW/Zqul/KUsm5EeYHCHatbQBEeeilDIbVRs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YUW3NNFSFOZ7O6uVIqNrXXx18gU6TFrLnzIzQyRIJkAL9ThvBdfuqshYQeC3Vo5gL
	 isQlFiiCGbM2aVVFg6lelT+1J3yGxkcLSXG3p59hpxVPT+VVGA7mTZDp4i8aVhv+Oi
	 Fdy5YJWGlrVBUzoBtY28/8z5re8G1jTORsp1T9uTiY8dxxZe9b/fe7ANXRnnygYgf+
	 PxkznhN+bpapKCXRnzqKsRonDd1Fpk2JECtGvTJFeXLEemJsjvQ8+YF+aHsEnDGyya
	 2dqKQSyYg7egUJejMnDtyCuUd/lS7xwsDSn24dx/Lge4IKRF3rTJwdL9CigTfTElks
	 Aj1EQAmrjnVdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A149409D0;
	Fri, 27 Nov 2026 16:49:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7060426D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 566998115E
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:49:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 19DuWay0VQKe for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 16:49:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 558588114E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=C6uBGG8J
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 558588114E
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:49:15 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-70059e4dab6so4380338eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795798154; x=1796402954;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GOWeF3JOxW/Zqul/KUsm5EeYHCHatbQBEeeilDIbVRs=;
 b=C6uBGG8J5rdhYWYa7LUvTuwzpCAVXJiLjAQTAm38czlgn5VzJDQtGgZarRI3ExmZqf
 KsFFOs4l6CSMnLfqp7ZBP5EdrCkyMSUotvY79jJhAfIEz6gkeoJbA1b6R8IlzyO3jM7G
 kp78XT3ImV254zbvUob7r+BmlDMLdDlJuTWwwODpbnFWUGHCv/28P5RhZKvLJv5yT5aX
 /BZ0+3fLVZW14B8HfPCJ2lrgizgVpi8jXVvihMsSSFc4FoW9I+l0yDEfct0ONelitKJR
 qkmCUVWivtAfP4ZtpP+B5nAut0HUouC1cP2hYXySKdE6KRwQMoHywjzX8nDQgbb138CZ
 fS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795798154; x=1796402954;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GOWeF3JOxW/Zqul/KUsm5EeYHCHatbQBEeeilDIbVRs=;
 b=I7KD2TOCRZ0BhFIsowq1GpWMsygkDSzcbtggrFVwra3JcdHupLfDdVwVbbwY8yFtL/
 uU0cq6424mVBQJEMRik+oTT/GJZv74RDuEn+iQssDIl4hAWIXV9qm5YE67kKZU13hw6g
 zMGsSUAgcKbH80iWjsEpDSLw0WlfNQ/LVWNy9D2caTs2GkNfyPk7CwkJv72Y4MlkJCTO
 IEm+zhSHVPmiV5Tt/X9r1jZ4jpEuEOl01wHbveWEPl5yl4MpcdCeqZZCOLuqjcWdnMga
 NRM38WHZEgRyH4s5rNk65+jrcMtwE7kxfMZhXXtu/GOsmnKOcewVxVWXRIcCDVszbg0c
 Puqg==
X-Forwarded-Encrypted: i=1;
 AL+hErF+bNFYXU0PFG34H1VN2qRGzbHoBiYM/+zrWTzElQGiew9t/gqrr+9ZqpBTDZ2LavpNLbiT/iU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/xBIKpy2SDAhUCH3/F/WzCos1Nbau225lNi5XHQPcoPCgF8Qd1
 K5Y4L78u9TyTS68TS/8mlzQupHGmilCHDQpflVaUKEOM7FxC3xREwr50Ac9moWu3lQk=
X-Gm-Gg: AZFdTZfftc2Qqu3sLK9Lt7vK81P2gT0OkfB2rJ9G5EpUeR1aN2ze1p8OB+Cq/Rexx/l
 5bZw/KbXHEM5KXoay97gervNuzBdDVIynae8JzH5rdNF6t/12xiuWShVB6y6vDLYbSxscaz6Okj
 Zood6QS6Q5plr2NobGCYJYECFhg4y7HNc76U51db6tdzPfN9wOMX8BvqGTJO9LCdDc5d7PIYdIY
 Hol3BFKscJhDljsQM3bRiEaP1ipA+qG6fb2QBS/LZwKjJjq37Z/kZfsmb5xY/sxgfue5gLXkAEX
 sqkzvsW2+ejUO8mwgYZwnUF3BeZNBefciGnLciAREZAg7BZxMF57OD8T5MO25VW9ViTdGTu1g3k
 c/cIqOMq95tFGWNFVZ4LlJnS5+jP7SGw1Om+PeaV7ztIw/pPWAZppjsrnZ76jf6XL9Uf+PcHdbS
 hhKdAM+EJci0s8AybfG6EccCvrDeKkT243/VE/bnJjHxj40C/ucS7Cw4PygGpa5rVY6D3Ul67bK
 hSdqlc35E6epmeulhzTnyVI+ePQgB/nSsDTIJr4Nv4re6HrcAX0YT7lItNEBr4cwEo2G/lqCNmi
 bwS0CDM4TndeDny388ReQRVUrJkSBBtsI5AVKxqKF5yW1qmTKcdqX9P+7jBrPpFGZQ7XrS+mZaD
 doy/QoOBPz/+1gyioBVwbX2wu
X-Received: by 2002:a05:6820:6fdc:b0:705:e5c5:acd8 with SMTP id
 006d021491bc7-71b394d84d9mr18028257eaf.16.1795798154631; 
 Fri, 27 Nov 2026 08:49:14 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:3f9c:a2ed:829d:5419?
 ([2600:8803:e7e4:500:3f9c:a2ed:829d:5419])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86392f8d28dsm1515973a34.12.2026.11.27.08.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 08:49:13 -0800 (PST)
Message-ID: <3e31dcd4-0639-4292-b854-6c1fe3063894@baylibre.com>
Date: Fri, 27 Nov 2026 10:49:12 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: service the watchdog while waiting for the
 flash
To: Steffen Dirkwinkel <lists@steffen.cc>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Alexander Koch <akoch@initse.com>, Marek Vasut <marex@nabladev.com>,
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Yuho Choi <oss.patchbox@gmail.com>, Carlo Caione <ccaione@baylibre.com>
References: <20261123-std-upstream-spi-nor-wdt-v1-1-97a7cf1c51d4@beckhoff.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261123-std-upstream-spi-nor-wdt-v1-1-97a7cf1c51d4@beckhoff.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 6:07 AM, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> spi_nor_wait_till_ready_with_timeout() polls the status register until
> the flash is ready, without calling schedule(). A chip erase is a single
> flash operation, which can take longer than the watchdog timeout. The
> board then resets in the middle of the erase.
> 
> The MediaTek watchdog cannot be set to more than 16 s. Erasing a fully
> programmed 8 MiB GD25LQ64C on an MT8370 board with "sf erase 0 0x800000":
> 
>   before    board resets after 15.7 s
>   after     erase done after 20.9 s
> 
> Call schedule() in the loop, as the erase and write loops already do.
> 
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index 7bc889c9629e..68c292ecb131 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -898,6 +898,7 @@ static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
>  	timebase = get_timer(0);
>  
>  	while (get_timer(timebase) < timeout) {
> +		schedule();
>  		ret = spi_nor_ready(nor);
>  		if (ret < 0)
>  			return ret;
> 
> ---
> base-commit: 2f83ef8a7dd4a409b534ea68cd13b17b686cc53c
> change-id: 20261117-std-upstream-spi-nor-wdt-f3e405372cbd
> 
> Best regards,
> --  
> Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

I had made the same patch already and not sent it yet. :-)

So...

Reviewed-by: David Lechner <dlechner@baylibre.com>
Tested-by: David Lechner <dlechner@baylibre.com>


And FWIW, I had also added:

#include <u-boot/schedule.h>

To follow "include what you use" principals.

And:

Fixes: 7aeedac01534 ("mtd: spi: Port SPI NOR framework from Linux")

Since there are a couple schedule() calls already, but this one was missed.

