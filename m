Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727D4C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC0D88826;
	Wed, 24 Jul 2024 12:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721818620;
	bh=/s7KkX46ihE+Tel3MjkYu1BIn2RhM2MKPOHWM88rOMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UMoBgLiejS8WjXB17u3JQFhDPFcJu+VoX6NLzSgau8Xwdz7f/zOjOSBISoFQFsFOC
	 13D7gv+ImjFUUX4+paQR4kzWpcdLaqwwADNv/2aXsNEfMTG0ovQhigGWOON8tfaAFJ
	 7Jb4eR0L8aToaWbF9BjmZIXRwHQ3vFDGi9BiwU7dgbW0OjFJVqlxU2y7Qpz+O6qNtj
	 ux5Dr/NFEp4Gwl1UeqJYulvrgqUaUUfHiCuDJSsX6uALOM13fEgaCZhiH797KK4B9b
	 1ZqZTLHJoZ7L+PvCNkC3fZIGn1TLPgFOGU2PdK/HSkm0gvCKZ713xw58LgFcC6drWe
	 nxfnzEJR6jO5Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 40CAB88826;
 Wed, 24 Jul 2024 12:56:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721818619;
 bh=/s7KkX46ihE+Tel3MjkYu1BIn2RhM2MKPOHWM88rOMM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eDmT6qOtD3T/Lbvc6NzBPpBJX9lRJaPE1SsfPTlfluERjRoKeRzoxY0419bRlYfnQ
 zBzbfpvx+HjGNbK5/3UwumtpdDULPCa35r2u6n7OTjltc2AiF8Jm+Y1/5vCnASUNHs
 Egog++72rYSVjL0b8OF6snid0NBGdz6KQE9ClJsB95IDGjQjGU1dKDQ1rNPNkmRknQ
 JZUbotrcYeBoN0hORj6ze/4gdIWqQSQHDS2/83Y0RlEZq4GdnOWoirQfue07pMqdtn
 7J/jaXTSPhSJAVkWNUSGcu6QpOC0rVCBWDkuiMNdAwMM8SRD/5SXNyKcMjf/W2Mfuf
 Z7S1KNW05nneA==
Message-ID: <02d82a41-c336-4689-a340-f5c8658d1614@denx.de>
Date: Wed, 24 Jul 2024 12:04:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] i2c: imx_lpi2c: Fix a typo in bus_i2c_receive
To: fedorross@gmail.com, u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20240724095943.214967-1-fedor.ross@ifm.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240724095943.214967-1-fedor.ross@ifm.com>
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

On 7/24/24 11:59 AM, fedorross@gmail.com wrote:
> From: Fedor Ross <fedor.ross@ifm.com>
> 
> Fix a typo in a debug message. It should be 'for' not 'fot' .
> 
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>

Please add '---' here for V2, so the CC list does not get included in 
commit message when the patch is applied.

> Cc: Heiko Schocher <hs@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Marek Vasut <marex@denx.de>
> ---
>   drivers/i2c/imx_lpi2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
> index a1be841b119..3c43f61d819 100644
> --- a/drivers/i2c/imx_lpi2c.c
> +++ b/drivers/i2c/imx_lpi2c.c
> @@ -130,7 +130,7 @@ static int bus_i2c_receive(struct udevice *bus, u8 *rxbuf, int len)
>   
>   	result = bus_i2c_wait_for_tx_ready(regs);
>   	if (result) {
> -		debug("i2c: receive wait fot tx ready: %d\n", result);
> +		debug("i2c: receive wait for tx ready: %d\n", result);

Reviewed-by: Marek Vasut <marex@denx.de>
