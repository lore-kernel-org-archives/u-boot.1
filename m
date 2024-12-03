Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B071AE7716A
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 01:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E293E89427;
	Wed,  4 Dec 2024 02:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733276653;
	bh=1MCyKAQuW5dNvn2tAeTqEiAPjgY+iXAjEt3j235H1I4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QwCg95pDjtATfMjfAn5zgrrPGgkWuEV5HwKj3lH4ykXzlEV7i87YCEEJer3F8CLlD
	 sEJCslyCHZhAh1XUec/MkCyeRB41ha5uhOvxjIr5laj7j4D0x8ML9fACjhIoyWDGIn
	 0WRFJKHhLqOWkWr/5tDb7cBjxegVkkA6EBCbcwzPdcIhEHHIf/mziLP3cIsJRjrDTb
	 CKhVW0hsJS/pnE++WJdj+AmEWcBJnE2kR+n7X8qkwAFzllWIExo69xJwle8C6neA4F
	 I9beUO6EZjvmCq7W+NhY/W6ko6yZ9OqUUN25KjdHG2wtHq3/VAgcV4as7TwXdT8VYK
	 L8HHfmCpu0lLw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3E6DF88F55;
 Wed,  4 Dec 2024 02:44:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1733276652;
 bh=1MCyKAQuW5dNvn2tAeTqEiAPjgY+iXAjEt3j235H1I4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=phdIwG0GjiWnQERC5Eu2a14xgikfg+EQiQlxfOMD75Uf6zvKGkq8KIQpJ2WIJ2dir
 SWbKAgw6H9abAQeZfADQUZ28pZnuKg0sj59hmQMngRVq6FHQSHd3V5DDTeIJV1yZtA
 sL/P+Ni/gNJVrfAv26qEV0nMhU9qHyCdD5vIQhBjSWZe4AYZSTv/Xc2/e5Qsgqe320
 TTpJhEXQJT56aq+uhE8BnblWS7cJcS6OY4/jPORn+0Oj44QHv7jkHmWvPjIV6jHES7
 oNkmbvs5+LIn3NoFZSPkPPrn62e4Dwq+WFTq2oOPJPQjSw0GMTzs/PUGE4IzXLZaND
 52P7nJWgGTARQ==
Message-ID: <ea18dd21-1251-455e-8456-09098414c1dd@denx.de>
Date: Wed, 4 Dec 2024 00:37:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dwmac_socfpga: Add RGMII-ID support
To: Rufus Segar <rhs@riseup.net>, u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, Rufus Segar <rufuss@carallon.com>,
 Rufus Segar <rufus.segar@carallon.com>
References: <20241203233006.42764-1-rhs@riseup.net>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241203233006.42764-1-rhs@riseup.net>
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

On 12/4/24 12:30 AM, Rufus Segar wrote:
> From: Rufus Segar <rufuss@carallon.com>
> 
> This patch adds support for the "rgmii-id", "rgmii-rxid", and
> "rgmii-txid" modes for the dwmac_socfpga driver.
> 
> Signed-off-by: Rufus Segar <rufus.segar@carallon.com>
> ---
>   drivers/net/dwmac_socfpga.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
> index bba3fc4d34..dcaf4132c5 100644
> --- a/drivers/net/dwmac_socfpga.c
> +++ b/drivers/net/dwmac_socfpga.c
> @@ -106,6 +106,9 @@ static int dwmac_socfpga_probe(struct udevice *dev)
>   		modereg = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RMII;
>   		break;
>   	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
>   		modereg = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RGMII;
>   		break;
>   	default:

$ git log --oneline --no-merges drivers/net/dwmac_socfpga.c

indicates the subject prefix should be 'net: designware: socfpga: Add 
RGMII-ID support' . With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
