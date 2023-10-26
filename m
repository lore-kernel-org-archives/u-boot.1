Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6A9C0032E
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 03:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8303E87AD7;
	Thu, 26 Oct 2023 05:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698291703;
	bh=cl5WquQxz5vhQaTwL+AOuTsXq/iCmxPvMT50qS3asJg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=xHbB34f0M/7TbipLuzjkDYcxfB7rkylZWCZxz27Rn1QWm0TlRJb+iUSqoVmA7Ew5x
	 a8L/ev4PXzY6ArYLUhB/x/FSC4UQaYuykadCEvHeJwAPJZzuJO6IXlqQTKPbtguzDr
	 s/n38Yi2remP+LgKDe1tIxwEeinYNRpKkT8BUDit7QT63RrWKqw8/dOX7uKFadFlPB
	 jH/cYeY9hHmn9cBr95Uj7Ab+TN9XY7LkoIda3HpdmZf/MwJJKq7cVVQCh11hleg9m+
	 drU011847gYkirrzrhuOUEsvfiuJb8Rs9BIm5H1aKX8woC1MCnF/qAs7nzF6NmEFvX
	 /F5nFOVQrfxcQ==
Received: from [192.168.1.107] (fibhost-66-250-177.fibernet.hu [85.66.250.177])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 61C1087ACD;
 Thu, 26 Oct 2023 05:41:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698291702;
 bh=cl5WquQxz5vhQaTwL+AOuTsXq/iCmxPvMT50qS3asJg=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=a6xZTLbrwButQjOUnHTAh0e80Iz0yV4U0wOFHnvFlr82fCQRsh/iN7be9EkTSml92
 QLxfAH7e67LkXyLr/g3bjp7eiGeVpcl1wQXnVH+fMi4h0c8flI8Nkv5RUlIZlHDU18
 A1BqBKGTm5IewXH8dPa82yTWHqbIm2xVeMw1I2QFVHCqtgyeGGTck0A0PmbiOOgYim
 9H7khX1oAPk/b4FTOrdzfcl8x0F0kDeZztB/7ynUA01iLBMq4QWUD60iOwK1Glx1Di
 uotiMwkGsJ+r6ds8DIL9+MTPEp8v+gZDkhaMf6F2tiG5KPRTeTslrJhTwblZ9b0PQ/
 xeOFXxrumOMGw==
Subject: Re: [PATCH v2 1/3] bootcount: Remove legacy I2C driver
To: Philip Richard Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20231020090227.16634-1-pro@denx.de>
 <20231020090227.16634-2-pro@denx.de>
From: Heiko Schocher <hs@denx.de>
Message-ID: <e09f8c31-3474-b88d-fbc9-c21210f11933@denx.de>
Date: Thu, 26 Oct 2023 05:41:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20231020090227.16634-2-pro@denx.de>
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

Hello Philip.

On 20.10.23 11:02, Philip Richard Oberfichtner wrote:
> The legacy I2C bootcounter will hereby be removed and eventually
> be replaced by a driver model implementation in the follow-up commit.
> 
> The legacy driver has the following drawbacks:
> 	- It's not adhering to the driver model
> 	- Settings are grabbed from Kconfig rather than device tree
> 	- i2c_{read,write} are being used instead of dm_i2c_{read,write}
> 
> Signed-off-by: Philip Richard Oberfichtner <pro@denx.de>
> ---
> 
> Changes in v2: none
> 
>  drivers/bootcount/Kconfig         | 24 +++--------------
>  drivers/bootcount/Makefile        |  1 -
>  drivers/bootcount/bootcount_i2c.c | 43 -------------------------------
>  3 files changed, 3 insertions(+), 65 deletions(-)
>  delete mode 100644 drivers/bootcount/bootcount_i2c.c

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
