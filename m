Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD87C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 05:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25935808A2;
	Thu,  6 Mar 2025 06:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741240586;
	bh=DwzNVsyaK+UaAZkW501mq0+9m7F56PdvpbjLA0cQbfs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=LPJV9LGWASqmTFT06FT2s3CsWO8O3IkPcuBLg30I0cHAL0Ge73Y2ocMH2KbsSc7i/
	 e3HepPBfDETtgPs3uGiyhfSgNaymE/s2QkqdqG0diglfdh5UQx5NSMp1CQAWpu7Nbk
	 Bg8I8XXdQNrhaaAoYVbfcWIk6DvgwHA9RX69Ap4VOodDV0D1IM8jKuavuwgT0Fd7bM
	 Gh6TbrX97w6CR1Qsnw6RLMpFazP3m+ST/Bu4i1YgZQq9L/h5w997yQ9m+JBbGd7jOQ
	 JBglBUn544CjFrQJWb551tCCSUbcVC+2WO/z1jr2I61RL+rKQduDPmQOpssCqNH0WK
	 S5aG8O3xwAF6w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0476810ED; Thu,  6 Mar 2025 06:56:24 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FD5D80805
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 06:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="dqWBZ4yO"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 341EA10382F1F; Thu,  6 Mar 2025 06:56:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741240581;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=DwzNVsyaK+UaAZkW501mq0+9m7F56PdvpbjLA0cQbfs=;
 b=dqWBZ4yOwe82qCJOBRZNcqLJGKeKm6AjIGk7CQ7A/qsIh8XaCecrrxG2BKOtOj8jkltAuV
 wt489jukxNGbM6xccr+YlhxnfoNCRq/+orhLkF+NvJS6T3rwoEgwynzwtWe/FUs+4n20Gg
 pzJNaoWUTIeHJlODrnOB7UEqos6e7UxmMiPZs18gFu3/9l6Pg5D8rszM9TmmuVsPYom9CG
 +8EifOGOjHMi/eyjC5v3lB/Tx+HfnIihOmTv5buaZNAwvFl6iKZ49PbKbVtV4wkhxaZ/ff
 J7Y0uyFRQkxkcuPmmcjw2ns9Eaj2k7gk0Ck3eSYUBz90vZR9ne3zS2knpIA98w==
Message-ID: <29607b7f-f492-9244-9a52-851d49123de5@denx.de>
Date: Thu, 6 Mar 2025 06:56:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 06/12] i2c: Add support for ADI SC5XX-family I2C
 peripheral
Content-Language: en-US
To: Greg Malysa <malysagreg@gmail.com>, u-boot@lists.denx.de
Cc: adsp-linux@analog.com,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 David Virag <virag.david003@gmail.com>, Greg Malysa
 <greg.malysa@timesys.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250226173150.13198-1-malysagreg@gmail.com>
 <20250226173150.13198-7-malysagreg@gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250226173150.13198-7-malysagreg@gmail.com>
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

Hello Greg,

On 26.02.25 18:30, Greg Malysa wrote:
> From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> 
> Co-developed-by: Greg Malysa <malysagreg@gmail.com>
> Signed-off-by: Greg Malysa <malysagreg@gmail.com>
> Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
> Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
> Co-developed-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
> Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
> Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
> Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> 
> ---
> 
> Changes in v3:
> - replace readw/writew with ioread16 and iowrite16 and friends
> 
>   MAINTAINERS           |   1 +
>   drivers/i2c/Kconfig   |   7 +
>   drivers/i2c/Makefile  |   1 +
>   drivers/i2c/adi_i2c.c | 386 ++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 395 insertions(+)
>   create mode 100644 drivers/i2c/adi_i2c.c

I am unsure if I not already sended a Reviewed by in an earlier version, so:

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
HEiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
