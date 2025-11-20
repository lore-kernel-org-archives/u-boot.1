Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D34BCF856D
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 09:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E39784073;
	Thu, 20 Nov 2025 10:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="i95fQ/f0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30BB58407F; Thu, 20 Nov 2025 10:08:35 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 253058405B
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 10:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7B4EE10B3B2; Thu, 20 Nov 2025 10:08:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763629712;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=hk0y6T/XBTYSn05bH7ywpYkcCfGTdBUn2GcsxYpsJZ4=;
 b=i95fQ/f0hkPOWfDzLKL+FXnn6KbH3wq2FvkhiFiLTXk180IvM1WR5T7d25wISCegI5ooPC
 9pcA81dImDxJwAf/L0105nPfgKGHUHs23lwTCdsXpkJg6CTChs5dZf6cJeArZ1pB/5WOsz
 XXNOjLKbL82DXQ4d+N3kDVssF0xZ1CbYbYNXgi1ONt78ftKUFYYXFwgniDC7Wi0nnHnjkt
 h3Zb1Szp9LpIYKyNsA37CCHEL2Vs+M6bvyuxjEgmbI5/alJNqG4fufd5N8YUPHHOsK5s1r
 qst/ElC+p0ZdQVeuvqGC4FNLcbRvMh1tvRwO4LroZbW1ZZ1jCJkDey79+z7vYQ==
Message-ID: <6a902e2d-b1be-1ba1-5d8b-e0a07ea2aebe@nabladev.com>
Date: Thu, 20 Nov 2025 10:08:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20251120041526.817288-1-marek.vasut+renesas@mailbox.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251120041526.817288-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Marek,

On 20.11.25 05:15, Marek Vasut wrote:
> If CONFIG_OF_PLATDATA=y , then the udevice has no valid OF node associated
> with it and ofnode_valid(node) evaluates to 0. The dev_read_u32_default()
> call ultimately reaches ofnode_read_u32_index() which invokes fdt_getprop()
> and passes result of ofnode_to_offset(node) as an offset parameter into it.
> 
> The ofnode_to_offset(node) returns -1 for invalid node, which leads to an
> fdt_getprop(..., -1, ...) invocation, which will crash sandbox with SIGSEGV
> because libfdt can not handle negative node offsets without full tree check,
> which U-Boot inhibits to keep size lower.
> 
> Since i2c_child_post_bind() already calls dev_has_ofnode(dev), reuse the
> same call and assign i2c->speed_hz = I2C_SPEED_STANDARD_RATE in case the
> device has no valid node associated with it, and do not call any of the
> dev_read_*() functions for devices without valid nodes.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/i2c/i2c-uclass.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
> index 380a9f8f3ad..d0e9dad7202 100644
> --- a/drivers/i2c/i2c-uclass.c
> +++ b/drivers/i2c/i2c-uclass.c
> @@ -749,8 +749,11 @@ static int i2c_post_probe(struct udevice *dev)
>   #if CONFIG_IS_ENABLED(OF_REAL)
>   	struct dm_i2c_bus *i2c = dev_get_uclass_priv(dev);
>   
> -	i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
> -					     I2C_SPEED_STANDARD_RATE);
> +	if (!dev_has_ofnode(dev))
> +		i2c->speed_hz = I2C_SPEED_STANDARD_RATE;
> +	else
> +		i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
> +						     I2C_SPEED_STANDARD_RATE);
>   
>   	return dm_i2c_set_bus_speed(dev, i2c->speed_hz);
>   #else
> 

This sounds more as a bug of dev_read_u32_default() to me and should
be fixed there, else we need to make this check around each call of
dev_read_u32_default() ...

And looking into u-boot:/drivers/core/read.c there are more
candidates for such a fix (all with "default" in function name?)

and such a fix would also make the dev_has_ofnode(dev) check in
i2c_child_post_bind() obsolete.

Or may we fix the default functions in drivers/core/ofnode.c ?

Something like that:
"""
hs@threadripper:u-boot  [master] $ git diff
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index cf1cf8abfbe..400512c1a30 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -401,7 +401,9 @@ int ofnode_read_u32(ofnode node, const char *propname, u32 *outp)

  u32 ofnode_read_u32_default(ofnode node, const char *propname, u32 def)
  {
-       assert(ofnode_valid(node));
+       if (!ofnode_valid(node))
+               return def;
+
         ofnode_read_u32_index(node, propname, 0, &def);

         return def;
"""

I would interprete a default function in a way, that whatever happens,
it returns the default value... but may I oversee something obvious?

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
