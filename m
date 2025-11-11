Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4EACCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 14:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F06A983F8E;
	Tue, 11 Nov 2025 15:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kE1bu2x8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E07D83F91; Tue, 11 Nov 2025 15:07:21 +0100 (CET)
Received: from mail-m3270.qiye.163.com (mail-m3270.qiye.163.com
 [220.197.32.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A32B83F8A
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 15:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.234])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2934dfe46;
 Tue, 11 Nov 2025 22:07:15 +0800 (GMT+08:00)
Message-ID: <87e6d30f-08ca-4e8c-8486-64e606d6f506@rock-chips.com>
Date: Tue, 11 Nov 2025 22:07:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: i2c: move ACK comment where it applies
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Wadim Egorov <w.egorov@phytec.de>, Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20251107-rk-i2c-illegal-v1-0-3e5fea13a899@cherry.de>
 <20251107-rk-i2c-illegal-v1-2-3e5fea13a899@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251107-rk-i2c-illegal-v1-2-3e5fea13a899@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a733e052f03afkunmff0f563d343b7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCT0hNVh1NS09NQxgYGhgaGVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSUhPWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=kE1bu2x8lsp8bEydJJ61/4jqv6Mkj4kyXakuRAJdZlNNR9I6u5vM7pEFO6cnyYxT6hCa8jw/LNAUQ4hT7Izm+tAZpiOIgjbAa7qaHd232zrKEp18eT8nGvU533p+qrIvPm0xICeLcTsuuW2KzyVg4vgELITexJvHmW7qhYk3oRI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=a5F/HJ5fwzl2+uV2K5AybNdSEwm+k7qrQ6MfOn7BOr4=;
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
> The I2C_CON_LASTACK is kind of a misnomer as setting it means sending a
> NACK as last byte acknowledge when the controller is in receive mode. It
> should therefore be used only when there's no more data to transfer
> after this.
>
> Move the comment in the proper if block.
>
> Sync the comment with the Linux kernel's while at it so it's more
> explicit.
>
> Fixes: 5deaa530280f ("rockchip: i2c: fix >32 byte reads")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/i2c/rk_i2c.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/rk_i2c.c b/drivers/i2c/rk_i2c.c
> index fe09e75d3fb..3c44d0e65f5 100644
> --- a/drivers/i2c/rk_i2c.c
> +++ b/drivers/i2c/rk_i2c.c
> @@ -195,13 +195,14 @@ static int rk_i2c_read(struct rk_i2c *i2c, uchar chip, uint reg, uint r_len,
>   
>   	while (bytes_remain_len) {
>   		if (bytes_remain_len > RK_I2C_FIFO_SIZE) {
> +			/*
> +			 * The hw can read up to 32 bytes at a time. If we need
> +			 * more than one chunk, send an ACK after the last byte
> +			 * of the current chunk.
> +			 */
>   			con = I2C_CON_EN;
>   			bytes_xferred = 32;
>   		} else {
> -			/*
> -			 * The hw can read up to 32 bytes at a time. If we need
> -			 * more than one chunk, send an ACK after the last byte.
> -			 */
>   			con = I2C_CON_EN | I2C_CON_LASTACK;
>   			bytes_xferred = bytes_remain_len;
>   		}
>
