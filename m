Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F9606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UQvsWAnB;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=we6gxh/a
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7981A6070C;
	Tue,  3 Nov 2026 07:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w6f3dC1dHkK2; Tue,  3 Nov 2026 07:58:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E8AF2606A2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793692720;
	b=Lf5CfuS61m8jenxacXgWksKGlFP85E4pHPJ7wV+/IvWwooeAlAlWRruMG+dSwYR53GxA
	 7CUa49qgD6dAFmfZ1jbFayZr4tKEkH7t46U4mWdZ4lpdLGe/yFR6hS4nZ7Kb++buCA5AZ
	 qdmafGCJ+SGsFCyHl7gTajq129zDHystcZFnpyfMWkl9KsnJJRBUJBLgDmttdiCsaKP+k
	 8WzJioAbWxwHurRTbSXIu8IOXWAm5MyhEvtNJ8XMIr0yOuGlsupm3n9vtyH8/rIOU8Scd
	 g92n2cm3I6NUduXq8V+RuDtXcJeiLmZSYvYq/hVXoM/0odByDxVKlsgmXEp6MirtN5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793692720;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Zs3XJoIOffZLbaAbx18roee61MXF4cui79TuY0lJuKQ=;
	b=F1Bi8OMzrvi6In89Z2ZvrExrMgvrbD7u5pn78vA8rbIcQKaJ9zLfE9z3PwVX9vpYYipd
	 T9AY7zjCXyoie/h6L4fNvZ9ARs70m4b2vVNPf18XNsG3LYr4HwI0I/UlLWdkeaXr/rAN0
	 uIy+VLUNYSiUawE+ylUnqOCUnBmwdkjG1SB6xS2eVhNqNSwRghiVGAKB+mubQ/HJgj/HN
	 WOIf1qo9WYGMJW1nW9cxCHLzoc3BBuOuzwHfc+J1HZVrmTPRxEHSnkan0D332q3h/yL7n
	 +aJPVe8G1QPB47AOWzL1sUqglotEoS/NzcVEiD7XJMA4NjlHhHeLUvygL1/EOdre74g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793692720;
	bh=Zs3XJoIOffZLbaAbx18roee61MXF4cui79TuY0lJuKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UQvsWAnBFHvd7mAhIp4DZHo0wDLvezSnUJwRXrusar/HlIbLkJtnAGiOtBSOLuJys
	 L5hQGglODyui0DKfObhQzZ7hPg7Z+4fdJRW/ta+V36gG0iSj+EhgrX1kJnLy2mnYQH
	 YvFcYh2XZ4QI7buRrBySFfm/qg54rQfWWRmpld5lvObZJXnCm98hsfQg45LKuKeZlH
	 BGaB7IHu+XWBDnXGxw9NzMz/LhG8UI+y1pWbaEBFWS/GUhFF0FH5aP6HEmmxiuC7Yl
	 T3ggHE8YFrWqnpJSkE74QN/2JfuRU8A+haWkPeMi49N1JL9/iDy9ehIUdFsdTG3P2t
	 J3VVxjXqIO5mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8AF2606A2;
	Tue,  3 Nov 2026 07:58:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AF8C235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C70E4009D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:58:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mxjKNlaxh3vO for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:58:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B0CDF400BE
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793692717;
 b=SZ8cTGwVtWHZjRx5y4znPIQUNqGStH9B/zwyMwse2xq5aZCbV7+A7Lvj8aBz1x9hTfRM
 aLMxUStZoy5bBy6btMYYvNtMrzwjWaX8fx/pyM3RVUI90Q9xdt2NOM7XAVs1nvdvBv6ny
 NpmNPJ8uhfRIZ7PAEJs8tSHwl3bvnv5fM2ddadwq+E1W3wbKI/Bia058yt/EY2bpP13JM
 LMrMX193BvBJeud5w6DB4mc/Zsvrrzw0p9+UxpESwayrc9bM1tZkn0k3KeNNc9yV3o53I
 mRFXKTzJ+0zD1FInVF4nYgQ5Gt4287staIa2VEcxRkYbKrSXfqf39RCQeC4I1kZuOmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793692717;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=Zs3XJoIOffZLbaAbx18roee61MXF4cui79TuY0lJuKQ=;
 b=SH0N1BhmY5+zdKT0O54PZ9Fwekt7BGSJ+xsGsre4wcjR5iootDODHax/jMMWmcU3ghI3
 /w25Ql9u/Ac2CSSeaUAHK81u6n8hz61Hk1DNI9d9wMDk7GMVTHl/yFjRSzp1mSF9/Ofl1
 xLOcaoceZgBvSQNaDn0Gw7mQIF9PTOCvj453Yjl38f7Aam+r/Y+DxDUhr8EgZoRlpfkRv
 FF21u+VgPDZzJARIh7DGthKdGJHYyGPuWDxqz/NjxpotU25JuKh/rV0C7nnNrfdPUaMrk
 uSPj0Sa+DbSdvZ8sHvYarEj77SfVosCAnYhv/OVIj+Bsa7mc8nVXFTZJfN+BtYYfGdQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b="we6gxh/a"; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=we6gxh/a
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B0CDF400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:58:35 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 9A5F54E413C8;
 Tue,  3 Nov 2026 07:58:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 549E56046C;
 Tue,  3 Nov 2026 07:58:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9459F10328267; Tue,  3 Nov 2026 08:58:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793692711; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Zs3XJoIOffZLbaAbx18roee61MXF4cui79TuY0lJuKQ=;
 b=we6gxh/a60AzegLlDObsrvoB4Ambc+vAPEl4A0XuASXMDLQsdAcOqZkOpa+0VUn4feOSYi
 x1Wqpw3HT4A73rf1LPx8uR6xR9hHk7ZETdv8PrnT7z9dAChPbQNPlq1+n65rscHI6BHkkG
 c+A91YvDcUSZF0euZSYyHwr8hukyAwCZ0x0yHnmEiFt3ObUpleXTRcAgiyR0Hnqte26Wxz
 B2UzU7PO2uVrAutMVSj8bLWzHCSK//A3LhPLoLu2gtdQOhUcTjBnVB9QoIeUaawrktZ9Gz
 tjdcApFs3v+QuUOCzlDJr/8pUzh7tyiQU4LNkGEnY4wbNKZAWMOHHe0KEqzjsg==
