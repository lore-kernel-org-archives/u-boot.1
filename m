Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF36D35664
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 01:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1ADE84239;
	Wed, 28 Jan 2026 02:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bzkRFJED";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F16AB84246; Wed, 28 Jan 2026 02:02:57 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6753684238
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 02:02:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f13sn2l4kz9txg;
 Wed, 28 Jan 2026 02:02:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769562173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+elh9DfpUq0lGUzSKFlx4dTCeYtp1NabuVDUZ90Lzs=;
 b=bzkRFJEDMlnn52WBXsVmwFuppgm/7q2cXoHMBBQbSCwPZ5elEp2jcwY1McFvNhIGEfNv54
 awCLgIGcXi4myRCDOotiJvaht5GtNObhl92qyq5REE7x2dkIb6O4zRnO7BWhiT4/TwCHjt
 eDtQnU11lm97pSu1FEYm0uBxB2RjahdTGOucTDU8xLUKR3P124DQjDSF3CZ5DWJIO1+axu
 7qHRXKNW0HMGEgnBC++ccaCc0BpodfvGKiDuX/wdlAZ+XhuEcue8wbbxHW+PG1ocAyCwce
 LUTp4pf6EM+4yVdMymHBgTg1rSUNbNX+3jW90+4wYNbvvRvrdpN4bFqzpSdfGg==
Message-ID: <36f1173e-0549-4d38-90ef-4a9a942f0a49@mailbox.org>
Date: Tue, 27 Jan 2026 22:15:57 +0100
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH v4 6/7] usb: musb-new: Relative ctrl_mod address parsing
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher
 <hs@nabladev.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
 <20260127-topic-musb-probing-v2026-01-v4-6-ea3201e0f809@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260127-topic-musb-probing-v2026-01-v4-6-ea3201e0f809@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5f5a11c20ec360aa69d
X-MBO-RS-META: wuijcj15oo5xkqpen8wx9r8iztd7mm93
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

On 1/27/26 12:03 PM, Markus Schneider-Pargmann (TI.com) wrote:
> For the upstream DT the ctrl_mod node is using a relative register
> address which is not translated by the current code.
> 
> Make address parsing understand relative addresses.
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   drivers/usb/musb-new/ti-musb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
> index bcd31adba522fc55190fc43fd2dbd2dec93a2731..d3c3d3057c1df2a5cc62df3c57d8b071bb0f12b8 100644
> --- a/drivers/usb/musb-new/ti-musb.c
> +++ b/drivers/usb/musb-new/ti-musb.c
> @@ -93,7 +93,7 @@ static int ti_musb_of_to_plat(struct udevice *dev)
>   
>   	phys = fdtdec_lookup_phandle(fdt, node, "phys");
>   	ctrl_mod = fdtdec_lookup_phandle(fdt, phys, "ti,ctrl_mod");
> -	plat->ctrl_mod_base = (void *)fdtdec_get_addr(fdt, ctrl_mod, "reg");
> +	plat->ctrl_mod_base = (void *)ofnode_get_addr(offset_to_ofnode(ctrl_mod));
Can you please also clean up the other two fdtdec_* calls above while 
you're at it ? Thanks
