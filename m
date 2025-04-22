Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55327C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE0AD810F4;
	Tue, 22 Apr 2025 12:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745319548;
	bh=nkQtO8rs+L1n6sEGsXVXzgJeyR1mmXenHHd/AmtZaig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Y1CIEZB3eJeSF8Ne8XjtKUpG2QI6EkNlYlzeIbAxXoqYZPJTC8cz6SAXC4023kyC8
	 DdJWpkTKkERu5ulOIKHy42j+Gl8RpxAkWb23hF7KvtIRVTYfOOef3vrfrWyli+OyNJ
	 CUaTCcIjKIvGgTHyWlRR32IAa9uNwex/d5gryeQydRqZD8vSlezwfqjYqQEWxL+SwH
	 ISVBCx+aybsxYX6F+7MNC+czblGw+kA/5tBTWSmJJMLyg1A04NdaHHSh6c/k3H1Ito
	 OtxtRzhqiXq+RsURDrKa/n3QBpWhEVmUpSWW5F46NedPaEP7QTNe+SFWmd4fNq7Teo
	 7INrD6QNynBRg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D39AA81273; Tue, 22 Apr 2025 12:59:07 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DEFA810E8
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="LmjfNuJA"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2FC48102E13D0; 
 Tue, 22 Apr 2025 12:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745319544;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=nkQtO8rs+L1n6sEGsXVXzgJeyR1mmXenHHd/AmtZaig=;
 b=LmjfNuJAGsjI7p5b8ptCAPJyGF+WLQiOc8k7FNIiwlEK+ILoQGDfuvUqOvnsUhngUUteaO
 L/JzE4q3Bj40rpAnP1MP+c7/yZV9gKAhil6UQY3ijPMNmN09XOqsoy4JyDdQE9x3SXJ77R
 ZW66mZuJRtUfCSoBfYpOoIw/6oHEwazcwmO2OagItm4VpbNI1oIC/Uozxp6Uzrhl8y8YDT
 f1HUhjUic8vKwk28t1zvVargTf/BbHGRsX6CbcW8wd+FM8Kqugw9tQngV7B8m0M6UfhkO/
 KJEbw/+qRAEwL/UB8tzAOUUeAGxBzYWM1h8GIOBgW8uRNbJYs5zEdGTceuUjsw==
Message-ID: <cd02e1a4-45bd-354a-b3a9-c01b0370eae4@denx.de>
Date: Tue, 22 Apr 2025 12:59:36 +0200
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

Thanks for the update!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
