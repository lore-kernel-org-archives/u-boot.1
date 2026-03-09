Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FC0F417E3
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 14:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAD2E83F14;
	Mon,  9 Mar 2026 15:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="duNAlRcZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2575383F59; Mon,  9 Mar 2026 15:38:09 +0100 (CET)
Received: from mail-m49245.qiye.163.com (mail-m49245.qiye.163.com
 [45.254.49.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C4DB83952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 15:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.154])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3646e81fb;
 Mon, 9 Mar 2026 22:38:02 +0800 (GMT+08:00)
Message-ID: <801647b1-accc-43b4-8f84-bdb9ae64be5d@rock-chips.com>
Date: Mon, 9 Mar 2026 22:38:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] rockchip: mkimage: Re-sort the spl_infos list
 alphanumerically
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de
References: <20260131233843.3419737-1-jonas@kwiboo.se>
 <20260131233843.3419737-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260131233843.3419737-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd30899cb03afkunm5cfa345116bc2d8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHk1DVkpKTEIeSx8eGBhMGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk5PWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=duNAlRcZYJb0tD3iRK+ogmWTfTpZEpaNYZtMzGzOAkCdv5Y6gimnA1z7UL1LPrtnkwCKvXzdYkolt8QxOthQl/7f6JFu38JJvZB5DBLaFS0Egoy8HA8B37hOfk6TxqDHAXErL8HVfO8a9Dhy7IF3FXUUySjSTCQWduE9jzcyeGo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=S6Ciu55k3ws6kbBXH5NR1RQ57tI6B/iE5KhXTLG6XjI=;
 h=date:mime-version:subject:message-id:from;
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


On 2026/2/1 07:38, Jonas Karlman wrote:
> The first RK35xx SoC was initially appended to the end of the otherwise
> alphanumerically sorted spl_infos list, possible because it was using a
> new header structure.
>
> Re-sort the spl_infos list to keep it alphanumerically ordered based
> on imagename.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch
> ---
>   tools/rkcommon.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> index e7e78ef7e5b7..dbc1c177843a 100644
> --- a/tools/rkcommon.c
> +++ b/tools/rkcommon.c
> @@ -148,12 +148,12 @@ static struct spl_info spl_infos[] = {
>   	{ "rk3328", "RK32", 0x8000 - 0x800, false, RK_HEADER_V1 },
>   	{ "rk3368", "RK33", 0x8000 - 0x1000, false, RK_HEADER_V1 },
>   	{ "rk3399", "RK33", 0x30000 - 0x2000, false, RK_HEADER_V1 },
> -	{ "rv1108", "RK11", 0x1800, false, RK_HEADER_V1 },
> -	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
>   	{ "rk3528", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
>   	{ "rk3568", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
>   	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2 },
>   	{ "rk3588", "RK35", 0x100000 - 0x1000, false, RK_HEADER_V2 },
> +	{ "rv1108", "RK11", 0x1800, false, RK_HEADER_V1 },
> +	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
>   };
>   
>   /**
