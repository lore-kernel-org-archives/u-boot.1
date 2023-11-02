Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49B6C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F052877BD;
	Thu,  2 Nov 2023 15:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698934093;
	bh=kG6pciVH3AMy+UxQzxT3ex4jHpHit9G/ldUWV8achpk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=bcd1bJHBuyj9zdQwMPKDivWv3Tg4CIXqrDetmd7P09iyI8IPLe2Rga25Pr9NyQ1cu
	 yjgmIvs7Jwa6hbxQDJkx0QQnnoYPtdpP4JhvPn+Go5aTTvUCueHeewQlFKFdDPjcXh
	 t3OIM+XC6BxNLj4gf63AU6vJ4zMiC/9NUwqsO+zSFPOgIKbA0GohUw2VD/l0Q4n6rT
	 Pg6R20C9TvZn4VCf3Pdc3qTiTPWnsnspaUbQatxCnyd8oUXVbA9zVQG0MGOHe9N3zG
	 rrbWDZkOJt4rhSEkLP2jw5SJxBna4I487f3so9qJv7GafmIhUbFSydcQ0ldFyRgFOQ
	 O8dBzPoEpxJpQ==
Received: from [192.168.1.107] (82-131-157-32.pool.digikabel.hu
 [82.131.157.32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2AD9C877B6;
 Thu,  2 Nov 2023 15:08:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698934092;
 bh=kG6pciVH3AMy+UxQzxT3ex4jHpHit9G/ldUWV8achpk=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=qVUqF0OnNN17D07u2KlUhaV/0Bo4iBeAzqX9yZVVlAVKKK1B0h16DjewwOf71vw7k
 A721OCf8s64MS7jId1qef9M0c8Hmex8cKErPDVrmKDDWvNnZ0/j0dYLOWUa4swSHsk
 162j4eLtQv74hRI2GBnqiJrOCcDTgGsrmtq7Gh11D7uhIytEakzbd3V6fF7qXAi4vY
 533tMBu/XT9W16JCMXjfu1GdTbDvQXnhh1sR09InQ74S3uyTlhXJMUEZXWJgoNZkwz
 TD0eDvoiaFLHphzoyd8cFR9bhQwJXydzGHnwiREzCsdVCItXHT1jc0yd4t/V7g+hN+
 b54r0mVYlORiA==
Subject: Re: [PATCH v3 3/3] bootcount: Add driver model I2C driver
To: Philip Richard Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20231031073844.15683-2-pro@denx.de>
 <20231031073844.15683-8-pro@denx.de>
From: Heiko Schocher <hs@denx.de>
Message-ID: <dfcf1445-6bae-66da-bcfc-f544dfe022c9@denx.de>
Date: Thu, 2 Nov 2023 15:08:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20231031073844.15683-8-pro@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

Hello Philip,

On 31.10.23 08:38, Philip Richard Oberfichtner wrote:
> This adds a generic I2C bootcounter adhering to driver model to replace
> the previously removed legacy implementation.
> 
> There is no change in functionality, it can be used on any I2C device.
> The device tree configuration may look like this for example:
> 
> 	bootcount {
> 		compatible = "u-boot,bootcount-i2c";
> 		i2cbcdev = <&i2c_rtc>;
> 		offset = <0x11>;
> 	};
> 
> Signed-off-by: Philip Richard Oberfichtner <pro@denx.de>
> ---
> 
> Notes:
>     Changes in v3:
>     	- Remove common.h #include
>     
>     Changes in v2:
>     	- Adaption of Kconfig help message
>     	- Rename chip to bcdev
>     	- Adapt probe to use i2c_get_chip_by_phandle()
> 
>  drivers/bootcount/Kconfig            |  10 +++
>  drivers/bootcount/Makefile           |   1 +
>  drivers/bootcount/bootcount_dm_i2c.c | 102 +++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
>  create mode 100644 drivers/bootcount/bootcount_dm_i2c.c

Applied to u-boot-i2c.git master

Thanks!

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
