Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707FBC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB22C83BDF;
	Thu, 10 Apr 2025 14:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A823ajB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB2683BEB; Thu, 10 Apr 2025 14:16:53 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4261E83BCC
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 14:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8885344C1E;
 Thu, 10 Apr 2025 12:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BF5C4CEE7;
 Thu, 10 Apr 2025 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744287409;
 bh=V87VtnKX4SQVHTMCYqKBK/O3WX7GKWgC3FiKAYAywy4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=A823ajB8JDCa9IOqraf5kx1OkPvhp9zYPHdkAPVyhHBOuqEkpwk+yu35AlVRqNbs4
 co3RACpuMcz2H482O9ECpgWKDVGKtYSzyryavnHvjSihvj24oly5AGtNjJBaT21ZmE
 4bNANujyPdzN47e/GVzfeKu+zpgvl0NRDfNCh791A5lykEwLFHjn2jbvX/vwbTVJwd
 85WTgJ6EhPVPHBiO3K9yV4xcb2NX2TsGwVMm8Eg+julVrsret4X/bDbKQ9yTsbDv+a
 X1KvK97OT2EBpAQuFk4U0dCDB+f65Obh8xJQz/QpUJnV1PodpADbNGm8Ocp7C9xmE9
 h5CZCi4ljF8Rw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Loic Poulain
 <loic.poulain@oss.qualcomm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] usb: gadget: f_acm: Allow restarting ACM console
 after stopping it
In-Reply-To: <20250407-acm-fixes-v1-2-e3dcb592d6d6@linaro.org>
References: <20250407-acm-fixes-v1-0-e3dcb592d6d6@linaro.org>
 <20250407-acm-fixes-v1-2-e3dcb592d6d6@linaro.org>
Date: Thu, 10 Apr 2025 14:16:45 +0200
Message-ID: <87y0w8fbyq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Stephan,

Thank you for the patch.

On lun., avril 07, 2025 at 16:59, Stephan Gerhold <stephan.gerhold@linaro.org> wrote:

> When using IOMUX, the "usbacm" console can be added/removed dynamically
> from the stdout/stderr/stdin environment variables to allow temporarily
> starting other USB gadgets (e.g. Fastboot).
>
> However, right now acm_stdio_stop() does not completely undo
> acm_stdio_start(): The USB gadget is unregistered, but as long as dev->priv
> stays set acm_stdio_start() will never register the USB gadget again.
>
> Clear dev->priv after we detach to make sure a start operation after a stop
> operation registers the gadget again.
>
> Fixes: fc2b399ac03b ("usb: gadget: Add CDC ACM function")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/gadget/f_acm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
> index 2665fa4168f99b35a8c595aa24cb3fc4e8ab8529..8f7256069f58527b2e43e5add725a0b5f06baa6d 100644
> --- a/drivers/usb/gadget/f_acm.c
> +++ b/drivers/usb/gadget/f_acm.c
> @@ -663,6 +663,7 @@ static int acm_stdio_stop(struct stdio_dev *dev)
>  {
>  	g_dnl_unregister();
>  	g_dnl_clear_detach();
> +	dev->priv = NULL;
>  
>  	return 0;
>  }
>
> -- 
> 2.47.2
