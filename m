Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FADDFF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 09:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A01184659;
	Tue, 28 Apr 2026 11:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="N7G64aAG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68FED84669; Tue, 28 Apr 2026 11:55:26 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A09E84658
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CBF9B112D53; Tue, 28 Apr 2026 11:55:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1777370123;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=4ISnnAaEg4+nyke7Eh7a9f981z0OR4h1wU/DmWR5JIw=;
 b=N7G64aAG+XXFpbNvr/g7lHzuvEN7+P3QRkPoVbmxYNqBL9E7ItOVem9dTsUJSXiH3+vbD0
 aI2zFLddMc0Nxhh7wvDmsasrPaQZ6LSJ6muO9beYuamam1MgrXUQGoLrkIwkZROzfBUDSI
 z+TZGxPCmHpyW3Kudc1621dL/ftln538bKoPogz8pd+ejrvIrDBLxQS1jDxqmogGpn8su2
 Xw0xbmkm30vEnLRiiVLEXZ7mgoDdOGKASJr5wTNaEFh2jNFFRVU9pVU0l6ucsOAQvU5x3Q
 1VSQmiZwzm9JHTo9p/vQJ4wuMcbibLv21snfwse6MIPQV9waM88olgrZIr61wA==
Message-ID: <41960ee3-8645-4d79-0a01-e9642b674a6b@nabladev.com>
Date: Tue, 28 Apr 2026 11:55:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: imx_lpi2c: Fix MSR status check issue in STOP
Content-Language: en-US
To: Ye Li <ye.li@nxp.com>, festevam@gmail.com, u-boot@lists.denx.de,
 peng.fan@nxp.com
Cc: uboot-imx@nxp.com
References: <20260428085312.1808358-1-ye.li@nxp.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260428085312.1808358-1-ye.li@nxp.com>
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

Hello Ye Li,

On 28.04.26 10:53, Ye Li wrote:
> In bus_i2c_stop, the MSR SDF is checked in a loop after stop command
> is sent. Meanwhile, some error status in MSR is also checked by
> imx_lpci2c_check_clear_error. But the imx_lpci2c_check_clear_error
> will clear the MSR.
> 
> It causes problem in below situation:
> In current loop, SDF does not set, but error status is found by
> imx_lpci2c_check_clear_error (for example, NDF), then NDF will be cleared
> and result has NDF error. However, because SDF does not set in this loop,
> it goes not next loop. When SDF is set in next loop,
> imx_lpci2c_check_clear_error is re-executed, but as the MSR is cleared,
> the result is 0. Then the stop return 0. But it should return NDF error.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> ---
>   drivers/i2c/imx_lpi2c.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
> index a309fd6f07c..e2b4fd334ec 100644
> --- a/drivers/i2c/imx_lpi2c.c
> +++ b/drivers/i2c/imx_lpi2c.c
> @@ -239,7 +239,6 @@ static int bus_i2c_stop(struct udevice *bus)
>   	start_time = get_timer(0);
>   	while (1) {
>   		status = readl(&regs->msr);
> -		result = imx_lpci2c_check_clear_error(regs);

Wouldn;t it be better to evaluate bits in result too, and return
if error bits found?

>   		/* stop detect flag */
>   		if (status & LPI2C_MSR_SDF_MASK) {
>   			/* clear stop flag */
> @@ -250,10 +249,13 @@ static int bus_i2c_stop(struct udevice *bus)
>   
>   		if (get_timer(start_time) > LPI2C_NACK_TOUT_MS) {
>   			debug("stop timeout\n");
> +			result = imx_lpci2c_check_clear_error(regs);
>   			return -ETIMEDOUT;
>   		}
>   	}
>   
> +	result = imx_lpci2c_check_clear_error(regs);
> +
>   	return result;
>   }
>   
> 

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
