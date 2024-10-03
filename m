Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D081CF34AD
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 20:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B7C88E65;
	Thu,  3 Oct 2024 22:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727988439;
	bh=R3EoSUfwWedaSG7mJJUo2fsbePij7CDEZN6mG2jyWh4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AU350SDioXQ6S1NrVmJqAL2Seom3vuaN4KDPrMZKC/e4aoG5zTsPCGqXfiRVQysLO
	 imwkvj8p0JBwXkjXbzGRDiOemMNacoXbDXPZ9TeosFQZlk2HrCY9+AWh1BK6JRGaIJ
	 d/JCfF7SHpP5RYpnrJJRk3P9KHhvQMesjpw8HXO0HCvQw4zJol2Hmb80NfQHI6UZO3
	 20+oK2esWDXRsFVvrpErMLNIMwMEFajnmEXt3UvLmZ3urXfwNOYgi1oci4S1UCpIZq
	 u4n9XptoZgf8VWlYhFC7JtZcS1XdiTRMJL9gki9vxEhIUt3vc/26lwQPYlUqX7U4kO
	 WJG90O/fz6n1w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 27B3988DB2;
 Thu,  3 Oct 2024 22:47:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727988438;
 bh=R3EoSUfwWedaSG7mJJUo2fsbePij7CDEZN6mG2jyWh4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sFh2ods//4OfG7nxsw+wor2Zqjhps7jvJLLxWAugwJw7PXCW/2xxJWF+QalCK3oPr
 6LXdtGjwd8l7AyF/iC/ce0LRkQcaOSQ8mrvT1v+gl1N58Ozxk3bLEZZALBxtSeTe0b
 kYo+lVBLG+AcTrPWrm+A17eIFoNjmtU8nLi+803P8T/UECVYFahqWh01h+9Oi/on4Y
 6VlquEsAbpyiWt4fKNQapaz0eRSgGQ4+DlzdbgjjooarIhBKacS2LAALLSUl0GfQb8
 wuXKQn+rh1ImhW3WdoXqTJTbHiF7ANyvZ6yGE1SLB/9uqFdYGJOHUi78dds2cxicU2
 IacinhXrc1XhQ==
Message-ID: <80e7d47f-335d-4c81-ac7c-3af531474e50@denx.de>
Date: Thu, 3 Oct 2024 22:47:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sandbox: i2c: Make sure phandle dependency is probed
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241003203736.298649-1-marex@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241003203736.298649-1-marex@denx.de>
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

On 10/3/24 10:37 PM, Marek Vasut wrote:
> This driver depends on i2c emulator via DT phandle. Make sure the
> dependency is probed before this driver is probed, not when it is
> first used during transfer. This fixes the following i2c_emul_find()
> error:
> 
> "
> $ ./u-boot -Dc ""
> ...
>         i2c_emul_find() No emulators for device 'sandbox_pmic'
>    sandbox_pmic_write() write error to device: 0000000018c568d0 register: 0x0!
>         out_set_value() PMIC write failed: -5
>         i2c_emul_find() No emulators for device 'sandbox_pmic'
>    sandbox_pmic_write() write error to device: 0000000018c568d0 register: 0x0!
>         out_set_value() PMIC write failed: -5
> ...
> "
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/i2c/sandbox_i2c.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/i2c/sandbox_i2c.c b/drivers/i2c/sandbox_i2c.c
> index 74bb5e93397..9a39ac14fb4 100644
> --- a/drivers/i2c/sandbox_i2c.c
> +++ b/drivers/i2c/sandbox_i2c.c
> @@ -80,6 +80,14 @@ static int sandbox_i2c_xfer(struct udevice *bus, struct i2c_msg *msg,
>   	return ops->xfer(emul, msg, nmsgs);
>   }
>   
> +static int sandbox_i2c_probe(struct udevice *dev)
> +{
> +	struct udevice *emul;
> +
> +	return uclass_get_device_by_phandle(UCLASS_I2C_EMUL, dev,
> +					    "sandbox,emul", &emul);
> +}
Hmmm, no, this does not do it, but it does show what the issue is -- 
sandbox_i2c_xfer is misused to defer access to this emulator until the 
first I2C transfer, so the emulator can hopefully probe in the meantime. 
This is fragile and now it broke. What I am not quite sure about is why 
this uclass_get_device_by_phandle() returns -2 here instead of probing 
the emulator ?
