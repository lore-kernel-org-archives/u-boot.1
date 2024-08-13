Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9EEC52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D044D88360;
	Tue, 13 Aug 2024 06:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522918;
	bh=N5ytIeKuhsCkE5CvXA0Nxulli2Y9wRyGUCZkuRVILjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=hPPp3bS/Kt65awsVwL7ufZpt1O6wKvNkUz+buKtCufWbig0QEcHu7z/GSDNsho16j
	 TtxsE9udHT0v2FWCvihIylfyOsx9WvQ6+qaSvQmskvIYA6JGYSuYPqtydCWrp7Vmsx
	 R8EVvYcyGphXxAExV+cUB+Lg4GoDRABGgsT6+myBkka0d1F81Epmyz7h1SBgHxkG6n
	 J8metr/wcu6l+qLGZ0ubmvcp7SCjeAFhxfSBNFUrlhfERE2zcqy21WkYf0JgVGiiTS
	 9E/quX0vkPhbaZXk4X3DGRiSJqUBydHGcGEHvj2KtF+MvlcTUjs1xSWmUXJyGkaPXV
	 W93YMSbIxOjjA==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DB89887E30;
 Tue, 13 Aug 2024 06:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522917;
 bh=N5ytIeKuhsCkE5CvXA0Nxulli2Y9wRyGUCZkuRVILjI=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=Wzpd7JjuuwMGmV6meJKkM8jdjQin2H8YKjLwRtBLCJoUZJ+zr9tJDRmyXqnT+GY9z
 h8o0GW4krwfLeCJSdZQVK50iSCybW+s1ZAk9f0gFPtfutmvr+uipQJOI6tuzPn+u5l
 UmR3ZIAL1KrUhH5nJawIY6S3Jr9SVKv5F+zw0agkOy5LRYo97fo1m5KKPjF4LilS26
 fI5jjGrbqOXHm/Vei4jj05HVh2YbDrhwkIPTruAUH7moX4dmiVgq8akRVpCVbd7gGH
 nu+mftBMXc4Ws+oosim1pZxDITVssoDO0bqDGP8cEcqXDXzIcxcSuOho8fhgSebb1w
 TKoBnJ54sgLTA==
Message-ID: <45391933-afc2-38b9-81ab-5ab81e1618a5@denx.de>
Date: Tue, 13 Aug 2024 06:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 18/18] i2c: Remove CFG_SYS_I2C_DIRECT_BUS
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-19-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-19-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Simon,

On 11.08.24 16:50, Simon Glass wrote:
> Now that this is always 1, remove it and the associated dead code.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Drop patch "pg-wcom: Drop CFG_SYS_I2C_MAX_HOPS"
> 
>   README                 |   7 +--
>   drivers/i2c/i2c_core.c | 104 -----------------------------------------
>   include/i2c.h          |  35 --------------
>   3 files changed, 1 insertion(+), 145 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
HEiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
