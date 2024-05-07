Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A78C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 07:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A68288747;
	Tue,  7 May 2024 09:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DgeU+rr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B9858872B; Tue,  7 May 2024 09:41:43 +0200 (CEST)
Received: from mail-m127172.xmail.ntesmail.com
 (mail-m127172.xmail.ntesmail.com [115.236.127.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 379AC8874D
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 09:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=DgeU+rr7bc2sn88QcdFfhmmb4Y5dnGk/EIEeIzbguX5QEkuMa2W7Ova2oVFLsYmEar7lSIQyCDnQzHll67DkYmcEq2tedn254yvouSNOi4btuV38ER75wYQGjfT/CtTeFhLse9LmsVujDd2CHZp8jadNyMtJ/fZgaxJm6mx2S6E=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=Nfz+7NBrJcIeXsjnKVhfM4FSnIqt++VcfpMqm2/EzCc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id F2D2D900347;
 Tue,  7 May 2024 15:41:26 +0800 (CST)
Message-ID: <79be36d1-dc84-4fca-a811-2170739a0393@rock-chips.com>
Date: Tue, 7 May 2024 15:41:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 060/149] board: firefly: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Andy Yan <andy.yan@rock-chips.com>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-60-trini@konsulko.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240501024316.1767971-60-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUpOHlYdTEgdTRhCShpCQ0NVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f520011af03a9kunmf2d2d900347
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oi46Igw5QzNLPgs0FQMDITcI
 HTcKCjhVSlVKTEpOS01MTUNMTEtIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITkxCNwY+
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


On 2024/5/1 10:41, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Cc: Levin Du <djw@t-chip.com.cn>
> Cc: Suniel Mahesh <sunil@amarulasolutions.com>
> ---
>   board/firefly/firefly-rk3288/firefly-rk3288.c | 1 -
>   board/firefly/firefly-rk3308/roc_cc_rk3308.c  | 1 -
>   board/firefly/roc-pc-rk3399/roc-pc-rk3399.c   | 1 -
>   3 files changed, 3 deletions(-)
>
> diff --git a/board/firefly/firefly-rk3288/firefly-rk3288.c b/board/firefly/firefly-rk3288/firefly-rk3288.c
> index 95d8b00924d8..8e67ab4b1327 100644
> --- a/board/firefly/firefly-rk3288/firefly-rk3288.c
> +++ b/board/firefly/firefly-rk3288/firefly-rk3288.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2015 Google, Inc
>    */
>   
> -#include <common.h>
>   #include <hang.h>
>   #include <led.h>
>   #include <log.h>
> diff --git a/board/firefly/firefly-rk3308/roc_cc_rk3308.c b/board/firefly/firefly-rk3308/roc_cc_rk3308.c
> index af00250e118d..404bdc632bbc 100644
> --- a/board/firefly/firefly-rk3308/roc_cc_rk3308.c
> +++ b/board/firefly/firefly-rk3308/roc_cc_rk3308.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2019 Rockchip Electronics Co., Ltd
>    */
>   
> -#include <common.h>
>   #include <adc.h>
>   #include <asm/arch-rockchip/grf_rk3308.h>
>   #include <asm/arch-rockchip/hardware.h>
> diff --git a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> index 590519b32af2..a149e4fe822e 100644
> --- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> +++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2016 Rockchip Electronics Co., Ltd
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <env.h>
>   #include <log.h>
