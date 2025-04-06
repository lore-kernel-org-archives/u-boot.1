Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B84C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B6A82B53;
	Sun,  6 Apr 2025 17:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dXohCydx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D0182B63; Sun,  6 Apr 2025 17:17:47 +0200 (CEST)
Received: from mail-m32123.qiye.163.com (mail-m32123.qiye.163.com
 [220.197.32.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 799C282B4A
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.73.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 10d020652;
 Sun, 6 Apr 2025 23:17:40 +0800 (GMT+08:00)
Message-ID: <34bddc8c-24fa-452e-be04-9074ba2d0506@rock-chips.com>
Date: Sun, 6 Apr 2025 23:17:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] rockchip: binman: Correct the OS prop for U-Boot
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki
 <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250329150626.2879942-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEhJVh5CSUpLQ09PThhKS1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTEhVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
X-HM-Tid: 0a960badc65303afkunm10d020652
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBQ6LAw6MjJPD0k5T0kZMyEy
 HzdPCRlVSlVKTE9IQk5JTU1LTE9CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTEhVSVlXWQgBWUFKQkxLNwY+
DKIM-Signature: a=rsa-sha256;
 b=dXohCydx+OkR/R7TfwfP5CrBO83sMUYEQT5xkhLzTzGstlMWYwpHCwfPYVlZcHmt2h7nrsP+VIGoFaA2nCapV98aUDgb5BWN/WwC/2J8RJii6o4iwJUlZ+BwCXrdISAb3xBkdgWmfIlwMivzsiJ1dYS4rOdjzmbifKU0hAtVjNo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=WJQyAaBUHACfgpf5tJps+W6gIGDXOP42ss/LEcXrTlo=;
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


On 2025/3/29 23:06, Jonas Karlman wrote:
> From: Simon Glass <sjg@chromium.org>
>
> The U-Boot image is currently being identified as an invalid OS in
> spl_fit_image_get_os() due to case sensitive compare.
>
> Use the correct lower-case value to fix this.
>
> Fixes: e0c0efff2a02 ("rockchip: Support building the all output files in binman")
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v4:
> - Update commit message
> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index c8c928c7e508..e9ed1d4b5738 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -50,7 +50,7 @@
>   				u-boot {
>   					description = "U-Boot";
>   					type = "standalone";
> -					os = "U-Boot";
> +					os = "u-boot";
>   #ifdef CONFIG_ARM64
>   					arch = "arm64";
>   #else
