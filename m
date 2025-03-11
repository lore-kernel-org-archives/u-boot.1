Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49997C28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 05:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81675806D8;
	Tue, 11 Mar 2025 06:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741671017;
	bh=zHD9pNwdUQDVWoAkTw5Bep7wVeN+FUSY3bAa9Z8ygbE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=EUhQskuYDExgmwTCWMAWFEoRDhW+nPmDfTIoVyiEA3xmmT1JsK+wlAlYdTQHDRJRn
	 uuKcyFTRZkG7N1BQTfA8hMkvtO8yV3/E/QnmvPtwjweTURJqhk+qCR8VwJA7SHQ2VS
	 c6vWpJYEeXznCgE8jSTjfGJVSW9YS7YVizFXsG+A76YdhSsrcky4c9HCbLcXFSGtFL
	 8o3v8tRWRP8K7R4+w5B53L5UMy1kx+angaR04jqE+X5CPEH7sHFP0Urt/dVJE+pQA4
	 O/LBtnTwZAlqA0HYNc6zqz2SJ+JzMhtiMED9hO7iGaQciPHgdlDvtCZjwqvcibrcC9
	 B/+Y3Cb4kac4g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B307807D7; Tue, 11 Mar 2025 06:30:16 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB6D6800C1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 06:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="WQ6RsFVM"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 86A491020CACD; Tue, 11 Mar 2025 06:30:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741671012;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=zHD9pNwdUQDVWoAkTw5Bep7wVeN+FUSY3bAa9Z8ygbE=;
 b=WQ6RsFVMTbx/O8S06tqbDakmFJdwHGQ5AfX0R9MER3HyZGBT8i6y1mTivZ5DNxSlclVyQk
 oZbsHT5/955RaRgA8WdSab1MxQP0EOCPOnT205Uy1I5CQ1mEb4oQpjR4ag/bigAVeTc83p
 7hAboUFRDcRkpCgZ4yAKnPv+H/v5KZUZ6b/9amdexjiKEa4WwgHR+ZT7J1ZJGMZd4TI4xL
 ccz4OYW1EVfDZcj4Bu6UXdnLxnF2sRg6UFX14le749+8IIOmC/or8sWtfv0RvBtvdDBM6C
 vE+PaQiI9DpZLDWfrfU0gbG8bv9lBdnWPNBZbgqM8VlfZ95LO1SFa87E3sDUag==
Message-ID: <a0eff724-032a-9499-8302-badb44eaef46@denx.de>
Date: Tue, 11 Mar 2025 06:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/4] i2c: omap24xx_i2c: support CONFIG for repeated
 start in DM_I2C xfer
Content-Language: en-US
To: Aniket Limaye <a-limaye@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 virag.david003@gmail.com, stefan.agner@toradex.com, w.egorov@phytec.de,
 j-keerthy@ti.com, u-kumar1@ti.com
References: <20250310103702.1464782-1-a-limaye@ti.com>
 <20250310103702.1464782-4-a-limaye@ti.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250310103702.1464782-4-a-limaye@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Aniket,

On 10.03.25 11:36, Aniket Limaye wrote:
> Repeated Start Condition (Sr) can be used to transfer multiple i2c msgs
> without sending a Stop condition (P). So far, the driver default was to
> always send a Stop condition after every i2c msg.
> 
> Add support for a config option (CONFIG_SYS_I2C_OMAP24XX_REPEATED_START)
> to disable sending the Stop condition by default. If this config is
> enabled, Stop condition will be sent only if explicitly requested in the
> msg flags OR if it is the last msg in the transfer.
> 
> Consequently, handle the Repeated Start condition (Sr) in the next msg
> by not calling the wait_for_bb() check since it will simply timeout in
> the absence of a stop condition (BB will be 1 until Stop is programmed)
> 
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
> 
> v2:
> - fixup code formatting and comment blocks
> - CONFIG_I2C_REPEATED_START -> CONFIG_SYS_I2C_OMAP24XX_REPEATED_START
> - Link to v1: https://lore.kernel.org/u-boot/20250304220546.866602-3-a-limaye@ti.com/
> 
> ---
>   drivers/i2c/omap24xx_i2c.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)


Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
