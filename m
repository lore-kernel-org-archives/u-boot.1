Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9EACA0EDB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 18:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB1A38312A;
	Tue, 12 Aug 2025 20:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lHzhlTSb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF3A82F03; Tue, 12 Aug 2025 19:50:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE0CA82EB8
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 19:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9bb8=2Z=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1755021009;
 bh=xrY/F6fH/+w9qNXXh5dE2nOoly906LIgJ19qxdBEIFM=;
 b=lHzhlTSbJYr9etEECyJGuKaYRE+pT2APQHtkrGHcd9l8IeXXDjgZ05Qa+9V5e1mDj1p6MeXH2
 6wShK+C92Ra0nmt7cbt2J44ZIKiQvCFoSUF4mgXuwo3g0fad8D01wz1N53c6oAihJHnMNugYjo1
 eP9/6TKhQ0IcB8k4oHv3lt55/fvVIt0FrzViRNhjrPq1FtGIm75VW/iNl/vaP700wKI5rfA4uxb
 kxGATisPAItakNAUxvFV/oQqINxWOxK4RbqpQJxwim+HSnpQdenM93xkJMevwlT8om1qo9QqlAT
 7UgP4StXI9b520+ZRLBmKUBnDA9Myse9EjbEEuUYY0vg==
X-Forward-Email-ID: 689b7ec4f092412ac2632004
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9f234367-9ee0-4656-a222-d1c461a49c3d@kwiboo.se>
Date: Tue, 12 Aug 2025 19:49:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] mmc: rockchip: fix clock get wrong index
To: WeiHao Li <cn.liweihao@gmail.com>
Cc: u-boot@lists.denx.de, antonio.borneo@foss.st.com, mk7.kang@samsung.com,
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za,
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com,
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org,
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com,
 jerome.forissier@linaro.org, quentin.schulz@cherry.de,
 andrew.goodbody@linaro.org, sumit.garg@kernel.org, ag.dev.uboot@gmail.com,
 rfried.dev@gmail.com, joe.hershberger@ni.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, seanga2@gmail.com, lukma@denx.de,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 trini@konsulko.com, WeiHao Li <ieiao@outlook.com>
References: <20250807074419.336752-1-cn.liweihao@gmail.com>
 <20250807074419.336752-3-cn.liweihao@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250807074419.336752-3-cn.liweihao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 12 Aug 2025 20:04:30 +0200
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

Hi,

On 8/7/2025 9:44 AM, WeiHao Li wrote:
> Signed-off-by: WeiHao Li <ieiao@outlook.com>
> ---
>  drivers/mmc/rockchip_dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
> index 7a72abaa38..a3f001d7e7 100644
> --- a/drivers/mmc/rockchip_dw_mmc.c
> +++ b/drivers/mmc/rockchip_dw_mmc.c
> @@ -132,7 +132,7 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
>  
>  	ret = clk_get_by_phandle(dev, &dtplat->clocks[1], &priv->clk);
>  #else
> -	ret = clk_get_by_index(dev, 1, &priv->clk);
> +	ret = clk_get_by_index(dev, 0, &priv->clk);

Index 1 is the ciu clk and matches the linux driver and u-boot driver
usage of the clock.

Please explain why you think this should use index 0?

Could it be the device tree that is using "wrong" clock order?,
the dt-binding define following order: biu, ciu, ciu-drive, ciu-sample.

Or possible an issue in the rk3368 u-boot clk driver?

Also if this is wrong then &dtplat->clocks[1] should also be changed.

Regards,
Jonas

>  #endif
>  	if (ret < 0 && ret != -ENOSYS)
>  		return log_msg_ret("clk", ret);

