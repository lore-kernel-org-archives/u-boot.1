Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56F6CD5BBF
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 10:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 123FA83DBD;
	Thu, 13 Nov 2025 11:35:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pUJjRDRb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eDUkX5c8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42E0383DCB; Thu, 13 Nov 2025 11:35:05 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC0783D77
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d6c925C16z9tYQ;
 Thu, 13 Nov 2025 11:35:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763030102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ihQkGCyjJ+lUNC35Zu9n6oFWWLBIPriB0icrOz5UWOo=;
 b=pUJjRDRbQ8wP7LfYG3wFpJrTMNwrG4/i22l9Ofb/m1L0WqOSWBC1o+aX2aNZA7Fim9/LTZ
 yNQuG3MjU0zRa07XoASX8WYWGuXZKKWkL5N/LHV5pdB0/APw5An2PlV9T/FpK6SUna1ICu
 nkvUvaPP/iEjWpeNCfaiALxClvILGsyziMP8JFPfR+yJnjE6qKll64po3+a5qVD92Wc8g0
 5knCuw6nzk/gYxzu1xGSlECviBR2P5LK3Wb1RXSyR/4TNXUdP0PgEQpl+0iH3zeOPQ9gsN
 4OWa22JIdJLHnmMNICJo1+MsZVLwps7VbWbk8gqefoo03WEdRhGz8rCDk9dphQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=eDUkX5c8;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <e9e45a91-7b28-41b2-8c34-b9cdac169137@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763030100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ihQkGCyjJ+lUNC35Zu9n6oFWWLBIPriB0icrOz5UWOo=;
 b=eDUkX5c8Q/cel9M3NBtMvl4/LYSe96d8Y3O7y26D6h/2tBefQ5483MkpTYyypw8EV5pYW/
 B9A0r32eI3SgpjMj55/dXbURtOmk6bWhvygSyNW4Trwz4T4U9NnhgAE8K+gJNPMvVOgehg
 RndzkMag/9cQy906UahEtRGs2/Vvhkdvo5x4vPljie2/AtbQMAbU7EOb1wqV2VBWQc+2gq
 UEh8F/iSIRoERTN1YOEUZSAkvlF27XJ0OQLztsZI3SlzJsrHdggPxvxm6XSjrp4kBVUOKc
 UjUgUxtuLw36tHnZ1iUtgbHCRts9GUSqHuV8mxvyRv06Zg63US2nRHng1hoi1A==
Date: Thu, 13 Nov 2025 11:34:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] ufs: rcar-gen5: Use a unique U_BOOT_DRIVER name
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20251112211841.1428696-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251112211841.1428696-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0e37a85e1b90b2129ac
X-MBO-RS-META: o3jao6c48uksfu6wubczbo5d5fqe8amz
X-Rspamd-Queue-Id: 4d6c925C16z9tYQ
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

On 11/12/25 10:18 PM, Tom Rini wrote:
> All instances of U_BOOT_DRIVER must be unique or we will have link time
> failures. It is possible to enable both ufs-renesas-rcar.c and
> ufs-renesas-rcar-gen5.c at the same time, so give
> ufs-renesas-rcar-gen5.c a new unique U_BOOT_DRIVER name.
> 
> Fixes: 3351fe7ecc1a ("ufs: Add UFS driver for Renesas R-Car X5H")
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/ufs/ufs-renesas-rcar-gen5.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs-renesas-rcar-gen5.c b/drivers/ufs/ufs-renesas-rcar-gen5.c
> index 3c66022579fc..cc53e91449c3 100644
> --- a/drivers/ufs/ufs-renesas-rcar-gen5.c
> +++ b/drivers/ufs/ufs-renesas-rcar-gen5.c
> @@ -258,7 +258,7 @@ static const struct udevice_id ufs_renesas_pltfm_ids[] = {
>   	{ /* sentinel */ }
>   };
>   
> -U_BOOT_DRIVER(ufs_renesas) = {
> +U_BOOT_DRIVER(ufs_renesas_gen5) = {
Acked-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !

btw. Neil, can you please pick this and the 5 other Makefile sorting 
patches , so they won't get outdated ? Thank you !
