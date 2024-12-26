Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9E3E77188
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 16:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B63803B7;
	Thu, 26 Dec 2024 17:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1735230644;
	bh=v7BfeMMUsuKIDM7/dgPZtiKv1cRWfh5F9xdlkS0sFiY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h/4PgU3r7xw7HvO4HTLvLuvyuizZepIy29Hzu7FNuhud1GYWnW8fSOmaFrz3BXLsB
	 nJpUDcZzssX/KPqPxZlRclBL9mXT0i2NiIEPrSgErsrk6NJ9m3V8/UJkDQ4v3YH0qu
	 fp+1km4wtfu84n50c+onHPr8+5w+exkbmeOq1vpOgoEPH8FNuWG+Zc6COa6jAe6gpF
	 7ijAvACb0O1Wqr9RujfCjPtQd2A3j3++RbG+kfWJej/MnfVQ6r+IlbqZfTZQb8ElRb
	 jlsRlufPNlPfCWz5wPa3wLBfJXs1r3Nd5Jk2TZhLf0/8l5CWLsEOe9LlsvYPuWl0Vx
	 e0GklnKiE0S5g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08DAD80384; Thu, 26 Dec 2024 17:30:43 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE11280384
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 17:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="bTk7oHu4"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 90D6E1040DBCA; Thu, 26 Dec 2024 17:30:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1735230639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v7BfeMMUsuKIDM7/dgPZtiKv1cRWfh5F9xdlkS0sFiY=;
 b=bTk7oHu4uuPjQDRS14O477V+3qq/tPhdpL2LTaPyedWOotKZDkbaUW286FIpovt/7BwznF
 f74R1HSR9cIn+xIdCUB0EQzPefK7/uDPJEB8G2HqB0CvbCP54jViGnaus/gS9ZwaxVFsRl
 eHxELA4oOTNtjImyfIAlvQYELsZTpJ+JyhXy6PT02QKk7oCO0CSQB3HTV7z1usL8PJATSq
 lQpA1pMLUX+2tI9m9uYyYwWT63/CKHVQbfIngVnNLFJoJjfSiOgcFXyO0roWMI5y7BwYKn
 s56Xfr/O4cxkmUfSJZa02GNySn6jopMYvHKZHb7Z6wXjBJVrAXstQnH0TZ/gtA==
Message-ID: <9e5e11d5-ab45-447f-87fd-10f96dabbbd0@denx.de>
Date: Thu, 26 Dec 2024 17:30:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, tudor.ambarus@linaro.org, j-humphreys@ti.com
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 u-kumar1@ti.com, trini@konsulko.com, seanga2@gmail.com,
 caleb.connolly@linaro.org, sjg@chromium.org, william.zhang@broadcom.com,
 stefan_b@posteo.net, quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com,
 p-mantena@ti.com, git@amd.com
References: <20241224153707.2054421-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241224153707.2054421-1-venkatesh.abbarapu@amd.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/24/24 4:37 PM, Venkatesh Yadav Abbarapu wrote:

> @@ -1593,18 +1596,22 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>   	}
>   
>   	while (len) {
> -		bank = (u32)from / SZ_16M;
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			bank /= 2;
> +		read_len = len;
> +		offset = from;
>   
> -		rem_bank_len = SZ_16M * (bank + 1);
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			rem_bank_len *= 2;
> -		rem_bank_len -= from;
> +		if (CONFIG_IS_ENABLED(SPI_FLASH_BAR)) {
                                       ^^^^^^^^^^^^^

> +			bank = (u32)from / SZ_16M;
> +			if (nor->flags & SNOR_F_HAS_PARALLEL)
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Is this really correct ?

Should this be wrapped in if (CONFIG_IS_ENABLED(STACKED_PARALLEL)) instead ?

[...]
