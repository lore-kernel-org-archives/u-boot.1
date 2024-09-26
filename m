Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D056CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC3488EE2;
	Thu, 26 Sep 2024 23:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727386811;
	bh=w2Bqmr6gVc7Y6QH7Ba1/jW8/N42Pas9kbTRItd0lZBc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RMCj3hdcKQN5kzNvlvd/VBfaaE2lDjrXHcGo2e1mph46BQDhfE/yjZP6eceREXgoC
	 khQV0VtOgLHwZt0Tv8X9PpCQX/VOtYORTMOphyEGwtlA3+qPPhMxnyawAD6M2yDNK2
	 rgm8uvb8VTHW61p+iRMcNHoViKcmphyaSgmGklsFrwny4hbaYY+Nm6bvX6UKs7YxUC
	 LRtIxGnf4IZi5RXtprnt2Fogkd+U7Dl439rtZF/A3wa6+9/bVa4jKEGIV5XqO6drmU
	 TdUIKuxU4EnexYoSrerVNzvbHX4iB7EFcaJOLvN1hej6OcH2NyhLAnunXTwzS1zyyg
	 TPyLKhfMeD0Pw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A0D6E88EAF;
 Thu, 26 Sep 2024 23:40:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727386810;
 bh=w2Bqmr6gVc7Y6QH7Ba1/jW8/N42Pas9kbTRItd0lZBc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=W7YK9Pz+Qkmw/JEUVjYgNInlBiYD2ya6r/2+Av4404Zc/9pMZNGuXKzgVR2gjWq5M
 6smTXRVt9sjNMcF5ZRy5b5w4Fwsv/lzIEsknkLmmgcvljucmBg6Rg+Nhagp0Bc1QCi
 YwBnzMmliELxe8tWL9rQyOR6z8sDFYKzVU0FeTg3eO82xyHgGiAwyQ5COXuM+mVtJt
 dr+Ol2xOMxEvKKkuaW/5gmA/ieAO1/b7g2U5Eeyioz1xtEi545PW1GC3w6PiV+KCc/
 7dTLgy3qf1dbwZTTE3b8vtZKnoNAkug1+BPWxwvnDY4gfBNM4g1Ru76/qFS+LXdr83
 idynM9cv0IvQQ==
Message-ID: <68dfb206-92c8-4016-ade6-007ad8830667@denx.de>
Date: Thu, 26 Sep 2024 23:39:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/27] mx23_olinuxino: Drop status-LED code
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240926204455.963584-1-sjg@chromium.org>
 <20240926204455.963584-20-sjg@chromium.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240926204455.963584-20-sjg@chromium.org>
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

On 9/26/24 10:44 PM, Simon Glass wrote:
> This is not used anymore, so drop it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   board/olimex/mx23_olinuxino/mx23_olinuxino.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/board/olimex/mx23_olinuxino/mx23_olinuxino.c b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
> index b2bb6678c23..78136c1620a 100644
> --- a/board/olimex/mx23_olinuxino/mx23_olinuxino.c
> +++ b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
> @@ -13,9 +13,6 @@
>   #include <asm/arch/imx-regs.h>
>   #include <asm/arch/clock.h>
>   #include <asm/arch/sys_proto.h>
> -#ifdef CONFIG_LED_STATUS
> -#include <status_led.h>
> -#endif
>   #include <linux/delay.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
> @@ -61,9 +58,5 @@ int board_init(void)
>   	/* Adress of boot parameters */
>   	gd->bd->bi_boot_params = PHYS_SDRAM_1 + 0x100;
>   
> -#if defined(CONFIG_LED_STATUS) && defined(CONFIG_LED_STATUS_BOOT_ENABLE)
> -	status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_STATE);
> -#endif
Why not define the GPIO LED in DT, it might even already be defined there.
