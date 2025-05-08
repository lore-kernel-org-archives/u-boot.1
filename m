Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2736C3ABC6
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 16:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD491828A2;
	Thu,  8 May 2025 18:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=lexina.in header.i=@lexina.in header.b="Q2OCt9Zh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A419828BC; Thu,  8 May 2025 18:19:17 +0200 (CEST)
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C795E822D7
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 18:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=adeep@lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 38E671A07C8; Thu,  8 May 2025 19:18:59 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
 t=1746721149; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Pj02wZoYyvks9dwufqjVpolSrUoYci36iRZm5QsYDyI=;
 b=Q2OCt9Zhdddpp4pAde2ov6Py049aLOmXs+X1LKpE+KunFKHkJyMDKlhiFNCwhE5N5HoPJa
 iUgD4jcrE1hb23Y0mtUUFXKDjN29rEisah7VvD+/SBp5ymhEUqG/FXuxMwHD2ghSbDCHXL
 koyBOXVBpVO68xW6kmPlWbQOo9OyPnzIKfN4RtdXsiziJb3pdd0SLqAnIQ4nn4IJmemDCw
 X0zaaN3hv/IggchSSdvKlhQxeFnQrJkp71Ud90CABeNkC+Me+lsUQzw6lRpzOq/95RRgS2
 hjmZDeiRURyCy4UFIMfayN8IQQEeUfRakmeQM/W/5/4vjm/I/rCtxCyi1wy09g==
Message-ID: <4e993fa2-b882-4f76-a3f6-4f8beb8821df@lexina.in>
Date: Thu, 8 May 2025 19:18:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/22] amlogic: Include env.h to permit reading the
 environment
To: u-boot-amlogic@groups.io, sjg@chromium.org,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-13-sjg@chromium.org>
Content-Language: ru
From: Viacheslav <adeep@lexina.in>
In-Reply-To: <20250501010456.3930701-13-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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



01/05/2025 04.04, Simon Glass via groups.io wrote:
> This file reads from the environment but does not include the correct
> header. Update it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   board/amlogic/jethub-j100/jethub-j100.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/board/amlogic/jethub-j100/jethub-j100.c b/board/amlogic/jethub-j100/jethub-j100.c
> index b770a1f8c53..9e87fb9f9d7 100644
> --- a/board/amlogic/jethub-j100/jethub-j100.c
> +++ b/board/amlogic/jethub-j100/jethub-j100.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #include <dm.h>
> +#include <env.h>
>   #include <init.h>
>   #include <net.h>
>   #include <asm/io.h>

Reviewed-by: Viacheslav Bocharov <adeep@lexina.in>
