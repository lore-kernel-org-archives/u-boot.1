Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F858C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 15:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 624AB831C2;
	Mon,  7 Jul 2025 17:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wgLBrXhf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="w2N7ECvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91E9283106; Mon,  7 Jul 2025 17:52:23 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3ABA83046
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 17:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bbTJj3bybz9scd;
 Mon,  7 Jul 2025 17:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751903541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RC9PldNxpIl0D8q8E0+ZDNvs6sZRE/0bSi1QAipP23o=;
 b=wgLBrXhf6rtfQiUdhfKGTB8mynPy4pOF4/cQBCv51IHXhNFbuhG+UttVPtHt7fohHw5rVc
 uomrI+iJ73juuNyrgeeu51HCTglJxtm55cNVJm3wGxwFxMWb119/z7XeSXQqmiVSpZZoGN
 0zkkQ99O+FceaFpLUkWMVKNT1UOaJhO1hRVZfpIeBs3hdA5mZ6OJHt+XoaEiPdq/q+uPSi
 FbtnBFbhM388wS0caGkODbVn63rNwuS42kwZrZetZusOF4Gw74BevxwAG9EvRqr2Rm/wpA
 AAi6saMdJXC81/grdbthLEZiKatsuWLeQM8WeiCGc8E2p/b7UlQMjscdFsJWRg==
Message-ID: <57c2b5df-5874-4e37-ad7d-9c7f06d28787@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751903539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RC9PldNxpIl0D8q8E0+ZDNvs6sZRE/0bSi1QAipP23o=;
 b=w2N7ECvuXdNqNMC1TB1Eg+WfIu3+pSZVg6CnZhN3x26u5wZNWfKEGJqgCiN2swakR7bp5o
 PYmTPhuZ5sHLcg7QE4bY4ZWV+fvv4yyk2yvsWXB2B8rPrmWaS0U+GRBC6DBlXtZo4MuHKL
 H0VmOiXW8Lu8TRRziNlo49vVNvhlGzD8f+mSVtYVmICH5PaqxltJXmZGPZGmz8Yn4LSn4u
 JNyUkjpXnYSubTztly6jmC2A2Ajl77VZrvRlA2IcxjHaNCFOKGQoqchYIRpkUjmwZYFEBx
 y+f5MVAUoWoNgtrb0gwhHsOcwrGMcOAQqMR24DqADZkpKTo+zcGT06rgxEkvug==
Date: Mon, 7 Jul 2025 17:43:16 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 6/9] spi: renesas_rpc_spi: Add RZ/A2 SPI Multi I/O
 support
To: Magnus Damm <damm@opensource.se>, u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, marek.vasut+renesas@mailbox.org,
 geert+renesas@glider.be
References: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
 <175180136211.86839.18252924614607632271.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <175180136211.86839.18252924614607632271.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 5ico669hgjjdfxzepcaotydmconparj4
X-MBO-RS-ID: 34b44d9b65c778fec0a
X-Rspamd-Queue-Id: 4bbTJj3bybz9scd
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

On 7/6/25 1:29 PM, Magnus Damm wrote:

> +++ work/drivers/spi/Kconfig	2025-07-05 03:07:38.660458220 +0900
> @@ -432,12 +432,12 @@ config SPI_QUP
>   
>   config RENESAS_RPC_SPI
>   	bool "Renesas RPC SPI driver"
> -	depends on RCAR_64 || RZA1
> +	depends on RCAR_64 || RZA1 || RZA2
>   	imply SPI_FLASH_SFDP_SUPPORT
>   	help
> -	  Enable the Renesas RPC SPI driver, used to access SPI NOR flash
> -	  on Renesas R-Car Gen3 SoCs. This uses driver model and requires a
> -	  device tree binding to operate.
> +	 Enable the Renesas RPC SPI driver, used to access SPI NOR flash
> +	 on Renesas R-Car Gen3 and RZ/A series of SoCs. This uses driver model
> +	 and requires a device tree binding to operate.
Please avoid the indent change, thank you.
