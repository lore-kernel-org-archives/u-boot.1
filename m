Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E6AD0E6FC
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A95688D5C;
	Tue, 22 Oct 2024 13:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729595613;
	bh=C1ZI6R3X1UvO/DfaSxC+q6Fk6xZ2MSGJeMmTjN2Pcfs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P5Vyy8gtf4vAS4KEv4O8UBJPiJf9BA3nZ/lQ4XeJ9NWBsA4IB8pMZ/TpzRK6qU+qD
	 Aqxn3uM9gvvHY/BnADw+wS7L7EhHZay8YARgOO1tS+7qeubmCG6fGlnjuuCF7rb8VM
	 2+zQMEuyVY2O4Eg0slTu3HYhVKaFaU3VjBnNo8+YwgYtuPbp9I9HBoQoNwYFFcsfWz
	 U2RfJ3v+sO1Gk4epGv7daSJvYNSpCoRZasYvh5TDUeMRvySb3cC4JG/Y+IM5h+aSYz
	 /vd5c5atud3o4ZTmnxabdwIQ2iTWLfRcalsmLwolxOf/om8909LrV/GgO8JNnVvSFD
	 exAoERhqYE7gQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8D3088F8E; Tue, 22 Oct 2024 13:13:31 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 026A78641A
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4XXqKz6kKbz9t1F;
 Tue, 22 Oct 2024 13:13:27 +0200 (CEST)
Message-ID: <b0a2d2ad-8068-443c-a87a-6c85eea60cc3@denx.de>
Date: Tue, 22 Oct 2024 13:13:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 10/13] i2c: rzg2l: include u-boot/schedule.h
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-11-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003212802.3810-11-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XXqKz6kKbz9t1F
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
> This TU currently relies on getting a declaration of schedule()
> through some nested include. Include the proper header directly.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/i2c/rz_riic.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/rz_riic.c b/drivers/i2c/rz_riic.c
> index 5f3f8d1b24b..f292c824362 100644
> --- a/drivers/i2c/rz_riic.c
> +++ b/drivers/i2c/rz_riic.c
> @@ -14,6 +14,7 @@
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
>   #include <reset.h>
> +#include <u-boot/schedule.h>
>   #include <wait_bit.h>
>   
>   #define RIIC_ICCR1	0x00

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
