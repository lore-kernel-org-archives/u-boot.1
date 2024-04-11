Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F1BCD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 06:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C793C88344;
	Thu, 11 Apr 2024 08:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="dKkoDo3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C16B588361; Thu, 11 Apr 2024 08:45:32 +0200 (CEST)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bd])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9248588344
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 08:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
Date: Thu, 11 Apr 2024 16:45:04 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712817928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hMaXI2XBTZV9AucirTQS0EosFfNCb4ki5KWjAf/eqLU=;
 b=dKkoDo3gFVF6/VTZ5HUctqRHZUxKMLdxYO8hGPSWMSAck7AUqa/AUlxqgv73vMN595FgEl
 LwSTMzEiHI6XRMk5IqRqKuu9U6bASQxjWgoUzlaSJ4qQGIuoY76LJq6i80rHFAnQaFlICC
 NaXuzeJ8MVGKdCjLAXtNo5H1D+D/o5/3gRnbnNMdQ+SitYat7gFlTE3+NG3L1p8t0RIIhf
 LA7VnRFRiciVOoSqLkuymB8pb6vP7meQklBgHtWoqy/XPW2JhvA2f84GrAK71H/ep6VHB2
 tDWVNM0LU+oUzwhHAmzOi33TqezEkIFsKB4MGPsQ7QulfJHUOSfrCkXZp+H5uQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 0/2] sunxi, usb: UDC/DM gadget model support
Message-ID: <ZheG8J8h-X5GPdwX@titan>
References: <20230608195631.55364-1-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608195631.55364-1-CFSworks@gmail.com>
X-Migadu-Flow: FLOW_OUT
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

Hi there,

I've tested this patch and it seems to support the gadget model, but I'm having
a lot of USB errors. What device did you test this on?

John.

On Thu, Jun 08, 2023 at 01:56:29PM -0600, Sam Edwards wrote:
> Happy Thursday, U-Boot list!
> 
> Here is attempt 2 at making this USB controller driver compatible with
> DM's gadget model, following what most of the other musb variants do.
> 
> v2 removes the unwanted printfs in the probe func, per feedback from Marek.
> I received no other feedback against v1 of this patch.
> 
> Cheers,
> Sam
> 
> Sam Edwards (2):
>   usb: musb-new: sunxi: remove unwanted printfs
>   usb: musb-new: sunxi: make compatible with UDC/DM gadget model
> 
>  drivers/usb/musb-new/sunxi.c | 52 +++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 21 deletions(-)
> 
> -- 
> 2.39.2
> 
