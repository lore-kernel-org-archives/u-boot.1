Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF9ACCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 14:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B94783BD2;
	Tue, 11 Nov 2025 15:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="TXSujK0O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC0D783F85; Tue, 11 Nov 2025 15:07:01 +0100 (CET)
Received: from mail-m15579.qiye.163.com (mail-m15579.qiye.163.com
 [101.71.155.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD93F83B8A
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 15:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.234])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2934dfe1b;
 Tue, 11 Nov 2025 22:06:53 +0800 (GMT+08:00)
Message-ID: <0af76f64-9315-4c75-b097-98dfbf8d7a01@rock-chips.com>
Date: Tue, 11 Nov 2025 22:06:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: i2c: fix incorrect STOP flag for the
 interrupt enable register
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Wadim Egorov <w.egorov@phytec.de>, Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20251107-rk-i2c-illegal-v1-0-3e5fea13a899@cherry.de>
 <20251107-rk-i2c-illegal-v1-1-3e5fea13a899@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251107-rk-i2c-illegal-v1-1-3e5fea13a899@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a733dadca03afkunm5b436a3134213
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTx8aVhoYHhkeGE9JSkJCT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSUhPWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=TXSujK0O8YtlxvZIq/cNGa58NjDEvuurqa4OLAkZfMJae8CkJl+tGA48DfnnVLnnbrN/NCGYPQP8k+aNl2G6LgaDqmRXUDmEOgNBsNmtNZO/Z0+eDhLqpdAKsqVDQXNn9itlXtHB3C9I0P8Gk2yL9n5SmPfuTd+sq2IkednAigY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=6T8yqfSSBvMloeJiLeSU62RxqZEPWzYpYlhfDln2Q5k=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/11/7 19:39, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> I2C_CON_STOP is a flag to be used for the con register, where it is bit
> 4 to send the STOP condition.
>
> To enable the interrupt the controller sends to tell it's finished
> sending the STOP condition, it's the ien register at bit 5.
>
> Let's use the proper offset.
>
> My hunch is that enabling the interrupt is useless as the interrupt
> status register is always up-to-date and enabling the interrupt is just
> so that the interrupt is available via the GIC. However, U-Boot has no
> interrupt support and the logic was working well before this patch. This
> is just so people aren't side-tracked when debugging I2C issues on
> Rockchip by checking all writes are proper.
>
> Fixes: 3437469985df ("rockchip: Add I2C driver")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Rockchip vendor U-Boot has  the same fixes.


Reviewed-by: Kever Yang <kever.yang@rock-chips.com>


Thanks,
- Kever
> ---
>   drivers/i2c/rk_i2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/rk_i2c.c b/drivers/i2c/rk_i2c.c
> index fa167268ae7..fe09e75d3fb 100644
> --- a/drivers/i2c/rk_i2c.c
> +++ b/drivers/i2c/rk_i2c.c
> @@ -137,7 +137,7 @@ static int rk_i2c_send_stop_bit(struct rk_i2c *i2c)
>   	writel(I2C_IPD_ALL_CLEAN, &regs->ipd);
>   
>   	writel(I2C_CON_EN | I2C_CON_STOP, &regs->con);
> -	writel(I2C_CON_STOP, &regs->ien);
> +	writel(I2C_STOPIEN, &regs->ien);
>   
>   	start = get_timer(0);
>   	while (1) {
>
