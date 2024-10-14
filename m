Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5ECCD1813C
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 18:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4A6E89066;
	Mon, 14 Oct 2024 20:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728931329;
	bh=DtQRMwf907Ur+SBsTm8DDPnFnncLOJTKzgEh8fUfWt0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vx3FuOpVqlGj3qXa3Fp27SBs1B2pBgTD25idvfIz3eSEHzzFDB/lDMLrXlQtSnSY0
	 G+hQEqRln3kJh7mv2tvXvye86GQbDqfWEvlpGmQ3TvqzTpq/PrtiaCK0Olu9cZL2o3
	 uN4UNp10j5HtQZR1Kf5lIs487NeQKQPo0lNtLYF2B+vJJGC2s9yA63YxzDTgkAa4je
	 aO5DI1nwyPEzo0jHxODjKhgBzoz37UPwbY2mW5ojo4U+YiDNmTpyroVHcksLGmAsIB
	 H3OZjILxBjfohS5CBz69pxpQ69OA0p9hM5Yz+L1r0nRpwjkpIl7UrXYj051XKAE4R/
	 tjDFjR/ahm37A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5E94F8903C;
 Mon, 14 Oct 2024 20:42:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728931328;
 bh=DtQRMwf907Ur+SBsTm8DDPnFnncLOJTKzgEh8fUfWt0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XQf6jhxYVahPpkgicsJtBplKUNLhHYqzXMQXCyQeGuGC8bunVaTf1Ybv7SDKfSRvO
 WX0dP7MefDfvt0tUSNCZc1ZE2ZJpC9+y7FncgPFguFOw6UbA4NtxnLq5CizhozVmbp
 EcvhpVv6qRoc+ltzbjcow7sgU7DOrQmS7ttZsPOv8YeQEe/ApHDEwiMudb+hs5kdo8
 yqha0Ejs2O5DyoA2fexJO6cX/3q7Lg8s53qT95NBEVr1hXpcXfCS2t35T8TuMXLKou
 cQgWRcIxF+/M9C136Q9AeKOrnplxg/MB3lVWOERsWUSySalN5E1QF2U107RAR9DCEY
 zUXoZZs/1R2xw==
Message-ID: <064b25bf-0eb9-4c4f-8871-30bb32b3b3f5@denx.de>
Date: Mon, 14 Oct 2024 19:57:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] misc: atsha204a: update kconfig description
To: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@intel.com, sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
 <20241013143232.2090645-9-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241013143232.2090645-9-l.rubusch@gmail.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/13/24 4:32 PM, Lothar Rubusch wrote:
> The atsha204a crypto chip is not only on the Turris Omnia board. Extend
> the description of the atsha204a kconfig to cover also other boards. As
> an example the Enclustra Mercury+ AA1 SoM.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>   drivers/misc/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 90fa8c9eae..6009d55f40 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -73,7 +73,7 @@ config ATSHA204A
>   	help
>   	   Enable support for I2C connected Atmel's ATSHA204A
>   	   CryptoAuthentication module found for example on the Turris Omnia
> -	   board and Enclustra SoC FPGA boards.
> +	   board.
>   
>   config GATEWORKS_SC
>   	bool "Gateworks System Controller Support"

This should be squashed into 7/10 ?
