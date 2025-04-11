Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75E1C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 04:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3119D83E60;
	Fri, 11 Apr 2025 06:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744344465;
	bh=HlpqM+ylmQAyBMVYGP143Q97yAyc+ARHyKnoQekn3Ik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=rzYEyL9RQIq6H3KRvaj9+lGuU+5id+bGMrVm7MwRuMv207aXAn2lrnKWlNLQja39F
	 GbDEZtJShc1durbG/EyszjCNHjlMqr6CMWk6bnl7A6BdcvpCqlutMzCvPlhlkQGo8g
	 XHpZ//H6S8BBzJilv+dRIW644U6P5V5u/rD60sQkXS8AX1KISNv2gy6Vlrb1hknufL
	 oo1vCTdowc+htoqNRfhLs0BR5xtiLYTp3eZT4gJV83S1yRBkL65K5LKi46/OFu5gpa
	 LakLuJCW6hxto4v6v/6GrU9jyu2PemLT8RmrHVuELisuYA45kw9NozlGUed9X8hE0X
	 KyHrMRehZIHBg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8691D83E65; Fri, 11 Apr 2025 06:07:44 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86487836E7
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 06:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Vq9Wt5oz"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A0B73103B92D7; 
 Fri, 11 Apr 2025 06:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744344461;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=HlpqM+ylmQAyBMVYGP143Q97yAyc+ARHyKnoQekn3Ik=;
 b=Vq9Wt5ozEUBC1hZnIxbpL39g9e5RxNxeWyR+KRfkKiYMwUN+huYQY2IKyPflXXvZIqMv0l
 YGaOzFPuWwowMRirzyqUTvNGHUb7ajaLpGIP2aOUIewY/QxJzcxvhqgVPwj5YHHF5K/oS5
 aTYdss4eWfGKDMWQQ02mG8PyslMQzpn5PJCR88fCCgp/sY2VTbWGhYrUoYN9XfkbsLD1ZS
 UMw2wNnecdBUrPQd29qFNnuvMB+OywBuJRhLFPURvvpmuOCSkuCtGv3rXhPXcQrWoDPV62
 VMTLRN+DwReN2xWAZEerKH5ozhq6tbYyHYY/dK2fYe7EOqYJuIMEE/HmBmggIg==
Message-ID: <1e460373-f7c7-2261-332f-e615951d4900@denx.de>
Date: Fri, 11 Apr 2025 06:08:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] gpio: zynq: Read using DATA register when direction is
 output
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Nam Ian <ian.nam@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <8067946288c687c323403857aff01e3074bcaeca.1744273514.git.michal.simek@amd.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <8067946288c687c323403857aff01e3074bcaeca.1744273514.git.michal.simek@amd.com>
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

Hello Michal,

On 10.04.25 10:25, Michal Simek wrote:
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> 
> Gpio status command reads the DATA_RO register rather than
> DATA registers even when the direction is "output", fix this
> by reading from DATA register when direction is "output".
> 
> Signed-off-by: Nam Ian <ian.nam@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/gpio/zynq_gpio.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
