Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E829DC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 11:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55A8381F45;
	Fri, 25 Apr 2025 13:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745579581;
	bh=rw2SvhufAJ7Psah4YTDhrj0jgsmaDMAshilI4bvYjGw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=R32ENZSqjfoOw3FJyT8lz1HOmH2f/P8HdboEVq0kR6xokmUDhEvCsqnRYv+KlOH7L
	 m4FlAFyyOGdpkA5AJjl1wBuc4OQuMpRSSFyIFTS9qv3SSwM4y1aiEYOO5EUnRN9ogH
	 y+MMFujzjzcEgMiyvC0vxPOhyvJijr4jejY7AfqSprpaEEvPMBfdhPD1SpT9T9x9ey
	 lHfRL4od3CKz/9QgDmzrCBxu6PcAqmx65bv5p6KpuKgnzGwbEXkzpq4RzhQnZpS5AV
	 SZH+wMEIE3F9BIzv3xMqQChfk47bxzaBWUU7LpPKaewJIlOzcW89wnQ7EDmNVSvCXc
	 57MrnlkrCv2tQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77E8E81F45; Fri, 25 Apr 2025 13:13:00 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 858F680194
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 13:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="IbVX/u0w"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9D96010275AFC; 
 Fri, 25 Apr 2025 13:12:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745579577;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=rw2SvhufAJ7Psah4YTDhrj0jgsmaDMAshilI4bvYjGw=;
 b=IbVX/u0wX8uBHRoofvyiweFgcFMFdQdMJMkoIRxy/BV13A2Yrx//IqsEB0bgbbIvwYDrGB
 wKOLN71QFB10eMmT3OqPSk7TK8chuPBbO+7wFemrL/Tz0d3exKl5RzOsOkQBUcBmqfEizY
 jir0vxvB3ejD0UZoJ+eb0Avjqg+TgTgUqmRgxsAkeNswRn2bwSApUmIuPghfcTvRClqou7
 rlU9ud45XJxBdYz7PvZKMWzXS2gB7Vy7NPO6xs8FVlZtITFUCtSttG5XSuOLQnXgNa/9tX
 BieQiOx9fdsbIEKiLG5GjVKLvZTol7ViUy60r93CRReEkOB51fWYuSiJwRFhsg==
Message-ID: <555e55d7-fd75-fdb4-c657-dcb5d40ea956@denx.de>
Date: Fri, 25 Apr 2025 13:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] imx: power-domain: Enable refcounting on imx8mp
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Samuel Holland <samuel.holland@sifive.com>,
 Neha Malcom Francis <n-francis@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Fabio Estevam <festevam@denx.de>
References: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
 <20250425-ge-ian-display-support-v1-2-8a7a0fe75023@bootlin.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250425-ge-ian-display-support-v1-2-8a7a0fe75023@bootlin.com>
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

Hello Miquel,

On 25.04.25 08:49, Miquel Raynal wrote:
> Prevent enabling/disabling multiple times the same power domain to avoid
> breakages due to the same power domains being referenced several times
> by different device nodes.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   drivers/power/domain/imx8m-power-domain.c | 4 ++++
>   drivers/power/domain/imx8mp-hsiomix.c     | 4 ++++
>   drivers/power/domain/imx8mp-mediamix.c    | 4 ++++
>   3 files changed, 12 insertions(+)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>
Tested-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
