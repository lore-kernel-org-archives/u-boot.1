Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13896C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 13:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 382968815D;
	Mon, 15 Apr 2024 15:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="l9yYJJ7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 564B98815D; Mon, 15 Apr 2024 15:54:09 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6860388151
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 15:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: a7d6e707-fb2f-11ee-b64f-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id a7d6e707-fb2f-11ee-b64f-005056994fde;
 Mon, 15 Apr 2024 15:54:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=N2U9/XWpCeqIgTLdbO+3wf6LLg5RsBWhyVh72mlwB84=;
 b=l9yYJJ7WI+BIkY+q6cSRbj96xc3s1eHIKLEV2zAjo1jJ0/hj194kT+WL5C4pzP06bmXiXFuZ8uAbt
 7Ece2r2JYI3T7EeGhY1DFufP5HVnyHzp1ZxPI9FLlRhOQPCdnqWf5SABrln9cRY2NLfHqr/JuB45IZ
 g9AunkNV6cIjaQ+1jhX4qMuHk6PwPehfSaDQvLusmmg3Bxm2Tu1kKjzgm4qlg8iLRs1xqJaoZg8hil
 youBSnJUT1gpvG2ZmqDFeyUWhp4S8tl7l7tIeaVbtjtVKyiDBi4PGSqr2wmloAUYi7jyJN9pQv2yNf
 xYRO1VosuOALgGvZl/15UbmrEchffJA==
X-KPN-MID: 33|VN2mXUeJ5QI2L3OP7qKqPhwWEusblFBUklbSpmGcr8KuVZzEE/kOCF5v9kbKfqe
 LxllxviH13WkXTa5TijwO99ZoGxG5FVsdfThyYq2DQoE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|G5g+r+Po3HBb0PZFlE+poBB9GamiwSyKHnWjzUlkvPUA1XfirZFz7HYrW9MdOky
 XVZRYnNUjS+rgyOlpxNi2Eg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id a00ba609-fb2f-11ee-9eb4-00505699772e;
 Mon, 15 Apr 2024 15:54:06 +0200 (CEST)
Date: Mon, 15 Apr 2024 15:54:06 +0200
Message-Id: <877cgyhgu9.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: <j@jannau.net>
Cc: kettenis@openbsd.org, trini@konsulko.com, sjg@chromium.org,
 u-boot@lists.denx.de, asahi@lists.linux.dev, j@jannau.net
In-Reply-To: <20240317-apple_config-v1-2-1b862bc140a9@jannau.net> (message
 from Janne Grunau via B4 Relay on Sun, 17 Mar 2024 15:54:48 +0100)
Subject: Re: [PATCH 2/4] configs: apple: Use "vidconsole,serial" as
 stdout/stderr
References: <20240317-apple_config-v1-0-1b862bc140a9@jannau.net>
 <20240317-apple_config-v1-2-1b862bc140a9@jannau.net>
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

> From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
> Date: Sun, 17 Mar 2024 15:54:48 +0100
> 
> From: Janne Grunau <j@jannau.net>
> 
> The display size querying in efi_console relies on this order. The
> display should be the primary output device and should be used to
> display more than 80x25 chars.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  include/configs/apple.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/configs/apple.h b/include/configs/apple.h
> index 0576bc04c9..a70440b3ad 100644
> --- a/include/configs/apple.h
> +++ b/include/configs/apple.h
> @@ -6,8 +6,8 @@
>  /* Environment */
>  #define ENV_DEVICE_SETTINGS \
>  	"stdin=serial,usbkbd,spikbd\0" \
> -	"stdout=serial,vidconsole\0" \
> -	"stderr=serial,vidconsole\0"
> +	"stdout=vidconsole,serial\0" \
> +	"stderr=vidconsole,serial\0"
>  
>  #if IS_ENABLED(CONFIG_CMD_NVME)
>  	#define BOOT_TARGET_NVME(func) func(NVME, nvme, 0)
> 
> -- 
> 2.44.0
> 
> 
> 
