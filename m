Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1894CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 13:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D7B84CBB;
	Fri,  8 May 2026 15:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JfVA7CDz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QVbj6CuC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9168584CD0; Fri,  8 May 2026 15:56:20 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB85284CB5
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 15:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBrJ16hKzz9thT;
 Fri,  8 May 2026 15:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778248577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iapstlb3bfPsCjm7dy33pRpAI+EgySWl9cMsQoBqm3Y=;
 b=JfVA7CDzWvWDB6y8g1fYD7F39LWrLe4i6GNB1IpagChqGS4rHuG0ZqM5oeBuToQUYq5vlY
 Pt/XeQpHxfLiqN2SwHU4NCWF0TzwkQH/Ddyd5otAz7moB/w3UhgpdREftFaEiq0RPS+PZN
 MNZAVOMHFUmRgePMvtHaXlX3OvzOFjEEy6TJ7bShvkLoWeD4e9B5uYsk9Ux8rDhIsyjW1e
 H9CHjl40FF0NUSGSvo5w/9yQv5DiIVQgukZLM1vGAuPHpA8RBZiEzD/o6q+eeb8VrLwyKq
 wfzEVlIObOstcs5tOuVosEpPtdPm6XU7pSFrTfok/rjtcDYRY9XUgU4T0YiVfA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=QVbj6CuC;
 spf=pass (outgoing_mbo_mout: domain of stefan.roese@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=stefan.roese@mailbox.org
Message-ID: <93f60758-d5b7-4dbe-a55e-bf564507f37a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778248576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iapstlb3bfPsCjm7dy33pRpAI+EgySWl9cMsQoBqm3Y=;
 b=QVbj6CuCJd85IZcleieKPLJsgz4GgC6WN8/uqEPVbsBNvexvd8kCMGnngtnnKGmiIHTT6U
 PzkbQHVtWNbXCe8Rgn/3X2/ZxXI+WeAU8+pW1bU0faiAxs1AbIrtEyoN7fRairHLWMvVlL
 qsFw3tz+rU30JUDJB1VeqywcJvf6xhZGl6xEut9aMB2aDXrthTwOcehlY1ReIfKUjb8l7X
 HfXI7EIuzy3+C/shNwDgo0Muxj3LwSXIOYEdAkZotwBPq1Ok19rI8/sBRPGbto+YQbFavh
 hpTXQ/pzoXvjLdRiFUe/z+zYHy5yYMy8LPfmvYAFzBZkIuoFShlHmyHfQ8yOTg==
Date: Fri, 8 May 2026 15:56:14 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] pinctrl: armada-38x: Staticize and constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20260508122201.512840-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260508122201.512840-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3483592cd7ca9a3c62d
X-MBO-RS-META: bfnwkt45fkh9kgph6km3sqz1dxiedwnx
X-Rspamd-Queue-Id: 4gBrJ16hKzz9thT
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

On 5/8/26 14:21, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Stefan Roese <stefan.roese@mailbox.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/pinctrl/mvebu/pinctrl-armada-38x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
> index 78184d2860a..c18afe958dc 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
> @@ -550,7 +550,7 @@ static int armada_38x_pinctrl_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> -struct pinctrl_ops armada_37xx_pinctrl_ops = {
> +static const struct pinctrl_ops armada_37xx_pinctrl_ops = {
>   	.get_pins_count = armada_38x_pinctrl_get_pins_count,
>   	.get_pin_name = armada_38x_pinctrl_get_pin_name,
>   	.get_functions_count = armada_38x_pinctrl_get_functions_count,

