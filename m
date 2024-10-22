Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFC6D0E6FC
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 564AC88F82;
	Tue, 22 Oct 2024 13:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729595491;
	bh=Cq+eodP1lyxWMgW9ezsHtN7l21YyekAGYrCIIRyZQ/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kGxzbASB1tL9RCvByuHlMUyewglgjfZQRRnCT7llQhxXI3tM8y5BZH4qrDKh6FeVs
	 oisbNdjKpj/2odVMmysp5DWYnI+PTvnGbj/RYTLW0d0dZdIDzVQjrgXfOW4uX+sU9l
	 mQTswAP27k2Ig8QD77HGDGicVtUKbiqbANbaKb7kEdvx0vY0slzeNvY7fYBuptM+VY
	 GHtaxXQKd5bFRg7xGmZIdihcTfNpG+6Z1bSXJ8wkirhtKmhowtevrtLxYQ2zKO2nr3
	 yrdPBpRmlvWmL9ExxQsakbyXE7tWMrScU0f5Ywu+dYitg9YOvdFuMvhZ8E3ze03IKw
	 ZAhaYZNBrqQVg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D441A88D91; Tue, 22 Oct 2024 13:11:29 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FF7188D5A
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XXqHb5CY3z9smy;
 Tue, 22 Oct 2024 13:11:23 +0200 (CEST)
Message-ID: <826a4ad9-0948-4a9f-af44-6f41b3549220@denx.de>
Date: Tue, 22 Oct 2024 13:11:23 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 03/13] led: include cyclic.h in led_sw_blink.c
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-4-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003212802.3810-4-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XXqHb5CY3z9smy
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
> This makes use of the cyclic API but relies on implicitly getting the
> appropriate declarations through some nested include. Include the
> cyclic.h header directly.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/led/led_sw_blink.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
> index 9e36edbee47..6976b84544e 100644
> --- a/drivers/led/led_sw_blink.c
> +++ b/drivers/led/led_sw_blink.c
> @@ -5,6 +5,7 @@
>    * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>    */
>   
> +#include <cyclic.h>
>   #include <dm.h>
>   #include <led.h>
>   #include <time.h>

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
