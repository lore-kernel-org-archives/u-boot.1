Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF080F417E7
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 14:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D52283F82;
	Mon,  9 Mar 2026 15:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kWYUhcnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C191383F6E; Mon,  9 Mar 2026 15:38:21 +0100 (CET)
Received: from mail-m32115.qiye.163.com (mail-m32115.qiye.163.com
 [220.197.32.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45F1B83F82
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 15:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.154])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3646e8213;
 Mon, 9 Mar 2026 22:38:15 +0800 (GMT+08:00)
Message-ID: <7e3d4603-9187-468b-a923-fd5e23fe3e34@rock-chips.com>
Date: Mon, 9 Mar 2026 22:38:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] rockchip: mkimage: Add support for RK3506
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Xuhui Lin <xuhui.lin@rock-chips.com>
References: <20260131233843.3419737-1-jonas@kwiboo.se>
 <20260131233843.3419737-4-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260131233843.3419737-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd308cf1a03afkunmfa282fed16bc350
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGUJKVkhMQkgaQktLHU9IT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk5PWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=kWYUhcnSVpmRu8b+oB+6C81RguvEpwHbU6WBL9sUjC2hxiw7+949d1vz4vqcEiET8i8a9Gah41JZ6/9Db1w48sVVp1VI05540h84qtAUxAJGK+1jzuBiAYwf2tp89L7vQrbjP49P90ITJwFAlQShscgUFKNxVU8w8Avr5It9AJg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=DVaz5M8Xiuhayq1iL7mdLucTKVDZDFcRwwhLM11sgDQ=;
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
> From: Xuhui Lin <xuhui.lin@rock-chips.com>
>
> Add support for generating Rockchip Boot Image for RK3506.
>
> The RK3506 has 48 KiB SRAM and 4 KiB is reserved for BootROM.
>
> Signed-off-by: Xuhui Lin <xuhui.lin@rock-chips.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Tested-by: Aaron Griffith <aargri@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Collect t-b tag
> ---
>   tools/rkcommon.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> index dbc1c177843a..cb2d30bfd57a 100644
> --- a/tools/rkcommon.c
> +++ b/tools/rkcommon.c
> @@ -148,6 +148,7 @@ static struct spl_info spl_infos[] = {
>   	{ "rk3328", "RK32", 0x8000 - 0x800, false, RK_HEADER_V1 },
>   	{ "rk3368", "RK33", 0x8000 - 0x1000, false, RK_HEADER_V1 },
>   	{ "rk3399", "RK33", 0x30000 - 0x2000, false, RK_HEADER_V1 },
> +	{ "rk3506", "RK35", 0xC000 - 0x1000, false, RK_HEADER_V2 },
>   	{ "rk3528", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
>   	{ "rk3568", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
>   	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2 },
