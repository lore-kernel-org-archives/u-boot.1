Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C823D15D9D
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B246688D5C;
	Tue, 22 Oct 2024 13:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729595575;
	bh=8kH+tMJi8Ahf2JMKDrB/gYSnGmcIzlP/QmEabvKwaAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mVe4Rt5UVQlzL3WBsZcDxJCKmIs3gIZSESAN/TWwNjs0dN8F3MDyn0iO4Vl8RHMMF
	 Nwr8zxoOn/nHrS2TGh+OR4NJD2hVD8xwrkGUfqxLsabyAg7kyX+qMBsNplot2IpGb5
	 +VabjVkIs0uOZYQwM5QxuKrVSW20ZD+CgwntvHVJmRfopg/zgnBbZOokGaOy1pLOYx
	 0DtW9L4sDg3MgPVNo5Sh+ZuS0wKKYledezOjEIP/pqgIDTB75cAStjEVY00AFHXBoX
	 AEpnlK3noj7Oq98GXYvZa4pdns37XqGn4UIRXkaoxFYoJij/5bQ2xBX9PsIaw/1N46
	 Fx+a8YFldE+Kw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D290E88F4D; Tue, 22 Oct 2024 13:12:53 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02CCB8641A
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4XXqKF6cnhz9smb;
 Tue, 22 Oct 2024 13:12:49 +0200 (CEST)
Message-ID: <7ec7f6c5-06a0-4291-a39f-f06dd9c865ae@denx.de>
Date: Tue, 22 Oct 2024 13:12:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 08/13] watchdog.h: change include of cyclic.h to
 u-boot/schedule.h
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-9-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003212802.3810-9-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XXqKF6cnhz9smb
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

On 10/3/24 23:27, Rasmus Villemoes wrote:
> Nobody relies on getting the cyclic API declared by including the
> watchdog.h header, but for historical reasons, many TUs include
> watchdog.h to get a declaration of schedule(). Now that we have a
> dedicated header for just that, include that header instead of
> cyclic.h.
> 
> Eventually, all TUs that call schedule() should themselves include
> u-boot/schedule.h, but this is a step towards getting rid of
> unnecessary include statements in cyclic.h and global_data.h.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   include/watchdog.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/watchdog.h b/include/watchdog.h
> index d1956fafca1..0149b44d077 100644
> --- a/include/watchdog.h
> +++ b/include/watchdog.h
> @@ -10,7 +10,7 @@
>   #ifndef _WATCHDOG_H_
>   #define _WATCHDOG_H_
>   
> -#include <cyclic.h>
> +#include <u-boot/schedule.h> // to be removed later
>   
>   /*
>    * Reset the watchdog timer, always returns 0

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
