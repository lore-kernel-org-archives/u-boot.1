Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17151C25B6B
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 01:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F37287BDB;
	Fri, 27 Oct 2023 03:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698371069;
	bh=+s+EJ5/hULMJ1QPLK6X6s82/FiqUZM2ACKB+4VH6xC0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rYkedX/4MUkRvQF10pxDzDLQ0609jJ/yAjoxvuVSymx59Z4gBWFJI1gxNtY6lAUnY
	 dPZzqIYYM4gL34alsHgs1lZu6l8rgE93Ra1mkt9XkgmoSikfZ7S8PkUtTw4rkI0Gvn
	 ObWVeyuLnmcCjb/eDu31zswElPHt2QkMTVcIk8kPedlkAvthEKeSqDGsfPgKdWfs1Y
	 fSrhH2qk8OghyqmM5cE2Jni4zvYofDkXCYSmbjeDy8mFl1aN0SWRQhD0rs/1FbSJIA
	 PGT2BAI++xeUJ/uHzfHufvWJ8RrBFbzt+4QetGH4nZqGEI6eeZyZolSrENLBreMc6O
	 OpBV8evCDt3aA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C4DC487B84;
 Fri, 27 Oct 2023 03:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698371057;
 bh=+s+EJ5/hULMJ1QPLK6X6s82/FiqUZM2ACKB+4VH6xC0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Qq13ESr1qJ48hoipYMIQxnB79CMLXORILlmlWaxGhIyKRp7u/i9iGEsUh37jR1qLL
 VMSKH2l/hZFaHV71+U02y/rVy4O38U9HIV6DKja5ZX7MktAsIiy1NRglzthvjjpdBI
 z3saQ+EnJDcKmqzpSZhM49tGDlfMMR3troeqEnpnlSG17aRiiJsMRRbv3UJDy48RyN
 wjf37yZVPhcrbv3Fkrhb60W116gRKHGRfGJsqha7lbl4yrv1fD9I6E3fa1TbUGBm+a
 qD629Rl9TcbMrTBK7xYe7GGRWVM+RWchJICHvasl/p0+gtz/k/uhjFAXrIuUgRHDNz
 rBA6AtMoOpMig==
Message-ID: <f2cd8dab-a494-4e9a-b450-0311444f436b@denx.de>
Date: Fri, 27 Oct 2023 02:36:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fixup! usb: xhci: Guard all calls to xhci_wait_for_event
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 asahi@lists.linux.de, Minda Chen <minda.chen@starfivetech.com>
References: <20231027-usb-fixes-1-v1-1-1c879bbcd928@marcan.st>
 <20231026232642.16668-1-marcan@marcan.st>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231026232642.16668-1-marcan@marcan.st>
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

On 10/27/23 01:26, Hector Martin wrote:
> Gah, I should've paid more attention to that rebase. Here's a dumb
> fixup for this patch. I'll squash it into a v2 if needed alongside
> any other changes, or if it looks good feel free to apply/squash
> it in directly.
> 
> ---
>   drivers/usb/host/xhci-ring.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index e2bd2e999a8e..7f2507be0cf0 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -532,6 +532,7 @@ static void reset_ep(struct usb_device *udev, int ep_index)
>   	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
>   	if (!event)
>   		return;
> +	field = le32_to_cpu(event->trans_event.flags);
>   	BUG_ON(TRB_TO_SLOT_ID(field) != udev->slot_id);
>   	xhci_acknowledge_event(ctrl);

Please squash, and add

Reviewed-by: Marek Vasut <marex@denx.de>

Also, +CC Minda,

there has been a similar fix to this one but with much more information 
about the failure, see:

[PATCH v1] usb: xhci: Check return value of wait for TRB_TRANSFER event

I think it would be useful to somehow include that information, so it 
wouldn't be lost.
