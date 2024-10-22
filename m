Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AFDD15D9D
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF4C188F4D;
	Tue, 22 Oct 2024 13:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729595630;
	bh=8CfjI7E8DscGreM0vA3tMgZd4/JPgfs7v3tsoL/sQ6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kTmpVa7+/jHwwfBIms6iomalQb3Fq8W1Gbxkll+VXv6EGDrMk6laK0kZhAZ69xziS
	 rh26ZlAZKZUk5FA+k7CDezkVHTVUNBGcsfb6Z67WB61yLVmHxRpaTr0eFgY/ri4z62
	 YnuSq3JzMQNwKK9XPBHLHO+YXvlMfPQXKPnkHhMUdweNAG2plRiNZq/PvQcSFTTn2U
	 Qqp0yqOd3Og1DnMR4+fHyMOH9NaogMmImy/FYxkdF4J+HT/VV/gUvXWL6uY7kApnRy
	 NOxc5eh2qZL9D07wjXA8TeJAOUq7dgjV1WyXpbq1lWznkeTiMI6o1bmlMBT4qLYC8C
	 qRwNuv4Zdmwbg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A844A88FB8; Tue, 22 Oct 2024 13:13:49 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3E3C88D8D
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XXqLK5jTpz9sS5;
 Tue, 22 Oct 2024 13:13:45 +0200 (CEST)
Message-ID: <012261ea-b755-4e57-b7db-414fa48f2bab@denx.de>
Date: Tue, 22 Oct 2024 13:13:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 11/13] ddr: altera: include u-boot/schedule.h
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-12-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003212802.3810-12-ravi@prevas.dk>
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

On 10/3/24 23:28, Rasmus Villemoes wrote:
> These TUs currently rely on getting a declaration of schedule()
> through some nested include. Include the proper header directly.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/ddr/altera/sdram_n5x.c   | 1 +
>   drivers/ddr/altera/sdram_soc64.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
> index db09986f64b..d1fc93b6bdd 100644
> --- a/drivers/ddr/altera/sdram_n5x.c
> +++ b/drivers/ddr/altera/sdram_n5x.c
> @@ -22,6 +22,7 @@
>   #include <asm/io.h>
>   #include <linux/err.h>
>   #include <linux/sizes.h>
> +#include <u-boot/schedule.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
> index 9e57c2ecfa4..10a8e64af3d 100644
> --- a/drivers/ddr/altera/sdram_soc64.c
> +++ b/drivers/ddr/altera/sdram_soc64.c
> @@ -24,6 +24,7 @@
>   #include <asm/io.h>
>   #include <dm/device_compat.h>
>   #include <linux/sizes.h>
> +#include <u-boot/schedule.h>
>   
>   #define PGTABLE_OFF	0x4000
>   

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
