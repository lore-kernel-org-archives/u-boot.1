Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6781EECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 10:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9074989032;
	Tue, 10 Sep 2024 12:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725965689;
	bh=ef0gc9ak2gAAxjw4CvysSksi0cmplrEknIh3JKcAVcI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GD7jvnXjbkQnV/doSfxCEYZuOrMBPak3m3ebW4m5HFQvaIEAWMkL50v2p2JeSjKGI
	 UbtMXr3vYZPkusSwLD7Nq3IzbAYHcJnC+PiwkH3YZLAPTmnFumEBZlfUf1Fc1J+iIH
	 PGvT1SV8lQGANG7NeyHWZQzW05ECO126uAzmV1ZKwqKvZfexKOMeU14t8bH6woEY8d
	 WNBonNUjcRYeHNZFLhI4peHWbGX9JuzrAWSpN7AGd4yZwQG7hwI5tgOVqrBRZcs5lu
	 eq8V3buuUnPbIY1AuiydboGi+AEQcFQIijYEhvqs8D7ERYihVBz4uiM2TbCHmL59u5
	 38h/Bt8Xw/DxA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9075288F50;
 Tue, 10 Sep 2024 12:54:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725965688;
 bh=ef0gc9ak2gAAxjw4CvysSksi0cmplrEknIh3JKcAVcI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=xlrfGcpt0u+WDoCXxmrlNFo5RCzfbYzIFr7FWqPcjR0G2226Lxa7sInNm3SLrD9DN
 w5fdYoQNfv3vN979PlM/ViDURqXvZ7WcRgsSWnHHWSoiWr/5gzYtmfmQmjeeokqyKO
 SB/1joQPGkPGxqoToRV5/OSquObGDC7hSwXvpt4smazQdmSFzC2sfRTzf3zsdwaOfW
 lYoqubJ5dHxXBhM51MXv2qWQeXK4zYd3lLPgLz4nDL1m8TrbjYzWtLds7/YiNybN2z
 HVO30pH/P8SFkPPBbZuhb2EDkEb7QD/d7njl41Z+rJKUhidiBYiJjxhpFBK4c0hFDP
 82SdgV+pLFlcw==
Message-ID: <da054716-c475-4bd7-9980-625ee478c2d2@denx.de>
Date: Tue, 10 Sep 2024 12:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dfu: fix Kconfig dependencies
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <20240910102751.3182982-1-jerome.forissier@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240910102751.3182982-1-jerome.forissier@linaro.org>
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

On 9/10/24 12:27 PM, Jerome Forissier wrote:
> Fix link errors caused by missing Kconfig dependencies:
> 
> 1. DFU_OVER_USB compiles common/dfu.c which calls g_dnl_clear_detach()
> which is implemented in drivers/usb/gadget/g_dnl.c which needs
> USB_GADGET_DOWNLOAD. Test case:
> 
>   $ printf "CONFIG_USB_GADGET_DOWNLOAD=n\nCONFIG_USB_FUNCTION_FASTBOOT=n" \
>         >>configs/am62px_evm_a53_defconfig
>   $ make am62px_evm_a53_defconfig
>   $ make CROSS_COMPILE=aarch64-linux-gnu-
>   [...]
>   common/dfu.c:34:(.text.run_usb_dnl_gadget+0x68): undefined reference to `g_dnl_clear_detach
>   [...]
> 
> 2. With the above fixed, the same build causes:
> 
>   common/spl/spl_dfu.c:29:(.text.spl_dfu_cmd+0xb0): undefined reference to `run_usb_dnl_gadget'
> 
> This is because SPL_DFU compiles common/spl/spl_dfu.c which calls
> run_usb_dnl_gadget() which is implemented in common/dfu.c which needs
> DFU_OVER_USB.
> 
> Therefore add these dependencies to Kconfig.
Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
