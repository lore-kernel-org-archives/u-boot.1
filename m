Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C28C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 08:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2029F875B6;
	Tue, 31 Oct 2023 09:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698739674;
	bh=SYS/jzABN6qxWDU0YVvFDsnfA4a/1SVZmsb3s4sQuLY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=gWhCv3b3sE57AU32VBLFROx1n4gCySnZbA/hxIbIPCusNllqU5lFcR+oASOpD4XI7
	 2S4zD0Fi+8OMhd7DO98l4bSmq7X9A9ikcHuOMdYHQIJedqQDvXwEZ/qmWsB1yysN0K
	 oKBQP0Gl77WIiBi947JFAFkytEVxUOY5K916q749eo18S84w3EB64Vs7FsuaRG+ZF4
	 rzqrBFdo57UP6OrCG+Crae9lupXEV+4yFYNjaTyCLPTXtDhdkQxbUoEM4uRXrm0jOs
	 nI9jID7d4QxX46fC6YrKbzvCTfLREgMrb1K/OUx0TUmTqBpPLbBWABcbKqUkHdekie
	 lg/Pp73WybwIg==
Received: from [192.168.1.107] (82-131-157-32.pool.digikabel.hu
 [82.131.157.32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BD28F874B0;
 Tue, 31 Oct 2023 09:07:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698739672;
 bh=SYS/jzABN6qxWDU0YVvFDsnfA4a/1SVZmsb3s4sQuLY=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=OY8YZ7es7ikpdQI7ut29aBbLFB4cgsyQxFwSGaxCT/FnjygWuVmFeopI6jhbrEyyw
 +WL8fgcsafMMQorpoQalvJn5ChvacgZh5zb4I+gn2vTfEReu1BehR9mH4kvG8hfXal
 E6coADr4yXL++xWm6/z0bwpM26yeqwYH5QuH7gqIFJgWxamRPdIRyV4pV6V2cva7F2
 GtWIhYOaPQqfBgn8GN5r+wfRqqABZ3Nv/2lkOAa/DhKs7VVKZT2D6xB1Y2LmQxl3V1
 sBbILHppzNXVLUxidwHOchUBZM0ccY3K97DqCPHQlKBxsOkrYpmAp/nPwKjhSddZxW
 Krn7JqBxdOiBw==
Subject: Re: [PATCH v3 3/3] bootcount: Add driver model I2C driver
To: Philip Richard Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20231031073844.15683-2-pro@denx.de>
 <20231031073844.15683-8-pro@denx.de>
From: Heiko Schocher <hs@denx.de>
Message-ID: <1490ba71-ee6a-6bc4-8860-a562d60fd70e@denx.de>
Date: Tue, 31 Oct 2023 09:07:39 +0100
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

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
