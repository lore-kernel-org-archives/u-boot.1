Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4017FC369D3
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 15:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2E6980F6B;
	Tue, 22 Apr 2025 17:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745335128;
	bh=qVcTD8IV6+WkufO8VrPhW3RC7My+wqogW1DI/sZbZmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Q6/w4qySJj+2icxljlmV+7k3gn80rJxFKnANgMZoVAXfCMumqzyVaUQL25D64p8vy
	 bjR7D35o46n7aI4ermyp8+BwymST4LXGmG5UGorW7kbTwXTCRb3tCVcA7MuwYEXW28
	 nZBKiT+gI+8ednmg4u0aoiPAm6K81tVKmh9govU1IzwF2vKz/smOOu9lXeTmYu2URB
	 tJLwtwkvKcbWWDEYVVFW9m8DaltN1+0n2QiOXXiF9DmQwPFSbLN6jZk/+eGdZt6UjP
	 v5DmOW/8lE6744G/q5InnDJQ0JthgVLL1R7xUhVnKLblABfrQE3vjFcVVul5schGOd
	 08WdPI9mgMSrw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D0780FA8; Tue, 22 Apr 2025 17:18:47 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80AA980F03
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 17:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hENQ2ONG"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 349791039EF31; 
 Tue, 22 Apr 2025 17:18:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745335124;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=qVcTD8IV6+WkufO8VrPhW3RC7My+wqogW1DI/sZbZmQ=;
 b=hENQ2ONGWFLtFefMEtgd32mEo1nlkycKyRfdF19aai1ka6+FgbWQoKtbFt4gqQ9MDweQUn
 WW4C+FFNM1VUc41IZjDKYeWgQ7V1+PsyR3bX68FdwWIk3Y9HC5urYwmNQHIV3e7/iCYo9z
 bkPJFHywNLH4ktB7wZWmMBkT9e4l/ABCxf/GBmUTTe+PTA7j6B2gMhQl0ijJTD66uEmnxD
 IzCNjW9Fp5HMnwVG5QvSPclIwH1SMoMv8gxdfDIn1lc6D9o7hGIZFnJ13PUVlrJr4wChxB
 vJjoezp3b+gVHNLfo/fYPXKOrWZagnBsAHyfBVv1+LmsvFn6AmcHXtlt83Br0A==
Message-ID: <56694a79-9016-d175-1478-51f0286705a4@denx.de>
Date: Tue, 22 Apr 2025 17:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 1/4] i2c: omap24xx_i2c: Remove unused
 CONFIG_I2C_REPEATED_START
Content-Language: en-US
To: Aniket Limaye <a-limaye@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 virag.david003@gmail.com, w.egorov@phytec.de, j-keerthy@ti.com,
 u-kumar1@ti.com
References: <20250422101957.1949448-1-a-limaye@ti.com>
 <20250422101957.1949448-2-a-limaye@ti.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250422101957.1949448-2-a-limaye@ti.com>
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

Hello Aniket,

On 22.04.25 12:19, Aniket Limaye wrote:
> Remove unused piece of code under CONFIG_I2C_REPEATED_START which does
> not have any Kconfig entry at all.
> 
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
>   drivers/i2c/omap24xx_i2c.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)

Applied to u-boot-i2c master

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
