Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92452D0E6FC
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D50788D8D;
	Tue, 22 Oct 2024 13:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729595645;
	bh=wdxDy5I9euMQrVv0vP6udNMAkzZD8byzn2cu/G9eksA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L5xpojfVZfGCo3xNiWzGYFo4AsstCFILc+TM1FoQe6ftbIrJf0wN8elgj8OQ0AxZl
	 lBj3gZ8+AZoNNLK4SZEWQm9Bmyw/75MnoQka47ZKn6RJZmUQ9xM9PbXmzjM4U22jbz
	 wddhvoY06ZO0LRzFtOLa3+kXmO/1WR1JbB1d4CSMqrbOixbPSCP7PvnOTPw8N692q7
	 m9P13YXOkjRMqbrukpME8ZJ0L2fN0qY+FvoUXGiOfDb6gSrd5OJ3RH90plmzhk3uKs
	 pCA2PPJRWBQuUpq+pv/FTjjJLyx9vx4OuAIxY+ujMZe+PTgTwq1yU7c9OPQ9N/Lpyk
	 UjsXsJUdpyYgA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76BB189056; Tue, 22 Oct 2024 13:14:03 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2298188D91
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XXqLb0s3rz9sS5;
 Tue, 22 Oct 2024 13:13:59 +0200 (CEST)
Message-ID: <5f03433a-0e24-49be-bec6-0ff900e386ad@denx.de>
Date: Tue, 22 Oct 2024 13:13:58 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 12/13] boot: cedit: include u-boot/schedule.h
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-13-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003212802.3810-13-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XXqLb0s3rz9sS5
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

On 10/3/24 23:28, Rasmus Villemoes wrote:
> This TU currently relies on getting a declaration of schedule()
> through some nested include. Include the proper header directly.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   boot/cedit.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/boot/cedit.c b/boot/cedit.c
> index c29a2be14ce..ff0efda3a7b 100644
> --- a/boot/cedit.c
> +++ b/boot/cedit.c
> @@ -20,6 +20,7 @@
>   #include <video.h>
>   #include <linux/delay.h>
>   #include "scene_internal.h"
> +#include <u-boot/schedule.h>
>   
>   enum {
>   	CMOS_MAX_BITS	= 2048,

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
