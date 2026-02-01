Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429B1E65298
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 18:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72E2B83B86;
	Sun,  1 Feb 2026 19:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QkxFg83H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 570CB83BDD; Sun,  1 Feb 2026 19:36:25 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 671E983B03
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 19:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f3z3S6KKJz9tV1;
 Sun,  1 Feb 2026 19:36:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769970980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2mKAPvbR0AzPR7uKYTnQU5EAKc3Nmo/w+fol14pGAM=;
 b=QkxFg83HFfWIzD+NSUw+53zRic/9w0KRkD99e3tm/HBxVO/DAkCxlhJ1i2jZJHiCCgk0wb
 ZJbYqs02x4IeEgvWav/tdDPvDXbyYIcciA2KuGFBhhthF6WaRkEhWgPf0pxP2KnTpgiPKo
 K/DKz2zLaYE+2ZVWPu59Q46CULraLqP+PvM2OKdncFCRjcALAPeTuci76s3v1tVWFjKlER
 tcb9/ZTaYppL28LeLAQKckjROq0JGrNJYP9MFHoRFXyF6+hhziGw+dj57SLEWLlAQUP9F3
 iyl9aIKTy0eOE8+wMvGuZxQ/P7MM1Da89W48v+KVnQvj5TlPI5OLAZEEXb7LLQ==
Message-ID: <c0c59409-95e4-46a2-ab19-06bd150cdec0@mailbox.org>
Date: Sun, 1 Feb 2026 19:18:04 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/2] usb: musb-new: Relative ctrl_mod address parsing
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>
References: <20260130-topic-musb-probing-v2026-01-v5-0-195b23c7948f@baylibre.com>
 <20260130-topic-musb-probing-v2026-01-v5-1-195b23c7948f@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260130-topic-musb-probing-v2026-01-v5-1-195b23c7948f@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: aa7bb1c4c4fd91e4ff9
X-MBO-RS-META: 338p63bqi7ht31y5sb1t7qicb51thwzk
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

On 1/30/26 5:28 PM, Markus Schneider-Pargmann (TI.com) wrote:
> For the upstream DT the ctrl_mod node is using a relative register
> address which is not translated by the current code.
> 
> Make address parsing understand relative addresses.
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   drivers/usb/musb-new/ti-musb.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
> index bcd31adba522fc55190fc43fd2dbd2dec93a2731..75dc2dc18748e33785c7312a24145544b659579d 100644
> --- a/drivers/usb/musb-new/ti-musb.c
> +++ b/drivers/usb/musb-new/ti-musb.c
> @@ -83,17 +83,17 @@ static int ti_musb_of_to_plat(struct udevice *dev)
>   	struct ti_musb_plat *plat = dev_get_plat(dev);
>   	const void *fdt = gd->fdt_blob;
>   	int node = dev_of_offset(dev);
> -	int phys;
> -	int ctrl_mod;
> +	ofnode phys_node;
> +	ofnode ctrl_mod_node;
>   	int usb_index;
>   	int ret;
>   	struct musb_hdrc_config *musb_config;
>   
>   	plat->base = devfdt_get_addr_index_ptr(dev, 1);
>   
> -	phys = fdtdec_lookup_phandle(fdt, node, "phys");
> -	ctrl_mod = fdtdec_lookup_phandle(fdt, phys, "ti,ctrl_mod");
> -	plat->ctrl_mod_base = (void *)fdtdec_get_addr(fdt, ctrl_mod, "reg");
> +	phys_node = ofnode_get_by_phandle(dev_read_u32_default(dev, "phys", 0));
> +	ctrl_mod_node = ofnode_get_by_phandle(ofnode_read_u32_default(phys_node, "ti,ctrl_mod", 0));
> +	plat->ctrl_mod_base = (void *)ofnode_get_addr(ctrl_mod_node);
Is the cast to void * necessary , and if yes, can it be removed ?