Message-ID: <cb7b6362-2181-48e8-944d-4698688d0988@bootlin.com>
Date: Tue, 3 Nov 2026 08:58:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] arm: mach-k3: j722s: Wait for TIFS initialization
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Aristo Chen <aristo.chen@canonical.com>,
 Simon Glass <sjg@chromium.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Julien Panis <jpanis@baylibre.com>
References: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
 <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-6-2a67384ed0ef@baylibre.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-6-2a67384ed0ef@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le 30/10/2026 à 13:27, Markus Schneider-Pargmann a écrit :
> On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
> the firewall on the registers at the end of initialization. On HS-SE the
> U-Boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
> leading to a race condition. This leads to a broken watchdog since the
> signal configuration doesn't succeed because the write doesn't take
> effect.
> 
> Wait for TIFS to be initialized using k3_sysfw_wait_ready() before doing
> ctrl_mmr_unlock(). As spl_early_init() may already probe some drivers, I
> am attaching to the EVT_DM_POST_INIT_F event to wait for TIFS and call
> ctrl_mmr_unlock() before anything got probed.
> 
> Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
> Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/
Tested-by: Richard Genoud <richard.genoud@bootlin.com> # on j722s HS-FS

Thanks!> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/Kconfig            |  1 +
>   arch/arm/mach-k3/j722s/j722s_init.c | 17 +++++++++++++++--
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 3c567f50b223..a952638fc282 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -33,6 +33,7 @@ config SOC_K3_J721S2
>   
>   config SOC_K3_J722S
>   	bool "TI's K3 based J722S SoC Family Support"
> +	select SPL_DM_EVENT if SPL
>   
>   config SOC_K3_J784S4
>   	bool "TI's K3 based J784S4 SoC Family Support"
> diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
> index 1180c75f551d..7b09691998c9 100644
> --- a/arch/arm/mach-k3/j722s/j722s_init.c
> +++ b/arch/arm/mach-k3/j722s/j722s_init.c
> @@ -11,6 +11,7 @@
>   #include <dm.h>
>   #include <dm/uclass-internal.h>
>   #include <dm/pinctrl.h>
> +#include <event.h>
>   
>   #include "../sysfw-loader.h"
>   #include "../common.h"
> @@ -70,6 +71,20 @@ static void ctrl_mmr_unlock(void)
>   	mmr_unlock(PADCFG_MMR1_BASE, 1);
>   }
>   
> +/*
> + * Called by spl_early_init() after all devices are bound, but before any of
> + * them are probed. TIFS has to finish its initialization before CTRL_MMR can
> + * be unlocked, and any device probe may already need the unlocked CTRL_MMR.
> + */
> +static int k3_spl_dm_post_init_f(void)
> +{
> +	k3_sysfw_wait_ready();
> +	ctrl_mmr_unlock();
> +
> +	return 0;
> +}
> +EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, k3_spl_dm_post_init_f);
> +
>   static void k3_spl_init(void)
>   {
>   	struct udevice *dev;
> @@ -84,8 +99,6 @@ static void k3_spl_init(void)
>   	 */
>   	store_boot_info_from_rom();
>   
> -	ctrl_mmr_unlock();
> -
>   	/* Init DM early */
>   	ret = spl_early_init();
>   	if (ret)
> 


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
