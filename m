Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91164C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 19:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E100D81298;
	Wed,  5 Mar 2025 20:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jxKDWQSv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="U5huxTvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BF3781273; Wed,  5 Mar 2025 20:56:24 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21131808A2
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 20:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Z7NbT6BRCz9sdQ;
 Wed,  5 Mar 2025 20:56:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741204582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1M6bcTdbNXgciKbZlKtVRHfyJDu7fJsNeylwXY3sbts=;
 b=jxKDWQSvt1awGZi9FSSuZ/MttQh+eTVUVxeDiENGmRe+GDWPwog//taysRBK9P0pnCO82G
 esHYcx+h9cXWBKKoN1j7Ep0xFgjLH1MyImN2sgt2bsgD58eZwEs1RRWEHlmPFzgfMfulMV
 dGBs1NUl3b0gBqjiLEPqhEniOqa/OYPIpN7hUuL0rFs0tqtmRCT7rE7R6OKZf7I59X0TMw
 1CSTEbyISvVo4xiW/wnfiGI2N/Vg6MT9H8N1sz83NjRD/dViiEtWUp82gI4QlGSP6mymar
 b+qZTN04e6pImxvih5JGvikuK7VbY5ud/EOHYrc4P2gZCdZlZqPExrr9AzM1uA==
Message-ID: <8aa61771-e37c-4f5a-a24a-473be3080352@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741204580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1M6bcTdbNXgciKbZlKtVRHfyJDu7fJsNeylwXY3sbts=;
 b=U5huxTvJYu6To73l/cYNy4G/z8heBs9xLT4JkVIxdGWwpGvaZiwN9NPs17OEfYRQLgbDhS
 8EqSKW/DhAlPEYMM99yzQDTPkG8YqRCgAlnUI+sGY8u2EYnQNDqyurhn9Dxmv5Z17xXqrt
 c6MrIRgAfDZ/8yl2BHpJb+GYFrpcgRw8VGkQ8MK94JXBcI/mwvQEihBx5bvLwZAzLuwgk6
 k0q8hsCAxLfmIUUYuy0k8zq9llJLqSpdXqFQrUw415oxGbe8sXs4C/3q0gIfW5maDyp9zS
 atSufiuVjZrRkvjVNSYFg9kNUmtN+G1zz5wUjnArNQdChCRquMTat2kEUxrZkQ==
Date: Wed, 5 Mar 2025 20:53:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] net: ravb: Fix RX frame size limit
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20250304200712.92514-1-paul.barker.ct@bp.renesas.com>
 <20250304200712.92514-3-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250304200712.92514-3-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f04e3425c07df4add94
X-MBO-RS-META: 113dod7end19ftjkhkzptt5xxytcw4k1
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

On 3/4/25 9:07 PM, Paul Barker wrote:
> The value written to the RFLR register includes the length of the CRC
> data at the end of each Ethernet frame. So we need to increase the value
> written to this register to ensure that we can receive full size frames.
> 
> While we're here we can also copy the improved comment from the Linux
> kernel.
> 
> Fixes: 8ae51b6f324e ("net: ravb: Add Renesas Ethernet RAVB driver")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>   drivers/net/ravb.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
> index 6129929568a3..6bd94cf6bb1b 100644
> --- a/drivers/net/ravb.c
> +++ b/drivers/net/ravb.c
> @@ -354,8 +354,14 @@ static int ravb_mac_init(struct ravb_priv *eth)
>   	/* Disable MAC Interrupt */
>   	writel(0, eth->iobase + RAVB_REG_ECSIPR);
>   
> -	/* Recv frame limit set register */
> -	writel(RFLR_RFL_MIN, eth->iobase + RAVB_REG_RFLR);
> +	/* Set receive frame length

/*
  * Set receive ...

Please don't use netdev-style comments here.

With that fixed:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

I can also fix while applying, please let me know.
