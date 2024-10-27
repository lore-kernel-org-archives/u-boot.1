Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A88D1356F
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C840B88EFB;
	Sun, 27 Oct 2024 17:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pPh9S+O6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xGHkhkwn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09FCF88B1F; Sun, 27 Oct 2024 17:32:22 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78FF989068
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 17:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Xc29P1WKsz9sky;
 Sun, 27 Oct 2024 17:32:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d3mamJAKOYkyIt/gbtdBkEdBDNerzw7bmk9h8tSBJ20=;
 b=pPh9S+O6uBFAIiM9ld6uFkH+pveqXP/bQhctgnuWjHeDuc5M60Q6xn6pfrRxJjgTZY4Zci
 WP0Dv4x+P4CbpQu3YtwNu63HgqaVbfFfnGbMkH2SaolXJf16JwlOq7s7hyKTEwjdqIr9R/
 ram9KfI4qYn7kKGFIRHlOfg6X3pOgQU6Tc4X5Ap4PxJDeGJB9cwgVIP7FenSb5n65UFGL2
 I+lyexV/vZSfblSOjk4awEt4UTPEYTaZtzMDxXozvQaOUVvIFNtwnmV3g7xJLCmXpvU9O4
 YhmIRekWFWgjGVGX9ZhG0zwagPjXNpe99Y+3N5yjNjUhknPrixJ+O0+R+IV6jQ==
Message-ID: <5537c831-f91b-44e5-8a00-3f2790936ae2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d3mamJAKOYkyIt/gbtdBkEdBDNerzw7bmk9h8tSBJ20=;
 b=xGHkhkwnt1JMTs0O9MM+KgvWMGbEoZc3mOo3hQermtsnqoi7Ikf+01mtgoGT4reOkf9qZn
 3q2hZ8beYzrDRGq5jSddE+Xq9Czw1u1q8t+NB5AOmSxmofMo15dC9jnKxPgYtCRVj+o+ft
 UkeEcea7bMfpImAqDxgco3E1njELIn87gYMeYy+gopVBgApkrObQxMGUYlMMfJIovaPw43
 jks7+N6/GDDT3bIkYLpQAvmgLJnE8MAHnTTcHJSLkNanOxn1gaXOYymrQeJk7ZX/jsjAFV
 TvNxvCDxooW1UdAnILLPLTyOra3n+xvqDbNmM5rzrLaGXeexzSR1D2e8hnIGSw==
Date: Sun, 27 Oct 2024 17:21:27 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 10/14] net: ravb: Simplify max-speed handling in
 ravb_of_to_plat
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-11-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241024152448.102-11-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fp93wqchkeyr6rs38dqq57ibu9wh6hm8
X-MBO-RS-ID: 93855948fbf4d61e970
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

On 10/24/24 5:24 PM, Paul Barker wrote:
> We can call dev_read_u32_default() instead of calling fdt_getprop() then
> fdt32_to_cpu().
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>   drivers/net/ravb.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
> index 9b33ce929618..fb869cd0872e 100644
> --- a/drivers/net/ravb.c
> +++ b/drivers/net/ravb.c
> @@ -676,10 +676,7 @@ int ravb_of_to_plat(struct udevice *dev)
>   	if (pdata->phy_interface == PHY_INTERFACE_MODE_NA)
>   		return -EINVAL;
>   
> -	pdata->max_speed = 1000;
> -	cell = fdt_getprop(gd->fdt_blob, dev_of_offset(dev), "max-speed", NULL);
> -	if (cell)
> -		pdata->max_speed = fdt32_to_cpu(*cell);
> +	pdata->max_speed = dev_read_u32_default(dev, "max-speed", 1000);
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
