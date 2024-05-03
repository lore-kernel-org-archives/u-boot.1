Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8ABC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 08:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F8788BE3;
	Fri,  3 May 2024 10:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="sBOb5JMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADD5588BE9; Fri,  3 May 2024 10:47:34 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1A4C88BD9
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 10:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1714726052; x=1717318052;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6vnnNLXUsVegWvHxSGgGmvKdg7wS0ddq5gA2FTrA94g=;
 b=sBOb5JMGHQawT5rwZ73xd20Prf1cOyhS+0te6VAD4bftjzk9+u0HpJ4XlHM1Nkeu
 8081smvjIYVna+OR+OVpTROQUDBckAV5+AQL95nKoY+bEyhVU0uZp/d+nNpNRv3K
 zWf/JVNeUjdjKmX3D5JVHBn6ndTTVdZzxpoGfUK2EgQ=;
X-AuditID: ac14000a-fbefe7000000290d-dc-6634a4a360f6
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 37.BB.10509.3A4A4366;
 Fri,  3 May 2024 10:47:32 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 3 May 2024
 10:47:30 +0200
Message-ID: <6917c0d5-1886-4b97-80f8-6d839d67386a@phytec.de>
Date: Fri, 3 May 2024 10:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 103/149] board: phytec: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
CC: Martyn Welch <martyn.welch@collabora.com>, Parthiban Nallathambi
 <parthitce@gmail.com>, "Albert ARIBAUD (3ADEV)" <albert.aribaud@3adev.fr>,
 Niel Fourie <lusus@denx.de>, Teresa Remmet <t.remmet@phytec.de>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, Fabio Estevam
 <festevam@gmail.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-103-trini@konsulko.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240501024316.1767971-103-trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWyRpKBR3fJEpM0g4U3WS0e/H/JZvHwqr/F
 tuk/2SxWXX7HaPHgYheLxZm1p1gsuldWW3zbso3RYuqkzewWb/d2slt0v1N34PbYP/c+o8fs
 hossHjvuLmH0mDfrBIvHzll32T1eHVjF7nH2zg5Gj/7uFlaPv7P2AyVuP2QK4IrisklJzcks
 Sy3St0vgymhf2cBeMNm04mjbadYGxn/aXYycHBICJhI9U/ewdDFycQgJLGGSePfiChOEc4dR
 4tGbeYwgVbwCNhJ/jrWzdTFycLAIqEi0LeKGCAtKnJz5hAXEFhWQl7h/awY7iC0sEC4xZfst
 VhBbBMh+9WwGG8hMZoHbzBJ9j2+ygSSEBLIlzrbtB7OZBcQlbj2ZzwRiswmoS9zZ8A2smRNo
 7+VN96BqLCQWvznIDmHLS2x/O4cZYo68xItLy1kgvpGXmHbuNTOEHSpxZNNqpgmMwrOQ3DoL
 ybpZSMbOQjJ2ASPLKkah3Mzk7NSizGy9gozKktRkvZTUTYyguBRh4NrB2DfH4xAjEwfjIUYJ
 DmYlEV7tycZpQrwpiZVVqUX58UWlOanFhxilOViUxHlXdwSnCgmkJ5akZqemFqQWwWSZODil
 Ghh77kx9kn9w5kuHiR84S5UDb32/cOyI4/OJ6VUpakbFJkUeB+tqpQ90n5urfrJG99PDxHet
 G84wNj5/z+d7ZN0rISnJdxYH97lvbvtrWtSU8G/eh7a+BZEX2ro/8Wb4+VfY86xz01GKfs47
 6Y6p4EQW/daIescNCwK2v+r91JL8LcvHvnn9tddKLMUZiYZazEXFiQA6z0gouQIAAA==
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



Am 01.05.24 um 04:42 schrieb Tom Rini:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Wadim Egorov <w.egorov@phytec.de>

