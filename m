Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46ECDCDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 08:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2677B8477A;
	Mon, 16 Oct 2023 10:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697444080;
	bh=sMiwOcMMihH0dcWDH1V+IBIE0gmqbhYdEMLYKQgNb68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tNDTrwvrgp7HnySPiufu2UYOd9KmbJEnbolM5F6+ldjGKkQWzhXtPbAKp/aDw3Juf
	 VwPeu0JkgAy2nS/kcRFss4gkPgvPXJ4m4v4jzWedQZZnQ9CMRN8nG76SJtXJiT7RWQ
	 1nwYwTrVX7WQqqra/19dSAu05RQAhJeIfiElVF5KhLUthwgXcO1lBerev+kmmVMyNW
	 ug4cTN8uxypMJEoAWCqKkXE1LoRrnmREVp+rDyzwf8zD5n5f6dWoroz6Mhu8i018mR
	 tuPex/sM+yzbTM+z4kpHh1cc4vVEwrRnmkoPBfOLeQ8DNTppycIuX6B6PfXrEtDV6W
	 BhEEeaRNXenTw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A51F8644E; Mon, 16 Oct 2023 10:14:36 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D830803AC
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 10:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4S88zD4Nw1z9sV6;
 Mon, 16 Oct 2023 10:14:32 +0200 (CEST)
Message-ID: <414b433b-33d9-496b-8c7f-8eaafde3476b@denx.de>
Date: Mon, 16 Oct 2023 10:14:30 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] wdt: nuvoton: fix reset/expire function error
Content-Language: en-US
To: Jim Liu <jim.t90615@gmail.com>, trini@konsulko.com, KWLIU@nuvoton.com,
 YSCHU@nuvoton.com, JJLIU0@nuvoton.com
Cc: u-boot@lists.denx.de
References: <20231003084058.2656171-1-JJLIU0@nuvoton.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231003084058.2656171-1-JJLIU0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/3/23 10:40, Jim Liu wrote:
> fix npcm845 watchdog halt for reset function and expire function.
> reset function is restart wdt.

Please start sentences with an uppercase word.

> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> 
> Changes for v2:
>     - add commit message
>     - fix no empty line problem
>     - remove dts
> ---
>   drivers/watchdog/npcm_wdt.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> index e56aa0ebe1..22d7fc45dd 100644
> --- a/drivers/watchdog/npcm_wdt.c
> +++ b/drivers/watchdog/npcm_wdt.c
> @@ -70,14 +70,21 @@ static int npcm_wdt_reset(struct udevice *dev)
>   {
>   	struct npcm_wdt_priv *priv = dev_get_priv(dev);
>   
> -	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, priv->regs);
> +	u32 val;

Now you have an empty line before this variable declaration line. Please
remove the empty line in v3.

Thanks,
Stefan

> +
> +	val = readl(priv->regs);
> +	writel(val | NPCM_WTR, priv->regs);
>   
>   	return 0;
>   }
>   
>   static int npcm_wdt_expire_now(struct udevice *dev, ulong flags)
>   {
> -	return npcm_wdt_reset(dev);
> +	struct npcm_wdt_priv *priv = dev_get_priv(dev);
> +
> +	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, priv->regs);
> +
> +	return 0;
>   }
>   
>   static int npcm_wdt_of_to_plat(struct udevice *dev)

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
