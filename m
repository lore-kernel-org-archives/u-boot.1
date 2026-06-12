Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08193CD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 22:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B7E384717;
	Sat, 13 Jun 2026 00:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="m3R/4fVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E321848B0; Sat, 13 Jun 2026 00:13:53 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0868E8466E
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 00:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-69e489edbf8so1009096eaf.0
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 15:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781302430; x=1781907230; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5J1rCM4qBekPdxqPpB/L5LL+s8/DUf72tbrBxigaDhc=;
 b=m3R/4fVPbwkakewCJjP9tJZKQ21SzzaR/rAy6/COJcElVc5hLO5mQdpp5ImAW4ubhl
 Wb3oZgug1e+PI4fNkJI2Ul/FmD1bgOuiepSEReYVXXIHVGg3dQdmLjQ4LpQkJy7QHJu8
 0YSYj4vyyEXc+oPRFrnZ65rL0T6HhnuBwa6eVHab42o1F6VUbwpEXIBTLk3+VpIkPJxh
 DxVgIy0CWXod+RnmqHzr6RbiGKyAgatfqOJXB1cRvZKaZ5BfZwJ9Xf384j30qrcJZqQ1
 i1afXlvGArpzU1NXMYcpWlUhGsAJkhyzH6VfduPCKrzuFpAp63BuOW2SsQ7atKQmWa7o
 z5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781302430; x=1781907230;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5J1rCM4qBekPdxqPpB/L5LL+s8/DUf72tbrBxigaDhc=;
 b=c4yGmjHPEv7lo47W3GNXg9Ygh3lVuPvBnTpVtYSS/JXnS0eunkXmPZpkaK4BCyIjKl
 1Ta8EeIIW2va7UZ0wqkSaK93a2cLufj/f61GW8v3pps7pvkNZvLyWNu8WKeIXCPIM2eP
 aIQ5a9n0BpocBUWuS06PAsCCjvkeSdeI44BpxY6dkDenMsdj8BCTLo8KlwvbgVxUCMKR
 B37fVWUQ0jUqCz/rtL0a+rpGkt21G+yUKrnUFo1cFf6zo8VkNElWD+pTYOPEvUSw4U2D
 ydae+a5qQF9yNE1EoxZzmlasnZ245tJX9QMgNOm4PK9EqpJ9RG8iIG+Ecnc60CpQ+KdV
 Kx3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lX/sMciOpjEJ24vM6RTLXmzDYTvk7yZ9j54gWfK1AgSUdz7ERoY4EibzmSy96Ro/onc1wpX0=@lists.denx.de
X-Gm-Message-State: AOJu0YxXBdJ8zkXz+FJeqx46BHj/yhma01l6oOoEcwrZ0DIR/UOKiHQ1
 WFn9R+PgqzPGDOgWF3+17EYmhhAh9VNIolUkszw76dMsvS1Cys+7zsAaPjtEa2saz2A=
X-Gm-Gg: Acq92OFLqBFUqEJMkPBvDMssc2RX/M6n2ELWK9oYsJwitbb9mliEhNDvHvoLmORQiV9
 X4ogTH6FUSQ1vnafrV0lESU8vNq5DRHf4GrCSbqo6wgHoS2/ZKrhvy37FaLLCFvDTjdUyRl1crT
 pySBDZYxTuD0MblY++gtg1HU3c4R5IIgTjRjIVuAtQG+MdbxZ/kYVd00Uw3RKsqle9EyoWUNsLS
 iUOGeh+yDzO7dj5HksXdsnel4V9yGAOt+QkLqtQ6m1c34g53HzAoblxPxQrfFEzr3Ufk2jULTBZ
 UEBbcWUIn1VZ8IY0J9Kn6/WlDXC39arM74ACzU9xoN0avHDgvX44k2/+j3yI0Sw2ApKYAt2zt1P
 1666E/0sD6glVrW5jmJQDoVJy81Q8iv0bMGA2uSBFOO529UcerVoOnnButdZPYLOzw0Dh5Lr7VI
 DKGCkHq+DcRskRZ+tQ6y+X5jxAvV/BXN4HYAAkWm7rSYurqXFFZsgIIeBSmwF8o1wFaFP24EL7y
 LGrmbSjLJr0
