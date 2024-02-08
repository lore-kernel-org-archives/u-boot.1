Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34783C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 05:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 573CE87D92;
	Thu,  8 Feb 2024 06:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1707370935;
	bh=GuFefFj5AklVJS5cOKI7+K4CKSqJLW9hI+/sG6+gTV4=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IYlRXKCQgddxL3TrgVyk4PzY0TLE4h8N5Zkm6OcAbLaazn3p5hQ3MY3pJXVZOlyNt
	 TCfX/F1yPP8S8bboT/P3/4FDROSupcHzUo0/crgHnx6T3I/k+GRyIZc59Q6ogciRON
	 tENRxljXLoCpTVZpjFXE2kYSRl50Ljrm7956SPK9pECvr6Q1PpmpFddeIuFrvBt656
	 37wuoH2Wp1tbQVyTCf/aQGxbBe7rXzcs0LCUZXEkU4gbNqKys/0biG0DYdrsYDN7lF
	 Q4akQ/1ODYtt/bO/531Feb7Mq9/a85FgIX5+2bzQYDbs4B45VAQuglHj3cJJKJXVM6
	 hNEmpW+TgfUpA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB2987DD6; Thu,  8 Feb 2024 06:42:11 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1047087D3B
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 06:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4TVm8F3jKwz9sM1;
 Thu,  8 Feb 2024 06:42:05 +0100 (CET)
Message-ID: <a513d5d5-1cdd-4350-b4f3-5b3b1b2fae5b@denx.de>
Date: Thu, 8 Feb 2024 06:42:04 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] rng: Add Turris Mox rTWM RNG driver
To: Max Resch <resch.max@gmail.com>, u-boot@lists.denx.de
References: <20240207150017.666213-1-resch.max@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240207150017.666213-1-resch.max@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TVm8F3jKwz9sM1
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

Hi Max,

On 2/7/24 16:00, Max Resch wrote:
> A RNG driver for Armada 3720 boards running the Turris Mox rWTM firmware
> from CZ.NIC in the secure processor.
> 
> Signed-off-by: Max Resch <resch.max@gmail.com>
> ---
> 
> Changes in v3:
>   - More meaningful variable names in accordance with review
> 
> Changes in v2:
>   - Removed ring buffer implementation
> 
>   drivers/rng/turris_rwtm_rng.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/rng/turris_rwtm_rng.c b/drivers/rng/turris_rwtm_rng.c
> index 143fe0b47f..ec2cb0bca3 100644
> --- a/drivers/rng/turris_rwtm_rng.c
> +++ b/drivers/rng/turris_rwtm_rng.c
> @@ -41,18 +41,19 @@ static int turris_rwtm_rng_fill_entropy(phys_addr_t entropy, size_t size)
>   
>   static int turris_rwtm_rng_random_read(struct udevice *dev, void *data, size_t count)
>   {
> -	phys_addr_t p;
> +	struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
> +	phys_addr_t phys;

You've now just sent the update v2->v3. As v2 is not applied yet
this is not the way to do it. Please squash this patch into the v2
one a send this as v3 or even better v4 now.

Thanks,
Stefan

>   	size_t size;
>   	int ret;
>   
> -	p = ((struct turris_rwtm_rng_priv *)dev_get_priv(dev))->buffer;
> +	phys = priv->buffer;
>   
>   	while (count) {
>   		size = min_t(size_t, RNG_BUFFER_SIZE, count);
>   
> -		ret = turris_rwtm_rng_fill_entropy(p, size);
> +		ret = turris_rwtm_rng_fill_entropy(phys, size);
>   
> -		memcpy(data, (void *)p, size);
> +		memcpy(data, (void *)phys, size);
>   		count -= size;
>   		data = (u8 *)data + size;
>   	}
> @@ -62,7 +63,7 @@ static int turris_rwtm_rng_random_read(struct udevice *dev, void *data, size_t c
>   
>   static int turris_rwtm_rng_probe(struct udevice *dev)
>   {
> -	struct turris_rwtm_rng_priv *priv;
> +	struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
>   	u32 args[] = { 0 };
>   	int ret;
>   
> @@ -76,7 +77,6 @@ static int turris_rwtm_rng_probe(struct udevice *dev)
>   		return ret;
>   
>   	/* entropy buffer */
> -	priv = (struct turris_rwtm_rng_priv *)dev_get_priv(dev);
>   	priv->buffer = 0;
>   
>   	/* buffer address need to be aligned */
> @@ -89,10 +89,10 @@ static int turris_rwtm_rng_probe(struct udevice *dev)
>   
>   static int turris_rwtm_rng_remove(struct udevice *dev)
>   {
> -	phys_addr_t p;
> +	struct turris_rwtm_rng_priv *priv = dev_get_priv(dev);
> +	phys_addr_t phys = priv->buffer;
>   
> -	p = ((struct turris_rwtm_rng_priv *)dev_get_priv(dev))->buffer;
> -	dma_free_coherent((void *)p);
> +	dma_free_coherent((void *)phys);
>   
>   	return 0;
>   }

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
