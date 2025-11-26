Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B5BD10390
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 09:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA2F83F88;
	Wed, 26 Nov 2025 10:31:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="KV8l8WLv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE9683F89; Wed, 26 Nov 2025 10:31:08 +0100 (CET)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23AF483F75
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 10:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id D4C44240027
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 10:31:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1764149465; bh=iiwoCZTZa4WXNq4HdhJ/HsYhdd48KwGmDJbUFjxE18s=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=KV8l8WLvRG5eLPA4nKZW0Lgks/Qq+8VX8Wp+MlD9ZaCbzt5KoutFs+qLpZbqTkbZy
 re0GEuTYLqeNxykRRn8TizL+cdTfMbqR4lpIM//vx/5D8Y9CE1sXNth/kfID5rp0Jt
 9rfMpEOfwWjeDGKOtKk6HhUHx59uWNpv1F35Frs+VBRlsuSWAGoCrWkkTX1JuPUT4e
 nQ8P359C39lN4FMNXLB1t1uR09dbn8Pz/AB/1hzmP1tnEEbAH86Ujf0Kstly+pNzT8
 R2HtNFRYyrJTZaMfNAnD96l4w3v88s9e4Ex/YffW0I4smt3LPDye+6AsMp9bIxUm/h
 ds+loKpv/TzUw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4dGZ7F0x8mz9rxD;
 Wed, 26 Nov 2025 10:31:05 +0100 (CET)
Message-ID: <b56b9e23-5667-b018-0d12-58f21e913066@posteo.net>
Date: Wed, 26 Nov 2025 09:31:05 +0000
MIME-Version: 1.0
Subject: Re: [PATCH] s5p4418_nanopi2: Stop disabling device tree relocation
To: Tom Rini <trini@konsulko.com>
References: <20251119145535.843388-1-trini@konsulko.com>
Content-Language: en-US, de-DE
Cc: u-boot@lists.denx.de
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20251119145535.843388-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tom,

On 19.11.25 15:55, Tom Rini wrote:
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---

Tested-by: Stefan Bosch <stefan_b@posteo.net>

Looks OK, tested on FriendlyElec-Board NanoPC-T2 
(s5p4418_nanopi2_defconfig) with booting of LUbuntu Xenial (kernel 
4.4.49-s5p4418).

Thanks!

> If there is some window of memory that must be used for where the device
> tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
> or bootm_mapsize are the correct way do this. Please see
> doc/usage/environment.rst for more details.
> 
> Cc: Stefan Bosch <stefan_b@posteo.net>
> ---
>   include/configs/s5p4418_nanopi2.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/configs/s5p4418_nanopi2.h b/include/configs/s5p4418_nanopi2.h
> index fec1bfd50eb9..8a8d54daf7b4 100644
> --- a/include/configs/s5p4418_nanopi2.h
> +++ b/include/configs/s5p4418_nanopi2.h
> @@ -139,7 +139,6 @@
>   #endif
>   
>   #define CFG_EXTRA_ENV_SETTINGS				\
> -	"fdt_high=0xffffffff\0"					\
>   	"initrd_high=0xffffffff\0"				\
>   	"rootdev=" __stringify(CONFIG_ROOT_DEV) "\0"		\
>   	"rootpart=" __stringify(CONFIG_ROOT_PART) "\0"		\

Regards,
Stefan
