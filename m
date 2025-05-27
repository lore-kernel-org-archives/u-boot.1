Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F3FC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 03:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 240BA82E40;
	Tue, 27 May 2025 05:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1748317105;
	bh=LP1/S5oH7VH84t5KD6CksjdVSmdjfSZJqXMz7zeT/mk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=bdKJdXqtZepLQpB1eLCM6pi1dQauQAuNLgfwVDUY5b1PGD3L1bT7gpCfscsyq2FCu
	 bz988p1xByTeNvTlp/MaQfIr7wFZVHlUjR7jWp/ISzW6bsbMSPjJh8nsFK/ISIayjk
	 bsGnEInwV5MTBHY2NTqg4d/kdS00TzFXRWJpplH5zg6mG+FTO+wSnz7vuyK2TL6Rrf
	 GJ+WLg4wOrCGMQrv0shMv9/m2Of7F41MDWOUc/JiqSUMiMzqI70mH3WFDUTBNYN8YI
	 f4auIuhFybRe9849qoI8oCtQmlscxZNZb87pD/7iv0omugMXTU3au8BGP/f6DJleN4
	 oJX/PPlAgfu+Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A74D682EBE; Tue, 27 May 2025 05:38:24 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B681582E25
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 05:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="gCzaHWfh"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DD2FD1039728C; 
 Tue, 27 May 2025 05:38:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1748317101;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=LP1/S5oH7VH84t5KD6CksjdVSmdjfSZJqXMz7zeT/mk=;
 b=gCzaHWfheTfh03FhHpcxMUA7UiTy7ATqHVjUe5FnTsFO1lZjseKpddRyY/PorKC5Hs6l8L
 zgzqOv74Xz5Sv0E7r86bFHwn6ffow8mAG1s+u8RXTC4RWbp298mIXb/58VxxYi9LD9xrep
 C8N9LbNIeIzxIt7I6WjUF5YfsLYFbVnDPF6H/wnzGKvnCXmcwzYyKPjK1+/2Umug0vbzO1
 VdVWwP55qksNW8X7LbzvF9wCdQZYkroSvRLv8ppcETLCOYEwnScVHm4hr50RndPFPt5o6G
 2NQUMb0FIFl4KNuXMm+5eW98yBXGiYKqqUJRlehYtN9IGEodvk+7RJZ3BO9vtw==
Message-ID: <d1fdcbd9-eca4-00e3-afa3-0903e3dffd22@denx.de>
Date: Tue, 27 May 2025 05:38:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: designware_i2c Return -ETIMEDOUT for timeout errors
Content-Language: en-US
To: Wojciech Szamocki <wojciech.szamocki@nokia.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250523105707.16605-1-wojciech.szamocki@nokia.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250523105707.16605-1-wojciech.szamocki@nokia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Wojciech,

On 23.05.25 12:57, Wojciech Szamocki wrote:
> Change the return value for timeout errors in i2c-designware from 1 to
> -ETIMEDOUT. Returning errors as negative values is standard practice in the
> u-boot, which enhances error handling consistency across the codebase.
> 
> The current behavior can lead to silent errors when functions check for
> negative return values to identify errors. For example, in
> `dm_i2c_reg_read` from i2c-uclass.c, a timeout results in an uninitialized
> value being returned, potentially causing unexpected behavior.
> 
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Wojciech Szamocki <wojciech.szamocki@nokia.com>
> Signed-off-by: Wojciech Szamocki <wojciech.szamocki@nokia.com>
> ---
> 
>   drivers/i2c/designware_i2c.c | 30 +++++++++++++++++++-----------
>   1 file changed, 19 insertions(+), 11 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