X-Received: by 2002:a05:6820:138c:b0:69e:fe:587b with SMTP id
 006d021491bc7-69edc7a954bmr3024040eaf.52.1781302429652; 
 Fri, 12 Jun 2026 15:13:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:cb9a:87cc:1314:fef5?
 ([2600:8803:e7e4:500:cb9a:87cc:1314:fef5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69ed854c10esm2535624eaf.11.2026.06.12.15.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 15:13:48 -0700 (PDT)
Message-ID: <0d9f31df-34a4-4454-9eb5-7fe82fbc5482@baylibre.com>
Date: Fri, 12 Jun 2026 17:13:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] lmb: default LMB_LIMIT_DMA_BELOW_RAM_TOP for 64-bit
 Mediatek SoCs
From: David Lechner <dlechner@baylibre.com>
To: Sam Edwards <cfsworks@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, Rudy Andram
 <rmandrad@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.denx.de
References: <20260611-mtk-fix-ram-size-v1-0-42ed330660ca@baylibre.com>
 <20260611-mtk-fix-ram-size-v1-1-42ed330660ca@baylibre.com>
 <CAH5Ym4i=fkGC_WvECVqzK=K-GL_fV8hyBH3qd30f02n9gnfq5A@mail.gmail.com>
 <249e2ffb-2ad1-4dd4-8d24-dce8053244e2@baylibre.com>
Content-Language: en-US
In-Reply-To: <249e2ffb-2ad1-4dd4-8d24-dce8053244e2@baylibre.com>
Content-Type: text/plain; charset=UTF-8
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

On 6/12/26 4:30 PM, David Lechner wrote:
> On 6/12/26 12:52 PM, Sam Edwards wrote:
>> On Fri, Jun 12, 2026 at 10:32 AM David Lechner <dlechner@baylibre.com> wrote:
>>>
>>> Add 64-bit Mediatek ARM SoCs to the default y setting of
>>> LMB_LIMIT_DMA_BELOW_RAM_TOP. These platforms have a 4GiB DMA limit, e.g.
>>> for the SD/MMC controller.
>>
>> Hi David,
>>
>> Is the 4GiB DMA limit due to the interconnect itself or are there
>> merely a few blocks that can't speak 64-bit? If the latter, I think
>> it'd be clearer to associate the setting with the culprit driver(s)
>> rather than the whole platform, so that it can be removed if/when
>> those drivers begin to use bounce buffers.
>>
> For MediaTek, I think it is mostly specific IP blocks (e.g. MMC in the
> mt8xxx targets in and NETSYS in mt79xx targets covered by this series are
> the ones I am aware of).
> 
> Weijie Gao, maybe you have more information about this?
> 
> 

Sam,

Just to make sure I understood you correctly, your suggestion is to
do this instead?

---
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 24bd16ad5f3..e2c5a54f925 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -858,6 +858,7 @@ config MMC_MTK
 	bool "MediaTek SD/MMC Card Interface support"
 	depends on ARCH_MEDIATEK || ARCH_MTMIPS || ARCH_AIROHA
 	depends on OF_CONTROL
+	select LMB_LIMIT_DMA_BELOW_RAM_TOP
 	help
 	  This selects the MediaTek(R) Secure digital and Multimedia card Interface.
 	  If you have a machine with a integrated SD/MMC card reader, say Y here.
diff --git a/drivers/net/mtk_eth/Kconfig b/drivers/net/mtk_eth/Kconfig
index 5d4e54ab90e..7d58f542bde 100644
--- a/drivers/net/mtk_eth/Kconfig
+++ b/drivers/net/mtk_eth/Kconfig
@@ -5,6 +5,7 @@ config MEDIATEK_ETH
 	select PHYLIB
 	select DM_GPIO
 	select DM_RESET
+	select LMB_LIMIT_DMA_BELOW_RAM_TOP
 	help
 	  This Driver support MediaTek Ethernet GMAC
 	  Say Y to enable support for the MediaTek Ethernet GMAC.
diff --git a/lib/Kconfig b/lib/Kconfig
index 27ad43125e4..cf13ac1bdad 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1298,7 +1298,7 @@ config SPL_LMB_ARCH_MEM_MAP
 config LMB_LIMIT_DMA_BELOW_RAM_TOP
 	bool
 	depends on LMB
-	default y if ARCH_BCM283X || (ARCH_MEDIATEK && ARM64)
+	default y if ARCH_BCM283X
 	help
 	  Some architectures can not DMA above ram_top boundary,
 	  which is after 4 GiB or 32-bit boundary too. Limit the

