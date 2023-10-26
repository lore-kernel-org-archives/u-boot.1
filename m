Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B81C0032E
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 03:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E771B87AEC;
	Thu, 26 Oct 2023 05:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698291862;
	bh=ig5il3JXYPeqECk0HNex3x3tIPj5iHAojMn5LuCadHU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=DK1905Gn7xvL1nwZYjz/Ib51+PMw7oIJc6C5n0p4ozoQ5uhuLU1ms9XkeGNkTFuph
	 oQ0oPLOAf7EWlnOCuHPbLYowQnVpuN9FW/eUjwRdFZ6Y3c/WFZ7JGa6gSVYjhVuCPK
	 SzytUCz39AVB+Es82Y8/WFLX0es+Wla6W/jr9vQmF3+47zPr0WURdryk6fD94AedI4
	 Uv3m/QzlURG3SSMZ3rAXxbsSP5rEQBMRGN186K3/tMI+FM1OyMTJy2Cu9eisG5sEe7
	 GTSBiA34ZFIH3AJ2z9Z6cLbfLbz/73bvzr1CHD4vI3hLXAMJSW4L8+0IijseElSjXZ
	 HP9G5IB1/tmhw==
Received: from [192.168.1.107] (fibhost-66-250-177.fibernet.hu [85.66.250.177])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3C68F87AEE;
 Thu, 26 Oct 2023 05:44:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698291861;
 bh=ig5il3JXYPeqECk0HNex3x3tIPj5iHAojMn5LuCadHU=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Wg8Dr2DgQYFy79x6KrzCpTYdsvfmv/Ch5ifVB+ISJdcfwYlUtC0vvzAXAUuaCRecA
 ybq/h72+yIPtm+Ig6uWtBrl5kHYYQTpAteshqN2YS0y+2eXUQ32nhg43KGo4yvQ90v
 ktbo5K/5akdIrGQyxpISe6lKhZKq9VXtRYabVRtnBeiMXbxPLYihBsxGLPslLuhRKo
 1JFf8Gxse5tFtvMjh9RMqx2DgqChmQl4TyZaq1g1rcKLYJaqUPK2kl1H/rLY9Ha2zB
 0MjTdW/MORijO6Ya+OY4dWObKC9bWE4D4aKK6MhLKqODYKB3rziyMMWLc8i96pwGBs
 eT18Aa3rJh71g==
Subject: Re: [PATCH v2 3/3] bootcount: Add driver model I2C driver
To: Philip Richard Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20231020090227.16634-1-pro@denx.de>
 <20231020090227.16634-4-pro@denx.de>
From: Heiko Schocher <hs@denx.de>
Message-ID: <1f54d2df-f56b-f2c0-6962-c6aed0c61a31@denx.de>
Date: Thu, 26 Oct 2023 05:44:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20231020090227.16634-4-pro@denx.de>
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

On 20.10.23 11:02, Philip Richard Oberfichtner wrote:
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
> Changes in v2:
>     	- Adaption of Kconfig help message
>     	- Rename chip to bcdev
>     	- Adapt probe to use i2c_get_chip_by_phandle()
> 
>  drivers/bootcount/Kconfig            |  10 +++
>  drivers/bootcount/Makefile           |   1 +
>  drivers/bootcount/bootcount_dm_i2c.c | 103 +++++++++++++++++++++++++++
>  3 files changed, 114 insertions(+)
>  create mode 100644 drivers/bootcount/bootcount_dm_i2c.c

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