> ---
> Cc: Martyn Welch <martyn.welch@collabora.com>
> Cc: Parthiban Nallathambi <parthitce@gmail.com>
> Cc: "Albert ARIBAUD (3ADEV)" <albert.aribaud@3adev.fr>
> Cc: Niel Fourie <lusus@denx.de>
> Cc: Teresa Remmet <t.remmet@phytec.de>
> Cc: Wadim Egorov <w.egorov@phytec.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Yannic Moog <y.moog@phytec.de>
> Cc: Daniel Schultz <d.schultz@phytec.de>
> Cc: Benjamin Hahn <B.Hahn@phytec.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> ---
>   board/phytec/common/imx8m_som_detection.c    | 1 -
>   board/phytec/common/phytec_som_detection.c   | 1 -
>   board/phytec/pcl063/spl.c                    | 2 +-
>   board/phytec/pcm052/pcm052.c                 | 1 -
>   board/phytec/pcm058/pcm058.c                 | 1 -
>   board/phytec/phycore_am335x_r2/board.c       | 2 +-
>   board/phytec/phycore_am335x_r2/mux.c         | 1 -
>   board/phytec/phycore_imx8mm/phycore-imx8mm.c | 1 -
>   board/phytec/phycore_imx8mm/spl.c            | 1 -
>   board/phytec/phycore_imx8mp/phycore-imx8mp.c | 1 -
>   board/phytec/phycore_imx8mp/spl.c            | 1 -
>   board/phytec/phycore_rk3288/phycore-rk3288.c | 1 -
>   12 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/board/phytec/common/imx8m_som_detection.c b/board/phytec/common/imx8m_som_detection.c
> index ee34a5b95791..bfd60ffb7773 100644
> --- a/board/phytec/common/imx8m_som_detection.c
> +++ b/board/phytec/common/imx8m_som_detection.c
> @@ -4,7 +4,6 @@
>    * Author: Teresa Remmet <t.remmet@phytec.de>
>    */
>   
> -#include <common.h>
>   #include <asm/arch/sys_proto.h>
>   #include <dm/device.h>
>   #include <dm/uclass.h>
> diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
> index 78c173df20d4..b14bb3dbb7fa 100644
> --- a/board/phytec/common/phytec_som_detection.c
> +++ b/board/phytec/common/phytec_som_detection.c
> @@ -4,7 +4,6 @@
>    * Author: Teresa Remmet <t.remmet@phytec.de>
>    */
>   
> -#include <common.h>
>   #include <dm/device.h>
>   #include <dm/uclass.h>
>   #include <i2c.h>
> diff --git a/board/phytec/pcl063/spl.c b/board/phytec/pcl063/spl.c
> index b6d459fdfce6..b98c46dbcbd4 100644
> --- a/board/phytec/pcl063/spl.c
> +++ b/board/phytec/pcl063/spl.c
> @@ -6,7 +6,7 @@
>    * Copyright (C) 2015-2016 Stefan Roese <sr@denx.de>
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <init.h>
>   #include <spl.h>
>   #include <asm/arch/clock.h>
> diff --git a/board/phytec/pcm052/pcm052.c b/board/phytec/pcm052/pcm052.c
> index 0f7235979b04..20f2aac332da 100644
> --- a/board/phytec/pcm052/pcm052.c
> +++ b/board/phytec/pcm052/pcm052.c
> @@ -6,7 +6,6 @@
>    * Copyright 2013 Freescale Semiconductor, Inc.
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> diff --git a/board/phytec/pcm058/pcm058.c b/board/phytec/pcm058/pcm058.c
> index b37c6fe218da..ecc5b75d8d42 100644
> --- a/board/phytec/pcm058/pcm058.c
> +++ b/board/phytec/pcm058/pcm058.c
> @@ -9,7 +9,6 @@
>    * Both NAND and eMMC cannot be set because they share the
>    * same pins (SD4)
>    */
> -#include <common.h>
>   #include <init.h>
>   #include <net.h>
>   #include <asm/arch/crm_regs.h>
> diff --git a/board/phytec/phycore_am335x_r2/board.c b/board/phytec/phycore_am335x_r2/board.c
> index 5700effbd3f6..2022525651dc 100644
> --- a/board/phytec/phycore_am335x_r2/board.c
> +++ b/board/phytec/phycore_am335x_r2/board.c
> @@ -10,7 +10,7 @@
>    * Copyright (C) 2019 DENX Software Engineering GmbH
>    */
>   
> -#include <common.h>
> +#include <config.h>
>   #include <init.h>
>   #include <spl.h>
>   #include <asm/arch/cpu.h>
> diff --git a/board/phytec/phycore_am335x_r2/mux.c b/board/phytec/phycore_am335x_r2/mux.c
> index 7091c985ba12..bb1c48da0fe5 100644
> --- a/board/phytec/phycore_am335x_r2/mux.c
> +++ b/board/phytec/phycore_am335x_r2/mux.c
> @@ -6,7 +6,6 @@
>    * Copyright (C) 2019 DENX Software Engineering GmbH
>    */
>   
> -#include <common.h>
>   #include <asm/arch/sys_proto.h>
>   #include <asm/arch/hardware.h>
>   #include <asm/arch/mux.h>
> diff --git a/board/phytec/phycore_imx8mm/phycore-imx8mm.c b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
> index ef6472916903..06cffbca3a69 100644
> --- a/board/phytec/phycore_imx8mm/phycore-imx8mm.c
> +++ b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
> @@ -4,7 +4,6 @@
>    * Author: Teresa Remmet <t.remmet@phytec.de>
>    */
>   
> -#include <common.h>
>   #include <asm/arch/sys_proto.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> diff --git a/board/phytec/phycore_imx8mm/spl.c b/board/phytec/phycore_imx8mm/spl.c
> index 690a51f7a72e..8d858590a39b 100644
> --- a/board/phytec/phycore_imx8mm/spl.c
> +++ b/board/phytec/phycore_imx8mm/spl.c
> @@ -4,7 +4,6 @@
>    * Author: Teresa Remmet <t.remmet@phytec.de>
>    */
>   
> -#include <common.h>
>   #include <asm/arch/clock.h>
>   #include <asm/arch/ddr.h>
>   #include <asm/arch/imx8mm_pins.h>
> diff --git a/board/phytec/phycore_imx8mp/phycore-imx8mp.c b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
> index dbdd6bb79373..35683591433c 100644
> --- a/board/phytec/phycore_imx8mp/phycore-imx8mp.c
> +++ b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
> @@ -4,7 +4,6 @@
>    * Author: Teresa Remmet <t.remmet@phytec.de>
>    */
>   
> -#include <common.h>
>   #include <asm/arch/sys_proto.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8mp/spl.c
> index df158024654e..352f803e4541 100644
> --- a/board/phytec/phycore_imx8mp/spl.c
> +++ b/board/phytec/phycore_imx8mp/spl.c
> @@ -4,7 +4,6 @@
>    * Author: Teresa Remmet <t.remmet@phytec.de>
>    */
>   
> -#include <common.h>
>   #include <asm/arch/clock.h>
>   #include <asm/arch/ddr.h>
>   #include <asm/arch/imx8mp_pins.h>
> diff --git a/board/phytec/phycore_rk3288/phycore-rk3288.c b/board/phytec/phycore_rk3288/phycore-rk3288.c
> index 1ddb4a4f8085..a970634b4c33 100644
> --- a/board/phytec/phycore_rk3288/phycore-rk3288.c
> +++ b/board/phytec/phycore_rk3288/phycore-rk3288.c
> @@ -9,7 +9,6 @@
>   #include <net.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <env.h>
>   #include <env_internal.h>
