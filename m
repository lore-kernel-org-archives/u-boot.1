Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BA9D232E4
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 06:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AA2A8423D;
	Fri,  9 Jan 2026 07:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="cqan8fi0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D625F84248; Fri,  9 Jan 2026 07:03:43 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8CD484150
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 07:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CA0F310B5F5; Fri,  9 Jan 2026 07:03:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1767938621;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=sjFXXkuGaTAKH4K6YqvOSiEhXIe4k+XlXx2zN/V2tQs=;
 b=cqan8fi0DyatpFjGn5HwoPq2dXxDvTCsTxjE3a8pRfHQzHsGZBGQtxFeS4B1gSu1AHKh4Z
 7uAh3u2syLMqN2ZAElOSvJ3tpTJ6Fv/LtOsa7ca1qha4vOoxtusQXO3zpUgrZ/dpJOnV7r
 5lQIQ4l1dkp93KxeLnBSH/i1UKNO7Sa9MgQW7LC6lyOZBcrkg1N8++abhu8nzUAqAOj1tJ
 g2tpVwPJtiuk5S0nvj6vo8cw8eqJd1Ft5zAi2+XJd/tiNea6i9fMMdJPUwM9i1uOLT3Uqa
 pr8KDZXJe9oXPFJKnrYVzV1He3fGBEhy98VuNTAP+bA+T/44kiWu27Cxi8U4rA==
Message-ID: <6e424cf1-04c6-6fb5-60ad-3a5563f6e50d@nabladev.com>
Date: Fri, 9 Jan 2026 07:03:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: geni: bail when clocks can't be enabled
Content-Language: en-US
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260108195301.3159260-1-casey.connolly@linaro.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260108195301.3159260-1-casey.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Casey,

On 08.01.26 20:52, Casey Connolly wrote:
> Failing to enable clocks will lead to bus hangs and the board crashing
> in some cases, let's actually deal with this error and fail probe rather than hoping the clocks are already enabled.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   drivers/i2c/geni_i2c.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Heiko Schocher

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
